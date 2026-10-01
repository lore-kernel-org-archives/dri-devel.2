Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE705CA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:07:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F63610E114;
	Thu,  1 Oct 2026 22:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nqRMZNnQ";
	dkim-atps=neutral
Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com
 [74.125.224.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A181F10E114
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 22:07:28 +0000 (UTC)
Received: by mail-yx2-f40.google.com with SMTP id
 956f58d0204a3-67567ff2e77so3322881d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 15:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790892447; cv=none;
 d=google.com; s=arc-20260327;
 b=qhAmMOi8XRtPs48khEqL5mrWESqQepsVxc22p/1oBY58FZuJBgpPfzZI7sM/EvlXeI
 lhGtClHNBk7rmYqxtPweJMc75XgI2jL28ZviL6fez1/8UZnGfWCIEcWTEd8cD+VL779t
 5ChxUXofxl+abpc3CPaGxvL1xv0j5kdL8ftN/MwI6CkWAPwuRE0bSTGLGCWKtQuAncgn
 k4RECSBWtvnazLRRKoKFZDKNqcnQgxhS9BionEMZ3vCKxdnjxJmyxda+YzcrSpCt95ng
 07rRL4QKgHxFsp1/NkaKTEzI1ztNaZY3gLCNU4KwRo7t2+1Z/PLNiKmheAbVpif4qzJh
 CR3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qRnvWx4hvW9UfrQiuhK4me8Zst5xcEf8OHS5EhrlTSg=;
 fh=kAGRFKDN7aRGd6VO33HQbsOy3CoTfL4nr4GTMsDqfhg=;
 b=gcep04WfG0AgDadDLL1ckV53/I1+JOcvRXX3XC1q/tr3m4jKdI26xsGk4WCInm1sY6
 bF5XBY6EXGIGocG35CPZD2tXEsCQz/oKzM+jZ0Wwjr/3moQyiciaj9yzFlaqZoT28X/p
 txywkIIhNmW4edejdE/F7RzPsVw4mYYkS4niJbowUZcsRw7vE2uQnQBiHs88emweKxnR
 TKc7Jvgs4WZkL1fKhKWsOUVHl3da47UYUvhY76qNX28aXg3vObGlXH3W8gn8Id8NDbj7
 v1bldcIbVlemfsl/TcacWe1NYyBgLA/cShub7ugCCNd4qdqAt3MFEnXm/Wa+t7JS9G9b
 773w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790892447; x=1791497247; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qRnvWx4hvW9UfrQiuhK4me8Zst5xcEf8OHS5EhrlTSg=;
 b=nqRMZNnQhg4Gr5X9Iw1IdIJWdqbbtj4LWCFW0oyXC5dWg9vKTkPKtwZq5gXzGQPX78
 iOX3+1BR14TpFFVXt8Z0yhuGtkl+enBKC2m5TVVLC08QOJOnsru7RbIxWonWLTs6Y+Ly
 k8WpXmn1xPTuCT/XzMYDcSATqhicFo9W4ER7Ct2vaF5OVXaWRc6rETJM51S7IrfUhOAf
 2zxmR1X7sCKVyQYZR1oaFOw3DNEW8SU4x+Z0X9vkS7MpVI6AGNDpk36+9nMaSXy1bA0P
 KpovcTDGK/jlqnYQnvtS6xdfWzWdqZSgIcEYgmlJhRjB1XKXIYmtwoPNUdzcB5my7IHf
 x5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892447; x=1791497247;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qRnvWx4hvW9UfrQiuhK4me8Zst5xcEf8OHS5EhrlTSg=;
 b=JJGAsQpsbdHfZohJNWSN2tcX1YhGM0r2jqcnPWnrptQmVwxJXWffU9x/hNc/nuwwU3
 oy5bSVes7E4X6l376t96/TsWcCfWfSLERbnwYz3CP6lvfktP3qTEALvH9fFIn33YY/ha
 bALspJ+kWuXbcIBTc4631oFoD6SukO87Ex+b1gYddDnLJym0YysShp6bUZOPLcHcDdW1
 QDAmcdM1ZDGK/aksEGm96RBJNSDnTMqEA7KGhsBQmY8krmp9XDy8PkWn6zm1fClDLUb1
 ufWknmrR1Sh0KSddNnfWBg+vHBlwpKkODm97SXjfcE3kh/WaUhYGvlDEVXkfGFCuqaP6
 kSJg==
X-Gm-Message-State: AFq9FYIRM6XP3IDn0EScx6br2Z3Yt7MKd0TzDJvsCKvkRDGfgiZgHTLx
 Nvq98EsBl3sv8+Jy4jmmmTMEKafvZUh5X16TIPfCU5rqQZxx43BlqMfeHp4p/9b+Uccfk1a1ogC
 p6DKSQXBC2MFr816ViqlfhX9iwZ8IlBrRn36i
X-Gm-Gg: AYBFou3tOyOyg1HWPEHK378l4IuabW4nB6RRuo5a+AH8mdbXnwMj7giscuN7ZxHIYXQ
 X9vRUgQnL7VPv/z/0I+dh7NUdaN3/ul4sQUvrDudcqvYY+xJESDsuZWcDvNUq6hyIeXTMHvXe8g
 G5zA0LckE7O6Iaydvb8XccxHpQl7trjfLfVSmYDI+iOd+kty+gew+KVqwy17NaoVVa/Ya1nLwCM
 kcTuMN9ORKWHq5I+N5zz12nDnL1Ja+yNE/3HQtzrR354jh0FKRmtNVK9aFxVASLAaPnY/8F9O3G
 /i06Cx+iukDOcZQ4yD5I89/+i5ksCD3/NSMiLsEouWLTO120hdD2ysG3uPg8l52hrL4RLohDY4d
 kZ3LSU0QrZ/TcUVLJ0/9VMY3zePwCSyLOadJc+wZSOjOU
X-Received: by 2002:a05:690e:24a:b0:671:506a:9fb5 with SMTP id
 956f58d0204a3-677abfbae92mr332349d50.35.1790892447614; Thu, 01 Oct 2026
 15:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-31-9b6c217fdf2f@gmail.com>
 <20260923224722.F199F1F000FF@smtp.kernel.org>
In-Reply-To: <20260923224722.F199F1F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 16:07:00 -0600
X-Gm-Features: AclHuK-0SkBh2JCEKbGxlnSItQq61tpkSYiR0faSf0oEXk0XEt53T5FhJ13xWCE
Message-ID: <CAJfuBxxDFgqVQt7CvKU5-G_i67a6zBr_Xi_h+jkjbrYVVYq-Aw@mail.gmail.com>
Subject: Re: [PATCH v11 31/38] dyndbg: split multi-query strings with @
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Sep 23, 2026 at 4:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] dyndbg: UAPI break for boot parameters containing unquoted @
> --
>
> commit a948e5ac96c252adcbc1059b7607e6fa7aab2b9d
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: split multi-query strings with @
>
> This commit adds '@' to the existing ';' and '\n' separators for dynamic =
debug
> queries. This provides a more shell-friendly delimiter, reducing the need=
 for
> quoting and escaping.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 6482fd28def46..636a88994a774 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
>
> [ ... ]
>
> > @@ -622,6 +622,30 @@ static int ddebug_exec_query(char *query_string, c=
onst char *modname)
> >       return nfound;
> >  }
> >
> > +/*
> > + * Split multi-query string on delimiters (@, ;, \n), ignoring delimit=
ers
> > + * that appear inside single or double quoted strings.
> > + */
> > +static char *ddebug_find_delimiter(char *str, const char *delims)
> > +{
> > +     bool in_quote =3D false;
> > +     char quote_char =3D 0;
> > +
> > +     for (; *str; str++) {
> > +             if (*str =3D=3D '"' || *str =3D=3D '\'') {
> > +                     if (!in_quote) {
> > +                             in_quote =3D true;
> > +                             quote_char =3D *str;
> > +                     } else if (*str =3D=3D quote_char) {
> > +                             in_quote =3D false;
> > +                     }
> > +             } else if (!in_quote && strchr(delims, *str)) {
>
> [Severity: Medium]
> Does this cause a regression for boot parameters with an unquoted '@' sym=
bol?
>
> When a user provides a kernel parameter like dyndbg=3D"format i2c@1000 +p=
",
> parse_args() strips the outer double-quotes before passing the unquoted
> string down.
>
> Once ddebug_exec_queries() passes the string to ddebug_find_delimiter(), =
it
> will prematurely split the string at the '@' because in_quote is false,
> producing invalid queries like 'format i2c' and '1000 +p', both of which
> fail to parse.
>
> Could this break existing boot parameters or modprobe configurations that
> rely on the '@' symbol in format strings (e.g., matching device tree node=
s)?
>

0. next_arg() in kernel/params.c strips only the outermost pair of
   quotes enclosing the parameter value. It leaves inner single quotes
   or escaped quotes completely intact.

1. ddebug_find_delimiter() was written specifically to track both single
   and double quotes (' and "). A boot argument containing '@' in a
   format string protects it by passing inner single quotes:
     dyndbg=3D"format 'i2c@1000' +p"

2. Previously, dynamic debug split multi-queries on ";\n" using
   strpbrk(), which had zero quote awareness and split on ';' even when
   enclosed in quotes. ddebug_find_delimiter() is strictly more robust
   than the baseline parser by preserving quoted delimiters while giving
   users an unescaped '@' alternative to shell-sensitive ';'.



> > +                     return str;
> > +             }
> > +     }
> > +     return NULL;
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D31
