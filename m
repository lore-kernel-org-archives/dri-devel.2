Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763AAC44507
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 10:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FBA10F4FF;
	Fri, 17 Jul 2026 10:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QEEiw3Uf";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 390BB10F4EE
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 10:48:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A3C169E;
 Fri, 17 Jul 2026 03:48:23 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com
 [10.2.198.107])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05CCF3F7D8;
 Fri, 17 Jul 2026 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1784285307; bh=hL8zKEfkHR6cwYhCGYTeqo96eLtnIhcZah/Vhkb5Kyw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QEEiw3Uf+kHm/zL1nFZBxldILQjzxBFtjhfH7EA92tF9OyM93+HNtLYZ9vPDFTQfZ
 UnECFi4Mu3zS9ouFkdwePVIYiEmBC6juhEOfM0DrXtx7xq3o5DWIyZ+iC6rUoj9Th3
 yj2UICSyOOTN2JPHcBs/PsQ8B3E1oy19hU4DDskw=
From: Ryan Roberts <ryan.roberts@arm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Oded Gabbay <ogabbay@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: [RFC PATCH v1 4/8] misc/arm-cla: Initialize devices on CPU bringup
Date: Fri, 17 Jul 2026 11:47:48 +0100
Message-ID: <20260717104759.123203-5-ryan.roberts@arm.com>
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

CLA registers are only accessible from the CPU local to the CLA, so
perform device initialization from the CPU hotplug online callback.

Clear the DATA registers, reset each attached accelerator and verify
that it returns to the expected idle state. Record the set of usable
accelerators and expose only those through PL0CTRL, and through PL1CTRL
when the kernel is running at EL2.

Reset optional timestamp and PMU controls where available so userspace
starts from a predictable state, but do not fail probing if those
optional controls cannot be programmed.

On CPU teardown, reset all known accelerators and mark the device broken
if reset fails, since the hotplug teardown path cannot safely fail.

Signed-off-by: Jean-Philippe Brucker <jpb@kernel.org>
---
 drivers/misc/arm-cla/arm-cla.h  |  14 +++
 drivers/misc/arm-cla/cla-init.c | 178 ++++++++++++++++++++++++++++++++
 drivers/misc/arm-cla/cla-ops.c  |  19 ++++
 3 files changed, 211 insertions(+)

diff --git a/drivers/misc/arm-cla/arm-cla.h b/drivers/misc/arm-cla/arm-cla.h
index 1853daa200e4..57d0acd01d3a 100644
--- a/drivers/misc/arm-cla/arm-cla.h
+++ b/drivers/misc/arm-cla/arm-cla.h
@@ -28,16 +28,25 @@ struct cla_domain;
  * @regs:		Registers accessed by the kernel.
  * @dev:		The platform device.
  * @pfn:		Page of registers assigned to user.
+ * @accelerators:	Available accelerators.
  * @pg_offset:		Mmap offset of this device.
  * @domain:		The domain this CLA belongs to.
+ *
+ * Mutable, only accessed under @lock:
+ * @lock:		Protects the following members.
+ * @broken:		Hardware failure.
  */
 struct cla_dev {
 	unsigned int cpu;
 	void __iomem *regs;
 	struct device *dev;
 	unsigned long pfn;
+	u8 accelerators;
 	unsigned long pg_offset;
 	struct cla_domain *domain;
+
+	struct mutex lock;
+	bool broken;
 };
 
 /**
@@ -62,6 +71,10 @@ extern struct cla_dev **cla_lut_cpu;
 extern struct cla_dev **cla_lut_pg;
 extern unsigned int cla_nr_devs;
 
+#define cla_for_each_accid(dev, accid) \
+	for ((accid) = 0; (accid) < CLA_NUM_ACC; (accid)++) \
+		for_each_if((dev)->accelerators & BIT(accid))
+
 #define cla_dbg(dev, fmt, ...) \
 	dev_dbg((dev)->dev, "[%u] " fmt, (dev)->cpu, ##__VA_ARGS__)
 #define cla_info(dev, fmt, ...) \
@@ -97,6 +110,7 @@ void cla_domains_free(void);
 
 int cla_op_wait_lresp(struct cla_dev *dev, u64 *lresp);
 int cla_op_reset(struct cla_dev *dev, unsigned int accid);
+int cla_op_reset_all(struct cla_dev *dev);
 int cla_op_regread(struct cla_dev *dev, unsigned int accid, unsigned int regidx,
 		   size_t nregs, u64 *regs);
 int cla_op_regwrite(struct cla_dev *dev, unsigned int accid,
diff --git a/drivers/misc/arm-cla/cla-init.c b/drivers/misc/arm-cla/cla-init.c
index 731ca08c9b79..ba7552a2d886 100644
--- a/drivers/misc/arm-cla/cla-init.c
+++ b/drivers/misc/arm-cla/cla-init.c
@@ -17,18 +17,192 @@
 
 static int cla_cpuhp_state = -1;
 
+static int cla_reset_ts(struct cla_dev *dev, unsigned int accid)
+{
+	int ret;
+	u64 reg;
+
+	ret = cla_op_regread(dev, accid, CLA_REG_ACAP, 1, &reg);
+	if (ret)
+		return ret;
+	if (!FIELD_GET(CLA_ACAP_TS, reg))
+		return 0;
+
+	/*
+	 * Disable TS control from userspace, provide TS from CNTP. If we do
+	 * have to provide a timer to userspace or a virtual offset to a guest,
+	 * we'll need to make sure we have access to both TSCTRLOWNER and
+	 * TSOFFOWNER. For now best effort.
+	 */
+	reg = FIELD_PREP(CLA_TSCTRLOWNER_PL, cla_kernel_pl);
+	ret = cla_op_regwrite(dev, accid, CLA_REG_TSCTRLOWNER, 1, &reg);
+	if (!ret) {
+		reg = FIELD_PREP(CLA_TSCTRL_TS, CLA_TSCTRL_PHYSICAL);
+		ret = cla_op_regwrite(dev, accid, CLA_REG_TSCTRL, 1, &reg);
+		if (ret)
+			return ret;
+	}
+
+	reg = FIELD_PREP(CLA_TSOFFOWNER_PL, cla_kernel_pl);
+	ret = cla_op_regread(dev, accid, CLA_REG_TSOFFOWNER, 1, &reg);
+	if (!ret) {
+		reg = 0;
+		ret = cla_op_regwrite(dev, accid, CLA_REG_TSVOFF, 1, &reg);
+		if (ret)
+			return ret;
+		ret = cla_op_regwrite(dev, accid, CLA_REG_TSPOFF, 1, &reg);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int cla_reset_pmu(struct cla_dev *dev, unsigned int accid)
+{
+	int ret;
+	u64 reg;
+
+	/* Disable PMU access */
+	reg = FIELD_PREP(CLA_PMUOWNER_PL, cla_kernel_pl);
+	ret = cla_op_regwrite(dev, accid, CLA_REG_PMUOWNER, 1, &reg);
+	if (!ret) {
+		reg = 0;
+		ret = cla_op_regwrite(dev, accid, CLA_REG_PMURESET, 1, &reg);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+/*
+ * Return: 0 on success, 1 if the accelerator is not attached or not usable, or
+ * an error
+ */
+static int cla_dev_setup_accel(struct cla_dev *dev, unsigned int accid)
+{
+	u64 status;
+	int ret;
+
+	/*
+	 * Probe and reset. Return 1 if no accelerator is attached, happy days.
+	 * If the accelerator is unavailable (masked by higher PL with PLxCTRL),
+	 * return an error. Individual accelerators cannot be owned by a higher
+	 * PL, since the MTC is shared between all accelerators attached to this
+	 * CLA.
+	 *
+	 * Some accelerators will be masked due to returning 1 further down this
+	 * function. If we end up with no dev->accelerators because of that we
+	 * won't setup the MTC, but as long as this reset succeeds, the
+	 * accelerator is not issuing memory transactions.
+	 */
+	ret = cla_op_reset(dev, accid);
+	if (ret)
+		return ret;
+
+	status = cla_reg_read(dev, CLA_REG_STATUS(accid));
+	if ((status & CLA_STATUS_STATE_MASK) != CLA_STATUS_STATE_IDLE) {
+		cla_err(dev, "unexpected status 0x%llx for accelerator %d\n",
+			status, accid);
+		return -EIO;
+	}
+
+	/*
+	 * The following are nice to have, but the accelerator should work
+	 * without them.
+	 */
+	ret = cla_reset_ts(dev, accid);
+	if (ret)
+		cla_err(dev, "[%u] could not reset TS: %d\n", accid, ret);
+
+	ret = cla_reset_pmu(dev, accid);
+	if (ret)
+		cla_err(dev, "[%u] could not reset PMU: %d\n", accid, ret);
+
+	return 0;
+}
+
+/* Clean the device before releasing it */
+static void cla_dev_reinit(struct cla_dev *dev)
+{
+	int i;
+	bool broken;
+
+	mutex_lock(&dev->lock);
+	broken = dev->broken;
+	mutex_unlock(&dev->lock);
+	if (broken)
+		return;
+
+	if (WARN_ON(cla_op_reset_all(dev))) {
+		mutex_lock(&dev->lock);
+		dev->broken = true;
+		mutex_unlock(&dev->lock);
+		return;
+	}
+
+	if (is_kernel_in_hyp_mode())
+		cla_reg_write(dev, CLA_REG_PL1CTRL, ~0ULL);
+	cla_reg_write(dev, CLA_REG_PL0CTRL, ~0ULL);
+	for (i = 0; i < CLA_NUM_DATA_REGS; i++)
+		cla_reg_write(dev, CLA_REG_DATA(i), 0);
+	cla_reg_write(dev, CLA_REG_LRESP, 0);
+}
+
 static int cla_dev_setup(unsigned int cpu)
 {
+	int i;
+	int ret;
+	bool broken;
+	unsigned int accid;
 	struct cla_dev *dev;
+	u64 plxctrl_val = 0;
 
 	dev = cla_lut_cpu[cpu];
 	if (!dev)
 		return 0;
 
+	mutex_lock(&dev->lock);
+	broken = dev->broken;
+	mutex_unlock(&dev->lock);
+	if (broken)
+		return 0;
+
 	if (WARN_ON(smp_processor_id() != cpu || dev->cpu != cpu))
 		return -EINVAL;
 
+	/* Clear DATA and LRESP_DATANZ */
+	for (i = 0; i < CLA_NUM_DATA_REGS; i++)
+		cla_reg_write(dev, CLA_REG_DATA(i), 0);
+
+	/*
+	 * Reset all accelerators. We restrict PLxCTRL to the accelerators that
+	 * are attached and well behaved.
+	 */
+	for (accid = 0; accid < CLA_NUM_ACC; accid++) {
+		ret = cla_dev_setup_accel(dev, accid);
+		if (ret > 0)
+			continue;
+		else if (ret < 0)
+			goto err;
+
+		dev->accelerators |= (1 << accid);
+		plxctrl_val |= CLA_PLxCTRL_PREP(accid,
+						FIELD_PREP(CLA_PLxCTRL_AVAIL, 1));
+	}
+
+	if (is_kernel_in_hyp_mode())
+		cla_reg_write(dev, CLA_REG_PL1CTRL, plxctrl_val);
+
+	cla_reg_write(dev, CLA_REG_PL0CTRL, plxctrl_val);
+
+	if (dev->accelerators)
+		cla_info(dev, "available accelerators: 0x%02x\n",
+			 dev->accelerators);
+
 	return 0;
+err:
+	cla_dev_reinit(dev);
+	return ret;
 }
 
 static int cla_dev_teardown(unsigned int cpu)
@@ -43,6 +217,8 @@ static int cla_dev_teardown(unsigned int cpu)
 	if (!dev)
 		return 0;
 
+	cla_dev_reinit(dev);
+
 	return 0;
 }
 
@@ -84,6 +260,8 @@ static struct cla_dev *cla_dev_alloc(struct device *parent, int cpu,
 	dev->cpu = cpu;
 	dev->dev = parent;
 
+	mutex_init(&dev->lock);
+
 	/* Attempt to find device domain, or allocate a new one */
 	dev->domain = cla_dev_domain_get(dev);
 	if (IS_ERR(dev->domain))
diff --git a/drivers/misc/arm-cla/cla-ops.c b/drivers/misc/arm-cla/cla-ops.c
index d594344a2eb4..f9e5570e89c1 100644
--- a/drivers/misc/arm-cla/cla-ops.c
+++ b/drivers/misc/arm-cla/cla-ops.c
@@ -143,6 +143,25 @@ int cla_op_reset(struct cla_dev *dev, unsigned int accid)
 	return ret;
 }
 
+/**
+ * cla_op_reset_all - Reset all attached accelerators
+ * @dev: CLA device.
+ *
+ * Return: 0 on success, or an error
+ */
+int cla_op_reset_all(struct cla_dev *dev)
+{
+	int ret;
+	unsigned int accid;
+
+	cla_for_each_accid(dev, accid) {
+		ret = cla_op_reset(dev, accid);
+		if (ret)
+			return ret < 0 ? ret : -ENODEV;
+	}
+	return 0;
+}
+
 static int cla_op_access_reg(struct cla_dev *dev, u8 op,
 			     enum cla_launch_data_mode data_mode,
 			     unsigned int accid, unsigned int regidx,
-- 
2.43.0

