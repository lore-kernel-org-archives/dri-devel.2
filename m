Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 605DFCD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:41:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B62C110F24E;
	Mon,  8 Jun 2026 11:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hK0pgCWv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDBAC10F24E
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 11:41:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 30ECE6001D;
 Mon,  8 Jun 2026 11:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652A21F00893;
 Mon,  8 Jun 2026 11:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780918861;
 bh=d+EZBqP+S1aJsp/54O1thKJUxSPzexaWOdFPdQexaOQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=hK0pgCWv91eMLD6Vb7Vjy6FrQ9Y1cL3wtLXb/5eQqR565L49DIaE1d0oIQvDGQdoc
 /UGL3EOQ72zhpnpz/u4CpFmCN1SHGjN3Vpppt5fwLzvw5Bra8bS9MS97dCKmo1PYj0
 6aVeZZBbUhNEeijzwN4XyDloYovC0zjoB8DCw0EXzGLjIrkTJ9PtUOhhPPLXp1iOU6
 8z0FTezbycjRP97nSjcsyMdM8FciOe3nIwXyHdkjnKwI85Xk/++YtrMoei8u4Ougya
 ZLW5jMWmQoqRO7/IxFbx2VCkyZr3RbJhTsko7FN6aYeezBmuTbwk2yxm37rqrwsBA/
 KwRXAVbq1fkbA==
Date: Mon, 8 Jun 2026 13:40:59 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Hui Pu <Hui.Pu@gehealthcare.com>, 
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
Message-ID: <20260608-mindful-heavy-frigatebird-be9faf@houat>
References: <20260519-drm-bridge-hotplug-v1-0-45e2bdb3dfb4@bootlin.com>
 <20260519-drm-bridge-hotplug-v1-5-45e2bdb3dfb4@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="e7zj77hk553y5yo5"
Content-Disposition: inline
In-Reply-To: <20260519-drm-bridge-hotplug-v1-5-45e2bdb3dfb4@bootlin.com>
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


--e7zj77hk553y5yo5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 05/37] drm/display: bridge-connector: split code creating
 the connector to a subfunction
MIME-Version: 1.0

On Tue, May 19, 2026 at 12:37:22PM +0200, Luca Ceresoli wrote:
> In preparation to introduce bridge hotplug, split out from
> drm_bridge_connector_init() the code adding the drm_connector into a
> dedicated function. This will be needed to be able to add (and re-add) the
> connector from different code paths.

Same story here, explaining what you need later on that calls for that
change would be nice.

Maxime

--e7zj77hk553y5yo5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiaqSwAKCRAnX84Zoj2+
dp1sAYDuIBPdRMXXYBe4R+Ta//fpPl4lVKuHiYq4geMva/MrZIlnJY7jkUmM+ILE
qeT0kEkBfRpI8JftVgC2DB8CWv5JjL9HjVHimGNWg5t97RHprSbK09+C/O7VS3Ng
Kvor1YDv5Q==
=iyL4
-----END PGP SIGNATURE-----

--e7zj77hk553y5yo5--
