Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F74CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 16:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A18511352D;
	Mon,  1 Jun 2026 16:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Md85yp0Q";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01DD11352D
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 16:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1780329735; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dWLfqeyV5WXjimFfWnAgO1EKAXipeZMeRS/GJBbNT1VJnz9WJ7HksOtqDmof+a3n9bL3yqdb7dp1ejwD0WIMD8+FdcKyeqSLxgefw/cojtUfTdaHowURHjzh1pAZYwaWm65nVkc0kvH1YcR2b0ef0Fr3HDr2WG/yzUyTLHluIUY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780329735;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=SrsUXfnUJrD3l+nPosSf0I8cEPXSLvK+jSRPGolnPCA=; 
 b=a1LCjnCLgMUwtAE8moiaooaKL0y+yoR0dSuETuq7SKl3yLci9p1suFbQ/u7nbpSzTZKgClAY+BdAPCHET7up3Vz6xgqsPihcX7O7tlCl/sDf3UYsNFS3FsAbAAFXI6GZd0cRFdN5JxxyiJDNlCssSOMUXu+VgNHeetI6sX6+clw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
 dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780329735; 
 s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=SrsUXfnUJrD3l+nPosSf0I8cEPXSLvK+jSRPGolnPCA=;
 b=Md85yp0QPWNgLeGQzcK8jn69COKx7rvJRYO5DInWLjweyu5OPvsGnCFuQTdrGKBq
 Z8UAz6BapUNiEbc76dSZ56B/SHks1jo+EwcabqKjGeS9StOU2rVWRx2Rq54buO2TXbN
 SoBcGQabwluOkLdb233EgG1+UT3oWzrYg7FaMWVw=
Received: by mx.zohomail.com with SMTPS id 1780329732652585.4977616290358;
 Mon, 1 Jun 2026 09:02:12 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
 id 4418F181D80; Mon, 01 Jun 2026 18:02:08 +0200 (CEST)
Date: Mon, 1 Jun 2026 18:02:08 +0200
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
Subject: Re: [PATCH v3 3/3] drm/bridge: display-connector: trigger initial
 HPD event for DP
Message-ID: <ah2s4fLscIjuLVrG@venus>
References: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
 <20260528-dp-connector-hpd-v3-3-d656eb1079b7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eeqjbs2l4yu5hol3"
Content-Disposition: inline
In-Reply-To: <20260528-dp-connector-hpd-v3-3-d656eb1079b7@oss.qualcomm.com>
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


--eeqjbs2l4yu5hol3
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 3/3] drm/bridge: display-connector: trigger initial
 HPD event for DP
MIME-Version: 1.0

Hi,

On Thu, May 28, 2026 at 10:10:50AM +0300, Dmitry Baryshkov wrote:
> If the DisplayPort drivers use display-connector for the HPD detection,
> the internal HPD state machine might be not active and thus the hardware
> might be not able to handle cable detection correctly. Instead it will
> depend on the external HPD notifications to set the cable state,
> bypassing the internal HPD state machine (for example this is the case
> for the msm DP driver).
>=20
> However if the cable has been plugged before the HPD IRQ has been
> enabled, there will be no HPD event coming. The drivers might fail
> detection in such a case. Trigger the HPD notification after enabling
> the HPD IRQ, propagating the cable insertion state.
>=20
> Note, this issue only affects drivers which set OP_HPD but not OP_DETECT
> (like dp-connector). Here DP differs from HDMI. For HDMI there is no
> additional state or extra "bridge with no sinks plugged" cases. The HPD
> pin state is equal to the display plugged state. Nor do we have an AUX
> bus with timeouts, etc.
>=20
> Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
> Reported-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Greetings,

-- Sebastian

>  drivers/gpu/drm/bridge/display-connector.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm=
/bridge/display-connector.c
> index 6bb1134f75c3..f7a5bfd9c075 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -12,6 +12,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
> =20
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -25,6 +26,8 @@ struct display_connector {
> =20
>  	struct regulator	*supply;
>  	struct gpio_desc	*ddc_en;
> +
> +	struct work_struct	hpd_work;
>  };
> =20
>  static inline struct display_connector *
> @@ -92,15 +95,29 @@ static void display_connector_hpd_enable(struct drm_b=
ridge *bridge)
>  	struct display_connector *conn =3D to_display_connector(bridge);
> =20
>  	enable_irq(conn->hpd_irq);
> +
> +	if (conn->bridge.type =3D=3D DRM_MODE_CONNECTOR_DisplayPort)
> +		schedule_work(&conn->hpd_work);
>  }
> =20
>  static void display_connector_hpd_disable(struct drm_bridge *bridge)
>  {
>  	struct display_connector *conn =3D to_display_connector(bridge);
> =20
> +	if (conn->bridge.type =3D=3D DRM_MODE_CONNECTOR_DisplayPort)
> +		cancel_work_sync(&conn->hpd_work);
> +
>  	disable_irq(conn->hpd_irq);
>  }
> =20
> +static void display_connector_hpd_work(struct work_struct *work)
> +{
> +	struct display_connector *conn =3D container_of(work, struct display_co=
nnector, hpd_work);
> +	struct drm_bridge *bridge =3D &conn->bridge;
> +
> +	drm_bridge_hpd_notify(bridge, display_connector_detect(bridge));
> +}
> +
>  static const struct drm_edid *display_connector_edid_read(struct drm_bri=
dge *bridge,
>  							  struct drm_connector *connector)
>  {
> @@ -395,6 +412,8 @@ static int display_connector_probe(struct platform_de=
vice *pdev)
>  		conn->bridge.ops |=3D DRM_BRIDGE_OP_DETECT;
>  	if (conn->hpd_irq >=3D 0)
>  		conn->bridge.ops |=3D DRM_BRIDGE_OP_HPD;
> +	if (conn->hpd_irq >=3D 0 && type =3D=3D DRM_MODE_CONNECTOR_DisplayPort)
> +		INIT_WORK(&conn->hpd_work, display_connector_hpd_work);
> =20
>  	dev_dbg(&pdev->dev,
>  		"Found %s display connector '%s' %s DDC bus and %s HPD GPIO (ops 0x%x)=
\n",
>=20
> --=20
> 2.47.3
>=20

--eeqjbs2l4yu5hol3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmodrP8ACgkQ2O7X88g7
+pqGzhAAo18XRV0vx/fZs/FIw1cs7rGOU4GuRI5Fqor6Oa8XkP4ug1pvRA5pXBq9
cBsbIlJN5jYtsNdcAjPIpj51ifbCmRJ2yFSs4alZQ60v0qqMQM/X09jYsMH2oCfG
+AmTKXW/T5zG0MDSOSckK+eEmhQDdtVmHZjugLs5jfgELF9P+jRVsGo3rNqAnOTP
9OPwXcK8jYBqYmyvUwNS5QIl3DvqYc3ah3V0ccUgaiIe+pWbRYm+fql2d19tf/Da
euy7W6UZWqFlLkwngm+Pu33+rsllzL8CCbJcG64gMpQgIlsD+mlZD3xhDk1Dutv/
npFgNLD2IF+KOlI9mD9j94TLBKQlfoRMTXsNH/B92PbA99dWwOZZy4rsRlZiM0Q8
xSdNY1eNMATYE9CX14nhuvIlMhpzTXIY/KCarf3cIL6RdBZJeoG72r9WhmQkSgbq
Y9fmbLh5vvB29i41eX1crsg/apeVM46jkXokjJzW34IMzOj5bKP7HsczKsyiaWvJ
B17cJb+jlg7NtiFRRQNW0/ro+FPehKoVT286PNTJfiGZy35hsGzoRbe/A/8fCY7O
H1P9Qwi5IDGrYiQvzVqC2GigJfJhy4GqLcXSo7w3LINoZefJQMe0owPb2OlEHDhy
o56VssTjurGR6l09PMwtudLOgQFZhUJhkkQChjltNzpsC++v/lU=
=OVj4
-----END PGP SIGNATURE-----

--eeqjbs2l4yu5hol3--
