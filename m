Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F8FCD98CC
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE20010EE3E;
	Thu, 11 Jun 2026 10:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TikirlpU";
	dkim-atps=neutral
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com
 [74.125.82.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B76710EC70
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 02:42:51 +0000 (UTC)
Received: by mail-dy1-f193.google.com with SMTP id
 5a478bee46e88-304d7f31215so6727165eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 19:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781145770; x=1781750570; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ3tnpLmuxVn6RG46V9wPX6GdF132bX99ersePpQd08=;
 b=TikirlpUrRJBk4acnsjCNhjjr22bB5P1jeoKItQyBS2FKBq402U7dudxhTiqibxb6+
 Dn4cM2ghKCYnZA+Y/gkN2iy/8jhA01GSs/DLD4o2pTUAenhc9QbVug8gLiAfdpGIp7FS
 lwyr+/TLYgCQ3RE/XH93KontZ2EB00po+kNihIuN/I+JgnxIKx925KMBkp4v3eZqp6Fm
 MztJ9kHsCvx2RRNLFOCu3rdr8Z4zI8LyDjaivOIyX82/KM7UBqI9e4ixslPdimAVIdco
 pSJGh8COHFbv+Gs49n2oTcb45xtqsZWNCAjJlzPtC6hiUrgfqLkWAvdowDLN2Wt5waA9
 geig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781145770; x=1781750570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZ3tnpLmuxVn6RG46V9wPX6GdF132bX99ersePpQd08=;
 b=oEzw+HeXiYZ63YswPCXZ/ahT+eG0MONdEp0q50BRzdQDdX2xZSZuNJvvT45uDt92WP
 epuZu05kZiUwt68kNByOZJbXRhoegrlkV5lFeE2eLDXq6SiTijcctPRwqL4CdW5t7aIB
 M0lXd7hlXNdFuevq8cntDJBP7STuyh/1puwjc90y1V5ElzhxVUlgwxbBiX5jMDN2RHqC
 zY317SPYveDWkOwghbZJuLZDeCVybzQMUtc0ekzeJK4DnWsgJDnsVL1oxY92Vcw+yLNJ
 lDOk70iZtrREnyKH7ENG/ZWSm2F8xULFkaUX5LG2NJcQe4Y2c3y0bHihiPa/8O535hD5
 XEcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yMEPGHLTTpZ1P7+0QDVkg6ZSYJkiSjZfMEMI0URjbdCGsmUzmCUzv4ooJgxhxjNvfgu+f/ZAaVYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTfV0JysmvqgElOlKJmt/PSIh0QHxsZtrpUERaScotJX224xx3
 TdkD1sWDke9Fy/0SVgkHdHMRI6xuXQuiRnMi0yjyz5hoK7K0gPKCowuC
X-Gm-Gg: Acq92OHAWGg+sqzCYz345k9TwbCXMD3yCjVuV7h0nzs0UEH6hDpw6ODQmrbrqKwsYWl
 TawtqHyXjlD07mkxZjMrJbc+RRSP+l6bMyDgw4tXWNA1O36mCy2I0KpIrXvzhYOW3D6xl922EJC
 ExDwHVmVBgJwGDwr0q52xXeEokxoH3QVVEMr1/lW0Xp3LLiDpAleg/yLzyR/vB/m6qQdJBDqmyb
 y6LUKnwDTn+jhU6QNfcDJEiFpcz3UJ7KV2NpmbXlfiKxWV+/fKBtTvPrZwQY5p4OBA3h4P4YjNt
 Uim1KOyR0U4ZKvn0GDnr0V17O7iLLR56mPjHTlE3Gg87vpZLNgUBd4PXeK+Jtnvn+DvT+28TWSS
 SnmDebBMZTo5Zn7kZmHS/wyzqxvFcYtNPy+u4ClPW4rPLl1M5uZVr6iZbVQBJbU5/AHKx1rWt3K
 tLVauBpkdRLjiNZcn74Zwx8LAECf52HDyd9RHTG/r7m9eRrKOqSBmw
X-Received: by 2002:a05:7300:2306:b0:2d9:a799:3c4f with SMTP id
 5a478bee46e88-30804ced98cmr649040eec.24.1781145770308; 
 Wed, 10 Jun 2026 19:42:50 -0700 (PDT)
Received: from andrel-LOQ.. ([2804:1b3:a540:e4c5:8689:633f:71cf:5300])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee1253sm316973eec.27.2026.06.10.19.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 19:42:49 -0700 (PDT)
From: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>,
 Enzo Furegatti Spinella <enzo.spinella@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: deduplicate JPEG v5.0 interrupt routine
Date: Wed, 10 Jun 2026 23:40:52 -0300
Message-ID: <20260611024211.233876-1-andrebueno.mac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADnq5_POUhiOuusWBXgZMLCUhoRutMoH0NaLJgjWqapXd0eRcw@mail.gmail.com>
References: <CADnq5_POUhiOuusWBXgZMLCUhoRutMoH0NaLJgjWqapXd0eRcw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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

Both jpeg_v5_0_1.c and jpeg_v5_0_2.c implement identical
interrupt processing routines. To avoid code duplication,
make the implementation in jpeg_v5_0_1.c non-static and
call it directly from jpeg_v5_0_2.c.

Signed-off-by: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
Co-developed-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
Signed-off-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
---

v2:
 - Dropped the new jpeg_v5_0_interrupt.c/h files and Makefile changes.
 - Kept the interrupt routine in jpeg_v5_0_1.c but removed the 'static' modifier.
 - Declared the function prototype in jpeg_v5_0_1.h and included it in jpeg_v5_0_2.c to call it directly, as suggested by Alex Deucher.

 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h |  8 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 63 ++----------------------
 3 files changed, 12 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index edecbfe66c79..46bcbecd89e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -755,7 +755,7 @@ static int jpeg_v5_0_1_set_ras_interrupt_state(struct amdgpu_device *adev,
 
 
 
-static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
+int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
index a7e58d5fb246..67346faecb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.h
@@ -108,4 +108,12 @@ enum amdgpu_jpeg_v5_0_1_sub_block {
 	AMDGPU_JPEG_V5_0_1_MAX_SUB_BLOCK,
 };
 
+struct amdgpu_irq_src;
+struct amdgpu_iv_entry;
+struct amdgpu_device;
+
+int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					struct amdgpu_iv_entry *entry);
+
 #endif /* __JPEG_V5_0_1_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 285c459379c4..250e7f849037 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -34,6 +34,8 @@
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 
+#include "jpeg_v5_0_1.h"
+
 static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -583,65 +585,6 @@ static int jpeg_v5_0_2_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v5_0_2_process_interrupt(struct amdgpu_device *adev,
-					 struct amdgpu_irq_src *source,
-					 struct amdgpu_iv_entry *entry)
-{
-	u32 i, inst;
-
-	i = node_id_to_phys_map[entry->node_id];
-	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
-
-	for (inst = 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
-		if (adev->jpeg.inst[inst].aid_id == i)
-			break;
-
-	if (inst >= adev->jpeg.num_jpeg_inst) {
-		dev_WARN_ONCE(adev->dev, 1,
-			      "Interrupt received for unknown JPEG instance %d",
-			      entry->node_id);
-		return 0;
-	}
-
-	switch (entry->src_id) {
-	case VCN_5_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
-		break;
-	case VCN_5_0__SRCID__JPEG1_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
-		break;
-	case VCN_5_0__SRCID__JPEG2_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
-		break;
-	case VCN_5_0__SRCID__JPEG3_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
-		break;
-	case VCN_5_0__SRCID__JPEG4_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
-		break;
-	case VCN_5_0__SRCID__JPEG5_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
-		break;
-	case VCN_5_0__SRCID__JPEG6_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
-		break;
-	case VCN_5_0__SRCID__JPEG7_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
-		break;
-	case VCN_5_0__SRCID__JPEG8_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
-		break;
-	case VCN_5_0__SRCID__JPEG9_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
-		break;
-	default:
-		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
-			      entry->src_id, entry->src_data[0]);
-		break;
-	}
-
-	return 0;
-}
 
 static void jpeg_v5_0_2_core_stall_reset(struct amdgpu_ring *ring)
 {
@@ -749,7 +692,7 @@ static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs jpeg_v5_0_2_irq_funcs = {
 	.set = jpeg_v5_0_2_set_interrupt_state,
-	.process = jpeg_v5_0_2_process_interrupt,
+	.process = jpeg_v5_0_1_process_interrupt,
 };
 
 static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev)
-- 
2.43.0

