Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C8FC5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10F8010E8F1;
	Mon, 10 Aug 2026 15:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Vt8Uw4uT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2AB010E8F1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:02:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 75926600C8;
 Mon, 10 Aug 2026 15:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D201D1F000E9;
 Mon, 10 Aug 2026 15:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786374166;
 bh=nJrdftnA5dFdS9Rs8j4FKwEAwssX5jWSQkP633ZLCy4=;
 h=Date:From:To:Cc:Subject;
 b=Vt8Uw4uTyYxkAae4u3UGB9uZ08ahJ3GtmQK0Y2AZKflGJFNzXhw/i7XqVhdUXEikF
 kxGQjFXhuc1UKLgauA+uaj7oHvmFpdMf05rX1o3OwRGJSGizwFXasOlNVkyIhgZesk
 P7Y896EQYWZFAo8aWEezqZRKyF71aEsx2zDUISpDv/MfBR6E2/OKW2PcIJQjvPVOAb
 EyYYvu/SU6sDtVKtttu4TUWDl8gZ8ZjGAeXW/sWjrvDdlRUzsBSQkVXtsz3GveZPGu
 IGJ4jW9IS5UIeEeNKKV2pPSfrjT0dI+4/CSYf6pzut5b1mb1kkZ696HHg2zfY2XtZt
 eiEIvbuMFg8Bg==
Date: Mon, 10 Aug 2026 16:02:42 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Yang Wang <kevinyang.wang@amd.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <annoEomdInpOqqPO@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rg9/KF51gF/Kfdk0"
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


--rg9/KF51gF/Kfdk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c

between commits:

  e987eabc02646 ("drm/amd/pm: fix smu14 power limit range calculation")
  1849a64165ccc ("drm/amd/pm: use milliwatts for GPU power sensors")

=66rom the origin tree and commits:

  6c9e0328d1dee ("drm/amd/pm: refactor PPT limits by controller and power s=
ource")
  757ba0790bafe ("drm/amd/pm: use milliwatts for GPU power sensors")
  93bd6de5518da ("drm/amd/pm: account for OD percentage in effective PPT li=
mits")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index bd054cbfbae08,1054c4b4b03e1..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@@ -59,6 -59,9 +59,9 @@@
  static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
  					      int od_feature_bit,
  					      int32_t *min, int32_t *max);
+ static int smu_v14_0_2_init_ppt_limits(struct smu_context *smu);
+ static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
+ 					   OverDriveTableExternal_t *od_table);
 =20
  static const struct smu_feature_bits smu_v14_0_2_dpm_features =3D {
  	.bits =3D { SMU_FEATURE_BIT_INIT(FEATURE_DPM_GFXCLK_BIT),
@@@ -370,7 -373,7 +373,7 @@@ static int smu_v14_0_2_setup_pptable(st
  	if (ret)
  		return ret;
 =20
- 	return ret;
+ 	return smu_v14_0_2_init_ppt_limits(smu);
  }
 =20
  static int smu_v14_0_2_tables_init(struct smu_context *smu)
@@@ -1610,58 -1613,69 +1613,69 @@@ static int smu_v14_0_2_get_fan_speed_rp
  						speed);
  }
 =20
- static int smu_v14_0_2_get_power_limit(struct smu_context *smu,
- 				       uint32_t *current_power_limit,
- 				       uint32_t *default_power_limit,
- 				       uint32_t *max_power_limit,
- 				       uint32_t *min_power_limit)
+ static int smu_v14_0_2_get_ppt_limit(struct smu_context *smu,
+ 				     enum smu_ppt_limit_type limit_type,
+ 				     uint32_t *ppt_limit)
+ {
+ 	OverDriveTableExternal_t od_table;
+ 	int ret;
+=20
+ 	if (limit_type !=3D SMU_PPT_LIMIT_PPT0)
+ 		return -EOPNOTSUPP;
+=20
+ 	ret =3D smu_v14_0_get_ppt_limit(smu, limit_type, ppt_limit);
+ 	if (ret)
+ 		return ret;
+=20
+ 	ret =3D smu_v14_0_2_get_overdrive_table(smu, &od_table);
+ 	if (ret)
+ 		return ret;
+=20
+ 	if (od_table.OverDriveTable.Ppt > 0)
+ 		*ppt_limit =3D *ppt_limit *
+ 			(100 + od_table.OverDriveTable.Ppt) / 100;
+=20
+ 	return 0;
+ }
+=20
+ static int smu_v14_0_2_init_ppt_limits(struct smu_context *smu)
  {
  	struct smu_table_context *table_context =3D &smu->smu_table;
  	struct smu_14_0_2_powerplay_table *powerplay_table =3D
  		table_context->power_play_table;
  	PPTable_t *pptable =3D table_context->driver_pptable;
  	CustomSkuTable_t *skutable =3D &pptable->CustomSkuTable;
- 	uint32_t pp_limit =3D smu->adev->pm.ac_power ?
- 		skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
- 		skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
- 	uint32_t msg_limit =3D pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_P=
PT0][POWER_SOURCE_AC];
- 	uint32_t min_limit =3D min_t(uint32_t, pp_limit, msg_limit);
- 	uint32_t max_limit =3D max_t(uint32_t, pp_limit, msg_limit);
  	int16_t od_percent_upper =3D 0, od_percent_lower =3D 0;
- 	int ret;
+ 	uint32_t pp_limit, msg_limit, min_limit, max_limit;
+ 	int i;
 =20
- 	if (current_power_limit) {
- 		ret =3D smu_v14_0_get_current_power_limit(smu, current_power_limit);
- 		if (ret)
- 			*current_power_limit =3D pp_limit;
+ 	if (powerplay_table &&
+ 	    smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
+ 		od_percent_upper =3D pptable->SkuTable.OverDriveLimitsBasicMax.Ppt;
+ 		od_percent_lower =3D pptable->SkuTable.OverDriveLimitsBasicMin.Ppt;
  	}
 =20
- 	if (default_power_limit)
- 		*default_power_limit =3D pp_limit;
+ 	for (i =3D SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT; i++) {
+ 		pp_limit =3D i =3D=3D SMU_POWER_SOURCE_AC ?
+ 			skutable->SocketPowerLimitAc[PPT_THROTTLER_PPT0] :
+ 			skutable->SocketPowerLimitDc[PPT_THROTTLER_PPT0];
+ 		msg_limit =3D pptable->SkuTable.MsgLimits.Power
+ 			[PPT_THROTTLER_PPT0][i];
+ 		min_limit =3D min(pp_limit, msg_limit);
+ 		max_limit =3D max(pp_limit, msg_limit);
 =20
- 	if (powerplay_table) {
- 		if (smu->od_enabled &&
- 		    smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_BIT)) {
- 			od_percent_upper =3D pptable->SkuTable.OverDriveLimitsBasicMax.Ppt;
- 			od_percent_lower =3D pptable->SkuTable.OverDriveLimitsBasicMin.Ppt;
- 		} else if (smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_PPT_B=
IT)) {
- 			od_percent_upper =3D 0;
- 			od_percent_lower =3D pptable->SkuTable.OverDriveLimitsBasicMin.Ppt;
- 		}
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].default_value =3D
+ 			pp_limit;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].max =3D max_limit;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].min =3D
+ 			min_limit * (100 + od_percent_lower) / 100;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].od_max =3D
+ 			max_limit * (100 + od_percent_upper) / 100;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].od_min =3D
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].min;
  	}
 =20
- 	dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d (defau=
lt power: %d)\n",
- 					od_percent_upper, od_percent_lower, pp_limit);
-=20
- 	if (max_power_limit) {
- 		*max_power_limit =3D max_limit * (100 + od_percent_upper);
- 		*max_power_limit /=3D 100;
- 	}
-=20
- 	if (min_power_limit) {
- 		*min_power_limit =3D min_limit * (100 + od_percent_lower);
- 		*min_power_limit /=3D 100;
- 	}
+ 	smu->ppt_limits.supported_mask |=3D BIT(SMU_PPT_LIMIT_PPT0);
 =20
  	return 0;
  }
@@@ -1832,9 -1846,10 +1846,10 @@@ static int smu_v14_0_2_set_power_profil
  				return -ENOMEM;
  		}
  		if (custom_params && custom_params_max_idx) {
- 			if (custom_params_max_idx !=3D SMU_14_0_2_CUSTOM_PARAMS_COUNT)
- 				return -EINVAL;
- 			if (custom_params[0] >=3D SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT)
+ 			if (!smu_cmn_custom_params_count_valid(custom_params_max_idx,
+ 							       SMU_14_0_2_CUSTOM_PARAMS_COUNT) ||
+ 			    !smu_cmn_custom_params_clock_valid(custom_params[0],
+ 							       SMU_14_0_2_CUSTOM_PARAMS_CLOCK_COUNT))
  				return -EINVAL;
  			idx =3D custom_params[0] * SMU_14_0_2_CUSTOM_PARAMS_COUNT;
  			smu->custom_profile_params[idx] =3D 1;
@@@ -2788,22 -2803,28 +2803,28 @@@ static int smu_v14_0_2_od_edit_dpm_tabl
  	return ret;
  }
 =20
- static int smu_v14_0_2_set_power_limit(struct smu_context *smu,
- 				       enum smu_ppt_limit_type limit_type,
- 				       uint32_t limit)
+ static int smu_v14_0_2_set_ppt_limit(struct smu_context *smu,
+ 				     enum smu_ppt_limit_type limit_type,
+ 				     uint32_t limit)
  {
  	PPTable_t *pptable =3D smu->smu_table.driver_pptable;
- 	uint32_t msg_limit =3D pptable->SkuTable.MsgLimits.Power[PPT_THROTTLER_P=
PT0][POWER_SOURCE_AC];
+ 	uint32_t msg_limit =3D pptable->SkuTable.MsgLimits.Power
+ 		[PPT_THROTTLER_PPT0][POWER_SOURCE_AC];
  	struct smu_table_context *table_context =3D &smu->smu_table;
  	OverDriveTableExternal_t *od_table =3D
  		(OverDriveTableExternal_t *)table_context->overdrive_table;
+ 	OverDriveTableExternal_t current_od_table;
  	int ret =3D 0;
 =20
- 	if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT)
+ 	if (limit_type !=3D SMU_PPT_LIMIT_PPT0)
  		return -EINVAL;
 =20
  	if (limit <=3D msg_limit) {
- 		if (smu->current_power_limit > msg_limit) {
+ 		ret =3D smu_v14_0_2_get_overdrive_table(smu, &current_od_table);
+ 		if (ret)
+ 			return ret;
+=20
+ 		if (current_od_table.OverDriveTable.Ppt) {
  			od_table->OverDriveTable.Ppt =3D 0;
  			od_table->OverDriveTable.FeatureCtrlMask |=3D 1U << PP_OD_FEATURE_PPT_=
BIT;
 =20
@@@ -2813,9 -2834,9 +2834,9 @@@
  				return ret;
  			}
  		}
- 		return smu_v14_0_set_power_limit(smu, limit_type, limit);
+ 		return smu_v14_0_set_ppt_limit(smu, limit_type, limit);
  	} else if (smu->od_enabled) {
- 		ret =3D smu_v14_0_set_power_limit(smu, limit_type, msg_limit);
+ 		ret =3D smu_v14_0_set_ppt_limit(smu, limit_type, msg_limit);
  		if (ret)
  			return ret;
 =20
@@@ -2828,7 -2849,6 +2849,6 @@@
  		  return ret;
  		}
 =20
- 		smu->current_power_limit =3D limit;
  	} else {
  		return -EINVAL;
  	}
@@@ -2882,8 -2902,8 +2902,8 @@@ static const struct pptable_funcs smu_v
  	.get_unique_id =3D smu_v14_0_2_get_unique_id,
  	.get_fan_speed_pwm =3D smu_v14_0_2_get_fan_speed_pwm,
  	.get_fan_speed_rpm =3D smu_v14_0_2_get_fan_speed_rpm,
- 	.get_power_limit =3D smu_v14_0_2_get_power_limit,
- 	.set_power_limit =3D smu_v14_0_2_set_power_limit,
+ 	.get_ppt_limit =3D smu_v14_0_2_get_ppt_limit,
+ 	.set_ppt_limit =3D smu_v14_0_2_set_ppt_limit,
  	.get_power_profile_mode =3D smu_v14_0_2_get_power_profile_mode,
  	.set_power_profile_mode =3D smu_v14_0_2_set_power_profile_mode,
  	.run_btc =3D smu_v14_0_run_btc,
@@@ -2893,8 -2913,6 +2913,6 @@@
  	.deep_sleep_control =3D smu_v14_0_deep_sleep_control,
  	.gfx_ulv_control =3D smu_v14_0_gfx_ulv_control,
  	.get_bamaco_support =3D smu_v14_0_get_bamaco_support,
- 	.baco_get_state =3D smu_v14_0_baco_get_state,
- 	.baco_set_state =3D smu_v14_0_baco_set_state,
  	.baco_enter =3D smu_v14_0_2_baco_enter,
  	.baco_exit =3D smu_v14_0_2_baco_exit,
  	.mode1_reset_is_support =3D smu_v14_0_2_is_mode1_reset_supported,

--rg9/KF51gF/Kfdk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp56BEACgkQJNaLcl1U
h9By4Af/Zb5OFzM8H5eLHG0ktYlYdBC2GDRAVRD+8oDyuARic5Vw9CwZCcSNTQ7j
/VTbN39wnI3Fk2kuIAlyj7vjBCfm9qtgIoiNy0nFPhTYromqtYb73WERBGIOO6yI
BTH/zQHHYo9G8TUuhsX5kkmDOCEPRRMrH3etaC43nOASF36XpvCoQ4qpKgZWy5jo
iEq5xxQ39c/t3hd3HLu9XL7xNlOgmmCBxyIV5t0y5h1r+I6V3ZmeVolIMMqCvLgB
pACeXjdufJ18Kky2WBy/qQiSTG6E7QF0czPjJmafPKLgIQl7BJl/LcECoZje7lK5
CHDOllOsmR4EfUIvFj6LrSCQaO6M4A==
=QlN4
-----END PGP SIGNATURE-----

--rg9/KF51gF/Kfdk0--
