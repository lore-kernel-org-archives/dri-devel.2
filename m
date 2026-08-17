Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC2CC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D143F10E75F;
	Mon, 17 Aug 2026 11:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="aX45QNQi";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z/twwMHh";
	dkim-atps=neutral
Received: from flow-a6-smtp.messagingengine.com
 (flow-a6-smtp.messagingengine.com [103.168.172.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E957B10E75F
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 11:37:56 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailflow.phl.internal (Postfix) with ESMTP id 61CB7138014E;
 Mon, 17 Aug 2026 07:37:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Mon, 17 Aug 2026 07:37:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1786966676; x=
 1786970276; bh=QqYs61U7N6pw/xXHm7tnvP//SKIcaROwi9b3n48KzQM=; b=a
 X45QNQij4CEsPWwNfU5UK0l2uasH9DLGoKflFQpKpJGUkxtpSk54hLV3LggNBANV
 EQt3HR6gOsOCpCoVkz0R+kRAlNJq+/D0fw8WHocZksna/R05w1sVHn4QJC/7ONYY
 uOPwTpZlTjFSHvU3tI3tPeOhMHExRO/xLyyBCIkSYNDn4uOW1WRTEb52fdLkmhZ6
 xQdgY4+3uxUZeoP71V4DzDDvX7uKJDp/nh5lAbTQOq5IgeL4lDUUjOryoMXj+pCy
 P2k+bj19FABkRroNLc30xtlBKsvn3pKxtjbRKSVpY4ujeBWUDrMUhndvZQvSlAeJ
 9RmCopWg09p3ACxOio/Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786966676; x=1786970276; bh=Q
 qYs61U7N6pw/xXHm7tnvP//SKIcaROwi9b3n48KzQM=; b=Z/twwMHhSP24RZyq9
 U30mdFZzeBDgZ42JtRgoEH58wwI/evvg6D7pjnY3houIXd1YVscYd/pZfQ0mbtZP
 BIycRTjJqKbq5HXe8gHfFdJRYLl1EKWl8UEDwkG/Pl4TTJCITjsxAP9hQujQliLp
 UwvBtHFW4YkZ4BfUX7ewg1W0/13TrqOKokrh+9vmLy//Av0tS4OrBBX3+aJ0PMiJ
 9mUuLgmjNHlyDLtrMjL8aACsb5ZSwqEO9a7jJQoMmBFTKoBSYU/SsKUabihF6h4S
 N+tqnxJhlwG8yu8YXEDxRinwmCtuDfSNkh5c96xqphR9ZRkjpZ77rkAL/mR1bXi8
 VWvtg==
X-ME-Sender: <xms:lPKCauYih2ZwNEh2UFnp1WoRuuAD9Lczt5FJ1wHGmPj49sAAC5hNrA>
 <xme:lPKCakLMNtktAuWN6K2yRDuRrfuzjPGjOE_PDig-BBtnYOfHlu-Nx8PutIMyYcg6-
 K2VkwyO3ksS10nGGLXuroQyNIAc95OsxZRifwmwFROaOrR-IiGTO5X1>
X-ME-Received: <xmr:lPKCal3fDNTMzi_1otFuX4xl2PjxnSmdspyK3dScOFcL8WEV4m86W1WN_pSV6MQBOz_ITog9dg>
X-ME-Proxy-Cause: dmFkZTGRRcyR+YiMd/jhPMK2LDaAfro3KpG8mwTrEv7E4mEzvj2txyhTgD+fs65N7wnV3Q
 ZFpKABbHtBfiqJo9YB7wE3AOwEsjL7LE2t9zeWYgIOh0HEPXvjroEY7A7K7jMG0/0fl+C0
 KAIuWnTHIGX7QPoQIvFOpkUdsk7aJAKlgVSUlz7uXpTFS/+fxkQ3GpODrl8zGo6E0W5p0K
 NGRjvl3JXeHNFC8FiWNqKovpg6wccqDTajbzWGle/st3dM8lvsYVQHbozIEIxOI7pv7PHf
 AunPXT7Drnj66lnY/pCqh2ULPLP5V0CPUcCsOBF4xGb9LUhHT35RonFcrW/np3RNyoXoFV
 6+yoWVEk1tzVAXygyiY9iFAlZCANfIiDy8jGmPtDCosu8WlTvw5y5FmCh/4EZOYAkgGYg1
 77HbxIcVQp2weYEeRq82wl2a39gJ28nG/YyonSepBTuyTPUkP0NHwERZQprdGQiY1yWUr8
 rmFHMR297BEOctdj+7oMxa0/J0yk0sLA4V5fAsz7ZQb303XAe/PlQmgQiTysJ89Qr1Y+oz
 abN2ESz9d8UQD2ZB22zMd7jDXt/1DaNM6O6b16mYAAFqNuGeGfu9MfZkh6Giyj+SU/ncFz
 YSg3QwXTP10J58hkTJbHI0gOLm3Te83lnWRQ4WBcNWspt2lf+dBz4HpjLt4A
X-ME-Proxy: <xmx:lPKCaoJZ42bYx4uRSu7bpJjZv_e2tHs9gnelblHjsld_eqAeqCYQCw>
 <xmx:lPKCahPefqqcok_8xrFJ6GK2dXa2UU4eEZha9Vjf24gTUT3_xT5tBA>
 <xmx:lPKCahz9ect89X0RX38E9EBRBsVyI4T9WzGXDhoyAavLGuO6rIds0Q>
 <xmx:lPKCahJsCvsrTIzO_gTcUblckyh5tIFQCebP9sXWATJQmAFGPuNF6w>
 <xmx:lPKCao5bE6lr-2rBKdgBWH7xaSAzz-10D2LcBqeGIG-2bVMTybsxf2tm>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:37:49 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, chaoyi.chen@rock-chips.com, diederik@cknow-tech.com,
 alchark@flipper.net, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v8 10/12] accel/rocket: add RK3576 NPU (RKNN) support
Date: Mon, 17 Aug 2026 23:36:01 +1200
Message-ID: <20260817113603.1436067-11-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
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

The RK3576 has two cores of the same RKNN block and a few platform
differences:

 - the CBUF (convolution buffer) has its own clock domain, so the core
   needs six clocks rather than four;
 - there is no per-core hclk reset. The CRU has SRST_A_RKNN0 and
   SRST_A_RKNN1 but no SRST_H_RKNN0 or SRST_H_RKNN1, so a core takes one
   reset where RK3588 takes two;
 - the NPU spans two power domains, and a device with more than one is
   skipped by the driver-core single-domain auto-attach, so the list has
   to be attached explicitly;
 - PC_TASK_CON packs the task number with sixteen bits rather than
   twelve, moving the three controls above it up by four.

That last one is the reason this series has been reporting, since v3,
that the block accepts exactly one task per reset. rocket_registers.h is
generated from the RK3588 description, so writing it unchanged to an
RK3576 asks for task_number 0x7001, which is 28673 tasks, and puts
TASK_COUNT_CLEAR on a bit that does nothing. The counter is then only
ever cleared by a reset.

The layout was confirmed by Chaoyi Chen of Rockchip, including a fourth
control at BIT(18), task_last_layer_clear, which belongs on every submit
alongside the count clear:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

With that written correctly a job of several tasks runs to completion,
the completion interrupt arrives, and /proc/interrupts counts up. A
convolution submitted three times with three different inputs is byte
exact against the CPU reference each time, with no reset in between and
with nothing retiring the job but the interrupt.

Counting the cores now walks the driver's own match table instead of a
second, hand-kept list of compatibles. The array sized from that count
is indexed by every core that goes on to probe, so the two lists cannot
be allowed to disagree.

All of it hangs off the soc_data added earlier, so the RK3588 path keeps
its existing counts and behaviour.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c   | 20 +++++++++++++++
 drivers/accel/rocket/rocket_core.h   |  8 +++---
 drivers/accel/rocket/rocket_device.c |  7 ++++-
 drivers/accel/rocket/rocket_drv.c    | 16 +++++++++---
 drivers/accel/rocket/rocket_drv.h    |  2 ++
 drivers/accel/rocket/rocket_job.c    | 38 +++++++++++++++++++++++++---
 6 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b202d1581..91f690176 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -21,6 +22,7 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	/* RK3576 has no per-core hclk reset, so it takes srst_a alone. */
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
 	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
@@ -32,6 +34,9 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[1].id = "hclk";
 	core->clks[2].id = "npu";
 	core->clks[3].id = "pclk";
+	/* RK3576 clocks the CBUF separately; the compute path stalls without these. */
+	core->clks[4].id = "aclk_cbuf";
+	core->clks[5].id = "hclk_cbuf";
 	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
@@ -60,6 +65,21 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return err;
 
+	/*
+	 * RK3576 spans two power domains, and a multi-domain device is skipped
+	 * by the driver-core single-domain auto-attach, so attach the list here.
+	 * This goes before the first thing that would have to be unwound, so a
+	 * failure can simply return.
+	 */
+	if (core->soc->multi_power_domain) {
+		struct dev_pm_domain_list *pd_list;
+
+		err = devm_pm_domain_attach_list(dev, NULL, &pd_list);
+		if (err < 0)
+			return dev_err_probe(dev, err,
+					     "failed to attach NPU power domains\n");
+	}
+
 	core->iommu_group = iommu_group_get(dev);
 
 	err = rocket_job_init(core);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index ba74c5339..8c8d1f453 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -29,8 +29,10 @@
 
 /* Per-SoC differences, selected by the of_device_id match data. */
 struct rocket_soc_data {
-	unsigned int num_clks;		/* clk_bulk count */
-	unsigned int num_resets;	/* reset_bulk count */
+	unsigned int num_clks;		/* clk_bulk count: 4 base, 6 with CBUF */
+	unsigned int num_resets;	/* reset_bulk count: 2 base, 1 on RK3576 */
+	bool multi_power_domain;	/* device spans more than one PM domain */
+	bool task_con_16bit;		/* PC_TASK_CON uses the 16-bit task number */
 };
 
 struct rocket_core {
@@ -43,7 +45,7 @@ struct rocket_core {
 	void __iomem *pc_iomem;
 	void __iomem *cna_iomem;
 	void __iomem *core_iomem;
-	struct clk_bulk_data clks[4];
+	struct clk_bulk_data clks[6];
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1e7..923add5bd 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 
 #include "rocket_device.h"
+#include "rocket_drv.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
 					 const struct drm_driver *rocket_drm_driver)
@@ -27,7 +28,11 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	ddev = &rdev->ddev;
 	dev_set_drvdata(dev, rdev);
 
-	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
+	/*
+	 * Count over the same match table the platform driver binds with, so
+	 * that a core added there is counted here without a second edit.
+	 */
+	for_each_matching_node(core_node, rocket_dt_match)
 		if (of_device_is_available(core_node))
 			num_cores++;
 
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 6e7dc91c5..e46962949 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -217,13 +217,23 @@ static void rocket_remove(struct platform_device *pdev)
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
+	.multi_power_domain = false,
+	.task_con_16bit = false,
 };
 
-static const struct of_device_id dt_match[] = {
+static const struct rocket_soc_data rk3576_soc_data = {
+	.num_clks = 6,
+	.num_resets = 1,
+	.multi_power_domain = true,
+	.task_con_16bit = true,
+};
+
+const struct of_device_id rocket_dt_match[] = {
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
+	{ .compatible = "rockchip,rk3576-rknn-core", .data = &rk3576_soc_data },
 	{}
 };
-MODULE_DEVICE_TABLE(of, dt_match);
+MODULE_DEVICE_TABLE(of, rocket_dt_match);
 
 static int find_core_for_dev(struct device *dev)
 {
@@ -282,7 +292,7 @@ static struct platform_driver rocket_driver = {
 	.driver	 = {
 		.name = "rocket",
 		.pm = pm_ptr(&rocket_pm_ops),
-		.of_match_table = dt_match,
+		.of_match_table = rocket_dt_match,
 	},
 };
 
diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 2c673bb99..0096c4ab1 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -6,10 +6,12 @@
 
 #include <drm/drm_mm.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/mod_devicetable.h>
 
 #include "rocket_device.h"
 
 extern const struct dev_pm_ops rocket_pm_ops;
+extern const struct of_device_id rocket_dt_match[];
 
 struct rocket_iommu_domain {
 	struct iommu_domain *domain;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 0bb11c718..afd7b82fb 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -21,6 +21,29 @@
 
 #define JOB_TIMEOUT_MS 500
 
+/*
+ * PC_TASK_CON packs the task number with three controls, and the field widths
+ * are not the same on every SoC. rocket_registers.h is generated from the
+ * RK3588 description, where the task number is twelve bits:
+ *
+ *   RK3588   BIT[11:0] task_number, BIT[12] pp_en, BIT[13] count_clear
+ *   RK3576   BIT[15:0] task_number, BIT[16] pp_en, BIT[17] count_clear,
+ *            BIT[18] last_layer_clear
+ *
+ * The RK3576 layout was confirmed by Chaoyi Chen of Rockchip:
+ * https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/
+ *
+ * Writing the RK3588 layout to an RK3576 therefore asks for task_number
+ * 0x7001, that is 28673 tasks, and lands the count clear on a bit that does
+ * nothing. The task counter is then only ever cleared by a reset, which is
+ * exactly the "one task per reset" behaviour this series has been reporting
+ * since v3.
+ */
+#define RK3576_PC_TASK_CON_TASK_NUMBER(n)	((n) & 0xffff)
+#define RK3576_PC_TASK_CON_PP_EN		BIT(16)
+#define RK3576_PC_TASK_CON_COUNT_CLEAR		BIT(17)
+#define RK3576_PC_TASK_CON_LAST_LAYER_CLEAR	BIT(18)
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -142,10 +165,17 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_MASK_DPU_1);
 	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_CLEAR_DPU_1);
 
-	rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
-					 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
-					 PC_TASK_CON_TASK_NUMBER(1) |
-					 PC_TASK_CON_TASK_PP_EN(1));
+	if (core->soc->task_con_16bit)
+		rocket_pc_writel(core, TASK_CON,
+				 RK3576_PC_TASK_CON_LAST_LAYER_CLEAR |
+				 RK3576_PC_TASK_CON_COUNT_CLEAR |
+				 RK3576_PC_TASK_CON_PP_EN |
+				 RK3576_PC_TASK_CON_TASK_NUMBER(1));
+	else
+		rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
+						 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
+						 PC_TASK_CON_TASK_NUMBER(1) |
+						 PC_TASK_CON_TASK_PP_EN(1));
 
 	rocket_pc_writel(core, TASK_DMA_BASE_ADDR, PC_TASK_DMA_BASE_ADDR_DMA_BASE_ADDR(0x0));
 
-- 
2.43.0

