Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8681C56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD0710E327;
	Thu,  6 Aug 2026 15:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fujBcfWb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB40610E327
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 15:52:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 638D4416A9;
 Thu,  6 Aug 2026 15:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C151F000E9;
 Thu,  6 Aug 2026 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786031574;
 bh=XPw3enwGX95RXfElNSyDCr0BeaHfU7WQp7mz5RFXKzs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fujBcfWbb/WrGIyEmwZYzP7zqQl3QbxQvW98rB9PYwQJJE155W19yVWFpYNCfoias
 JBMnQYTKi8jWnV0d2sg6waH3TA7Y0i/Cn2z0WaVLsjsTwaDkiVQ2sELtwWEhcCBpM2
 h1F+h2E47iil+pbDsuNa+1BqsRyPGd+QCEOEJldZ3u5jKl0QB2m44X0dhXOU3LVtxJ
 QwC+U0ZIQeQJUl6XH8726PwjE4vnOS+x2ovZ45og3/9UQ9uj/5xek4axw2uEUBb0MG
 4fv/dEQgWkDJZ0I6t6lBegAPB2i78qYdWdiE9IW4K2qblYFtmWs89HiB3XiPOvde5z
 ZVwzPNdV4rftA==
Date: Thu, 6 Aug 2026 21:22:50 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v6 5/7] phy: rockchip: phy-rockchip-typec: Add DRM AUX
 bridge
Message-ID: <anSt0gsVo29rLRqd@vaman>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-6-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804070730.68-6-kernel@airkyi.com>
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

On 04-08-26, 15:07, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
> 
> Using the DRM_AUX_BRIDGE helper to create the transparent DRM bridge
> device.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
