Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F046C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A789410E57A;
	Fri, 14 Aug 2026 14:45:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="n9o7Fwd/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D96110E57A
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:45:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B568F600C3;
 Fri, 14 Aug 2026 14:45:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D0381F000E9;
 Fri, 14 Aug 2026 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786718711;
 bh=JkdhX9xnw163FKI3ZfukFjAto5H7eUFYNA4/7qbzFNI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=n9o7Fwd/0nt8cA66zk7gnXbFzV8iRpuQjR//usUiNzb09L9Ljik2IsfQ8iqYuYYqq
 3k77VddAmllLstyreRYd9RZJ3fbgrAxbBmEl38A39PpNA6rLubMJW6Atx4ETZLmH9G
 SD0lHEV9dMk384u/a8l+QfEc1+ZPZyB0g2zS6ch7rAOthJDJLSGdsmoyh93SzSlOxF
 qrfkboE3t/0ugVHNi/29X84+FD9blYniR13QgCj86oWKOzTaPRjZFlGHoQoqaX1AKS
 QGbJ3mnf+O9XzAE0wXfYBCdLau+sveKODXeJoM0lw8z0pMq8edQChHgqs14NESsvzx
 LAjw91FGIqICw==
Date: Fri, 14 Aug 2026 15:45:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm tree
Message-ID: <f6d2ef8a-4aca-4923-b459-53bb06a227ad@sirena.org.uk>
References: <annoPJ_kdzJylWIz@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j4oz+cx7fKX2skL8"
Content-Disposition: inline
In-Reply-To: <annoPJ_kdzJylWIz@sirena.org.uk>
X-Cookie: The more the merrier.
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


--j4oz+cx7fKX2skL8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 04:03:24PM +0100, Mark Brown wrote:
> Hi all,
>=20
> After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
>=20
> /tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/src=
/dml2_core/dml2_core_dcn5_funcs_mode_programming.c:11:13: error: stack fram=
e size (2400) exceeds limit (2048) in 'dcn5_mode_programming' [-Werror,-Wfr=
ame-larger-than]
>    11 | static bool dcn5_mode_programming(struct dml2_core_calcs_mode_pro=
gramming_ex *in_out_params)
>       |             ^
>=20
> Caused by a previously reported issue in the amdgpu tree.  I have used
> the tree from next-20260807 instead.

This issue is still present today.  The amdgpu tree has had a fix for a
day or so but nothing from the main drm tree for the past week has made
it into -next.  Please consider prioritising fixes for issues such as
this.

--j4oz+cx7fKX2skL8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/KfIACgkQJNaLcl1U
h9CoZAgAhSqdCYvsx7tO9Inm8kktCBYIdAmEHzrCEXgH60Roeo3C98DJXDvJnrg6
7Md290tPaPosiIVtfGimhEFeMovn0HHayPL5vrUBecuc8NeFvh9P/OcNU9gGUlKX
bFDWGZeHwCIDqY5UGW3yKYSYgL+IKz5pszeAiscJl4kD8Ke5UIQY/f68/HoCGkC7
kL1DMIXj8XCBFS14kDvJe3zKMo92NOmEtpWU1ec1daIAdcnYQaVSjxBjeKCFWFNu
wPVy59rpGFdM53StfhJ5U1GB6iflOC72h7NALL+1iWTPNJQQKqMx5oNbgMhxzW59
DcORoBaEMnFsmFeiGcCJwxaS8EazKw==
=govk
-----END PGP SIGNATURE-----

--j4oz+cx7fKX2skL8--
