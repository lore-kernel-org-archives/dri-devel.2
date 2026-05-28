Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A74CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00AB410F209;
	Thu, 28 May 2026 13:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XbHPh2+E";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0B7A10F209
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:58:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B3A8A43A6C;
 Thu, 28 May 2026 13:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2921F000E9;
 Thu, 28 May 2026 13:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779976694;
 bh=lHC/FW7tnteRVtutAnHZv6iVlMg+BbUjWq+ubu9W2Uw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=XbHPh2+E2OGIwRPj70BzxHGm0COOLjIGDv6+Q7v6tJJmQmvTIukdU5NRlDbCXCD1v
 lVhqjIjA1ZEhcK4+CwAedkOnP2eoC1CeCEy7OHeEMqYdp7CrjWQ4uw7bWKueifWQRV
 e9XMaLZqeKNO69qdwDyx9fxIaVN3WS+QfJs0zzzU24KAg4ZJMH+RPJKy6oE5jsyGtT
 99E6Y2ATljuyyu3KxxuRphhaKShcr0uK68n3yWFnBk6a6eq/KkxjeeeQIThcCCbFP/
 OuCVS2u+UiYng9DBFGMEslQNY3N7pB2i9K+0TjugBfXuY9fY6Uu6O8JYzO6pI2f6mZ
 XGSIDL2ZyNasQ==
Date: Thu, 28 May 2026 15:58:12 +0200
From: Thierry Reding <thierry.reding@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Mark Zhang <markz@nvidia.com>,
 Sean Paul <seanpaul@chromium.org>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] gpu: host1x: Fix device reference leak in
 host1x_device_parse_dt() error path
Message-ID: <ahhJ6Uo5qHfn0CBg@orome>
References: <20260413141526.2961841-1-lgs201920130244@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kcchf3ioudov7kum"
Content-Disposition: inline
In-Reply-To: <20260413141526.2961841-1-lgs201920130244@gmail.com>
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


--kcchf3ioudov7kum
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] gpu: host1x: Fix device reference leak in
 host1x_device_parse_dt() error path
MIME-Version: 1.0

On Mon, Apr 13, 2026 at 10:15:26PM +0800, Guangshuo Li wrote:
> After device_initialize(), the embedded struct device in struct
> host1x_device should be released through the device core with
> put_device().
>=20
> In host1x_device_add(), if host1x_device_parse_dt() fails, the current
> error path frees the object directly with kfree(device). That bypasses
> the normal device lifetime handling and leaks the reference held on the
> embedded struct device.
>=20
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>=20
> Fix this by using put_device() in the host1x_device_parse_dt() failure
> path.
>=20
> Fixes: f4c5cf88fbd50 ("gpu: host1x: Provide a proper struct bus_type")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - note that the issue was identified by my static analysis tool
>   - and confirmed by manual review
>=20
> v2:
>   - add Cc: stable@vger.kernel.org
>=20
>  drivers/gpu/host1x/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--kcchf3ioudov7kum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmoYSfQACgkQ3SOs138+
s6G23Q//VVEOmgeC4pq1oP4zmKOzGSMNrQQw6ocVaJnDBex8C/JZv3p0LENKt0Ci
N4mBgQ3uHYceV4B47TWfeiyKe5Hk2Q6Cm+YBVi1/AJ8bg7lMkxJpI08pdv6jMYgc
cl2fKIpRFZi+MccCZw6QtIH2O9+yg4LpLYFZ5BU9ma4dEzhyqpYYWf+I4h+WirEI
b4fWCD60kERAfpF7i3Itqsq+iQdehu28h97gczDZRIiI0o6xeJYZll+woDtyq6QE
eT6vKAoRpLsdaDjyg4qPyyJ+o7KkFQnonfmqrOS1DhWLhTTrHpQfTeJbBhlCB3aD
kDBThYlQAU4Zjo+dQYez2iho1xPF5jyYzipFEdNWAqfBEBAFAtZECP/+v+0oDBLZ
8G9Mt5Pzz7sqQFNHszf2quySJl9Qrqvr6BcjqIr30GTGgTVTyniODwFzDmpTLnvc
hQwNWvuYuqFI+jQ+CC7jl0amPIZsW9Yi+w2HJ0NtchK2p0yVXQ2lIWF7xeRuf5JE
Gxil6d1/PN5LqSPXCQ9S1Fnk8xODUzrX1IACsqVTKyonfy130rDZBzSaYsnA31rE
wqENcv5e1qRo7Z9bZ5REYQfsibhU0HtMP2DJ8cgpJgPQHqIpB//bdTCqrtbTIWwx
O1FPLIvHT5WI2GuN+MkqIiiSTU5UHa3dbJuOyh9oy/E/BaP2PuA=
=16zP
-----END PGP SIGNATURE-----

--kcchf3ioudov7kum--
