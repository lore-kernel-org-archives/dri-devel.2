Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D581ACD37AF
	for <dri-devel@archiver.kernel.org>; Sun, 10 May 2026 10:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9D3710E638;
	Sun, 10 May 2026 10:07:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fjH2Gn48";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2097810E02D
 for <dri-devel@lists.freedesktop.org>; Sun, 10 May 2026 05:30:37 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2baef9f5ecdso15245835ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 22:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778391036; x=1778995836; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HiZtT3KiED6Ar39Wsw4WFRof7QOLYq294txhwcfCtho=;
 b=fjH2Gn48kJu+pUIuCrwtfu10ooDgE5tzmcU51DcnbdvkdYnJjLBaTQsFkMRKGVtlAv
 bZDgsDQVPn0qAOTm0jx41BrFvF9cyEsZap8KuZYylvKKmYcMNZG2sk3MRQP6i7YY+xly
 pQUBa6B7Emsco9CO0NYi1Tv5hyZjdjYAMqcYywpABGZfpWCtImks+xOcd3ruO4JcASRv
 ytjE5uXcTU/GzLZ6JfsqxSz2ki7Ab8fMfDxaa57ysAuVX7DGqJcYgEYf92AXcL8tt7+a
 nxGD5+hn/eucO4FZI3claO1B3Gnttw3Ik8KWgIdFMQBXvTdo+JmM6S2iwwbwgLtm+7rS
 PuOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778391036; x=1778995836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HiZtT3KiED6Ar39Wsw4WFRof7QOLYq294txhwcfCtho=;
 b=LKoEisX2pPqEmk2+/PyIWfjQsmFwxt4eCsu7j5s3iJC0wNNY1WAB39SURVwIVbKkrt
 A/9AxuIE36UoO9DSDEGxJaGEF6jbOPVN9tp5paFe66I8t3YWLXSWw3KKVGVWhx5klrIl
 Pe8v/2u5X1mpiHgWr+K0O6eyMrnBgzJPnjv2jxh2Z9lgv18HPQxbvvgs10JYh9s/DvhR
 8Vcr4y+TDSyypiEqbHbg3+1bQVogbmk2hvp5jzQAo2ylpPH21A+I9R88u3byhE7l1lyi
 T6b9eA/KOSKfjaglReLzqcP1ZREFfeW542MVSbzCayyM0iJkBzylQ+xaJOl4GnP2AzLZ
 wviQ==
X-Gm-Message-State: AOJu0YxxgNLPfonOdtomxUGsiHrx4++JXHil4x/nslicXG8YE12eHxyx
 R8i6xSS1aDknA7ypRVt88N9RBAL24u0h7tVtrcckhMAkUBi3qBmgHdhy
X-Gm-Gg: Acq92OFetEpoI9LPWAuUHGcD2tPvNAq5q8DvJzCNVJY4nA4ZHBmX4i8mnLr48x+aUJq
 ZvfJLEfb6usBqpyQ125BUk8RRl3bWjE9sAp33uqmq/C7s5+Sr6ffH6jpcod6fcnK6JNxDCL1mzo
 f3/pJvaZagrlF7vlPQ7SWiUnT87ZV2v2HsM+bWUvKJsoSdn0ylcEz6hPD1w6ii3QHWDe4oW6INW
 kNKzyc7DYLnyDjxORGZB+XpaOIEjFhf/5QoOuZadaSmezzbSFi09MolZbeJoUil//gujpyZogPl
 YSZELkemgzheNYPx4l8Fx8iuhhnIdOkVXwc/GQwsGvHbU68qvm67O4fqhBC9WbmqAjMLUK8UIxo
 bNgOFbHZwao1sxaIgCh+ra8F7bx8850hEcbA6G5pefN4+SkDlHxJZUYxddiVCGzm2VjLWz+jhTK
 U052ZPIhfOZsYBsEAIi9Tfs9QJVAwJmPZg8GdGOkT8rjfNGtePyx1aymTlSsDIYRoQfgfCnw7OC
 DwQDXA=
X-Received: by 2002:a17:903:388c:b0:2ba:307:4584 with SMTP id
 d9443c01a7336-2bc7aa40967mr50895195ad.32.1778391036502; 
 Sat, 09 May 2026 22:30:36 -0700 (PDT)
Received: from deepanshu-kernel-hacker..
 ([2405:201:682f:383f:5d23:3a35:10d1:5ed6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ebea72sm67859095ad.77.2026.05.09.22.30.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 22:30:36 -0700 (PDT)
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
Subject: [PATCH] drm/virtio: check virtio_gpu_array_lock_resv() return in
 cursor update
Date: Sun, 10 May 2026 11:00:25 +0530
Message-ID: <20260510053025.100224-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 May 2026 10:07:04 +0000
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

virtio_gpu_cursor_plane_update() calls virtio_gpu_array_lock_resv()
but ignores its return value. The function can fail in two ways:

  - dma_resv_lock_interruptible() returns -ERESTARTSYS when a signal
    is delivered while waiting for the reservation lock.
  - dma_resv_reserve_fences() returns -ENOMEM if it fails to allocate
    a fence slot; in this case lock_resv unlocks before returning.

In both cases the resv lock is not held on return. The cursor path
proceeds to queue a fenced transfer command. The queue path then
walks the object array and calls dma_resv_add_fence() on the cursor
BO's reservation. dma_resv_add_fence() requires the resv lock to be
held; with lockdep enabled the missing lock trips
dma_resv_assert_held():

  WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
  Call Trace:
   virtio_gpu_array_add_fence+0xcd/0x140
   virtio_gpu_queue_ctrl_sgs
   virtio_gpu_queue_fenced_ctrl_buffer+0x578/0xfb0
   virtio_gpu_cursor_plane_update+0x411/0xbc0
   drm_atomic_helper_commit_planes+0x497/0xf10
   ...
   drm_mode_cursor_ioctl+0xd4/0x110
   drm_ioctl+0x5e6/0xc60
   __x64_sys_ioctl+0x18e/0x210

Beyond the WARN, mutating the dma_resv fence list without the lock
races with concurrent readers/writers and can corrupt the list.

Check the return value of virtio_gpu_array_lock_resv(). On failure,
drop the references taken by virtio_gpu_array_add_obj() with
virtio_gpu_array_put_free() (which does not unlock, matching the
not-locked state) and return without queueing the command. A
skipped cursor frame is harmless; the WARN and the underlying race
are not.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_plane.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index a126d1b25f46..ca379b08b9ec 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -459,7 +459,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_array_lock_resv(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.43.0

