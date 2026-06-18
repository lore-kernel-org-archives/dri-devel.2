Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78639CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:45:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C82CA10F35D;
	Thu, 18 Jun 2026 15:45:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J5wTG+rp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3086610F376
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 15:45:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 06C3A43F0A;
 Thu, 18 Jun 2026 15:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F211F00A3A;
 Thu, 18 Jun 2026 15:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781797547;
 bh=hpG0tX0qNZMLiDxqSN/SJYcJuFVULIX9hGpZpr3KQoU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J5wTG+rpdbPMlMEX7BJWdlv+rdenjOqlaXbikuW/s1128ikyn7TEsp24n58dhHLrY
 1xdPKFqK/b/NJ/ZrisoKOLwXejwnAqsuzaC93w7rccfZ79ZKPlvme5SuJ8UBseHFC2
 l600JfZPwyMwKHsZBK1HkcpbmW1y1ruVB+zl7STGjDe8fAslZMPwfxfKYe4Vi8T0fM
 YLIUefFAtfwG3BTddgfY48DHiJhw1gtd607E8WdZxt+vRpbIggcHNomcXrN0y9g1CF
 aFwF/097BrguGU5xSuONu/StZRArauip1Jsnd9A7MHYmyBRAIRuvhTi3w/sKpFgzEa
 EY8kJd24ZH85A==
Date: Thu, 18 Jun 2026 17:45:45 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH 2/2] drm/display: hdmi: Round odd max_bpc down to even
 numbers
Message-ID: <20260618-ultramarine-crane-of-prestige-af6b75@houat>
References: <20260608-hdmi-max-bpc-fix-v1-0-6e8dcebc7274@collabora.com>
 <20260608-hdmi-max-bpc-fix-v1-2-6e8dcebc7274@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="k7u5mip3hj27ogmo"
Content-Disposition: inline
In-Reply-To: <20260608-hdmi-max-bpc-fix-v1-2-6e8dcebc7274@collabora.com>
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


--k7u5mip3hj27ogmo
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] drm/display: hdmi: Round odd max_bpc down to even
 numbers
MIME-Version: 1.0

On Mon, Jun 08, 2026 at 01:19:08PM +0200, Nicolas Frattaroli wrote:
> The HDMI state helpers will count down from the max bpc to 8 in steps of
> 2, trying each value as a possible output bpc. This goes awry if max bpc
> is restricted by userspace to an odd number with the "max bpc" connector
> property.
>=20
> Prevent this, without introducing any additional bpc format trial steps,
> by simply subtracting max_bpc modulo 2 from max_bpc as the starting
> point for the for loop.
>=20
> Additionally, add a KUnit test to validate the handling of this.
>=20
> Fixes: 26ff1c38fc29 ("drm/connector: hdmi: Compute bpc and format automat=
ically")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  2 +-
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 71 ++++++++++++++++=
++++++
>  2 files changed, 72 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 8303475ec021..9fbf88054ad8 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -648,7 +648,7 @@ hdmi_compute_format_bpc(const struct drm_connector *c=
onnector,
>  	unsigned int bpc;
>  	int ret;
> =20
> -	for (bpc =3D max_bpc; bpc >=3D 8; bpc -=3D 2) {
> +	for (bpc =3D max_bpc - max_bpc % 2; bpc >=3D 8; bpc -=3D 2) {

bpc =3D round_down(max_bpc, 2) (or rounddown) would be more readable here.

Looks good otherwise, once fixed
Reviewed-by: Maxime Ripard <mripard@kernel.org>

Maxime

--k7u5mip3hj27ogmo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCajQSqQAKCRAnX84Zoj2+
dp4ZAYCKGeCdY8yI9mS0X6IPjxZEjZzMGCuuBmUWULt4Np5RFCUrLDSPSvF9TzwW
zHfRbM0BgOKS2ewsvDXz6Q5i8Lr4RJqSScFJRt17T2NGOo0Ls7dW65wlIAG3/ieX
urpqWeFytg==
=ouQu
-----END PGP SIGNATURE-----

--k7u5mip3hj27ogmo--
