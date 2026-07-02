Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA24C43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9D810E4E7;
	Thu,  2 Jul 2026 13:02:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MHvDB0PD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8938D10F370;
 Thu,  2 Jul 2026 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DyWqc4wPdfvM4114hsamLmuQ0/7w1IqiQaxw7+9Jmd4=; b=MHvDB0PDyTcQOyC5hVfzD/RO75
 z4CsbOI/naXxti5OAXnecjOfl91QTjP9M1aokpD4L33+8ps2eHGPKNo+rsDZfH0PPqGGqdTNPXXXG
 AXUGzV/LL9h+XAiz5sxq6nmLZNbAjpMO/hZeWxHk3CMKgbPZhQDYeHsOK5KIkHQ4QuOzgm0/iNKKZ
 lZsF4uPAUavidJ6YMDCN31cZDXfOgvmRTyh/8ukCVjPJ80veKtyU3A7IDZCgRVmVABFDAqppnK6p3
 B96IBLUrQ7VfoOB1YveEunni9AH373YzjO7UxD02ezlAWvIkCyRMJ98gLHf1z/+rTxso9NsmYcRzE
 b+xyqD0w==;
Received: from [179.125.94.247] (helo=quatroqueijos.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfH3R-0082Ji-7J; Thu, 02 Jul 2026 15:02:09 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org,
 Christian Koenig <christian.koenig@amd.com>,
 maarten.lankhorst@linux.intel.com,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: [PATCH i-g-t v2 4/7] lib/xe: Introduce dmem driver and implement Xe
 support
Date: Thu,  2 Jul 2026 10:00:55 -0300
Message-ID: <20260702130108.1397444-5-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702130108.1397444-1-cascardo@igalia.com>
References: <20260702130108.1397444-1-cascardo@igalia.com>
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

The Xe implementation was based on the original operations from
xe_cgroups.c written by Thomas Hellström. However, instead of doing a
deferred backing, followed by a bind, it does a simple non-deferred GEM
object creation on the VRAM region.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 lib/igt_dmem_driver.h |  24 +++++++
 lib/meson.build       |   1 +
 lib/xe/xe_dmem.c      | 143 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 168 insertions(+)
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
index e0d9c2f7475b..04fe5755c82c 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -126,6 +126,7 @@ lib_sources = [
 	'igt_msm.c',
 	'igt_dsc.c',
 	'igt_hook.c',
+	'xe/xe_dmem.c',
 	'xe/xe_gt.c',
 	'xe/xe_ioctl.c',
 	'xe/xe_legacy.c',
diff --git a/lib/xe/xe_dmem.c b/lib/xe/xe_dmem.c
new file mode 100644
index 000000000000..0de3a8c0b222
--- /dev/null
+++ b/lib/xe/xe_dmem.c
@@ -0,0 +1,143 @@
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
+	size_t len;
+};
+
+struct xe_dmem_ctx {
+	int fd;
+	uint32_t vm;
+	struct xe_bo *bos;
+	uint64_t vram_region;
+	int max_bo;
+};
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
+	err = __xe_bo_create(xe_ctx->fd, 0, len, xe_ctx->vram_region, 0,
+			     NULL, &handle);
+	if (err)
+		goto out;
+
+	xe_ctx->bos[n_bo].handle = handle;
+	xe_ctx->bos[n_bo].len = len;
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

