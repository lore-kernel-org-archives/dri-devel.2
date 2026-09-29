Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36229CA5FA7
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:22:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D54810ED74;
	Tue, 29 Sep 2026 08:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UDec8Oir";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6D9F10ED17
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 07:07:22 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso36236445e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790665641; x=1791270441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0kjavUluxIdj8vslb6mPPnH9lKklEmbuVjVAK6jlaIw=;
 b=UDec8OirfmH2ZqFq2/bRbFVp/nRjjqCAgZjCF4pt34luPV0C32N0T4KK/tmo/j12H8
 UN5CfRQ1g8SYLrVdioC0qvkCiSeafKVz4NI1fUhENen2xsIeRKb9//JE/o7BDYX1H5Kb
 S/ToqClherWu8Zvo3aB7Fc74/SPBB4M4TdGx7ZhdtgIh4t/FthV5blRvBd1LLD5n5bLU
 JxgQvNd3Fu3twOEzfKAfe4RXtEKT0Lvr+QYARW+yMTlq0R6wuv6b5/3ezl9TKF0wiJWu
 vnz3XjRHOLB4ib2cFAtBVb8XHaVKumgHtVBqb6wBFe8LXnYWX4ITZVNSbLaERNb4Q8JZ
 XJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790665641; x=1791270441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0kjavUluxIdj8vslb6mPPnH9lKklEmbuVjVAK6jlaIw=;
 b=ajRoBqZRE01KNk3Pp3XRCnT6oEy0Vxl/DjbLA6U2YOJy28pTG2y7aJyhY8zHPtLAoM
 D8jK6gyAIuKDAsMnFIJc0jHZwXVQnNfzeppn9bR7p+j8UKgNZFF0dTjaeSWgM1KS7mmz
 BVgQ+BnGkqpkETB+tNkP9d+pBNnEo8Ja9Edh822G9UkgvzjzNlQ+3N1Gl8mhlCWFYabY
 yrQgo02wLDm/D175gfxvKde3tsW0st5x9c4k8pEDLgCQgFBfKF8KD6i5DyzMw1E8LZqP
 +/l/jEoVcVYKqoLG9/2iekVoMVp0HTLVNtgw3w7vnOfEsR88eVJl0DX7uXuO3fdICQnG
 Xc0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzI2a8XaCEuPDmJ6wXVt+J9c4ErIrzSDS0VbvB+YoQ0ZbtU2KiMUPUFMl7pLUtnf4lmV6qBfybCQ64=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nn3/Wzstv8Uz6ZXRyrI2TgtIgnTXoWUFqtCd6hPYt7jvaG6l4x
 gH50mmMeVspfCGwOcq0kw77ElJJGAJdmFd4ekfyrIRv9dqX60HzBTNVQ
X-Gm-Gg: AYBFou1nmRJZfjUgGYaYd8lTn4QCa2siBhJ4wLvuzBjbQ92DgFHDJGvZplK6j6sqFdj
 oB0lS0E5ktasJDr45spJHrF7Oppzm0mTAXJFPiKbuLRF55l725iz9edn/pvjMuBnqm5/VYpBPaI
 xSKw3iQdDtQVzBr0s3pa4G1SvlgHUiS5pFgD43gUw6IQcEUxbCtlM1Dlmc6nJbHDbtgX4LY+xHi
 v8FnuNVuK6sR5MXAhQ8LBZuWcfrVA/VZyd2ze6Ph5GKPk6FxfatMBgqT2MZ5hWAt1IHzJRrAMmw
 ngZZzOZDIij1cIM3WJuFNLua5YKi/bhTB3I6R/C7cZwSUcdkYoJ2AsJGk2vmW+FuLX3A8Ec51Z1
 u9wUcZZIjQACIbut126vW8uWEeIyT7Ql3LoLwxTtyZlNrv6I8zIdfHb02egKzGOWFhF/hEkgoN4
 SltOzQser7JBoX+tDvlWjHecefNSfK9CRb9q0VqLbBgZ7ynWVoVNWC6DTt9gpYv471Ix6myXDXm
 iIxxeu5Q+kXbYNz6NZ52cmgh6aSGRwmEzQ6pHdimuMFLD50QOPoQIpsvXWqcOrgDu0=
X-Received: by 2002:a05:600c:3556:b0:49f:bd3c:bc24 with SMTP id
 5b1f17b1804b1-49fe6708a46mr262115795e9.31.1790665640767; 
 Tue, 29 Sep 2026 00:07:20 -0700 (PDT)
Received: from f3a6eae2255e.fritz.box
 (dynamic-002-214-017-137.2.214.pool.telefonica.de. [2.214.17.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfec770sm57919625e9.8.2026.09.29.00.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:07:20 -0700 (PDT)
From: Abhin Parekadan Jose <abhinjoses@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Dongwon Kim <dongwon.kim@intel.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com,
 Abhin Parekadan Jose <abhinjoses@gmail.com>
Subject: [PATCH] drm/virtio: Destroy obj_restore_lock on the final
 drm_dev_put()
Date: Tue, 29 Sep 2026 07:07:14 +0000
Message-ID: <20260929070714.169412-1-abhinjoses@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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

virtio_gpu_deinit() calls mutex_destroy() on obj_restore_lock, but
deinit runs from virtio_gpu_remove() at unbind or PCI remove, and GEM
objects can outlive that. An open /dev/fb0 keeps the fbdev buffer
alive, and the fbdev DRM client holds a drm_device reference. When the
fd is finally closed, the buffer is freed and takes the destroyed lock:

  fb_release()
    drm_fbdev_shmem_fb_destroy()
      drm_client_buffer_delete()
        virtio_gpu_free_object()
          virtio_gpu_remove_from_restore_list()
            mutex_lock(&vgdev->obj_restore_lock)

  DEBUG_LOCKS_WARN_ON(lock->magic != lock)
  WARNING: kernel/locking/mutex.c:625 at __mutex_lock+0xf2c/0x12ec

virtio_gpu_deinit() should only do hardware teardown in this case
related virtio, its queues and others. Software state that GEM callbacks
still use belongs in virtio_gpu_release(), which runs on the final
drm_dev_put().

There are two equivalent ways to tie the mutex lifetime to the
drm_device:

 1) Move mutex_destroy() from virtio_gpu_deinit() to the end of
    virtio_gpu_release(). This is what this patch does. It is the
    smallest change and keeps the teardown next to the rest of the
    final-put software cleanup.

 2) Initialise the lock with drmm_mutex_init() (checking its return
    value) and drop mutex_destroy() from virtio_gpu_deinit(), so DRM's
    managed release destroys it. This also covers the virtio_gpu_init()
    error path, where release returns early because dev_private is
    NULL. Skipping mutex_destroy() there is harmless, since it only
    matters for mutex debugging.

Either fix removes the WARN. Option 1 is sent as the smaller change,
and option 2 can be done instead if preferred.

Reproduced on arm64 QEMU (-device virtio-gpu-pci) with DEBUG_MUTEXES
and PROVE_LOCKING: open /dev/fb0, write 1 to
/sys/bus/pci/devices/0000:00:01.0/remove, then close the fd. With this
patch the WARN is gone, and rebinding brings back /dev/fb0 and
/dev/dri/card0.

Fixes: 54a970048296 ("drm/virtio: Add support for saving and restoring virtio_gpu_objects")
Reported-by: syzbot+3590d97d8a586fa955c2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3590d97d8a586fa955c2
Assisted-by: LLM
Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index 1d4d3bf46a20..0ec755c35050 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -354,7 +354,6 @@ void virtio_gpu_deinit(struct drm_device *dev)
 	virtio_reset_device(vgdev->vdev);
 	virtio_gpu_reclaim_vbufs(vgdev);
 	vgdev->vdev->config->del_vqs(vgdev->vdev);
-	mutex_destroy(&vgdev->obj_restore_lock);
 }
 
 void virtio_gpu_release(struct drm_device *dev)
@@ -370,6 +369,8 @@ void virtio_gpu_release(struct drm_device *dev)
 
 	if (vgdev->has_host_visible)
 		drm_mm_takedown(&vgdev->host_visible_mm);
+
+	mutex_destroy(&vgdev->obj_restore_lock);
 }
 
 int virtio_gpu_driver_open(struct drm_device *dev, struct drm_file *file)

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.51.1

