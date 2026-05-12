Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5F2CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 21:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E1C10EC3C;
	Tue, 12 May 2026 21:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="goOvs5EB";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1417710E5A3;
 Tue, 12 May 2026 21:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rgD9rs6hlwoREPQEqdFi5L79EY0qCTv5cMmu057b6C0=; b=goOvs5EB1G88+Q2AUL7E9wxHOq
 vQxdlpD8/EAILIwJOsucLAn6Y4VfDNNGb+3rXnVb6xU8/gOAvZHgnqdZCLKPiiOSZAomh6JPXrfne
 G/S09Y3tjOolubAbQbwLmDbT396jzIKS9cX07sibE6pl0FGVx1UfdZa4vUMqs/GgVYmNRXldNpySM
 ejk1NFfkP+svy+C4px9H/IU/SYJ44juKU4HGsziHIIiA3DY9SADdlYLFTNt/Js0FWx4R+xCZbEfYz
 hsyruPLnE7XnbgAEaD8PB6sJ2kZqgzJ4QoH6HDoVz9I82I8jVKNOe7m1gR7FFC/ukxUCCR0T3ldL6
 CBCuCmMA==;
Received: from 179-242-241-236.3g.claro.net.br ([179.242.241.236]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wMv1W-009frh-Ik; Tue, 12 May 2026 23:52:18 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Natalie Vock <natalie.vock@gmx.de>, kernel-dev@igalia.com,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH i-g-t 1/8] Introduce dmem driver and implement Xe support
Date: Tue, 12 May 2026 18:51:48 -0300
Message-ID: <20260512215156.4083082-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512215156.4083082-1-cascardo@igalia.com>
References: <20260512215156.4083082-1-cascardo@igalia.com>
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

In order to be reuse the same dmem tests with multiple drivers, we need to
abstract a few operations. That includes getting the region name, and
allocating and releasing VRAM. As there is some initialization also when
multiple allocations are done, also provide init and deinit functions.

The Xe implementation is based on the equivalente operations from
xe_cgroups.c.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 lib/igt_dmem_driver.h |  24 +++++++
 lib/meson.build       |   1 +
 lib/xe/xe_dmem.c      | 145 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 lib/igt_dmem_driver.h
 create mode 100644 lib/xe/xe_dmem.c

diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
new file mode 100644
index 000000000000..869356fbf2c2
--- /dev/null
+++ b/lib/igt_dmem_driver.h
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Valve Corporation
+ * Authors:
+ *  Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
+ */
+
+#ifndef __IGT_DMEM_DRIVER_H__
+#define __IGT_DMEM_DRIVER_H__
+
+#include <stdlib.h>
+
+struct igt_dmem_driver {
+	const char *name;
+	char * (*get_region_name)(int fd);
+	int (*init)(void **ctx, int fd, int max_bo);
+	void (*deinit)(void *ctx);
+	int (*allocate_vram)(void *ctx, int n_bo, size_t len);
+	void (*free_vram)(void *ctx, int n_bo, size_t len);
+};
+
+extern const struct igt_dmem_driver xe_dmem_driver;
+
+#endif
diff --git a/lib/meson.build b/lib/meson.build
index fb4679ffdfc1..269f3b9f0af8 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -122,6 +122,7 @@ lib_sources = [
 	'igt_msm.c',
 	'igt_dsc.c',
 	'igt_hook.c',
+	'xe/xe_dmem.c',
 	'xe/xe_gt.c',
 	'xe/xe_ioctl.c',
 	'xe/xe_legacy.c',
diff --git a/lib/xe/xe_dmem.c b/lib/xe/xe_dmem.c
new file mode 100644
index 000000000000..977b4c5f168f
--- /dev/null
+++ b/lib/xe/xe_dmem.c
@@ -0,0 +1,145 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Valve Corporation
+ * Authors:
+ *  Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
+ */
+
+#include "igt_dmem_driver.h"
+
+#include <errno.h>
+
+#include "igt.h"
+#include "igt_cgroup.h"
+#include "xe_drm.h"
+#include "xe/xe_ioctl.h"
+#include "xe/xe_query.h"
+
+static char * xe_dmem_get_region_name(int fd)
+{
+	uint64_t vram_region = 0;
+	uint64_t region;
+	char *cg_region;
+
+	/* Find first VRAM region */
+	xe_for_each_mem_region(fd, all_memory_regions(fd), region) {
+		if (xe_region_class(fd, region) == DRM_XE_MEM_REGION_CLASS_VRAM) {
+			vram_region = region;
+			break;
+		}
+	}
+	if (!vram_region)
+		return NULL;
+
+	cg_region = xe_cgroup_region_name(fd, vram_region);
+
+	return cg_region;
+}
+
+struct xe_dmem_ctx {
+	int fd;
+	uint32_t vm;
+	uint32_t *handles;
+	uint64_t addr;
+	uint64_t vram_region;
+};
+
+#define BIND_BASE		0x100000000ULL	/* 4 GiB VA base */
+
+static int xe_dmem_init(void **ctx, int fd, int max_bo)
+{
+	struct xe_dmem_ctx *xe_ctx;
+	uint64_t region;
+
+	xe_ctx = malloc(sizeof(*xe_ctx));
+	if (!xe_ctx)
+		return -ENOMEM;
+
+	xe_ctx->handles = calloc(max_bo, sizeof(xe_ctx->handles[0]));
+	if (!xe_ctx->handles)
+		goto out;
+
+	xe_ctx->vram_region = 0;
+	/* Find first VRAM region */
+	xe_for_each_mem_region(fd, all_memory_regions(fd), region) {
+		if (xe_region_class(fd, region) == DRM_XE_MEM_REGION_CLASS_VRAM) {
+			xe_ctx->vram_region = region;
+			break;
+		}
+	}
+	if (!xe_ctx->vram_region)
+		goto out;
+
+	xe_ctx->addr = BIND_BASE;
+	xe_ctx->fd = fd;
+
+	xe_ctx->vm = xe_vm_create(fd, DRM_XE_VM_CREATE_FLAG_LR_MODE, 0);
+
+	*ctx = xe_ctx;
+
+	return 0;
+
+out:
+	if (xe_ctx->handles)
+		free(xe_ctx->handles);
+	free(xe_ctx);
+
+	return -ENOMEM;
+}
+
+static void xe_dmem_deinit(void *ctx)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+
+	xe_vm_destroy(xe_ctx->fd, xe_ctx->vm);
+	free(xe_ctx->handles);
+	free(xe_ctx);
+}
+
+static int xe_dmem_allocate_vram(void *ctx, int n_bo, size_t len)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+	uint32_t handle;
+	int err;
+
+	err = __xe_bo_create(xe_ctx->fd, 0, len, xe_ctx->vram_region,
+			     DRM_XE_GEM_CREATE_FLAG_DEFER_BACKING,
+			     NULL, &handle);
+	if (err)
+		goto out;
+
+	xe_ctx->handles[n_bo] = handle;
+
+	err = __xe_vm_bind_lr_sync(xe_ctx->fd, xe_ctx->vm, handle, 0,
+				   xe_ctx->addr, len, 0);
+	if (err)
+		goto out;
+
+	xe_ctx->addr += len;
+
+out:
+	return err;
+}
+
+static void xe_dmem_free_vram(void *ctx, int n_bo, size_t len)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+	uint64_t addr = BIND_BASE;
+	int i;
+	for (i = 0; i < n_bo; i++) {
+		if (xe_ctx->handles[i]) {
+			xe_vm_unbind_lr_sync(xe_ctx->fd, xe_ctx->vm, 0, addr, len);
+			gem_close(xe_ctx->fd, xe_ctx->handles[i]);
+		}
+		addr += len;
+	}
+}
+
+const struct igt_dmem_driver xe_dmem_driver = {
+	.name = "xe",
+	.get_region_name = xe_dmem_get_region_name,
+	.init = xe_dmem_init,
+	.deinit = xe_dmem_deinit,
+	.allocate_vram = xe_dmem_allocate_vram,
+	.free_vram = xe_dmem_free_vram,
+};
-- 
2.47.3

