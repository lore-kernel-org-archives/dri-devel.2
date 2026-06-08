Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2577ECD8CA4
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 19:57:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A5E10F95B;
	Mon,  8 Jun 2026 19:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d0Iar3lD";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E6310F95B
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 19:57:05 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490a78b0c8fso3623585e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 12:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780948624; x=1781553424; darn=lists.freedesktop.org;
 h=mime-version:content-transfer-encoding:date:references:in-reply-to
 :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=x6JwvLsWsLYWBCdua6MGpYaGoK7ZZnWaJbNlGrTrnXA=;
 b=d0Iar3lDXot8Tvg8tb0IM8Cidc/QtppAxa1WVIDCOtyLR7OruPpLtuYC7+ap+Wus2c
 1q7/mrtdya1n8iT4fuOXUMOpn9XQvrn+1OW2ClgxaFQ2vSoERi4noxJjeoMon3diuJLY
 kCp+z7FtfWbyuGso5vegcJVVSFb0fvRB0Ll5Gna+1g9LSLw7v7YUJ+gO0GX9bl6GG3VC
 2ifqjuXpZMPQ9QyfqUcK6mXReCdANmIamzj1gFG4ByjlO6QLXh97bq8G3Q8tybCiqu68
 VSJoSl1Mod0Ii94HdDUAuZMXJJzTl//0ihtQMNgQO8o0OqdtW/KcbWNbNWGabeqXN9az
 1xYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780948624; x=1781553424;
 h=mime-version:content-transfer-encoding:date:references:in-reply-to
 :subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x6JwvLsWsLYWBCdua6MGpYaGoK7ZZnWaJbNlGrTrnXA=;
 b=cMsILWeCOLYKYgOgvXYJaiyJiZQbZJxEc5Bg+ujYbi7/oHjDVpupIZ23haVgm4fhkn
 fUH3NRiJaSpfnjlIbm9SadFiU2ClD4/AYoWJT2dMfY3Z6HnSdz/I4h7TkC61JFA2IDau
 54sgTuj1De4+UWkfFosE+t55NvTymTF8BopDGIYwFRPipp6XPBAYIFJVPLQQ4n/E3/HQ
 Ab05BpIgk+nhTERK63c7IL++eXZ5UaW/HY0rVcEtgkGJnhtOxBO+hXiNuHFhSvSoUkhb
 BZaQi0qOMATmuhXmdfC2jGMq6xvZSHBchwdMoyseOjeYuaYC4QpLcFdoXiiskeuwOhNr
 wSAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LjWwhfJK/8gdjBQuOnGSantLPRKBw7WXcDESUbRgPJRp6GQcl7khrN4nFLyjhOAwloMxfPno74O0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6Ap87o7bb5H7pIFWGx2mvJcttNszXTEFt6RrRwSjCt9BO3N3U
 H7DNeCFrKXt2s7r2QX/SxIG75Jk2KlqjhsZu8O9BedT8pd0V3ra3QONZ
X-Gm-Gg: Acq92OFeTsTE60T/mSpyAJeW7A0sY7jugivpXVL7b0XFBih/doQVGR6c9otGpRY2GuJ
 +75934ha7kwpZK27+adogTTI40URv7TgWNMuJ/A1+Qr6+ARmX23GrWwpUzqTlt3fhcwNeh8QEDJ
 FPh3pjMbBgCiX72pg5aSfIDsnMRobujFI9jYnrAU2+zKKvtxf3UWNpmAtpaAjnOO1KcmpMXZh5/
 V2mF8c6a4Frge3ZPaE5L4qn+N8u2SbZ7RUCSuOn6HC8JWbbfDeMAOh9D1vTx4ju3EYQRo5A4k1L
 d5f/B10JK6EoE7ypYLP30uddpcnzlVEubSezsoxqlk1n+D0Oz5KuHKvLwqwJI5FmDFExst+Qdrc
 JOcxkKAxcJh9oW5NN4io5SM3TMCoUFADPWYp+uwJa6qW6E/APLHFx3Kfb1QGxt6Lrjt4wQYsuYW
 gaPed0ch/EEcwRMserNfBfwx9sKjRMWCgMZV4aMqhvKbqYssnfw2RIRqNsvc/+mV6QjLrTv//G0
 OzEcCuEmo1ut+u56A8//R0=
X-Received: by 2002:a05:600c:3551:b0:490:af9d:8b6f with SMTP id
 5b1f17b1804b1-490c2617419mr116664765e9.7.1780948623972; 
 Mon, 08 Jun 2026 12:57:03 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918fcsm479793855e9.3.2026.06.08.12.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 12:57:03 -0700 (PDT)
Message-ID: <6a271e8f.0c2aff9d.374a2c.9275@mx.google.com>
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: Fab Stz <fabstz-it@yahoo.fr>
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/3] drm/nouveau: stability fixes for NVAC (MCP79/MCP7A)
In-Reply-To: <2c6340fe-2d3f-4d38-ae6c-d89adfea98b6@yahoo.fr>
References: <20260409172126.115441-1-marek@czernohous.de>
 <2c6340fe-2d3f-4d38-ae6c-d89adfea98b6@yahoo.fr>
Date: Mon, 08 Jun 2026 21:57:02 +0200
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
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

Hi Fab,

Thanks for reaching out.

On the crash you linked (gitlab #443): I had a careful look and I don't
think this series will fix that one. The oops is in nouveau_fence_sync(),
on the TTM buffer-eviction / nouveau_bo_move() path, hit while a renderer
process allocates a GEM buffer and the IGP runs out of instance memory
(the "imem: OOM ... -28" line right before it). My patches are all
elsewhere:

  1/3 swaps the MSI re-arm method (interrupt delivery / FIFO stability).
  2/3 adds a NULL check in nv50_sor_atomic_disable() (display-encoder
      teardown). That is also a NULL deref, but in the modeset path, not
      the fence/BO path, so it is a different bug.
  3/3 retries a DisplayPort link check on an HPD IRQ.

None of them touch nouveau_fence.c or nouveau_bo.c, so they won't help
that specific crash, and I didn't want to give you false hope. For #443
itself, the fence/eviction code was reworked quite a bit after 6.12
(around 6.15/6.16), so the most useful next step is probably to check
whether a current kernel (6.15+ or 6.18) still reproduces it, and if so
attach a fresh oops to the gitlab issue. That part of the driver is
outside what I work on, so the maintainers there are better placed than I
am to chase it.

Where the series might actually help you is if you also see any of these,
which is exactly what it targets:

  - sporadic FIFO errors / hangs that you work around with NvMSI=0
    (nouveau.config=NvMSI=0)                  -> patch 1/3
  - a kernel oops in nv50_sor_atomic_disable() when ending a Wayland
    session or switching VTs                  -> patch 2/3
  - DisplayPort flicker or a brief blackout after DPMS / monitor wake
                                              -> patch 3/3

It was developed on 6.18 but does not depend on anything 6.18-only, so it
is easy to try on 6.12:

  - Patches 2/3 and 3/3 apply to 6.12 as-is.
  - Patch 1/3 needs a one-line manual edit, because the g94_pci_func
    struct was reorganised between 6.12 and 6.18. The change is identical:
    in drivers/gpu/drm/nouveau/nvkm/subdev/pci/g94.c set
        .msi_rearm = nv46_pci_msi_rearm,
    instead of nv40_pci_msi_rearm. nv46_pci_msi_rearm already exists in
    6.12, so that single line is the whole change.

If you give them a try and they help with the MSI or display symptoms, I
would be glad to hear back. A Tested-by on the list would also genuinely
help the case for getting these merged.

Regards,
Marek

(Disclosure: drafted with help from an AI assistant, Claude; conclusions
are mine and verified.)
