Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA95C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4150810F5A1;
	Thu,  9 Jul 2026 12:33:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wyb6fr+0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A40B10F5C1;
 Thu,  9 Jul 2026 12:33:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9F454170B;
 Thu,  9 Jul 2026 12:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852A81F000E9;
 Thu,  9 Jul 2026 12:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783600429;
 bh=VxCyzKYt+2p3S+jwZw/Xoev9w+MftLxRp12EmyoN6qg=;
 h=Date:From:To:Cc:Subject;
 b=Wyb6fr+0pCxMUPXahLueym4g6s3cML7pvQLcuhdpnJKxBrORwnE2Vp1Z7fL4swA3V
 ASEoocmKX2BCUatvHAGHq1begAG8KDEY1lXuiFCChp07RPuN9qqSAjK4PNi6GfnC8+
 z67n2bevu+XyqfUdfIhTgRjHZhadPGSKDl/hH37hHRlQQHOgqlaIC9fHnyEG+UMK+B
 vJT+kceqvc7xToyrUGhBkdGic7Ce32BrsNvJKJxoY4f7DqJy2v3z/XSfzoNbZlHPZL
 mOsMhnNQIz5ICWTO8xYziHTYykdhBFqtM+kGWpwbQ4+/i6IRXjsCk8k6Xb1+jiihEf
 M9mf7ILVhKgdw==
Date: Thu, 9 Jul 2026 13:33:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org
Subject: Fixes tags need work in the drm-misc tree
Message-ID: <ak-VKufd0zg0F8AD@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bH6rGYeBd6bmCszn"
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


--bH6rGYeBd6bmCszn
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

--bH6rGYeBd6bmCszn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmpPlSkACgkQJNaLcl1U
h9AKgwf/RNYiEzszQGfZYdb3GELo4yuwD1Al49eAnwIfZAipRVTgJ/1jqVvHJ+WL
IGvU7NFMNysq4atFQBJLm0O/CIb0uIOXwYpm0Xxe9t3C0/jTgCYPsvZm8Xdd3+Bl
2YzytulHikVL1rZzufMIALPRSpjWBQor7w07hPRGvFC99kZ3LB0USzcw6BWNfYjU
p5sFxU7osiPF8YESyt2W6sl6zfh+FcHx61PeuQZ4AlKu41Lu2+eBjFToVIXHAVoQ
+zN6+3hWXnnoaQAoc/1sLNrfoTyXwpoFdjuHsJt3lczZNbRfN5ZJMl3WlSzhoA5T
dRiuFf1W05o9v/LJRhoLBOd0IAr/Lw==
=wWw7
-----END PGP SIGNATURE-----

--bH6rGYeBd6bmCszn--
