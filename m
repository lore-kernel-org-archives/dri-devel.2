Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C3A5CD8CBF
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDB4810E319;
	Tue,  9 Jun 2026 13:20:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nu3c//Al";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC72D10E2D7;
 Tue,  9 Jun 2026 13:20:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6F6FC4369A;
 Tue,  9 Jun 2026 13:20:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F451F0089B;
 Tue,  9 Jun 2026 13:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781011204;
 bh=3kfzfYUQjmzrzaNngkfG7jEfCJtYkrmcPuvtAzgJevo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Nu3c//AlzSp8dePkkxInyBwOH1za16zBtOfwyKKYtLFFLjiG8i4p3lxnz7/woXZRt
 JtKfFb9rqoH+SnrrC4q2iV44PdZ/9zVTsMNh6FhyvEl7aeFW7q1jiKXD0iYDuZT/19
 WAoTm2OfHpFKUjwDV7p3e1NXD1LDpjNUjE5OJ0BXTDAqSNdwXFpcotHjICirfRcDqq
 gXCCws+Lwj8qzUFh7jDIZdWSsogSZOcJi186LTV8ZYFAGhPuAZOcImMurdCnIqzQ5X
 HlfUlKnoNl7MCbPDCPLxB+eDFsxDgAHMilxw3DMD1rCWpElmqaPJkEJURsALDig2p1
 sWS4POf/gNapw==
Date: Tue, 9 Jun 2026 15:20:01 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>, 
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Francesco Dolcini <francesco@dolcini.it>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, 
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Subject: Re: [PATCH v4 1/8] drm/connector: report out-of-band IRQ_HPD events
Message-ID: <20260609-bouncy-tomato-dalmatian-70ccee@houat>
References: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
 <20260608-hpd-irq-events-v4-1-30b62b335487@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="25e53fw4vpfchyki"
Content-Disposition: inline
In-Reply-To: <20260608-hpd-irq-events-v4-1-30b62b335487@oss.qualcomm.com>
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


--25e53fw4vpfchyki
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 1/8] drm/connector: report out-of-band IRQ_HPD events
MIME-Version: 1.0

Hi,

On Mon, Jun 08, 2026 at 12:33:02AM +0300, Dmitry Baryshkov wrote:
> The DisplayPort standard defines a special kind of events called IRQ.
> These events are used to notify DP Source about the events on the Sink
> side. It is extremely important for DP MST handling, where the MST
> events are reported through this IRQ.
>=20
> In case of the USB-C DP AltMode there is no actual HPD pulse, but the
> events are reported through the bits in the AltMode VDOs.
>=20
> Rename drm_connector_oob_hotplug_event() to drm_connector_dp_oob_status()
> and extend its interface to report IRQ events to the DisplayPort Sink
> drivers.
>=20
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/drm_connector.c          | 20 ++++++++++++--------
>  drivers/usb/typec/altmodes/displayport.c | 23 +++++++++++++++--------
>  include/drm/drm_connector.h              | 21 +++++++++++++++++++--
>  3 files changed, 46 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 3fa4d2082cd7..bb128dd0263a 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -3502,20 +3502,24 @@ struct drm_connector *drm_connector_find_by_fwnod=
e(struct fwnode_handle *fwnode)
>  }
> =20
>  /**
> - * drm_connector_oob_hotplug_event - Report out-of-band hotplug event to=
 connector
> + * drm_connector_dp_oob_status - Report out-of-band hotplug event to Dis=
playPort connector
>   * @connector_fwnode: fwnode_handle to report the event on
>   * @status: hot plug detect logical state
> + * @extra_status: additional information provided by the sink without ch=
anging
> + * the HPD state (or in addition to such a change).
>   *
> - * On some hardware a hotplug event notification may come from outside t=
he display
> - * driver / device. An example of this is some USB Type-C setups where t=
he hardware
> - * muxes the DisplayPort data and aux-lines but does not pass the altmod=
e HPD
> - * status bit to the GPU's DP HPD pin.
> + * In some cases when DisplayPort signals are being routed through the U=
SB
> + * Type-C port the hotplug event notifications come from outside of the =
display
> + * driver / device. In this case hardware muxes the DisplayPort data and
> + * AUX-lines but does not pass the altmode HPD status bit to the GPU's D=
P HPD
> + * pin.
>   *
>   * This function can be used to report these out-of-band events after ob=
taining
>   * a drm_connector reference through calling drm_connector_find_by_fwnod=
e().
>   */
> -void drm_connector_oob_hotplug_event(struct fwnode_handle *connector_fwn=
ode,
> -				     enum drm_connector_status status)
> +void drm_connector_dp_oob_status(struct fwnode_handle *connector_fwnode,
> +				 enum drm_connector_status status,
> +				 enum drm_connector_status_extra extra_status)

Thanks for the renaming, but I think we can also rename
drm_connector_status_extra to something a bit more descriptive now?
drm_connector_dp_oob_event? status?

The rest looks good.

Maxime

--25e53fw4vpfchyki
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaigTAQAKCRAnX84Zoj2+
dnv2AX9le3hz+Lu8gxYvgEXc1sDIBCPM1bh/zkVwBN3wZ9THVMA3l8RMscsHED+I
ZdjXquUBeQESub4sfU2kH0nggZa7VB2wC1SqcPxTrCSdEwKVl5n4RlSMJ/F47hOK
i6kZa+CMlQ==
=wSKV
-----END PGP SIGNATURE-----

--25e53fw4vpfchyki--
