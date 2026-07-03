Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8755CC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 18:33:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F65810E65D;
	Fri,  3 Jul 2026 18:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sntech.de header.i=@sntech.de header.b="JaiJG4NC";
	dkim-atps=neutral
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB1510E65D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 18:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de; 
 s=gloria202408;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
 bh=00oEUKbXqblY98GY99IjBpABdrFGvC9SalkPe3rfYJY=; b=JaiJG4NCQrh7UOwml5H8y1y6s4
 yqDBRMXUxAZMydcriv+Mcawda0XeZpT6vUQ/HEDJClr46CID+61qicGWPdiUYWGEnyxxUQ0HF3G6b
 YEMR8BFpzIccfcE0rxI5FrCgOxkWN94baj2bnZBDDNoTg/GhjsuXaVTibH2FDr+lQNUbOOpDcEEhw
 ZjkGbnIwd0UTi2sheyaxQxW7jcdRQDxIR1EXfOQ3JSJ0jNqG3kyShUW+1SU7zWeMvuCgtcePJ7AV8
 /Rdk8/hBWTJM1jAujFciN/H/cOd9+6X/MnYFdfJ+Mh621yA+5X1cW0jQ57vAYy3tu9rc5Os2DFST4
 jl1e6F7g==;
From: Heiko Stuebner <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2] MAINTAINERS: Track dw-hdmi-qp under Rockchip DRM
 drivers
Date: Fri,  3 Jul 2026 20:33:00 +0200
Message-ID: <178310357191.42647.16730078751010845257.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260612-maintainers-rk-drm-upd-v2-1-3ff65fc41a93@collabora.com>
References: <20260612-maintainers-rk-drm-upd-v2-1-3ff65fc41a93@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Fri, 12 Jun 2026 13:01:29 +0300, Cristian Ciocaltea wrote:
> The DW HDMI QP TX library was developed for and is currently only used
> by Rockchip platforms.  Add it to the Rockchip DRM drivers section to
> ensure all relevant parties are kept in the loop on any changes.
> 
> As its file paths fall outside the generic wildcard patterns defined in
> the ARM/Rockchip SoC support section, also add the
> linux-rockchip@lists.infradead.org mailing list to avoid any
> notification gaps.
> 
> [...]

Applied, thanks!

[1/1] MAINTAINERS: Track dw-hdmi-qp under Rockchip DRM drivers
      commit: 01d082bbbd60c4468e88a97bc07052678339f9f6

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
