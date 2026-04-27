Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D40EFF8870
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CF310E951;
	Mon, 27 Apr 2026 21:41:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="gdKjbtj1";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAB8710E951;
 Mon, 27 Apr 2026 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=qslmqTqWbkCvg1OPvraTWpbg89eE83xCleC2USj8oko=; b=gdKjbtj1xl8pKadfdR1+km7F4a
 ZjWkVT/ivNSiHmT7SbIWzkpWphekCCkYjz1GM3eyO0tFWWTmbCLSLy4gEu6MUYpb/VInwQPtL8Sr0
 Dc9H1ssMSSc9rI/8/z+yoZdpHezgcIDuayntGc2CsVIC3Gluer4+zc+ZnwmqUKnRDNpvx9z0BgWuO
 4tlvFWJ2gi/ZLIjfqQ+Y4MBvFs3SjQg0P2os5HQvE4RsCaqNmJhgwN5ZUz5kFsZeYFDrEoccRMndz
 CLp8otcrG3pS5vWMG9yPE8EAkxqUMma/pASPsd7lbozq8LYpB7CcFEQD8+0DxwDdExHblfqqmwM7s
 6Cp7X7xQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wHThl-00000000BoX-2jgA; Mon, 27 Apr 2026 21:41:25 +0000
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
Subject: [PATCH 3/3 v2] drm/amd/display: dmub_cmd.h: add missing kernel-doc
 for enums
Date: Mon, 27 Apr 2026 14:41:21 -0700
Message-ID: <20260427214122.784024-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427214122.784024-1-rdunlap@infradead.org>
References: <20260427214122.784024-1-rdunlap@infradead.org>
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

For enums that have a kernel-doc ("/**") comment block, add or correct
their kernel-doc to eliminate all kernel-doc enum warnings.

Some of these needed "struct" changed to "enum" in the kernel-doc header.
For a few of them, I changed the "/**" comment to a plain "/*"
comment since there was no kernel-doc content there.

Example:

Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:2673 Enum value 'FAMS2_ALLOW_DELAY_CHECK_NONE' not described in enum 'dmub_fams2_allow_delay_check_mode'
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:2673 Enum value 'FAMS2_ALLOW_DELAY_CHECK_FROM_START' not described in enum 'dmub_fams2_allow_delay_check_mode'
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:2673 Enum value 'FAMS2_ALLOW_DELAY_CHECK_FROM_PREPARE' not described in enum 'dmub_fams2_allow_delay_check_mode'

All .o files are the same with or without this patch.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: rebase & resend

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h |  156 +++++++++-----
 1 file changed, 108 insertions(+), 48 deletions(-)

--- linux-next-20260427.orig/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ linux-next-20260427/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -1008,15 +1008,30 @@ union dmub_fw_boot_status {
  * enum dmub_fw_boot_status_bit - Enum bit definitions for SCRATCH0.
  */
 enum dmub_fw_boot_status_bit {
-	DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE = (1 << 0), /**< 1 if DAL FW */
-	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1), /**< 1 if mailbox ready */
-	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2), /**< 1 if init done */
-	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3), /**< 1 if driver should call restore */
-	DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED = (1 << 4), /**< 1 if VBIOS data is deferred programmed */
-	DMUB_FW_BOOT_STATUS_BIT_FAMS_ENABLED = (1 << 5), /**< 1 if FAMS is enabled*/
-	DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED = (1 << 6), /**< 1 if detection need to be triggered by driver*/
-	DMUB_FW_BOOT_STATUS_BIT_HW_POWER_INIT_DONE = (1 << 7), /**< 1 if hw power init is completed */
-	DMUB_FW_BOOT_STATUS_BIT_ONO_REGIONS_ENABLED = (1 << 8), /**< 1 if ONO regions are enabled */
+	/** @DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE: 1 if DAL FW */
+	DMUB_FW_BOOT_STATUS_BIT_DAL_FIRMWARE = (1 << 0),
+	/** @DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY: 1 if mailbox ready */
+	DMUB_FW_BOOT_STATUS_BIT_MAILBOX_READY = (1 << 1),
+	/** @DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE: 1 if init done */
+	DMUB_FW_BOOT_STATUS_BIT_OPTIMIZED_INIT_DONE = (1 << 2),
+	/** @DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED: 1 if driver should call restore */
+	DMUB_FW_BOOT_STATUS_BIT_RESTORE_REQUIRED = (1 << 3),
+	/**
+	 * @DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED: 1 if VBIOS data is
+	 * deferred programmed
+	 */
+	DMUB_FW_BOOT_STATUS_BIT_DEFERRED_LOADED = (1 << 4),
+	/** @DMUB_FW_BOOT_STATUS_BIT_FAMS_ENABLED: 1 if FAMS is enabled */
+	DMUB_FW_BOOT_STATUS_BIT_FAMS_ENABLED = (1 << 5),
+	/**
+	 * @DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED: 1 if detection needs
+	 * to be triggered by driver
+	 */
+	DMUB_FW_BOOT_STATUS_BIT_DETECTION_REQUIRED = (1 << 6),
+	/** @DMUB_FW_BOOT_STATUS_BIT_HW_POWER_INIT_DONE: 1 if hw power init is completed */
+	DMUB_FW_BOOT_STATUS_BIT_HW_POWER_INIT_DONE = (1 << 7),
+	/** @DMUB_FW_BOOT_STATUS_BIT_ONO_REGIONS_ENABLED: if ONO regions are enabled */
+	DMUB_FW_BOOT_STATUS_BIT_ONO_REGIONS_ENABLED = (1 << 8),
 };
 
 /* Register bit definition for SCRATCH5 */
@@ -1080,18 +1095,22 @@ enum dmub_ips_comand_type {
  */
 enum dmub_cursor_offload_comand_type {
 	/**
+	 * @DMUB_CMD__CURSOR_OFFLOAD_INIT:
 	 * Initializes the cursor offload feature.
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD_INIT = 0,
 	/**
-	 * Enables cursor offloading for a stream and updates the timing parameters.
+	 * @DMUB_CMD__CURSOR_OFFLOAD_STREAM_ENABLE: Enables cursor offloading
+	 * for a stream and updates the timing parameters.
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD_STREAM_ENABLE = 1,
 	/**
+	 * @DMUB_CMD__CURSOR_OFFLOAD_STREAM_DISABLE:
 	 * Disables cursor offloading for a given stream.
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD_STREAM_DISABLE = 2,
 	/**
+	 * @DMUB_CMD__CURSOR_OFFLOAD_STREAM_PROGRAM:
 	 * Programs the latest data for a given stream.
 	 */
 	DMUB_CMD__CURSOR_OFFLOAD_STREAM_PROGRAM = 3,
@@ -1157,7 +1176,7 @@ enum dmub_fw_boot_options_bit {
  * [Header (256 Bytes)][Feature 1 (256 Bytes)][Feature 2 (256 Bytes)]...
  */
 
-/**
+/*
  * enum dmub_shared_state_feature_id - List of shared state features.
  */
 enum dmub_shared_state_feature_id {
@@ -1908,30 +1927,36 @@ enum dmub_cmd_type {
  */
 enum dmub_out_cmd_type {
 	/**
-	 * Invalid outbox command, ignored.
+	 * @DMUB_OUT_CMD__NULL: Invalid outbox command, ignored.
 	 */
 	DMUB_OUT_CMD__NULL = 0,
 	/**
+	 * @DMUB_OUT_CMD__DP_AUX_REPLY:
 	 * Command type used for DP AUX Reply data notification
 	 */
 	DMUB_OUT_CMD__DP_AUX_REPLY = 1,
 	/**
+	 * @DMUB_OUT_CMD__DP_HPD_NOTIFY:
 	 * Command type used for DP HPD event notification
 	 */
 	DMUB_OUT_CMD__DP_HPD_NOTIFY = 2,
 	/**
+	 * @DMUB_OUT_CMD__SET_CONFIG_REPLY:
 	 * Command type used for SET_CONFIG Reply notification
 	 */
 	DMUB_OUT_CMD__SET_CONFIG_REPLY = 3,
 	/**
+	 * @DMUB_OUT_CMD__DPIA_NOTIFICATION:
 	 * Command type used for USB4 DPIA notification
 	 */
 	DMUB_OUT_CMD__DPIA_NOTIFICATION = 5,
 	/**
+	 * @DMUB_OUT_CMD__HPD_SENSE_NOTIFY:
 	 * Command type used for HPD redetect notification
 	 */
 	DMUB_OUT_CMD__HPD_SENSE_NOTIFY = 6,
 	/**
+	 * @DMUB_OUT_CMD__FUSED_IO:
 	 * Command type used for Fused IO notification
 	 */
 	DMUB_OUT_CMD__FUSED_IO = 7,
@@ -2123,19 +2148,19 @@ struct dmub_rb_cmd_PLAT_54186_wa {
  */
 enum dmub_cmd_mall_type {
 	/**
-	 * Allows display refresh from MALL.
+	 * @DMUB_CMD__MALL_ACTION_ALLOW: Allows display refresh from MALL.
 	 */
 	DMUB_CMD__MALL_ACTION_ALLOW = 0,
 	/**
-	 * Disallows display refresh from MALL.
+	 * @DMUB_CMD__MALL_ACTION_DISALLOW: Disallows display refresh from MALL.
 	 */
 	DMUB_CMD__MALL_ACTION_DISALLOW = 1,
 	/**
-	 * Cursor copy for MALL.
+	 * @DMUB_CMD__MALL_ACTION_COPY_CURSOR: Cursor copy for MALL.
 	 */
 	DMUB_CMD__MALL_ACTION_COPY_CURSOR = 2,
 	/**
-	 * Controls DF requests.
+	 * @DMUB_CMD__MALL_ACTION_NO_DF_REQ: Controls DF requests.
 	 */
 	DMUB_CMD__MALL_ACTION_NO_DF_REQ = 3,
 };
@@ -2164,18 +2189,21 @@ struct dmub_rb_cmd_mall {
  */
 enum dmub_cmd_cab_type {
 	/**
+	 * @DMUB_CMD__CAB_NO_IDLE_OPTIMIZATION:
 	 * No idle optimizations (i.e. no CAB)
 	 */
 	DMUB_CMD__CAB_NO_IDLE_OPTIMIZATION = 0,
 	/**
-	 * No DCN requests for memory
+	 * @DMUB_CMD__CAB_NO_DCN_REQ: No DCN requests for memory
 	 */
 	DMUB_CMD__CAB_NO_DCN_REQ = 1,
 	/**
+	 * @DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB:
 	 * Fit surfaces in CAB (i.e. CAB enable)
 	 */
 	DMUB_CMD__CAB_DCN_SS_FIT_IN_CAB = 2,
 	/**
+	 * @DMUB_CMD__CAB_DCN_SS_NOT_FIT_IN_CAB:
 	 * Do not fit surfaces in CAB (i.e. no CAB)
 	 */
 	DMUB_CMD__CAB_DCN_SS_NOT_FIT_IN_CAB = 3,
@@ -2190,7 +2218,7 @@ struct dmub_rb_cmd_cab_for_ss {
 	uint8_t debug_bits;     /* debug bits */
 };
 
-/**
+/*
  * Enum for indicating which MCLK switch mode per pipe
  */
 enum mclk_switch_mode {
@@ -2664,11 +2692,18 @@ struct dmub_fams2_stream_static_state_v1
  * p-state request to allow latency
  */
 enum dmub_fams2_allow_delay_check_mode {
-	/* No check for request to allow delay */
+	/**
+	 * @FAMS2_ALLOW_DELAY_CHECK_NONE: No check for request to allow delay
+	 */
 	FAMS2_ALLOW_DELAY_CHECK_NONE = 0,
-	/* Check for request to allow delay */
+	/**
+	 * @FAMS2_ALLOW_DELAY_CHECK_FROM_START: Check for request to allow delay
+	 */
 	FAMS2_ALLOW_DELAY_CHECK_FROM_START = 1,
-	/* Check for prepare to allow delay */
+	/**
+	 * @FAMS2_ALLOW_DELAY_CHECK_FROM_PREPARE:
+	 * Check for prepare to allow delay
+	 */
 	FAMS2_ALLOW_DELAY_CHECK_FROM_PREPARE = 2,
 };
 
@@ -2740,27 +2775,28 @@ struct dmub_rb_cmd_ib {
  */
 enum dmub_cmd_idle_opt_type {
 	/**
-	 * DCN hardware restore.
+	 * @DMUB_CMD__IDLE_OPT_DCN_RESTORE: DCN hardware restore.
 	 */
 	DMUB_CMD__IDLE_OPT_DCN_RESTORE = 0,
 
 	/**
-	 * DCN hardware save.
+	 * @DMUB_CMD__IDLE_OPT_DCN_SAVE_INIT: DCN hardware save.
 	 */
 	DMUB_CMD__IDLE_OPT_DCN_SAVE_INIT = 1,
 
 	/**
-	 * DCN hardware notify idle.
+	 * @DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE: DCN hardware notify idle.
 	 */
 	DMUB_CMD__IDLE_OPT_DCN_NOTIFY_IDLE = 2,
 
 	/**
+	 * @DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE:
 	 * DCN hardware notify power state.
 	 */
 	DMUB_CMD__IDLE_OPT_SET_DC_POWER_STATE = 3,
 
 	/**
-	 * DCN notify to release HW.
+	 * @DMUB_CMD__IDLE_OPT_RELEASE_HW: DCN notify to release HW.
 	 */
 	 DMUB_CMD__IDLE_OPT_RELEASE_HW = 4,
 };
@@ -2789,7 +2825,7 @@ struct dmub_rb_cmd_idle_opt_dcn_notify_i
 	struct dmub_dcn_notify_idle_cntl_data cntl_data;
 };
 
-/**
+/*
  * enum dmub_idle_opt_dc_power_state - DC power states.
  */
 enum dmub_idle_opt_dc_power_state {
@@ -2831,7 +2867,7 @@ struct dmub_clocks {
  */
 enum dmub_cmd_clk_mgr_type {
 	/**
-	 * Notify DMCUB of clock update.
+	 * @DMUB_CMD__CLK_MGR_NOTIFY_CLOCKS: Notify DMCUB of clock update.
 	 */
 	DMUB_CMD__CLK_MGR_NOTIFY_CLOCKS = 0,
 };
@@ -3076,21 +3112,40 @@ struct dmub_rb_cmd_dpphy_init {
  * 4 AUX request command bits are shifted to high nibble.
  */
 enum dp_aux_request_action {
-	/** I2C-over-AUX write request */
+	/**
+	 * @DP_AUX_REQ_ACTION_I2C_WRITE: I2C-over-AUX write request
+	 */
 	DP_AUX_REQ_ACTION_I2C_WRITE		= 0x00,
-	/** I2C-over-AUX read request */
+	/**
+	 * @DP_AUX_REQ_ACTION_I2C_READ: I2C-over-AUX read request
+	 */
 	DP_AUX_REQ_ACTION_I2C_READ		= 0x10,
-	/** I2C-over-AUX write status request */
+	/**
+	 * @DP_AUX_REQ_ACTION_I2C_STATUS_REQ: I2C-over-AUX write status request
+	 */
 	DP_AUX_REQ_ACTION_I2C_STATUS_REQ	= 0x20,
-	/** I2C-over-AUX write request with MOT=1 */
+	/**
+	 * @DP_AUX_REQ_ACTION_I2C_WRITE_MOT:
+	 * I2C-over-AUX write request with MOT=1
+	 */
 	DP_AUX_REQ_ACTION_I2C_WRITE_MOT		= 0x40,
-	/** I2C-over-AUX read request with MOT=1 */
+	/**
+	 * @DP_AUX_REQ_ACTION_I2C_READ_MOT:
+	 * I2C-over-AUX read request with MOT=1
+	 */
 	DP_AUX_REQ_ACTION_I2C_READ_MOT		= 0x50,
-	/** I2C-over-AUX write status request with MOT=1 */
+	/**
+	 * @DP_AUX_REQ_ACTION_I2C_STATUS_REQ_MOT:
+	 * I2C-over-AUX write status request with MOT=1
+	 */
 	DP_AUX_REQ_ACTION_I2C_STATUS_REQ_MOT	= 0x60,
-	/** Native AUX write request */
+	/**
+	 * @DP_AUX_REQ_ACTION_DPCD_WRITE: Native AUX write request
+	 */
 	DP_AUX_REQ_ACTION_DPCD_WRITE		= 0x80,
-	/** Native AUX read request */
+	/**
+	 * @DP_AUX_REQ_ACTION_DPCD_READ: Native AUX read request
+	 */
 	DP_AUX_REQ_ACTION_DPCD_READ		= 0x90
 };
 
@@ -3098,21 +3153,21 @@ enum dp_aux_request_action {
  * enum aux_return_code_type - DP AUX process return code listing.
  */
 enum aux_return_code_type {
-	/** AUX process succeeded */
+	/** @AUX_RET_SUCCESS: AUX process succeeded */
 	AUX_RET_SUCCESS = 0,
-	/** AUX process failed with unknown reason */
+	/** @AUX_RET_ERROR_UNKNOWN: AUX process failed with unknown reason */
 	AUX_RET_ERROR_UNKNOWN,
-	/** AUX process completed with invalid reply */
+	/** @AUX_RET_ERROR_INVALID_REPLY: AUX process completed with invalid reply */
 	AUX_RET_ERROR_INVALID_REPLY,
-	/** AUX process timed out */
+	/** @AUX_RET_ERROR_TIMEOUT: AUX process timed out */
 	AUX_RET_ERROR_TIMEOUT,
-	/** HPD was low during AUX process */
+	/** @AUX_RET_ERROR_HPD_DISCON: HPD was low during AUX process */
 	AUX_RET_ERROR_HPD_DISCON,
-	/** Failed to acquire AUX engine */
+	/** @AUX_RET_ERROR_ENGINE_ACQUIRE: Failed to acquire AUX engine */
 	AUX_RET_ERROR_ENGINE_ACQUIRE,
-	/** AUX request not supported */
+	/** @AUX_RET_ERROR_INVALID_OPERATION: AUX request not supported */
 	AUX_RET_ERROR_INVALID_OPERATION,
-	/** AUX process not available */
+	/** @AUX_RET_ERROR_PROTOCOL_ERROR: AUX process not available */
 	AUX_RET_ERROR_PROTOCOL_ERROR,
 };
 
@@ -3120,9 +3175,9 @@ enum aux_return_code_type {
  * enum aux_channel_type - DP AUX channel type listing.
  */
 enum aux_channel_type {
-	/** AUX thru Legacy DP AUX */
+	/** @AUX_CHANNEL_LEGACY_DDC: AUX thru Legacy DP AUX */
 	AUX_CHANNEL_LEGACY_DDC,
-	/** AUX thru DPIA DP tunneling */
+	/** @AUX_CHANNEL_DPIA: AUX thru DPIA DP tunneling */
 	AUX_CHANNEL_DPIA
 };
 
@@ -3607,7 +3662,7 @@ enum phy_link_rate {
 	 */
 };
 
-/**
+/*
  * enum dmub_phy_fsm_state - PHY FSM states.
  * PHY FSM state to transit to during PSR enable/disable.
  */
@@ -5884,10 +5939,11 @@ struct dmub_rb_cmd_abm_query_caps {
  */
 enum dmub_abm_ace_curve_type {
 	/**
-	 * ACE curve as defined by the SW layer.
+	 * @ABM_ACE_CURVE_TYPE__SW: ACE curve as defined by the SW layer.
 	 */
 	ABM_ACE_CURVE_TYPE__SW = 0,
 	/**
+	 * @ABM_ACE_CURVE_TYPE__SW_IF:
 	 * ACE curve as defined by the SW to HW translation interface layer.
 	 */
 	ABM_ACE_CURVE_TYPE__SW_IF = 1,
@@ -5898,10 +5954,11 @@ enum dmub_abm_ace_curve_type {
  */
 enum dmub_abm_histogram_type {
 	/**
-	 * ACE curve as defined by the SW layer.
+	 * @ABM_HISTOGRAM_TYPE__SW: ACE curve as defined by the SW layer.
 	 */
 	ABM_HISTOGRAM_TYPE__SW = 0,
 	/**
+	 * @ABM_HISTOGRAM_TYPE__SW_IF:
 	 * ACE curve as defined by the SW to HW translation interface layer.
 	 */
 	ABM_HISTOGRAM_TYPE__SW_IF = 1,
@@ -6107,14 +6164,17 @@ struct dmub_rb_cmd_get_visual_confirm_co
  */
 enum dmub_cmd_panel_cntl_type {
 	/**
+	 * @DMUB_CMD__PANEL_CNTL_HW_INIT:
 	 * Initializes embedded panel hardware blocks.
 	 */
 	DMUB_CMD__PANEL_CNTL_HW_INIT = 0,
 	/**
+	 * @DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO:
 	 * Queries backlight info for the embedded panel.
 	 */
 	DMUB_CMD__PANEL_CNTL_QUERY_BACKLIGHT_INFO = 1,
 	/**
+	 * @DMUB_CMD__PANEL_DEBUG_PWM_FREQ:
 	 * Sets the PWM Freq as per user's requirement.
 	 */
 	DMUB_CMD__PANEL_DEBUG_PWM_FREQ = 2,
