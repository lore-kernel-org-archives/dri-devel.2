Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72068FF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EBEC10E948;
	Mon, 27 Apr 2026 21:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="UsUVIDOJ";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC8CB10E948;
 Mon, 27 Apr 2026 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=uA71jEWx+4ZJFtOSm0w69X/YNfuN3y9/1tr88NG3p7I=; b=UsUVIDOJiaSKRMosjcwiWURPQO
 4H0dX2mxJ8tMMdH0XhspJwtTvdMNk9vez0kuML2YqlYAbrjdi+i4Iy7LRTifjWUIaxHwdAjm0FHW6
 NJQTQwuO0HSALimyAvWXMg8TL9ET36jzV2VjVAWNvqgjpor6s7/woFGsNOkpRqglisHmPnH5w8sN4
 vHEH0Lc4KVp7Gi/lZ+WjRJjJSpk+PjJczrbHliPJCVT9g09gc4Hsnc4NVrn3XsDuq6CTQQknD0XHa
 clD3xTJAEQcWb1+ljuvGpKfGfRWpvE2VvRFeO7sfKj6+I1x6o3gjjHdC5BD3qjU9SbCzSoapNN3L0
 EDHIxJ+Q==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wHThk-00000000BoX-3XFP; Mon, 27 Apr 2026 21:41:24 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: dri-devel@lists.freedesktop.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/3 v2] drm/amd/display: dmub_cmd.h: correct typos and spellos
Date: Mon, 27 Apr 2026 14:41:19 -0700
Message-ID: <20260427214122.784024-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Fix spelling issues that are reported by codespell:

dmub_cmd.h:332: alighment ==> alignment
dmub_cmd.h:2029: sequeunce ==> sequence
dmub_cmd.h:3684: optimzations ==> optimizations
dmub_cmd.h:4491: isntance ==> instance
dmub_cmd.h:4514: optimzations ==> optimizations
dmub_cmd.h:4604: isntance ==> instance
dmub_cmd.h:4643: isntance ==> instance
dmub_cmd.h:4679: isntance ==> instance
dmub_cmd.h:4699: isntance ==> instance
dmub_cmd.h:4719: isntance ==> instance
dmub_cmd.h:4735: isntance ==> instance
dmub_cmd.h:4749: isntance ==> instance
dmub_cmd.h:4795: isntance ==> instance
dmub_cmd.h:4903: isntance ==> instance
dmub_cmd.h:4936: isntance ==> instance
dmub_cmd.h:5066: re-use ==> reuse
dmub_cmd.h:6552: isntance ==> instance
dmub_cmd.h:6630: isntance ==> instance
dmub_cmd.h:6639: optimzations ==> optimizations
dmub_cmd.h:6720: isntance ==> instance
dmub_cmd.h:6742: isntance ==> instance

and fix a few that I found:

dicated		==> dictated (7x)
afftet		==> after (is this correct?)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: fix one more typo; rebase & resend

Questions:
(a) Is one of "negative" or "pos" incorrect?

	/**
	 * Dark negative gain.
	 */
	uint8_t dark_pos_gain[NUM_AMBI_LEVEL][NUM_AGGR_LEVEL];   // 184B

(b) Is one of "min" or "Maximum" incorrect?

	uint16_t min_frame_rate;	/**< Maximum frame rate */

(c) Is one of "max" or "Minimum" incorrect?

	uint16_t max_frame_rate;	/**< Minimum frame rate */

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>


 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h |   58 +++++++-------
 1 file changed, 29 insertions(+), 29 deletions(-)

--- linux-next-20260427.orig/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ linux-next-20260427/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -329,7 +329,7 @@ union dmub_addr {
 
 /* Flattened structure containing SOC BB parameters stored in the VBIOS
  * It is not practical to store the entire bounding box in VBIOS since the bounding box struct can gain new parameters.
- * This also prevents alighment issues when new parameters are added to the SoC BB.
+ * This also prevents alignment issues when new parameters are added to the SoC BB.
  * The following parameters should be added since these values can't be obtained elsewhere:
  * -dml2_soc_power_management_parameters
  * -dml2_soc_vmin_clock_limits
@@ -2001,7 +2001,7 @@ struct dmub_rb_cmd_read_modify_write {
 };
 
 /*
- * Update a register with specified masks and values sequeunce
+ * Update a register with specified masks and values sequence
  *
  * 60 payload bytes can hold address + up to 7 sets of mask/value combo, each take 2 dword
  *
@@ -3483,7 +3483,7 @@ enum dmub_cmd_psr_type {
 
 	/**
 	 * Set PSR level.
-	 * PSR level is a 16-bit value dicated by driver that
+	 * PSR level is a 16-bit value dictated by driver that
 	 * will enable/disable different functionality.
 	 */
 	DMUB_CMD__PSR_SET_LEVEL			= 4,
@@ -3640,7 +3640,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	union dmub_psr_debug_flags debug;
 	/**
-	 * 16-bit value dicated by driver that will enable/disable different functionality.
+	 * 16-bit value dictated by driver that will enable/disable different functionality.
 	 */
 	uint16_t psr_level;
 	/**
@@ -3680,7 +3680,7 @@ struct dmub_cmd_psr_copy_settings_data {
 	 */
 	uint8_t aux_inst;
 	/**
-	 * Determines if SMU optimzations are enabled/disabled.
+	 * Determines if SMU optimizations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -3797,7 +3797,7 @@ struct dmub_rb_cmd_psr_copy_settings {
  */
 struct dmub_cmd_psr_set_level_data {
 	/**
-	 * 16-bit value dicated by driver that will enable/disable different functionality.
+	 * 16-bit value dictated by driver that will enable/disable different functionality.
 	 */
 	uint16_t psr_level;
 	/**
@@ -4175,7 +4175,7 @@ struct dmub_rb_cmd_update_cursor_info {
  */
 struct dmub_cmd_psr_set_vtotal_data {
 	/**
-	 * 16-bit value dicated by driver that indicates the vtotal in PSR active requirement when screen idle..
+	 * 16-bit value dictated by driver that indicates the vtotal in PSR active requirement when screen idle..
 	 */
 	uint16_t psr_vtotal_idle;
 	/**
@@ -4189,7 +4189,7 @@ struct dmub_cmd_psr_set_vtotal_data {
 	 */
 	uint8_t panel_inst;
 	/*
-	 * 16-bit value dicated by driver that indicates the vtotal in PSR active requirement when doing SU/FFU.
+	 * 16-bit value dictated by driver that indicates the vtotal in PSR active requirement when doing SU/FFU.
 	 */
 	uint16_t psr_vtotal_su;
 	/**
@@ -4489,7 +4489,7 @@ struct dmub_cmd_replay_copy_settings_dat
 	uint8_t aux_inst;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel instance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4512,7 +4512,7 @@ struct dmub_cmd_replay_copy_settings_dat
 	 */
 	uint8_t dpphy_inst;
 	/**
-	 * Determines if SMU optimzations are enabled/disabled.
+	 * Determines if SMU optimizations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -4602,7 +4602,7 @@ struct dmub_rb_cmd_smart_power_oled_enab
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4641,7 +4641,7 @@ struct dmub_rb_cmd_replay_enable_data {
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4689,7 +4689,7 @@ struct dmub_rb_cmd_replay_enable {
 struct dmub_cmd_replay_set_power_opt_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4709,7 +4709,7 @@ struct dmub_cmd_replay_set_power_opt_dat
 struct dmub_cmd_replay_set_timing_sync_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4729,7 +4729,7 @@ struct dmub_cmd_replay_set_timing_sync_d
 struct dmub_cmd_replay_set_pseudo_vtotal {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4745,7 +4745,7 @@ struct dmub_cmd_replay_set_pseudo_vtotal
 struct dmub_cmd_replay_disabled_adaptive_sync_sdp_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4759,7 +4759,7 @@ struct dmub_cmd_replay_disabled_adaptive
 struct dmub_cmd_replay_set_general_cmd_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4796,7 +4796,7 @@ struct dmub_rb_cmd_replay_set_power_opt
  */
 struct dmub_cmd_replay_set_coasting_vtotal_data {
 	/**
-	 * 16-bit value dicated by driver that indicates the coasting vtotal.
+	 * 16-bit value dictated by driver that indicates the coasting vtotal.
 	 */
 	uint16_t coasting_vtotal;
 	/**
@@ -4805,12 +4805,12 @@ struct dmub_cmd_replay_set_coasting_vtot
 	uint8_t cmd_version;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
 	/**
-	 * 16-bit value dicated by driver that indicates the coasting vtotal high byte part.
+	 * 16-bit value dictated by driver that indicates the coasting vtotal high byte part.
 	 */
 	uint16_t coasting_vtotal_high;
 	/**
@@ -4913,7 +4913,7 @@ struct dmub_rb_cmd_replay_set_general_cm
 struct dmub_cmd_replay_frameupdate_timer_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -4946,7 +4946,7 @@ struct dmub_rb_cmd_replay_set_frameupdat
 union dmub_replay_cmd_set {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -5122,7 +5122,7 @@ struct dmub_hw_lock_inst_flags {
 	uint8_t opp_inst;
 	/**
 	 * OTG HW instance for global update lock.
-	 * TODO: Remove, and re-use otg_inst.
+	 * TODO: Remove, and reuse otg_inst.
 	 */
 	uint8_t dig_inst;
 	/**
@@ -6609,7 +6609,7 @@ struct dmub_cmd_pr_enable_data {
 	uint8_t enable;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which replay_state to use
+	 * Panel instance to identify which replay_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6687,7 +6687,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	uint8_t aux_inst;
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel instance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6696,7 +6696,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	 */
 	uint8_t dpphy_inst;
 	/**
-	 * Determines if SMU optimzations are enabled/disabled.
+	 * Determines if SMU optimizations are enabled/disabled.
 	 */
 	uint8_t smu_optimizations_en;
 	/**
@@ -6704,7 +6704,7 @@ struct dmub_cmd_pr_copy_settings_data {
 	 */
 	uint32_t line_time_in_ns;
 	/*
-	 * Use FSFT afftet pixel clk
+	 * Use FSFT after pixel clk
 	 */
 	uint32_t pix_clk_100hz;
 	/*
@@ -6777,7 +6777,7 @@ union dmub_pr_runtime_flags {
 struct dmub_cmd_pr_update_state_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel instance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
@@ -6799,7 +6799,7 @@ struct dmub_cmd_pr_update_state_data {
 struct dmub_cmd_pr_general_cmd_data {
 	/**
 	 * Panel Instance.
-	 * Panel isntance to identify which psr_state to use
+	 * Panel instance to identify which psr_state to use
 	 * Currently the support is only for 0 or 1
 	 */
 	uint8_t panel_inst;
