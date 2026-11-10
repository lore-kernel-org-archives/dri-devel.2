Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4560A2614
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HsDGBfLO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8F410EDFC;
	Tue, 10 Nov 2026 06:17:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DEEB10EDF7;
 Tue, 10 Nov 2026 06:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794291429; x=1825827429;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=i9E4O9TKE7dKx4MSkota8L4HZTnkoZPc43Bd40PlJkE=;
 b=HsDGBfLO8moPz8XD8Shm8G+WcJvNaAM4hqDBn7+ERAYpHkv23N4iicaG
 bbjVaFQlXYo5zsd97khIKOjChEWn+K5Y6Ag2PQfx/L7XyD4HIWpv64gg9
 ISx1AtBDK54J5NxXgb9V5XvFdvw+piqpr90MvVxXdWdM+ec7Bs4VLjdzR
 iyJB6GUoUDOE3IFWiHQnMR8Si62drK1hj8/mJb43RwfA05/8GrP3vQnjV
 dXlOE2zcWPMCiy1QXCpGPhNNNfYaMLDo3AXD43qUQb2wdly9uOjIxRp43
 0mQm3b7uOVS0Kdz0zlajg92tP76mTunPnyi2OeLwNd1crNdjKVY3uMr13 A==;
X-CSE-ConnectionGUID: rFQYqDPpTUOnyS2Y1EXdyg==
X-CSE-MsgGUID: Es4aRoqSTvmpRY52dOP8pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3020935"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3020935"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 22:17:09 -0800
X-CSE-ConnectionGUID: Uy6yENXrS2CIodehctaDyA==
X-CSE-MsgGUID: Nc0qYijfRVeBa83NZF11kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7930979"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by orviesa004.jf.intel.com with ESMTP; 09 Nov 2026 22:17:02 -0800
From: Suraj Kandpal <suraj.kandpal@intel.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, John.Harrison@Igalia.com,
 kernel-dev@igalia.com, alex.hung@amd.com, liviu.dudau@arm.com,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, laurent.pinchart+renesas@ideasonboard.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 mcanal@igalia.com, kernel-list@raspberrypi.com, uma.shankar@intel.com,
 arun.r.murthy@intel.com, Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH v7 2/8] drm: writeback: Refactor drm_writeback_connector
 structure
Date: Tue, 10 Nov 2026 11:46:31 +0530
Message-Id: <20261110061637.2500929-3-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110061637.2500929-1-suraj.kandpal@intel.com>
References: <20261110061637.2500929-1-suraj.kandpal@intel.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some drivers cannot work with the current design where the connector
is embedded within the drm_writeback_connector such as Intel and
some drivers that can get it working end up adding a lot of checks
all around the code to check if it's a writeback conenctor or not,
this is due to the limitation of inheritance in C.
To solve this move the drm_writeback_connector within the
drm_connector and remove the drm_connector base which was in
drm_writeback_connector. Make this drm_writeback_connector
a union with hdmi connector to save memory and since a connector can
never be both writeback and hdmi it should serve us well.
Do all other required modifications that come with these changes
along with addition of new function which returns the drm_connector
when drm_writeback_connector is present.
Modify drivers using the drm_writeback_connector to
allow them to use this connector without breaking them.
The drivers modified here are amd, komeda, mali, vc4, vkms,
rcar_du, msm

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: John Harrison <John.Harrison@Igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
v6 -> v7:
- Rebase over latest kernel
- Rebase over latest writeback series by Dmitry

v5 -> v6:
- Rebase on latest kernel

v4 -> v5:
- Remove more unnecessary wrapping of drm_writeback_to_connector() (John)

v3 -> v4:
- Use drm_writeback_to_connector() wherever possible (John)
- Do not wrap line where not needed (John)

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  6 +-
 .../tests/amdgpu_dm_connector_test.c          |  6 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  2 +-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  6 +-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  6 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  6 +-
 .../arm/display/komeda/komeda_wb_connector.c  | 10 +--
 drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
 drivers/gpu/drm/arm/malidp_drv.h              |  2 +-
 drivers/gpu/drm/arm/malidp_hw.c               |  6 +-
 drivers/gpu/drm/arm/malidp_mw.c               |  8 +--
 drivers/gpu/drm/drm_atomic_uapi.c             |  2 +-
 drivers/gpu/drm/drm_writeback.c               | 30 ++++----
 .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 14 ++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h |  4 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  6 +-
 .../drm/renesas/rcar-du/rcar_du_writeback.c   | 17 ++---
 drivers/gpu/drm/vc4/vc4_txp.c                 | 14 ++--
 drivers/gpu/drm/vkms/vkms_composer.c          |  2 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |  2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c         | 13 ++--
 include/drm/drm_connector.h                   | 69 +++++++++++++++++--
 include/drm/drm_writeback.h                   | 66 +-----------------
 27 files changed, 160 insertions(+), 152 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 12bc10f852e2..2fca88a4ac7d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4816,7 +4816,7 @@ dm_set_writeback(struct amdgpu_display_manager *dm,
 		 struct drm_connector *connector,
 		 struct drm_connector_state *new_con_state)
 {
-	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
+	struct drm_writeback_connector *wb_conn = &connector->writeback;
 	struct amdgpu_device *adev = dm->adev;
 	struct amdgpu_crtc *acrtc;
 	struct dc_writeback_info *wb_info;
@@ -4830,7 +4830,7 @@ dm_set_writeback(struct amdgpu_display_manager *dm,
 		goto cleanup;
 	}
 
-	acrtc = to_amdgpu_crtc(to_amdgpu_dm_wb_connector(wb_conn)->encoder.crtc);
+	acrtc = to_amdgpu_crtc(to_amdgpu_dm_wb_connector(connector)->encoder.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		goto cleanup;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index aa838a9367d8..a80cb086f64f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -945,7 +945,7 @@ static inline void amdgpu_dm_set_mst_status(uint8_t *status,
 #define to_amdgpu_dm_connector(x) container_of(x, struct amdgpu_dm_connector, base)
 
 struct amdgpu_dm_wb_connector {
-	struct drm_writeback_connector base;
+	struct drm_connector base;
 	struct drm_encoder encoder;
 	struct dc_link *link;
 };
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index e8c57660b69b..9ba1acabf2dc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1512,11 +1512,9 @@ create_stream_for_sink(struct drm_connector *connector,
 		aconnector = to_amdgpu_dm_connector(connector);
 		link = aconnector->dc_link;
 	} else {
-		struct drm_writeback_connector *wbcon = NULL;
 		struct amdgpu_dm_wb_connector *dm_wbcon = NULL;
 
-		wbcon = drm_connector_to_writeback(connector);
-		dm_wbcon = to_amdgpu_dm_wb_connector(wbcon);
+		dm_wbcon = to_amdgpu_dm_wb_connector(connector);
 		link = dm_wbcon->link;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index dde02b2b018b..4cd8fdf6ef07 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -260,9 +260,9 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	if (res)
 		return res;
 
-	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
+	drm_connector_helper_add(&wbcon->base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base.writeback,
 					   &amdgpu_dm_wb_connector_funcs,
 					   &wbcon->encoder,
 					   amdgpu_dm_wb_formats,
@@ -275,7 +275,7 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	 * Some of the properties below require access to state, like bpc.
 	 * Allocate some default initial connector state with our reset helper.
 	 */
-	connector = &wbcon->base.base;
+	connector = &wbcon->base;
 	if (connector->funcs->atomic_create_state) {
 		struct drm_connector_state *conn_state;
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 02f2121718f4..cdea4ab52687 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -7146,7 +7146,7 @@ static void dm_test_create_validate_stream_writeback(struct kunit *test)
 	wbcon = drmm_kzalloc(drm, sizeof(*wbcon), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, wbcon);
 	KUNIT_ASSERT_EQ(test,
-			drmm_connector_init(drm, &wbcon->base.base,
+			drmm_connector_init(drm, &wbcon->base,
 			&dm_test_connector_funcs,
 			DRM_MODE_CONNECTOR_WRITEBACK, NULL), 0);
 
@@ -7160,7 +7160,7 @@ static void dm_test_create_validate_stream_writeback(struct kunit *test)
 
 	dm_state = kunit_kzalloc(test, sizeof(*dm_state), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, dm_state);
-	dm_state->base.connector = &wbcon->base.base;
+	dm_state->base.connector = &wbcon->base;
 	dm_state->scaling = RMX_OFF;
 
 	mode = kunit_kzalloc(test, sizeof(*mode), GFP_KERNEL);
@@ -7169,7 +7169,7 @@ static void dm_test_create_validate_stream_writeback(struct kunit *test)
 	mode->vdisplay = 1080;
 	mode->clock = 148500;
 
-	stream = amdgpu_dm_create_validate_stream_for_sink(&wbcon->base.base,
+	stream = amdgpu_dm_create_validate_stream_for_sink(&wbcon->base,
 							   mode, dm_state, NULL);
 	KUNIT_ASSERT_NOT_NULL(test, stream);
 	dc_stream_release(stream);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 61b72eba4c31..b3bbbf7a7284 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -4597,7 +4597,7 @@ static void dm_test_set_writeback_no_pipe(struct kunit *test)
 	conn_state->writeback_job = job;
 	crtc_state->stream = dm_kunit_alloc_stream(test, NULL);
 
-	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base.base, conn_state);
+	dm_set_writeback(&adev->dm, crtc_state, &wb_conn->base, conn_state);
 
 	KUNIT_EXPECT_NULL(test, acrtc->wb_conn);
 	KUNIT_EXPECT_FALSE(test, acrtc->wb_pending);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
index 8ba4299578ea..0628b250f47f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_wb_test.c
@@ -508,9 +508,9 @@ static void dm_test_wb_connector_init_success(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, ret, 0);
 	KUNIT_EXPECT_PTR_EQ(test, wbcon->link, link);
-	KUNIT_EXPECT_TRUE(test, wbcon->base.base.funcs != NULL);
-	KUNIT_EXPECT_TRUE(test, wbcon->base.base.helper_private != NULL);
-	KUNIT_EXPECT_TRUE(test, wbcon->base.base.state != NULL);
+	KUNIT_EXPECT_TRUE(test, wbcon->base.funcs != NULL);
+	KUNIT_EXPECT_TRUE(test, wbcon->base.helper_private != NULL);
+	KUNIT_EXPECT_TRUE(test, wbcon->base.state != NULL);
 	KUNIT_EXPECT_TRUE(test, wbcon->encoder.funcs != NULL);
 	KUNIT_EXPECT_EQ(test, wbcon->encoder.possible_crtcs, 0x1);
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index 0fd069fc3386..1908a4578f73 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -214,7 +214,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 		struct komeda_wb_connector *wb_conn = kcrtc->wb_conn;
 
 		if (wb_conn)
-			drm_writeback_signal_completion(&wb_conn->base, 0);
+			drm_writeback_signal_completion(&wb_conn->base.writeback, 0);
 		else
 			drm_warn(drm, "CRTC[%d]: EOW happen but no wb_connector.\n",
 				 drm_crtc_index(&kcrtc->base));
@@ -270,9 +270,9 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
 	if (slave && has_bit(slave->id, kcrtc_st->affected_pipes))
 		komeda_pipeline_update(slave, old->state);
 
-	conn_st = wb_conn ? wb_conn->base.base.state : NULL;
+	conn_st = wb_conn ? wb_conn->base.state : NULL;
 	if (conn_st && conn_st->writeback_job)
-		drm_writeback_queue_job(&wb_conn->base, conn_st);
+		drm_writeback_queue_job(&wb_conn->base.writeback, conn_st);
 
 	/* step 2: notify the HW to kickoff the update */
 	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
index 4d41681a834b..1cd6fdd1f22c 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
@@ -53,8 +53,8 @@ struct komeda_plane_state {
  * struct komeda_wb_connector
  */
 struct komeda_wb_connector {
-	/** @base: &drm_writeback_connector */
-	struct drm_writeback_connector base;
+	/** @base: &drm_connector */
+	struct drm_connector base;
 
 	/** @encoder: writeback encoder */
 	struct drm_encoder encoder;
@@ -142,7 +142,7 @@ struct komeda_kms_dev {
 static inline bool is_writeback_only(struct drm_crtc_state *st)
 {
 	struct komeda_wb_connector *wb_conn = to_kcrtc(st->crtc)->wb_conn;
-	struct drm_connector *conn = wb_conn ? &wb_conn->base.base : NULL;
+	struct drm_connector *conn = wb_conn ? &wb_conn->base : NULL;
 
 	return conn && (st->connector_mask == BIT(drm_connector_index(conn)));
 }
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
index ea4589b00ee0..07075a8b5aa8 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_wb_connector.c
@@ -52,7 +52,7 @@ komeda_wb_encoder_atomic_check(struct drm_encoder *encoder,
 		return -EINVAL;
 	}
 
-	wb_layer = to_kconn(to_wb_conn(conn_st->connector))->wb_layer;
+	wb_layer = to_kconn(conn_st->connector)->wb_layer;
 
 	/*
 	 * No need for a full modested when the only connector changed is the
@@ -124,7 +124,7 @@ komeda_wb_connector_fill_modes(struct drm_connector *connector,
 static void komeda_wb_connector_destroy(struct drm_connector *connector)
 {
 	drm_connector_cleanup(connector);
-	kfree(to_kconn(to_wb_conn(connector)));
+	kfree(to_kconn(connector));
 }
 
 static const struct drm_encoder_funcs komeda_wb_encoder_funcs = {
@@ -164,7 +164,7 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 
 	kwb_conn->wb_layer = kcrtc->master->wb_layer;
 
-	wb_conn = &kwb_conn->base;
+	wb_conn = &kwb_conn->base.writeback;
 
 	formats = komeda_get_layer_fourcc_list(&mdev->fmt_tbl,
 					       kwb_conn->wb_layer->layer_type,
@@ -223,9 +223,9 @@ static int komeda_wb_connector_add(struct komeda_kms_dev *kms,
 					    drm_encoder_mask(wb_encoder);
 	}
 
-	drm_connector_helper_add(&wb_conn->base, &komeda_wb_conn_helper_funcs);
+	drm_connector_helper_add(&kwb_conn->base, &komeda_wb_conn_helper_funcs);
 
-	info = &kwb_conn->base.base.display_info;
+	info = &kwb_conn->base.display_info;
 	info->bpc = __fls(kcrtc->master->improc->supported_color_depths);
 	info->color_formats = kcrtc->master->improc->supported_color_formats;
 
diff --git a/drivers/gpu/drm/arm/malidp_crtc.c b/drivers/gpu/drm/arm/malidp_crtc.c
index ec7b9db8b0b4..2710949020a9 100644
--- a/drivers/gpu/drm/arm/malidp_crtc.c
+++ b/drivers/gpu/drm/arm/malidp_crtc.c
@@ -422,7 +422,7 @@ static int malidp_crtc_atomic_check(struct drm_crtc *crtc,
 		u32 new_mask = crtc_state->connector_mask;
 
 		if ((old_mask ^ new_mask) ==
-		    (1 << drm_connector_index(&malidp->mw_connector.base)))
+		    (1 << drm_connector_index(&malidp->mw_connector)))
 			crtc_state->connectors_changed = false;
 	}
 
diff --git a/drivers/gpu/drm/arm/malidp_drv.h b/drivers/gpu/drm/arm/malidp_drv.h
index 64610f2d23e2..928d46f6c322 100644
--- a/drivers/gpu/drm/arm/malidp_drv.h
+++ b/drivers/gpu/drm/arm/malidp_drv.h
@@ -32,7 +32,7 @@ struct malidp_drm {
 	struct drm_device base;
 	struct malidp_hw_device *dev;
 	struct drm_crtc crtc;
-	struct drm_writeback_connector mw_connector;
+	struct drm_connector mw_connector;
 	struct drm_encoder mw_encoder;
 	wait_queue_head_t wq;
 	struct drm_pending_vblank_event *event;
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 9b845d3f34e1..5a7bd27d3718 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -1315,15 +1315,15 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
 	if (status & se->vsync_irq) {
 		switch (hwdev->mw_state) {
 		case MW_ONESHOT:
-			drm_writeback_signal_completion(&malidp->mw_connector, 0);
+			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
 			break;
 		case MW_STOP:
-			drm_writeback_signal_completion(&malidp->mw_connector, 0);
+			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
 			/* disable writeback after stop */
 			hwdev->mw_state = MW_NOT_ENABLED;
 			break;
 		case MW_RESTART:
-			drm_writeback_signal_completion(&malidp->mw_connector, 0);
+			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
 			fallthrough;	/* to a new start */
 		case MW_START:
 			/* writeback started, need to emulate one-shot mode */
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index 3669d10540bf..503a19963587 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -220,7 +220,7 @@ int malidp_mw_connector_init(struct drm_device *drm)
 	if (!malidp->dev->hw->enable_memwrite)
 		return 0;
 
-	drm_connector_helper_add(&malidp->mw_connector.base,
+	drm_connector_helper_add(&malidp->mw_connector,
 				 &malidp_mw_connector_helper_funcs);
 
 	formats = get_writeback_formats(malidp, &n_formats);
@@ -239,7 +239,7 @@ int malidp_mw_connector_init(struct drm_device *drm)
 		return ret;
 	}
 
-	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
+	ret = drm_writeback_connector_init(drm, &malidp->mw_connector.writeback,
 					   &malidp_mw_connector_funcs,
 					   &malidp->mw_encoder,
 					   formats, n_formats);
@@ -256,8 +256,8 @@ void malidp_mw_atomic_commit(struct drm_device *drm,
 			     struct drm_atomic_commit *old_state)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
-	struct drm_writeback_connector *mw_conn = &malidp->mw_connector;
-	struct drm_connector_state *conn_state = mw_conn->base.state;
+	struct drm_writeback_connector *mw_conn = &malidp->mw_connector.writeback;
+	struct drm_connector_state *conn_state = malidp->mw_connector.state;
 	struct malidp_hw_device *hwdev = malidp->dev;
 	struct malidp_mw_connector_state *mw_state;
 
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 1eebcf6f5e05..a3e8809b4508 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1520,7 +1520,7 @@ static int prepare_signaling(struct drm_device *dev,
 		f[*num_fences].out_fence_ptr = fence_ptr;
 		*fence_state = f;
 
-		wb_conn = drm_connector_to_writeback(conn);
+		wb_conn = &conn->writeback;
 		fence = drm_writeback_get_out_fence(wb_conn);
 		if (!fence)
 			return -ENOMEM;
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 0c5d2fbe7a7c..c3d2853755ac 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -96,8 +96,9 @@ static const char *drm_writeback_fence_get_driver_name(struct dma_fence *fence)
 {
 	struct drm_writeback_connector *wb_connector =
 		fence_to_wb_connector(fence);
+	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
 
-	return wb_connector->base.dev->driver->name;
+	return connector->dev->driver->name;
 }
 
 static const char *
@@ -177,7 +178,7 @@ static int __drm_writeback_connector_init(struct drm_device *dev,
 					  struct drm_encoder *enc, const u32 *formats,
 					  int n_formats)
 {
-	struct drm_connector *connector = &wb_connector->base;
+	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
 	struct drm_mode_config *config = &dev->mode_config;
 	struct drm_property_blob *blob;
 	int ret = create_writeback_properties(dev);
@@ -253,7 +254,7 @@ int drm_writeback_connector_init(struct drm_device *dev,
 				 struct drm_encoder *enc,
 				 const u32 *formats, int n_formats)
 {
-	struct drm_connector *connector = &wb_connector->base;
+	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
 	int ret;
 
 	ret = drm_connector_init(dev, connector, con_funcs,
@@ -283,7 +284,7 @@ EXPORT_SYMBOL(drm_writeback_connector_init);
 void drm_writeback_connector_cleanup(struct drm_connector *connector)
 {
 	struct drm_writeback_connector *wb_connector =
-		drm_connector_to_writeback(connector);
+		&connector->writeback;
 	struct drm_writeback_job *pos, *n;
 	unsigned long flags;
 
@@ -328,7 +329,7 @@ int drmm_writeback_connector_init(struct drm_device *dev,
 				  struct drm_encoder *enc,
 				  const u32 *formats, int n_formats)
 {
-	struct drm_connector *connector = &wb_connector->base;
+	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
 	int ret;
 
 	ret = drmm_connector_init(dev, connector, con_funcs,
@@ -352,7 +353,7 @@ int drm_writeback_set_fb(struct drm_connector_state *conn_state,
 			return -ENOMEM;
 
 		conn_state->writeback_job->connector =
-			drm_connector_to_writeback(conn_state->connector);
+			&conn_state->connector->writeback;
 	}
 
 	drm_framebuffer_assign(&conn_state->writeback_job->fb, fb);
@@ -361,13 +362,14 @@ int drm_writeback_set_fb(struct drm_connector_state *conn_state,
 
 int drm_writeback_prepare_job(struct drm_writeback_job *job)
 {
-	struct drm_writeback_connector *connector = job->connector;
+	struct drm_writeback_connector *wb_connector = job->connector;
+	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
 	const struct drm_connector_helper_funcs *funcs =
-		connector->base.helper_private;
+		connector->helper_private;
 	int ret;
 
 	if (funcs->prepare_writeback_job) {
-		ret = funcs->prepare_writeback_job(connector, job);
+		ret = funcs->prepare_writeback_job(wb_connector, job);
 		if (ret < 0)
 			return ret;
 	}
@@ -413,12 +415,13 @@ EXPORT_SYMBOL(drm_writeback_queue_job);
 
 void drm_writeback_cleanup_job(struct drm_writeback_job *job)
 {
-	struct drm_writeback_connector *connector = job->connector;
+	struct drm_writeback_connector *wb_connector = job->connector;
+	struct drm_connector *connector	= drm_writeback_to_connector(wb_connector);
 	const struct drm_connector_helper_funcs *funcs =
-		connector->base.helper_private;
+		connector->helper_private;
 
 	if (job->prepared && funcs->cleanup_writeback_job)
-		funcs->cleanup_writeback_job(connector, job);
+		funcs->cleanup_writeback_job(wb_connector, job);
 
 	if (job->fb)
 		drm_framebuffer_put(job->fb);
@@ -500,8 +503,9 @@ struct dma_fence *
 drm_writeback_get_out_fence(struct drm_writeback_connector *wb_connector)
 {
 	struct dma_fence *fence;
+	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
 
-	if (WARN_ON(wb_connector->base.connector_type !=
+	if (WARN_ON(connector->connector_type !=
 		    DRM_MODE_CONNECTOR_WRITEBACK))
 		return NULL;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 22433bfbea1e..e2a328225c9e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -481,7 +481,8 @@ static void dpu_encoder_phys_wb_prepare_for_kickoff(
 		return;
 	}
 
-	drm_conn = &wb_enc->wb_conn->base;
+	drm_conn =
+		drm_writeback_to_connector(wb_enc->wb_conn);
 	state = drm_conn->state;
 
 	if (wb_enc->wb_conn && wb_enc->wb_job)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 83ff7122a187..95db5002e999 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -29,8 +29,7 @@ static int dpu_wb_conn_get_modes(struct drm_connector *connector)
 static int dpu_wb_conn_atomic_check(struct drm_connector *connector,
 				    struct drm_atomic_commit *state)
 {
-	struct drm_writeback_connector *wb_conn = drm_connector_to_writeback(connector);
-	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(wb_conn);
+	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
 	struct drm_connector_state *conn_state =
 		drm_atomic_get_new_connector_state(state, connector);
 	struct drm_crtc *crtc;
@@ -88,10 +87,10 @@ static const struct drm_connector_funcs dpu_wb_conn_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static int dpu_wb_conn_prepare_job(struct drm_writeback_connector *connector,
+static int dpu_wb_conn_prepare_job(struct drm_writeback_connector *wb_conn,
 		struct drm_writeback_job *job)
 {
-
+	struct drm_connector *connector = drm_writeback_to_connector(wb_conn);
 	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
 
 	if (!job->fb)
@@ -102,9 +101,10 @@ static int dpu_wb_conn_prepare_job(struct drm_writeback_connector *connector,
 	return 0;
 }
 
-static void dpu_wb_conn_cleanup_job(struct drm_writeback_connector *connector,
+static void dpu_wb_conn_cleanup_job(struct drm_writeback_connector *wb_connector,
 		struct drm_writeback_job *job)
 {
+	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
 	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
 
 	if (!job->fb)
@@ -132,9 +132,9 @@ int dpu_writeback_init(struct drm_device *dev, struct drm_encoder *enc,
 
 	dpu_wb_conn->maxlinewidth = maxlinewidth;
 
-	drm_connector_helper_add(&dpu_wb_conn->base.base, &dpu_wb_conn_helper_funcs);
+	drm_connector_helper_add(&dpu_wb_conn->base, &dpu_wb_conn_helper_funcs);
 
-	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base,
+	rc = drmm_writeback_connector_init(dev, &dpu_wb_conn->base.writeback,
 					   &dpu_wb_conn_funcs, enc,
 					   format_list, num_formats);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h
index 4b11cca8014c..9ebf15392b20 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h
@@ -16,12 +16,12 @@
 #include "dpu_encoder_phys.h"
 
 struct dpu_wb_connector {
-	struct drm_writeback_connector base;
+	struct drm_connector base;
 	struct drm_encoder *wb_enc;
 	u32 maxlinewidth;
 };
 
-static inline struct dpu_wb_connector *to_dpu_wb_conn(struct drm_writeback_connector *conn)
+static inline struct dpu_wb_connector *to_dpu_wb_conn(struct drm_connector *conn)
 {
 	return container_of(conn, struct dpu_wb_connector, base);
 }
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
index d8b1dcab8dea..242f1913116b 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.h
@@ -43,7 +43,7 @@ struct rcar_du_vsp;
  * @cmm: CMM associated with this CRTC
  * @vsp: VSP feeding video to this CRTC
  * @vsp_pipe: index of the VSP pipeline feeding video to this CRTC
- * @writeback: the writeback connector
+ * @wb_connector: the drm connector which contains the writeback connector
  * @encoder: the writeback encoder
  */
 struct rcar_du_crtc {
@@ -74,12 +74,12 @@ struct rcar_du_crtc {
 	const char *const *sources;
 	unsigned int sources_count;
 
-	struct drm_writeback_connector writeback;
+	struct drm_connector wb_connector;
 	struct drm_encoder encoder;
 };
 
 #define to_rcar_crtc(c)		container_of(c, struct rcar_du_crtc, crtc)
-#define wb_to_rcar_crtc(c)	container_of(c, struct rcar_du_crtc, writeback)
+#define wb_to_rcar_crtc(c)	container_of(c, struct rcar_du_crtc, wb_connector)
 
 /**
  * struct rcar_du_crtc_state - Driver-specific CRTC state
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index a88408124758..0708e5a38a15 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -50,7 +50,8 @@ static int rcar_du_wb_conn_get_modes(struct drm_connector *connector)
 static int rcar_du_wb_prepare_job(struct drm_writeback_connector *connector,
 				  struct drm_writeback_job *job)
 {
-	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(connector);
+	struct drm_connector *conn = drm_writeback_to_connector(connector);
+	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(conn);
 	struct rcar_du_wb_job *rjob;
 	int ret;
 
@@ -75,7 +76,8 @@ static int rcar_du_wb_prepare_job(struct drm_writeback_connector *connector,
 static void rcar_du_wb_cleanup_job(struct drm_writeback_connector *connector,
 				   struct drm_writeback_job *job)
 {
-	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(connector);
+	struct drm_connector *conn = drm_writeback_to_connector(connector);
+	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(conn);
 	struct rcar_du_wb_job *rjob = job->priv;
 
 	if (!job->fb)
@@ -202,7 +204,7 @@ static const u32 writeback_formats[] = {
 int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 			   struct rcar_du_crtc *rcrtc)
 {
-	struct drm_writeback_connector *wb_conn = &rcrtc->writeback;
+	struct drm_writeback_connector *wb_conn = &rcrtc->wb_connector.writeback;
 	struct drm_encoder *encoder = &rcrtc->encoder;
 	int ret;
 
@@ -214,9 +216,8 @@ int rcar_du_writeback_init(struct rcar_du_device *rcdu,
 	if (ret)
 		return ret;
 
-	drm_connector_helper_add(&wb_conn->base,
+	drm_connector_helper_add(&rcrtc->wb_connector,
 				 &rcar_du_wb_conn_helper_funcs);
-
 	ret = drm_writeback_connector_init(&rcdu->ddev, wb_conn,
 					   &rcar_du_wb_conn_funcs,
 					   encoder,
@@ -237,7 +238,7 @@ void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
 	struct drm_framebuffer *fb;
 	unsigned int i;
 
-	state = rcrtc->writeback.base.state;
+	state = rcrtc->wb_connector.state;
 	if (!state || !state->writeback_job)
 		return;
 
@@ -252,10 +253,10 @@ void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
 		cfg->mem[i] = sg_dma_address(rjob->sg_tables[i].sgl)
 			    + fb->offsets[i];
 
-	drm_writeback_queue_job(&rcrtc->writeback, state);
+	drm_writeback_queue_job(&rcrtc->wb_connector.writeback, state);
 }
 
 void rcar_du_writeback_complete(struct rcar_du_crtc *rcrtc)
 {
-	drm_writeback_signal_completion(&rcrtc->writeback, 0);
+	drm_writeback_signal_completion(&rcrtc->wb_connector.writeback, 0);
 }
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 6ffc54d23d48..591753dcfb30 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -167,7 +167,7 @@ struct vc4_txp {
 	struct platform_device *pdev;
 
 	struct vc4_encoder encoder;
-	struct drm_writeback_connector connector;
+	struct drm_connector connector;
 
 	void __iomem *regs;
 };
@@ -176,7 +176,7 @@ struct vc4_txp {
 	container_of_const(_encoder, struct vc4_txp, encoder.base)
 
 #define connector_to_vc4_txp(_connector)				\
-	container_of_const(_connector, struct vc4_txp, connector.base)
+	container_of_const(_connector, struct vc4_txp, connector)
 
 static const struct debugfs_reg32 txp_regs[] = {
 	VC4_REG32(TXP_DST_PTR),
@@ -356,7 +356,7 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 
 	TXP_WRITE(TXP_DST_CTRL, ctrl);
 
-	drm_writeback_queue_job(&txp->connector, conn_state);
+	drm_writeback_queue_job(&txp->connector.writeback, conn_state);
 
 	drm_dev_exit(idx);
 }
@@ -505,7 +505,7 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
 	 */
 	TXP_WRITE(TXP_DST_CTRL, TXP_READ(TXP_DST_CTRL) & ~TXP_EI);
 	vc4_crtc_handle_vblank(vc4_crtc);
-	drm_writeback_signal_completion(&txp->connector, 0);
+	drm_writeback_signal_completion(&txp->connector.writeback, 0);
 
 	return IRQ_HANDLED;
 }
@@ -599,9 +599,9 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 	if (ret)
 		return ret;
 
-	drm_connector_helper_add(&txp->connector.base,
+	drm_connector_helper_add(&txp->connector,
 				 &vc4_txp_connector_helper_funcs);
-	ret = drm_writeback_connector_init(drm, &txp->connector,
+	ret = drm_writeback_connector_init(drm, &txp->connector.writeback,
 					   &vc4_txp_connector_funcs,
 					   encoder,
 					   drm_fmts, ARRAY_SIZE(drm_fmts));
@@ -623,7 +623,7 @@ static void vc4_txp_unbind(struct device *dev, struct device *master,
 {
 	struct vc4_txp *txp = dev_get_drvdata(dev);
 
-	drm_connector_cleanup(&txp->connector.base);
+	drm_connector_cleanup(&txp->connector);
 }
 
 static const struct component_ops vc4_txp_ops = {
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 0fc915a954ba..13e34d4f515e 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -658,7 +658,7 @@ void vkms_composer_worker(struct work_struct *work)
 		return;
 
 	if (wb_pending) {
-		drm_writeback_signal_completion(&out->wb_connector, 0);
+		drm_writeback_signal_completion(&out->wb_connector.writeback, 0);
 		spin_lock_irq(&out->composer_lock);
 		crtc_state->wb_pending = false;
 		spin_unlock_irq(&out->composer_lock);
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index dea6cad3f1b9..1b3c39f08333 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -217,7 +217,7 @@ struct vkms_crtc_state {
  */
 struct vkms_output {
 	struct drm_crtc crtc;
-	struct drm_writeback_connector wb_connector;
+	struct drm_connector wb_connector;
 	struct drm_encoder wb_encoder;
 	struct workqueue_struct *composer_workq;
 	spinlock_t lock;
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 858df1f89f66..b9f33f2e8b92 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -103,10 +103,13 @@ static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
 	return ret;
 }
 
-static void vkms_wb_cleanup_job(struct drm_writeback_connector *connector,
+static void vkms_wb_cleanup_job(struct drm_writeback_connector *wb_conn,
 				struct drm_writeback_job *job)
 {
 	struct vkms_writeback_job *vkmsjob = job->priv;
+	struct drm_connector *connector = container_of(wb_conn,
+						       struct drm_connector,
+						       writeback);
 	struct vkms_output *vkms_output = container_of(connector,
 						       struct vkms_output,
 						       wb_connector);
@@ -128,8 +131,8 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
 											 conn);
 	struct vkms_output *output = drm_crtc_to_vkms_output(connector_state->crtc);
-	struct drm_writeback_connector *wb_conn = &output->wb_connector;
-	struct drm_connector_state *conn_state = wb_conn->base.state;
+	struct drm_writeback_connector *wb_conn = &output->wb_connector.writeback;
+	struct drm_connector_state *conn_state = output->wb_connector.state;
 	struct vkms_crtc_state *crtc_state = output->composer_state;
 	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
 	u16 crtc_height = crtc_state->base.mode.vdisplay;
@@ -167,7 +170,7 @@ static const struct drm_connector_helper_funcs vkms_wb_conn_helper_funcs = {
 int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
 				    struct vkms_output *vkms_output)
 {
-	struct drm_writeback_connector *wb = &vkms_output->wb_connector;
+	struct drm_writeback_connector *wb = &vkms_output->wb_connector.writeback;
 	int ret;
 
 	ret = drmm_encoder_init(&vkmsdev->drm, &vkms_output->wb_encoder,
@@ -178,7 +181,7 @@ int vkms_enable_writeback_connector(struct vkms_device *vkmsdev,
 	vkms_output->wb_encoder.possible_clones |=
 		drm_encoder_mask(&vkms_output->wb_encoder);
 
-	drm_connector_helper_add(&wb->base, &vkms_wb_conn_helper_funcs);
+	drm_connector_helper_add(&vkms_output->wb_connector, &vkms_wb_conn_helper_funcs);
 
 	return drmm_writeback_connector_init(&vkmsdev->drm, wb,
 					     &vkms_wb_connector_funcs,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index f656ed8324d3..825da0f4839e 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2270,6 +2270,61 @@ struct drm_connector_cec {
 	void *data;
 };
 
+/**
+ * struct drm_writeback_connector - DRM writeback connector
+ */
+struct drm_writeback_connector {
+	/**
+	 * @pixel_formats_blob_ptr:
+	 *
+	 * DRM blob property data for the pixel formats list on writeback
+	 * connectors
+	 * See also drm_writeback_connector_init()
+	 */
+	struct drm_property_blob *pixel_formats_blob_ptr;
+
+	/** @job_lock: Protects job_queue */
+	spinlock_t job_lock;
+
+	/**
+	 * @job_queue:
+	 *
+	 * Holds a list of a connector's writeback jobs; the last item is the
+	 * most recent. The first item may be either waiting for the hardware
+	 * to begin writing, or currently being written.
+	 *
+	 * See also: drm_writeback_queue_job() and
+	 * drm_writeback_signal_completion()
+	 */
+	struct list_head job_queue;
+
+	/**
+	 * @fence_context:
+	 *
+	 * timeline context used for fence operations.
+	 */
+	unsigned int fence_context;
+	/**
+	 * @fence_lock:
+	 *
+	 * spinlock to protect the fences in the fence_context.
+	 */
+	spinlock_t fence_lock;
+	/**
+	 * @fence_seqno:
+	 *
+	 * Seqno variable used as monotonic counter for the fences
+	 * created on the connector's timeline.
+	 */
+	unsigned long fence_seqno;
+	/**
+	 * @timeline_name:
+	 *
+	 * The name of the connector's fence timeline.
+	 */
+	char timeline_name[32];
+};
+
 /**
  * struct drm_connector - central DRM connector control structure
  *
@@ -2688,10 +2743,16 @@ struct drm_connector {
 	 */
 	struct llist_node free_node;
 
-	/**
-	 * @hdmi: HDMI-related variable and properties.
-	 */
-	struct drm_connector_hdmi hdmi;
+	union {
+		/**
+		 * @hdmi: HDMI-related variable and properties.
+		 */
+		struct drm_connector_hdmi hdmi;
+		/**
+		 * @writeback: Writeback related valriables.
+		 */
+		struct drm_writeback_connector writeback;
+	};
 
 	/**
 	 * @hdmi_audio: HDMI codec properties and non-DRM state.
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index 958466a05e60..702141099520 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -15,66 +15,6 @@
 #include <drm/drm_encoder.h>
 #include <linux/workqueue.h>
 
-/**
- * struct drm_writeback_connector - DRM writeback connector
- */
-struct drm_writeback_connector {
-	/**
-	 * @base: base drm_connector object
-	 */
-	struct drm_connector base;
-
-	/**
-	 * @pixel_formats_blob_ptr:
-	 *
-	 * DRM blob property data for the pixel formats list on writeback
-	 * connectors
-	 * See also drm_writeback_connector_init()
-	 */
-	struct drm_property_blob *pixel_formats_blob_ptr;
-
-	/** @job_lock: Protects job_queue */
-	spinlock_t job_lock;
-
-	/**
-	 * @job_queue:
-	 *
-	 * Holds a list of a connector's writeback jobs; the last item is the
-	 * most recent. The first item may be either waiting for the hardware
-	 * to begin writing, or currently being written.
-	 *
-	 * See also: drm_writeback_queue_job() and
-	 * drm_writeback_signal_completion()
-	 */
-	struct list_head job_queue;
-
-	/**
-	 * @fence_context:
-	 *
-	 * timeline context used for fence operations.
-	 */
-	unsigned int fence_context;
-	/**
-	 * @fence_lock:
-	 *
-	 * spinlock to protect the fences in the fence_context.
-	 */
-	spinlock_t fence_lock;
-	/**
-	 * @fence_seqno:
-	 *
-	 * Seqno variable used as monotonic counter for the fences
-	 * created on the connector's timeline.
-	 */
-	unsigned long fence_seqno;
-	/**
-	 * @timeline_name:
-	 *
-	 * The name of the connector's fence timeline.
-	 */
-	char timeline_name[32];
-};
-
 /**
  * struct drm_writeback_job - DRM writeback job
  */
@@ -131,10 +71,10 @@ struct drm_writeback_job {
 	void *priv;
 };
 
-static inline struct drm_writeback_connector *
-drm_connector_to_writeback(struct drm_connector *connector)
+static inline struct drm_connector *
+drm_writeback_to_connector(struct drm_writeback_connector *wb_connector)
 {
-	return container_of(connector, struct drm_writeback_connector, base);
+	return container_of(wb_connector, struct drm_connector, writeback);
 }
 
 int drm_writeback_connector_init(struct drm_device *dev,
-- 
2.34.1

