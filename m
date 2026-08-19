Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2506FC5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 10:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8823910E52C;
	Wed, 19 Aug 2026 10:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="rEWYxZDQ";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 298FF10EDA7
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 10:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=ofn2ZZ6XPlR/lPmYUjXtJeQNkxi/butXlRsGauSrOlc=; b=rEWYxZDQRF3HvBIMiv+yoXDvJo
 cQALU3IXk3TYG8G+ih0Tt76d5TTQOvmtu2WqEuJ8glTMKwAKs9Yn1Q0rGE1efzNrn9S3pPeIKvDx9
 eygs1DIwW4lqO0geAU4dtPljbEXOvpXk03UPEjBKlqBkvG2SeE1xlTUjwrVKI9vhR4DUtajlaT3gd
 CYw//BQiWamdbW56G4+EqzgIRnDFvUZHcsItJsgEql0DvDm8rEA06c8rdAnAoC6LM+rsT+IBfTWop
 6WPIDz+kU3uvly6U8OWDfRqaZkkIwCkyaPj/OpfyMDVh9QWYl53PFI+zFHPeEeM5gFaI8Fos1pXrg
 W+ZxJJLw==;
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Algea Cao <algea.cao@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Liu Ying <victor.liu@nxp.com>, Phong LE <ple@baylibre.com>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v10 54/69] drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4
 capabilities
Date: Wed, 19 Aug 2026 12:36:29 +0200
Message-ID: <7956767.Wku2Vz74k6@diego>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-54-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-54-294364b2cf15@collabora.com>
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

Am Freitag, 31. Juli 2026, 18:20:01 Mitteleurop=C3=A4ische Sommerzeit schri=
eb Cristian Ciocaltea:
> Bridges using DRM_BRIDGE_OP_HDMI are now expected to also provide a
> supported HDMI version.  This is not yet enforced, but will become
> mandatory once the migration to the new caps-based HDMI connector
> initialization API is completed.
>=20
> The RK3066 HDMI TX supports HDMI 1.4a, as described in commit
> f84d3d37b7fb ("drm: rockchip: introduce rk3066 hdmi").  However, the
> driver does not currently enforce a maximum TMDS character rate, it only
> filters non-CEA modes and excludes VIC 1 (640x480) via the .mode_valid
> callback.
>=20
> Advertise HDMI 1.4 support for now so that modes exceeding the 340 MHz
> TMDS limit are rejected by the core.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


