Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97755CD98F6
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 06:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B8310E4AA;
	Mon, 22 Jun 2026 06:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jqC65v2k";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEF3A10E4AA
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 06:49:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E3DDF6001A;
 Mon, 22 Jun 2026 06:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140481F000E9;
 Mon, 22 Jun 2026 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782110962;
 bh=YZQ8yptCt1lq6NlPILbwAJXHuZqPr53lP1nmexhIeps=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=jqC65v2kSfalprkM/QEu6WCz9T+4cKA3S4sf9oWnxV6jK3M6yhMiSWeonmqxyX5aC
 VCCxu84+0XOFIYqBo9NYYy34s5wUNlStPNjWx1rJSBNmCodAdjFB/euzaobvxXi8f8
 6KrXIjRP3Adm3PDrG6/CKZGYR4+bZMfack/gI3TxkYn6pHmUKBOR5YwNFMBwF1Nz7d
 vpjyNFM/unx/6MXPdM9hzpvz1MiyLaJerVI5gLtvuRRjA1FK0I4S9aDqqEydH4nRMz
 S8B3fcIC0qk2+UoNZq2pEwYFNXzMsQHRHRo9Mchf5ZLHCDroDkr/prkD3R1b+z1Mnn
 yeo6TeCl6J04Q==
Date: Mon, 22 Jun 2026 08:49:19 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: Fix a strange error handling path
Message-ID: <ajjaW_fGdHWPZr9K@orome>
References: <308ea09281bd0b3fb0ec7e90e23012c0783f373c.1781983379.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bwk7zbxn2pnhgwkg"
Content-Disposition: inline
In-Reply-To: <308ea09281bd0b3fb0ec7e90e23012c0783f373c.1781983379.git.christophe.jaillet@wanadoo.fr>
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


--bwk7zbxn2pnhgwkg
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: Fix a strange error handling path
MIME-Version: 1.0

On Sat, Jun 20, 2026 at 09:23:14PM +0200, Christophe JAILLET wrote:
> The resource freed at the 'put_aux' label is "sor->aux->dev".
> However, this resource is taken after devm_tegra_pmc_get(), so there is no
> point to release it in this error handling path.
>=20
> This is harmless because put_device() will be called with a NULL pointer,
> but this is confusing.
>=20
> So, fix the logic and return directly.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
>=20
> This is not a bug, so no need for a Fixes tag.
> If needed anyway, it was introduced by commit e68c4244136b ("drm/tegra:
> Explicitly specify PMC instance to use")
> ---
>  drivers/gpu/drm/tegra/sor.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Good catch! Looks like I used the put_aux label without realizing that
sor->aux isn't acquired until *after* sor->pmc here.

Thanks for fixing this,
Thierry

--bwk7zbxn2pnhgwkg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmo42usACgkQ3SOs138+
s6GSbA//VUr9ah6aJm5qD5DKf1B6cLsg2AIC61cAOTFggrPwRm11eLgTNgtdv0rd
UZz2PFAt1YzKNlA/vIM1W1Z1Zjf3r2uXnBMgFmS1CbIVf6zPt0webV1kIUhtrPNf
Ln/WoJGJocjvAujFvOXKzFL7OE8R8TBKuGCUAHr96+XIfAABlBuuk4X8sxoiO0WD
DW8RNYP+e2UaxOZhJcJt4jVaalfLMS2o6KdOP37cSECDIVoCMUXQNqM7Hx7kcN7+
RQq9mvRe4E5zJiP7cOkCwQgjRocFbBbuqkFYcTKhKmvYshZb4hKwjtIyQ2SrVbc5
H0TWlYGEX9jQAApPn96Xm90nieYPXSaz3+vYwN+PjTACQMLPoJvd54K9JpshtyAs
wX4zIRkheTc5eFjv4lNUDsJYw47ivzEnIj3+DTRsmK8JDwY8XZw3Wdrow5c7HLNT
JvH6HSfUG+mf6AMeb5fp53ztJyRKHwd4g+iDzAR6kxRf+NDL5ZhX6tAhRCN2Vv7w
sVMKvoC67uReGFQXvLiONTYtl1IyDSaXyDn+xwEl4XR3juudFwW7LOiwEvySHeye
BVvFPauNP8QAYKwp6CsCituDXHHsscG1U9SRTh/rEJcxyiagTDJ+DTf4Pr95UxrZ
AbDVQDrueHk3MZntlVFRagAu1XEeLUb8AeB5GCfLKB7z0xbUlrc=
=kXhu
-----END PGP SIGNATURE-----

--bwk7zbxn2pnhgwkg--
