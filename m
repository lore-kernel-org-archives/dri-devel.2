Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396D8CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 08:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8466A10E9D4;
	Tue, 12 May 2026 08:59:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="byLuxiws";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB0410E9CD
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778576376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=E8x/nB6+eHD5O3AzeJFXB6I/hH3gbVO1zz0k4nECC2U=;
 b=byLuxiws1j8OxKXMJgguhGJZqoAg/DHOcrl8mYmqR2oO5QTTa/+qLmWEk9RfwrrS7j4SZZ
 TijOy6DbtQc8jNt/GjraCsrxMb16O+KZ2JJPSKCi7mQpdoBpXArXf1uvlEjyV1PMiAKxrK
 7Ck072Wk17u3QRny3J5mtS/DcqVdf0s=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-3rmPE4xKMNaagSEzCv2qcA-1; Tue, 12 May 2026 04:59:35 -0400
X-MC-Unique: 3rmPE4xKMNaagSEzCv2qcA-1
X-Mimecast-MFC-AGG-ID: 3rmPE4xKMNaagSEzCv2qcA_1778576374
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c828acf7c1dso2691735a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 01:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778576374; x=1779181174;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8x/nB6+eHD5O3AzeJFXB6I/hH3gbVO1zz0k4nECC2U=;
 b=qP0/L4eVsCyLHpETZqx+rxVO7i7HckPw6nD3jzb8Jljbwfmyd+rDSftN5yqmokch9b
 8sn9HCO5sQWcVm7AW318SGhKPFQuJHySHDU9c7QOwGmsZf4FolXr46efKPCXELMKRa1/
 7R29YzSxwR2kCaMVnd5lVrmjdrUjdxrgxvndSk8aWQMbysqbiou2rHFryjge3H/wkpbo
 X/teHERKqhkiaao4Oyi9CZfel4/s/wfE5nO2+S6KAuaYaodD9BfJlLt2msQwGFOHJJjh
 9mF8j3IhY/UpAHY+2etvCbC6GYLUi0tbEoXQ51K9r4F84rovJosT9sReomxgQytHXmjt
 STIw==
X-Gm-Message-State: AOJu0YwdlAU41dGQRaE22IKfHJK0YZu3P77xKHa7irLBPBFTfFlxT3t2
 1oSQUW+A8Q7iDcaCqLZb4vVaMReIa1GWPwb19g9RJjQMDWKiT3NSH8ZkHcw2CXwcMb38kqzH+kU
 W1MtF292UejfBS2QhEFYmNxVDqyPHYchI4P27Lp2Ducir5JX10SMFwb1W4+nSkY8pAilosQ==
X-Gm-Gg: Acq92OHW41H+F70TrlH0pVB5TglsNj53Eb8ZfkY3Qvl5Az4ANq21Buf4Dgk8ZVxXCAW
 q9uGtbLGYfckweIIemdCx+vJVwQ9PsF0FBqZF5Fdp6ZxjwBZXlS/iFRmjQahRLLpS9elHxzM+eG
 KnmQMXpjw6nk0/InQrygbIzZ5XZATSeeTCP8vgpuNQu+pKNNKdMBx0HSpJg62czjyNr25pjigx6
 UKKg5YKvj6hCk0uE6Flr3Uj770arc+g/x0PjxzLnzF5po/nFA9j5X/LU8BoFyUTm0aROU0K1S4Y
 FBPQHvdX6SuOpzm0MoJkYVpy7j2zTfuUlEoK4Zp9hW9uH+X/wDzN9g2UODlWnRuVA4ymHiSmbVr
 vkfcL6w7WwseYXz/rgpArPNIBuRuZ359mkdDAxsCuEeXIUaEC1HXGttfczOk=
X-Received: by 2002:a05:6a00:2446:b0:835:405a:7e69 with SMTP id
 d2e1a72fcca58-83eebb5e9e1mr2301791b3a.16.1778576374226; 
 Tue, 12 May 2026 01:59:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:2446:b0:835:405a:7e69 with SMTP id
 d2e1a72fcca58-83eebb5e9e1mr2301758b3a.16.1778576373655; 
 Tue, 12 May 2026 01:59:33 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83967dbd995sm21336715b3a.43.2026.05.12.01.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 01:59:32 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Tue, 12 May 2026 04:59:02 -0400
Subject: [PATCH] drm/virtio: add timeout to virtqueue wait to avoid hung task
MIME-Version: 1.0
Message-Id: <20260512-virtio-gpu_wait_event-v1-1-207eb4c1a69a@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBNM0KKrRITZWLNRUbMgunvS8
 i3+fyBhJEwwNg9ELJTIu4qubcAc2u3IaKsGwYXishOsUMzk2R7O5dKUFyzoMkNuNjuoXq69gdq
 GiJbu/zvN7/sBdmCa/2cAAAA=
X-Change-ID: 20260512-virtio-gpu_wait_event-e0cdf8675b7c
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com, 
 syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com, 
 Ryosuke Yasuoka <ryasuoka@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vvVbs9R4eIQoW77K4Dpyp77aNt7OxBAGIO5SXzmPe6I_1778576374
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
wait_event() without timeout when waiting for virtqueue space. If the
host device stops processing commands, these waits block indefinitely.
Since callers may hold DRM locks, this can make the entire system
unresponsive.

Replace wait_event() with wait_event_timeout() using a 5-second timeout,
consistent with the existing timeout pattern in the driver. On timeout,
clean up and return -ENODEV, following the same error path as
drm_dev_enter() failure.

Reported-by: syzbot+d6dd6f86d3aaf7eebe7406e45c1c6e549453f224@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
Reported-by: syzbot+908bd910da5dd79b88de4cf7baf376cc873a922e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 67865810a2e7..05e816a0ae0b 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -396,7 +396,16 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	if (vq->num_free < elemcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		virtio_gpu_notify(vgdev);
-		wait_event(vgdev->ctrlq.ack_queue, vq->num_free >= elemcnt);
+		if (!wait_event_timeout(vgdev->ctrlq.ack_queue,
+					vq->num_free >= elemcnt,
+					5 * HZ)) {
+			/* The device did not respond */
+			if (fence && vbuf->objs)
+				virtio_gpu_array_unlock_resv(vbuf->objs);
+			free_vbuf(vgdev, vbuf);
+			drm_dev_exit(idx);
+			return -ENODEV;
+		}
 		goto again;
 	}
 
@@ -566,7 +575,14 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue, vq->num_free >= outcnt);
+		if (!wait_event_timeout(vgdev->cursorq.ack_queue,
+					vq->num_free >= outcnt,
+					5 * HZ)) {
+			/* The device did not respond */
+			free_vbuf(vgdev, vbuf);
+			drm_dev_exit(idx);
+			return;
+		}
 		spin_lock(&vgdev->cursorq.qlock);
 		goto retry;
 	} else {

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260512-virtio-gpu_wait_event-e0cdf8675b7c

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

