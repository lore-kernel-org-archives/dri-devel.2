Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6109CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 07:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50215112F2A;
	Mon,  1 Jun 2026 07:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fdTlBSBg";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1418112F2A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 07:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780300425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zIqhrXUwwJrpCl1gMsGp42AZVtWIyb4Pqr0eIXGPoJc=;
 b=fdTlBSBgJlXU2RRjQ2I27RmPhg9NEhQ0d29HTXVF68Gr0k2cE9bw1DGt1fG4Gck82azXny
 zHJ22i8P4THxqk6aXbxTEthphqAbVHvja8iPz9ro2go/sQUJMqVY7ZCk9ORJeJwshMfIBq
 AGtrEj+I9BY40CcEt1Etwkwq2IZ9M3A=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-AoCJC4sGO2O7zvLE3EoZKg-1; Mon, 01 Jun 2026 03:53:42 -0400
X-MC-Unique: AoCJC4sGO2O7zvLE3EoZKg-1
X-Mimecast-MFC-AGG-ID: AoCJC4sGO2O7zvLE3EoZKg_1780300421
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2c0c3315d31so11866675ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 00:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780300421; x=1780905221;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zIqhrXUwwJrpCl1gMsGp42AZVtWIyb4Pqr0eIXGPoJc=;
 b=f2o71CcTEeF30sZemkufBYl7pKA6bVk5y/aOGhiLFuhX0nhc+O8dfAjJMzarEvyHuM
 hjSeOiJAhTFMF6gPm5zsNDmTUn44pSjCZ9nt7pvP4tFo6hA92GoBuztlwdUmqhhs1HCQ
 SIL7GkevaB+YUj0fs3XXaylaXmShuFfVXbcJ5bQ8bSiI88ZtQcnyDTuoyfaGUIyYIUks
 Hl85vVAlUCIZ2iEvN9tnrcQMOE66qAfk4TqTEGxd6NccGQa3hhAW+57ZGJ2PxGJg7IkD
 dea5d0mzqN6O/rK/I9OiVF2oV7U9IbX+ZfmurSurwYYLngFuHVisiInepuNERCM0/T/3
 bbNQ==
X-Gm-Message-State: AOJu0YwimiZjCHoHykv38bwb+YrkJjjJvJG4CK752RVtfhRT//cDOfCh
 wzAcHlm6MK60jiHWHRdQOQq9+LXr+t7HukQWO6EQoyvYbgM0TDW3C+aF+Z+O8LMFZz6OPHMpqt2
 +D6SbKfj8r/B7O8u3bmFeVqdJrDkWrb0mpOjoHp+YG9IFYnuUU9MZi2M/6HKYzqRtVBMeqw==
X-Gm-Gg: Acq92OE0OKy2fj50xS0o9vVsUJF9/nqz+UfZdmGfvtJrH7Dz8WbXi6WDMx6DKJ0/W9W
 3WiblGHZ1sGBNmod4hYAu8rIpBt82mjr7DSoV2mfC3J0mkeAt5ZrH7uvdN+j0IPgGIKvPQovlNP
 UsZ/hMuCoSBkBnsfRsAfQrE+Qe4wWE3PM9QBOhpJEp8WrmtxsVE7FH2aN9HQ9SxAEVbERUoicFJ
 ynARtTeFzBa10iYmoCIUq6dd70SGPXoSy0frqI+664oUa9biYXEtWZpW5M8nEwwAw64M9OFaRKW
 AKJT/lI2L1+vzp5n1yZmSmlLKfKCKu2WoQiBmCnUoNOmkk9F0GNaUX+UbfCx4jMqB97GSRisb9q
 o5nesgAeG6M+UG9ZVRtdc3JhLAriO6nfOhWHvdKUvhL96DCzczqXV+kyDmDLQK6KN7ZEjqg==
X-Received: by 2002:a17:902:f78b:b0:2bf:9760:b953 with SMTP id
 d9443c01a7336-2bf9760bc6bmr96883245ad.14.1780300421000; 
 Mon, 01 Jun 2026 00:53:41 -0700 (PDT)
X-Received: by 2002:a17:902:f78b:b0:2bf:9760:b953 with SMTP id
 d9443c01a7336-2bf9760bc6bmr96883055ad.14.1780300420534; 
 Mon, 01 Jun 2026 00:53:40 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e7483sm93308075ad.14.2026.06.01.00.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 00:53:40 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Mon, 01 Jun 2026 16:53:15 +0900
Subject: [PATCH v3] drm/virtio: abort virtqueue wait on device removal to
 avoid hung task
MIME-Version: 1.0
Message-Id: <20260601-virtio-gpu_wait_event-v3-1-89530517a98a@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNyw6CMBBFf4XM2po+LKgr/8MQUukAs5CStlYN6
 b9biVuX5yT33BUCesIA52oFj4kCubmA2lXQT2YekZEtDJLLmmtxZIl8JMfG5dE9DcUOE86RaWN
 4zRt9GISEsl08DvTaute28EQhOv/ebpL82l9Rij/FJJlgujnVN2UaYbm6eLSTifve3aHNOX8A0
 PGvlrsAAAA=
X-Change-ID: 20260518-virtio-gpu_wait_event-5aa060754f12
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ryosuke Yasuoka <ryasuoka@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TdlNYGcDLmAVitqFZEDfYA_lvbbXwf4zI1ZAOeFSvC0_1780300421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() use
wait_event() without any abort condition when waiting for virtqueue
space. If the host device stops processing commands, these waits block
indefinitely inside a drm_dev_enter/exit() critical section. Since
drm_dev_unplug(), which is called in device removal and system shutdown
call path, blocks on synchronize_srcu() until all critical sections
complete, device removal and system shutdown also hang.

Add a vqs_released flag to virtio_gpu_device and include it in the
wait_event() condition. Set the flag and wake up both queues in a new
virtio_gpu_release_vqs() helper, called before drm_dev_unplug() in both
virtio_gpu_remove() and virtio_gpu_shutdown(). When the flag is set, the
wait returns immediately and the command is aborted, following the same
cleanup path as drm_dev_enter() failure.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
Changes in v3:
- Remove Reported-by and Closes tag from commit msg because they are not
  related to this fix.
- Link to v2: https://lore.kernel.org/r/20260521-virtio-gpu_wait_event-v2-1-5796b3a71d03@redhat.com

Changes in v2:
- Update the commit message.
- Replace wait_event_timeout() with wait_event() using a compound
condition that includes a new vqs_released flag.
- Add virtio_gpu_release_vqs() helper to set the flag and wake up
both queues, called before drm_dev_unplug() in remove and shutdown
paths.
- Remove the hardcoded 5-second timeout. Recovery is now driven by
the driver flag instead of an arbitrary timeout value.
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 15 +++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_drv.h |  1 +
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 23 +++++++++++++++++++++--
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index a5ce96fb8a1d..e4fe5e0780f9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -119,10 +119,24 @@ static int virtio_gpu_probe(struct virtio_device *vdev)
 	return ret;
 }
 
+/*
+ * Release pending virtqueue waits so the drm_dev_enter/exit() critical
+ * sections complete before drm_dev_unplug() blocks on synchronize_srcu().
+ */
+static void virtio_gpu_release_vqs(struct drm_device *dev)
+{
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+
+	vgdev->vqs_released = true;
+	wake_up_all(&vgdev->ctrlq.ack_queue);
+	wake_up_all(&vgdev->cursorq.ack_queue);
+}
+
 static void virtio_gpu_remove(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
 
+	virtio_gpu_release_vqs(dev);
 	drm_dev_unplug(dev);
 	drm_atomic_helper_shutdown(dev);
 	virtio_gpu_deinit(dev);
@@ -133,6 +147,7 @@ static void virtio_gpu_shutdown(struct virtio_device *vdev)
 {
 	struct drm_device *dev = vdev->priv;
 
+	virtio_gpu_release_vqs(dev);
 	/* stop talking to the device */
 	drm_dev_unplug(dev);
 }
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 2f3531950aa4..5f7bb6cc6ba7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -235,6 +235,7 @@ struct virtio_gpu_device {
 
 	struct virtio_gpu_queue ctrlq;
 	struct virtio_gpu_queue cursorq;
+	bool vqs_released;
 	struct kmem_cache *vbufs;
 
 	atomic_t pending_commands;
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..8057a9b7356d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -396,7 +396,19 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	if (vq->num_free < elemcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		virtio_gpu_notify(vgdev);
-		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
+		wait_event(vgdev->ctrlq.ack_queue,
+			   vq->num_free >= elemcnt || vgdev->vqs_released);
+		/*
+		 * Set by virtio_gpu_release_vqs() to unblock
+		 * synchronize_srcu() wait in drm_dev_unplug().
+		 */
+		if (vgdev->vqs_released) {
+			if (fence && vbuf->objs)
+				virtio_gpu_array_unlock_resv(vbuf->objs);
+			free_vbuf(vgdev, vbuf);
+			drm_dev_exit(idx);
+			return -ENODEV;
+		}
 		goto again;
 	}
 
@@ -566,7 +578,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
+		wait_event(vgdev->cursorq.ack_queue,
+			   vq->num_free >= outcnt || vgdev->vqs_released);
+		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
+		if (vgdev->vqs_released) {
+			free_vbuf(vgdev, vbuf);
+			drm_dev_exit(idx);
+			return;
+		}
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {

---
base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
change-id: 20260518-virtio-gpu_wait_event-5aa060754f12

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

