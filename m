Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C9E9C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 09:42:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6A8510EF1A;
	Wed, 12 Aug 2026 09:42:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="1VBY1rel";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="GivkY+kQ";
	dkim-atps=neutral
Received: from flow-b8-smtp.messagingengine.com
 (flow-b8-smtp.messagingengine.com [202.12.124.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3DB710EF1A
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 09:42:37 +0000 (UTC)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailflow.stl.internal (Postfix) with ESMTP id 99A171300228;
 Wed, 12 Aug 2026 05:42:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 05:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1786527756; x=
 1786531356; bh=mPwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=1
 VBY1rel3Bzytp7cOXfRfTvaqK0NDsWRZhVvU76tRhtMJnnbucxOjqWea/VxBfylT
 CPSKkm3pC02/QGtIogbUom1hjkofP1xzRIM75mFKHmovVyZ307q+OdPWkcyDJi5v
 AZu8gdfxFYdtxsig52ZwUeNDSlbsIv31poYvNPwltHIFH53Ssk6BkUptjiczouq0
 jjfSRgUiDKMfVRpjqfsOvnbuADokCbNEPAJAdrvPuU0zAWxGt4fm/NdmX7JrloUx
 9mPidEOni+M20Qm1So52YMTFJ5MCUvxOxGmYOw8ms85CVZSo2TSWH0od2+9FK3cg
 qzPrNU4eZdK/dGgQvrVgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1786527756; x=1786531356; bh=m
 PwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=GivkY+kQwTzoyFVnY
 Ebt6TNPLZvdjwPSH4tcG7CRKeDxOTxiVDd1WPSK8+btmAN0BAQcJ0LEVCWNJZ8AW
 FeC51CGxcod2rxfAZHhhbjHLmcA5pel4s97J/KW7ugEtFPlpsJhC+I4748hTawwW
 PKm8neVFt2v62+vBlVed6rSDTr6PsLxe6TLEt1YnnAyQGe40rtq3qe6DGWK3/LVi
 IHK1NDUoB/Y7xgmax8dnzWnUXsfCUxQFGoN4bER4lXoSZUJZnUJdeu+1VZ3xEdXX
 agsG8Z8dYLqb7WAVBhabD/D2ay7HH5exdYevX0g9NKpjDcKEargYElL/blt3ifp2
 g1jUQ==
X-ME-Sender: <xms:DEB8aigwWquPxmDdtgu8e5dI62CuTrna9pJJ07YXONzYHV1dpM3Tdw>
 <xme:DEB8aly91Dm0vhIUYWFxNUQduKBguLG0nR5tUbfeTHFdx6V8B3YyYsAl0JdjMLgoL
 57jQzz-ikItjpk5U-KJocxjNM1qtJi6wMusfEFkJL3YNbfuTlhd4n91>
X-ME-Received: <xmr:DEB8am_j4a0iVqwVUbi6Ht0YdxWTml-Y4wyqjasLojDY5WFhmJeNqDP_eNRmKF8IQR6FCRcvig>
X-ME-Proxy-Cause: dmFkZTEPBq1l3vFlyW0vKyyzWbsEa8EjIJrLsZFQa+nnMaKW9vbMVF1o3VXk/fr8PXXfwo
 EHGGBPBVgnGNQ4MZA+j3T+aCPWSOGEzAvjDORzQTfgPB/Ainylhn3owwbGK9va5TERblfI
 pZC1Z9NgyoofcMrcorhTINRDtTJvhbtCpv4Cgf4bCaPcZhnbvMaCed02P82qQB69ERAnMu
 jJ3Xu0AR6n3Rt452d42hgFmHGx5kk8HXgHeV5NQkgbxlDfToVJV8iUy3qTKNY0qUCY3BG/
 aaNQSHMLtlJ9/cSg7vuYjBeElNsZYw8heCP9G/4EgRkJkAPO+nbLXZ1pSvU0kIewZmBOcb
 UC8iEeF5sBBaoBOIiTxbJ/TcV0LTSws8eMY8P/UnZueAoDqKwwIxqCP8l3bPShA7oLvrl9
 oUxkYpGhlsMtKIOk7QPE9EXrIG5v6ac4TB7jRVdY0Op7JKlxCUwPvfEVnIJoM2Big5jZ2M
 i3GBX0taGJEI0vVwTLy9GC927mXXByMZgCePj+1Ka6IU49bN3rkrVnAhpLCrpZX+4SCHwD
 3NXuFIV2SqqNBHSklX+zj0ZuLym5iyhtHbGAU3qTH8LI/iQNAHTIPBUM4eTmkUddOOA9mh
 TYbl3clvq/F6rgp2lYw0p+GRfMWJN8B6Sw+LBMZWwwAIy++/N153nULJBQsA
X-ME-Proxy: <xmx:DEB8aixB1uRNlTLQqyDfJXZXPIPun0ASYiU1j3xsvPn2tuBSsMJl5w>
 <xmx:DEB8anU9xoPtiSQ165F5ppUHr7cNw5-rTH2KCLEGMRWjqQJqGB7Bcg>
 <xmx:DEB8atal51ixQfxkztGjeEaosMzCLO7UQMOrHL1wlz13YqnD_b8p1w>
 <xmx:DEB8akRfyo9wFAOwHBWqqoBSWsJp2ppGIlllF0HJym7Lfa9PrD7TVA>
 <xmx:DEB8atg76lWo9su8ludr16pIPMa1ly4b2GCAL1RHovSI_W5hen-UmsM8>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:42:28 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org, zhangqing@rock-chips.com
Cc: royalnet026@gmail.com, alchark@flipper.net, chaoyi.chen@rock-chips.com,
 diederik@cknow-tech.com, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux.dev,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v7 07/10] accel/rocket: select the per-core clock and reset
 counts from match data
Date: Wed, 12 Aug 2026 21:41:02 +1200
Message-ID: <20260812094106.1391698-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812094106.1391698-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
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
RK3588 keeps four clocks and two resets, so nothing changes for it, and
the arrays keep their present sizes: the SoC that needs a longer one
grows it in the patch that adds the names.

rocket_core_reset() is switched over as well. It is the same array, and
leaving it on ARRAY_SIZE() would walk entries that were never acquired
once a SoC asks for fewer.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c |  8 ++++----
 drivers/accel/rocket/rocket_core.h |  7 +++++++
 drivers/accel/rocket/rocket_drv.c  | 12 +++++++++---
 3 files changed, 20 insertions(+), 7 deletions(-)

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
index 8bbbce594..6e7dc91c5 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -176,6 +176,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = of_device_get_match_data(&pdev->dev);
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -213,8 +214,13 @@ static void rocket_remove(struct platform_device *pdev)
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
@@ -240,7 +246,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -260,7 +266,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

