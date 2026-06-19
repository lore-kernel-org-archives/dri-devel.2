Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C0ACD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:01:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59DC310F612;
	Fri, 19 Jun 2026 14:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fPMsuA12";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F387910F612
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 14:01:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26300601E3;
 Fri, 19 Jun 2026 14:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8041F00A3A;
 Fri, 19 Jun 2026 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781877710;
 bh=L3w5DFmo5LWBF/MmINv32YYzLvzXSqsQ7GWh271tmlU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=fPMsuA12Y32h107pM3faOHT7T70MDyIZOZbqXEpcSfY1nbfwAszB990E+asjUPJgw
 FyKAH3JLnjqDswXDUCcIwgNd+OmJ5aRKBCKTPuF8ZTvNqlao0/Zj8VS6CDgf28dnXb
 hHHZOTSRzl0HAY59FDB+nkNN+vEIE1347gD5VQB79jgzBX8OCrAkYwn0hl0rJngJnZ
 jQesCMI4yK5Roex1d2YNwNOnOBx3hBOg+khJgCLJxbbYhImndcjpo4X/CYx2k6O1Qp
 KZBmrlxlYs2f2sILIiXl6KhMTZj1GoyVNy6A1c4h8J/Z/1gYSrGOoXf68k57b3g/X+
 TW1AHGk90CtNA==
Date: Fri, 19 Jun 2026 16:01:48 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v2 1/2] drm/display: hdmi: Only allow BPC values of 8,
 10, 12 and 16
Message-ID: <20260619-shapeless-proficient-corgi-4cdeb1@houat>
References: <20260618-hdmi-max-bpc-fix-v2-0-7b67f489b0cc@collabora.com>
 <20260618-hdmi-max-bpc-fix-v2-1-7b67f489b0cc@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="lchwn5gpqwej4pby"
Content-Disposition: inline
In-Reply-To: <20260618-hdmi-max-bpc-fix-v2-1-7b67f489b0cc@collabora.com>
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


--lchwn5gpqwej4pby
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/2] drm/display: hdmi: Only allow BPC values of 8,
 10, 12 and 16
MIME-Version: 1.0

Hi Nicolas,

On Thu, Jun 18, 2026 at 08:54:23PM +0200, Nicolas Frattaroli wrote:
> As per the comment in sink_supports_format_bpc(), CTA-861-F defines that
> only bits-per-channel values of 8, 10, 12 and 16 are allowed for HDMI.
> Allowing more than this has surprising consequences for the atomic check
> phase. The HDMI state helpers may accidentally conclude that a sink
> supports 11bpc if a caller asks for it.
>=20
> Fix this by exiting early if the bpc value doesn't match one of those
> given in the standard.
>=20
> Fixes: 26ff1c38fc29 ("drm/connector: hdmi: Compute bpc and format automat=
ically")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index ce17eeefc2da..0bf6102244f7 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -420,6 +420,16 @@ sink_supports_format_bpc(const struct drm_connector =
*connector,
>  		return false;
>  	}
> =20
> +	switch (bpc) {
> +	case 8:
> +	case 10:
> +	case 12:
> +	case 16:
> +		break;
> +	default:
> +		return false;
> +	}
> +

Sorry for not noticing in your first version, but I'd move this before
the VIC 1 check, and would add a comment to refer to the spec (possibly
by splitting the comment already there for the VIC 1 check).

We should also log debug message on failure like we do for every other
rejection path.

Maxime

--lchwn5gpqwej4pby
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajVLzAAKCRAnX84Zoj2+
dlpLAYD01pN0pz6tGuaz2wd0mxFQ3rHcyXxXDjpx0LVqb6F5FPiYjRKlM9DMzMhr
wlBanTUBf36bd0rutP5lNFgPWTemzh9AGcrxCgHDCnKk3E3Nw6AtNAVEwNBaL6PR
yh1F/cqykw==
=oOlc
-----END PGP SIGNATURE-----

--lchwn5gpqwej4pby--
