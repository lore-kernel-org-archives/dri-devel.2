Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB0CCA5FA1
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7954D10E84D;
	Mon, 28 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Axo52xk1";
	dkim-atps=neutral
Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com
 [74.125.227.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55A010E0C2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 04:07:02 +0000 (UTC)
Received: by mail-pj2-f40.google.com with SMTP id
 98e67ed59e1d1-3a0f64df6a6so210650a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 21:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790482022; x=1791086822; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7z9jyGFvSNyPE4j90ojKfCFxGEKOnKcOHIMpedzYh5o=;
 b=Axo52xk1zekoWaTkNUDDKxAFl4o/mOmqfrf+qknLfp/zVERVmp6EaMzmKqbkCi6odz
 vQ3J+tBnFR69zB/nSlW8Z69pX1ez0PWXkechezTR/pRjhBvGoqx8vrjdkEkbe19B/FM+
 7OJuKurchBGmN+gCzTVKp5tAi0zUSkM3zI1hDiVYSkF6FTuiQQlYYjP0QqxOezB/cE14
 L+XqykOaJdILimQk/ZlcNUeX9+vFDjPD+gD4vaEEN7J8MM0skxpkDeG1qdJjQ6Hv76oz
 bb/o6JZIN43GD2q2klOg505IUV2loINN3vZkP7HpbapIIhbZKITxOQQp3AM9YWq2ZR71
 Y4Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790482022; x=1791086822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7z9jyGFvSNyPE4j90ojKfCFxGEKOnKcOHIMpedzYh5o=;
 b=0WOBejxQCmPFI5COYxoELLfbaYx3A+iu2/PEKzDYsLo2q/ghYsFawvjL5F264uOBy0
 UYC/xWYOrlldSaib17ldaRoQwcVQNruFqraNpxJIZWOXabsE1/7uUgH9k/Vo6Ah8tNgo
 QPJLXSs81LOLQ953Adq8UaDpKPWTcbU9daYtGChFiMssDWkUQyg3/UM/NItu7kzTONuN
 bdug0gY1xoSG3Edmllzlq7kJ2YllZjLry3JoU6MX0qhiUYT9dC7MOKb4ZG6eQ+Dmzvwa
 xlwq5z82IdQQ1fdTm+r+c+8LKy/ot0wCdboJkC3NaNq4j9Ow8UAybgDovDe90559YZ1r
 bZ6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx5qm5KysAj4fw31vD5gSl9uTwOzFGbqoWjt14MmPCPOB/jPm/j1416CzdqFYRIvT7zwDS2aga5f4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIeMdhcJjmMVs2k7L2o9ID80tFUgO41YC08wra0fbF83vGG413m
 l4hdRTDn1kWdYEZfAPaCljuLtAmVtzEbymXxbU9FRjy72PexM3dsYiVhyjMdqw==
X-Gm-Gg: AYBFou1lqm4HCRyWYDzpdPHfQum4hLwoNrogkGH7pd1Y/f7Wr+62qYcfCkHyJORK8nt
 DASzZEvvEfnucrkSa241Cm+f7TjjQm+qZDP5otWKaFP5MbexaX65+JDrb+4y3zsbeBpmXhK4P5Q
 lBi3soxRqQV3x7Oa7bCgrSmkO75/6tXsuYuZncTXUaHXKS0taCxIuUSuLERIEF0WeQwjggrmOrE
 u3U+xBKbWbhbIF5laLNzWiw8UgyFv+AIU8PMeq2BzRSL/mim5qeyf8YH9vZk2ViGf4RymL3Cysv
 peFKcKPG79olY5IQHFWnjJoHUYb59WaifqHowrR4eN/RpZIoaG/rZYt2Pjz9s3s2dQOB/Zs7VYA
 5YX3WTj5Jq7OmEwPki9wj2BTP1JpicjhWolEbUPjnxaK2qwS797haTo5ggu3uWLMK/1PfKPlllL
 jhKWbROfPZCNjDalbg6/7vQ43o8It4IttPuZnmyr024WagX760Sl1dijFc98Xzu4B8AkpSAj4eC
 6ZB9BPHLpgaSt7w
X-Received: by 2002:a17:90b:57e8:b0:39e:6c6a:6578 with SMTP id
 98e67ed59e1d1-3a0bb6537admr5254135a91.59.1790482022096; 
 Sat, 26 Sep 2026 21:07:02 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm5833191a91.13.2026.09.26.21.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 21:07:01 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com
Subject: [PATCH] drm/virtio: put GEM objects when dropping a vbuf on unplug
Date: Sun, 27 Sep 2026 11:06:55 +0700
Message-ID: <20260927040655.14531-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:41 +0000
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

virtio_gpu_queue_ctrl_sgs() drops the command when drm_dev_enter() fails
or when vqs_released is set. It unlocks the reservation and frees the
vbuf, but never releases the references that the caller handed over in
vbuf->objs. Those references are normally dropped from the dequeue path,
which never sees a command that was not queued.

If a framebuffer flush races with device removal, the GEM object backing
the fbdev buffer keeps a stale reference, is never freed, and its node is
still in the vma offset manager when the drm_device is released:

  Memory manager not clean during takedown.
  WARNING: drivers/gpu/drm/drm_mm.c:965 at drm_mm_takedown
  Call Trace:
   drm_managed_release
   drm_dev_put
   virtio_dev_remove
   virtio_pci_remove
   pci_device_remove
   remove_store

Drop the object references together with the vbuf on both early-exit
paths.

Reported-by: syzbot+d93b9064fe5f74af3aa3@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d93b9064fe5f74af3aa3
Fixes: b7170f9457f2 ("drm/virtio: return virtio_gpu_queue errors")
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c02c03c10d92..b36c4da04b18 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -208,6 +208,17 @@ static void free_vbuf(struct virtio_gpu_device *vgdev,
 	kmem_cache_free(vgdev->vbufs, vbuf);
 }
 
+static void virtio_gpu_drop_vbuf(struct virtio_gpu_device *vgdev,
+				 struct virtio_gpu_vbuffer *vbuf, bool locked)
+{
+	if (vbuf->objs) {
+		if (locked)
+			virtio_gpu_array_unlock_resv(vbuf->objs);
+		virtio_gpu_array_put_free(vbuf->objs);
+	}
+	free_vbuf(vgdev, vbuf);
+}
+
 void virtio_gpu_reclaim_vbufs(struct virtio_gpu_device *vgdev)
 {
 	struct virtio_gpu_vbuffer *vbuf;
@@ -410,9 +421,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	int ret, idx;
 
 	if (!drm_dev_enter(vgdev->ddev, &idx)) {
-		if (fence && vbuf->objs)
-			virtio_gpu_array_unlock_resv(vbuf->objs);
-		free_vbuf(vgdev, vbuf);
+		virtio_gpu_drop_vbuf(vgdev, vbuf, fence);
 		return -ENODEV;
 	}
 
@@ -432,9 +441,7 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 		 * synchronize_srcu() wait in drm_dev_unplug().
 		 */
 		if (vgdev->vqs_released) {
-			if (fence && vbuf->objs)
-				virtio_gpu_array_unlock_resv(vbuf->objs);
-			free_vbuf(vgdev, vbuf);
+			virtio_gpu_drop_vbuf(vgdev, vbuf, fence);
 			drm_dev_exit(idx);
 			return -ENODEV;
 		}
-- 
2.43.0

