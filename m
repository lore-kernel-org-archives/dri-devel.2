Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1A4606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhgxR9Wo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88D3610E32C;
	Tue, 17 Nov 2026 11:24:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987A410E32C
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 11:24:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B5E4601BE;
 Tue, 17 Nov 2026 11:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1B91F000C4;
 Tue, 17 Nov 2026 11:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794914692;
 bh=vWOxMHWlcWtp27VVdwB8K8C+YGb+xa1iSkIZnmlgfTA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=DhgxR9Wo+dUuqkYWxNm8rH7ej9OWfhE/Xv8DnoobJmZZLPkYsdBJo5fCkCZJFSl4t
 gwGGW5A9I9pO32K4YLEJ21S1X1QscsjDvk9tYDpyVp11eavqV0M+giyonO4WQ9luHS
 5AElNQ21OYGOL+Scg06kyjBswlpqwU2uTVobkQZKp/xMBI0CqlAb18JPvqRawXRLFp
 frySI+jf1vEbDNQ7Y7x75M3uceernjmsj2cRQuY0uX1RHS+OYO9MOFD75qofuEO9AU
 UUoIry2Wm88kf3dDuVi67A1d0DM7gEyQwu0X5yMLyoIdz5Getfbw0SIvcyO35O7Rh8
 sTzKdEBXgCMLQ==
Date: Tue, 17 Nov 2026 12:24:49 +0100
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
Message-ID: <avw5LNHICh6OHpqs@orome>
References: <20261105-drm-no-more-config-reset-v1-0-1f58d1e33380@kernel.org>
 <20261105-drm-no-more-config-reset-v1-53-1f58d1e33380@kernel.org>
 <auyjMrCi8trUahdB@orome> <avNBTIciv6QlEp9a@houat>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zcuoxflydzito32u"
Content-Disposition: inline
In-Reply-To: <avNBTIciv6QlEp9a@houat>
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--zcuoxflydzito32u
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RESEND 53/83] drm/tegra: Switch to
 drm_mode_config_create_initial_state
MIME-Version: 1.0

On Tue, Nov 10, 2026 at 05:10:01PM +0100, Maxime Ripard wrote:
> Hi Thierry,
>=20
> On Thu, Nov 05, 2026 at 04:51:46PM +0100, Thierry Reding wrote:
> > On Thu, Nov 05, 2026 at 04:30:02PM +0100, Maxime Ripard wrote:
> > > drm_mode_config_reset() has a dual role: it creates the initial KMS
> > > state at probe time, and resets hardware and software state during
> > > suspend/resume cycles.
> > >=20
> > > Since the two roles need different behaviors (notably for objects like
> > > drm_private_obj that must persist across suspend/resume),
> > > drm_mode_config_create_initial_state() was introduced to handle only
> > > the initial state creation at probe time.
> > >=20
> > > Switch to drm_mode_config_create_initial_state().
> > >=20
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > ---
> > > Cc: Jonathan Hunter <jonathanh@nvidia.com>
> > > Cc: Mikko Perttunen <mperttunen@nvidia.com>
> > > Cc: Thierry Reding <thierry.reding@kernel.org>
> > > Cc: linux-tegra@vger.kernel.org
> > > ---
> > >  drivers/gpu/drm/tegra/drm.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > I'd have to check more closely since it's been a while, but I think we
> > might depend on the reset hooks getting called during probe.
> >=20
> > Looking at the implementation of drm_mode_config_create_initial_state(),
> > it ends up calling drm_mode_config_connector_create_state(), which
> > silently exists if the connector doesn't implement atomic_create_state,
> > which none of the Tegra connectors do, so wouldn't that lead to a NULL
> > pointer dereference at some point?
>=20
> AFAIK, all tegra connectors have now been converted to
> atomic_create_state instead of reset (commits c5c0e4821938 and
> f808d9f8e5a3 in drm-misc-next) so it shouldn't have any reset specific
> behaviour at all and the transition to
> drm_mode_config_create_initial_state().
>=20
> Am I missing something?

Ah, I don't think they were in linux-next (which is what I was looking
at) yet when I replied. Looks like it should be fine now:

Acked-by: Thierry Reding <treding@nvidia.com>

--zcuoxflydzito32u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmr8OYEACgkQ3SOs138+
s6HwgQ/9F/dU5Fwj1VmRt0XTem4o41tqgkGUsXzETd3U/l9jBb8BRnZCRYtlml/R
oT62Ai/D0zJkNBKKhjlykcGYDf4vTd47uor5P6/VgBHbuAfJBOmsRD944bL6Mi5t
crpiyXqWQGbzFxz+We9vGBbI6KdE6czvrb/jU8SJ2gzWMHltmP3/n++F2FOL3WHf
yAB79ZWQYEXNgoMsC+Q8uvs2KEANEPgjZ9HNLsq4EcP8bqfPFf86DSQn/oe5Fio0
MYrmlYsVm4qGiFHQwNVtage4A6d8djYn2szn/3D3nHvLyj4cGnsxI68XZ5tjSRAc
rhv/pl3QgbatOqJcP4m4aNK8/adgzV+iR0s/tAB4ET3uuyL4NjFtr9rCukIo34Gq
+6okBMrL7D0NDOTV6zgJufjcWYkTmylhWu4EjYYiros9gTzCkpcJH68qkNjN8VLF
dwVB9iz2KOEWyCXny7bbInyp/TyUq2gQRFAYW3XrG4WI4LZFyNO/qUNE63MY9+ut
OjhX3R7XpuSBRHJNEfQEvcbDNoiOiVdyU/MXvu8TrFLUjF5auQ4NEijJ3aLIf58M
XAquAAilfek9lTtxHMkbvdnLwQH8ib1EcctBBx8heJRLytrcwGiWIlejoT0N1JGv
Nsen3WczV/1YgYc6RLUc/fN9URshi5H1zm/WlH559Sk5UDGNMPc=
=tQ8v
-----END PGP SIGNATURE-----

--zcuoxflydzito32u--
