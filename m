Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24A4CA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBEE10E9BA;
	Tue, 29 Sep 2026 12:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C+A3HWkd";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5C9210E9BA
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:33:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 36E69601DB;
 Tue, 29 Sep 2026 12:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA111F000FF;
 Tue, 29 Sep 2026 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790685204;
 bh=KUwUjMVBP3vS5uVD7JFyXQM3OFGJ06H6GRm6/a2EbWI=;
 h=Date:From:To:Subject:In-Reply-To:References:Cc;
 b=C+A3HWkdKO81/B1Q1XFktA3cbzqSOwj9eFQnuyH1QhF6ABihMg5Jd+lFJELVLWDUb
 bIksCr13OHa4mrpetUxgiwbW6P8UWdbuASa1OZLd/KMEPEjHqpG6fh4i7dDtruj7yG
 iAGFJO06run5kQDMb0fl880QTkb6RAW6GlNh2qXr3HtK5MQu/tSyDuFgCyYY8UDY9R
 IVaelf9cJFE878R2IqyJ9IR1QxqFONbpdryO2e/Ml+nfSenAoXxM3fewEqC/aPysBx
 dRIP4pDI79mmHHA9t/yHsb6aU0H9/LIZ9OVtovmpoW4e2hq9qK1ShP7D6tBfAPvZOa
 UdcEyA4cUBcXg==
Message-ID: <fd2f689afaecae34de3b027ce19aefca@kernel.org>
Date: Tue, 29 Sep 2026 12:33:21 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH 1/7] drm/imx/lcdc: stop using deprecated
 devm_drm_of_get_bridge()
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v1-1-ccb7e602daad@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v1-1-ccb7e602daad@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, "Andrzej
 Hajda" <andrzej.hajda@intel.com>, "Arnd Bergmann" <arnd@kernel.org>, "Dave
 Stevenson" <dave.stevenson@raspberrypi.com>, "David Airlie" <airlied@gmail.com>,
 "Doug
 Anderson" <dianders@chromium.org>, "Fabio Estevam" <festevam@gmail.com>, "Frank
 Li" <Frank.Li@nxp.com>, "Geert Uytterhoeven" <geert+renesas@glider.be>, "Hui
 Pu" <Hui.Pu@gehealthcare.com>, "Ian Ray" <ian.ray@gehealthcare.com>, "Icenowy
 Zheng" <zhengxingda@iscas.ac.cn>, "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Jonas Karlman" <jonas@kwiboo.se>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>, 
 =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>,
 "Neil Armstrong" <neil.armstrong@linaro.org>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>,
 "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Robert
 Foss" <rfoss@kernel.org>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Simona
 Vetter" <simona@ffwll.ch>, "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
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

On Tue, 29 Sep 2026 12:36:33 +0200, Luca Ceresoli wrote:
> devm_drm_of_get_bridge() is deprecated, switch to
> of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() retur=
ns
> a refcounted bridge, ensure it is put.
>=20
> Fixes build failure when CONFIG_OF is disabled.
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
