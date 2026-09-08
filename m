Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BACA1C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB13710EBDC;
	Tue,  8 Sep 2026 13:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BaRrzSMA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C099E10EBDC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:05:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 09CFB601F6;
 Tue,  8 Sep 2026 13:05:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038CC1F00A3A;
 Tue,  8 Sep 2026 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788872717;
 bh=aGTtaq+6H/MylUW1RWg3sjvRgbOJMdbhBr1FvgmlBNM=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=BaRrzSMAn8EfjT4wRWhWrmfDz3x8XeYQnqZBLLwgqh1oJ1Oc4pdvbE5XJoSjByxhY
 2wvb+OFrl2a3PjTSpfVjroAfOBcmdBcjr2C/uLiDV6NXhYvHfwc3Ogfeu6T8HxwhVE
 bgQkr067DWEIH4gYyjiZT6x5mozingz+yPwOfUlDIdVfasy+7VJBL9+qedyEzH2x2N
 yhABRXMH7nDhhHoGKyOKtybXt6WT1qOJjcX95PUXYlIPpQ8ueJo3Brozfj2WA3T6E0
 DylCu8/1RdTxJE85P/L4lVXfXnEJixtF20gT6+i25aXRiULJt0200kBuvjyVG0F3lK
 TSpNFZUQvLO6w==
Message-ID: <0d05dad937047c8c8e18df7d5a92f89f@kernel.org>
Date: Tue, 08 Sep 2026 13:05:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 47/74] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-47-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-47-bc12954a0688@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, "Algea
 Cao" <algea.cao@rock-chips.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Andy
 Yan" <andy.yan@rock-chips.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Daniel
 Stone" <daniels@collabora.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 "Helge Deller" <deller@gmx.de>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu Ying" <victor.liu@nxp.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Phong LE" <ple@baylibre.com>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>,
 "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Robert
 Foss" <rfoss@kernel.org>, "Samuel Holland" <samuel@sholland.org>, "Sandy
 Huang" <hjc@rock-chips.com>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
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

On Tue, 1 Sep 2026 21:51:11 +0300, Cristian Ciocaltea wrote:
> Replace driver local scrambling logic with the newly introduced common
> HDMI 2.0 scrambling support:
> 
> - Advertise source-side scrambling capability by setting supported HDMI
>   version based on the variant's max_pixel_clock.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
