Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B136CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 11:03:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97EC110F2F1;
	Wed, 30 Sep 2026 11:03:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="pr6gP+dM";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EABCE10F2F1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:03:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 3F0B91A107A;
 Wed, 30 Sep 2026 11:03:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 09A8C60749;
 Wed, 30 Sep 2026 11:03:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D8F3810328F7B; 
 Wed, 30 Sep 2026 13:03:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790766213; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=ijJfwiKLlTSy9rxP4IMNmmV3iD9aU2IeJcZz/YO1yr0=;
 b=pr6gP+dMr69oYimKPOIdbp5KMj8d5ltUTNrztyVmewFeK+Il/fJwZkQVcY1nvsumKPbiFp
 H+ixPwd120YzUC2kNP+ksnghILPnhKRL92J8mbAFq2TrnUc3B16wIb7KsEtjPtsVQxw8Q9
 4/upitHqXbTfcvdntbX4OARxD27oUI9GIPuzJtCGPaoTj+zXGWoJdplv5vS9pAsh6yNJ1z
 KE3KLIVbSwaW4bGLL1nl7D/0JciPTA0k/hGlQf6fe88M1BXOItrDU0obTgAzs/Ba+Ixhz6
 CL4CHf+Nsc6ONlTiDttt0XVoOG9hX6Q0d3ROfYoslREjggy+K5FSmP7xNjL8nA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Sashiko <sashiko-bot@kernel.org>, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
Subject: Re: (subset) [PATCH v11 00/74] Add HDMI 2.0 support to DW HDMI QP TX
Message-Id: <179076619955.542608.8005316063997157342.b4-ty@b4>
Date: Wed, 30 Sep 2026 13:03:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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


On Tue, 01 Sep 2026 21:50:24 +0300, Cristian Ciocaltea wrote:
> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) on the Synopsys DW HDMI QP
> TX controller, as found in Rockchip RK3576 & RK3588 SoCs, by adding SCDC
> management for high TMDS clock ratio and scrambling.  Since SCDC state
> is lost on sink disconnects, the bridge driver needs to trigger a CRTC
> reset during connector detection.
> 
> To support this at the DRM infrastructure level, the series first
> introduces the HDMI version enum, then prepares for changing the
> signature of drmm_connector_hdmi_init(), i.e. dropping the vendor,
> product, supported_formats and max_bpc arguments, which are being moved
> into struct drm_connector_hdmi_funcs, by temporarily renaming the helper
> to drmm_connector_hdmi_ini2().  This lets the new signature be
> introduced under the original name while callers are converted
> incrementally.  Note the transitional name matches the original's length
> so continuation-line arguments stay aligned to the opening parenthesis,
> keeping the diff to the identifier itself and avoiding re-alignment
> churn.
> 
> [...]

Applied, thanks!

[12/74] drm/bridge: Fix unlocked list_del in drm_bridge_add()
        commit: b62e3db8cdc1680e1c3390591e872f485148541a
[14/74] drm/bridge: Fix unlocked list access in drm_bridge_attach()
        commit: 57889076afd1be890150c32ffde3b691fe5707c8

Best regards,
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


