Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05016C44507
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 21:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 559BC10EE29;
	Tue, 14 Jul 2026 21:16:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TDVUca3h";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6FEF10EE69
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 21:16:31 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f3e6cc44aso2343783f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784063790; x=1784668590; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/0bDbsUAsCNrKRVFeKWSEZSKWRta+w0G44odHsje0xU=;
 b=TDVUca3hGY163A+s78reNf6YxDGDIE+4u+hZwDzj4zLfugXX6r0YERlKd7XdIN62gk
 /5pJfrhzd/IRct9dGwoKBgfah97tttHZYchPPM+FDp8dbiJyi7rg+ACuDFrmI9zJ5cHh
 xojaV/Pg6gfXSlCalWUMIK7cNPRUJ3kCLvBbGIO66Gl3GgGhoIANliEuZ7kQPcmxrSUG
 QYMsOo/UVJk7Z4P2oaCZMw93/x7F5UN6RFm8/yr1flGIyMNVWO/Y3fDAHzxNZjA/P4SW
 EY70P1rz7bC2rQ45wZLL/JnZaR9A/Vq/sxcnMvpIbBrIlEN4FEDBhRY9UgE0cZmCrJH9
 AXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784063790; x=1784668590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/0bDbsUAsCNrKRVFeKWSEZSKWRta+w0G44odHsje0xU=;
 b=EDYcGgz1tHd4kirv/GWXw+4w/ir445LOIF2PFWmdaTW0T2zYZUdDj4qfeGFv+DIjG2
 veHbY4QCNC+oy+0hPLeeRrA3l+uTKX0NV1RO4VfNU79OrlBqJpS9Oi9VyFW4pOjbti6j
 owScwu7HY95ZCm5Oju3VGrQWKfw4BrPgVWm+GcOsMHSdeYjZBEOFR8yrVkf0MUtNIGwN
 Lo/kPZPgX7MHk5kkps3bjWJ26xMxFR7JQmC435L+AfvlVf/Bt+ObohUhtX+9OpAROGFg
 1doMLRvE4iK+FXSHliL7ZRXSZ9p24QFbpJVr5gcZL3tB5Jfjl0LYF4PKvYkb37/PK3nX
 oCZQ==
X-Gm-Message-State: AOJu0YxuG51UvZZHh6S/Fqbse+uayfTXwXrsing9jWD53BSATy+8VZIp
 s5X6l4nldAi0MEHJA2gOzt00WS5o2cUNSrZ9FvO2q0QZAoWAXLDm4QvV
X-Gm-Gg: AfdE7cn3RHZOjjgPRDziKxnAwMGKScFJHWYfY3G9446IEGx8XltwUrANElK/YkJk77c
 GQf/4GT0QwrUQ8YXZHGKrxKVBLPSO+ZPcdadeAyDhYptSE9w4iNNr3YG6nQJtTitlok1itTCDLm
 sEfQGtMdLEgQN4ouJ5tFjNJY/JTYRTRFnJYhT3yq6fC5gG5+CYQh97jZ283xLcQxCp/i+Qb6i8V
 uDMXYVJgLUQ3XMSW5czxrY3yyZdSkPyY5ZQt4Ni/JiOwftXYgdhPPFZ+caNWF9jEDs8utdk9Xwi
 ax0P0+KbXSf5imG6z33Lu/t5oXg6iv8PX03oZHJdAEjtjUMe8O+sdh3SPH7nWAw+pgj339c001D
 HntWCxxgDzv+hH08KQd5fl507ugnpp7/WjbX2zZMVBSKIW0Hwxt19v11bIbznkBiPL7z3FRKvB5
 99naZGfKhakWX5A+/KfI0tqDeAL0+67R0=
X-Received: by 2002:a05:600c:c84:b0:493:ece1:86b9 with SMTP id
 5b1f17b1804b1-495389cdfbdmr41072165e9.8.1784063790070; 
 Tue, 14 Jul 2026 14:16:30 -0700 (PDT)
Received: from fedora ([94.205.182.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a32a2casm149843875e9.12.2026.07.14.14.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 14:16:28 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Mary Guillemard <mary@mary.zone>,
 Milos Tijanic <mtijanic@nvidia.com>, nouveau@lists.freedesktop.org,
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Subject: [PATCH 5/6] drm/nouveau: expose global VRAM size and usage via sysfs
Date: Wed, 15 Jul 2026 01:14:28 +0400
Message-ID: <20260714211429.238355-6-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
References: <20260714211429.238355-1-mohamedahmedegypt2001@gmail.com>
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

Monitoring tools want a device-wide VRAM total and current usage, but
nouveau exposed neither outside of NOUVEAU_GETPARAM ioctls, which are
awkward to use for some tools as they rely on pulling libdrm.

Add two read-only files in a device attribute group:

  mem_info_vram_total  user-accessible VRAM, i.e. NOUVEAU_GETPARAM_FB_SIZE
  mem_info_vram_used   bytes currently allocated from the VRAM TTM manager

Both read nouveau's own framebuffer and TTM accounting, the exact source
behind the FB_SIZE/VRAM_USED getparams, so they need no GSP and are
present on every board, unlike the GSP-only RUSD group. total is the size
of the pool used draws from, so used never exceeds total. used counts only
memory nouveau itself allocated and can read below firmware-reserved usage.

Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
---
 .../ABI/testing/sysfs-driver-nouveau          | 17 +++++-
 drivers/gpu/drm/nouveau/nouveau_drv.h         |  1 +
 drivers/gpu/drm/nouveau/nouveau_sysfs.c       | 61 +++++++++++++++++++
 3 files changed, 78 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-nouveau b/Documentation/ABI/testing/sysfs-driver-nouveau
index 947474b9955d..968c3ac0c464 100644
--- a/Documentation/ABI/testing/sysfs-driver-nouveau
+++ b/Documentation/ABI/testing/sysfs-driver-nouveau
@@ -149,4 +149,19 @@ Date:		June 2026
 Contact:	nouveau <nouveau@lists.freedesktop.org>
 Description:
 		PCIe link telemetry. pcie_gen is a packed gen/width bitfield;
-		the remaining files are link error and event counters.
\ No newline at end of file
+		the remaining files are link error and event counters.
+
+What:		/sys/class/drm/card<n>/device/mem_info_vram_total
+What:		/sys/class/drm/card<n>/device/mem_info_vram_used
+Date:		June 2026
+Contact:	nouveau <nouveau@lists.freedesktop.org>
+Description:
+		The amount of VRAM usable for allocations and the amount currently
+		in use, in bytes, world-readable and read-only. mem_info_vram_total
+		is the installed VRAM minus the region firmware reserves. This is the
+		same value as NOUVEAU_GETPARAM_FB_SIZE, so it can read slightly below
+		the card's marketed size, and it is the size of the pool that
+		mem_info_vram_used draws from (so used never exceeds total). Both
+		come from nouveau's own framebuffer and TTM accounting (the same
+		source as the FB_SIZE/VRAM_USED ioctls) and are present on every
+		nouveau board, independent of GSP-RM.
\ No newline at end of file
diff --git a/drivers/gpu/drm/nouveau/nouveau_drv.h b/drivers/gpu/drm/nouveau/nouveau_drv.h
index a3e343085cc1..a8ca86556e2f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drv.h
+++ b/drivers/gpu/drm/nouveau/nouveau_drv.h
@@ -297,6 +297,7 @@ struct nouveau_drm {
 	struct nouveau_hwmon *hwmon;
 	struct nouveau_debugfs *debugfs;
 	bool rusd_sysfs;
+	bool mem_sysfs;
 
 	/* led management */
 	struct nouveau_led *led;
diff --git a/drivers/gpu/drm/nouveau/nouveau_sysfs.c b/drivers/gpu/drm/nouveau/nouveau_sysfs.c
index f3d9462deaba..789b3781bedc 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sysfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sysfs.c
@@ -7,11 +7,18 @@
  * file is one decoded value; nvkm owns the units and conversions. A section
  * that is not supported on this board, or has not been polled yet, reads
  * -ENODATA. See Documentation/ABI/testing/sysfs-driver-nouveau for units.
+ *
+ * Also exposes global VRAM size and usage (mem_info_vram_total/used, bytes)
+ * from nouveau's own FB/TTM accounting. Unlike RUSD these do not need GSP and
+ * are present on every board.
  */
 #include <linux/device.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/sysfs.h>
 
+#include <drm/ttm/ttm_placement.h>
+#include <drm/ttm/ttm_resource.h>
+
 #include "nouveau_drv.h"
 #include "nouveau_sysfs.h"
 
@@ -214,11 +221,60 @@ static const struct attribute_group rusd_group = {
 	.attrs = rusd_attrs,
 };
 
+/*
+ * Global VRAM size and current usage, in bytes. These use the same source as the
+ * NOUVEAU_GETPARAM_FB_SIZE/VRAM_USED ioctls, and are exposed here as a more
+ * convenient way for monitoring tools to access the data.
+ *
+ * Unlike the RUSD group these need no GSP and are present on every board.
+ */
+static ssize_t
+mem_info_vram_total_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nouveau_drm *drm = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%llu\n", drm->client.device.info.ram_user);
+}
+static DEVICE_ATTR_RO(mem_info_vram_total);
+
+static ssize_t
+mem_info_vram_used_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct nouveau_drm *drm = dev_get_drvdata(dev);
+	struct ttm_resource_manager *vram = ttm_manager_type(&drm->ttm.bdev, TTM_PL_VRAM);
+
+	return sysfs_emit(buf, "%llu\n", ttm_resource_manager_usage(vram));
+}
+static DEVICE_ATTR_RO(mem_info_vram_used);
+
+static struct attribute *nouveau_mem_attrs[] = {
+	&dev_attr_mem_info_vram_total.attr,
+	&dev_attr_mem_info_vram_used.attr,
+	NULL,
+};
+
+static const struct attribute_group nouveau_mem_group = {
+	.attrs = nouveau_mem_attrs,
+};
+
 int
 nouveau_sysfs_init(struct nouveau_drm *drm)
 {
 	int ret;
 
+	/*
+	 * VRAM size/usage comes from nouveau's own accounting, so this group is
+	 * present on every board (GSP or legacy).
+	 *
+	 * The group is NOT devm-managed on drm->dev->dev: that device's devres
+	 * outlives nouveau's remove path (which frees the drm objects the files
+	 * read), so it is torn down explicitly in nouveau_sysfs_fini() before that.
+	 */
+	ret = device_add_group(drm->dev->dev, &nouveau_mem_group);
+	if (ret)
+		return ret;
+	drm->mem_sysfs = true;
+
 	/*
 	 * Only GPUs running GSP with RUSD registered (r570+) get the group. On
 	 * everything else there is nothing to expose. All files appear when RUSD
@@ -247,4 +303,9 @@ nouveau_sysfs_fini(struct nouveau_drm *drm)
 		device_remove_group(drm->dev->dev, &rusd_group);
 		drm->rusd_sysfs = false;
 	}
+
+	if (drm->mem_sysfs) {
+		device_remove_group(drm->dev->dev, &nouveau_mem_group);
+		drm->mem_sysfs = false;
+	}
 }
-- 
2.55.0

