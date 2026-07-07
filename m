Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E77C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2085210E487;
	Tue,  7 Jul 2026 11:23:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BQemc0Hc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1CBB10E487
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:23:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBC4E6001D;
 Tue,  7 Jul 2026 11:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097931F000E9;
 Tue,  7 Jul 2026 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783423409;
 bh=afXSRg97etRkliDeKDwVvpVp5Xi6PLbgojXLrd7azl4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BQemc0Hcb7z76zOw4HQNzmV6OuUkLkYz3nAJOGTBVjD4CmPGM3a0a/v3yzIuTK1hv
 lHLF9SfroTOJXeVstYsTrw/yQFMbAaGa/ZulojRZGrEFkyjGzefPQ1jkFXOEl4YTqb
 r5VAb2xnTwZ+UxS1ruz0aXbAl0hOqxVSTt35l7AzGw9u+4dHfV6MILwLe0R0kFc94X
 B/CX/nf79hr5EIXnBQGy3Z2wHZi4D4sAEizpzQqeXSfvmEBIHhOWBAeY72MnufhuTH
 Cjge+N7xXFeno1f7PjTIK8LuSKFquj46J1tH1w3gan9L/dkw0lxx12V85Oa0RdeTeA
 Bjlx97QCa+u8g==
Date: Tue, 7 Jul 2026 13:23:25 +0200
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
Subject: Re: [PATCH v8 09/39] drm/display: hdmi-state-helper: Add fallback
 TMDS rate validation
Message-ID: <20260707-venomous-helpful-magpie-b2962b@penduick>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-9-d79890d00b6a@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="xqdhmpvohpfwe23c"
Content-Disposition: inline
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-9-d79890d00b6a@collabora.com>
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


--xqdhmpvohpfwe23c
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 09/39] drm/display: hdmi-state-helper: Add fallback
 TMDS rate validation
MIME-Version: 1.0

Hi,

On Thu, Jul 02, 2026 at 05:46:22PM +0300, Cristian Ciocaltea wrote:
> Validate the computed TMDS character rate against
> connector->hdmi.max_tmds_char_rate when no driver-specific
> tmds_char_rate_valid() hook is provided.
>=20
> This gives HDMI connectors a common fallback for rejecting modes whose
> TMDS character rate exceeds the connector limit, while still allowing
> drivers with custom validation requirements to implement their own
> tmds_char_rate_valid() callback.
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index ce17eeefc2da..db76699093e8 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -566,6 +566,9 @@ hdmi_clock_valid(const struct drm_connector *connecto=
r,
>  		status =3D funcs->tmds_char_rate_valid(connector, mode, clock);
>  		if (status !=3D MODE_OK)
>  			return status;
> +	} else if (connector->hdmi.max_tmds_char_rate) {
> +		if (clock > connector->hdmi.max_tmds_char_rate)
> +			return MODE_CLOCK_HIGH;

I think we should handle this the same way we do for
info->max_tmds_clock: if it's set, we always check that before calling
the driver.

It reduces the boilerplate in drivers, and it's always a relevant check
anyway.

Maxime

--xqdhmpvohpfwe23c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCakzhnwAKCRAnX84Zoj2+
dlQUAYDUyaRz2CLMNtPg+Ete4u3K2eX5wKEVc3xRNSnTNqYt+QTr77szt9RzsUj9
EqW9z60BfiKLufcvycQ8bIdbCUrO6y0nFPZeaJoYxyommDmZDGb1cLCKCrsLpmQX
Q2l28KHXkA==
=ruW9
-----END PGP SIGNATURE-----

--xqdhmpvohpfwe23c--
