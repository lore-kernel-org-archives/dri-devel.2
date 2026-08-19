Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C63C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9044A10E0A9;
	Wed, 19 Aug 2026 12:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O6INs1Qf";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B44010E0A9
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:37:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B200F402B7;
 Wed, 19 Aug 2026 12:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEB81F000E9;
 Wed, 19 Aug 2026 12:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787143071;
 bh=Y0tJoZ7ZFXTl/tMoaD1TEZl2H8Uq6kgMx3rbwieyM5U=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=O6INs1QfspOL+mcZFjses1Bw6NTnyn30eBjytQOVUnC3lv8KvPFc1f5RgXJX5fhd6
 U5dTPQUIBGTJshfMXxDQbhx7sdJ0mV3ou6FFBjinfJzZ6gorg3XP9211PcPoXp8xik
 reYg8mlQEm8tq44N5if+hlCEEDPmICIeKuyk8wNPQFJ/ibf4oAdbxke1zVFhJTn00q
 bC6A9odn2W9OSbmdN0j3Yp2kGQTjp+9LNyCLqby2AQc6X2KYEIH7OJ3+adOQzlljUG
 wF2Pi65c8BLpqb7Ty+ibH4vBL6w7pH9QEN65JWzFm/n5dAJPufr/8hjR30X3Pm/y7d
 oQhTczfskp9bA==
Message-ID: <f2765a490c501ccc6e410b94b5497ec8@kernel.org>
Date: Wed, 19 Aug 2026 12:37:49 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v10 10/69] drm/display: hdmi: Add HDMI 2.0 scrambling
 management helpers
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-10-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-10-294364b2cf15@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, "Algea
 Cao" <algea.cao@rock-chips.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Andy
 Yan" <andy.yan@rock-chips.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Daniel
 Stone" <daniels@collabora.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu
 Ying" <victor.liu@nxp.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maud Spierings" <maud_spierings@hotmail.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Phong LE" <ple@baylibre.com>,
 "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>,
 "Robert Foss" <rfoss@kernel.org>, "Samuel
 Holland" <samuel@sholland.org>, "Sandy Huang" <hjc@rock-chips.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: 7bit
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

On Fri, 31 Jul 2026 19:19:17 +0300, Cristian Ciocaltea wrote:
> Add helpers to manage the full lifecycle of HDMI 2.0 SCDC scrambling on
> both source and sink sides:
> 
> - drm_hdmi_mode_needs_scrambling(): checks whether a mode, bits per
>   component and output format combination requires scrambling, which is
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
