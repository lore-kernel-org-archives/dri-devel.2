Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54954606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MI4H4iOS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB10210E9BB;
	Mon, 16 Nov 2026 08:17:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE37B10E961;
 Mon, 16 Nov 2026 08:17:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ACC4F4036C;
 Mon, 16 Nov 2026 08:17:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794817058;
 b=OCeY4UnZQDql2b1LILscAzJSjSnkRlzvsYhkkhSzd3VztRTyMF380UCvzQDhiqOFLwmf
 e4xf7gbELFi0C9Ez2S5N3f0eelpuAvYPE7iAMv53Jc4eyKnas+sASj/VNtMNcmOx2qlbv
 liCQLiCFIt3eXRk9q45bUH9m9qf3gdMWkcW0KQEosu0983ktPMos2wK0P3QNQIgmArQP0
 Ryzg8XkvChbIeDZ1NZxjk7mOQT+DyUf41h+XcfbSopdVB84QwJgtg6EqxxTX9+RApbtfZ
 w27KphZSRMzMLezo4/3w+VE1I3YYA2jI5FO44I7TVHf7S+FOcUV5SMmypuwjuwhRaig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794817058;
 h=DKIM-Signature:Received:From:Date:Subject:To:Cc:In-Reply-To:
 References:Message-ID:MIME-Version:Content-Type:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=sSXgYBkHT/oc6vNY04Q3fm3X2G3ni/aAOgRi/r/6vDE=;
 b=vBA7+Zj30wUK1edwZ2oPQJKQPt6Wd1jWqV2i52V3T8xmFczfIpbBGlg8xAXpyWiwvCK6
 SZKesvJQd7VZlJHHVOG0RR8xFW+k+Lui/sGwFCismwI1dPsNYjQw9pn3ODbwBoF6P0/U2
 vdVs7by97CV/DmWMrnIl+E1OFVREAXz2C30Qz6SAkHgFRhbmH+7kMP+lTqCOu5ml7kT0B
 1b4KCKXmQYOzki+4HC6hLKmXzGqZNJjjXZz618WeS9PIljpnUExO0VOFAt3eM0uhBq+by
 hf0vSzlMjJzHQzRXH/2PReia7sCGUMQEAEjqv6iCnrIUd9P7NiwY9bXKrNCZMUiy+Xg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B3E6D1F000C4;
 Mon, 16 Nov 2026 08:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794817058;
 bh=sSXgYBkHT/oc6vNY04Q3fm3X2G3ni/aAOgRi/r/6vDE=;
 h=From:Date:Subject:To:Cc:In-Reply-To:References:Reply-To;
 b=MI4H4iOSdFZsTgA4mCsCdaxrHZRjYzZoCNH44TtYLIrO504n/ALhK/aZVY6LnCjHh
 SjAkk8j7+wmDtV7gkSHOiC/pKDWHL/mTyYxZVzmGdJelblKtAAx0qOGzS5a8jILLXg
 E8jg4e+jo1fn63DmuB1E1+ygRn+Y3vDt+ketccvArGzrcs6gvPSt885sf+oE8ALaPu
 af+8x+XPPe/cwvbsuDKP1A20OceWf5mMdMGbOjwhzLsGzpoZ8kIR+FHdmA2w4g2n6h
 uAwg9ao9NisSEE5mdG9Wi90t9te4zA0O3T4+Hcuc8vVr4iyiATcaBcH9efeg+Gzc7M
 eSygMmvvAoGuw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 173574A3CD;
 Mon, 16 Nov 2026 08:17:37 +0000 (UTC)
From: Joshua Horne via B4 Relay <devnull+hornejd.etsu.edu@kernel.org>
Date: Mon, 16 Nov 2026 03:17:36 -0500
Subject: [PATCH v2 4/5] drm/amd/pm: allow editing the smu8 overdrive sclk table
To: Alex Deucher <alexander.deucher@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>
Cc: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Joshua Horne <hornejd@etsu.edu>, sashiko-reviews@lists.linux.dev
In-Reply-To: <sashiko-outbox-214116@kernel.org>
References: <20261113-smu8-overdrive-v1-0-763f07bdfca9@etsu.edu>
 <20261113-smu8-overdrive-v1-4-763f07bdfca9@etsu.edu>
 <sashiko-outbox-214116@kernel.org>
Message-ID: <179481705669.12281.9149615824591242380@etsu.edu>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794817056; l=11965;
 i=hornejd@etsu.edu; s=20261109; h=from:subject:message-id;
 bh=Hxlr9ljtauqnWTX2eK5EXPT1Bv8cN3MCNVdWdSawep4=;
 b=5r4PiR6Y58SuGTmVElW7aVsymX49F9H7uzIL/TKr0kc3s2fa/3+2OEhmsm60pOugR75DeiJoq
 9aJjCx3AqlqCaSE3LeGPmCFoA5P1nauoeigO5LnfNYLTJpuvdNb4gxB
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Joshua Horne <hornejd@etsu.edu>

Implement the "s <level> <MHz> <mV>", "r" and "c" commands of
pp_od_clk_voltage for Carrizo and Stoney.

The levels given in one write are checked against OD_RANGE and applied
all or none. A new clock is rounded to the one the engine PLL produces,
as reported by the ComputeMemoryEnginePLL table. OD_SCLK and OD_RANGE
show whole MHz, so a level written back with the clock OD_SCLK shows or
with its VBIOS clock keeps that exact clock, and the OD_RANGE maximum
stands for the exact limit. A voltage between two VID steps is rounded
up by convert_to_vid(). A commit is refused unless the clocks increase
from level to level over the whole table, in which the levels that the
SMU does not enable keep their VBIOS clocks.

As on smu7 and vega10, a commit only marks the table as pending. The
power state readjustment that follows it writes the clocks and VDDGFX
voltages into the dependency tables and uploads them through
smu8_upload_pptable_to_smu(), the path used at init and resume, so the
settings also survive suspend. The NB voltages (GnbVid) are not
changed. The power states refer to the levels by clock and are read by
amdgpu_dpm_get_sclk(), so update them as well, like
vega10_odn_update_power_state() does.

smu8_update_sclk_limit() sends the display's minimum engine clock to
the SMU as a level index, but only when that clock changes. The upload
clears the cached clock, so the minimum is looked up again in the new
table.

The SMU accepts the new table at runtime and switches to the new clock
and voltage of a level the next time it enters that level. No
powerplay backend forces a level change after a commit, so this one
does not either.

Signed-off-by: Joshua Horne <hornejd@etsu.edu>
---
Sashiko found two real bugs in v1 4/5:
https://lore.kernel.org/amd-gfx/sashiko-outbox-214116@kernel.org/

1. smu8_update_sclk_limit() resends SclkHardMin only when the display
   minimum clock changes, so after a commit the SMU could keep a stale
   level index. Auto mode mostly hides this; forced and manual modes
   show it. v2 clears the cached clock in smu8_od_upload_sclk_table().

2. A clock written back as OD_SCLK or OD_RANGE shows it could be rounded
   down by the PLL lookup. v2 keeps the exact clock for the level's VBIOS
   clock and for the OD_RANGE maximum. My OD_RANGE limits are whole MHz,
   so I can't hit the -EINVAL case, but the same rounding broke writing
   back an edited level's VBIOS clock.

Tested before and after the fix on an A10-8700P (Carrizo), 7.4.0-rc2
plus this series:

  - v1: "s 2 500 862" then "s 2 423 862" left level 2 at 411 MHz, and
    committing the stock table in manual mode sent no SclkHardMin (0x14).
  - v2: level 2 returns to 423 MHz, and the commit sends 0x14.
  - The S3 and pp_dpm_sclk tests pass on both.

Claude Code wrote the fixes, the commit message changes, this note and
the test script; I reviewed them and ran the tests.

Patches 1-3 and 5 are unchanged; this applies on top of v1 1/5-3/5.

Changes in v2:
- Clear the cached display minimum clock when uploading the table
  (Sashiko).
- Keep the exact clock for a level's VBIOS clock and the OD_RANGE
  maximum (Sashiko).

 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c   | 228 ++++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.h   |   1 +
 2 files changed, 229 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
index 93a7e7e176f3..272c85f0d163 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu8_hwmgr.c
@@ -860,10 +860,92 @@ static void smu8_populate_umdpstate_clocks(struct pp_hwmgr *hwmgr)
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
+	 * The SMU gets the display minimum as a level index, which may differ
+	 * in the new table: make smu8_update_sclk_limit() send it again.
+	 */
+	data->sclk_dpm.hard_min_clk = 0;
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
@@ -2057,6 +2139,151 @@ static void smu8_dpm_powergate_vce(struct pp_hwmgr *hwmgr, bool bgate)
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
+	 * OD_SCLK and OD_RANGE show whole MHz. A level written back unchanged
+	 * or with its VBIOS clock keeps that exact clock, and the OD_RANGE
+	 * maximum stands for the exact limit. Otherwise use the clock the PLL
+	 * produces.
+	 */
+	clk = mhz * 100;
+	if (clk == od->entries[level].clock / 100 * 100)
+		clk = od->entries[level].clock;
+	else if (clk == data->od_default_sclk.entries[level].clock / 100 * 100)
+		clk = data->od_default_sclk.entries[level].clock;
+	else if (clk == max_clk / 100 * 100)
+		clk = smu8_od_real_sclk(hwmgr, max_clk);
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
@@ -2087,6 +2314,7 @@ static const struct pp_hwmgr_func smu8_hwmgr_funcs = {
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


