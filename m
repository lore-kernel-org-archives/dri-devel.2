Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE390606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TCrIU93w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00C2410EDDB;
	Mon, 26 Oct 2026 10:26:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB18010EDBA;
 Mon, 26 Oct 2026 10:26:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DECF43BAC;
 Mon, 26 Oct 2026 10:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF781F01828;
 Mon, 26 Oct 2026 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793010370;
 bh=Y6oRwARljAebElUKFvK8H3t3ANwhHxuF/Ppq0WMLrq8=;
 h=From:To:Cc:Subject:Date;
 b=TCrIU93w9IHx64zbHME5wnCOja5h5+idy8mXAZzOIJn62yXZ5CiDq4JKjUxL9oeoV
 svklRgsVSTOk6cwdO3SCpHUUUsyLy6XbUXAq1e3GXOgrzpQbyUi6/nryC0XHKSYPDT
 xuFeQYaHtFksLzQicEe6FVWCOV7zDcaJ8MYpq/m3Wdhp4JxW6d0VkpgWQLqX6gbkYJ
 Vqs4kGvZVOYuSIp42uXgSEf8j71pmmpU3kkFmaSaihvBYQnBnokduJTty788sN3ueU
 FYXlFevbdSUl0FlGtHdOpuXtBUK/3KTK7ZQQFFf0n64JGXQ+bc8i77vfqZLM6KqS3O
 AKfe8307sq18w==
From: Arnd Bergmann <arnd@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>,
 Lucas De Marchi <demarchi@kernel.org>, Riana Tauro <riana.tauro@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Matthew Auld <matthew.auld@intel.com>,
 Shuicheng Lin <shuicheng.lin@intel.com>, Armin Wolf <W_Armin@gmx.de>,
 Zhanjun Dong <zhanjun.dong@intel.com>,
 Michal Wajdeczko <michal.wajdeczko@intel.com>,
 =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
 Tejas Upadhyay <tejas.upadhyay@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: xe: select configfs
Date: Mon, 26 Oct 2026 11:25:50 +0100
Message-ID: <20261026102603.2045493-1-arnd@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Arnd Bergmann <arnd@arndb.de>

The original addition of configfs to xe missed a compile-time dependency,
which leads to a link failure when configfs is enabled as a loadable module:

ld.lld-21: error: undefined symbol: xe_configfs_get_survivability_mode
>>> referenced by xe_survivability_mode.c:224
>>>               drivers/gpu/drm/xe/xe_survivability_mode.o:(xe_survivability_mode_is_requested) in archive vmlinux.a

A recent workaround added a 'IS_REACHABLE()' check around the calls into
configfs, which makes it link in this configuration, but this is generally
a bad idea because it makes the actual behavior inconsistent and confusing
to users that expect configfs to work if both xe and configfs are enabled.

Use 'select CONFIGFS_FS' instead, like every other configfs user does,
and remove the unnecessary stub functions. There is little practical
difference here as anyone using XE graphics is likely to have a complex
configuration that already selects configfs anyway, and the link error
or the IS_REACHABLE() would only manifest during randconfig testing.

Fixes: 30499cbd7961 ("drm/xe: Fix build with DRM_XE=y and CONFIGFS_FS=m")
Fixes: 16280ded45fb ("drm/xe: Add configfs to enable survivability mode")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/xe/Kconfig       |  1 +
 drivers/gpu/drm/xe/xe_configfs.h | 30 ------------------------------
 2 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4fc8abdc5cb6..b52a8dc28f97 100644
--- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -11,6 +11,7 @@ config DRM_XE
 	# the shmem_readpage() which depends upon tmpfs
 	select SHMEM
 	select TMPFS
+	select CONFIGFS_FS
 	select DRM_BUDDY
 	select DRM_CLIENT_SELECTION
 	select DRM_KMS_HELPER
diff --git a/drivers/gpu/drm/xe/xe_configfs.h b/drivers/gpu/drm/xe/xe_configfs.h
index 327b648944ff..d726800de26a 100644
--- a/drivers/gpu/drm/xe/xe_configfs.h
+++ b/drivers/gpu/drm/xe/xe_configfs.h
@@ -14,7 +14,6 @@
 
 struct pci_dev;
 
-#if IS_REACHABLE(CONFIG_CONFIGFS_FS)
 int xe_configfs_init(void);
 void xe_configfs_exit(void);
 void xe_configfs_check_device(struct pci_dev *pdev);
@@ -36,34 +35,5 @@ u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
 unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev);
 bool xe_configfs_admin_only_pf(struct pci_dev *pdev);
 #endif
-#else
-static inline int xe_configfs_init(void) { return 0; }
-static inline void xe_configfs_exit(void) { }
-static inline void xe_configfs_check_device(struct pci_dev *pdev) { }
-static inline bool xe_configfs_get_survivability_mode(struct pci_dev *pdev) { return false; }
-static inline bool xe_configfs_primary_gt_allowed(struct pci_dev *pdev) { return true; }
-static inline bool xe_configfs_media_gt_allowed(struct pci_dev *pdev) { return true; }
-static inline u64 xe_configfs_get_engines_allowed(struct pci_dev *pdev) { return U64_MAX; }
-static inline bool xe_configfs_get_psmi_enabled(struct pci_dev *pdev) { return false; }
-static inline bool xe_configfs_get_enable_multi_queue(struct pci_dev *pdev) { return true; }
-static inline u32 xe_configfs_get_migrate_ulls_period_ms(struct pci_dev *pdev) { return 5; }
-static inline bool xe_configfs_get_disable_vram_page_offline(struct pci_dev *pdev) { return false; }
-static inline u32 xe_configfs_get_ctx_restore_mid_bb(struct pci_dev *pdev,
-						     enum xe_engine_class class,
-						     const u32 **cs) { return 0; }
-static inline u32 xe_configfs_get_ctx_restore_post_bb(struct pci_dev *pdev,
-						      enum xe_engine_class class,
-						      const u32 **cs) { return 0; }
-#ifdef CONFIG_PCI_IOV
-static inline unsigned int xe_configfs_get_max_vfs(struct pci_dev *pdev)
-{
-	return xe_modparam.max_vfs;
-}
-static inline bool xe_configfs_admin_only_pf(struct pci_dev *pdev)
-{
-	return XE_DEFAULT_ADMIN_ONLY_PF;
-}
-#endif
-#endif
 
 #endif
-- 
2.53.0

