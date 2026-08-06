Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60DFC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 23:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E6110E23F;
	Wed,  5 Aug 2026 23:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NvPn1PG/";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF0410E23F
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 23:29:50 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-69c108fee7fso2250141a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 05 Aug 2026 16:29:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785972589; cv=none;
 d=google.com; s=arc-20260327;
 b=G1Wp/ug/z7EqMhK5+yfmG6ES1rvtfacQEGjHgli4FPAPcqsW0Gw3Z69r4CF+pIYdBo
 igD50S/CsnXQXGUwSqqQ9KGdhkxcW4SbsPjzGBK9qJYEioltBM3Lmjb48h6U/ebV7qcq
 rTU/dyBDmFSYvFlTMxrnsV3P8SdKEolbDAR58yvO18POosH45w1JKQjsCwm3/zhHa5/6
 uvPWJYxtwsSPguxmWBfnbFNvJvNx79a8+nwvNH11Uo0Y38gV/981GJo2ayPIiFH03++9
 fx/0ONOIpy8JmxMGaqmUY/XyNUufwUGkpel8369dcSDcYw2MLZ6c6DkNLNpnXKNh3Qrj
 koNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MTSoKJ2hblhaC6ZNsPcka3G1aJYd4eOopX2GWEssqdE=;
 fh=zEEk1Bsxg3c8XjE1vzFZbBEU2CGCWkCh0dBpo+mgl28=;
 b=DTl9XLNk/eGJhtZVgR4sbVKfygjD8Mq8wrOqfAejRDlRxZiDcLOKHHi3/0HLP8d4XR
 0APHzlrsuKIZk86oE3QA32NQPphN8wq50AWQuYxoIEr/Q2Tj/1XgfElrkbhy/eYVN6+P
 grTMvo1Rvz1QL67vfUV6g0wRQYBUxWvw9UlZgcum8/XN4Z3g7bVwQrLY1YjT6hPzJMe2
 rnhwS4srYzYH8c1vhdDUvbYUAALLsLQ2xsaP7nIegSkU+Xhqs9bmKJhjfjYxMhOcsYWt
 yuEi4+yTmgmDRvjjFVnv758qOS8N5q6hx/3CeZJe2SwCA3of2nREbuII+37WNyu0nNAj
 ZzKQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785972589; x=1786577389; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MTSoKJ2hblhaC6ZNsPcka3G1aJYd4eOopX2GWEssqdE=;
 b=NvPn1PG/3Gslimnu8XN/ZiZzrbBHqB5S29TbQqrbLQJJAkp7chR+SxP5HzOOjif9nx
 IT1KcPuUfPuR4hgdp7ArxJNDbIoXcZxoHkMFZ8IbGLtYygVcjSx+W62rHcpVMf4+8KFx
 D6CShfNFnlmYTZV3551Cfi8GqwkusflO0QRegtqorEZqHSO+AXWjqeyJKlmQyRvruOql
 yphLTKVWPCst6AkKKJKtakjHI2lhniItQv+ybX91B/OZZmRLS22BKv6DnB5VxSmn41VK
 WWEustGsvn2Bi8p/d679Lu+NAJLFfHFANBgB9x53SmY4LfRILqUW2pa8/sNSJ+YJYepH
 1Zig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785972589; x=1786577389;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MTSoKJ2hblhaC6ZNsPcka3G1aJYd4eOopX2GWEssqdE=;
 b=gCA7gcwjHZUh20wk5T7g0d+Og2XHd6l2D7z6uHM1Cr5ia8VGNt9sR+PNR69DtoEW14
 Xbn+EQEAnFL2jI2SbfNlaOWBmgdgRlb5PLqOW2cDhxpMR85Ay8qWQQjtrZoQ9V+4xORn
 Sse5loYk9BgaN9ATJ3UW4EPhxyj0CcM1pNPK5HvE+2l7lgMZfwDnQ4GTDjHxi9bZmb/9
 TFwUQjkx7PAps4RD2VP8joK1PtKgrB2zv91WrM/gRLYtYi2qc/0H2wuHzEUClJNweECE
 nn4igZ6cDOJlWlYGZGG3tYargbDKRyS9gR7xxXf3svsJxRMGDjeWit0YdNN0MRI7cyTj
 958g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSf9kiz+JaLSVO6IZx0HeVdqPR7yh/rAANAflJkcxEwwxMotI+qWkiJ9RMqGpaRakXkvORol55Tlk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoHxtdvCQmR7tnTpuct6i5CjCuyRYXjjURTDyey6N6Dzeq8B47
 jnyfchtNY6H3JL5m4HAtjBVtReCjTto/L+sG5ibsrWF6Je8KH52RBjQq9bMqJtKr03eZ4ks/MVV
 vyuthPZqbx1N7VD+kg//W2KGCXIP7eFw=
X-Gm-Gg: AR+sD13qyZchqSKi+vwPbNxdJhGTcZIczr/yrPAl8mC5rf2rAjO/wIRVAVImB3fT5Da
 5PuFLlVU5xbNPzycvhhZpyVxX7zt7eMN7GRR9A10eCFP03WlqNm0RMFj7K5sQKpJDBH5FpbXNKc
 BtZ3aZltvZZVG4o4OtY/PlqbsF7+NdDUzhLhAStZzq8BRyoTQzkw+wJ7hfQB6e76+q09ZaNYpEY
 Xj4cwqD8oEgl/qxLv4+5wVQ0OBHxhI/oCACFTYZl/zkaQQftjmp897rEHYlqoDkgBLBlB4/7t5z
 cGfXL9aHslVlv2SbDU50rifg0G29v51BvmIAERky73m2
X-Received: by 2002:a05:6402:c45:b0:6a0:8885:e6ea with SMTP id
 4fb4d7f45d1cf-6a14f0c51dfmr5738361a12.6.1785972588952; Wed, 05 Aug 2026
 16:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260804225617.264861-1-maximpedraza@gmail.com>
 <20260805140941.GA495716-robh@kernel.org>
In-Reply-To: <20260805140941.GA495716-robh@kernel.org>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Thu, 6 Aug 2026 03:29:35 +0200
X-Gm-Features: AUfX_mwz5ayJK-cjMOmnYRs5QzSleK6Vf1I78jG8sHW7TJviplVzPHQLkrOC4xU
Message-ID: <CAEUXW=HQA7Hwo7m1s5=6mNsbLg3doc4rgg+_+6tTPD2sUxTQdA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Boot logo supplied by the device tree
To: Rob Herring <robh@kernel.org>
Cc: Helge Deller <deller@gmx.de>, Geert Uytterhoeven <geert@linux-m68k.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Maxime Ripard <mripard@kernel.org>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

El mi=C3=A9, 5 ago 2026 a las 16:09, Rob Herring (<robh@kernel.org>) escrib=
i=C3=B3:
> Why is this linux specific? Don't people want to do a splash screen in
> u-boot or other firmware?

You are right, and I had not questioned the name. Looking at chosen.yaml,
the split is clear: the "linux," properties are kernel-internal structures
(initrd, kexec handover, the UEFI memory map), while anything a second
implementation could reasonably consume has no prefix at all -- bootargs,
bootsource, stdout-path, kaslr-seed. A boot logo is squarely in the second
group, and simple-framebuffer, which this sits next to, carries no vendor
prefix either.

There is a second Linux-ism in there that your question made me notice:
the 224 in the format. That is 256 minus the 32 palette entries fbcon
reserves for the console, which means nothing outside Linux. The 32 entry
offset itself is already applied by the kernel rather than by the binding,
so it is only the limit that leaks.

Rather than guess at the shape you would want, I would rather ask, since
both the name and the format follow from your answer.

On the name: dropping the prefix would give something like
"boot-logo-clut224", or "boot-logo" with the format named by a property.
Is a bare, unprefixed compatible acceptable here, the way
simple-framebuffer is, or would you rather see this described some other
way entirely?

On the format, two options that I can see:

  a) Keep a palette, but allow the full 256 entries, so that the limit
     Linux applies is a kernel limitation rather than part of the binding.

  b) Reuse the simple-framebuffer vocabulary, format =3D "r5g6b5" and so on=
,
     with raw pixels.

I lean towards (a), because the palette is what makes carrying the image
in the device tree viable at all: our own 800x480 logo is 17 KiB paletted
and 768 KiB raw. But (b) reuses an existing vocabulary instead of adding
one, and if you prefer it the reserved memory form still covers our case,
so the in-tree image could go entirely.

I will follow whichever you think is right; I would just rather not
respin the binding twice.

> What does /options/oem-logo look like? Why can't that be used?

Two reasons, and the second is the real one.

It is fixed at 64x64 monochrome (IEEE 1275-1994), stored in NVRAM. As a
precedent for "firmware may carry a logo" it is exactly right, which is
why the binding cites it, but it cannot express a product logo on a
modern panel.

More importantly, /options is the wrong node for something the kernel
reads. Its own schema in dt-schema says it is "for passing data into and
between firmware components" and that "it is ignored by operating
systems", while /chosen is firmware to OS. So the oem-logo precedent
argues for the idea and /chosen for the location, which is where Geert
pointed the node in v2.

> If you are going to put it in memory, why not just draw it into the
> simple-framebuffer?

I did not know about simplefb, and that is worth saying plainly: this
started as a patch against 4.19 for a product, simpledrm did not exist
then (5.14), and I never went looking for what the alternative would be
today. So thank you for the question.

I spent today testing it on the board rather than arguing about it. The
result is that it does not work here, and I could not make it work:

  - Added a simple-framebuffer node under /chosen pointing at U-Boot's
    framebuffer, with the region declared in reserved-memory. simpledrm
    binds cleanly at 0.62s and registers fb0. Nothing is visible.

  - The panel is dark for that entire window. The backlight is a
    pwm-backlight owned by the panel, and it is drm_panel_enable() that
    calls backlight_enable() (drm_panel.c), which only happens at the
    native driver's modeset, around 2.2s. So for as long as
    simple-framebuffer is the only driver, there is no light.

  - Forced the backlight on from probe with a local hack to pwm_bl.c, so
    the panel is lit from about 1s. The image is still not there.

  - Disabled the LCDC target module in the device tree entirely and booted
    with clk_ignore_unused, so that nothing in Linux touches the
    controller and it keeps whatever U-Boot left. Still nothing.

  - Repeated all of it with simplefb instead of simpledrm. Same result.

  - Read back the framebuffer memory through fb0 after boot: all zeros.

So the pixels are gone by the time Linux can show them, and I have not
found what clears them. I can say what it is not: not the choice of
driver, not the modeset, and not the backlight. Somewhere between U-Boot
jumping to the kernel and simpledrm probing, this platform stops
displaying that memory.

One smaller thing I noticed on the way: tilcdc came up as card1 and
simpledrm stayed on card0, with no conflicting-framebuffer removal
between them. Two DRM devices with the real one second is not a state I
would want to ship either.

There is also a case against this that does not depend on our hardware at
all. U-Boot's Falcon mode boots the kernel straight from SPL, skipping
U-Boot proper, and display initialisation normally lives in U-Boot proper
rather than in SPL. On a Falcon boot there is therefore no firmware splash
to hand over and nothing for a simple-framebuffer node to point at. That is
not an obscure corner either: Falcon mode exists to shorten boot time,
which is the same reason one cares about how early the logo appears in the
first place. A logo the kernel can draw itself works the same way in both
cases.

I am not claiming the experimental result above generalises. It may well be
specific to AM335x, or to how our U-Boot hands over. But on the hardware
this series exists for, a firmware-drawn splash does not survive into the
kernel, and the logo has to be drawn again once the native driver owns the
display. That is the gap the series fills, and the reserved memory region
is what gives the kernel the pixels to do it with.

Max
