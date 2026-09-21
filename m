Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F30C982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 10:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8A6F10E063;
	Mon, 21 Sep 2026 10:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="cuLLnOrI";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE8A910E063
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 10:03:06 +0000 (UTC)
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 1A4FC1F947;
 Mon, 21 Sep 2026 12:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1789984984;
 bh=4lv/4qA49zZhVU6Mtn/HDxpZJGQJyADrP9l8XahpZC0=; h=From:To:Subject;
 b=cuLLnOrIpN8MYL71+U54afnRLtYNj/apQyXqHsXD9V/kHSFYbwoBTBFnCQcYdNKDH
 fMg36K1GT5vECr5fNb2Db3WPSzoY1SLhnGhqu8eYP4g1TnaBRQxUZ92knI4Ka3haIW
 +P2RCIwINK245R2oFTShmrgCQJcLEfMR79X9ovppMS2DxPcGQdDacjfU8LwDyRu4nE
 JAy9bK13RJq9ryRnODkiNkcdIr/RtUDSo0YvvkB7DBaYELvv5NFoSGOdaRujsitttc
 wGenHDupm2H7gCaGJ98fMkAx1rkJUNRn72umjS/GD/kz5KbhwC/qzbmeDNK+HGsL3t
 mMY8HON3Y+o9Q==
Date: Mon, 21 Sep 2026 12:02:59 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 0/3] drm/bridge: Add Thine THC63LVD827 LVDS encoder
 and 10inch LVDS panel on Colibri iMX7
Message-ID: <20260921100259.GA61633@francesco-nb>
References: <20260908100230.83796-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908100230.83796-1-francesco@dolcini.it>
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

Hello,
just a gentle ping on this.

On Tue, Sep 08, 2026 at 12:02:24PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This series adds support for the Thine THC63LVD827 DPI to LVDS encoder and
> afterward uses it to add a DT overlay to enable the Toradex 10inch LVDS panel
> on Colibri iMX7 / Iris

I did not get any feedback on the binding (apart a small comment from
Frank -> thanks!) and zero feedback on the driver. Maybe some DT and DRM
bridge people can have a look?

Thanks a lot, appreciated.

Francesco


