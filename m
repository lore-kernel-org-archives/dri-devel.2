Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A0ACA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF1C610EE8C;
	Tue, 29 Sep 2026 12:35:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kSao9Y6Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD16910EE8C
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 12:35:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A7B24149F;
 Tue, 29 Sep 2026 12:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073811F000FF;
 Tue, 29 Sep 2026 12:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790685348;
 bh=SVS98uBuKLlulEgGUf4CF5N23plwVuHF1+58y7MeRw0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=kSao9Y6ZyIhIEhOL8deNeZES2JKLRtgBYjdkfGFmqEGINTsooFvBefZrTFwp3Wcm7
 4380RM7ANERkudKmY9eMTcgvAKLzXUn/XtVJoklDsD2kbLyo1qLjSaXibrh3cfN/Cl
 HADtSYF+ATgTwSmGVUyhxPlFXAVXBmoW719SBZoV9dTETNxDD3VMbb9mxCqvg/DBlC
 L++cXq5zwu7FfVBlBTXpgCvhhpacZDSjpxJrbPxqCtDBRb891vI2ZvV6PT6Zpm1cMn
 NPodJv18zgr3QM93urQuh9gXXsSlEQTWIMLkFGI5yJ5tBcEJ2Zwf0qxT+M5VH8xVbH
 qGuvwvMxsQixQ==
Date: Tue, 29 Sep 2026 14:35:45 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Icenowy Zheng <zhengxingda@iscas.ac.cn>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Arnd Bergmann <arnd@kernel.org>, Doug Anderson <dianders@chromium.org>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 5/7] drm/vc4: dpi: stop using deprecated
 drmm_of_get_bridge()
Message-ID: <aruwg3rk97RuI75G@houat>
References: <20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v1-5-ccb7e602daad@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="gu4ry47i36m6y6ya"
Content-Disposition: inline
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v1-5-ccb7e602daad@bootlin.com>
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


--gu4ry47i36m6y6ya
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 5/7] drm/vc4: dpi: stop using deprecated
 drmm_of_get_bridge()
MIME-Version: 1.0

On Tue, Sep 29, 2026 at 12:36:37PM +0200, Luca Ceresoli wrote:
> devm_drm_of_get_bridge() is deprecated, switch to
> of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() returns
> a refcounted bridge, ensure it is put.

You didn't remove devm_drm_of_get_bridge but drmm_drm_of_get_bridge here

Maxime

--gu4ry47i36m6y6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaruwoQAKCRAnX84Zoj2+
dhXFAX9+KeIOq/xb4GCdjfaVk97PHMNyuDv+YPaRJjRr9ci7wa6Mnd1jmeH173OC
EBavZnwBgJ6Vgs3vD6hzIFe0v11EyR4LeqnaRde5Ku4D5Zkir/3MpOhKIAxjopqG
7th5dz2hCA==
=7NDu
-----END PGP SIGNATURE-----

--gu4ry47i36m6y6ya--
