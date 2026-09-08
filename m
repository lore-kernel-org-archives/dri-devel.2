Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFA0C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E04410EBDB;
	Tue,  8 Sep 2026 13:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GME5OEfm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1C6110EBDB
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:04:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD5E2601DB;
 Tue,  8 Sep 2026 13:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4F21F00A3A;
 Tue,  8 Sep 2026 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788872686;
 bh=0c6VVgpgr8QRvVK0L3AA+Ya2VGnRG3C/SeaIoCEOEIw=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=GME5OEfmBM3W0vV/lVcz+5iVnZEC5ckUSFlvI8uKcFRfnIi/d7yvCw33IdTcWPrOG
 +ODsMzky9dGz8w1QvGQ90Rjxbc6478UAnrg7p0yiOWzjOSF7WU7wxuE4NUxRanh3EY
 J5K091ChOVt841MVIvPiboxtyhgRplOqOOGj15aUxNb1vbrf5IZl/UbnwkrW5qD87Q
 Ov23nnRh40+Y3J/7ubOvVyg/lyu1P7SFBrsi4Q6EDRPLYoKu2jm4Xv30Yk+DFrdsJn
 XkOmt3S3WSQ7t2wPuUTZli7yc041+BiDeff9S74+zS6fP2gdhUrypH5nX4llhwjzd3
 3Dk7FHiMKatdw==
Message-ID: <0ec40db90bd0d2ece46b185deb3c8eca@kernel.org>
Date: Tue, 08 Sep 2026 13:04:43 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 45/74] drm/vc4: hdmi: Propagate -EDEADLK to the top
 level
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-45-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-45-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:09 +0300, Cristian Ciocaltea wrote:
> drm_connector_helper_funcs.detect_ctx() is expected to propagate
> -EDEADLK so that context owners, e.g. drm_helper_probe_detect_ctx(), can
> perform the required backoff and retry.
> 
> vc4_hdmi_handle_hotplug() instead runs its own retry loop and calls
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
