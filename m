Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23292606A336
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 07:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SDvgBNIY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B64C10F57E;
	Thu, 12 Nov 2026 07:52:55 +0000 (UTC)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CD4E10F44A
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 07:52:48 +0000 (UTC)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-8b5a6f2f27fso1581644b3a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 23:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794469968; x=1795074768; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g8AhcBKXX6u9q0M0CVMCOKRVoJRFPnXIpVIntJS4u+k=;
 b=SDvgBNIYiyjjSrD5lnywJbrrKxZmi/WgCsTdHdYnE9aXAhcOEJEIaCot86aHfS6eko
 qHl2xV9imGqdgEj2HefHXt/VWqemniuOv/LDI4DcXR5yEZhwkRXS4tyhBtJ6v8bG9Uiz
 sqo9E18hQ8bZcmUap82Ze0XyJuxl+Rl9xtHZYEW0akuGZ41sYDeoGTSCrVhqnefCCv+A
 9x/fZzDmGQ069nmuLYwwYyf3a0IjAHS6M2lnfU49EonfR6dluEX2I9f3rJXwVKyTu1rd
 URStO3+H92l3Wgq5LvMOlvyiM5RVGiDIbpdJIbtGlHAJzP+6s3DO/szyms6kGzdoG8gm
 NuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794469968; x=1795074768;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=g8AhcBKXX6u9q0M0CVMCOKRVoJRFPnXIpVIntJS4u+k=;
 b=tyXQ5oePyg77kydEJq2eobSst0W6G21zLOLzIK7FxWQStStSQA2EhHVtP1mSYiSoSD
 vZuAYKXtIPAaKhVnvqFrn5CkEkAM7l8OydQhnUlifOH+YcIXEpRZ5Kmpl0Yaf8WFk82L
 8Krsx1FZSqlDcKJ9JJAAqvoQRrZAyHUcL/HXdC0pWUzD4P1firjDr+Q1Yj8uaqkzZrbJ
 aHq4AWnJzEtsgdGhf3htQKXQAUfiYgDkO40gZYIWDcwv7SUjUtwx1ssyM9kU68Dsz/6Y
 EXi/cUDzXNKcMkbrRurQasgTVOrDEw1fjmJI87Y6HniFotlrvhEHudwjmjP7sql0H6+n
 6/lw==
X-Forwarded-Encrypted: i=1;
 AL+hErHzXROQBq2WKH3TlHBSuGF48R+8zIiCxEqCb+tga8nM6VujkBhFc7cioEjU9bKVnrOJbkuwDQIwFLY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9jHufiHAPHu5fnBadwA56pT8lfX/E90SpsFw+AO+kxP3XCyXha
 opv1OJuI81Env6FjRhSIQN3hmYs6MuMizY/5rqkdUoH9ipcWxsVlgSb1cNxrgYSnjDM=
X-Gm-Gg: AYBFou0IfO+EbSFyNuoPkwKNOd4NkGoK7woLoVp+NQ9SYEpHufJ+DB+xRzd9XX5oWVt
 Z+HTKvATfzeb8yuNJaMVCzKaARAA+ExeT7yxCek5PB/n2LAWpvkMr0vMIqx6JUlxuOGMl9BFT/g
 daP77gr95p85iUJSPEpkcXgl/uoYA1MnrNJOOK5YqnaUVdGDeyAVKx7R9kvgxX/p19n/mcZhe7Q
 0p9w2pF/BK7GZkr8hBU08U8bzdfnGLa0Q953cU/KyqQoayWf5n6Fzio9inX+Ykv4RPKmkJ9Pc37
 JVgmc71jw6IFYmFgoELEpbiNNrBPvku1t83B9ltjG7JPpeNwDUGZLP8toFiKur33yKTb2P48Lnr
 W+neVNXbPb8ZMvfMSmL4vzNgDlx+Mb6p0SV7yP3AjD1ceNwsWi32DtLd9vEyMxhm3TwLlIPf1NS
 CLQq12VPbw6YJDvdZ2Fi7GSkukziBPyEFDJkuhokx2ifEJzBx6S/Z6ESJ3TfzFc1ML/j7/kYKZQ
 nEYFbjvqjSJpdf0VCZPIzTRor8J009TUb3HrCwClQI3voXsSWr0oZNY8JMriqWifoCRwwGi9t7N
 OSXXhV9BNk6vKUhgCJDxzsDx1E5IOw==
X-Received: by 2002:a05:6a00:2290:b0:883:904e:da56 with SMTP id
 d2e1a72fcca58-8bc1c2a8880mr4908334b3a.36.1794469967620; 
 Wed, 11 Nov 2026 23:52:47 -0800 (PST)
Received: from [127.0.1.1] ([116.237.168.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baab5f3f99sm3131256b3a.51.2026.11.11.23.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 23:52:47 -0800 (PST)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 12 Nov 2026 15:52:07 +0800
Subject: [PATCH 6/8] drm/msm/dpu: Make writeback interface reallocatable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-cwb-upstream-v1-6-a6a88d928aa4@linaro.org>
References: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
In-Reply-To: <20261112-cwb-upstream-v1-0-a6a88d928aa4@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794469928; l=17305;
 i=jun.nie@linaro.org; h=from:subject:message-id;
 bh=QHlsqEMhbMBWURU/fzCVHZeCr5Dgp9EmOzVDPiskrNQ=;
 b=StpQcMojVCJ6GTRj8sfRFRk1zF4Z1KIv71uskOqOSrwnmiqlgVnqj5wYbyAvrOSOpFRxXOq6R
 nCtaWR4hqB/BPEddFifRL3hdO3SThPlMoziNOmaCV5QMsuUc7E4QB7X
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=O9aRQ3+xXWihQiRRgStCET+eFXx1EZs43Fh0Xh+8Bu4=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, only a single writeback interface is supported even when
the hardware provides two. A single writeback interface has limited
bandwidth and only supports up to two mixers.

Make the writeback interface reallocatable so that two writeback
interfaces can be attached to a single CRTC pipeline. This enables
quad-pipe use cases and provides higher writeback bandwidth.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        | 145 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h   |   2 +
 .../gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c    |   8 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h          |  11 ++
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  45 +++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c             |  64 +++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h             |  24 ++++
 9 files changed, 274 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 11eae4b19684..2f19ecfb6020 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -57,6 +57,7 @@
 
 #define MAX_CHANNELS_PER_ENC 4
 #define MAX_CWB_PER_ENC MAX_CHANNELS_PER_ENC
+#define MAX_WB_PER_ENC 2
 
 #define IDLE_SHORT_TIMEOUT	1
 
@@ -141,6 +142,7 @@ enum dpu_enc_rc_states {
  * @hw_dsc:		Handle to the DSC blocks used for the display.
  * @dsc_mask:		Bitmask of used DSC blocks.
  * @cwb_mask:		Bitmask of used CWB muxes
+ * @wb_mask:		Bitmask of used WB muxes
  * @intfs_swapped:	Whether or not the phys_enc interfaces have been swapped
  *			for partial update right-only cases, such as pingpong
  *			split where virtual pingpong does not generate IRQs
@@ -184,10 +186,12 @@ struct dpu_encoder_virt {
 	struct dpu_encoder_phys *cur_slave;
 	struct dpu_hw_pingpong *hw_pp[MAX_CHANNELS_PER_ENC];
 	struct dpu_hw_cwb *hw_cwb[MAX_CWB_PER_ENC];
+	struct dpu_hw_wb *hw_wb[MAX_WB_PER_ENC];
 	struct dpu_hw_dsc *hw_dsc[MAX_CHANNELS_PER_ENC];
 
 	unsigned int dsc_mask;
 	unsigned int cwb_mask;
+	unsigned int wb_mask;
 
 	bool intfs_swapped;
 
@@ -1128,6 +1132,143 @@ void dpu_encoder_cleanup_wb_job(struct drm_encoder *drm_enc,
 	}
 }
 
+static void dpu_encoder_update_wb_info(int num_wb,
+				       struct dpu_encoder_virt *dpu_enc,
+				       struct msm_display_info *info)
+{
+	info->intf_type = INTF_WB;
+	info->is_cmd_mode = false;
+	info->h_tile_instance[info->num_of_h_tiles++] = dpu_enc->hw_wb[0]->idx;
+	if (num_wb == 2) {
+		info->h_tile_instance[info->num_of_h_tiles++] =
+			dpu_enc->hw_wb[1]->idx;
+		info->num_of_h_tiles = 2;
+	} else {
+		info->num_of_h_tiles = 1;
+	}
+}
+
+static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
+				 struct dpu_kms *dpu_kms,
+				 struct msm_display_info *disp_info);
+
+static int dpu_encoder_reinit(struct dpu_encoder_virt *dpu_enc,
+		struct dpu_kms *dpu_kms,
+		struct msm_display_info *disp_info)
+{
+	int ret;
+
+	ret = dpu_encoder_setup_display(dpu_enc, dpu_kms, disp_info);
+	if (ret) {
+		DPU_ERROR("failed to setup encoder\n");
+		return ret;
+	}
+
+	memcpy(&dpu_enc->disp_info, disp_info, sizeof(*disp_info));
+
+	DPU_DEBUG_ENC(dpu_enc, "re-inited\n");
+
+	return ret;
+}
+
+static int dpu_encoder_reinit_writeback(struct dpu_kms *dpu_kms,
+				    struct dpu_encoder_virt *dpu_enc,
+				    struct dpu_global_state *global_state,
+				    struct drm_crtc_state *crtc_state,
+				    int num_wb)
+{
+	struct msm_display_info info;
+	int i, rc = 0;
+
+	dpu_enc->wb_mask = 0;
+	for (i = 0; i < MAX_WB_PER_ENC; i++)
+		dpu_enc->hw_wb[i] = NULL;
+
+	memset(&info, 0, sizeof(info));
+	dpu_rm_release_all_wb(global_state, crtc_state->crtc);
+	for (i = 0; i < num_wb; i++) {
+		dpu_enc->hw_wb[i] = dpu_rm_reserve_wb(&dpu_kms->rm, global_state,
+						      crtc_state->crtc->base.id);
+		if (!dpu_enc->hw_wb[i]) {
+			DPU_ERROR("Failed to get the %s writeback controller\n",
+				  i ? "2nd" : "1st");
+			return -EBUSY;
+		}
+		dpu_enc->wb_mask |= BIT(dpu_enc->hw_wb[i]->idx - WB_0);
+	}
+
+	dpu_encoder_update_wb_info(num_wb, dpu_enc, &info);
+	rc = dpu_encoder_reinit(dpu_enc, dpu_kms, &info);
+	if (rc) {
+		DPU_ERROR("Re-init encoder failed for writeback\n");
+		return rc;
+	}
+
+	return rc;
+}
+
+static void dpu_encoder_virt_remove_phys_encs(
+		struct drm_device *dev,
+		struct dpu_encoder_virt *dpu_enc,
+		struct dpu_encoder_phys *phy)
+{
+	DPU_DEBUG_ENC(dpu_enc, "num_phys_encs %d\n", dpu_enc->num_phys_encs);
+
+	if (dpu_enc->disp_info.intf_type == INTF_WB) {
+		dpu_encoder_phys_wb_deinit(dev, phy);
+
+		dpu_enc->phys_encs[dpu_enc->num_phys_encs - 1] = NULL;
+		--dpu_enc->num_phys_encs;
+	}
+}
+
+static int dpu_encoder_release_wb_phys(struct dpu_encoder_virt *dpu_enc, struct dpu_kms *dpu_kms)
+{
+	if (dpu_enc->num_phys_encs == 2)
+		dpu_encoder_virt_remove_phys_encs(dpu_kms->dev,
+			dpu_enc, dpu_enc->cur_slave);
+
+	if (dpu_enc->num_phys_encs)
+		dpu_encoder_virt_remove_phys_encs(dpu_kms->dev,
+			dpu_enc, dpu_enc->cur_master);
+
+	dpu_enc->num_phys_encs = 0;
+	dpu_enc->cur_slave = NULL;
+	dpu_enc->cur_master = NULL;
+
+	return 0;
+}
+
+static int dpu_encoder_virt_atomic_check(struct drm_encoder *encoder,
+			    struct drm_crtc_state *crtc_state,
+			    struct drm_connector_state *conn_state)
+{
+	struct msm_drm_private *priv;
+	struct dpu_kms *dpu_kms;
+	struct dpu_encoder_virt *dpu_enc;
+	struct dpu_global_state *global_state = dpu_kms_get_global_state(crtc_state->state);
+	int num_lm = dpu_crtc_get_num_lm(crtc_state);
+	bool clone_mode = drm_crtc_in_clone_mode(crtc_state);
+	int num_wb = max(1, num_lm / 2);
+	int ret = 0;
+
+
+	dpu_enc = to_dpu_encoder_virt(encoder);
+	priv = encoder->dev->dev_private;
+	dpu_kms = to_dpu_kms(priv->kms);
+	global_state = dpu_kms_get_global_state(crtc_state->state);
+
+	if (clone_mode && encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL) {
+		if (num_wb == dpu_enc->num_phys_encs)
+			return 0;
+		dpu_encoder_release_wb_phys(dpu_enc, dpu_kms);
+		ret = dpu_encoder_reinit_writeback(dpu_kms, dpu_enc, global_state,
+						   crtc_state, num_wb);
+	}
+
+	return ret;
+}
+
 static void dpu_encoder_virt_atomic_mode_set(struct drm_encoder *drm_enc,
 					     struct drm_crtc_state *crtc_state,
 					     struct drm_connector_state *conn_state)
@@ -2680,6 +2821,9 @@ static int dpu_encoder_setup_display(struct dpu_encoder_virt *dpu_enc,
 			DPU_ERROR_ENC(dpu_enc, "failed to add phys encs\n");
 			break;
 		}
+
+		DPU_DEBUG_ENC(dpu_enc, "%s add %d phyenc\n", dpu_enc->base.name,
+			      dpu_enc->num_phys_encs);
 	}
 
 	mutex_unlock(&dpu_enc->enc_lock);
@@ -2720,6 +2864,7 @@ static void dpu_encoder_frame_done_timeout(struct timer_list *t)
 
 static const struct drm_encoder_helper_funcs dpu_encoder_helper_funcs = {
 	.atomic_mode_set = dpu_encoder_virt_atomic_mode_set,
+	.atomic_check = dpu_encoder_virt_atomic_check,
 	.atomic_disable = dpu_encoder_virt_atomic_disable,
 	.atomic_enable = dpu_encoder_virt_atomic_enable,
 };
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
index 0bfbce317575..b8c8222a03b2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
@@ -352,4 +352,6 @@ void dpu_encoder_frame_done_callback(
 void dpu_encoder_phys_init(struct dpu_encoder_phys *phys,
 			   struct dpu_enc_phys_init_params *p);
 
+void dpu_encoder_phys_wb_deinit(struct drm_device *dev,
+				struct dpu_encoder_phys *phys_enc);
 #endif /* __dpu_encoder_phys_H__ */
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 7d3528907670..6f40a420f30b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -711,3 +711,11 @@ struct dpu_encoder_phys *dpu_encoder_phys_wb_init(struct drm_device *dev,
 
 	return phys_enc;
 }
+
+void dpu_encoder_phys_wb_deinit(struct drm_device *dev,
+				struct dpu_encoder_phys *phys_enc)
+{
+	struct dpu_encoder_phys_wb *wb_enc = to_dpu_encoder_phys_wb(phys_enc);
+
+	drmm_kfree(dev, wb_enc);
+}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index ba1554095a33..16544ca69a2c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -25,6 +25,7 @@
 #define DPU_MAX_IMG_HEIGHT 0x3fff
 
 #define CRTC_QUAD_MIXERS	4
+#define CRTC_DUAL_WB		2
 
 #define MAX_XIN_COUNT 16
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
index cfdbb5bb2a0f..8149bad5963b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_wb.h
@@ -65,6 +65,7 @@ struct dpu_hw_wb_ops {
  * @ops: function pointers
  */
 struct dpu_hw_wb {
+	struct dpu_hw_blk base;
 	struct dpu_hw_blk_reg_map hw;
 
 	/* wb path */
@@ -75,6 +76,16 @@ struct dpu_hw_wb {
 	struct dpu_hw_wb_ops ops;
 };
 
+/**
+ * dpu_hw_wb - convert base object dpu_hw_base to container
+ * @hw: Pointer to base hardware block
+ * return: Pointer to hardware block container
+ */
+static inline struct dpu_hw_wb *to_dpu_hw_wb(struct dpu_hw_blk *hw)
+{
+	return container_of(hw, struct dpu_hw_wb, base);
+}
+
 struct dpu_hw_wb *dpu_hw_wb_init(struct drm_device *dev,
 				 const struct dpu_wb_cfg *cfg,
 				 void __iomem *addr,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..135626c88691 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -715,37 +715,39 @@ static int _dpu_kms_initialize_hdmi(struct drm_device *dev,
 }
 
 static int _dpu_kms_initialize_writeback(struct drm_device *dev,
-		struct msm_drm_private *priv, struct dpu_kms *dpu_kms,
-		const u32 *wb_formats, int n_formats)
+		struct msm_drm_private *priv, struct dpu_kms *dpu_kms)
 {
 	struct drm_encoder *encoder = NULL;
 	struct msm_display_info info;
-	const enum dpu_wb wb_idx = WB_2;
+	const u32 *wb_formats;
+	int n_formats;
+	int max_wb = min(2, dpu_kms->catalog->wb_count);
+	int rc = 0;
 	u32 maxlinewidth;
-	int rc;
 
 	memset(&info, 0, sizeof(info));
-
-	info.num_of_h_tiles = 1;
-	/* use only WB idx 2 instance for DPU */
-	info.h_tile_instance[0] = wb_idx;
 	info.intf_type = INTF_WB;
+	info.num_of_h_tiles = 1;
+	info.h_tile_instance[0] = dpu_kms->catalog->wb[0].id;
+	info.is_cmd_mode = false;
 
 	maxlinewidth = dpu_rm_get_wb(&dpu_kms->rm, info.h_tile_instance[0])->caps->maxlinewidth;
+	maxlinewidth *= max_wb;
 
 	encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_VIRTUAL, &info);
 	if (IS_ERR(encoder)) {
-		DPU_ERROR("encoder init failed for dsi display\n");
+		DPU_ERROR("encoder init failed for writeback\n");
 		return PTR_ERR(encoder);
 	}
 
+	wb_formats = dpu_kms->catalog->wb[0].format_list;
+	n_formats = dpu_kms->catalog->wb[0].num_formats;
+
 	rc = dpu_writeback_init(dev, encoder, wb_formats, n_formats, maxlinewidth);
-	if (rc) {
+	if (rc)
 		DPU_ERROR("dpu_writeback_init, rc = %d\n", rc);
-		return rc;
-	}
 
-	return 0;
+	return rc;
 }
 
 /**
@@ -781,20 +783,9 @@ static int _dpu_kms_setup_displays(struct drm_device *dev,
 		return rc;
 	}
 
-	/* Since WB isn't a driver check the catalog before initializing */
-	if (dpu_kms->catalog->wb_count) {
-		for (i = 0; i < dpu_kms->catalog->wb_count; i++) {
-			if (dpu_kms->catalog->wb[i].id == WB_2) {
-				rc = _dpu_kms_initialize_writeback(dev, priv, dpu_kms,
-						dpu_kms->catalog->wb[i].format_list,
-						dpu_kms->catalog->wb[i].num_formats);
-				if (rc) {
-					DPU_ERROR("initialize_WB failed, rc = %d\n", rc);
-					return rc;
-				}
-			}
-		}
-	}
+	rc = _dpu_kms_initialize_writeback(dev, priv, dpu_kms);
+	if (rc)
+		DPU_ERROR("initialize_WB failed, rc = %d\n", rc);
 
 	return rc;
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index e39831a397b1..cb5edeae8e56 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -133,6 +133,7 @@ struct dpu_global_state {
 
 	uint32_t sspp_to_crtc_id[SSPP_MAX - SSPP_NONE];
 	uint32_t cwb_to_crtc_id[CWB_MAX - CWB_0];
+	uint32_t wb_to_crtc_id[WB_MAX - WB_0];
 };
 
 struct dpu_global_state
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
index 9519cc59e9f3..7d0d3d497c22 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
@@ -755,6 +755,8 @@ void dpu_rm_release(struct dpu_global_state *global_state,
 	_dpu_rm_clear_mapping(&global_state->cdm_to_crtc_id, 1, crtc_id);
 	_dpu_rm_clear_mapping(global_state->cwb_to_crtc_id,
 			ARRAY_SIZE(global_state->cwb_to_crtc_id), crtc_id);
+	_dpu_rm_clear_mapping(global_state->wb_to_crtc_id,
+			ARRAY_SIZE(global_state->wb_to_crtc_id), crtc_id);
 }
 
 /**
@@ -878,6 +880,34 @@ void dpu_rm_release_all_sspp(struct dpu_global_state *global_state,
 		ARRAY_SIZE(global_state->sspp_to_crtc_id), crtc_id);
 }
 
+void dpu_rm_release_all_wb(struct dpu_global_state *global_state,
+			   struct drm_crtc *crtc)
+{
+	uint32_t crtc_id = crtc->base.id;
+
+	_dpu_rm_clear_mapping(global_state->wb_to_crtc_id,
+		ARRAY_SIZE(global_state->wb_to_crtc_id), crtc_id);
+}
+
+struct dpu_hw_wb *dpu_rm_reserve_wb(struct dpu_rm *rm,
+				    struct dpu_global_state *global_state,
+				    uint32_t crtc_id)
+{
+	int wb_idx;
+
+	for (wb_idx = 0; wb_idx < ARRAY_SIZE(rm->hw_wb); wb_idx++) {
+		if (!rm->hw_wb[wb_idx])
+			continue;
+
+		if (global_state->wb_to_crtc_id[wb_idx])
+			continue;
+
+		global_state->wb_to_crtc_id[wb_idx] = crtc_id;
+		return rm->hw_wb[wb_idx];
+	}
+	return NULL;
+}
+
 static char *dpu_hw_blk_type_name[] = {
 	[DPU_HW_BLK_TOP] = "TOP",
 	[DPU_HW_BLK_SSPP] = "SSPP",
@@ -989,6 +1019,40 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
 	return num_blks;
 }
 
+int dpu_rm_get_assigned_wb(struct dpu_rm *rm,
+	struct dpu_global_state *global_state, struct drm_crtc *crtc,
+	struct dpu_hw_wb **blks, int blks_size)
+{
+	uint32_t crtc_id = crtc->base.id;
+	struct dpu_hw_wb **hw_blks;
+	uint32_t *hw_to_crtc_id;
+	int i, num_blks, max_blks;
+
+	hw_blks = rm->hw_wb;
+	hw_to_crtc_id = global_state->wb_to_crtc_id;
+	max_blks = ARRAY_SIZE(rm->hw_wb);
+
+	num_blks = 0;
+	for (i = 0; i < max_blks; i++) {
+		if (hw_to_crtc_id[i] != crtc_id)
+			continue;
+
+		if (num_blks == blks_size) {
+			DPU_ERROR("More than %d WB assigned to crtc %d\n",
+				  blks_size, crtc_id);
+			break;
+		}
+		if (!hw_blks[i]) {
+			DPU_ERROR("WB unavailable to assign to crtc %d\n",
+				  crtc_id);
+			break;
+		}
+		blks[num_blks++] = hw_blks[i];
+	}
+
+	return num_blks;
+}
+
 static void dpu_rm_print_state_helper(struct drm_printer *p,
 					    struct dpu_hw_blk *blk,
 					    uint32_t mapping)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
index 9b2ea51608de..2723f78dc175 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
@@ -93,6 +93,13 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
 	struct dpu_global_state *global_state, struct drm_crtc *crtc,
 	enum dpu_hw_blk_type type, struct dpu_hw_blk **blks, int blks_size);
 
+/**
+ * Get WB hw resources of the given type that are assigned to this crtc.
+ */
+int dpu_rm_get_assigned_wb(struct dpu_rm *rm,
+	struct dpu_global_state *global_state, struct drm_crtc *crtc,
+	struct dpu_hw_wb **blks, int blks_size);
+
 void dpu_rm_print_state(struct drm_printer *p,
 			const struct dpu_global_state *global_state);
 
@@ -106,6 +113,15 @@ static inline struct dpu_hw_intf *dpu_rm_get_intf(struct dpu_rm *rm, enum dpu_in
 	return rm->hw_intf[intf_idx - INTF_0];
 }
 
+/**
+ * dpu_rm_release_all_wb - Given the CRTC, release all WB
+ *	blocks previously reserved for that use case.
+ * @rm: DPU Resource Manager handle
+ * @crtc: DRM CRTC handle
+ */
+void dpu_rm_release_all_wb(struct dpu_global_state *global_state,
+			     struct drm_crtc *crtc);
+
 /**
  * dpu_rm_get_wb - Return a struct dpu_hw_wb instance given it's index.
  * @rm: DPU Resource Manager handle
@@ -116,6 +132,14 @@ static inline struct dpu_hw_wb *dpu_rm_get_wb(struct dpu_rm *rm, enum dpu_wb wb_
 	return rm->hw_wb[wb_idx - WB_0];
 }
 
+/**
+ * dpu_rm_reserve_wb - Reserve the WB for the provided CRTC
+ * @dpu_kms: dpu_kms handle
+ */
+struct dpu_hw_wb *dpu_rm_reserve_wb(struct dpu_rm *rm,
+				    struct dpu_global_state *global_state,
+				    uint32_t crtc_id);
+
 /**
  * dpu_rm_get_sspp - Return a struct dpu_hw_sspp instance given it's index.
  * @rm: DPU Resource Manager handle

-- 
2.53.0

