Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942FDC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 15:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E294D10E0B7;
	Fri, 17 Jul 2026 15:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Zi0Qlyig";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2C010E0B7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 15:12:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E5D3E60A61;
 Fri, 17 Jul 2026 15:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF2D1F000E9;
 Fri, 17 Jul 2026 15:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784301130;
 bh=F/QA0Yq5ZBmneMvPVvb9OjyEuQx6hTVgoJ+uI8nUFgY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Zi0QlyigCjCBkQ61CkWLH6nobkhhotWMWi6l+RMiPUJawOkn2m5MCord8UQZF7pKS
 B4cPvhpDeEpIk5hzD6QUb2sJlVut8GL1kZQaoiENH6LCou1RMqwF1CbhzGJnxCBVN9
 2rwDF4ID7+7m8VYv7gN+RLaPEIwOm3XTtnZT86OqsqPss5WlX+K0QoXK/7alVySnV7
 0VIGgMu5y5Vfc0+TelWMwNycdJq6HPgRP39q+T4bkD2z0YO1kDWnBwhoIVyftQrLMW
 7H84S12BqDDoNE0VHQjk+Z91LbFPdqUlw0fgvegQ8tJVeHwg6QfxfccY0hYxTzlI7k
 eGvJN59Q19W1A==
Date: Fri, 17 Jul 2026 16:12:05 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>,
 Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>,
 Gabe Teeger <gabe.teeger@amd.com>, George Zhang <george.zhang@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Matthew Stewart <matthew.stewart2@amd.com>,
 Peichen Huang <PeiChen.Huang@amd.com>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: Re: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <9c1d382f-1a2d-4b3b-a8ac-435e7818c64e@sirena.org.uk>
References: <alo-x_TORE2vBFlX@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p1BCFUjbatynoVHo"
Content-Disposition: inline
In-Reply-To: <alo-x_TORE2vBFlX@sirena.org.uk>
X-Cookie: Enjoy yourself while you're still old.
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


--p1BCFUjbatynoVHo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 03:40:07PM +0100, Mark Brown wrote:

> Today's linux-next merge of the drm tree got a conflict in:
>=20
>   drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
>=20
> between commits:
>=20
>   6351003b1f4ec ("drm/amd/display: wire DCN42B mcache programming callbac=
k")
>   57cf172be2827 ("drm/amd/display: fix dcn42b det allocation order")
>   c4bc7ffb91586 ("drm/amd/display: Fix DCN42B null registers & register m=
asks")
>=20
> from the drm-fixes tree and commits:
>=20
>   85453fb4ff726 ("drm/amd/display: wire DCN42B mcache programming callbac=
k")

Actually the merge here doesn't build.  I'll try to fix it up but
*please* try not to do this constant, routine cherry picking.  Sometimes
it's the sensible thing to do but most of the time I'd expect to see the
fixes go up onto the -next branch with a merge. =20

--p1BCFUjbatynoVHo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaRkUACgkQJNaLcl1U
h9Bxwgf/ZIcw84xQ3n6v5ISb84CqD1cZBkp8MCB5bvDcPMataYds8o0vLlWqGtJj
mBcEDvhwgz8c+O62Ih7pQBslKJn3nMK+ais/lhhLSmXyg/kXCJY6DEm/DUHZ8dG1
zlz2TWA+fLZI9JXnR8vFoflGCf4DYaNkxnDwEEoz/WNvHlwchbzLf9yg2/cI6ElF
RaMN9fhju3QDcd130o/SqCc8+BxZAfhhPa4YyYyO6425OMQcoJ5e9WSWJCHk7gtq
viUBU8I52727Ux+LVXdhZ8cBfUknJeWYFfdJYh+tLh8PLKINJhBS7ZasFvz2Q4pa
9IHfryXRmassAfdCM09NZjdhXy8Ysw==
=1876
-----END PGP SIGNATURE-----

--p1BCFUjbatynoVHo--
