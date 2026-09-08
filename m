Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF2DC79F9E
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:01:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6B210E115;
	Tue,  8 Sep 2026 14:01:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S0Pvh77G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C701D89EAE;
 Tue,  8 Sep 2026 14:01:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DC8D601DB;
 Tue,  8 Sep 2026 14:01:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4933E1F00A3A;
 Tue,  8 Sep 2026 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788876110;
 bh=ASO1YLZO+3Ki8lA+q6vKQbYAHU3cyVD1rsR3m5ZiDS0=;
 h=Date:From:To:Cc:Subject;
 b=S0Pvh77GnZjZ7C5vbB/1bSilLS5Mv60rVGCfzGATWxN69zCQRQNQevDfyuTh8KpNb
 LpzbEzabCmeSvQxTHEjdEHz03kN69PdCWd06tJ54V4hI5g/S/g3WPi/F0oauMMoha0
 0U9mTKfNyS2jpO0uPeRwg6g1Zzx+KD5Nq21AxYuvX1PXcAaJ/0RpKlSrV1+ITl/jK0
 3lEvMktf2TTY8nwoaTv8D496heRupcKeKa/fWe8qUceh6kdYcDVFYqGeoVdX6q2LYt
 9BCxo7L4eQLp9SAAcc/BaHqwpDO+DhGIemYZB5Jsn8Obbb91qlYHREcruBXIVJC1BF
 UtcFVtja5LPAg==
Date: Tue, 8 Sep 2026 15:01:46 +0100
From: Mark Brown <broonie@kernel.org>
To: Simona Vetter <simona.vetter@ffwll.ch>,
 Intel Graphics <intel-gfx@lists.freedesktop.org>,
 DRI <dri-devel@lists.freedesktop.org>, Alex Huang <Alex.Huang2@amd.com>,
 Mario Limonciello <superm1@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-misc tree
Message-ID: <aqAVSgsypMch2c0v@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oCgtILCq07VH6vPj"
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


--oCgtILCq07VH6vPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

After merging the drm-misc tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/tests/amdgpu_dm_connector_test.ko: symbol 'parse_hdmi_amd_vsdb' undefined!

Caused by commit

   65198b3d0738 (drm/amd/display: Use HDMI FreeSync range from common EDID parser)

I have continued to use the version from next-20260831 instead.

--oCgtILCq07VH6vPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmqgFUoACgkQJNaLcl1U
h9BPXgf/VvfYotmhsQHXtyVeE14Iia+Lsczx6xzeIK0C4iDQCZpb0FBLm2OWpf9u
oQU3Oa8WOW5kIjXQ0mYOob9fvNUJj3c3MUa/0NzYlJgBtAn+Nw4IbgIZh7JrgRKD
G9oKark58335VLe4R/uG+giFS/JoRqm8Wt1WUfSSYJ8vbPR0Oqt2EWor7BsAhHuE
AlIvX2KLFEu2LEn7PI0QvYMGf3l0eZCmZDmNPctfRdCSpcMtxeBu7y3CEaPN5EnB
+6Df+PqKdWLLsglC3t+I0SwR2LERDZQ6TC16dZ3y2oHJJ7SgtUMBXhXFV0A4fIXz
gVgcXdzLx4ynHRKe6sIMtw/TRJ2GHg==
=vZ/X
-----END PGP SIGNATURE-----

--oCgtILCq07VH6vPj--
