Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E89CC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:17:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B78810EBA7;
	Tue,  8 Sep 2026 12:17:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WdCizk8G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E70C210EBA7
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:17:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED1E96020A;
 Tue,  8 Sep 2026 12:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24CB1F00A3D;
 Tue,  8 Sep 2026 12:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788869829;
 bh=2dKrCoMuS/VkRK9SgbcPzXa6yS0fI5ekjQCw4D7v3J0=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=WdCizk8GgeFL6S4xnqYLHl8qXbPSs6ZwCcTkn2P1iLWdnhwFMHYyvHvoLq7wQLe+X
 c2cWgJTqLM14kDyKBC50dblaDuMSRgvZVE3iFZtSq8ciL2tZEpZxRRcQyqPZWD0hau
 JqfN+7pIdqDaDs3r2stj/WdvUaMSKOKoCxvKXVeUXpl/vGUBaoYP8fwueK9RzP0eOV
 GvMj684ThvSaykz7rdpjc7cjk4TaOdZ3oRsjafeMxqRfin2UfcnBZ5wlK3iKACfQFD
 FOmNteKzxAsc18KUYSPy0t+HJ4ZVGccp7PAnxytqamoC5wwFOu3+B41+OancAXa1lf
 YoL3MU+mhl5Xw==
Message-ID: <379922705bfffd1db28821d192bd4970@kernel.org>
Date: Tue, 08 Sep 2026 12:17:05 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 73/74] drm/connector: Use the SPD InfoFrame field
 length defines
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-73-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-73-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:37 +0300, Cristian Ciocaltea wrote:
> DRM_CONNECTOR_HDMI_{VENDOR,PRODUCT}_LEN used to size the vendor and
> product arrays in struct drm_connector_hdmi.  Those arrays are gone and
> both names are now only validated before being copied into the SPD
> InfoFrame, hence the limits they have to be checked against are the ones
> of the SPD InfoFrame fields themselves.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
