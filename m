Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98534C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:03:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB74410E8EC;
	Mon, 10 Aug 2026 15:03:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ly8s64ut";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D100310E8F3
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 15:03:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A1749411C8;
 Mon, 10 Aug 2026 15:03:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC4D1F000E9;
 Mon, 10 Aug 2026 15:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786374198;
 bh=hM8HLlKbrT1beYGbDdF7rwYTBKfbtjlEfpyGo7c512U=;
 h=Date:From:To:Cc:Subject;
 b=ly8s64ut6otNVsjaUzMPETzYtTXl54gmrN3UKqMTf0r+dDlZJugyUBPYhaGB/ZH5B
 DQDPFcinGE7Tw1FWp2597cnSMT7VByLzzqt0RQJuqXWRr9trZDelED0ZMElNjRd/Zg
 8eoCeRa5GWAli8pid6TTudcLRf9nrPHDwQ5H+aZsHB4tz8/5AbVYmzfkcOLPtHpqq1
 H/dEpOhDHqiVb47xdLMba16pLVyakIP8k7Nd2mxMUMxf9bINSXWwfMtY2b97Y+9NVx
 ciZI1aimrnFZnUUKUgGG+idhxRwkjaYiAShREwQjissmP2EQMwFxDSj+ZIQYioXiSE
 mOvWQDCwGBOXg==
Date: Mon, 10 Aug 2026 16:03:13 +0100
From: Mark Brown <broonie@kernel.org>
To: Dave Airlie <airlied@redhat.com>, DRI <dri-devel@lists.freedesktop.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Granthali Vinodkumar Dhandar <granthali.vinodkumardhandar@amd.com>,
 Kanala Ramalingeswara Reddy <Kanala.RamalingeswaraReddy@amd.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
 Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>,
 Suresh Guttula <Suresh.Guttula@amd.com>, Yang Wang <kevinyang.wang@amd.com>
Subject: linux-next: manual merge of the drm tree with the origin tree
Message-ID: <annoMaclCDBha2QH@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qpABl4jOwb76ithB"
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


--qpABl4jOwb76ithB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c

between commits:

  e2469bde3fcaa ("drm/amdgpu: add support for SMU version 15.0.9")
  119b828afb87d ("drm/amdgpu: Update driver if header for SMU V15.0.5")
  1849a64165ccc ("drm/amd/pm: use milliwatts for GPU power sensors")

=66rom the origin tree and commits:

  1dfd4e84b5bee ("drm/amdgpu: add support for SMU version 15.0.9")
  3ee6561f8ae0a ("drm/amdgpu: Update driver if header for SMU V15.0.5")
  757ba0790bafe ("drm/amd/pm: use milliwatts for GPU power sensors")
  74e6d50d02e56 ("drm/amd/pm/smu15: switch SMU v15.0.0 to DRAM-based accumu=
lator metrics")

=66rom the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --combined drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 0da1ffb3a5678,12fe2bc0488e7..0000000000000
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@@ -33,6 -33,9 +33,9 @@@
  #include "smu_v15_0_0_pmfw.h"
  #include "smu_cmn.h"
 =20
+ #include <linux/overflow.h>
+ #include <linux/math64.h>
+=20
  /*
   * DO NOT use these for err/warn/info/debug messages.
   * Use dev_err, dev_warn, dev_info and dev_dbg instead.
@@@ -119,6 -122,9 +122,9 @@@ static struct cmn2asic_msg_mapping smu_
  	MSG_MAP(DisableLSdma,                   PPSMC_MSG_DisableLSdma,				1),
  	MSG_MAP(SetSoftMaxVpe,                  PPSMC_MSG_SetSoftMaxVpe,			1),
  	MSG_MAP(SetSoftMinVpe,                  PPSMC_MSG_SetSoftMinVpe,			1),
+ 	MSG_MAP(GetMetricsTableVersion,         PPSMC_MSG_GetMetricsTableVersion=
,		1),
+ 	MSG_MAP(GetMetricsTableLogSample,       PPSMC_MSG_GetMetricsTableLogSamp=
le,		1),
+ 	MSG_MAP(GetMetricsTableLogDramAddr,     PPSMC_MSG_GetMetricsTableLogDram=
Addr,	1),
  };
 =20
  static struct cmn2asic_mapping smu_v15_0_0_feature_mask_map[SMU_FEATURE_C=
OUNT] =3D {
@@@ -160,10 -166,37 +166,37 @@@ static struct cmn2asic_mapping smu_v15_
  	TAB_MAP_VALID(DPMCLOCKS),
  };
 =20
+ static int smu_v15_0_0_get_metrics_table_dram_addr(struct smu_context *sm=
u,
+ 					SMU_15_0_0_MetricsInfo_t *metrics_info)
+ {
+ 	struct smu_msg_ctl *ctl =3D &smu->msg_ctl;
+ 	struct smu_msg_args args =3D {
+ 		.msg =3D SMU_MSG_GetMetricsTableLogDramAddr,
+ 		.num_args =3D 0,
+ 		.num_out_args =3D 3,
+ 	};
+ 	int ret;
+=20
+ 	ret =3D ctl->ops->send_msg(ctl, &args);
+ 	if (ret)
+ 		return ret;
+=20
+ 	metrics_info->addr =3D ((uint64_t)args.out_args[1] << 32) | args.out_arg=
s[0];
+ 	metrics_info->table_size =3D args.out_args[2];
+=20
+ 	metrics_info->cpu_addr =3D ioremap_wc(metrics_info->addr,
+ 					    metrics_info->table_size);
+ 	if (!metrics_info->cpu_addr)
+ 		return -ENOMEM;
+=20
+ 	return 0;
+ }
+=20
  static int smu_v15_0_0_init_smc_tables(struct smu_context *smu)
  {
  	struct smu_table_context *smu_table =3D &smu->smu_table;
  	struct smu_table *tables =3D smu_table->tables;
+ 	SMU_15_0_0_MetricsInfo_t *metrics_info;
  	int ret;
 =20
  	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
@@@ -173,7 -206,7 +206,7 @@@
  	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
  		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 =20
- 	smu_table->metrics_table =3D kzalloc_obj(SmuMetrics_t);
+ 	smu_table->metrics_table =3D kzalloc_obj(SMU_15_0_0_MetricsInfo_t);
  	if (!smu_table->metrics_table)
  		goto err0_out;
  	smu_table->metrics_time =3D 0;
@@@ -192,8 -225,16 +225,16 @@@
  	if (ret)
  		goto err3_out;
 =20
+ 	metrics_info =3D (SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+=20
+ 	ret =3D smu_v15_0_0_get_metrics_table_dram_addr(smu, metrics_info);
+ 	if (ret)
+ 		goto err4_out;
+=20
  	return 0;
 =20
+ err4_out:
+ 	smu_driver_table_fini(smu, SMU_DRIVER_TABLE_GPU_METRICS);
  err3_out:
  	kfree(smu_table->watermarks_table);
  err2_out:
@@@ -207,6 -248,14 +248,14 @@@ err0_out
  static int smu_v15_0_0_fini_smc_tables(struct smu_context *smu)
  {
  	struct smu_table_context *smu_table =3D &smu->smu_table;
+ 	SMU_15_0_0_MetricsInfo_t *metrics_info =3D smu_table->metrics_table;
+=20
+ 	if (metrics_info) {
+ 		if (metrics_info->cpu_addr) {
+ 			iounmap(metrics_info->cpu_addr);
+ 			metrics_info->cpu_addr =3D NULL;
+ 		}
+ 	}
 =20
  	kfree(smu_table->clocks_table);
  	smu_table->clocks_table =3D NULL;
@@@ -299,7 -348,7 +348,7 @@@ static int smu_v15_0_0_set_default_dpm_
  				    smu_table->clocks_table, false);
  }
 =20
- static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+ static int smu_v15_0_0_get_gpu_metrics_table(struct smu_context *smu,
  							void *metrics_table,
  							bool bypass_cache)
  {
@@@ -329,114 -378,161 +378,161 @@@
  	return 0;
  }
 =20
+ /*
+  * Fetch a fresh metrics sample into the inactive buffer.
+  * Returns 0 if a new sample was copied, 1 if the cached sample is still
+  * fresh (nothing copied), or a negative errno on failure.
+  */
+ static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+ 					SMU_15_0_0_MetricsInfo_t *metrics_info)
+ {
+ 	struct smu_table_context *smu_table =3D &smu->smu_table;
+ 	void __iomem *cpu_addr =3D metrics_info->cpu_addr;
+ 	struct smu_msg_ctl *ctl =3D &smu->msg_ctl;
+ 	struct smu_msg_args args =3D {0};
+ 	size_t table_size =3D metrics_info->table_size;
+ 	int ret;
+=20
+ 	if (smu_table->metrics_time &&
+ 	    !time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1)))
+ 		return 1;
+=20
+ 	if (!cpu_addr)
+ 		return -ENOMEM;
+=20
+ 	args.msg =3D SMU_MSG_GetMetricsTableLogSample;
+ 	args.num_args =3D 0;
+ 	args.num_out_args =3D 0;
+=20
+ 	ret =3D ctl->ops->send_msg(ctl, &args);
+ 	if (ret)
+ 		return ret;
+=20
+ 	/* best to flush before copy */
+ 	amdgpu_hdp_invalidate(smu->adev, NULL);
+ 	if (table_size <=3D sizeof(MetricsTable_t))
+ 		memcpy_fromio(&metrics_info->metrics[!metrics_info->active_idx],
+ 			      cpu_addr, table_size);
+ 	else
+ 		memcpy_fromio(&metrics_info->metrics[!metrics_info->active_idx],
+ 			      cpu_addr, sizeof(MetricsTable_t));
+=20
+ 	metrics_info->active_idx =3D !metrics_info->active_idx;
+ 	smu_table->metrics_time =3D jiffies;
+=20
+ 	return 0;
+ }
+=20
+ /*
+  * Accumulators monotonically increase and roll over at their type width.
+  * Use the kernel wrapping_sub() API to compute the delta so the subtract=
ion
+  * wraps modulo 2^n (correct across a single rollover) without tripping a=
ny
+  * wrap-around sanitizers.
+  */
+ static void smu_v15_0_0_compute_all_metrics(
+ 		uint32_t *avg_metric,
+ 		MetricsTable_t *prev,
+ 		MetricsTable_t *curr)
+ {
+ 	uint64_t counter, val;
+ 	uint32_t mw;
+ 	MetricsTable_IOD_t *p =3D &prev->IOD;
+ 	MetricsTable_IOD_t *c =3D &curr->IOD;
+=20
+ 	counter =3D wrapping_sub(u32, c->AccumulationCounter, p->AccumulationCou=
nter);
+ 	if (!counter)
+ 		return;
+=20
+ 	/* Accumulator-based clock frequencies (fixed-point /1024) */
+ 	val =3D wrapping_sub(u64, c->GfxclkFreqEffAcc, p->GfxclkFreqEffAcc);
+ 	avg_metric[METRICS_AVERAGE_GFXCLK] =3D div_u64(div64_u64(val, counter), =
1024);
+=20
+ 	val =3D wrapping_sub(u64, c->SocclkFreqEffAcc, p->SocclkFreqEffAcc);
+ 	avg_metric[METRICS_AVERAGE_SOCCLK] =3D div_u64(div64_u64(val, counter), =
1024);
+=20
+ 	val =3D wrapping_sub(u64, c->VclkFreqEffAcc, p->VclkFreqEffAcc);
+ 	avg_metric[METRICS_AVERAGE_VCLK] =3D div_u64(div64_u64(val, counter), 10=
24);
+=20
+ 	val =3D wrapping_sub(u64, c->MemclkFreqEffAcc, p->MemclkFreqEffAcc);
+ 	avg_metric[METRICS_AVERAGE_UCLK] =3D div_u64(div64_u64(val, counter), 10=
24);
+=20
+ 	val =3D wrapping_sub(u64, c->FclkFreqEffAcc, p->FclkFreqEffAcc);
+ 	avg_metric[METRICS_AVERAGE_FCLK] =3D div_u64(div64_u64(val, counter), 10=
24);
+=20
+ 	val =3D wrapping_sub(u64, c->NpuhclkFreqEffAcc, p->NpuhclkFreqEffAcc);
+ 	avg_metric[METRICS_AVERAGE_NPUCLK] =3D div_u64(div64_u64(val, counter), =
1024);
+=20
+ 	/* Activity (fixed-point /1024) */
+ 	val =3D wrapping_sub(u64, c->GfxBusyAcc, p->GfxBusyAcc);
+ 	avg_metric[METRICS_AVERAGE_GFXACTIVITY] =3D div_u64(div64_u64(val, count=
er), 1024);
+=20
+ 	val =3D wrapping_sub(u64, c->VcnBusyAcc, p->VcnBusyAcc);
+ 	avg_metric[METRICS_AVERAGE_VCNACTIVITY] =3D div_u64(div64_u64(val, count=
er), 1024);
+=20
+ 	/*
+ 	 * Power: accumulator holds a 1024x fixed-point value in Watts.
+ 	 * Average it into milliwatts, which is the unit expected by
+ 	 * power sensor consumers (hwmon/debugfs).
+ 	 */
+ 	val =3D wrapping_sub(u64, c->ApuPowerAcc, p->ApuPowerAcc);
+ 	mw =3D div_u64(div64_u64(val, counter) * 1000, 1024);
+ 	avg_metric[METRICS_AVERAGE_SOCKETPOWER] =3D mw;
+=20
+ 	val =3D wrapping_sub(u64, c->SystemPowerAcc, p->SystemPowerAcc);
+ 	mw =3D div_u64(div64_u64(val, counter) * 1000, 1024);
+ 	avg_metric[METRICS_CURR_SOCKETPOWER] =3D mw;
+=20
+ 	/*
+ 	 * Temperature: accumulator holds a 1024x fixed-point value in
+ 	 * Celsius. Descale by 1024 and convert to millidegrees C as the
+ 	 * hwmon/sysfs consumers expect (temp*_input is in millidegrees).
+ 	 */
+ 	val =3D wrapping_sub(u64, c->GFX_TempAcc, p->GFX_TempAcc);
+ 	avg_metric[METRICS_TEMPERATURE_VRGFX] =3D
+ 		div_u64(div64_u64(val, counter) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES=
, 1024);
+=20
+ 	val =3D wrapping_sub(u64, c->STT_APU_HotSpotTempAcc, p->STT_APU_HotSpotT=
empAcc);
+ 	avg_metric[METRICS_TEMPERATURE_HOTSPOT] =3D
+ 		div_u64(div64_u64(val, counter) * SMU_TEMPERATURE_UNITS_PER_CENTIGRADES=
, 1024);
+=20
+ 	/* Voltage: accumulator holds a 1024x fixed-point value in Volts;
+ 	 * convert to millivolts for the hwmon/sysfs consumers.
+ 	 */
+ 	val =3D wrapping_sub(u64, c->VDDCR_GFX_TelemetryVoltage, p->VDDCR_GFX_Te=
lemetryVoltage);
+ 	avg_metric[METRICS_VOLTAGE_VDDGFX] =3D div_u64(div64_u64(val, counter) *=
 1000, 1024);
+=20
+ 	val =3D wrapping_sub(u64, c->VDDCR_SOC_TelemetryVoltage, p->VDDCR_SOC_Te=
lemetryVoltage);
+ 	avg_metric[METRICS_VOLTAGE_VDDSOC] =3D div_u64(div64_u64(val, counter) *=
 1000, 1024);
+ }
+=20
  static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
  					    MetricsMember_t member,
  					    uint32_t *value)
  {
  	struct smu_table_context *smu_table =3D &smu->smu_table;
+ 	SMU_15_0_0_MetricsInfo_t *metrics_info =3D
+ 		(SMU_15_0_0_MetricsInfo_t *)smu_table->metrics_table;
+ 	int ret;
 =20
- 	SmuMetrics_t *metrics =3D (SmuMetrics_t *)smu_table->metrics_table;
- 	int ret =3D 0;
+ 	if (member >=3D ARRAY_SIZE(metrics_info->avg_metric))
+ 		return -EINVAL;
 =20
- 	ret =3D smu_v15_0_0_get_metrics_table(smu, NULL, false);
- 	if (ret)
+ 	ret =3D smu_v15_0_0_get_metrics_table(smu, metrics_info);
+ 	if (ret < 0)
  		return ret;
 =20
- 	switch (member) {
- 	case METRICS_AVERAGE_GFXCLK:
- 		*value =3D metrics->GfxclkFrequency;
- 		break;
- 	case METRICS_AVERAGE_SOCCLK:
- 		*value =3D metrics->SocclkFrequency;
- 		break;
- 	case METRICS_AVERAGE_VCLK:
- 		*value =3D metrics->VclkFrequency;
- 		break;
- 	case METRICS_AVERAGE_DCLK:
- 		*value =3D 0;
- 		break;
- 	case METRICS_AVERAGE_UCLK:
- 		*value =3D metrics->MemclkFrequency;
- 		break;
- 	case METRICS_AVERAGE_FCLK:
- 		*value =3D metrics->FclkFrequency;
- 		break;
- 	case METRICS_AVERAGE_VPECLK:
- 		*value =3D metrics->VpeclkFrequency;
- 		break;
- 	case METRICS_AVERAGE_NPUCLK:
- 		*value =3D metrics->NpuclkFrequency;
- 		break;
- 	case METRICS_AVERAGE_GFXACTIVITY:
- 		if ((smu->smc_fw_version > 0x5d4600))
- 			*value =3D metrics->GfxActivity;
- 		else
- 			*value =3D metrics->GfxActivity / 100;
- 		break;
- 	case METRICS_AVERAGE_VCNACTIVITY:
- 		*value =3D metrics->VcnActivity / 100;
- 		break;
- 	case METRICS_AVERAGE_SOCKETPOWER:
- 	case METRICS_CURR_SOCKETPOWER:
- 		*value =3D metrics->SocketPower;
- 		break;
- 	case METRICS_TEMPERATURE_EDGE:
- 		*value =3D metrics->GfxTemperature / 100 *
- 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
- 		break;
- 	case METRICS_TEMPERATURE_HOTSPOT:
- 		*value =3D metrics->SocTemperature / 100 *
- 		SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
- 		break;
- 	case METRICS_THROTTLER_RESIDENCY_PROCHOT:
- 		*value =3D metrics->ThrottleResidency_PROCHOT;
- 		break;
- 	case METRICS_THROTTLER_RESIDENCY_SPL:
- 		*value =3D metrics->ThrottleResidency_SPL;
- 		break;
- 	case METRICS_THROTTLER_RESIDENCY_FPPT:
- 		*value =3D metrics->ThrottleResidency_FPPT;
- 		break;
- 	case METRICS_THROTTLER_RESIDENCY_SPPT:
- 		*value =3D metrics->ThrottleResidency_SPPT;
- 		break;
- 	case METRICS_THROTTLER_RESIDENCY_THM_SOC:
- 		*value =3D metrics->ThrottleResidency_THM_SOC;
- 		break;
- 	case METRICS_VOLTAGE_VDDGFX:
- 		*value =3D 0;
- 		break;
- 	case METRICS_VOLTAGE_VDDSOC:
- 		*value =3D 0;
- 		break;
- 	case METRICS_SS_APU_SHARE:
- 		/* return the percentage of APU power with respect to APU's power limit.
- 		 * percentage is reported, this isn't boost value. Smartshift power
- 		 * boost/shift is only when the percentage is more than 100.
- 		 */
- 		if (metrics->StapmOpnLimit > 0)
- 			*value =3D (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
- 		else
- 			*value =3D 0;
- 		break;
- 	case METRICS_SS_DGPU_SHARE:
- 		/* return the percentage of dGPU power with respect to dGPU's power lim=
it.
- 		 * percentage is reported, this isn't boost value. Smartshift power
- 		 * boost/shift is only when the percentage is more than 100.
- 		 */
- 		if ((metrics->dGpuPower > 0) &&
- 		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
- 			*value =3D (metrics->dGpuPower * 100) /
- 				 (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
- 		else
- 			*value =3D 0;
- 		break;
- 	default:
- 		*value =3D UINT_MAX;
- 		break;
+ 	if (ret =3D=3D 0 &&
+ 	    metrics_info->metrics[metrics_info->active_idx].IOD.AccumulationCoun=
ter !=3D
+ 	    metrics_info->metrics[!metrics_info->active_idx].IOD.AccumulationCou=
nter) {
+ 		/* New sample: active_idx already points to the latest sample. */
+ 		smu_v15_0_0_compute_all_metrics(metrics_info->avg_metric,
+ 						&metrics_info->metrics[!metrics_info->active_idx],
+ 						&metrics_info->metrics[metrics_info->active_idx]);
  	}
 =20
- 	return ret;
+ 	*value =3D metrics_info->avg_metric[member];
+=20
+ 	return 0;
  }
 =20
  static int smu_v15_0_0_read_sensor(struct smu_context *smu,
@@@ -473,9 -569,9 +569,9 @@@
  						       (uint32_t *)data);
  		*size =3D 4;
  		break;
- 	case AMDGPU_PP_SENSOR_EDGE_TEMP:
+ 	case AMDGPU_PP_SENSOR_GPU_TEMP:
  		ret =3D smu_v15_0_0_get_smu_metrics_data(smu,
- 						       METRICS_TEMPERATURE_EDGE,
+ 						       METRICS_TEMPERATURE_VRGFX,
  						       (uint32_t *)data);
  		*size =3D 4;
  		break;
@@@ -511,18 -607,6 +607,6 @@@
  						       (uint32_t *)data);
  		*size =3D 4;
  		break;
- 	case AMDGPU_PP_SENSOR_SS_APU_SHARE:
- 		ret =3D smu_v15_0_0_get_smu_metrics_data(smu,
- 						       METRICS_SS_APU_SHARE,
- 						       (uint32_t *)data);
- 		*size =3D 4;
- 		break;
- 	case AMDGPU_PP_SENSOR_SS_DGPU_SHARE:
- 		ret =3D smu_v15_0_0_get_smu_metrics_data(smu,
- 						       METRICS_SS_DGPU_SHARE,
- 						       (uint32_t *)data);
- 		*size =3D 4;
- 		break;
  	default:
  		ret =3D -EOPNOTSUPP;
  		break;
@@@ -633,7 -717,7 +717,7 @@@ static ssize_t smu_v15_0_0_get_gpu_metr
  	SmuMetrics_t metrics;
  	int ret =3D 0;
 =20
- 	ret =3D smu_v15_0_0_get_metrics_table(smu, &metrics, false);
+ 	ret =3D smu_v15_0_0_get_gpu_metrics_table(smu, &metrics, false);
  	if (ret)
  		return ret;
 =20

--qpABl4jOwb76ithB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmp56DEACgkQJNaLcl1U
h9AuoAf/VgbjKJDncBDjkYFaAWMo7zjzH1vbT3LDIHL3gcMzG4LGR5QvdGgbD2BA
8qOV9sPLbFfdexCDuQ7hf57BdDajqeSYEV5cU6K9Lka/6jmlM2Pr7f//r8lWqOGF
QWj+TMhd10Ej06zIwupDLD2JrvTSUAiQFzCbSMbcBfPfEnb5Y/iBI0HGOvSUHaBp
aJiABUotW55LsyCpQ3pIOvwkqMa5mNcYArf6B6nC4h0Rj8VuiibpQ7qCVynxSedn
pziQFEIIpVukjXzyqlfg87TQX76uvhwX6UNGs3kaxbiKZFqnvkHWwPaPfZSzY2SH
QzG+KbWBO20TCmU5liAYaEbJnt/nZQ==
=Dj/C
-----END PGP SIGNATURE-----

--qpABl4jOwb76ithB--
