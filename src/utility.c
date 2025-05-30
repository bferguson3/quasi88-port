/***********************************************************************
 *      雑多な関数
 ************************************************************************/
#include <string.h>

/*===========================================================================
 * 大文字・小文字の区別なく、文字列比較 (stricmp/strcasecmp ?)
 *      戻り値: 一致時 == 0, 不一致時 != 0 (大小比較はなし)
 *===========================================================================*/
int     my_strcmp( const char *s, const char *d )
{
  if( s==NULL || d==NULL ) return 1;

  while( tolower(*s) == tolower(*d) ){
    if( *s == '\0' ) return 0;
    s++;
    d++;
  }
  return 1;
}

/*===========================================================================
 * 文字列 ct を 文字列 s に コピー (strlcpy ?)
 *      s の文字列終端は、必ず '\0' となり、s の長さは n-1 文字以下に収まる。
 *      余分な領域は \0 で埋められない。
 *      戻り値: なし
 *===========================================================================*/
void    my_strncpy( char *s, const char *ct, unsigned long n )
{
  s[0] = '\0';
  strncat( s, ct, n-1 );
}

/*===========================================================================
 * 文字列 ct を 文字列 s に 連結 (strlcat ?)
 *      s の文字列終端は、必ず '\0' となり、s の長さは n-1 文字以下に収まる。
 *      戻り値: なし
 *===========================================================================*/
void    my_strncat( char *s, const char *ct, unsigned long n )
{
  size_t used = strlen(s) + 1;

  if( n > used )
    strncat( s, ct, n - used );
}

/*===========================================================================
 * SJIS を EUC に変換 (かなり適当)
 *      *sjis_p の文字列を EUC に変換して、*euc_p に格納する。
 *
 *      注意！）この関数は、バッファあふれをチェックしていない。
 *              *euc_p は、*sjis_p の倍以上の長さがないと危険
 *===========================================================================*/
void    sjis2euc( char *euc_p, const char *sjis_p )
{
  int   h,l, h2, l2;

  while( ( h = (unsigned char)*sjis_p++ ) ){

    if( h < 0x80 ){                             /* ASCII */

      *euc_p ++ = h;

    }else if( 0xa1 <= h && h <= 0xdf ){         /* 半角カナ */

      *euc_p ++ = (char)0x8e;
      *euc_p ++ = h;

    }else{                                      /* 全角文字 */

      if( ( l = (unsigned char)*sjis_p++ ) ){

        if( l <= 0x9e ){
          if( h <= 0x9f ) h2 = (h - 0x71) *2 +1;
          else            h2 = (h - 0xb1) *2 +1;
          if( l >= 0x80 ) l2 = l - 0x1f -1;
          else            l2 = l - 0x1f;
        }else{
          if( h <= 0x9f ) h2 = (h - 0x70) *2;
          else            h2 = (h - 0xb0) *2;
          l2 = l - 0x7e;
        }
        *euc_p++ = 0x80 | h2;
        *euc_p++ = 0x80 | l2;

      }else{
        break;
      }

    }
  }

  *euc_p = '\0';
}


/*===========================================================================
 * EUC を SJIS に変換 (かなり適当)
 *      *euc_p の文字列を SJIS に変換して、*sjis_p に格納する。
 *
 *      注意！）この関数は、バッファあふれをチェックしていない。
 *              *sjis_p は、*euc_p と同等以上の長さがないと危険
 *===========================================================================*/

void    euc2sjis( char *sjis_p, const char *euc_p )
{
  int   h,l;

  while( ( h = (unsigned char)*euc_p++ ) ){

    if( h < 0x80 ){                             /* ASCII */

      *sjis_p ++ = h;

    }else if( h==0x8e ){                        /* 半角カナ */

      if( ( h = (unsigned char)*euc_p++ ) ){

        if( 0xa1 <= h && h <= 0xdf )
          *sjis_p ++ = h;

      }else{
        break;
      }

    }else if( h & 0x80 ){                       /* 全角文字 */

      if( ( l = (unsigned char)*euc_p++ ) ){

        if( l & 0x80 ){

          h = (h & 0x7f) - 0x21;
          l = (l & 0x7f) - 0x21;

          if( h & 0x01 ) l += 0x9e;
          else           l += 0x40;
          if( l >= 0x7f ) l += 1;

          h = (h>>1) + 0x81;

          if( h >= 0xa0 ) h += 0x40;

          *sjis_p++ = h;
          *sjis_p++ = l;

        }

      }else{
        break;
      }

    }
  }

  *sjis_p = '\0';
}


/*===========================================================================
 * EUC文字列の長さを計算 (けっこう適当)
 *      ASCII・半角カナは1文字、全角漢字は2文字とする。
 *      文字列末の、\0 は長さに含めない。
 *===========================================================================*/

int     euclen( const char *euc_p )
{
  int   i = 0, h;

  while( ( h = (unsigned char)*euc_p++ ) ){

    if( h < 0x80 ){                             /* ASCII */

      i++;

    }else if( h == 0x8e ){                      /* 半角カナ */

      euc_p ++;
      i++;

    }else{                                      /* 漢字 */

      euc_p ++;
      i += 2;

    }
  }

  return i;
}

/*===========================================================================
 * 文字列 src をトークンに分割する。
 *      区切り文字は、スペースとタブ。先頭のスペース・タブは無視される。
 *      分割したトークンは ( \0 を付加して ) dst にコピーし、
 *      src の残りの文字列部分の先頭アドレスを返す。
 *      これ以上分割できない場合は dst には "\0" をコピーし、NULLを返す。
 *
 *      トークンに分割する際のルール
 *        ・ 改行(\r or \n) ないし 終端(\0) で文字列は終わりとみなす。
 *      特別な文字
 *        ・ スペースとタブは、区切り文字とする
 *        ・ # はコメント文字とし、終端文字と同様に扱う。
 *        ・ \ はエスケープ文字とする。スペース、タブ、#、"、\ の前に \ が
 *           ある場合、これらは特別な文字とせずに通常の文字と同様に扱う。
 *           他の文字の前に \ がある場合、単に \ はスキップされる。
 *        ・ " は引用符文字とする。この文字で囲まれた部分の文字列について、
 *           スペース、タブ、#、\ は特別な文字とみなされない。
 *           ただし、 "" の2文字が続いている場合に限り、" とみなす。
 *===========================================================================*/
#define COMMENT         '#'
#define ESCAPE          '\\'
#define QUOTE           '\"'
char    *my_strtok( char *dst, char *src )
{
  char *p = &src[0];
  char *q = &dst[0];

  int esc   = FALSE;                    /* エスケープシーケンス処理中 */
  int quote = FALSE;                    /* クォート文字処理中         */

  *q = '\0';

  while( *p==' ' || *p=='\t' ){         /* 先頭のスペース・タブをスキップ */
    p ++;
  }

  while(1){

    if( quote == FALSE ){               /* 通常部分の処理 */

      if( esc == FALSE ){
        if     ( *p=='\0' ||
                 *p=='\r' ||
                 *p=='\n' ||
                 *p==' '  ||
                 *p=='\t' ||
                 *p==COMMENT ){ *q = '\0';   break; }
        else if( *p==QUOTE   ){         p++; quote = TRUE; }
        else if( *p==ESCAPE  ){         p++; esc = TRUE;   }
        else                  { *q++ = *p++;               }
      }else{
        if     ( *p=='\0' ||
                 *p=='\r' ||
                 *p=='\n' )   { *q = '\0'; break; }
        else                  { *q++ = *p++; esc = FALSE;  }
      }

    }else{                              /* " " で囲まれた部分の処理 */

        if     ( *p=='\0' ||
                 *p=='\r' ||
                 *p=='\n'   ){ *q = '\0';   break; }
        else if( *p==QUOTE  )
          if( *(p+1)==QUOTE ){ *q++ = QUOTE; p+=2; quote = FALSE; }
          else               {               p++;  quote = FALSE; }
        else                 { *q++ = *p++;                }

    }
  }

  if( *dst == '\0' ) return NULL;
  else               return p;
}
