Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B293FC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C40110E8F6;
	Mon, 10 Aug 2026 15:03:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VWDWac8i";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E7410E8F4
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:03:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C02CF4186C;
 Mon, 10 Aug 2026 15:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9A11F000E9;
 Mon, 10 Aug 2026 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786374208;
 bh=b6kBSWCplxQGLWrtceh74uwXpFbK1ls84Ij2a6DqG8w=;
 h=Date:From:To:Cc:Subject;
 b=VWDWac8i/RuVrEp4k3XWNW8iccTJ9k5HrB00K5/LkFMps9Gic2GJiaKjzDDajg/9+
 u1ymfkhOd1oiBGHKtxT5XYu+Z6C5+ehEl15gbCuokIVHZh6HLP9B8N7w1UJOd7ttS3
 ARydFBouNXgTyJJV1qkqU91jlYSwmHCMahyq9lDJJw0Wd4lJ57+QeVSswen0I/Djdv
 oc4MwM0P4g+GLwBpz2cRDkluePd54BwUkQD0QV8p/N/NIls1MRcleAv/0PhPT+DZcu
 OZjlPKtOqagg4aZU7wCU8E99D1a/NhtOWXIQE4iuUB339Pe1O/4zHgsejQ2Cf8HtVH
 KQk629THzAzhQ==
Date: Mon, 10 Aug 2026 16:03:24 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>,
 Alex Deucher <alexdeucher@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm tree
Message-ID: <annoPJ_kdzJylWIz@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jAd1A7MIYgrcv0VI"
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


--jAd1A7MIYgrcv0VI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the drm tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

/tmp/next/build/drivers/gpu/drm/amd/amdgpu/../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c:11:13: error: stack frame size (2400) exceeds limit (2048) in 'dcn5_mode_programming' [-Werror,-Wframe-larger-than]
   11 | static bool dcn5_mode_programming(struct dml2_core_calcs_mode_programming_ex *in_out_params)
      |             ^

Caused by a previously reported issue in the amdgpu tree.  I have used
the tree from next-20260807 instead.

--jAd1A7MIYgrcv0VI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp56DwACgkQJNaLcl1U
h9BcRwf9Hzx7NfMLht4eE0IYxBGSgvqrZQ1azFb/SonV90y9Ub1FlVhTtzzbHEQ3
bsG1pdSYB6PfNPhT2XTdVE9ScK79XJkAIdzlsL6tfq6sfVOQ/d6saM6qT35ey1B+
8ScHGfrvoxY5ZO0+Dje2LLTB2SVAIA/18UUC53VLVbXgpbXRPv/fJB1WuIWsn7lA
pmbxzF1TG1AwU6xAvZijtDImaNjHRJx0f5vUgYpol6xHaBVBC6/kAP5bx8Afp44n
jUCRs86s+LaBBZy3OZZIUMJtb4HviltSrp5XkNWLbENTreUHdSFZsqvmSRCmGOkc
5Tl7w1Pit0dKZNvnM2Vor90V6jVadw==
=y3N+
-----END PGP SIGNATURE-----

--jAd1A7MIYgrcv0VI--
