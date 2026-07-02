Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3554C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:02:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6C810E4BB;
	Thu,  2 Jul 2026 13:02:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="H5shq5kP";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E348E10F376;
 Thu,  2 Jul 2026 13:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eQ01zZl7CA9tZ/G/ueOCdHz/Z0lI9e7IYSPPzuvxq8o=; b=H5shq5kPuHqc57yPmlcclbwDLf
 PPAcMPdrqnXDm/iguk5LONL4SRfrwC6G1KaBcYzvUtdXkHtDPLZOlZogVL8ngj5pySwi74vUt1d7V
 eNkAr+fSoqbnaHgerEKiPD7KAYO782IpulSlZBzbGOJMha62qNv2umvCuEZhmqKLMiIb9CbR67GzB
 pdY3ji51YlUfPGlrHqla6SqDPuxdroSnEQdZKL2MVVAubVARuiIc0NNv9Twio9pf0qP+tZl6bvtn7
 qrZu8i+iaUm+ctuT7ORQOX3vBIisXrd5UlDqR5WtxtZLVAr3oEAk0eyP87aaXebWInAFZN9gzYo2O
 Tutcir6Q==;
Received: from [179.125.94.247] (helo=quatroqueijos.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wfH3c-0082Ji-GS; Thu, 02 Jul 2026 15:02:21 +0200
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
Subject: [PATCH i-g-t v2 6/7] lib/amdgpu: add amdgpu support to igt_dmem_driver
Date: Thu,  2 Jul 2026 10:00:57 -0300
Message-ID: <20260702130108.1397444-7-cascardo@igalia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702130108.1397444-1-cascardo@igalia.com>
References: <20260702130108.1397444-1-cascardo@igalia.com>
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

This allows dmem cgroups tests to run on top of amdgpu driver, adding
support to allocate and release VRAM memory.

This does this by allocating a BO from VRAM domain, which will try to
place BOs on VRAM, but may fallback to GTT.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 lib/amdgpu/amd_dmem.c | 99 +++++++++++++++++++++++++++++++++++++++++++
 lib/igt_dmem_driver.h |  1 +
 lib/meson.build       |  1 +
 3 files changed, 101 insertions(+)
 create mode 100644 lib/amdgpu/amd_dmem.c

diff --git a/lib/amdgpu/amd_dmem.c b/lib/amdgpu/amd_dmem.c
new file mode 100644
index 000000000000..5ff6437dc78a
--- /dev/null
+++ b/lib/amdgpu/amd_dmem.c
@@ -0,0 +1,99 @@
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
+#include "lib/amdgpu/amd_memory.h"
+
+struct amdgpu_dmem_ctx {
+	int fd;
+	amdgpu_device_handle device;
+	amdgpu_bo_handle *handles;
+	int max_bo;
+};
+
+static int amdgpu_dmem_init(void **ctx, int fd, int max_bo)
+{
+	struct amdgpu_dmem_ctx *actx;
+	uint32_t major, minor;
+	int err = -ENOMEM;
+
+	actx = malloc(sizeof(*actx));
+	if (!actx)
+		return -ENOMEM;
+
+	actx->handles = calloc(max_bo, sizeof(actx->handles[0]));
+	if (!actx->handles)
+		goto out;
+
+	actx->max_bo = max_bo;
+
+	err = amdgpu_device_initialize(fd, &major, &minor, &actx->device);
+	if (err)
+		goto out;
+
+	*ctx = actx;
+
+	return 0;
+
+out:
+	if (actx->handles)
+		free(actx->handles);
+	free(actx);
+
+	return err;
+}
+
+static void amdgpu_dmem_deinit(void *ctx)
+{
+	struct amdgpu_dmem_ctx *actx = ctx;
+
+	amdgpu_device_deinitialize(actx->device);
+	free(actx->handles);
+	free(actx);
+}
+
+static int amdgpu_dmem_allocate_vram(void *ctx, int n_bo, size_t len)
+{
+	struct amdgpu_dmem_ctx *actx = ctx;
+	amdgpu_bo_handle handle;
+	int err;
+
+	if (n_bo >= actx->max_bo)
+		return -ENOMEM;
+
+	err = amdgpu_bo_alloc_wrap(actx->device, len, 4096,
+				   AMDGPU_GEM_DOMAIN_VRAM, 0, &handle);
+	if (err)
+		return err;
+
+	actx->handles[n_bo] = handle;
+
+	return 0;
+}
+
+static void amdgpu_dmem_free_vram(void *ctx, int n_bo)
+{
+	struct amdgpu_dmem_ctx *actx = ctx;
+	if (n_bo >= actx->max_bo)
+		return;
+	if (actx->handles[n_bo])
+		amdgpu_bo_free(actx->handles[n_bo]);
+	actx->handles[n_bo] = 0;
+}
+
+const struct igt_dmem_driver amdgpu_dmem_driver = {
+	.name = "amdgpu",
+	.get_region_name = amdgpu_cgroup_region_name,
+	.init = amdgpu_dmem_init,
+	.deinit = amdgpu_dmem_deinit,
+	.allocate_vram = amdgpu_dmem_allocate_vram,
+	.free_vram = amdgpu_dmem_free_vram,
+};
diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
index 2f4a4673ab16..d34c839740a5 100644
--- a/lib/igt_dmem_driver.h
+++ b/lib/igt_dmem_driver.h
@@ -20,5 +20,6 @@ struct igt_dmem_driver {
 };
 
 extern const struct igt_dmem_driver xe_dmem_driver;
+extern const struct igt_dmem_driver amdgpu_dmem_driver;
 
 #endif
diff --git a/lib/meson.build b/lib/meson.build
index 04fe5755c82c..6bf9d0d9cb74 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -199,6 +199,7 @@ if libdrm_amdgpu.found()
 		'amdgpu/amd_mmd_shared.c',
 		'amdgpu/amd_jpeg_shared.c',
 		'amdgpu/amd_utils.c',
+		'amdgpu/amd_dmem.c',
 		'amdgpu/amd_vcn_shared.c'
 	]
 	if libdrm_amdgpu.version().version_compare('> 2.4.99')
-- 
2.47.3

