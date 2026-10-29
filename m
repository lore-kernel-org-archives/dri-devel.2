Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B465660A261E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 16:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hO3mPhkJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE5B1112477;
	Thu, 29 Oct 2026 16:54:32 +0000 (UTC)
Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com
 [209.85.210.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A454112459
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 16:54:26 +0000 (UTC)
Received: by mail-pf1-f227.google.com with SMTP id
 d2e1a72fcca58-8a0880a46e7so665421b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793292866; x=1793897666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=guqN8L+wJ90DWa7rhPYEh5Wd1wQCdUdxW2JdkMgWnQY=;
 b=ilJOnD6vTFQD2tyfIATWwdcRu2gJuFeym8c9YJ4I+LCW0nnaqeZPEWx6O4M+zw1YLr
 ySO3dat2tcG+MoYX8uxG/jwzlbnLZQjqyGW+b+W962fjaRVidCcFNiHSwU5jJQ2H1qM8
 xjdTdibg4fL14OUsCO2JxAP6JIy848aTedng75E7zK7U88MzmGNXL58Pk/+ZftTrm+5e
 H6PxawUdXiTPQ+Aa0lmlnBXXwY46pdUZnZiqDPDUwaoOSfCMQTcEbaBBGu1ppgY1UgPe
 +4/B7b7dVacLBr2GCCbLb4WPpnHO620+ziVlSdI4QfoyVhB+sPYaJBJgR92xsmCzTCT7
 ZHNA==
X-Gm-Message-State: AFq9FYKctwW1632I/Kc4ttBvaQb6kt+6bb+heCiKqalxl4+amiXgfEm+
 1fKEcPlr4CPP0L2ldtXVnSkT/wrvFg5jd/DqhjoTvKwaniJWpVfoJxOwVaTgY9cxIYdyc/Uho0a
 TsakGlvtV1yGQHKZBTES6POHVJ5aa5SLBhJS2iqgHAFgG3vYIvYcLaLsqqSBvOANxhqnTin23Oz
 Cq2qnvxA9D4R5Zgskm8zX4HZlbj7wgeKVMoq87fTwrO4diLILrpCEgXZs4gWuFnuD9FQbVL2v/s
 S+fYINq+e5mCoBCyMBG
X-Gm-Gg: AYBFou3yiN9gVx80lI4pAcfcQotV6QdsO+a+VI3oXh9iOPDIyR4QcT39M9uTgnXMg9t
 bEhviAxH3lyH+UQ2ul7dYBPsubVJ3GSf2eZZMGDj6u6FJvr3Ivi2Q5KhcGvxHKTLS3l126S9Zbc
 /c79lO4cLGXVt+Kbhxiu+PjoNq/5ZtoN1yCMM4O3PNgpLZUGoO5js59jVMRByrp5RH58yYSWiGa
 nS412FL5sdWfCxN3T8QnpxzZAaqFzSCv3GCWGc1ckNYF8rymGQc/xXbaU+AjKKloaSys9GaAsja
 pN7wpzm+AqhQEdEH9AStw5mwa6NJT2xhVFpDOyu8XhQ/g9Klmjj8uT6NTf4kjs4ILEK/vyuo1L7
 x0pb2PgLWVd7U/dfB4k441xQF9pUjffVpAkGmjwauXZPN41z3yW/mdz+5+aRpot8byOClJrdhsu
 Pu3kMxytakKdjo0BbiTJnDwhgByB7T7nkE
X-Received: by 2002:a05:6a00:2449:b0:8a0:6417:8f9b with SMTP id
 d2e1a72fcca58-8a83279df94mr2144468b3a.32.1793292865564; 
 Thu, 29 Oct 2026 09:54:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-8a98c9f551bsm4767b3a.1.2026.10.29.09.54.25
 for <dri-devel@lists.freedesktop.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Oct 2026 09:54:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-36a26fe9521so922287eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1793292864; x=1793897664;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=guqN8L+wJ90DWa7rhPYEh5Wd1wQCdUdxW2JdkMgWnQY=;
 b=hO3mPhkJKoCdtDqiASzvIjnolHRCtwhRA2E+uwpDoW0SGEDwaTvNolM8s8J5TNmswn
 bI58lBcukH9xKeHO/LvhBJEqpI00BoNiszJggwUdFPyDTIMeL4UuC29HZSi+avLqJd93
 tZzFrDPeaQMqkK+z7MqIhWsFlgXuqlTDpkdUM=
X-Received: by 2002:a05:7022:628d:b0:184:40db:6bb9 with SMTP id
 a92af1059eb24-1a94876dbd0mr5647147c88.8.1793292863221; 
 Thu, 29 Oct 2026 09:54:23 -0700 (PDT)
X-Received: by 2002:a05:7022:628d:b0:184:40db:6bb9 with SMTP id
 a92af1059eb24-1a94876dbd0mr5647083c88.8.1793292862254; 
 Thu, 29 Oct 2026 09:54:22 -0700 (PDT)
Received: from plasma.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a4104b2cesm423020eec.11.2026.10.29.09.54.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 09:54:21 -0700 (PDT)
From: Ian Forbes <ian.forbes@broadcom.com>
To: dri-devel@lists.freedesktop.org
Cc: bcm-kernel-feedback-list@broadcom.com, zack.rusin@broadcom.com,
 maaz.mombasawala@broadcom.com, Ian Forbes <ian.forbes@broadcom.com>
Subject: [PATCH] drm/vmwgfx: Remove fence event code
Date: Thu, 29 Oct 2026 11:54:17 -0500
Message-ID: <20261029165417.249123-1-ian.forbes@broadcom.com>
X-Mailer: git-send-email 2.56.0
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

The last vmwgfx internal use of this code was removed in commit
2e10cdc6e85d ("drm/vmwgfx: Remove explicit and broken vblank handling")

The vmw_fence_event ioctl was introduced in commit
57c5ee79acba ("vmwgfx: Add fence events") which claimed it would be used
by the xf86-video-vmware Xorg driver but the git history shows that it was
never used in that driver; nor was it used by mesa.

Remove this code as we've had a number of bug reports related to it.

Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 241 +-------------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.h |   6 -
 2 files changed, 1 insertion(+), 246 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 384c6736cf6b..004ed060cf54 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -23,27 +23,6 @@ struct vmw_user_fence {
 	struct vmw_fence_obj fence;
 };
 
-/**
- * struct vmw_event_fence_action - fence callback that delivers a DRM event.
- *
- * @base:  For use with dma_fence_add_callback(...)
- * @event: A pointer to the pending event.
- * @dev: Pointer to a struct drm_device so we can access the event stuff.
- * @tv_sec: If non-null, the variable pointed to will be assigned
- * current time tv_sec val when the fence signals.
- * @tv_usec: Must be set if @tv_sec is set, and the variable pointed to will
- * be assigned the current time tv_usec val when the fence signals.
- */
-struct vmw_event_fence_action {
-	struct dma_fence_cb base;
-
-	struct drm_pending_event *event;
-	struct drm_device *dev;
-
-	uint32_t *tv_sec;
-	uint32_t *tv_usec;
-};
-
 static struct vmw_fence_manager *
 fman_from_fence(struct vmw_fence_obj *fence)
 {
@@ -524,226 +503,8 @@ int vmw_fence_obj_unref_ioctl(struct drm_device *dev, void *data,
 					 arg->handle);
 }
 
-/**
- * vmw_event_fence_action_seq_passed
- *
- * @f: The struct dma_fence which provides timestamp for the action event
- * @cb: The struct dma_fence_cb callback for the action event.
- *
- * This function is called when the seqno of the fence has passed
- * and it is always called from atomic context.
- * It queues the event on the submitter's event list.
- */
-static void vmw_event_fence_action_seq_passed(struct dma_fence *f,
-					      struct dma_fence_cb *cb)
-{
-	struct vmw_event_fence_action *eaction =
-		container_of(cb, struct vmw_event_fence_action, base);
-	struct drm_device *dev = eaction->dev;
-	struct drm_pending_event *event = eaction->event;
-
-	if (unlikely(event == NULL))
-		return;
-
-	spin_lock_irq(&dev->event_lock);
-
-	if (likely(eaction->tv_sec != NULL)) {
-		struct timespec64 ts;
-
-		ts = ktime_to_timespec64(f->timestamp);
-		/* monotonic time, so no y2038 overflow */
-		*eaction->tv_sec = ts.tv_sec;
-		*eaction->tv_usec = ts.tv_nsec / NSEC_PER_USEC;
-	}
-
-	drm_send_event_locked(dev, eaction->event);
-	eaction->event = NULL;
-	spin_unlock_irq(&dev->event_lock);
-	dma_fence_put(f);
-	kfree(eaction);
-}
-
-/**
- * vmw_event_fence_action_queue - Post an event for sending when a fence
- * object seqno has passed.
- *
- * @file_priv: The file connection on which the event should be posted.
- * @fence: The fence object on which to post the event.
- * @event: Event to be posted. This event should've been alloced
- * using k[mz]alloc, and should've been completely initialized.
- * @tv_sec: If non-null, the variable pointed to will be assigned
- * current time tv_sec val when the fence signals.
- * @tv_usec: Must be set if @tv_sec is set, and the variable pointed to will
- * be assigned the current time tv_usec val when the fence signals.
- * @interruptible: Interruptible waits if possible.
- *
- * As a side effect, the object pointed to by @event may have been
- * freed when this function returns. If this function returns with
- * an error code, the caller needs to free that object.
- */
-
-int vmw_event_fence_action_queue(struct drm_file *file_priv,
-				 struct vmw_fence_obj *fence,
-				 struct drm_pending_event *event,
-				 uint32_t *tv_sec,
-				 uint32_t *tv_usec,
-				 bool interruptible)
-{
-	struct vmw_event_fence_action *eaction;
-	struct vmw_fence_manager *fman = fman_from_fence(fence);
-
-	eaction = kzalloc_obj(*eaction);
-	if (unlikely(!eaction))
-		return -ENOMEM;
-
-	eaction->event = event;
-	eaction->dev = &fman->dev_priv->drm;
-	eaction->tv_sec = tv_sec;
-	eaction->tv_usec = tv_usec;
-
-	vmw_fence_obj_reference(fence); // Dropped in CB
-	if (dma_fence_add_callback(&fence->base, &eaction->base,
-				   vmw_event_fence_action_seq_passed) < 0)
-		vmw_event_fence_action_seq_passed(&fence->base, &eaction->base);
-	return 0;
-}
-
-struct vmw_event_fence_pending {
-	struct drm_pending_event base;
-	struct drm_vmw_event_fence event;
-};
-
-static int vmw_event_fence_action_create(struct drm_file *file_priv,
-				  struct vmw_fence_obj *fence,
-				  uint32_t flags,
-				  uint64_t user_data,
-				  bool interruptible)
-{
-	struct vmw_event_fence_pending *event;
-	struct vmw_fence_manager *fman = fman_from_fence(fence);
-	struct drm_device *dev = &fman->dev_priv->drm;
-	int ret;
-
-	event = kzalloc_obj(*event);
-	if (unlikely(!event)) {
-		DRM_ERROR("Failed to allocate an event.\n");
-		ret = -ENOMEM;
-		goto out_no_space;
-	}
-
-	event->event.base.type = DRM_VMW_EVENT_FENCE_SIGNALED;
-	event->event.base.length = sizeof(event->event);
-	event->event.user_data = user_data;
-
-	ret = drm_event_reserve_init(dev, file_priv, &event->base, &event->event.base);
-
-	if (unlikely(ret != 0)) {
-		DRM_ERROR("Failed to allocate event space for this file.\n");
-		kfree(event);
-		goto out_no_space;
-	}
-
-	if (flags & DRM_VMW_FE_FLAG_REQ_TIME)
-		ret = vmw_event_fence_action_queue(file_priv, fence,
-						   &event->base,
-						   &event->event.tv_sec,
-						   &event->event.tv_usec,
-						   interruptible);
-	else
-		ret = vmw_event_fence_action_queue(file_priv, fence,
-						   &event->base,
-						   NULL,
-						   NULL,
-						   interruptible);
-	if (ret != 0)
-		goto out_no_queue;
-
-	return 0;
-
-out_no_queue:
-	drm_event_cancel_free(dev, &event->base);
-out_no_space:
-	return ret;
-}
-
 int vmw_fence_event_ioctl(struct drm_device *dev, void *data,
 			  struct drm_file *file_priv)
 {
-	struct vmw_private *dev_priv = vmw_priv(dev);
-	struct drm_vmw_fence_event_arg *arg =
-		(struct drm_vmw_fence_event_arg *) data;
-	struct vmw_fence_obj *fence = NULL;
-	struct vmw_fpriv *vmw_fp = vmw_fpriv(file_priv);
-	struct ttm_object_file *tfile = vmw_fp->tfile;
-	struct drm_vmw_fence_rep __user *user_fence_rep =
-		(struct drm_vmw_fence_rep __user *)(unsigned long)
-		arg->fence_rep;
-	uint32_t handle;
-	int ret;
-
-	/*
-	 * Look up an existing fence object,
-	 * and if user-space wants a new reference,
-	 * add one.
-	 */
-	if (arg->handle) {
-		struct ttm_base_object *base =
-			vmw_fence_obj_lookup(tfile, arg->handle);
-
-		if (IS_ERR(base))
-			return PTR_ERR(base);
-
-		fence = &(container_of(base, struct vmw_user_fence,
-				       base)->fence);
-		(void) vmw_fence_obj_reference(fence);
-
-		if (user_fence_rep != NULL) {
-			ret = ttm_ref_object_add(vmw_fp->tfile, base,
-						 NULL, false);
-			if (unlikely(ret != 0)) {
-				DRM_ERROR("Failed to reference a fence "
-					  "object.\n");
-				goto out_no_ref_obj;
-			}
-			handle = base->handle;
-		}
-		ttm_base_object_unref(&base);
-	}
-
-	/*
-	 * Create a new fence object.
-	 */
-	if (!fence) {
-		ret = vmw_execbuf_fence_commands(file_priv, dev_priv,
-						 &fence,
-						 (user_fence_rep) ?
-						 &handle : NULL);
-		if (unlikely(ret != 0)) {
-			DRM_ERROR("Fence event failed to create fence.\n");
-			return ret;
-		}
-	}
-
-	BUG_ON(fence == NULL);
-
-	ret = vmw_event_fence_action_create(file_priv, fence,
-					    arg->flags,
-					    arg->user_data,
-					    true);
-	if (unlikely(ret != 0)) {
-		if (ret != -ERESTARTSYS)
-			DRM_ERROR("Failed to attach event to fence.\n");
-		goto out_no_create;
-	}
-
-	vmw_execbuf_copy_fence_user(dev_priv, vmw_fp, 0, user_fence_rep, fence,
-				    handle, -1);
-	vmw_fence_obj_unreference(&fence);
-	return 0;
-out_no_create:
-	if (user_fence_rep != NULL)
-		ttm_ref_object_base_unref(tfile, handle);
-out_no_ref_obj:
-	vmw_fence_obj_unreference(&fence);
-	return ret;
+	return -ENOTTY; // Never Used
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.h b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.h
index e897cccae1ae..24d7b279ca4b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.h
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.h
@@ -101,10 +101,4 @@ extern int vmw_fence_obj_unref_ioctl(struct drm_device *dev, void *data,
 				     struct drm_file *file_priv);
 extern int vmw_fence_event_ioctl(struct drm_device *dev, void *data,
 				 struct drm_file *file_priv);
-extern int vmw_event_fence_action_queue(struct drm_file *filee_priv,
-					struct vmw_fence_obj *fence,
-					struct drm_pending_event *event,
-					uint32_t *tv_sec,
-					uint32_t *tv_usec,
-					bool interruptible);
 #endif /* _VMWGFX_FENCE_H_ */
-- 
2.56.0

