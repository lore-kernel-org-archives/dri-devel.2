Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8B4CA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B4D10F395;
	Wed, 30 Sep 2026 12:44:12 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E2E510EA14
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 12:44:09 +0000 (UTC)
X-QQ-mid: zesmtpip3t1790772171t3f14f698
X-QQ-Originating-IP: kJrvdrvSrDyx+pNNfkFw4vp+d6T7Q/uT5yBR5r5hmcM=
Received: from [192.168.30.32] ( [localhost]) by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 30 Sep 2026 20:42:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3594575140432455932
EX-QQ-RecipientCnt: 16
From: Xilin Wu <sophon@radxa.com>
Date: Wed, 30 Sep 2026 20:41:56 +0800
Subject: [PATCH 12/13] drm/msm/dp: Serialize video test state changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-msm-dp-hdr10-v1-12-dbbf8b2b42bc@radxa.com>
References: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
In-Reply-To: <20260930-msm-dp-hdr10-v1-0-dbbf8b2b42bc@radxa.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9106; i=sophon@radxa.com;
 h=from:subject:message-id; bh=e4hz6d7zJa4YX8tzhNQaTqN1PBFr7mjK8xvaDaSt5y0=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDFl7mZf/1X5fda5w6oa0Kx/PKkdXLGGNz3FYE1eR/NXf2
 eSLbbxpRykLgxgXg6yYIotCPMNc9srca0/FSvVg5rAygQxh4OIUgInszGBkWFJ/auXNd6YJfXJL
 ozI7PbMfpddWFcryuTfP7Vo5n/XcNkaGZymKJwocBeac2Rmatb7ip1iA5cWYF+cvHFt/RKlf6fV
 tFgA=
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: N10XyoOyIIl0JQrSJYj/99868rrI6Z/tKJwYHInyceOvVTmAaTFWLARf
 YVncRZaHbMWrM9cqt5iIelkVG3Y1BBp+KSMhDesK96T19vSf62BkdrZDizmGv6nLZn1lXdn
 yVKS+PGWffXF92n8bo8TYccvd7JmlvtI+UUhFL1SUc2rhFc9LuAIHNK57R4qnas6itKCv4/
 EFf5+iQS5L7A9OqBa1N7zGhpdU3YWwM89toFTUgnhnjSS2+CZOqgHuSMSA4n2Ojs6Y6/yAT
 QgpV6CmCB3w7yEXRa5rDmv5BDrUEhvhJDl/YxFg7hWahInK19MMQog08v0KnLgjjdr1njSV
 7FTD1b4ntPJBxBqz1s1oiQhwYUvQgxLau0eUvj1IokCUM0gNoVB5dJbCUCrWe1hLOaTvcRl
 Af5SzbWYW/x/0xWlpnZ/FsZabwgQQYcMmkPbKww1V/Y9qf9OXzmmBHNfqbQrGpeoCKL88+7
 wQKIIIIwFOzdVLmXlSELO5Xwz+js2bM9PZG17K9ozF5YiZvsxgjQqNPjZrOoSAWny331CpP
 D6n/1OiXD1qovQaoaSjCr7hjxyfnl4MU4jk0jFeZTZ5UaBYfj6Qp3OXdYLsymF5OVJ2GHQF
 wpO0jRSNS4jI1PKhWYGECus9o9AUnoNEAl7+wgrN9gKSGazmqwxkPE0Mw6sOmQfxQFnnNHb
 RLFcCrrjTugWYtbE9IaarK3TrDp5aW8eM9pSiOwaaFHSIMLpZ79Ihs8j81+mvcxEcarZM6o
 4RpnIo9HZOL9T6vT65iX9PRnnGEU1nuef0vu2Fn07fcxsndhMOoAgR3ymnavO6SEACfEk3+
 papT4IL+b3LBnXKKwlNs1HVuZWqHqZZR9F9j+m7zLrGZ2kRiL6Tp7g66oVYB1tfjm2ks+5H
 gqaBbWNlg7hw93Ttg9YOlTuUVQV0sz4LdSGl/QWq2a401bRBaNFrnhOJ3LCkb8S6gfDSPXB
 4FwhuGXwf/FNNyJ8gl+UeZNbJ7sGKeyTXtTlorNpBzk6N0xpa/hQvQqdUvhONIbfn8vVuf4
 FAvP/WKZa9sRtfpebcI13DMCnn0tSp8KjU0Vmmi/O8vcXOI37Mk91LH1cY8HNF144BQPDv7
 Q==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
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

The debugfs test control writes video_test directly, racing HPD handling
and mode programming. Reading the test flag and its requested depth in
separate calls also allows those values to change between the reads.

Route test state access through the display and use plugged_lock for both
HPD and debugfs updates. Hold the same lock while selecting the test depth
and installing the mode. Pass the display instance to debugfs for access
to its connector and the serialized test controls.

Preserve the existing SDR test behavior. The shared setter provides the
entry point for rejecting incompatible tests when HDR is added.

Assisted-by: LLM
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 drivers/gpu/drm/msm/dp/dp_debug.c   | 27 ++++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_debug.h   |  8 +++++---
 drivers/gpu/drm/msm/dp/dp_display.c | 34 ++++++++++++++++++++++------------
 drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
 4 files changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
index 00fb1a7ba40e..c26b356f998a 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.c
+++ b/drivers/gpu/drm/msm/dp/dp_debug.c
@@ -21,7 +21,7 @@
 struct msm_dp_debug_private {
 	struct msm_dp_link *link;
 	struct msm_dp_panel *panel;
-	struct drm_connector *connector;
+	struct msm_dp *dp;
 };
 
 static int msm_dp_debug_show(struct seq_file *seq, void *p)
@@ -89,7 +89,7 @@ DEFINE_SHOW_ATTRIBUTE(msm_dp_debug);
 static int msm_dp_test_data_show(struct seq_file *m, void *data)
 {
 	const struct msm_dp_debug_private *debug = m->private;
-	const struct drm_connector *connector = debug->connector;
+	const struct drm_connector *connector = debug->dp->connector;
 	u32 bpc;
 
 	if (connector->status == connector_status_connected) {
@@ -111,7 +111,7 @@ DEFINE_SHOW_ATTRIBUTE(msm_dp_test_data);
 static int msm_dp_test_type_show(struct seq_file *m, void *data)
 {
 	const struct msm_dp_debug_private *debug = m->private;
-	const struct drm_connector *connector = debug->connector;
+	const struct drm_connector *connector = debug->dp->connector;
 
 	if (connector->status == connector_status_connected)
 		seq_printf(m, "%02x", DP_TEST_LINK_VIDEO_PATTERN);
@@ -133,7 +133,7 @@ static ssize_t msm_dp_test_active_write(struct file *file,
 	int val = 0;
 
 	debug = ((struct seq_file *)file->private_data)->private;
-	connector = debug->connector;
+	connector = debug->dp->connector;
 
 	if (len == 0)
 		return 0;
@@ -154,10 +154,11 @@ static ssize_t msm_dp_test_active_write(struct file *file,
 		/* To prevent erroneous activation of the compliance
 		 * testing code, only accept an actual value of 1 here
 		 */
-		if (val == 1)
-			debug->panel->video_test = true;
-		else
-			debug->panel->video_test = false;
+		status = msm_dp_display_set_video_test(debug->dp, val == 1);
+		if (status) {
+			kfree(input_buffer);
+			return status;
+		}
 	}
 	kfree(input_buffer);
 
@@ -168,10 +169,10 @@ static ssize_t msm_dp_test_active_write(struct file *file,
 static int msm_dp_test_active_show(struct seq_file *m, void *data)
 {
 	struct msm_dp_debug_private *debug = m->private;
-	struct drm_connector *connector = debug->connector;
+	struct drm_connector *connector = debug->dp->connector;
 
 	if (connector->status == connector_status_connected) {
-		if (debug->panel->video_test)
+		if (msm_dp_display_check_video_test(debug->dp))
 			seq_puts(m, "1");
 		else
 			seq_puts(m, "0");
@@ -200,12 +201,12 @@ static const struct file_operations test_active_fops = {
 
 int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 		  struct msm_dp_link *link,
-		  struct drm_connector *connector,
+		  struct msm_dp *dp,
 		  struct dentry *root, bool is_edp)
 {
 	struct msm_dp_debug_private *debug;
 
-	if (!dev || !panel || !link) {
+	if (!dev || !panel || !link || !dp || !dp->connector) {
 		DRM_ERROR("invalid input\n");
 		return -EINVAL;
 	}
@@ -216,7 +217,7 @@ int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 
 	debug->link = link;
 	debug->panel = panel;
-	debug->connector = connector;
+	debug->dp = dp;
 
 	debugfs_create_file("dp_debug", 0444, root,
 			debug, &msm_dp_debug_fops);
diff --git a/drivers/gpu/drm/msm/dp/dp_debug.h b/drivers/gpu/drm/msm/dp/dp_debug.h
index a90083fec856..430891e110fb 100644
--- a/drivers/gpu/drm/msm/dp/dp_debug.h
+++ b/drivers/gpu/drm/msm/dp/dp_debug.h
@@ -9,6 +9,8 @@
 #include "dp_panel.h"
 #include "dp_link.h"
 
+struct msm_dp;
+
 #if defined(CONFIG_DEBUG_FS)
 
 /**
@@ -17,7 +19,7 @@
  * @dev: device instance of the caller
  * @panel: instance of panel module
  * @link: instance of link module
- * @connector: double pointer to display connector
+ * @dp: display instance owning the connector and video test state
  * @root: connector's debugfs root
  * @is_edp: set for eDP connectors / panels
  * return: pointer to allocated debug module data
@@ -27,7 +29,7 @@
  */
 int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 		  struct msm_dp_link *link,
-		  struct drm_connector *connector,
+		  struct msm_dp *dp,
 		  struct dentry *root,
 		  bool is_edp);
 
@@ -36,7 +38,7 @@ int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 static inline
 int msm_dp_debug_init(struct device *dev, struct msm_dp_panel *panel,
 		  struct msm_dp_link *link,
-		  struct drm_connector *connector,
+		  struct msm_dp *dp,
 		  struct dentry *root,
 		  bool is_edp)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 65ac35e41ed8..ec65800f629a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -426,10 +426,20 @@ static void msm_dp_display_host_deinit(struct msm_dp_display_private *dp)
 	dp->core_initialized = false;
 }
 
+static int msm_dp_display_set_video_test_locked(struct msm_dp_display_private *dp,
+						bool enable)
+{
+	lockdep_assert_held(&dp->plugged_lock);
+
+	dp->panel->video_test = enable;
+	return 0;
+}
+
 static void msm_dp_display_handle_video_request(struct msm_dp_display_private *dp)
 {
 	if (dp->link->sink_request & DP_TEST_LINK_VIDEO_PATTERN) {
-		dp->panel->video_test = true;
+		if (msm_dp_display_set_video_test_locked(dp, true))
+			dp->link->test_response = DP_TEST_NAK;
 		msm_dp_link_send_test_response(dp->link);
 	}
 }
@@ -671,8 +681,10 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	if (msm_dp_display_check_video_test(msm_dp_display))
-		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
+	guard(mutex)(&dp->plugged_lock);
+
+	if (dp->panel->video_test)
+		bpp = msm_dp_link_bit_depth_to_bpp(dp->link->test_video.test_bit_depth);
 	else
 		bpp = state->bpp;
 
@@ -940,22 +952,20 @@ bool msm_dp_display_check_video_test(struct msm_dp *dp)
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	guard(mutex)(&msm_dp_display->plugged_lock);
+
 	return msm_dp_display->panel->video_test;
 }
 
-int msm_dp_display_get_test_bpp(struct msm_dp *dp)
+int msm_dp_display_set_video_test(struct msm_dp *dp, bool enable)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
-	if (!dp) {
-		DRM_ERROR("invalid params\n");
-		return 0;
-	}
-
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	return msm_dp_link_bit_depth_to_bpp(
-		msm_dp_display->link->test_video.test_bit_depth);
+	guard(mutex)(&msm_dp_display->plugged_lock);
+
+	return msm_dp_display_set_video_test_locked(msm_dp_display, enable);
 }
 
 void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
@@ -1505,7 +1515,7 @@ void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *r
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 	dev = &dp->msm_dp_display.pdev->dev;
 
-	rc = msm_dp_debug_init(dev, dp->panel, dp->link, dp->msm_dp_display.connector, root, is_edp);
+	rc = msm_dp_debug_init(dev, dp->panel, dp->link, msm_dp_display, root, is_edp);
 	if (rc)
 		DRM_ERROR("failed to initialize debug, rc = %d\n", rc);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 6a77e5952530..ac64c1d3227a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -30,7 +30,7 @@ struct msm_dp {
 
 int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
 bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
-int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
+int msm_dp_display_set_video_test(struct msm_dp *dp, bool enable);
 void msm_dp_display_signal_audio_start(struct msm_dp *msm_dp_display);
 void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display);
 void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);

-- 
2.55.0

