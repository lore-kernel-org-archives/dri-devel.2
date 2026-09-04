Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD880C61DD6
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B970610F8F4;
	Fri,  4 Sep 2026 13:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MeuenZkQ";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4280810E54F
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 13:09:32 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-4843751b694so153707f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 04 Sep 2026 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788527370; x=1789132170; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Nc493Zxn3lB2uIUk0uEHaMMSyj53T93ezhvvuGgReI=;
 b=MeuenZkQ63zS/J3WtLQS9eqDyyx0OhCg91546FmIX/qokkeeuqoIP6gOZ00EPDFaw1
 vJyr5RS/BWyg2Xk3JGPugpr1t0JXEGg4p1N83McTCYL7BTGzjFiqfNO6HMajtzf2IU/C
 Gnw5R0U4/oADcWFOxNGFG9DR9SYP6yIriR73NJ3e/ziwNUfKAZ6U6otFjyeX7QYHpmdM
 PvDgQm4NvWNKsUDbiWliYqji9UC1Pr/TRunXf14s8U5BxUwYLnFGXMDWcjkPUoL4O9RI
 V9mLwOVw5UjyvQ/PClA10ym5nEnoZQW+Mi+/aUs760K8D0XnSMxAXau1uaOkVgxOezaI
 +nAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527370; x=1789132170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Nc493Zxn3lB2uIUk0uEHaMMSyj53T93ezhvvuGgReI=;
 b=otBZucDjYdBNldMi2Wqxsip7+D2yzOa6q2FkMNqHlaS/3KaWyEjzpTUHOhJ8BajwCb
 QB1XV8wz1uXZq9oTK/bEQGgnc8oO4S4BgY0f27+lzTfG+N3zCzIlt3qgUhY/AICoyWK5
 e8sl831RZ3wJoCvcbpTV6zTNNEZNgmPaC3/NE5uMUwQf8S+YYXkpFshghygVPmxVk2/l
 1PFV7puaq8Z9OKFtJ323CAcWWoeLmQG1rl7QIggFyNAe3R3AFM0U6l/5CJhrJwBxomBM
 LxLy/8x9cYPoUNaktA2o/vUGFFkAjBA+RG2NqTIj8Zm1XSAnYmTkPU/UGgFEeRLqZNaz
 hCHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWXynZ3RzrIZ/afPny84QSIDOeJ4qiHGPzzkSoirDt/1SDGLNrFv1n9m2/sS51T0T1yAYE0QZsK38=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kPLRjDaz39WxSSxVn3dnT5mIuzm4/xLdU1fNiBqaCLcMex6ngR
 zuSc+hH370/p9ZBdmQlg4T+TSI4WZdrJe5UkS1ZEAM+rw/B6rKIJZa5o
X-Gm-Gg: AYBFou0TA6m4owB9e5dWmdThUD9HOaBxnyP6uLbD8S5Ci8LbZePJnapldscmmDPX7pL
 q1SSMqfYy4YS7T5RA1YoWrstD/L/PYgMKO7LrR7jQwmvSIaRMZZcI3iCr0PWFmZS2RnQNMiSC8W
 fE7Y1AdQFIWt1x+DoNRrjz7Hv6c60RpQwG6c0Bz4i3BDKpUv+lh3JZPS9+LGUvBR+Yi+voy2PaV
 2niqjAqNCDvElL2QA/fTY2mfOTYQkVLzQJWPVuXB3Z5HkpcCJutbxwd/5wipqRk8ytsN8oe2A7A
 kpz+1z99G3sFUnlDVI4NQxlWXEI3nfHhtTgIjK/L3Y+StdGApIqu5HJQA1Rc972iWL3mt2BjUlJ
 vSVz4iFZXuWwQmCe44pDqzWkGtN7uVnX1mMyUEyYtSp5rqDxCDfve0BvUnP+/kNu5fyBjkKhfPS
 Xadm7E3ZU2xZkK2Y2xocB2xqoIJ9dGd/ZXuwCJkvc9Re/FPz+pfLcbdldT0rmMUBVyfCiN8jWu7
 sYvs+rXUfxrwvRBnWSzEUpt0dJ9qE0VZfnv2jy2yfg/Id33RT+CfrPovQr3oFeNLWYQ
X-Received: by 2002:a05:600c:1d26:b0:49c:cbf4:572b with SMTP id
 5b1f17b1804b1-49cf8245fe1mr47842485e9.2.1788527370519; 
 Fri, 04 Sep 2026 06:09:30 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME
 (20014C4E1B871500CB6EF488A18F9C42.dsl.pool.telekom.hu.
 [2001:4c4e:1b87:1500:cb6e:f488:a18f:9c42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce554d52esm135575435e9.3.2026.09.04.06.09.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:09:29 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>, Oded Gabbay <ogabbay@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Sidong Yang <sidong.yang@furiosa.ai>,
 Diederik de Haas <diederik@cknow-tech.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jiaxing Hu <gahing@gahingwoo.com>, Nicolas Dufresne <nicolas@ndufresne.ca>,
 Jonas Karlman <jonas@kwiboo.se>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Igor Paunovic <royalnet026@gmail.com>
Subject: [PATCH 4/7] accel/rocket: restore the NPU clock boot rate before
 powering the cores down
Date: Fri,  4 Sep 2026 15:08:55 +0200
Message-ID: <20260904130858.27803-5-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904130858.27803-1-royalnet026@gmail.com>
References: <20260904130858.27803-1-royalnet026@gmail.com>
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
handover: once devfreq is driving the clock, a reboot or a kexec would
otherwise pass the raised rate to the next kernel, which powers the islands
up before it looks at it. What this cannot do is rescue a rate it did not
set - the rate read at probe is taken as the boot rate whatever it is.

The rate is read at probe rather than hardcoded. Mainline pins the RK3588
cores at 200 MHz with assigned-clock-rates, but that is a devicetree
property, not a property of the hardware, and a SoC whose devicetree does
not set it would be left running at a rate this driver had invented.

All three cores share the clock, so only the last core to suspend may lower
it; the others just drop the count. Lowering it is safe with the islands
already down, because the firmware serves the boot rate from GPLL and
writes only CRU clock selectors to get there, never a register inside the
NPU.

Signed-off-by: Igor Paunovic <royalnet026@gmail.com>
Assisted-by: LLM sparse checkpatch
---
 drivers/accel/rocket/rocket_core.c   | 12 +++++++++
 drivers/accel/rocket/rocket_device.h | 10 +++++++
 drivers/accel/rocket/rocket_drv.c    | 40 ++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 5dd260bacbff6..61200e5d5ac0d 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -12,6 +12,7 @@
 #include <linux/reset.h>
 
 #include "rocket_core.h"
+#include "rocket_device.h"
 #include "rocket_job.h"
 
 int rocket_core_init(struct rocket_core *core)
@@ -36,6 +37,17 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
 
+	/*
+	 * Record what the compute clock was running at before anything here
+	 * touched it, on the first core to probe. Reading it rather than
+	 * hardcoding a rate keeps this working on a SoC whose devicetree does
+	 * not pin the clock with assigned-clock-rates.
+	 */
+	if (!core->rdev->npu_clk) {
+		core->rdev->npu_clk = core->clks[2].clk;
+		core->rdev->npu_boot_rate = clk_get_rate(core->rdev->npu_clk);
+	}
+
 	core->pc_iomem = devm_platform_ioremap_resource_byname(pdev, "pc");
 	if (IS_ERR(core->pc_iomem)) {
 		dev_err(dev, "couldn't find PC registers %ld\n", PTR_ERR(core->pc_iomem));
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index c62d567010696..466ebc4c26a8a 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -20,6 +20,16 @@ struct rocket_device {
 	struct rocket_core *cores;
 	unsigned int num_cores;
 	unsigned int max_cores;
+
+	/*
+	 * The cores have no clock of their own: one clock feeds all of them,
+	 * so any core's handle refers to the same thing. npu_boot_rate is the
+	 * rate it was left at before the driver touched it, and active_cores
+	 * counts the cores that are runtime resumed right now.
+	 */
+	struct clk *npu_clk;
+	unsigned long npu_boot_rate;
+	atomic_t active_cores;
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 2bcfe4ab3c68f..b7199de57ccc7 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -231,6 +231,28 @@ static int find_core_for_dev(struct device *dev)
 	return -1;
 }
 
+/*
+ * Put the compute clock back where the bootloader had it. The cores share
+ * this clock, so this is only correct once none of them is running any more.
+ *
+ * Lowering the rate is safe with the power islands down: the firmware serves
+ * the boot rate from GPLL and touches only the CRU clock selectors on the way
+ * there, none of the NPU's own registers.
+ */
+static void rocket_npu_restore_boot_rate(struct rocket_device *rdev)
+{
+	int err;
+
+	if (!rdev->npu_clk)
+		return;
+
+	err = clk_set_rate(rdev->npu_clk, rdev->npu_boot_rate);
+	if (err)
+		dev_warn(rdev->cores[0].dev,
+			 "failed to restore the NPU boot rate of %lu Hz: %d\n",
+			 rdev->npu_boot_rate, err);
+}
+
 static int rocket_device_runtime_resume(struct device *dev)
 {
 	struct rocket_device *rdev = dev_get_drvdata(dev);
@@ -246,6 +268,8 @@ static int rocket_device_runtime_resume(struct device *dev)
 		return err;
 	}
 
+	atomic_inc(&rdev->active_cores);
+
 	return 0;
 }
 
@@ -262,6 +286,9 @@ static int rocket_device_runtime_suspend(struct device *dev)
 
 	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
 
+	if (atomic_dec_and_test(&rdev->active_cores))
+		rocket_npu_restore_boot_rate(rdev);
+
 	return 0;
 }
 
@@ -270,9 +297,22 @@ EXPORT_GPL_DEV_PM_OPS(rocket_pm_ops) = {
 	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
+/*
+ * A kexec or a reboot hands the next kernel whatever rate is set here, and
+ * that kernel will power the islands up before it looks at the clock.
+ */
+static void rocket_shutdown(struct platform_device *pdev)
+{
+	struct rocket_device *rdev = dev_get_drvdata(&pdev->dev);
+
+	if (rdev)
+		rocket_npu_restore_boot_rate(rdev);
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

