Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65264FF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D2110E953;
	Mon, 27 Apr 2026 21:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.b="RKRi/tD/";
	dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB5210E94D;
 Mon, 27 Apr 2026 21:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=wfCWRNqlZezMxFMCv0tqtbKuZJLO2xtkjSupxx5nIf4=; b=RKRi/tD/qwm0U6+H4oQtnhNH6S
 ACAK8ntdmAhMyxafmCSaITYdAk2nMrlrNxGqHhW6b5eP0QTkzf9+sa7Kw11Zmuyt8Joe9x6L6UPNi
 LEE+PhYMFF0ac1wOHyidVqkuzJCgTe3Jj0Sl812KdALNrS/LEqd0AEmxjoh+8r+9ynOZ2NMw7EXRN
 27IfOyE5No78OWGF7EgYs0+7Hy8rgp2KiDUyNFa73W24TojB/9O310jsbEY9VzJWc0ov1cdrqPbLY
 U0NIalvFc86MZHhvkg+Rv0XP2k4lIVW2JFRRHdpfHQI2quCGH1mzUifW+IWMlrCWy7Yce5QAa8et2
 NddinQFg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
 id 1wHThl-00000000BoX-109a; Mon, 27 Apr 2026 21:41:25 +0000
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
Subject: [PATCH 2/3 v2] drm/amd/display: dmub_cmd.h: correct all kernel-doc
 prototype warnings
Date: Mon, 27 Apr 2026 14:41:20 -0700
Message-ID: <20260427214122.784024-2-rdunlap@infradead.org>
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

Correct all typedef, struct, and union prototype warnings in
dmub_cmd.h by using the matching names or "typedef" keyword:

Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:961 cannot understand function prototype: 'typedef uint32_t dmub_trace_code_t;'
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:1183 expecting prototype for union dmub_shared_state_ips_fw. Prototype was for union dmub_shared_state_ips_fw_signals instead
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:1203 expecting prototype for union dmub_shared_state_ips_signals. Prototype was for union dmub_shared_state_ips_driver_signals instead
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:1253 expecting prototype for struct dmub_shared_state_cursor_offload_v1. Prototype was for struct dmub_shared_state_cursor_offload_stream_v1 instead
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:1269 struct dmub_shared
_state_feature_common { uint32_t padding[62]; };: error: Cannot parse enum!
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:1278 struct dmub_shared
_state_feature_header { uint16_t id;  uint16_t version;  uint32_t reserved;  };:
 error: Cannot parse enum!
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:2001 expecting prototype for struct dmub_cmd_read_modify_write_sequence. Prototype was for struct dmub_rb_cmd_read_modify_write instead
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:2191 expecting prototype for struct dmub_rb_cmd_cab. Prototype was for struct dmub_rb_cmd_cab_for_ss instead
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:2875 expecting prototype for struct dmub_cmd_set_pixel_clock_data. Prototype was for struct dmub_rb_cmd_set_pixel_clock instead
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:3398 expecting prototype for union dpia_notify_data_type. Prototype was for union dpia_notification_data instead
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:3447 expecting prototype for struct dmub_rb_cmd_hpd_sense_notify. Prototype was for struct dmub_rb_cmd_hpd_sense_notify_data instead
Warning: drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h:6267 expecting prototype for struct dmub_cmd_cable_id_input. Prototype was for struct dmub_cmd_cable_id_output instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: fix more warnings; rebase & resend

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>

 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h |   24 +++++++-------
 1 file changed, 12 insertions(+), 12 deletions(-)

--- linux-next-20260427.orig/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ linux-next-20260427/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -958,7 +958,7 @@ union dmub_fw_meta {
 //==============================================================================
 #if !defined(TENSILICA) && !defined(DMUB_TRACE_ENTRY_DEFINED)
 /**
- * dmub_trace_code_t - firmware trace code, 32-bits
+ * typedef dmub_trace_code_t - firmware trace code, 32-bits
  */
 typedef uint32_t dmub_trace_code_t;
 
@@ -1170,7 +1170,7 @@ enum dmub_shared_state_feature_id {
 };
 
 /**
- * struct dmub_shared_state_ips_fw - Firmware signals for IPS.
+ * struct dmub_shared_state_ips_fw_signals - Firmware signals for IPS.
  */
 union dmub_shared_state_ips_fw_signals {
 	struct {
@@ -1185,7 +1185,7 @@ union dmub_shared_state_ips_fw_signals {
 };
 
 /**
- * struct dmub_shared_state_ips_signals - Firmware signals for IPS.
+ * struct dmub_shared_state_ips_driver_signals - Firmware signals for IPS.
  */
 union dmub_shared_state_ips_driver_signals {
 	struct {
@@ -1247,7 +1247,7 @@ struct dmub_shared_state_ips_driver {
 }; /* 248-bytes, fixed */
 
 /**
- * struct dmub_shared_state_cursor_offload_v1 - Header metadata for cursor offload.
+ * struct dmub_shared_state_cursor_offload_stream_v1 - Header metadata for cursor offload.
  */
 struct dmub_shared_state_cursor_offload_stream_v1 {
 	uint32_t last_write_idx; /**< Last write index */
@@ -1263,14 +1263,14 @@ struct dmub_shared_state_cursor_offload_
 }; /* 248-bytes, fixed */
 
 /**
- * enum dmub_shared_state_feature_common - Generic payload.
+ * struct dmub_shared_state_feature_common - Generic payload.
  */
 struct dmub_shared_state_feature_common {
 	uint32_t padding[62];
 }; /* 248-bytes, fixed */
 
 /**
- * enum dmub_shared_state_feature_header - Feature description.
+ * struct dmub_shared_state_feature_header - Feature description.
  */
 struct dmub_shared_state_feature_header {
 	uint16_t id; /**< Feature ID */
@@ -1990,7 +1990,7 @@ struct dmub_cmd_read_modify_write_sequen
 #define DMUB_READ_MODIFY_WRITE_SEQ__MAX 5
 
 /**
- * struct dmub_cmd_read_modify_write_sequence - Read modify write command.
+ * struct dmub_rb_cmd_read_modify_write - Read modify write command.
  */
 struct dmub_rb_cmd_read_modify_write {
 	struct dmub_cmd_header header;  /**< command header */
@@ -2182,7 +2182,7 @@ enum dmub_cmd_cab_type {
 };
 
 /**
- * struct dmub_rb_cmd_cab - CAB command data.
+ * struct dmub_rb_cmd_cab_for_ss - CAB command data.
  */
 struct dmub_rb_cmd_cab_for_ss {
 	struct dmub_cmd_header header;
@@ -2867,7 +2867,7 @@ struct dmub_cmd_set_pixel_clock_data {
 };
 
 /**
- * struct dmub_cmd_set_pixel_clock_data - Set pixel clock command.
+ * struct dmub_rb_cmd_set_pixel_clock - Set pixel clock command.
  */
 struct dmub_rb_cmd_set_pixel_clock {
 	struct dmub_cmd_header header; /**< header */
@@ -3383,7 +3383,7 @@ struct dpia_bw_allocation_notify_data {
 };
 
 /**
- * union dpia_notify_data_type - DPIA Notification in Outbox command
+ * union dpia_notification_data - DPIA Notification in Outbox command
  */
 union dpia_notification_data {
 	/**
@@ -3439,7 +3439,7 @@ struct dmub_rb_cmd_query_hpd_state {
 };
 
 /**
- * struct dmub_rb_cmd_hpd_sense_notify - HPD sense notification data.
+ * struct dmub_rb_cmd_hpd_sense_notify_data - HPD sense notification data.
  */
 struct dmub_rb_cmd_hpd_sense_notify_data {
 	uint32_t old_hpd_sense_mask; /**< Old HPD sense mask */
@@ -6318,7 +6318,7 @@ struct dmub_cmd_cable_id_input {
 };
 
 /**
- * struct dmub_cmd_cable_id_input - Defines the output of DMUB_CMD_GET_USBC_CABLE_ID command.
+ * struct dmub_cmd_cable_id_output - Defines the output of DMUB_CMD_GET_USBC_CABLE_ID command.
  */
 struct dmub_cmd_cable_id_output {
 	uint8_t UHBR10_20_CAPABILITY	:2; /**< b'01 for UHBR10 support, b'10 for both UHBR10 and UHBR20 support */
