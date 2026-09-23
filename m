Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED359C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F7D10F1B0;
	Wed, 23 Sep 2026 20:45:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="ke7tDSPv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7011D10F1BB;
 Wed, 23 Sep 2026 20:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=n2VfsyIPMQV4+RsBmUQcSmWAc2DpqI1+tED7RtaYpdQ=; b=ke7tDSPvU67PWtlbTL9HQc1zQ/
 wsb4lTgpFMwc3/Ryheh8weJEoLpalCSRoHARtG4IvGQT6L+NIzfiRoUn1p7/VeI3PXwLMpEsnIzUF
 mMeBFmn7kKXruFSA9YpdQ6Sl0DxUUX7zgwKy4uOHuHWx4QEJ5d4puCSQBnGNqsfPkIEtt2Si8NrxV
 y3uaG9Dqg2PplKHD1iAowml8GfvSinwgkPpS7Svs82h/CsiT9YG9dKI+vXUbkPSCVJDixhAzEV0B7
 myKRuIrKMAI4RdQYdAi5g+iM0e4zNSqgP3dVtW3rKWAk0Y1K5gRkLFmhc6Q7lksZ3ZkE/ocvwXdwB
 Xf1vIT5Q==;
Received: from 179-125-72-1-dinamico.pombonet.net.br ([179.125.72.1]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x9Tpw-006KVk-6z; Wed, 23 Sep 2026 22:45:04 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Wed, 23 Sep 2026 17:44:38 -0300
Subject: [PATCH i-g-t v7 3/9] lib/xe: add xe_cgroup_region_name() helper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-dmem_max-v7-3-194ea47bbb4d@igalia.com>
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

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

Add xe_cgroup_region_name(fd, region) which constructs the dmem cgroup
region path for a given xe memory region.  The returned string has the
form "drm/<pci-slot>/<region>" (e.g. "drm/0000:03:00.0/vram0"),
matching the name registered by the kernel via drmm_cgroup_register_region().

Only VRAM regions are tracked by the dmem controller; system and stolen
memory regions return NULL.

Assisted-by: GitHub Copilot:claude-sonnet-4.6
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 lib/xe/xe_query.c | 32 ++++++++++++++++++++++++++++++++
 lib/xe/xe_query.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/lib/xe/xe_query.c b/lib/xe/xe_query.c
index 91ffc36e6425..058f95ed1484 100644
--- a/lib/xe/xe_query.c
+++ b/lib/xe/xe_query.c
@@ -7,6 +7,7 @@
  */
 
 #include <fcntl.h>
+#include <limits.h>
 #include <stdlib.h>
 #include <pthread.h>
 
@@ -21,6 +22,7 @@
 
 #include "drmtest.h"
 #include "igt_debugfs.h"
+#include "igt_device.h"
 #include "ioctl_wrappers.h"
 #include "igt_map.h"
 #include "intel_common.h"
@@ -1302,6 +1304,36 @@ int xe_query_eu_thread_count(int fd, int gt)
 		xe_hwconfig_lookup_value_u32(fd, INTEL_HWCONFIG_NUM_THREADS_PER_EU);
 }
 
+/**
+ * xe_cgroup_region_name() - Build the dmem cgroup region name for an xe memory region.
+ * @fd: xe device fd.
+ * @region: Region mask (as used by xe_mem_region(), xe_region_name(), etc.).
+ *
+ * Constructs the full dmem cgroup region path for @region on the device
+ * identified by @fd.  The returned string has the form
+ * ``drm/<pci-slot>/<region>`` (e.g. ``drm/0000:03:00.0/vram0``), matching
+ * the name registered by the kernel driver via drmm_cgroup_register_region().
+ *
+ * Only VRAM regions are registered with the dmem controller; passing a
+ * system-memory region returns %NULL.
+ *
+ * Return: A newly allocated string that the caller must free(), or %NULL if
+ * @region is not tracked by the dmem cgroup controller.
+ */
+char *xe_cgroup_region_name(int fd, uint64_t region)
+{
+	char pci_slot[NAME_MAX];
+	char *name;
+
+	if (xe_region_class(fd, region) != DRM_XE_MEM_REGION_CLASS_VRAM)
+		return NULL;
+
+	igt_device_get_pci_slot_name(fd, pci_slot);
+
+	igt_assert(asprintf(&name, "drm/%s/%s", pci_slot, xe_region_name(region)) > 0);
+	return name;
+}
+
 igt_constructor
 {
 	xe_device_cache_init();
diff --git a/lib/xe/xe_query.h b/lib/xe/xe_query.h
index 59330d80fd1b..a6ef9cab9aa1 100644
--- a/lib/xe/xe_query.h
+++ b/lib/xe/xe_query.h
@@ -206,4 +206,6 @@ void xe_device_put(int fd);
 int xe_query_eu_count(int fd, int gt);
 int xe_query_eu_thread_count(int fd, int gt);
 
+char *xe_cgroup_region_name(int fd, uint64_t region);
+
 #endif	/* XE_QUERY_H */

-- 
2.47.3

