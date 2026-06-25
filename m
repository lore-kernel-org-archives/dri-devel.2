Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37418CDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A7BF10F49C;
	Fri, 26 Jun 2026 07:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=haghiri.net header.i=@haghiri.net header.b="ddq64g4B";
	dkim-atps=neutral
X-Greylist: delayed 901 seconds by postgrey-1.36 at gabe;
 Thu, 25 Jun 2026 15:19:55 UTC
Received: from a4i518.smtp2go.com (a4i518.smtp2go.com [158.120.82.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5911910E216
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 15:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haghiri.net;
 i=@haghiri.net; q=dns/txt; s=s670074; t=1782399892; h=from : subject :
 to : message-id : date;
 bh=5ZwT0PxOqnzVKIx4Y3cq874cex5oIA7eLWed26NQDUA=;
 b=ddq64g4BBOnNrM36lpQueYme068HsCmiV6jLgqsfGAY5/lnyyWyd43ORMMVU9W7XFkwop
 FGHZe+4i0/Q9waXRc3bUHJ1YISCrLcRKDIvEfnpVHBF24HWOt5i3oYUWoKti/CWj/HPrawU
 XxwJP3f//Zg3nz2reAqnm/bHDU/ZWpihJRK287INm5kW3wwPASi9KYVCbE4tGw3m+jhegQz
 /TZprbMtCCjw0psDiW7PH6GpKrBLlxet0mo7U0yKd+yWxumP90h4rhbZhvU8M+d7kujtBx3
 Re/KqYYXnU4rpW+9EdGWWpIWJ6p6HFRRDVwLbQjvZSdpVwEveZc0R3cnBaaA==
Received: from [10.132.241.142] (helo=opensuse-desktop.haghiri.lan)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.99.4) (envelope-from <nick@haghiri.net>)
 id 1wcldC-FnQW0hPksvN-Ir6Z; Thu, 25 Jun 2026 15:04:42 +0000
From: Nick Haghiri <nick@haghiri.net>
To: amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Nick Haghiri <nick@haghiri.net>
Subject: [RFC PATCH] drm/amd/display: extend HPD debounce filter to
 DisplayPort SST
Date: Thu, 25 Jun 2026 11:04:39 -0400
Message-ID: <20260625150439.330875-1-nick@haghiri.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 670074m:670074aX29xAY:670074skgR_GI0uG
X-smtpcorp-track: VSWjz9o1K-Ut.Kk-_KJI4hp4E.Gw9WMgBisT7
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

Commit c97da4785b3b ("drm/amd/display: Add an HPD filter for HDMI") and
commit 6a681cd90345 ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms
module") added a filter that, on an HDMI disconnect, waits
hdmi_hpd_debounce_delay_ms and suppresses the hotplug if the sink comes
back with an unchanged EDID, instead of churning userspace.

DisplayPort SST sinks show the same pattern: some monitors briefly drop
and re-assert HPD when they enter deep sleep after DPMS-off. On the DP
path that toggle is forwarded as a real hotplug, so the compositor
re-probes and re-enables the output and the panel can never stay powered
off while connected.

Extend the existing filter to DisplayPort SST behind a new
dp_hpd_debounce_delay_ms module parameter (default 0/off, mirroring the
HDMI knob). eDP and MST are excluded; are_sinks_equal() and the debounce
work are reused unchanged.

Signed-off-by: Nick Haghiri <nick@haghiri.net>
---

RFC notes / open questions (below the --- so they stay out of the commit):

- Near-mechanical port of the HDMI filter to DisplayPort SST. I run it
  daily on an RX 9070 XT (RDNA4) driving an MSI MPG 274U over DP, which
  briefly drops and re-asserts HPD on DPMS-off and otherwise keeps the
  panel from staying asleep; dp_hpd_debounce_delay_ms=1500 fixes it.
- The DP path reuses the existing debounce work and ->hdmi_prev_sink, so
  those names are now a little misleading. Happy to rename them to a
  generic hpd_* if you'd prefer.
- I added a separate dp_hpd_debounce_delay_ms knob to mirror the HDMI
  one; folding both into a single hpd_debounce_delay_ms applied by signal
  type would work too. Let me know which you'd rather have.
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 12 +++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 +++++
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 20 ++++++++-------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 25 ++++++++++++-------
 5 files changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e2d4be3c1..c085a6cc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -271,6 +271,7 @@ extern int amdgpu_user_queue;
 extern int amdgpu_ptl;
 
 extern uint amdgpu_hdmi_hpd_debounce_delay_ms;
+extern uint amdgpu_dp_hpd_debounce_delay_ms;
 
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 65f2de86f..78df53b8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -246,6 +246,7 @@ int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
 uint amdgpu_hdmi_hpd_debounce_delay_ms;
+uint amdgpu_dp_hpd_debounce_delay_ms;
 int amdgpu_ptl = -1; /* auto */
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
@@ -1113,6 +1114,17 @@ module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 MODULE_PARM_DESC(hdmi_hpd_debounce_delay_ms, "HDMI HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
 module_param_named(hdmi_hpd_debounce_delay_ms, amdgpu_hdmi_hpd_debounce_delay_ms, uint, 0644);
 
+/*
+ * DOC: dp_hpd_debounce_delay_ms (uint)
+ * DisplayPort SST HPD disconnect debounce delay in milliseconds.
+ *
+ * Used to filter short disconnect->reconnect HPD toggles some DisplayPort SST
+ * sinks generate while entering/leaving power save. Set to 0 to disable by
+ * default. eDP and MST are not affected.
+ */
+MODULE_PARM_DESC(dp_hpd_debounce_delay_ms, "DisplayPort SST HPD disconnect debounce delay in milliseconds (0 to disable (by default), 1500 is common)");
+module_param_named(dp_hpd_debounce_delay_ms, amdgpu_dp_hpd_debounce_delay_ms, uint, 0644);
+
 /**
  * DOC: ptl (int)
  * Enable PTL feature at boot time. Possible values:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2f4a56741..abc17f547 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -64,6 +64,11 @@ enum amd_vsdb_panel_type {
  * Maximum HDMI HPD debounce delay in milliseconds
  */
 #define AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS 5000
+
+/*
+ * Maximum DisplayPort SST HPD debounce delay in milliseconds
+ */
+#define AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS 5000
 /*
 #include "include/amdgpu_dal_power_if.h"
 #include "amdgpu_dm_irq.h"
@@ -875,6 +880,7 @@ struct amdgpu_dm_connector {
 
 	/* HDMI HPD debounce support */
 	unsigned int hdmi_hpd_debounce_delay_ms;
+	unsigned int dp_hpd_debounce_delay_ms;
 	struct delayed_work hdmi_hpd_debounce_work;
 	struct dc_sink *hdmi_prev_sink;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 6143cdcf2..c79a8ada8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1747,8 +1747,8 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	if (aconnector->mst_mgr.dev)
 		drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
 
-	/* Cancel and flush any pending HDMI HPD debounce work */
-	if (aconnector->hdmi_hpd_debounce_delay_ms) {
+	/* Cancel and flush any pending HPD debounce work */
+	if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
 		cancel_delayed_work_sync(&aconnector->hdmi_hpd_debounce_work);
 		if (aconnector->hdmi_prev_sink) {
 			dc_sink_release(aconnector->hdmi_prev_sink);
@@ -2829,16 +2829,18 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	mutex_init(&aconnector->handle_mst_msg_ready);
 
 	/*
-	 * If HDMI HPD debounce delay is set, use the minimum between selected
-	 * value and AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS
+	 * If an HPD debounce delay is set, clamp each signal's delay to its
+	 * maximum. The debounce work and cached sink are shared by both the
+	 * HDMI and DisplayPort SST paths.
 	 */
-	if (amdgpu_hdmi_hpd_debounce_delay_ms) {
-		aconnector->hdmi_hpd_debounce_delay_ms = min(amdgpu_hdmi_hpd_debounce_delay_ms,
-							     AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS);
+	aconnector->hdmi_hpd_debounce_delay_ms = amdgpu_hdmi_hpd_debounce_delay_ms ?
+		min(amdgpu_hdmi_hpd_debounce_delay_ms, AMDGPU_DM_MAX_HDMI_HPD_DEBOUNCE_MS) : 0;
+	aconnector->dp_hpd_debounce_delay_ms = amdgpu_dp_hpd_debounce_delay_ms ?
+		min(amdgpu_dp_hpd_debounce_delay_ms, AMDGPU_DM_MAX_DP_HPD_DEBOUNCE_MS) : 0;
+
+	if (aconnector->hdmi_hpd_debounce_delay_ms || aconnector->dp_hpd_debounce_delay_ms) {
 		INIT_DELAYED_WORK(&aconnector->hdmi_hpd_debounce_work, amdgpu_dm_hdmi_hpd_debounce_work);
 		aconnector->hdmi_prev_sink = NULL;
-	} else {
-		aconnector->hdmi_hpd_debounce_delay_ms = 0;
 	}
 
 	dm->hdmi_frl_status_polling_delay_ms = 200;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 85711a2f2..2a732d19b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1302,6 +1302,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 	struct dc *dc = aconnector->dc_link->ctx->dc;
 	bool ret = false;
 	bool debounce_required = false;
+	unsigned int debounce_delay_ms = 0;
 
 	if (adev->dm.disable_hpd_irq)
 		return;
@@ -1325,10 +1326,16 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 		drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
 	/*
-	 * Check for HDMI disconnect with debounce enabled.
+	 * Check for an HDMI or DisplayPort SST disconnect with debounce
+	 * enabled. eDP and MST are intentionally excluded.
 	 */
-	debounce_required = (aconnector->hdmi_hpd_debounce_delay_ms > 0 &&
-			      dc_is_hdmi_signal(aconnector->dc_link->connector_signal) &&
+	if (dc_is_hdmi_signal(aconnector->dc_link->connector_signal))
+		debounce_delay_ms = aconnector->hdmi_hpd_debounce_delay_ms;
+	else if (aconnector->dc_link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
+		 aconnector->dc_link->type != dc_connection_mst_branch)
+		debounce_delay_ms = aconnector->dp_hpd_debounce_delay_ms;
+
+	debounce_required = (debounce_delay_ms > 0 &&
 			      new_connection_type == dc_connection_none &&
 			      aconnector->dc_link->local_sink != NULL);
 
@@ -1344,12 +1351,12 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else if (debounce_required) {
 		/*
-		 * HDMI disconnect detected - schedule delayed work instead of
+		 * Disconnect detected - schedule delayed work instead of
 		 * processing immediately. This allows us to coalesce spurious
-		 * HDMI signals from physical unplugs.
+		 * HDMI/DP HPD signals from physical unplugs.
 		 */
-		drm_dbg_kms(dev, "HDMI HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
-			    aconnector->hdmi_hpd_debounce_delay_ms);
+		drm_dbg_kms(dev, "HPD: Disconnect detected, scheduling debounce work (%u ms)\n",
+			    debounce_delay_ms);
 
 		/* Cache the current sink for later comparison */
 		if (aconnector->hdmi_prev_sink)
@@ -1361,8 +1368,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
 		/* Schedule delayed detection. */
 		if (mod_delayed_work(system_percpu_wq,
 				 &aconnector->hdmi_hpd_debounce_work,
-				 msecs_to_jiffies(aconnector->hdmi_hpd_debounce_delay_ms)))
-			drm_dbg_kms(dev, "HDMI HPD: Re-scheduled debounce work\n");
+				 msecs_to_jiffies(debounce_delay_ms)))
+			drm_dbg_kms(dev, "HPD: Re-scheduled debounce work\n");
 
 	} else {
 
-- 
2.54.0

