Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 822B3CD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 08:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBB510E0A9;
	Sat,  6 Jun 2026 08:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OVr8kyq/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1883D10E077
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 08:54:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1F771600AE;
 Sat,  6 Jun 2026 08:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419511F00893;
 Sat,  6 Jun 2026 08:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780736065;
 bh=BXBDhJFqXmNFTR1SDUa/CoufD3WKY2E1dhVX8e8Uar8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OVr8kyq/s5fJ/763/Xu6H+g3vFesXLnSE7D5UIYTbLsNQclQYhuVWj8fAFOki5iH+
 AtFVCMTGGUZt9/uowfLWKs2ynfWEjho73qll9+UzcXyKAScGw6yZe6QSNr3H8bpNEf
 eeFvcZqwyFBDW9aQLZJ+cmHhvoArHg8KpCQtan016Jo1vU4U3Ttvy6ed5Tdz6xOq0J
 1fw07XQs5JTABAETiN1xvvqXvgxnLsAKlCabZ+e0j7BKsD0yOm+XXpSF+d6WxFhCsq
 QSFwO5DpBLl4cFkxP3ndfHtrvP+11jLQDvmEjYyy6sYosDdcTod6dg4ce/vTIRJQ/g
 QCqCxoyerpOvQ==
Date: Sat, 6 Jun 2026 10:54:23 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Daniel Stone <daniel@fooishbar.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Daniel Stone <daniels@collabora.com>
Subject: Re: [PATCH v5 3/4] drm/display: bridge_connector: init scdc debugfs
 for HDMI
Message-ID: <20260606-bright-smooth-chihuahua-3eac7f@houat>
References: <20260604-scdc-link-health-v5-0-11173b0ac3de@collabora.com>
 <20260604-scdc-link-health-v5-3-11173b0ac3de@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="t55cz35iw4h5faha"
Content-Disposition: inline
In-Reply-To: <20260604-scdc-link-health-v5-3-11173b0ac3de@collabora.com>
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


--t55cz35iw4h5faha
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 3/4] drm/display: bridge_connector: init scdc debugfs
 for HDMI
MIME-Version: 1.0

Hi,

On Thu, Jun 04, 2026 at 05:52:08PM +0200, Nicolas Frattaroli wrote:
> On drm_bridge_connectors that contain an HDMI bridge, initialise the
> SCDC debugfs entry under the connector's debugfs root.
>=20
> Reviewed-by: Daniel Stone <daniels@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index cafa498c3848..629d9b8aff22 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -25,6 +25,7 @@
>  #include <drm/display/drm_hdmi_cec_helper.h>
>  #include <drm/display/drm_hdmi_helper.h>
>  #include <drm/display/drm_hdmi_state_helper.h>
> +#include <drm/display/drm_scdc_helper.h>
> =20
>  /**
>   * DOC: overview
> @@ -263,6 +264,9 @@ static void drm_bridge_connector_debugfs_init(struct =
drm_connector *connector,
>  		if (bridge->funcs->debugfs_init)
>  			bridge->funcs->debugfs_init(bridge, root);
>  	}
> +
> +	if (bridge_connector->bridge_hdmi)
> +		drm_scdc_debugfs_init(connector, root);
>  }

We register the other debugfs entries in drm_debugfs_connector_add /
hdmi_debugfs_add. I don't think there's anything specific to bridge
connector here and it would benefit to drivers that don't use it as
well, so I think putting it in the generic part of the framework would
be better.

Maxime

--t55cz35iw4h5faha
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaiPgPgAKCRAnX84Zoj2+
dt3EAYDiWtHPJ6LNFz3CxHTW7D6Yg5C5i2JBIz/1KB+HNHrI48bgJJbnnlG6t93b
8feD5UYBgKYNv5FUAM0da9JiIx4bBVmTjJuXbwvp7xwdL9EYmBsEZP9IHMLrOHEi
4Ij0bwSKxw==
=n3ds
-----END PGP SIGNATURE-----

--t55cz35iw4h5faha--
