Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DA1CD484E
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 00:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C789F10E94C;
	Tue, 12 May 2026 00:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="QWzbEvlE";
	dkim-atps=neutral
Received: from mail-yx1-f98.google.com (mail-yx1-f98.google.com
 [74.125.224.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A788F10E94C
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 00:26:01 +0000 (UTC)
Received: by mail-yx1-f98.google.com with SMTP id
 956f58d0204a3-651bf695701so5298404d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778545560; x=1779150360;
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xQDb8dcdbwfEIRSjFtSRBEJ11zCKqYu50NEG8uTsg14=;
 b=s/Z6gNtY53swtwObb7ulDIi+BU7TCoTDx7zRq7DJj/JNiVqzmf1BS2lQMvYv8qHKJp
 3gjxVe82yH+JfBnRBTZqyY6W/gYd/ijAFQ9vc6IkFZ5TW69PGAPT4H/8Jz7bcN84KnWX
 jbS2BEm753weWMPl1XDLPi28FjrbP00EiH0Oc1Br1D5+tvBIY6TDmKvbGChioPJ4+6b3
 2j6971gTZFuDL7+kttHrurp/wKAWNq1cE774Lu7wEBcVetBepyLzhzSIlU1U2LpciEG0
 10f8xqMWycBLsEu0UnF7Q//ncki0IsJsbmX4UGH1QFENzZHPHuPyQPcAdQ9FKj/O+ILR
 KcHA==
X-Gm-Message-State: AOJu0YxgiPh/pej6W4mK/j4tJ07l0IWLBGxbHhpQ3SOSbsXyEyKJDxMB
 xFrH29QQzGNUEq0Z+W3Ikx+FuTx5GVcFPRtZzv3hMrwyzq4xrdR9579yARmC7VBEk7ZTIw6A1g7
 DHdTboPo19Fz5Oz5RBX/XWI1pAEsD2lx/V7H8oGi8R9ZazlW2U9Nj6WCIZFpb6PAs2N6IQG87fN
 Lwbxwiw+XXoRlzUYqL04JcUetpntcGj+id9q+trezJ4Xh9nZOt/NM4CUvSXKH6N8d0OqOsdXbSV
 Ly74eUvM9wC5LywKlyWUqNsCoLJ
X-Gm-Gg: Acq92OHjRd1VDiOXRHS9eNM9TTkk+MEXDVcNT4q3jAn28Spes+Fej8ALwxMUPP1/lMp
 DJ4emXGBxrUfQdXfHXhw9Wp0ShZ2zMz4B2v9JLCJgKXwp/JLRe9N80scF2gZcZy/5pyZ36uaZdD
 KaFMMksCz/cFcpL/Vm9wxhd7JZmdc5M38R2NSmrj7LoSPm5FaRxgxZ4VbsMI+YmSPGB4OxeFf1f
 LS4BrWCQVxA0rQhjERdf6pMWpAXoS6oYDnfIAjHRPz1pzJF8MhcyGITuyXishIsx0FjBxaEQ6Zp
 coKDl3400+2eUlscvCkoQXc51EckV8Kz7PyWA5j8hjm380LJkzGPWE0eAMviAUNk0Y+Ax7bEykP
 vZIeH6KYTQ29hOrTW/mhrEo4Nqu+jb/fDxYIhOc3CrUt5BicBV3jH9ZXuCJq41JMvhDNzm9jrmG
 mT1CLT7r0oH7OC67hC878rodxtgtVVaDlJoL2CwwtwUZBnfdg54vVJeMC6D+IKcQ==
X-Received: by 2002:a05:690e:1485:b0:654:acd4:9c10 with SMTP id
 956f58d0204a3-65de0fda20cmr673771d50.13.1778545560234; 
 Mon, 11 May 2026 17:26:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 956f58d0204a3-65d96beaa16sm952045d50.28.2026.05.11.17.25.59
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 May 2026 17:26:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-132a99125f8so692077c88.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 17:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1778545559; x=1779150359;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:reply-to:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xQDb8dcdbwfEIRSjFtSRBEJ11zCKqYu50NEG8uTsg14=;
 b=QWzbEvlEGN8zCccu9Ur9892fbxZSIJog4gFYwo1Jg3rPcbVRc/F0+mhRSuAj1MkLle
 7yJox1PWc+Op0jHE+H6v01uy2q2n/deTa0UkKR+vUd9l7ErXV6KHg6mf/aHLV0/Wadh2
 vnrx3MDlvOgHKLngGy7tfRIwW/HiUcHF62kr4=
X-Received: by 2002:a05:7022:128e:b0:11b:f056:a19b with SMTP id
 a92af1059eb24-13344d5aecdmr619110c88.18.1778545558864; 
 Mon, 11 May 2026 17:25:58 -0700 (PDT)
X-Received: by 2002:a05:7022:128e:b0:11b:f056:a19b with SMTP id
 a92af1059eb24-13344d5aecdmr619095c88.18.1778545558140; 
 Mon, 11 May 2026 17:25:58 -0700 (PDT)
Received: from mombasawalam-Precision-5820-Tower.cap.broadcom.net
 ([192.19.50.250]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327821fd00sm20395488c88.8.2026.05.11.17.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 17:25:57 -0700 (PDT)
From: Maaz Mombasawala <maaz.mombasawala@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, ian.forbes@broadcom.com,
 zack.rusin@broadcom.com, Maaz Mombasawala <maaz.mombasawala@broadcom.com>
Subject: [PATCH v2 5/5] drm/vmwgfx: Remove duplicates in vmwgfx_bo.h
Date: Mon, 11 May 2026 17:27:52 -0700
Message-ID: <20260512002752.2826685-6-maaz.mombasawala@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
References: <20260512002752.2826685-1-maaz.mombasawala@broadcom.com>
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
index f2abaf1bda6a..6fbc4c321158 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.h
@@ -127,7 +127,6 @@ struct vmw_res_func;
  * resource destruction.
  */
 struct vmw_bo;
-struct vmw_bo;
 struct vmw_resource_dirty;
 struct vmw_resource {
 	struct kref kref;
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
index 121a4f006804..230dd9c281a2 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -1967,7 +1967,7 @@ int vmw_connector_get_modes(struct drm_connector *connector)
 struct vmw_user_object *vmw_user_object_ref(struct vmw_user_object *uo)
 {
 	if (uo->buffer)
-		vmw_user_bo_ref(uo->buffer);
+		vmw_bo_reference(uo->buffer);
 	else if (uo->surface)
 		vmw_surface_reference(uo->surface);
 	return uo;
@@ -1976,7 +1976,7 @@ struct vmw_user_object *vmw_user_object_ref(struct vmw_user_object *uo)
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

