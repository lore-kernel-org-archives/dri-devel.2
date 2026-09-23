Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC43C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:45:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C5DF10F1B4;
	Wed, 23 Sep 2026 20:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gslfvGTX";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA9810F1BC;
 Wed, 23 Sep 2026 20:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=bSZa7iI5Fx8g5l32o40PHUn/chnhLjd72suXzmozKdc=; b=gslfvGTXccwnQk5jYmNcxhHCjb
 C78ieli+m53O/Xf4IJUrQVI3u0QRi5vSpDcVDN4+rYYpdaLlhmoxwv8XUrTh6+uf74w8D57OfP9vC
 /BJzJn0cTPjgsCn4iZbs79Q7A0x1tmUzQECYXwKIVXOc/MGvyNfkftFzM4Y0w0wMtAuaVmjGNA5D3
 qkX+n03mrLa57PLS5l19JoTBK0Md2j7cQ63kbRuHFML6ZBS+iqyP8mY9QVT/COGB80YQyZDBRWyUB
 d+P2ixADzupwdb3DJdYiNc5kVRGW8NxpGOCkEib1W4Hs3QsRZVf1qNvNxKjGFo9JsIv4dQiy5wNAU
 +vhXUmVA==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9Tq1-006KVk-6X; Wed, 23 Sep 2026 22:45:09 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 23 Sep 2026 17:44:39 -0300
Subject: [PATCH i-g-t v7 4/9] lib/xe: Introduce dmem driver and implement
 Xe support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-dmem_max-v7-4-194ea47bbb4d@igalia.com>
References: <20260923-dmem_max-v7-0-194ea47bbb4d@igalia.com>
In-Reply-To: <20260923-dmem_max-v7-0-194ea47bbb4d@igalia.com>
To: igt-dev@lists.freedesktop.org
Cc: siqueira@igalia.com, Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, Christian Koenig <christian.koenig@amd.com>, 
 maarten.lankhorst@linux.intel.com, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Kamil Konieczny <kamil.konieczny@linux.intel.com>, 
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, 
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Natalie Vock <natalie.vock@gmx.de>, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
X-Mailer: b4 0.16-dev-62088
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
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 lib/igt_dmem_driver.h | 35 ++++++++++++++++++
 lib/meson.build       |  1 +
 lib/xe/xe_dmem.c      | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 134 insertions(+)

diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
new file mode 100644
index 000000000000..821ccb7a29a9
--- /dev/null
+++ b/lib/igt_dmem_driver.h
@@ -0,0 +1,35 @@
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
+/**
+ * struct igt_dmem_driver - vendor driver to allocate and free device memory
+ *
+ */
+struct igt_dmem_driver {
+	/** @name: Driver name */
+	const char *name;
+	/** @init: Initialize an opaque context given a DRM device fd */
+	int (*init)(void **ctx, int fd);
+	/** @deinit: Release resources associated with context */
+	void (*deinit)(void *ctx);
+	/**
+	 * @get_region_name: Return expected region name at dmem cgroup files.
+	 * Must be freed by caller after use.
+	 */
+	char * (*get_region_name)(void *ctx);
+	/** @allocate_vram: Allocate @len sized vram and return an opaque @handle */
+	int (*allocate_vram)(void *ctx, size_t len, void **handle);
+	/** @free_vram: Free vram associated with @handle */
+	void (*free_vram)(void *ctx, void *handle);
+};
+
+extern const struct igt_dmem_driver xe_dmem_driver;
+
+#endif
diff --git a/lib/meson.build b/lib/meson.build
index df5f13efac56..c5d35bc8e88e 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -132,6 +132,7 @@ lib_sources = [
 	'igt_hook.c',
 	'imagination/pvr_device_info.c',
 	'xe/xe_device.c',
+	'xe/xe_dmem.c',
 	'xe/xe_ggtt.c',
 	'xe/xe_gt.c',
 	'xe/xe_ioctl.c',
diff --git a/lib/xe/xe_dmem.c b/lib/xe/xe_dmem.c
new file mode 100644
index 000000000000..054f88df32d3
--- /dev/null
+++ b/lib/xe/xe_dmem.c
@@ -0,0 +1,98 @@
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
+struct xe_dmem_ctx {
+	int fd;
+	uint64_t vram_region;
+};
+
+static int xe_dmem_init(void **ctx, int fd)
+{
+	struct xe_dmem_ctx *xe_ctx;
+	uint64_t region;
+
+	xe_ctx = malloc(sizeof(*xe_ctx));
+	if (!xe_ctx)
+		return -ENOMEM;
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
+	*ctx = xe_ctx;
+
+	return 0;
+
+out:
+	free(xe_ctx);
+
+	return -ENOMEM;
+}
+
+static void xe_dmem_deinit(void *ctx)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+
+	free(xe_ctx);
+}
+
+static char * xe_dmem_get_region_name(void *ctx)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+
+	return xe_cgroup_region_name(xe_ctx->fd, xe_ctx->vram_region);
+}
+
+static int xe_dmem_allocate_vram(void *ctx, size_t len, void **ret_handle)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+	uint32_t handle;
+	int err;
+
+	err = __xe_bo_create(xe_ctx->fd, 0, len, xe_ctx->vram_region, 0,
+			     NULL, &handle);
+	if (err)
+		return err;
+
+	if (ret_handle)
+		*ret_handle = (void *)(uintptr_t) handle;
+	return 0;
+}
+
+static void xe_dmem_free_vram(void *ctx, void *handle)
+{
+	struct xe_dmem_ctx *xe_ctx = ctx;
+
+	gem_close(xe_ctx->fd, (uint32_t)(uintptr_t) handle);
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

