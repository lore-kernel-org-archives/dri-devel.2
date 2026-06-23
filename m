Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24441CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90DDD10EC30;
	Tue, 23 Jun 2026 17:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="dtqVGPWa";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730E510EC27;
 Tue, 23 Jun 2026 17:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4YTsZIaFwU6ZukbX4Jr8mkIV/CwaU7Ymxm/ypzFkYPM=; b=dtqVGPWaEkWVbOj2EfkebuanDW
 0IcmKQnsJW9plnJBrOYoAOmaGaWkAdyYBqX/uw+bR6qHuXFETuktb71a6o/h+VZstPaefua9lFh7y
 RJD9oyHyctcjfE+DsEV/wensmp3Ynb9RsACcEGbYKQrj2ho+86qjKq+hxHlds9EvndqbxQKh4Wsk0
 VKpOyVrljrU4Ih5h/KJyHN13r7iBhd01RsGD7NKRkjg7tzj8QzXtFHEOecoTBjNlN+P3m6pcOlSRx
 3jxiTVKCj/n8ZrBcvO8z+G2833EMura81RST+ZqBO1IzLZPNHHA0CGEF5l07AwE8VlL1x/w7Te0P8
 tDAmPHSA==;
Received: from 179-125-64-254-dinamico.pombonet.net.br ([179.125.64.254]
 helo=quatroqueijos.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wc5A8-004HEi-0u; Tue, 23 Jun 2026 19:43:52 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH i-g-t 4/7] lib/xe: Introduce dmem driver and implement Xe
 support
Date: Tue, 23 Jun 2026 14:43:16 -0300
Message-ID: <20260623174319.4138648-5-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260623174319.4138648-1-cascardo@igalia.com>
References: <20260623174319.4138648-1-cascardo@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The Xe implementation is based on the original operations from
xe_cgroups.c written by Thomas Hellström.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 lib/igt_dmem_driver.h |  24 +++++++
 lib/meson.build       |   1 +
 lib/xe/xe_dmem.c      | 159 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 lib/igt_dmem_driver.h
 create mode 100644 lib/xe/xe_dmem.c

diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
new file mode 100644
index 000000000000..2f4a4673ab16
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
+	void (*free_vram)(void *ctx, int n_bo);
+};
+
+extern const struct igt_dmem_driver xe_dmem_driver;
+
+#endif
diff --git a/lib/meson.build b/lib/meson.build
index 3aaebc5b1948..cd7a3805accb 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -125,6 +125,7 @@ lib_sources = [
 	'igt_msm.c',
 	'igt_dsc.c',
 	'igt_hook.c',
+	'xe/xe_dmem.c',
 	'xe/xe_gt.c',
 	'xe/xe_ioctl.c',
 	'xe/xe_legacy.c',
diff --git a/lib/xe/xe_dmem.c b/lib/xe/xe_dmem.c
new file mode 100644
index 000000000000..b979dfa7f4cf
--- /dev/null
+++ b/lib/xe/xe_dmem.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Valve Corporation
+ * Authors:
+ *  Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
+ */
+
+#include <errno.h>
+
+#include "igt.h"
+#include "igt_cgroup.h"
+#include "igt_dmem_driver.h"
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
+struct xe_bo {
+	uint32_t handle;
+	uint64_t addr;
+	size_t len;
+};
+
+struct xe_dmem_ctx {
+	int fd;
+	uint32_t vm;
+	struct xe_bo *bos;
+	uint64_t addr;
+	uint64_t vram_region;
+	int max_bo;
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
+	xe_ctx->bos = calloc(max_bo, sizeof(xe_ctx->bos[0]));
+	if (!xe_ctx->bos)
+		goto out;
+	memset(xe_ctx->bos, 0, max_bo * sizeof(xe_ctx->bos[0]));
+	xe_ctx->max_bo = max_bo;
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
+	if (xe_ctx->bos)
+		free(xe_ctx->bos);
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
+	free(xe_ctx->bos);
+	free(xe_ctx);
+}
+
+static int xe_dmem_allocate_vram(void *ctx, int n_bo, size_t len)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+	uint32_t handle;
+	int err;
+
+	if (n_bo >= xe_ctx->max_bo)
+		return -ENOMEM;
+
+	err = __xe_bo_create(xe_ctx->fd, 0, len, xe_ctx->vram_region,
+			     DRM_XE_GEM_CREATE_FLAG_DEFER_BACKING,
+			     NULL, &handle);
+	if (err)
+		goto out;
+
+	err = __xe_vm_bind_lr_sync(xe_ctx->fd, xe_ctx->vm, handle, 0,
+				   xe_ctx->addr, len, 0);
+	if (err)
+		goto out;
+
+	xe_ctx->bos[n_bo].handle = handle;
+	xe_ctx->bos[n_bo].len = len;
+	xe_ctx->bos[n_bo].addr = xe_ctx->addr;
+
+	xe_ctx->addr += len;
+
+out:
+	return err;
+}
+
+static void xe_dmem_free_vram(void *ctx, int n_bo)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+	size_t len;
+	if (n_bo >= xe_ctx->max_bo)
+		return;
+	len = xe_ctx->bos[n_bo].len;
+	if (len) {
+		uint64_t addr = xe_ctx->bos[n_bo].addr;
+		xe_vm_unbind_lr_sync(xe_ctx->fd, xe_ctx->vm, 0, addr, len);
+		gem_close(xe_ctx->fd, xe_ctx->bos[n_bo].handle);
+		xe_ctx->bos[n_bo].len = 0;
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

