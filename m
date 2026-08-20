Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F43C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:16:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BD3710EFA5;
	Thu, 20 Aug 2026 10:16:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jaVpEuwT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C532010EFA5
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 10:16:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9658760A5C;
 Thu, 20 Aug 2026 10:16:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1E961F000E9;
 Thu, 20 Aug 2026 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787220979;
 bh=k/x/Ldk7pJn5hAaYG+4LmXlk3NMFui0TNJgVftohRSo=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=jaVpEuwTCkHducIWFaPzemcmRsz9Y6z6HW+eT1ezml7OORLHvBMN8whKTNwRoBhk2
 0RdQ8QeLhTDxrUtl4zHYcgxcPTc8KaLbUX7YfQcul+paiJYAu5+8CJEcBGeVB4b6er
 KQ7r0uJD07gjy6oGzxS/yR28+ANd2XRT2UVpckttsrfbEHmlsXsZzA9Tw/3bigaAza
 VXC5U3q7n/3Ve0HazQi9/N44qlNU43jl/eZSUY/crkISqW2lwCbWYuEagKZ2UOVrOY
 oKMZ1U3PRJsy5/j/ozutNsMOxgR7BLHdvjVM80n9ZLpqj0sDtcjaAY+mcUgmT0CSFV
 NQeYPvC0pUK/g==
Message-ID: <9ad943a20de08d78ff7c2133fa4a3e05@kernel.org>
Date: Thu, 20 Aug 2026 10:16:17 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v10 46/69] drm/vc4: hdmi: Defer pixel clock validation
 to HDMI helpers
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-46-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-46-294364b2cf15@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, "Algea
 Cao" <algea.cao@rock-chips.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Andy
 Yan" <andy.yan@rock-chips.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Daniel
 Stone" <daniels@collabora.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu Ying" <victor.liu@nxp.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
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

On Fri, 31 Jul 2026 19:19:53 +0300, Cristian Ciocaltea wrote:
> drm_atomic_helper_connector_hdmi_check() rejects modes whose computed
> TMDS character rate exceeds the connector limit before invoking the
> driver's .tmds_char_rate_valid() hook.
> 
> BCM2835 is capped at 162 MHz, slightly below the 165 MHz limit of HDMI
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
