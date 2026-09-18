Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BAC2C982D7
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 23:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7839310E38B;
	Fri, 18 Sep 2026 23:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cTke2d2w";
	dkim-atps=neutral
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com
 [74.125.230.235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE99010E38B
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 23:54:19 +0000 (UTC)
Received: by mail-qk2-f43.google.com with SMTP id
 d75a77b69052e-530280b8234so6534191cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 16:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789775658; x=1790380458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XdY92PMLKIgjJ7iJT5OfPO8aY0kcQJ8wiVZMdQNIWQk=;
 b=cTke2d2wDtaDKXfzxBjbIHBDiPtmkhnKh826EJa47wEGeJZt6ljtkCRCzBxPVsg109
 Q6UG+o2iLMinhjraOc1FUhRZMz9mXHhz+PlDz6qqBTGyrcbaIlsJGQER975zmI4rAIrx
 hXBGG3P2X7L/N5D2PtZ/3FZYWwTrSGgq/EobLE+w7PEN0Z3HtXk5cRQUsiRqDtwOReTE
 f6wmrW7Dw8nAuHZEe4duqkyVX/P79e1WwCPCM3AtrKlXjA58sNv7MShHSj5mLvgP1dZO
 4cAzlLV9QOQ4wnSVHel5FGPuneO1dNMm3KJBxm23tM+hSX47j5ihPLK7SsTHjHaX3oLI
 TVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789775658; x=1790380458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XdY92PMLKIgjJ7iJT5OfPO8aY0kcQJ8wiVZMdQNIWQk=;
 b=oyTggiPdfVJ86TaHdkZKAPQwWYqeBSazhB5TKZhu3MXnt2ddZ+bdBhlWZuxP0vsB9I
 N5vmKcGN4gPCroUiNLJ4NNh0IwZ+cuWmRdgFo+icJ71njqnguVCPYHZO7kYdVnE3sv/g
 ILFSLGFsfhMl+FXDyalAi0Px4H/q/9NRVg9DPjzMEIRbQGG/WRZ7oSwMFVqLlar6aKbq
 U9godfnsa4aSmNn7xpnU/oZdTysNdUPJcMLY6RlPSAs25w+oFzy+VwO6/oa/doVYb4vW
 2MvGEiMq/QP3MW+w+8FW8+MWxaKf+wdQ8C1vT1ttIgtGKoCCouJ24696Z6sM1mQGW7nZ
 IrPg==
X-Forwarded-Encrypted: i=1;
 AKwUvByslRM7DGNq0hC/tBcLyTF7seJSMTF/1UmUsIcUPqGd7elDo23x9/LnyYUTTPjjh8nMmiKYAgkQYAY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/NjoVCrzplUegRiN9baInXvR68N0hSZY3KeHzM2SFgf0BCR4Y
 E+oLF2ime435q+zhnyudGg/iwusVSwM9kVacvb79RhTcJbn/VEWykhMA
X-Gm-Gg: AYBFou3zc6qYFC/LiVNmWLqFYa5+P0mjF3u08cpayDUwBpy2e0xFNEIwjBOXb9lPwsa
 6Yvu5kWKLnTxAMdsYsBJDlkZCFxU55VMQxfMHIsX0Y/o3p9Uoihclcw4yRCb5sLKzxS6pLp+Dx3
 GnkJIur1JydquOrXCNcwxaP0D4kNVUKTG0Y7q+ZUaQtkaeHstoP6Rwjw3AEjztV211s5ee4+hNs
 /z1nsiz2RQhqpj5WQ9jWN3JsKKIMk5YMQEQUZFn4SsnGD4PxHnxM4uHwd97I0zQQn2oG9WDJK3+
 u3xpEGsX0Ic4xulbdIzpOArBQKXyuW63UpwSaN7FYqEeeyayIwDRXmrD0I8Y5knh1lqIvP6WxaB
 81+8K+vMo2v572qGJtnsiHTBu4r1q92shLABETa/ybyGZD0GcWpq/xOUyrno238avNHy1WC+Uch
 MYsRjmTVLIQj4qlc2gzUPEMJSSHXqoK4TE2fJatjVuXfaNDgfgw1Qard5AaXn6e2gL0teMqZBuN
 Vz94dsIOUi0SXoMJiqbHm2TEdJUKLs+JxsZMcPtR+5XpB9WIR3NjA==
X-Received: by 2002:a05:622a:614:b0:530:514f:3c3d with SMTP id
 d75a77b69052e-5329e793881mr65771251cf.11.1789775658468; 
 Fri, 18 Sep 2026 16:54:18 -0700 (PDT)
Received: from localhost.localdomain (static-173-249-255-168.cust.tzulo.com.
 [173.249.255.168]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532ae77acccsm8517991cf.30.2026.09.18.16.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 16:54:18 -0700 (PDT)
From: Forest Crossman <cyrozap@gmail.com>
To: hansg@kernel.org
Cc: Forest Crossman <cyrozap@gmail.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/gm12u320: fix system freeze on surprise unplug
Date: Fri, 18 Sep 2026 18:53:49 -0500
Message-ID: <20260918235351.398269-1-cyrozap@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Unplugging (or deauthorizing) a GM12U320 device while it is driving an
output causes the system to freeze. When this happens, other screens
stop updating and USB input (keyboard and mouse) stops working, but
non-USB storage, audio, network and ACPI events are unaffected. Because
the unplug never completes, the only way out is a reboot.

The kernel log shows a NULL pointer dereference on every such unplug:

  BUG: kernel NULL pointer dereference, address: 0000000000000030
  RIP: 0010:drm_mode_object_put+0x9/0x20
  Call Trace:
   drm_atomic_helper_commit_crtc_disable
   drm_atomic_helper_commit_tail
   commit_tail
   drm_atomic_helper_commit
   drm_atomic_commit
   drm_atomic_helper_disable_all
   drm_atomic_helper_shutdown
   gm12u320_usb_disconnect
   usb_unbind_interface
   ...
   usb_set_configuration
   usb_deauthorize_device
   authorized_store

The call trace above was caused by triggering a deauthorization, but a
physical unplug reaches the same gm12u320_usb_disconnect() path through
hub_event/usb_disconnect().

The task faults while holding the USB device mutex
(usb_set_configuration()) and the DRM modeset locks taken by
drm_atomic_helper_shutdown(). Mutexes are not released when a task dies
in an oops, so they stay locked forever, with the USB hub workqueue
(hub_event) and the DRM framebuffer-removal worker both blocking on
them. This is what freezes the system when the driver crashes.

gm12u320_stop_fb_update() drops the cached upload framebuffer
unconditionally:

  old_fb = gm12u320->fb_update.fb;
  gm12u320->fb_update.fb = NULL;
  ...
  drm_framebuffer_put(old_fb);

gm12u320->fb_update.fb is legitimately NULL when no update is queued,
for example when the update was already stopped, and
drm_framebuffer_put() does not accept NULL. On unplug,
gm12u320_usb_disconnect() calls drm_atomic_helper_shutdown(), which
commits a CRTC disable and reaches gm12u320_stop_fb_update() with a NULL
fb.

The NULL check was lost in commit 8f2cb9379fb4 ("drm/gm12u320: Simplify
upload work"). That commit moved the reference release out of
fb_update.lock (so the framebuffer destructor does not run under the
lock), but the previous form guarded the call with "if
(gm12u320->fb_update.fb)" and that check was dropped in the rewrite.
gm12u320_fb_mark_dirty() still has the same guard.

To fix the crash, restore the NULL check before calling
drm_framebuffer_put(). With this, the CRTC disable completes, no locks
are leaked, and unplugging the GM12U320 device while it is in use no
longer freezes the system. Tested by surprise-unplugging the device as
the active output--before the change the kernel oopsed and wedged on
every attempt, after it there is no oops and no stuck task.

Fixes: 8f2cb9379fb4 ("drm/gm12u320: Simplify upload work")
Cc: stable@vger.kernel.org
Signed-off-by: Forest Crossman <cyrozap@gmail.com>
---
 drivers/gpu/drm/tiny/gm12u320.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index 4ad074337af0..5bb6488556de 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -446,7 +446,8 @@ static void gm12u320_stop_fb_update(struct gm12u320_device *gm12u320)
 	iosys_map_clear(&gm12u320->fb_update.src_map);
 	mutex_unlock(&gm12u320->fb_update.lock);
 
-	drm_framebuffer_put(old_fb);
+	if (old_fb)
+		drm_framebuffer_put(old_fb);
 }
 
 static int gm12u320_set_ecomode(struct gm12u320_device *gm12u320)

base-commit: 1717fcc5be575d4768279148ae9465a8b13d4339
-- 
2.55.0

