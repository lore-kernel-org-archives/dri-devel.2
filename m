Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A6FFC72C4
	for <dri-devel@archiver.kernel.org>; Sun, 22 Mar 2026 14:13:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D3D510E229;
	Sun, 22 Mar 2026 14:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m1JSvO3v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1A8010E229
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 14:13:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F234441FD
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 14:13:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A12C4AF0B
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774188806;
 bh=6WyenFkskQRviNgIdSNi6d7LvQNFj/WN1yDFKmE61aM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=m1JSvO3vBoAW11h+1jUFpD4M3o87pi5WVIS30EG+IpjrhSbVVm0n+a1tBuAfjEvBt
 DUqzvAtEE8KJ6CZfJtmKqQq9BVDuNmVeWZsoYGhGiqY+t+Q6RwWFQc5ZQdL1p/KZIY
 UFQwKK08jzzYTvqEXZ4Ac8G4DE5xsSYsUXc8IfhWTBw9DfA2DD2C6LLzRNU24IbyFb
 lrOIf3a8BJJBT9sBoXhMHNUMb8I5hhEpcoV0xfuwNuKiNcSCrIcGPuQKtmayUZ9HXR
 hFKtrSq+WjK11fCbeC076eyEPEXZo0kTu3ZozNAe6J8tQQi2tgc/U6j9xLH40yQ+qZ
 AsEOEj7QkGiCQ==
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12a695044a4so2646195c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 07:13:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCW9BPeIz/VbW95BOkJgwLYvJImbfOVuOJZoVEoejdJ/rX1qchfyzm3+PULR5AO2zlFtn25EA4iXGzM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxMLq40gjOHUQhp8uMOsGHIFa+u03owpzBA2dydiJIgcQ/+P+Kt
 mlmw7cSbn9lLUuUqWgLr02OP2+IW/q/e6IE0YKWu34MEyt+MAR4jXnqNfhaHRver9ZR9OIjy98E
 d5pO0r3T1sAPBBNk4VgevaVb1OcgM1Q==
X-Received: by 2002:a05:7022:629f:b0:11b:9386:7ecd with SMTP id
 a92af1059eb24-12a726e3eadmr3908663c88.42.1774188804941; Sun, 22 Mar 2026
 07:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260107-drm-bridge-alloc-getput-drm_of_find_bridge-3-v1-0-ef48a517828e@bootlin.com>
 <20260107-drm-bridge-alloc-getput-drm_of_find_bridge-3-v1-4-ef48a517828e@bootlin.com>
In-Reply-To: <20260107-drm-bridge-alloc-getput-drm_of_find_bridge-3-v1-4-ef48a517828e@bootlin.com>
From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date: Sun, 22 Mar 2026 14:13:12 +0000
X-Gmail-Original-Message-ID: <CAAOTY_9PH4yV-mDFZ+mkNRT7R9qoZOtjQhhqmyWjx1LWSu=giw@mail.gmail.com>
X-Gm-Features: AaiRm5108rX0H_CDRkg1jedFrdyn5bPiHycKlLMUICMJdSqU48gN54_ILYySwo8
Message-ID: <CAAOTY_9PH4yV-mDFZ+mkNRT7R9qoZOtjQhhqmyWjx1LWSu=giw@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/mediatek: mtk_hdmi*: convert to
 of_drm_find_and_get_bridge()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
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

Luca Ceresoli <luca.ceresoli@bootlin.com> =E6=96=BC 2026=E5=B9=B41=E6=9C=88=
7=E6=97=A5=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:22=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> of_drm_find_bridge() is deprecated. Move to its replacement
> of_drm_find_and_get_bridge() which gets a bridge reference, and ensure it
> is put when done by using the drm_bridge::next_bridge pointer.

Acked-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> 2.52.0
>
