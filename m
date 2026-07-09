Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65FDC44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16AF710F44C;
	Thu,  9 Jul 2026 07:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=haghiri.net header.i=@haghiri.net header.b="cCgcY9Ma";
	dkim-atps=neutral
X-Greylist: delayed 901 seconds by postgrey-1.36 at gabe;
 Thu, 09 Jul 2026 01:37:29 UTC
Received: from a4i518.smtp2go.com (a4i518.smtp2go.com [158.120.82.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A01C10F33F
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 01:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haghiri.net;
 i=@haghiri.net; q=dns/txt; s=s670074; t=1783560147; h=from : subject :
 to : message-id : date;
 bh=KkiCaALhAJ0hkcqk4KtZdF8tOvI98P3cJzz6eBuDRvQ=;
 b=cCgcY9MadfE0pWaRgRHyGwuIuN059xl8IWq9Lhd/pxtMoqdoX8uEvrR36QyYypGOzxwvg
 Y8TjT30Z2zoIKFvolYpyxM/M4Siqp19GcREqZ/06ydjtqmLJkenUuu2gehR4OrLfgnnH3ct
 fysLdgfOBFvMEL+ykQpcy87muwMn4Da2FpkTuvib5IzV+Nh9xBe3l75VY+kzPRdnBgFdwn3
 FXuywggdXyzu2wGRtDjF5T2SWYcWJQeOSSYB478g/zrWKE9Qy8pa+apaeJEZe0bM/ofUGiN
 P9nQZ5qQixTwXwpp5xXutrsDawZUbicd0ZTMV7OAmLnzQwscGcERsbr35xVA==
Received: from [10.132.241.142] (helo=[172.27.1.123])
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <nick@haghiri.net>)
 id 1whdSm-FnQW0hPqD0W-2VFa; Thu, 09 Jul 2026 01:22:04 +0000
From: Nick Haghiri <nick@haghiri.net>
Date: Wed, 08 Jul 2026 21:20:49 -0400
Subject: [PATCH v2] drm/amd/display: unify HDMI/DP SST HPD debounce delay
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-hpd-debounce-unify-v2-1-d214832551b3@haghiri.net>
X-B4-Tracking: v=1; b=H4sIAHD3TmoC/yWNyw6CMBBFf8V07Zg+tLSu/A/DgtIpHReFtEAkh
 H8XcHmSc89dWcFMWNjzsrKMMxXq0w7yemFtbFKHQH5nJrnUvOIG4uDBo+un1CJMicICxurGK12
 5wCXbh0PGQN8z+q7/XCb3wXY8SocRqYx9Xs7XWRweM6hlEMqC8FrAXSkEw6UFJziXj0Ya69UrN
 l2kTLeEI6u3bfsBIO/bUb8AAAA=
X-Change-ID: 20260708-hpd-debounce-unify-896ad367bf02
In-Reply-To: <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
References: <8e62f139-1d61-433e-8029-b10025a289d3@haghiri.net>
To: Ivan Lipski <ivlipski@amd.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Xaver Hugl <xaver.hugl@kde.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Nick Haghiri <nick@haghiri.net>
X-Mailer: b4 0.15.2
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 670074m:670074aX29xAY:670074sBSGKfEW_W
X-smtpcorp-track: 48Qtt6pkuIzB.5PXcjDPCdZ3J.oO5YVAqyQ4K
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

Per review feedback on the DP SST debounce extension, fold
hdmi_hpd_debounce_delay_ms and dp_hpd_debounce_delay_ms into a single
hpd_debounce_delay_ms module parameter (eDP and MST still excluded),
and rename the shared connector fields, work, and cached sink from
hdmi_* to generic hpd_*.

Also add an apply_edid_quirks() case for the MSI MPG 274U
(drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0)) that enables a
1500ms default debounce delay for that panel, overridable by the
module parameter.

Signed-off-by: Nick Haghiri <nick@haghiri.net>
---
Ivan, generalized to a single hpd_debounce_delay_ms for both HDMI and
DP SST as suggested, and added the apply_edid_quirks() case for the
MSI MPG 274U (1500ms default, module param still overrides it).

Went with replacing hdmi_hpd_debounce_delay_ms rather than keeping a
back-compat alias, since it's only a couple cycles old. Shout if you'd
rather I keep the alias.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h                |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            | 26 +++-------
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  | 18 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    | 29 ++++-------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |  8 +++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c  | 58 +++++++++++-----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h  |  2 +-
 7 files changed, 60 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c085a6cc1..af1748984 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -270,8 +270,7 @@ extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
 extern int amdgpu_ptl;
 
-extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
-extern uint amdgpu_dp_hpd_debounce_delay_ms;
+extern uint amdgpu_hpd_debounce_delay_ms;
 
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 78df53b8c..5ed415aa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -245,8 +245,7 @@ int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
-uint amdgpu_hdmi_hpd_debounce_delay_ms;
-uint amdgpu_dp_hpd_debounce_delay_ms;
+uint amdgpu_hpd_debounce_delay_ms;
 int amdgpu_ptl = -1; /* auto */
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
@@ -1105,25 +1104,12 @@ MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disab
 module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 
 /*
- * DOC: hdmi_hpd_debounce_delay_ms (uint)
- * HDMI HPD disconnect debounce delay in milliseconds.
- *
- * Used to filter short disconnect->reconnect HPD toggles some HDMI sinks
- * generate while entering/leaving power save. Set to 0 to disable by default.
- */
-MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
-module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
-
-/*
- * DOC: dp_hpd_debounce_delay_ms (uint)
- * DisplayPort SST HPD disconnect debounce delay in milliseconds.
- *
- * Used to filter short disconnect->reconnect HPD toggles some DisplayPort SST
- * sinks generate while entering/leaving power save. Set to 0 to disable by
- * default. eDP and MST are not affected.
+ * DOC: hpd_debounce_delay_ms (uint)
+ * HDMI/DP SST HPD disconnect debounce delay in milliseconds. eDP and MST
+ * are not affected. Overrides any per-panel default set via EDID quirks.
  */
-MODULE_PARM_DESC(dp_hpd_debounce_delay_ms, "DisplayPort SST HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
-module_param_named(dp_hpd_debounce_delay_ms, amdgpu_dp_hpd_debounce_delay_ms, uint, 0644);
+MODULE_PARM_DESC(hpd_debounce_delay_ms, "HDMI/DP SST HPD disconnect debounce delay in milliseconds (0 to disable (by default) or use the EDID quirk default, 1500 is common)");
+module_param_named(hpd_debounce_delay_ms, amdgpu_hpd_debounce_delay_ms, uint, 0644);
 
 /**
  * DOC: ptl (int)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index abc17f547..530e63321 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -61,14 +61,9 @@ enum amd_vsdb_panel_type {
 #define AMDGPU_HDR_MULT_DEFAULT (0x100000000LL)
 
 /*
- * Maximum HDMI HPD debounce delay in milliseconds
+ * Maximum HDMI/DP SST HPD debounce delay in milliseconds
  */
-#define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
-
-/*
- * Maximum DisplayPort SST HPD debounce delay in milliseconds
- */
-#define AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS 5000
+#define AMDGPU_DM_MAX_HPD_DEBOUNCE_MS 5000
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -878,11 +873,10 @@ struct amdgpu_dm_connector {
 	enum adaptive_sync_type as_type;
 	struct amdgpu_hdmi_vsdb_info vsdb_info;
 
-	/* HDMI HPD debounce support */
-	unsigned int hdmi_hpd_debounce_delay_ms;
-	unsigned int dp_hpd_debounce_delay_ms;
-	struct delayed_work hdmi_hpd_debounce_work;
-	struct dc_sink *hdmi_prev_sink;
+	/* HDMI/DP SST HPD debounce support */
+	unsigned int hpd_debounce_delay_ms;
+	struct delayed_work hpd_debounce_work;
+	struct dc_sink *hpd_prev_sink;
 
 	/* HDMI compliance automation */
 	bool hdmi_comp_auto;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index c79a8ada8..798825ec1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1748,12 +1748,10 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
 
 	/* Cancel and flush any pending HPD debounce work */
-	if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
-		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
-		if (aconnector->hdmi_prev_sink) {
-			dc_sink_release(aconnector->hdmi_prev_sink);
-			aconnector->hdmi_prev_sink = NULL;
-		}
+	cancel_delayed_work_sync(&aconnector->hpd_debounce_work);
+	if (aconnector->hpd_prev_sink) {
+		dc_sink_release(aconnector->hpd_prev_sink);
+		aconnector->hpd_prev_sink = NULL;
 	}
 
 	if (aconnector->bl_idx != -1) {
@@ -2828,20 +2826,11 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	mutex_init(&aconnector->hpd_lock);
 	mutex_init(&aconnector->handle_mst_msg_ready);
 
-	/*
-	 * If an HPD debounce delay is set, clamp each signal's delay to its
-	 * maximum. The debounce work and cached sink are shared by both the
-	 * HDMI and DisplayPort SST paths.
-	 */
-	aconnector->hdmi_hpd_debounce_delay_ms = amdgpu_hdmi_hpd_debounce_delay_ms ?
-		min(amdgpu_hdmi_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS) : 0;
-	aconnector->dp_hpd_debounce_delay_ms = amdgpu_dp_hpd_debounce_delay_ms ?
-		min(amdgpu_dp_hpd_debounce_delay_ms, AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS) : 0;
-
-	if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
-		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, amdgpu_dm_hdmi_hpd_debounce_work);
-		aconnector->hdmi_prev_sink = NULL;
-	}
+	/* May be overridden later by an EDID quirk in apply_edid_quirks() */
+	aconnector->hpd_debounce_delay_ms = amdgpu_hpd_debounce_delay_ms ?
+		min(amdgpu_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS) : 0;
+	aconnector->hpd_prev_sink = NULL;
+	INIT_DELAYED_WORK(&aconnector->hpd_debounce_work, amdgpu_dm_hpd_debounce_work);
 
 	dm->hdmi_frl_status_polling_delay_ms = 200;
 	INIT_DELAYED_WORK(&dm->hdmi_frl_status_polling_work, hdmi_frl_status_polling_work);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 9c4e0a4e2..71c897416 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -137,6 +137,14 @@ static void apply_edid_quirks(struct dc_link *link, struct edid *edid,
 		drm_dbg_driver(dev, "Skip PHY SSC reduction on panel id %X\n", panel_id);
 		link->wa_flags.skip_phy_ssc_reduction = true;
 		break;
+	/* Workaround for monitors that toggle HPD on entering deep sleep */
+	case drm_edid_encode_panel_id('M', 'S', 'I', 0x3CF0):
+		if (!aconnector->hpd_debounce_delay_ms) {
+			drm_dbg_driver(dev, "Enabling HPD debounce on panel id %X\n", panel_id);
+			aconnector->hpd_debounce_delay_ms =
+				min(1500U, AMDGPU_DM_MAX_HPD_DEBOUNCE_MS);
+		}
+		break;
 	default:
 		return;
 	}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 2a732d19b..e423dbe9b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1217,13 +1217,13 @@ EXPORT_IF_KUNIT(are_sinks_equal);
 
 
 /**
- * DOC: amdgpu_dm_hdmi_hpd_debounce_work
+ * DOC: amdgpu_dm_hpd_debounce_work
  *
- * HDMI HPD debounce delay in milliseconds. When an HDMI display toggles HPD
+ * HDMI/DP SST HPD debounce delay in milliseconds. When a display toggles HPD
  * (such as during power save transitions), this delay determines how long to
  * wait before processing the HPD event. This allows distinguishing between a
- * physical unplug (>hdmi_hpd_debounce_delay)
- * and a spontaneous RX HPD toggle (<hdmi_hpd_debounce_delay).
+ * physical unplug (>hpd_debounce_delay)
+ * and a spontaneous RX HPD toggle (<hpd_debounce_delay).
  *
  * If the toggle is less than this delay, the driver compares sink capabilities
  * and permits a hotplug event if they changed.
@@ -1231,11 +1231,11 @@ EXPORT_IF_KUNIT(are_sinks_equal);
  * The default value of 1500ms was chosen based on experimental testing with
  * various monitors that exhibit spontaneous HPD toggling behavior.
  */
-void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
+void amdgpu_dm_hpd_debounce_work(struct work_struct *work)
 {
 	struct amdgpu_dm_connector *aconnector =
 		container_of(to_delayed_work(work), struct amdgpu_dm_connector,
-			     hdmi_hpd_debounce_work);
+			     hpd_debounce_work);
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -1259,11 +1259,12 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 		/* Apply workaround delay for certain panels */
 		amdgpu_dm_apply_delay_after_dpcd_poweroff(adev, aconnector->dc_sink);
 		/* Compare sinks to determine if this was a spontaneous HPD toggle */
-		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hdmi_prev_sink)) {
+		if (are_sinks_equal(aconnector->dc_link->local_sink, aconnector->hpd_prev_sink)) {
 			/*
-			 * Sinks match - this was a spontaneous HDMI HPD toggle.
+			 * Sinks match - this was a spontaneous HPD toggle.
 			 */
-			drm_dbg_kms(dev, "HDMI HPD: Sink unchanged after debounce, internal re-enable\n");
+			drm_dbg_kms(dev,
+				    "HPD: Sink unchanged after debounce, internal re-enable\n");
 			fake_reconnect = true;
 		}
 
@@ -1280,9 +1281,9 @@ void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work)
 	}
 
 	/* Release the cached sink reference */
-	if (aconnector->hdmi_prev_sink) {
-		dc_sink_release(aconnector->hdmi_prev_sink);
-		aconnector->hdmi_prev_sink = NULL;
+	if (aconnector->hpd_prev_sink) {
+		dc_sink_release(aconnector->hpd_prev_sink);
+		aconnector->hpd_prev_sink = NULL;
 	}
 
 	scoped_guard(mutex, &adev->dm.dc_lock) {
@@ -1302,7 +1303,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 	struct dc *dc = aconnector->dc_link->ctx->dc;
 	bool ret = false;
 	bool debounce_required = false;
-	unsigned int debounce_delay_ms = 0;
+	bool debounce_eligible;
 
 	if (adev->dm.disable_hpd_irq)
 		return;
@@ -1329,13 +1330,12 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 	 * Check for an HDMI or DisplayPort SST disconnect with debounce
 	 * enabled. eDP and MST are intentionally excluded.
 	 */
-	if (dc_is_hdmi_signal(aconnector->dc_link->connector_signal))
-		debounce_delay_ms = aconnector->hdmi_hpd_debounce_delay_ms;
-	else if (aconnector->dc_link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
-		 aconnector->dc_link->type != dc_connection_mst_branch)
-		debounce_delay_ms = aconnector->dp_hpd_debounce_delay_ms;
+	debounce_eligible = dc_is_hdmi_signal(aconnector->dc_link->connector_signal) ||
+			     (aconnector->dc_link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
+			      aconnector->dc_link->type != dc_connection_mst_branch);
 
-	debounce_required = (debounce_delay_ms > 0 &&
+	debounce_required = (debounce_eligible &&
+			      aconnector->hpd_debounce_delay_ms > 0 &&
 			      new_connection_type == dc_connection_none &&
 			      aconnector->dc_link->local_sink != NULL);
 
@@ -1356,25 +1356,25 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 		 * HDMI/DP HPD signals from physical unplugs.
 		 */
 		drm_dbg_kms(dev, "HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
-			    debounce_delay_ms);
+			    aconnector->hpd_debounce_delay_ms);
 
 		/* Cache the current sink for later comparison */
-		if (aconnector->hdmi_prev_sink)
-			dc_sink_release(aconnector->hdmi_prev_sink);
-		aconnector->hdmi_prev_sink = aconnector->dc_link->local_sink;
-		if (aconnector->hdmi_prev_sink)
-			dc_sink_retain(aconnector->hdmi_prev_sink);
+		if (aconnector->hpd_prev_sink)
+			dc_sink_release(aconnector->hpd_prev_sink);
+		aconnector->hpd_prev_sink = aconnector->dc_link->local_sink;
+		if (aconnector->hpd_prev_sink)
+			dc_sink_retain(aconnector->hpd_prev_sink);
 
 		/* Schedule delayed detection. */
 		if (mod_delayed_work(system_percpu_wq,
-				 &aconnector->hdmi_hpd_debounce_work,
-				 msecs_to_jiffies(debounce_delay_ms)))
+				 &aconnector->hpd_debounce_work,
+				 msecs_to_jiffies(aconnector->hpd_debounce_delay_ms)))
 			drm_dbg_kms(dev, "HPD: Re-scheduled debounce work\n");
 
 	} else {
 
-		/* If the aconnector->hdmi_hpd_debounce_work is scheduled, exit early */
-		if (delayed_work_pending(&aconnector->hdmi_hpd_debounce_work))
+		/* If the aconnector->hpd_debounce_work is scheduled, exit early */
+		if (delayed_work_pending(&aconnector->hpd_debounce_work))
 			return;
 
 		scoped_guard(mutex, &adev->dm.dc_lock) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index bccb5d354..66fb82961 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -113,7 +113,7 @@ void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
 struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(struct amdgpu_device *adev);
 void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm);
 int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev);
-void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work);
+void amdgpu_dm_hpd_debounce_work(struct work_struct *work);
 
 /* IRQ handlers */
 struct amdgpu_crtc *amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,

---
base-commit: c92b5b607c1c8ab786fccf03d62352b82f6539ae
change-id: 20260708-hpd-debounce-unify-896ad367bf02

Best regards,
--  
Nick Haghiri <nick@haghiri.net>

