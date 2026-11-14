Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0409A606A88B
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uwts5WwH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39CB510EC9A;
	Sat, 14 Nov 2026 03:04:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 912D210EC18;
 Sat, 14 Nov 2026 03:04:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0616061D73;
 Sat, 14 Nov 2026 03:04:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794625445;
 b=fe3tpOkxQMK/+iNVVQfeFFYLfdglfnvyp/lsnxIUtwMxoBObFj1hK8/mMcNZjp1Egp2a
 z50xNfxidKX4QLjeNmfTw5Akp7Q4bBixE2tO7gnvI8wfpWm0HWrGV7lycStrlw8lga4e/
 Xz1LLnmff15cF3eEgbrBEdH+jbo5qWOJR/5MnQq7PLz8/HCKFCgkY8hc+EzX1v8hhPBME
 avju20zSOkqgG8T3bwkO23MRaDMmVCqUn/2PzO9rXdJDg9N0jk4rlWA0K16L9TqvgtjDV
 e1dbr816aUVf32KLfnf0t0F+DtaRyUvBVo9JCtcDYK8xLk6bu8wWwK/q1QXPXhzNmaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794625445;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=rk3QCEcH09eZoVXdaY3UXkigxINGDix11N9NInmpK+0=;
 b=dv7yGITUfa9BPjWDFZi1l0XlgLi3DAElB6JJgKw1ukQDJOopELfCWgZ3nE1pkapqSwO+
 0F4mwD8IC/IrD3B26zOZg5BWh+Osjwg7J8GUckf0gJ2r0E+1ouzvznZxQObECi3bSBJlu
 X/X0ZbmpyoNDO3O8TNSl0hXp87iJmHcQxam9g1TEwN03YqtFJYEs4E+fLL+1Llcs6q0Xx
 P6NomS9FtMcuZNJwQfIQI5TPAXis6jaCFH2SD7TG7Qf7mmR2j35WB3gCRgK4LdPwCRPw/
 LaHgkA+yeq+bU9DgVN28IHE/tkRgjr6vHH1OJiJPVaOOQXNWZejcPuNVSXOrUDZQn6Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 6A65D1F000C8;
 Sat, 14 Nov 2026 03:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794625445;
 bh=rk3QCEcH09eZoVXdaY3UXkigxINGDix11N9NInmpK+0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=Uwts5WwHMDzvzzmg1X2p4zS2Pme4a638hCt/W2XC1EEL79goPDVAn++HQTL1S+o2P
 OyJLlLmIIdmTHVWJUqmQGsjWV8nnBDP9dN8msJKm8C1H9QavT/XTZQEvpqI+R1WAHp
 NvzX000+A4KdCYbnU0OzB4OLnjx7aHp7xsDJt7bT9gCE8zApYjRoEN+OdwaAcw9GsI
 ZutYiO6JqOtfCG4B8FLzLR6jFeWi9ixiubNYyLAbxkoc9CiV2yWumfIMxsdHNisOFU
 V+uOPcXx5u4gQ22CRGYyqg5bkmHnEsW0lqjHxLbClSdrd+4Wu/oNlP+RSSEk9H3a0j
 CBUt/W6OnalnA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E637E49C5D;
 Sat, 14 Nov 2026 03:04:02 +0000 (UTC)
From: Joshua Horne via B4 Relay <devnull+hornejd.etsu.edu@kernel.org>
Date: Fri, 13 Nov 2026 22:03:24 -0500
Subject: [PATCH 4/5] drm/amd/pm: allow editing the smu8 overdrive sclk
 table
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261113-smu8-overdrive-v1-4-763f07bdfca9@etsu.edu>
References: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
In-Reply-To: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
To: Alex Deucher <alexander.deucher@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>
Cc: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Joshua Horne <hornejd@etsu.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794625442; l=9681;
 i=hornejd@etsu.edu; s=20261109; h=from:subject:message-id;
 bh=9CthicXd5if7HHSGNCOUZf1A6LQY3sogsKxoiIFSOss=;
 b=Emgm8wuxuJIdAAHUS4yCH3Bht7enlR4RrVumJUe8dTXxi/SK0Gjc5wQWQnetNwtgabD4udOGB
 dRBViyH4OT0CpBWqt81ypZNmrFwEN4G5mgZWaOEiKEdydroOUg0sBFc
X-Developer-Key: i=hornejd@etsu.edu; a=ed25519;
 pk=HNOtiwerBbrJhfhzLHLxj3GDsUH9udRXflqnaI8sQmQ=
X-Endpoint-Received: by B4 Relay for hornejd@etsu.edu/20261109 with
 auth_id=1469
X-Original-From: Joshua Horne <hornejd@etsu.edu>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: hornejd@etsu.edu
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joshua Horne <hornejd@etsu.edu>

Implement the "s <level> <MHz> <mV>", "r" and "c" commands of
pp_od_clk_voltage for Carrizo and Stoney.

The levels given in one write are checked against OD_RANGE and applied
all or none. A new clock is rounded to the one the engine PLL produces,
as reported by the ComputeMemoryEnginePLL table; a level written back
with the clock OD_SCLK shows keeps its exact clock. A voltage between two
VID steps is rounded up by convert_to_vid(). A commit is refused unless
the clocks increase from level to level over the whole table, in which
the levels that the SMU does not enable keep their VBIOS clocks.

As on smu7 and vega10, a commit only marks the table as pending. The
power state readjustment that follows it writes the clocks and VDDGFX
voltages into the dependency tables and uploads them through
smu8_upload_pptable_to_smu(), the path used at init and resume, so the
settings also survive suspend. The NB voltages (GnbVid) are not
changed. The power states refer to the levels by clock and are read by
amdgpu_dpm_get_sclk(), so update them as well, like
vega10_odn_update_power_state() does.

The SMU accepts the new table at runtime and switches to the new clock
and voltage of a level the next time it enters that level. No
powerplay backend forces a level change after a commit, so this one
does not either.

Signed-off-by: Joshua Horne <hornejd@etsu.edu>
---
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c    | 216 +++++++++++++++++++++
 .../gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h    |   1 +
 2 files changed, 217 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 93a7e7e176f3..c6045234965c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -860,10 +860,86 @@ static void smu8_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
 	hwmgr->pstate_mclk_peak = 0;
 }
 
+static void smu8_od_update_power_state(struct pp_hwmgr *hwmgr,
+				       struct pp_power_state *ps)
+{
+	struct smu8_hwmgr *data = hwmgr->backend;
+	const struct phm_odn_clock_levels *od = &data->od_edit_sclk;
+	const struct phm_clock_voltage_dependency_table *old =
+				hwmgr->dyn_state.vddc_dependency_on_sclk;
+	struct smu8_power_state *smu8_ps;
+	struct smu8_power_level *level;
+	uint32_t i, j;
+
+	if (!ps)
+		return;
+
+	smu8_ps = cast_smu8_power_state(&ps->hardware);
+	if (!smu8_ps)
+		return;
+
+	for (i = 0; i < smu8_ps->level; i++) {
+		level = &smu8_ps->levels[i];
+		for (j = 0; j < od->num_of_pl; j++) {
+			if (level->engineClock == old->entries[j].clk) {
+				level->engineClock = od->entries[j].clock;
+				break;
+			}
+		}
+	}
+}
+
+static int smu8_od_upload_sclk_table(struct pp_hwmgr *hwmgr)
+{
+	struct smu8_hwmgr *data = hwmgr->backend;
+	const struct phm_odn_clock_levels *od = &data->od_edit_sclk;
+	struct phm_clock_voltage_dependency_table *vddc_table =
+				hwmgr->dyn_state.vddc_dependency_on_sclk;
+	struct phm_clock_voltage_dependency_table *vdd_gfx_table =
+				hwmgr->dyn_state.vdd_gfx_dependency_on_sclk;
+	struct pp_power_state *ps;
+	uint32_t i;
+
+	data->od_update_pending = false;
+
+	/* the power states refer to the levels by clock, update them first */
+	ps = hwmgr->ps;
+	for (i = 0; i < hwmgr->num_ps; i++) {
+		smu8_od_update_power_state(hwmgr, ps);
+		ps = (struct pp_power_state *)
+			((unsigned long)ps + hwmgr->ps_size);
+	}
+	smu8_od_update_power_state(hwmgr, hwmgr->current_ps);
+	smu8_od_update_power_state(hwmgr, hwmgr->request_ps);
+
+	/* the NB voltages (GnbVid) of the levels are left untouched */
+	for (i = 0; i < od->num_of_pl; i++) {
+		vddc_table->entries[i].clk = od->entries[i].clock;
+		vdd_gfx_table->entries[i].clk = od->entries[i].clock;
+		vdd_gfx_table->entries[i].v =
+			convert_to_vid(od->entries[i].vddc);
+	}
+
+	smu8_populate_umdpstate_clocks(hwmgr);
+
+	/*
+	 * The SMU switches to the new clock and voltage of a level the next
+	 * time it enters that level.
+	 */
+	return smu8_upload_pptable_to_smu(hwmgr);
+}
+
 static int smu8_set_power_state_tasks(struct pp_hwmgr *hwmgr, const void *input)
 {
+	struct smu8_hwmgr *data = hwmgr->backend;
 	int ret = 0;
 
+	if (data->od_update_pending) {
+		ret = smu8_od_upload_sclk_table(hwmgr);
+		if (ret)
+			return ret;
+	}
+
 	smu8_update_sclk_limit(hwmgr);
 	smu8_set_deep_sleep_sclk_threshold(hwmgr);
 	smu8_set_watermark_threshold(hwmgr);
@@ -2057,6 +2133,145 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
 	}
 }
 
+/* the engine clock that the PLL produces for @clk */
+static uint32_t smu8_od_real_sclk(struct pp_hwmgr *hwmgr, uint32_t clk)
+{
+	pp_atomctrl_clock_dividers_kong dividers;
+
+	if (atomctrl_get_engine_pll_dividers_kong(hwmgr, clk, &dividers) ||
+	    !dividers.real_clock)
+		return clk;
+
+	return dividers.real_clock;
+}
+
+static int smu8_od_edit_sclk_level(struct pp_hwmgr *hwmgr,
+				   struct phm_odn_clock_levels *od,
+				   long level, long mhz, long mv)
+{
+	struct smu8_hwmgr *data = hwmgr->backend;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t min_clk, max_clk, clk;
+
+	min_clk = data->od_default_sclk.entries[0].clock;
+	max_clk = hwmgr->platform_descriptor.overdriveLimit.engineClock;
+
+	if (level < 0 || level >= od->num_of_pl) {
+		dev_info(adev->dev,
+			 "OD sclk level %ld is out of range [0 - %u]\n",
+			 level, od->num_of_pl - 1);
+		return -EINVAL;
+	}
+
+	if (mhz < min_clk / 100 || mhz > max_clk / 100) {
+		dev_info(adev->dev,
+			 "OD engine clock is out of range [%u - %u] MHz\n",
+			 min_clk / 100, max_clk / 100);
+		return -EINVAL;
+	}
+
+	if (mv < data->od_min_vddc || mv > data->od_max_vddc) {
+		dev_info(adev->dev, "OD voltage is out of range [%u - %u] mV\n",
+			 data->od_min_vddc, data->od_max_vddc);
+		return -EINVAL;
+	}
+
+	/*
+	 * OD_SCLK shows whole MHz, so keep the exact clock of a level that is
+	 * written back unchanged. Otherwise use the clock the PLL produces.
+	 */
+	clk = mhz * 100;
+	if (clk == od->entries[level].clock / 100 * 100)
+		clk = od->entries[level].clock;
+	else
+		clk = smu8_od_real_sclk(hwmgr, clk);
+
+	if (clk < min_clk || clk > max_clk) {
+		dev_info(adev->dev,
+			 "OD engine clock %u.%02u MHz is out of range\n",
+			 clk / 100, clk % 100);
+		return -EINVAL;
+	}
+
+	od->entries[level].clock = clk;
+	/* a voltage between two VID steps is rounded up */
+	od->entries[level].vddc = convert_to_vddc(convert_to_vid(mv));
+
+	return 0;
+}
+
+static int smu8_od_commit_sclk_table(struct pp_hwmgr *hwmgr)
+{
+	struct smu8_hwmgr *data = hwmgr->backend;
+	struct phm_odn_clock_levels *od = &data->od_edit_sclk;
+	struct phm_clock_voltage_dependency_table *table =
+				hwmgr->dyn_state.vddc_dependency_on_sclk;
+	struct amdgpu_device *adev = hwmgr->adev;
+	uint32_t i, clk, prev = 0;
+
+	/* the levels that the SMU does not enable keep their clocks */
+	for (i = 0; i < table->count; i++) {
+		clk = i < od->num_of_pl ? od->entries[i].clock :
+					  table->entries[i].clk;
+		if (clk <= prev) {
+			dev_info(adev->dev, "OD sclk levels must increase\n");
+			return -EINVAL;
+		}
+		prev = clk;
+	}
+
+	/* uploaded by the power state readjustment that follows a commit */
+	data->od_update_pending = true;
+
+	return 0;
+}
+
+static int smu8_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
+				   enum PP_OD_DPM_TABLE_COMMAND type,
+				   long *input, uint32_t size)
+{
+	struct smu8_hwmgr *data = hwmgr->backend;
+	struct amdgpu_device *adev = hwmgr->adev;
+	struct phm_odn_clock_levels od;
+	uint32_t i;
+	int ret;
+
+	if (!hwmgr->od_enabled) {
+		dev_info(adev->dev, "OverDrive feature not enabled\n");
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case PP_OD_EDIT_SCLK_VDDC_TABLE:
+		break;
+	case PP_OD_RESTORE_DEFAULT_TABLE:
+		data->od_edit_sclk = data->od_default_sclk;
+		return 0;
+	case PP_OD_COMMIT_DPM_TABLE:
+		return smu8_od_commit_sclk_table(hwmgr);
+	default:
+		return -EINVAL;
+	}
+
+	if (!input || !size || size % 3) {
+		dev_info(adev->dev,
+			 "OD sclk input must be <level> <MHz> <mV>\n");
+		return -EINVAL;
+	}
+
+	/* apply all of the given levels or none of them */
+	od = data->od_edit_sclk;
+	for (i = 0; i < size; i += 3) {
+		ret = smu8_od_edit_sclk_level(hwmgr, &od, input[i],
+					      input[i + 1], input[i + 2]);
+		if (ret)
+			return ret;
+	}
+	data->od_edit_sclk = od;
+
+	return 0;
+}
+
 static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
 	.backend_init = smu8_hwmgr_backend_init,
 	.backend_fini = smu8_hwmgr_backend_fini,
@@ -2087,6 +2302,7 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
 	.dynamic_state_management_disable = smu8_disable_dpm_tasks,
 	.notify_cac_buffer_info = smu8_notify_cac_buffer_info,
 	.get_thermal_temperature_range = smu8_get_thermal_temperature_range,
+	.odn_edit_dpm_table = smu8_odn_edit_dpm_table,
 };
 
 int smu8_init_function_pointers(struct pp_hwmgr *hwmgr)
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h
index 490fcc352a8f..63ae7826a2da 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h
@@ -313,6 +313,7 @@ struct smu8_hwmgr {
 	struct phm_odn_clock_levels od_edit_sclk;
 	uint32_t od_min_vddc;		/* in mV */
 	uint32_t od_max_vddc;		/* in mV */
+	bool od_update_pending;		/* committed, not uploaded yet */
 };
 
 #endif /* _SMU8_HWMGR_H_ */

-- 
2.56.0


