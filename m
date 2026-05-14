Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB19CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 22:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CCA10F36F;
	Thu, 14 May 2026 22:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="Qz5icPBh";
	dkim-atps=neutral
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com
 [209.85.210.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC8B810F368
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 22:46:15 +0000 (UTC)
Received: by mail-ot1-f99.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso4887626a34.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778798775; x=1779403575;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jf9h4NFwZHXmgYtzHkyOj8TESQz103LagxipZff/Qr4=;
 b=BQwHvd+cR2P7/zGvJ4Q7UCQihZdvx3q0q1IIhs6ErU7uQmqUeuphelYieb56I28JtO
 eIQJWuf5SocixNUwgHm2pn0IsfZJLWCB3uKrWgp2JvtDTSdH1gVKValyZas9nnasvSeH
 0GIBrhrFRodpG8UsiLXh8si4k2XkSXm4U+/AgHrfIPaDekHloz2PgIWjFGaschnlBT/n
 H/ZS8G4pC2yMtw+4dik2daKuR/CwCCVQLz2TOQ41YR/kQ0cqHt7dLy3KZiDILef0GAwT
 gOPhZk73qNfTNt7wRkKI5PAlFcLvONqqPibicIZ4rQMKHmXVsc3vpdlAbrMkOTXSfR0c
 gpmA==
X-Gm-Message-State: AOJu0YzIXWEEcRV4lzMxJXmqBzglIBeKqEWErq3tNE1z9EkyBVlenxgA
 SY6R9WC368ukFo4pCuLHnCKPOSUwNpNqfVrBl8S597vvw4BtcZnQsuEU6L+w5A0/8hKNock5/52
 OL3HDTGYMyzsdYfi69xEVRByfL/7NqRmGWp0HDUDXU6CQO9s+r9R8u2XL/Yu9gcBppkoEk8CqIq
 gr+aLAl+syMlhC3Tnf7Akq4zgeVDeClQjHWnogPKeVgZyn0+zXwH8zJEXBAqG5m5jvQrG1asq7w
 vg7DyRqpu18LiQrnb1lubpJROc1IKE=
X-Gm-Gg: Acq92OFDkZ8fO6mGlhCemvuBjelolGeP7nIZ3RoJHkCOSOI8mZp38cAS7EijYEP4/Zv
 HBXWAJSOdf/2Lg21000jViFI2YA3/3RglrD7H4PvEfsPRhN0pkubPBBJC1Srlwa7PZnf9byCok8
 lPuu5WaWwl6seBrTmbu01P7c16/osliVLffrhLE8bRIrT/MoZigdibCjrG2c8SA9jlpl6FxMFbZ
 z1X4sbaLJCqoD/5ZjO0vmyGS15lgOXi5ROj5VudgepAcvAW/bdvFtfM4/a6NkwKPCP6WzLadhc7
 23hLCZxZjTZ0OWfkNeE7EjDXXJfyxvSKP0Uvrhs5Gk+EQTrUgHVQTdL+xyjaRsp+TrfklKsc94e
 dZ5pSxo7IFuJMl//0nmhw52vjAKc+6hrpFWus9SEO1T3Ei8DQDDAptUm+KlX49Ropfva/V7oj1B
 VnYUuarIvH/PIpOAzagRiod8yKk3qFPV43F6DUuFWCAFy5XXdBSJWz12n6xyScWQ==
X-Received: by 2002:a05:6820:820:b0:696:17a7:498c with SMTP id
 006d021491bc7-69c9437a908mr920151eaf.30.1778798774804; 
 Thu, 14 May 2026 15:46:14 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-21.dlp.protect.broadcom.com. [144.49.247.21])
 by smtp-relay.gmail.com with ESMTPS id
 586e51a60fabf-439fc52f0fdsm289210fac.11.2026.05.14.15.46.14
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 May 2026 15:46:14 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ee34588671so11394501eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778798773; x=1779403573;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jf9h4NFwZHXmgYtzHkyOj8TESQz103LagxipZff/Qr4=;
 b=Qz5icPBhJqTbi9OSXVbQSOJebMbnas3ffXXJKxyIGzHofuFFTWoQ7rHZUhGCngVFwD
 HAiapx2VsngihlfavdIJ4BulSHDem4tzbzvOJIFi81tALwzk9Fbjp0x1u0XxWUxbP0JR
 TgRZVJGyQtE5mka5rP8VVpRKOAmcd25UclhPk=
X-Received: by 2002:a05:7022:922:b0:132:7ab5:6cb8 with SMTP id
 a92af1059eb24-13504311c97mr627151c88.2.1778798773189; 
 Thu, 14 May 2026 15:46:13 -0700 (PDT)
X-Received: by 2002:a05:7022:922:b0:132:7ab5:6cb8 with SMTP id
 a92af1059eb24-13504311c97mr627116c88.2.1778798772308; 
 Thu, 14 May 2026 15:46:12 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbdcf140sm6678737c88.5.2026.05.14.15.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 15:46:11 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v3 5/5] drm/vmwgfx: Remove duplicates in vmwgfx_bo.h
Date: Thu, 14 May 2026 15:48:19 -0700
Message-ID: <20260514224819.3631763-6-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
References: <20260514224819.3631763-1-maaz.mombasawala@broadcom.com>
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
Reply-To: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The vmw_user_bo_ref and vmw_user_bo_unref functions are identical to
vmw_bo_reference and vmw_bo_unreference respectively, remove them.

Signed-off-by: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.h       | 15 ---------------
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c  |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h      |  1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c  |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c      |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c  |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_prime.c    |  2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 12 ++++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c   |  4 ++--
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c  |  6 +++---
 11 files changed, 21 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
index 6817e0b8ce99..4071190408b5 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.c
@@ -539,7 +539,7 @@ static int vmw_user_bo_synccpu_release(struct drm_file *filp,
 		if (!(flags & drm_vmw_synccpu_allow_cs)) {
 			atomic_dec(&vmw_bo->cpu_writers);
 		}
-		vmw_user_bo_unref(&vmw_bo);
+		vmw_bo_unreference(&vmw_bo);
 	}
 
 	return ret;
@@ -581,7 +581,7 @@ int vmw_user_bo_synccpu_ioctl(struct drm_device *dev, void *data,
 			return ret;
 
 		ret = vmw_user_bo_synccpu_grab(vbo, arg->flags);
-		vmw_user_bo_unref(&vbo);
+		vmw_bo_unreference(&vbo);
 		if (unlikely(ret != 0)) {
 			if (ret == -ERESTARTSYS || ret == -EBUSY)
 				return -EBUSY;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
index cf84a163bfcb..f3c2cfb42588 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_bo.h
@@ -213,21 +213,6 @@ static inline struct vmw_bo *vmw_bo_reference(struct vmw_bo *buf)
 	return buf;
 }
 
-static inline struct vmw_bo *vmw_user_bo_ref(struct vmw_bo *vbo)
-{
-	drm_gem_object_get(&vbo->tbo.base);
-	return vbo;
-}
-
-static inline void vmw_user_bo_unref(struct vmw_bo **buf)
-{
-	struct vmw_bo *tmp_buf = *buf;
-
-	*buf = NULL;
-	if (tmp_buf)
-		drm_gem_object_put(&tmp_buf->tbo.base);
-}
-
 static inline struct vmw_bo *to_vmw_bo(struct drm_gem_object *gobj)
 {
 	return container_of((gobj), struct vmw_bo, tbo.base);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
index 091f1039a052..9c882e746e3c 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c
@@ -502,7 +502,7 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 
 	vmw_resource_mob_attach(res);
 	/* Let go of the old mob. */
-	vmw_user_bo_unref(&old_buf);
+	vmw_bo_unreference(&old_buf);
 	res->id = vcotbl->type;
 
 	ret = dma_resv_reserve_fences(bo->base.resv, 1);
@@ -521,7 +521,7 @@ static int vmw_cotable_resize(struct vmw_resource *res, size_t new_size)
 out_wait:
 	ttm_bo_unpin(bo);
 	ttm_bo_unreserve(bo);
-	vmw_user_bo_unref(&buf);
+	vmw_bo_unreference(&buf);
 
 out_done:
 	MKS_STAT_TIME_POP(MKSSTAT_KERN_COTABLE_RESIZE);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
index 38bea8abab84..812f1224f83e 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -96,7 +96,6 @@ struct vmwgfx_hash_item {
 
 struct vmw_res_func;
 
-struct vmw_bo;
 struct vmw_bo;
 struct vmw_resource_dirty;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
index e1f18020170a..f3fd45f28140 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c
@@ -1148,7 +1148,7 @@ static int vmw_translate_mob_ptr(struct vmw_private *dev_priv,
 	vmw_bo_placement_set(vmw_bo, VMW_BO_DOMAIN_MOB, VMW_BO_DOMAIN_MOB);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
 	tmp_bo = vmw_bo;
-	vmw_user_bo_unref(&tmp_bo);
+	vmw_bo_unreference(&tmp_bo);
 	if (unlikely(ret != 0))
 		return ret;
 
@@ -1205,7 +1205,7 @@ static int vmw_translate_guest_ptr(struct vmw_private *dev_priv,
 			     VMW_BO_DOMAIN_GMR | VMW_BO_DOMAIN_VRAM);
 	ret = vmw_validation_add_bo(sw_context->ctx, vmw_bo);
 	tmp_bo = vmw_bo;
-	vmw_user_bo_unref(&tmp_bo);
+	vmw_bo_unreference(&tmp_bo);
 	if (unlikely(ret != 0))
 		return ret;
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 4db29b645a38..6bd83e49885b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1968,7 +1968,7 @@ int vmw_connector_get_modes(struct drm_connector *connector)
 struct vmw_user_object *vmw_user_object_ref(struct vmw_user_object *uo)
 {
 	if (uo->buffer)
-		vmw_user_bo_ref(uo->buffer);
+		vmw_bo_reference(uo->buffer);
 	else if (uo->surface)
 		vmw_surface_reference(uo->surface);
 	return uo;
@@ -1977,7 +1977,7 @@ struct vmw_user_object *vmw_user_object_ref(struct vmw_user_object *uo)
 void vmw_user_object_unref(struct vmw_user_object *uo)
 {
 	if (uo->buffer)
-		vmw_user_bo_unref(&uo->buffer);
+		vmw_bo_unreference(&uo->buffer);
 	else if (uo->surface)
 		vmw_surface_unreference(&uo->surface);
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
index 679adf7c7183..d4a1cd50c325 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c
@@ -451,7 +451,7 @@ int vmw_overlay_ioctl(struct drm_device *dev, void *data,
 
 	ret = vmw_overlay_update_stream(dev_priv, buf, arg, true);
 
-	vmw_user_bo_unref(&buf);
+	vmw_bo_unreference(&buf);
 
 out_unlock:
 	mutex_unlock(&overlay->mutex);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
index 598b90ac7590..6abeb1ee1f8f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_prime.c
@@ -117,7 +117,7 @@ int vmw_prime_handle_to_fd(struct drm_device *dev,
 								 handle, flags,
 								 prime_fd);
 		}
-		vmw_user_bo_unref(&vbo);
+		vmw_bo_unreference(&vbo);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index 388011696941..1391bed79f7b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -143,7 +143,7 @@ static void vmw_resource_release(struct kref *kref)
 		if (res->coherent)
 			vmw_bo_dirty_release(res->guest_memory_bo);
 		ttm_bo_unreserve(bo);
-		vmw_user_bo_unref(&res->guest_memory_bo);
+		vmw_bo_unreference(&res->guest_memory_bo);
 	}
 
 	if (likely(res->hw_destroy != NULL)) {
@@ -315,7 +315,7 @@ int vmw_user_object_lookup(struct vmw_private *dev_priv,
 							    uo->buffer,
 							    handle);
 		if (uo->surface)
-			vmw_user_bo_unref(&uo->buffer);
+			vmw_bo_unreference(&uo->buffer);
 	}
 
 	return ret;
@@ -466,11 +466,11 @@ void vmw_resource_unreserve(struct vmw_resource *res,
 			vmw_resource_mob_detach(res);
 			if (res->coherent)
 				vmw_bo_dirty_release(res->guest_memory_bo);
-			vmw_user_bo_unref(&res->guest_memory_bo);
+			vmw_bo_unreference(&res->guest_memory_bo);
 		}
 
 		if (new_guest_memory_bo) {
-			res->guest_memory_bo = vmw_user_bo_ref(new_guest_memory_bo);
+			res->guest_memory_bo = vmw_bo_reference(new_guest_memory_bo);
 
 			/*
 			 * The validation code should already have added a
@@ -560,7 +560,7 @@ vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 	drm_gem_object_put(&val_buf->bo->base);
 	val_buf->bo = NULL;
 	if (guest_memory_dirty)
-		vmw_user_bo_unref(&res->guest_memory_bo);
+		vmw_bo_unreference(&res->guest_memory_bo);
 
 	return ret;
 }
@@ -736,7 +736,7 @@ int vmw_resource_validate(struct vmw_resource *res, bool intr,
 		goto out_no_validate;
 	else if (!res->func->needs_guest_memory && res->guest_memory_bo) {
 		WARN_ON_ONCE(vmw_resource_mob_attached(res));
-		vmw_user_bo_unref(&res->guest_memory_bo);
+		vmw_bo_unreference(&res->guest_memory_bo);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
index eca4e3e97eb4..ede4de9dc8b0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_shader.c
@@ -180,7 +180,7 @@ static int vmw_gb_shader_init(struct vmw_private *dev_priv,
 
 	res->guest_memory_size = size;
 	if (byte_code) {
-		res->guest_memory_bo = vmw_user_bo_ref(byte_code);
+		res->guest_memory_bo = vmw_bo_reference(byte_code);
 		res->guest_memory_offset = offset;
 	}
 	shader->size = size;
@@ -809,7 +809,7 @@ static int vmw_shader_define(struct drm_device *dev, struct drm_file *file_priv,
 				    shader_type, num_input_sig,
 				    num_output_sig, tfile, shader_handle);
 out_bad_arg:
-	vmw_user_bo_unref(&buffer);
+	vmw_bo_unreference(&buffer);
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
index 256e7b89daea..3525d1388f33 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_surface.c
@@ -972,7 +972,7 @@ static int vmw_buffer_prime_to_surface_base(struct vmw_private *dev_priv,
 
 	*base_p = base;
 out:
-	vmw_user_bo_unref(&bo);
+	vmw_bo_unreference(&bo);
 
 	return ret;
 }
@@ -1593,12 +1593,12 @@ vmw_gb_surface_define_internal(struct drm_device *dev,
 		if (ret == 0) {
 			if (res->guest_memory_bo->is_dumb) {
 				VMW_DEBUG_USER("Can't backup surface with a dumb buffer.\n");
-				vmw_user_bo_unref(&res->guest_memory_bo);
+				vmw_bo_unreference(&res->guest_memory_bo);
 				ret = -EINVAL;
 				goto out_unlock;
 			} else if (res->guest_memory_bo->tbo.base.size < res->guest_memory_size) {
 				VMW_DEBUG_USER("Surface backup buffer too small.\n");
-				vmw_user_bo_unref(&res->guest_memory_bo);
+				vmw_bo_unreference(&res->guest_memory_bo);
 				ret = -EINVAL;
 				goto out_unlock;
 			} else {
-- 
2.54.0

