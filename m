Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DC1C44516
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:48:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B68B10F4F5;
	Fri, 17 Jul 2026 10:48:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="qKWqs1tY";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3961A10F4EE
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:48:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A08D316A3;
 Fri, 17 Jul 2026 03:48:25 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com
 [10.2.198.107])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0ECF73F7D8;
 Fri, 17 Jul 2026 03:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784285309; bh=h0EEXQNHC9ihxehacPaDoP+3zl/YwSV/oonbudN70L0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qKWqs1tY4kGLvj0gph/UT0cDasG2iUSxFJk9CnGa6FFPiPJoH5EQy29uMxr97/1d/
 wEkd91gR/EF+z4DZE8nzCyw0QSKBraxhHKuDDKMFQn/7KoXTjwo5aZLdmmtK91VrRq
 3jSY0+QxsYnyBPyggY6M0LbPWGM2YQ/m1zNBRos4=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: [RFC PATCH v1 5/8] misc/arm-cla: Accelerator context save and restore
Date: Fri, 17 Jul 2026 11:47:49 +0100
Message-ID: <20260717104759.123203-6-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717104759.123203-1-ryan.roberts@arm.com>
References: <20260717104759.123203-1-ryan.roberts@arm.com>
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

From: Jean-Philippe Brucker <jpb@kernel.org>

Add helpers to save and restore CLA context for later domain switching.
The saved state includes DATA registers, LRESP, per-accelerator SRSTATE
and any implementation-defined internal accelerator state exposed
through the IAS register window.

Use ENTERSR to stop each accelerator and collect SRSTATE, then read the
advertised internal register state with REGREAD. Restore by entering SR
mode from a reset, idle accelerator, writing the saved internal state
with REGWRITE and completing the transition with EXITSR.

Reject accelerators that require SAVE/RESTORE operations during setup,
since that path needs a DMA buffer for state storage. We don't have any
accelerators that support this anyway. Allocate per-device save areas
for all CLAs in a domain, sized from the combined IASSIZE discovered at
setup time.

Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
---
 drivers/misc/arm-cla/Makefile   |   1 +
 drivers/misc/arm-cla/arm-cla.h  |  27 ++++
 drivers/misc/arm-cla/cla-init.c |  22 +++
 drivers/misc/arm-cla/cla-ops.c  |  43 ++++++
 drivers/misc/arm-cla/cla-regs.c | 263 ++++++++++++++++++++++++++++++++
 5 files changed, 356 insertions(+)
 create mode 100644 drivers/misc/arm-cla/cla-regs.c

diff --git a/drivers/misc/arm-cla/Makefile b/drivers/misc/arm-cla/Makefile
index 84ed1a054a21..c1b14155454d 100644
--- a/drivers/misc/arm-cla/Makefile
+++ b/drivers/misc/arm-cla/Makefile
@@ -3,6 +3,7 @@
 arm-cla-y := \
 	cla-init.o \
 	cla-ops.o \
+	cla-regs.o \
 	cla-topology.o
 
 obj-$(CONFIG_ARM_CLA) += arm-cla.o
diff --git a/drivers/misc/arm-cla/arm-cla.h b/drivers/misc/arm-cla/arm-cla.h
index 57d0acd01d3a..f1c6d509c3fe 100644
--- a/drivers/misc/arm-cla/arm-cla.h
+++ b/drivers/misc/arm-cla/arm-cla.h
@@ -30,6 +30,7 @@ struct cla_domain;
  * @pfn:		Page of registers assigned to user.
  * @accelerators:	Available accelerators.
  * @pg_offset:		Mmap offset of this device.
+ * @iassizes:		Combined regstate of all accels.
  * @domain:		The domain this CLA belongs to.
  *
  * Mutable, only accessed under @lock:
@@ -43,6 +44,7 @@ struct cla_dev {
 	unsigned long pfn;
 	u8 accelerators;
 	unsigned long pg_offset;
+	unsigned long iassizes;
 	struct cla_domain *domain;
 
 	struct mutex lock;
@@ -65,6 +67,23 @@ struct cla_domain {
 	struct cla_dev **devs;
 };
 
+/**
+ * struct cla_regs - Saved CLA register state
+ *
+ * @data:		DATA registers.
+ * @lresp:		LRESP register.
+ * @accel_valid:	Accelerator state has been saved once.
+ * @srstate:		Save/restore state for each accelerator.
+ * @regstate:		Internal accelerator state.
+ */
+struct cla_regs {
+	u64 data[CLA_NUM_DATA_REGS];
+	u64 lresp;
+	bool accel_valid;
+	u64 srstate[CLA_NUM_ACC][CLA_SRSTATE_LEN];
+	u64 regstate[];
+};
+
 extern struct xarray cla_domains;
 extern unsigned int cla_nr_domains;
 extern struct cla_dev **cla_lut_cpu;
@@ -115,5 +134,13 @@ int cla_op_regread(struct cla_dev *dev, unsigned int accid, unsigned int regidx,
 		   size_t nregs, u64 *regs);
 int cla_op_regwrite(struct cla_dev *dev, unsigned int accid,
 		    unsigned int regidx, size_t nregs, u64 *regs);
+int cla_op_entersr(struct cla_dev *dev, unsigned int accid, u64 *srstate);
+int cla_op_exitsr(struct cla_dev *dev, unsigned int accid, u64 *srstate);
+
+int cla_regs_switch_out(struct cla_dev *dev, struct cla_regs *regs,
+			bool save_regs);
+int cla_regs_switch_in(struct cla_dev *dev, struct cla_regs *regs);
+struct cla_regs **cla_regs_alloc_domain(struct cla_domain *domain);
+void cla_regs_free_domain(struct cla_domain *domain, struct cla_regs **regs);
 
 #endif /* _ARM_CLA_H_ */
diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-init.c
index ba7552a2d886..189ab2a139f1 100644
--- a/drivers/misc/arm-cla/cla-init.c
+++ b/drivers/misc/arm-cla/cla-init.c
@@ -81,6 +81,8 @@ static int cla_reset_pmu(struct cla_dev *dev, unsigned int accid)
 static int cla_dev_setup_accel(struct cla_dev *dev, unsigned int accid)
 {
 	u64 status;
+	u64 iassize;
+	u64 acap;
 	int ret;
 
 	/*
@@ -106,6 +108,26 @@ static int cla_dev_setup_accel(struct cla_dev *dev, unsigned int accid)
 		return -EIO;
 	}
 
+	/*
+	 * We don't support SROP (SAVE and RESTORE ops), only context switching
+	 * with REGREAD and REGWRITE. SROP would require finding a DMA buffer
+	 * where to save state, ideally in userspace process to avoid kernel
+	 * DMA. It's complicated and no implementation needs it at the moment.
+	 */
+	ret = cla_op_regread(dev, accid, CLA_REG_ACAP, 1, &acap);
+	if (ret)
+		return ret;
+	if (FIELD_GET(CLA_ACAP_SROP, acap)) {
+		cla_err(dev, "[%u] SROP not supported\n", accid);
+		return 1;
+	}
+
+	ret = cla_op_regread(dev, accid, CLA_REG_IASSIZE, 1, &iassize);
+	if (ret)
+		return ret;
+	if (FIELD_GET(CLA_ACAP_REGSTATE, acap) && iassize)
+		dev->iassizes += iassize;
+
 	/*
 	 * The following are nice to have, but the accelerator should work
 	 * without them.
diff --git a/drivers/misc/arm-cla/cla-ops.c b/drivers/misc/arm-cla/cla-ops.c
index f9e5570e89c1..7ddb973927e9 100644
--- a/drivers/misc/arm-cla/cla-ops.c
+++ b/drivers/misc/arm-cla/cla-ops.c
@@ -245,3 +245,46 @@ int cla_op_regwrite(struct cla_dev *dev, unsigned int accid,
 	return cla_op_access_reg(dev, CLA_LAUNCH_OP_REGWRITE, CLA_DATA_IN,
 				 accid, regidx, nregs, regs);
 }
+
+/**
+ * cla_op_entersr - launch ENTERSR operation.
+ * @dev: CLA device.
+ * @accid: accelerator ID.
+ * @srstate: 64-byte save/restore state written by CLA. May be NULL if the
+ *           SRSTATE isn't needed.
+ *
+ * Return: 0 on success, or an error.
+ */
+int cla_op_entersr(struct cla_dev *dev, unsigned int accid, u64 *srstate)
+{
+	struct cla_launch launch = {
+		.op		= CLA_LAUNCH_OP_ENTERSR,
+		.ndata_m1	= 7,
+		.accid		= accid,
+		.data_mode	= srstate ? CLA_DATA_OUT : CLA_DATA_NONE,
+		.data		= srstate,
+	};
+
+	return cla_op_launch(dev, &launch);
+}
+
+/**
+ * cla_op_exitsr - launch EXITSR operation.
+ * @dev: CLA device.
+ * @accid: accelerator ID.
+ * @srstate: 64-byte save/restore state written to CLA.
+ *
+ * Return: 0 on success, or an error.
+ */
+int cla_op_exitsr(struct cla_dev *dev, unsigned int accid, u64 *srstate)
+{
+	struct cla_launch launch = {
+		.op		= CLA_LAUNCH_OP_EXITSR,
+		.ndata_m1	= 7,
+		.accid		= accid,
+		.data_mode	= CLA_DATA_IN,
+		.data		= srstate,
+	};
+
+	return cla_op_launch(dev, &launch);
+}
diff --git a/drivers/misc/arm-cla/cla-regs.c b/drivers/misc/arm-cla/cla-regs.c
new file mode 100644
index 000000000000..7507796cd551
--- /dev/null
+++ b/drivers/misc/arm-cla/cla-regs.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Arm CLA driver - save/restore accelerator context
+ *
+ * Copyright 2026 Arm Limited.
+ */
+
+#include <linux/io.h>
+
+#include "arm-cla.h"
+
+static int cla_regs_save_accel(struct cla_dev *dev, unsigned int accid,
+			       struct cla_regs *regs, off_t *regstate_off)
+{
+	int ret;
+	u64 status;
+	size_t regstate_size;
+	u64 *srstate = regs->srstate[accid];
+
+	ret = cla_op_entersr(dev, accid, srstate);
+	if (ret) {
+		/*
+		 * Note that we don't expect the accelerator to return an error.
+		 * Implementations that don't support context switch cancel the
+		 * work and write an error in SRSTATE_STATUS, but don't fail
+		 * ENTERSR.
+		 */
+		return ret;
+	}
+
+	status = cla_reg_read(dev, CLA_REG_STATUS(accid));
+	if ((status & CLA_STATUS_STATE_MASK) != CLA_STATUS_STATE_SRMODE) {
+		cla_err(dev, "unexpected SR status 0x%llx\n", status);
+		return -EIO;
+	}
+
+	/*
+	 * A device that supports SROP fails device probe. Others should not
+	 * report SROP here, we don't support it.
+	 */
+	WARN_ON(FIELD_GET(CLA_SRSTATE_0_SROP, srstate[0]));
+
+	regstate_size = FIELD_GET(CLA_SRSTATE_0_REGSTATE, srstate[0]);
+	if (WARN_ON(*regstate_off + regstate_size * 8 > dev->iassizes))
+		return -ENOSPC;
+
+	if (regstate_size) {
+		ret = cla_op_regread(dev, accid, CLA_REG_IASn, regstate_size,
+				     regs->regstate + *regstate_off);
+		if (ret) {
+			cla_err(dev, "failed to save regstate: %d\n", ret);
+			return ret;
+		}
+	}
+
+	*regstate_off += regstate_size;
+
+	return 0;
+}
+
+/*
+ * Errors are very unlikely, but if they happen the device is left in SRMODE.
+ */
+static int cla_regs_restore_accel(struct cla_dev *dev, unsigned int accid,
+				  struct cla_regs *regs, off_t *regstate_off)
+{
+	int ret;
+	u64 status;
+	size_t regstate_size;
+	u64 *srstate = regs->srstate[accid];
+
+	/*
+	 * The accelerator was reset and isn't in SRMODE. Later we could support
+	 * coming directly from cla_regs_save_accel() in SRMODE, but at the
+	 * moment we always need a RESET.
+	 */
+	status = cla_reg_read(dev, CLA_REG_STATUS(accid));
+	if ((status & CLA_STATUS_STATE_MASK) != CLA_STATUS_STATE_IDLE) {
+		cla_err(dev, "unexpected status 0x%llx\n", status);
+		return -EIO;
+	}
+
+	ret = cla_op_entersr(dev, accid, NULL);
+	if (ret)
+		return ret;
+
+	WARN_ON(FIELD_GET(CLA_SRSTATE_0_SROP, srstate[0]));
+
+	regstate_size = FIELD_GET(CLA_SRSTATE_0_REGSTATE, srstate[0]);
+	if (WARN_ON(*regstate_off + regstate_size * 8 > dev->iassizes))
+		return -ENOSPC;
+
+	if (regstate_size) {
+		ret = cla_op_regwrite(dev, accid, CLA_REG_IASn, regstate_size,
+				      regs->regstate + *regstate_off);
+		if (ret) {
+			cla_err(dev, "failed to restore regstate: %d\n", ret);
+			return ret;
+		}
+	}
+
+	*regstate_off += regstate_size;
+
+	return cla_op_exitsr(dev, accid, srstate);
+}
+
+/**
+ * cla_regs_switch_out - Save CLA context and reset all accelerators
+ * @dev: CLA device
+ * @regs: CLA register state to save
+ * @save_regs: whether to save the DATA and accelerator state
+ *
+ * When this completes, all accelerators are idle. If this fails, some
+ * accelerators may still be running.
+ *
+ * Return: 0 on success, or an error
+ */
+int cla_regs_switch_out(struct cla_dev *dev, struct cla_regs *regs,
+			bool save_regs)
+{
+	int i;
+	int ret;
+	unsigned int accid;
+	off_t regstate_off = 0;
+
+	/*
+	 * When we interrupt the user process in the middle of launching a
+	 * command, we have to wait for LRESP_PENDING to clear before we can
+	 * launch a new command or save the DATA registers.
+	 */
+	ret = cla_op_wait_lresp(dev, &regs->lresp);
+	if (ret)
+		return ret;
+
+	if (save_regs) {
+		for (i = 0; i < CLA_NUM_DATA_REGS; i++)
+			regs->data[i] = cla_reg_read(dev, CLA_REG_DATA(i));
+
+		cla_for_each_accid(dev, accid) {
+			ret = cla_regs_save_accel(dev, accid, regs, &regstate_off);
+			if (ret)
+				return ret;
+		}
+
+		regs->accel_valid = true;
+	}
+
+	/*
+	 * "If the accelerator is non idle when ENTERSR is launched, then a
+	 * RESET operation is required after the internal accelerator state has
+	 * been saved"
+	 *
+	 * However some accelerators keep stale internal state and caches even
+	 * after job completion, so always RESET for now.
+	 */
+	return cla_op_reset_all(dev);
+}
+
+/**
+ * cla_regs_switch_in - Restore CLA context
+ * @dev: CLA device
+ * @regs: CLA register state to restore
+ *
+ * Restore the DATA and LRESP registers, and accelerator state if one has been
+ * saved. This function is called with all accelerators idle and no trace of
+ * previous work.
+ *
+ * Return: 0 on success, or an error
+ */
+int cla_regs_switch_in(struct cla_dev *dev, struct cla_regs *regs)
+{
+	int i;
+	int ret;
+	unsigned int accid;
+	off_t regstate_off = 0;
+
+	cla_for_each_accid(dev, accid) {
+		if (regs->accel_valid) {
+			ret = cla_regs_restore_accel(dev, accid, regs, &regstate_off);
+			if (ret)
+				return ret;
+			/*
+			 * At this point we must not read STATUS because that
+			 * would clear EVENT. Userspace always gets a spurious
+			 * EVENT on restore, because we have no way to
+			 * save/restore EVENT and userspace missing an event
+			 * would be worse than getting a spurious one.
+			 */
+		} else {
+			/*
+			 * If this context has never been scheduled, then we
+			 * just clean the CLA regs. Also clear EVENT by reading
+			 * STATUS, to provide a pristine context.
+			 */
+			cla_reg_read(dev, CLA_REG_STATUS(accid));
+		}
+	}
+
+	for (i = 0; i < CLA_NUM_DATA_REGS; i++)
+		cla_reg_write(dev, CLA_REG_DATA(i), regs->data[i]);
+	cla_reg_write(dev, CLA_REG_LRESP, regs->lresp);
+
+	return 0;
+}
+
+/**
+ * cla_regs_alloc_domain - Allocate register state for a CLA domain
+ * @domain: CLA domain
+ *
+ * Allocate register state to save and restore every device in @domain.
+ *
+ * Return: an array of register state pointers on success, %NULL on failure.
+ */
+struct cla_regs **cla_regs_alloc_domain(struct cla_domain *domain)
+{
+	int i;
+	size_t size;
+	struct cla_regs **regs_ptrs;
+
+	regs_ptrs = kmalloc_objs(*regs_ptrs, domain->nr_devs,
+				 GFP_KERNEL_ACCOUNT);
+	if (!regs_ptrs)
+		return NULL;
+
+	for (i = 0; i < domain->nr_devs; i++) {
+		struct cla_regs *regs;
+		struct cla_dev *dev = domain->devs[i];
+
+		/*
+		 * The regs structures are only ever accessed from the CLA
+		 * device's CPU, so try to allocate them on the right NUMA node
+		 */
+		size = sizeof(*regs) + dev->iassizes;
+		regs = kvzalloc_node(size, GFP_KERNEL_ACCOUNT,
+				     cpu_to_node(dev->cpu));
+		if (!regs)
+			goto err_free;
+
+		regs_ptrs[i] = regs;
+	}
+
+	return regs_ptrs;
+
+err_free:
+	for (i--; i >= 0; i--)
+		kvfree(regs_ptrs[i]);
+	kfree(regs_ptrs);
+	return NULL;
+}
+
+/**
+ * cla_regs_free_domain - Free register state for a CLA domain
+ * @domain: CLA domain
+ * @regs: array of register state pointers to free
+ */
+void cla_regs_free_domain(struct cla_domain *domain, struct cla_regs **regs)
+{
+	int i;
+
+	for (i = 0; i < domain->nr_devs; i++)
+		kvfree(regs[i]);
+	kfree(regs);
+}
-- 
2.43.0

