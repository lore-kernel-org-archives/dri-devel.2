Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13823CD98E6
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 13:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 680EC891BA;
	Tue, 16 Jun 2026 13:14:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I4MBLu/6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A53B2891BA
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 13:14:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B199960137;
 Tue, 16 Jun 2026 13:14:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE91E1F000E9;
 Tue, 16 Jun 2026 13:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781615659;
 bh=DilPkWusCOrRK+QxWFdyli7e2cLkKJXdQxVixQApeQU=;
 h=Date:From:To:Cc:Subject;
 b=I4MBLu/6USsUf4xXAndanbwmm75OHpO+gXiQZadH/OE38RXohgLvtlljHAdsO6YhU
 Y+6R9pt+JiqWkRka05bTHy27f8sFnczHO1458HWS+Vdz9l3SLnmE3f0vci15aKINBK
 7hLfKD6Whni0KPanEfMuk8H4Yy5gf3+GWag/G3sPTWFyf3Q3Dg1nnaaLkqY0/jVuyc
 mrzWYwVYDi+2Zujntc7FiqunNhRnk8SahcxTxETL5Gz81nvELklrwmYDa6o1cRnzLu
 Z5kKxerJvPq38TJ5ah1UjRwiYkyNbP0W0A1JendXMAJ2MMjL7pZz7q7G4pUgwH076S
 h/7qPsEDoHEjw==
Date: Tue, 16 Jun 2026 14:14:15 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Christoph Hellwig <hch@lst.de>, Vlastimil Babka <vbabka@kernel.org>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <ajFMJzsbcZ1m_vr3@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gGWJYHMcz3gYQOnl"
Content-Disposition: inline
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


--gGWJYHMcz3gYQOnl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/tmp/next/build/drivers/gpu/drm/panthor/panthor_mmu.c:1251:6: error: unused=
 variable 'ret' [-Werror,-Wunused-variable]
 1251 |         int ret;
      |             ^~~

Caused by commit

  6bb0009862c5f (mm/slab: improve kmem_cache_alloc_bulk)

interacting with changes in the drm tree.  I have applied the fixup
below and can carry as needed.

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/pantho=
r/panthor_mmu.c
index 3151de6aa1bae..10e32fe26f7e4 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1248,7 +1248,6 @@ static int panthor_vm_op_ctx_prealloc_pts(struct pant=
hor_vm_op_ctx *op_ctx)
 {
 	u64 size =3D op_ctx->va.range;
 	u64 va =3D op_ctx->va.addr;
-	int ret;
=20
 	/* L1, L2 and L3 page tables.
 	 * We could optimize L3 allocation by iterating over the sgt and merging

--gGWJYHMcz3gYQOnl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoxTCYACgkQJNaLcl1U
h9AZgAf8DqLZuojK5ugxAXjS4IPqeZ1qPp5aC1w+KbJk+Si1diFUg1EMHpNaB9Li
RgnMfXnXlUhdsGXg+8nasuaOgQpsVzTSQ7vM2V3lqkw8HW3GoMUNkz5bjp0L6tum
OhWtLZh0iQ6Hi4sXAaLH+GwouTyK7oBx1dZZIHn68kpR/Bzj23DinsDbbRWY5B3t
zj0jirjkGJ6KZwc+VihhWNu5vQzzUFHI18no7urGBV/A/BUE91o0pYAhiREKYImD
X1b4AjBcQm+IlFdjHRaVowdvEj/F2dXdgGFXisCX4EYOp/eTOfKRFT4FKneHrarl
6bM5TTl4cKwPqfdk8O2LJ20Yagfryw==
=L6F2
-----END PGP SIGNATURE-----

--gGWJYHMcz3gYQOnl--
