Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E833C9830D
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 401D910F1BC;
	Wed, 23 Sep 2026 20:45:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="N4opUzxW";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F8FD10F1A2;
 Wed, 23 Sep 2026 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=mdQz3tU0YJszlOH9sQguzcG7R9kqcS7kozwbMzdT0PY=; b=N4opUzxWse5TqwQMcKOnaqsYeb
 OYSIZrof9051X6irGsaMZcurD617Wa7Cp2w28QX4q8EV/rt2rgHzul5MMYpN2kjnRa9n64lLTzl/0
 Jpnrf5IliLi+R+yiNk/AiA0Rkq6mTJg8XVLXmkC2q+wI1n2jCfCbymbziYKF2nvhN7n/oX1sK5fCe
 xq1BPwAGlso6keqhmf+NrBAtMIwCkxdjWO/917N9TvadsLYkw5uRlIadPKjU/O4pHEa+NK4fSi7hd
 SwRlzCqmBGEyLwQXI8HUPNDAwAz7JoVO/QonstUwh8As4sseTM8LNOLYjkkGVIoibLHz9zfgjsEbQ
 GOwQKY2w==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9TqA-006KVk-Vn; Wed, 23 Sep 2026 22:45:18 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 23 Sep 2026 17:44:41 -0300
Subject: [PATCH i-g-t v7 6/9] lib/amdgpu: add amdgpu support to igt_dmem_driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-dmem_max-v7-6-194ea47bbb4d@igalia.com>
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

This allows dmem cgroups tests to run on top of amdgpu driver, adding
support to allocate and release VRAM memory.

This does this by allocating a BO from VRAM domain, which will try to
place BOs on VRAM, but may fallback to GTT.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 lib/amdgpu/amd_dmem.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/igt_dmem_driver.h |  1 +
 lib/meson.build       |  1 +
 3 files changed, 92 insertions(+)

diff --git a/lib/amdgpu/amd_dmem.c b/lib/amdgpu/amd_dmem.c
new file mode 100644
index 000000000000..dd1e9083170b
--- /dev/null
+++ b/lib/amdgpu/amd_dmem.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Valve Corporation
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
index 821ccb7a29a9..ad739c536435 100644
--- a/lib/igt_dmem_driver.h
+++ b/lib/igt_dmem_driver.h
@@ -31,5 +31,6 @@ struct igt_dmem_driver {
 };
 
 extern const struct igt_dmem_driver xe_dmem_driver;
+extern const struct igt_dmem_driver amdgpu_dmem_driver;
 
 #endif
diff --git a/lib/meson.build b/lib/meson.build
index c5d35bc8e88e..b9075ff37631 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -207,6 +207,7 @@ if libdrm_amdgpu.found()
 		'amdgpu/amd_mmd_shared.c',
 		'amdgpu/amd_jpeg_shared.c',
 		'amdgpu/amd_utils.c',
+		'amdgpu/amd_dmem.c',
 		'amdgpu/amd_vcn_shared.c'
 	]
 	if libdrm_amdgpu.version().version_compare('> 2.4.99')

-- 
2.47.3

