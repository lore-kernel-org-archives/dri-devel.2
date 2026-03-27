Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0867110F2865
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 20:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A7F010EF43;
	Fri, 27 Mar 2026 20:46:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OR7jsRGD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50C1210EF43
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 20:46:44 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 17E7C406F6;
 Fri, 27 Mar 2026 20:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D1FC19423;
 Fri, 27 Mar 2026 20:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774644404;
 bh=gqe4LAGuCb4RtNvmNg6tR8B3xrEJPSnvi6SSrFFEZsk=;
 h=Date:From:To:Cc:Subject:From;
 b=OR7jsRGDazG0LJKVljWvz3UC+P0ro+r3ZEmAgwmagwSkHj4KH4/LgvCCST1A6jnVo
 a8jukvK+7iLGVIR/vDeA1JMWD8a7LC5MLKe0xhrM62GFULrqzzFv8DEUAnbtSlobzN
 8zC+4ZypFnpr8mW+plCSz3k2tyE44aJajDW9nuqH7BifIOPImW3zt2O1GjnhKQcEJI
 EI8JTmL1GdVlrlDi+Uv6pQ8iKO/9EBC+gpT96TKNMcQwYzp4Tx8H2toAFKwGE4Dzdx
 4GrkQR7isEdsQ4K3NVwqYnzfegbv3h19s/h75mFHZIWoLkTP04Tx6AtsIo4s50hkRV
 kuvxETggLt+9A==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
 id 3E31C1AC589B; Fri, 27 Mar 2026 20:46:41 +0000 (GMT)
Date: Fri, 27 Mar 2026 20:46:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Asad Kamal <asad.kamal@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-fixes tree
Message-ID: <acbssTMtPLungKX4@sirena.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P1k9K3V0XLk0kG/u"
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


--P1k9K3V0XLk0kG/u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c

between commit:

  cdbc3b62cfc278 ("drm/amd/pm: Skip redundant UCLK restore in smu_v13_0_6")

=66rom the drm-fixes tree and commits:

  17f11bbbc76c8e ("drm/amd/pm: Skip redundant UCLK restore in smu_v13_0_6")
  5da89a8afca14a ("drm/amd/pm: Add custom fclk setting support")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 870bcc86fd7948,47554118978298..00000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@@ -373,6 -373,9 +373,9 @@@ static void smu_v13_0_12_init_caps(stru
  	} else {
  		smu_v13_0_12_tables_fini(smu);
  	}
+=20
+ 	if (fw_ver >=3D 0x04561000)
+ 		smu_v13_0_6_cap_set(smu, SMU_CAP(TEMP_AID_XCD_HBM));
  }
 =20
  static void smu_v13_0_6_init_caps(struct smu_context *smu)
@@@ -458,6 -461,7 +461,7 @@@
  		smu_v13_0_6_cap_set(smu, SMU_CAP(SDMA_RESET));
 =20
  	if ((pgm =3D=3D 0 && fw_ver >=3D 0x00558200) ||
+ 	    (pgm =3D=3D 4 && fw_ver >=3D 0x04557100) ||
  	    (pgm =3D=3D 7 && fw_ver >=3D 0x07551400))
  		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
  }
@@@ -478,7 -482,7 +482,7 @@@ static int smu_v13_0_6_check_fw_version
  {
  	int r;
 =20
- 	r =3D smu_v13_0_check_fw_version(smu);
+ 	r =3D smu_cmn_check_fw_version(smu);
  	/* Initialize caps flags once fw version is fetched */
  	if (!r)
  		smu_v13_0_x_init_caps(smu);
@@@ -1196,6 -1200,7 +1200,7 @@@ static int smu_v13_0_6_populate_umd_sta
  	struct smu_dpm_table *gfx_table =3D &dpm_context->dpm_tables.gfx_table;
  	struct smu_dpm_table *mem_table =3D &dpm_context->dpm_tables.uclk_table;
  	struct smu_dpm_table *soc_table =3D &dpm_context->dpm_tables.soc_table;
+ 	struct smu_dpm_table *fclk_table =3D &dpm_context->dpm_tables.fclk_table;
  	struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
 =20
  	pstate_table->gfxclk_pstate.min =3D SMU_DPM_TABLE_MIN(gfx_table);
@@@ -1213,6 -1218,12 +1218,12 @@@
  	pstate_table->socclk_pstate.curr.min =3D SMU_DPM_TABLE_MIN(soc_table);
  	pstate_table->socclk_pstate.curr.max =3D SMU_DPM_TABLE_MAX(soc_table);
 =20
+ 	pstate_table->fclk_pstate.min =3D SMU_DPM_TABLE_MIN(fclk_table);
+ 	pstate_table->fclk_pstate.peak =3D SMU_DPM_TABLE_MAX(fclk_table);
+ 	pstate_table->fclk_pstate.curr.min =3D SMU_DPM_TABLE_MIN(fclk_table);
+ 	pstate_table->fclk_pstate.curr.max =3D SMU_DPM_TABLE_MAX(fclk_table);
+ 	pstate_table->fclk_pstate.standard =3D SMU_DPM_TABLE_MIN(fclk_table);
+=20
  	if (gfx_table->count > SMU_13_0_6_UMD_PSTATE_GFXCLK_LEVEL &&
  	    mem_table->count > SMU_13_0_6_UMD_PSTATE_MCLK_LEVEL &&
  	    soc_table->count > SMU_13_0_6_UMD_PSTATE_SOCCLK_LEVEL) {
@@@ -1398,7 -1409,15 +1409,15 @@@ static int smu_v13_0_6_emit_clk_levels(
  				      pstate_table->uclk_pstate.curr.min,
  				      pstate_table->uclk_pstate.curr.max);
  		break;
+ 	case SMU_OD_FCLK:
+ 		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT))
+ 			return -EOPNOTSUPP;
 =20
+ 		size +=3D sysfs_emit_at(buf, size, "%s:\n", "OD_FCLK");
+ 		size +=3D sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+ 				      pstate_table->fclk_pstate.curr.min,
+ 				      pstate_table->fclk_pstate.curr.max);
+ 		break;
  	case SMU_SCLK:
  	case SMU_GFXCLK:
  		single_dpm_table =3D &(dpm_context->dpm_tables.gfx_table);
@@@ -2040,7 -2059,7 +2059,7 @@@ static int smu_v13_0_6_set_soft_freq_li
  	int ret =3D 0;
 =20
  	if (clk_type !=3D SMU_GFXCLK && clk_type !=3D SMU_SCLK &&
- 	    clk_type !=3D SMU_UCLK)
+ 	    clk_type !=3D SMU_UCLK && clk_type !=3D SMU_FCLK)
  		return -EINVAL;
 =20
  	if ((smu_dpm->dpm_level !=3D AMD_DPM_FORCED_LEVEL_MANUAL) &&
@@@ -2081,6 -2100,15 +2100,15 @@@
  				pstate_table->uclk_pstate.curr.max =3D max;
  		}
 =20
+ 		if (clk_type =3D=3D SMU_FCLK) {
+ 			if (max =3D=3D pstate_table->fclk_pstate.curr.max)
+ 				return 0;
+=20
+ 			ret =3D smu_v13_0_set_soft_freq_limited_range(smu, SMU_FCLK, 0, max, f=
alse);
+ 			if (!ret)
+ 				pstate_table->fclk_pstate.curr.max =3D max;
+ 		}
+=20
  		return ret;
  	}
 =20
@@@ -2123,6 -2151,7 +2151,7 @@@ static int smu_v13_0_6_usr_edit_dpm_tab
  	struct smu_dpm_context *smu_dpm =3D &(smu->smu_dpm);
  	struct smu_13_0_dpm_context *dpm_context =3D smu_dpm->dpm_context;
  	struct smu_dpm_table *uclk_table =3D &dpm_context->dpm_tables.uclk_table;
+ 	struct smu_dpm_table *fclk_table =3D &dpm_context->dpm_tables.fclk_table;
  	struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
  	uint32_t min_clk;
  	uint32_t max_clk;
@@@ -2203,6 -2232,40 +2232,40 @@@
  			pstate_table->uclk_pstate.custom.max =3D input[1];
  		}
  		break;
+ 	case PP_OD_EDIT_FCLK_TABLE:
+ 		if (size !=3D 2) {
+ 			dev_err(smu->adev->dev,
+ 				"Input parameter number not correct\n");
+ 			return -EINVAL;
+ 		}
+=20
+ 		if (!smu_cmn_feature_is_enabled(smu,
+ 						SMU_FEATURE_DPM_FCLK_BIT)) {
+ 			dev_warn(smu->adev->dev,
+ 				 "FCLK limits setting not supported!\n");
+ 			return -EOPNOTSUPP;
+ 		}
+=20
+ 		max_clk =3D SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
+ 		if (input[0] =3D=3D 0) {
+ 			dev_info(smu->adev->dev,
+ 				 "Setting min FCLK level is not supported\n");
+ 			return -EOPNOTSUPP;
+ 		} else if (input[0] =3D=3D 1) {
+ 			if (input[1] > max_clk) {
+ 				dev_warn(smu->adev->dev,
+ 					 "Maximum FCLK (%ld) MHz specified is greater than the maximum allow=
ed (%d) MHz\n",
+ 					 input[1], max_clk);
+ 				pstate_table->fclk_pstate.custom.max =3D
+ 					pstate_table->fclk_pstate.curr.max;
+ 				return -EINVAL;
+ 			}
+=20
+ 			pstate_table->fclk_pstate.custom.max =3D input[1];
+ 		} else {
+ 			return -EINVAL;
+ 		}
+ 		break;
 =20
  	case PP_OD_RESTORE_DEFAULT_TABLE:
  		if (size !=3D 0) {
@@@ -2232,6 -2295,17 +2295,17 @@@
  				if (ret)
  					return ret;
  			}
+=20
+ 			if (SMU_DPM_TABLE_MAX(fclk_table) !=3D
+ 			    pstate_table->fclk_pstate.curr.max) {
+ 				max_clk =3D SMU_DPM_TABLE_MAX(&dpm_context->dpm_tables.fclk_table);
+ 				min_clk =3D SMU_DPM_TABLE_MIN(&dpm_context->dpm_tables.fclk_table);
+ 				ret =3D smu_v13_0_6_set_soft_freq_limited_range(smu,
+ 									      SMU_FCLK, min_clk,
+ 									      max_clk, false);
+ 				if (ret)
+ 					return ret;
+ 			}
  			smu_v13_0_reset_custom_level(smu);
  		}
  		break;
@@@ -2258,6 -2332,16 +2332,16 @@@
  			if (ret)
  				return ret;
 =20
+ 			if (pstate_table->fclk_pstate.custom.max) {
+ 				min_clk =3D pstate_table->fclk_pstate.curr.min;
+ 				max_clk =3D pstate_table->fclk_pstate.custom.max;
+ 				ret =3D smu_v13_0_6_set_soft_freq_limited_range(smu,
+ 									      SMU_FCLK, min_clk,
+ 									      max_clk, false);
+ 				if (ret)
+ 					return ret;
+ 			}
+=20
  			if (!pstate_table->uclk_pstate.custom.max)
  				return 0;
 =20
@@@ -3163,14 -3247,25 +3247,25 @@@ static int smu_v13_0_6_reset_vcn(struc
 =20
  static int smu_v13_0_6_ras_send_msg(struct smu_context *smu, enum smu_mes=
sage_type msg, uint32_t param, uint32_t *read_arg)
  {
+ 	struct amdgpu_device *adev =3D smu->adev;
  	int ret;
 =20
+ 	if (amdgpu_sriov_vf(adev))
+ 		return -EOPNOTSUPP;
+=20
  	switch (msg) {
  	case SMU_MSG_QueryValidMcaCount:
  	case SMU_MSG_QueryValidMcaCeCount:
  	case SMU_MSG_McaBankDumpDW:
  	case SMU_MSG_McaBankCeDumpDW:
  	case SMU_MSG_ClearMcaOnRead:
+ 	case SMU_MSG_GetRASTableVersion:
+ 	case SMU_MSG_GetBadPageCount:
+ 	case SMU_MSG_GetBadPageMcaAddr:
+ 	case SMU_MSG_SetTimestamp:
+ 	case SMU_MSG_GetTimestamp:
+ 	case SMU_MSG_GetBadPageIpid:
+ 	case SMU_MSG_EraseRasTable:
  		ret =3D smu_cmn_send_smc_msg_with_param(smu, msg, param, read_arg);
  		break;
  	default:

--P1k9K3V0XLk0kG/u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmnG7LAACgkQJNaLcl1U
h9C+PQf+P5GoqNwSc+JuvEt24fNuYCPlEbYpJrQ5YtMnB/7MzMCR0JOHbrqcmBB6
iGadmfumOeeAUoVh+7Trk8rkz9GVGX46KdRWa05ePY+V+LbkFsNxx6GtToxNKUcs
7r7rlVfE7HAz4GEIYWXOafHPsl7GkywEgpflbiK8u/35o5+YUDlsdFRaHyPG9j15
rWB6w5ZVU2DrX1zyyMM59FO2yhTV+ner1VEFQZmWFj1RSZa9bWSA6MXelxB4ilIi
ouctIhxpkCeWHrFUI5RsnKr2CIuRQbaQ5RA+UmB6w3X/n0X6Syf+HlmdogRl9/J7
2yIjltnBns2ySv2lCaL+ZMPWXjIciQ==
=wfmr
-----END PGP SIGNATURE-----

--P1k9K3V0XLk0kG/u--
