Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60869C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE01E10EDFD;
	Tue,  7 Jul 2026 15:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aKaCWfWY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8772910EDFE
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:36:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DE4243A49;
 Tue,  7 Jul 2026 15:36:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D43F81F000E9;
 Tue,  7 Jul 2026 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438564;
 bh=x785U4hGf4t7GOqLyuTFzRX+R9J/H44/NLYC184utQo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=aKaCWfWYJ5JEaok7ENp7t2mSK0Cz9whSR1F7bpRfWa2GGKbp9nqlEycT07VHtVsFl
 trVPf03vEBzlxjiNc1MDTRySb5OvWnEtH+k5s+G/VgXoI2EK9lLtd96Tb9AfDbN9NA
 g+WTTgqMAQg0wNK/9a5jHgGWppVzpxsDs4XZyo87QeFpfI4dJgWStZot5pM7u1RE8k
 IrLrQOx5L9YTTx3tjv4sPwNCYg5IVS7/w/8ySkXKIrvrbsPyfCZFzu1ZHbeRJ0ltd0
 54kt6Y0c4ziOgihL57GwWNji4+qs1KzIPEeZ1qbwzv6kFA4IhH7JH+rClsuP+sqIc1
 iR2iS1PIw0PUQ==
Date: Tue, 7 Jul 2026 17:36:02 +0200
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
Subject: Re: [PATCH v8 31/39] drm/vc4: hdmi: Convert to common SCDC
 scrambling infrastructure
Message-ID: <20260707-jade-wapiti-of-reverence-ad31b6@houat>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-31-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="qh2qpyce2k5iwgvq"
Content-Disposition: inline
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-31-d79890d00b6a@collabora.com>
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


--qh2qpyce2k5iwgvq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 31/39] drm/vc4: hdmi: Convert to common SCDC
 scrambling infrastructure
MIME-Version: 1.0

Hi,

On Thu, Jul 02, 2026 at 05:46:44PM +0300, Cristian Ciocaltea wrote:
> @@ -416,10 +281,11 @@ static int vc4_hdmi_connector_detect_ctx(struct drm=
_connector *connector,
>  			status =3D connector_status_connected;
>  	}
>
> -	vc4_hdmi_handle_hotplug(vc4_hdmi, ctx, status);
> +	ret =3D drm_atomic_helper_connector_hdmi_hotplug(connector, status, ctx=
);
> +
>  	pm_runtime_put(&vc4_hdmi->pdev->dev);
>
> -	return status;
> +	return ret =3D=3D -EDEADLK ? ret : status;
>  }

This looks like a change that should have its own patch and explanation.


> @@ -778,32 +658,14 @@ static int vc4_hdmi_write_spd_infoframe(struct drm_=
connector *connector,
>  					buffer, len);
>  }
> =20
> -#define SCRAMBLING_POLLING_DELAY_MS	1000
> -
> -static void vc4_hdmi_enable_scrambling(struct drm_encoder *encoder)
> +static int vc4_hdmi_scrambler_enable(struct drm_connector *connector)
>  {
> -	struct vc4_hdmi *vc4_hdmi =3D encoder_to_vc4_hdmi(encoder);
> -	struct drm_connector *connector =3D &vc4_hdmi->connector;
> -	struct drm_device *drm =3D connector->dev;

If you don't remove this line....

> -	const struct drm_display_mode *mode =3D &vc4_hdmi->saved_adjusted_mode;
> +	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
>  	unsigned long flags;
>  	int idx;
> =20
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi_supports_scrambling(vc4_hdmi))
> -		return;
> -
> -	if (!drm_hdmi_mode_needs_scrambling(mode,
> -					    vc4_hdmi->output_bpc,
> -					    vc4_hdmi->output_format))
> -		return;
> -
> -	if (!drm_dev_enter(drm, &idx))

Then you don't need to change this one either

[...]

> -		return;
> -
> -	drm_scdc_set_high_tmds_clock_ratio(connector, true);
> -	drm_scdc_set_scrambling(connector, true);
> +	if (!drm_dev_enter(connector->dev, &idx))
> +		return -ENODEV;
>
>  	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
>  	HDMI_WRITE(HDMI_SCRAMBLER_CTL, HDMI_READ(HDMI_SCRAMBLER_CTL) |

> @@ -812,59 +674,26 @@ static void vc4_hdmi_enable_scrambling(struct drm_e=
ncoder *encoder)
> =20
>  	drm_dev_exit(idx);
> =20
> -	vc4_hdmi->scdc_enabled =3D true;
> -
> -	queue_delayed_work(system_percpu_wq, &vc4_hdmi->scrambling_work,
> -			   msecs_to_jiffies(SCRAMBLING_POLLING_DELAY_MS));
> +	return 0;
>  }
> =20
> -static void vc4_hdmi_disable_scrambling(struct drm_encoder *encoder)
> +static int vc4_hdmi_scrambler_disable(struct drm_connector *connector)
>  {
> -	struct vc4_hdmi *vc4_hdmi =3D encoder_to_vc4_hdmi(encoder);
> -	struct drm_connector *connector =3D &vc4_hdmi->connector;
> -	struct drm_device *drm =3D connector->dev;
> +	struct vc4_hdmi *vc4_hdmi =3D connector_to_vc4_hdmi(connector);
>  	unsigned long flags;
>  	int idx;
> =20
> -	lockdep_assert_held(&vc4_hdmi->mutex);
> -
> -	if (!vc4_hdmi->scdc_enabled)
> -		return;
> -
> -	vc4_hdmi->scdc_enabled =3D false;
> -
> -	if (delayed_work_pending(&vc4_hdmi->scrambling_work))
> -		cancel_delayed_work_sync(&vc4_hdmi->scrambling_work);
> -
> -	if (!drm_dev_enter(drm, &idx))
> -		return;
> +	if (!drm_dev_enter(connector->dev, &idx))

Ditto

Maxime

--qh2qpyce2k5iwgvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCak0c4QAKCRAnX84Zoj2+
dnJlAX0YfVV+d4ScVr1xy6mVtKtaV6ALFFFnpPrs5zvBqSQA3MnmVbCUO8RxoxUx
6vi0I04BgNpvDXYzoCqcZbJ8g9Dzbk7zABoM27ZEdR7FTZGpG+FQnkYaqJvbHhh6
WVAPcSFdvQ==
=AcaK
-----END PGP SIGNATURE-----

--qh2qpyce2k5iwgvq--
