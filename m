Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E38C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 10:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C630B10FB6A;
	Tue, 15 Sep 2026 10:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="aOe9tJc/";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZEtvQCXW";
	dkim-atps=neutral
Received: from flow-b6-smtp.messagingengine.com
 (flow-b6-smtp.messagingengine.com [202.12.124.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C485010FB79
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 10:45:51 +0000 (UTC)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailflow.stl.internal (Postfix) with ESMTP id A228E130050E;
 Tue, 15 Sep 2026 06:45:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Tue, 15 Sep 2026 06:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1789469150; x=
 1789476350; bh=eIbu+FRnuIaeFrU8yxIF1UYO5RWNoHkH+v38kjzzSXI=; b=a
 Oe9tJc/KbSPm6LnSS0W12ygsu/gOyiXfDmTbaLCRRPdRXTmbsCm6PD0/UPF+CnLU
 A21GDL+L5wchSKXPquENUGYGvK+qt4wb6pOr/f+W3R1rJuuAg1Ay8JvvRlAinSRb
 DfkluYUaG3AF3zfDLFeVcsQ0ozCom/e4YYbcUowRQmpRXYuini9pSLDqsvKQiSJP
 uXa4xL6vudnALo9WXSldUkMZn78ALH0U+W8J30uuy6SfONq0OgdWYBn7CliDNEBM
 dTqro4+Zas5EsiCAviCUD3lK+fFu/GRribdi3bOOOyNSWuxDQeyhUEKC9+fd7Mip
 kEazL0lM9SoE82n97YYnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1789469150; x=1789476350; bh=e
 Ibu+FRnuIaeFrU8yxIF1UYO5RWNoHkH+v38kjzzSXI=; b=ZEtvQCXWbG1zhneiL
 F6wLta87fZXvyI5HZedfG+4Ml9SoBwWV3u455yXpjoLv+GaN1IdvHXDcmA6g4OIk
 s1TG3D2elRJ7IzPxugBTNHYQL15/naka1eg87nxpSIrxj+oL6Pp6q3rX5s6rPVNX
 jXRk4qHgvVg3c1Nu0mEDIg1URo+TS9G0LN5L4ewrsmO/amS0sawkEupT/B//I4zk
 tA5jCuyWoEiFm3tqL9DVLC7min53CxFUqqeFq869PhuLELlrlm5HuWcbm5Pt9Ya4
 QR6O5fc8rLV/jn7lxz1igAuo56dVeWjrDGF0/6UPBzNVKfBT4YB0ouDPE9dda3RY
 M+hZQ==
X-ME-Sender: <xms:3iGpaqv0GXweuwS5SgiB7QJPFE6r3Bzv1SDX4qDWeXU6dA2IM_4sfw>
 <xme:3iGpavmuim7q-1lUUpRe2LPnSkiSPbed0_LDX-AtZI_GPAvTRFOAeH-gseFGNOfzN
 ewovpn3U0x_q_fnk2E8gA_CBovUZSSm8-IX8QfLPOHrHQggVDVV_Hb_>
X-ME-Received: <xmr:3iGpajmUouBlCtABrC2JkhG3ET-BD9NZYFX6WsleLeQmokEO_uWZcRoHiyCSGCUcoH3IKqXYmg>
X-ME-Proxy-Cause: dmFkZTEvgn30TE/Bhy7j+lDgP7gXmnxf1yEA4+9JDGkkLDKOX+PjWS6C4wfYB6bRewT1h4
 g+oMcdzBaiIBs5c+Pz0dQXZKfUwZnHiQVlJVJDqMWGJD2749OJ0l99nR2edJCf/ZcGPYLu
 30RXGTuoiFK6E8ovSjrRraOKQw1/yZ9qQ/P4z8BMLsmS14llkOiSgUnfVjorc51oae8LTo
 anVnmEPQ5HlX5K1+WHVdnXvbEVz7yNCh4wXVnb5mrixp2KjAAisQetPkg2Ry4FRfbKhSiZ
 90+dZVL2qmx3uYvp96MNB3kt9H9Tf++stO3hlho9KW9Zr3E3C1i+M3opDz8IhDGp0X2eHi
 fM6eIWurbrqHYUdEAqZyIBGPJyjfsgnsEWYhWmUYhRbgy4VD0rHKaB7ZnAGRG+/MsvY6NO
 S+r9ZhbQ1otdM7Ol1ucyRq4VXv0s5TUXXHcQwQsI5mZ02nENOvZVUGsCpN9JpkbB4YYUcz
 RTAAoj143E677ktRlQg9bhB6TcCDFblU5e7CZoYoHac1JjLDQ11yw3XTAT0kil5BJXIK7W
 c8LX/GvSNYmfL2HuNK7ywErbjPKrUj9ERcRxrNU0c42kY7+uWK146/uWIvgekCF19wUmfW
 nJUKhxHkiGVHZ+WfCvBh7vbopaHA74c0qMQ2tn5xpMhJM8LY5k1jKjxd1MdQ
X-ME-Proxy: <xmx:3iGpapeR5VysNVF88vNMcf5rz41adtAQL-wA2GLMdLe87jm7mAMXKw>
 <xmx:3iGpapJV2lFNFwL5XkFLZL6HNt_8xoC39bawmzRE4zb2hUzZfV33kw>
 <xmx:3iGpas6O9TA4ge4biRGOQHPGcz-XeuZ61sr6tMaGYv7mp8lTUR0JQQ>
 <xmx:3iGpagQINaQo98fdGBX6Re-IRynPtXjEqdFAmpcT-xh_8MWFDI4JmQ>
 <xmx:3iGpaoyEJwybJ-owMxxh0ZuEs2xiNvHEkW1MFcO2-wwh2CPjYA_pyUBT>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:45:42 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, abel.vesa@oss.qualcomm.com,
 sebastian.reichel@collabora.com, sidong.yang@furiosa.ai,
 u.kleine-koenig@baylibre.com, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, alchark@flipper.net,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v13 11/14] accel/rocket: select the per-core clock and reset
 counts from match data
Date: Tue, 15 Sep 2026 22:43:25 +1200
Message-ID: <20260915104328.45901-12-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
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

The RK3576 carries the same RKNN block with a different set of clocks and
resets, so the counts cannot stay compile-time constants. Add a soc_data
struct to the of_device_id match data and take the bulk counts from it.
RK3588 keeps four clocks and two resets, so nothing changes for it, and the
arrays keep their present sizes: the SoC that needs a longer one grows it
in the patch that adds the names.

rocket_core_reset() is switched over as well. It is the same array, and
leaving it on ARRAY_SIZE() would walk entries that were never acquired once
a SoC asks for fewer.

soc is checked at the top of rocket_probe(), before anything is allocated
and before the per-core fields are stored. of_device_get_match_data()
returns NULL for a device that bound by name rather than by compatible, and
such a device has no of_node, so it was never counted by the walk of
matching nodes that sizes rdev->cores[]. Storing into that array first and
checking afterwards would be writing past the end under the check's own
premise, and returning from there is the one error path in this function
that would skip the unwind the path below it does.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c |  8 ++++----
 drivers/accel/rocket/rocket_core.h |  7 +++++++
 drivers/accel/rocket/rocket_drv.c  | 26 +++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 5dd260bac..b202d1581 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -23,7 +23,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
-	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
+	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
 						    core->resets);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
@@ -32,7 +32,7 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[1].id = "hclk";
 	core->clks[2].id = "npu";
 	core->clks[3].id = "pclk";
-	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
+	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
 
@@ -109,9 +109,9 @@ void rocket_core_fini(struct rocket_core *core)
 
 void rocket_core_reset(struct rocket_core *core)
 {
-	reset_control_bulk_assert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_bulk_assert(core->soc->num_resets, core->resets);
 
 	udelay(10);
 
-	reset_control_bulk_deassert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_bulk_deassert(core->soc->num_resets, core->resets);
 }
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d738285..ba74c5339 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -27,9 +27,16 @@
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+/* Per-SoC differences, selected by the of_device_id match data. */
+struct rocket_soc_data {
+	unsigned int num_clks;		/* clk_bulk count */
+	unsigned int num_resets;	/* reset_bulk count */
+};
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	const struct rocket_soc_data *soc;
 	unsigned int index;
 
 	int irq;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594..7ed64c131 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -159,8 +159,22 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	const struct rocket_soc_data *soc = of_device_get_match_data(&pdev->dev);
 	int ret;
 
+	/*
+	 * soc is dereferenced without a check by every one of its users, and
+	 * rocket_core_init() below is the first of them. A device that bound
+	 * by name rather than by compatible has no match data, so fail before
+	 * anything is allocated rather than at the first dereference: the
+	 * number of cores comes from a walk of matching DT nodes, and a device
+	 * with no of_node was never counted by it.
+	 */
+	if (!soc) {
+		dev_err(&pdev->dev, "no match data for this device\n");
+		return -ENODEV;
+	}
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -176,6 +190,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = soc;
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -213,8 +228,13 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct rocket_soc_data rk3588_soc_data = {
+	.num_clks = 4,
+	.num_resets = 2,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
@@ -240,7 +260,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -260,7 +280,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

