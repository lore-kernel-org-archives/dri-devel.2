Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7903BCD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:47:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8AC710EDF5;
	Thu, 18 Jun 2026 15:47:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C9d4Vyp8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6883610EDF5
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:47:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 14BB840E22;
 Thu, 18 Jun 2026 15:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4175E1F000E9;
 Thu, 18 Jun 2026 15:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781797631;
 bh=SSw/Uhx8aZ7nWt2RmzSWAzAgFrth5Kl5JGysnJhW3XI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=C9d4Vyp8EDWS3pIHLDVbTIDyiYGIG3sGvHYCDpkIuMWJDK/66/DzNupxq9LW/3go0
 IBV5ZX0pAy5OCcHRTOAxedP71jPWw2nUWh8TL8/H41cWqc18C2cvscM4k1UbC7QwLv
 hV3f9VZEYm++VoudgO4FJ7+0DJ0NtvWewwfofbmwBlndDyCAKK91n/dszv+XmL2oKe
 bYIIF9QSt6RtTr+6KzCST2sICKnmvJ2qJmIhb0mFLUXVQCL3PEGX/msVynItnOLjgG
 KABGweet/vWz5biVekPNZt5u8kxd+Kg7h6dVDa8i2k98YMeqZroVoFxdJ1fKah/sT/
 Inrpaeh9iEY6A==
Date: Thu, 18 Jun 2026 17:47:09 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH 1/2] drm/display: hdmi: Only allow BPC values of 8, 10,
 12 and 16
Message-ID: <20260618-lemon-carp-of-acceptance-0ee7de@houat>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
 <20260608-hdmi-max-bpc-fix-v1-1-6e8dcebc7274@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="ilnmesjaemdjcvp2"
Content-Disposition: inline
In-Reply-To: <20260608-hdmi-max-bpc-fix-v1-1-6e8dcebc7274@collabora.com>
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


--ilnmesjaemdjcvp2
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] drm/display: hdmi: Only allow BPC values of 8, 10,
 12 and 16
MIME-Version: 1.0

On Mon, Jun 08, 2026 at 01:19:07PM +0200, Nicolas Frattaroli wrote:
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
> index a331ebdd65af..8303475ec021 100644
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

That might be slightly personal, but I think if (bpc < 8 || bpc > 16 ||
bpc % 2) is more readable

With that fixed
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--ilnmesjaemdjcvp2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajQS/AAKCRAnX84Zoj2+
drq3AYDfG+CjOVuYHiRDSRt/gO6uSSyFE37noQOMaRR7IxKLrdRChpk5ITrgshlv
uANwJTkBgIjSloeYGeP3wAZVO49PWfuWumxJDWYiTrL/ER+pkBSEPhP5Nxmm93WE
kHDomR7YPQ==
=+lyf
-----END PGP SIGNATURE-----

--ilnmesjaemdjcvp2--
