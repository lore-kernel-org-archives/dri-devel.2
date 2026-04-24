Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71D5FED3C2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 12:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F6C10F58A;
	Fri, 24 Apr 2026 12:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="KHzSF6tl";
	dkim-atps=neutral
X-Greylist: delayed 13699 seconds by postgrey-1.36 at gabe;
 Fri, 24 Apr 2026 12:45:37 UTC
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4622E10F58A
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 12:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=5r
 0o7mLKi250C8auX2QzQkF3sv+tYItmksBtWh9gy6E=; b=KHzSF6tljpR9gH9CwO
 D68jxylwibcSyIPVr1vLnOc94iqRz9qIxKG/FnQBx85jU7FqNYpq5ScKOJJ8uiTf
 vI6QY5pTt9W4fzup/qSAaRi3OYUd5ydK3o+q2WRsND+VNEWEwBLt9lv54HJrcq/f
 MiePjuS32Je+l9URJ6+zmXMsM=
Received: from localhost.localdomain (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAXzs63ZetpEjsBBg--.49385S2; 
 Fri, 24 Apr 2026 20:44:40 +0800 (CST)
From: Shixiong Ou <oushixiong1025@163.com>
To: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH v3] drm/udl: Increase GET_URB_TIMEOUT
Date: Fri, 24 Apr 2026 20:44:27 +0800
Message-ID: <20260424124427.657-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.47.1.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXzs63ZetpEjsBBg--.49385S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WFyUtrW3ZrW5WFWUJrWfuFg_yoW8try7pF
 srJrWjyrW5ZFWDta17tF4vya43Jay3GaykGrZ7Gas3u3WUtrn8J34kAryYgFy8Z3srCF1a
 qrs2vrZ0vF45Ar7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uq385UUUUU=
X-Originating-IP: [2409:8a50:670:d630:dc9b:2ee6:e45e:c77b]
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbC-hjc62nrZbjkCwAA3h
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

From: Shixiong Ou <oushixiong@kylinos.cn>

[WHY]
A situation has occurred where udl_handle_damage() executed successfully
and the kernel log appears normal, but the display fails to show any output.
This is because the call to udl_get_urb() in udl_crtc_helper_atomic_enable()
failed without generating any error message.

[HOW]
1. Increase timeout of getting urb.
2. Add error messages when calling udl_get_urb() failed in
udl_crtc_helper_atomic_enable().

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
v3: Remove GET_URB_TIMEOUT macro and pass 2 * HZ directly.

 drivers/gpu/drm/udl/udl_main.c    | 3 +--
 drivers/gpu/drm/udl/udl_modeset.c | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index bc58991a6f14..b4c23dbcf3e3 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -285,13 +285,12 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
 	return unode->urb;
 }
 
-#define GET_URB_TIMEOUT	HZ
 struct urb *udl_get_urb(struct udl_device *udl)
 {
 	struct urb *urb;
 
 	spin_lock_irq(&udl->urbs.lock);
-	urb = udl_get_urb_locked(udl, GET_URB_TIMEOUT);
+	urb = udl_get_urb_locked(udl, HZ * 2);
 	spin_unlock_irq(&udl->urbs.lock);
 	return urb;
 }
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 231e829bd709..1ca073a4ecb2 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -21,6 +21,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
@@ -342,8 +343,10 @@ static void udl_crtc_helper_atomic_enable(struct drm_crtc *crtc, struct drm_atom
 		return;
 
 	urb = udl_get_urb(udl);
-	if (!urb)
+	if (!urb) {
+		drm_err_ratelimited(dev, "get urb failed when enabling crtc\n");
 		goto out;
+	}
 
 	buf = (char *)urb->transfer_buffer;
 	buf = udl_vidreg_lock(buf);
-- 
2.47.1.windows.2

