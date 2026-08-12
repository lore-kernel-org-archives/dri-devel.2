Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A75C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 22:32:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1D510E119;
	Tue, 11 Aug 2026 22:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fc7RlCn/";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 308F610E119
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 22:32:11 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a36982a875so221058a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 15:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786487529; cv=none;
 d=google.com; s=arc-20260327;
 b=kckqUYLUkgIHVqYar6ON9Ftwa8D09AUgECKYOQdKgI0DyeCvqefFsvQWW3JyjQYU8Y
 GIyxPPfOs8Z4T6ouZQ5IzRD+2K7PCK/2rT07ofPAPq043RSk78sSigS2yshfv9NbFlJK
 pG5g9DgyH4NDfTMl5kMiBX0WIRf1g5Jlx/ebrSO+knre/cOmZe6NvD7SZEsYLFMhw1KW
 BNKdFy9klRmHYKlnxhDvzlZE0spIKuzI5GUkFrGkx8lejTCOSH/Q72qluMFo2Nkkyfsx
 lQ58Nb0Qkx5F18GAUPtBafHmfH9O93emLRER7Jdn8KSrG44HtP7xAvUwKyjs0PBE0i37
 CFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NDhag9T7TgtaVJbOY8rWrSF9da5OrhIz5kdObvPrx0c=;
 fh=lp0DbWTeAC4fk0mSF5ea5G6UXK/2ZnGYOmtZhs0fd1I=;
 b=sHrkK/Jqu4TvdLF4Q7rSKn+lnaNtH96/BAERoFbWXl86bDMJrO2/6j1GQahPsAUF9Z
 fblyPHf3CoBIN6gTB5IjWI1rnPoQF7/0U0IvvKhuUW9Dp/1QyRgdS0iTVYqzy6F5dFcd
 Qkij+AJQtEAZCimF9MAgQIZLgtEOAJscqf6DbybuEYw/4goIEwDgALaY+cjA6W32gDDM
 skDIuHyzSpuigjcYlq8+OBkB3IixeHrzSumHuvhjr+fheyO8ZMgt+EBpQqg7XM+jwGVo
 vyw1N3OwyvoPPRqCgVpFOFJbxo8fiKJl/ve8EFjeODnZOoQM70wcvgJPUNBalEpXPB92
 9TrA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786487529; x=1787092329; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NDhag9T7TgtaVJbOY8rWrSF9da5OrhIz5kdObvPrx0c=;
 b=fc7RlCn/aBcaZbKLIovP0SspHhtiucqv/8XeFkiFK1VKk4X31adf//Ycp0wLR1x+dN
 tx7NDhYciqPqUkfnepWjxZw+ItWpDPVtplLu9D8DFroVSIHHdktvvrUNdmy7raFER7Z4
 Vp58y8eReisCD/NVA0+2hG9nNfMYjxfG0wSAfDnCsWrSEN/o5weDe9w39A+mNtVJoZ78
 Ub4DAkVR3ha5SRqjqby+5Rn7+FXLfYnrOAyvMHltt70Wwiy/HXz2L9OatjnRlS8O5Rof
 0fn+UXVNGon92ZoFcpILQ3xQTTCaaBHpCOUiml2EL7qFGl2df246F1unK+QO+mZgGbKE
 zDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786487529; x=1787092329;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NDhag9T7TgtaVJbOY8rWrSF9da5OrhIz5kdObvPrx0c=;
 b=HF2KCZmFBPZ02KbW16wXvV+Lbwk8mXTCH+Yc7kkcEF4XVdZHbYThwG0FulXgl2qXUO
 Oey3TyZUlUzkIBv+hwY1l7pEtyNYFJd6Dh4N4HC6uVC6JR6M+vWdxOX4K3vyuIxKMKQ3
 PySW92LRm9bIt/U3pDNc/a1iRj2hufx+g8vtmKGqr/GlZ7zzbXoo7V3/MVz3P3bxxKyy
 eWjO8hp0Dy9sJEzQXcT90fvBropJMyf8zHQVq9Rbwszw84In2rFU550rOp4K07EXO0qP
 Q76Kh/LaC0cfxZ5jpL2X7CTAZ+K7MrrtSUi5EBxOJ8XPqrPBfMXjo3W6nghC2Iu6BXTY
 W9sw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIlJ4MjdTAdxJz5S04Jlrec+cWcaFEKVmBau8032BL2x0+jh/pKT4/tj5D1gXxssbw9YBf84uSx5Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6+L4p5PDi8cxOAwwrkrcnOrCniC2M3b9IAuPILKW/luM5GX/o
 cU5SeQKAzD5PARV9tCgLZJAAP+jCPMNKMzLnSj6gHJcDhEkh0YRwpAeZKpL36xemO0UEQmRkk1q
 pt65Gtew4KQtSZe7Y6YVfhytvA5XDv7c=
X-Gm-Gg: AR+sD11EdYsVajP1JF28JP73PcJEJ+gZNHUg6AkhwkYAx4Pp0UJNp/bZDM7zNp8LGzl
 W56V1geDkek6iLQALi36CoJQasEIAIUEPcQKQAFX/2tCgYDqQJ94li9tyM1YAPVdJR2k09/bZ9q
 6SvOv9FkmDla3TonEcd1IQBiShBirRF0GKojUD8bkHeRMJI7VESjjOkCnsNru7MYmMjSDuhoeQC
 p5S7iwWP0SYPBpRGCZrpTy2cd5l5GGaVY6ieud7Uv7Mk3GiuHwcQNkMJ9eVfpOPFxu9wXZJP/Uw
 J8zCizc/tp/lnDPkffAT4wYNE4h53Piwk8x0+AQ0CqDx
X-Received: by 2002:a05:6402:2792:b0:6a1:ffc4:9c0f with SMTP id
 4fb4d7f45d1cf-6a375f5c06fmr15680a12.19.1786487529251; Tue, 11 Aug 2026
 15:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros> <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
 <20260810-devout-pig-of-performance-595ccc@houat>
In-Reply-To: <20260810-devout-pig-of-performance-595ccc@houat>
From: =?UTF-8?Q?M=C3=A0xim_Pedraza_Padilla?= <maximpedraza@gmail.com>
Date: Wed, 12 Aug 2026 02:31:52 +0200
X-Gm-Features: AUfX_mz7nXWHSfkKAN1Ac7JJQdBN1iB9iQXcLpUm_kEW3oLMc-SNNbJ2H3j21U8
Message-ID: <CAEUXW=GuHypVE5Xre8AQBmkrcUbPQxh03Lq8os=kjcLeGahOgw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
To: Maxime Ripard <mripard@kernel.org>
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de
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

El lun, 10 ago 2026 a las 11:02, Maxime Ripard (<mripard@kernel.org>) escri=
bi=C3=B3:
> If the sole reason for this series is to keep having something on the
> display while the kernel boots until DRM catches up, then you probably
> want to check [drm state readout]

Thanks, I had missed it. I read it and then measured, having earlier
claimed in this thread that our hardware kept no state worth reading. That
was wrong.

Dumping the LCDC registers at the top of tilcdc's probe, before the driver
touches anything:

  RASTER_CTRL=3D00280081  FB=3D9df13cc0..9dfcf4bc

LCD_EN is set and the scanout address is exactly the framebuffer U-Boot
reported, still holding the image. So readout would have something real to
adopt here. tilcdc is not one of the drivers you implement, but that is
work rather than a disagreement.

One observation that may be worth your time. Pointing a simple-framebuffer
node at that same memory, same device tree, only the driver differing:

  simplefb   the image is still there afterwards
  simpledrm  the buffer reads back as all zeros

So where the CRTC is still scanning the bootloader's buffer, simpledrm
wipes the image it was meant to carry over. I have not chased down the call
that clears it.

What readout cannot cover is having no firmware splash to read. U-Boot's
Falcon mode boots the kernel from SPL and skips U-Boot proper, where
display init lives, so there is no image and no programmed CRTC to inherit
-- and Falcon mode exists to shorten boot time, which is the same reason
one cares about the logo appearing early.

So I do not think they are alternatives: readout preserves what firmware
put up, this series lets the kernel put something there when firmware did
not. On hardware with both, readout is the better answer for the handover
and I would rather not duplicate it.

Max
