Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E36DCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E41710ED2A;
	Wed, 13 May 2026 07:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rYlYnkxM";
	dkim-atps=neutral
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2B9810E231
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 02:07:32 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8353c9f24d2so2595942b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 19:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778551652; x=1779156452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/QiKU/+m/deMkZnUgiMPX7icRFO8sAPHl3F/zxCh9ig=;
 b=rYlYnkxMz/9j5Pwx94OmbIk/m3cnrVB1jp31xd6xE7vXu8yCgTZNgBisbRKmsAuwBd
 Wayzapr9Kp/NO/YK4ND7LjyofpWl1A9woN+mVdVg9tdp6uSsVfQQgI9sLM/NGtmzeojl
 KC6uhAM1sdxC+DXH/zJuuaE/ZajhyRLo1aClDNO+WIgiNl9tJSJu0J8/t+5485CmbqOE
 /DMuupLG7fYakALxo83KFHrk0f5mB2rl808w3bxW4WU9twc4+xdjYQjY/fKV39m1mHsH
 WJtPM2nWSFHHMKfh0TPMnPkSaGdxF0Z68qNTrnCN1hOCn+oFBuJVnNhF4ls8nf6CJPQ1
 y6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778551652; x=1779156452;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/QiKU/+m/deMkZnUgiMPX7icRFO8sAPHl3F/zxCh9ig=;
 b=OlvlS0D/K5bTTs9cjjQLu9Q3GF/lOmxU7LbKneeQSSDNK+BPJew9Jc05bcPl/46MVp
 120iVmdFNtAM2Nk7Uo/cL9g32LZMBk8v5dWER/X9KDW+VwLx9oSYTw/Lq4Ay2ycSFN0C
 6XMVFBRH7IDzH/kwglsgxLsSyxlGcKYrHh0Gn7Z+czTUBGPCvYdlecS50aEO5QTzgk7Y
 2DEd4t0k0MH1EDc7333gafEG2zUjSwGEPKUHCns74rsa2iGWMehIPtQ6wLLzSTk7qwPa
 AjNdy8HjS5NpGHSSoLQOXIvQKUdc5feBFlDJ9aOUSnGZUfDUU7w3SCzLxgY3QcjmPJND
 TSqQ==
X-Gm-Message-State: AOJu0YzzfcajpvgochXKeQi8jDT2a8LErNIR3HDFGEKEK5ORwiW22reA
 SlaUjTXCDhs8dmjR8MwCPYR5zuq55x+N3xd1Sbzg3c2a4WzbzfTPAFFp
X-Gm-Gg: Acq92OH7gP9Hi+ZLJUjo9vGvXlHgmBRbucglcobrmaFJDkJDwhjNLAxCJVhs24Cl4cD
 YelUeBlhpFzrXjX50i0olHcKfKF1dw6zNUHm7p3NMKO7vsW9gr7SuOrzRsFU0SbSLI1xQtO+sUe
 GAzF4TTueyR7wHfYAS/BOvXx2/FYNQAl8WRuaugipSH3giqF0ti0B/O/6J65FZl4UihMjz0BlFW
 Fe1P+T/iiDF7QCPdtgAudtFdHTU8xUT3jiCG15wqiM2jhkGw7GZI1UsoqKI8YxXQ3ou7BjTeCDJ
 Y8POTmJKUlvlKo7xKnqwRsovwUDsRNzT30JvZ+GOT2EA+rLuDpSAxELG5d+YK+yLWXAzozaF/qu
 3X8/Hc8Vq2sr08DquUSt0ZGnptizYZfT9V6XBk94e2aO/kQB9Uwuuq0g9KUSWdM0vmD0vokNObN
 V6KJ9liTiiqsTiGb8NdZkcXhDWZB/1EUNi7f2pyZyAs0XueBzaCTDhz/y3XWCiZVOI/JmjukFiD
 dLJdZs=
X-Received: by 2002:a05:6a00:ad8a:b0:82a:17b8:1474 with SMTP id
 d2e1a72fcca58-83eeb9f0e34mr977275b3a.1.1778551652212; 
 Mon, 11 May 2026 19:07:32 -0700 (PDT)
Received: from deepanshu-kernel-hacker..
 ([2405:201:682f:383f:b0ab:8219:937d:e207])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbf7d2sm28966425b3a.49.2026.05.11.19.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 19:07:31 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: airlied@redhat.com, kraxel@redhat.com, dmitry.osipenko@collabora.com,
 gurchetansingh@chromium.org, olvaffe@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 simona@ffwll.ch, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Deepanshu Kartikey <kartikey406@gmail.com>,
 syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/virtio: move cursor resv lock acquisition to prepare_fb
Date: Tue, 12 May 2026 07:37:18 +0530
Message-ID: <20260512020718.108044-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

virtio_gpu_cursor_plane_update() allocates a virtio_gpu_object_array,
locks its dma_resv, and queues a fenced transfer to the host. The
lock acquisition can fail in two ways:

  - dma_resv_lock_interruptible() returns -EINTR when a signal is
    delivered while waiting for the reservation lock.
  - dma_resv_reserve_fences() returns -ENOMEM if it fails to allocate
    a fence slot; in this case lock_resv unlocks before returning.

The return value was ignored, so the cursor path could proceed with
the resv lock not held. The queue path then walks the object array
and calls dma_resv_add_fence(), which requires the lock; with lockdep
enabled this trips dma_resv_assert_held():

  WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
  Call Trace:
   virtio_gpu_array_add_fence
   virtio_gpu_queue_ctrl_sgs
   virtio_gpu_queue_fenced_ctrl_buffer
   virtio_gpu_cursor_plane_update
   drm_atomic_helper_commit_planes
   drm_atomic_helper_commit_tail
   commit_tail
   drm_atomic_helper_commit
   drm_atomic_commit
   drm_atomic_helper_update_plane
   __setplane_atomic
   drm_mode_cursor_universal
   drm_mode_cursor_common
   drm_mode_cursor_ioctl
   drm_ioctl
   __x64_sys_ioctl

Beyond the WARN, mutating the dma_resv fence list without the lock
races with concurrent readers/writers and can corrupt the list.

The DRM atomic helpers do not allow .atomic_update to fail: by the
time it runs, the commit has been signed off to userspace and there
is no clean rollback path. Move the fallible work -- objs allocation,
dma_resv locking, and fence slot reservation -- into
virtio_gpu_plane_prepare_fb, which is the designated callback for
resource acquisition and may return errors that the framework
handles by rolling back the commit. Stash the prepared object array
on virtio_gpu_plane_state so the update step can consume it.

Make virtio_gpu_plane_cleanup_fb release the objs if the commit was
rolled back before update ran (i.e., objs not consumed). The queue
path already unlocks the resv after attaching the fence (vq.c:411)
and frees the array via put_free_delayed after host completion
(vq.c:271), so the update step only needs to clear vgplane_st->objs
to transfer ownership.

Simplify virtio_gpu_cursor_plane_update to a no-fail queue submission
that hands the prepared, locked objs to the queue path.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260510053025.100224-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2: Move resv lock acquisition from .atomic_update (which must not
    fail) to .prepare_fb (which may), per maintainer review of v1.
    The previous approach of silently skipping the cursor update on
    lock failure violated the atomic-commit contract with userspace.
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_plane.c | 38 ++++++++++++++++++++------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..e51f959dce46 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -198,6 +198,7 @@ struct virtio_gpu_framebuffer {
 struct virtio_gpu_plane_state {
 	struct drm_plane_state base;
 	struct virtio_gpu_fence *fence;
+	struct virtio_gpu_object_array *objs;
 };
 #define to_virtio_gpu_plane_state(x) \
 	container_of(x, struct virtio_gpu_plane_state, base)
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..b0511ace89e6 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -381,6 +381,23 @@ static int virtio_gpu_plane_prepare_fb(struct drm_plane *plane,
 			goto err_fence;
 	}
 
+	if (plane->type == DRM_PLANE_TYPE_CURSOR && bo->dumb) {
+		struct virtio_gpu_object_array *objs;
+
+		objs = virtio_gpu_array_alloc(1);
+		if (!objs) {
+			ret = -ENOMEM;
+			goto err_fence;
+		}
+		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
+		ret = virtio_gpu_array_lock_resv(objs);
+		if (ret) {
+			virtio_gpu_array_put_free(objs);
+			goto err_fence;
+		}
+		vgplane_st->objs = objs;
+	}
+
 	return 0;
 
 err_fence:
@@ -417,6 +434,12 @@ static void virtio_gpu_plane_cleanup_fb(struct drm_plane *plane,
 		vgplane_st->fence = NULL;
 	}
 
+	if (vgplane_st->objs) {
+		virtio_gpu_array_unlock_resv(vgplane_st->objs);
+		virtio_gpu_array_put_free(vgplane_st->objs);
+		vgplane_st->objs = NULL;
+	}
+
 	obj = state->fb->obj[0];
 	if (drm_gem_is_imported(obj))
 		virtio_gpu_cleanup_imported_obj(obj);
@@ -452,21 +475,18 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 	}
 
 	if (bo && bo->dumb && (plane->state->fb != old_state->fb)) {
-		/* new cursor -- update & wait */
-		struct virtio_gpu_object_array *objs;
-
-		objs = virtio_gpu_array_alloc(1);
-		if (!objs)
-			return;
-		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		/* objs and fence were prepared in virtio_gpu_plane_prepare_fb;
+		 * the resv is already locked. The queue path takes ownership
+		 * of objs and unlocks the resv after attaching the fence.
+		 */
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
 			 plane->state->crtc_h,
-			 0, 0, objs, vgplane_st->fence);
+			 0, 0, vgplane_st->objs, vgplane_st->fence);
 		virtio_gpu_notify(vgdev);
 		dma_fence_wait(&vgplane_st->fence->f, true);
+		vgplane_st->objs = NULL;
 	}
 
 	if (plane->state->fb != old_state->fb) {
-- 
2.43.0

