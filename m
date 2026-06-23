Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D05CDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 17:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6812810E1F5;
	Tue, 23 Jun 2026 17:43:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="e8RpEkEc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87D0F10E1F5;
 Tue, 23 Jun 2026 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6TVXvKXi2fz4NFUSpDpWa+zkRcGFMS2H8TncLOLuN0w=; b=e8RpEkEcfLyZ/FbgulR4wYdqpe
 Q12uCG9SSR6B6k98EJd5ZjNKXX7JHSPAARzley5T5YRcOeDY9cao5bwJ5fCOeWZvW/ltvVjs1fIgY
 DOaK6mNjkt5anFdkHwjMJtkMKxnM6J1xZIYWJ3kZVri7RCyRtqIJGFeMqklsDJWGOxiJflDStP0ON
 4snlic9LpX96MKWI1pjSvSnuCEM61XmpPIKw+u3Zluhn46KQ2SyxaW3SIQuqGE622c3DKhBvhbp0J
 +RtSWn1s56oQvvlggY1KDurZTcw21tL5SJlAyUT3nt9d10GuAj5Ths5VWs2IAcbPoCnJIn7zD9tkI
 RGIKqOsg==;
Received: from 179-125-64-254-dinamico.pombonet.net.br ([179.125.64.254]
 helo=quatroqueijos.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wc5A3-004HEi-1A; Tue, 23 Jun 2026 19:43:47 +0200
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
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, kernel-dev@igalia.com
Subject: [PATCH i-g-t 3/7] lib/xe: add xe_cgroup_region_name() helper
Date: Tue, 23 Jun 2026 14:43:15 -0300
Message-ID: <20260623174319.4138648-4-cascardo@igalia.com>
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
index f0799f268cf4..192d9566178a 100644
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
 #include "intel_pat.h"
@@ -1290,6 +1292,36 @@ int xe_query_eu_thread_count(int fd, int gt)
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
index 9f04a7422042..a34e9a6592b9 100644
--- a/lib/xe/xe_query.h
+++ b/lib/xe/xe_query.h
@@ -205,4 +205,6 @@ void xe_device_put(int fd);
 int xe_query_eu_count(int fd, int gt);
 int xe_query_eu_thread_count(int fd, int gt);
 
+char *xe_cgroup_region_name(int fd, uint64_t region);
+
 #endif	/* XE_QUERY_H */
-- 
2.47.3

