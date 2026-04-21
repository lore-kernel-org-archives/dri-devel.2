Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95517F94CDE
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3362110E93A;
	Wed, 22 Apr 2026 08:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ebKmvOgx";
	dkim-atps=neutral
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com
 [209.85.216.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D71E410ED91
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 20:06:11 +0000 (UTC)
Received: by mail-pj1-f68.google.com with SMTP id
 98e67ed59e1d1-35fc258aaa4so2986917a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776801971; x=1777406771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tqUPrapJmfk162jOprC1A32Q+Yo8c7HKbfTLBNJ4ZkA=;
 b=ebKmvOgxSESybvHb/Rg6zf1ablxPpgiqy1wrQbi3NNB08J2UD2axmiUdjRxgNaQ5e3
 wQJkETZrx5hRuSrxVZTxTJD4DjTf2tdhKp96+cw+38QHtah/qGDYAQ/8FtFm/Wvaicvk
 SdPIZFTCuVLJEzWQG99lNyFFuIZMDJMgvKIzyYtsQfzyzrNuvUkFu4QW/sVwrqMIN07n
 0zYAMs/wV24cg9AclzkK5X8LQd4Hvrr8FbxxLKtnyFsx6zuMw5kms1Q7QSuUAgvsBBKe
 VY09YFHSkpODM8tolQuVnBvfmUdUVdX1dKdmhgZqZ/1S6BbpekJnsmtnuH8xNA5O8GBQ
 TOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776801971; x=1777406771;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tqUPrapJmfk162jOprC1A32Q+Yo8c7HKbfTLBNJ4ZkA=;
 b=hHN9ZxIgm1hxp9AqF/SrOjPq5A4rTDSs5QC0m/nVKDEAwooi03t6+eNwJV0JfUtiUF
 tD/naiyFWkt6V1cNr3hl5oqz8M37n0wynSiXhPvlupHCrl0xRfgoejY4tlWY7yioNIWV
 YvXcclYk7JF5gaR1rWTZCo1aKoH7lrYYtiVuM6OfT3Jx39OSQXrcgdry5G6m1uwMA0wk
 iiI5YU6G4/82SXdbQS8rfFRIVt7kuU/Qd4DH1dHsPZ9+SPQUVd4c9NMX1681xAG3SAVU
 wOVdH/rBm30VC/ela/uSKWNL30D2eUZhXv7QWHvl0uRSEw02TpIkUHGFbrmXSoSd2Gm2
 cYAw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8c2U8pYRjnGOWMYecekRb5kCfOy84+Fq2u047YbfkT1aEQbTHDUANSDuQmLJye9yWesmWEUReWqDY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4LQoB1MOTcd3vaFvCWqmmJz7LNx2FWUMHR43AFeX4vGg3b0V7
 m7iy0sXC0T9mmMja4jQiMi4G1LH8VX8uORweCxGH/bivzGtd+6Lu74Ir
X-Gm-Gg: AeBDies/zlVfRzPb3cA06MOPcNl73n1BSenAM+/tSHMgOnwba4GVNG/ngTOHSFDaZ9D
 pjfeUa+3yAtsABshvTCvPHAeXJsE8fm39+2blcAXSOdrr/2KwI0Dq/8v7+BAAwkIRs3ZqVQGw0i
 SwshjA8FeJ+eHSFT329TEWlH9jySoewn0QVgOaZrNVcZSEOm3ezu2GYTw2Gs6/rWhJMWWZQRdnD
 g3yReiQlWvPEd/OB2tZZUIOKnRygM7CAC3U607vz2sAvrF2y88hYuwtiDb6nlP0fyH1HSEdIiNb
 E5iuzcQ36kuYGrG1GioHPbM6f9yMBFSWDkTBUTmPu1sBK8ivnDa69Rb+++zLcd8nAnYVDM9L0z+
 QKp35rg3yzWUYjEO68uTDxbGt7QGx6C1MQYU46JxaBO3W1Ae01m7/n80qA4LISx2x3264FWwoTA
 4pa5jkTjPyrPOb0UODoikHC/InncbXq3Sltu18XeRmVo+ozDfwUYSOjw==
X-Received: by 2002:a17:90b:5106:b0:35a:189b:43db with SMTP id
 98e67ed59e1d1-361403d5c41mr17003533a91.4.1776801971250; 
 Tue, 21 Apr 2026 13:06:11 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a542:324a:19b3:4f10:39f6:f212])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-362bbf963c9sm4606304a91.16.2026.04.21.13.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:06:10 -0700 (PDT)
From: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: enzo.spinella@usp.br, Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: deduplicate JPEG v5.0 interrupt routine
Date: Tue, 21 Apr 2026 17:02:25 -0300
Message-ID: <20260421200236.30927-1-andrebueno.mac@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 Apr 2026 08:26:51 +0000
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
extract this implementation into a shared common function
in new jpeg_v5_0_interrupt.c and .h files.

Signed-off-by: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
Co-developed-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
Signed-off-by: Enzo Furegatti Spinella <enzo.spinella@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  1 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c      | 57 +----------------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c      | 57 +----------------
 .../gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c  | 64 +++++++++++++++++++
 .../gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h  | 12 ++++
 5 files changed, 83 insertions(+), 108 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index db66c6372199..69e5e55e1a2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -229,6 +229,7 @@ amdgpu-y += \
 	jpeg_v5_0_0.o \
 	jpeg_v5_0_1.o \
 	jpeg_v5_0_2.o \
+	jpeg_v5_0_interrupt.o \
 	jpeg_v5_3_0.o
 
 # add VPE block
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index edecbfe66c79..6e5611921eda 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -34,6 +34,8 @@
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 
+#include "jpeg_v5_0_interrupt.h"
+
 static int jpeg_v5_0_1_start_sriov(struct amdgpu_device *adev);
 static void jpeg_v5_0_1_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
@@ -759,60 +761,7 @@ static int jpeg_v5_0_1_process_interrupt(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 struct amdgpu_iv_entry *entry)
 {
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
+	return jpeg_v5_0_process_interrupt_common(adev, entry);
 }
 
 static void jpeg_v5_0_1_core_stall_reset(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index 285c459379c4..daea95907639 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -34,6 +34,8 @@
 #include "vcn/vcn_5_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
 
+#include "jpeg_v5_0_interrupt.h"
+
 static void jpeg_v5_0_2_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v5_0_2_set_irq_funcs(struct amdgpu_device *adev);
 static int jpeg_v5_0_2_set_powergating_state(struct amdgpu_ip_block *ip_block,
@@ -587,60 +589,7 @@ static int jpeg_v5_0_2_process_interrupt(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *source,
 					 struct amdgpu_iv_entry *entry)
 {
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
+	return jpeg_v5_0_process_interrupt_common(adev, entry);
 }
 
 static void jpeg_v5_0_2_core_stall_reset(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c
new file mode 100644
index 000000000000..a76ee6586b63
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+#include "amdgpu.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+#include "jpeg_v5_0_interrupt.h"
+
+int jpeg_v5_0_process_interrupt_common(struct amdgpu_device *adev,
+				       struct amdgpu_iv_entry *entry)
+{
+	u32 i, inst;
+
+	i = node_id_to_phys_map[entry->node_id];
+	DRM_DEV_DEBUG(adev->dev, "IH: JPEG TRAP\n");
+
+	for (inst = 0; inst < adev->jpeg.num_jpeg_inst; ++inst)
+		if (adev->jpeg.inst[inst].aid_id == i)
+			break;
+
+	if (inst >= adev->jpeg.num_jpeg_inst) {
+		dev_WARN_ONCE(adev->dev, 1,
+			      "Interrupt received for unknown JPEG instance %d",
+			      entry->node_id);
+		return 0;
+	}
+
+	switch (entry->src_id) {
+	case VCN_5_0__SRCID__JPEG_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[0]);
+		break;
+	case VCN_5_0__SRCID__JPEG1_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[1]);
+		break;
+	case VCN_5_0__SRCID__JPEG2_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[2]);
+		break;
+	case VCN_5_0__SRCID__JPEG3_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[3]);
+		break;
+	case VCN_5_0__SRCID__JPEG4_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[4]);
+		break;
+	case VCN_5_0__SRCID__JPEG5_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[5]);
+		break;
+	case VCN_5_0__SRCID__JPEG6_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[6]);
+		break;
+	case VCN_5_0__SRCID__JPEG7_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[7]);
+		break;
+	case VCN_5_0__SRCID__JPEG8_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[8]);
+		break;
+	case VCN_5_0__SRCID__JPEG9_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst[inst].ring_dec[9]);
+		break;
+	default:
+		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
+			      entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h
new file mode 100644
index 000000000000..046bcb4a3906
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_interrupt.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef __JPEG_V5_0_INTERRUPT_H__
+#define __JPEG_V5_0_INTERRUPT_H__
+
+struct amdgpu_device;
+struct amdgpu_iv_entry;
+
+int jpeg_v5_0_process_interrupt_common(struct amdgpu_device *adev,
+				       struct amdgpu_iv_entry *entry);
+
+#endif /* __JPEG_V5_0_INTERRUPT_H__ */
-- 
2.43.0

