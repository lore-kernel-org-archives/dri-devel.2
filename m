Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD3C2C531D0
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 02:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2975110E2A3;
	Tue, 28 Jul 2026 02:08:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="R/daAVTS";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B29F110E2A3
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:08:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785204503; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ADvwHjaqTI7E0Ew6bj3umGfz0Hr7gp1rj6aB3gUM773C/DsZaYi8kEDT41qeczvA0IV3mu4P0OTpDjNk1gF6r7EwNOPXNEbxvpMJIEy0iVdU1J9l4c1iPBeOLUw8OC/zzxXQeYU9KX3Hxy51CgnSm5TJQVV6/Bb1VCfeTsnOrR0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785204503;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RyEWZIgGoF00G9qiUl97iH+HUGBemn4hfiC+wbFVDiI=; 
 b=nlSDbbaQ8REpRbXiHYh4dAJk2Jp298wpYTkR1Q+qPXdmhTmbgkd8H9ItP6GBCvWkl/UzYYkqwOf6GKUxHlEfuhwBDXLHrzncKukOK7cVtOTSajfbHuLodf4WD7R6kHRRcZP+dL8I5cceRtQVe1F8Pzw7ezpJZLX/AifT4YTg65w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785204503; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=RyEWZIgGoF00G9qiUl97iH+HUGBemn4hfiC+wbFVDiI=;
 b=R/daAVTSKLTAycVKPXjCmrhxZH0DDxBEiKhWVgKorykxEbxt8t7KEacDegxCEub9
 h/AzVtHxD1eJEMyNv6BX1EjE7oWrc6Euc1bfL5JzxWviEJJIaq0/zyM8dHb9toFaMMZ
 2L4JX7WXzvkWFwdMwGBHzelz54v7IbnVDHz1p+gM=
Received: by mx.zohomail.com with SMTPS id 1785204500990426.00984876395273;
 Mon, 27 Jul 2026 19:08:20 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 759CE180524; Tue, 28 Jul 2026 04:08:14 +0200 (CEST)
Date: Tue, 28 Jul 2026 04:08:14 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Chaoyi Chen <kernel@airkyi.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Sandy Huang <hjc@rock-chips.com>, 
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, 
 Vinod Koul <vkoul@kernel.org>, Chaoyi Chen <chaoyi.chen@rock-chips.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-phy@lists.infradead.org
Subject: Re: [PATCH v4 0/5] This series is split from the v15 "Add Type-C DP
 support for RK3399 EVB
Message-ID: <amgMXujurBrB5B0L@venus>
References: <20260727064408.101-1-kernel@airkyi.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wslejz3kxq4lsyn3"
Content-Disposition: inline
In-Reply-To: <20260727064408.101-1-kernel@airkyi.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.10.1.5.2/285.167.77
X-ZohoMailClient: External
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


--wslejz3kxq4lsyn3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/5] This series is split from the v15 "Add Type-C DP
 support for RK3399 EVB
MIME-Version: 1.0

Hello Chaoyi,

On Mon, Jul 27, 2026 at 02:44:03PM +0800, Chaoyi Chen wrote:
> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>=20
> [1] https://lore.kernel.org/all/20260304094152.92-1-kernel@airkyi.com/
>=20
> =3D=3D=3D=3D
> 1. Generic Type-C DP HPD bridge
>=20
> Currently, several USB-C controller drivers register their own DP HPD
> bridge via aux-hpd-bridge.c, each duplicating the same logic. For
> devicetree based platforms, the USB-C controller may vary across boards,
> and not every USB-C controller driver implements this feature. Patch 1
> implements a generic DP HPD bridge that monitors Type-C bus events and
> automatically creates an HPD bridge when a Type-C port device with DP
> SVID is registered.
>=20
> 2. Multiple bridge model for CDN-DP
>=20
> The RK3399 has two USB/DP combo PHY and one CDN-DP controller. Patch 5
> introduces a multi-bridge model where each PHY port gets a separate
> encoder and bridge, allowing flexible selection of the output PHY port.
> This is based on the DRM AUX HPD bridge rather than extcon.
>=20
> =3D=3D=3D=3D
> Patch 1 adds generic USB Type-C DP HPD bridge (Dmitry, Heikki).
> Patch 2 adds new API drm_aux_bridge_register_from_node() (Neil).
> Patch 3 adds DRM AUX bridge support for RK3399 USBDP PHY (Neil).
> Patch 4 drops CDN-DP's extcon dependency when Type-C is present (Dmitry).
> Patch 5 adds multiple bridges to support PHY port selection (Dmitry, Luca=
).
>=20
> Changes in v4:
> - Link to v3: https://lore.kernel.org/all/20260717072323.96-1-kernel@airk=
yi.com/
> - Scan the entire typec_bus and attempt to register the hpd bridge,
>   so as not to miss devices that were already added during initialization.

While that may help with the module being loaded late, it does not
help with triggering the module load in the first place.

The module does not have any MODULE_DEVICE_TABLE() helping with
that. So basically any system relying on the automatic hpd bridge
registration and using a modular kernel (e.g. the arm64 defconfig or
the kernels usually provided by Linux distributions) requires
manually loading that module to get any graphical output.

Greetings,

-- Sebastian

> Changes in v3:
> - Link to v2: https://lore.kernel.org/all/20260608070805.88-1-kernel@airk=
yi.com/
>   (Sorry, I forgot to add the "v2" title, so it looks like v1.)
> - Remove now-redundant call to drm_connector_attach_encoder()
> - Rebase to v7.2-rc2
>=20
> Changes in v2:
> - Link to v1: https://lore.kernel.org/all/20260521032854.103-1-kernel@air=
kyi.com/
> - Add copyright text.
> - Remove useless goto.
> - Fix incorrect function names in the documentation comments.
> - Fix the check logic for dp->active_port (0 is valid).
> - Fix the uninitialized prev_port.
> - Remove duplicate logic from cdn_dp_switch_port().
> - Fix the prototype of cdn_dp_bridge_hpd_notify().
> - Properly release connector->fwnode.
> - Properly release next_bridge.
>=20
> Chaoyi Chen (5):
>   drm/bridge: Implement generic USB Type-C DP HPD bridge
>   drm/bridge: aux: Add drm_aux_bridge_register_from_node()
>   phy: rockchip: phy-rockchip-typec: Add DRM AUX bridge
>   drm/rockchip: cdn-dp: Support handle lane info without extcon
>   drm/rockchip: cdn-dp: Add multiple bridges to support PHY port
>     selection
>=20
>  drivers/gpu/drm/bridge/Kconfig                |  10 +
>  drivers/gpu/drm/bridge/Makefile               |   1 +
>  drivers/gpu/drm/bridge/aux-bridge.c           |  26 +-
>  .../gpu/drm/bridge/aux-hpd-typec-dp-bridge.c  |  64 ++++
>  drivers/gpu/drm/rockchip/Kconfig              |   1 +
>  drivers/gpu/drm/rockchip/cdn-dp-core.c        | 358 ++++++++++++++----
>  drivers/gpu/drm/rockchip/cdn-dp-core.h        |  18 +-
>  drivers/phy/rockchip/Kconfig                  |   2 +
>  drivers/phy/rockchip/phy-rockchip-typec.c     |  13 +-
>  include/drm/bridge/aux-bridge.h               |   6 +
>  10 files changed, 428 insertions(+), 71 deletions(-)
>  create mode 100644 drivers/gpu/drm/bridge/aux-hpd-typec-dp-bridge.c
>=20
> --=20
> 2.53.0
>=20
>=20

--wslejz3kxq4lsyn3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmpoDwoACgkQ2O7X88g7
+pq00g/+P6xQ6MSgg91MljD+vnTg2VTasRDBvjtKt4yJqP8hXXIFvfLaJaysp2kp
dHor49WP4MhEzAbseLecHnyzcR8uDvl0MPwNJJ6J8Fb4yCMPPT+SG79m9YaxRW2Q
cQ+nMvDcCQOQFU0vcxEN+CzOlexgXCVrRqEiLMPKYB8qTfT7AxnWE1Lg577QHP9J
W8EInQO1Ail9XlLypdaGFN9tozuiufX8XmvDaV+LrJf3KZvt3uqsBa0l4aAzB6/W
pg0ZGbO7x7hIO3bvIDsS83hmGDHdeMJrfxvcoBO1aeK+DDl0JdXdiefH6AT/tiKK
4wuvIYP4vgrtZZKJtUsSRPuy46EKJnc4ID/b/vspsyqXReypNxKN4u/PzuFtXcbh
yGGTU7rzrOq9BwRKryiMHekpbw7VlKPiOnWDzkXrQ0NJevDnEe4iG4DkS/RugOND
tFKvrXgGUwLo4zd0VIQ43B0PX15qmbGG+XSvuxIqdDJpSddelcl4yNmfpSm2YD9y
/6YocqSJ4lsMmkncKjAOt0KYCef2dsFh2UhezJrZNAZEzcfLRXjUn2s6rLJBq+m5
ab30eeOoK7iqpeISWT7MJu1dGC7+WntBG7Wvu2tOz4R37lpbttnZ4mSigwOt2X7Y
pd34j30G3aCD+Kz/lDVrKP04yHdqCRHsTioVnTqxptb894J0wgI=
=Fuia
-----END PGP SIGNATURE-----

--wslejz3kxq4lsyn3--
