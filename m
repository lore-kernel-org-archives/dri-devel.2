Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D2CCD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:46:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B739410F1D1;
	Thu, 28 May 2026 13:45:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="arm9cXMv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2793910F1D1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:45:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F49F6054B;
 Thu, 28 May 2026 13:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23FF1F000E9;
 Thu, 28 May 2026 13:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779975957;
 bh=Uq9PfcT9oNnQ9+pZTlegE9YsQku1WA8KL9XtpyGLILE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=arm9cXMvV+O8GtGvyHEejAgBBpEshl3KQG/SwHEWR+K8aC47nftWygGYzVc8HzYtt
 lJ/JKLcn1nut4RuvUhABgQkf/o0pTCJB46sOZYdE8544pke6U1549fmhuzI0rOslmW
 9Y3/0/lu/qkYrtWtMv0j5EUSI4WtwxWiPU684FBkMeoQ3sE/ao7zZKxVZLhXnlOAQ/
 O2KHUopK36qa7z+ZbfZ0IQpos2GG85UrRGkj0RTQlVVXOl+MAXtk/Ly0ODpWHkOMjA
 SmTGLaGqf8vB2KQ4wq//8Uy04bmIfaES1kMd7+5wm/88sAbl8dZClHDk6Gfl9Vnpkw
 hop47aDC69gyg==
Date: Thu, 28 May 2026 15:45:54 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: dri-devel@lists.freedesktop.org, Mikko Perttunen <mperttunen@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3] drm/tegra: tegra_drm.h: fix all uapi kernel-doc
 warnings
Message-ID: <ahhHA-U5LHclxZYJ@orome>
References: <20260427184454.693794-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hrmst3avf3g2aerj"
Content-Disposition: inline
In-Reply-To: <20260427184454.693794-1-rdunlap@infradead.org>
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


--hrmst3avf3g2aerj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] drm/tegra: tegra_drm.h: fix all uapi kernel-doc
 warnings
MIME-Version: 1.0

On Mon, Apr 27, 2026 at 11:44:54AM -0700, Randy Dunlap wrote:
> Add 2 struct member descriptions and convert #define macro constants
> comments to kernel-doc comments to eliminate all kernel-doc warnings:
>=20
> Warning: include/uapi/drm/tegra_drm.h:353 struct member 'cmdbuf' not
>  described in 'drm_tegra_reloc'
> Warning: include/uapi/drm/tegra_drm.h:353 struct member 'target' not
>  described in 'drm_tegra_reloc'
>=20
> Warning: include/uapi/drm/tegra_drm.h:780 This comment starts with '/**',
>  but isn't a kernel-doc comment.
>  * Specify that bit 39 of the patched-in address should be set to switch
> Warning: include/uapi/drm/tegra_drm.h:832 This comment starts with '/**',
>  but isn't a kernel-doc comment.
>  * Execute `words` words of Host1x opcodes specified in the
>  `gather_data_ptr`
> Warning: include/uapi/drm/tegra_drm.h:837 This comment starts with '/**',
>  but isn't a kernel-doc comment.
>  * Wait for a syncpoint to reach a value before continuing with further
> Warning: include/uapi/drm/tegra_drm.h:842 This comment starts with '/**',
>  but isn't a kernel-doc comment.
>  * Wait for a syncpoint to reach a value before continuing with further
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2: add kernel-doc comments for #define constants (thanks, Mikko)
> v3: rebase & resend
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Mikko Perttunen <mperttunen@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
>=20
>  include/uapi/drm/tegra_drm.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Applied, thanks.

Thierry

--hrmst3avf3g2aerj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYRxAACgkQ3SOs138+
s6FlmQ//WgZaowhnnd0vtyNvaTTZLm5F8oExC+UsiGrSFJhaeDxUtFiF6P0OzRhD
hXklIEc4Jn8lXmoFUzwrARQ17rge3Z6E3sdWBE5EoFl8MZzTW55NHQtW0ceY3PVj
BgTA6cQISURycIhN9KglhP/mucHvZ9E5Z/5tz22Zd3TtOs6ss/Lca4AgPmD6hn81
qVawafDZGw7uN/v3EY714XUkL8xgGQl7QXSQrbWcpMnNxE6rZDDq1TFYiuCUdiKO
2q3ZOCbemrd53dEY6/LdoNTnr7576eNEVmBC/AcvfP4wAGVgSjRZqyTdCgvot7jW
1CHJ0NvJMCPatwR1wnGngEiJgN9bRnPQstl9iWxfiMvOnrP+5FCDfwfawyI02xPa
LpZvsegu/NEFDEEuAekgfhRcwRfnYxkjGBIdqCAj1rvAXhFVcdwHeS/HgTDMZ27Y
/B02V+MpjgHoXPAR/u6C1S+BsezqUdqAN1vgaDJ0xn9uQN310BnzyoIDftU4B85T
1GEdmu/N9hDQZGV4mdFjKnfRU/J9TXyH1UoFF2OhF932bMVmIrkpxWBmBOvMlyHL
kj+CEVhwRE9XZW6naj29ZCcw70R9wRPwn2J5hNIsZE+a31tVMFpU+/P7NebP3zr7
bPQw6KJFFRu1mwLovuxCRa2Nj4yHhu2wut9lNIoYZ0/sNsKtJ7c=
=yOyu
-----END PGP SIGNATURE-----

--hrmst3avf3g2aerj--
