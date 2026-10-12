Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E22F2CA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:41:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48A7B10E407;
	Mon, 12 Oct 2026 16:41:03 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDD8D10E60A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 16:40:56 +0000 (UTC)
Received: from killaraus.ideasonboard.com (i68975AE2.versanet.de
 [104.151.90.226])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 548F322B;
 Mon, 12 Oct 2026 18:38:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1791823134;
 bh=psu8SUNxGWOkv+ylpg3Mn+GzzgQJS+IaRBtMvOCtzD0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hnc5ghg+R78pkLio/XQ2zib4fsPKVAHorkCShNxFoD4zgwwrLD2NIcUtbT8pUvzTs
 Xw7bWX9M0vc7aktIrGNXxW1xwOq8V/a33mjOSm1DBMdHOXTOUhKAVVU4UyMX6bkCXr
 Irp4BHU/3pyjtlDvlqUucJq65YtM9uPKgarMmyk0=
Date: Mon, 12 Oct 2026 18:40:54 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Leonardo Costa <leoreis.costa@gmail.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 Leonardo Costa <leonardo.costa@toradex.com>
Subject: Re: [PATCH 0/3] Add VGA support for Apalis iMX6
Message-ID: <20261012164054.GA56180@killaraus.ideasonboard.com>
References: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
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

On Mon, Oct 12, 2026 at 04:25:22AM -0300, Leonardo Costa wrote:
> This series adds a device tree overlay that enables the VGA output on Apalis
> iMX6, which is driven from a parallel RGB interface passing through a
> non-programmable video DAC.
> 
> The video DAC is a simple resistor network gated by an active-low
> data-enable signal. For the bridge to work properly, this series also
> changes the following in the dt-bindings and simple-bridge driver:
> 
> - dt-bindings: Add a new compatible for the bridge in the simple-bridge
>   binding. This is necessary because the existing dumb-vga-dac compatible
>   doesn't describe a data-enable signal polarity.
> 
> - simple-bridge: Add the VGA bridge match-table entry and timings
>   struct, setting the DRM_BUS_FLAG_DE_LOW flag for the bridge.

Is there schematics available anywhere ? That would help reviewing the
series ?

> 
> This change depends on another patch, and should be applied after it:
> 
> - https://lore.kernel.org/all/20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com/T/#u
> 
>   Adds the atomic_check function to the simple-bridge driver, which
>   allows the data-enable bus flag to be propagated through the DRM
>   pipeline. This is necessary for the VGA to work correctly on the
>   Apalis iMX6.
> 
> Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
> ---
> Leonardo Costa (3):
>       dt-bindings: display: bridge: simple: Add the Toradex Apalis iMX6 VGA DAC bridge
>       drm/bridge: simple-bridge: Add Toradex RGB to VGA DAC bridge
>       ARM: dts: imx6q-apalis: Add VGA overlay
> 
>  .../bindings/display/bridge/simple-bridge.yaml     |  1 +
>  arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
>  .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 79 ++++++++++++++++++++++
>  drivers/gpu/drm/bridge/simple-bridge.c             | 10 +++
>  4 files changed, 111 insertions(+)
> ---
> base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
> change-id: 20260928-v1-apalis-imx6-enable-vga-5c7ba6b358fe

-- 
Regards,

Laurent Pinchart
