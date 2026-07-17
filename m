Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD14C44514
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45E2E10F4E2;
	Fri, 17 Jul 2026 10:48:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="cJgfiMyz";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id F27D510F4E2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:48:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65F2C1476;
 Fri, 17 Jul 2026 03:48:19 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com
 [10.2.198.107])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB3313F7D8;
 Fri, 17 Jul 2026 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784285303; bh=M3lQjBH3mo1sMqyWrYmtwxYC4XzZifrPrCwjDq5ZBXc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=cJgfiMyzr4hAsdGyqLrDgeDsXQcFIC1Bp+XaYgE5uSear1jwwNWNqgC0X9ZAe+iHz
 us2qcoPEpHV03mVh//mr7qig09B0iwNvNjSyT3WMLwCUu0yKZ5NsWQ6MWGiG/7vOIA
 R7tbHF4pvvlvjVb4No9CRXRkltgmfyqsQXBBGYY8=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: [RFC PATCH v1 2/8] misc/arm-cla: Add launch operation helpers
Date: Fri, 17 Jul 2026 11:47:46 +0100
Message-ID: <20260717104759.123203-3-ryan.roberts@arm.com>
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

CLA commands are issued by writing optional payload registers,
programming the LAUNCH register and polling LRESP until the hardware
accepts or rejects the operation.

Add a common launch helper that performs this sequence on the CLA's
local CPU, waits for LRESP completion and translates launch response
codes into Linux errors.

Build accelerator reset and register read and write support on top of
it. The register read and write helpers split larger accesses into
multiple launch operations when an access crosses an eight-register
window.

Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
---
 drivers/misc/arm-cla/Makefile   |   6 +
 drivers/misc/arm-cla/arm-cla.h  |  21 +++
 drivers/misc/arm-cla/cla-init.c |  12 ++
 drivers/misc/arm-cla/cla-ops.c  | 228 ++++++++++++++++++++++++++++++++
 4 files changed, 267 insertions(+)
 create mode 100644 drivers/misc/arm-cla/cla-init.c
 create mode 100644 drivers/misc/arm-cla/cla-ops.c

diff --git a/drivers/misc/arm-cla/Makefile b/drivers/misc/arm-cla/Makefile
index a4e40e534e6a..3fa8567c8b3e 100644
--- a/drivers/misc/arm-cla/Makefile
+++ b/drivers/misc/arm-cla/Makefile
@@ -1 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+arm-cla-y := \
+	cla-init.o \
+	cla-ops.o
+
+obj-$(CONFIG_ARM_CLA) += arm-cla.o
diff --git a/drivers/misc/arm-cla/arm-cla.h b/drivers/misc/arm-cla/arm-cla.h
index f265d7b60268..9294b71929f1 100644
--- a/drivers/misc/arm-cla/arm-cla.h
+++ b/drivers/misc/arm-cla/arm-cla.h
@@ -7,6 +7,8 @@
 #ifndef _ARM_CLA_H_
 #define _ARM_CLA_H_
 
+#include <linux/device.h>
+#include <linux/io.h>
 #include <linux/types.h>
 
 #include "arm-cla-regs.h"
@@ -21,10 +23,12 @@
  *
  * Immutable state:
  * @cpu:		The CPU this CLA is attached to.
+ * @regs:		Registers accessed by the kernel.
  * @dev:		The platform device.
  */
 struct cla_dev {
 	unsigned int cpu;
+	void __iomem *regs;
 	struct device *dev;
 };
 
@@ -35,4 +39,21 @@ struct cla_dev {
 #define cla_err(dev, fmt, ...) \
 	dev_err((dev)->dev, "[%u] " fmt, (dev)->cpu, ##__VA_ARGS__)
 
+static inline u64 cla_reg_read(struct cla_dev *dev, off_t reg)
+{
+	return readq_relaxed(dev->regs + reg);
+}
+
+static inline void cla_reg_write(struct cla_dev *dev, off_t reg, u64 val)
+{
+	return writeq_relaxed(val, dev->regs + reg);
+}
+
+int cla_op_wait_lresp(struct cla_dev *dev, u64 *lresp);
+int cla_op_reset(struct cla_dev *dev, unsigned int accid);
+int cla_op_regread(struct cla_dev *dev, unsigned int accid, unsigned int regidx,
+		   size_t nregs, u64 *regs);
+int cla_op_regwrite(struct cla_dev *dev, unsigned int accid,
+		    unsigned int regidx, size_t nregs, u64 *regs);
+
 #endif /* _ARM_CLA_H_ */
diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-init.c
new file mode 100644
index 000000000000..3d1f47592842
--- /dev/null
+++ b/drivers/misc/arm-cla/cla-init.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Arm CLA driver - probing and initialization
+ *
+ * Copyright 2026 Arm Limited.
+ */
+
+#include <linux/module.h>
+
+MODULE_DESCRIPTION("Arm Core Local Accelerator");
+MODULE_AUTHOR("Arm Limited");
+MODULE_LICENSE("GPL");
diff --git a/drivers/misc/arm-cla/cla-ops.c b/drivers/misc/arm-cla/cla-ops.c
new file mode 100644
index 000000000000..d594344a2eb4
--- /dev/null
+++ b/drivers/misc/arm-cla/cla-ops.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Arm CLA driver - Launch operations
+ *
+ * Copyright 2026 Arm Limited.
+ */
+
+#include <linux/iopoll.h>
+
+#include "arm-cla.h"
+
+/* Time to wait between two LRESP reads */
+#define CLA_LRESP_DELAY_US	1
+
+/*
+ * Time to wait for LRESP_PENDING to clear. Commands like REGREAD should
+ * complete in a few cycles, but ENTERSR and RESET may need to clean up
+ * some very large states depending on the work interrupted, and may need
+ * 1us or more.
+ */
+#define CLA_LRESP_TIMEOUT_US	100
+
+enum cla_launch_data_mode {
+	CLA_DATA_NONE,
+	CLA_DATA_IN,
+	CLA_DATA_OUT,
+};
+
+struct cla_launch {
+	u8	op;		/* opcode */
+	u8	ndata_m1;	/* Data size minus 1 */
+	u8	accid;		/* Accelerator ID */
+	bool	seq;		/* part of compound cmd */
+	u32	regidx;		/* Register index */
+
+	enum cla_launch_data_mode data_mode;
+	u64	*data;		/* In/out data */
+
+	u8	errcode;	/* Output error code */
+};
+
+/**
+ * cla_op_launch - Launch operation.
+ * @dev: CLA device.
+ * @launch: LAUNCH settings.
+ *
+ * 1. If data_mode is %CLA_DATA_IN, write DATA registers.
+ * 2. Launch the operation, and wait for the response.
+ * 3. If data_mode is %CLA_DATA_OUT, read DATA registers into @launch->data.
+ *
+ * Return:
+ * * %0			- Success.
+ * * %-ETIMEDOUT	- LAUNCH timed out (possibly no CLA at this address).
+ *			  Unless LRESP_PENDING eventually clears, this is
+ *			  unrecoverable.
+ * * %-ENODEV		- Accelerator not available.
+ * * %-EBUSY		- Accelerator is busy.
+ * * %-EIO		- LAUNCH error. @launch->errcode contains the LRESP
+ *			  error code.
+ */
+static int cla_op_launch(struct cla_dev *dev, struct cla_launch *launch)
+{
+	int i;
+	int ret;
+	u64 lresp;
+
+	if (WARN_ON(smp_processor_id() != dev->cpu))
+		return -EINVAL;
+
+	if (launch->data_mode == CLA_DATA_IN)
+		for (i = 0; i < launch->ndata_m1 + 1; i++)
+			cla_reg_write(dev, CLA_REG_DATA(i), launch->data[i]);
+
+	/*
+	 * No barrier needed because accesses use Device-nGnRE, within the same
+	 * memory-mapped peripheral, so accesses arrive at the endpoint in
+	 * program order.
+	 */
+	cla_reg_write(dev, CLA_REG_LAUNCH,
+		      FIELD_PREP(CLA_LAUNCH_OP, launch->op) |
+		      FIELD_PREP(CLA_LAUNCH_NDATA_M1, launch->ndata_m1) |
+		      FIELD_PREP(CLA_LAUNCH_ACCID, launch->accid) |
+		      FIELD_PREP(CLA_LAUNCH_SEQ, launch->seq) |
+		      FIELD_PREP(CLA_LAUNCH_REGIDX, launch->regidx));
+
+	ret = cla_op_wait_lresp(dev, &lresp);
+	if (ret) {
+		cla_err(dev, "launch failed with %d\n", ret);
+		return ret;
+	}
+
+	switch (FIELD_GET(CLA_LRESP_CODE, lresp)) {
+	case CLA_LRESP_OK:
+		break;
+	case CLA_LRESP_UNAVAIL:
+		return -ENODEV;
+	case CLA_LRESP_BUSY:
+		return -EBUSY;
+	case CLA_LRESP_ERROR:
+		launch->errcode = FIELD_GET(CLA_LRESP_ERRCODE, lresp);
+		return -EIO;
+	}
+
+	if (launch->data_mode == CLA_DATA_OUT)
+		for (i = 0; i < launch->ndata_m1 + 1; i++)
+			launch->data[i] = cla_reg_read(dev, CLA_REG_DATA(i));
+
+	return 0;
+}
+
+/**
+ * cla_op_wait_lresp - Wait for any LAUNCH op to complete.
+ * @dev: CLA device.
+ * @lresp: last LRESP value read.
+ *
+ * Return: 0 on success, -ETIMEDOUT in case of timeout.
+ */
+int cla_op_wait_lresp(struct cla_dev *dev, u64 *lresp)
+{
+	return readq_relaxed_poll_timeout_atomic(dev->regs + CLA_REG_LRESP,
+			*lresp, FIELD_GET(CLA_LRESP_PENDING, *lresp) == 0,
+			CLA_LRESP_DELAY_US, CLA_LRESP_TIMEOUT_US);
+}
+
+/**
+ * cla_op_reset - Launch RESET operation for this accelerator.
+ * @dev: CLA device.
+ * @accid: accelerator ID.
+ *
+ * Return: 0 on success, 1 if there is no accelerator with this ID, or an error.
+ */
+int cla_op_reset(struct cla_dev *dev, unsigned int accid)
+{
+	int ret;
+	struct cla_launch launch = {
+		.op	= CLA_LAUNCH_OP_RESET,
+		.accid	= accid,
+	};
+
+	ret = cla_op_launch(dev, &launch);
+	if (ret == -EIO && launch.errcode == CLA_ERRCODE_NOACC)
+		return 1;
+	return ret;
+}
+
+static int cla_op_access_reg(struct cla_dev *dev, u8 op,
+			     enum cla_launch_data_mode data_mode,
+			     unsigned int accid, unsigned int regidx,
+			     size_t nregs, u64 *regs)
+{
+	int ret = -EINVAL;
+	unsigned long max_regidx;
+	struct cla_launch launch = {
+		.op = op,
+		.accid = accid,
+		.data_mode = data_mode,
+	};
+
+	switch (op) {
+	case CLA_LAUNCH_OP_REGREAD:
+	case CLA_LAUNCH_OP_REGWRITE:
+		max_regidx = 0x100000000;
+		break;
+	default:
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	if (WARN_ON(regidx + nregs > max_regidx))
+		return -EINVAL;
+
+	/* 1 to 8 registers accessed at a time, within the same 8-reg group */
+	while (nregs > 0) {
+		unsigned int reg_group = ALIGN_DOWN(regidx, 8);
+		unsigned int max_reg = min(regidx + nregs, reg_group + 8);
+		unsigned int ndata = max_reg - regidx;
+
+		launch.ndata_m1 = ndata - 1;
+		launch.regidx = regidx;
+		launch.data = regs;
+
+		ret = cla_op_launch(dev, &launch);
+		if (ret)
+			break;
+
+		regidx += ndata;
+		regs += ndata;
+		nregs -= ndata;
+	}
+
+	return ret;
+}
+
+/**
+ * cla_op_regread - Launch REGREAD operations.
+ * @dev: CLA device.
+ * @accid: accelerator ID.
+ * @regidx: first register index.
+ * @nregs: number of registers. Can be greater than 8 (accessed with multiple
+ *         REGREAD operations).
+ * @regs: array of length @nregs.
+ *
+ * Return: 0 on success, or an error.
+ */
+int cla_op_regread(struct cla_dev *dev, unsigned int accid,
+			  unsigned int regidx, size_t nregs, u64 *regs)
+{
+	return cla_op_access_reg(dev, CLA_LAUNCH_OP_REGREAD, CLA_DATA_OUT,
+				 accid, regidx, nregs, regs);
+}
+
+/**
+ * cla_op_regwrite - Launch REGWRITE operations.
+ * @dev: CLA device.
+ * @accid: accelerator ID.
+ * @regidx: first register index.
+ * @nregs: number of registers. Can be greater than 8 (accessed with multiple
+ *         REGWRITE operations).
+ * @regs: array of length @nregs.
+ *
+ * Return: 0 on success, or an error.
+ */
+int cla_op_regwrite(struct cla_dev *dev, unsigned int accid,
+			   unsigned int regidx, size_t nregs, u64 *regs)
+{
+	return cla_op_access_reg(dev, CLA_LAUNCH_OP_REGWRITE, CLA_DATA_IN,
+				 accid, regidx, nregs, regs);
+}
-- 
2.43.0

