Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45010C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D2F10E491;
	Tue,  7 Jul 2026 11:34:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gdWLrpSd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A69110E491
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:34:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 040B543A88;
 Tue,  7 Jul 2026 11:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690D71F000E9;
 Tue,  7 Jul 2026 11:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783424046;
 bh=sL7dY+pEzujogPZkZ8vNNIvsiQVh8MEzqk7xSFEGLhk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=gdWLrpSdF6PHcul0blfCZC5vEbgvqodNcf5N+wUMIH+WE9ltCmHo/XTQbCvlKiHir
 twky5cvhs9GOSxfOpTBSKRSw/tiD5f6cOqzXabUSGtf1ULVBzUbtPxkH4F7vx71sth
 jIAI15Ki+NH8Pdv3RX0ci4Gj6fkRtVRyTc8YvZsSRCJqknuSwXHKGevaAQLdAQPBFJ
 oEpP/T9henyD1b4kkPkgzlc2YzWqg3SnWXhuzPO4CW3vEBFHYHj/5C6Hy4GU8qDrhs
 kLJciwAMakdGJRsvE6cA1uM1eW0MuogWeb0NZnwQNsKADlLLIkGYVQCcnd+z2oPu62
 92ihaqrxfkscw==
Date: Tue, 7 Jul 2026 13:34:04 +0200
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
Subject: Re: [PATCH v8 11/39] drm/display: hdmi-state-helper: Set HDMI
 scrambling requirement
Message-ID: <20260707-imperial-tuna-of-finesse-ede3bd@penduick>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-11-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="wdvgsce7rl2qft2y"
Content-Disposition: inline
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-11-d79890d00b6a@collabora.com>
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


--wdvgsce7rl2qft2y
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 11/39] drm/display: hdmi-state-helper: Set HDMI
 scrambling requirement
MIME-Version: 1.0

On Thu, Jul 02, 2026 at 05:46:24PM +0300, Cristian Ciocaltea wrote:
> Set drm_connector_hdmi_state.scrambler_needed when the computed TMDS
> character rate exceeds the HDMI 1.3 maximum TMDS character rate.
>=20
> HDMI 2.0 requires scrambling above 340 MHz.  Centralize that clock-based
> requirement in the HDMI state helper so drivers do not need to open-code
> the threshold check.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 69ccfbf123fe..34e48e04d971 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -592,6 +592,7 @@ hdmi_compute_clock(const struct drm_connector *connec=
tor,
>  		return -EINVAL;
> =20
>  	conn_state->hdmi.tmds_char_rate =3D clock;
> +	conn_state->hdmi.scrambler_needed =3D (clock > HDMI_1_3_TMDS_CHAR_RATE_=
MAX_HZ);

I'd add a FIXME/TODO comment that we might want to check
drm_display_info.hdmi.scdc.scrambling.low_rates

With that fixed,
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--wdvgsce7rl2qft2y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakzkKwAKCRAnX84Zoj2+
dmfRAYDkaExzkpf+waVhXctxjhiXK+3I7kKkj6uK/0EC1DlpCxqa5sUOmdPwOpRh
gWTu7SgBfAh2qupQ8L0m6pj6X0K7zPmKCzS5zf0f6KyNXoT8vSXEbf5UGH1iukpG
MlRBPNHUFQ==
=lvbH
-----END PGP SIGNATURE-----

--wdvgsce7rl2qft2y--
