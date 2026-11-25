Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C874606A333
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC16410F995;
	Wed, 25 Nov 2026 02:19:30 +0000 (UTC)
X-Greylist: delayed 549 seconds by postgrey-1.36 at gabe;
 Wed, 25 Nov 2026 02:19:29 UTC
Received: from yocto-server-2.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1136D10F994
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:19:29 +0000 (UTC)
Received: by yocto-server-2.amd.com (Postfix, from userid 1009)
 id 67A87A0D50; Wed, 25 Nov 2026 02:10:17 +0000 (UTC)
From: Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <roman.li@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>,
 Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
Subject: [PATCH v2 1/2] drm/amd/display: skip hotplug uevent when sink is
 unchanged
Date: Wed, 25 Nov 2026 02:10:16 +0000
Message-ID: <20261125021017.603857-2-Jyotiranjan.Bhuyan@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125021017.603857-1-Jyotiranjan.Bhuyan@amd.com>
References: <20261022094835.591175-1-jyotiranjan.bhuyan@amd.com>
 <20261125021017.603857-1-Jyotiranjan.Bhuyan@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

dm_resume() sent a DRM hotplug after every resume, even when the panel
did not change.

Compare dc_link type and local_sink before and after detection. Any
changed root connector sends one hotplug event. No change sends
nothing. Both NULL sinks compare equal, so a disconnected link or an
MST root that stays an MST branch is unchanged. Port changes stay with
drm_dp_mst_topology_queue_probe(). Log that both-NULL case with
drm_dbg_kms.

Signed-off-by: Jyotiranjan Bhuyan <Jyotiranjan.Bhuyan@amd.com>
---
v1: https://lists.freedesktop.org/archives/amd-gfx/2026-October/155562.html

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 63 ++++++++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  5 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |  2 +-
 3 files changed, 64 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5d1b010bec9b..156cf7309fb0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1892,6 +1892,43 @@ STATIC_IFN_KUNIT void amdgpu_dm_dump_links_and_sinks(struct amdgpu_device *adev)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_dump_links_and_sinks);
 
+/*
+ * Compare link type and local_sink from before dc_link_detect() with the
+ * values after detection.
+ *
+ * A type change is a plug or unplug. When the type is unchanged,
+ * are_sinks_equal() compares the sinks. Both NULL is unchanged: a
+ * disconnected link, or an MST root after discover_dp_mst_topology()
+ * calls link_disconnect_sink(). Downstream MST port changes are
+ * reported by drm_dp_mst_topology_queue_probe().
+ */
+static bool dm_resume_connector_changed(struct drm_connector *connector,
+					struct dc_link *link,
+					enum dc_connection_type old_type,
+					struct dc_sink *old_sink)
+{
+	enum dc_connection_type new_type = link->type;
+	struct dc_sink *new_sink = link->local_sink;
+	bool changed = false;
+
+	if (old_type != new_type)
+		changed = true;
+	else
+		changed = !are_sinks_equal(old_sink, new_sink);
+
+	if (!old_sink && !new_sink)
+		drm_dbg_kms(connector->dev,
+			    "resume: %s both sinks NULL, type %d -> %d\n",
+			    connector->name, old_type, new_type);
+
+	drm_dbg_kms(connector->dev,
+		    "resume: %s type %d -> %d, sink %p -> %p, changed=%d\n",
+		    connector->name, old_type, new_type,
+		    old_sink, new_sink, changed);
+
+	return changed;
+}
+
 static int dm_resume(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -1904,6 +1941,7 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	struct dc_state *dc_state;
 	int i, r, j;
+	unsigned int connector_changes = 0;
 	struct dc_commit_streams_params commit_params = {};
 
 	if (dm->dc->caps.ips_support) {
@@ -2032,6 +2070,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
 		bool ret;
+		enum dc_connection_type old_type;
+		struct dc_sink *old_sink;
 
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
@@ -2042,8 +2082,8 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			continue;
 
 		/*
-		 * this is the case when traversing through already created end sink
-		 * MST connectors, should be skipped
+		 * Leaf connectors set mst_root to the root connector.
+		 * The root connector itself has mst_root == NULL.
 		 */
 		if (aconnector->mst_root)
 			continue;
@@ -2054,6 +2094,12 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 			continue;
 
 		guard(mutex)(&aconnector->hpd_lock);
+
+		old_type = aconnector->dc_link->type;
+		old_sink = aconnector->dc_link->local_sink;
+		if (old_sink)
+			dc_sink_retain(old_sink);
+
 		if (!dc_link_detect_connection_type(aconnector->dc_link, &new_connection_type))
 			drm_err(adev_to_drm(adev), "KMS: Failed to detect connector\n");
 
@@ -2072,6 +2118,13 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		if (aconnector->fake_enable && aconnector->dc_link->local_sink)
 			aconnector->fake_enable = false;
 
+		if (dm_resume_connector_changed(connector, aconnector->dc_link,
+						old_type, old_sink))
+			connector_changes++;
+
+		if (old_sink)
+			dc_sink_release(old_sink);
+
 		if (aconnector->dc_sink)
 			dc_sink_release(aconnector->dc_sink);
 		aconnector->dc_sink = NULL;
@@ -2115,7 +2168,11 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 
 	amdgpu_dm_smu_write_watermarks_table(adev);
 
-	drm_kms_helper_hotplug_event(ddev);
+	if (connector_changes) {
+		drm_dbg_kms(ddev, "resume: hotplug, changes %u\n",
+			    connector_changes);
+		drm_kms_helper_hotplug_event(ddev);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 5b4ff079cd55..37f33e41d9dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -1271,10 +1271,11 @@ void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_hpd_rx_irq_work_suspend);
 
-STATIC_IFN_KUNIT bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
+bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2)
 {
+	/* Both NULL is the same disconnected state. One NULL is a change. */
 	if (!sink1 || !sink2)
-		return false;
+		return sink1 == sink2;
 	if (sink1->sink_signal != sink2->sink_signal)
 		return false;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 6ba567df5f0a..35dda9394e12 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -151,6 +151,7 @@ struct hpd_rx_irq_offload_work_queue *amdgpu_dm_hpd_rx_irq_create_workqueue(stru
 void amdgpu_dm_hpd_rx_irq_work_suspend(struct amdgpu_display_manager *dm);
 int amdgpu_dm_register_hpd_handlers(struct amdgpu_device *adev);
 void amdgpu_dm_hdmi_hpd_debounce_work(struct work_struct *work);
+bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2);
 
 /* IRQ handlers */
 struct amdgpu_crtc *amdgpu_dm_get_crtc_by_otg_inst(struct amdgpu_device *adev,
@@ -165,7 +166,6 @@ struct amdgpu_iv_entry;
 enum amdgpu_interrupt_state;
 
 enum dc_irq_source amdgpu_dm_hpd_to_dal_irq_source(unsigned int type);
-bool are_sinks_equal(const struct dc_sink *sink1, const struct dc_sink *sink2);
 const char *dmub_notification_type_str(enum dmub_notification_type e);
 int amdgpu_dm_set_hpd_irq_state(struct amdgpu_device *adev,
 				struct amdgpu_irq_src *source,
-- 
2.43.0

