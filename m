Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B18606A8B8
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 03:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=BCjYoXHC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=oDAt/bYZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEDF10E6C7;
	Sat, 14 Nov 2026 03:07:33 +0000 (UTC)
Received: from flow-a4-smtp.messagingengine.com
 (flow-a4-smtp.messagingengine.com [103.168.172.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D82C510E647
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 03:07:21 +0000 (UTC)
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
 by mailflow.phl.internal (Postfix) with ESMTP id 428D11381A42
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 22:07:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-07.internal (MEProxy); Fri, 13 Nov 2026 22:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1794625641; x=
 1794632841; bh=ZxUyROuDthVLtFanIfBp0sfv7UFu/s7kRd8U8ZoQom8=; b=B
 CjYoXHC60d7oK4R4g7YqMcyUqG6Dy1AoKYQE6F0y0chzDx1+LDxcGXvkgHLoRWtd
 7d5p6vApXNbn4BPPK4WArEyZ3L+Kmcv994SgZnhI6Z6F4IX7co2N48IrW53YC+ip
 4ozpgeUw+/C3X9pn0t6ggdxlC6Q/wey86HuiOi//ul52Pqx9j8xWu7di0NoBFhBO
 5wSXp3a3F2HyOSFJtLlh6bgtdjLXS6pG4VhKrIu5QDBX6ajtuR+HVSJLGd0OAAUS
 6o77X8A5GDvW0uq0l46XMuaHF3U9ee+DxMMT926O/45bTcZ8u41NVCDKW/Zwuh2h
 sSvLKAZmXQNtMrg3G7rfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1794625641; x=1794632841; bh=Z
 xUyROuDthVLtFanIfBp0sfv7UFu/s7kRd8U8ZoQom8=; b=oDAt/bYZmpRtxNBkX
 rsikVhlCHC0YpYN6JfJHAQbUYYrY0B5yLtr0fwYXRUgxIhJKXrT+uCGwV+OsIdRG
 dhqRE//cBrJeR29Y8qkCgRGhjUMws3V3QR3Vff8oPT7jHqJTQfNGJmG1mZ0GUPgU
 5S7DX0bwZaREhQ3MsuyU4nlxHu1KS71diIHsDI1tm+/yqSDC4s8ZxPBO8gU6kv3v
 cG8SkGViY+EDpVTIOUFLQjqSWCzl+dil8TFrY804TcD4yhRekE6mVv6uoHJbcob8
 mig3efvaEta/CC39oRPP6TBYT9I8bpFBGwAGPx/q3UVrshjb7H0Vd90d2Lvba+OY
 JZyDg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794625641; d=gahingwoo.com;
 mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:TtcaRIs508t9rYYCko1ZO9H1PJbP6Hm59epgzZaKvPXVzgg
 g3hBbfOd51cjAAYIInwiq80SXQ/7cc9wvZ44Wa9FEjJioy+3Nuw5Ft+hddiqhKnq
 OZ7qbS5ersz1qgsl7gyDQnl4fcij/hK91hchb18NP3p4G0DytkaFprMH9kC6QeA9
 EcRxsImtA/WC/hosC7+iAzlodrarn10TygxWDygZ8SfbzHfJX9sR7PXFhwPbAW3H
 t8XHbeB27rKmM7MxRjFPUKnIXw+DQzZ70JdP9nSv42XppoxWmYHcroUT1LmBrgLX
 AXZgOJ84qvjgyRZdkUFgj8hhsJ5fFYfxNksuEEg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:X5ESKhpGyixR+D89Fb0Ja8nTlYtS8VLcsQwSjmxxrXM=:ebLMyHUtp2h/cZGBOQS5t6ujg1UFzw5hcjwxzwQhJYU=;
X-ME-Sender: <xms:aND3ak4iaLvrt7-F119nkCWV4U4gVayzbXvNtJGNPQYIyo7Zz0J7Qw>
 <xme:aND3aiUwoIG6dnhreqaa0CEHFSuKG4aOIPVyTUWbuep1kha5aZg3RuBKt6yQ9KCGD
 qi7KCjt5EV2IYHVZMKHTk_IxzbKSRRSBHtKSm7ZuTEE5zqxLuJKlygm>
X-ME-Received: <xmr:aND3aqsIcJ8eldb4Etughh2F0-BEWpzdKZkDypk5ZeQeYQSl385DDWeYrEdYWG8u0PDMsa8_>
X-ME-Proxy-Cause: dmFkZTGLv1hz09a3Z3EXCwmORUpwC+Cy72ChFuKnGtX6ZU8GGLHgxpuX6WqGXEA/YZrryv
 vv0prpdLfBwpQpLWmeD6AMfy7KlCfIGstcy+mENKkf07iojtVvEya/NHDu3GuWT4c2rhqI
 ZONNY3wWPMjfN9lDAHW9TqItupPiJk+3wyJf0nnsl70tYmnvYemNXYszDru2blGoT8EQgR
 h1/Ss5vi/yXiM3iowxUh2VDtjNJEl9yaMnp9yw432jsGdApevC/sGgaH7cyYWyAVXTJw6p
 6LHSFyjkbDMd9Mymm1VF44oN6b4dfIstLoOUWpNdcumuV3L/vQ1Ryv1ZYSCAHCK+wZoelk
 iMYij8HqJFVdFvx8k/yzupStm23xdFlZBIJmaIwJpUMFeufkNaUnN/Y6ihJE3Wobfo5362
 DP9ip92GHJlA3oHxsh3fz6s8OIUZBC+a4/GAp5GFYfdJgmy0/b7hSf17wiplKi+DGYI2ve
 6UrA145QYBwQgXzX8bGm89lB/ZdAZMPnUvqu9zkMyRtKtQKg/s1RyOl8Q+96cnD4oHRBkh
 R7FAwIyhLW9GAILzcPrdQUqjO6fyA/K4tW1OiTU+OLmfc4mcCFf8e2EUGGvvcFnfQDjF+Q
 kyfRqSKRpw98aojJhZzBVXsrwA4SAZbMvviKHTPGH+Q5MxF86dpPHH54uC4w
X-ME-Proxy: <xmx:aND3avpudo-sP_8_CdJ-WFMQB6aculeBDsg5kLiImq3MZxYHVqN9cw>
 <xmx:aND3aoZBfesLwIxXgoG5aUKXFfDqoYdIkl73pCficBgziTLzNML5jg>
 <xmx:aND3agxBO79eN31h2yX4EynXdU9fU5ynla1X7lMqKeRNe8lrk76FmQ>
 <xmx:aND3au9undxGOqnW8gup2TQpxubP7hN7sZy-y-jDWxM3nMtBv2KZOQ>
 <xmx:adD3avtPqcdm1iifGHlgumTTqOyGdfsaeAWBSfR0rAEav9rnAQl90kk7>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 22:07:12 -0500 (EST)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, p.zabel@pengutronix.de, ogabbay@kernel.org,
 zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, ulf.hansson@oss.qualcomm.com,
 abel.vesa@oss.qualcomm.com, sebastian.reichel@collabora.com,
 sidong.yang@furiosa.ai, u.kleine-koenig@baylibre.com,
 chaoyi.chen@rock-chips.com, shawn.lin@rock-chips.com,
 finley.xiao@rock-chips.com, diederik@cknow-tech.com, alchark@flipper.net,
 leonard@lausen.nl, vlwwwwww@gmail.com, jeff.hugo@oss.qualcomm.com,
 rfoss@kernel.org, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v17 09/12] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sat, 14 Nov 2026 16:05:26 +1300
Message-ID: <57874e7459ed84ad47b2e31a62871ff535da249b.1794615323.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1794615324.git.gahing@gahingwoo.com>
References: <cover.1794615324.git.gahing@gahingwoo.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for the RK3576 NPU. It has two cores; each core needs six
clocks and one reset, with aclk_cbuf and hclk_cbuf on top of what the
RK3588 has.

The task number in PC_TASK_CON is 16 bits wide, not 12. BIT16, BIT17 and
BIT18 are pp_en, count_clear and last_layer_clear. Chaoyi Chen confirmed
this layout on the list:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

The number of NPU cores is taken from the driver's own match table.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>

# Conflicts:
#	drivers/accel/rocket/rocket_core.c
#	drivers/accel/rocket/rocket_core.h
---
 drivers/accel/rocket/rocket_core.c   |  2 ++
 drivers/accel/rocket/rocket_core.h   |  3 +++
 drivers/accel/rocket/rocket_device.c |  3 ++-
 drivers/accel/rocket/rocket_drv.c    | 14 +++++++++++---
 drivers/accel/rocket/rocket_drv.h    |  2 ++
 drivers/accel/rocket/rocket_job.c    | 20 ++++++++++++++++----
 6 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 040272573a72..638061a97bf3 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -32,6 +32,8 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[ROCKET_CLK_HCLK].id = "hclk";
 	core->clks[ROCKET_CLK_NPU].id = "npu";
 	core->clks[ROCKET_CLK_PCLK].id = "pclk";
+	core->clks[ROCKET_CLK_ACLK_CBUF].id = "aclk_cbuf";
+	core->clks[ROCKET_CLK_HCLK_CBUF].id = "hclk_cbuf";
 	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index 05d34e538e36..ef7043046bc6 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -32,12 +32,15 @@ enum rocket_clk {
 	ROCKET_CLK_HCLK,
 	ROCKET_CLK_NPU,
 	ROCKET_CLK_PCLK,
+	ROCKET_CLK_ACLK_CBUF,
+	ROCKET_CLK_HCLK_CBUF,
 	ROCKET_CLK_MAX,
 };
 
 struct rocket_soc_data {
 	unsigned int num_clks;
 	unsigned int num_resets;
+	bool task_con_16bit;
 };
 
 struct rocket_core {
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index db137e2ec15e..868af86d00ce 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -9,6 +9,7 @@
 #include <linux/of.h>
 
 #include "rocket_device.h"
+#include "rocket_drv.h"
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
 					 const struct drm_driver *rocket_drm_driver)
@@ -27,7 +28,7 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 	ddev = &rdev->ddev;
 	dev_set_drvdata(dev, rdev);
 
-	for_each_compatible_node(core_node, NULL, "rockchip,rk3588-rknn-core")
+	for_each_matching_node(core_node, rocket_dt_match)
 		if (of_device_is_available(core_node))
 			num_cores++;
 
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 1030d8407b78..fff31c1ebe52 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -226,13 +226,21 @@ static void rocket_remove(struct platform_device *pdev)
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
+	.task_con_16bit = false,
 };
 
-static const struct of_device_id dt_match[] = {
+static const struct rocket_soc_data rk3576_soc_data = {
+	.num_clks = 6,
+	.num_resets = 1,
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
@@ -291,7 +299,7 @@ static struct platform_driver rocket_driver = {
 	.driver	 = {
 		.name = "rocket",
 		.pm = pm_ptr(&rocket_pm_ops),
-		.of_match_table = dt_match,
+		.of_match_table = rocket_dt_match,
 	},
 };
 
diff --git a/drivers/accel/rocket/rocket_drv.h b/drivers/accel/rocket/rocket_drv.h
index 9421e48ec5d8..eb1e243ff75a 100644
--- a/drivers/accel/rocket/rocket_drv.h
+++ b/drivers/accel/rocket/rocket_drv.h
@@ -6,10 +6,12 @@
 
 #include <drm/drm_mm.h>
 #include <drm/gpu_scheduler.h>
+#include <linux/device-id/of.h>
 
 #include "rocket_device.h"
 
 extern const struct dev_pm_ops rocket_pm_ops;
+extern const struct of_device_id rocket_dt_match[];
 
 struct rocket_iommu_domain {
 	struct iommu_domain *domain;
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 68df1596014e..59a6f548e108 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -31,6 +31,11 @@
 /* Bits 3:0 of PC_BASE_ADDRESS hold the mode selection bit and reserved bits */
 #define ROCKET_REGCMD_ALIGN	16
 
+#define RK3576_PC_TASK_CON_TASK_NUMBER(n)	((n) & 0xffff)
+#define RK3576_PC_TASK_CON_PP_EN		BIT(16)
+#define RK3576_PC_TASK_CON_COUNT_CLEAR		BIT(17)
+#define RK3576_PC_TASK_CON_LAST_LAYER_CLEAR	BIT(18)
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -166,10 +171,17 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
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

