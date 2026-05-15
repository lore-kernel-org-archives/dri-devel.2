Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20766CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:41:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E7C10E6E0;
	Mon, 18 May 2026 07:41:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IBmNKkQC";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ABB610F48F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:40:42 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-368763a1bdfso3788114a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 01:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778834442; x=1779439242; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BcNd3ITFWzMqmrli28Wy6nyBCrJ36rIyJ26nJuqd1AM=;
 b=IBmNKkQCEPS+zXg26IOU58tTXkH1mnTFn18ycsr9QmPGckt4JBiOFzM0spGGmfUhjZ
 SFh4b1nWbSjawRnYwmX6NV5Ov03PmsY5pLG4g73GIWUsEebp4fjZdTeDcXIDIU9Eza/y
 A6V4W8tq4DwcneDmk4BkzlNfF6hL7v0fsY4v8Xf/TR9pMefLJd9y/iI59ZyMqM5em8Hq
 zxhKXemXlqa53bnSud1x86jKH579FxN/lZv8pdAnlHN5nP2cwAtjpHRqrP3fMGSk92Ru
 YxuZsnZicIsaRwker8oYbcdqdIqaAKi9Iwo10BZjaa7NWqQ5HemSBRqyZuLWb7hMwWrU
 FkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778834442; x=1779439242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcNd3ITFWzMqmrli28Wy6nyBCrJ36rIyJ26nJuqd1AM=;
 b=eTKJgFGKVuZ9DyOvVYsSLf0gwfc5pyCz0ULF8g7FB0BmUAaYPIKiC5w70gKaMkeeQf
 KbfFwRRA92IXsEKXtWiuVraWcSpfr84hPb05BtNkj6JQ3Y5QrRrr4aytY2HAgpuSrew/
 LlWoiCnoIu02lA4RnUcy5tIyGlc+LKjhmbP9TT1pYcNnrLDks94pG8oOo4XEE5fqVX9D
 Wb6UrS8U4izDjCkCM/rd6mZGaxf4D509222cRUfwWVoAu9PvQ8xbVjUczZj93ApoWJeU
 FLdEKZcvKobYvJQIRNm1NdpNK1ZD/XfdVVTEYeu8lK2LqhWYpLY6pBNh3AOCZSYv+yp5
 tHSw==
X-Gm-Message-State: AOJu0YyJ0nS/3OH6hH4MlvCPGF/oQYEyocuiJ7JPcgO3UWzBf4bgdaHO
 jrTa+o9zsiMm5+x9XqvYwtzuX/CmaUQUtM//BPYhW9B2x+MuBC3AL7DP
X-Gm-Gg: Acq92OGLD3YbQARnXpHNZTnq2PM5qlI4eLesDWmInUxBZCoiVBac492gtZl/ZzvqJiH
 w5AmTU+AxLkOR2FjhovklN957wTY1RxEnT/KBLjwG5lrEOh/3QaY8iRQjGKc976L/F0m4Pn0Ni1
 vL/PeV3vcl5cJIaiw49wgxE8Qcrhd7BCIURrunj33p4o41l/IopifmhDK9W/YI2BFy1/6kcCNVy
 CJtAJqas+nE/AajfBhnmtGacatrTYP84O34dxUiE2vssU/YWBYNUeTCSH7kdodZ0bcEAJgns8BO
 fXvpM1Sp6vdzOpI2YpuGOYHXzJT5sHp4MY/x2MQnESbXcNxxG2ebQE3j2WSJDHV8GJw4NAECHz0
 iu5e5VchNUxK/UeRqQIKDs4Uc73QM6KMn8Ct0AXk86IARSEih7w9+67aTagXwHmN5tyHopS4BWu
 d0R/vY5wVsuAn9bHSlbI8TDHzSMNu2WnbS9RW2dtuLYC2EAg8Wwt0rf5ix3EdynNpm7/F61CHEj
 GugpKA=
X-Received: by 2002:a17:90b:134b:b0:368:78da:803 with SMTP id
 98e67ed59e1d1-36951a01748mr3017625a91.12.1778834441878; 
 Fri, 15 May 2026 01:40:41 -0700 (PDT)
Received: from deepanshu-kernel-hacker..
 ([2405:201:682f:383f:ad23:b1a5:6537:1208])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36956535742sm637091a91.3.2026.05.15.01.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 01:40:41 -0700 (PDT)
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
Subject: [PATCH v3] drm/virtio: use uninterruptible resv lock for plane updates
Date: Fri, 15 May 2026 14:10:30 +0530
Message-ID: <20260515084030.21986-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush() lock
the framebuffer BO's dma_resv via virtio_gpu_array_lock_resv() and
ignore its return value. The function can fail with -EINTR from
dma_resv_lock_interruptible() (signal during lock wait) or with
-ENOMEM from dma_resv_reserve_fences() (fence slot allocation),
leaving the resv lock not held. The queue path then walks the object
array and calls dma_resv_add_fence(), which requires the lock held;
with lockdep enabled this trips dma_resv_assert_held():

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

Both call sites run inside the .atomic_update plane callback, which
DRM atomic helpers do not allow to fail (by the time it runs, the
commit has been signed off to userspace and there is no clean
rollback path). Moving the lock acquisition to .prepare_fb (v2) was
rejected because the broader lock scope deadlocks against other
BO locking paths in the same atomic commit.

Introduce virtio_gpu_array_lock_resv_uninterruptible() that uses
dma_resv_lock() instead of dma_resv_lock_interruptible() on the
nents==1 path. This eliminates the -EINTR failure mode -- the
realistic syzbot trigger -- without extending the lock hold across
the commit. Use it from both virtio_gpu_cursor_plane_update() and
virtio_gpu_resource_flush(); check the return value to handle the
remaining -ENOMEM case by freeing the objs and skipping the plane
update for that frame. The framebuffer BOs touched here are not
shared with other contexts and lock contention is expected to be
brief, so the loss of signal-interruptibility is acceptable.

Other callers of virtio_gpu_array_lock_resv() (the ioctl paths)
continue to use the interruptible variant.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v3: Per maintainer feedback on v2 (lockup caused by the broader
    lock scope in prepare_fb conflicting with other BO locking in
    the same atomic commit): drop the prepare_fb/cleanup_fb
    approach, introduce an uninterruptible variant of
    virtio_gpu_array_lock_resv(), and use it in both
    virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush().
v2: Move resv lock acquisition from .atomic_update (which must not
    fail) to .prepare_fb (which may), per maintainer review of v1.
    The previous approach of silently skipping the cursor update on
    lock failure violated the atomic-commit contract with userspace.
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++--
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f17660a71a3e..43a7eb568e15 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -317,6 +317,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index f22dc5c21cd4..08c4b7ef8d44 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -238,6 +238,30 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 	return ret;
 }
 
+int virtio_gpu_array_lock_resv_uninterruptible(struct virtio_gpu_object_array *objs)
+{
+	unsigned int i;
+	int ret = 0;
+
+	if (objs->nents == 1) {
+		dma_resv_lock(objs->objs[0]->resv, NULL);
+	} else {
+		ret = drm_gem_lock_reservations(objs->objs, objs->nents,
+						&objs->ticket);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < objs->nents; ++i) {
+		ret = dma_resv_reserve_fences(objs->objs[i]->resv, 1);
+		if (ret) {
+			virtio_gpu_array_unlock_resv(objs);
+			return ret;
+		}
+	}
+	return 0;
+}
+
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
 {
 	if (objs->nents == 1) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..ef118cb4f0fa 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -215,7 +215,10 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_array_lock_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
 					      width, height, objs,
 					      vgplane_st->fence);
@@ -459,7 +462,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_array_lock_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.43.0

