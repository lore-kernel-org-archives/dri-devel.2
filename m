Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A70BCD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0976C10E266;
	Thu, 11 Jun 2026 15:19:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sg9gAoyR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5166610E266
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:19:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 59586600AA;
 Thu, 11 Jun 2026 15:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F7A1F00898;
 Thu, 11 Jun 2026 15:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781191177;
 bh=28c7kE48N7xjxdMBXG72aK5f+72+xxiC+Mf8uQsdzvY=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=Sg9gAoyR72sLzbmyaHYiKZePL+6yRvjflirMaehl2jqek7CuVSbv97qgN+zz4tc5V
 dDN8CgNOySokjqRq0Y6JYB6pF+KY4FR8917omVcSeer5b2DiflwT6icPRAI9FGKr4v
 70alWR0susjbOymSmjfofooZ02DFXEjagsWLwUlLOIQRXSn71pE2XoJ6fU4zBolehm
 SiJdVYOWz23MHn8SD1TW32sgbpvSm4m8i0anxDw0sOzLBNhhWBpY/LqusCqQ0UAs+m
 H9y9WcOZLpkaXLCD6MVHksd+iUWnr8hAKWOvFCUaHthnJIBnW56PJFGi0Or7AbTXKQ
 w3FjaM+Fdir1w==
Message-ID: <404cdc5ee5da868c0f0cb17d19dcebd8@kernel.org>
Date: Thu, 11 Jun 2026 15:19:34 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v7 03/30] drm/display: scdc_helper: Add macro for
 connector-prefixed debug messages
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-3-445eb54ee1ed@collabora.com>
References: <20260602-dw-hdmi-qp-scramb-v7-3-445eb54ee1ed@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Andy Yan" <andy.yan@rock-chips.com>, "Daniel
 Stone" <daniels@collabora.com>,
 "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>,
 "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, 
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Raspberry
 Pi Kernel Maintenance" <kernel-list@raspberrypi.com>,
 "Robert Foss" <rfoss@kernel.org>, "Sandy
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

On Tue, 2 Jun 2026 01:44:03 +0300, Cristian Ciocaltea wrote:
> Introduce the drm_scdc_dbg() wrapper over drm_dbg_kms() to help getting
> rid of the boilerplate around prefixing the debug messages with the
> connector information.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
