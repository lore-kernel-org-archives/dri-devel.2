Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5513CA5FE6
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 19:36:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6609310E442;
	Sun,  4 Oct 2026 19:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=reactivated.net header.i=@reactivated.net header.b="WHjMaIHr";
	dkim-atps=neutral
Received: from out13-174.antispamcloud.com (out13-174.antispamcloud.com
 [185.201.17.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D45610E1D6
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 18:25:46 +0000 (UTC)
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
 by mx322.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <dan@reactivated.net>)
 id 1xDQtq-006hQt-GW; Sun, 04 Oct 2026 20:25:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=reactivated.net; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yHbOGaVl1vUCtGpoBWGwkPMnujnLEZApFP/YJcaW1LE=; b=WHjMaIHr2XUgJFLt9qDD+mGV5M
 1+D7t8nDdhYA0JkrgvWmX3S2WzgHNRugM8RQxsDxvH4Iimf0UX/u7GBkaAT4YpHik9B4SCQDr4ans
 a/qhoNy+5e8O6Cq526TEG94YCwzxXE/08Ziru6W3fPUxkxEzP2ucAOnYh0edZ4cLOLFX3kB/K9+XX
 FmnCOCzZGkD5qC6QG02lIOnTiUYKMfprPa6y8aIrkyvaN8ThrNYKc2SHHgQguDM1pYOjcUYoguIdb
 1GRupOOkgHeGggG/LGKjRJKpBDe/zA4tET8d/Sm4z34Cy/2bAir0yDUwYdgReUMOqL1IQfcmwyRTE
 Nm+byaiw==;
Received: from [188.251.249.2] (port=51200 helo=[192.168.1.123])
 by s1041.use1.mysecurecloudhost.com with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dan@reactivated.net>) id 1xDQtl-0000000EsQr-0agT;
 Sun, 04 Oct 2026 18:25:21 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Sun, 04 Oct 2026 19:24:45 +0100
Subject: [PATCH v3] drm/vc4: Set DRM DMA device directly from HVS and V3D
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-drm-dma-device-2-v3-1-45b121ab819f@reactivated.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQ6CMAyA4VchO1uzdRGGJ9/DeBhbkR0Asy2Lh
 vDuFk4eiMe/ab8uIlEMlMS1WkSkElKYJw59qoQb7PQkCJ5boMRattiAjyP40YLnZUeA0LhOSts
 3KOtW8NkrUh/eO3l/cA8h5Tl+9g9FbdM/WFGgQKNm0HlnLuoWybocis3kzxNlsZEFfxlzwCAzh
 kxXozHO6wNmXdcvnSDOof0AAAA=
X-Change-ID: 20260927-drm-dma-device-2-7cb00af72069
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Daniel Drake <dan@reactivated.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6110; i=dan@reactivated.net;
 h=from:subject:message-id; bh=OZ3oG6iH09Jix73aeJl43r0w6V/mHd7HgQnVqGacfPw=;
 b=owEBbQKS/ZANAwAKAcPmj7FTFEe7AcsmYgBqwpoN/l376houhEBtKA6NrU5AFgm9Jo8IZz09x
 GeUL3LGxAeJAjMEAAEKAB0WIQQ6Rf0sUP1iEhXfVfjD5o+xUxRHuwUCasKaDQAKCRDD5o+xUxRH
 u3qnEACQXAqoX+3wbtIfNyS658AdfbKjO4iJhhkvRemzE3yapZu8pIll6gmLaftYeShVXOpxSKz
 M6i1yzjVTiGoy8KXBqjzSghujjdBGzQitS3xa088EihzrVho/K6w3shLSEI1yxw11Z8uoRoz2Jx
 AnNwK6XbVlG9JxwB4qZTrRaZHOnqH3E+Pag0pIcoP7Ah4a7WkzYajl5JbKF9XpxvqGWtmLWnYNE
 RWeH2cj5/V8ypitt7etkbsP6n+iAAXWX+ia+hU63s+gfMqpzWFa7izeyYdrGW3Ddbvpe74MhcqQ
 zsd3IaRTclUfXa4rCkswrt2AfY4+zP2fDZ4q0TdNsJsfS6suO8/ryb7LpXtRZnkyyK3/J5rSHiV
 bHLY8+nLA07Xm4/Me73ywj1aRNN5YLIsm984QQ9S9YdEsNBEK8WoiU++zgjN2xd3JCN9wg4/uu6
 1o5jw5HDlYaKOF7icywmBULaKde272Ppqsw9Wu5ROXZLqdOYzvcbYcqo3pQdwCWA3CONFg1Dril
 gx55N9NBkbpLq14XeKAtAQuzGkQDvZXERLgphaLyZMyWMimdmSrqqIeSRIG4NdaqmCCmM0G79f3
 XkBgfUadOY5zDuzWLkG8jiMYQPk1EAp/FEI0987RhtSBb7HkMXXRVkpWg9UUfiPdHoUyR++PPsh
 VALrNan3ONJEvkg==
X-Developer-Key: i=dan@reactivated.net; a=openpgp;
 fpr=3A45FD2C50FD621215DF55F8C3E68FB1531447BB
X-Get-Message-Sender-Via: s1041.use1.mysecurecloudhost.com: authenticated_id:
 dan@reactivated.net
X-Authenticated-Sender: s1041.use1.mysecurecloudhost.com: dan@reactivated.net
X-Originating-IP: 192.250.231.249
X-Spampanel-Domain: s1041.use1.mysecurecloudhost.com
X-Spampanel-Username: 192.250.231.249
Authentication-Results: antispamcloud.com; auth=pass
 smtp.auth=192.250.231.249@s1041.use1.mysecurecloudhost.com
X-Spampanel-Outgoing-Class: ham
X-Spampanel-Outgoing-Evidence: SB/global_tokens (0.000100610566402)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXO7nvTQ7yy9k7Unlg39gKNb1+nkUtl5LJx
 qh/lJIkflyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIOBmjaSCHoTrwQQ0dEVSPCXGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCfZW7a9uhvfuE0J/hsBuu+eB7itP8hgjDRserKv4bhbzM0MOKiGRkxO3FaI58br05WBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyKHa1tRM2
 MU++S1qmG33eyqfQ0CRf03ZVL8nj1p8+jZp97u2myWNKWrutk7qV7AtOkpZtNxry89swgsinGDHL
 Y/93lXcLjZIBgjNjkg38WlOarwwDJTRYznu0602gN4H9hZv0zCLEij/0AqtMgiDne6Vg56B8KEO7
 8ArmTbU4AeRvs08d1ameATIctaL3Sq56xFfxiYEcAIg1a8j1Zik7vLK+lgGfV4Nw4Dyej6XrR3O3
 +9Jv3M1vFh0dedaFWq5OCCuV+S/+kUYBNmmWTS5W8LHjCgCvBtIx9tg0f8t8WKhLn/njN5eSj526
 f3kLYY1TkTsdNKe8xXkJ8GaBwxMdT6Pe4NwW4k31hVDWPTz0BYk1sEdzjJ1KtITTOeCJfzyYE00o
 4HcXiVlmqq7rjtmnPPvgN0j5Zjdo7lug1QoDSvrYNiHnrwo3MxFvlFv7ce8Spf+GMZJk67EtLxTr
 EHBFDDaVxo8uvMBjbuQvf6VNVyYoAi8Uc2oZx8hUUuy5epJAJTBivmuTWFpVYNhpSn7kRHMcN6qo
 XPjenLhIOF1oeRb/UAjtSdLUCm4oBscLM8knFgqzU1XKd5949/0WFIkTx8Iip7Xtxa+Z/gH4HeQf
 wOk8fvDJlqs+4uVSxCZaxD168J7ArISHgc1ouiDb0lGY3htzeHnKxaPb82JYf6EvQqPTPpuFqUUQ
 z+mM8JAD4ECWUEmmlTt39YF6tMVf4ZbCsLPTDm9x1wcjenLcvy0+pYBTkP/qV+1a5UVM8nkKOUP3
 SMSeJeNXixEo1fdA8D3e7XPZw7Q4Udv5oqK+7o66I2dlE8tcUX6kZr3+Ob4JcQTWeXW8oEyu47TQ
 DqTi6GKwcPGM2dTl3QCYaxBp/L42XX16l+mke5pNa7TIOj7iFBj9MkiPhSHaQZlugDaDyn+fTA7j
 SeBK0owOZo/nKKA2Y8v1MU62oe4qNRYfW7XcddzgZJ0Q4x+0GOxZvoENDONKwfMsKvKUfj3CUGQZ
 VNqeRfoLADSib5OZB5Y+uxAGfYgWMkiPhSHaQZlugDaDyn+fTEvwYiZNmk2q0LoKDU23xXc=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com
X-Mailman-Approved-At: Sun, 04 Oct 2026 19:36:32 +0000
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

vc4 uses of_dma_configure() during bind to set the DMA configuration of
the drm device by borrowing the configuration of one of its component
devices.

This violates driver model expectations that IOMMU probing and domain
attachment occur before driver binding - see commit bcb81ac6ae3c ("iommu:
Get DT/ACPI parsing into the proper probe path").

With the introduction of the bcm2712-iommu driver behind the vc4 hvs
device, a warning is triggered:

    vc4-drm gpu: late IOMMU probe at driver bind, something fishy here!

Instead of configuring the virtual aggregate device, adopt the pattern
used by sun4i/sun8i/exynos where candidate DMA-capable hardware components
register themselves as the device to use for DRM allocations via
drm_dev_set_dma_dev(), provided a DMA device has not already been
assigned.

HVS will typically bind first and claim the DMA device. The gen6 36-bit
DMA mask configuration was moved into vc4_hvs_bind() accordingly. For
older generations, vc4's v3d component continues to be available as a
fallback, and the default platform bus 32-bit DMA mask is retained.

Fixes: da8e393e23ef ("drm/vc4: drv: Adopt the dma configuration from the HVS or V3D component")
Signed-off-by: Daniel Drake <dan@reactivated.net>
---
Changes in v3:
- Drop unused includes (of_device.h, dma-mapping.h, drm_drv.h)
- Drop redundant comment on HVS DMA device setup
- Link to v2: https://lore.kernel.org/r/20260928-drm-dma-device-2-v2-1-8e8b6288cd31@reactivated.net

Changes in v2:
- Fix vc4_bo_purge() to also use the selected DMA device for freeing
  allocations
- Link to v1: https://lore.kernel.org/r/20260927-drm-dma-device-2-v1-1-3230afcdc851@reactivated.net
---
 drivers/gpu/drm/vc4/vc4_bo.c  |  3 ++-
 drivers/gpu/drm/vc4/vc4_drv.c | 29 -----------------------------
 drivers/gpu/drm/vc4/vc4_hvs.c | 10 ++++++++++
 drivers/gpu/drm/vc4/vc4_v3d.c |  7 +++++++
 4 files changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 49ea2ed0996b..320c5a0c71ed 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -303,7 +303,8 @@ static void vc4_bo_purge(struct drm_gem_object *obj)
 
 	drm_vma_node_unmap(&obj->vma_node, dev->anon_inode->i_mapping);
 
-	dma_free_wc(dev->dev, obj->size, bo->base.vaddr, bo->base.dma_addr);
+	dma_free_wc(drm_dev_dma_dev(dev), obj->size, bo->base.vaddr,
+		    bo->base.dma_addr);
 	bo->base.vaddr = NULL;
 	bo->madv = __VC4_MADV_PURGED;
 }
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 616caf9d9915..83a9443db98f 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -24,10 +24,8 @@
 #include <linux/clk.h>
 #include <linux/component.h>
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
@@ -273,16 +271,6 @@ static void vc4_component_unbind_all(void *ptr)
 	component_unbind_all(vc4->dev, &vc4->base);
 }
 
-static const struct of_device_id vc4_dma_range_matches[] = {
-	{ .compatible = "brcm,bcm2711-hvs" },
-	{ .compatible = "brcm,bcm2712-hvs" },
-	{ .compatible = "brcm,bcm2835-hvs" },
-	{ .compatible = "brcm,bcm2835-v3d" },
-	{ .compatible = "brcm,cygnus-v3d" },
-	{ .compatible = "brcm,vc4-v3d" },
-	{}
-};
-
 static int vc4_drm_bind(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -295,8 +283,6 @@ static int vc4_drm_bind(struct device *dev)
 	enum vc4_gen gen;
 	int ret = 0;
 
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
 	gen = (enum vc4_gen)of_device_get_match_data(dev);
 
 	if (gen > VC4_GEN_4)
@@ -304,21 +290,6 @@ static int vc4_drm_bind(struct device *dev)
 	else
 		driver = &vc4_drm_driver;
 
-	if (gen >= VC4_GEN_6_C)
-		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
-	else
-		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
-
-	node = of_find_matching_node_and_match(NULL, vc4_dma_range_matches,
-					       NULL);
-	if (node) {
-		ret = of_dma_configure(dev, node, true);
-		of_node_put(node);
-
-		if (ret)
-			return ret;
-	}
-
 	vc4 = devm_drm_dev_alloc(dev, driver, struct vc4_dev, base);
 	if (IS_ERR(vc4))
 		return PTR_ERR(vc4);
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index e715147d091c..b1fb096858cc 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -22,6 +22,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -1662,6 +1663,15 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 		hvs->regset.nregs = ARRAY_SIZE(vc4_hvs_regs);
 	}
 
+	if (vc4->gen >= VC4_GEN_6_C) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+		if (ret)
+			return ret;
+	}
+
+	if (drm_dev_dma_dev(drm) == drm->dev)
+		drm_dev_set_dma_dev(drm, dev);
+
 	if (vc4->gen >= VC4_GEN_5) {
 		struct rpi_firmware *firmware;
 		struct device_node *node;
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index f32410420d3e..345766ef353c 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -443,6 +443,13 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
 	vc4->v3d = v3d;
 	v3d->vc4 = vc4;
 
+	/*
+	 * In headless setups where HVS is absent, use V3D as the fallback
+	 * DMA controller for buffer allocations.
+	 */
+	if (drm_dev_dma_dev(drm) == drm->dev)
+		drm_dev_set_dma_dev(drm, dev);
+
 	v3d->clk = devm_clk_get_optional(dev, NULL);
 	if (IS_ERR(v3d->clk))
 		return dev_err_probe(dev, PTR_ERR(v3d->clk), "Failed to get V3D clock\n");

---
base-commit: 16130ac7861fbbaef5564463a9f6be230e00fb24
change-id: 20260927-drm-dma-device-2-7cb00af72069

Best regards,
-- 
Daniel Drake <dan@reactivated.net>

