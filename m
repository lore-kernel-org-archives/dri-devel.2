Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B6DC61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F37B510E0D6;
	Thu,  3 Sep 2026 09:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G5huG6F6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30A9810E0D6
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 09:51:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C3CB743750;
 Thu,  3 Sep 2026 09:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0891F000E9;
 Thu,  3 Sep 2026 09:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788429094;
 bh=K1d1X7CTU5oXDtnyZDKqo+yDP2x2AA29X2d+7rWBvAU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=G5huG6F6h5AzuCaARyL9jE5Ryhonmr3ez7aRWq01/M7HOSwftTFBmtEtULML3mxH0
 J55V0cARnQg0RA8j5m3C9wDLoRwjAMIJoDkqzdTrZ7TjTcta5VfB8/TMeH7oRVICEA
 RbTVNW+eAo7aZz5hX/BtHYmhjOOQLLMdw+lVFdRNRdKcWHkcGloC41ENJzUfmj7Oef
 6q3+XPh+C0bJP3TYvgsTxnvDGGZfeYMMlQIUTpii9IBp7Mq86AHGSvTENzPFViplR6
 hPcCjdFIhWuUxgKy0Dofg7bAiRtS0S/k0sRoS3zARU2EdJHDCCtox0IFku8MUVK39l
 9n3pskS6djpfA==
Date: Thu, 3 Sep 2026 11:51:31 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Linus Walleij <linusw@kernel.org>, Inki Dae <inki.dae@samsung.com>, 
 Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Albert Esteve <aesteve@redhat.com>, Anusha Srivatsa <asrivats@redhat.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v2 01/19] drm: of: move drm_of_find_panel_or_bridge()
 from drm_of.c to bridge/panel.c
Message-ID: <aplCttfyxmPhToUq@houat>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-1-2ab8ee24538e@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="gkp53kusgh3zbgdw"
Content-Disposition: inline
In-Reply-To: <20260903-drm-bridge-every-panel-v2-1-2ab8ee24538e@bootlin.com>
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


--gkp53kusgh3zbgdw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 01/19] drm: of: move drm_of_find_panel_or_bridge()
 from drm_of.c to bridge/panel.c
MIME-Version: 1.0

Hi,

On Thu, Sep 03, 2026 at 10:11:04AM +0200, Luca Ceresoli wrote:
> We want to move drm_panel.o from the main drm module to a new drm_panel
> module, but there is one function in the drm module that calls into
> drm_panel.c code:
>=20
>   drm_of_find_panel_or_bridge() (in drm_of.c, drm module)
>      -> calls of_drm_find_panel (in drm_panel.c, would-be the new drm_pan=
el module)
>=20
> Avoid this issue by moving drm_of_find_panel_or_bridge() to bridge/panel.c
> (which is currently in the drm_kms_helper module).
>=20
> As a result drm_kms_helper will depend on the new drm_panel module, which
> is fine because there is no dependency of drm_panel on drm_kms_helper.
>=20
> After this change, all drivers using drm_of_find_panel_or_bridge() will
> have to select DRM_PANEL_BRIDGE (and DRM_PANEL, recursively). Add that for
> affected drivers. While there, also add DRM_PANEL on drivers selecting
> DRM_PANEL_BRIDGE.
>=20
> No functional changes, just moving code around.
>=20
> [AI used to add 'select DRM_PANEL[_BRIDGE]' for affected drivers]
> Assisted-by: opencode:deepseek-v4-flash-0731
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

In the previous discussion, I suggested to move it to drm_panel.c
because it's not really related to the panel_bridge stuff, like, at all.
And both drm_panel.c and drm_bridge.c are in drm.ko at this point so you
shouldn't have any issue there.

Also, you don't have to select DRM_PANEL_BRIDGE anymore.

Maxime

--gkp53kusgh3zbgdw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaplDIQAKCRAnX84Zoj2+
dk6vAXwO9vOKeJZow147hUdFsI/s8UxS5hxKETOiyZPWrbu+faDqiS5MdVQxCber
PerzaxcBfjoc29Dn4cN2dHrv1BvfGdeLbaagCNC2F7PI/Iq0C+B5uLN1H2pXvtNa
rhDNHq+V4w==
=AlCQ
-----END PGP SIGNATURE-----

--gkp53kusgh3zbgdw--
