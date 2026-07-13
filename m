Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD838C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 13:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03DA110E98E;
	Mon, 13 Jul 2026 13:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="Jy8/bqwm";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 115D210E984
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783947679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bIN4Uwhb8SwPUKKjdKqPp/oSbTdbYDS5rLSl3N5RmDg=;
 b=Jy8/bqwmGgDs4QJk62IEjnPc4ocCf/g8dQijbH5Muh+FPWsQQjs+baCM/l0opQmh+We5td
 C2uFz1+iaSKQwH4h/NKLt8Es5TuKQFxV3y09bYamwBOOEKpBasb8rVyv0nE8oSxzOQ5coi
 D0gE77u7O9D38aTmq1cpzg5VH253X9k=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-h-85zVtMOaWmNiMJarzP7Q-1; Mon, 13 Jul 2026 09:01:16 -0400
X-MC-Unique: h-85zVtMOaWmNiMJarzP7Q-1
X-Mimecast-MFC-AGG-ID: h-85zVtMOaWmNiMJarzP7Q_1783947675
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso3218109a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 06:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947675; x=1784552475;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bIN4Uwhb8SwPUKKjdKqPp/oSbTdbYDS5rLSl3N5RmDg=;
 b=r0DtphZC3e6eyLKgeuDfdQBaWHUBgzKa8q0oTNoDgfxhlXDqgatNNoFe8+CVcx5MXh
 JC6fwLd0XSqgaulrYpjrZroOFM/KWoRBiRWjfcDm1kT+3Nur/ri1ozONpgxTOoPo6B4F
 4XA28k6EQEYb9bWQBR3PLplJ0QaR99hP0aZANgFzCsN1f+EbzllFS6Tl/Y9aVwaLh9PC
 8GHGL3c9TyZsnBkC4hEhs0z+gyoJlFQR/GCdyp67rOJtmlRTJ5/7Ax0GHFeffhTetHe2
 sjIr2mkMvM+YRm3SyzLvJDmQKLHVf+QY2QDRjNOA/N91WZRCzzLg2GfSldWZDHDgSQIo
 NXgw==
X-Gm-Message-State: AOJu0YzxpUsdP4MY7yB6SdjhwYBnyRtzgnDGtcQsq2sTtj8VnNxouLL+
 06XGalBlIXvUEq62WWtQHjA/me8P0cXxlRZN/a5jf+46inFxnahtWSDVoGgSMMKGIK5Ycpw6QNK
 ooRuqxzzVW0NczfkHbh0R7b56dDI1nygc/n2Stb2xj/2/ZpEfBgewnRZ6ZpukcM5rYqqt1A==
X-Gm-Gg: AfdE7cmafOjZRbwnx9hkZiEyGTbiolaNCsLbE9hcr5BCwfu/1JR7hGLU1hleTXneffC
 E2uA068G3XryPrEqzZPm6jMyfA850CRnhlH5wyW+GAx3zT1KFkZMX87IsHrGQGnQVs0ryDSaeu9
 jXmT4YTBCqgMUEj8QtR7Ad9c+HCmPlpZynK5mOl64QbrSlF0Drxk2ctiVsTiUikvDKTqQ8NTOUw
 LZAGXzoH9s122ofYcBe2pQvT21fxchmgsReqw+qq0FvY8Q39F/NqAdEhA83pKvmwNKVS2T2J87h
 SRh6j0SZKaAAix4rEcFnCbNQY4DAxjJuwJcKDtqHpeDJMaoq1/t0tJS0x37iNcaIkpMAH+lUJgV
 uifQ/2mpCIPYlbf/R9+ot8t4yTt6JjercS1Ywnrhm5cDdm85h
X-Received: by 2002:a05:6a00:1d90:b0:845:e9e8:6458 with SMTP id
 d2e1a72fcca58-84889703f26mr7907405b3a.20.1783947674911; 
 Mon, 13 Jul 2026 06:01:14 -0700 (PDT)
X-Received: by 2002:a05:6a00:1d90:b0:845:e9e8:6458 with SMTP id
 d2e1a72fcca58-84889703f26mr7907345b3a.20.1783947674363; 
 Mon, 13 Jul 2026 06:01:14 -0700 (PDT)
Received: from ryasuoka-thinkpadx1carbongen9.tokyo.csb ([126.143.164.49])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84909673e32sm3183069b3a.56.2026.07.13.06.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 06:01:13 -0700 (PDT)
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
Date: Mon, 13 Jul 2026 22:01:00 +0900
Subject: [PATCH v2] drm/virtio: fix deadlock in display_info_cb by removing
 hotplug from dequeue worker
MIME-Version: 1.0
Message-Id: <20260713-virtiogpu_syzbot-v2-1-2958fa37d46d@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNzQ7CIBCEX6XZs5gF0/pz8j1MYygs7R4sDSCxN
 n13sfHm8ZvJfLNApMAU4VItEChzZD8WULsKzKDHngTbwqBQNdjIs8gcEvt+et7j/O58Ep3VXY0
 n54ytocymQI5fm/LWFh44Jh/m7SHLb/qTHfBflqWQArXGptTHGukayA467Y1/QLuu6wd/koZ6s
 QAAAA==
X-Change-ID: 20260619-virtiogpu_syzbot-bdab508ffcd5
To: David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Ryosuke Yasuoka <ryasuoka@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BM9UC5YCHFBASh45GmfJv-6J_jqLgTk-a0j-nvGJySI_1783947675
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

A probe-time deadlock can occur between the dequeue worker and
drm_client_register(). During probe, drm_client_register() holds
clientlist_mutex and calls the fbdev hotplug callback, which triggers an
atomic commit that ends up sleeping in virtio_gpu_queue_ctrl_sgs()
waiting for virtqueue space. The dequeue worker that would free that
space calls virtio_gpu_cmd_get_display_info_cb(), which invokes
drm_kms_helper_hotplug_event() -> drm_client_dev_hotplug(), attempting
to acquire the same clientlist_mutex. Since wake_up() is only called
after the resp_cb loop, the probe thread is never woken and both threads
deadlock.

Fix this by removing the hotplug notification from
virtio_gpu_cmd_get_display_info_cb(). The display data (outputs[i].info)
is still updated synchronously in the callback.

For the init path, drm_client_register() already fires an initial
hotplug when the client is registered, which picks up the connector
state updated by display_info_cb.

For the runtime config_changed path, add a wait_event_timeout() in
config_changed_work_func() so that display_info_cb updates the connector
data before the hotplug notification is sent. Also replace
drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event() since
virtio-gpu never calls drm_kms_helper_poll_init() and thus
drm_helper_hpd_irq_event() always returns false without doing anything.

Fixes: 27655b9bb9f0 ("drm/client: Send hotplug event after registering a client")
Closes: https://syzkaller.appspot.com/bug?id=d6dd6f86d3aaf7eebe7406e45c1c6e549453f224
Closes: https://syzkaller.appspot.com/bug?id=908bd910da5dd79b88de4cf7baf376cc873a922e
Suggested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
I checked whether drm_helper_hpd_irq_event() is needed in
virtio_gpu_init(), as Dmitry suggested. AFAIS, it is not needed because:

1. drm_helper_hpd_irq_event() is always a no-op in virtio-gpu.
   It returns false immediately probe_helper.c:1088 because
   dev->mode_config.poll_enabled is false — virtio-gpu never calls
   drm_kms_helper_poll_init(). Even if it passed that gate, no
   virtio-gpu connectors set DRM_CONNECTOR_POLL_HPD.

1082 bool drm_helper_hpd_irq_event(struct drm_device *dev)
1083 {
...
1088         if (!dev->mode_config.poll_enabled)
1089                 return false;

2. virtio_gpu_init() runs before drm_dev_register() and
   drm_client_setup(), so no DRM clients are registered yet.
   drm_kms_helper_hotplug_event() would iterate an empty client list.
   The initial hotplug is handled by drm_client_register(), which fires
   a hotplug callback to the newly registered client. By that time,
   display_info_cb has already updated the connector data.

For the same reason, drm_helper_hpd_irq_event() in
config_changed_work_func() was also a no-op. The actual runtime hotplug
notification was always delivered by display_info_cb's call to
drm_kms_helper_hotplug_event(). This patch replaces it with a direct
drm_kms_helper_hotplug_event() call after waiting for the display info
response.
---
Changes in v2:
- Dropped the work_struct approach from v1.
- Instead, removed the hotplug calls from display_info_cb entirely, as
suggested by Dmitry.
- Added wait_event_timeout() in config_changed_work_func() so that the
display info response is received before sending the hotplug
notification.
- Replaced drm_helper_hpd_irq_event() with drm_kms_helper_hotplug_event()
in config_changed_work_func() since drm_helper_hpd_irq_event() is
always a no-op in virtio-gpu (poll_enabled is never set).
- No changes to virtio_gpu_init() — drm_client_register() already
handles the initial hotplug and hotplug event does nothing before DRM
device/client has been registered.
- Link to v1: https://lore.kernel.org/r/20260630-virtiogpu_syzbot-v1-1-0aa06630750e@redhat.com
---
 drivers/gpu/drm/virtio/virtgpu_kms.c | 5 ++++-
 drivers/gpu/drm/virtio/virtgpu_vq.c  | 3 ---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
index cfde9f573df6..b4329f28e976 100644
--- a/drivers/gpu/drm/virtio/virtgpu_kms.c
+++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
@@ -49,7 +49,10 @@ static void virtio_gpu_config_changed_work_func(struct work_struct *work)
 				virtio_gpu_cmd_get_edids(vgdev);
 			virtio_gpu_cmd_get_display_info(vgdev);
 			virtio_gpu_notify(vgdev);
-			drm_helper_hpd_irq_event(vgdev->ddev);
+			wait_event_timeout(vgdev->resp_wq,
+					   !vgdev->display_info_pending,
+					   5 * HZ);
+			drm_kms_helper_hotplug_event(vgdev->ddev);
 		}
 		events_clear |= VIRTIO_GPU_EVENT_DISPLAY;
 	}
diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
index c8b9475a7472..e5e1af8b8e8a 100644
--- a/drivers/gpu/drm/virtio/virtgpu_vq.c
+++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
@@ -840,9 +840,6 @@ static void virtio_gpu_cmd_get_display_info_cb(struct virtio_gpu_device *vgdev,
 	vgdev->display_info_pending = false;
 	spin_unlock(&vgdev->display_info_lock);
 	wake_up(&vgdev->resp_wq);
-
-	if (!drm_helper_hpd_irq_event(vgdev->ddev))
-		drm_kms_helper_hotplug_event(vgdev->ddev);
 }
 
 static void virtio_gpu_cmd_get_capset_info_cb(struct virtio_gpu_device *vgdev,

---
base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
change-id: 20260619-virtiogpu_syzbot-bdab508ffcd5

Best regards,
-- 
Ryosuke Yasuoka <ryasuoka@redhat.com>

