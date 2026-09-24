Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB007C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 10:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2077210F44F;
	Thu, 24 Sep 2026 10:23:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="C3ZbbAj3";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="osA5MyXx";
	dkim-atps=neutral
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A21E710F44F
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 10:23:54 +0000 (UTC)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 7C50A7A0097;
 Thu, 24 Sep 2026 06:23:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Thu, 24 Sep 2026 06:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1790245433; x=
 1790331833; bh=oK6wxGougQp0SuP8vJAFgL8o20YacB9pFHDqguiERHc=; b=C
 3ZbbAj3aZ6f8Mzl5JZ8qpjfVSGjKVTOsPPJaGZuAG3dCIe/U/p/EAe72Bnb0WnAt
 frzYkc3nqsHyi0Sb7Y/sBEOkEFuK9/WQASoz5vlr4KyPUZQRZmz2cwAfjDx38Gxp
 /Mhk+I9zjRDuWwXR+dkiYIXory/NbZlNPu9hA6GcjraOTOwIrJoC8jSZ+1PgJc2p
 L5DlEmDVoX+f9fJ5Jm6zaUD3O4Ic+beAZltteW3G06ULjRJI7bDQd36JUiuPocGp
 rahEZaFUj1B1/GgijUMLEGWGXcnCAM6GPDO3bx8dEJAVMMG5mwFZipIdz8nQ9x9Y
 f4dSphKpyDZiWJIULUsZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1790245433; x=1790331833; bh=o
 K6wxGougQp0SuP8vJAFgL8o20YacB9pFHDqguiERHc=; b=osA5MyXxb8/0oAD+K
 b8Pb3YPQaGjBdEcD63UV1z/IJjgZvTZlQlHe6+zN0CncMdOBj3Br1wLhOT9blju4
 WcM86Yrwk6WGrmlKxpHZz8lGPTV+Vq4LAY+kCTmDL6w61h5DWZU0wa19tLHSCQvs
 GSsMUgadybZ1u4LA3htAZZEwa5Kq/eo1YhPiSMJ+yJZz1SPCwLfJp58LV2g2gqMz
 C4Fgr5IIs3cvJlsPO2trtOiD0fvBH2zHFVPIkS1L3ASi7Xe01fcZHizIAiEjl5B4
 m5VetJ6rwiOjvdgA5/xkFXKyHsVZs9KHk93kvwLSq6RKoL188alrmMYhoef8QJIq
 FN0RA==
X-ME-Sender: <xms:OPq0asDDPKB9cLmYOFvKUxnEA5QUANLsYd5b6HIaKm04m2P7sgHFdw>
 <xme:OPq0auq4xTRK_nUaFIcS2sGniJmtCS1ztTDinEP3q1sAZepvqa-VPvxjz720sCOtl
 d-zfBYXoqnAj0tnuTN7uFEbHKvVNd9MjjPYE19VTM-ttkRu5qTk6g>
X-ME-Received: <xmr:OPq0atZV4HrovZXm6pYlkguNsX48AH7U7RyteOYJSyHp_vpjrj0VR8fi1iFI7Adugu7oKQcXGQ>
X-ME-Proxy-Cause: dmFkZTGDX9MhO02E6aN+xiCdNxSLlRQcCcCNuvJqlDq/EeMyqx9sOhFfhs0W3+1YUs0VtZ
 C4nEebFI0osOzqEkQHRvG/7wkcbKglvvfYaeqp3aI8yQkFiebpTmTpj4nhIcZkrHx5wdwr
 kRnVCaW8+aKaXLKS/OflxApldP8QfdDM+5W3jozW36QZJgdRxSemzjs9ko+Wb/wLHMQeLb
 eD+rruhjEh6WPODJKZu+5eS2P9OpWF1fvgBuOreOmXgkjB4+pF8qHyniimi1rz9dR9dFf+
 ZQpqbFvZmfrj6mFfFmlpuarA1kw/E5U/tvFDqLyFRTZ7flH2koDx6Na4EwL+XG2w7O70PV
 UpUGVff7yHHiJn1uBsn8vgxkrrij2RQUvXTq2kfr5/GyHJS45MKz8WBDWyIvNPeJP1BwpQ
 3Wiry+DGSl/kZG+YyDC7YhtPOCqGidvZDB+ungg38Yf1K2bRajEN2HVlQJQU0IaZP+tRQx
 kTxKRwdjJuOfrY2B2BV5wr8O/49Gj41hEVpgBO3JJnWu7v2uDIi16vw5idodiqbPhCu9dN
 G7HJYx6k3jzj5iVgyrFreCTewVv/ROek/F8u/Gzzz/ciOito3VMPAkGSdmGskLCyT4hcSq
 czbV1M4QlYrjUu/g1WiyFqQyNSiqoiVUDtyJVwKPRt3ecLFmNcIOaBx/C9ZQ
X-ME-Proxy: <xmx:OPq0anAP4CdghDK_ExFJ8tXc2SYHq1S56sQmQ5SwOUFTSvQzmUWNUw>
 <xmx:OPq0avfgnv2usYLdY_HXEZ0smyvSunQfJR1_9o70pUPxovbPccMLKg>
 <xmx:OPq0as-m_f8f7cesUD00JM00ipqAqto1XQQKCcCMMTyfJskxWwkfNg>
 <xmx:OPq0anEmJA8lATgel08dJnMn308DXJymCbLI2WU1DmVDl4V4lZJYqQ>
 <xmx:Ofq0apeLHCi2ZSG7-DyQtyZrm8O9KeQJMbR8ek1EPrUPglaFHJW-R6KL>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:23:44 -0400 (EDT)
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
Subject: [PATCH v14 10/15] pmdomain: rockchip: cycle an optional power-domain
 reset on power-on
Date: Thu, 24 Sep 2026 22:21:30 +1200
Message-ID: <20260924102135.92217-11-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
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

Some Rockchip domains come out of power-on with their bus interface in an
undefined state. On the RK3576 NPU this shows up as a hang on the first
register access after the domain is switched on, and pulsing the domain's
reset at this point clears it.

Take the domain node's reset if it has one, and pulse it between
releasing idle and restoring QoS. The reset is optional, so domains that
do not list one are unaffected.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 33 +++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 39988efd8..7278c9bbe 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -19,6 +19,7 @@
 #include <linux/of_clk.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/reset.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
@@ -103,6 +104,7 @@ struct rockchip_pm_domain {
 	struct clk_bulk_data *clks;
 	struct device_node *node;
 	struct regulator *supply;
+	struct reset_control *reset;
 };
 
 struct rockchip_pmu {
@@ -688,6 +690,21 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (ret < 0)
 			goto out;
 
+		/*
+		 * Optional: some domains need their reset cycled once power
+		 * is on. This goes BEFORE the settle delay, not after: a
+		 * domain that asks for both is asking to settle before the
+		 * QoS registers answer, and a reset deasserted after the
+		 * delay would leave nothing between it and the QoS writes.
+		 * On RK3576 the reset being cycled is the NPU core's bus
+		 * interface, which is what those writes go through.
+		 */
+		if (pd->reset) {
+			reset_control_assert(pd->reset);
+			usleep_range(10, 20);
+			reset_control_deassert(pd->reset);
+		}
+
 		/* Some domains need to settle before the QoS registers answer. */
 		if (pd->info->delay_us)
 			udelay(pd->info->delay_us);
@@ -861,6 +878,14 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	if (error)
 		goto err_put_clocks;
 
+	pd->reset = of_reset_control_get_optional_exclusive(node, NULL);
+	if (IS_ERR(pd->reset)) {
+		error = dev_err_probe(pmu->dev, PTR_ERR(pd->reset),
+				      "%pOFn: failed to get reset\n", node);
+		pd->reset = NULL;
+		goto err_unprepare_clocks;
+	}
+
 	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
 						 NULL);
 
@@ -931,11 +956,13 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->reset);
 	return error;
 }
 
 static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 {
+	struct reset_control *reset;
 	int ret;
 
 	/*
@@ -950,11 +977,15 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
 
-	/* protect the zeroing of pm->num_clks */
+	/* protect the zeroing of pd->num_clks and pd->reset */
 	mutex_lock(&pd->pmu->mutex);
 	pd->num_clks = 0;
+	reset = pd->reset;
+	pd->reset = NULL;
 	mutex_unlock(&pd->pmu->mutex);
 
+	reset_control_put(reset);
+
 	/* devm will free our memory */
 }
 
-- 
2.43.0

