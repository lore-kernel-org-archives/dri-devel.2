Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8430CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 16:25:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6E010F3D4;
	Thu, 28 May 2026 16:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="VYqlOkwx";
	dkim-atps=neutral
Received: from mail-ot1-f100.google.com (mail-ot1-f100.google.com
 [209.85.210.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CC7510F3D4
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 16:25:36 +0000 (UTC)
Received: by mail-ot1-f100.google.com with SMTP id
 46e09a7af769-7e612d0693eso5053295a34.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 09:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779985535; x=1780590335;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NRT4ulSrFr0N+iLsZRjSEYFDyJfVFybBwvkq3FULihQ=;
 b=XpBxxew+auJq8EpxK6v2Z6s+wRlYQQf8q51TKrTRKkuQ8KPkj58I4kxmO+fCPP/wmJ
 Ao2VA5V9t2+lGk7VkzRQhshTK6aPrS4CwEl5XloSVGEO6CrQZrOpNm7CG4uyoc8h7aUp
 Fm25TVL//3MUhSxtNNn5L01uzsykLhA/KWyicZlf5uAWXyXuheiHOxmGJP8RVpw8/pqB
 th3OlUGivFa5cnjD/zaG62mYsmUN+gHdHMBPkN4UsiVlxg9gWRsOUeFfALxBVnrtuxO2
 qwud0KEb4ev2n8PrXvG6yH98QeSYxp4Qv608cTykQDXdcmNZiwPeUjz0dtlIZDhNeGby
 8rhw==
X-Gm-Message-State: AOJu0YzEpzyGkQ9qAG8CpMyDSEy1fKJvssyQqPSQaUNYsJXzSRNiIjBh
 PkACDC/K/ilAq0GjDS8jkBDV2fPtFVwpbaFneeAQBHsBPwl8hcs7BPLPqNi/bcZTK1m+mRnVfeC
 JXOczbZiutYy/+Sj88KFrEtHoILOcAwUcWvPP0Pvw+asfn11qH5ezkB2oLTydjHV0IcnHUqmBFE
 QLNq+sM77ZC8i57R6Y05Fe9Z9q7tT8t+P1MY5mSx3lGHGnYf+IndAseBA53k0MWDShtRO2E0sih
 PDaxofFKo+2aLtksCOX
X-Gm-Gg: Acq92OFjEt4fjStUqD9vD8yai/PTQ+iB7jI48gyTnhMWOBKMqm0U08CoEdd4zfLask9
 Qr3PLH6nVQyNZFlgAtOglG2YMIkdDOQiQUGOlEWkJ1Mk6+Nzct2fR20FrWoJK5S7aMfClDgyhCf
 +mvaFjzYnLg58CSuMImX/KMQFwL0oD5ko4pvEG9TMuDI0cZm4112oHLAVCF+kxt90FwX/HaUdFr
 VKrwmbEKL+8z/WFWYE9+/n8MqsgxCXfjsmKB1Pnfrpf+Y4Qn1FUgQRpdRoGg8nOPXHwxV8jKQMr
 bNyMMhjFgCJSbO1OVyHIGUGyiX5BYPepon896T6S/uWF2S+Zx3uqtPv0NEC67088TUVPSKFtbcX
 TdvLTYyU6kN3/dh0vWAdP7K/vv5+1g5rUsMzoJkNJLruVN8PdKcfqCHCteIWrf77COXFZgkif47
 90wblhru9s60RQTALNGhEacMBnvsRIG+e+z5jG+U4OsS46j6VM8mV1O+MvFHL/2dtieMQ=
X-Received: by 2002:a05:6820:f014:b0:69b:922f:cad0 with SMTP id
 006d021491bc7-69d7ece92ccmr13297344eaf.57.1779985534844; 
 Thu, 28 May 2026 09:25:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
 by smtp-relay.gmail.com with ESMTPS id
 006d021491bc7-69d83ad6518sm834792eaf.19.2026.05.28.09.25.34
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 May 2026 09:25:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-90f5248b209so1218966185a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 09:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1779985534; x=1780590334;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NRT4ulSrFr0N+iLsZRjSEYFDyJfVFybBwvkq3FULihQ=;
 b=VYqlOkwxTOfyPLICoYgpchnfv88jUpxlZMO6M2eX8WfwJSeZ82jit9XMaF90KC1k2x
 VeArzFekNnuUgGQ9xNkYhkvVvtkQ8q6Vxi+QTsu05p//csFHsxJwcb0IaXnImn29OkVI
 YKVE6bn0n5WEoZexTntV1TrwxUa4kbLVETZkQ=
X-Received: by 2002:a05:620a:25d0:b0:915:2404:bfe9 with SMTP id
 af79cd13be357-9152404c5c3mr259850885a.9.1779985533714; 
 Thu, 28 May 2026 09:25:33 -0700 (PDT)
X-Received: by 2002:a05:620a:25d0:b0:915:2404:bfe9 with SMTP id
 af79cd13be357-9152404c5c3mr259842585a.9.1779985532911; 
 Thu, 28 May 2026 09:25:32 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86e9bf5sm858500685a.8.2026.05.28.09.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 09:25:32 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Fix Display Unit cleanup
Date: Thu, 28 May 2026 11:25:27 -0500
Message-ID: <20260528162527.1280708-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

Because vmwgfx has no clear delineation between crtcs, connectors, and
encoders we were destroying and freeing the entire display unit when any
of these components were destroyed. This breaks the cleanup code in
drm_mode_config_cleanup which has a specific teardown order and results
in a use after free and/or nullptr deref.

A display unit most closely maps to a CRTC which is destroyed last in
drm_mode_config_cleanup so all major cleanup related to the DU should be
done in the crtc_destroy hook.

Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 24 ---------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  4 --
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  | 41 ++++-----------
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 40 ++++-----------
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 75 ++++------------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c |  4 --
 6 files changed, 28 insertions(+), 160 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 1b407b61f683..53de95d25ee8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -26,30 +26,6 @@ void vmw_du_init(struct vmw_display_unit *du)
 	vmw_vkms_crtc_init(&du->crtc);
 }
 
-void vmw_du_cleanup(struct vmw_display_unit *du)
-{
-	struct vmw_private *dev_priv = vmw_priv(du->primary.dev);
-
-	vmw_vkms_crtc_cleanup(&du->crtc);
-	drm_plane_cleanup(&du->primary);
-	if (vmw_cmd_supported(dev_priv))
-		drm_plane_cleanup(&du->cursor.base);
-
-	drm_connector_unregister(&du->connector);
-	drm_crtc_cleanup(&du->crtc);
-	drm_encoder_cleanup(&du->encoder);
-	drm_connector_cleanup(&du->connector);
-}
-
-
-void vmw_du_primary_plane_destroy(struct drm_plane *plane)
-{
-	drm_plane_cleanup(plane);
-
-	/* Planes are static in our case so we don't free it */
-}
-
-
 /**
  * vmw_du_plane_unpin_surf - unpins resource associated with a framebuffer surface
  *
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
index 2224d7d91d1b..ec3d23b449e4 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.h
@@ -348,7 +348,6 @@ struct vmw_display_unit {
  * Shared display unit functions - vmwgfx_kms.c
  */
 void vmw_du_init(struct vmw_display_unit *du);
-void vmw_du_cleanup(struct vmw_display_unit *du);
 int vmw_du_crtc_gamma_set(struct drm_crtc *crtc,
 			   u16 *r, u16 *g, u16 *b,
 			   uint32_t size,
@@ -403,9 +402,6 @@ void vmw_guess_mode_timing(struct drm_display_mode *mode);
 void vmw_kms_update_implicit_fb(struct vmw_private *dev_priv);
 void vmw_kms_create_implicit_placement_property(struct vmw_private *dev_priv);
 
-/* Universal Plane Helpers */
-void vmw_du_primary_plane_destroy(struct drm_plane *plane);
-
 /* Atomic Helpers */
 int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
 				      struct drm_atomic_commit *state);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
index af3e32174563..e6e1c7235673 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c
@@ -60,21 +60,18 @@ struct vmw_legacy_display_unit {
 	struct list_head active;
 };
 
-static void vmw_ldu_destroy(struct vmw_legacy_display_unit *ldu)
-{
-	list_del_init(&ldu->active);
-	vmw_du_cleanup(&ldu->base);
-	kfree(ldu);
-}
-
-
 /*
  * Legacy Display Unit CRTC functions
  */
 
 static void vmw_ldu_crtc_destroy(struct drm_crtc *crtc)
 {
-	vmw_ldu_destroy(vmw_crtc_to_ldu(crtc));
+	struct vmw_legacy_display_unit *ldu = vmw_crtc_to_ldu(crtc);
+
+	list_del_init(&ldu->active);
+	vmw_vkms_crtc_cleanup(&ldu->base.crtc);
+	drm_crtc_cleanup(&ldu->base.crtc);
+	kfree(ldu);
 }
 
 static int vmw_ldu_commit_list(struct vmw_private *dev_priv)
@@ -264,29 +261,19 @@ static const struct drm_crtc_funcs vmw_legacy_crtc_funcs = {
  * Legacy Display Unit encoder functions
  */
 
-static void vmw_ldu_encoder_destroy(struct drm_encoder *encoder)
-{
-	vmw_ldu_destroy(vmw_encoder_to_ldu(encoder));
-}
-
 static const struct drm_encoder_funcs vmw_legacy_encoder_funcs = {
-	.destroy = vmw_ldu_encoder_destroy,
+	.destroy = drm_encoder_cleanup,
 };
 
 /*
  * Legacy Display Unit connector functions
  */
 
-static void vmw_ldu_connector_destroy(struct drm_connector *connector)
-{
-	vmw_ldu_destroy(vmw_connector_to_ldu(connector));
-}
-
 static const struct drm_connector_funcs vmw_legacy_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = vmw_ldu_connector_destroy,
+	.destroy = drm_connector_cleanup,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
 	.atomic_destroy_state = vmw_du_connector_destroy_state,
@@ -363,7 +350,7 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
 static const struct drm_plane_funcs vmw_ldu_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = vmw_du_primary_plane_destroy,
+	.destroy = drm_plane_cleanup,
 	.reset = vmw_du_plane_reset,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
@@ -492,18 +479,12 @@ static int vmw_ldu_init(struct vmw_private *dev_priv, unsigned unit)
 	encoder->possible_crtcs = (1 << unit);
 	encoder->possible_clones = 0;
 
-	ret = drm_connector_register(connector);
-	if (ret) {
-		DRM_ERROR("Failed to register connector\n");
-		goto err_free_encoder;
-	}
-
 	ret = drm_crtc_init_with_planes(dev, crtc, primary,
 		      vmw_cmd_supported(dev_priv) ? &cursor->base : NULL,
 		      &vmw_legacy_crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to initialize CRTC\n");
-		goto err_free_unregister;
+		goto err_free_encoder;
 	}
 
 	drm_crtc_helper_add(crtc, &vmw_ldu_crtc_helper_funcs);
@@ -526,8 +507,6 @@ static int vmw_ldu_init(struct vmw_private *dev_priv, unsigned unit)
 
 	return 0;
 
-err_free_unregister:
-	drm_connector_unregister(connector);
 err_free_encoder:
 	drm_encoder_cleanup(encoder);
 err_free_connector:
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index c83061cf7455..2c008892f51d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -97,20 +97,16 @@ struct vmw_screen_object_unit {
 	bool defined;
 };
 
-static void vmw_sou_destroy(struct vmw_screen_object_unit *sou)
-{
-	vmw_du_cleanup(&sou->base);
-	kfree(sou);
-}
-
-
 /*
  * Screen Object Display Unit CRTC functions
  */
-
 static void vmw_sou_crtc_destroy(struct drm_crtc *crtc)
 {
-	vmw_sou_destroy(vmw_crtc_to_sou(crtc));
+	struct vmw_screen_object_unit *sou = vmw_crtc_to_sou(crtc);
+
+	vmw_vkms_crtc_cleanup(&sou->base.crtc);
+	drm_crtc_cleanup(&sou->base.crtc);
+	kfree(sou);
 }
 
 /*
@@ -319,29 +315,19 @@ static const struct drm_crtc_funcs vmw_screen_object_crtc_funcs = {
  * Screen Object Display Unit encoder functions
  */
 
-static void vmw_sou_encoder_destroy(struct drm_encoder *encoder)
-{
-	vmw_sou_destroy(vmw_encoder_to_sou(encoder));
-}
-
 static const struct drm_encoder_funcs vmw_screen_object_encoder_funcs = {
-	.destroy = vmw_sou_encoder_destroy,
+	.destroy = drm_encoder_cleanup,
 };
 
 /*
  * Screen Object Display Unit connector functions
  */
 
-static void vmw_sou_connector_destroy(struct drm_connector *connector)
-{
-	vmw_sou_destroy(vmw_connector_to_sou(connector));
-}
-
 static const struct drm_connector_funcs vmw_sou_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = vmw_sou_connector_destroy,
+	.destroy = drm_connector_cleanup,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
 	.atomic_destroy_state = vmw_du_connector_destroy_state,
@@ -755,7 +741,7 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 static const struct drm_plane_funcs vmw_sou_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = vmw_du_primary_plane_destroy,
+	.destroy = drm_plane_cleanup,
 	.reset = vmw_du_plane_reset,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
@@ -881,18 +867,12 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
 	encoder->possible_crtcs = (1 << unit);
 	encoder->possible_clones = 0;
 
-	ret = drm_connector_register(connector);
-	if (ret) {
-		DRM_ERROR("Failed to register connector\n");
-		goto err_free_encoder;
-	}
-
 	ret = drm_crtc_init_with_planes(dev, crtc, primary,
 					&cursor->base,
 					&vmw_screen_object_crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to initialize CRTC\n");
-		goto err_free_unregister;
+		goto err_free_encoder;
 	}
 
 	drm_crtc_helper_add(crtc, &vmw_sou_crtc_helper_funcs);
@@ -910,8 +890,6 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
 
 	return 0;
 
-err_free_unregister:
-	drm_connector_unregister(connector);
 err_free_encoder:
 	drm_encoder_cleanup(encoder);
 err_free_connector:
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 9deeee9b92da..eb3f64d2f54c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -133,12 +133,6 @@ struct vmw_screen_target_display_unit {
 	unsigned int cpp;
 };
 
-
-
-static void vmw_stdu_destroy(struct vmw_screen_target_display_unit *stdu);
-
-
-
 /******************************************************************************
  * Screen Target Display Unit CRTC Functions
  *****************************************************************************/
@@ -150,7 +144,11 @@ static void vmw_stdu_destroy(struct vmw_screen_target_display_unit *stdu);
  */
 static void vmw_stdu_crtc_destroy(struct drm_crtc *crtc)
 {
-	vmw_stdu_destroy(vmw_crtc_to_stdu(crtc));
+	struct vmw_screen_target_display_unit *stdu = vmw_crtc_to_stdu(crtc);
+
+	vmw_vkms_crtc_cleanup(&stdu->base.crtc);
+	drm_crtc_cleanup(&stdu->base.crtc);
+	kfree(stdu);
 }
 
 /**
@@ -806,23 +804,8 @@ static const struct drm_crtc_funcs vmw_stdu_crtc_funcs = {
  * Screen Target Display Unit Encoder Functions
  *****************************************************************************/
 
-/**
- * vmw_stdu_encoder_destroy - cleans up the STDU
- *
- * @encoder: used the get the containing STDU
- *
- * vmwgfx cleans up crtc/encoder/connector all at the same time so technically
- * this can be a no-op.  Nevertheless, it doesn't hurt of have this in case
- * the common KMS code changes and somehow vmw_stdu_crtc_destroy() doesn't
- * get called.
- */
-static void vmw_stdu_encoder_destroy(struct drm_encoder *encoder)
-{
-	vmw_stdu_destroy(vmw_encoder_to_stdu(encoder));
-}
-
 static const struct drm_encoder_funcs vmw_stdu_encoder_funcs = {
-	.destroy = vmw_stdu_encoder_destroy,
+	.destroy = drm_encoder_cleanup,
 };
 
 
@@ -831,21 +814,6 @@ static const struct drm_encoder_funcs vmw_stdu_encoder_funcs = {
  * Screen Target Display Unit Connector Functions
  *****************************************************************************/
 
-/**
- * vmw_stdu_connector_destroy - cleans up the STDU
- *
- * @connector: used to get the containing STDU
- *
- * vmwgfx cleans up crtc/encoder/connector all at the same time so technically
- * this can be a no-op.  Nevertheless, it doesn't hurt of have this in case
- * the common KMS code changes and somehow vmw_stdu_crtc_destroy() doesn't
- * get called.
- */
-static void vmw_stdu_connector_destroy(struct drm_connector *connector)
-{
-	vmw_stdu_destroy(vmw_connector_to_stdu(connector));
-}
-
 static enum drm_mode_status
 vmw_stdu_connector_mode_valid(struct drm_connector *connector,
 			      const struct drm_display_mode *mode)
@@ -916,7 +884,7 @@ static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = vmw_stdu_connector_destroy,
+	.destroy = drm_connector_cleanup,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
 	.atomic_destroy_state = vmw_du_connector_destroy_state,
@@ -1482,7 +1450,7 @@ vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
 static const struct drm_plane_funcs vmw_stdu_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = vmw_du_primary_plane_destroy,
+	.destroy = drm_plane_cleanup,
 	.reset = vmw_du_plane_reset,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
@@ -1616,18 +1584,12 @@ static int vmw_stdu_init(struct vmw_private *dev_priv, unsigned unit)
 	encoder->possible_crtcs = (1 << unit);
 	encoder->possible_clones = 0;
 
-	ret = drm_connector_register(connector);
-	if (ret) {
-		DRM_ERROR("Failed to register connector\n");
-		goto err_free_encoder;
-	}
-
 	ret = drm_crtc_init_with_planes(dev, crtc, primary,
 					&cursor->base,
 					&vmw_stdu_crtc_funcs, NULL);
 	if (ret) {
 		DRM_ERROR("Failed to initialize CRTC\n");
-		goto err_free_unregister;
+		goto err_free_encoder;
 	}
 
 	drm_crtc_helper_add(crtc, &vmw_stdu_crtc_helper_funcs);
@@ -1645,8 +1607,6 @@ static int vmw_stdu_init(struct vmw_private *dev_priv, unsigned unit)
 
 	return 0;
 
-err_free_unregister:
-	drm_connector_unregister(connector);
 err_free_encoder:
 	drm_encoder_cleanup(encoder);
 err_free_connector:
@@ -1656,23 +1616,6 @@ static int vmw_stdu_init(struct vmw_private *dev_priv, unsigned unit)
 	return ret;
 }
 
-
-
-/**
- *  vmw_stdu_destroy - Cleans up a vmw_screen_target_display_unit
- *
- *  @stdu:  Screen Target Display Unit to be destroyed
- *
- *  Clean up after vmw_stdu_init
- */
-static void vmw_stdu_destroy(struct vmw_screen_target_display_unit *stdu)
-{
-	vmw_du_cleanup(&stdu->base);
-	kfree(stdu);
-}
-
-
-
 /******************************************************************************
  * Screen Target Display KMS Functions
  *
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 7b8163b5e501..c223766ca900 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -294,12 +294,8 @@ vmw_vkms_crtc_init(struct drm_crtc *crtc)
 void
 vmw_vkms_crtc_cleanup(struct drm_crtc *crtc)
 {
-	struct vmw_private *vmw = vmw_priv(crtc->dev);
 	struct vmw_display_unit *du = vmw_crtc_to_du(crtc);
 
-	if (vmw->vkms_enabled)
-		drm_crtc_vblank_cancel_timer(crtc);
-
 	if (du->vkms.surface)
 		vmw_surface_unreference(&du->vkms.surface);
 	WARN_ON(work_pending(&du->vkms.crc_generator_work));
-- 
2.54.0

