Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A10CD6E5D
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:31:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E61510F612;
	Tue,  2 Jun 2026 22:31:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XuCoCrm0";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A034710F52B
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 19:33:46 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-304ddfcf72cso6019048eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 12:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780428826; cv=none;
 d=google.com; s=arc-20240605;
 b=EbnNeAElx2iK91ErDP0qIeGpxpkspjShZghNH0+I9JkDW6H4M1hz0dCbenU947xIvJ
 vx4i4mmgnG7oXXUbpqI6NT45hZ6rPqD/wMjmSLDFAM2PZ+MVB9JtL0Qi76o7qo2R7olV
 WE8I+ciUfxcVEjDBnVFUVVSVqoCspUXfDKzaNW93tGX3Im7zhLfTaYC5jCxAikMrYse0
 Xfa+V1xx1s/P8Xs0tKAiG2O/wugEQ3lOBr/qURCuRHuRsSG8IekKsYo8X/4vnDjTxc6H
 b8XOfl60sP4zsbEXg1xw1Jc3QCH1p8QkgJwlY0JX5n/3/CBCWovtA3oNMIkBAVNqqrZl
 mSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9Q32trZhQ3betjB25iJrISerMVqFtqzYveNpNux0sE0=;
 fh=XfdFIfc5rgMwus/2e5wzht/kU2m/ZXvPTI7UQo0Pkkw=;
 b=XH65Oayf5rEHwGF4Y8VGL507uP+NeyRnrp9pW3oFhyz3yZx/DKKK4wFHhtn+AP0ARH
 0kBxxC5Gor2qE/RO3VBjj9Pi3GdgB/V9z1vgDkcINwc51dFNF+bWa6H8S290y8DdObrl
 HIBznTAIqeG+yKTQP/rCHcRoq4gvp5/hymXV3KRAJOzG2PhFl9LYZJoLM9i5Ft8IsPZV
 oo94B/onhHBBTcLz8yItel/buA1bedU4lmyYDMHsV8vMvufaf5evAkSDbSKjbb8GrQUY
 wKKFMPo79E0TQwddhqRHI72hGw8MSrLWqR5W1ixDOOelqCVecxtUsCQMcWxaXVKl0AvK
 +hWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780428826; x=1781033626; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9Q32trZhQ3betjB25iJrISerMVqFtqzYveNpNux0sE0=;
 b=XuCoCrm0RgY9XEA0Mtv9FmREBrrYU+sLKzR03ytm1WZBq/xgznNzR6lMFZSgVfgyXR
 SG0xzdb2Je2ZowBsqRNQ/4u/5kEaho/UYj1RhSsufe3+5i9LdCTVeCQjQtLuWa0tVLiB
 I6zuFY0JU1WqC0NSQw6vWUiu7HONGrSwPu0cRWixs7UjsMqVa+130NaQuOJgpYFtK25Q
 Fgu5vekwPK5/DDv8wClCtgx/OnciRrfohF6dlquyJJdSGnG+9ZE6NE1dhnBsbBcECgSV
 /zuqWEUffqdBNjB2jfuDz0nd37HoZQ5kkTLkKyAEo4CkOl8yPxSlPtefrHdQcT3VpRiZ
 M8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780428826; x=1781033626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Q32trZhQ3betjB25iJrISerMVqFtqzYveNpNux0sE0=;
 b=G1WiixzCk8fSFJu755hnzOj9J1Dm8XqpKoL0eGSO/kuZ68HIDCKpl+aOLfiXtzUkiv
 9t3VTmRHEIbvHb7CQ4mn+kVY/yVPTdMU/s2gzqk0KehOgM8/JZBIGkRBOczjLtNWspkC
 DOwVKCbmv+X4aRQxhIgHK7kMELWjb8d424Xk0ZCbuTCc2hiP+4NyQosI2acCGu7bN+MH
 TU8y8CxptCYOguc/sUON7RQftTyd9yMMtB2TF21j7/45JOm2lziKH3Gootsl4hu7KpnZ
 fJU1E3ARlcnNJopfuYcRmtqgp2CVGw2PZRE+D7ygPlgAxRapkAhRJPwSMbf4QiJ2KAdK
 jTLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LiMwx4fVtIcPVVVzU0So5ECgijFo8rjnM70XmsQ0NqH9bH6qAZ9NhQay3yjOqQScBNyqf0/tXHlI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7NjUcV2BsokVHE3ZCObpZN1sDp3WDgCukoecbNApBbDL04JNu
 Xx0RyuDwLyOYiWcuHWGP4e+S0R8ZBZ9+gQPGTV/AW8Nxn1ZoCK4v6/hQvOu3QopTc6WNMay9231
 b3kFj0syOoEXIVCpDlxW2i+rb/gTDcf8=
X-Gm-Gg: Acq92OH9+759hwUkxD8BooO4sIxzHqxZFZl269T28iiGsKAmWV8X1fb6oEWXsDv+Rl+
 sB/bbcH9FyLcahgeiOl60jdYzBPIM79ezrpzKPHMUOe+JHVuaHgxpIwTNo+vbdLteVnFqmSlPHu
 8Bl+gCRMDlSWC7IL/OVkz8tPZnZKbMXpc1xzoPKdsATk+k2osTpoall8VJHUEBGc6X89GDT0Xms
 S9B+qPgPt2wsID1652SpjXg2yfdXtxz9qxi7A0lo7qH60NMY4QsBm4ToFiVgWWEauuL+9TmwEo+
 vdWcj59n/m9v7elauA==
X-Received: by 2002:a05:693c:300a:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-3074fb67910mr55309eec.17.1780428825742; Tue, 02 Jun 2026
 12:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
 <CAHp75Vc15t7zmNGeuNG_fLHwCN=Ym9w5Cn92+eqbtsioGxFzCQ@mail.gmail.com>
 <CAOSULedF6GUK_e_3KRPB+D0Jxgtow38OjQu9B1=vG-XTfsdYOA@mail.gmail.com>
 <CAHp75VdtOuLEkiuiUqxa3DT75y8Hd-1PtquodpN4qJ=rCFs_4Q@mail.gmail.com>
In-Reply-To: <CAHp75VdtOuLEkiuiUqxa3DT75y8Hd-1PtquodpN4qJ=rCFs_4Q@mail.gmail.com>
From: Enchanted Hunter <enchantedredhunter@gmail.com>
Date: Tue, 2 Jun 2026 22:33:34 +0300
X-Gm-Features: AVHnY4LO5aj5gePMCLGWoyXYpw3j1YKmdqPnCxhzZg20CQI-vj_aHIty6lALnAU
Message-ID: <CAOSULeev+3LsSR6QboTy7oCUbTNQOOx72vjgf_tnZcr_JKbhmQ@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace sprintf with snprintf
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, andy@kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000b4d0fe06534a6349"
X-Mailman-Approved-At: Tue, 02 Jun 2026 22:31:15 +0000
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

--000000000000b4d0fe06534a6349
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I suppose I agree with you. My patch does look silly, and I regret wasting
your time. I've just started learning kernel development. Perhaps if you
happen to have any routine task, you could suggest something that would
actually be worth doing. I'm very interested in this. I will sign with my
real name, but I'm from Russia, and I understand that this might be a big
problem right now.

=D0=B2=D1=82, 2 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 21:32, Andy=
 Shevchenko <andy.shevchenko@gmail.com>:

> On Tue, Jun 2, 2026 at 8:13=E2=80=AFPM Enchanted Hunter
> <enchantedredhunter@gmail.com> wrote:
> >
> > Overall, it doesn't address any compiler warnings, but this is my first
> patch. I wanted to start with something concrete, and I saw an unsafe
> function and tried to fix it. The fact that the compilation behavior won'=
t
> change is true, but the code will become a bit more formal =E2=80=94 mayb=
e that's a
> good thing.
>
> Not sure we need a churn on the working code.
>
> A process hint: Do not top-post.
>
> > =D0=BF=D0=BD, 1 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 11:25, =
Andy Shevchenko <andy.shevchenko@gmail.com>:
> >>
> >> On Mon, Jun 1, 2026 at 3:44=E2=80=AFAM Enchanted Hunter
> >> <enchantedredhunter@gmail.com> wrote:
> >> >
> >> > This patch replaces unsafe sprintf calls with snprintf in
> >> > fbtft_register_framebuffer() to prevent potential buffer overflow.
> >> >
> >> > Signed-off-by: rat1bor <enchantedredhunter@gmail.com>
>
> Another thing, use your real name and not an alias.
>
> >> Does this change address any compiler warning or something like that?
> >> At a glance I do not see any usefulness of this patch except an
> >> unneeded churn.
>
> --
> With Best Regards,
> Andy Shevchenko
>

--000000000000b4d0fe06534a6349
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span class=3D"gmail-">I suppose I agree =
with you. My patch does look=20
silly, and I regret wasting your time. I&#39;ve just started learning kerne=
l
 development. Perhaps if you happen to have any routine task, you could=20
suggest something that would actually be worth doing. I&#39;m very=20
interested in this. I will sign with my real name, but I&#39;m from Russia,=
=20
and I understand that this might be a big problem right now.</span></div><b=
r><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">=D0=B2=D1=82, 2 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =
=D0=B2 21:32, Andy Shevchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.c=
om">andy.shevchenko@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Tue, Jun 2, 2026 at 8:13=E2=80=AFPM Enchanted Hun=
ter<br>
&lt;<a href=3D"mailto:enchantedredhunter@gmail.com" target=3D"_blank">encha=
ntedredhunter@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Overall, it doesn&#39;t address any compiler warnings, but this is my =
first patch. I wanted to start with something concrete, and I saw an unsafe=
 function and tried to fix it. The fact that the compilation behavior won&#=
39;t change is true, but the code will become a bit more formal =E2=80=94 m=
aybe that&#39;s a good thing.<br>
<br>
Not sure we need a churn on the working code.<br>
<br>
A process hint: Do not top-post.<br>
<br>
&gt; =D0=BF=D0=BD, 1 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 11:25,=
 Andy Shevchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.com" target=3D=
"_blank">andy.shevchenko@gmail.com</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Jun 1, 2026 at 3:44=E2=80=AFAM Enchanted Hunter<br>
&gt;&gt; &lt;<a href=3D"mailto:enchantedredhunter@gmail.com" target=3D"_bla=
nk">enchantedredhunter@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; This patch replaces unsafe sprintf calls with snprintf in<br>
&gt;&gt; &gt; fbtft_register_framebuffer() to prevent potential buffer over=
flow.<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: rat1bor &lt;<a href=3D"mailto:enchantedredhunt=
er@gmail.com" target=3D"_blank">enchantedredhunter@gmail.com</a>&gt;<br>
<br>
Another thing, use your real name and not an alias.<br>
<br>
&gt;&gt; Does this change address any compiler warning or something like th=
at?<br>
&gt;&gt; At a glance I do not see any usefulness of this patch except an<br=
>
&gt;&gt; unneeded churn.<br>
<br>
-- <br>
With Best Regards,<br>
Andy Shevchenko<br>
</blockquote></div></div>

--000000000000b4d0fe06534a6349--
