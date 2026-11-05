Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1EF60A2621
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCiFUSzS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6A210E2ED;
	Thu,  5 Nov 2026 15:51:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFC2410E2ED
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 15:51:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BE23A4227B;
 Thu,  5 Nov 2026 15:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA3D1F0093A;
 Thu,  5 Nov 2026 15:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793893908;
 bh=yW5Rri0/xouoNsLJNVbYSyO17syEQzUkfzWZkS+25ls=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RCiFUSzSSfyP+gIvp4+OW8TUa1kz0fktak6quFU6YBruJn8wlGpdRZUcwQrB+lndk
 kn9xSO866242JswpZmGavaL1nA3fK6AUhEZqSAUiOJ+PtspZJDczIATnMSAeFDoR2P
 d3UZq/CZHbbSHy5XwuHAwZ2IAj1hpEYwDy9mT1M2pfrK99CVTmSK0b/FRXz7qhyAVy
 eUSLnTw3ALqhyEfI5ATlw9XsK1vmK9OwlEJUHutRNwB3K0a5MGwiM4UPbiqovuYqRm
 y9xLwI/+X++ogg+dYFYqKfQ87FfYR0yTwePtiCFNfBUHuVOb2VTPSctUFGtDvwNVQL
 N2TLiXkKNtwoA==
Date: Thu, 5 Nov 2026 16:51:46 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, 
 Jonathan Hunter <jonathanh@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH RESEND 53/83] drm/tegra: Switch to
 drm_mode_config_create_initial_state
Message-ID: <auyjMrCi8trUahdB@orome>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-53-1f58d1e33380@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7zxtqfr7iy6ea5vf"
Content-Disposition: inline
In-Reply-To: <20261105-drm-no-more-config-reset-v1-53-1f58d1e33380@kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--7zxtqfr7iy6ea5vf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND 53/83] drm/tegra: Switch to
 drm_mode_config_create_initial_state
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:30:02PM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: Thierry Reding <thierry.reding@kernel.org>
> Cc: linux-tegra@vger.kernel.org
> ---
>  drivers/gpu/drm/tegra/drm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

I'd have to check more closely since it's been a while, but I think we
might depend on the reset hooks getting called during probe.

Looking at the implementation of drm_mode_config_create_initial_state(),
it ends up calling drm_mode_config_connector_create_state(), which
silently exists if the connector doesn't implement atomic_create_state,
which none of the Tegra connectors do, so wouldn't that lead to a NULL
pointer dereference at some point?

Thierry

--7zxtqfr7iy6ea5vf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrspg8ACgkQ3SOs138+
s6Edjg//T5Q+3ZilA1THhY9qcdUxRBdfbBoYoWC89LpYiTfrOtkFud2oA78ftqLL
vG01Xwma6JVVZNdnn44IZL73JRsUWJ+PVrDkHbbL/rwIZQgdPFWNms/klhES6Rzz
J/sXBXrWf6I81TftZh8YT9kwt4bi0sdH5+vuEakuUGRjf5IYiKduF0w0NIpDzGMi
bOuQMFYC0V4aSj7H8mysU0T7RWokPF5hhx8OMXxc7f/j9DqG31Y2Q9zxTTHTyKtp
LLSRtSPhEsaASIPSMddsoqACPuQZbfp/tXr1nrrOwAG/2mFqZJ4DqKssOlVXxRBV
vJe8DQnEQ5LmNaL1TrFYj/ARG3shuY1FuIkT+vnNyILkiwbml8d/sujqnia0yIvW
yQRD4LZjrLkR97vSrJyjhuGol+MkcSEyctvlSw2SGOMseDPlVE3+HCGSRzx5M1sf
1+F1F+QYzMZ/PTivO4s0VH9ObxNlEnwnhjCIK5pa4xguLnsiKmoxxWMpYtCjTT5r
VaszbpKkg7N9XoPHCgNy18wREn6NPlONLAi723bSqvYkk9XjdIb/qlKRwDHCshQM
o/5D8Y3/S0kfEop4OtmrKR7q7CwcPWiRx0jKsfj1KpV0xdVLrHtJhsl5+W/JtpZx
+kISRoLODNn2AbHnNyxVtTl559iJh2K+X5gOyReOnnetot8ZWns=
=d0BZ
-----END PGP SIGNATURE-----

--7zxtqfr7iy6ea5vf--
