Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA82CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70E06113532;
	Mon,  1 Jun 2026 16:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="h0u1hGjE";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63AF3113530
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 16:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780329678; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Xz46wNfnlz0b8gUAF9eu84SORf+31YzJYeqWTAshuiIWSrQOmUYHmPL0A91lX345YMcrpvIA1h02WDA0M7W0oQzN3q6Iah1l2WeP2WqF/N5V7FRW7TiQMHrLwf5YpsfAyIZMWxuXlDccNDMCAvIZDGFVG8Rq4FlvExbWAgOEsGc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780329678;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=M6RUKK6Dv4KYmFZJqR7uG26GOOxK74QJpHTVhXZZ0XE=; 
 b=g12wVPffJgxv62LUT2MhD5HpzJZQp5Hg9JdjylXbRdBa1l4QdyugySkalrZlpZIO3xEBeZvGl2gqIc+cDp8ZZuO9hnt/k5vx6eWoxlP/H2t3urFVz1zxoDlaB8tvAHDU5c1FoW3/yV9FZzWL6HN5dfNrEB3Itb12KP0XFB4lTes=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780329678; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=M6RUKK6Dv4KYmFZJqR7uG26GOOxK74QJpHTVhXZZ0XE=;
 b=h0u1hGjE4VNbXcRp6R8oXgSTgMuPAY89H8m59YLeA0S4y7Y71+/fM5s8VytD9ngW
 cBbGvJTfrnfhpzSr2Qn4FRdQKHrb1vLyI40ylrqRyN+A4pIk8NA8xwFB8/ADKzLjNFp
 4gyT1IgyrOyy/NwQlzUdqdX0zareSCxjH4UsWi30=
Received: by mx.zohomail.com with SMTPS id 1780329676984725.7810970568634;
 Mon, 1 Jun 2026 09:01:16 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 5D356181D80; Mon, 01 Jun 2026 18:01:12 +0200 (CEST)
Date: Mon, 1 Jun 2026 18:01:12 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Yongxing Mou <yongxing.mou@oss.qualcomm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] drm/bridge: split hpd_mutex into two mutexes
Message-ID: <ah2smWb3vurXHg1X@venus>
References: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
 <20260528-dp-connector-hpd-v3-1-d656eb1079b7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sukuz4zqzekqlssz"
Content-Disposition: inline
In-Reply-To: <20260528-dp-connector-hpd-v3-1-d656eb1079b7@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.2.1.5.2/280.325.56
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


--sukuz4zqzekqlssz
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 1/3] drm/bridge: split hpd_mutex into two mutexes
MIME-Version: 1.0

Hi,

On Thu, May 28, 2026 at 10:10:48AM +0300, Dmitry Baryshkov wrote:
> Currently almost all bridge drivers which implement hpd_enable /
> hpd_disable callbacks simply toggle the hardware registers generating
> the interrupt. However, as pointed out by Jonas Karlman and Sashiko bot,
> using those callbacks for enable_irq() / disable_irq() calls or
> scheduling and cancelling the work can cause a AB-BA deadlock (between
> hpd_mutex lock and the corresponding lock).
>=20
> Split the hpd_mutex into two locks: one simply making sure that hpd_cb /
> hpd_data are consistent and another one, hpd_state_mutex, making sure
> that concurrent drm_bridge_hpd_enable() / drm_bridge_hpd_disable() calls
> can't end up with inconsistency between hpd_cb/_data and bridge's
> internal state.
>=20
> Link: https://lore.kernel.org/dri-devel/9aa4bd35-bff6-4009-a959-ce31010c7=
b35@kwiboo.se
> Link: https://sashiko.dev/#/patchset/20260513-dp-connector-hpd-v2-0-42f75=
7bfcbf9%40oss.qualcomm.com
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

-- Sebastian

>  drivers/gpu/drm/drm_bridge.c | 16 +++++++++++++---
>  include/drm/drm_bridge.h     |  4 ++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 687b36eea0c7..9a185032a3bd 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -417,6 +417,7 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  	if (!list_empty(&bridge->list))
>  		list_del_init(&bridge->list);
> =20
> +	mutex_init(&bridge->hpd_state_mutex);
>  	mutex_init(&bridge->hpd_mutex);
> =20
>  	if (bridge->ops & DRM_BRIDGE_OP_HDMI)
> @@ -469,6 +470,7 @@ void drm_bridge_remove(struct drm_bridge *bridge)
>  	mutex_unlock(&bridge_lock);
> =20
>  	mutex_destroy(&bridge->hpd_mutex);
> +	mutex_destroy(&bridge->hpd_state_mutex);
> =20
>  	drm_bridge_put(bridge);
>  }
> @@ -1451,19 +1453,25 @@ void drm_bridge_hpd_enable(struct drm_bridge *bri=
dge,
>  	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
>  		return;
> =20
> +	mutex_lock(&bridge->hpd_state_mutex);
> +
>  	mutex_lock(&bridge->hpd_mutex);
> =20
> -	if (WARN(bridge->hpd_cb, "Hot plug detection already enabled\n"))
> +	if (WARN(bridge->hpd_cb, "Hot plug detection already enabled\n")) {
> +		mutex_unlock(&bridge->hpd_mutex);
>  		goto unlock;
> +	}
> =20
>  	bridge->hpd_cb =3D cb;
>  	bridge->hpd_data =3D data;
> =20
> +	mutex_unlock(&bridge->hpd_mutex);
> +
>  	if (bridge->funcs->hpd_enable)
>  		bridge->funcs->hpd_enable(bridge);
> =20
>  unlock:
> -	mutex_unlock(&bridge->hpd_mutex);
> +	mutex_unlock(&bridge->hpd_state_mutex);
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_hpd_enable);
> =20
> @@ -1484,13 +1492,15 @@ void drm_bridge_hpd_disable(struct drm_bridge *br=
idge)
>  	if (!(bridge->ops & DRM_BRIDGE_OP_HPD))
>  		return;
> =20
> -	mutex_lock(&bridge->hpd_mutex);
> +	mutex_lock(&bridge->hpd_state_mutex);
>  	if (bridge->funcs->hpd_disable)
>  		bridge->funcs->hpd_disable(bridge);
> =20
> +	mutex_lock(&bridge->hpd_mutex);
>  	bridge->hpd_cb =3D NULL;
>  	bridge->hpd_data =3D NULL;
>  	mutex_unlock(&bridge->hpd_mutex);
> +	mutex_unlock(&bridge->hpd_state_mutex);
>  }
>  EXPORT_SYMBOL_GPL(drm_bridge_hpd_disable);
> =20
> diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
> index 4ba3a5deef9a..00a95f927e34 100644
> --- a/include/drm/drm_bridge.h
> +++ b/include/drm/drm_bridge.h
> @@ -1256,6 +1256,10 @@ struct drm_bridge {
>  	 * @hpd_mutex: Protects the @hpd_cb and @hpd_data fields.
>  	 */
>  	struct mutex hpd_mutex;
> +	/**
> +	 * @hpd_state_mutex: Protects the HPD en/disablement state for the brid=
ge.
> +	 */
> +	struct mutex hpd_state_mutex;
>  	/**
>  	 * @hpd_cb: Hot plug detection callback, registered with
>  	 * drm_bridge_hpd_enable().
>=20
> --=20
> 2.47.3
>=20

--sukuz4zqzekqlssz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmodrMQACgkQ2O7X88g7
+pqUPA//cGkiPvhmcQq+CSXgsvzW8DDCzoNFeoVaa15FM2vyov1HuzIQ3lfffo1T
JmUxqXK7QGKR/5HrNKjcY8chBjBY7thj/uc4yWV35IEal+LGeUpEilurqpHgIjrU
Q2TMo4UFqguyExGeuPlB/PMbupsNCexIXwwdcJijROnRXIpARqsrsbwqyH68/Vmg
erjVJ0QwOv92jPxoRX4xSy8rpC426lVnWBHhnQch0+XVfcNseXU/yvBvMSNaQosF
PHOnWy2PIBvn7SNm75oUvjN2uyazlXwuS6xdJjxNBYxLcTxIrGUsnmW1Gd92Xtt9
YwmMLiYLd7l/UESdUmf+nOx4IxQU6vi58CJJYyxIhKCv3ExD7VyPlmXRLJOIg6Nj
9imcFAaDLwHOupXc+bVisUcX5Z7X1hvzpNvNav2Pwa+pNG10NVIpzmyOoyiGkT+e
0mbjEodUXd6ZtJxFrVdxXRTHPXWsX6mw7Eem7rHRu5mPBvNTduacybBfEWsTOX1M
bOsx8yWAYK2CWWMvzHxt6QMNUYPuRu3de6BvFGlqOZ5LLG/dL3im3g7MZB5MyebS
6zZmLTL7hDarO2mboe2xGDqCaQUQH8ge96g3xlajIMwQlyCwbrn/3mpCOQmRlP0s
h2txyY6EL6Yd94B4poND20o6DQGf4c8mxW+Eye6l+xu6JgG75Zg=
=kR2R
-----END PGP SIGNATURE-----

--sukuz4zqzekqlssz--
