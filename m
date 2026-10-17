Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A47CCF2CF
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3669E10E656;
	Sun, 18 Oct 2026 14:53:15 +0000 (UTC)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1328E10E096
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 15:35:44 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3ab868eb9cfso493778a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792251343; x=1792856143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cSCIoQiIuzOVCfYEbcmwZdLYkQEpSik/mWoNdRkPnwc=;
 b=e7shroJCp0Q/e2smOeU+XKHXycgacI3bxg10WUDXgJE/IovGrulagC87qDYhIK9V7B
 OKBZa26dy7tJPze7rk5iOX7aN3tbJF1sTz2AeKro8mZtU5Xf7Sif7neX8J39iVdVksil
 guSy8hQCnAsKvjScwZaSofb24UMTmRt3xJCzrJED02BsuC6DmoP53kTYAeHcYxY3EPpE
 dXJudeUGBpzoiqkbhP6fNn7fRaU5ZRIApfA/h5yr0A6Qlr/c4fQhtABqw5qMspFZkDZM
 0MViD4vr8SyzNnEi/Hpmn7kcVSAE1B/NFlT9bIkGKWB5Jx8Nzoko7yqm+AQTqFlEc6Kp
 JHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792251343; x=1792856143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cSCIoQiIuzOVCfYEbcmwZdLYkQEpSik/mWoNdRkPnwc=;
 b=zYQiZMLb5LEylkcQOu8G6vIVtWHmJFA4AfddRfwjfNyX8o5IPlIRHHJePm3IZ7/17n
 5bSv19W3Xk6y/RwUMn5JEkHAgqaN1Km2rjSRkKxDMLpNoq803UMWkyr/y1mvQzMaOBGs
 P/ysUf9QwU7DebtIxtBfefupzpb6y3IkwdTTABM4csHmLXYfo9PdHFVIWIe8bHlW/iVK
 ZtpvnjF1p8Vdmy2vhyT4yinOtCxXbvUmpoZ2oJfC7ZbK2SjQUQ+A1lKwbXhVp7wcMh0D
 09i2fYycGpCrYHPEjYvBxhaXjZZcKI5ZnBmub/mzDdhuLn8mZXarVpy7VO1ME7zMnGYU
 wxwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTNTnd3X7E8mkiSo9VzarKEgcD88CAZQPed7RPvV6I6FEC5Dy4ORV5Yo9qlR9THGN93eu8VkgAdIw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTK3XOPJQV/wSRLr7yStPOu+3BNQCymCjaPt62i2eS+93Ll2sS
 J18j+cIN/kNsCWufBYE2Tjs6ZCR3nd8d1LmLOQIvPmltosEdcu/n4hKw
X-Gm-Gg: AYBFou3gG80X9REUN3WGjgOFWORwniXYdUA3hYyasyoNp9b1A3N/xTfVkLFuxf4pQ3a
 5c+ICnfhqsiPAddL7mB7AMLyW1y8mF51OyjbW6MgJqPjw2rPO09ev0DZL0AVAHxnNwZ97x/KZ27
 DEi1/vYi50Hbj+bccojfJ3O8dRYFRsDLOH1B2yRre5hsvf25X0cGxDXxyDQrS9kkP3dTbnPAmWp
 ML1oqlciVD1vWVi/FPwBP42Po/YeQTmPtarpbZDXUub7kdLqUWxhN7jyELGOJpxwByhxw1gc99t
 rBRvg2jE/1lWx8JV5+zzr/Q3hpmy2U7GXq43aatZr86eaqnI7fVaNEcjExO4xZEeC06AkfIf16z
 eRuApj48flmS2mcLReH6W5vmwNxpwCIn0qgWif8UtWX/d9iWpcJmzL9soyOHrYwgVJLu3Kue0zP
 +FA9LMMgBFAuHOcLCMEPyE6i6Mpc/905WnmAdb6cghJ6lsmm6+xnuDj8gAkE3dT8pCstmA
X-Received: by 2002:a17:90b:590c:b0:3ab:1b19:78f0 with SMTP id
 98e67ed59e1d1-3acef2b52e6mr3075121a91.41.1792251343394; 
 Sat, 17 Oct 2026 08:35:43 -0700 (PDT)
Received: from hachimi ([101.5.168.240]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9474b52fsm15330221a91.9.2026.10.17.08.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 08:35:42 -0700 (PDT)
From: Lanfeng Wei <xlfylawarthur@gmail.com>
To: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-hyperv@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, Lanfeng Wei <xlfylawarthur@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Date: Sat, 17 Oct 2026 23:34:30 +0800
Message-ID: <20261017153524.8870-1-xlfylawarthur@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

A performance regression has been observed on Hyper-V causing serious
frame rate drops since commit 52e6b1988334 ("drm/hypervdrm: Use vblank
timer").

The regression occurs when using Xorg with a software rendered cursor.
The offending commit uses the DRM vblank hrtimer to pace atomic update
completion events, making each event wait for the next simulated vblank.
However, cursor damage invoked by mouse movement is unconstrained by
screen refresh rate, and therefore consumes most of Xorg's update
opportunities, starving normal graphical updates, resulting in
plummeting frame rate.

Hyper-V virtual display framebuffer is able to accept multiple writes in
one update window, so the commit broke this expected behavior.

The regression is also reported by other users:

Link: https://www.mail-archive.com/ubuntu-bugs@lists.ubuntu.com/msg6302857.html

Add a read-only module parameter hyperv_drm.vblank_timer, which is
enabled by default. Disabling it prevents the timer's enable callback
from starting the timer. The vblank framework and the existing atomic
callbacks remain registered. When disabled, the first
drm_crtc_vblank_get() fails through the callback, so the existing helper
sends the atomic event immediately and skips the vblank wait, matching
the behavior before the timer was introduced.

This provides an opt-out for affected virtual display users.

Benchmark results:

Workload: Inject mouse movement at 125 Hz against a flashing
animation running at 60 Hz, matching the screen refresh rate, for 4
seconds.

Tested versions: 6.18 (the last major version before the offending
commit), version 6.19 (the first major version containing that commit),
version 7.1.8 (on which the patch is based), and its patched version.

Version  Anim. Hz            Mouse Hz         Max client-request gap
====================================================================
6.18     59.66-60.00        122.00-123.33     17.0 ms
6.19     0-0.162            59.73-59.86       7.53 s
7.1.8    0.133-0.162        59.83-59.86       6.16 s
Patched  59.75-60.00        122.75-124.50     14.0 ms

The patch restores both animation and mouse update rates, and reduces
the maximum client-request gap from seconds to milliseconds.

Fixes: 52e6b1988334 ("drm/hypervdrm: Use vblank timer")
Cc: stable@vger.kernel.org
Signed-off-by: Lanfeng Wei <xlfylawarthur@gmail.com>
---
The parameter defaults to enabled to preserve the current kernel
behavior. I do not know the full set of users who rely on the vblank
timer, so changing the default could introduce a different regression.
Affected users can set hyperv_drm.vblank_timer=0.

If the maintainers prefer the parameter to default to disabled, or if
there is a better way to detect the affected configuration
automatically, I'm happy to send a v2.
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 23 ++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index d48ca6c23..527385748 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/hyperv.h>
+#include <linux/moduleparam.h>
 
 #include <drm/drm_atomic.h>
 #include <drm/drm_crtc_helper.h>
@@ -25,6 +26,19 @@
 
 #include "hyperv_drm.h"
 
+static bool vblank_timer = true;
+module_param(vblank_timer, bool, 0444);
+MODULE_PARM_DESC(vblank_timer,
+		 "Enable the Hyper-V DRM vblank timer (default: true)");
+
+static int hyperv_crtc_enable_vblank(struct drm_crtc *crtc)
+{
+	if (!vblank_timer)
+		return -EOPNOTSUPP;
+
+	return drm_crtc_vblank_helper_enable_vblank_timer(crtc);
+}
+
 static int hyperv_blit_to_vram_rect(struct drm_framebuffer *fb,
 				    const struct iosys_map *vmap,
 				    struct drm_rect *rect)
@@ -132,7 +146,14 @@ static const struct drm_crtc_funcs hyperv_crtc_funcs = {
 	.page_flip = drm_atomic_helper_page_flip,
 	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_crtc_destroy_state,
-	DRM_CRTC_VBLANK_TIMER_FUNCS,
+	/*
+	 * expanded DRM_CRTC_VBLANK_TIMER_FUNCS to override
+	 * enable_vblank with hyperv_crtc_enable_vblank
+	 */
+	.enable_vblank = hyperv_crtc_enable_vblank,
+	.disable_vblank = drm_crtc_vblank_helper_disable_vblank_timer,
+	.get_vblank_timestamp =
+		drm_crtc_vblank_helper_get_vblank_timestamp_from_timer,
 };
 
 static int hyperv_plane_atomic_check(struct drm_plane *plane,
-- 
2.55.0

