Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D3AC624DE
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 22:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B719B10F7C9;
	Thu,  3 Sep 2026 22:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mWxFd83/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F9E10F7BD;
 Thu,  3 Sep 2026 22:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=FkmyOOSfgUdEr7sP8I2zpSYHh7cll3fuy6nX0RpNhlY=; b=mWxFd83/kUVEWo0xieEg3Dn0Km
 pD5UKhw2zqkRqpwYSalzdtVwdxBHAKrNfN7zUjMazgPawvyrlHnI8KSBGo0EmYXL2OERmUOoVXvGQ
 /7ae9EkHK0omh4xL8EBLa0usL7z/N/je4igftVdO8jsut42T0IATknpYacCK/F9D5KIsMNU271Vlh
 dQ+OjRMmbthtJuLheGFUAGNaWCoLcFPFOcf5zVFr2iKg/0ubWoDtSPUtN3iN9Dv5oslPST3ZZNy72
 GLukUQ1Xe7GD8Hx4KzEZMwust56vTSq0bLYKK9zUomjO5eaDWqRoo0XvmFR94XCqONpPQoPoEMtiT
 +sBUplhg==;
Received: from [187.43.152.48] (helo=[127.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x2FUe-00EbUz-A9; Fri, 04 Sep 2026 00:01:12 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Thu, 03 Sep 2026 19:00:27 -0300
Subject: [PATCH i-g-t v6 5/9] lib/amdgpu: add amdgpu_cgroup_region_name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-dmem_max-v6-5-61dc62970fae@igalia.com>
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

The amdgpu dmem region name uses its PCI address, just like the one from
Xe, but there is only a single VRAM region.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 lib/amdgpu/amd_memory.c | 25 +++++++++++++++++++++++++
 lib/amdgpu/amd_memory.h |  2 ++
 2 files changed, 27 insertions(+)

diff --git a/lib/amdgpu/amd_memory.c b/lib/amdgpu/amd_memory.c
index 12fe23c65ab2..2da4a8a4baee 100644
--- a/lib/amdgpu/amd_memory.c
+++ b/lib/amdgpu/amd_memory.c
@@ -30,9 +30,11 @@
 #include <amdgpu_drm.h>
 #include <stdio.h>
 #include <string.h>
+#include <limits.h>
 #include <unistd.h>
 #include <sys/mman.h>
 #include <inttypes.h>
+#include "igt_device.h"
 
 /**
  *
@@ -679,6 +681,29 @@ bool virtual_free_memory(void *address, unsigned int size)
 	}
 }
 
+/**
+ * amdgpu_cgroup_region_name() - Build the dmem cgroup region name for an amdgpu.
+ * @fd: amdgpu device fd.
+ *
+ * Constructs the full dmem cgroup region path for VRAM on the device
+ * identified by @fd.  The returned string has the form
+ * ``drm/<pci-slot>/vram`` (e.g. ``drm/0000:03:00.0/vram``), matching
+ * the name registered by the kernel driver via drmm_cgroup_register_region().
+ *
+ * Return: A newly allocated string that the caller must free(), or %NULL if
+ * @region is not tracked by the dmem cgroup controller.
+ */
+char *amdgpu_cgroup_region_name(int fd)
+{
+	char pci_slot[NAME_MAX];
+	char *name;
+
+	igt_device_get_pci_slot_name(fd, pci_slot);
+
+	igt_assert(asprintf(&name, "drm/%s/vram", pci_slot) > 0);
+	return name;
+}
+
 /**
  * Wait for specific value in memory with timeout
  */
diff --git a/lib/amdgpu/amd_memory.h b/lib/amdgpu/amd_memory.h
index e26c85bc4b0a..de169e580c1b 100644
--- a/lib/amdgpu/amd_memory.h
+++ b/lib/amdgpu/amd_memory.h
@@ -105,6 +105,8 @@ void
 bool
 virtual_free_memory(void *address, unsigned int size);
 
+char *amdgpu_cgroup_region_name(int fd);
+
 bool
 wait_on_value(unsigned int *ptr, unsigned int expected);
 #endif

-- 
2.47.3

