Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A12DBCA5FB2
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9172E10ED91;
	Tue, 29 Sep 2026 08:23:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=reactivated.net header.i=@reactivated.net header.b="Fghx87X2";
	dkim-atps=neutral
X-Greylist: delayed 84271 seconds by postgrey-1.36 at gabe;
 Mon, 28 Sep 2026 20:17:24 UTC
Received: from out13-173.antispamcloud.com (out13-173.antispamcloud.com
 [185.201.17.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384AF10E339
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 20:17:24 +0000 (UTC)
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
 by mx323.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <dan@reactivated.net>)
 id 1xBHmZ-007KfO-2f; Mon, 28 Sep 2026 22:17:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=reactivated.net; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XCQ+Jqlo/1+DmjMeD+QyS9dHb8G5UE657pxVi4mOYiE=; b=Fghx87X2cqfAHYTK3Jb8k+Ss0j
 bwG2/lbXpoxYsSTUBxRn5xdbHtPuZPd885wzctGcYKz3ct68j8N4EGj7Mvl561H3Fq6GzbTeGtiUu
 abOoqc95az7lOdLsTG4BaODXxRMMW2zV+2+t2vN+i7ERhIZHvHwxGUhzm9dkGX7YJwyVhI53hqpxS
 Xbxj4Tis4HlAyIPbCUSTemRRi6NeNjoiu75KtJiKJ5zxrzBO/WM4GYu33fJE4AZxPVa2ASB8B4CFr
 wSmkQTxHhAfaGFNvcTLjzw//qj6ReUjco4gsl5ra0QOiNvGx+vnC4Im8d5dRvevKKEV8/QNa5HFl8
 1QWrY8FQ==;
Received: from [188.251.249.2] (port=38962 helo=[192.168.1.123])
 by s1041.use1.mysecurecloudhost.com with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dan@reactivated.net>) id 1xBHmT-00000006NMK-1W9M;
 Mon, 28 Sep 2026 20:16:57 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Mon, 28 Sep 2026 21:16:27 +0100
Subject: [PATCH v2] drm/vc4: Set DRM DMA device directly from HVS and V3D
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-drm-dma-device-2-v2-1-8e8b6288cd31@reactivated.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Zh2iFRccQ/DoraDzAIwbdNoS
 O9u5QAu38//7+8QOQhHuDU7BM4SZVsr0KkBN9v1ySi+MpCiTvVk0IcF/WLR17JjJDTuoZSdDKm
 uhzp7BZ7kfSjvY+VZYtrC53jI+pf+kWWNGltqq9B5d73oIbB1SbJN7M8rJxhLKV+GO5+9tgAAA
 A==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5896; i=dan@reactivated.net;
 h=from:subject:message-id; bh=KiWS9rmqlrWbx4H52Mu5IK9wp+kih7ag98lHIYjLONQ=;
 b=owEBbQKS/ZANAwAKAcPmj7FTFEe7AcsmYgBquss2HURnzr50sciRsNToYpadPq7mv1xZbDaET
 +O/T1QFnruJAjMEAAEKAB0WIQQ6Rf0sUP1iEhXfVfjD5o+xUxRHuwUCarrLNgAKCRDD5o+xUxRH
 u0GiD/0RPtBXkr4k4VphvnSrfb4p35MKCy92nRY+fsWRY9YzGlNzSY2TrV/Pz6JfMAVSRWPxTKc
 ZLhgO+ia887X+hOwUI6q1VnEbAONzY4UUCtE8699Tz55leufYqAR/fQD5ZH4sDVWqhUWT/ncflw
 jZDZkFVVnNj3FNzlTYoTGP0CAq/e1Jp66yBx4PFeISvUn04BRq6t4cr3oyxDQKKCncCIwpd+VSt
 ZzpvG7V3MjvSFUaqmrcvASnVZ1Vd4YaKBBzuZVbR/fxL0AgsSrLqLnVO6OpCbJ0LXsiRRxsUUm4
 HgmUSVyG8G8MquCGLXNzPgEGaQgSO8f3yuyixiFnERFOEupw6xoY5bs1IvuQlqqWJShUiWHPQUx
 vtsAue4h5JEWHwAURMAUAB1TJk//7HgwQ3EzjFk8gKA+aVLWshJu6mzsQ1hRxa37OGICFAOsQPj
 SttrnrwuLmByGnYbFAuTkLPVPHgvjgBuYP7S/kiOkH8o3FS/PeVTDZLAFWAaUfDDnA/VAVMs1f9
 ARL1yWZ90sRHzCHHBfRmex8Qd38owJpLfevxZXlo0sr/Q7SnxOSjZWoEkYq7wtsXM4zVUEvrXs0
 YXxEsJsoHhd30pVUpe2/CeNz0brWCc8X2JCLXbWMOjnYdiHsbjgsqZHxFmllF1Jz1TggzYkkfLM
 eZOlHZK28c6uOPg==
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
X-Spampanel-Outgoing-Evidence: SB/global_tokens (3.15595205073e-05)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuUMmaoMuBSiUwtDGP72TL6jd0apT5URAmlP
 Ap1xtw4+Pyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIPuerjYGMhFdj0XRzUIOuasGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCfZW7a9uhvfuE0J/hsBuu+eB7itP8hgjDRserKv4bhb0iZ5sDJvU3vQetKu48NmiFWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyuRGwS4zb
 U2SpbuGn2H9wu1eUhmDyvvkU36kt1G/6UaF01G345XaD9uig/JeVXRFOvN2Zyl1BO2RsqHwINePX
 0v+Bu4/uGdQrw1B0vCxVYoiTq41BYWjic3wJagIFQBlh/6hdMqrVysFrZniWUMHCbXbG5pHi0EDC
 xCu4joth+xIfHUK/o2YKorGG+wjslSExNlc+l3JfrXHsIjFHUvXSqWyy2EIYrTBj84Gn4hZQUC7O
 aWSYTlEGP1UnNT1fbIpcMX2J9HfksJ+XzzsUxQdwG/aW7E6exW/eiSb8KOox1L+p3Y5OHK08p1d3
 9/788m5+t0YLipR+Df7pf/QfK9meWhMyCmWQXzwyKuAo5gIr2X7Ln2JFvTwxw2rUoW840DiKE00o
 4HcXiVlmqq7rjtmnPPvgN0j5Zjdo7lug1QoDSvrYNiHnrwo3MxFvlFv7ce8Spf+GMZJk67EtLxTr
 EHBFDDaVxo8uvMBjbuQvf6VNVyYoAi8Uc2oZx8hUUuy5epJAJTBivmuTWFpVYNhpSn7kRHMcN6qo
 XPjenLhIOF1oeRb/UAjtSdLUCm4oBscLM8knIGNgyBKMPc7zMAqywG0cN7qx7jyvDaJXYkeEPRzA
 leU8fvDJlqs+4uVSxCZaxD168J7ArISHgc1ouiDb0lGY3htzeHnKxaPb82JYf6EvQqPTPpuFqUUQ
 z+mM8JAD4ECWUEmmlTt39YF6tMVf4ZbCsLPTDm9x1wcjenLcvy0+pYBTkP/qV+1a5UVM8nkKOUP3
 tkPn0sdJdb3NZ6ToW7sjD5Nt2di8yRcICxi3Rg/ILhdlE8tcUX6kZr3+Ob4JcQTWeXW8oEyu47TQ
 DqTi6GKwcPGM2dTl3QCYaxBp/L42XX16l+mke5pNa7TIOj7iFBj9MkiPhSHaQZlugDaDyn+fTA7j
 SeBK0owOZo/nKKA2Y8v1MU62oe4qNRYfW7XcddzgZJ0Q4x+0GOxZvoENDONKwfMsKvKUfj3CUGQZ
 VNqeRfoLADSib5OZB5Y+uxAGfYgWMkiPhSHaQZlugDaDyn+fTEvwYiZNmk2q0LoKDU23xXc=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com
X-Mailman-Approved-At: Tue, 29 Sep 2026 08:22:37 +0000
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
Changes in v2:
- Fix vc4_bo_purge() to also use the selected DMA device for freeing
  allocations
- Link to v1: https://lore.kernel.org/r/20260927-drm-dma-device-2-v1-1-3230afcdc851@reactivated.net
---
 drivers/gpu/drm/vc4/vc4_bo.c  |  3 ++-
 drivers/gpu/drm/vc4/vc4_drv.c | 27 ---------------------------
 drivers/gpu/drm/vc4/vc4_hvs.c | 14 ++++++++++++++
 drivers/gpu/drm/vc4/vc4_v3d.c |  8 ++++++++
 4 files changed, 24 insertions(+), 28 deletions(-)

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
index 616caf9d9915..62f1a5731e33 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -273,16 +273,6 @@ static void vc4_component_unbind_all(void *ptr)
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
@@ -295,8 +285,6 @@ static int vc4_drm_bind(struct device *dev)
 	enum vc4_gen gen;
 	int ret = 0;
 
-	dev->coherent_dma_mask = DMA_BIT_MASK(32);
-
 	gen = (enum vc4_gen)of_device_get_match_data(dev);
 
 	if (gen > VC4_GEN_4)
@@ -304,21 +292,6 @@ static int vc4_drm_bind(struct device *dev)
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
index e715147d091c..305770c87dcf 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -22,6 +22,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/dma-mapping.h>
 #include <linux/platform_device.h>
 
 #include <drm/drm_atomic_helper.h>
@@ -1662,6 +1663,19 @@ static int vc4_hvs_bind(struct device *dev, struct device *master, void *data)
 		hvs->regset.nregs = ARRAY_SIZE(vc4_hvs_regs);
 	}
 
+	if (vc4->gen >= VC4_GEN_6_C) {
+		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Use the HVS as the DRM device's DMA controller for buffer
+	 * allocations if one has not already been configured.
+	 */
+	if (drm_dev_dma_dev(drm) == drm->dev)
+		drm_dev_set_dma_dev(drm, dev);
+
 	if (vc4->gen >= VC4_GEN_5) {
 		struct rpi_firmware *firmware;
 		struct device_node *node;
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index f32410420d3e..1f76d4850122 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -10,6 +10,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_drv.h>
 #include <drm/drm_print.h>
 
 #include "vc4_drv.h"
@@ -443,6 +444,13 @@ static int vc4_v3d_bind(struct device *dev, struct device *master, void *data)
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

