Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232BCCCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 11:01:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8220F10E13A;
	Thu, 30 Apr 2026 11:01:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="e6y3ybpx";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A0D10E13A
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 11:01:29 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id CBD224E42B77;
 Thu, 30 Apr 2026 11:01:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 9CCD960495;
 Thu, 30 Apr 2026 11:01:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0CDC0102F1848; 
 Thu, 30 Apr 2026 13:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1777546886; h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=BhwMpVtUqkZLZTp2J+UylAJhGh2ZmpvGBNpjDJzUMOE=;
 b=e6y3ybpx6XSBy89HNTym3ef67O679iDtfDSaVQki6qQgpE5PVC7smn8l7fAmVxRIeU69nm
 KFxQ7O7x/2AAX9vGZ1hH/Pk4DNc4TD49bVWA+foXLOOkZbcqppmZvPD6aFcVnoqtEExu4z
 dLVieyAAzlEdiqoySGYVzMK8lkHwP4btby+Z4H9hk6PEg+6TPCsNKEc3TehuEBHXdso+pU
 V7Z41toV/9v6pxnKb7XQjLX4AIHsEuJQIad0KqavjZM6HmTK3vFwHSRsFn+hvNDF7d16hn
 BA7fFfvvwuhW7aFYLvkxGwgmMvg24sjUvjKda0gwqiqcIiM3zf1qqkSrxYhdgg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 30 Apr 2026 13:01:16 +0200
Message-Id: <DI6FS20AP8M2.3PBKGP25K4XQX@bootlin.com>
Subject: Re: [PATCH v3 2/2] drm/bridge: chipone-icn6211: use
 devm_drm_bridge_add in dsi probe
To: "Osama Abdelkader" <osama.abdelkader@gmail.com>, "Jagan Teki"
 <jagan@amarulasolutions.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Robert Foss"
 <rfoss@kernel.org>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>,
 "Jonas Karlman" <jonas@kwiboo.se>, "Jernej Skrabec"
 <jernej.skrabec@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.20.1
References: <20260423200604.324615-1-osama.abdelkader@gmail.com>
In-Reply-To: <20260423200604.324615-1-osama.abdelkader@gmail.com>
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

Hello Osama,

On Thu Apr 23, 2026 at 10:06 PM CEST, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop drm_bridge_remove() in chipone_dsi_probe.

Wait, this patch must drop drm_bridge_remove() in chipone_dsi_remove() too!
Otherwise it'd be introducing an excess put, and consequent use-after-free.

I have to withdraw my R-by.

You can amend in v4.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
