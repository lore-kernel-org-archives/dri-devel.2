Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7C3C5DF69
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E33C510E15E;
	Fri, 14 Aug 2026 13:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y34s3tuN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4065610E15E
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 13:56:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ED45D43AD0;
 Fri, 14 Aug 2026 13:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA0AA1F000E9;
 Fri, 14 Aug 2026 13:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786715776;
 bh=+CaPwxI2ZP9QSXxOEOIbJnLV2bwxmJZdVBL0wNdm8YA=;
 h=Date:From:To:Cc:Subject;
 b=Y34s3tuNzU0BxdODSrh2IOshB63iEdnQBZyM/97sOBlxL7sEw2G/gqag5s8nSEYvt
 jqzUr5tcr+WsEDO40pIgZIhHPH4BleLDv0h/sx8Z84Vllx+IOXH6FDAPzWbQArjx2H
 8WI7xRY9lSrfYa0T2G0nL4obpIwFIFy8oRu+9CX3rLe8qdtZ3C9pRxgFujeBKUDyRP
 wlJGsus936qT9cg5Zjr/5UDMjQno1I/5Z/kN0ycvSVCQeNnqAsxI51MPn9WDTHnlC0
 5q2H1JjbOETgIDkJtYBoe7ORXnDv8hIX1GmJGhiOm7sMI5IJnWM936gaEDvQiU3nGZ
 Gz5UaPRuL58xA==
Date: Fri, 14 Aug 2026 14:56:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Yang Wang <kevinyang.wang@amd.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <an8efGzrumcwPuHz@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="55AXQbE56ost/Mas"
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


--55AXQbE56ost/Mas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got conflicts in:

  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c

between commit:

  1849a64165ccc ("drm/amd/pm: use milliwatts for GPU power sensors")

=66rom the origin tree and commits:

  757ba0790bafe ("drm/amd/pm: use milliwatts for GPU power sensors")
  a01ff85d6f09d ("drm/amd/pm: Keep sub-watt precision in Q10 socket power")
  1f33a9688f201 ("drm/amd/pm: Keep sub-degree precision in Q10 temperatures=
")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.


diff --combined drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 8d476a60d62fd,0033453f27e5a..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@@ -434,23 -434,19 +434,19 @@@ int smu_v13_0_12_get_smu_metrics_data(s
  		*value =3D SMUQ10_ROUND(metrics->DramBandwidthUtilization);
  		break;
  	case METRICS_CURR_SOCKETPOWER:
- 		*value =3D SMUQ10_ROUND(metrics->SocketPower) *
- 			 MILLIWATT_PER_WATT;
+ 		*value =3D SMUQ10_TO_MILLIWATT(metrics->SocketPower);
  		break;
  	case METRICS_TEMPERATURE_HOTSPOT:
- 		*value =3D SMUQ10_ROUND(metrics->MaxSocketTemperature) *
- 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(metrics->MaxSocketTemperature);
  		break;
  	case METRICS_TEMPERATURE_MEM:
- 		*value =3D SMUQ10_ROUND(metrics->MaxHbmTemperature) *
- 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(metrics->MaxHbmTemperature);
  		break;
  	/* This is the max of all VRs and not just SOC VR.
  	 * No need to define another data type for the same.
  	 */
  	case METRICS_TEMPERATURE_VRSOC:
- 		*value =3D SMUQ10_ROUND(metrics->MaxVrTemperature) *
- 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(metrics->MaxVrTemperature);
  		break;
  	default:
  		*value =3D UINT_MAX;
@@@ -1018,139 -1014,3 +1014,3 @@@ const struct smu_temp_funcs smu_v13_0_1
  	.temp_metrics_is_supported =3D smu_v13_0_12_is_temp_metrics_supported,
  	.get_temp_metrics =3D smu_v13_0_12_get_temp_metrics,
  };
-=20
- static int smu_v13_0_12_get_ras_table_version(struct amdgpu_device *adev,
- 					      uint32_t *table_version)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
-=20
- 	return smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_GetRASTableVersion, 0, table_version);
- }
-=20
- static int smu_v13_0_12_get_badpage_count(struct amdgpu_device *adev, uin=
t32_t *count,
- 					  uint32_t timeout)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	uint64_t end, now;
- 	int ret =3D 0;
-=20
- 	now =3D (uint64_t)ktime_to_ms(ktime_get());
- 	end =3D now + timeout;
- 	do {
- 		ret =3D smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_GetBadPageCount, 0, count);
- 		/* eeprom is not ready */
- 		if (ret !=3D -EBUSY)
- 			return ret;
- 		mdelay(10);
- 		now =3D (uint64_t)ktime_to_ms(ktime_get());
- 	} while (now < end);
-=20
- 	dev_err(adev->dev,
- 			 "smu get bad page count timeout!\n");
- 	return ret;
- }
-=20
- static int smu_v13_0_12_set_timestamp(struct amdgpu_device *adev, uint64_=
t timestamp)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
-=20
- 	return smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_SetTimestamp, (uint32_t)timestamp, 0);
- }
-=20
- static int smu_v13_0_12_get_timestamp(struct amdgpu_device *adev,
- 				      uint16_t index, uint64_t *timestamp)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	uint32_t temp;
- 	int ret;
-=20
- 	ret =3D smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_GetTimestamp, index, &temp);
- 	if (!ret)
- 		*timestamp =3D temp;
-=20
- 	return ret;
- }
-=20
- static int smu_v13_0_12_get_badpage_ipid(struct amdgpu_device *adev,
- 					 uint16_t index, uint64_t *ipid)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	uint32_t temp_arg, temp_ipid_lo, temp_ipid_high;
- 	int ret;
-=20
- 	temp_arg =3D index | (1 << 16);
- 	ret =3D smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_lo);
- 	if (ret)
- 		return ret;
-=20
- 	temp_arg =3D index | (2 << 16);
- 	ret =3D smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_GetBadPageIpid, temp_arg, &temp_ipid_high);
- 	if (!ret)
- 		*ipid =3D (uint64_t)temp_ipid_high << 32 | temp_ipid_lo;
- 	return ret;
- }
-=20
- static int smu_v13_0_12_erase_ras_table(struct amdgpu_device *adev,
- 					uint32_t *result)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
-=20
- 	return smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_EraseRasTable, 0, result);
- }
-=20
- static int smu_v13_0_12_get_badpage_mca_addr(struct amdgpu_device *adev,
- 					     uint16_t index, uint64_t *mca_addr)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	uint32_t temp_arg, temp_addr_lo, temp_addr_high;
- 	int ret;
-=20
- 	temp_arg =3D index | (1 << 16);
- 	ret =3D smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_lo);
- 	if (ret)
- 		return ret;
-=20
- 	temp_arg =3D index | (2 << 16);
- 	ret =3D smu_cmn_send_smc_msg_with_param(smu,
- 			SMU_MSG_GetBadPageMcaAddr, temp_arg, &temp_addr_high);
- 	if (!ret)
- 		*mca_addr =3D (uint64_t)temp_addr_high << 32 | temp_addr_lo;
- 	return ret;
- }
-=20
- static const struct ras_eeprom_smu_funcs smu_v13_0_12_eeprom_smu_funcs =
=3D {
- 	.get_ras_table_version =3D smu_v13_0_12_get_ras_table_version,
- 	.get_badpage_count =3D smu_v13_0_12_get_badpage_count,
- 	.get_badpage_mca_addr =3D smu_v13_0_12_get_badpage_mca_addr,
- 	.set_timestamp =3D smu_v13_0_12_set_timestamp,
- 	.get_timestamp =3D smu_v13_0_12_get_timestamp,
- 	.get_badpage_ipid =3D smu_v13_0_12_get_badpage_ipid,
- 	.erase_ras_table =3D smu_v13_0_12_erase_ras_table,
- };
-=20
- static void smu_v13_0_12_ras_smu_feature_flags(struct amdgpu_device *adev=
, uint64_t *flags)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
-=20
- 	if (!flags)
- 		return;
-=20
- 	*flags =3D 0ULL;
-=20
- 	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(RAS_EEPROM)))
- 		*flags |=3D RAS_SMU_FEATURE_BIT__RAS_EEPROM;
-=20
- }
-=20
- const struct ras_smu_drv smu_v13_0_12_ras_smu_drv =3D {
- 	.smu_eeprom_funcs =3D &smu_v13_0_12_eeprom_smu_funcs,
- 	.ras_smu_feature_flags =3D smu_v13_0_12_ras_smu_feature_flags,
- };
diff --combined drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 41608574bc61c,84c02e6d9673b..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@@ -44,8 -44,6 +44,6 @@@
  #include "amdgpu_xgmi.h"
  #include <linux/pci.h>
  #include "amdgpu_ras.h"
- #include "amdgpu_mca.h"
- #include "amdgpu_aca.h"
  #include "smu_cmn.h"
  #include "mp/mp_13_0_6_offset.h"
  #include "mp/mp_13_0_6_sh_mask.h"
@@@ -76,6 -74,9 +74,9 @@@ MODULE_FIRMWARE("amdgpu/smu_13_0_14.bin
  	[smu_feature] =3D { 1, (smu_13_0_6_feature) }
 =20
  #define FEATURE_MASK(feature) (1ULL << feature)
+=20
+ static int smu_v13_0_6_init_ppt_limits(struct smu_context *smu);
+=20
  static const struct smu_feature_bits smu_v13_0_6_dpm_features =3D {
  	.bits =3D {
  		SMU_FEATURE_BIT_INIT(FEATURE_DATA_CALCULATION),
@@@ -99,25 -100,6 +100,6 @@@
  #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
  #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
  #define LINK_SPEED_MAX 4
- #define MCA_BANK_IPID(_ip, _hwid, _type) \
- 	[AMDGPU_MCA_IP_##_ip] =3D { .hwid =3D _hwid, .mcatype =3D _type, }
-=20
- struct mca_bank_ipid {
- 	enum amdgpu_mca_ip ip;
- 	uint16_t hwid;
- 	uint16_t mcatype;
- };
-=20
- struct mca_ras_info {
- 	enum amdgpu_ras_block blkid;
- 	enum amdgpu_mca_ip ip;
- 	int *err_code_array;
- 	int err_code_count;
- 	int (*get_err_count)(const struct mca_ras_info *mca_ras, struct amdgpu_d=
evice *adev,
- 			     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, ui=
nt32_t *count);
- 	bool (*bank_is_valid)(const struct mca_ras_info *mca_ras, struct amdgpu_=
device *adev,
- 			      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry);
- };
 =20
  #define P2S_TABLE_ID_A 0x50325341
  #define P2S_TABLE_ID_X 0x50325358
@@@ -1171,7 -1153,7 +1153,7 @@@ static int smu_v13_0_6_set_default_dpm_
  		}
  	}
 =20
- 	return 0;
+ 	return smu_v13_0_6_init_ppt_limits(smu);
  }
 =20
  static int smu_v13_0_6_setup_pptable(struct smu_context *smu)
@@@ -1321,23 -1303,19 +1303,19 @@@ static int smu_v13_0_6_get_smu_metrics_
  		*value =3D SMUQ10_ROUND(GET_METRIC_FIELD(DramBandwidthUtilization, vers=
ion));
  		break;
  	case METRICS_CURR_SOCKETPOWER:
- 		*value =3D SMUQ10_ROUND(GET_METRIC_FIELD(SocketPower, version)) *
- 			 MILLIWATT_PER_WATT;
+ 		*value =3D SMUQ10_TO_MILLIWATT(GET_METRIC_FIELD(SocketPower, version));
  		break;
  	case METRICS_TEMPERATURE_HOTSPOT:
- 		*value =3D SMUQ10_ROUND(GET_METRIC_FIELD(MaxSocketTemperature, version)=
) *
- 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(GET_METRIC_FIELD(MaxSocketTemperature=
, version));
  		break;
  	case METRICS_TEMPERATURE_MEM:
- 		*value =3D SMUQ10_ROUND(GET_METRIC_FIELD(MaxHbmTemperature, version)) *
- 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(GET_METRIC_FIELD(MaxHbmTemperature, v=
ersion));
  		break;
  	/* This is the max of all VRs and not just SOC VR.
  	 * No need to define another data type for the same.
  	 */
  	case METRICS_TEMPERATURE_VRSOC:
- 		*value =3D SMUQ10_ROUND(GET_METRIC_FIELD(MaxVrTemperature, version)) *
- 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(GET_METRIC_FIELD(MaxVrTemperature, ve=
rsion));
  		break;
  	default:
  		*value =3D UINT_MAX;
@@@ -1720,54 -1698,82 +1698,82 @@@ static int smu_v13_0_6_read_sensor(stru
  	return ret;
  }
 =20
- static int smu_v13_0_6_get_power_limit(struct smu_context *smu,
- 						uint32_t *current_power_limit,
- 						uint32_t *default_power_limit,
- 						uint32_t *max_power_limit,
- 						uint32_t *min_power_limit)
+ static int smu_v13_0_6_get_ppt_limit(struct smu_context *smu,
+ 				     enum smu_ppt_limit_type limit_type,
+ 				     uint32_t *ppt_limit)
  {
- 	struct smu_table_context *smu_table =3D &smu->smu_table;
- 	struct PPTable_t *pptable =3D
- 		(struct PPTable_t *)smu_table->driver_pptable;
- 	uint32_t power_limit =3D 0;
  	int ret;
 =20
- 	ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
-=20
+ 	if (limit_type =3D=3D SMU_PPT_LIMIT_PPT1) {
+ 		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)))
+ 			return -EOPNOTSUPP;
+ 		ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit,
+ 					       ppt_limit);
+ 	} else {
+ 		ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit,
+ 					       ppt_limit);
+ 	}
  	if (ret) {
  		dev_err(smu->adev->dev, "Couldn't get PPT limit");
  		return -EINVAL;
  	}
 =20
- 	if (current_power_limit)
- 		*current_power_limit =3D power_limit;
- 	if (default_power_limit)
- 		*default_power_limit =3D pptable->MaxSocketPowerLimit;
-=20
- 	if (max_power_limit) {
- 		*max_power_limit =3D pptable->MaxSocketPowerLimit;
- 	}
-=20
- 	if (min_power_limit)
- 		*min_power_limit =3D 0;
  	return 0;
  }
 =20
- static int smu_v13_0_6_set_power_limit(struct smu_context *smu,
- 				       enum smu_ppt_limit_type limit_type,
- 				       uint32_t limit)
+ static int smu_v13_0_6_init_ppt_limits(struct smu_context *smu)
+ {
+ 	struct smu_table_context *smu_table =3D &smu->smu_table;
+ 	struct PPTable_t *pptable =3D
+ 		(struct PPTable_t *)smu_table->driver_pptable;
+ 	int i;
+=20
+ 	for (i =3D SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT; i++) {
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].default_value =3D
+ 			pptable->MaxSocketPowerLimit;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].max =3D
+ 			pptable->MaxSocketPowerLimit;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].min =3D 0;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].od_max =3D
+ 			pptable->MaxSocketPowerLimit;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].od_min =3D 0;
+ 	}
+ 	smu->ppt_limits.supported_mask |=3D BIT(SMU_PPT_LIMIT_PPT0);
+=20
+ 	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT))) {
+ 		for (i =3D SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT; i++) {
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].default_value =3D
+ 				pptable->PPT1Default;
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].max =3D
+ 				pptable->PPT1Max;
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].min =3D
+ 				pptable->PPT1Min;
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].od_max =3D
+ 				pptable->PPT1Max;
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].od_min =3D
+ 				pptable->PPT1Min;
+ 		}
+ 		smu->ppt_limits.supported_mask |=3D BIT(SMU_PPT_LIMIT_PPT1);
+ 	}
+=20
+ 	return 0;
+ }
+=20
+ static int smu_v13_0_6_set_ppt_limit(struct smu_context *smu,
+ 				     enum smu_ppt_limit_type limit_type,
+ 				     uint32_t limit)
  {
  	struct smu_table_context *smu_table =3D &smu->smu_table;
  	struct PPTable_t *pptable =3D
  		(struct PPTable_t *)smu_table->driver_pptable;
  	int ret;
 =20
- 	if (limit_type =3D=3D SMU_FAST_PPT_LIMIT) {
+ 	if (limit_type =3D=3D SMU_PPT_LIMIT_PPT1) {
  		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)))
  			return -EOPNOTSUPP;
  		if (limit > pptable->PPT1Max || limit < pptable->PPT1Min) {
  			dev_err(smu->adev->dev,
- 				"New power limit (%d) should be between min %d max %d\n",
+ 				"New PPT limit (%d) should be between min %d max %d\n",
  				limit, pptable->PPT1Min, pptable->PPT1Max);
  			return -EINVAL;
  		}
@@@ -1778,43 -1784,7 +1784,7 @@@
  		return ret;
  	}
 =20
- 	return smu_v13_0_set_power_limit(smu, limit_type, limit);
- }
-=20
- static int smu_v13_0_6_get_ppt_limit(struct smu_context *smu,
- 				     uint32_t *ppt_limit,
- 				     enum smu_ppt_limit_type type,
- 				     enum smu_ppt_limit_level level)
- {
- 	struct smu_table_context *smu_table =3D &smu->smu_table;
- 	struct PPTable_t *pptable =3D
- 		(struct PPTable_t *)smu_table->driver_pptable;
- 	int ret =3D 0;
-=20
- 	if (type =3D=3D SMU_FAST_PPT_LIMIT) {
- 		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(FAST_PPT)))
- 			return -EOPNOTSUPP;
- 		switch (level) {
- 		case SMU_PPT_LIMIT_MAX:
- 			*ppt_limit =3D pptable->PPT1Max;
- 			break;
- 		case SMU_PPT_LIMIT_CURRENT:
- 			ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit, ppt_limit);
- 			if (ret)
- 				dev_err(smu->adev->dev, "Get fast PPT limit failed!\n");
- 			break;
- 		case SMU_PPT_LIMIT_DEFAULT:
- 			*ppt_limit =3D pptable->PPT1Default;
- 			break;
- 		case SMU_PPT_LIMIT_MIN:
- 			*ppt_limit =3D pptable->PPT1Min;
- 			break;
- 		default:
- 			return -EOPNOTSUPP;
- 		}
- 		return ret;
- 	}
- 	return -EOPNOTSUPP;
+ 	return smu_v13_0_set_ppt_limit(smu, limit_type, limit);
  }
 =20
  static int smu_v13_0_6_irq_process(struct amdgpu_device *adev,
@@@ -1944,17 -1914,6 +1914,6 @@@ static int smu_v13_0_6_notify_unload(st
  	return 0;
  }
 =20
- static int smu_v13_0_6_mca_set_debug_mode(struct smu_context *smu, bool e=
nable)
- {
- 	/* NOTE: this ClearMcaOnRead message is only supported for smu version 8=
5.72.0 or higher */
- 	if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(MCA_DEBUG_MODE)))
- 		return 0;
-=20
- 	return smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_ClearMcaOnRead,
- 					       enable ? 0 : ClearMcaOnRead_UE_FLAG_MASK | ClearMcaOnRead_CE_=
POLL_MASK,
- 					       NULL);
- }
-=20
  static int smu_v13_0_6_system_features_control(struct smu_context *smu,
  					       bool enable)
  {
@@@ -3300,651 -3259,12 +3259,12 @@@ static int smu_v13_0_6_post_init(struc
  	return 0;
  }
 =20
- static int mca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
-=20
- 	return smu_v13_0_6_mca_set_debug_mode(smu, enable);
- }
-=20
- static int smu_v13_0_6_get_valid_mca_count(struct smu_context *smu, enum =
amdgpu_mca_error_type type, uint32_t *count)
- {
- 	uint32_t msg;
- 	int ret;
-=20
- 	if (!count)
- 		return -EINVAL;
-=20
- 	switch (type) {
- 	case AMDGPU_MCA_ERROR_TYPE_UE:
- 		msg =3D SMU_MSG_QueryValidMcaCount;
- 		break;
- 	case AMDGPU_MCA_ERROR_TYPE_CE:
- 		msg =3D SMU_MSG_QueryValidMcaCeCount;
- 		break;
- 	default:
- 		return -EINVAL;
- 	}
-=20
- 	ret =3D smu_cmn_send_smc_msg(smu, msg, count);
- 	if (ret) {
- 		*count =3D 0;
- 		return ret;
- 	}
-=20
- 	return 0;
- }
-=20
- static int __smu_v13_0_6_mca_dump_bank(struct smu_context *smu, enum amdg=
pu_mca_error_type type,
- 				       int idx, int offset, uint32_t *val)
- {
- 	uint32_t msg, param;
-=20
- 	switch (type) {
- 	case AMDGPU_MCA_ERROR_TYPE_UE:
- 		msg =3D SMU_MSG_McaBankDumpDW;
- 		break;
- 	case AMDGPU_MCA_ERROR_TYPE_CE:
- 		msg =3D SMU_MSG_McaBankCeDumpDW;
- 		break;
- 	default:
- 		return -EINVAL;
- 	}
-=20
- 	param =3D ((idx & 0xffff) << 16) | (offset & 0xfffc);
-=20
- 	return smu_cmn_send_smc_msg_with_param(smu, msg, param, val);
- }
-=20
- static int smu_v13_0_6_mca_dump_bank(struct smu_context *smu, enum amdgpu=
_mca_error_type type,
- 				     int idx, int offset, uint32_t *val, int count)
- {
- 	int ret, i;
-=20
- 	if (!val)
- 		return -EINVAL;
-=20
- 	for (i =3D 0; i < count; i++) {
- 		ret =3D __smu_v13_0_6_mca_dump_bank(smu, type, idx, offset + (i << 2), =
&val[i]);
- 		if (ret)
- 			return ret;
- 	}
-=20
- 	return 0;
- }
-=20
- static const struct mca_bank_ipid smu_v13_0_6_mca_ipid_table[AMDGPU_MCA_I=
P_COUNT] =3D {
- 	MCA_BANK_IPID(UMC, 0x96, 0x0),
- 	MCA_BANK_IPID(SMU, 0x01, 0x1),
- 	MCA_BANK_IPID(MP5, 0x01, 0x2),
- 	MCA_BANK_IPID(PCS_XGMI, 0x50, 0x0),
- };
-=20
- static void mca_bank_entry_info_decode(struct mca_bank_entry *entry, stru=
ct mca_bank_info *info)
- {
- 	u64 ipid =3D entry->regs[MCA_REG_IDX_IPID];
- 	u32 instidhi, instid;
-=20
- 	/* NOTE: All MCA IPID register share the same format,
- 	 * so the driver can share the MCMP1 register header file.
- 	 * */
-=20
- 	info->hwid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, HardwareID);
- 	info->mcatype =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, McaType);
-=20
- 	/*
- 	 * Unfied DieID Format: SAASS. A:AID, S:Socket.
- 	 * Unfied DieID[4] =3D InstanceId[0]
- 	 * Unfied DieID[0:3] =3D InstanceIdHi[0:3]
- 	 */
- 	instidhi =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdHi);
- 	instid =3D REG_GET_FIELD(ipid, MCMP1_IPIDT0, InstanceIdLo);
- 	info->aid =3D ((instidhi >> 2) & 0x03);
- 	info->socket_id =3D ((instid & 0x1) << 2) | (instidhi & 0x03);
- }
-=20
- static int mca_bank_read_reg(struct amdgpu_device *adev, enum amdgpu_mca_=
error_type type,
- 			     int idx, int reg_idx, uint64_t *val)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	uint32_t data[2] =3D {0, 0};
- 	int ret;
-=20
- 	if (!val || reg_idx >=3D MCA_REG_IDX_COUNT)
- 		return -EINVAL;
-=20
- 	ret =3D smu_v13_0_6_mca_dump_bank(smu, type, idx, reg_idx * 8, data, ARR=
AY_SIZE(data));
- 	if (ret)
- 		return ret;
-=20
- 	*val =3D (uint64_t)data[1] << 32 | data[0];
-=20
- 	dev_dbg(adev->dev, "mca read bank reg: type:%s, index: %d, reg_idx: %d, =
val: 0x%016llx\n",
- 		type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE ? "UE" : "CE", idx, reg_idx, *val);
-=20
- 	return 0;
- }
-=20
- static int mca_get_mca_entry(struct amdgpu_device *adev, enum amdgpu_mca_=
error_type type,
- 			     int idx, struct mca_bank_entry *entry)
- {
- 	int i, ret;
-=20
- 	/* NOTE: populated all mca register by default */
- 	for (i =3D 0; i < ARRAY_SIZE(entry->regs); i++) {
- 		ret =3D mca_bank_read_reg(adev, type, idx, i, &entry->regs[i]);
- 		if (ret)
- 			return ret;
- 	}
-=20
- 	entry->idx =3D idx;
- 	entry->type =3D type;
-=20
- 	mca_bank_entry_info_decode(entry, &entry->info);
-=20
- 	return 0;
- }
-=20
- static int mca_decode_ipid_to_hwip(uint64_t val)
- {
- 	const struct mca_bank_ipid *ipid;
- 	uint16_t hwid, mcatype;
- 	int i;
-=20
- 	hwid =3D REG_GET_FIELD(val, MCMP1_IPIDT0, HardwareID);
- 	mcatype =3D REG_GET_FIELD(val, MCMP1_IPIDT0, McaType);
-=20
- 	for (i =3D 0; i < ARRAY_SIZE(smu_v13_0_6_mca_ipid_table); i++) {
- 		ipid =3D &smu_v13_0_6_mca_ipid_table[i];
-=20
- 		if (!ipid->hwid)
- 			continue;
-=20
- 		if (ipid->hwid =3D=3D hwid && ipid->mcatype =3D=3D mcatype)
- 			return i;
- 	}
-=20
- 	return AMDGPU_MCA_IP_UNKNOW;
- }
-=20
- static int mca_umc_mca_get_err_count(const struct mca_ras_info *mca_ras, =
struct amdgpu_device *adev,
- 				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, u=
int32_t *count)
- {
- 	uint64_t status0;
- 	uint32_t ext_error_code;
- 	uint32_t odecc_err_cnt;
-=20
- 	status0 =3D entry->regs[MCA_REG_IDX_STATUS];
- 	ext_error_code =3D MCA_REG__STATUS__ERRORCODEEXT(status0);
- 	odecc_err_cnt =3D MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
-=20
- 	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
- 		*count =3D 0;
- 		return 0;
- 	}
-=20
- 	if (umc_v12_0_is_deferred_error(adev, status0) ||
- 	    umc_v12_0_is_uncorrectable_error(adev, status0) ||
- 	    umc_v12_0_is_correctable_error(adev, status0))
- 		*count =3D (ext_error_code =3D=3D 0) ? odecc_err_cnt : 1;
-=20
- 	amdgpu_umc_update_ecc_status(adev,
- 			entry->regs[MCA_REG_IDX_STATUS],
- 			entry->regs[MCA_REG_IDX_IPID],
- 			entry->regs[MCA_REG_IDX_ADDR]);
-=20
- 	return 0;
- }
-=20
- static int mca_pcs_xgmi_mca_get_err_count(const struct mca_ras_info *mca_=
ras, struct amdgpu_device *adev,
- 					  enum amdgpu_mca_error_type type, struct mca_bank_entry *entry,
- 					  uint32_t *count)
- {
- 	u32 ext_error_code;
- 	u32 err_cnt;
-=20
- 	ext_error_code =3D MCA_REG__STATUS__ERRORCODEEXT(entry->regs[MCA_REG_IDX=
_STATUS]);
- 	err_cnt =3D MCA_REG__MISC0__ERRCNT(entry->regs[MCA_REG_IDX_MISC0]);
-=20
- 	if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE &&
- 	    (ext_error_code =3D=3D 0 || ext_error_code =3D=3D 9))
- 		*count =3D err_cnt;
- 	else if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_CE && ext_error_code =3D=3D 6)
- 		*count =3D err_cnt;
-=20
- 	return 0;
- }
-=20
- static bool mca_smu_check_error_code(struct amdgpu_device *adev, const st=
ruct mca_ras_info *mca_ras,
- 				     uint32_t errcode)
- {
- 	int i;
-=20
- 	if (!mca_ras->err_code_count || !mca_ras->err_code_array)
- 		return true;
-=20
- 	for (i =3D 0; i < mca_ras->err_code_count; i++) {
- 		if (errcode =3D=3D mca_ras->err_code_array[i])
- 			return true;
- 	}
-=20
- 	return false;
- }
-=20
- static int mca_gfx_mca_get_err_count(const struct mca_ras_info *mca_ras, =
struct amdgpu_device *adev,
- 				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, u=
int32_t *count)
- {
- 	uint64_t status0, misc0;
-=20
- 	status0 =3D entry->regs[MCA_REG_IDX_STATUS];
- 	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
- 		*count =3D 0;
- 		return 0;
- 	}
-=20
- 	if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE &&
- 	    REG_GET_FIELD(status0, MCMP1_STATUST0, UC) =3D=3D 1 &&
- 	    REG_GET_FIELD(status0, MCMP1_STATUST0, PCC) =3D=3D 1) {
- 		*count =3D 1;
- 		return 0;
- 	} else {
- 		misc0 =3D entry->regs[MCA_REG_IDX_MISC0];
- 		*count =3D REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
- 	}
-=20
- 	return 0;
- }
-=20
- static int mca_smu_mca_get_err_count(const struct mca_ras_info *mca_ras, =
struct amdgpu_device *adev,
- 				     enum amdgpu_mca_error_type type, struct mca_bank_entry *entry, u=
int32_t *count)
- {
- 	uint64_t status0, misc0;
-=20
- 	status0 =3D entry->regs[MCA_REG_IDX_STATUS];
- 	if (!REG_GET_FIELD(status0, MCMP1_STATUST0, Val)) {
- 		*count =3D 0;
- 		return 0;
- 	}
-=20
- 	if (type =3D=3D AMDGPU_MCA_ERROR_TYPE_UE &&
- 	    REG_GET_FIELD(status0, MCMP1_STATUST0, UC) =3D=3D 1 &&
- 	    REG_GET_FIELD(status0, MCMP1_STATUST0, PCC) =3D=3D 1) {
- 		if (count)
- 			*count =3D 1;
- 		return 0;
- 	}
-=20
- 	misc0 =3D entry->regs[MCA_REG_IDX_MISC0];
- 	*count =3D REG_GET_FIELD(misc0, MCMP1_MISC0T0, ErrCnt);
-=20
- 	return 0;
- }
-=20
- static bool mca_gfx_smu_bank_is_valid(const struct mca_ras_info *mca_ras,=
 struct amdgpu_device *adev,
- 				      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
- {
- 	uint32_t instlo;
-=20
- 	instlo =3D REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, In=
stanceIdLo);
- 	instlo &=3D GENMASK(31, 1);
- 	switch (instlo) {
- 	case 0x36430400: /* SMNAID XCD 0 */
- 	case 0x38430400: /* SMNAID XCD 1 */
- 	case 0x40430400: /* SMNXCD XCD 0, NOTE: FIXME: fix this error later */
- 		return true;
- 	default:
- 		return false;
- 	}
-=20
- 	return false;
- };
-=20
- static bool mca_smu_bank_is_valid(const struct mca_ras_info *mca_ras, str=
uct amdgpu_device *adev,
- 				  enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	uint32_t errcode, instlo;
-=20
- 	instlo =3D REG_GET_FIELD(entry->regs[MCA_REG_IDX_IPID], MCMP1_IPIDT0, In=
stanceIdLo);
- 	instlo &=3D GENMASK(31, 1);
- 	if (instlo !=3D 0x03b30400)
- 		return false;
-=20
- 	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND))) {
- 		errcode =3D MCA_REG__SYND__ERRORINFORMATION(entry->regs[MCA_REG_IDX_SYN=
D]);
- 		errcode &=3D 0xff;
- 	} else {
- 		errcode =3D REG_GET_FIELD(entry->regs[MCA_REG_IDX_STATUS], MCMP1_STATUS=
T0, ErrorCode);
- 	}
-=20
- 	return mca_smu_check_error_code(adev, mca_ras, errcode);
- }
-=20
- static int sdma_err_codes[] =3D { CODE_SDMA0, CODE_SDMA1, CODE_SDMA2, COD=
E_SDMA3 };
- static int mmhub_err_codes[] =3D {
- 	CODE_DAGB0, CODE_DAGB0 + 1, CODE_DAGB0 + 2, CODE_DAGB0 + 3, CODE_DAGB0 +=
 4, /* DAGB0-4 */
- 	CODE_EA0, CODE_EA0 + 1, CODE_EA0 + 2, CODE_EA0 + 3, CODE_EA0 + 4,	/* MME=
A0-4*/
- 	CODE_VML2, CODE_VML2_WALKER, CODE_MMCANE,
- };
-=20
- static int vcn_err_codes[] =3D {
- 	CODE_VIDD, CODE_VIDV,
- };
- static int jpeg_err_codes[] =3D {
- 	CODE_JPEG0S, CODE_JPEG0D, CODE_JPEG1S, CODE_JPEG1D,
- 	CODE_JPEG2S, CODE_JPEG2D, CODE_JPEG3S, CODE_JPEG3D,
- 	CODE_JPEG4S, CODE_JPEG4D, CODE_JPEG5S, CODE_JPEG5D,
- 	CODE_JPEG6S, CODE_JPEG6D, CODE_JPEG7S, CODE_JPEG7D,
- };
-=20
- static const struct mca_ras_info mca_ras_table[] =3D {
- 	{
- 		.blkid =3D AMDGPU_RAS_BLOCK__UMC,
- 		.ip =3D AMDGPU_MCA_IP_UMC,
- 		.get_err_count =3D mca_umc_mca_get_err_count,
- 	}, {
- 		.blkid =3D AMDGPU_RAS_BLOCK__GFX,
- 		.ip =3D AMDGPU_MCA_IP_SMU,
- 		.get_err_count =3D mca_gfx_mca_get_err_count,
- 		.bank_is_valid =3D mca_gfx_smu_bank_is_valid,
- 	}, {
- 		.blkid =3D AMDGPU_RAS_BLOCK__SDMA,
- 		.ip =3D AMDGPU_MCA_IP_SMU,
- 		.err_code_array =3D sdma_err_codes,
- 		.err_code_count =3D ARRAY_SIZE(sdma_err_codes),
- 		.get_err_count =3D mca_smu_mca_get_err_count,
- 		.bank_is_valid =3D mca_smu_bank_is_valid,
- 	}, {
- 		.blkid =3D AMDGPU_RAS_BLOCK__MMHUB,
- 		.ip =3D AMDGPU_MCA_IP_SMU,
- 		.err_code_array =3D mmhub_err_codes,
- 		.err_code_count =3D ARRAY_SIZE(mmhub_err_codes),
- 		.get_err_count =3D mca_smu_mca_get_err_count,
- 		.bank_is_valid =3D mca_smu_bank_is_valid,
- 	}, {
- 		.blkid =3D AMDGPU_RAS_BLOCK__XGMI_WAFL,
- 		.ip =3D AMDGPU_MCA_IP_PCS_XGMI,
- 		.get_err_count =3D mca_pcs_xgmi_mca_get_err_count,
- 	}, {
- 		.blkid =3D AMDGPU_RAS_BLOCK__VCN,
- 		.ip =3D AMDGPU_MCA_IP_SMU,
- 		.err_code_array =3D vcn_err_codes,
- 		.err_code_count =3D ARRAY_SIZE(vcn_err_codes),
- 		.get_err_count =3D mca_smu_mca_get_err_count,
- 		.bank_is_valid =3D mca_smu_bank_is_valid,
- 	}, {
- 		.blkid =3D AMDGPU_RAS_BLOCK__JPEG,
- 		.ip =3D AMDGPU_MCA_IP_SMU,
- 		.err_code_array =3D jpeg_err_codes,
- 		.err_code_count =3D ARRAY_SIZE(jpeg_err_codes),
- 		.get_err_count =3D mca_smu_mca_get_err_count,
- 		.bank_is_valid =3D mca_smu_bank_is_valid,
- 	},
- };
-=20
- static const struct mca_ras_info *mca_get_mca_ras_info(struct amdgpu_devi=
ce *adev, enum amdgpu_ras_block blkid)
- {
- 	int i;
-=20
- 	for (i =3D 0; i < ARRAY_SIZE(mca_ras_table); i++) {
- 		if (mca_ras_table[i].blkid =3D=3D blkid)
- 			return &mca_ras_table[i];
- 	}
-=20
- 	return NULL;
- }
-=20
- static int mca_get_valid_mca_count(struct amdgpu_device *adev, enum amdgp=
u_mca_error_type type, uint32_t *count)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	int ret;
-=20
- 	switch (type) {
- 	case AMDGPU_MCA_ERROR_TYPE_UE:
- 	case AMDGPU_MCA_ERROR_TYPE_CE:
- 		ret =3D smu_v13_0_6_get_valid_mca_count(smu, type, count);
- 		break;
- 	default:
- 		ret =3D -EINVAL;
- 		break;
- 	}
-=20
- 	return ret;
- }
-=20
- static bool mca_bank_is_valid(struct amdgpu_device *adev, const struct mc=
a_ras_info *mca_ras,
- 			      enum amdgpu_mca_error_type type, struct mca_bank_entry *entry)
- {
- 	if (mca_decode_ipid_to_hwip(entry->regs[MCA_REG_IDX_IPID]) !=3D mca_ras-=
>ip)
- 		return false;
-=20
- 	if (mca_ras->bank_is_valid)
- 		return mca_ras->bank_is_valid(mca_ras, adev, type, entry);
-=20
- 	return true;
- }
-=20
- static int mca_smu_parse_mca_error_count(struct amdgpu_device *adev, enum=
 amdgpu_ras_block blk, enum amdgpu_mca_error_type type,
- 					 struct mca_bank_entry *entry, uint32_t *count)
- {
- 	const struct mca_ras_info *mca_ras;
-=20
- 	if (!entry || !count)
- 		return -EINVAL;
-=20
- 	mca_ras =3D mca_get_mca_ras_info(adev, blk);
- 	if (!mca_ras)
- 		return -EOPNOTSUPP;
-=20
- 	if (!mca_bank_is_valid(adev, mca_ras, type, entry)) {
- 		*count =3D 0;
- 		return 0;
- 	}
-=20
- 	return mca_ras->get_err_count(mca_ras, adev, type, entry, count);
- }
-=20
- static int mca_smu_get_mca_entry(struct amdgpu_device *adev,
- 				 enum amdgpu_mca_error_type type, int idx, struct mca_bank_entry *ent=
ry)
- {
- 	return mca_get_mca_entry(adev, type, idx, entry);
- }
-=20
- static int mca_smu_get_valid_mca_count(struct amdgpu_device *adev,
- 				       enum amdgpu_mca_error_type type, uint32_t *count)
- {
- 	return mca_get_valid_mca_count(adev, type, count);
- }
-=20
- static const struct amdgpu_mca_smu_funcs smu_v13_0_6_mca_smu_funcs =3D {
- 	.max_ue_count =3D 12,
- 	.max_ce_count =3D 12,
- 	.mca_set_debug_mode =3D mca_smu_set_debug_mode,
- 	.mca_parse_mca_error_count =3D mca_smu_parse_mca_error_count,
- 	.mca_get_mca_entry =3D mca_smu_get_mca_entry,
- 	.mca_get_valid_mca_count =3D mca_smu_get_valid_mca_count,
- };
-=20
- static int aca_smu_set_debug_mode(struct amdgpu_device *adev, bool enable)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
-=20
- 	return smu_v13_0_6_mca_set_debug_mode(smu, enable);
- }
-=20
- static int smu_v13_0_6_get_valid_aca_count(struct smu_context *smu, enum =
aca_smu_type type, u32 *count)
- {
- 	uint32_t msg;
- 	int ret;
-=20
- 	if (!count)
- 		return -EINVAL;
-=20
- 	switch (type) {
- 	case ACA_SMU_TYPE_UE:
- 		msg =3D SMU_MSG_QueryValidMcaCount;
- 		break;
- 	case ACA_SMU_TYPE_CE:
- 		msg =3D SMU_MSG_QueryValidMcaCeCount;
- 		break;
- 	default:
- 		return -EINVAL;
- 	}
-=20
- 	ret =3D smu_cmn_send_smc_msg(smu, msg, count);
- 	if (ret) {
- 		*count =3D 0;
- 		return ret;
- 	}
-=20
- 	return 0;
- }
-=20
- static int aca_smu_get_valid_aca_count(struct amdgpu_device *adev,
- 				       enum aca_smu_type type, u32 *count)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	int ret;
-=20
- 	switch (type) {
- 	case ACA_SMU_TYPE_UE:
- 	case ACA_SMU_TYPE_CE:
- 		ret =3D smu_v13_0_6_get_valid_aca_count(smu, type, count);
- 		break;
- 	default:
- 		ret =3D -EINVAL;
- 		break;
- 	}
-=20
- 	return ret;
- }
-=20
- static int __smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_=
smu_type type,
- 				       int idx, int offset, u32 *val)
- {
- 	uint32_t msg, param;
-=20
- 	switch (type) {
- 	case ACA_SMU_TYPE_UE:
- 		msg =3D SMU_MSG_McaBankDumpDW;
- 		break;
- 	case ACA_SMU_TYPE_CE:
- 		msg =3D SMU_MSG_McaBankCeDumpDW;
- 		break;
- 	default:
- 		return -EINVAL;
- 	}
-=20
- 	param =3D ((idx & 0xffff) << 16) | (offset & 0xfffc);
-=20
- 	return smu_cmn_send_smc_msg_with_param(smu, msg, param, (uint32_t *)val);
- }
-=20
- static int smu_v13_0_6_aca_bank_dump(struct smu_context *smu, enum aca_sm=
u_type type,
- 				     int idx, int offset, u32 *val, int count)
- {
- 	int ret, i;
-=20
- 	if (!val)
- 		return -EINVAL;
-=20
- 	for (i =3D 0; i < count; i++) {
- 		ret =3D __smu_v13_0_6_aca_bank_dump(smu, type, idx, offset + (i << 2), =
&val[i]);
- 		if (ret)
- 			return ret;
- 	}
-=20
- 	return 0;
- }
-=20
- static int aca_bank_read_reg(struct amdgpu_device *adev, enum aca_smu_typ=
e type,
- 			     int idx, int reg_idx, u64 *val)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	u32 data[2] =3D {0, 0};
- 	int ret;
-=20
- 	if (!val || reg_idx >=3D ACA_REG_IDX_COUNT)
- 		return -EINVAL;
-=20
- 	ret =3D smu_v13_0_6_aca_bank_dump(smu, type, idx, reg_idx * 8, data, ARR=
AY_SIZE(data));
- 	if (ret)
- 		return ret;
-=20
- 	*val =3D (u64)data[1] << 32 | data[0];
-=20
- 	dev_dbg(adev->dev, "mca read bank reg: type:%s, index: %d, reg_idx: %d, =
val: 0x%016llx\n",
- 		type =3D=3D ACA_SMU_TYPE_UE ? "UE" : "CE", idx, reg_idx, *val);
-=20
- 	return 0;
- }
-=20
- static int aca_smu_get_valid_aca_bank(struct amdgpu_device *adev,
- 				      enum aca_smu_type type, int idx, struct aca_bank *bank)
- {
- 	int i, ret, count;
-=20
- 	count =3D min_t(int, 16, ARRAY_SIZE(bank->regs));
- 	for (i =3D 0; i < count; i++) {
- 		ret =3D aca_bank_read_reg(adev, type, idx, i, &bank->regs[i]);
- 		if (ret)
- 			return ret;
- 	}
-=20
- 	return 0;
- }
-=20
- static int aca_smu_parse_error_code(struct amdgpu_device *adev, struct ac=
a_bank *bank)
- {
- 	struct smu_context *smu =3D adev->powerplay.pp_handle;
- 	int error_code;
-=20
- 	if (smu_v13_0_6_cap_supported(smu, SMU_CAP(ACA_SYND)))
- 		error_code =3D ACA_REG__SYND__ERRORINFORMATION(bank->regs[ACA_REG_IDX_S=
YND]);
- 	else
- 		error_code =3D ACA_REG__STATUS__ERRORCODE(bank->regs[ACA_REG_IDX_STATUS=
]);
-=20
- 	return error_code & 0xff;
- }
-=20
- static const struct aca_smu_funcs smu_v13_0_6_aca_smu_funcs =3D {
- 	.max_ue_bank_count =3D 12,
- 	.max_ce_bank_count =3D 12,
- 	.set_debug_mode =3D aca_smu_set_debug_mode,
- 	.get_valid_aca_count =3D aca_smu_get_valid_aca_count,
- 	.get_valid_aca_bank =3D aca_smu_get_valid_aca_bank,
- 	.parse_error_code =3D aca_smu_parse_error_code,
- };
-=20
  static void smu_v13_0_6_set_temp_funcs(struct smu_context *smu)
  {
  	smu->smu_temp.temp_funcs =3D (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)
  			=3D=3D IP_VERSION(13, 0, 12)) ? &smu_v13_0_12_temp_funcs : NULL;
  }
 =20
- static int smu_v13_0_6_get_ras_smu_drv(struct smu_context *smu, const str=
uct ras_smu_drv **ras_smu_drv)
- {
- 	if (!ras_smu_drv)
- 		return -EINVAL;
-=20
- 	if (amdgpu_sriov_vf(smu->adev))
- 		return -EOPNOTSUPP;
-=20
- 	if (smu_cmn_feature_is_enabled(smu, SMU_FEATURE_HROM_EN_BIT))
- 		smu_v13_0_6_cap_set(smu, SMU_CAP(RAS_EEPROM));
-=20
- 	switch (amdgpu_ip_version(smu->adev, MP1_HWIP, 0)) {
- 	case IP_VERSION(13, 0, 12):
- 		*ras_smu_drv =3D &smu_v13_0_12_ras_smu_drv;
- 		break;
- 	default:
- 		*ras_smu_drv =3D NULL;
- 		break;
- 	}
-=20
- 	return 0;
- }
-=20
  static const struct pptable_funcs smu_v13_0_6_ppt_funcs =3D {
  	/* init dpm */
  	.init_allowed_features =3D smu_v13_0_6_init_allowed_features,
@@@ -3955,7 -3275,7 +3275,7 @@@
  	.force_clk_levels =3D smu_v13_0_6_force_clk_levels,
  	.read_sensor =3D smu_v13_0_6_read_sensor,
  	.set_performance_level =3D smu_v13_0_6_set_performance_level,
- 	.get_power_limit =3D smu_v13_0_6_get_power_limit,
+ 	.get_ppt_limit =3D smu_v13_0_6_get_ppt_limit,
  	.is_dpm_running =3D smu_v13_0_6_is_dpm_running,
  	.get_unique_id =3D smu_v13_0_6_get_unique_id,
  	.init_microcode =3D smu_v13_0_6_init_microcode,
@@@ -3973,8 -3293,7 +3293,7 @@@
  	.system_features_control =3D smu_v13_0_6_system_features_control,
  	.get_enabled_mask =3D smu_v13_0_6_get_enabled_mask,
  	.feature_is_enabled =3D smu_cmn_feature_is_enabled,
- 	.set_power_limit =3D smu_v13_0_6_set_power_limit,
- 	.get_ppt_limit =3D smu_v13_0_6_get_ppt_limit,
+ 	.set_ppt_limit =3D smu_v13_0_6_set_ppt_limit,
  	.set_xgmi_pstate =3D smu_v13_0_set_xgmi_pstate,
  	.register_irq_handler =3D smu_v13_0_6_register_irq_handler,
  	.enable_thermal_alert =3D smu_v13_0_enable_thermal_alert,
@@@ -4003,7 -3322,6 +3322,6 @@@
  	.dpm_reset_vcn =3D smu_v13_0_6_reset_vcn,
  	.post_init =3D smu_v13_0_6_post_init,
  	.ras_send_msg =3D smu_v13_0_6_ras_send_msg,
- 	.get_ras_smu_drv =3D smu_v13_0_6_get_ras_smu_drv,
  };
 =20
  void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
@@@ -4021,7 -3339,5 +3339,5 @@@
  	smu->smc_fw_caps |=3D SMU_FW_CAP_RAS_PRI;
  	smu_v13_0_init_msg_ctl(smu, message_map);
  	smu_v13_0_6_set_temp_funcs(smu);
- 	amdgpu_mca_smu_init_funcs(smu->adev, &smu_v13_0_6_mca_smu_funcs);
- 	amdgpu_aca_set_smu_funcs(smu->adev, &smu_v13_0_6_aca_smu_funcs);
  }
 =20
diff --combined drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
index 8fc99e93ac536,4c0236196de4f..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
@@@ -174,7 -174,7 +174,7 @@@ int smu_v15_0_init_pptable_microcode(st
  	if (!pptable_id)
  		return 0;
 =20
- 	ret =3D smu_v15_0_get_pptable_from_firmware(smu, &table, &size, pptable_=
id);
+ 	ret =3D smu_cmn_get_pptable_from_firmware(smu, &table, &size, pptable_id=
);
  	if (ret)
  		return ret;
 =20
@@@ -207,48 -207,6 +207,6 @@@ int smu_v15_0_check_fw_status(struct sm
  	return -EIO;
  }
 =20
- static int smu_v15_0_set_pptable_v2_0(struct smu_context *smu, void **tab=
le, uint32_t *size)
- {
- 	struct amdgpu_device *adev =3D smu->adev;
- 	uint32_t ppt_offset_bytes;
- 	const struct smc_firmware_header_v2_0 *v2;
-=20
- 	v2 =3D (const struct smc_firmware_header_v2_0 *) adev->pm.fw->data;
-=20
- 	ppt_offset_bytes =3D le32_to_cpu(v2->ppt_offset_bytes);
- 	*size =3D le32_to_cpu(v2->ppt_size_bytes);
- 	*table =3D (uint8_t *)v2 + ppt_offset_bytes;
-=20
- 	return 0;
- }
-=20
- static int smu_v15_0_set_pptable_v2_1(struct smu_context *smu, void **tab=
le,
- 				      uint32_t *size, uint32_t pptable_id)
- {
- 	struct amdgpu_device *adev =3D smu->adev;
- 	const struct smc_firmware_header_v2_1 *v2_1;
- 	struct smc_soft_pptable_entry *entries;
- 	uint32_t pptable_count =3D 0;
- 	int i =3D 0;
-=20
- 	v2_1 =3D (const struct smc_firmware_header_v2_1 *) adev->pm.fw->data;
- 	entries =3D (struct smc_soft_pptable_entry *)
- 		((uint8_t *)v2_1 + le32_to_cpu(v2_1->pptable_entry_offset));
- 	pptable_count =3D le32_to_cpu(v2_1->pptable_count);
- 	for (i =3D 0; i < pptable_count; i++) {
- 		if (le32_to_cpu(entries[i].id) =3D=3D pptable_id) {
- 			*table =3D ((uint8_t *)v2_1 + le32_to_cpu(entries[i].ppt_offset_bytes)=
);
- 			*size =3D le32_to_cpu(entries[i].ppt_size_bytes);
- 			break;
- 		}
- 	}
-=20
- 	if (i =3D=3D pptable_count)
- 		return -EINVAL;
-=20
- 	return 0;
- }
-=20
  static int smu_v15_0_get_pptable_from_vbios(struct smu_context *smu, void=
 **table, uint32_t *size)
  {
  	struct amdgpu_device *adev =3D smu->adev;
@@@ -271,45 -229,6 +229,6 @@@
  	return 0;
  }
 =20
- int smu_v15_0_get_pptable_from_firmware(struct smu_context *smu,
- 					void **table,
- 					uint32_t *size,
- 					uint32_t pptable_id)
- {
- 	const struct smc_firmware_header_v1_0 *hdr;
- 	struct amdgpu_device *adev =3D smu->adev;
- 	uint16_t version_major, version_minor;
- 	int ret;
-=20
- 	hdr =3D (const struct smc_firmware_header_v1_0 *) adev->pm.fw->data;
- 	if (!hdr)
- 		return -EINVAL;
-=20
- 	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
-=20
- 	version_major =3D le16_to_cpu(hdr->header.header_version_major);
- 	version_minor =3D le16_to_cpu(hdr->header.header_version_minor);
- 	if (version_major !=3D 2) {
- 		dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
- 			version_major, version_minor);
- 		return -EINVAL;
- 	}
-=20
- 	switch (version_minor) {
- 	case 0:
- 		ret =3D smu_v15_0_set_pptable_v2_0(smu, table, size);
- 		break;
- 	case 1:
- 		ret =3D smu_v15_0_set_pptable_v2_1(smu, table, size, pptable_id);
- 		break;
- 	default:
- 		ret =3D -EINVAL;
- 		break;
- 	}
-=20
- 	return ret;
- }
-=20
  int smu_v15_0_setup_pptable(struct smu_context *smu)
  {
  	struct amdgpu_device *adev =3D smu->adev;
@@@ -329,7 -248,7 +248,7 @@@
  	if ((amdgpu_sriov_vf(adev) || !pptable_id) && (amdgpu_emu_mode !=3D 1))
  		ret =3D smu_v15_0_get_pptable_from_vbios(smu, &table, &size);
  	else
- 		ret =3D smu_v15_0_get_pptable_from_firmware(smu, &table, &size, pptable=
_id);
+ 		ret =3D smu_cmn_get_pptable_from_firmware(smu, &table, &size, pptable_i=
d);
 =20
  	if (ret)
  		return ret;
@@@ -664,6 -583,7 +583,7 @@@ int smu_v15_0_gfx_off_control(struct sm
 =20
  	switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
  	case IP_VERSION(15, 0, 0):
+ 	case IP_VERSION(15, 0, 5):
  	case IP_VERSION(15, 0, 9):
  		if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
  			return 0;
@@@ -699,14 -619,17 +619,17 @@@ int smu_v15_0_notify_display_change(str
  	return ret;
  }
 =20
- int smu_v15_0_get_current_power_limit(struct smu_context *smu,
- 				      uint32_t *power_limit)
+ int smu_v15_0_get_ppt_limit(struct smu_context *smu,
+ 			    enum smu_ppt_limit_type limit_type,
+ 			    uint32_t *ppt_limit)
  {
  	int power_src;
  	int ret =3D 0;
 =20
  	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT))
  		return -EINVAL;
+ 	if (limit_type !=3D SMU_PPT_LIMIT_PPT0)
+ 		return -EOPNOTSUPP;
 =20
  	power_src =3D smu_cmn_to_asic_specific_index(smu,
  						   CMN2ASIC_MAPPING_PWR,
@@@ -719,35 -642,33 +642,33 @@@
  	ret =3D smu_cmn_send_smc_msg_with_param(smu,
  					      SMU_MSG_GetPptLimit,
  					      power_src << 16,
- 					      power_limit);
+ 					      ppt_limit);
  	if (ret)
  		dev_err(smu->adev->dev, "[%s] get PPT limit failed!", __func__);
 =20
  	return ret;
  }
 =20
- int smu_v15_0_set_power_limit(struct smu_context *smu,
- 			      enum smu_ppt_limit_type limit_type,
- 			      uint32_t limit)
+ int smu_v15_0_set_ppt_limit(struct smu_context *smu,
+ 			    enum smu_ppt_limit_type limit_type,
+ 			    uint32_t limit)
  {
  	int ret =3D 0;
 =20
- 	if (limit_type !=3D SMU_DEFAULT_PPT_LIMIT)
+ 	if (limit_type !=3D SMU_PPT_LIMIT_PPT0)
  		return -EINVAL;
 =20
  	if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_PPT_BIT)) {
- 		dev_err(smu->adev->dev, "Setting new power limit is not supported!\n");
+ 		dev_err(smu->adev->dev, "Setting new PPT limit is not supported!\n");
  		return -EOPNOTSUPP;
  	}
 =20
  	ret =3D smu_cmn_send_smc_msg_with_param(smu, SMU_MSG_SetPptLimit, limit,=
 NULL);
  	if (ret) {
- 		dev_err(smu->adev->dev, "[%s] Set power limit Failed!\n", __func__);
+ 		dev_err(smu->adev->dev, "[%s] Set PPT limit failed!\n", __func__);
  		return ret;
  	}
 =20
- 	smu->current_power_limit =3D limit;
-=20
  	return 0;
  }
 =20
diff --combined drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
index 118eda5429ff7,aa4daf8f7d6f2..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c
@@@ -55,6 -55,13 +55,13 @@@
  #define SMUQ10_TO_UINT(x) ((x) >> 10)
  #define SMUQ10_FRAC(x) ((x) & 0x3ff)
  #define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >=3D 0x2=
00))
+ /* Convert Q10 watts to milliwatts, preserving the fractional part */
+ #define SMUQ10_TO_MILLIWATT(x) (SMUQ10_TO_UINT(x) * MILLIWATT_PER_WATT + \
+ 				((SMUQ10_FRAC(x) * MILLIWATT_PER_WATT) >> 10))
+ /* Convert Q10 degrees Celsius to millidegrees, preserving the fractional=
 part */
+ #define SMUQ10_TO_MILLICELSIUS(x) \
+ 	(SMUQ10_TO_UINT(x) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES + \
+ 	 ((SMUQ10_FRAC(x) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES) >> 10))
 =20
  #define hbm_stack_mask_valid(umc_mask) \
  	(((umc_mask) & 0xF) =3D=3D 0xF)
@@@ -72,6 -79,8 +79,8 @@@
 =20
  #define FEATURE_MASK(feature) (1ULL << feature)
 =20
+ static int smu_v15_0_8_init_ppt_limits(struct smu_context *smu);
+=20
  static const struct smu_feature_bits smu_v15_0_8_dpm_features =3D {
  	.bits =3D { SMU_FEATURE_BIT_INIT(FEATURE_ID_DATA_CALCULATION),
  		  SMU_FEATURE_BIT_INIT(FEATURE_ID_DPM_GFXCLK),
@@@ -411,12 -420,10 +420,10 @@@ static int smu_v15_0_8_get_smu_metrics_
  		*value =3D SMUQ10_ROUND(metrics->DramBandwidthUtilization);
  		break;
  	case METRICS_CURR_SOCKETPOWER:
- 		*value =3D SMUQ10_ROUND(metrics->SocketPower) *
- 			 MILLIWATT_PER_WATT;
+ 		*value =3D SMUQ10_TO_MILLIWATT(metrics->SocketPower);
  		break;
  	case METRICS_TEMPERATURE_HOTSPOT:
- 		*value =3D SMUQ10_ROUND(metrics->MaxSocketTemperature) *
- 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(metrics->MaxSocketTemperature);
  		break;
  	case METRICS_TEMPERATURE_MEM:
  	{
@@@ -434,19 -441,18 +441,18 @@@
  				if (!hbm_stack_mask_valid(mask))
  					continue;
 =20
- 				temp =3D SMUQ10_ROUND(metrics->HbmTemperature[stack_idx]);
+ 				temp =3D metrics->HbmTemperature[stack_idx];
  				if (temp > max_hbm_temp)
  					max_hbm_temp =3D temp;
  			}
  		}
- 		*value =3D max_hbm_temp * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(max_hbm_temp);
  		break;
  	}
  	/* This is the max of all VRs and not just SOC VR.
  	 */
  	case METRICS_TEMPERATURE_VRSOC:
- 		*value =3D SMUQ10_ROUND(metrics->MaxVrTemperature) *
- 			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+ 		*value =3D SMUQ10_TO_MILLICELSIUS(metrics->MaxVrTemperature);
  		break;
  	default:
  		*value =3D UINT_MAX;
@@@ -1153,7 -1159,7 +1159,7 @@@ static int smu_v15_0_8_set_default_dpm_
  	if (ret)
  		return ret;
 =20
- 	return 0;
+ 	return smu_v15_0_8_init_ppt_limits(smu);
  }
 =20
  static int smu_v15_0_8_irq_process(struct amdgpu_device *adev,
@@@ -1767,12 -1773,17 +1773,17 @@@ static ssize_t smu_v15_0_8_get_gpu_metr
  		idx++;
  	}
 =20
- 	/* Per-VCN clocks */
+ 	/* Per-VCN clocks and busy */
  	for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
  		inst =3D GET_INST(VCN, i);
  		if (inst >=3D 0) {
  			gpu_metrics->current_vclk0[i] =3D SMUQ10_ROUND(metrics->VclkFrequency[=
inst]);
  			gpu_metrics->current_dclk0[i] =3D SMUQ10_ROUND(metrics->DclkFrequency[=
inst]);
+ 			gpu_metrics->vcn_busy[i] =3D SMUQ10_ROUND(metrics->VcnBusy[inst]);
+ 			for (j =3D 0; j < NUM_JPEG_RINGS_FW; ++j)
+ 				gpu_metrics->jpeg_busy[(i * NUM_JPEG_RINGS_FW) + j] =3D
+ 					SMUQ10_ROUND(metrics->JpegBusy[(inst * NUM_JPEG_RINGS_FW)
+ 								       + j]);
  		}
  	}
 =20
@@@ -1843,34 -1854,59 +1854,59 @@@ static void smu_v15_0_8_get_unique_id(s
  	adev->unique_id =3D pptable->PublicSerialNumberMID;
  }
 =20
- static int smu_v15_0_8_get_power_limit(struct smu_context *smu,
- 				       uint32_t *current_power_limit,
- 				       uint32_t *default_power_limit,
- 				       uint32_t *max_power_limit,
- 				       uint32_t *min_power_limit)
+ static int smu_v15_0_8_get_ppt_limit(struct smu_context *smu,
+ 				     enum smu_ppt_limit_type limit_type,
+ 				     uint32_t *ppt_limit)
  {
- 	struct smu_table_context *smu_table =3D &smu->smu_table;
- 	PPTable_t *pptable =3D (PPTable_t *)smu_table->driver_pptable;
- 	uint32_t power_limit =3D 0;
  	int ret;
 =20
- 	ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit, &power_limit);
+ 	if (limit_type =3D=3D SMU_PPT_LIMIT_PPT1)
+ 		ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit,
+ 					       ppt_limit);
+ 	else
+ 		ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetPptLimit,
+ 					       ppt_limit);
  	if (ret) {
  		dev_err(smu->adev->dev, "Couldn't get PPT limit");
  		return -EINVAL;
  	}
 =20
- 	if (current_power_limit)
- 		*current_power_limit =3D power_limit;
+ 	return 0;
+ }
 =20
- 	if (default_power_limit)
- 		*default_power_limit =3D pptable->MaxSocketPowerLimit;
+ static int smu_v15_0_8_init_ppt_limits(struct smu_context *smu)
+ {
+ 	struct smu_table_context *smu_table =3D &smu->smu_table;
+ 	PPTable_t *pptable =3D (PPTable_t *)smu_table->driver_pptable;
+ 	int i;
 =20
- 	if (max_power_limit)
- 		*max_power_limit =3D pptable->MaxSocketPowerLimit;
+ 	for (i =3D SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT; i++) {
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].default_value =3D
+ 			pptable->MaxSocketPowerLimit;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].max =3D
+ 			pptable->MaxSocketPowerLimit;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].min =3D 0;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].od_max =3D
+ 			pptable->MaxSocketPowerLimit;
+ 		smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT0].od_min =3D 0;
+ 	}
+ 	smu->ppt_limits.supported_mask |=3D BIT(SMU_PPT_LIMIT_PPT0);
 =20
- 	if (min_power_limit)
- 		*min_power_limit =3D 0;
+ 	if (pptable->PPT1Max) {
+ 		for (i =3D SMU_POWER_SOURCE_AC; i < SMU_POWER_SOURCE_COUNT; i++) {
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].default_value =3D
+ 				pptable->PPT1Default;
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].max =3D
+ 				pptable->PPT1Max;
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].min =3D
+ 				pptable->PPT1Min;
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].od_max =3D
+ 				pptable->PPT1Max;
+ 			smu->ppt_limits.range[i][SMU_PPT_LIMIT_PPT1].od_min =3D
+ 				pptable->PPT1Min;
+ 		}
+ 		smu->ppt_limits.supported_mask |=3D BIT(SMU_PPT_LIMIT_PPT1);
+ 	}
 =20
  	return 0;
  }
@@@ -1915,7 -1951,7 +1951,7 @@@ static int smu_v15_0_8_set_performance_
  	struct smu_dpm_table *gfx_table =3D &dpm_context->dpm_tables.gfx_table;
  	struct smu_dpm_table *uclk_table =3D &dpm_context->dpm_tables.uclk_table;
  	struct smu_umd_pstate_table *pstate_table =3D &smu->pstate_table;
- 	int ret;
+ 	int ret =3D 0;
 =20
  	switch (level) {
  	case AMD_DPM_FORCED_LEVEL_PERF_DETERMINISM:
@@@ -1956,9 -1992,6 +1992,6 @@@
  				SMU_DPM_TABLE_MAX(uclk_table);
  		}
 =20
- 		if (ret)
- 			goto out;
-=20
  		smu_cmn_reset_custom_level(smu);
 =20
  		break;
@@@ -2208,15 -2241,15 +2241,15 @@@ static int smu_v15_0_8_get_thermal_temp
  	return 0;
  }
 =20
- static int smu_v15_0_8_set_power_limit(struct smu_context *smu,
- 				       enum smu_ppt_limit_type limit_type,
- 				       uint32_t limit)
+ static int smu_v15_0_8_set_ppt_limit(struct smu_context *smu,
+ 				     enum smu_ppt_limit_type limit_type,
+ 				     uint32_t limit)
  {
  	struct smu_table_context *smu_table =3D &smu->smu_table;
  	PPTable_t *pptable =3D (PPTable_t *)smu_table->driver_pptable;
  	int ret;
 =20
- 	if (limit_type =3D=3D SMU_FAST_PPT_LIMIT) {
+ 	if (limit_type =3D=3D SMU_PPT_LIMIT_PPT1) {
  		if (!pptable->PPT1Max)
  			return -EOPNOTSUPP;
 =20
@@@ -2235,49 -2268,7 +2268,7 @@@
  		return ret;
  	}
 =20
- 	return smu_v15_0_set_power_limit(smu, limit_type, limit);
- }
-=20
- static int smu_v15_0_8_get_ppt_limit(struct smu_context *smu,
- 				     uint32_t *ppt_limit,
- 				     enum smu_ppt_limit_type type,
- 				     enum smu_ppt_limit_level level)
- {
- 	struct smu_table_context *smu_table =3D &smu->smu_table;
- 	PPTable_t *pptable =3D (PPTable_t *)smu_table->driver_pptable;
- 	int ret =3D 0;
-=20
- 	if (!ppt_limit)
- 		return -EINVAL;
-=20
- 	if (type =3D=3D SMU_FAST_PPT_LIMIT) {
- 		if (!pptable->PPT1Max)
- 			return -EOPNOTSUPP;
-=20
- 		switch (level) {
- 		case SMU_PPT_LIMIT_MAX:
- 			*ppt_limit =3D pptable->PPT1Max;
- 			break;
- 		case SMU_PPT_LIMIT_CURRENT:
- 			ret =3D smu_cmn_send_smc_msg(smu, SMU_MSG_GetFastPptLimit,
- 						   ppt_limit);
- 			if (ret)
- 				dev_err(smu->adev->dev,
- 					"Get fast PPT limit failed!\n");
- 			break;
- 		case SMU_PPT_LIMIT_DEFAULT:
- 			*ppt_limit =3D pptable->PPT1Default;
- 			break;
- 		case SMU_PPT_LIMIT_MIN:
- 			*ppt_limit =3D pptable->PPT1Min;
- 			break;
- 		default:
- 			return -EOPNOTSUPP;
- 		}
- 		return ret;
- 	}
-=20
- 	return -EOPNOTSUPP;
+ 	return smu_v15_0_set_ppt_limit(smu, limit_type, limit);
  }
 =20
  static uint32_t smu_v15_0_8_get_throttler_status(struct smu_context *smu)
@@@ -2374,9 -2365,8 +2365,8 @@@ static const struct pptable_funcs smu_v
  	.get_dpm_ultimate_freq =3D smu_v15_0_8_get_dpm_ultimate_freq,
  	.get_gpu_metrics =3D smu_v15_0_8_get_gpu_metrics,
  	.get_unique_id =3D smu_v15_0_8_get_unique_id,
- 	.get_power_limit =3D smu_v15_0_8_get_power_limit,
- 	.set_power_limit =3D smu_v15_0_8_set_power_limit,
  	.get_ppt_limit =3D smu_v15_0_8_get_ppt_limit,
+ 	.set_ppt_limit =3D smu_v15_0_8_set_ppt_limit,
  	.emit_clk_levels =3D smu_v15_0_8_emit_clk_levels,
  	.read_sensor =3D smu_v15_0_8_read_sensor,
  	.populate_umd_state_clk =3D smu_v15_0_8_populate_umd_state_clk,

--55AXQbE56ost/Mas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp/HnsACgkQJNaLcl1U
h9C6uwf/SHy4f7lLiXLg8g6OOoD5A8xbCUcWCyJbwMJ35r0yuyuscndIgznC2+xI
/1BZ6IquJsC06RFWJ3oG1HLcWuwwWy+SNcjCCbVipRD614bOafQXvduhCCBl0e+e
AxV5uBR948zpzjpdW9+9dQxZ+EL0q/rm+9Ww3oVZfpPlEu5rw+ANRdSnETjSfZKl
pv5qasUBYuijaCdtbOUezWQIEFjWQtyz5JlO+CBCJWjvtC0/3jMn2ywJ20HoSr4p
fuSfJ8IwcY29gI/TtEIl4K7JP/6VBx92C1sGOgyNB3JGr9QFcmTelzTzTS8oI2eT
hAkdWWS0EdpCt+S76Yfr/I878/R9VA==
=8ItE
-----END PGP SIGNATURE-----

--55AXQbE56ost/Mas--
