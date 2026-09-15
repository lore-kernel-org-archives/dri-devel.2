Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA10BC88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:58:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E253810EFBD;
	Tue, 15 Sep 2026 16:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ztDWLvYg";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E1DD10EFBD
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 16:58:49 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id A71B2C5CD53;
 Tue, 15 Sep 2026 16:52:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 024C7602B0;
 Tue, 15 Sep 2026 16:52:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AC5D711C7AFE9; 
 Tue, 15 Sep 2026 18:51:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1789491119; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=J+W8jzUN9Nr4o39KHusBPRBAUepoUVjLuBu5Yy8yLeM=;
 b=ztDWLvYgvZDO6Q/PM5ZMPZFmmQ6qzwP0+voZl57rf+NwnScvs96wJoeW/LpJJziSuQyN+H
 xwB9A2e9BnlDTrQb2LO4ARd9cHDH4SB+R1ufzxeltVj9SuKsHRTtGhRj8NXYs+Mj22BGIi
 lTwczkyi44rEUMIUuKqGCqhhgY/RGCyXPwiGLyKBPHl2ICnwTorL0/n7ZiEeBvjL/XHk++
 0TVj6o3V38psNtbQ7v2UjYzvOcLcB8wAZeaEmqkU9gpL+sf+v3gyY5ymXMOC+KkUpd9ipH
 W55kT1pOSM6FFQE2QyA6zDsDuxVDIUK4/es0tZsRC4YmHOxHN59A1peoDI94nQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 18:51:47 +0200
Message-Id: <DLG1NM1TYW5E.IEVBU2FZSJDD@bootlin.com>
Subject: Re: [PATCH v4 0/9] drm/bridge: Kconfig: cleanup DRM_PANEL usage
Cc: "Hui Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray"
 <ian.ray@gehealthcare.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mediatek@lists.infradead.org>, "Marek Szyprowski"
 <m.szyprowski@samsung.com>, "Marek Vasut" <marex@denx.de>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Christopher Vollo"
 <chris@renewoutreach.org>, "Sean Paul" <seanpaul@chromium.org>, "Vincent
 Palatin" <vpalatin@chromium.org>, "Tony Lindgren" <tony@atomide.com>,
 "Michael Walle" <mwalle@kernel.org>, "Vinay Simha BN" <simhavcs@gmail.com>,
 "Maoyi Xie" <maoyixie.tju@gmail.com>, "Andy Yan" <andy.yan@rock-chips.com>,
 "Andrey Gusakov" <andrey.gusakov@cogentembedded.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, "Peter Ujfalusi"
 <peter.ujfalusi@ti.com>, "Svyatoslav Ryhel" <clamor95@gmail.com>, "Sam
 Ravnborg" <sam@ravnborg.org>, <sashiko-bot@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Andrzej Hajda"
 <andrzej.hajda@intel.com>, "Neil Armstrong" <neil.armstrong@linaro.org>,
 "Robert Foss" <rfoss@kernel.org>, "Laurent Pinchart"
 <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman" <jonas@kwiboo.se>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>, "Andrey Gusakov"
 <andrey.gusakov@cogentembedded.com>, "Andy Yan" <andy.yan@rock-chips.com>,
 "Christopher Vollo" <chris@renewoutreach.org>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Maoyi Xie" <maoyixie.tju@gmail.com>, "Marek
 Szyprowski" <m.szyprowski@samsung.com>, "Marek Vasut" <marex@denx.de>,
 "Michael Walle" <mwalle@kernel.org>, "Peter Ujfalusi"
 <peter.ujfalusi@ti.com>, "Sam Ravnborg" <sam@ravnborg.org>, "Sean Paul"
 <seanpaul@chromium.org>, "Svyatoslav Ryhel" <clamor95@gmail.com>, "Tomi
 Valkeinen" <tomi.valkeinen@ideasonboard.com>, "Tony Lindgren"
 <tony@atomide.com>, "Vinay Simha BN" <simhavcs@gmail.com>, "Vincent
 Palatin" <vpalatin@chromium.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com>
In-Reply-To: <20260915-drm-bridge-drm_panel-cleanup-v4-0-30401d9406f3@bootlin.com>
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

Hello Andrey, Andy, Christopher, Jagan, Maoyi, Marek, Marek, Michael,
Peter, Sam, Sean, Svyatoslav, Tomi, Tony, Vinay, Vincent,

On Tue Sep 15, 2026 at 6:46 PM CEST, Luca Ceresoli wrote:
> As a cleanup in preparation for making every drm_panel embed a drm_bridge=
,
> fix missing or unnecessary usage of DRM_PANEL and DRM_PANEL_BRIDGE in
> drivers/gpu/drm/bridge/Kconfig.

these patches are trivial oneliners and other work depends on them, but
cannot be applied as they have no reviews so far.

I'd appreciate if you could find a moment to review those you are in Cc as
maintainers, reviewers or recent contributors (and other patches in the
series you might find interesting).

Being just Kconfig changes, there should be no runtime regressions, only
build failures in the worst case.

Thank you in advance for your time.

Kind regards,
Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
