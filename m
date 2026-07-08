Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190B3C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D19F10F42F;
	Thu,  9 Jul 2026 07:26:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ky+fqACu";
	dkim-atps=neutral
Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7224E10E61C
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 16:30:46 +0000 (UTC)
Received: by mail-pj2-f0.google.com with SMTP id
 98e67ed59e1d1-380f4166f80so749362a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783528246; x=1784133046; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HZ3tnpLmuxVn6RG46V9wPX6GdF132bX99ersePpQd08=;
 b=ky+fqACuNOzkciRdtmWZ0qGqoM/dpWTNN7NysmSRjQV+3a7NLPY0aa877xUySwRNBM
 jAb9Aj8lkZBlE2UC8THutURSjJZtDsgzRE1RCtpPQ/lDpdvv1RiGO1lOCnifiGdBpZ9s
 xiOWNzjnlYOrt70ao6/YjuNdFN6vdPjE58PRW3s+Z+rzYS030sk1PIuYh44ub9e7A/IX
 BeYjmyjp6cO+o5ucNrha7601USLj8VQGWVkvsCyUjBwlvrNGfGCnHk00zPymcJZQUBYb
 jo2PX0XsoFb/vxg20RQGzzSbyU13wWD8DtDHDM782O4hOOAJf90MJqyuRw8fGUrwwLrm
 RbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783528246; x=1784133046;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HZ3tnpLmuxVn6RG46V9wPX6GdF132bX99ersePpQd08=;
 b=WRb+4G6H++jnm3c+yMIsCAm0hVFbXupxpKQqrVY+yuoWWhKwD/WOcpM7+8fSQI0jCu
 N6MlYi8OVSGXvPA37eoB2wsV8eF3Oq0IVO0OZq14Ku3A1gY5opkt/u3kjccQTjf/4yMa
 wye+6ZoCnHzjD8QpKXWhSK7VSyq9FJojkDGMZKo1zskF2oXroYcd5LHKBfdDhplb/AhB
 G+q09gopPSesHZAIhnK2fXnTvMT6BHzjPViERmPuYao6CgBVrmCwIPtfX98sPJjVFDwX
 QqJmiVud7OUy3TfcI69dWRK6M/PtNICao0G0E2ug793CAVe7YniyIp4d8VepR+VAIVQO
 Lgmw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNXGaRkdPMWU2nhRCboptHTw0JR38E23hBxr9jdZGYWt0pWmufR58Ji8kf5uJYd6/fbjb4ZDWm4tk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yydl0toiNaEqpLAvZgyRUBgSwhTn+Ien5kFChlITs3F7ie+uv34
 AXtQdNfPa0eUr1bV4q46gRPUV8YUps8L/hq2a+w6GqpJZT6BxEtnAdfq
X-Gm-Gg: AfdE7cnPIptaITqVH/GBOfDDn1ZSQ6i46My0Rv8DnXVRY/YVDFfLU4dpyYTWESL9azE
 jwUcJAEsKv4D33KeYlQY3PgYfU/e2O2jpeZ+Uez/JClW2/JBQObNeRJRQUTVZVRYddXusYch+wP
 yF3IO0K33IkB+g/KnGwOobxCUqi2HJ9rPIVW38cW6sWCiaF1AlcKFYAaP/ZA/VHguW3Y8CQC+x+
 x2orwrKLcK5n/s+rp7dRxhgW0e/Kw/yQMxqX//rhyBGYwUNPwsZz9M6aivzrcPSlWKc7Z4czTyQ
 AoInKwMcQYFbxnyv9OzhLJ/nEj6Uk8HknER2Z+8ZwMG8EMu1wM2Wt9BX8SBmG0z12gGzze/xv3h
 30cQKHkHxoonmBc769ZNbaYMCQAtryz55XknLDn8m5S+YuO91MUKHg+MEv65fFb5IIeztDC3hfc
 0sPJZKkyR3EGMSnmZV5wVsYPsj3jFYaZD6acCT0H7IGPM=
X-Received: by 2002:a17:90b:2ccd:b0:381:528a:808a with SMTP id
 98e67ed59e1d1-38941cc5987mr3015296a91.27.1783528245829; 
 Wed, 08 Jul 2026 09:30:45 -0700 (PDT)
Received: from andrel-LOQ.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm12654063eec.14.2026.07.08.09.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:30:45 -0700 (PDT)
From: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>,
 Enzo Furegatti Spinella <enzo.spinella@usp.br>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH V2] drm/amdgpu: deduplicate JPEG v5.0 interrupt routine
Date: Wed,  8 Jul 2026 13:28:50 -0300
Message-ID: <20260708163013.221986-1-andrebueno.mac@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

