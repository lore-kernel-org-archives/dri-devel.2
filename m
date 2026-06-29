Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C62C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8029010E03F;
	Mon, 29 Jun 2026 08:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TgW9Zjrc";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0858F10E03F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:32:29 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-662ebb1329aso1771178d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 01:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782721949; cv=none;
 d=google.com; s=arc-20260327;
 b=S21R8+cOV4tBotxveYaaKnZRMQZhOSgNEgjFhYP7M9G4uibGP0ed7T4sBGChkiognU
 EzOmH0ojoSqJNU0YwUlw59T2cfMFWyeLwA4f+gHHo2r3oOO94pNRXzJrGsdelBvvSFTp
 7eiP44NTy3v3Hkc+QWYNkI6BdrjMp4WGq1KC4GH294QXrS4eJm/exQNtX5rAEPzn4XE6
 +l90mMZoLwCo9h1UP3Qeh012xvklEs0At+WxyPTBZXDHfjQs+9S2Y0qvb3vWhRWzxgRu
 te43fWgyNM4jWiH/meT1pmpL5Nrf/kywotg8hz/hNR/Ash/jNYweQXT4gD2df+jytdc5
 +NYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0OGxAqovijs+7cXCtbhWhwlyJk66go2fepY9edT2JPs=;
 fh=9gflIqG1zWat/s2d7i3BXFKnZZ4uE5Gk3yDFGboiub4=;
 b=f1LsUldAvMbAFCwM2uwT2gmPYfrBSHgPmTnA5pvCmJY9FPvTfDdBH+frtpA+GA/77P
 jHXE1/aqmMJFHuwpooJF5IBDbevGWjZg5LqmL0ZSHsTdPNGpuWxEkNp0cliUMoTiLt5r
 QbE/xpd8eB3AbnIsDVvVMOUJ1Fh9dxzu0EHVXX0IPnSKGmScBwVzP7zYCnnq5BVcjjDg
 l74xr6gSrr0OO/IaiYA2KwcTH7bMkHTch/7LwE/O9c2zqD44CStAvdeUBsm3sEM52kHt
 b/9LJ8bTCGK4t4k72WRg9wEfsbMsQytn48Uz3nPwnyflToU63ipHwUcRs+jD2mhch/xK
 ou8w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782721949; x=1783326749; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0OGxAqovijs+7cXCtbhWhwlyJk66go2fepY9edT2JPs=;
 b=TgW9Zjrc1kqfcWNqBLnNv3UhAf+a2k++7ppF52YCB4DRDh4DRvhA1znGXeEtSDZZRz
 YHNpQKokNoPjL9t5sR9DGjM2v0D7Lid8dAS25CS8wLDy5xLasBUblnWjMB1MpS25ekmO
 j1SVO+x8tl0mBb89nizNNi9RmdYChAs3JgiutgCuegwr2e5zMFAQSybdETT/cMA5BgpS
 6V1Y0PvEoKNw7MRGk0+NLpvlxlfgfS5oBQUNkXmIs43qfMn2GKoUjqF65yhv/oFCyuKV
 x2PXjznh+UVfEu+954UCPGQp5rD1phi3OjE4NE5/smYEsjdOIfBfN+VOdWJhu40Q5VtW
 vARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782721949; x=1783326749;
 h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0OGxAqovijs+7cXCtbhWhwlyJk66go2fepY9edT2JPs=;
 b=ILcJeHYirJmwYMb+arHoUporzaKy6FQBvgHr7NahLlHSDFuwT0fKsZwvfwwQyPMqZz
 Z+jehIwLIhm9PzEHNZTfc6Or/Lp3wjjMJi63PxpRBDjrLiITgROnkO5fH0YCZ5tjpjYM
 HDopawhBmsDd/jsbhjSjpGipZelj/o6N/NrPGX4yHZaTVCkV2lCvvfO67UbBedWDxpLU
 /6dQliw514fz1WwEyZql10+U0r2C9OMz4vE/OegQIQA8M1DPONujqn+OToEU3KQc/2I7
 ZAZ1D5uE1hzRHkThQ9haM5ppIETxxcLawoRg9hLc150/Lb0EXC3Ui9T+UYpMKTDr/959
 GSEw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3WAgO/28zzMRfo/iEsf4A0z8+GY/Y36B1P3GHrqdg82rBJnhT642KfmczRefOTb4or10l6RYnouM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2k6YkREpLcrdTXAREyDpjQh8bKPOiPkYiKPYV3jWPtu15GkyD
 i/kMo0QpWa5AWpQvzFtc7g/VwwzIfqHJgSFloyGr8B6PWsjR2urOmc+Td3qJmnMiuDzEeLkiN/L
 ebraF/+FpW40L8SgaBow1ZqPqMmZhwUg=
X-Gm-Gg: AfdE7cmpmROjBwUCG/WDhPO5+jVhQ+wJl0Ke+faYxU8QIIQoyugkJbaDg06VNNSdgu0
 MC2SkmC7BowjWppJEMHZd0PnJIn09e3xtE6KVQOdZm0lKCmu3gM3QECtzrcVBDUCQW4Dtu7s9Gc
 JGdMuMvAO7nJZsYlhDjPQdRTMmxBBc2Bz+7eFezD1jtbRvgqtZZez2mxet9okrkKdr6xSL2BfcN
 ESD13xyEMBoqbiwNfbkwFYIIfegPPQJWuKp9j1rXfbC2tkxZkwp8NoNKbFhfH8MPyhpK3XMScfU
 YCqWXZ4HZ082mkxxm3T7hlpTwEE0Z143shTb5fc=
X-Received: by 2002:a05:690c:3706:b0:80d:c2cc:f67a with SMTP id
 00721157ae682-80dc2cd05a3mr49197357b3.38.1782721948672; Mon, 29 Jun 2026
 01:32:28 -0700 (PDT)
MIME-Version: 1.0
References: <aj5neetgYdu0QpcK@GRAPHRT> <20260629094419.6bb56d99@fedora-2.home>
In-Reply-To: <20260629094419.6bb56d99@fedora-2.home>
From: Erik Faye-Lund <kusmabite@gmail.com>
Date: Mon, 29 Jun 2026 10:31:50 +0200
X-Gm-Features: AVVi8CfyDy7wdmQRBtdUUoaeCB5v9_-wvxYFDwHeoEjB60cKt2Gpgm5W5qq3jm4
Message-ID: <CABPQNSa0-wqQTm0CzLFojWZLVY5OqQxWTXrpO=O4p8go52808Q@mail.gmail.com>
Subject: Re: [BUG] drm/panthor: intermittent freezes in Xorg xserver
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Marius Dinu <m95d+git@psihoexpert.ro>, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>
Content-Type: multipart/alternative; boundary="0000000000007be7c70655604c9c"
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
Reply-To: kusmabite@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

--0000000000007be7c70655604c9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I wonder if you're experiencing the same issue as this?

https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15116

On Mon, Jun 29, 2026 at 10:24=E2=80=AFAM Boris Brezillon <
boris.brezillon@collabora.com> wrote:

> On Fri, 26 Jun 2026 14:50:17 +0300
> Marius Dinu <m95d+git@psihoexpert.ro> wrote:
>
> > Hi.
> >
> > The system is Radxa Rock 5 ITX, RK3588, 32GB RAM,
> > mainline kernel v7.1.0 with panthor driver, mesa 26.0.7 with panfrost
> driver,
> > xorg-server v21.1.22 accelerated by modesetting driver, x11perf v1.7.0.
>
> Are we sure that's a panthor issue? Also, is this a regression
> introduced by the latest kernel version, or has it been like that from
> the start?
>
> Also, would you mind opening an issue on [1]?
>
> >
> > The most clean way to reproduce this bug:
> > Form a console or ssh session, start Xorg in background, without a wind=
ow
> > manager, and then run x11perf on that display.
> >
> > Xorg :0 &
> > x11perf -all -display :0
> >
> > The bug: weird intermittent performance issues in some of the tests.
> > Examples:
> >
> >     1000 reps @  18.0799 msec (    55.3/sec): 10x10 rectangle outline
> >     1000 reps @  18.0791 msec (    55.3/sec): 10x10 rectangle outline
> >     1000 reps @  18.0790 msec (    55.3/sec): 10x10 rectangle outline
> >     1000 reps @  18.0789 msec (    55.3/sec): 10x10 rectangle outline
> >     1000 reps @   0.0287 msec ( 34800.0/sec): 10x10 rectangle outline
> >     5000 trep @  14.4691 msec (    69.1/sec): 10x10 rectangle outline
> >
> >  5000000 reps @   0.0029 msec (345000.0/sec): 1-pixel solid circle
> >  5000000 reps @   0.0009 msec (1100000.0/sec): 1-pixel solid circle
> >  5000000 reps @   0.0012 msec (818000.0/sec): 1-pixel solid circle
> >  5000000 reps @   0.0000 msec (20900000.0/sec): 1-pixel solid circle
> >  5000000 reps @   0.0000 msec (32300000.0/sec): 1-pixel solid circle
> > 25000000 trep @   0.0010 msec (979000.0/sec): 1-pixel solid circle
> >
> >     1000 reps @  31.6607 msec (    31.6/sec): Fill 10x10 trapezoid
> >     1000 reps @  16.9012 msec (    59.2/sec): Fill 10x10 trapezoid
> >     1000 reps @   0.0234 msec ( 42700.0/sec): Fill 10x10 trapezoid
> >     1000 reps @   0.0272 msec ( 36700.0/sec): Fill 10x10 trapezoid
> >     1000 reps @  32.1268 msec (    31.1/sec): Fill 10x10 trapezoid
> >     5000 trep @  16.1479 msec (    61.9/sec): Fill 10x10 trapezoid
> >
> > There are no messages in kernel log or Xorg log.
> >
> > Visually, most of the tests runs fast as expected, but in some of the
> tests
> > it gets "stuck" randomly. The test suddenly freezes while drawing the
> pattern.
> > Then, after a while (a few seconds up to a couple of minutes), it gets
> > unstuck by itself, draws a few more patterns extremely fast for less
> than a
> > second, and then it gets stuck again.
>
> It smells like a signalling issue. Can you check the CPU activity and
> report any outstanding process? Can you maybe connect a gdb to the
> x11perf to see where it's blocked, and post the backtrace here (or in
> the gitlab issue)?
>
> Regards,
>
> Boris
>
> [1]https://gitlab.freedesktop.org/mesa/mesa
>

--0000000000007be7c70655604c9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I wonder if you&#39;re experiencing the same issue as=
 this?</div><div><br></div><div><a href=3D"https://gitlab.freedesktop.org/m=
esa/mesa/-/work_items/15116">https://gitlab.freedesktop.org/mesa/mesa/-/wor=
k_items/15116</a></div></div><br><div class=3D"gmail_quote gmail_quote_cont=
ainer"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 29, 2026 at 10:24=
=E2=80=AFAM Boris Brezillon &lt;<a href=3D"mailto:boris.brezillon@collabora=
.com">boris.brezillon@collabora.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">On Fri, 26 Jun 2026 14:50:17 +0300<br>
Marius Dinu &lt;<a href=3D"mailto:m95d%2Bgit@psihoexpert.ro" target=3D"_bla=
nk">m95d+git@psihoexpert.ro</a>&gt; wrote:<br>
<br>
&gt; Hi.<br>
&gt; <br>
&gt; The system is Radxa Rock 5 ITX, RK3588, 32GB RAM,<br>
&gt; mainline kernel v7.1.0 with panthor driver, mesa 26.0.7 with panfrost =
driver,<br>
&gt; xorg-server v21.1.22 accelerated by modesetting driver, x11perf v1.7.0=
.<br>
<br>
Are we sure that&#39;s a panthor issue? Also, is this a regression<br>
introduced by the latest kernel version, or has it been like that from<br>
the start?<br>
<br>
Also, would you mind opening an issue on [1]?<br>
<br>
&gt; <br>
&gt; The most clean way to reproduce this bug:<br>
&gt; Form a console or ssh session, start Xorg in background, without a win=
dow<br>
&gt; manager, and then run x11perf on that display.<br>
&gt; <br>
&gt; Xorg :0 &amp;<br>
&gt; x11perf -all -display :0<br>
&gt; <br>
&gt; The bug: weird intermittent performance issues in some of the tests.<b=
r>
&gt; Examples:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 18.0799 msec (=C2=A0 =C2=A0 55.3/=
sec): 10x10 rectangle outline<br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 18.0791 msec (=C2=A0 =C2=A0 55.3/=
sec): 10x10 rectangle outline<br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 18.0790 msec (=C2=A0 =C2=A0 55.3/=
sec): 10x10 rectangle outline<br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 18.0789 msec (=C2=A0 =C2=A0 55.3/=
sec): 10x10 rectangle outline<br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 =C2=A00.0287 msec ( 34800.0/sec):=
 10x10 rectangle outline<br>
&gt;=C2=A0 =C2=A0 =C2=A05000 trep @=C2=A0 14.4691 msec (=C2=A0 =C2=A0 69.1/=
sec): 10x10 rectangle outline<br>
&gt; <br>
&gt;=C2=A0 5000000 reps @=C2=A0 =C2=A00.0029 msec (345000.0/sec): 1-pixel s=
olid circle<br>
&gt;=C2=A0 5000000 reps @=C2=A0 =C2=A00.0009 msec (1100000.0/sec): 1-pixel =
solid circle<br>
&gt;=C2=A0 5000000 reps @=C2=A0 =C2=A00.0012 msec (818000.0/sec): 1-pixel s=
olid circle<br>
&gt;=C2=A0 5000000 reps @=C2=A0 =C2=A00.0000 msec (20900000.0/sec): 1-pixel=
 solid circle<br>
&gt;=C2=A0 5000000 reps @=C2=A0 =C2=A00.0000 msec (32300000.0/sec): 1-pixel=
 solid circle<br>
&gt; 25000000 trep @=C2=A0 =C2=A00.0010 msec (979000.0/sec): 1-pixel solid =
circle<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 31.6607 msec (=C2=A0 =C2=A0 31.6/=
sec): Fill 10x10 trapezoid<br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 16.9012 msec (=C2=A0 =C2=A0 59.2/=
sec): Fill 10x10 trapezoid<br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 =C2=A00.0234 msec ( 42700.0/sec):=
 Fill 10x10 trapezoid<br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 =C2=A00.0272 msec ( 36700.0/sec):=
 Fill 10x10 trapezoid<br>
&gt;=C2=A0 =C2=A0 =C2=A01000 reps @=C2=A0 32.1268 msec (=C2=A0 =C2=A0 31.1/=
sec): Fill 10x10 trapezoid<br>
&gt;=C2=A0 =C2=A0 =C2=A05000 trep @=C2=A0 16.1479 msec (=C2=A0 =C2=A0 61.9/=
sec): Fill 10x10 trapezoid<br>
&gt; <br>
&gt; There are no messages in kernel log or Xorg log.<br>
&gt; <br>
&gt; Visually, most of the tests runs fast as expected, but in some of the =
tests<br>
&gt; it gets &quot;stuck&quot; randomly. The test suddenly freezes while dr=
awing the pattern.<br>
&gt; Then, after a while (a few seconds up to a couple of minutes), it gets=
<br>
&gt; unstuck by itself, draws a few more patterns extremely fast for less t=
han a<br>
&gt; second, and then it gets stuck again.<br>
<br>
It smells like a signalling issue. Can you check the CPU activity and<br>
report any outstanding process? Can you maybe connect a gdb to the<br>
x11perf to see where it&#39;s blocked, and post the backtrace here (or in<b=
r>
the gitlab issue)?<br>
<br>
Regards,<br>
<br>
Boris<br>
<br>
[1]<a href=3D"https://gitlab.freedesktop.org/mesa/mesa" rel=3D"noreferrer" =
target=3D"_blank">https://gitlab.freedesktop.org/mesa/mesa</a><br>
</blockquote></div>

--0000000000007be7c70655604c9c--
