Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61AB107637E
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 13:49:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A98910EB36;
	Wed,  1 Apr 2026 13:49:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gr02LWd6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99F6B10E4E9
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775051349;
 bh=8Hg+Pr9Kt4CFNtwrRmKMVq0vSp/0qICGVS+8alWV3L4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gr02LWd6NrGDXLWzMOuFUtp5IjBFBBRlpg9qOFclAK5iMywYhaZh6+Gcp4ukCpmlf
 SJYioscMsQes2u1nN+0LOjVcCA90uOHOdyfsOwdAYW3JUCBXqAP49J+UdWj8WPwWC6
 WXWJiaACYln3Fo6qycH0e08jG2szuMnprxH7CCAJpgaaZrJsOEv6fSzM27MrtZXLgp
 AX1CSHMrRLDupUY1Vw5fdOCi9uK3KkFIx1hlXajvfXtGkJCYvDvX5Il1YnpIuz2icx
 N0GFMAxBlSwGaolOUYIGLqJ/rlWpvbYiO51TWqrgdVHGjx9/VfkTt/Jx1VaX6OeBoI
 I2wnj+k32TWbw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:a2a7:f53:ebb0:945e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B4E717E752F;
 Wed,  1 Apr 2026 15:49:08 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Akash Goel <akash.goel@arm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Chris Diamand <chris.diamand@arm.com>, Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, Chia-I Wu <olvaffe@gmail.com>,
 kernel@collabora.com
Subject: [PATCH v7 03/10] drm/panthor: Move panthor_gems_debugfs_init() to
 panthor_gem.c
Date: Wed,  1 Apr 2026 15:48:47 +0200
Message-ID: <20260401134854.2275433-4-boris.brezillon@collabora.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401134854.2275433-1-boris.brezillon@collabora.com>
References: <20260401134854.2275433-1-boris.brezillon@collabora.com>
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

There's no reason for panthor_drv to know about panthor_gem.c internals,
so let's move the GEM debugfs init logic to panthor_gem.c.

v2:
- Collect R-bs

v3:
-No changes

v4:
- No changes

v5:
- No changes

v6:
- No changes

v7:
- No changes

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_drv.c | 26 +-----------------------
 drivers/gpu/drm/panthor/panthor_gem.c | 29 +++++++++++++++++++++++++--
 drivers/gpu/drm/panthor/panthor_gem.h |  3 +--
 3 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index 87d27c3c1456..b1339d4db0a9 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1756,34 +1756,10 @@ static const struct file_operations panthor_drm_driver_fops = {
 };
 
 #ifdef CONFIG_DEBUG_FS
-static int panthor_gems_show(struct seq_file *m, void *data)
-{
-	struct drm_info_node *node = m->private;
-	struct drm_device *dev = node->minor->dev;
-	struct panthor_device *ptdev = container_of(dev, struct panthor_device, base);
-
-	panthor_gem_debugfs_print_bos(ptdev, m);
-
-	return 0;
-}
-
-static struct drm_info_list panthor_debugfs_list[] = {
-	{"gems", panthor_gems_show, 0, NULL},
-};
-
-static int panthor_gems_debugfs_init(struct drm_minor *minor)
-{
-	drm_debugfs_create_files(panthor_debugfs_list,
-				 ARRAY_SIZE(panthor_debugfs_list),
-				 minor->debugfs_root, minor);
-
-	return 0;
-}
-
 static void panthor_debugfs_init(struct drm_minor *minor)
 {
 	panthor_mmu_debugfs_init(minor);
-	panthor_gems_debugfs_init(minor);
+	panthor_gem_debugfs_init(minor);
 }
 #endif
 
diff --git a/drivers/gpu/drm/panthor/panthor_gem.c b/drivers/gpu/drm/panthor/panthor_gem.c
index 6d14b0269574..c7b8b84a8f8b 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.c
+++ b/drivers/gpu/drm/panthor/panthor_gem.c
@@ -9,6 +9,8 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include <drm/drm_debugfs.h>
+#include <drm/drm_file.h>
 #include <drm/drm_print.h>
 #include <drm/panthor_drm.h>
 
@@ -683,8 +685,8 @@ static void panthor_gem_debugfs_bo_print(struct panthor_gem_object *bo,
 		totals->reclaimable += resident_size;
 }
 
-void panthor_gem_debugfs_print_bos(struct panthor_device *ptdev,
-				   struct seq_file *m)
+static void panthor_gem_debugfs_print_bos(struct panthor_device *ptdev,
+					  struct seq_file *m)
 {
 	struct gem_size_totals totals = {0};
 	struct panthor_gem_object *bo;
@@ -704,4 +706,27 @@ void panthor_gem_debugfs_print_bos(struct panthor_device *ptdev,
 	seq_printf(m, "Total size: %zd, Total resident: %zd, Total reclaimable: %zd\n",
 		   totals.size, totals.resident, totals.reclaimable);
 }
+
+static int panthor_gem_show_bos(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct panthor_device *ptdev =
+		container_of(dev, struct panthor_device, base);
+
+	panthor_gem_debugfs_print_bos(ptdev, m);
+
+	return 0;
+}
+
+static struct drm_info_list panthor_gem_debugfs_list[] = {
+	{ "gems", panthor_gem_show_bos, 0, NULL },
+};
+
+void panthor_gem_debugfs_init(struct drm_minor *minor)
+{
+	drm_debugfs_create_files(panthor_gem_debugfs_list,
+				 ARRAY_SIZE(panthor_gem_debugfs_list),
+				 minor->debugfs_root, minor);
+}
 #endif
diff --git a/drivers/gpu/drm/panthor/panthor_gem.h b/drivers/gpu/drm/panthor/panthor_gem.h
index 22519c570b5a..94b2d17cf032 100644
--- a/drivers/gpu/drm/panthor/panthor_gem.h
+++ b/drivers/gpu/drm/panthor/panthor_gem.h
@@ -203,8 +203,7 @@ panthor_kernel_bo_create(struct panthor_device *ptdev, struct panthor_vm *vm,
 void panthor_kernel_bo_destroy(struct panthor_kernel_bo *bo);
 
 #ifdef CONFIG_DEBUG_FS
-void panthor_gem_debugfs_print_bos(struct panthor_device *pfdev,
-				   struct seq_file *m);
+void panthor_gem_debugfs_init(struct drm_minor *minor);
 #endif
 
 #endif /* __PANTHOR_GEM_H__ */
-- 
2.53.0

