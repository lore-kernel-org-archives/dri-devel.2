Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AABC624DE
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D82B10F7C1;
	Thu,  3 Sep 2026 22:01:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="YRVlLmxv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D18E610F7C1;
 Thu,  3 Sep 2026 22:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=6aapiCutfAySGkiBJU8QXnrefOR2z/k8QtWrp2iu6pw=; b=YRVlLmxvANgJDPIWvmM5i3ofXH
 yH4ZALv+ilKL5C9yGDyLIvPiKJ4fj8RrUXJDNJUP8kQOBlnoAM53qEUXgG04y+HQgGMHbzedSE813
 B385nabePOgPx9sYCJG2VJok6VPgHIw/ymlDncaNhGIo5ulaTjs4Hl4s6loNsZ0Q8WxCbvXE4vVwt
 stTsxXP4TwRQc9lSFLZNUPoa5UgpjhXjNj2JIVd6B/SK9f7qcFo/bVCqCI7jezYNImBQt9PGSW06h
 7ACdfqN9edX6yyjbwyPyvgqdNslLeESYg5/UiRQL23jxe0Lw8v8XB7ytny6jsXtLYahGGMD8qTv1W
 ppe8zShw==;
Received: from [187.43.152.48] (helo=[127.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x2FUk-00EbUz-KT; Fri, 04 Sep 2026 00:01:18 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 03 Sep 2026 19:00:28 -0300
Subject: [PATCH i-g-t v6 6/9] lib/amdgpu: add amdgpu support to igt_dmem_driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dmem_max-v6-6-61dc62970fae@igalia.com>
References: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
In-Reply-To: <20260903-dmem_max-v6-0-61dc62970fae@igalia.com>
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

This allows dmem cgroups tests to run on top of amdgpu driver, adding
support to allocate and release VRAM memory.

This does this by allocating a BO from VRAM domain, which will try to
place BOs on VRAM, but may fallback to GTT.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 lib/amdgpu/amd_dmem.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/igt_dmem_driver.h |  1 +
 lib/meson.build       |  1 +
 3 files changed, 92 insertions(+)

diff --git a/lib/amdgpu/amd_dmem.c b/lib/amdgpu/amd_dmem.c
new file mode 100644
index 000000000000..cb0fed4b870a
--- /dev/null
+++ b/lib/amdgpu/amd_dmem.c
@@ -0,0 +1,90 @@
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
+};
+
+static int amdgpu_dmem_init(void **ctx, int fd)
+{
+	struct amdgpu_dmem_ctx *actx;
+	uint32_t major, minor;
+	int err;
+
+	actx = malloc(sizeof(*actx));
+	if (!actx)
+		return -ENOMEM;
+
+	err = amdgpu_device_initialize(fd, &major, &minor, &actx->device);
+	if (err)
+		goto out;
+
+	actx->fd = fd;
+
+	*ctx = actx;
+
+	return 0;
+
+out:
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
+	free(actx);
+}
+
+static char * amdgpu_dmem_get_region_name(void *ctx)
+{
+	struct amdgpu_dmem_ctx *actx = ctx;
+
+	return amdgpu_cgroup_region_name(actx->fd);
+}
+
+static int amdgpu_dmem_allocate_vram(void *ctx, size_t len, void **ret_handle)
+{
+	struct amdgpu_dmem_ctx *actx = ctx;
+	amdgpu_bo_handle handle;
+	int err;
+
+	err = amdgpu_bo_alloc_wrap(actx->device, len, 4096,
+				   AMDGPU_GEM_DOMAIN_VRAM, 0, &handle);
+	if (err)
+		return err;
+
+	if (ret_handle)
+		*ret_handle = (void *) handle;
+
+	return 0;
+}
+
+static void amdgpu_dmem_free_vram(void *ctx, void *handle)
+{
+	amdgpu_bo_free(handle);
+}
+
+const struct igt_dmem_driver amdgpu_dmem_driver = {
+	.name = "amdgpu",
+	.get_region_name = amdgpu_dmem_get_region_name,
+	.init = amdgpu_dmem_init,
+	.deinit = amdgpu_dmem_deinit,
+	.allocate_vram = amdgpu_dmem_allocate_vram,
+	.free_vram = amdgpu_dmem_free_vram,
+};
diff --git a/lib/igt_dmem_driver.h b/lib/igt_dmem_driver.h
index e6998387eff9..f2d9d74196db 100644
--- a/lib/igt_dmem_driver.h
+++ b/lib/igt_dmem_driver.h
@@ -30,5 +30,6 @@ struct igt_dmem_driver {
 };
 
 extern const struct igt_dmem_driver xe_dmem_driver;
+extern const struct igt_dmem_driver amdgpu_dmem_driver;
 
 #endif
diff --git a/lib/meson.build b/lib/meson.build
index 022408ce6864..e191793f0097 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -205,6 +205,7 @@ if libdrm_amdgpu.found()
 		'amdgpu/amd_mmd_shared.c',
 		'amdgpu/amd_jpeg_shared.c',
 		'amdgpu/amd_utils.c',
+		'amdgpu/amd_dmem.c',
 		'amdgpu/amd_vcn_shared.c'
 	]
 	if libdrm_amdgpu.version().version_compare('> 2.4.99')

-- 
2.47.3

