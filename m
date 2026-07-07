Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4CAC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:52:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5750510E4D7;
	Tue,  7 Jul 2026 11:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LnH5gXOZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C49C10E4D7
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 11:52:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F37AE42B1C;
 Tue,  7 Jul 2026 11:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C1E1F000E9;
 Tue,  7 Jul 2026 11:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783425171;
 bh=stP6f/4kuRNi9NzfK+cYLF9hGdhU4QwZi3GgzpKITT4=;
 h=Date:From:To:Cc:Subject;
 b=LnH5gXOZ6YcHO0g0mcFpwGIve2InqcdpwB43WmoOgSurXFZp4agiY9eefM/UGMDf5
 iPQQZboa1vpIQoK2ZdQy08BO1uDbEdI9PWurerdXzHbaWQRPTZoBUb0blk6MpiyQVT
 kCPC9w2g9mPR7z1jWwTOnCGZkbZMcqoRCf0VdyJnSyIZQ/OSuuXocry6UGVildsCNg
 +4RI9FtAPhK1TyqOH2fE7HI9LHBjteGeoJ6QYNe5Q/DMKQUFYAZsdLgnG3g9/CVjnC
 p5oCX9YIxeYhAx5g9gvt8r3x2R6UHlGgfcRajWrYEPPfJhC6DDj6FPrYBV+C0PIaFC
 IDKkTu+WNHHiw==
Date: Tue, 7 Jul 2026 12:52:48 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the drm tree
Message-ID: <akzokN7rHrYSZ_A7@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="fMfP6VrfMp13jt4S"
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


--fMfP6VrfMp13jt4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In commit

  3b1f4d5e47b36 ("drm/amd/display: Fix dangling pointer in connector reset function")

Fixes tag

  Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_crtc and dm_crtc_state")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format='Fixes: %h ("%s")'

--fMfP6VrfMp13jt4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpM6I8ACgkQJNaLcl1U
h9Ct2Qf+JVp9vWrtUsjH9h9ccl3UbPPOMq/NNFCn0CUnQ9qVGGtRskw6hfRm+xt0
fIwwCgk6fQmDvHMyFzteNHdGBrPyHIIbKv+ZyM84i/4CqvfC49EsHbu64pkp4rkr
u68vnTRqG258yJ8KsxXgKLGt8Y2xv4pmZgbABPiT/eMKfq0Xlt6iO1eUzkWSc9Tt
FEKj3i38Jvx8jctjTBBivlQ5x5tgpJPzAi4N9JNJf7rxvtVjNJlZ/ucogF4nYRk0
xXktZwO6eA63CVZyIn4qKOI0ELe1+wu5VuP3ZyfbseBVLnKpumouSrKgEGW2gOml
7yNrAHJDe16wJfoRCl+ymo3+WCW0+Q==
=xjip
-----END PGP SIGNATURE-----

--fMfP6VrfMp13jt4S--
