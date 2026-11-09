Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB79606A337
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FaboM7pJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E699610F366;
	Mon,  9 Nov 2026 13:58:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4EE510F33B;
 Mon,  9 Nov 2026 13:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794232673; x=1825768673;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lJ+MpfaXsLLB/CoYg6rP2y+Y3CdlnNLtqwLbXPCmfXM=;
 b=FaboM7pJciNcFKBMdapaWvNEXMbf/1yp5kGp6QWifuxiFgQA64MbVtL+
 jvcOLMAC9OuWUj+pk5hN1SV0++1NRXTrGSehP7byr/9443hOPZYQ4xjSl
 qEwwgrbZl2GU1Vcg1mESwLLdvBHryH5YXCF19yIkIQCmYS5uCnqZeYZkz
 M3Oz7zQ1qLcTTgSZAsh5JenBAvlvJ16bsg/JdjOL/2YXCpr+dZGG0qY1R
 TWaLwypBvuvAOXr9pN2AfeUZy/SYrUFqFUYL34p00fARmnHy6qwPpMU8A
 Yhu+aVDZNrU30jmyIIy119aOb0Zo0RewGHtyxKjHwSAKXacrmXdQWBKJQ g==;
X-CSE-ConnectionGUID: x+FkxOE3Re2cx54hmIJAww==
X-CSE-MsgGUID: 5SgTeHB4SsCfgrvvQaQo1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2851008"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2851008"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:53 -0800
X-CSE-ConnectionGUID: YyYBSOgFRLWSrFqr4SM7zg==
X-CSE-MsgGUID: w44LQZWdRI6PST79USWkOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8203087"
Received: from pgcooper-mobl2.ger.corp.intel.com (HELO
 mkuoppal-desk.home.arpa) ([10.245.246.220])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 05:57:47 -0800
From: Mika Kuoppala <mika.kuoppala@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: simona.vetter@ffwll.ch, matthew.brost@intel.com, christian.koenig@amd.com,
 thomas.hellstrom@linux.intel.com, joonas.lahtinen@linux.intel.com,
 gustavo.sousa@intel.com, jan.maslak@intel.com,
 dominik.karol.piatkowski@intel.com, rodrigo.vivi@intel.com,
 andrzej.hajda@intel.com, matthew.auld@intel.com,
 maciej.patelczyk@intel.com, gwan-gyeong.mun@intel.com,
 michal.wajdeczko@intel.com, dri-devel@lists.freedesktop.org,
 Christoph Manszewski <christoph.manszewski@intel.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: [PATCH 20/20] drm/xe: Add xe_client_debugfs and introduce debug_data
 file
Date: Mon,  9 Nov 2026 15:55:45 +0200
Message-ID: <20261109135549.4128280-21-mika.kuoppala@linux.intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christoph Manszewski <christoph.manszewski@intel.com>

Create a debug_data file for each xe file/client. It lists all mapped
debug data and mimics '/proc/pid/maps'.
Each line represents a single mapping and has the following format:

  <vm id> <begin>-<end> <flags> <offset>	<pathname>

v2: trim len in debug_data_read() (Sashiko)
v3: - fix return len, avoid rewind (Sashiko)
    - use guard, kdoc, cleanups (Michal)
    - drop client ref after seq_file is done (Claude)

Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Christoph Manszewski <christoph.manszewski@intel.com>
Signed-off-by: Maciej Patelczyk <maciej.patelczyk@intel.com>
Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
---
 drivers/gpu/drm/xe/Makefile            |   3 +-
 drivers/gpu/drm/xe/xe_client_debugfs.c | 134 +++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_client_debugfs.h |  17 ++++
 drivers/gpu/drm/xe/xe_device.c         |   3 +
 4 files changed, 156 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/xe/xe_client_debugfs.c
 create mode 100644 drivers/gpu/drm/xe/xe_client_debugfs.h

diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
index 356f44aac308..dface1936da3 100644
--- a/drivers/gpu/drm/xe/Makefile
+++ b/drivers/gpu/drm/xe/Makefile
@@ -366,7 +366,8 @@ ifeq ($(CONFIG_DRM_FBDEV_EMULATION),y)
 endif
 
 ifeq ($(CONFIG_DEBUG_FS),y)
-	xe-y += xe_debugfs.o \
+	xe-y += xe_client_debugfs.o \
+		xe_debugfs.o \
 		xe_gt_debugfs.o \
 		xe_gt_sriov_vf_debugfs.o \
 		xe_gt_stats.o \
diff --git a/drivers/gpu/drm/xe/xe_client_debugfs.c b/drivers/gpu/drm/xe/xe_client_debugfs.c
new file mode 100644
index 000000000000..ca0f83acf8af
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_client_debugfs.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "xe_client_debugfs.h"
+#include "xe_debug_data.h"
+#include "xe_debug_data_types.h"
+#include "xe_device.h"
+#include "xe_device_types.h"
+#include "xe_vm.h"
+#include "xe_vm_types.h"
+
+static void debug_data_show_vm(struct seq_file *m, unsigned long vm_id,
+			       struct xe_vm *vm)
+{
+	struct xe_debug_data *dd;
+
+	guard(mutex)(&vm->debug_data.lock);
+
+	list_for_each_entry(dd, &vm->debug_data.list, link) {
+		/* Format: <vm id> <begin>-<end> <flags> <offset>\t<pathname> */
+		seq_printf(m, "%lu 0x%llx-0x%llx 0x%llx 0x%llx\t",
+			   vm_id,
+			   dd->addr,
+			   dd->addr + dd->range,
+			   dd->flags,
+			   dd->offset);
+
+		if (dd->flags & DRM_XE_VM_BIND_DEBUG_DATA_FLAG_PSEUDO)
+			seq_puts(m, xe_debug_data_pseudo_path_to_string(dd->pseudopath));
+		else
+			/*
+			 * The pathname originates from userspace; escape it the
+			 * same way seq_path() does for /proc/pid/maps so that a
+			 * newline cannot break the line oriented format.
+			 */
+			seq_escape(m, dd->pathname, "\n");
+
+		seq_putc(m, '\n');
+	}
+}
+
+static int debug_data_show(struct seq_file *m, void *data)
+{
+	struct xe_file *xef = m->private;
+	unsigned long vm_id = 0;
+	struct xe_vm *vm;
+
+	/*
+	 * xef->vm.lock only covers the lookup and reference, so hold it just
+	 * long enough to pin the next VM. A closed VM has an empty list.
+	 *
+	 * xe_file_close() puts the VMs without erasing them from xef->vm.xa,
+	 * but we never see those stale entries: drm_file_free() removes this
+	 * file before ->postclose, and the debugfs proxy waits out readers
+	 * in flight and fails later reads on an fd that is still open.
+	 */
+	for (;;) {
+		mutex_lock(&xef->vm.lock);
+		vm = xa_find(&xef->vm.xa, &vm_id, ULONG_MAX, XA_PRESENT);
+		if (vm)
+			xe_vm_get(vm);
+		mutex_unlock(&xef->vm.lock);
+
+		if (!vm)
+			break;
+
+		debug_data_show_vm(m, vm_id, vm);
+		xe_vm_put(vm);
+		vm_id++;
+	}
+
+	return 0;
+}
+
+static int debug_data_open(struct inode *inode, struct file *file)
+{
+	struct xe_file *xef = inode->i_private;
+	int ret;
+
+	ret = single_open(file, debug_data_show, xef);
+	if (ret)
+		return ret;
+
+	/* Keeps xef alive until release, see debug_data_show() for the VMs */
+	xe_file_get(xef);
+
+	return 0;
+}
+
+static int debug_data_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct xe_file *xef = m->private;
+	int ret;
+
+	ret = single_release(inode, file);
+	xe_file_put(xef);
+
+	return ret;
+}
+
+static const struct file_operations debug_data_fops = {
+	.owner = THIS_MODULE,
+	.open = debug_data_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = debug_data_release,
+};
+
+/**
+ * xe_client_debugfs_register() - Register the per-client debugfs files
+ * @xef: The xe file to register the files for
+ *
+ * Create the debugfs entries exposed under the DRM client directory of @xef.
+ * Called from xe_file_open(), after DRM has created the client directory.
+ *
+ * The files are removed by drm_file_free() before ->postclose runs, so they
+ * do not need to be torn down by the driver. Nothing is created if DRM failed
+ * to create the client directory, as a NULL parent would place the file in the
+ * debugfs root where it would outlive @xef.
+ */
+void xe_client_debugfs_register(struct xe_file *xef)
+{
+	if (IS_ERR_OR_NULL(xef->drm->debugfs_client))
+		return;
+
+	debugfs_create_file("debug_data", 0444, xef->drm->debugfs_client, xef,
+			    &debug_data_fops);
+}
diff --git a/drivers/gpu/drm/xe/xe_client_debugfs.h b/drivers/gpu/drm/xe/xe_client_debugfs.h
new file mode 100644
index 000000000000..8b2e3d230ef8
--- /dev/null
+++ b/drivers/gpu/drm/xe/xe_client_debugfs.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef _XE_CLIENT_DEBUGFS_H_
+#define _XE_CLIENT_DEBUGFS_H_
+
+struct xe_file;
+
+#ifdef CONFIG_DEBUG_FS
+void xe_client_debugfs_register(struct xe_file *xef);
+#else
+static inline void xe_client_debugfs_register(struct xe_file *xef) { }
+#endif
+
+#endif
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 6968ae9cc300..a50147b4fc34 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -25,6 +25,7 @@
 #include "regs/xe_regs.h"
 #include "xe_bo.h"
 #include "xe_bo_evict.h"
+#include "xe_client_debugfs.h"
 #include "xe_configfs.h"
 #include "xe_debugfs.h"
 #include "xe_cpu_bind.h"
@@ -132,6 +133,8 @@ static int xe_file_open(struct drm_device *dev, struct drm_file *file)
 		put_task_struct(task);
 	}
 
+	xe_client_debugfs_register(xef);
+
 	return 0;
 }
 
-- 
2.53.0

