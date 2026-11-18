Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE260A2603
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=a20Wmb++
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B7910FFEB;
	Wed, 18 Nov 2026 20:09:57 +0000 (UTC)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4400E10FFEB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:09:51 +0000 (UTC)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3adac5b29ebso919231a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795032591; x=1795637391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ziOQXduvjKa2Jv0YUc0g84WkcfJmG683K02Srp3e1XM=;
 b=ExrYVjzPU6jmd75FY6TdCG4+lpmtb7PYb9LZuld1iuj+pdPkcH/IYcKX89q44ligk8
 OshYaFPK0TpH4cx5FVkwElHuqVYTpa1fFER82mQmYDCibTU6wdSXVYr2jkTGEOcG82Ln
 EZSaWM25FuQCE+AiTqutd/YQHR7OxYklUIcc3On1YX+kr391PtVwqh1KZMN/3YX1bjXG
 1YZbR3houSKuCz0+VkdPcaiwDVfYhIfL8klEE+12JQD2+WXBYdMrVVzSsoVVIA6bAzwY
 vLuDjOlBGFgyeiUhPQnnqnSoclgvSeRZ1CqZl0y/cddTMYMEfa6yorXFZaqqr/wDLo3k
 xNXw==
X-Gm-Message-State: APuU4Z/gfU3X7SEQbgT+xZ6EhWuhqQJc4Hza7QUWDXpmiPIfIUSoLrd3
 19RBEaIzH6FAi2lW5cs6O8hJTK0QER2ZNUJULAWM4SrK3KHf4PwoZmxD+wPZl9JgDNzS04uzw0i
 fIyXXjQHp0Co0UjktTfThPGmjWN/IifAAsTCLXrddThW+nVxkospy7mZZMYRjSsc45W4BJuQu4Y
 7HGCRh9Woop0eMNZOeUg3A+z3gjqm047iQ9qcelzatQ/beeZABPUx0cxJnQz6AFIKsa8t3IDTUI
 mpTFnMR+CMjwi4LepJR
X-Gm-Gg: AZFdTZdfbaSetOVtGD3SZv1YUXK7bmLvyyvIwJlbXa5qMmWKsrLh12vo+e1t7vd6sR0
 s/uq/QXM/zJEdKxzdTTKE4uIEAKpdj1r6DuhkUfKffkmI1Hb/FaRA2HuwlRrE3kf2VEDli3NIRQ
 STdkjTu4a01uYLjzw+sUV6pgC09TY4pAaLb/m6ZTKK3uf+v+K25xQ5Z5A1s+80uBW57uXepjeUt
 YUAiMuFUGhW0Q9aDZDYTyyI1vpNK9BhOrgQTt10wKGED6rk13uwHdela3LsemU+065eBiw+8pqQ
 UmnHrRRn12ftDMDBqqL79VCfFIP9ZDved+9AsF7dqEDaq2/MlINApa2pjKxmTTJVZDUzdfQ2+eX
 8bThMqO90RO8lFk2VfTbPCqgMIQOLA4gEjxLIjl+ziU5hmtq9iiygJsoSt8jWzvg9Qj7hYQeNj+
 Nh27evx8b9J73xbC3rba5P2uLOzMSohcy+
X-Received: by 2002:a17:90b:4fc5:b0:3ae:a4fe:7ad4 with SMTP id
 98e67ed59e1d1-3b3d06417c7mr3624426a91.2.1795032590664; 
 Wed, 18 Nov 2026 12:09:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-26.dlp.protect.broadcom.com. [144.49.247.26])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b3f6e01d7fsm370700a91.3.2026.11.18.12.09.50
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Nov 2026 12:09:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f26dd2165so383820285a.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1795032589; x=1795637389;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ziOQXduvjKa2Jv0YUc0g84WkcfJmG683K02Srp3e1XM=;
 b=a20Wmb++FpgsFieBhxvXFleyhG9+WPGF8GOdlDVUzV7iOJOTW0VgYu8vlanLZ2GA3a
 HC7zBTx7fIRCwnUV2WZIXOaoqT3IGOVe3vNKZByoKQrXcwQi7ik08mRA0mx3Pa/KHRo/
 cGutjpEpxi2TjpUnbZ2tc3chDOIrXI0BYRwis=
X-Received: by 2002:a05:620a:2a06:b0:949:6fd4:354d with SMTP id
 af79cd13be357-949994b40f7mr700225585a.8.1795032589368; 
 Wed, 18 Nov 2026 12:09:49 -0800 (PST)
X-Received: by 2002:a05:620a:2a06:b0:949:6fd4:354d with SMTP id
 af79cd13be357-949994b40f7mr700218485a.8.1795032588707; 
 Wed, 18 Nov 2026 12:09:48 -0800 (PST)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm262134785a.11.2026.11.18.12.09.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:09:48 -0800 (PST)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH v2] drm/vmwgfx: Fix Display Unit cleanup
Date: Wed, 18 Nov 2026 14:08:32 -0600
Message-ID: <20261118200942.573456-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20260528162527.1280708-1-ian.forbes@broadcom.com>
References: <20260528162527.1280708-1-ian.forbes@broadcom.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

v2:
 - rebase

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c  | 24 ---------
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  4 --
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  | 41 ++++-----------
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c | 40 ++++-----------
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 75 ++++------------------------
 5 files changed, 28 insertions(+), 156 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index fed844ccd789..4613963076f8 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -34,30 +34,6 @@ void vmw_du_init(struct vmw_display_unit *du)
 						     BIT(DRM_MODE_BLEND_PREMULTI));
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
index 5085d8bccf0a..1373003c25d7 100644
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
index a7828b8ed68e..92080a3b4013 100644
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
@@ -265,29 +262,19 @@ static const struct drm_crtc_funcs vmw_legacy_crtc_funcs = {
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
@@ -364,7 +351,7 @@ vmw_ldu_primary_plane_atomic_update(struct drm_plane *plane,
 static const struct drm_plane_funcs vmw_ldu_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = vmw_du_primary_plane_destroy,
+	.destroy = drm_plane_cleanup,
 	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
@@ -493,18 +480,12 @@ static int vmw_ldu_init(struct vmw_private *dev_priv, unsigned unit)
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
@@ -527,8 +508,6 @@ static int vmw_ldu_init(struct vmw_private *dev_priv, unsigned unit)
 
 	return 0;
 
-err_free_unregister:
-	drm_connector_unregister(connector);
 err_free_encoder:
 	drm_encoder_cleanup(encoder);
 err_free_connector:
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
index bc6c200f5129..d286b4841d8d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c
@@ -98,20 +98,16 @@ struct vmw_screen_object_unit {
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
@@ -321,29 +317,19 @@ static const struct drm_crtc_funcs vmw_screen_object_crtc_funcs = {
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
@@ -757,7 +743,7 @@ vmw_sou_primary_plane_atomic_update(struct drm_plane *plane,
 static const struct drm_plane_funcs vmw_sou_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = vmw_du_primary_plane_destroy,
+	.destroy = drm_plane_cleanup,
 	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
@@ -883,18 +869,12 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
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
@@ -912,8 +892,6 @@ static int vmw_sou_init(struct vmw_private *dev_priv, unsigned unit)
 
 	return 0;
 
-err_free_unregister:
-	drm_connector_unregister(connector);
 err_free_encoder:
 	drm_encoder_cleanup(encoder);
 err_free_connector:
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index 08b32babc1cd..422a16c1aea9 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -134,12 +134,6 @@ struct vmw_screen_target_display_unit {
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
@@ -151,7 +145,11 @@ static void vmw_stdu_destroy(struct vmw_screen_target_display_unit *stdu);
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
@@ -808,23 +806,8 @@ static const struct drm_crtc_funcs vmw_stdu_crtc_funcs = {
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
 
 
@@ -833,21 +816,6 @@ static const struct drm_encoder_funcs vmw_stdu_encoder_funcs = {
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
@@ -918,7 +886,7 @@ static const struct drm_connector_funcs vmw_stdu_connector_funcs = {
 	.dpms = vmw_du_connector_dpms,
 	.detect = vmw_du_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = vmw_stdu_connector_destroy,
+	.destroy = drm_connector_cleanup,
 	.reset = vmw_du_connector_reset,
 	.atomic_duplicate_state = vmw_du_connector_duplicate_state,
 	.atomic_destroy_state = vmw_du_connector_destroy_state,
@@ -1484,7 +1452,7 @@ vmw_stdu_crtc_atomic_flush(struct drm_crtc *crtc,
 static const struct drm_plane_funcs vmw_stdu_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
-	.destroy = vmw_du_primary_plane_destroy,
+	.destroy = drm_plane_cleanup,
 	.atomic_create_state = vmw_du_plane_create_state,
 	.atomic_duplicate_state = vmw_du_plane_duplicate_state,
 	.atomic_destroy_state = vmw_du_plane_destroy_state,
@@ -1618,18 +1586,12 @@ static int vmw_stdu_init(struct vmw_private *dev_priv, unsigned unit)
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
@@ -1647,8 +1609,6 @@ static int vmw_stdu_init(struct vmw_private *dev_priv, unsigned unit)
 
 	return 0;
 
-err_free_unregister:
-	drm_connector_unregister(connector);
 err_free_encoder:
 	drm_encoder_cleanup(encoder);
 err_free_connector:
@@ -1658,23 +1618,6 @@ static int vmw_stdu_init(struct vmw_private *dev_priv, unsigned unit)
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
-- 
2.56.1

