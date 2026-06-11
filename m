Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10095CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 618DF10E839;
	Thu, 11 Jun 2026 15:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E6JjFmTK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DC9A10E839
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:32:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3987643EFE;
 Thu, 11 Jun 2026 15:32:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909911F00898;
 Thu, 11 Jun 2026 15:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781191951;
 bh=U4b25Ho+ItGseHhBRS5Gh6L3AIi5GEWNlEQHnamaQOA=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=E6JjFmTK8d6ee2miRza2BirHt4M4zPh9No880YNmvw71uiXJBxvX+x0l9rXMttYiC
 prAz09+HQg9HHMF5DCr1VpHUBmIJ4Ecr/zs6elMSjCJVDdYOb5N5SyKiXVcvwNSkNm
 7Fz12vNMMbZCIUaIZqmqK0ni+LILRQ7KF/BsTAz51C7DXbOCkyrTfPy+e5bnlTZMeu
 KLKRp7XIOakTjjiSS7LVV8z2jl5vjHhQV8bSM3ZPasaNtr/y3NJju+bFEULpcIHgvR
 S2C4+Tw84D0+G76skiHhglYVs0le53rQmRNjUfa4rdvl2M0kcB0pZzRyqwh4+yjVyj
 n1JE2r2MJnESg==
Message-ID: <e6d0f078ffe3425dfbcd36a42ba9053a@kernel.org>
Date: Thu, 11 Jun 2026 15:32:27 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v7 24/30] drm/vc4: hdmi: Use common TMDS char rate
 constants
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-24-445eb54ee1ed@collabora.com>
References: <20260602-dw-hdmi-qp-scramb-v7-24-445eb54ee1ed@collabora.com>
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

On Tue, 2 Jun 2026 01:44:24 +0300, Cristian Ciocaltea wrote:
> Replace HDMI_14_MAX_TMDS_CLK defined locally with
> HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ provided by linux/hdmi.h.  Note this
> incorrectly referenced HDMI 1.4, as the 340 MHz maximum TMDS character
> rate was actually introduced in HDMI 1.3.
> 
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
