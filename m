Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775A7C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 12:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7F9E10EBAC;
	Tue,  8 Sep 2026 12:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T+OZxDzm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7DDB10EBAC
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 12:27:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF7F743BEB;
 Tue,  8 Sep 2026 12:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16D21F00A3A;
 Tue,  8 Sep 2026 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788870437;
 bh=fzGtfk86Cjb9SfEfKKT3CvCMk5MzBMJhuuAr5zCkHDo=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=T+OZxDzmFhtwfxQUDigQV8iYgcmk1nVuS1p5I+fsWVjs6z/Foia6U8gnM+85CdD1q
 8e3kEiGLj5EIgbAajVqBFp3BmOAhliLVBkj0EbrxHbdhYj0OvlJS0h96Wd2S+Zj9Pw
 7jOLuBaY9BnvA7BAYgHvOcpQ/qlhcash2+du7RPJj3Ph3VhFr8SidngLg0LGPcaCmi
 AiUiql/fUlpQrSx5KSbjx7cz3fJozZD1rnmNxtYPXWQanoXM8F7rp7I5rKC3oSnfTg
 bPCZucNWjKUAAFXBzd2Q2OYiVjpAQTRt9a1cBETRT1WfyVUGh1JI/NJQbQA2+FmK2j
 Duxwa0xZf8Fsw==
Message-ID: <d251e4005c5bef3e1cf1cd49abe0e1bb@kernel.org>
Date: Tue, 08 Sep 2026 12:27:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 07/74] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-7-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-7-bc12954a0688@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-sunxi@lists.linux.dev, "Algea
 Cao" <algea.cao@rock-chips.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Andy
 Yan" <andy.yan@rock-chips.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Daniel
 Stone" <daniels@collabora.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>,
 "Dmitry Baryshkov" <lumag@kernel.org>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Helge
 Deller" <deller@gmx.de>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu
 Ying" <victor.liu@nxp.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maud Spierings" <maud_spierings@hotmail.com>, "Maxime
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

On Tue, 1 Sep 2026 21:50:31 +0300, Cristian Ciocaltea wrote:
> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
> 
> - A drm_connector_hdmi_scrambler_supported() helper to report whether
>   the source supports the scrambling capability
> - A .scrambler_{enable,disable}() pair of callbacks in
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
