Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720F9CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA27310EC11;
	Thu, 18 Jun 2026 07:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="UlGZUA4w";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 839BD10EC11
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 07:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781767152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rCqSdccfBETy30vxIetTOcEo73ed1Rs+CAf/MV+45CE=;
 b=UlGZUA4wQKnYWs0Q1lS80RUoe96xOtSGArUZ5iYYThmwT33RPi3ZfRqOwW4ENHJIu7Q12C
 ixKQw9BG9EddJQUtWQfiki0Lcu4Fp0+p5y79FMSfio/mM7JFh+ivmbn8po3VlFugu4CiTM
 m7nuzoxWisR2VUS2MLb1l3OMZun4S6Q=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-JVJG-sziPlGJbkLMrU8jgg-1; Thu, 18 Jun 2026 03:19:10 -0400
X-MC-Unique: JVJG-sziPlGJbkLMrU8jgg-1
X-Mimecast-MFC-AGG-ID: JVJG-sziPlGJbkLMrU8jgg_1781767150
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c85dcdbe502so421925a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 00:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781767149; x=1782371949;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCqSdccfBETy30vxIetTOcEo73ed1Rs+CAf/MV+45CE=;
 b=lx1Qy6WzAIAiBNb4o4RZ5wpgVI/ll8SQEi7MBv2Y7v84l3VHWNb+AJFZvSgDwnlNHj
 kNaujCxt6e2Y4kULhusXPX24yHVJlWf6zo8AA3yOt7YuubbsNhppTSGFflqdE7ElhpET
 L/GYd/xeser/5zbqtOJrfsr4GV1dAymRQpYVfhNSXzYPRrd7ZRM5dNvfwqLsYYOKVQPp
 XUOiqU+N7rn0JQMRoBoDQiWVi0nWDmbOBcVJ+D/IgNqpyvhf4VJaoYLq0dRFuv+e1K4e
 hxYQ2IkHgZCR3tqb0g/McKk3yNMnvl94Henkzq9EoCppywfpFeWEySKsA29n4Qxy1Jvo
 zrbw==
X-Gm-Message-State: AOJu0Ywy+J7Xh7jJnwbBna9T4YEOpXMa5KQnU1s1xfHE+nFUFkqMCDld
 kMJL4K3/g3OCLLw94KKEQgpcB+8sLEURpmgh6xZAoU2ta4o9iflzmYpqDVoiUdlcZPeClLCBCxY
 LRj4vSR9RrZtd8N81n2qAXKTwyC3nNzR+hvxhXsxHDGq5x6hNNVxRzBOZYrZWpLr+YkdXIA==
X-Gm-Gg: AfdE7clmorJGNGxW6PHgKMOT03Jvd8PpAT1sYeGnLBHLSiM11zYRC3FR1btDzw5Sdql
 PxjjPtdOUc7nlPUWoMNSMX+28kCYzGVIiEdyo0QKGxUJmBd0MtSKuTgH+9H+7RpQX9h/yjxZ2tf
 STxvGw1lOgjEMhdL8lLfgBb2PnoL9u2rGEa0JMB4HsU2hqJkVkyA8yeL9LjJGflr6jWFQlU5sGs
 wh5Ad5vg8Pwk6X8tDoQdhQxU0xSX7UcNfwnwpoJfLbBMCTNiAis/meUMXFAcYfnH59ifSusCnDn
 eiHxaogH8qGbt9cde49l6y+Op16aI2MQpzXXhdAVpXjRpvKXdPQ6zRdPBu65ojKyC2j1zDYs50C
 6DReA5t0W8HY4+keqI8rjHbE6V9vjKM4f6/5VNLSe39s7CsUb
X-Received: by 2002:a05:6a00:1706:b0:843:4726:e3df with SMTP id
 d2e1a72fcca58-8452459a7efmr8045421b3a.35.1781767149421; 
 Thu, 18 Jun 2026 00:19:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:1706:b0:843:4726:e3df with SMTP id
 d2e1a72fcca58-8452459a7efmr8045395b3a.35.1781767148924; 
 Thu, 18 Jun 2026 00:19:08 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84531dbbe7fsm3178594b3a.14.2026.06.18.00.19.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 00:19:08 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Thu, 18 Jun 2026 16:18:30 +0900
Subject: [PATCH] drm/virtio: warn when virtqueue has no free space for too long
MIME-Version: 1.0
Message-Id: <20260618-virtiogpu_add_timeout-v1-1-dc36cef609d9@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBPSyKyrRETkVLNIRS0C8e5Jy
 7f4P0FATxhgrBJ4fCiQNQW8rmA7V3MgI10MohGykVyyh3wke7h7WbVeIl1o78jaFgfV9VxtQkB
 pnced3v87zTl/9qg/SmcAAAA=
X-Change-ID: 20260616-virtiogpu_add_timeout-33e985718c22
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
X-Mimecast-MFC-PROC-ID: lJs4bHuw2KplxgGsnNasaB_uHbRJLRy8-Y_qQJbV6EU_1781767150
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
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

virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() wait for
virtqueue space using wait_event() with vqs_released as the only abort
condition. This covers the device removal path, where
virtio_gpu_release_vqs() sets the flag, but does not help when the host
simply stops processing the virtqueue while the device remains present.

In that case, the virtqueue fills up and subsequent command submissions
block indefinitely in D state with no diagnostic output, making the root
cause difficult to identify.

Replace the bare wait_event() with a wait_event_timeout() loop that
prints a warning every 5 seconds while the virtqueue remains full. The
wait still blocks indefinitely so driver behavior is unchanged. The
warnings help identify an unresponsive host device during
troubleshooting.

Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
When the host stops processing the virtio-gpu virtqueue without
triggering device removal, the bare wait_event() in
virtio_gpu_queue_ctrl_sgs() and virtio_gpu_queue_cursor() blocks
indefinitely with no diagnostic output. A DRM atomic commit worker
blocks in virtio_gpu_queue_fenced_ctrl_buffer() while holding the
modeset lock. During graceful shutdown, systemd (PID 1) needs the same
lock — either by writing to the console via fbcon, or by closing a DRM
file descriptor that triggers framebuffer cleanup — and blocks as well,
making the VM unrecoverable without a forced power-off.

  PID: 553    COMMAND: "kworker/u4:3"
   #0 __schedule
   #1 schedule
   #2 virtio_gpu_queue_fenced_ctrl_buffer [virtio_gpu]
   #3 virtio_gpu_primary_plane_update [virtio_gpu]
   ...

  PID: 1      COMMAND: "systemd"  (console write path)
   #0 __schedule
   #1 schedule
   #2 schedule_preempt_disabled
   #3 __ww_mutex_lock
   #4 drm_modeset_lock [drm]
   #5 drm_atomic_get_plane_state [drm]
   #6 drm_client_modeset_commit_atomic [drm]
   #7 drm_client_modeset_commit_locked [drm]
   #8 drm_fb_helper_pan_display [drm_kms_helper]
   #9 fb_pan_display
  #10 bit_update_start
  #11 fbcon_switch
  #12 redraw_screen
   ...

Reproduction steps:
1. Build QEMU with the fault injection patch [1] that adds an
   x-ctrl-queue-broken property to virtio-gpu.
2. Boot the VM and trigger the fault injection from the host.
3. Fill the ctrlq (e.g., move the mouse on the guest's display).
   The process gets stuck in virtio_gpu_queue_fenced_ctrl_buffer()
   in D state.
4. Run a graceful shutdown command (shutdown now or reboot).
5. The shutdown process hangs.

My earlier patch a46991b334f6 ("drm/virtio: abort virtqueue wait on
device removal to avoid hung task") covers the case where the shutdown
process reaches the device_shutdown() call path, which sets vqs_released
to unblock the wait. However, during graceful shutdown, systemd (PID 1)
gets stuck on the modeset lock before ever reaching device_shutdown(),
so vqs_released is never set and the wait is never unblocked.

I initially considered adding a module parameter to abort the wait with
-ENODEV on timeout:

  +static unsigned int virtio_gpu_vq_timeout;
  +MODULE_PARM_DESC(vq_timeout,
  +     "Timeout in seconds for virtqueue wait (0 = no timeout, default)");
  +module_param_named(vq_timeout, virtio_gpu_vq_timeout, uint, 0444);
  ...
  +             if (virtio_gpu_vq_timeout) {
  +                     if (!wait_event_timeout(vgdev->ctrlq.ack_queue,
  +                                             vq->num_free >= elemcnt ||
  +                                             vgdev->vqs_released,
  +                                             secs_to_jiffies(virtio_gpu_vq_timeout))) {
  +                             if (fence && vbuf->objs)
  +                                     virtio_gpu_array_unlock_resv(vbuf->objs);
  +                             free_vbuf(vgdev, vbuf);
  +                             drm_dev_exit(idx);
  +                             return -ENODEV;
  +                     }
  +             } else {
  +                     wait_event(vgdev->ctrlq.ack_queue,
  +                                vq->num_free >= elemcnt ||
  +                                vgdev->vqs_released);
  +             }

This approach aborts the wait and allows the graceful shutdown process
to eventually proceed, albeit with a delay.

But that approach has drawbacks: it allows users to set arbitrarily
short timeouts that could destabilize the driver, and aborting commands
mid-flight is a rough recovery path. An unconditional timeout was also
discussed previously [2] but is not appropriate without virtio
specification support.

This patch takes a safer approach: replace the bare wait_event() with
wait_event_timeout() and print a warning every 5 seconds while the
virtqueue remains full. The wait still blocks indefinitely and no
commands are aborted, so driver behavior is unchanged. The warnings
help identify an unresponsive host device during troubleshooting.
Once the user notices the warning, they can work around the hang by
unbinding the VT from fbcon, removing the device, or forcing a shutdown
via SysRq.

[1] https://gist.github.com/YsuOS/fbcd181752594af35f954953a1d260b8
[2] https://lore.kernel.org/all/8a986c52-964f-42a5-b063-fbe2b242ca36@collabora.com/
---
 drivers/gpu/drm/virtio/virtgpu_vq.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index 68d097ad9d1d..a546130d3b6a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -410,8 +410,13 @@ static int virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
 	if (vq->num_free < elemcnt) {
 		spin_unlock(&vgdev->ctrlq.qlock);
 		virtio_gpu_notify(vgdev);
-		wait_event(vgdev->ctrlq.ack_queue,
-			   vq->num_free >= elemcnt || vgdev->vqs_released);
+		while (!wait_event_timeout(vgdev->ctrlq.ack_queue,
+					   vq->num_free >= elemcnt ||
+					   vgdev->vqs_released,
+					   5 * HZ) && !vgdev->vqs_released)
+			DRM_WARN("ctrlq waiting for host: no free space for %d secs\n",
+				 5);
+
 		/*
 		 * Set by virtio_gpu_release_vqs() to unblock
 		 * synchronize_srcu() wait in drm_dev_unplug().
@@ -592,8 +597,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,
 	ret = virtqueue_add_sgs(vq, sgs, outcnt, 0, vbuf, GFP_ATOMIC);
 	if (ret == -ENOSPC) {
 		spin_unlock(&vgdev->cursorq.qlock);
-		wait_event(vgdev->cursorq.ack_queue,
-			   vq->num_free >= outcnt || vgdev->vqs_released);
+		while (!wait_event_timeout(vgdev->cursorq.ack_queue,
+					   vq->num_free >= outcnt ||
+					   vgdev->vqs_released,
+					   5 * HZ) && !vgdev->vqs_released)
+			DRM_WARN("cursorq waiting for host: no free space for %d secs\n",
+				 5);
+
 		/* See comment in virtio_gpu_queue_ctrl_sgs(). */
 		if (vgdev->vqs_released) {
 			free_vbuf(vgdev, vbuf);

---
base-commit: b9e2d5cdaab05c997be3a69d9b372d7676683e1b
change-id: 20260616-virtiogpu_add_timeout-33e985718c22

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

