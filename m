Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C736BC4451C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 13:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F078010E46B;
	Fri, 17 Jul 2026 13:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m5VQsbix";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2006610E46B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:30:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B0B260A5E;
 Fri, 17 Jul 2026 13:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BD61F000E9;
 Fri, 17 Jul 2026 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784295047;
 bh=7Tsm3hpo5hHlIZ+af1QXLvQU8K0c+DZaaEtqVcnWEBc=;
 h=Date:From:To:Cc:Subject;
 b=m5VQsbixKFf5yx/OlgD3Iv2aM5BdFJNIAqMlGA8jE3UdgeU8YYqyxblBPL0HgJkSI
 QrjpghO26howb+xSfnXKRVkCb06C7MKvN/zPAxAAI02ob1+cDoEPLmgqE1cyQTmIQX
 8Rf6H0u6nRl0C39o8On27Ai1ykPHrsZV3dU/LbM/fTgbKz1aNLIQsBwCeMva5Wj6Qe
 Dh/SPR8tdHCBJebg5N9FQiYNTpP0KRQQqYOk+As+v3XN3kzgGrYQFa1mbX0hcQpv10
 lPeYy1a0QQOm1Gym4cGaYFL7rGqyRtLGvuGPZjnwzrp3JnWTLqXEPvwQ+xslGU/YgF
 lDiOCS6Mc66KA==
Date: Fri, 17 Jul 2026 14:30:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Missing signoff in the drm-fixes tree
Message-ID: <aloug6sR_dZqRqkX@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8mp/SNMY+Ae6Jj4E"
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


--8mp/SNMY+Ae6Jj4E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commits

  c9ab9622f5b27 ("Revert "drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs"")
  d73f4e118dc4c ("drm/amd/display: check GRPH_FLIP status before sending event")
  d094bc1f17783 ("drm/amd/display: consolidate DCN vblank/flip handling onto vupdate_no_lock")
  2979ff0595f84 ("drm/amdgpu: fix bo->pin leaking in amdgpu_bo_create_reserved")
  cee666427f280 ("drm/amdgpu/userq: fix indefinite fence wait during GPU reset")
  57cf172be2827 ("drm/amd/display: fix dcn42b det allocation order")
  bdd22e186a959 ("drm/amd/display: fix dcn42 det allocation order")

are missing a Signed-off-by from their committers

--8mp/SNMY+Ae6Jj4E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpaLoIACgkQJNaLcl1U
h9Ay2gf+Ko2K0RalcgllZDq/Ezhl7OU7Yyl7TzucQc6snNuucMEnrAhR5SAdRCt8
DG6UN+j5s/5g57d9HNBWc/2m3thYhP05p17OAJ6fFFS3Y6vcwOzJ28K0UIpcKOE7
YBmRZMSqABFOiR6cJnHR9pkPUhs121W5BlQQ9bzokpqtraSmDRgBbF0+ng7e4YjC
5T7jx7AjiLDlVlhJ2yIE+bYKZEd7zT0+sYQR5dH60jD6WqlgTVxXnCLIvRzyBPtK
o4g8JlYl5ambDaXU1e2dDOgoIG/BG0+1BrszwgRUVD7Qb11FgmsgD8V/jifMjLsj
Yqx60oB1wkHrW7qxZt06SQpOBaGoeQ==
=c7ie
-----END PGP SIGNATURE-----

--8mp/SNMY+Ae6Jj4E--
