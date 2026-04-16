Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8383F8A14A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:05:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F0710E872;
	Thu, 16 Apr 2026 09:05:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=qq.com header.i=@qq.com header.b="b92akC9B";
	dkim-atps=neutral
X-Greylist: delayed 366 seconds by postgrey-1.36 at gabe;
 Thu, 16 Apr 2026 09:05:21 UTC
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com
 [162.62.57.210])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DEF010E86B
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1776330317; bh=N3ramACyPhXUAZW93RdREYCDRdJX0tWNQOLNEHoTlPA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b92akC9B3XLudN/a03P0UBz2cgnHqLB43/OLylUmeijb4rHSxpm42juktMeUoffb8
 T/+m9pAuVohkQdro+XpdfErvmVodNRG9k/8Oj8vrHkfuM+zYsECmmKcFKeHvu7muzi
 E2VXJjY3++Rz/GZ1nwkDY+F0iYFa5XTXQ4rCGJio=
Received: from lxu-ped-host.. ([111.198.231.89])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id E74866E2; Thu, 16 Apr 2026 16:57:52 +0800
X-QQ-mid: xmsmtpt1776329872tly3okefn
Message-ID: <tencent_937883A1C441576C3765C6C5F36B43636905@qq.com>
X-QQ-XMAILINFO: NcnCCMbb94woXpv83bjolnxJvqW/8oBO4r0cPzDfFIjDMkBEQzNPnhutruWrom
 OhR7HV9G06Zne68/LX9OOSMez26cGldGKItWg7Gi/23/+y6nno9xv2JtEEfupAarfbLDdBbEE07s
 VJMtK/X8BRHrHBQbKfZM5YiclNXqQpbz42sGbRW4VqUmDxgT5Afjv5OxbwrX++a5jBJDH2ajvmcb
 0alJA6/7TGd8WORIthFWO/wgwd6/tbEv8Fmkyhc/C8BHkWpLgusopPCs3N04g0D1ERNfuVSWfYIA
 UDpDsE498YZkIN8ashuwTQVsbWmBQEfr+fVuJhCbwnIS6dlkQXgOh25FMGJaWt5FqGFD1Vz/dWFZ
 fm7adrXJ8MCjYd6OaMVrxiICgQmW+85vT3JI01Eu1FjiOUGCTyIx6ExL2DDVKcOv2vRUIXOnyRy/
 i7a43brLNwx4GWTpTken0oCARtdB0Z/ZLpWfZrOw7lG65VWz16Jze+qsz70IIbK3O6YkqP7XhauW
 N5ktRpAT0xs8RGeME61rkxHYNLXERwlclv8fVno5xpmtrBeHE8U0w/fnAqcDMl9i+Cjydz2BhVCi
 GY94o0vjX4WACL3eYEfpOym1gdidrYWFoNOxQb6xxPJHSYIMHywv963FalQOF5uLGD4R22JEGPgc
 saMcMiuGVu0h5wIV+pSfvZyy8XJ3zWizFUckpCOFHqPeM00BuN1drQ6jge2AnkWUZCqmJg/wN6yG
 7KkH2+WzShfZREKym9IkYeXhjhydjDQdlC1znAYbhcsU0be0OHL5dgxOYI0bvQWoqIcYxafxPznc
 Xzp9wmHGi1fvXpMdQFrNvXFWSxq4qyl5Eoj0+ua+nXYyV8g8LsFbn/jwSqBK7usiN+NXX7BSDj8u
 Bx9zk28tPaEplo264yhF2gykfGP+o169rmPJWOeDsJAqpM6pKk7iIKaaHbPRQkHid7UZLb7N+/UE
 MJKGSFbPNqqepu+YdxK7OKUnqBaD91iy9zT8q8JW8/eY3HdByzAOnzI+qxQ6XL/+wGAxhu0PLC3b
 3BP7g2DmTHxf6tvwJn
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b2e951687503f32f74ce@syzkaller.appspotmail.com
Cc: airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, syzkaller-bugs@googlegroups.com,
 tzimmermann@suse.de
Subject: [PATCH] drm: Avoid the chaotic interleaving of change and delete
 handle
Date: Thu, 16 Apr 2026 16:57:52 +0800
X-OQ-MSGID: <20260416085752.381974-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69dd24f4.a00a0220.468cb.004a.GAE@google.com>
References: <69dd24f4.a00a0220.468cb.004a.GAE@google.com>
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

First, let's take a look at how GEM object is freed:
CPU0					CPU1
====					====
drm_gem_change_handle_ioctl()
 drm_gem_object_lookup() // got GEM obj and refcnt is 2
 ... blocks on prime.lock
					drm_gem_handle_delete()
	                                 drm_gem_object_release_handle()
					  ... acquires prime.lock
					  drm_prime_remove_buf_handle()
					  ... unlock prime.lock
					  drm_gem_object_handle_put_unlocked()
					   drm_gem_object_put() // obj refcnt is 1
 ... acquires prime.lock
 drm_gem_object_put() // obj refcnt is 0
  drm_gem_shmem_free() // obj is freed

After a GEM object has been freed, a Use-After-Free vulnerability [1]
is triggered when closes the DRM file, as the drm_gem_release() function
attempts to access the already-freed GEM object.

Adjust the change handle ioctl and handle delete ioctl to be atomic
operations; this prevents simultaneous change and delete operations
on the same GEM object from interfering with the release of the GEM
object during the closing of the DRM file.

[1]
BUG: KASAN: slab-use-after-free in drm_gem_object_release_handle+0x4b/0x1e0 drivers/gpu/drm/drm_gem.c:374
Call Trace:
 drm_gem_object_release_handle+0x4b/0x1e0 drivers/gpu/drm/drm_gem.c:374
 idr_for_each+0x1c6/0x2a0 lib/idr.c:210
 drm_gem_release+0x28/0x40 drivers/gpu/drm/drm_gem.c:1088
 drm_file_free+0x729/0xa00 drivers/gpu/drm/drm_file.c:261
 drm_close_helper drivers/gpu/drm/drm_file.c:290 [inline]
 drm_release+0x2de/0x3f0 drivers/gpu/drm/drm_file.c:438

Allocated by task 6090:
 __drm_gem_shmem_create+0xc4/0x2e0 drivers/gpu/drm/drm_gem_shmem_helper.c:130
 drm_gem_shmem_create drivers/gpu/drm/drm_gem_shmem_helper.c:157 [inline]
 drm_gem_shmem_create_with_handle drivers/gpu/drm/drm_gem_shmem_helper.c:460 [inline]
 drm_gem_shmem_dumb_create+0x72/0x120 drivers/gpu/drm/drm_gem_shmem_helper.c:549
 
Freed by task 6093:
 drm_gem_object_release_handle+0xc2/0x1e0 drivers/gpu/drm/drm_gem.c:385
 drm_gem_handle_delete+0x7b/0xb0 drivers/gpu/drm/drm_gem.c:413
 drm_ioctl_kernel+0x2df/0x3b0 drivers/gpu/drm/drm_ioctl.c:804

Fixes: 53096728b891 ("drm: Add DRM prime interface to reassign GEM handle")
Reported-by: syzbot+b2e951687503f32f74ce@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b2e951687503f32f74ce
Tested-by: syzbot+b2e951687503f32f74ce@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/gpu/drm/drm_gem.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 891c3bff5ae0..63a8d7e980b5 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -374,14 +374,8 @@ drm_gem_object_release_handle(int id, void *ptr, void *data)
 	if (obj->funcs->close)
 		obj->funcs->close(obj, file_priv);
 
-	mutex_lock(&file_priv->prime.lock);
-
 	drm_prime_remove_buf_handle(&file_priv->prime, id);
-
-	mutex_unlock(&file_priv->prime.lock);
-
 	drm_vma_node_revoke(&obj->vma_node, file_priv);
-
 	drm_gem_object_handle_put_unlocked(obj);
 
 	return 0;
@@ -401,13 +395,16 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
 {
 	struct drm_gem_object *obj;
 
+	mutex_lock(&filp->prime.lock);
 	spin_lock(&filp->table_lock);
 
 	/* Check if we currently have a reference on the object */
 	obj = idr_replace(&filp->object_idr, NULL, handle);
 	spin_unlock(&filp->table_lock);
-	if (IS_ERR_OR_NULL(obj))
+	if (IS_ERR_OR_NULL(obj)) {
+		mutex_unlock(&filp->prime.lock);
 		return -EINVAL;
+	}
 
 	/* Release driver's reference and decrement refcount. */
 	drm_gem_object_release_handle(handle, obj, filp);
@@ -416,6 +413,7 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
 	spin_lock(&filp->table_lock);
 	idr_remove(&filp->object_idr, handle);
 	spin_unlock(&filp->table_lock);
+	mutex_unlock(&filp->prime.lock);
 
 	return 0;
 }
@@ -1012,17 +1010,18 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 		return -EINVAL;
 	handle = args->new_handle;
 
+	mutex_lock(&file_priv->prime.lock);
 	obj = drm_gem_object_lookup(file_priv, args->handle);
-	if (!obj)
+	if (!obj) {
+		mutex_unlock(&file_priv->prime.lock);
 		return -ENOENT;
+	}
 
 	if (args->handle == handle) {
 		ret = 0;
-		goto out;
+		goto out_unlock;
 	}
 
-	mutex_lock(&file_priv->prime.lock);
-
 	spin_lock(&file_priv->table_lock);
 	ret = idr_alloc(&file_priv->object_idr, obj, handle, handle + 1,
 			GFP_NOWAIT);
@@ -1051,9 +1050,8 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	spin_unlock(&file_priv->table_lock);
 
 out_unlock:
-	mutex_unlock(&file_priv->prime.lock);
-out:
 	drm_gem_object_put(obj);
+	mutex_unlock(&file_priv->prime.lock);
 
 	return ret;
 }
@@ -1085,8 +1083,10 @@ drm_gem_open(struct drm_device *dev, struct drm_file *file_private)
 void
 drm_gem_release(struct drm_device *dev, struct drm_file *file_private)
 {
+	mutex_lock(&file_private->prime.lock);
 	idr_for_each(&file_private->object_idr,
 		     &drm_gem_object_release_handle, file_private);
+	mutex_unlock(&file_private->prime.lock);
 	idr_destroy(&file_private->object_idr);
 }
 
-- 
2.43.0


