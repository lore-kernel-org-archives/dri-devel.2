Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DE4CA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:43:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C980D10E8A9;
	Mon, 28 Sep 2026 08:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=reactivated.net header.i=@reactivated.net header.b="kMIe1YC3";
	dkim-atps=neutral
X-Greylist: delayed 5938 seconds by postgrey-1.36 at gabe;
 Sun, 27 Sep 2026 21:13:00 UTC
Received: from out16-31.antispamcloud.com (out16-31.antispamcloud.com
 [185.201.18.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A19B10E6B2
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 21:13:00 +0000 (UTC)
Received: from s1041.use1.mysecurecloudhost.com ([192.250.231.249])
 by mx321.antispamcloud.com with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.94.2) (envelope-from <dan@reactivated.net>)
 id 1xAud9-006i4J-Br; Sun, 27 Sep 2026 21:33:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=reactivated.net; s=default; h=Cc:To:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eYn3yUQGUXnIYiDWdziiC+KrDZkUHHUq1uCuWFnAodI=; b=kMIe1YC3zf16GpJHHEoe5K07tr
 xaMinBv1gwcpHOKMQkhN4k56bDcGIs1nqIg3L93QY9dMoZpgZlGPYhuhnoP8GXhugL3F0GekUuZMp
 i0XNKpssSTEIMLjVr9w1gkeym1Oap66+IImlP7ymfKfZ1KXKTV1xpd4HanVTksd5xmIWp5CXNpF7j
 ZtAo0RD7Qa4GrpJ9DotQJ6aBFBOxqRE7M4sJT5BQqCQ8W0DQpRyYMvRZn9xifm7D3938DleKn+tpf
 GGV9Vm2Yi0U+0KLcyo5DPDLYb1mSyhHFmUhUJd4oa/+tSJtNrHhSdaGWObAxxEiqxpUydKoEcBgnj
 fDcpfmrw==;
Received: from [188.251.249.2] (port=58472 helo=[192.168.1.123])
 by s1041.use1.mysecurecloudhost.com with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dan@reactivated.net>) id 1xAud3-0000000GfmQ-2TT0;
 Sun, 27 Sep 2026 19:33:41 +0000
From: Daniel Drake <dan@reactivated.net>
Date: Sun, 27 Sep 2026 20:33:01 +0100
Subject: [PATCH] drm/vc4: Set DRM DMA device directly from HVS and V3D
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-drm-dma-device-2-v1-1-3230afcdc851@reactivated.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MuwqAMAwAf6VkNhAztOiviENto2bwQQsilP67x
 fHg7gpkSSoZRlMgyaNZr7NB3xkIuz83QY2NgYktDewwpgPj4TE2OQgyurAQ+dUx2QFadidZ9f2
 X01zrB0ZakfNiAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5087; i=dan@reactivated.net;
 h=from:subject:message-id; bh=xsHe8rDyTpbHhOP6MTP7JPbUKGLGUm5eujXlLIRhsMU=;
 b=owEBbQKS/ZANAwAKAcPmj7FTFEe7AcsmYgBquW+S/luswFlO3g0gETB4ea7gCB8sOyNf6UY8h
 hvEnJt1lkCJAjMEAAEKAB0WIQQ6Rf0sUP1iEhXfVfjD5o+xUxRHuwUCarlvkgAKCRDD5o+xUxRH
 u9EiD/0Z+vPS4fkcJqEDP3owzTvQZxVv72AttdZggD5/6TW5J6Q3FThmTUUH5iqaWjoHivzRnUa
 WE4gs1cDA0T39XSRghYykx2GRxh1QsTTkk7RsibP57ZbMAvLGkab4oJpGKjKgdeMnS+YyleD5PW
 svnF9FuUlamIfG27jzg64H182RysSRCxWPp1U22bfT7Kp3Z9VxpVviAtKZgVyia3nc+A/WB5HiS
 +C60O8YM4HukRWzducWS1RjCtRY6PiST3OQQ9m9WZedGjpZCBambIt2EwlM0QTsKCQ3KZQY3aeM
 zlWukTl+r+mS0UD55zHax2RrdIqvmhACqRI4kYcGrz5U9clqvxeCdZK/Cg2ZLNcWYN1LFtDFCGt
 ZKM2ZIeWzWToAeHY536bbqt4KG0o64uvf8U7rt8fU2YUxXQQAReOvspNTptJ+Enaqn6IoRlzWyh
 8BK7aYzuz+D4MiIFGpEvj864bO75kubDvG3IciZM/RXKvWhjVBGDlVquaYRGV8F4tpnQk3pd/iA
 VeSbBmF7hN3XsrKMaqGsEsDRxEckn3SBmT4fzWhAp2BrI7y2upn1x1mYtxrxLGCZsVm0dMUEYK0
 lkeOPuM5W6dacShIo1YpkEn3LPa35HKMPDWBzkly+skXWPIX1A4Q+BI2Qnj+075/RoGnFLFUaHS
 1l92MXeHiktZuuQ==
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
X-Spampanel-Outgoing-Evidence: SB/global_tokens (1.32201094524e-05)
X-Recommended-Action: accept
X-Filter-ID: 9kzQTOBWQUFZTohSKvQbgI7ZDo5ubYELi59AwcWUnuXaJbTqORSf8QPiiM91bDATa8pwdu0nlUtr
 v9yIzvpSsyu2SmbhJN1U9FKs8X3+Nt06bFpPrNOlRAlE9AVLwR4uGVjKNnzF3nQoDoQtBifM84JL
 M0i5ZAms0EHrvcCaVIPVMT93NoonounRkNyQ2LDLGnT3EFAinyrilm9zau/FuzkQt9Nb4Ml7QXdk
 EetczWCfZW7a9uhvfuE0J/hsBuu+eB7itP8hgjDRserKv4bhb7ubyJcscJCC/8jhyq4eIIJWBb39
 uS1TjWG2Inx+Ts2QrtVmombMJ4e2pn5C0yBMHZ0fE47nEjvubMSTLAkKCKefuLbx+lGq0svfyhth
 j0R6Iny++hg9dJLqN5zmWqF/oHgMZXS6X/fIHYslsKU0yPHM4JpSMI47HiFQBsGlm5AyrUaAnpoZ
 /2xtMtxefNLu7JERMeTgzFM97lqhSb1E3HMfLhaNlCBHzdFUdSuISaD+qfPp90TT+Pu+PDzsy9Db
 OpdwaC8qXZJdLAQDkwdJb5PTjlyEp834Uy5Cj2c5xTC3gJSz3Pb41oMWxWVAbzvbVkuf+eM3l5KP
 nbp/eQthjVO27qEN0i3uPdiiOcxb1W5yo97g3BbiTfWFUNY9PPQFifTCzuiwroezwaLJe7DuyROO
 r+K2JQ/RNOlnkgfwIFDd3XNhc7IqYUIgVggaPkXaIHzSipCF/9owBYArmW2JA+qetIPamnBS2qPX
 0YW4FkjLRw0lRJ7b6p62pxxRod1wrBC/x3Ws3N9QKU7baUkidxrLn2JFvTwxw2rUoW840DiKE00o
 4HcXiVlmqq7rjtmnPPvgN0j5Zjdo7lug1QoDSvrYNiHnrwo3MxFvlFv7ce8Spf+GMZJk67EtLxTr
 EHBFDDaVxo8uvMBjbuQvf6VNVyYoAi8Uc2oZx8hUUuy5epJAJTBivmuTWFpVYNhpSn7kRHMcN6qo
 XPjenLhIOF1oeRb/UAjtSdLUCm4oBscLM8kn2urBX6LyohhIXmM/9zzJ6C1JFZpT4XAXptlUCUDa
 dEg8fvDJlqs+4uVSxCZaxD168J7ArISHgc1ouiDb0lGY3htzeHnKxaPb82JYf6EvQqPTPpuFqUUQ
 z+mM8JAD4ECWUEmmlTt39YF6tMVf4ZbCsLPTDm9x1wcjenLcvy0+pYBTkP/qV+1a5UVM8nkKOUP3
 aKRYvBPrgzKAmkPQnJU9b1J75UPCuRu+8KylPX+NAXplE8tcUX6kZr3+Ob4JcQTWeXW8oEyu47TQ
 DqTi6GKwcPGM2dTl3QCYaxBp/L42XX16l+mke5pNa7TIOj7iFBj9MkiPhSHaQZlugDaDyn+fTA7j
 SeBK0owOZo/nKKA2Y8v1MU62oe4qNRYfW7XcddzgZJ0Q4x+0GOxZvoENDONKwfMsKvKUfj3CUGQZ
 VNqeRfoLADSib5OZB5Y+uxAGfYgWMkiPhSHaQZlugDaDyn+fTEvwYiZNmk2q0LoKDU23xXc=
X-Report-Abuse-To: spam@quarantine16.antispamcloud.com
X-Complaints-To: abuse@master.antispamcloud.com
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:42:42 +0000
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
 drivers/gpu/drm/vc4/vc4_drv.c | 27 ---------------------------
 drivers/gpu/drm/vc4/vc4_hvs.c | 14 ++++++++++++++
 drivers/gpu/drm/vc4/vc4_v3d.c |  8 ++++++++
 3 files changed, 22 insertions(+), 27 deletions(-)

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

