Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893FFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6F610E39D;
	Mon, 13 Jul 2026 23:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ItWEj+pJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6ED10E39D
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 23:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ogqx4JC2Bn9jeLYccrvGTKzYR0yir8BnH1/SoTEeO2w=; b=ItWEj+pJONztpGDkC1mM51JOGE
 /gnYhD5lGPLXae/TdgfnTH7AhRCcGaPt7o9k2KKVDd+KcY+qhfmUcUtc2oQH0ZzfqBL+mk2Uaav53
 UsGzBw6S+UXVN415GwXwPD+TBV/evxTtMOcwFfyP2JKmMsJj24lsNcSpyx/iJjiLJXQMc2vh0jiD7
 06cKpPPxGUuXQNclxdh9lMqZQeBgWRuHCppVuBDkicBSCUK7xAbQd5Z1efD6ATytoYS+SdxunfXai
 SVgjbGKeD/JNJY3FLuqqryvFU+X8LoMrzyekW3kCJfcxoLbxtQ/6XoSDH+y409YeqINszXc+FOD+u
 Xs898EOQ==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wjQS7-00EjJa-BP; Tue, 14 Jul 2026 01:52:47 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH v7 3/9] drm/amd/display: use drmm_writeback_connector_init()
Date: Mon, 13 Jul 2026 16:51:45 -0700
Message-ID: <20260713235153.3862650-4-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713235153.3862650-1-John.Harrison@Igalia.com>
References: <20260713235153.3862650-1-John.Harrison@Igalia.com>
MIME-Version: 1.0
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

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup (neither
manually nor by calling drm_writeback_connector_cleanup()). On the
contrary, the drmm_writeback_connector_init() function ensures the
proper cleanup of the job queue.

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1fd48e28f5fe..1726eb6a3c63 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4899,7 +4899,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 		return;
 	}
 
-	acrtc = to_amdgpu_crtc(wb_conn->encoder.crtc);
+	acrtc = to_amdgpu_crtc(crtc_state->base.crtc);
 	if (!acrtc) {
 		drm_err(adev_to_drm(adev), "no amdgpu_crtc found\n");
 		kfree(wb_info);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 0bf82e46f773..3ee31634549e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -174,7 +174,6 @@ static const struct drm_encoder_helper_funcs amdgpu_dm_wb_encoder_helper_funcs =
 
 static const struct drm_connector_funcs amdgpu_dm_wb_connector_funcs = {
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = drm_connector_cleanup,
 	.reset = amdgpu_dm_connector_funcs_reset,
 	.atomic_duplicate_state = amdgpu_dm_connector_atomic_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
@@ -193,17 +192,26 @@ int amdgpu_dm_wb_connector_init(struct amdgpu_display_manager *dm,
 	struct dc *dc = dm->dc;
 	struct dc_link *link = dc_get_link_at_index(dc, link_index);
 	int res;
+	struct drm_encoder *encoder;
+
+	encoder = drmm_plain_encoder_alloc(&dm->adev->ddev, NULL,
+					   DRM_MODE_ENCODER_VIRTUAL, NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &amdgpu_dm_wb_encoder_helper_funcs);
+
+	encoder->possible_crtcs = amdgpu_dm_get_encoder_crtc_mask(dm->adev);
 
 	wbcon->link = link;
 
 	drm_connector_helper_add(&wbcon->base.base, &amdgpu_dm_wb_conn_helper_funcs);
 
-	res = drm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
+	res = drmm_writeback_connector_init(&dm->adev->ddev, &wbcon->base,
 					    &amdgpu_dm_wb_connector_funcs,
-					    &amdgpu_dm_wb_encoder_helper_funcs,
+					    encoder,
 					    amdgpu_dm_wb_formats,
-					    ARRAY_SIZE(amdgpu_dm_wb_formats),
-					    amdgpu_dm_get_encoder_crtc_mask(dm->adev));
+					    ARRAY_SIZE(amdgpu_dm_wb_formats));
 
 	if (res)
 		return res;
-- 
2.43.0

