Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E6606A337
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4D491123E2;
	Thu, 12 Nov 2026 23:00:04 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0138311239F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:19 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-67c00f291e1so267215d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524359; x=1795129159;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ggLv8tMyYzCgQoxMfN/mL1izecY+0udo6MWNPS8D3rg=;
 b=KJ+qozJN+heJ1UaTGISHjjGys2gfzLka3CtODmXLL0BMdi/LqJsL6p9zAWgPdcziZh
 3cXyxvQRRre2ETXrvKm32a0lSkg/D7UIQh12ost1wL+iO1e5ZT8A9Z1E/o6AnLw6Wawp
 UHzBm1vQq7UH6NPHMyiDRJIrS2Qjvgf+I1Czr0RhOtGXXPe8fshp3tAu5cfEhevcOupo
 Q4vyTGG9JBhXsCiSfFDHJEJpUbOVVq17h9v41o+g4zNO3MyKrvRUDZesE1uFjLyFX5e6
 tBQEAMpL5nJIqoTcgnMaU55aYVJ90ALpXXBaoBBqkR27MCjdwMB6yc5Su9IxClWMS+e2
 l7gg==
X-Gm-Message-State: APuU4Z/jfOIVfWhvw5+cAoz2XTXwysu6tprKzz/U8ypK1q4ykij2300x
 xatyS+H1iUYZk2H3Ngx5M4reVAPp34l6MRKehaFzXuRln2IBx3Q78e/2
X-Gm-Gg: AYBFou3PTwd6Ng/hnR9wtzdOkJ+w1a0scsOMYjHiQ80/Z7iwx8V+k43DylgLSBtTWTt
 lLQ1y9RFKeGGNJ/QOJo8yT8rxBKZNduy3wOkLiDOWllfcOTGxrwSBvm9GcNrkuSrBdZ0Aj82rVW
 1AdMsnxd/GIoHTd8ZnUqrRwHxIZNUOt0HomlwTy6nvHG6Vgo8TT2W2L3fM1YvdM/jI9PG9pzZbR
 ybWZUrropUKyi/OjKOOYMhIOzTshlL17h6vV0VtP29Qn81FRLz4Otj1zxzIxAkg80anSN2VoQhn
 Ot8osXNN73cPkuFnzIkaNuiy1/TbBiwXRAS7pYcCQ+xiJX5iGWNT5X5f/MKU2XlKFJXRBXBD/21
 j9v18We9XzhZdjtuA7Zirdz7l+vRayvs4rXW0dO9U4YYvrRhOS4c6nrtrxBmk1mSRQSdRTSVMBw
 wu3EislEoCIdzvWbsBWI24n4As0EaevsID2tMff2LzXaqkpnx3VcVNoqrwAv/ZW9wgkQdywx9is
 FaKBRZzMJzPZ/cIScFI9ry9mxWXbfZsQ2yA2R6A3j8/LYmE2+LaYelUrL2104LnTsrFhG7fGncO
 du3mSHm0PikEEhg2tRHbcLFobGXvQ1ZXZvyl82CjegDE4q4D1SKqnlVHcWQ8Db7M11QsGexcTJU
 302tJOwCOWUR7EbvAAYPquuUl9GihKTeVmt7lgpMFoYgWS84M+TgKu3pjkSwNJ59qbiWhVO/io0
 5aB2X9n1CiehqHIDawTaFdlxCk
X-Received: by 2002:a05:690e:478f:20b0:67b:ef6f:4b68 with SMTP id
 956f58d0204a3-67d893e58f7mr350163d50.19.1794524358262; 
 Thu, 12 Nov 2026 14:59:18 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:17 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:58:56 -0500
Subject: [PATCH RFC 06/13] drm/powervr_sgx: Load and start the microkernel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-powervr-sgx-v1-6-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
To: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The GPU runs a microkernel on its shader unit. Load it with
request_firmware(), check its header (magic, interface version,
features, image CRC, entry points and patch sites), and refuse an image
that doesn't declare secure mode, in which no client page directory maps
the firmware's memory.

Build the microkernel's control blocks and entry PDS programs in kernel
memory, run the core's init script, kick the first event and wait for
the microkernel to report it is running. Stopping is the microkernel's
power-off, then the cores held in reset.

Commands reach the microkernel through a kernel-owned ring (the kernel
CCB); a command is done when the microkernel's read offset passes it.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c  | 204 +++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.h  |  52 +++
 drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c   | 731 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_fw.h   |  77 ++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_fwif.h | 519 +++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_pds.c  |  97 ++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_pds.h  |  37 ++
 7 files changed, 1717 insertions(+)

diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c
new file mode 100644
index 000000000..351a7f930
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The kernel CCB: a ring of 256 commands the host writes and the microkernel
+ * reads. The host advances the write offset and rings
+ * EUR_CR_EVENT_KICK; the microkernel advances the read offset as it takes each
+ * command. Neither raises an interrupt by itself, so a command is complete, as
+ * far as the ring is concerned, once the read offset has passed it.
+ */
+
+#include <drm/drm_print.h>
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/jiffies.h>
+#include <linux/string.h>
+
+#include "pvrsgx_ccb.h"
+#include "pvrsgx_device.h"
+
+#define CCB_WO 0
+#define CCB_RO 1
+
+static u32 *ccbctl(struct pvrsgx_device *sdev)
+{
+	return sdev->fw.cpu[PVRSGX_FW_CCBCTL];
+}
+
+void pvrsgx_ccb_reset(struct pvrsgx_device *sdev)
+{
+	memset(sdev->fw.cpu[PVRSGX_FW_CCB], 0, PVRSGX_CCB_SLOTS * PVRSGX_CCB_CMD_WORDS * 4);
+	ccbctl(sdev)[CCB_WO] = 0;
+	ccbctl(sdev)[CCB_RO] = 0;
+	*(u32 *)sdev->fw.cpu[PVRSGX_FW_KICKER] = 0;
+	/*
+	 * @ccb_issued carries on: a job sent after a restart has a higher sequence
+	 * than any count read before it, so a stale count can't complete it.
+	 */
+}
+
+/* Commands the microkernel has taken off the ring since the driver loaded. */
+u64 pvrsgx_ccb_consumed(struct pvrsgx_device *sdev)
+{
+	u32 ro = READ_ONCE(ccbctl(sdev)[CCB_RO]);
+	unsigned long flags;
+	u64 consumed;
+
+	/* The read offset is GPU-written: trust it only as an index. */
+	spin_lock_irqsave(&sdev->ccb_spin, flags);
+	consumed = sdev->ccb_issued - ((ccbctl(sdev)[CCB_WO] - ro) & (PVRSGX_CCB_SLOTS - 1));
+	spin_unlock_irqrestore(&sdev->ccb_spin, flags);
+	return consumed;
+}
+
+/* Write one command and ring the doorbell, with ccb_lock held. */
+static int ccb_write(struct pvrsgx_device *sdev, enum pvrsgx_kcmd type, u32 cache_control,
+		     const u32 data[6], u64 *seq)
+{
+	u32 *ctl = ccbctl(sdev), *cmd, wo;
+	unsigned long timeout = jiffies + msecs_to_jiffies(500);
+
+	wo = ctl[CCB_WO];
+	while (((wo + 1) & (PVRSGX_CCB_SLOTS - 1)) ==
+	       (READ_ONCE(ctl[CCB_RO]) & (PVRSGX_CCB_SLOTS - 1))) {
+		if (time_after(jiffies, timeout)) {
+			drm_err(&sdev->base, "kernel CCB full (wo %u ro %u)\n", wo, ctl[CCB_RO]);
+			return -EBUSY;
+		}
+		usleep_range(500, 1000);
+	}
+
+	cmd = (u32 *)sdev->fw.cpu[PVRSGX_FW_CCB] + wo * PVRSGX_CCB_CMD_WORDS;
+	cmd[0] = type;
+	cmd[1] = cache_control;
+	memcpy(&cmd[2], data, 6 * sizeof(u32));
+
+	/* Command, then offset, then doorbell. */
+	wmb();
+	spin_lock_irq(&sdev->ccb_spin);
+	ctl[CCB_WO] = (wo + 1) & (PVRSGX_CCB_SLOTS - 1);
+	sdev->ccb_issued++;
+	if (seq)
+		*seq = sdev->ccb_issued;
+	spin_unlock_irq(&sdev->ccb_spin);
+	*(u32 *)sdev->fw.cpu[PVRSGX_FW_KICKER] =
+		(*(u32 *)sdev->fw.cpu[PVRSGX_FW_KICKER] + 1) & 0xff;
+	/* The command and the kicker count reach memory before the kick. */
+	wmb();
+	sgx_wr(sdev, SGX_CR_EVENT_KICK, SGX_CR_EVENT_KICK_NOW);
+	return 0;
+}
+
+/*
+ * BRN_28889: a BIF directory or table invalidate and a data invalidate never
+ * go in one command. The BIF part goes first, alone, and the microkernel must
+ * have taken it before the data part is sent. An invalidate waiter
+ * (pvrsgx_ccb_after_invalidate()) waits for the first, which carries the BIF
+ * part.
+ */
+static int ccb_split_inval(struct pvrsgx_device *sdev, u32 *cache_control)
+{
+	static const u32 none[6];
+	unsigned long timeout = jiffies + msecs_to_jiffies(500);
+	u64 seq;
+	int err;
+
+	if (!(sdev->family->quirks & PVRSGX_QUIRK_BRN_28889) ||
+	    !(*cache_control & PVRSGX_CC_INVAL_DATA) ||
+	    !(*cache_control & ~PVRSGX_CC_INVAL_DATA))
+		return 0;
+	err = ccb_write(sdev, PVRSGX_KCMD_PROCESS_QUEUES, *cache_control & ~PVRSGX_CC_INVAL_DATA,
+			none, &seq);
+	if (err)
+		return err;
+	while (pvrsgx_ccb_consumed(sdev) < seq) {
+		if (time_after(jiffies, timeout)) {
+			drm_err(&sdev->base, "BIF invalidate not taken (BRN_28889)\n");
+			return -ETIMEDOUT;
+		}
+		usleep_range(100, 200);
+	}
+	*cache_control = PVRSGX_CC_INVAL_DATA;
+	return 0;
+}
+
+int pvrsgx_ccb_send(struct pvrsgx_device *sdev, enum pvrsgx_kcmd type,
+		    const u32 data[6], u64 *seq)
+{
+	u32 cache_control;
+	int err;
+
+	/* Types past the microkernel's command table are refused. */
+	if (type >= PVRSGX_KCMD_MAX)
+		return -EINVAL;
+
+	mutex_lock(&sdev->ccb_lock);
+	cache_control = sdev->fw.cache_control;
+	err = ccb_split_inval(sdev, &cache_control);
+	if (!err)
+		err = ccb_write(sdev, type, cache_control, data, seq);
+	if (!err)
+		sdev->fw.cache_control = 0;
+	mutex_unlock(&sdev->ccb_lock);
+	return err;
+}
+
+void pvrsgx_ccb_after_invalidate(struct pvrsgx_device *sdev, struct pvrsgx_inval_wait *w,
+				 u32 cache_control)
+{
+	unsigned long flags;
+
+	if (READ_ONCE(sdev->lost)) {
+		w->done(w);
+		return;
+	}
+	mutex_lock(&sdev->ccb_lock);
+	sdev->fw.cache_control |= cache_control;
+	w->seq = sdev->ccb_issued + 1;
+	mutex_unlock(&sdev->ccb_lock);
+	spin_lock_irqsave(&sdev->inval_lock, flags);
+	list_add_tail(&w->node, &sdev->inval_waits);
+	spin_unlock_irqrestore(&sdev->inval_lock, flags);
+}
+
+/* For status dumps: how much work still waits for an invalidate. */
+u32 pvrsgx_ccb_inval_pending(struct pvrsgx_device *sdev)
+{
+	struct pvrsgx_inval_wait *w;
+	unsigned long flags;
+	u32 n = 0;
+
+	spin_lock_irqsave(&sdev->inval_lock, flags);
+	list_for_each_entry(w, &sdev->inval_waits, node)
+		n++;
+	spin_unlock_irqrestore(&sdev->inval_lock, flags);
+	return n;
+}
+
+/*
+ * Run what waited for an invalidate the microkernel has now taken; all of it
+ * once the GPU is stopped. A restart empties the ring, so everything sent
+ * before it counts as taken: the GPU was reset, and the first command after
+ * the start carries an invalidate of its own.
+ */
+void pvrsgx_ccb_inval_reap(struct pvrsgx_device *sdev, bool all)
+{
+	struct pvrsgx_inval_wait *w, *tmp;
+	unsigned long flags;
+	LIST_HEAD(done);
+	u64 consumed;
+
+	spin_lock_irqsave(&sdev->inval_lock, flags);
+	consumed = all || READ_ONCE(sdev->lost) ? U64_MAX : pvrsgx_ccb_consumed(sdev);
+	list_for_each_entry_safe(w, tmp, &sdev->inval_waits, node) {
+		if (w->seq <= consumed)
+			list_move_tail(&w->node, &done);
+	}
+	spin_unlock_irqrestore(&sdev->inval_lock, flags);
+	list_for_each_entry_safe(w, tmp, &done, node) {
+		list_del(&w->node);
+		w->done(w);
+	}
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.h
new file mode 100644
index 000000000..2968cb41b
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_ccb.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_CCB_H
+#define PVRSGX_CCB_H
+
+#include <linux/list.h>
+#include <linux/types.h>
+
+struct pvrsgx_device;
+
+/**
+ * struct pvrsgx_inval_wait - Work that waits for a BIF invalidate to run
+ * @node: In pvrsgx_device.inval_waits.
+ * @seq: The kernel CCB command that carries the invalidate.
+ * @done: Called, in process context, once the microkernel has taken it.
+ */
+struct pvrsgx_inval_wait {
+	struct list_head node;
+	u64 seq;
+	void (*done)(struct pvrsgx_inval_wait *w);
+};
+
+/* Kernel CCB command types. */
+enum pvrsgx_kcmd {
+	PVRSGX_KCMD_TA = 0,
+	PVRSGX_KCMD_TRANSFER = 1,
+	PVRSGX_KCMD_POWER = 3,
+	PVRSGX_KCMD_PROCESS_QUEUES = 7,
+	PVRSGX_KCMD_MAX = 11
+};
+
+/* Cache control: invalidates the microkernel runs before the command. */
+#define PVRSGX_CC_INVAL_BIF_PT	0x1
+#define PVRSGX_CC_INVAL_BIF_PD	0x2
+#define PVRSGX_CC_INVAL_BIF_SL	0x4
+#define PVRSGX_CC_INVAL_DATA	0x8
+
+/* A kernel CCB command: entry, cache control, six data words. */
+#define PVRSGX_CCB_SLOTS	256
+#define PVRSGX_CCB_CMD_WORDS	8
+
+int pvrsgx_ccb_send(struct pvrsgx_device *sdev, enum pvrsgx_kcmd type,
+		    const u32 data[6], u64 *seq);
+u64 pvrsgx_ccb_consumed(struct pvrsgx_device *sdev);
+void pvrsgx_ccb_reset(struct pvrsgx_device *sdev);
+void pvrsgx_ccb_after_invalidate(struct pvrsgx_device *sdev, struct pvrsgx_inval_wait *w,
+				 u32 cache_control);
+void pvrsgx_ccb_inval_reap(struct pvrsgx_device *sdev, bool all);
+u32 pvrsgx_ccb_inval_pending(struct pvrsgx_device *sdev);
+
+#endif /* PVRSGX_CCB_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c
new file mode 100644
index 000000000..b3c0d1891
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c
@@ -0,0 +1,731 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * Loading and starting the microkernel: the buffers, constants, PDS programs
+ * and init scripts it needs.
+ *
+ * The host interface is version 1 of the microkernel's own
+ * (DRM_POWERVR_SGX_FW_IF_V1). The microkernel file's header lists its entry
+ * points and patch sites.
+ */
+
+#include <drm/drm_print.h>
+
+#include <linux/bitfield.h>
+#include <linux/crc32.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/seq_buf.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <uapi/drm/powervr_sgx_drm.h>
+
+#include "pvrsgx_ccb.h"
+#include "pvrsgx_core.h"
+#include "pvrsgx_device.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_fwif.h"
+#include "pvrsgx_kobj.h"
+#include "pvrsgx_mmu.h"
+#include "pvrsgx_pds.h"
+
+/* The microkernel file's header. */
+#define UKFW_MAGIC0		0x35584753	/* "SGX5" */
+#define UKFW_MAGIC1		0x4e524b55	/* "UKRN" */
+#define UKFW_HEADER_MIN		0x60
+#define UKFW_IF_MAJOR		1
+#define UKFW_FEATURES		(PVRSGX_UKFW_CLEANUP_V2 | PVRSGX_UKFW_SECURE | \
+				 PVRSGX_UKFW_DONE_SEQ | PVRSGX_UKFW_SINGLE_CONTEXT)
+/* Bits 16-31: the microkernel's own build variants, nothing the host must know. */
+#define UKFW_FEATURES_PRIVATE	GENMASK(31, 16)
+#define UKFW_MAX_IMAGE		(CODE_ARENA_SIZE - PDS_BYTES - 0x10)
+
+struct ukfw_header {
+	__le32 magic[2];
+	__le32 header_size;
+	__le32 interface;
+	__le32 features;
+	__le32 image_size;
+	__le32 image_crc32;
+	__le32 n_entries;
+	__le32 entries_off;
+	__le32 n_patches;
+	__le32 patches_off;
+	__le32 core_rev;
+	__le32 reserved[4];
+	char build_id[32];
+};
+
+struct ukfw_pair {
+	__le32 a, b;
+};
+
+enum ukfw_patch_value {
+	UKFW_TA3DCTL = 1,
+	UKFW_HOSTCTL,
+	UKFW_CCBCTL,
+	UKFW_CCB,
+	UKFW_MISC,
+	UKFW_PDTABLE,	/* single-context cores only */
+};
+
+/* The POWER command: data word 1. */
+#define POWER_OFF			1
+
+/* The microkernel's timer runs at 1 kHz. */
+#define UKERNEL_TIMER_HZ	1000
+
+/*
+ * Where each buffer lives: its offset in the kernel data or code arena, and
+ * its size.
+ */
+static const struct {
+	bool code;
+	u32 offset, size;
+} layout[PVRSGX_FW_NBUF] = {
+	[PVRSGX_FW_CCB] = { false, 0x0000, 0x2000 },
+	[PVRSGX_FW_CCBCTL] = { false, 0x2000, 0x8 },
+	[PVRSGX_FW_KICKER] = { false, 0x2010, 0x4 },
+	[PVRSGX_FW_TA3DCTL] = { false, 0x3000, sizeof(struct pvrsgx_fw_ta3d_ctl) },
+	/* Right after the control block, which fills 0x3000-0x30ff. */
+	[PVRSGX_FW_HOSTCTL] = { false, 0x3100, 0x44 },
+	[PVRSGX_FW_MISC] = { false, 0x3160, 0x54 },
+	/* The image at 0, then the PDS programs from its end. */
+	[PVRSGX_FW_UKERNEL] = { true, 0x0000, 0 },
+	[PVRSGX_FW_PDS0] = { true, 0x000, 0x18 },
+	[PVRSGX_FW_PDS1] = { true, 0x020, 0x38 },
+	[PVRSGX_FW_PDS2] = { true, 0x060, 0x18 },
+	[PVRSGX_FW_PDS3] = { true, 0x090, 0x100 },
+	[PVRSGX_FW_PDS4] = { true, 0x190, 0x68 },
+};
+
+static_assert(0x3000 + sizeof(struct pvrsgx_fw_ta3d_ctl) <= 0x3100);
+
+#define PDS_BYTES	0x200
+
+#define DATA_ARENA_SIZE	0xe000
+#define CODE_ARENA_SIZE	0xe000
+
+static u32 *fw_words(struct pvrsgx_device *sdev, enum pvrsgx_fw_buf b)
+{
+	return sdev->fw.cpu[b];
+}
+
+/* The TA3D control block as the microkernel left it (in-flight slot, PB state). */
+void pvrsgx_fw_dump(struct seq_buf *sb, struct pvrsgx_device *sdev, unsigned int b,
+		    const char *name)
+{
+	const u32 *w = fw_words(sdev, b);
+
+	seq_buf_printf(sb, "%s @ 0x%08x:", name, sdev->fw.addr[b]);
+	for (u32 i = 0; i < layout[b].size / 4; i++)
+		seq_buf_printf(sb, "%s%08x", i % 8 ? " " : "\n  ", READ_ONCE(w[i]));
+	seq_buf_puts(sb, "\n");
+}
+
+u32 pvrsgx_fw_hostctl(struct pvrsgx_device *sdev, unsigned int word)
+{
+	return READ_ONCE(fw_words(sdev, PVRSGX_FW_HOSTCTL)[word]);
+}
+
+void pvrsgx_fw_hostctl_set(struct pvrsgx_device *sdev, unsigned int word, u32 v)
+{
+	WRITE_ONCE(fw_words(sdev, PVRSGX_FW_HOSTCTL)[word], v);
+}
+
+/*
+ * Fill one of the microkernel's limm placeholders (word 0 0x?dbeef, the value
+ * bits of word 1 clear): bits 0-20 to word 0, 21-25 to word 1 bits 4-8, 26-31
+ * to word 1 bits 12-17.
+ */
+static int fw_limm(struct pvrsgx_device *sdev, u32 off, u32 v)
+{
+	u32 *i = (u32 *)((u8 *)sdev->fw.cpu[PVRSGX_FW_UKERNEL] + off);
+	bool ok = (i[0] & 0x1fffff) == 0xdbeef && !(i[1] & 0x0003f1f0);
+
+	if (off > sdev->fw.image_size - 8 || !ok) {
+		drm_err(&sdev->base, "%s: no patch placeholder at +0x%x\n", sdev->fw.name, off);
+		return -EINVAL;
+	}
+	i[0] = (i[0] & 0xffe00000) | (v & 0x1fffff);
+	i[1] = (i[1] & 0xfffc0e0f) | ((v >> 17) & 0x1f0) | ((v >> 26) << 12);
+	return 0;
+}
+
+/*
+ * The microkernel's control block, rebuilt at every start: after a reset it
+ * must not find the previous run's render in flight.
+ */
+static void ta3dctl_fill(struct pvrsgx_device *sdev)
+{
+	struct pvrsgx_fw_ta3d_ctl *t = sdev->fw.cpu[PVRSGX_FW_TA3DCTL];
+	struct pvrsgx_fw *f = &sdev->fw;
+
+	memset(t, 0, sizeof(*t));
+	t->self = f->addr[PVRSGX_FW_TA3DCTL];
+	t->host_ctl = f->addr[PVRSGX_FW_HOSTCTL];
+	t->ccb_ctl = f->addr[PVRSGX_FW_CCBCTL];
+	t->ccb = f->addr[PVRSGX_FW_CCB];
+	t->kernel_pd = pvrsgx_mmu_pd_addr(sdev->kernel_mmu);
+	/* A fresh microkernel counts finished jobs from 0. */
+	WRITE_ONCE(sdev->done_seq, 0);
+}
+
+/*
+ * The open microkernel's entry programs and patches, from its file header.
+ * A PDS program it doesn't list enters where program 0 does: its event entry
+ * dispatches every event itself.
+ */
+static int fw_build_open(struct pvrsgx_device *sdev)
+{
+	static const enum pvrsgx_fw_buf value_buf[] = {
+		[UKFW_TA3DCTL] = PVRSGX_FW_TA3DCTL,
+		[UKFW_HOSTCTL] = PVRSGX_FW_HOSTCTL,
+		[UKFW_CCBCTL] = PVRSGX_FW_CCBCTL,
+		[UKFW_CCB] = PVRSGX_FW_CCB,
+		[UKFW_MISC] = PVRSGX_FW_MISC,
+	};
+	struct pvrsgx_fw *f = &sdev->fw;
+	u32 entry[5];
+	int err = 0;
+
+	/* The header check guarantees program 0 is listed. */
+	for (u32 i = 0; i < f->n_entries; i++)
+		if (!f->entries[i][0])
+			memset32(entry, f->entries[i][1], ARRAY_SIZE(entry));
+	for (u32 i = 0; i < f->n_entries; i++)
+		entry[f->entries[i][0]] = f->entries[i][1];
+	for (u32 p = 0; p < ARRAY_SIZE(entry); p++)
+		pvrsgx_pds_entry(sdev, PVRSGX_FW_PDS0 + p, entry[p]);
+
+	for (u32 i = 0; i < f->n_patches && !err; i++) {
+		u32 v = f->patches[i][1];
+
+		if (v == UKFW_PDTABLE && !f->pdtable.pages) {
+			drm_err(&sdev->base, "%s: a PD table patch on a multi-context core\n",
+				f->name);
+			return -EINVAL;
+		}
+		err = fw_limm(sdev, f->patches[i][0],
+			      v == UKFW_PDTABLE ? f->pdtable.dev_addr : f->addr[value_buf[v]]);
+	}
+	if (err)
+		return err;
+	return 0;
+}
+
+/* Upload and patch the microkernel and assemble its entry programs. */
+static int fw_build(struct pvrsgx_device *sdev, const u8 *image)
+{
+	struct pvrsgx_fw *f = &sdev->fw;
+
+	memcpy(f->cpu[PVRSGX_FW_UKERNEL], image, f->image_size);
+
+	return fw_build_open(sdev);
+}
+
+/* Copy n pairs at off of the file, or NULL if they run past its end. */
+static u32 (*ukfw_table(const u8 *data, size_t size, u32 off, u32 n))[2]
+{
+	const struct ukfw_pair *src = (const void *)(data + off);
+	u32 (*t)[2];
+
+	if (!n || n > 64 || off > size || n * sizeof(*src) > size - off || !IS_ALIGNED(off, 4))
+		return NULL;
+	t = kmalloc_array(n, sizeof(*t), GFP_KERNEL);
+	if (!t)
+		return NULL;
+	for (u32 i = 0; i < n; i++) {
+		t[i][0] = le32_to_cpu(src[i].a);
+		t[i][1] = le32_to_cpu(src[i].b);
+	}
+	return t;
+}
+
+/*
+ * The microkernel file: check the header and take
+ * its image and tables into f. -ENOENT if data is not one; on -EINVAL, *why
+ * says what is wrong. f's tables and image are the caller's to free either way.
+ */
+static int ukfw_parse(const u8 *data, size_t size, struct pvrsgx_fw *f, const char **why)
+{
+	const struct ukfw_header *h = (const void *)data;
+	u32 hsize, isize, iface;
+	bool entry0 = false;
+
+	if (size < UKFW_HEADER_MIN || le32_to_cpu(h->magic[0]) != UKFW_MAGIC0 ||
+	    le32_to_cpu(h->magic[1]) != UKFW_MAGIC1)
+		return -ENOENT;
+	hsize = le32_to_cpu(h->header_size);
+	isize = le32_to_cpu(h->image_size);
+	iface = le32_to_cpu(h->interface);
+	f->features = le32_to_cpu(h->features);
+	*why = "bad sizes";
+	if (hsize < UKFW_HEADER_MIN || !IS_ALIGNED(hsize, 8) || hsize > size ||
+	    !isize || !IS_ALIGNED(isize, 8) || isize > size - hsize || isize > UKFW_MAX_IMAGE)
+		return -EINVAL;
+	*why = "interface or features not supported";
+	if (iface >> 16 != UKFW_IF_MAJOR ||
+	    (f->features & ~(UKFW_FEATURES | UKFW_FEATURES_PRIVATE)))
+		return -EINVAL;
+	*why = "image CRC mismatch";
+	if (crc32_le(~0, data + hsize, isize) != ~le32_to_cpu(h->image_crc32))
+		return -EINVAL;
+
+	*why = "bad entry or patch table";
+	f->n_entries = le32_to_cpu(h->n_entries);
+	f->n_patches = le32_to_cpu(h->n_patches);
+	f->entries = ukfw_table(data, size, le32_to_cpu(h->entries_off), f->n_entries);
+	if (f->n_patches)
+		f->patches = ukfw_table(data, size, le32_to_cpu(h->patches_off), f->n_patches);
+	if (!f->entries || (f->n_patches && !f->patches))
+		return -EINVAL;
+	for (u32 i = 0; i < f->n_entries; i++) {
+		if (f->entries[i][0] > 4 || f->entries[i][1] >= isize ||
+		    !IS_ALIGNED(f->entries[i][1], 8))
+			return -EINVAL;
+		entry0 |= !f->entries[i][0];
+	}
+	for (u32 i = 0; i < f->n_patches; i++) {
+		if (f->patches[i][0] > isize - 8 || !IS_ALIGNED(f->patches[i][0], 8) ||
+		    f->patches[i][1] < UKFW_TA3DCTL || f->patches[i][1] > UKFW_PDTABLE)
+			return -EINVAL;
+	}
+	if (!entry0)
+		return -EINVAL;
+
+	f->image_size = isize;
+	f->image = kmemdup(data + hsize, isize, GFP_KERNEL);
+	return f->image ? 0 : -ENOMEM;
+}
+
+static int ukfw_load(struct pvrsgx_device *sdev, const struct firmware *fw)
+{
+	const struct ukfw_header *h = (const void *)fw->data;
+	struct pvrsgx_fw *f = &sdev->fw;
+	const char *why = "";
+	u32 iface;
+	int err;
+
+	err = ukfw_parse(fw->data, fw->size, f, &why);
+	if (err == -EINVAL)
+		drm_err(&sdev->base, "%s: %s\n", f->name, why);
+	if (err)
+		return err;
+	/*
+	 * Secure mode keeps the firmware out of every client directory, which a
+	 * single-context core can't do: there the image must not claim it.
+	 */
+	if (pvrsgx_core_single_context(sdev->family)) {
+		if ((f->features & (PVRSGX_UKFW_SECURE | PVRSGX_UKFW_SINGLE_CONTEXT)) !=
+		    PVRSGX_UKFW_SINGLE_CONTEXT) {
+			drm_err(&sdev->base, "%s: not an image for a single-context core\n",
+				f->name);
+			return -EINVAL;
+		}
+	} else if (f->features & PVRSGX_UKFW_SINGLE_CONTEXT) {
+		drm_err(&sdev->base, "%s: an image for a single-context core\n", f->name);
+		return -EINVAL;
+	} else if (!(f->features & PVRSGX_UKFW_SECURE)) {
+		drm_err(&sdev->base, "%s: not a secure-mode image; clients would reach the firmware\n",
+			f->name);
+		return -EINVAL;
+	}
+	iface = le32_to_cpu(h->interface);
+	if (h->core_rev && le32_to_cpu(h->core_rev) != sdev->core_rev)
+		drm_warn(&sdev->base, "%s: validated on core revision 0x%x, this is 0x%x\n",
+			 f->name, le32_to_cpu(h->core_rev), sdev->core_rev);
+	drm_info(&sdev->base, "%s: open microkernel %.32s, interface %u.%u, features 0x%x\n",
+		 f->name, h->build_id, iface >> 16, iface & 0xffff, f->features);
+	return 0;
+}
+
+/*
+ * Single-context cores: the microkernel loads list 0 from this table, by the
+ * slot a HW context names, so no directory address it loads is GPU-writable.
+ * Read-only on the GPU, between the code arena and the kernel code objects.
+ * Every slot no VM holds names the firmware's directory.
+ */
+#define PDTABLE_OFFSET	0xf000
+#define PDTABLE_SLOTS	(PAGE_SIZE / sizeof(u32))
+
+/* The PD table sits past the code arena, inside the kernel code heap's first 64 KiB. */
+static_assert(PDTABLE_OFFSET >= CODE_ARENA_SIZE);
+static_assert(SZ_64K - PAGE_SIZE >= PDTABLE_OFFSET);
+
+static int pdtable_init(struct pvrsgx_device *sdev)
+{
+	struct pvrsgx_fw *f = &sdev->fw;
+	int err;
+
+	if (!pvrsgx_core_single_context(sdev->family))
+		return 0;
+	err = pvrsgx_kmem_alloc(sdev, &f->pdtable,
+				pvrsgx_heaps(sdev)->kernel_code.base + PDTABLE_OFFSET, PAGE_SIZE,
+				SGX_MMU_PTE_READONLY, 0);
+	if (err)
+		return err;
+	memset32(f->pdtable.cpu, pvrsgx_mmu_pd_addr(sdev->kernel_mmu), PDTABLE_SLOTS);
+	return 0;
+}
+
+/* A slot naming directory pd, for a new VM; its HW contexts carry the slot. */
+int pvrsgx_fw_pd_slot_get(struct pvrsgx_device *sdev, u32 pd)
+{
+	int slot = ida_alloc_range(&sdev->fw.pd_slots, 1, PDTABLE_SLOTS - 1, GFP_KERNEL);
+
+	if (slot < 0)
+		return slot;
+	WRITE_ONCE(((u32 *)sdev->fw.pdtable.cpu)[slot], pd);
+	/* In memory before any command names the slot. */
+	wmb();
+	return slot;
+}
+
+/* The VM is gone: its slot names the firmware's directory again. */
+void pvrsgx_fw_pd_slot_put(struct pvrsgx_device *sdev, int slot)
+{
+	WRITE_ONCE(((u32 *)sdev->fw.pdtable.cpu)[slot], pvrsgx_mmu_pd_addr(sdev->kernel_mmu));
+	/* The slot names the firmware's directory before another VM can take it. */
+	wmb();
+	ida_free(&sdev->fw.pd_slots, slot);
+}
+
+/* The arenas and the built image, once the file is loaded. */
+static int fw_arenas(struct pvrsgx_device *sdev)
+{
+	const struct pvrsgx_heap_layout *h = pvrsgx_heaps(sdev);
+	struct pvrsgx_fw *f = &sdev->fw;
+	u32 pds_base;
+	int err;
+
+	f->interface = DRM_POWERVR_SGX_FW_IF_V1;
+
+	/*
+	 * The PTE flags: data read-write and EDM-protected where the core allows
+	 * it, code read-only.
+	 */
+	err = pvrsgx_kmem_alloc(sdev, &f->data, h->kernel_data.base, DATA_ARENA_SIZE,
+				SGX_MMU_PTE_CACHECONSISTENT |
+				(sdev->family->data_no_edmprotect ? 0 : SGX_MMU_PTE_EDMPROTECT), 0);
+	if (err)
+		return err;
+	err = pvrsgx_kmem_alloc(sdev, &f->code, h->kernel_code.base, CODE_ARENA_SIZE,
+				SGX_MMU_PTE_READONLY, 0);
+	if (err)
+		return err;
+	err = pdtable_init(sdev);
+	if (err)
+		return err;
+
+	pds_base = ALIGN(f->image_size, 0x10);
+	for (int b = 0; b < PVRSGX_FW_NBUF; b++) {
+		struct pvrsgx_kmem *km = layout[b].code ? &f->code : &f->data;
+		u32 off = layout[b].offset;
+
+		if (b >= PVRSGX_FW_PDS0 && b <= PVRSGX_FW_PDS4)
+			off += pds_base;
+		f->addr[b] = km->dev_addr + off;
+		f->cpu[b] = (u8 *)km->cpu + off;
+	}
+	return fw_build(sdev, f->image);
+}
+
+int pvrsgx_fw_init(struct pvrsgx_device *sdev)
+{
+	struct pvrsgx_fw *f = &sdev->fw;
+	const struct firmware *fw;
+	int err;
+
+	ida_init(&f->pd_slots);
+	f->name = sdev->core->fw_name;
+	err = request_firmware(&fw, f->name, sdev->base.dev);
+	if (err) {
+		drm_err(&sdev->base, "no microkernel: %s (%d)\n", f->name, err);
+		return err;
+	}
+	err = ukfw_load(sdev, fw);
+	if (err == -ENOENT)
+		drm_err(&sdev->base, "%s: not a microkernel file\n", f->name);
+	release_firmware(fw);
+	if (err)
+		return err;
+	return fw_arenas(sdev);
+}
+
+void pvrsgx_fw_fini(struct pvrsgx_device *sdev)
+{
+	kfree(sdev->fw.entries);
+	kfree(sdev->fw.patches);
+	sdev->fw.entries = NULL;
+	sdev->fw.patches = NULL;
+	kfree(sdev->fw.image);
+	sdev->fw.image = NULL;
+	pvrsgx_kmem_free(sdev, &sdev->fw.pdtable);
+	pvrsgx_kmem_free(sdev, &sdev->fw.code);
+	pvrsgx_kmem_free(sdev, &sdev->fw.data);
+	ida_destroy(&sdev->fw.pd_slots);
+}
+
+/* USE_CODE_BASE's data master for the pixel windows and for the microkernel's. */
+#define USE_CODE_BASE_DM_PIXEL		1
+#define USE_CODE_BASE_DM_UKERNEL	3
+
+static u32 use_code_base(struct pvrsgx_device *sdev, u32 n)
+{
+	return sdev->cr->use_code_base0 + 4 * n;
+}
+
+/* A code base's value: the address in the core's unit, and the data master. */
+static u32 use_code_base_val(struct pvrsgx_device *sdev, u64 addr, u32 dm)
+{
+	const struct pvrsgx_core_regs *cr = sdev->cr;
+
+	return (u32)(addr >> cr->use_code_base_addr_shift) | dm << cr->use_code_base_dm_shift;
+}
+
+/*
+ * The event program's address as the event PDS base register takes it. A core
+ * without EDM_VERTEX_PDSADDR_FULL_RANGE holds 26 bits there, the 64 MiB above
+ * PDS_EXEC_BASE that PDS code may lie in: taken as an offset from that base,
+ * which is an assumption.
+ */
+static u32 event_pds_addr(struct pvrsgx_device *sdev)
+{
+	u32 a = sdev->fw.addr[PVRSGX_FW_PDS0] & ~0xfu;
+
+	if (!(sdev->family->features & PVRSGX_FEATURE_EDM_VERTEX_PDSADDR_FULL_RANGE))
+		a -= pvrsgx_heaps(sdev)->pds_pixel.base;
+	return a;
+}
+
+/* Where the event PDS registers are a guess, the address must read back before any kick. */
+static int check_event_pds(struct pvrsgx_device *sdev)
+{
+	u32 want = event_pds_addr(sdev), got;
+
+	if (!sdev->family->event_pds_guessed)
+		return 0;
+	got = sgx_rd(sdev, sdev->cr->event_pds_base);
+	if (got != want) {
+		drm_err(&sdev->base,
+			"event PDS base 0x%04x reads 0x%08x, not 0x%08x; not starting the microkernel\n",
+			sdev->cr->event_pds_base, got, want);
+		return -EIO;
+	}
+	return 0;
+}
+
+/* Init script part 2: the core's script, then the bases. */
+static int init_script_part2(struct pvrsgx_device *sdev)
+{
+	const struct pvrsgx_core_family *fam = sdev->family;
+	const struct pvrsgx_heap_layout *h = pvrsgx_heaps(sdev);
+	const struct pvrsgx_core_regs *cr = sdev->cr;
+	struct pvrsgx_fw *f = &sdev->fw;
+	int err;
+
+	for (u32 i = 0; i < fam->num_init_regs; i++)
+		sgx_wr(sdev, fam->init_regs[i].reg, fam->init_regs[i].val);
+	/*
+	 * Code bases 0-9 the pixel shader heap, 10-13 the vertex shader heap, 15
+	 * ours. A client's PDS program can name any of them, so 14 is a second
+	 * name for 0 rather than whatever it held.
+	 */
+	for (u32 i = 0; i < 10; i++)
+		sgx_wr(sdev, use_code_base(sdev, PVRSGX_USSE_PIXEL_BASE_INDEX + i),
+		       use_code_base_val(sdev, h->usse_pixel.base + (i << PVRSGX_USSE_WINDOW_LOG2),
+					 USE_CODE_BASE_DM_PIXEL));
+	sgx_wr(sdev, use_code_base(sdev, PVRSGX_USSE_SPARE_BASE_INDEX),
+	       use_code_base_val(sdev, h->usse_pixel.base, USE_CODE_BASE_DM_PIXEL));
+	for (u32 i = 0; i < 4; i++)
+		sgx_wr(sdev, use_code_base(sdev, PVRSGX_USSE_VERTEX_BASE_INDEX + i),
+		       use_code_base_val(sdev, h->usse_vertex.base + (i << PVRSGX_USSE_WINDOW_LOG2),
+					 0));
+	sgx_wr(sdev, use_code_base(sdev, PVRSGX_USSE_UKERNEL_BASE_INDEX),
+	       use_code_base_val(sdev, h->kernel_code.base, USE_CODE_BASE_DM_UKERNEL));
+	sgx_wr(sdev, cr->pds_exec_base, h->pds_pixel.base);
+	sgx_wr_opt(sdev, cr->cr_b30, 0x100);	/* unnamed; its start value */
+	sgx_wr(sdev, SGX_CR_EVENT_KICKER, f->addr[PVRSGX_FW_KICKER]);
+	sgx_wr(sdev, cr->event_pds_base, event_pds_addr(sdev));
+	sgx_wr(sdev, cr->event_pds_data0, 1);
+	sgx_wr(sdev, cr->event_pds_data1, 6);
+	/* Before the events are enabled, so a wrong guess starts nothing. */
+	err = check_event_pds(sdev);
+	if (err)
+		return err;
+	sgx_wr(sdev, cr->event_pds_enable, cr->event_pds_enable_all);
+	return 0;
+}
+
+static void deinit_script(struct pvrsgx_device *sdev)
+{
+	const struct pvrsgx_core_regs *cr = sdev->cr;
+
+	sgx_wr(sdev, cr->event_pds_enable, 0);
+	sgx_wr(sdev, cr->event_pds_base, 0);
+	sgx_wr(sdev, cr->event_pds_data0, 0);
+	sgx_wr(sdev, cr->event_pds_data1, 0);
+	sgx_wr(sdev, use_code_base(sdev, PVRSGX_USSE_UKERNEL_BASE_INDEX), 0);
+	sgx_wr(sdev, SGX_CR_EVENT_HOST_ENABLE, 0);
+	sgx_wr(sdev, SGX_CR_EVENT_HOST_ENABLE2, 0);
+	sgx_wr(sdev, SGX_CR_CLKGATECTL, 0);
+	sgx_wr_opt(sdev, cr->clkgatectl2, 0);
+}
+
+/*
+ * Start: clocks, init script part 1, reset, part 2, then the first event kick,
+ * and the microkernel's init entry sets INIT_COMPLETE.
+ */
+int pvrsgx_fw_start(struct pvrsgx_device *sdev)
+{
+	const struct pvrsgx_core_regs *cr = sdev->cr;
+	u32 *hc = fw_words(sdev, PVRSGX_FW_HOSTCTL);
+	bool first = !sdev->fw_started, was_powered = READ_ONCE(sdev->powered);
+	int err;
+
+	WRITE_ONCE(sdev->powered, true);
+
+	/*
+	 * A restart starts from a fresh image and empty arenas: the microkernel
+	 * changes both as it runs, and a module reload (which recovers) is
+	 * exactly this.
+	 */
+	if (!first) {
+		sdev->fw_gen++;
+		/*
+		 * After a hang the clocks are on and the cores may be busy. After a
+		 * clean stop (runtime suspend) they are gated and quiet already, and
+		 * a register read there can hang the SoC.
+		 */
+		if (was_powered) {
+			/* What an unload and reload (which recovers) does in between. */
+			deinit_script(sdev);
+			sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_cores);
+			sgx_rd(sdev, SGX_CR_SOFT_RESET);
+			/* Behind gma500 bus mastering is the display's too: leave it. */
+			if (sdev->pdev)
+				pci_clear_master(sdev->pdev);
+			fsleep(10000);
+			if (sdev->pdev)
+				pci_set_master(sdev->pdev);
+		}
+		memset(sdev->fw.data.cpu, 0, sdev->fw.data.size);
+		memset(sdev->fw.code.cpu, 0, sdev->fw.code.size);
+		err = fw_build(sdev, sdev->fw.image);
+		if (err)
+			return err;
+		/*
+		 * Nothing the old run pointed at matters any more. Freeing can take
+		 * locks a fence waiter holds, so the reap work does it, not a reset.
+		 */
+		WRITE_ONCE(sdev->restarts, sdev->restarts + 1);
+		queue_work(sdev->free_wq, &sdev->reap_work);
+	}
+	memset(hc, 0, layout[PVRSGX_FW_HOSTCTL].size);
+	hc[HOSTCTL_UK_TIMER_CLOCK] = sdev->core->clock_hz / UKERNEL_TIMER_HZ;
+	hc[HOSTCTL_FLAGS] = HOSTCTL_HOST_BGBLOCK;
+	/* The power status starts clear at every start. */
+	hc[HOSTCTL_POWER_STATUS] = 0;
+	pvrsgx_ccb_reset(sdev);
+	ta3dctl_fill(sdev);
+	/* The first command invalidates the directory cache, keeping what a reap queued. */
+	sdev->fw.cache_control |= PVRSGX_CC_INVAL_BIF_PD;
+
+	/* Every unit's clock gated automatically, but the DPM's: it stays on. */
+	sgx_wr(sdev, SGX_CR_CLKGATECTL,
+	       (SGX_CLKG_ALL(cr->clkgatectl_units, SGX_CLKG_AUTO) & ~cr->clkgatectl_dpm) |
+	       field_prep(cr->clkgatectl_dpm, SGX_CLKG_ON));
+	sgx_wr_opt(sdev, cr->clkgatectl2, SGX_CLKG_ALL(cr->clkgatectl2_units, SGX_CLKG_AUTO));
+	sgx_wr(sdev, cr->event_pds_enable, 0);
+	sgx_wr(sdev, SGX_CR_EVENT_TIMER, 0);
+
+	pvrsgx_reset(sdev, true);
+
+	*(u32 *)sdev->fw.cpu[PVRSGX_FW_KICKER] = 0;
+	err = init_script_part2(sdev);
+	if (err)
+		return err;
+
+	hc[HOSTCTL_INIT_STATUS] = 0;
+	/* The image and the host control block are in memory before the kick. */
+	wmb();
+	/* The init kick; a core with one kick register (BRN_22934) takes it there. */
+	if (cr->event_kick2)
+		sgx_wr(sdev, cr->event_kick2, cr->event_kick2_now);
+	else
+		sgx_wr(sdev, SGX_CR_EVENT_KICK, SGX_CR_EVENT_KICK_NOW);
+
+	err = pvrsgx_poll(sdev, &hc[HOSTCTL_INIT_STATUS], HOSTCTL_INIT_COMPLETE,
+			  HOSTCTL_INIT_COMPLETE, 500000);
+	if (err) {
+		drm_err(&sdev->base,
+			"microkernel did not start (init status 0x%x, event status 0x%x; BIF int 0x%x fault 0x%x req 0x%x)\n",
+			hc[HOSTCTL_INIT_STATUS], sgx_rd(sdev, SGX_CR_EVENT_STATUS),
+			sgx_rd(sdev, SGX_CR_BIF_INT_STAT), sgx_rd(sdev, SGX_CR_BIF_FAULT),
+			sgx_rd(sdev, SGX_CR_BIF_MEM_REQ_STAT));
+		return err;
+	}
+	sdev->fw_running = true;
+	sdev->fw_started = true;
+	if (first || sdev->reset_count != sdev->reset_logged) {
+		drm_info(&sdev->base, "microkernel started%s\n", first ? "" : " again");
+		sdev->reset_logged = sdev->reset_count;
+	}
+	return 0;
+}
+
+/*
+ * Every unit and the BIF held in reset, at once and without the microkernel:
+ * no GPU memory access after this returns. For a hang, before the jobs' memory
+ * can go, and when the device is lost.
+ */
+void pvrsgx_fw_halt(struct pvrsgx_device *sdev)
+{
+	const struct pvrsgx_core_regs *cr = sdev->cr;
+
+	sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_cores);
+	sgx_rd(sdev, SGX_CR_SOFT_RESET);
+	if (sdev->pdev)
+		pci_clear_master(sdev->pdev);
+}
+
+/* Ask the microkernel to power off, then hold the cores in reset. */
+void pvrsgx_fw_stop(struct pvrsgx_device *sdev)
+{
+	const struct pvrsgx_core_regs *cr = sdev->cr;
+	u32 *hc = fw_words(sdev, PVRSGX_FW_HOSTCTL);
+	u32 data[6] = { 0, POWER_OFF };
+
+	if (sdev->fw_running) {
+		if (pvrsgx_ccb_send(sdev, PVRSGX_KCMD_POWER, data, NULL) ||
+		    pvrsgx_poll(sdev, &hc[HOSTCTL_POWER_STATUS], HOSTCTL_POWMAN_POWEROFF_COMPLETE,
+				HOSTCTL_POWMAN_POWEROFF_COMPLETE, 500000))
+			drm_warn(&sdev->base, "microkernel did not power off\n");
+		/* Wait for the clocks to gate; the DPM's stays on. */
+		for (int i = 0; i < 500; i++) {
+			if (!(sgx_rd(sdev, cr->clkgatestatus) & ~cr->clkgatestatus_dpm))
+				break;
+			usleep_range(100, 200);
+		}
+		WRITE_ONCE(sdev->powered, false);
+		synchronize_irq(sdev->irq);
+		deinit_script(sdev);
+		sdev->fw_running = false;
+		sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_cores);
+		sgx_rd(sdev, SGX_CR_SOFT_RESET);
+	} else if (READ_ONCE(sdev->powered)) {
+		/* A failed start: the clocks are on, the microkernel isn't. */
+		WRITE_ONCE(sdev->powered, false);
+		synchronize_irq(sdev->irq);
+		sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_cores);
+		sgx_rd(sdev, SGX_CR_SOFT_RESET);
+	}
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.h
new file mode 100644
index 000000000..92dfa0898
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_fw.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_FW_H
+#define PVRSGX_FW_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+struct pvrsgx_device;
+struct seq_buf;
+
+/* Fixed device-virtual layout. */
+#define PVRSGX_HEAP_3D_PARAMS		0x10000000u
+#define PVRSGX_HEAP_TA_DATA		0x20000000u
+#define PVRSGX_HEAP_SYNC		0x2d000000u
+#define PVRSGX_HEAP_PDS_PIXEL		0x2e000000u
+#define PVRSGX_HEAP_KERNEL_CODE		0x30000000u
+#define PVRSGX_HEAP_PDS_VERTEX		0x30400000u
+#define PVRSGX_HEAP_KERNEL_DATA		0x32000000u
+#define PVRSGX_HEAP_USSE_PIXEL		0x37000000u
+#define PVRSGX_HEAP_USSE_PIXEL_SIZE	0x00500000u
+#define PVRSGX_HEAP_USSE_VERTEX		0x3c000000u
+#define PVRSGX_HEAP_USSE_VERTEX_SIZE	0x00200000u
+#define PVRSGX_HEAP_GENERAL		0x3e000000u
+#define PVRSGX_HEAP_TEXTURE		0xf0000000u
+
+/* Each USE code base register covers a 512 KiB window. */
+#define PVRSGX_USSE_WINDOW_LOG2		19
+#define PVRSGX_USSE_PIXEL_BASE_INDEX	0
+#define PVRSGX_USSE_VERTEX_BASE_INDEX	10
+#define PVRSGX_USSE_SPARE_BASE_INDEX	14
+#define PVRSGX_USSE_UKERNEL_BASE_INDEX	15
+
+/* Host control block words. */
+#define HOSTCTL_INIT_STATUS		0
+#define HOSTCTL_POWER_STATUS		1
+#define HOSTCTL_UK_LOCKUPS		3
+#define HOSTCTL_UK_TIMER_CLOCK		6
+#define HOSTCTL_INTERRUPT_FLAGS		8
+#define HOSTCTL_INTERRUPT_CLEAR		9
+#define HOSTCTL_ASSERT_FAIL		14
+
+#define HOSTCTL_FLAGS			15
+
+/* HOSTCTL_FLAGS: the host writes the background object's PDS words. */
+#define HOSTCTL_HOST_BGBLOCK		BIT(0)
+
+/* Feature bits of the microkernel file's header. */
+#define PVRSGX_UKFW_CLEANUP_V2		BIT(0)	/* accepted, unused */
+#define PVRSGX_UKFW_SECURE		BIT(1)
+/* It counts finished jobs in pvrsgx_fw_ta3d_ctl.done_seq, then interrupts. */
+#define PVRSGX_UKFW_DONE_SEQ		BIT(2)
+/*
+ * Runs on list 0 with the jobs, directories from the PD table, the firmware
+ * directory back on list 0 before any completion (single-context cores).
+ */
+#define PVRSGX_UKFW_SINGLE_CONTEXT	BIT(3)
+
+#define HOSTCTL_INIT_COMPLETE		BIT(0)
+#define HOSTCTL_POWMAN_POWEROFF_COMPLETE BIT(3)
+#define HOSTCTL_INTERRUPT_HWR		BIT(0)
+#define HOSTCTL_INTERRUPT_ACTIVE_POWER	BIT(1)
+
+int pvrsgx_fw_init(struct pvrsgx_device *sdev);
+int pvrsgx_fw_pd_slot_get(struct pvrsgx_device *sdev, u32 pd);
+void pvrsgx_fw_pd_slot_put(struct pvrsgx_device *sdev, int slot);
+void pvrsgx_fw_fini(struct pvrsgx_device *sdev);
+int pvrsgx_fw_start(struct pvrsgx_device *sdev);
+void pvrsgx_fw_stop(struct pvrsgx_device *sdev);
+void pvrsgx_fw_halt(struct pvrsgx_device *sdev);
+u32 pvrsgx_fw_hostctl(struct pvrsgx_device *sdev, unsigned int word);
+void pvrsgx_fw_hostctl_set(struct pvrsgx_device *sdev, unsigned int word, u32 v);
+void pvrsgx_fw_dump(struct seq_buf *sb, struct pvrsgx_device *sdev, unsigned int b,
+		    const char *name);
+
+#endif /* PVRSGX_FW_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_fwif.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_fwif.h
new file mode 100644
index 000000000..9fa7b64c0
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_fwif.h
@@ -0,0 +1,519 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_FWIF_H
+#define PVRSGX_FWIF_H
+
+#include <linux/bits.h>
+#include <linux/build_bug.h>
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+/*
+ * Structures the host writes and the microkernel reads, in the microkernel's
+ * layout. The SGX and its x86 hosts are both little-endian, so the fields are
+ * plain u32. Fields the driver leaves zero are padding here.
+ */
+
+/**
+ * struct pvrsgx_fw_ta3d_ctl - The microkernel's control block
+ *
+ * The host fills the addresses;
+ * the rest is the microkernel's live state, zero at every start.
+ */
+struct pvrsgx_fw_ta3d_ctl {
+	/** @self: Device address of this block. */
+	u32 self;
+	/** @host_ctl: Device address of the host control block. */
+	u32 host_ctl;
+	/** @ccb_ctl: Device address of the kernel CCB's write and read offsets. */
+	u32 ccb_ctl;
+	/* private: */
+	u32 pad_0c[19];
+	/* public: */
+	/** @ccb: Device address of the kernel CCB. */
+	u32 ccb;
+	/** @kernel_pd: Physical address of the firmware's page directory. */
+	u32 kernel_pd;
+	/* private: the microkernel's own state, to the block's end (word 0x3f) */
+	u32 uk_60[15];
+	/* @done_seq: Jobs finished since the start, with PVRSGX_UKFW_DONE_SEQ. */
+	u32 done_seq;
+	u32 uk_a0[24];
+};
+
+static_assert(offsetof(struct pvrsgx_fw_ta3d_ctl, ccb) == 0x58);
+static_assert(offsetof(struct pvrsgx_fw_ta3d_ctl, done_seq) == 0x9c);
+static_assert(sizeof(struct pvrsgx_fw_ta3d_ctl) == 0x100);
+
+/* struct pvrsgx_fw_ta_cmd.ta_flags */
+#define PVRSGX_TA_FIRST_KICK		BIT(0)
+#define PVRSGX_TA_LAST_KICK		BIT(1)
+#define PVRSGX_TA_FIRST_RENDER		BIT(4)	/* the RT dataset's first render */
+#define PVRSGX_TA_FLAGS_BASE		0x60	/* set on every kick */
+
+/* struct pvrsgx_fw_ta_cmd.ta_flags2 */
+#define PVRSGX_TA2_RENDER		BIT(22)	/* this kick starts the 3D */
+
+/* struct pvrsgx_fw_ta_cmd.flags_3d */
+#define PVRSGX_3D_RENDER		BIT(10)
+#define PVRSGX_3D_FRAME_SHIFT		14
+
+/**
+ * struct pvrsgx_fw_ta_cmd - One TA kick
+ *
+ * The header and tail come from the client's streams and the kernel's own
+ * structures; the shared part carries the synchronization.
+ */
+struct pvrsgx_fw_ta_cmd {
+	/** @size: The command's size in bytes. */
+	u32 size;
+	/** @ta_flags: PVRSGX_TA_*. */
+	u32 ta_flags;
+	/** @bg_pds: Background object PDS words: secondary, middle, primary. */
+	u32 bg_pds[3];
+	/** @ta_ctl: Two constant control words. */
+	u32 ta_ctl[2];
+	/** @flags_3d: 3D flags, on the scene's last kick. */
+	u32 flags_3d;
+	/** @frame: The RT dataset's frame counter. */
+	u32 frame;
+	/** @pb_desc: Device address of the parameter buffer descriptor. */
+	u32 pb_desc;
+	/* private: */
+	u32 pad_28[4];
+	/* public: */
+	/** @render_details: Device address of the render details. */
+	u32 render_details;
+	/** @rt_deps: Device address of the render-target dependency block. */
+	u32 rt_deps;
+	/** @rt_data: Device address of the RT data. */
+	u32 rt_data;
+	/** @rt_data_entry: Device address of this render's RT data entry. */
+	u32 rt_data_entry;
+	/* private: */
+	u32 pad_48[4];
+	/* public: */
+
+	/** @ready: Set when the command may run. */
+	u32 ready;
+	/* private: */
+	u32 pad_5c[6];
+	/* public: */
+	/** @sync3d_write_pending: The 3D sync's write-ops-pending value. */
+	u32 sync3d_write_pending;
+	/** @sync3d_write_complete: Its write-ops-complete address. */
+	u32 sync3d_write_complete;
+	/** @sync3d_read_pending: The 3D sync's read-ops-pending value. */
+	u32 sync3d_read_pending;
+	/** @sync3d_read_complete: Its read-ops-complete address. */
+	u32 sync3d_read_complete;
+	/* private: */
+	u32 pad_84[109];
+	/* public: */
+
+	/** @te_aa: Tiling engine anti-aliasing word. */
+	u32 te_aa;
+	/** @te_mtile: Macrotile boundaries in X and Y. */
+	u32 te_mtile[2];
+	/** @te_screen: Last tile in X (bits 0-11) and Y (bits 12 on). */
+	u32 te_screen;
+	/** @mt_tiles: Tiles per macrotile. */
+	u32 mt_tiles;
+	/** @ta_flags2: PVRSGX_TA2_* and the client's kick flags. */
+	u32 ta_flags2;
+	/** @vdm_base: Device address of the kick's VDM control stream. */
+	u32 vdm_base;
+	/** @vdm_ctl: Constant word next to it. */
+	u32 vdm_ctl;
+	/** @region_headers: This render's region header array. */
+	u32 region_headers;
+	/** @tail_pointers: The tail pointer array. */
+	u32 tail_pointers;
+	/** @eps: Two floats, 1e-6. */
+	u32 eps[2];
+	/** @screen_size: (height - 1) << 16 | (width - 1). */
+	u32 screen_size;
+	/* private: */
+	u32 pad_26c[2];
+	/* public: */
+	/** @params_base: Base of the 3D parameters heap the PB is in. */
+	u32 params_base;
+	/* private: */
+	u32 pad_278[11];
+	/* public: */
+	/** @rt_flags: RT data flags. */
+	u32 rt_flags;
+	/* private: */
+	u32 pad_2a8[6];
+};
+
+static_assert(offsetof(struct pvrsgx_fw_ta_cmd, ready) == 0x58);
+static_assert(offsetof(struct pvrsgx_fw_ta_cmd, te_aa) == 0x238);
+static_assert(offsetof(struct pvrsgx_fw_ta_cmd, params_base) == 0x274);
+static_assert(offsetof(struct pvrsgx_fw_ta_cmd, rt_flags) == 0x2a4);
+static_assert(sizeof(struct pvrsgx_fw_ta_cmd) == 0x2c0);
+
+/**
+ * struct pvrsgx_fw_rt_deps - A render target's dependency block
+ *
+ * What the 3D signals when it finishes: one destination sync, whose
+ * write-ops-complete the microkernel sets to the pending value plus one.
+ */
+struct pvrsgx_fw_rt_deps {
+	/** @access: Device address of the access word. */
+	u32 access;
+	/** @num_dst: Destination syncs, 1. */
+	u32 num_dst;
+	/** @read_pending: The destination's read-ops-pending value. */
+	u32 read_pending;
+	/** @read_complete: Its read-ops-complete address. */
+	u32 read_complete;
+	/** @write_pending: Its write-ops-pending value. */
+	u32 write_pending;
+	/** @write_complete: Its write-ops-complete address. */
+	u32 write_complete;
+	/* private: */
+	u32 pad_18[4];
+};
+
+static_assert(sizeof(struct pvrsgx_fw_rt_deps) == 0x28);
+
+/**
+ * struct pvrsgx_fw_rt_entry - One of an RT dataset's two render slots
+ *
+ * Frames alternate between the two.
+ */
+struct pvrsgx_fw_rt_entry {
+	/** @hw_render_ctx: Device address of the HW render context. */
+	u32 hw_render_ctx;
+	/** @render_details: The render in flight; the microkernel's. */
+	u32 render_details;
+	/** @mt_units: Tiles per macrotile >> 4. */
+	u32 mt_units;
+	/** @mt_bytes: Tiles per macrotile * 0xc. */
+	u32 mt_bytes;
+	/** @bg_block: Device address of the background object block. */
+	u32 bg_block;
+	/** @ta_data: The 0x88-, 0x40- and 0x50-byte TA data blocks. */
+	u32 ta_data[3];
+	/** @tail_pointers: The tail pointer array. */
+	u32 tail_pointers;
+	/** @tail_pointers_size: Its size in bytes. */
+	u32 tail_pointers_size;
+	/** @num_rts: Render targets, 1. */
+	u32 num_rts;
+	/* private: */
+	u32 pad_2c;
+	/* public: */
+	/** @entry_word: Device address of the slot's status word. */
+	u32 entry_word;
+	/** @unk_34: 0x10. */
+	u32 unk_34;
+};
+
+static_assert(sizeof(struct pvrsgx_fw_rt_entry) == 0x38);
+
+/**
+ * struct pvrsgx_fw_rt_data - An RT dataset's RT data
+ */
+struct pvrsgx_fw_rt_data {
+	/** @rt_word: Device address of the dataset's status word. */
+	u32 rt_word;
+	/* private: */
+	u32 pad_04;
+	/* public: */
+	/** @padded_tiles_x: Tiles in X, padded to whole macrotiles. */
+	u32 padded_tiles_x;
+	/* private: */
+	u32 pad_0c[2];
+	/* public: */
+	/** @num_entries: Render slots, 2. */
+	u32 num_entries;
+	/** @entry: The render slots. */
+	struct pvrsgx_fw_rt_entry entry[2];
+};
+
+static_assert(sizeof(struct pvrsgx_fw_rt_data) == 0x88);
+
+/**
+ * struct pvrsgx_fw_pb_desc - Parameter buffer descriptor
+ *
+ * Page numbers count from the 3D parameters heap.
+ */
+struct pvrsgx_fw_pb_desc {
+	/* private: */
+	u32 pad_00;
+	/* public: */
+	/** @pages: Pages in the PB. */
+	u32 pages;
+	/** @free_head: Free list head: last page << 16 | first page. */
+	u32 free_head;
+	/** @free_tail: (last page - 1) << 16. */
+	u32 free_tail;
+	/** @free_list: Device address of the free list. */
+	u32 free_list;
+	/* private: */
+	u32 pad_14;
+	/* public: */
+	/** @free_head_copy: The free list head again. */
+	u32 free_head_copy;
+	/** @free_tail_copy: The tail word again. */
+	u32 free_tail_copy;
+	/* private: */
+	u32 pad_20[2];
+	/* public: */
+	/** @ta_threshold: Pages the TA may use: pages + 0x10. */
+	u32 ta_threshold;
+	/** @zls_threshold: Pages for depth/stencil load/store: the request. */
+	u32 zls_threshold;
+	/** @global_threshold: The request. */
+	u32 global_threshold;
+	/** @pds_threshold: min(ZLS, TA) - 0x100. */
+	u32 pds_threshold;
+	/** @blocks: Device address of the PB block list. */
+	u32 blocks;
+};
+
+static_assert(sizeof(struct pvrsgx_fw_pb_desc) == 0x3c);
+
+/**
+ * struct pvrsgx_fw_render_details - Per-dataset render details
+ *
+ * Fields named unk_* hold values a render needs whose meaning isn't known.
+ */
+struct pvrsgx_fw_render_details {
+	/** @req_base_3d: 3D request base: the PB's 1 MiB-aligned base. */
+	u32 req_base_3d;
+	/** @zls_base: Depth/stencil request base, 1 MiB aligned. */
+	u32 zls_base;
+	/** @unk_08: 0x80. */
+	u32 unk_08;
+	/** @unk_0c: 0xf0000. */
+	u32 unk_0c;
+	/** @rt_ctl: Bit 31. */
+	u32 rt_ctl;
+	/** @depth_bias_units: glPolygonOffset units. */
+	u32 depth_bias_units;
+	/** @depth_bias_factor: glPolygonOffset factor, a float. */
+	u32 depth_bias_factor;
+	/* private: */
+	u32 pad_1c;
+	/* public: */
+	/** @region_headers: This render's region header array. */
+	u32 region_headers;
+	/* private: */
+	u32 pad_24;
+	/* public: */
+	/** @region_headers_next: The next render's. */
+	u32 region_headers_next;
+	/** @zls_ctl: Depth/stencil load and store control. */
+	u32 zls_ctl;
+	/** @depth: Depth buffer address - @zls_base, twice. */
+	u32 depth[2];
+	/** @stencil: Bit 31 | stencil buffer address - @zls_base, twice. */
+	u32 stencil[2];
+	/** @bg_depth: Depth every tile starts from, a float. */
+	u32 bg_depth;
+	/** @unk_44: 0x300. */
+	u32 unk_44;
+	/** @bg_object: 0x2000000 | (background block - PB base) >> 4. */
+	u32 bg_object;
+	/* private: */
+	u32 pad_4c;
+	/* public: */
+	/** @rt_flags: RT flags, 0x88. */
+	u32 rt_flags;
+	/* private: */
+	u32 pad_54;
+	/* public: */
+	/** @unk_58: 0x30. */
+	u32 unk_58;
+	/** @pixel_event_pds: End-of-tile PDS program. */
+	u32 pixel_event_pds;
+	/** @pixel_event_rows: Its data rows. */
+	u32 pixel_event_rows;
+	/** @unk_64: 1. */
+	u32 unk_64;
+	/** @unk_68: 1. */
+	u32 unk_68;
+	/* private: */
+	u32 pad_6c[24];
+	/* public: */
+	/** @unk_cc: 0x100. */
+	u32 unk_cc;
+	/** @sync: Device address of the render-details sync word. */
+	u32 sync;
+	/* private: */
+	u32 pad_d4;
+	/* public: */
+	/** @rt_data: Device address of the RT data. */
+	u32 rt_data;
+	/** @rt_data_entry: This render's RT data entry. */
+	u32 rt_data_entry;
+	/* private: */
+	u32 pad_e0[9];
+	/* public: */
+	/** @unk_104: 1. */
+	u32 unk_104;
+	/* private: */
+	u32 pad_108[2];
+	/* public: */
+	/** @word8: Device address of an 8-byte kernel word. */
+	u32 word8;
+	/** @bg_pds_word: Device address of the background object's primary PDS word. */
+	u32 bg_pds_word;
+	/* private: */
+	u32 pad_118[9];
+	/* public: */
+	/** @unk_13c: 0x7c00000. */
+	u32 unk_13c;
+	/* private: */
+	u32 pad_140[43];
+};
+
+static_assert(offsetof(struct pvrsgx_fw_render_details, unk_cc) == 0xcc);
+static_assert(offsetof(struct pvrsgx_fw_render_details, unk_104) == 0x104);
+static_assert(offsetof(struct pvrsgx_fw_render_details, unk_13c) == 0x13c);
+static_assert(sizeof(struct pvrsgx_fw_render_details) == 0x1ec);
+
+/* struct pvrsgx_fw_hw_render_ctx.flags */
+#define PVRSGX_HW_RENDER_CTX_VALID	BIT(0)
+#define PVRSGX_HW_RENDER_CTX_OWN_PB	BIT(5)
+
+/**
+ * struct pvrsgx_fw_hw_render_ctx - A render context, as the microkernel sees it
+ */
+struct pvrsgx_fw_hw_render_ctx {
+	/** @flags: PVRSGX_HW_RENDER_CTX_*. */
+	u32 flags;
+	/* private: */
+	u32 pad_04;
+	/* public: */
+	/** @page_dir: Physical address of the context's page directory. */
+	u32 page_dir;
+	/** @ccb: Device address of the context's command ring. */
+	u32 ccb;
+	/** @ccb_ctl: Device address of its write and read offsets. */
+	u32 ccb_ctl;
+	/* private: */
+	u32 pad_14;
+	/* public: */
+	/** @pb_desc: Device address of the PB descriptor. */
+	u32 pb_desc;
+	/** @scratch: Device address of the microkernel's per-context scratch block. */
+	u32 scratch;
+	/* private: */
+	u32 pad_20[8];
+	/* public: */
+	/** @pid: The creating process. */
+	u32 pid;
+};
+
+static_assert(sizeof(struct pvrsgx_fw_hw_render_ctx) == 0x44);
+
+/**
+ * struct pvrsgx_fw_hw_transfer_ctx - A transfer context, as the microkernel sees it
+ */
+struct pvrsgx_fw_hw_transfer_ctx {
+	/** @flags: 1. */
+	u32 flags;
+	/* private: */
+	u32 pad_04;
+	/* public: */
+	/** @page_dir: Physical address of the context's page directory. */
+	u32 page_dir;
+	/** @ccb: Device address of the context's command ring. */
+	u32 ccb;
+	/** @ccb_ctl: Device address of its write and read offsets. */
+	u32 ccb_ctl;
+	/* private: */
+	u32 pad_14[37];
+	/* public: */
+	/** @pid: The creating process. */
+	u32 pid;
+	/* private: */
+	u32 pad_ac[2];
+};
+
+static_assert(offsetof(struct pvrsgx_fw_hw_transfer_ctx, pid) == 0xa8);
+static_assert(sizeof(struct pvrsgx_fw_hw_transfer_ctx) == 0xb4);
+
+/* struct pvrsgx_fw_transfer_cmd.flags */
+#define PVRSGX_TRANSFER_DST_TWIDDLED	BIT(3)
+
+/**
+ * struct pvrsgx_fw_transfer_cmd - One transfer: a 3D render of a background object
+ *
+ * The first words are 3D registers in the
+ * render details' encoding; the shared part carries the destination sync.
+ */
+struct pvrsgx_fw_transfer_cmd {
+	/** @bg_object: 0x2000000 | (background block - @req_base_3d) >> 4. */
+	u32 bg_object;
+	/** @unk_04: 0x200. */
+	u32 unk_04;
+	/** @bg_depth: Depth every tile starts from, a float. */
+	u32 bg_depth;
+	/** @unk_0c: 3. */
+	u32 unk_0c;
+	/* private: */
+	u32 pad_10;
+	/* public: */
+	/** @unk_14: 0x100. */
+	u32 unk_14;
+	/** @req_base_3d: 3D request base, 1 MiB aligned. */
+	u32 req_base_3d;
+	/** @rt_ctl: Bit 31. */
+	u32 rt_ctl;
+	/** @rt_flags: 0x88. */
+	u32 rt_flags;
+	/** @pixel_event_pds: End-of-tile PDS program. */
+	u32 pixel_event_pds;
+	/** @pixel_event_rows: Its data rows. */
+	u32 pixel_event_rows;
+	/** @unk_2c: 1. */
+	u32 unk_2c;
+	/** @first_tile: First tile, x << 16 | y. */
+	u32 first_tile;
+	/** @last_tile: Last tile, x << 16 | y. */
+	u32 last_tile;
+	/** @unk_38: 0x80. */
+	u32 unk_38;
+	/** @pds_exec_base: PDS execution base: the pixel PDS heap. */
+	u32 pds_exec_base;
+	/* private: */
+	u32 pad_40[25];
+	/* public: */
+	/** @size: The command's size in bytes. */
+	u32 size;
+	/** @flags: PVRSGX_TRANSFER_*. */
+	u32 flags;
+	/* private: */
+	u32 pad_ac[33];
+	/* public: */
+	/** @num_dst: Destination syncs, 1. */
+	u32 num_dst;
+	/** @dst_read_pending: The destination sync's read-ops-pending value. */
+	u32 dst_read_pending;
+	/** @dst_read_complete: Its read-ops-complete address. */
+	u32 dst_read_complete;
+	/** @dst_write_pending: Its write-ops-pending value. */
+	u32 dst_write_pending;
+	/** @dst_write_complete: Its write-ops-complete address. */
+	u32 dst_write_complete;
+	/* private: */
+	u32 pad_144[20];
+	/* public: */
+	/** @unk_194: 0x7c00000. */
+	u32 unk_194;
+	/* private: */
+	u32 pad_198[10];
+};
+
+static_assert(offsetof(struct pvrsgx_fw_transfer_cmd, size) == 0xa4);
+static_assert(offsetof(struct pvrsgx_fw_transfer_cmd, num_dst) == 0x130);
+static_assert(offsetof(struct pvrsgx_fw_transfer_cmd, unk_194) == 0x194);
+static_assert(sizeof(struct pvrsgx_fw_transfer_cmd) == 0x1c0);
+
+#endif /* PVRSGX_FWIF_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_pds.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_pds.c
new file mode 100644
index 000000000..14afb4814
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_pds.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The PDS programs that enter the microkernel, assembled at load.
+ */
+
+#include "pvrsgx_fw.h"
+#include "pvrsgx_pds.h"
+
+/*
+ * DOUTU word 0 for microkernel code at device address a: code base 15 plus the
+ * 512 KiB segment, then the offset in the segment in 8-byte instructions, << 4.
+ * Bit 27 is set on every microkernel entry.
+ */
+u32 pvrsgx_doutu(u32 kcode, u32 a)
+{
+	u32 off = a - kcode, seg = off >> 19;
+
+	return ((seg + 15) & 15) | 0x8000000 | (((off - (seg << 19)) * 2) & 0x3ffff0);
+}
+
+void pvrsgx_pds_ds(struct pvrsgx_pds *p, unsigned int r, u32 v)
+{
+	unsigned int k = r & 0x3f;
+
+	p->w[(k >> 1) * 4 + (r >= 0x40 ? 2 : 0) + (k & 1)] = v;
+}
+
+static void pds_emit(struct pvrsgx_pds *p, u32 i)
+{
+	p->w[p->data + p->pc++] = i;
+}
+
+static unsigned int ds0w(unsigned int r)
+{
+	return r >= 0x80 ? r - 0x40 : r;
+}
+
+/* MOVS: four words from one DS0 pair and one DS1 pair to a DOUT destination. */
+void pvrsgx_pds_movs(struct pvrsgx_pds *p, unsigned int dest, unsigned int a,
+		     unsigned int b, unsigned int c, unsigned int d)
+{
+	unsigned int src[4] = { a, b, c, d }, r1 = 0, r2 = 0, sel = 0;
+
+	for (int i = 0; i < 4; i++) {
+		unsigned int s;
+
+		if (src[i] >= 0x40 && src[i] < 0x80) {
+			r2 = (src[i] - 0x40) >> 1;
+			s = 2 + (src[i] & 1);
+		} else {
+			r1 = ds0w(src[i]) >> 1;
+			s = ds0w(src[i]) & 1;
+		}
+		sel |= s << (11 - 2 * i);
+	}
+	pds_emit(p, (u32)PDS_CC_ALWAYS << 24 | r1 << 18 | r2 << 13 | sel | dest);
+}
+
+void pvrsgx_pds_halt(struct pvrsgx_pds *p)
+{
+	pds_emit(p, 0xaf000000u);
+}
+
+struct pvrsgx_pds pvrsgx_pds_prog(struct pvrsgx_device *sdev, enum pvrsgx_fw_buf b,
+				  unsigned int data)
+{
+	return (struct pvrsgx_pds){ sdev->fw.cpu[b], data, 0 };
+}
+
+/* Start the microkernel at offset e: DOUTU with word 1 = 2. */
+void pvrsgx_pds_entry(struct pvrsgx_device *sdev, enum pvrsgx_fw_buf b, u32 e)
+{
+	struct pvrsgx_pds p = pvrsgx_pds_prog(sdev, b, 4);
+	u32 doutu = pvrsgx_doutu(pvrsgx_heaps(sdev)->kernel_code.base,
+				 sdev->fw.addr[PVRSGX_FW_UKERNEL] + e);
+
+	if (sdev->family->features & PVRSGX_FEATURE_PDS_DATA_INTERLEAVE_2DWORDS) {
+		pvrsgx_pds_ds(&p, PDS_D0(0), doutu);
+		pvrsgx_pds_ds(&p, PDS_D0(1), 2);
+		pvrsgx_pds_movs(&p, PDS_DOUTU, PDS_D0(0), PDS_D0(1), PDS_D1(0), PDS_D0(0));
+	} else {
+		/*
+		 * Whether the data store interleaves one word at a time is unknown:
+		 * the memory row [doutu, 0, 0, 2] gives DOUTU (doutu, 2, 0)
+		 * under either layout.
+		 */
+		pvrsgx_pds_ds(&p, PDS_D0(0), doutu);
+		pvrsgx_pds_ds(&p, PDS_D0(1), 0);
+		pvrsgx_pds_ds(&p, PDS_D1(0), 0);
+		pvrsgx_pds_ds(&p, PDS_D1(1), 2);
+		pvrsgx_pds_movs(&p, PDS_DOUTU, PDS_D0(0), PDS_D1(1), PDS_D0(1), PDS_D0(0));
+	}
+	pvrsgx_pds_halt(&p);
+}
+
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_pds.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_pds.h
new file mode 100644
index 000000000..c5d1453c9
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_pds.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_PDS_H
+#define PVRSGX_PDS_H
+
+#include <linux/types.h>
+
+#include "pvrsgx_device.h"
+
+/*
+ * PDS assembly. A program is its data segment in 16-byte rows of
+ * DS0 DS0 DS1 DS1, then code. Operands are unified register numbers: DS0 words
+ * 0x00-0x3f, DS1 words 0x40-0x7f, inputs from 0x80 (DS0 words 0x40 on).
+ */
+#define PDS_D0(n)		(n)
+#define PDS_D1(n)		(0x40 + (n))
+#define PDS_CC_ALWAYS	7
+#define PDS_DOUTU		5
+
+/* A PDS program being assembled into a firmware buffer. */
+struct pvrsgx_pds {
+	u32 *w;
+	unsigned int data;	/* data segment words */
+	unsigned int pc;
+};
+
+u32 pvrsgx_doutu(u32 kcode, u32 addr);
+void pvrsgx_pds_ds(struct pvrsgx_pds *p, unsigned int r, u32 v);
+void pvrsgx_pds_movs(struct pvrsgx_pds *p, unsigned int dest, unsigned int a,
+		     unsigned int b, unsigned int c, unsigned int d);
+void pvrsgx_pds_halt(struct pvrsgx_pds *p);
+struct pvrsgx_pds pvrsgx_pds_prog(struct pvrsgx_device *sdev, enum pvrsgx_fw_buf b,
+				  unsigned int data);
+void pvrsgx_pds_entry(struct pvrsgx_device *sdev, enum pvrsgx_fw_buf b, u32 e);
+
+#endif /* PVRSGX_PDS_H */

-- 
2.50.1

