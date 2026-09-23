Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532C8C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 13:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD3210E8CE;
	Wed, 23 Sep 2026 13:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Nv9+vQJ4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F65710E8B7;
 Wed, 23 Sep 2026 13:25:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5C1F360210;
 Wed, 23 Sep 2026 13:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00C91F000FF;
 Wed, 23 Sep 2026 13:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790169928;
 bh=zlWa1e2jWcfiiYfu+fJY+2gOtdAjpcg6EpsI0gyoG1M=;
 h=Date:From:To:Cc:Subject;
 b=Nv9+vQJ4X1ZPR4LjImDulZSo8D7/jmLZDpa9NesjKRqgcJH9yrUPZXyjOH1hXpFrg
 Esif4bWydfMzQOEVLOZgkL3cqqsh5VxtSKP/Lq4lc+tLG+4z3i59TzjSMQdkx7gIM/
 6m546sdQTDrcbxXaiK7Jl8+rmgGsjdizMLCZdt1MjJOfRf5wn2El1q41PUj/fFQoTO
 FsKUuiZAIaaSukQ+n5WXssbE7bqYiBPqQD0AKafVWiCMr9snimVBjIyK37RCtyYAu8
 koaAZJ4Ba/XnQHAvezbFhEMyHKrpaDDk+aRwq2SDMSHZDOsyyqUwAJPb/stjY/oeT0
 VtmjT+x2oQHAA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id 033191AC573B; Wed, 23 Sep 2026 14:25:24 +0100 (BST)
Date: Wed, 23 Sep 2026 15:25:24 +0200
From: Mark Brown <broonie@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@redhat.com>,
 Alex Deucher <alexdeucher@gmail.com>,
 Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <arPTRF4qS6o1Q3vD@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="u4iB4BPRsdxcH5TP"
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


--u4iB4BPRsdxcH5TP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_memory_pool.c:8=
7:37: error: stack frame size (8264) exceeds limit (2048) in 'dc_memory_poo=
l_create' [-Werror,-Wframe-larger-than]
   87 | __must_check struct dc_memory_pool *dc_memory_pool_create(size_t si=
ze,
      |                      =20

which I am exceptionally frustrated to see was caused by commit

  bc3f07516a992 (Merge drm/drm-next into drm-misc-next)

which merged the bug I originally reported in the amdgpu tree:

  https://lore.kernel.org/r/aq0vYhZXtMqA41wZ@sirena.org.uk

and then in the drm tree when that was sent upstream without the report
having been addressed in any way:

  https://lore.kernel.org/r/arJoCiRM1hRbgRb5@sirena.co.uk

neither of which have had any response at all.  It really seems like
there is some room for improvement in your processes here, currently
that's three drm trees all held out of -next with the same fairly simple
build issue.  Can I suggest at least check to see if the code you are
trying to merge is in -next, the drm merge was done after amdgpu had
been held out of -next for several days.

--u4iB4BPRsdxcH5TP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqz0zsACgkQJNaLcl1U
h9BLTAf9EIijiMYDxEApkxScDx3f4Bi3xFEdhyaF/pQC0o575r2k4NOF7iZA3cTA
Az6mwVvR/OYFKgiWlMud0jcrwYH8F3oPL714/AlXxlrkGQFPQlHrjo8tk+DdWJoU
RX3gZP7VDGoNe9Ag20ZvcFUvUyPiBSp5NJENkGwaEBLzYwnmBjPluldBbHJPQ5Bh
D/HK0N+S+HWHq1/d8Jvbo9yaUKg3ZM+hNu37MMQjCuXCLREmwpfRg5mVtBwk99aI
jkx9SxUnZ665U0cPxMYskag0aiHxsdbDqkKXhafCLVJRooZpSGvNtDmbPSnl25rT
9N0YB0GV4MGYCpWVkpKIJUFaoCyqTQ==
=c41z
-----END PGP SIGNATURE-----

--u4iB4BPRsdxcH5TP--
