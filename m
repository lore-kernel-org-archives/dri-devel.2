Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC03ACD5BD1
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 22:31:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5151C10F615;
	Tue,  2 Jun 2026 22:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qnyyoxL3";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E42F10F384
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 17:13:12 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-13721dfd471so11302383c88.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 10:13:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780420391; cv=none;
 d=google.com; s=arc-20240605;
 b=k62uynoflzZFRA3l6BcGJoTb7pa4ZkxcG/VTrWvLbDVYn+0HfywOeNgm+vcPNAGp/h
 Cad6wPeniHwQcv8Mq/OFBFaV2d8HFSdoy9Pv8JzEEp9NkkR4tGeArnnxfEwE/2X3D75y
 vnZQMZCAECSc++KudVg6D5YfD7bQjaZHwdz02CjFyUezUJ711t3xZNTHjGehM47az/9V
 V3A3WpjAW5SgcMz+zBufabiXxAFgXNiaAfl9vJMHdb8kYtzMTLzugwbuJoS9dAJOFNow
 S5aVXymIl8SWHsf4LqTzeCN29bwtaGGltWAtVgrP67qYUuoP0wdL54P0ZzB23Lg9hsh+
 aWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TJfYQ7SmCYveUNo/x4CT0V08Q6uDUd9j8xLNrCB/Pls=;
 fh=RVswXDqsQTDVsijUtrUw8gjAxo+65mR17cx2EQga3d4=;
 b=Hc995dmuWRL/lMGWgEXfO7FgXKJv64yFYtTMAoGF61J6mxw1c+LwdA9s5jD3IvUhI2
 CAJstSLQPYzZjzolVBchkyz33MZ+RrJn5p5tCqH6YTiwh4Rz38TG8q3Ep0LaeenNmnJI
 MOaThonYQC9MOX/BKTuZb2YphRIlrVTtOr/nxWKaFMMC5v+owz9RTiIGqH7VfjRrAGm/
 QSEivetEYioNbZ8R+3UHzymmExw6IRCsLg1FTX3Z2Y/yJxlnepxIebv+a1PeQeyR4BJp
 Y9eQZr4HzXoDaWbVzW4FC6w938dOOsgu+rIp26FrfCnDyCXn4eEIPHmvKRkEh/Vw2PPZ
 uckQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780420391; x=1781025191; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TJfYQ7SmCYveUNo/x4CT0V08Q6uDUd9j8xLNrCB/Pls=;
 b=qnyyoxL3mv2DjQGBcckzm0gEx7yetrXw0MCM6Za8AC/hQk35Dn73Z5eKzHoXPmGjzL
 lxr2zJaT6gZI8C3cjBdQlKeGJWlqi0mDWdo508S8QGnns0okV9+lVZhEtbMBjwwBqiel
 dm1H2L20uyhlTfqjmlDP2b1vlOBd+WayejfvJ0C56KFaYKirWRvxh54NU5E4d5HbNmC6
 0HDzyptGKb6CaP7qNhbj7MAbv3Hj7K/yRFf3P/YKqd5R9v/bGun1R6kJjZQJ+yf1RiRM
 1EBnnOuBNKh4mgEKLmEKghAiuiQTaWIfhBd6uy7nTvsfPY92bhkmFgein5LBtEqKxvlg
 wKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780420391; x=1781025191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TJfYQ7SmCYveUNo/x4CT0V08Q6uDUd9j8xLNrCB/Pls=;
 b=a3Dioj/69/q8iG5d7eUzHOJT3b0ShkbTxlRe5ZUNcpK/8iJStqpO2K6QzKg9Cedzsb
 MqsdyJ1FpP1CpyaWwwwaFm2O/Z+Oa2iDDOnEdKLwYOPvl6DsNdcuUhlfYz4Y02O0ZWNl
 AXAogR1Zi//+u20MQT7R1f3hoO3Fv1EA9sMgMSJUfgB87ffwBBgJQ7iv3SEPNk2JF4uo
 eGjtTkeWBg+gaTS/zeCtbN8rCJt65GlQc/mz6sxNyIJcAx1fRUhbI7d4nEUrRWXHoZ5V
 oX+OVMvOhE3br121bvp6m1OZyfKcXdiFkSz45GuWS2WaGXWCrovuBtHzOmCnLq1j51p5
 akpQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ONHvo6y2yAV+ndbDcbQJkeOfkGh2z5Fz3yJI9+2K0Vfbv74JgPculcp4W29LR3n89dpbjgwCxzH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXNAudlqUtnFoYhXrnSLA8jZeb4ABY6u1lUYneJ7LNdHZ73eyK
 7lbq+ZgRBufegj/yw6G5Mofjn/SMhU4a9tYLIaZMTlEJEoes5rIKbdR+oPlSXHt/FQjUuoL4CvQ
 bXerPE0WKlEvZQ4vOUnj3B/eUwVFyUfw=
X-Gm-Gg: Acq92OEdd8zmPPVfWajmYfRYygzkiG3db1RwlRKPf4urWyIYvKZOYy4IHf5hAlkB6t8
 qsNf8AjEGsduut+YTfT8oCxyKSDwSXMqu2vCE/eV1bef3LKBupQbFGw/NpgnV0Kiz4tkxp4wWc6
 cLPrT0w7xxtEEKp6DTECfClPRvs4o2DAthAZ3KprXjFHMLsXLXP+kGFOLkpG1JMCsZ8/TuB7NZg
 eQCLSVrBf3LR9LiIhacUGXTadL9IXtU4B6Dnhs6mjQpWZxbhoHmLrtO8KC1F49UjNSUFQpe+BM5
 bk05Hl6W5Vv2rcGdQ8xGI+HuxApS
X-Received: by 2002:a05:693c:65d3:b0:306:f474:738c with SMTP id
 5a478bee46e88-306f4747844mr3906088eec.13.1780420391306; Tue, 02 Jun 2026
 10:13:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAOSULec2OpwTGB3OUb_n3CdKO6H_DGJnxw=qsBswbd+JBjemKA@mail.gmail.com>
 <CAHp75Vc15t7zmNGeuNG_fLHwCN=Ym9w5Cn92+eqbtsioGxFzCQ@mail.gmail.com>
In-Reply-To: <CAHp75Vc15t7zmNGeuNG_fLHwCN=Ym9w5Cn92+eqbtsioGxFzCQ@mail.gmail.com>
From: Enchanted Hunter <enchantedredhunter@gmail.com>
Date: Tue, 2 Jun 2026 20:12:59 +0300
X-Gm-Features: AVHnY4Ifjlgm3bm0rKt2KU-jSQcSx3CANtRAMdJpDQffQKA68-z0GjolTx4_bnc
Message-ID: <CAOSULedF6GUK_e_3KRPB+D0Jxgtow38OjQu9B1=vG-XTfsdYOA@mail.gmail.com>
Subject: Re: [PATCH] staging: fbtft: replace sprintf with snprintf
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, andy@kernel.org,
 dri-devel@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000f988e10653486cad"
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

--000000000000f988e10653486cad
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Overall, it doesn't address any compiler warnings, but this is my first
patch. I wanted to start with something concrete, and I saw an unsafe
function and tried to fix it. The fact that the compilation behavior won't
change is true, but the code will become a bit more formal =E2=80=94 maybe =
that's a
good thing.

=D0=BF=D0=BD, 1 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 11:25, Andy=
 Shevchenko <andy.shevchenko@gmail.com>:

> On Mon, Jun 1, 2026 at 3:44=E2=80=AFAM Enchanted Hunter
> <enchantedredhunter@gmail.com> wrote:
> >
> > This patch replaces unsafe sprintf calls with snprintf in
> > fbtft_register_framebuffer() to prevent potential buffer overflow.
> >
> > Signed-off-by: rat1bor <enchantedredhunter@gmail.com>
>
> Does this change address any compiler warning or something like that?
> At a glance I do not see any usefulness of this patch except an
> unneeded churn.
>
> --
> With Best Regards,
> Andy Shevchenko
>

--000000000000f988e10653486cad
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span>Overall, it doesn&#39;t address any=
 compiler=20
warnings, but this is my first patch. I wanted to start with something=20
concrete, and I saw an unsafe function and tried to fix it. The fact=20
that the compilation behavior won&#39;t change is true, but the code will=
=20
become a bit more formal =E2=80=94 maybe that&#39;s a good thing.</span></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=
=BF=D0=BD, 1 =D0=B8=D1=8E=D0=BD. 2026=E2=80=AF=D0=B3. =D0=B2 11:25, Andy Sh=
evchenko &lt;<a href=3D"mailto:andy.shevchenko@gmail.com" target=3D"_blank"=
>andy.shevchenko@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On Mon, Jun 1, 2026 at 3:44=E2=80=AFAM Enchanted Hunter=
<br>
&lt;<a href=3D"mailto:enchantedredhunter@gmail.com" target=3D"_blank">encha=
ntedredhunter@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This patch replaces unsafe sprintf calls with snprintf in<br>
&gt; fbtft_register_framebuffer() to prevent potential buffer overflow.<br>
&gt;<br>
&gt; Signed-off-by: rat1bor &lt;<a href=3D"mailto:enchantedredhunter@gmail.=
com" target=3D"_blank">enchantedredhunter@gmail.com</a>&gt;<br>
<br>
Does this change address any compiler warning or something like that?<br>
At a glance I do not see any usefulness of this patch except an<br>
unneeded churn.<br>
<br>
-- <br>
With Best Regards,<br>
Andy Shevchenko<br>
</blockquote></div>
</div>

--000000000000f988e10653486cad--
