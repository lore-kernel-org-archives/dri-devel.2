Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8468DC982FA
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 08:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D3B910E635;
	Tue, 22 Sep 2026 08:01:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="msE4aRpG";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 561D710E61F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 08:01:38 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e82ea30faso2295065e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 01:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790064097; x=1790668897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YqiXccAHsUrIMDsLkLXR6P0dTgO5nQzYlI6kaXLWWHg=;
 b=msE4aRpGvxA+ZxUBOoCF1CvgHa/IP2yxfmrFiHrAbWXZ6rdc+z48ZYS98Vz69PRnji
 oG3f3JItR3PdkD6u0VvkFUWPC0zwgjQhrM4k43pBezkKWoEoq84klQN2Sr4rav6+mi0X
 cKq8CMq1So0Ya19O+M2BkQr7FooabBaL2bAFFObd5rk4YlXaov8/oO/E4kpAZcD2ipeo
 hHhKJlGqZJ+z/D9WREsocZcsT7kZwhMFYCBpg+miJ2qQE3pAB1EKAlLPDKsihI8XZ+fP
 Fwd4hpJnufbOdANqiaUMh7U0j0ypyGYwfjRdsooH+SDSWXjCF3DYnx8oM0WuJxespoG0
 0Yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790064097; x=1790668897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YqiXccAHsUrIMDsLkLXR6P0dTgO5nQzYlI6kaXLWWHg=;
 b=BUudXgufwGxiSiWLWUaiSqZ2WnSs/MePjRt5xPOBnA9ZQMTSNdHX1u29aPUoz1MzEO
 NLUj3QlgHXNTaKaQTSiGTy99kkweiZeSW4DG4Tixd7q2rQ7OO8Ld6obZUek9S8WiOONk
 t48SfOp0qREQ6YTlbR5tELA1ndWO/fFLlo108VhCxvBK6vTVlgYGM++2x7QMXBNUTnrs
 Kwr/0C1U3ZLODhxWKeGzPM7pR621F+mq6iSWZcEm3PC1Wx2DPL8g4ULIdmUnHDaIBx6P
 JN+PgqmtI9ddrVcgXV7+3p0uv0Ii9t0EJ0qk/DyW6nSmIOMtOe9tNlBIYttdlFQU9hus
 4+RA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwy2TsNCFlzq32W5GN/pSvZD1NfnBXz7VFE2VoQZr2l1Mpz9uKAWGx5Oxf47jXRo1en2mArfRDC0lo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kfB1EwBamUmvNWMlCLk8gWYe1yg/kIiOQ5/RQEvmdiRFJ6/6O2
 NdHwXv133EADzlYO4iIFG6q9/BcwYxJfiac1tfzqYIl6Jfr056v+rDgE
X-Gm-Gg: AYBFou2MmRzwpfrsXZ+nlXfc35ziFW6GJcHuHQzq6GPVt5bur8SEkP9YN0pn/bLGDxn
 KfJhd9H3/wWSJJKYK35spruoytFXRfLSkjHuQxtAfwE6ymqHRF9a6u4GdeFhzosUgT4KjLkGFXX
 W2OTXM4+XBrHh3uOxfA92P2PelTJsDtIWWSQZGWk14JzVAZqXmACo8HqOOlryOxJaHmxv/N13kE
 /j5wHXWDRj+VemUXm/mBkpdmh5qRCtFCfCzddOvrQrEi0IjfsHS1LivgsVXX6Zly/69tpIdvdJO
 bCE4j1Ik7tcNXZPIaNcq34IOfFNVqP8qgdf1poD4PHH3SzA1K0OPR8qERp2dwpG5mqMZsq5VXYm
 yd5scI5/QrPLyFKTj5liVVjEcfqwJlBdrH5ZA5N3l7BzPzdSNOx3nIPoLqRWQxY7Lv5VCJebvvu
 bQY2Z7/Gte+yMdmqGX4gi6n2XjAM/NJroA+Y2WPqTUUPqdZGZwOqJ+HR8LBSofw67h39qzwaLM2
 r+jjaaGqAogNPZpnNF+0PPAKNhBJ4GAu5bPlLJ7aJB/eKuemrO3QmzZVQ4S4dLMnywdxJf/6YKQ
 PQ0=
X-Received: by 2002:a05:600c:3b99:b0:49e:6683:d227 with SMTP id
 5b1f17b1804b1-49fc7bbfe4bmr199180665e9.0.1790064096621; 
 Tue, 22 Sep 2026 01:01:36 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B80530056971C6280202175.dsl.pool.telekom.hu.
 [2001:4c4e:1b80:5300:5697:1c62:8020:2175])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaf97e2sm18248625e9.2.2026.09.22.01.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 01:01:36 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Robert Foss <rfoss@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, Guangshuo Li <lgs201920130244@gmail.com>,
 =?UTF-8?q?H=C3=BCseyin=20BIYIK?= <boogiepop@gmx.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH v2 08/11] accel/rocket: restore the NPU clock boot rate before
 powering the cores down
Date: Tue, 22 Sep 2026 10:01:11 +0200
Message-ID: <20260922080114.44662-9-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922080114.44662-1-royalnet026@gmail.com>
References: <20260922080114.44662-1-royalnet026@gmail.com>
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

The compute clock is generated by a PVTPLL that lives inside the NPU power
island. Powering an island up while that clock is above the rate the
bootloader left it at does not work: the domain never acks the power-on,
and the first register access into it afterwards takes an asynchronous
SError. So the rate has to be back down before the last core goes away.

Nothing in the driver raises the clock today, which makes this a no-op on
its own, but it is the guard that has to be in the tree before anything
does, and the next patches do. The .shutdown hook is the same guard for the
handover: once devfreq is driving the clock, a kexec would otherwise pass
the raised rate to the next kernel, which powers the islands up before it
looks at it. What this cannot do is rescue a rate it did not set - the rate
read at probe is taken as the boot rate whatever it is.

The rate is read at probe rather than hardcoded. Mainline pins the RK3588
cores at 200 MHz with assigned-clock-rates, but that is a devicetree
property, not a property of the hardware, and a SoC whose devicetree does
not set it would be left running at a rate this driver had invented.

All three cores share the clock, so only the last core to suspend may lower
it; the others just drop the count. Lowering it is safe with the islands
already down as long as the boot rate is one the firmware serves from GPLL,
which on the RK3588 is the 200 MHz the devicetree pins: for that rate the
firmware writes only CRU clock selectors, never a register inside the NPU.

Assisted-by: LLM sparse checkpatch
Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
---
v2: v1 of this patch kept a struct clk handle in struct rocket_device,
taken from the devres of the first core to probe, and used it from the
runtime suspend of whichever core went down last. Unbinding the cores
freed the handle underneath it: KASAN reported a slab-use-after-free in
clk_set_rate() during a ten-round unbind/rebind test on this board after
v1 was posted. No handle is kept any more; the callback uses the handle of
the core it runs for, which is bound for as long as the call lasts.
"A reboot" is dropped from the kexec sentence and the comment: whether the
clock selectors survive the global reset the firmware does on reboot has
not been checked. The argument that lowering the rate is safe is now
limited to a boot rate the firmware serves from GPLL, which on the RK3588
is the 200 MHz the devicetree pins.

 drivers/accel/rocket/rocket_core.c   | 10 ++++++
 drivers/accel/rocket/rocket_device.h | 15 +++++++++
 drivers/accel/rocket/rocket_drv.c    | 47 ++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 5dd260bacbff6..c736537cf28f6 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -12,6 +12,7 @@
 #include <linux/reset.h>
 
 #include "rocket_core.h"
+#include "rocket_device.h"
 #include "rocket_job.h"
 
 int rocket_core_init(struct rocket_core *core)
@@ -36,6 +37,15 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
 
+	/*
+	 * Record what the compute clock was running at before anything here
+	 * touched it, on the first core to probe. Reading it rather than
+	 * hardcoding a rate keeps this working on a SoC whose devicetree does
+	 * not pin the clock with assigned-clock-rates.
+	 */
+	if (!core->rdev->npu_boot_rate)
+		core->rdev->npu_boot_rate = clk_get_rate(core->clks[2].clk);
+
 	core->pc_iomem = devm_platform_ioremap_resource_byname(pdev, "pc");
 	if (IS_ERR(core->pc_iomem)) {
 		dev_err(dev, "couldn't find PC registers %ld\n", PTR_ERR(core->pc_iomem));
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index abb88a254e569..ba7c977cd6951 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -22,6 +22,21 @@ struct rocket_device {
 	unsigned int num_cores;
 	/* Slot capacity (DT core count); slots with a NULL .dev are free. */
 	unsigned int max_cores;
+
+	/*
+	 * The cores have no clock of their own: one clock feeds all of them,
+	 * so any core's handle refers to the same thing. No handle is kept
+	 * here: each one belongs to the devres of the core that asked for it
+	 * and dies with that core's unbind, while this structure outlives any
+	 * single core. Whoever needs the clock uses the handle of the core it
+	 * was called for, which is bound for as long as the call lasts.
+	 *
+	 * npu_boot_rate is the rate the clock was left at before the driver
+	 * touched it, and active_cores counts the cores that are runtime
+	 * resumed right now.
+	 */
+	unsigned long npu_boot_rate;
+	atomic_t active_cores;
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index b9b36c578db20..8f03de1af488c 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -297,6 +297,30 @@ static int find_core_for_dev(struct device *dev)
 	return -1;
 }
 
+/*
+ * Put the compute clock back where the bootloader had it. The cores share
+ * this clock, so this is only correct once none of them is running any more.
+ *
+ * Lowering the rate is safe with the power islands down as long as the boot
+ * rate is one the firmware serves from GPLL, which on the RK3588 is the
+ * 200 MHz the devicetree pins: for that rate the firmware touches only the
+ * CRU clock selectors, none of the NPU's own registers.
+ */
+static void rocket_npu_restore_boot_rate(struct rocket_core *core)
+{
+	struct rocket_device *rdev = core->rdev;
+	int err;
+
+	if (!rdev->npu_boot_rate)
+		return;
+
+	err = clk_set_rate(core->clks[2].clk, rdev->npu_boot_rate);
+	if (err)
+		dev_warn(core->dev,
+			 "failed to restore the NPU boot rate of %lu Hz: %d\n",
+			 rdev->npu_boot_rate, err);
+}
+
 static int rocket_device_runtime_resume(struct device *dev)
 {
 	struct rocket_device *rdev = dev_get_drvdata(dev);
@@ -312,6 +336,8 @@ static int rocket_device_runtime_resume(struct device *dev)
 		return err;
 	}
 
+	atomic_inc(&rdev->active_cores);
+
 	return 0;
 }
 
@@ -328,6 +354,9 @@ static int rocket_device_runtime_suspend(struct device *dev)
 
 	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
 
+	if (atomic_dec_and_test(&rdev->active_cores))
+		rocket_npu_restore_boot_rate(&rdev->cores[core]);
+
 	return 0;
 }
 
@@ -336,9 +365,27 @@ EXPORT_GPL_DEV_PM_OPS(rocket_pm_ops) = {
 	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
+/*
+ * A kexec hands the next kernel whatever rate is set here, and that kernel
+ * will power the islands up before it looks at the clock.
+ */
+static void rocket_shutdown(struct platform_device *pdev)
+{
+	struct rocket_device *rdev = dev_get_drvdata(&pdev->dev);
+	int core;
+
+	if (!rdev)
+		return;
+
+	core = find_core_for_dev(&pdev->dev);
+	if (core >= 0)
+		rocket_npu_restore_boot_rate(&rdev->cores[core]);
+}
+
 static struct platform_driver rocket_driver = {
 	.probe = rocket_probe,
 	.remove = rocket_remove,
+	.shutdown = rocket_shutdown,
 	.driver	 = {
 		.name = "rocket",
 		.pm = pm_ptr(&rocket_pm_ops),
-- 
2.43.0

