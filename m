Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671AAC624D7
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A23810F4D1;
	Thu,  3 Sep 2026 10:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U8Zjwm0s";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16C9C10F4D3
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 10:22:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 99A8E40649;
 Thu,  3 Sep 2026 10:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C3F1F000E9;
 Thu,  3 Sep 2026 10:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788430937;
 bh=nPec+8FroZakd8/xtdqsN1t+JoYELhFhTVkg3y1NsYo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=U8Zjwm0sni2XbTsU5qAzoDKqQUPllGyfp9lx0A08uWo8tfgiM+DfrucMB+Mv6qlAt
 yeDThp78Ij9kM7pIKHq/5L4I9kl1fS/2xSYcFNVhFdSNAy6bFzGvlDmJzTcMbpuJXn
 GeM3tJ++zzE4I4a0teg9KT1um1LcBhzFLhMzubifP8e6n6+UWzDOqml2/l+In9HKH/
 EgxX/wJT+4PRi8VqCoL7/+TYo/5udldmXHjWxKQ2vZIwZ+K9j+NqDFO56BLxuzMsIJ
 Dp8sSkQ5LuxMU2MIm/RBy0KKhJtEKY+SQ2uEGyIAEh+137sftzIuqAvIMhtuXoP845
 jl9rLaKilZjMw==
Date: Thu, 3 Sep 2026 12:22:14 +0200
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
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
Message-ID: <aplG-skzq-TPfFZQ@houat>
References: <20260903-drm-bridge-every-panel-v2-0-2ab8ee24538e@bootlin.com>
 <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="4hpbtqrwcomowwmy"
Content-Disposition: inline
In-Reply-To: <20260903-drm-bridge-every-panel-v2-5-2ab8ee24538e@bootlin.com>
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


--4hpbtqrwcomowwmy
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC v2 05/19] drm/panel: embed a drm_bridge into every
 drm_panel
MIME-Version: 1.0

On Thu, Sep 03, 2026 at 10:11:08AM +0200, Luca Ceresoli wrote:
> Adding a drm_panel does currently not add a panel_bridge wrapping
> it. Usually the panel_bridge creation happens later, when some other driv=
er
> (e.g. the previous bridge or the encoder) calls *_of_get_bridge() and the
> following element in the pipeline is a panel.
>=20
> This has some drawbacks:
>=20
>  * the bridge API is currently the best practice to access various
>    components of the pipeline, especially with complex cards where bridges
>    can be combined in different ways on different hardware
>  * the panel_bridge is not created in the context of the driver of the
>    underlying physical device (the panel driver), but of some other driver
>  * that other driver is not aware of whether the returned drm_bridge
>    pointer is a panel_bridge created on the fly, a pre-existing
>    panel_bridge or a non-panel bridge
>  * removal of a panel_bridge requires calling drm_panel_bridge_remove(),
>    but that other driver doesn't know whether this is needed because it
>    doesn't know whether it has created a panel_bridge or not
>=20
> Other drivers call [a variant of] drm_panel_bridge_add(), which also has
> some of the above drawbacks.
>=20
> So far the current approach was working mostly because devm and drmm ensu=
re
> the panel bridge would be dealloacted at some later point. However with t=
he
> upcoming implementation of bridge hotplug and dynamic bridge lifetime this
> will get more complicated.
>=20
> Switch to the new approach: embed a drm_bridge inside every drm_panel,
> which behaves just like the current drm_panel_bridge.
>=20
> Do this by copying and adapting the code from bridge/panel.c, using
> function names that are more suitable within drm_panel.c and doing the
> minimal adaptation needed.
>=20
> Currently drm_bridge and drm_panel have independent refcounted
> allocation. As they now become a single struct, just change
> drm_panel_get/put() to get/put the bridge. As a result, the refcount for a
> drm_bridge embedded in a drm_panel is:
>=20
>   bridge.refcount =3D=3D number of drm_bridge_get() calls
>                    + number of drm_panel_get() calls
>                    - number of drm_bridge_put() calls
>                    - number of drm_panel_put() calls
>=20
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

So there's a lot to unravel, and I wished you had split it, but I can't
find a good way to split it either.

> This patch is new in v2, and replaces "drm/bridge: panel: add a
> panel_bridge to every panel" which was based on a different approach.
> ---
>  drivers/gpu/drm/drm_panel.c | 258 ++++++++++++++++++++++++++++++++++++++=
+++---
>  include/drm/drm_panel.h     |  33 ++++--
>  2 files changed, 266 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f8f6082e637f..9b86195f9f66 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -22,15 +22,19 @@
>   */
> =20
>  #include <linux/backlight.h>
> +#include <linux/debugfs.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> =20
> +#include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
> +#include <drm/drm_modeset_helper_vtables.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_panel.h>
>  #include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> =20
>  static DEFINE_MUTEX(panel_lock);
>  static LIST_HEAD(panel_list);
> @@ -46,6 +50,18 @@ static LIST_HEAD(panel_list);
>   * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
>   */
> =20
> +static inline struct drm_panel *
> +drm_bridge_to_panel(const struct drm_bridge *bridge)
> +{
> +	return container_of(bridge, struct drm_panel, bridge);
> +}
> +
> +static inline struct drm_panel *
> +drm_connector_to_panel(const struct drm_connector *connector)
> +{
> +	return container_of(connector, struct drm_panel, connector);
> +}
> +
>  /**
>   * drm_panel_init - initialize a panel
>   * @panel: DRM panel
> @@ -86,6 +102,7 @@ void drm_panel_add(struct drm_panel *panel)
>  	mutex_lock(&panel_lock);
>  	list_add_tail(&panel->list, &panel_list);
>  	mutex_unlock(&panel_lock);
> +	drm_bridge_add(&panel->bridge);
>  }
>  EXPORT_SYMBOL(drm_panel_add);
> =20
> @@ -97,6 +114,7 @@ EXPORT_SYMBOL(drm_panel_add);
>   */
>  void drm_panel_remove(struct drm_panel *panel)
>  {
> +	drm_bridge_remove(&panel->bridge);
>  	mutex_lock(&panel_lock);
>  	list_del_init(&panel->list);
>  	mutex_unlock(&panel_lock);
> @@ -370,13 +388,198 @@ int drm_panel_get_modes(struct drm_panel *panel,
>  }
>  EXPORT_SYMBOL(drm_panel_get_modes);
> =20
> -static void __drm_panel_free(struct kref *kref)
> +static int drm_panel_bridge_connector_get_modes(struct drm_connector *co=
nnector)
> +{
> +	struct drm_panel *drm_panel =3D drm_connector_to_panel(connector);
> +
> +	return drm_panel_get_modes(drm_panel, connector);
> +}
> +
> +/**
> + * drm_bridge_set_connector_orientation - Set the connector panel
> + * orientation from the bridge that can be transformed to drm_panel.
> + *
> + * @bridge: The drm_bridge for a drm_panel.
> + * @connector: The connector to be set panel orientation.
> + *
> + * Returns 0 on success, negative errno on failure.
> + */
> +int drm_bridge_set_connector_orientation(const struct drm_bridge *bridge,
> +					 struct drm_connector *connector)
> +{
> +	struct drm_panel *panel =3D drm_bridge_to_panel(bridge);
> +
> +	return drm_connector_set_orientation_from_panel(connector, panel);
> +}
> +EXPORT_SYMBOL(drm_bridge_set_connector_orientation);

I don't think we should create new ones. Just move the code from
bridge/panel here and remove it there. The only thing left will be the
panel_bridge_add() variants that become almost trivial now, and you can
cleanup the drivers in later patches.

This also allows to get rid of all the symbol renaming, which isn't
great in itself, but also the existing names were good so it's hard to
come with better ones.

Maxime

--4hpbtqrwcomowwmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaplKVQAKCRAnX84Zoj2+
dgFsAYCcTMOOQhPr9OTZmkc6rWK9eZPvodMVaikEOyG4zm9OYqIalLkovi+u8Thj
AS0ouGEBewe+D+pUd87EXhPtJs7N2S1s+LY1gaPBKQQapphINewDZVG1/fjAgXR8
29Nmc0CKHQ==
=Su7e
-----END PGP SIGNATURE-----

--4hpbtqrwcomowwmy--
