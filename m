Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9FBCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B5B10E123;
	Thu,  1 Oct 2026 22:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="moB0Jo6o";
	dkim-atps=neutral
Received: from mail-yx2-f16.google.com (mail-yx2-f16.google.com
 [74.125.224.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E74210E123
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 22:02:42 +0000 (UTC)
Received: by mail-yx2-f16.google.com with SMTP id
 956f58d0204a3-6756f62025aso3853357d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 15:02:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790892161; cv=none;
 d=google.com; s=arc-20260327;
 b=Jz2t+s5iEyoNlrDCyLD7QAfmXdsBjoZ9oBBpW+i5Vnql7LDLUwf3vgpeOMYvDofE0F
 H36bk40SsmxIDdwFilNcR8xvxX0+E2Xk2wOfE/wRxonCjO5Rs5kMMzHG8Lbuq3HEvN+y
 tm/tMq/WGMyCgz3PCQO6p/O4HHr8OyVJlzOxJfq7XMH27hRUM/yd3GfE0jvR9yMZqsdc
 PAP1ipl+wxT7IZCp69h5IQqoapvacIQvZv6W4pfhqajvdXPC/qVzaw1sJpjwqSlGbT3b
 dgeOEwLzegdLhz1kBWwxemCnfY+dn486GUxf9tOwuGboXyzmiggyku5SGR3UtGQxNrnj
 GyTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fqM5uspbbFzV6bdXwPQ6MVvrUI0lCblX7jHB4nRMB9U=;
 fh=s1i/EJfIvhKKuJmCjSok1TlF4AblLz4977ooi9//Tts=;
 b=OWd6XfkQJWi47XZ/X9mW53JVnQp7Tixp/MutF1Na8zOByFqaJKgx3y+ZGmK7fk9ZRv
 5EacRaUIpNtpSeSrt7UxFdR7t1xa3UobkEdNNCQAJ37qsfAYPCywvOPgno5M1yLBh/+P
 CD1HV9ZnQuwWwW+//rNbn/CHK9K9ZMe6Rpk7cLIT8zATRWz9QuD/368vV7CeG6pZ3fbR
 cdxf8YL7F4UQdtrRS566ybDZxCKD6K50H7Pxgv9BpfY4ywHCsadskmtgXbz6ujF78a3V
 wDqFamJroa5N1umbJPORW65S1xVYTkgjjOt15dYID7tCKbwb9kTZzetUz5w9YAo2XPrJ
 q3og==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790892161; x=1791496961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fqM5uspbbFzV6bdXwPQ6MVvrUI0lCblX7jHB4nRMB9U=;
 b=moB0Jo6oOCk8e5MJWaUiO1n8qvVamnbuU/drFZmeWpLNUP61R8yMAHFrrUy/ITyf1d
 4lleGkHfpm0lRMTXdRfSUoYfRohB3mpz2FHb7ockFDJ5pOrQaw+5blL6x5ltzW/OKMz8
 ktdu9T4b0t2EPf6mx7wZQv+WD2xJENo7EA6HfjbUoVjp8ERoW2pjMN5Snw2Ub8TKkzGJ
 7jU/CtRjH+p02TnY/Ml8JWyScPm/yHvCirC48Vj3cNKDKrIlQUESq/L0D1fQLgiaZ+92
 ply1huBmfuNRNuLWJUnTLp7HXGmMFdfqdBQ5K1GQ1LLVd6rBZt7N+1pTzAja8S7Rifzn
 bGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892161; x=1791496961;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fqM5uspbbFzV6bdXwPQ6MVvrUI0lCblX7jHB4nRMB9U=;
 b=iaMZ3zfNV7qwUcTWR/PH6iqoDN2VETp6cMThjV9QWNGgTAtI9CQVH8lkGN7eZ4i79Q
 mdX0vtTe4j9aUNgYDT6PKsJ5sUsZxs4+7fMrYdf/8Z7fbkoSdsQfdjDNTAYB65LLSJsA
 P2QKYqS00VsR5wDQE77/fbWe6oeVtk/8Bg0sNL26v2G72CaKW5Va48RM9LXiWf9QH/A9
 NS/T+RT+Gea7Yj0ue2ADE9P+9g055R8YiqRDHaOh+acsnYnJSIZPz2ItACLAX92Ahih1
 yseBWdMAeF9x6eszLYARAeK+PzViAMoCRzyNvtoIrrhQO5jkxvayBrkQas7CrX7OOg1/
 SAtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8aCVFb89PT2fQ6i87mN50F394kvPNiW8PMh3PMT55bSRFugfbjYDqIxJfWpRmdIlhQbNKiFOakms=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLHV+SF160wHGnw//jYJ64cbAwKKlMdc1cGdCXtqv8Lf9IBF3O9
 Pxs4ALafIbZyQPnBx0CtUTIIOhWgiAFCfiBhdUDarD+4aK7K4yLXI5W4sbkv3LIahRso9FEog82
 jf8Ji1ai2LgxwYWZelYoNJ3nq5PYksgg=
X-Gm-Gg: AYBFou1KENJtb8UwzxBdqc1ndf1CNjWfMGtgsDf9N0ANxbOikkMy7boqIjIvyIEHHyM
 h8ygxUtEHuW4dMer3OaHuQ9sbY1ExV623ZeB/EzC2o1cHREZ2P7p1BSSa9TfipKD6FecVjar2Uu
 JlwCLeHW1HM5z2pus8yY2CFk0eyKGAAMFihrldG3JRJB5opJ5zRYmV/iuLs5wjzP+W8gBZqQ651
 GtGd9hSauE5giVQw0YBOKO0Eo7MkWDM1Ze1ffUG8B+qlaHJgbyx3L7EA6MmAICOVIN6vDMS/2aY
 0MVpaoY79eC5f4ydLUH1NqwARZy7gBUGjL8DIc7YHK1307LXS6IcS2tKj+v8H+FK6zm27O6O1bb
 4PKXhQyrAylaro9eQbOH226BbO7UDMOoz8w==
X-Received: by 2002:a05:690e:438d:b0:671:1bbe:f68c with SMTP id
 956f58d0204a3-677ac03e975mr192565d50.51.1790892161398; Thu, 01 Oct 2026
 15:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
 <20260923-dd-cmap-part2-clean-v11-29-9b6c217fdf2f@gmail.com>
 <20260923224657.3F5C71F000FF@smtp.kernel.org>
In-Reply-To: <20260923224657.3F5C71F000FF@smtp.kernel.org>
From: jim.cromie@gmail.com
Date: Thu, 1 Oct 2026 16:02:14 -0600
X-Gm-Features: AclHuK8ODmvd4WyPoy9OINszBNVr-POspB9wdJcmt3RssLX_jouSGEmCCu5Ssb0
Message-ID: <CAJfuBxwYku+xUmWVG2-BhqKCeb=-=B6d9cdOJ9vf73NtBq=sdA@mail.gmail.com>
Subject: Re: [PATCH v11 29/38] dyndbg: control-parser: treat comma as a token
 separator
To: sashiko-reviews@lists.linux.dev
Cc: linux-modules@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Wed, Sep 23, 2026 at 4:46=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] dyndbg: UAPI break for unquoted commas in queries
> --
>
> commit 3647cd55c26b2f7588078b414e3120a9276258a8
> Author: Jim Cromie <jim.cromie@gmail.com>
>
> dyndbg: control-parser: treat comma as a token separator
>
> This commit updates the dynamic debug control parser to treat commas as
> token separators alongside spaces and tabs. This is intended to allow use=
rs
> to avoid shell quoting issues by substituting spaces with commas.
>
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index 8eef2e7387a98..6482fd28def46 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> [ ... ]
> > @@ -336,8 +344,8 @@ static int ddebug_tokenize(char *buf, char *words[]=
, int maxwords)
> >       while (*buf) {
> >               char *end;
> >
> > -             /* Skip leading whitespace */
> > -             buf =3D skip_spaces(buf);
> > +             /* Skip leading whitespace and comma */
> > +             buf =3D skip_spaces_and_commas(buf);
>
> [Severity: High]
> Does this introduce a UAPI regression for existing unquoted queries that
> contain commas?
>
> For example, if a user currently submits a query like "format a,b +p" via
> the debugfs interface, the parser would previously see three tokens: "for=
mat",
> "a,b", and "+p".
>
> With commas treated as separators here and in the loop below, wouldn't th=
is
> result in four disconnected tokens: "format", "a", "b", and "+p"?
>

Treating comma as a lexical delimiter alongside space and tab is an
intentional grammar extension, explicitly documented in
Documentation/admin-guide/dynamic-debug-howto.rst:

0. Comma separation exists specifically to solve shell and command-line
   quoting friction in space-hostile contexts (boot command lines and
   modprobe args like "modprobe drm dyndbg=3Dclass,DRM_UT_CORE,+p").

1. The dynamic debug grammar rule is uniform: any argument containing a
   lexical delimiter must be quoted. Spaces inside format strings have
   always required quotes (e.g. format "foo bar" +p). Because commas are
   now full token terminators, commas inside format arguments must also
   be quoted (e.g. format "a,b" +p).

and the user is free to add the quotes if literal "a,b" is what they wanted=
.
    #> echo format "a,b" +p >control



> >               if (!*buf)
> >                       break;  /* oh, it was trailing whitespace */
> >               if (*buf =3D=3D '#')
> > @@ -353,7 +361,7 @@ static int ddebug_tokenize(char *buf, char *words[]=
, int maxwords)
> >                               return -EINVAL; /* unclosed quote */
> >                       }
> >               } else {
> > -                     for (end =3D buf; *end && !isspace(*end); end++)
> > +                     for (end =3D buf; *end && !isspace(*end) && *end =
!=3D ','; end++)
> >                               ;
>
> [Severity: High]
> Because the parser now explicitly stops at commas within an unquoted stri=
ng,
> existing queries containing unquoted commas will be split.
>
> Since ddebug_parse_query() expects an even number of match-spec tokens
> (checking nwords % 2 !=3D 0), won't it fail and print "expecting pairs of
> match-spec <value>"?
>
> This would break automated scripts or user commands that pass unquoted
> commas in their match arguments. Is there a way to support commas as
> separators without breaking existing unquoted comma usage?

again, if theyre looking for "a,b", then they should quote it.
just like if they were looking for "a b"

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dd-cmap-=
part2-clean-v11-0-9b6c217fdf2f@gmail.com?part=3D29
