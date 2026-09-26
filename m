Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAACCA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75F510E847;
	Mon, 28 Sep 2026 08:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CZ+UxAyb";
	dkim-atps=neutral
Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com
 [74.125.230.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B032010E008
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 20:20:47 +0000 (UTC)
Received: by mail-qk2-f40.google.com with SMTP id
 d75a77b69052e-53324cfe178so6452491cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790454046; x=1791058846; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1yMSXbv0RzpnT7LQIOAfBfWiKfyiEPbJB+JqeZgxSJQ=;
 b=CZ+UxAyb+5VFy/DTuAVVqWOBvxXmSftBhDsH9pOheJWLtSTXeqQ0nQyqmt4A/FFVNP
 nMYpR6scXT2EEVjqV3HO6Q9CJZ5ZWHXSJfyYYEMZzHkO+fiztWUQEVaYDE7Vx/npvHa1
 sr9qZ6a8wGopW8UPdhZG1VmUqzO0/ohbDselqD8d6mcj0d4aopowSz/FiLpK8H/jcLkm
 LSrAAlWQt9A/1OrXvTLKMZJE4Q4qljS9WTmZtOqB0Xs3U+Fw5vY3VzqwpxOIZsJNpMxf
 TFXhXpCvpkfmoha5eAbqQJHNq4dYDITFLGZJyeM+S4gcq1qDKCclEpcRbf0oGk9yCg9c
 /HQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790454046; x=1791058846;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1yMSXbv0RzpnT7LQIOAfBfWiKfyiEPbJB+JqeZgxSJQ=;
 b=FaNqo6Z3+FIu5JHaqr5O+EvnNjOvWKap1x5s7F5Un5V21EQp+tSSPrqKQVcd97u1Om
 XSScrPArGbnZPtRJMlqRAoIohAQwq27Bs6dIT0jKs0hAwISLSB2GE4yPo8FGaV+iD+O/
 zoJxxV/20LhmtatWODRa1MpO18m4Xe1rlBWbZvLerHIxzzLLt3ktn1HIDFUe8RNUIYED
 yjUpkcD9norCFhr1LbqriRcEyClhTjlhU9KArLD8ApS4v7LUzPrZi47fVL32K3FrGTeS
 jQj1Zmke5bK5nK1bHP1LRRAtyZW1g5UrovyB/ntzm4JfKoqePE03mGNocwrG8E3BJA68
 LZdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxkZEGwj7F3N+J2h2CLw+2T6dFQ8PhAs8U58kYJxfb7HPG827vp+MyR0m6U/tGUAU8CLluXb7kk/mM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kKDJSQTTfZWvEh0Mg73FyhYregWvLvZu5cgL/EUwqPFKU3zw8k
 F5rERV7azBDKVF/wlMKIzRZTUqZ2rT+5AuWWsyrAV5WzOiym0x0KzIb5
X-Gm-Gg: AYBFou2bgr4yeYNi04TtVpIfUsqFKhFLiBSOKwsWckvj2ikvUfpNmay/JT9CDOWv9fs
 8Ww7NOq7kfbw4PN+zWQYSzoI5tb3YAsYOz2RXzScp6lHnQGz7y/6Np/0rVNBgTdc5yutCBgtdAE
 SUa5NRYPqxpAaeZIEAPGL0z4WjglPysZ07sDdOEAr119W11Cu6UyXANQCNRXFT0BIje7AndtyYg
 FVDgCtdkoQocdfLylAPHUae4E6GzSDkIm0ywpkHzey5Fy4wpoh0hs0nnAyYSz/pVK4InMC9B6e8
 4n3Q5/TUWrCQttqU9HsQA8ZOVbA+VKYP5zE9GyJU9feNkhmqh4XkGX+AFOFZWyfm4zDRd+yt087
 jZ2JHF78HJOJm1MruHolcrScnMFGsuMwGaOudDFlNMLVosK914U4x3aVjIDZxeY9lH7TyFhZVF/
 3/0xNncvVTDpaANdbHQLv6HaWMceoWjMMYQHK9XJRYy9F7ZJsFzMyN1xjX16yKIgJjpDcAq41XQ
 QcUFcJKsRepTnbVA3AEZQ==
X-Received: by 2002:a05:622a:15c4:b0:530:178a:9dd8 with SMTP id
 d75a77b69052e-5330b556ae7mr122052901cf.8.1790454046528; 
 Sat, 26 Sep 2026 13:20:46 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5332238c585sm25325811cf.20.2026.09.26.13.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 13:20:46 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Dongwon Kim <dongwon.kim@intel.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
 Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Yuho Choi <oss.patchbox@gmail.com>, stable@vger.kernel.org
Subject: [PATCH v1] drm/virtio: Reset device before deleting virtqueues on
 freeze
Date: Sat, 26 Sep 2026 16:20:27 -0400
Message-ID: <20260926202040.1313385-1-oss.patchbox@gmail.com>
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

virtgpu_freeze() waits for the control and cursor queues to drain and
then deletes the virtqueues, but nothing tells the device to stop first.
del_vqs() frees the vring backing, but does not provide a generic device
quiesce operation. In particular, modern virtio-pci keeps enabled queues
active until the device is reset, so the device is left DRIVER_OK with
its queues pointing at memory that has been freed and may be reused while
the guest is suspended. virtio_device_restore() only resets the device
later, on resume.

Reset the device before deleting the virtqueues, the way
virtio_gpu_deinit() already does on removal.

Fixes: cad6a879a7fb ("drm/virtio: Freeze and restore hooks to support suspend and resume")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index 2aaa7cb08085..52c174f9bff7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -225,6 +225,7 @@ static int virtgpu_freeze(struct virtio_device *vdev)
 		goto err_resume;
 	}
 
+	virtio_reset_device(vdev);
 	vdev->config->del_vqs(vdev);
 
 	return 0;
-- 
2.43.0

