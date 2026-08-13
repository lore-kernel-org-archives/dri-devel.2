Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70297C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4ED210F332;
	Thu, 13 Aug 2026 13:29:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZRKCUPsV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D6A910F332
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 13:29:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 866E560A72;
 Thu, 13 Aug 2026 13:29:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92F41F000E9;
 Thu, 13 Aug 2026 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786627774;
 bh=AJLFF08mlIeE/IaoIYnB9WQvz/G/9RrPj8LIHZ81MUA=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=ZRKCUPsV2DcAo7/uNBRzJ5M9T3+Q5wbDsU50aulixxpZp2tJCLJEOzo9xpB4DvBqw
 JiP8zIhDOcdkaOO9A9sj0C6Yivmu+DzyFinRvAmSVh2VMic6UAoxZ5FG7zIK3chKYT
 z4aDv4EnWWonKLN5OCw1zwmoLmsUse62geBB4GtkbE2FrBgGSPWutIs3yH5wHN/2Ya
 yC06XlME0PfVSZp4Cv0eysB+DvKVsjTnSLIlmGCv6wqOeszXAvgS8AyByVUXp/M0Ij
 M8KvoiBto3KduG974o7B+FZr2xSRFTfeAL73fLio9biCykRwBhbPdDtkwV2E3g1J3Y
 hGGqtaE5vwzBQ==
Message-ID: <98a2bbceb9e9bcb99cddbd43d21e18ba@kernel.org>
Date: Thu, 13 Aug 2026 13:29:32 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v10 55/69] drm/sun4i: hdmi: Convert to
 drmm_connector_hdmi_init()
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-55-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-55-294364b2cf15@collabora.com>
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

On Fri, 31 Jul 2026 19:20:02 +0300, Cristian Ciocaltea wrote:
> Switch driver over to the new drmm_connector_hdmi_init() signature and
> advertise HDMI 1.2 support.  The vendor, product, supported_formats and
> max_bpc values previously passed as arguments are now provided through
> struct drm_connector_hdmi_funcs, together with the new
> supported_hdmi_ver field.
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
