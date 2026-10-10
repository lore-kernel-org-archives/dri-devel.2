Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B578ECA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6D6810E5B1;
	Sat, 10 Oct 2026 08:11:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sBpIpJpN";
	dkim-atps=neutral
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 910A710E5B1
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:11:11 +0000 (UTC)
Received: by mail-oo2-f7.google.com with SMTP id
 46e09a7af769-8210db80578so191709a34.0
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 01:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791619870; x=1792224670; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z2ha4Gusp7rfS5qI3QalwE3wIPhVWRGc9MjXkvhjipc=;
 b=sBpIpJpNE5MsZMjpDn/15IM5c9DLsnm276IhBIuaiP8Pl8r9ABoITkBB0ntcJGiiSt
 p3L2mWPkGRjHGyOWOaiwYQsQoJ7242E6UxFCri7Gq/16uD/SWz+BpT/j1qxyjv9oIugT
 HrPxafRyTmWh1GM6Rd86OD/2pdjP7pDqLPsL06hCkqKOYp4DI3wlknCqCSd71hp63NA1
 oM0uAWMpebCBzb07zOz5Hc9D3jchoD1V2LNQEr+0FzmdQYqfKFWv4AlfoQx/hSUiRa3+
 JSD6Y6pcl0S9pDBgLUGr/asDyle+Ixa9R/uIW+RFIR07qbHRYumYfgDXy7TH++Pf7iRa
 J2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791619870; x=1792224670;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z2ha4Gusp7rfS5qI3QalwE3wIPhVWRGc9MjXkvhjipc=;
 b=nz7f1+Ly3io9e94h3taSNu0+Z8RS4O794jJVsn3AMEZJlVur5igyhlCSGAgCTAX0VG
 VjOcRcXheXDwXCGCZg9szebsb2uG//g5IbJTRuk+1cQFI0KkFMqIdCy5SaulFe+tJdEo
 tv62boX+fCkgd5oKp8GGjGtqf2cOhkzTVDo2aL/sTh4bgaA0ksEHqxs89w5jEMDmIdaB
 /doqQuzt7IYYvNQ6lgQdmXoXibA7E1rsiRqUugvkYVJVHOrWP0B5uJSCgiYJ7yG8oX6z
 BTH+AyS4KW1CymB0dhnvpPEKQ3g0CVJu3NBCeKsGOlTYEsYSfUWTcxGRtFde070A3K31
 p2Lg==
X-Gm-Message-State: AFq9FYKNkt/p+v95vJPWGtJJsPYmY0KwBIbPbSTlpvb6yMQRq5NymHmX
 Wafey3s499y++07te1hJ8UCR/zQ9X0BeQFcpMxUKRNF4df+JItUi363w
X-Gm-Gg: AYBFou20xE2F3jaRo9/loRp6wnnODfDfAkCuUUOJ/sjFSCs1StxHpxWec4lbc3pNfDM
 jSmSV2xxArMK9UFrnvdBBdyQy1CkMBsOndiyezCimlCgQs1Q2z2Z4b51GeNF/FouSY0EKZpoTd4
 bmhhui4fvEr11kSa1s9iaX9ykbB6Stz5kkxtR1V9DT5KYvRm/Y1pLqllV4tBqro/8KG7iv/nrXi
 r21Y1Aqc7+4CvG6yo+PSZaGluqcS70sCfue+k/E9H+uwhKfenT1qt62ZVEBtEf7ExIU629N97kJ
 m86LfNCSGKdHl5gPE7lUoUzs6wcgCphPsXkur7lEhCqgtBaNf/J4vzAMkx8dfLfD1x88wQeqVUA
 QBZrX1DDxBsfFSIUhCDjEhP4Chs4irBikbRtcYxXA3tYJUIivffpuIoAPpgKlzYYaDnGHkPZVAc
 TrSCv+jYs8nIlXHl7Lx7Oc2rU/UYQnAfUqPIEcqzRjfx4FzEIUoVxi6QIKxVX/5tewmWlifsdfC
 YYDL7zbvtGAhYd1cL+rQkFt/G2cOBbPLv91aGzUdVJMzFnW
X-Received: by 2002:a05:6808:f8c:b0:4c1:f40e:b697 with SMTP id
 5614622812f47-50c56bf8ed8mr3581941b6e.38.1791619870362; 
 Sat, 10 Oct 2026 01:11:10 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.38])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-50c16755587sm4665356b6e.5.2026.10.10.01.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 01:11:08 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: David Airlie <airlied@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Chia-I Wu <olvaffe@gmail.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 Junrui Luo <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, Henry Martin <bsdhenrymartin@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/virtio: reject mappable HOST3D blobs without host-visible
 memory
Date: Sat, 10 Oct 2026 16:10:59 +0800
Message-ID: <20261010081059.3096312-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

virtio_gpu_resource_create_blob_ioctl() -> verify_blob() validates
blob flags, memory type, context and alignment, but never checks
VIRTGPU_BLOB_FLAG_USE_MAPPABLE against vgdev->has_host_visible.

For blob_mem == VIRTGPU_BLOB_MEM_HOST3D the blob is created via
virtio_gpu_vram_create(), and on a device without host-visible
memory (plain virtio-gpu-pci,blob=on with no hostmem) the failure
comes too late: the GEM object has been allocated, a host resource
id taken and the create_blob command issued when
virtio_gpu_vram_map() returns -EINVAL, and the cleanup calls
virtio_gpu_vram_free(), which is a no-op while bo->created is still
false (the host response has not been processed yet).  Every such
blob creation permanently leaks the vram object and its resource
id; /dev/dri/renderD* is reachable by unprivileged users.

Guest-backed blobs (VIRTGPU_BLOB_MEM_GUEST and
VIRTGPU_BLOB_MEM_HOST3D_GUEST) mmap through the shmem path and do
not need host-visible memory, so only the HOST3D case is rejected.

Commit 036d28db1818a ("drm/virtio: release the GEM object on
virtio_gpu_vram_create() errors") fixed the sibling error paths but
missed this one.  Reject the impossible combination at ioctl entry,
making the failure mode unreachable.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 16845c5d5409 ("drm/virtio: implement blob resources: implement vram object")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 81e70a12b3569..e3edade4a62dd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -533,6 +533,11 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
 			return -EINVAL;
 	}
 
+	if ((rc_blob->blob_flags & VIRTGPU_BLOB_FLAG_USE_MAPPABLE) &&
+	    rc_blob->blob_mem == VIRTGPU_BLOB_MEM_HOST3D &&
+	    !vgdev->has_host_visible)
+		return -EINVAL;
+
 	params->blob_mem = rc_blob->blob_mem;
 	params->size = rc_blob->size;
 	params->blob = true;
-- 
2.43.7
