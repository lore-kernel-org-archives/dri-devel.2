Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F676CD6E64
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 09:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF6BE10FA84;
	Wed,  3 Jun 2026 09:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sbu4P3BE";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD0CF10FA93
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 09:14:41 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-3045c195251so12888649eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 02:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780478081; cv=none;
 d=google.com; s=arc-20240605;
 b=k/cGUamT7lRU+T8TCYAg/N1+VbdX8PNGIWx9ki1RQNUP655FjK9VvozQglxw35JGvc
 KkIFuKpiy3rygEFbFkQMC5w5MC8UzMycK0uUtNLXGE9zsMZP9xm0wSXvLIFBxw4aQzfy
 ivoz6AxzVrEFhorD2SY6w0rilHkMMXBd3xNqzLVM2lIDeowMJUfnbZaLIX/C/fYGtbXu
 IiYuBGbklg723q78H/YwoX5WMZ7BAoN+eEiEfXd1vgweMxpz9dsKfjQKxmRP2Ex+cu15
 +JP6XcODEWi+E/tljOtkOYZsTMnXLj1k4QTXmy5RaJQS+5aGGZvJG1SO+kgsTDLkD3m5
 TkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Qly96tLqUufOrz99VbL4NP2+YlJ8ThHwzd10hgn+1b8=;
 fh=zJf6p3rXqvaDFz1lFAclh0AVUu7PsScHseOAS1j1vDE=;
 b=BAqOjkPbBQPuutelSeUIpN4UXsDj4+QSevPRZFhtHcY2v6j9YBVzMaCDway0KbquCe
 gYY6FY9bVEKXQkfm8uNQ08q/BorcOucfvOO76/sYUehWm16Vm2XcqITd5LJsIzWIwTbb
 MZpsNabfz3+bbCCzw7qNBtdWwLzyUR+w9pW3o55nQmRmHPBjyOm6GNx2Lx+u+ttTQw1U
 VHgF/HMdDlkUVjew0gkOgDUkrkLjOsZLwU7A+OOS+zr1aCKC2XgH+nU9/iP4cfX8NcbL
 A0m1rPFD5NICzWcwIda8U2U7tNhr+cSCMrMkruhrGORNCzWlmq9lPhBjHgtjRAExzu0s
 3bmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780478081; x=1781082881; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qly96tLqUufOrz99VbL4NP2+YlJ8ThHwzd10hgn+1b8=;
 b=Sbu4P3BEPoFSwO9DJdwi6KPV0TIQfqjwgywsiGcAxOq60ybkJu2fVaf2cojyFPlHYB
 i7MdrNVdVqu2MAoFGKjO/h6ipeOV8li4v+QPU+a2N61RZQJNIA05F29qUVuvacalfdmh
 N/0FY2Giv7pzNsozY8avRe7Gkb5bQZ7B60WvIkdLmAgVzrac/4QsSXZPUE+S1nopw2Wn
 qndJNVz+tvu88ezmMb1UiZZrXZ1NsvwpSdZDVoDE+Nkjc0A5pZPfwpr3fhgBBo4nWJD4
 LAvXXX9bdfPDoS+TkG9aobA55GjALr7GivS0ADoq7VsFM3fEPAvpALI+CO3oeJ9aV4Yx
 JZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780478081; x=1781082881;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qly96tLqUufOrz99VbL4NP2+YlJ8ThHwzd10hgn+1b8=;
 b=MXvfm8Rw8KShBPEZUzEjoRt2A3u6g1JV2JIjr+Nao0SyIVKOTXRmAaIYKqqTFlbCU0
 8WpPUObO3S1Q+UEA1RBYX8S0KFNp4QJudx8htvthqgYZtaCvX12dXjdLvvqdKRlY4tZe
 ws8XOKFrA6Z/GplCl0OdBIOcGGGcutmwJc6bIz15Dg0owKdFQo4ss0MAoX4LmvWs7FNp
 K5s5AfsKMcG7j3QAfmssrVoqlzKbi3lYWII7gIeL4UrskN47WPf2Io1pVYKsvAqgwnZv
 UZXiB1TUlzXpPvTWNrKpPZjGNKEbLm0s6k32rp7R3ygD5TP8uSDRj/Fh6L2UdtlIJ1fo
 xrug==
X-Forwarded-Encrypted: i=1;
 AFNElJ92TtoXqSP0gdnYKvyIDSDk6a2AqzjPJceODeKdBVaL1LhpojsqvLYdbcvi+3zZzBHbhHJgowAqaX0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyidOorx2nE2Ti1JP4+u0ioYglnIn3VVnAp4ydv4rHB2YywlQXZ
 ZZquWiKWdpMmd8fb4DUEfoUz99o5PwNt6o0grclhVyGQ/L8xLtO5cJgsLS11YDMQWA3CwTuPon7
 Fm8XFpeFkerZTP6lvlRgH1VWz1QyjGhI=
X-Gm-Gg: Acq92OGonbG6IgJlJetVjTQTg9qFpFS1FYgn/aHOy1S4C0QmkdxqFFiOMk2CyIpc3cm
 d7yE3Odyy7pGKb2I0Z3pF+h73fM0+q1QKNFqQJNvj7BmzXSpc2nnmslFGo4v3b3HBSIC4aY2r24
 gr6UJAeEz+8aPVAhh5QmguoFknG7atOkT/PII6Z2Yn/ktTN1kWyyy3lXXleXoRapn42Y1hMnmff
 k/SRsn+6U/HwABy+ImZhL6YaLQotEFK9/zlgdkDk7abnkkHoMDQJZotcCKutl3LNhPFV2h1f+2O
 BwsIuAtMKu+D1xakIg==
X-Received: by 2002:a05:693c:63ce:b0:304:c651:bdea with SMTP id
 5a478bee46e88-3074fb57117mr682975eec.21.1780478080691; Wed, 03 Jun 2026
 02:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
 <CAHp75Vc15t7zmNGeuNG_fLHwCN=Ym9w5Cn92+eqbtsioGxFzCQ@mail.gmail.com>
 <CAOSULedF6GUK_e_3KRPB+D0Jxgtow38OjQu9B1=vG-XTfsdYOA@mail.gmail.com>
 <CAHp75VdtOuLEkiuiUqxa3DT75y8Hd-1PtquodpN4qJ=rCFs_4Q@mail.gmail.com>
 <CAOSULeev+3LsSR6QboTy7oCUbTNQOOx72vjgf_tnZcr_JKbhmQ@mail.gmail.com>
 <ah9_utsktDp4oN9E@ashevche-desk.local>
In-Reply-To: <ah9_utsktDp4oN9E@ashevche-desk.local>
From: Enchanted Hunter <enchantedredhunter@gmail.com>
Date: Wed, 3 Jun 2026 12:14:29 +0300
X-Gm-Features: AVHnY4KfnZSEb3xpMbBBxDhgcrPfJ1sNC0lcOUa8IrwcjwggCM5bUggzIwQbl10
Message-ID: <CAOSULed6efCh6EYdv8gbOFdPxVrjEmXV0SJC6YR+aqBKkZ4wQw@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace sprintf with snprintf
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, gregkh@linuxfoundation.org, 
 linux-staging@lists.linux.dev, andy@kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000087b250065355db52"
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

--00000000000087b250065355db52
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 3 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 04:13, Andy=
 Shevchenko <andriy.shevchenko@intel.com>:

>
>
> Please, stop top-posting.
>
> On Tue, Jun 02, 2026 at 10:33:34PM +0300, Enchanted Hunter wrote:
> > I suppose I agree with you. My patch does look silly, and I regret
> wasting
> > your time. I've just started learning kernel development. Perhaps if yo=
u
> > happen to have any routine task, you could suggest something that would
> > actually be worth doing. I'm very interested in this. I will sign with =
my
> > real name, but I'm from Russia, and I understand that this might be a b=
ig
> > problem right now.
>
> I have this [1]. It shouldn't be a problem as long as you are not working
> for
> the OFAC sanctioned entity or tied to them in any ways.
>
>
> > =D0=B2=D1=82, 2 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 21:32, =
Andy Shevchenko <andy.shevchenko@gmail.com>:
> >
> > > On Tue, Jun 2, 2026 at 8:13=E2=80=AFPM Enchanted Hunter
> > > <enchantedredhunter@gmail.com> wrote:
> > > >
> > > > Overall, it doesn't address any compiler warnings, but this is my
> first
> > > patch. I wanted to start with something concrete, and I saw an unsafe
> > > function and tried to fix it. The fact that the compilation behavior
> won't
> > > change is true, but the code will become a bit more formal =E2=80=94 =
maybe
> that's a
> > > good thing.
> > >
> > > Not sure we need a churn on the working code.
> > >
> > > A process hint: Do not top-post.
> > >
> > > > =D0=BF=D0=BD, 1 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 11:=
25, Andy Shevchenko <
> andy.shevchenko@gmail.com>:
> > > >>
> > > >> On Mon, Jun 1, 2026 at 3:44=E2=80=AFAM Enchanted Hunter
> > > >> <enchantedredhunter@gmail.com> wrote:
> > > >> >
> > > >> > This patch replaces unsafe sprintf calls with snprintf in
> > > >> > fbtft_register_framebuffer() to prevent potential buffer overflo=
w.
> > > >> >
> > > >> > Signed-off-by: rat1bor <enchantedredhunter@gmail.com>
> > >
> > > Another thing, use your real name and not an alias.
> > >
> > > >> Does this change address any compiler warning or something like
> that?
> > > >> At a glance I do not see any usefulness of this patch except an
> > > >> unneeded churn.
>
> [1]: https://gist.github.com/andy-shev/a2cb1ee4767d6d2f5d20db53ecb9aabc
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>  I don't work for any organizations that are under OFAC sanctions. Sorry
for the top-posting.

--00000000000087b250065355db52
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 3 =D0=
=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 04:13, Andy Shevchenko &lt;<a =
href=3D"mailto:andriy.shevchenko@intel.com" target=3D"_blank">andriy.shevch=
enko@intel.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><br>
<br>
Please, stop top-posting.<br>
<br>
On Tue, Jun 02, 2026 at 10:33:34PM +0300, Enchanted Hunter wrote:<br>
&gt; I suppose I agree with you. My patch does look silly, and I regret was=
ting<br>
&gt; your time. I&#39;ve just started learning kernel development. Perhaps =
if you<br>
&gt; happen to have any routine task, you could suggest something that woul=
d<br>
&gt; actually be worth doing. I&#39;m very interested in this. I will sign =
with my<br>
&gt; real name, but I&#39;m from Russia, and I understand that this might b=
e a big<br>
&gt; problem right now.<br>
<br>
I have this [1]. It shouldn&#39;t be a problem as long as you are not worki=
ng for<br>
the OFAC sanctioned entity or tied to them in any ways.<br>
<br>
<br>
&gt; =D0=B2=D1=82, 2 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 21:32,=
 Andy Shevchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.com" target=3D=
"_blank">andy.shevchenko@gmail.com</a>&gt;:<br>
&gt; <br>
&gt; &gt; On Tue, Jun 2, 2026 at 8:13=E2=80=AFPM Enchanted Hunter<br>
&gt; &gt; &lt;<a href=3D"mailto:enchantedredhunter@gmail.com" target=3D"_bl=
ank">enchantedredhunter@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Overall, it doesn&#39;t address any compiler warnings, but t=
his is my first<br>
&gt; &gt; patch. I wanted to start with something concrete, and I saw an un=
safe<br>
&gt; &gt; function and tried to fix it. The fact that the compilation behav=
ior won&#39;t<br>
&gt; &gt; change is true, but the code will become a bit more formal =E2=80=
=94 maybe that&#39;s a<br>
&gt; &gt; good thing.<br>
&gt; &gt;<br>
&gt; &gt; Not sure we need a churn on the working code.<br>
&gt; &gt;<br>
&gt; &gt; A process hint: Do not top-post.<br>
&gt; &gt;<br>
&gt; &gt; &gt; =D0=BF=D0=BD, 1 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=
=B2 11:25, Andy Shevchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.com"=
 target=3D"_blank">andy.shevchenko@gmail.com</a>&gt;:<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; On Mon, Jun 1, 2026 at 3:44=E2=80=AFAM Enchanted Hunter<=
br>
&gt; &gt; &gt;&gt; &lt;<a href=3D"mailto:enchantedredhunter@gmail.com" targ=
et=3D"_blank">enchantedredhunter@gmail.com</a>&gt; wrote:<br>
&gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt;&gt; &gt; This patch replaces unsafe sprintf calls with snpri=
ntf in<br>
&gt; &gt; &gt;&gt; &gt; fbtft_register_framebuffer() to prevent potential b=
uffer overflow.<br>
&gt; &gt; &gt;&gt; &gt;<br>
&gt; &gt; &gt;&gt; &gt; Signed-off-by: rat1bor &lt;<a href=3D"mailto:enchan=
tedredhunter@gmail.com" target=3D"_blank">enchantedredhunter@gmail.com</a>&=
gt;<br>
&gt; &gt;<br>
&gt; &gt; Another thing, use your real name and not an alias.<br>
&gt; &gt;<br>
&gt; &gt; &gt;&gt; Does this change address any compiler warning or somethi=
ng like that?<br>
&gt; &gt; &gt;&gt; At a glance I do not see any usefulness of this patch ex=
cept an<br>
&gt; &gt; &gt;&gt; unneeded churn.<br>
<br>
[1]: <a href=3D"https://gist.github.com/andy-shev/a2cb1ee4767d6d2f5d20db53e=
cb9aabc" rel=3D"noreferrer" target=3D"_blank">https://gist.github.com/andy-=
shev/a2cb1ee4767d6d2f5d20db53ecb9aabc</a><br>
<br>
-- <br>
With Best Regards,<br>
Andy Shevchenko<br>
<br>
<br></blockquote><div>=C2=A0<span class=3D"gmail-">I don&#39;t work for any=
 organizations that are under OFAC sanctions. </span><span class=3D"gmail-"=
>Sorry for the top-posting.</span></div></div></div>
</div>

--00000000000087b250065355db52--
