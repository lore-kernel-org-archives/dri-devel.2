Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473AA606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 08:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jvluEQKI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62BD0112031;
	Thu, 29 Oct 2026 08:05:02 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28CD410E58C
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 22:25:07 +0000 (UTC)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-93f2f2edb19so130655885a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 15:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793226306; x=1793831106; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aAFBHqSFELXCigxcRHp1sfmuof9NM3vLwNWTQKlbcIc=;
 b=jvluEQKIMZ6ksmhk8OxTnRXzQcY4YsMFhxINyDSztQnr+D5byetShKZknpYy2kma/r
 4d3xlYIeE8hI5nZPseuYDXDEoYtDmGDeM68gstr4hB068pKZ/hZMSEEWMR6UUngKGTlp
 tjZ8dOIir3uxvnoCmxgHObLw48Ul3QLfptsU+N0iFCqARDbuAraqzXBv/RWRAvTpAFFt
 b4hFD4scnAxgpupYjLOOocm1tGOwPOZmUUm92G5kmUoWTlew5L8J+MIGzwfSJwwFYwku
 KJlClurMbEmkf8ie7OdJL/e7E1MyUl538r1jg7lZeMhzRa18IAhZ8zxNIjuUvl7eEFJ6
 azkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793226306; x=1793831106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aAFBHqSFELXCigxcRHp1sfmuof9NM3vLwNWTQKlbcIc=;
 b=j+RentBZBouSHNlsxGCEVQTWcQI49PEqmQF87lOL0Cps8x9hq080n9xJUFO481hK3P
 8olGrFgtq3/+6gN2GK7v3nepqV7AcQEAAk1DO5mk3dTp/yLSZHn8S42hNaIgtJGV2VsT
 hraQgGWb8/aUAtm2I3umByPexOJeC/QPNticXHNnC9zeQh40gFF2rElUSBRsHWwAqc4p
 RasVJAhHnskpJKde7WdxfA9HwbAb4oXVA3Oi4xkk2Bh1kVky8g/RxvDCNQLguzBgYgTe
 yG0lzcHSFJ3v27D4Immk/7m/nVoVM8Z1fWPZHDGDrPRSXrQL29XgbJ5ZpYLljRjnTJO8
 1I6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByQjxziZQlXXCN+fiVLhkQmYNESo33coSVDlAcXJvB/pIBRqtDnAy7DghT36HhnT1wLB/qG8rgyJtg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLYuxMSOjbgy7LHZpK9hooKijjfl8kyr4bO6WR887wea6UCbh48
 caUhKlniugjIsR+fb6LE+fmWDibDFUwqOkUnpSM5Ju0q4qUABQOd5IB8
X-Gm-Gg: AYBFou3GAmi4aE8afMsNeAx8JTporqV343y+AAb3rplnnDKN7rNnmepS73T6rSE/F40
 gmJA8jXV4LaITfsl80hTBTgcYm1pttmBUVqPFNC4BKp/fcdGWSMQZG2JMaaWApskQKAvnN0ESE+
 4H3mz3l3zF36k5Wj737MqY/JtzhltSu+XkeiwWEOimswOJbSjs7A31HVYCaLxBDPIOI73NYNZ/7
 vt9iOP97/4dSeKFfl43lsSMbu9RW6JI/GCkgIJmprwPRSj96NP8jHA15MBtu4Y1+GGpNJv7gTli
 FwjDnNmad6VJgI4yNoLLlYHs5BsX6q+KAfwzOBJrcYiB0BxDFRYdHZ2lwLz/BpCQI1Dwio8PAgj
 +D4yw9PVlWy9JSmD//0gGAMbMQDUXkSRf09xBL244v2V8phMVti7mudfRPKMO4HOX6eW0vJoVg/
 OUuJ/eUE7Fv10e0zcAIctFO/h0QPhk4dW26Rk6GeMt1HHOyvVnGfA4eppua4i0rlHEdodGG9g3r
 Ti2ezYuHoHMlzcqCbcV/QTxzQTU90b+rhLN4zUoNFxvzww0i/JzsflRFUSvBry0rexc2Vy/6mNT
 4ROYC8uS4dtHfVHMIg==
X-Received: by 2002:a05:620a:17ab:b0:93a:f9:614a with SMTP id
 af79cd13be357-94408c91a29mr596917085a.34.1793226305765; 
 Wed, 28 Oct 2026 15:25:05 -0700 (PDT)
Received: from linux.. ([8.34.174.240]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91c47bd2110sm142981306d6.13.2026.10.28.15.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 15:25:05 -0700 (PDT)
From: Changyul Lee <lcy8047@gmail.com>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Changyul Lee <lcy8047@gmail.com>
Subject: [PATCH] drm/virtio: Propagate errors from deferred blob mapping
Date: Wed, 28 Oct 2026 18:25:00 -0400
Message-ID: <20261028222500.2575769-1-lcy8047@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

virtio_gpu_vram_map_deferred() ignores errors from
virtio_gpu_vram_map(). If mapping fails before RESOURCE_MAP_BLOB
is queued, virtio_gpu_vram_mmap() still waits for a response
that will never arrive.

This can happen when drm_mm_insert_node() finds no room in
host_visible_mm. Since no command is sent, map_state remains
STATE_INITIALIZING. The task then waits indefinitely while holding
mmap_lock, and SIGKILL cannot terminate it. Any user with render
node access can trigger this by mmapping a deferred-mapping blob
larger than the host visible region.

Propagate the error so mmap() returns instead of waiting.

Tested on Linux v7.3 with QEMU (virtio-gpu-gl, blob=true,
hostmem=256M).

Fixes: 4c26e162947f ("drm/virtio: Extend blob UAPI with deferred-mapping hinting")
Signed-off-by: Changyul Lee <lcy8047@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h  |  2 +-
 drivers/gpu/drm/virtio/virtgpu_vram.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index f3bbbe4468bf..a3c52aa17ed8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -561,7 +561,7 @@ struct sg_table *virtio_gpu_vram_map_dma_buf(struct virtio_gpu_object *bo,
 void virtio_gpu_vram_unmap_dma_buf(struct device *dev,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir);
-void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
+int virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram);
 
 /* virtgpu_submit.c */
 int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
diff --git a/drivers/gpu/drm/virtio/virtgpu_vram.c b/drivers/gpu/drm/virtio/virtgpu_vram.c
index 01241ce4d07c..7e0fab7fb2eb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vram.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vram.c
@@ -45,7 +45,9 @@ static int virtio_gpu_vram_mmap(struct drm_gem_object *obj,
 	if (!(bo->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
 		return -EINVAL;
 
-	virtio_gpu_vram_map_deferred(vram);
+	ret = virtio_gpu_vram_map_deferred(vram);
+	if (ret)
+		return ret;
 
 	if (vram->map_state == STATE_INITIALIZING)
 		virtio_gpu_notify(vgdev);
@@ -243,13 +245,17 @@ int virtio_gpu_vram_create(struct virtio_gpu_device *vgdev,
 	return ret;
 }
 
-void virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
+int virtio_gpu_vram_map_deferred(struct virtio_gpu_object_vram *vram)
 {
+	int ret = 0;
+
 	if (!(vram->base.blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE))
-		return;
+		return 0;
 
 	mutex_lock(&map_lock);
 	if (!drm_mm_node_allocated(&vram->vram_node))
-		virtio_gpu_vram_map(&vram->base);
+		ret = virtio_gpu_vram_map(&vram->base);
 	mutex_unlock(&map_lock);
+
+	return ret;
 }

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

