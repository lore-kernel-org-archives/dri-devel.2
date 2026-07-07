Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B344C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885EE10E4CA;
	Tue,  7 Jul 2026 11:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K9KmMl0+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6086610E4CA
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:31:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEC466001D;
 Tue,  7 Jul 2026 11:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E081F000E9;
 Tue,  7 Jul 2026 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783423917;
 bh=o9XS4mAa/niw4o7KN4TnJnnoOPlMOHQQ8KOFpEX1oM8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=K9KmMl0+fowRhICuH9f1klH3DRqo2WG1LCQm2wDFDclswIvrGqYtrfJHDBFS9dFX/
 eZ+6mnlhIlro86j4VSf70oBCTcAkKfUuuZR6ptmxtWKHHuloAwtbHX0BtSlWoYrBNb
 MbmPUTpPefM9q/bXeGgFF2Lx0rHftbythW58UqjVmQ0g5QZRT6+yzYW0/3JCHKZcxa
 RCh2qlHaXt1FNyQelGzAtt+jSMYKYaqfSgzI75lV23R7vHHOPKUZB85ivamk3+A6gN
 86TQdJY7taIPDmzwj8QIsBHBesJ684crGpyh6KbioevtN5WSRJJi/87oCHnZvBpkoL
 Hekh74+MT4lDQ==
Date: Tue, 7 Jul 2026 13:31:53 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v8 10/39] drm/display: hdmi-state-helper: Sync SCDC state
 on hotplug
Message-ID: <20260707-unique-carmine-cheetah-af2cb8@penduick>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-10-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ckuhjwyyqe3iie6h"
Content-Disposition: inline
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-10-d79890d00b6a@collabora.com>
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


--ckuhjwyyqe3iie6h
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 10/39] drm/display: hdmi-state-helper: Sync SCDC state
 on hotplug
MIME-Version: 1.0

Hi,

On Thu, Jul 02, 2026 at 05:46:23PM +0300, Cristian Ciocaltea wrote:
> drm_atomic_helper_connector_hdmi_hotplug() does not currently
> synchronize SCDC status on hotplug events, leaving the scrambler state
> potentially inconsistent after (re)connect.
>=20
> Hook drm_connector_hdmi_sync_scdc() into both the connect and disconnect
> paths, replacing the existing TODOs around missing scrambler handling.
>=20
> SCDC synchronization may require a CRTC reset, which in turn needs a
> modeset acquire context for correct locking.  Therefore, extend
> drm_atomic_helper_connector_hdmi_hotplug() and
> drm_atomic_helper_connector_hdmi_update() to take a
> drm_modeset_acquire_ctx argument.  Additionally, change their return
> type from void to int, allowing propagation of errors, such as -EDEADLK
> from lock contention.
>=20
> Update existing callers to pass NULL for the acquire context, preserving
> current behavior.

You should have two patches here: one to change the prototype of the
helpers, and one to add the call to drm_connector_hdmi_sync_scdc


> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c  |  3 ++-
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 28 +++++++++++++++++--=
------
>  drivers/gpu/drm/vc4/vc4_hdmi.c                  |  2 +-
>  include/drm/display/drm_hdmi_state_helper.h     |  6 ++++--
>  4 files changed, 26 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 796069dbf1a1..46104506fe32 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -221,7 +221,8 @@ drm_bridge_connector_detect(struct drm_connector *con=
nector, bool force)
>  		status =3D detect->funcs->detect(detect, connector);
> =20
>  		if (hdmi)
> -			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
> +			drm_atomic_helper_connector_hdmi_hotplug(connector, status,
> +								 NULL);
> =20
>  		drm_bridge_connector_hpd_notify(connector, status);
>  	} else {

We should move this one to detect_ctx to get the ctx passed and avoid
passing NULL here.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index db76699093e8..69ccfbf123fe 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -1198,18 +1198,20 @@ drm_atomic_helper_connector_hdmi_clear_audio_info=
frame(struct drm_connector *con
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_clear_audio_infoframe);
> =20
> -static void
> +static int
>  drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
> -					enum drm_connector_status status)
> +					enum drm_connector_status status,
> +					struct drm_modeset_acquire_ctx *ctx)

detect_ctx has the context first, I think we should use that convention
here too.

>  {
>  	const struct drm_edid *drm_edid;
> +	int ret =3D 0;
> =20
>  	if (status =3D=3D connector_status_disconnected) {
> -		// TODO: also handle scramber, HDMI sink disconnected.
> +		ret =3D drm_connector_hdmi_sync_scdc(connector, false, ctx);
>  		drm_connector_hdmi_audio_plugged_notify(connector, false);
>  		drm_edid_connector_update(connector, NULL);
>  		drm_connector_cec_phys_addr_invalidate(connector);
> -		return;
> +		return ret;
>  	}
> =20
>  	if (connector->hdmi.funcs->read_edid)
> @@ -1222,24 +1224,32 @@ drm_atomic_helper_connector_hdmi_update(struct dr=
m_connector *connector,
>  	drm_edid_free(drm_edid);
> =20
>  	if (status =3D=3D connector_status_connected) {
> -		// TODO: also handle scramber, HDMI sink is now connected.
> +		ret =3D drm_connector_hdmi_sync_scdc(connector, true, ctx);
>  		drm_connector_hdmi_audio_plugged_notify(connector, true);
>  		drm_connector_cec_phys_addr_set(connector);
>  	}
> +
> +	return ret;
>  }
> =20
>  /**
>   * drm_atomic_helper_connector_hdmi_hotplug - Handle the hotplug event f=
or the HDMI connector
>   * @connector: A pointer to the HDMI connector
>   * @status: Connection status
> + * @ctx: Lock acquisition context to be used for resetting CRTC
>   *
>   * This function should be called as a part of the .detect() / .detect_c=
tx()
>   * callbacks for all status changes.
> + *
> + * Returns:
> + * Zero on success, error code on failure.
> + * If @ctx is set, it might also return -EDEADLK.
>   */
> -void drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *conn=
ector,
> -					      enum drm_connector_status status)
> +int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *conne=
ctor,
> +					     enum drm_connector_status status,
> +					     struct drm_modeset_acquire_ctx *ctx)
>  {
> -	drm_atomic_helper_connector_hdmi_update(connector, status);
> +	return drm_atomic_helper_connector_hdmi_update(connector, status, ctx);
>  }
>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
> =20
> @@ -1254,6 +1264,6 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotp=
lug);
>   */
>  void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connec=
tor)
>  {
> -	drm_atomic_helper_connector_hdmi_update(connector, connector->status);
> +	drm_atomic_helper_connector_hdmi_update(connector, connector->status, N=
ULL);
>  }

We should create a new context here.

>  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
> diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdm=
i.c
> index 74dce4be0c00..e165f604939b 100644
> --- a/drivers/gpu/drm/vc4/vc4_hdmi.c
> +++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
> @@ -375,7 +375,7 @@ static void vc4_hdmi_handle_hotplug(struct vc4_hdmi *=
vc4_hdmi,
>  	 * the lock for now.
>  	 */
> =20
> -	drm_atomic_helper_connector_hdmi_hotplug(connector, status);
> +	drm_atomic_helper_connector_hdmi_hotplug(connector, status, NULL);

vc4_hdmi_handle_hotplug has the context passed as an argument, we should re=
use it.

Maxime

--ckuhjwyyqe3iie6h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakzjqAAKCRAnX84Zoj2+
dt55AX9pNPl78Oml4GB8/KEiBCBKf+dju6sv4h4a8ejL8Fa9TaHpVvQr63GeUCxd
ovHkevUBgKCOZN2jEIYht0Z9sQMQ+tsG0ssT7n8+RS3LnMYbgxSw/m3XoQSMxRMW
ZGrm8k9+zA==
=cdCW
-----END PGP SIGNATURE-----

--ckuhjwyyqe3iie6h--
