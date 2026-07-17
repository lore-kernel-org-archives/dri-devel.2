Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48989C44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:15:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FC510E6DC;
	Mon, 20 Jul 2026 07:15:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=permerror (0-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="sA2LY6St";
	dkim=permerror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gCC3gjV+";
	dkim-atps=neutral
X-Greylist: delayed 510 seconds by postgrey-1.36 at gabe;
 Fri, 17 Jul 2026 09:01:04 UTC
Received: from flow-b8-smtp.messagingengine.com
 (flow-b8-smtp.messagingengine.com [202.12.124.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AE110E451
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 09:01:04 +0000 (UTC)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailflow.stl.internal (Postfix) with ESMTP id 2EB5713002D8;
 Fri, 17 Jul 2026 04:54:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 17 Jul 2026 04:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1784278463; x=
 1784282063; bh=seSFgE6LbXWJo7YCW4g2AAwmvQGJEAvcWH4KkhFCsJM=; b=s
 A2LY6StLVISCxwAPHXQfXhUiCfRml/tnFOSnuWFekpdGRECODNqylKed2UDPgpEQ
 R4u7uDgza8Ms/c4m06TJxTQhv6VenVyWeBBiGJ9iD6ZrdcWKi+3nh07Fylb8QakG
 wmz8FthpQTstXFd0h/FsSyUn8S25N6lmqkyV5vsZhPqQn9Bswrt9Y/2x4Xcq7c6p
 Tg5Gf7CqiQVFhDLAvReBTdxWz7EnR+hD0RviocZO2nJJTfX7FJXVm1gxw9qtKMoF
 T4ekSJQEx0mE1TJK2LT1myLeJcNGXF3TSx2B9tGyhj8s/BqUoF0mi/RhoFEk75xW
 oBRoTJ1u+AFfv1R60ohTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm2; t=1784278463; x=1784282063; bh=s
 eSFgE6LbXWJo7YCW4g2AAwmvQGJEAvcWH4KkhFCsJM=; b=gCC3gjV+EdZTBq4bq
 DDafDwV+5Z3DwA4HaL8O9Etuph+yJ4/tEFfphuKZYoYXrLQIVVDyiQ+JAwq01upD
 IcCb0hkTe47tEUIDOo5xxdRAheM4HoMeeYv36/l/6Pc2bbUypWf8hz1vsl8CiTNj
 wSP818hJgF/MFIv1Lji6MnkbtTXzNe983BwI28BLwkeMYsGbUwVng+045QoK5kGc
 RsEiffiLD0B1SWQYn8L/Ei7MeprA0K2Q+cuZDRpDRrfzvZaMOchnABAmNbiW0dbS
 PPAINcY+cOYEY3j+AVOxqPDWZ1exB7iGP9VfZGpcs7Vk7wOM1zON+fZVX/GVMNEi
 PV+YQ==
X-ME-Sender: <xms:vu1Zaq-4CViVdVAO5QfSylJY4jc5W-pxyVuypFHHXmF97tFXAJv5Xw>
 <xme:vu1ZamkraBfanLyKmnhnBOMWgGHOpgdB2No_ZTlm2UccstysCPMOl4W3xVOGUzCsI
 y5YMbXMYMl5oyEdMxc5R03QfwPECKrhfDXjSNl56SpwPPfcoxs9UrI>
X-ME-Received: <xmr:vu1Zari4Oqr2WKeC0vR-sxpI5V9visCVgxwAielS3DREzawnU_mtmX03tiq0BQ3fDImIqYWZdQ1QT7cK6EY>
X-ME-Proxy-Cause: dmFkZTFS7GW/vS+PGg3aNaRtXNWwH13wr4t6a3PsYvzLEfoa0d1tCLQMk4kuPOyqJxWYg8
 zWRgYifu3Q3qEvL/I6D+A7sONbehMF6Fzv0Jx15W8Bp0zPI2L6EoHnTvsn7KCzlmdcjq5Z
 AMiUX8pm/4UU/5q2rly/ctUYuGrpfv6aggolOMe4+7cw+YQgQv04wJ8otXu77hR4cT4fFc
 rauulgYGXJAH/ttinZ2FdpHwYOQghdgc8wZDZhtrydZHcBfVIkqxRabCZivPsjLLb49//R
 HUixI1q1RTZqMytwufV0grN2inkZxcvjyE8RnYSpDV3z9U1hNPWgMeNXqfzcYN3TNROTr7
 GhS8KrsazkGH+zkMmhFLe3IdUu0u3+BEObGJscKE+FletVLXmM3B/fQEURP4CTEW7qnPaE
 yjSppUj3XwD/XHmxEA3F2rZS06Vive3UE8t8mrDi1iTnX1qIGvYraTJNz9Hgo0d5QJJsCq
 997OIktKiWGBO8CyF6vsT4A+xqrByJkBpQ3CTV51agGvPysSXOvVk+XDGi1rNMBS1y2nEH
 PQAV3ZZaEAAKBio9dilm37IvEKROB2cU2YyK9nPacFJS6VC3FLKmPxl49flgDLVkLJVRJn
 dMG0EOfIE2rbZimUmbckSkZcLeRA7uAupals/u0dwJhPkxNHV3uBzEpkvvQw
X-ME-Proxy: <xmx:vu1ZambgCGrRKcqLU9HYY6IIOgDipJH64hAnShF0m2Y6uQzRCaFyYQ>
 <xmx:vu1ZanHo1uw2xaz4U4xCroXoJE1LDwG-XYuxkEp9sOEisft14ZP0-g>
 <xmx:vu1ZarYU3vI8exNxPTfv_2HHV6jkdeqSc27m_p8K0LsV8ESjrJyznQ>
 <xmx:vu1Zag13vOSGpedhDYw5-qAjs5fv5JppAq51RW0ho8h_t-D_eQIjaw>
 <xmx:vu1ZanPL4Q1vl4TXp1fX0FjBPQ7wUM1iB0gV_3waXRqJjBnaFOMcRTav>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 04:54:17 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de,
 ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH 6/9] iommu/rockchip: take all DT clocks
Date: Fri, 17 Jul 2026 20:50:44 +1200
Message-ID: <20260717085220.3212274-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717085220.3212274-1-gahing@gahingwoo.com>
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

rk_iommu only enabled a fixed {aclk,iface} pair. On the RK3576 NPU the
MMU sits behind the CBUF/DSU gates, so writes to DTE_ADDR are silently
dropped until those clocks run too (reads work, writes need more clocks).
Take every clock described in the DT for the IOMMU instead of a fixed
pair, so a platform can list the full set it needs.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/iommu/rockchip-iommu.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index ce586919b..49c841095 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -93,11 +93,6 @@ struct rk_iommu_domain {
 	struct iommu_domain domain;
 };
 
-/* list of clocks required by IOMMU */
-static const char * const rk_iommu_clocks[] = {
-	"aclk", "iface",
-};
-
 struct rk_iommu_ops {
 	phys_addr_t (*pt_address)(u32 dte);
 	u32 (*mk_dtentries)(dma_addr_t pt_dma);
@@ -1274,25 +1269,20 @@ static int rk_iommu_probe(struct platform_device *pdev)
 	iommu->reset_disabled = device_property_read_bool(dev,
 					"rockchip,disable-mmu-reset");
 
-	iommu->num_clocks = ARRAY_SIZE(rk_iommu_clocks);
-	iommu->clocks = devm_kcalloc(iommu->dev, iommu->num_clocks,
-				     sizeof(*iommu->clocks), GFP_KERNEL);
-	if (!iommu->clocks)
-		return -ENOMEM;
-
-	for (i = 0; i < iommu->num_clocks; ++i)
-		iommu->clocks[i].id = rk_iommu_clocks[i];
-
 	/*
-	 * iommu clocks should be present for all new devices and devicetrees
-	 * but there are older devicetrees without clocks out in the wild.
-	 * So clocks as optional for the time being.
+	 * Take every clock the devicetree provides.  Most IOMMU instances
+	 * need exactly "aclk" + "iface", but e.g. the RK3576 NPU IOMMUs sit
+	 * behind additional gates (CBUF/DSU) whose clocks must be running
+	 * for register writes to land.  Clocks stay optional because there
+	 * are older devicetrees without clocks out in the wild.
 	 */
-	err = devm_clk_bulk_get(iommu->dev, iommu->num_clocks, iommu->clocks);
-	if (err == -ENOENT)
+	err = devm_clk_bulk_get_all(iommu->dev, &iommu->clocks);
+	if (err == -ENOENT || err == 0)
 		iommu->num_clocks = 0;
-	else if (err)
+	else if (err < 0)
 		return err;
+	else
+		iommu->num_clocks = err;
 
 	err = clk_bulk_prepare(iommu->num_clocks, iommu->clocks);
 	if (err)
-- 
2.43.0

