Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942F6CC6B16
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 15:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73A010E0E4;
	Tue, 13 Oct 2026 15:44:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D7010E0E4;
 Tue, 13 Oct 2026 15:44:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61BCF42E9A;
 Tue, 13 Oct 2026 15:44:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47E41F000FF;
 Tue, 13 Oct 2026 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791906277;
 bh=o/DpTvlnWWp99dowUQXU1BLV47DN0YMWpoqq38I7qzM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=I8D9GRAwFmo1rdK/lDmYrdYP1YtZci3aovsdFYF6SlUWAmrRy6mV2wciVLzUMiFEf
 0LFgtUNNx2SIuZBrwH/T1ItrWhdZWqkeC1tBUrlPaxjC0Mr6nxhUvGLOujWy1YLOg4
 9NEbdJY/QRp1sIgZ6Us2XxzCei/qNgx18/UlWVSm3fRMrrKzDeY9HvpWpA3BNBq4bK
 b7OefKLXCbieobbOpN04MxglenF/Xaoj6LcWWvFoJEj2d8LSYZ1347LawCsnbyBeJK
 jumvzfADljgZcIcLRYs1Gx09iTkpCwlhqR+DgQUlNG9p10kBQe3JqbsXncWo2OAW2p
 dSgG+v5dFQZmg==
Date: Tue, 13 Oct 2026 17:44:34 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Aaron Kling <webgeek1234@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/nouveau/tegra: Keep the fuse clock enabled while
 the GPU is powered
Message-ID: <as5Q_Ukc9Ivzpzg0@orome>
References: <20261013145210.103565-1-sashal@kernel.org>
 <20261013145210.103565-3-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rs5rzstks4prssel"
Content-Disposition: inline
In-Reply-To: <20261013145210.103565-3-sashal@kernel.org>
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


--rs5rzstks4prssel
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/3] drm/nouveau/tegra: Keep the fuse clock enabled while
 the GPU is powered
MIME-Version: 1.0

On Tue, Oct 13, 2026 at 10:52:10AM -0400, Sasha Levin wrote:
> Since the GPU on the Jetson TX1 was enabled in commit d1b725476104
> ("arm64: tegra: p2180: Explicitly enable GPU"), nouveau often fails to
> bring up the GM20B. Either BOOT_0 reads back garbage ("unknown chipset
> (5ffefa47)"), or PRI reads of the GPC PLL time out ("MMIO read of
> 00000000 FAULT at 137000 [ TIMEOUT ]"), or the first register reads in
> nvkm_device_ctor() stall until an asynchronous SError. How often depends
> on the board; one board fails on every boot.
>=20
> nouveau powers the GPU up with the fuse clock gated: since commit
> 24a15252ff04 ("soc/tegra: fuse: Add runtime PM support"), the Tegra fuse
> driver only enables that clock around its own fuse reads. NVIDIA's
> downstream nvgpu driver enables the fuse clock along with the other GPU
> clocks whenever the GPU is powered. Do the same: take an optional "fuse"
> clock and keep it enabled from before the GPU rail is turned on until
> after it is turned off.
>=20
> Tested on eight Jetson TX1 devkits, on mainline and on v6.18. Without
> this patch, the GPU failed to come up in 27 of 109 boots; with it, in 11
> of 291, none of them with a garbage BOOT_0. On the board that failed on
> every boot, 38 of 40 boots now succeed. The remaining failures are
> mostly a register read that stalls until an SError; wherever the console
> shows when, nouveau had already finished probing. Such stalls also occur
> without this patch and are a separate problem. The Jetson Nano, which
> shares the Tegra210 GPU node, still works (24 of 24 boots).
>=20
> Fixes: d1b725476104 ("arm64: tegra: p2180: Explicitly enable GPU")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/nouveau/include/nvkm/core/tegra.h  |  1 +
>  drivers/gpu/drm/nouveau/nvkm/engine/device/tegra.c | 13 +++++++++++++
>  2 files changed, 14 insertions(+)

Given the failure rates, I'm almost tempted to say we need to break DT
ABI and consider the FUSE clock to be required, in which case the driver
should use the regular devm_clk_get() instead of the optional variant.

As you said, we probably got away with this for a long time because we
either didn't enabled the GPU by default or because the FUSE clock was
always turned on. Or we might've tested GPU as built-in, in which case
the FUSE clock might have still been on (not disabled after early boot
yet).

Thierry

--rs5rzstks4prssel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrOUeIACgkQ3SOs138+
s6E7Jw//Ra2WC610+ntOAnEJIGZQnFcG+pqpEU+qyfYMtfOhjSe/1LsDl+RjcyWP
L5QyNudF3CgNdrrdIX4GgSiP9GTndRC/HpSlzhiVE+dzC09OIzeBW7+DQhkqE+b5
hrA/50PY72fOmVnVQMh+0hJZCpuLXBXsKACfOxe436YP3KRm5ifKIrDw6ISn1NTL
YwZzwfForf/VA07oeGPYhEiKoQ4aTBnz16Wo3lPO5l3lJySvPR4LHt4TLvOxq9IP
asx5zqy1CGrQ4Y/WLBvY/ken6ftOqLhfj1vwGa9nY8z8LdQVzB7FBn0icnF4YhQy
PPvmUlVYLOS0wr0bZUBkzgMXf8oTa4QTSFgd9RBnowKaFSFTvpyZBsLLaSSngvI8
se1zFuCL+Y24z4ymXkC1G3cWnHBUdWRHEwW8YIXDLmo4BupTwuSaBmoMRI/koO1K
05ZaItgd6Mg+KRGGjdhxtKGDpC+mui3bgaCnI20yJ+c/7sgoge/7yJc6v+l5mEIJ
mXQoJStSjCcFI1otGSomsqYrdhr+GSDdz/F94iA4YBj4mImVgr3elFAYwOD5KCqw
AgrHyC2Ji0/wOC5RIQGsQ5AcSavBD12YN6pLIxUkOQiq9MB4MDqZtpdSx2a2IACw
HQ+iUVypNFyvsry686OpVM1gnyNIYUQtDvOZuCoXfismGNlLwM0=
=3s21
-----END PGP SIGNATURE-----

--rs5rzstks4prssel--
