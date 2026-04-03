Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 799FAE85367
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 13:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59A110E4FC;
	Fri,  3 Apr 2026 13:34:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mIGqkbXA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E4410E4FC
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 13:33:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8E0FA60008;
 Fri,  3 Apr 2026 13:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C46C4CEF7;
 Fri,  3 Apr 2026 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775223238;
 bh=55i/c5lvlRWPg2Xg8EGYTojiNtSSlmXver3/W4dI8hI=;
 h=Date:From:To:Cc:Subject:From;
 b=mIGqkbXAo+lkeSD/zYFAfj+Fn50Zrb+62b1Wpgs/kbplORzv61Cr+sQa0UR6ZhZ5e
 yb1wcYuVSAfuQYnvpGai9UE7kCBbi8zu1EZMc/4g5tCBM6GNIGzgtsS9gShSUt9I10
 /Tru8sXEFlLaNuk/dBjxJoo0OxDFhokxCcAAvd2w+GgwazHYtdnuiFR+VgulpuhAlp
 koVmnFykFoCjUOCAUfFJBzmFytPH+mbB/SLQZuykB5fcVKBzPpeng/hOii2vW/PrC1
 B8tLIGaNF1NBN030Si2LyJgQgCdnPLbnqQZVD3oDO4vcfEGNzzi8Xg6Jv8v+dT14Mw
 960R2xVLYgmxA==
Date: Fri, 3 Apr 2026 14:33:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <ac_BwiAI8NwRwubJ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PdPPV9cII2aZSET3"
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


--PdPPV9cII2aZSET3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
  drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c

between commit:

  a3ffaa5b397f4 ("drm/amdgpu/pm: drop SMU driver if version not matched mes=
sages")

=66rom the drm-fixes tree and commits:

  6b0a6116286ef ("drm/amd/pm: Unify version check in SMUv11")
  353f200825051 ("drm/amd/pm: Unify version check in SMUv12")
  964e532d58378 ("drm/amd/pm: Unify version check in SMUv14")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 7ca8fdd23206e,d68ceee16d8f1..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@@ -192,81 -192,6 +192,6 @@@ int smu_v11_0_check_fw_status(struct sm
  	return -EIO;
  }
 =20
- int smu_v11_0_check_fw_version(struct smu_context *smu)
- {
- 	struct amdgpu_device *adev =3D smu->adev;
- 	uint32_t if_version =3D 0xff, smu_version =3D 0xff;
- 	uint8_t smu_program, smu_major, smu_minor, smu_debug;
- 	int ret =3D 0;
-=20
- 	ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
- 	if (ret)
- 		return ret;
-=20
- 	smu_program =3D (smu_version >> 24) & 0xff;
- 	smu_major =3D (smu_version >> 16) & 0xff;
- 	smu_minor =3D (smu_version >> 8) & 0xff;
- 	smu_debug =3D (smu_version >> 0) & 0xff;
- 	if (smu->is_apu)
- 		adev->pm.fw_version =3D smu_version;
-=20
- 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
- 	case IP_VERSION(11, 0, 0):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV10;
- 		break;
- 	case IP_VERSION(11, 0, 9):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV12;
- 		break;
- 	case IP_VERSION(11, 0, 5):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_NV14;
- 		break;
- 	case IP_VERSION(11, 0, 7):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Sienna_Cichlid;
- 		break;
- 	case IP_VERSION(11, 0, 11):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Navy_Flounder;
- 		break;
- 	case IP_VERSION(11, 5, 0):
- 	case IP_VERSION(11, 5, 2):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_VANGOGH;
- 		break;
- 	case IP_VERSION(11, 0, 12):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Dimgrey_Cavefish;
- 		break;
- 	case IP_VERSION(11, 0, 13):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Beige_Goby;
- 		break;
- 	case IP_VERSION(11, 0, 8):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_Cyan_Skillfish;
- 		break;
- 	case IP_VERSION(11, 0, 2):
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_ARCT;
- 		break;
- 	default:
- 		dev_err(smu->adev->dev, "smu unsupported IP version: 0x%x.\n",
- 			amdgpu_ip_version(adev, MP1_HWIP, 0));
- 		smu->smc_driver_if_version =3D SMU11_DRIVER_IF_VERSION_INV;
- 		break;
- 	}
-=20
- 	/*
- 	 * 1. if_version mismatch is not critical as our fw is designed
- 	 * to be backward compatible.
- 	 * 2. New fw usually brings some optimizations. But that's visible
- 	 * only on the paired driver.
- 	 * Considering above, we just leave user a verbal message instead
- 	 * of halt driver loading.
- 	 */
- 	if (if_version !=3D smu->smc_driver_if_version) {
- 		dev_info(smu->adev->dev, "smu driver if version =3D 0x%08x, smu fw if v=
ersion =3D 0x%08x, "
- 			"smu fw program =3D %d, version =3D 0x%08x (%d.%d.%d)\n",
- 			smu->smc_driver_if_version, if_version,
- 			smu_program, smu_version, smu_major, smu_minor, smu_debug);
- 	}
-=20
- 	return ret;
- }
-=20
  static int smu_v11_0_set_pptable_v2_0(struct smu_context *smu, void **tab=
le, uint32_t *size)
  {
  	struct amdgpu_device *adev =3D smu->adev;
diff --combined drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
index ac5e44dff6c97,f09da4d14510b..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/smu_v12_0.c
@@@ -70,42 -70,6 +70,6 @@@ int smu_v12_0_check_fw_status(struct sm
  	return -EIO;
  }
 =20
- int smu_v12_0_check_fw_version(struct smu_context *smu)
- {
- 	struct amdgpu_device *adev =3D smu->adev;
- 	uint32_t if_version =3D 0xff, smu_version =3D 0xff;
- 	uint8_t smu_program, smu_major, smu_minor, smu_debug;
- 	int ret =3D 0;
-=20
- 	ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
- 	if (ret)
- 		return ret;
-=20
- 	smu_program =3D (smu_version >> 24) & 0xff;
- 	smu_major =3D (smu_version >> 16) & 0xff;
- 	smu_minor =3D (smu_version >> 8) & 0xff;
- 	smu_debug =3D (smu_version >> 0) & 0xff;
- 	if (smu->is_apu)
- 		adev->pm.fw_version =3D smu_version;
-=20
- 	/*
- 	 * 1. if_version mismatch is not critical as our fw is designed
- 	 * to be backward compatible.
- 	 * 2. New fw usually brings some optimizations. But that's visible
- 	 * only on the paired driver.
- 	 * Considering above, we just leave user a verbal message instead
- 	 * of halt driver loading.
- 	 */
- 	if (if_version !=3D smu->smc_driver_if_version) {
- 		dev_info(smu->adev->dev, "smu driver if version =3D 0x%08x, smu fw if v=
ersion =3D 0x%08x, "
- 			"smu fw program =3D %d, smu fw version =3D 0x%08x (%d.%d.%d)\n",
- 			smu->smc_driver_if_version, if_version,
- 			smu_program, smu_version, smu_major, smu_minor, smu_debug);
- 	}
-=20
- 	return ret;
- }
-=20
  int smu_v12_0_powergate_sdma(struct smu_context *smu, bool gate)
  {
  	if (!smu->is_apu)
diff --combined drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index e38354c694c95,d0a8df1aa6b64..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@@ -229,66 -229,6 +229,6 @@@ int smu_v14_0_check_fw_status(struct sm
  	return -EIO;
  }
 =20
- int smu_v14_0_check_fw_version(struct smu_context *smu)
- {
- 	struct amdgpu_device *adev =3D smu->adev;
- 	uint32_t if_version =3D 0xff, smu_version =3D 0xff;
- 	uint8_t smu_program, smu_major, smu_minor, smu_debug;
- 	int ret =3D 0;
-=20
- 	ret =3D smu_cmn_get_smc_version(smu, &if_version, &smu_version);
- 	if (ret)
- 		return ret;
-=20
- 	smu_program =3D (smu_version >> 24) & 0xff;
- 	smu_major =3D (smu_version >> 16) & 0xff;
- 	smu_minor =3D (smu_version >> 8) & 0xff;
- 	smu_debug =3D (smu_version >> 0) & 0xff;
- 	if (smu->is_apu)
- 		adev->pm.fw_version =3D smu_version;
-=20
- 	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
- 	case IP_VERSION(14, 0, 0):
- 	case IP_VERSION(14, 0, 4):
- 	case IP_VERSION(14, 0, 5):
- 		smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
- 		break;
- 	case IP_VERSION(14, 0, 1):
- 		smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_V14_0_1;
- 		break;
- 	case IP_VERSION(14, 0, 2):
- 	case IP_VERSION(14, 0, 3):
- 		smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_SMU_V14_0_2;
- 		break;
- 	default:
- 		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
- 			amdgpu_ip_version(adev, MP1_HWIP, 0));
- 		smu->smc_driver_if_version =3D SMU14_DRIVER_IF_VERSION_INV;
- 		break;
- 	}
-=20
- 	if (adev->pm.fw)
- 		dev_dbg(smu->adev->dev, "smu fw reported program %d, version =3D 0x%08x=
 (%d.%d.%d)\n",
- 			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
-=20
- 	/*
- 	 * 1. if_version mismatch is not critical as our fw is designed
- 	 * to be backward compatible.
- 	 * 2. New fw usually brings some optimizations. But that's visible
- 	 * only on the paired driver.
- 	 * Considering above, we just leave user a verbal message instead
- 	 * of halt driver loading.
- 	 */
- 	if (if_version !=3D smu->smc_driver_if_version) {
- 		dev_info(adev->dev, "smu driver if version =3D 0x%08x, smu fw if versio=
n =3D 0x%08x, "
- 			 "smu fw program =3D %d, smu fw version =3D 0x%08x (%d.%d.%d)\n",
- 			 smu->smc_driver_if_version, if_version,
- 			 smu_program, smu_version, smu_major, smu_minor, smu_debug);
- 	}
-=20
- 	return ret;
- }
-=20
  static int smu_v14_0_set_pptable_v2_0(struct smu_context *smu, void **tab=
le, uint32_t *size)
  {
  	struct amdgpu_device *adev =3D smu->adev;

--PdPPV9cII2aZSET3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnPwcEACgkQJNaLcl1U
h9AfmQf9GkQPCkfqCTXWnDy8UvZehlkNcxtd9S/DShRIVpgEUKaS17Qmkf4BB+hd
3t/oI1yjgNoaspEioBtZ6ANO2atY7u+lIroeuN197luvsqo7hBK3hJAXXbaF4Jez
amOtdi3Hq+6YyK5Zx3FMTdOFk+nE27Bz/pmG4xJuZtWysYDGLKz8FWeH0dNAKB0k
xvbNB1GUV7YJSljAphhEjU4JxqIu9OIbdoGeAOWMxdTHMEAdgmBXpwNsV3d7ZSdB
+UOnnOfMgDpEr2gnjhWk1SSOnlnPu4hNFic4NJSAV60nO4+iHGp6KHYJFU2h/m26
oYydofy6pLe73s+CoTCedpn9ff6mFw==
=A0ak
-----END PGP SIGNATURE-----

--PdPPV9cII2aZSET3--
