Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEDFDCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 14:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4175610F235;
	Thu, 28 May 2026 14:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jn8ao2vy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD6910F234
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:06:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 26AA66022B;
 Thu, 28 May 2026 14:06:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4951B1F00A3A;
 Thu, 28 May 2026 14:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779977202;
 bh=kiyC2moGcmtgdeNSaFo56pMgH3zNTMgObzQG6WFoEcI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Jn8ao2vyPizwcJF1veAq5VPirITuFbJb/f7gn6kc3nZmkA/vCa/Y1moRMs5c44JXU
 wwl238RW967IcqM7oxGfwCrrBogHogFwNb35s1LHa4wAFzGN91yOeln5E0beC9TDie
 Q3yqT5oEEph165diwVTH+S0jqJbAhevXFRJ46gzDsniuLAIXlwhL4Pea7K30pafAhs
 nedNVcZbboJ1ub8Xwp+DbTPxTMhZsF5UmKHc5w8HkLolaE8PYGH6h4TLmJLS4gGsmf
 ZRZpTUvhiXvjXQ7l6eO3/HkxTs30nLDDqBGyCWdY7DWtKE1sfjCxZu9oq40SJKSY53
 TJKBd8lhcWvYg==
Date: Thu, 28 May 2026 16:06:40 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: rgb: Fix use-after-free and leak in
 tegra_dc_rgb_probe()
Message-ID: <ahhLDKD2nI_skQ7B@orome>
References: <20260407084629.283151-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yljhe77scuhzfyua"
Content-Disposition: inline
In-Reply-To: <20260407084629.283151-1-vulab@iscas.ac.cn>
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


--yljhe77scuhzfyua
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: rgb: Fix use-after-free and leak in
 tegra_dc_rgb_probe()
MIME-Version: 1.0

On Tue, Apr 07, 2026 at 08:46:29AM +0000, Wentao Liang wrote:
> Move the of_device_is_available() check before devm_add_action_or_reset()
> to avoid using np after it may have been freed (if the action registration
> fails). Also release np immediately when the device is not available to
> prevent a reference leak.
>=20
> Fixes: 3c3642335065 ("drm/tegra: rgb: Fix the unbound reference count")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/tegra/rgb.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> index ff5a749710db..d7586fc820ce 100644
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c
> @@ -215,13 +215,15 @@ int tegra_dc_rgb_probe(struct tegra_dc *dc)
>  	if (!np)
>  		return -ENODEV;
> =20
> +	if (!of_device_is_available(np)) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
>  	err =3D devm_add_action_or_reset(dc->dev, tegra_dc_of_node_put, np);
>  	if (err < 0)
>  		return err;
> =20
> -	if (!of_device_is_available(np))
> -		return -ENODEV;
> -

I don't see how this achieves anything. If the action registration
fails, devm_add_action_or_reset() executes the action (that's the
"or_reset" part), so that takes care of the leak. Similarly, when things
fail, np is not going to be used anymore since we immediately return, so
there's no use-after-free either.

Thierry

--yljhe77scuhzfyua
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYS/AACgkQ3SOs138+
s6G16Q/7BrRolqQi2OPTpeyyk6ZZ2yv3zPoPbb+nsLxWsiwD/KifNFlr6LC9Yymu
rbVxDI2hkYfTclmvWuvJ9BQs0Nvusv1CXWcRY1j0zYIpZWJR2nYzSvAMwdxapH/b
F2AtXFQhuooInpwK8szOwS1EUQWxbuKr9bfCNoNuaCDGEunIf08TnZryao53v73x
qqlUyXnvVIQ+wwDYpD1mXNbPKRDvoh8GZjAlzBPUmsNN+6pYbPLDNM0KV0qR4+KS
M1tfCJC4AMALRUnVVVuYOazvRVROxaOFx+0sHYZxN8WNMcGEveb47FckLLkqivl6
qiQP1lhaQDAdan0ZUtoAy1OYjQbSBxRIr2kFQCmxRattoR0kxg9Co37n1O9izlNE
JwVl202cHPrJfPIylQaw6T2s06ljaz2bzR0ZMprwpjCnstwGwPc3mIkx4mv7+Zeu
SFM3n9jGLGgWZuHtSW34DRhVwI/3IJEeyokF6wjm1DeU4T/q1GSWawy2p2PRt6rh
iwOj5bGufEW503CqWUA02H26bNx4rxg0b/FpFPcUu2Gp3AN8UBmxcG7fQcl1hNB/
2h6E0/BROVrxBfkpd7Vu0LLZjjCK2hfuwoMhL8sWqzJBVzjIABqt9TBGLs3vqMc7
iAqDwdLdZw23vNzTxWpByCjT4voB/1M8bS+4f1ba3k4WX5mQX4I=
=gLnO
-----END PGP SIGNATURE-----

--yljhe77scuhzfyua--
