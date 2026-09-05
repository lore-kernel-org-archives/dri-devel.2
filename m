Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85BCC79F89
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 03:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F9810E10A;
	Sat,  5 Sep 2026 03:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aZQNKh+r";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF7510E10A
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 03:17:00 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-495590dde14so23875155e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 20:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788578219; x=1789183019; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8CCZA4VoDQ6PBSjxOO7MB9iXLnCy8XMS9eXQBMC5ARg=;
 b=aZQNKh+r92O2cJ2Z/5W8PsJxgtz7QbRIOBMUAboOtqBbmgIiVUvpzY9LXmKT1evq/g
 beibBmGN6psDVbU2l8jFepmt1/ee7wBq9Vguo8R+hr51oCcV6jDNpXXuJJWgzRsbbRYl
 4BSHiKyc8/Pu01hLam5dA+novlKbs854JBBc/YD+RKwHf2OqLSxOIAFehRhAH+wg7zE6
 lhI3En7tcqoPqrcKRDh/LFe9elSZz3lHfNyNzH4uqXrLSlcX6nE8yuKUG9E1tLIt8rAm
 MG8Eygo4UVeJ/DS9Yl9bW0O7mPxSEJP39RhioLQXtIPvdSaOhTt2/LbGqqNBamRhUn+V
 gRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788578219; x=1789183019;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8CCZA4VoDQ6PBSjxOO7MB9iXLnCy8XMS9eXQBMC5ARg=;
 b=pUlm/4wVSznMIjn6uimmgmhPSg9EIMWmsy9Jvi6k7mpjtASuJDKq7pZPwTcyPjBhuP
 RQRhjmtS1m469Zhxw8/uaM/0Y8gaayXMqGvjPkzeXoie6Q9k0xtpWRKRPeRzfbY6vFq6
 VKvy8aANpLpSTwbA7g3DyZKCPCSvdeepbpjk+8pphdDqL95DeWakzDXuCWCXVHZPaZc3
 zXtnRu/Zflj63PHWeeZR3RcVAU6h50vuPNDnVAbOz+1IN/g6m+pwSOyfyanCe/7Zn/f8
 gkBSUxTki9FuD6PF9tbxoz5a65BvephMh3l/vm59rbMhfQ/riqPW5yXCFgDMozeYEwSr
 /7jQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP9ttSH4Coi2tNTOHNiMZ/EJKwLDtXuJhUJec4QZwwUO12vDZ5/aQokX+2Lvw6PzR7GaHm9fvROYU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kHTKGVoHLPlTIG+VvYHLSxBAULsiRWKjxqLMrRlE+oc4vBJcHw
 jRRRdnM/qrGdE3yGLAqy40E/xEe/nvIFxHt6dDAMdKmElaAJqXuXRrqD
X-Gm-Gg: AYBFou3t3GNVXzwvsA5BxUQKWeJkcUcN8YvFn+7DJpyknEj8YFjUZdkAsuYD/CsoTFO
 SwnMroU/sKdy0EYIqwU0DB7o4yaqxX8A8DPaS2jXOfY486puBDOvH/GoMcSUHeyv0gA3pTjSazy
 f2uLeEX9QND29WHnNzKtO2nKqMa3hJfFcyMPK2lRYL2ppodBQbXDFPLYSG/dVZoy1Z2HcakAtEO
 0IHoDjAmffAKdXLP+jat8lI4UZDf1gOH7ki+ZDy+pMV7MZqVyYMu3bXFgWWI9JHhvrBdVc3WFU8
 0dZ+pdlrXts0+6IEfF3kg1TJiCRkU6ls60UzAmyrctWIxVwrblYPB8kv1LOPOqbkVhIJFgqu2kC
 h1mN3GEsaofaCs9C/hF8OGcUEZ6eenVp4tVq7CNhxPn1XN8hAlubSxCNlgVk5lUqMaLnkI//I9Z
 YSsmTAwjrl2g7loFTuhypE+JIW7H1L5hVzJ4TGAVr9EJQL957szhg/zZYlcBBWofymHJsWtdC9q
 UCS3yILh5yFQ80R8wIdMHmBlx8QEhsJeKBF7vQh5kJnqemlhyFPJCgQWzWjZtj2QdkZa78OXAAm
 dYiNCK57e84HQjji7AEeLIh7KYTP5TCsyeVdUyubrRsGjf/nal6yv4fugYVVBySDQLIzj6H82Uq
 ua7kItFpGv0VYXABwgfhNUEXHIJVld7naBkPMdKptI8RI5jmjataCDA==
X-Received: by 2002:a05:600c:1d01:b0:499:cd34:f7c with SMTP id
 5b1f17b1804b1-49cf81e6f87mr157093075e9.5.1788578218915; 
 Fri, 04 Sep 2026 20:16:58 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d03543064sm25312595e9.13.2026.09.04.20.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 20:16:58 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Barzin Lotfabadi <barzin221@gmail.com>
Cc: Ryan Walklin <ryan@testtoast.com>, dri-devel@lists.freedesktop.org,
 linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: allwinner: h616: add HDMI device tree
 nodes
Date: Sat, 05 Sep 2026 05:16:55 +0200
Message-ID: <uGlvDrXdQ7mTWJ790WN0hw@gmail.com>
In-Reply-To: <20260904213329.3910099-1-barzin221@gmail.com>
References: <20260904213329.3910099-1-barzin221@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

Dne petek, 4. september 2026 ob 23:33:27 Srednjeevropski poletni =C4=8Das j=
e Barzin Lotfabadi napisal(a):
> Hi all,
>=20
> These two patches add the device tree nodes needed for HDMI output on the
> Allwinner H616 family.  Tested on an Orange Pi Zero 3 (H618, 4GB), which
> drives a 1920x1080@60Hz desktop with these applied.
>=20
> Mainline already has DE33 mixer support in the sun4i driver, but there are
> no display nodes at all in sun50i-h616.dtsi, so nothing probes.  Ryan
> Walklin's "arm64: dts: allwinner: h616: add LCD timing controller and
> display engine support" series adds the display engine, bus, mixer and TC=
ON
> nodes, but states that HDMI output is not provided.  These patches are the
> missing HDMI half.
>=20
> Every register address, clock index and reset line was read out of the
> vendor device tree shipped with the board and translated to the mainline
> dt-bindings macros; the clock and reset numbering was verified identical
> between the vendor and mainline CCU headers before substitution.
>=20
> Two things I would appreciate guidance on:
>=20
> 1. Patch 1 currently also adds the display engine, bus, mixer and TCON
>    nodes, because Ryan's series has not landed and the HDMI nodes need
>    something to attach to.  If his series is merged first, I am happy to
>    respin this as an HDMI-only delta on top of it.  That is probably the
>    right shape; I did not want to post a series that applies to nothing in
>    the meantime.
>=20
> 2. These nodes alone are not sufficient for a picture.  Two driver changes
>    are also needed: an H616 variant in sun8i_hdmi_phy.c (only
>    a83t/h3/r40/a64/h6 exist today), and setting the TCON pad select bit in
>    sun4i_tcon.c.  Both exist in the Armbian sunxi-6.12 tree, authored by
>    The-going.  I have deliberately not included them here, because I cann=
ot
>    provide a Signed-off-by on another developer's work.  If someone in a
>    position to carry those forward would like to, I am happy to help test.
>    Without them these nodes probe but produce no output.
>=20
> checkpatch is clean apart from one 103-column warning on a remote-endpoint
> line in patch 1; the identical construct at the same width already exists=
 in
> sun50i-h6.dtsi:183, so I left it matching the surrounding convention.
>=20
> One implementation note worth recording, since it cost a boot cycle: the
> DE33 mixer's three register regions must be named "layers", "top" and
> "display".  The driver fetches the latter two by name, so a wrong name he=
re
> surfaces as "invalid resource (null)" and a -EINVAL bind failure several
> layers away from the cause.
>=20
> Result on the board, with the two driver patches also applied:
>=20
>   sun4i-drm display-engine: bound 1100000.mixer (ops sun8i_mixer_ops)
>   sun4i-drm display-engine: bound 6510000.tcon-top (ops sun8i_tcon_top_op=
s)
>   sun4i-drm display-engine: bound 6515000.lcd-controller (ops sun4i_tcon_=
ops)
>   sun8i-dw-hdmi 6000000.hdmi: Detected HDMI TX controller v2.12a with HDCP
>   sun4i-drm display-engine: bound 6000000.hdmi (ops sun8i_dw_hdmi_ops)
>   [drm] Initialized sun4i-drm 1.0.0 for display-engine on minor 0
>=20
> with the connector reading "connected", EDID read correctly from the sink,
> and 1920x1080 among the reported modes.
>=20
> Full boot logs, the decompiled vendor device tree the nodes were derived
> from, and a photo of the running desktop are at:
>=20
>   https://github.com/BarzinL/h616-hdmi-mainline
>=20
> Based on mainline a500db7819c5.

NACK.

This uses old, improper description of HW. That's why it was never
merged. Two mixers would never work with it. Also, TCON_TOP
isn't directly compatible with H6.

Here is newer work:
https://lore.kernel.org/linux-sunxi/20260509190015.79086-1-jernej.skrabec@s=
iol.net/

Best regards,
Jernej

>=20
> Barzin Lotfabadi (2):
>   arm64: dts: allwinner: h616: add display engine and HDMI nodes
>   arm64: dts: allwinner: orangepi-zero3: enable HDMI output
>=20
>  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi     | 191 +++++++++++++++=
++++++
>  .../dts/allwinner/sun50i-h618-orangepi-zero3.dts   |  25 +++
>  2 files changed, 216 insertions(+)
>=20
>=20




