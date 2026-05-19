Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83921CD5BAC
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 07:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B40B110EF31;
	Wed, 20 May 2026 07:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="anxTFeYw";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C8DD10E603
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 20:32:42 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5a8d1f43432so7430600e87.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 13:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779222760; x=1779827560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=X/ikCjUtr9BLtmgftFXqw6yHcczZAk5L2NhLLXZIjFQ=;
 b=anxTFeYwk0bhvqbZkAv9NEOozy36No4CSvoWtpc7XsJDXbmBL7CRbk0g08Y1h+5Psf
 9yEiTh7VVxClydbPQXqpeR2SJUJUVA7U1rqJjJoepAYVVOrE30sQkfAHAYDgidV3Csd0
 PvNokh1DYO01uudlj7/rlq/Bga+GiQuZDywUVxCiqR1od0E36xgmnruTRm4xAWVTXVLr
 Hk4Ig0faP2TxWm6X2h1cHedstfnl331Th+o1FVyxird9zEYdDNNYyKrQCHCOIEE6RnbW
 5igXI7xtf1wsvVM0EWYPyzGBy3VfBmE5fgBdxb9KXLJA1bepJbuvhU0ZPj2h2szIfLI8
 IrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779222760; x=1779827560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X/ikCjUtr9BLtmgftFXqw6yHcczZAk5L2NhLLXZIjFQ=;
 b=SiwQxRNFCnt5z+0WBHxOew5PW2GZlKg1G1ix8BRrnqQRwFnT1Q0JFagF3EC8HMUg7K
 ShSHssKKMNgzCjI9uP4DbrXL0kmWjUqTmAFoTicx5PnvtGAK4IigbDT8G3lgGQm3ePR8
 HcTz5+rlQ+QYvEBBGUmJ3GEe8GY5X1qpg+iSY/Oe5m5TVGw0dfdW6VJOTibAPt4MkNug
 znT6YUCNXAz3FuHqvFKYvmMGGeGfKGY8YsiV2w9AS1lqaigmDN5ZLfWvZvv10h/yf7lN
 NpT+uGvjQSKRmzUiChJdDiJgv14qMDis9pzvdZEw0PDn6HD5L7O435u8HAswcisjIDbi
 o7zg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cvA9q7wWN49R28jmnlpShzEQcneZBNvmpeiZcnifYhbAICAVqpsIGlFrq3RqshSfA06dAwPf9C+Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAtNzSKOkMd2x6/honNpVhu2LDg3M8IH2mDUTDbhm/MTxwhTT9
 NdjKi1M0iBXAGQIm2M2QUDoO7OyXccrH3cfTNwASlVjVlOFAV68T1VA/
X-Gm-Gg: Acq92OECNpRxBLbRnuCZvTco/K6X6JOiidZEN6hWoY7cI6zSYPNFB8cg1mNswQ8qoWt
 riLnZNyR1I/IHXGWk2cX5+oMUwN2x3UCpPDAID4jQcMIT01AjrFXRocmM3MoCeKEPjaB+J6qbBz
 aQYFF+Uulp/ypADqx2ywnfGLpajvhgsNUocVd3P/3k6Nr/hHK2zCcbMACKxi1jsAgcEodzhulsd
 KfqZKVZzZ1jv5twAmu6XayoHN4XQlkjREkaFm1hrGFYE9PEiUnhlee0q6R4Gd9vTfYduRsVJMFv
 YkCSrTdAZ+131zr8T/dtXFucwMd4hroGE2F60RtasGhkLsUrLPw3bx+maRJ4skT+aEX22fG/ktw
 i+gHqNZS6PIsuAqlxvFVKH42+IZCyMWXlzWSOi7PegNnLfaKzovmPiPV1Pqp0YD0czs3OQtrYjZ
 wEiWKjsgeqo/Ak0zyhsw7FtlGcwCl8YkxuYPWkUUNj8l3qq1vD1qv7n5jp
X-Received: by 2002:a05:6512:244:b0:5aa:126b:4504 with SMTP id
 2adb3069b0e04-5aa126b454bmr5249173e87.23.1779222760285; 
 Tue, 19 May 2026 13:32:40 -0700 (PDT)
Received: from Shofiq.home (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a9164c5a36sm4413800e87.60.2026.05.19.13.32.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 13:32:38 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: mamin506@gmail.com
Cc: lizhi.hou@amd.com, dri-devel@lists.freedesktop.org,
 Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH] drm/accel/amdxdna: add debugfs support
Date: Tue, 19 May 2026 23:32:36 +0300
Message-ID: <20260519203236.252068-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 May 2026 07:13:27 +0000
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

Expose driver state through debugfs to aid debugging and development.
Three read-only entries are created under /sys/kernel/debug/accel/<N>/:

 - fw_version:  firmware version as major.minor.sub.build
 - device_info: device VBNV string and device type identifier
 - clients:     per-fd info (pid, heap usage, total BO usage)

Resolves the TODO item in drivers/accel/amdxdna/TODO.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/accel/amdxdna/Makefile          |  1 +
 drivers/accel/amdxdna/amdxdna_debugfs.c | 63 +++++++++++++++++++++++++
 drivers/accel/amdxdna/amdxdna_debugfs.h | 17 +++++++
 drivers/accel/amdxdna/amdxdna_pci_drv.c |  3 ++
 4 files changed, 84 insertions(+)
 create mode 100644 drivers/accel/amdxdna/amdxdna_debugfs.c
 create mode 100644 drivers/accel/amdxdna/amdxdna_debugfs.h

diff --git a/drivers/accel/amdxdna/Makefile b/drivers/accel/amdxdna/Makefile
index cf9bf19de..01a809d88 100644
--- a/drivers/accel/amdxdna/Makefile
+++ b/drivers/accel/amdxdna/Makefile
@@ -10,6 +10,7 @@ amdxdna-y := \
 	aie2_smu.o \
 	aie2_solver.o \
 	amdxdna_ctx.o \
+	amdxdna_debugfs.o \
 	amdxdna_gem.o \
 	amdxdna_iommu.o \
 	amdxdna_mailbox.o \
diff --git a/drivers/accel/amdxdna/amdxdna_debugfs.c b/drivers/accel/amdxdna/amdxdna_debugfs.c
new file mode 100644
index 000000000..6806698c3
--- /dev/null
+++ b/drivers/accel/amdxdna/amdxdna_debugfs.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ */
+
+#include <drm/drm_debugfs.h>
+#include <drm/drm_device.h>
+
+#include "amdxdna_debugfs.h"
+#include "amdxdna_pci_drv.h"
+
+static inline struct amdxdna_dev *seq_to_xdna(struct seq_file *s)
+{
+	struct drm_debugfs_entry *entry = s->private;
+
+	return to_xdna_dev(entry->dev);
+}
+
+static int fw_version_show(struct seq_file *s, void *v)
+{
+	struct amdxdna_dev *xdna = seq_to_xdna(s);
+
+	seq_printf(s, "%d.%d.%d.%d\n",
+		   xdna->fw_ver.major, xdna->fw_ver.minor,
+		   xdna->fw_ver.sub, xdna->fw_ver.build);
+	return 0;
+}
+
+static int device_info_show(struct seq_file *s, void *v)
+{
+	struct amdxdna_dev *xdna = seq_to_xdna(s);
+
+	seq_printf(s, "vbnv:        %s\n", xdna->dev_info->vbnv);
+	seq_printf(s, "device_type: %d\n", xdna->dev_info->device_type);
+	return 0;
+}
+
+static int clients_show(struct seq_file *s, void *v)
+{
+	struct amdxdna_dev *xdna = seq_to_xdna(s);
+	struct amdxdna_client *client;
+
+	mutex_lock(&xdna->dev_lock);
+	list_for_each_entry(client, &xdna->client_list, node)
+		seq_printf(s, "pid %d heap_usage %zu total_bo_usage %zu\n",
+			   client->pid, client->heap_usage,
+			   client->total_bo_usage);
+	mutex_unlock(&xdna->dev_lock);
+
+	return 0;
+}
+
+static const struct drm_debugfs_info amdxdna_debugfs_list[] = {
+	{ "fw_version",  fw_version_show,  0 },
+	{ "device_info", device_info_show, 0 },
+	{ "clients",     clients_show,     0 },
+};
+
+void amdxdna_debugfs_init(struct amdxdna_dev *xdna)
+{
+	drm_debugfs_add_files(&xdna->ddev, amdxdna_debugfs_list,
+			      ARRAY_SIZE(amdxdna_debugfs_list));
+}
diff --git a/drivers/accel/amdxdna/amdxdna_debugfs.h b/drivers/accel/amdxdna/amdxdna_debugfs.h
new file mode 100644
index 000000000..e742a81fe
--- /dev/null
+++ b/drivers/accel/amdxdna/amdxdna_debugfs.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024, Advanced Micro Devices, Inc.
+ */
+
+#ifndef _AMDXDNA_DEBUGFS_H_
+#define _AMDXDNA_DEBUGFS_H_
+
+struct amdxdna_dev;
+
+#ifdef CONFIG_DEBUG_FS
+void amdxdna_debugfs_init(struct amdxdna_dev *xdna);
+#else
+static inline void amdxdna_debugfs_init(struct amdxdna_dev *xdna) {}
+#endif
+
+#endif /* _AMDXDNA_DEBUGFS_H_ */
diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
index b50a7d1f8..19866dbed 100644
--- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
+++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
@@ -15,6 +15,7 @@
 #include <linux/pci.h>
 
 #include "amdxdna_ctx.h"
+#include "amdxdna_debugfs.h"
 #include "amdxdna_gem.h"
 #include "amdxdna_pci_drv.h"
 #include "amdxdna_pm.h"
@@ -319,6 +320,8 @@ static int amdxdna_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto failed_sysfs_fini;
 	}
 
+	amdxdna_debugfs_init(xdna);
+
 	return 0;
 
 failed_sysfs_fini:
-- 
2.51.1

