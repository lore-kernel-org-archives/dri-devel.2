Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF9EC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BC910F31F;
	Thu, 13 Aug 2026 13:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TLLR93bR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C74F510F31F
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:28:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B4D4601DE;
 Thu, 13 Aug 2026 13:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9081F000E9;
 Thu, 13 Aug 2026 13:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786627696;
 bh=HFLGRf1OptuEnjBGG4ZtLeQrN6SrGXqYJaR5S/NF7lI=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=TLLR93bRjaY/MLZEpaYZ0/OQdva+N0w2HAG4QFzVLlxgq4MBj3w7aEIUPsDq0lPLD
 tiBX7x7GEuZDrqP4kvSh6Ycs4SCjtBqNK45xM/dMvRqVCok6WaTJaybpmqTpw/hv35
 t/6d479+w3DiLTFxMfSJEFVTe1U+G5UFXNNTt3AlrFnpkP+QCnN9fYL4NGoRxpdDFJ
 2u0IzblPbr9el0PcsFezPrChpy2bNiUfICSPHbDOuSgidIOidFa+jIaSaIHmr0ua2T
 GIuKYd+rXgXACi4jhG83yyOL/yn6mSAxzHABlzG7nidDoWftAHW1oqkJTj2hTlV9+B
 yT0v3tRBQy9Qw==
Message-ID: <13e95609da0a43f874381b248e8a7404@kernel.org>
Date: Thu, 13 Aug 2026 13:28:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v10 42/69] drm/vc4: hdmi: Switch to .force_ctx()
 connector helper
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-42-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-42-294364b2cf15@collabora.com>
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

On Fri, 31 Jul 2026 19:19:49 +0300, Cristian Ciocaltea wrote:
> Use drm_atomic_helper_connector_hdmi_force_ctx() as the .force_ctx()
> implementation, so that the acquire context created by the probe helper
> reaches the HDMI connector framework.
> 
> This is a prerequisite for converting the driver to the common HDMI 2.0
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
