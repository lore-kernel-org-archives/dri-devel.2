Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84706CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 14:20:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E647C10F27C;
	Thu, 28 May 2026 14:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KMPbH9MC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 774A310F27A
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 14:20:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C81AB6055C;
 Thu, 28 May 2026 14:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB731F00A3A;
 Thu, 28 May 2026 14:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779978039;
 bh=owd3yHcdZZk9kVBZfXXRZcFgZI3DQoqnNBNYxcexvmI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KMPbH9MCmF9mOEsS1NCjDqSBVX6tA37KmiqpwOmyO/6qlDnDJGjM9eP1vfZNhJFDM
 HmWrThGx5s2FaItFKeci91fl4MS1Spz5C0mpVhANv6pMdlmF60GIZplxFhK+8avCL5
 He5wkqagXhCe05KYx1seLWY9nln28qhh+SIrxVFDsgbBeUiz5QSOuYtiPdkg++F+qB
 FNeha83pm0hEZpttwjoEdzekjg2F4anH2Y90qqC2NKQaND/rbQ1Mdm34+ux5V3etnO
 ncTekxVCvE22Npl3kSILz9HFRBNRBTfr7PuPkE0jWs0pY31qkkjAa0hu8ukXjd+THA
 jJfEejhqD0QJA==
Date: Thu, 28 May 2026 16:20:37 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>, 
 Thierry Reding <treding@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tegra: dc: Fix device node reference leak in
 tegra_dc_has_output()
Message-ID: <ahhPH___c7pTjYUZ@orome>
References: <20260128-dc-v1-1-a88205826301@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="y6dsoxirkzmzvozk"
Content-Disposition: inline
In-Reply-To: <20260128-dc-v1-1-a88205826301@gmail.com>
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


--y6dsoxirkzmzvozk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/tegra: dc: Fix device node reference leak in
 tegra_dc_has_output()
MIME-Version: 1.0

On Wed, Jan 28, 2026 at 12:43:10AM +0800, Felix Gu wrote:
> The of_for_each_phandle() macro increments the reference count of the
> device node it iterates over. If the loop exits early, the reference must
> be released manually.
>=20
> In tegra_dc_has_output(), the function returns true immediately when a
> match is found, failing to release the current node's reference.
>=20
> Fix this by adding a call to of_node_put() before returning from the loop.
>=20
> Fixes: c57997bce423 ("drm/tegra: sor: Add Tegra186 support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Sorry for missing this earlier. Applied now, thanks.

Thierry

--y6dsoxirkzmzvozk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYTzIACgkQ3SOs138+
s6GxaRAAjgANXnfe1wgqu6b9m4HuFdaycpwxk4CcV3WwqHprSpxl1qFYVt1ibS7t
VeTme3TXMEQfWtWtjpmZP+v57XEl4GYqJbkwfWxe07IQ8J69VlW9SO1zuD0r2fDf
4Tne3aFpMyzAcnw6xdzwMKss3AG2kZSRCXL8lKStb9ukJBuodwjnCPyr7Rwb9I8R
6sEskI+ZrNxAQYhpO29NRnmMcbpF2ISammOI5BxpLJ3lidf1va0lP5J9C2v+g9Ev
50kAAmX+PmWJK8rVyKvrxVhjVA9fCFglWyGFxXk0Dv5Xe1f4dfPSLpBklKuxi3Xo
HnmFPiyagcl2edZmjzfpfptkrgpEtbqkWR6/K/KmcqVi6DOqNzRaZZO7yaSdKBat
19AggK170KetHSoynu2dFWNtH/z/NIhfEUTgZuZbXaQaaX+rvD0++RgcuzklISr+
6pT8QG8/aKTmuYZtvmOxyDwRGML+gR3LS2HkazV2c5JriN0xsZsZjWgt8a7NfVdv
UZajs6ifGkCtSa6zN8hiDeLw1yNBj1MNNb5f1qSnY0/jlNsnAZAxb1E8zE5fV4TI
9GGF3GZJzq6ILu2BIJ8cEWI3VTUbDEHD/eb8SJjt7hedRqU6fv/kgZNvDMA4cX8z
a+tVDxRXRhsxjbQhPh0z/HitFPVSe5JTHJ4mlJ2HniKMEuuXqcA=
=2DYb
-----END PGP SIGNATURE-----

--y6dsoxirkzmzvozk--
