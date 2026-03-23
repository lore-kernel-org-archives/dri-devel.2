Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A463F46137
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 15:01:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4A1610E488;
	Mon, 23 Mar 2026 15:01:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RYuzcDKW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE35310E120
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 15:01:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7B6D843047;
 Mon, 23 Mar 2026 15:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD45CC4CEF7;
 Mon, 23 Mar 2026 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774278084;
 bh=YXopQW8icP/uHmtDhhAJHN+93/Vjd5o3pQIcmkal458=;
 h=Date:From:To:Cc:Subject:From;
 b=RYuzcDKWY94tEWKPpelPD8Y7OB1b3N4aPQrFqDpadQQXWH3XlCmUclnWWrJawdnC3
 Z9zUj+xZ8oQzLU4e8iVTfIp7+wqKexyeDkMgukw7lk14DxyTlZoeCKt738Xu9qDfhg
 w9hk0+vf5iT9wnV02Q2jT0I6Ko9a1FO/cPNrTXaQkpp6HHwVy8pp+g/2nFqZ733LiR
 h5jmS1XqIP/yQSBMIkJzjucpX9kBGPIUBETyR54rRVs3dnv4UgE/U9uYmpuL56FXAW
 IQjn2iFe9lcb+hsFrvWBSBZFwUkzSkxWaiW8WYQI2s7YzDoP9stZMP7kaHvactGipU
 agHlhv+SPQcow==
Date: Mon, 23 Mar 2026 15:01:19 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <acFVv77gDXr1pMML@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bIOc6m73MNL8ArAQ"
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


--bIOc6m73MNL8ArAQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
  drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
  drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
  drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
  drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
  drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c

between commits:

  f39e1270277f4 ("drm/amdgpu/gmc9.0: add bounds checking for cid")
  9c52f49545478 ("drm/amdgpu/mmhub4.2.0: add bounds checking for cid")
  3cdd405831d8c ("drm/amdgpu/mmhub4.1.0: add bounds checking for cid")
  cdb82ecbeccb5 ("drm/amdgpu/mmhub3.0: add bounds checking for cid")
  e5e6d67b1ce97 ("drm/amdgpu/mmhub3.0.2: add bounds checking for cid")
  5d4e88bcfef29 ("drm/amdgpu/mmhub3.0.1: add bounds checking for cid")
  a54403a534972 ("drm/amdgpu/mmhub2.3: add bounds checking for cid")
  0b26edac4ac55 ("drm/amdgpu/mmhub2.0: add bounds checking for cid")

=66rom the origin tree and commits:

  35362833df056 ("drm/amdgpu: Add client ids for mmhub v2.x")
  642fb9e14c63a ("drm/amdgpu: Add client ids for mmhub v3.x")
  f2eceeef689c8 ("drm/amdgpu: Add client ids for mmhub v4.x")
  e14d468304832 ("drm/amdgpu/gmc9.0: add bounds checking for cid")
  dea5f235baf37 ("drm/amdgpu/mmhub4.2.0: add bounds checking for cid")
  04f063d85090f ("drm/amdgpu/mmhub4.1.0: add bounds checking for cid")
  f14f27bbe2a3e ("drm/amdgpu/mmhub3.0: add bounds checking for cid")
  1441f52c7f6ae ("drm/amdgpu/mmhub3.0.2: add bounds checking for cid")
  5f76083183363 ("drm/amdgpu/mmhub3.0.1: add bounds checking for cid")
  89cd90375c19f ("drm/amdgpu/mmhub2.3: add bounds checking for cid")
  e064cef4b5355 ("drm/amdgpu/mmhub2.0: add bounds checking for cid")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 8eba99aa0f8fa,1ca0202cfdea8..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@@ -660,42 -660,7 +660,7 @@@ static int gmc_v9_0_process_interrupt(s
  			gfxhub_client_ids[cid],
  			cid);
  	} else {
- 		switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
- 		case IP_VERSION(9, 0, 0):
- 			mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_vega10) ?
- 				mmhub_client_ids_vega10[cid][rw] : NULL;
- 			break;
- 		case IP_VERSION(9, 3, 0):
- 			mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_vega12) ?
- 				mmhub_client_ids_vega12[cid][rw] : NULL;
- 			break;
- 		case IP_VERSION(9, 4, 0):
- 			mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_vega20) ?
- 				mmhub_client_ids_vega20[cid][rw] : NULL;
- 			break;
- 		case IP_VERSION(9, 4, 1):
- 			mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_arcturus) ?
- 				mmhub_client_ids_arcturus[cid][rw] : NULL;
- 			break;
- 		case IP_VERSION(9, 1, 0):
- 		case IP_VERSION(9, 2, 0):
- 			mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_raven) ?
- 				mmhub_client_ids_raven[cid][rw] : NULL;
- 			break;
- 		case IP_VERSION(1, 5, 0):
- 		case IP_VERSION(2, 4, 0):
- 			mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_renoir) ?
- 				mmhub_client_ids_renoir[cid][rw] : NULL;
- 			break;
- 		case IP_VERSION(1, 8, 0):
- 		case IP_VERSION(9, 4, 2):
- 			mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_aldebaran) ?
- 				mmhub_client_ids_aldebaran[cid][rw] : NULL;
- 			break;
- 		default:
- 			mmhub_cid =3D NULL;
- 			break;
- 		}
+ 		mmhub_cid =3D amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
  		dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
  			mmhub_cid ? mmhub_cid : "unknown", cid);
  	}
@@@ -1435,6 -1400,52 +1400,52 @@@ static void gmc_v9_0_set_umc_funcs(stru
  	}
  }
 =20
+ static void gmc_v9_0_init_mmhub_client_info(struct amdgpu_device *adev)
+ {
+ 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+ 	case IP_VERSION(9, 0, 0):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_vega10,
+ 					     ARRAY_SIZE(mmhub_client_ids_vega10));
+ 		break;
+ 	case IP_VERSION(9, 3, 0):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_vega12,
+ 					     ARRAY_SIZE(mmhub_client_ids_vega12));
+ 		break;
+ 	case IP_VERSION(9, 4, 0):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_vega20,
+ 					     ARRAY_SIZE(mmhub_client_ids_vega20));
+ 		break;
+ 	case IP_VERSION(9, 4, 1):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_arcturus,
+ 					     ARRAY_SIZE(mmhub_client_ids_arcturus));
+ 		break;
+ 	case IP_VERSION(9, 1, 0):
+ 	case IP_VERSION(9, 2, 0):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_raven,
+ 					     ARRAY_SIZE(mmhub_client_ids_raven));
+ 		break;
+ 	case IP_VERSION(1, 5, 0):
+ 	case IP_VERSION(2, 4, 0):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_renoir,
+ 					     ARRAY_SIZE(mmhub_client_ids_renoir));
+ 		break;
+ 	case IP_VERSION(1, 8, 0):
+ 	case IP_VERSION(9, 4, 2):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_aldebaran,
+ 					     ARRAY_SIZE(mmhub_client_ids_aldebaran));
+ 		break;
+ 	default:
+ 		break;
+ 	}
+ }
+=20
  static void gmc_v9_0_set_mmhub_funcs(struct amdgpu_device *adev)
  {
  	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
@@@ -1452,6 -1463,8 +1463,8 @@@
  		adev->mmhub.funcs =3D &mmhub_v1_0_funcs;
  		break;
  	}
+=20
+ 	gmc_v9_0_init_mmhub_client_info(adev);
  }
 =20
  static void gmc_v9_0_set_mmhub_ras_funcs(struct amdgpu_device *adev)
diff --combined drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 534cb4c544dc4,42a09a277ec3e..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@@ -141,7 -141,7 +141,7 @@@ mmhub_v2_0_print_l2_protection_fault_st
  					     uint32_t status)
  {
  	uint32_t cid, rw;
- 	const char *mmhub_cid =3D NULL;
+ 	const char *mmhub_cid;
 =20
  	cid =3D REG_GET_FIELD(status,
  			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@@ -151,25 -151,7 +151,7 @@@
  	dev_err(adev->dev,
  		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
  		status);
- 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
- 	case IP_VERSION(2, 0, 0):
- 	case IP_VERSION(2, 0, 2):
- 		mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_navi1x) ?
- 			mmhub_client_ids_navi1x[cid][rw] : NULL;
- 		break;
- 	case IP_VERSION(2, 1, 0):
- 	case IP_VERSION(2, 1, 1):
- 		mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_sienna_cichlid) ?
- 			mmhub_client_ids_sienna_cichlid[cid][rw] : NULL;
- 		break;
- 	case IP_VERSION(2, 1, 2):
- 		mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_beige_goby) ?
- 			mmhub_client_ids_beige_goby[cid][rw] : NULL;
- 		break;
- 	default:
- 		mmhub_cid =3D NULL;
- 		break;
- 	}
+ 	mmhub_cid =3D amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
  	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
  		mmhub_cid ? mmhub_cid : "unknown", cid);
  	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@@ -521,6 -503,31 +503,31 @@@ static const struct amdgpu_vmhub_funcs=20
  	.get_invalidate_req =3D mmhub_v2_0_get_invalidate_req,
  };
 =20
+ static void mmhub_v2_0_init_client_info(struct amdgpu_device *adev)
+ {
+ 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
+ 	case IP_VERSION(2, 0, 0):
+ 	case IP_VERSION(2, 0, 2):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_navi1x,
+ 					     ARRAY_SIZE(mmhub_client_ids_navi1x));
+ 		break;
+ 	case IP_VERSION(2, 1, 0):
+ 	case IP_VERSION(2, 1, 1):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_sienna_cichlid,
+ 					     ARRAY_SIZE(mmhub_client_ids_sienna_cichlid));
+ 		break;
+ 	case IP_VERSION(2, 1, 2):
+ 		amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 					     mmhub_client_ids_beige_goby,
+ 					     ARRAY_SIZE(mmhub_client_ids_beige_goby));
+ 		break;
+ 	default:
+ 		break;
+ 	}
+ }
+=20
  static void mmhub_v2_0_init(struct amdgpu_device *adev)
  {
  	struct amdgpu_vmhub *hub =3D &adev->vmhub[AMDGPU_MMHUB0(0)];
@@@ -561,6 -568,8 +568,8 @@@
  		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 =20
  	hub->vmhub_funcs =3D &mmhub_v2_0_vmhub_funcs;
+=20
+ 	mmhub_v2_0_init_client_info(adev);
  }
 =20
  static void mmhub_v2_0_update_medium_grain_clock_gating(struct amdgpu_dev=
ice *adev,
diff --combined drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index ceb2f6b46de52,31c479d76c421..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@@ -80,7 -80,7 +80,7 @@@ mmhub_v2_3_print_l2_protection_fault_st
  					     uint32_t status)
  {
  	uint32_t cid, rw;
- 	const char *mmhub_cid =3D NULL;
+ 	const char *mmhub_cid;
 =20
  	cid =3D REG_GET_FIELD(status,
  			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@@ -90,17 -90,7 +90,7 @@@
  	dev_err(adev->dev,
  		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
  		status);
- 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
- 	case IP_VERSION(2, 3, 0):
- 	case IP_VERSION(2, 4, 0):
- 	case IP_VERSION(2, 4, 1):
- 		mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_vangogh) ?
- 			mmhub_client_ids_vangogh[cid][rw] : NULL;
- 		break;
- 	default:
- 		mmhub_cid =3D NULL;
- 		break;
- 	}
+ 	mmhub_cid =3D amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
  	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
  		mmhub_cid ? mmhub_cid : "unknown", cid);
  	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@@ -487,6 -477,10 +477,10 @@@ static void mmhub_v2_3_init(struct amdg
  		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 =20
  	hub->vmhub_funcs =3D &mmhub_v2_3_vmhub_funcs;
+=20
+ 	amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 				     mmhub_client_ids_vangogh,
+ 				     ARRAY_SIZE(mmhub_client_ids_vangogh));
  }
 =20
  static void
diff --combined drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index ab966e69a342a,3d82cfa0f1b51..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@@ -97,7 -97,7 +97,7 @@@ mmhub_v3_0_print_l2_protection_fault_st
  					     uint32_t status)
  {
  	uint32_t cid, rw;
- 	const char *mmhub_cid =3D NULL;
+ 	const char *mmhub_cid;
 =20
  	cid =3D REG_GET_FIELD(status,
  			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@@ -107,16 -107,7 +107,7 @@@
  	dev_err(adev->dev,
  		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
  		status);
- 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
- 	case IP_VERSION(3, 0, 0):
- 	case IP_VERSION(3, 0, 1):
- 		mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_v3_0_0) ?
- 			mmhub_client_ids_v3_0_0[cid][rw] : NULL;
- 		break;
- 	default:
- 		mmhub_cid =3D NULL;
- 		break;
- 	}
+ 	mmhub_cid =3D amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
  	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
  		mmhub_cid ? mmhub_cid : "unknown", cid);
  	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@@ -521,6 -512,10 +512,10 @@@ static void mmhub_v3_0_init(struct amdg
  		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_CONTEXTS_DISABLE);
 =20
  	hub->vmhub_funcs =3D &mmhub_v3_0_vmhub_funcs;
+=20
+ 	amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 				     mmhub_client_ids_v3_0_0,
+ 				     ARRAY_SIZE(mmhub_client_ids_v3_0_0));
  }
 =20
  static u64 mmhub_v3_0_get_fb_location(struct amdgpu_device *adev)
diff --combined drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 14a742d3a99d7,a1b0b7b39a42a..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@@ -104,7 -104,7 +104,7 @@@ mmhub_v3_0_1_print_l2_protection_fault_
  					      uint32_t status)
  {
  	uint32_t cid, rw;
- 	const char *mmhub_cid =3D NULL;
+ 	const char *mmhub_cid;
 =20
  	cid =3D REG_GET_FIELD(status,
  			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@@ -114,17 -114,7 +114,7 @@@
  	dev_err(adev->dev,
  		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
  		status);
-=20
- 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
- 	case IP_VERSION(3, 0, 1):
- 		mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_v3_0_1) ?
- 			mmhub_client_ids_v3_0_1[cid][rw] : NULL;
- 		break;
- 	default:
- 		mmhub_cid =3D NULL;
- 		break;
- 	}
-=20
+ 	mmhub_cid =3D amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
  	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
  		mmhub_cid ? mmhub_cid : "unknown", cid);
  	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@@ -504,6 -494,10 +494,10 @@@ static void mmhub_v3_0_1_init(struct am
  		MMVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 =20
  	hub->vmhub_funcs =3D &mmhub_v3_0_1_vmhub_funcs;
+=20
+ 	amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 				     mmhub_client_ids_v3_0_1,
+ 				     ARRAY_SIZE(mmhub_client_ids_v3_0_1));
  }
 =20
  static u64 mmhub_v3_0_1_get_fb_location(struct amdgpu_device *adev)
diff --combined drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index e1f07f2a18527,34e8dbd47c0f8..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@@ -97,7 -97,7 +97,7 @@@ mmhub_v3_0_2_print_l2_protection_fault_
  					     uint32_t status)
  {
  	uint32_t cid, rw;
- 	const char *mmhub_cid =3D NULL;
+ 	const char *mmhub_cid;
 =20
  	cid =3D REG_GET_FIELD(status,
  			    MMVM_L2_PROTECTION_FAULT_STATUS, CID);
@@@ -107,9 -107,7 +107,7 @@@
  	dev_err(adev->dev,
  		"MMVM_L2_PROTECTION_FAULT_STATUS:0x%08X\n",
  		status);
-=20
- 	mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_v3_0_2) ?
- 		mmhub_client_ids_v3_0_2[cid][rw] : NULL;
+ 	mmhub_cid =3D amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
  	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
  		mmhub_cid ? mmhub_cid : "unknown", cid);
  	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@@ -510,6 -508,10 +508,10 @@@ static void mmhub_v3_0_2_init(struct am
  		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_L2_BANK_SELECT_RESERVED_CID2);
 =20
  	hub->vmhub_funcs =3D &mmhub_v3_0_2_vmhub_funcs;
+=20
+ 	amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 				     mmhub_client_ids_v3_0_2,
+ 				     ARRAY_SIZE(mmhub_client_ids_v3_0_2));
  }
 =20
  static u64 mmhub_v3_0_2_get_fb_location(struct amdgpu_device *adev)
diff --combined drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
index 88bfe321f83aa,bef75c4c48d3e..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_1_0.c
@@@ -90,7 -90,7 +90,7 @@@ mmhub_v4_1_0_print_l2_protection_fault_
  					      uint32_t status)
  {
  	uint32_t cid, rw;
- 	const char *mmhub_cid =3D NULL;
+ 	const char *mmhub_cid;
 =20
  	cid =3D REG_GET_FIELD(status,
  			    MMVM_L2_PROTECTION_FAULT_STATUS_LO32, CID);
@@@ -100,15 -100,7 +100,7 @@@
  	dev_err(adev->dev,
  		"MMVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
  		status);
- 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
- 	case IP_VERSION(4, 1, 0):
- 		mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_v4_1_0) ?
- 			mmhub_client_ids_v4_1_0[cid][rw] : NULL;
- 		break;
- 	default:
- 		mmhub_cid =3D NULL;
- 		break;
- 	}
+ 	mmhub_cid =3D amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
  	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
  		mmhub_cid ? mmhub_cid : "unknown", cid);
  	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@@ -515,6 -507,10 +507,10 @@@ static void mmhub_v4_1_0_init(struct am
  		SOC15_REG_OFFSET(MMHUB, 0, regMMVM_CONTEXTS_DISABLE);
 =20
  	hub->vmhub_funcs =3D &mmhub_v4_1_0_vmhub_funcs;
+=20
+ 	amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 				     mmhub_client_ids_v4_1_0,
+ 				     ARRAY_SIZE(mmhub_client_ids_v4_1_0));
  }
 =20
  static u64 mmhub_v4_1_0_get_fb_location(struct amdgpu_device *adev)
diff --combined drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 2532ca80f7356,29f7ed4668587..0000000000000
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@@ -72,6 -72,45 +72,45 @@@ static const char *mmhub_client_ids_v4_
  	[23][1] =3D "VCN1",
  };
 =20
+ static int mmhub_v4_2_0_get_xgmi_info(struct amdgpu_device *adev)
+ {
+ 	u32 max_num_physical_nodes;
+ 	u32 max_physical_node_id;
+ 	u32 xgmi_lfb_cntl;
+ 	u32 max_region;
+ 	u64 seg_size;
+=20
+ 	/* limit this callback to A + A configuration only */
+ 	if (!adev->gmc.xgmi.connected_to_cpu)
+ 		return 0;
+=20
+ 	xgmi_lfb_cntl =3D RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
+ 				     regMMMC_VM_XGMI_LFB_CNTL);
+ 	seg_size =3D REG_GET_FIELD(
+ 		RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0), regMMMC_VM_XGMI_LFB_SIZE),
+ 		MMMC_VM_XGMI_LFB_SIZE, PF_LFB_SIZE) << 24;
+ 	max_region =3D
+ 		REG_GET_FIELD(xgmi_lfb_cntl, MMMC_VM_XGMI_LFB_CNTL, PF_MAX_REGION);
+=20
+ 	max_num_physical_nodes   =3D 4;
+ 	max_physical_node_id     =3D 3;
+=20
+ 	adev->gmc.xgmi.num_physical_nodes =3D max_region + 1;
+=20
+ 	if (adev->gmc.xgmi.num_physical_nodes > max_num_physical_nodes)
+ 		return -EINVAL;
+=20
+ 	adev->gmc.xgmi.physical_node_id =3D
+ 		REG_GET_FIELD(xgmi_lfb_cntl, MMMC_VM_XGMI_LFB_CNTL, PF_LFB_REGION);
+=20
+ 	if (adev->gmc.xgmi.physical_node_id > max_physical_node_id)
+ 		return -EINVAL;
+=20
+ 	adev->gmc.xgmi.node_segment_size =3D seg_size;
+=20
+ 	return 0;
+ }
+=20
  static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
  {
  	u64 base;
@@@ -131,7 -170,7 +170,7 @@@ static void mmhub_v4_2_0_setup_vm_pt_re
  static void mmhub_v4_2_0_mid_init_gart_aperture_regs(struct amdgpu_device=
 *adev,
  						     uint32_t mid_mask)
  {
- 	uint64_t pt_base =3D amdgpu_gmc_pd_addr(adev->gart.bo);
+ 	uint64_t pt_base;
  	int i;
 =20
  	if (adev->gmc.pdb0_bo)
@@@ -152,10 -191,10 +191,10 @@@
 =20
  			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
  				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_LO32,
- 				     (u32)(adev->gmc.fb_end >> 12));
+ 				     (u32)(adev->gmc.gart_end >> 12));
  			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
  				     regMMVM_CONTEXT0_PAGE_TABLE_END_ADDR_HI32,
- 				     (u32)(adev->gmc.fb_end >> 44));
+ 				     (u32)(adev->gmc.gart_end >> 44));
  		} else {
  			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
  				     regMMVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
@@@ -190,41 -229,74 +229,74 @@@ static void mmhub_v4_2_0_mid_init_syste
  		return;
 =20
  	for_each_inst(i, mid_mask) {
- 		/* Program the AGP BAR */
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_BASE_LO32, 0);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_BASE_HI32, 0);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_BOT_LO32,
- 			     lower_32_bits(adev->gmc.agp_start >> 24));
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_BOT_HI32,
- 			     upper_32_bits(adev->gmc.agp_start >> 24));
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_TOP_LO32,
- 			     lower_32_bits(adev->gmc.agp_end >> 24));
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_TOP_HI32,
- 			     upper_32_bits(adev->gmc.agp_end >> 24));
+ 		if (adev->gmc.pdb0_bo) {
+ 			/* Disable agp and system aperture
+ 			 * when vmid0 page table is enabled */
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_FB_LOCATION_TOP_LO32, 0);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_FB_LOCATION_TOP_HI32, 0);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_FB_LOCATION_BASE_LO32,
+ 				     0xFFFFFFFF);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_FB_LOCATION_BASE_HI32, 1);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_TOP_LO32, 0);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_TOP_HI32, 0);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_BOT_LO32,
+ 				     0xFFFFFFFF);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_BOT_HI32, 1);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+ 				     0xFFFFFFFF);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+ 				     0x7F);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32, 0);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32, 0);
+ 		} else {
+ 			/* Program the AGP BAR */
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_BASE_LO32, 0);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_BASE_HI32, 0);
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_BOT_LO32,
+ 				     lower_32_bits(adev->gmc.agp_start >> 24));
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_BOT_HI32,
+ 				     upper_32_bits(adev->gmc.agp_start >> 24));
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_TOP_LO32,
+ 				     lower_32_bits(adev->gmc.agp_end >> 24));
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_AGP_TOP_HI32,
+ 				     upper_32_bits(adev->gmc.agp_end >> 24));
 =20
- 		/* Program the system aperture low logical page number. */
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
- 			     lower_32_bits(min(adev->gmc.fb_start,
- 					       adev->gmc.agp_start) >> 18));
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
- 			     upper_32_bits(min(adev->gmc.fb_start,
- 					       adev->gmc.agp_start) >> 18));
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
- 			     lower_32_bits(max(adev->gmc.fb_end,
- 					       adev->gmc.agp_end) >> 18));
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
- 			     upper_32_bits(max(adev->gmc.fb_end,
- 					       adev->gmc.agp_end) >> 18));
+ 			/* Program the system aperture low logical page number. */
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
+ 				     lower_32_bits(min(adev->gmc.fb_start,
+ 						   adev->gmc.agp_start) >> 18));
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
+ 				     upper_32_bits(min(adev->gmc.fb_start,
+ 						   adev->gmc.agp_start) >> 18));
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32,
+ 				     lower_32_bits(max(adev->gmc.fb_end,
+ 						   adev->gmc.agp_end) >> 18));
+ 			WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
+ 				     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32,
+ 				     upper_32_bits(max(adev->gmc.fb_end,
+ 						   adev->gmc.agp_end) >> 18));
+ 		}
 =20
  		/* Set default page address. */
  		value =3D amdgpu_gmc_vram_mc2pa(adev, adev->mem_scratch.gpu_addr);
@@@ -252,38 -324,6 +324,6 @@@
  		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
  			     regMMVM_L2_PROTECTION_FAULT_CNTL2, tmp);
  	}
-=20
- 	/* In the case squeezing vram into GART aperture, we don't use
- 	 * FB aperture and AGP aperture. Disable them.
- 	 */
- 	if (adev->gmc.pdb0_bo) {
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_FB_LOCATION_TOP_LO32, 0);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_FB_LOCATION_TOP_HI32, 0);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_FB_LOCATION_BASE_LO32, 0xFFFFFFFF);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_FB_LOCATION_BASE_HI32, 1);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_TOP_LO32, 0);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_TOP_HI32, 0);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_BOT_LO32, 0xFFFFFFFF);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_AGP_BOT_HI32, 1);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_LO32,
- 			     0xFFFFFFFF);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_SYSTEM_APERTURE_LOW_ADDR_HI32,
- 			     0x7F);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_LO32, 0);
- 		WREG32_SOC15(MMHUB, GET_INST(MMHUB, i),
- 			     regMMMC_VM_SYSTEM_APERTURE_HIGH_ADDR_HI32, 0);
- 	}
  }
 =20
  static void mmhub_v4_2_0_mid_init_tlb_regs(struct amdgpu_device *adev,
@@@ -676,7 -716,7 +716,7 @@@ mmhub_v4_2_0_print_l2_protection_fault_
  					      uint32_t status)
  {
  	uint32_t cid, rw;
- 	const char *mmhub_cid =3D NULL;
+ 	const char *mmhub_cid;
 =20
  	cid =3D REG_GET_FIELD(status,
  			    MMVM_L2_PROTECTION_FAULT_STATUS_LO32, CID);
@@@ -686,15 -726,7 +726,7 @@@
  	dev_err(adev->dev,
  		"MMVM_L2_PROTECTION_FAULT_STATUS_LO32:0x%08X\n",
  		status);
- 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
- 	case IP_VERSION(4, 2, 0):
- 		mmhub_cid =3D cid < ARRAY_SIZE(mmhub_client_ids_v4_2_0) ?
- 			mmhub_client_ids_v4_2_0[cid][rw] : NULL;
- 		break;
- 	default:
- 		mmhub_cid =3D NULL;
- 		break;
- 	}
+ 	mmhub_cid =3D amdgpu_mmhub_client_name(&adev->mmhub, cid, rw);
  	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
  		mmhub_cid ? mmhub_cid : "unknown", cid);
  	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
@@@ -785,6 -817,10 +817,10 @@@ static void mmhub_v4_2_0_init(struct am
 =20
  	mid_mask =3D adev->aid_mask;
  	mmhub_v4_2_0_mid_init(adev, mid_mask);
+=20
+ 	amdgpu_mmhub_init_client_info(&adev->mmhub,
+ 				     mmhub_client_ids_v4_2_0,
+ 				     ARRAY_SIZE(mmhub_client_ids_v4_2_0));
  }
 =20
  static void
@@@ -884,6 -920,7 +920,7 @@@ const struct amdgpu_mmhub_funcs mmhub_v
  	.set_fault_enable_default =3D mmhub_v4_2_0_set_fault_enable_default,
  	.set_clockgating =3D mmhub_v4_2_0_set_clockgating,
  	.get_clockgating =3D mmhub_v4_2_0_get_clockgating,
+ 	.get_xgmi_info =3D mmhub_v4_2_0_get_xgmi_info,
  };
 =20
  static int mmhub_v4_2_0_xcp_resume(void *handle, uint32_t inst_mask)

--bIOc6m73MNL8ArAQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnBVb8ACgkQJNaLcl1U
h9DVSQf/Y+0VjP8505R81wh7OHH7VsHzfXbqwvXViW4U6QdyOdtOckEF4UFAbdFc
+hDLxGUb4b+ePc7mKcMU3iJBCv5oS2ADE/IrJUImcju5m2psApIf5V3ryPHQPFkW
0cX74HssylGoroUbDqSLLR2iApGGLREsyLJAOfUDBLk9b22hG3/lznIQm/qLsXJm
bqd6Ib7PK1/jPXACdpr9MAh0Pc8G5gSskOiQK6L3/TS1UNFvFMaw4HO9KtRhVCMK
jBy/x1ypsimZnYBkP/qzhFHNMfV0GzWYyxIURzOtZKpgjl74ELkX0p53OR8AX+KL
k4kYx/XKuZPJIHwHsuvAzyDih76uyA==
=KEq1
-----END PGP SIGNATURE-----

--bIOc6m73MNL8ArAQ--
