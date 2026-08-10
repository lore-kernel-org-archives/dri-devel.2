Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52218C5AC82
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:05:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 562CA10E7FB;
	Mon, 10 Aug 2026 12:05:38 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout04.xfusion.com [36.139.87.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2B910E7F9
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 12:05:35 +0000 (UTC)
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
 by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4hJYKZ3QBdzBGV5D;
 Mon, 10 Aug 2026 20:02:42 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Mon, 10 Aug 2026 20:05:21 +0800
From: shechenglong <shechenglong@xfusion.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Sam Ravnborg
 <sam@ravnborg.org>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <stone.xulei@xfusion.com>, <chenjialong@xfusion.com>, shechenglong
 <shechenglong@xfusion.com>
Subject: [PATCH] drm: Fix NULL pointer dereference in drm_minor_alloc() on
 error path
Date: Mon, 10 Aug 2026 20:05:09 +0800
Message-ID: <20260810120509.784-1-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.82.130.100]
X-ClientProxiedBy: wuxpheds03048.xfusion.com (10.32.143.30) To
 wuxpheds03048.xfusion.com (10.32.143.30)
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

When drm_sysfs_minor_alloc() fails (e.g., due to -ENOMEM), the
following Oops occurs because an ERR_PTR is passed to put_device():

  BUG: kernel NULL pointer dereference, address: 0000000000000030
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  RIP: 0010:kobject_put+0xd/0x60
  Call Trace:
   drm_minor_alloc_release+0x1c/0x50 [drm]
   drm_managed_release+0x96/0x160 [drm]
   drm_dev_init+0x269/0x330 [drm]
   drm_dev_alloc+0x3f/0x80 [drm]
   virtio_gpu_probe+0x40/0x180 [virtio_gpu]
   virtio_dev_probe+0x1fd/0x360
   ...
   do_syscall_64+0xaf/0x500
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

The call path that leads to this crash is:

  virtio_gpu_probe()
    drm_dev_alloc()
      drm_dev_init()
        drm_minor_alloc()              // allocates minor
          drm_sysfs_minor_alloc()      // returns ERR_PTR(-ENOMEM)
          minor->kdev = ERR_PTR(-ENOMEM)  // stored directly
          return -ENOMEM
        // drm_dev_init() fails, triggers cleanup:
        drm_managed_release()
          drm_minor_alloc_release(dev, minor)
            put_device(minor->kdev)     // ERR_PTR(-ENOMEM) dereferenced
              kobject_put()             // crashes at address 0x30

drm_minor_alloc() assigns the return value of drm_sysfs_minor_alloc()
directly to minor->kdev, even when it is an error pointer.  The
subsequent cleanup unconditionally calls put_device(minor->kdev),
which dereferences the error pointer and causes a NULL-pointer
dereference (offset 0x30 into a non-page-mapped area).

Fix this by using a temporary variable to hold the result of
drm_sysfs_minor_alloc().  If the allocation fails, we return the error
immediately, leaving minor->kdev as NULL (the whole minor structure is
zero-allocated).  put_device(NULL) is explicitly allowed and safe.

Fixes: f96306f9892b ("drm: manage drm_minor cleanup with drmm_")

Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 drivers/gpu/drm/drm_drv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index 675675480..2348fbb21 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -143,6 +143,7 @@ static void drm_minor_alloc_release(struct drm_device *dev, void *data)
 static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 {
 	struct drm_minor *minor;
+	struct device *kdev;
 	int r;
 
 	minor = drmm_kzalloc(dev, sizeof(*minor), GFP_KERNEL);
@@ -164,9 +165,11 @@ static int drm_minor_alloc(struct drm_device *dev, enum drm_minor_type type)
 	if (r)
 		return r;
 
-	minor->kdev = drm_sysfs_minor_alloc(minor);
-	if (IS_ERR(minor->kdev))
-		return PTR_ERR(minor->kdev);
+	kdev = drm_sysfs_minor_alloc(minor);
+	if (IS_ERR(kdev))
+		return PTR_ERR(kdev);
+
+	minor->kdev = kdev;
 
 	*drm_minor_get_slot(dev, type) = minor;
 	return 0;
-- 
2.43.0

