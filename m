Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E089F99C6A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:32:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B48510EAAC;
	Fri, 17 Apr 2026 21:32:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZSXhhSRR";
	dkim-atps=neutral
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com
 [209.85.208.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0769B10EAA0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 21:32:31 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-38e9653b580so12090421fa.2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776461549; x=1777066349; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4RdytHEJNq2b8qwksSfnD+lzh/+ULx6ZcQWcNHRMd1E=;
 b=ZSXhhSRRa5Y0AucHrEALUHOfexPda/1UYNnXO20gjfLYBfWdNQ+alY4Eo16DRkMQLO
 u4PlY5+ynLbimevxda3HfQmX8ZAgJu4AA+75sbHV5WrKbFsmu5duvp06uhN3hJblMq4/
 Wgi0cnWUgH+u/JQ/2il8h5vTDT4ISoaylQ33Ghz5NNnglPFL/KRp7f/Rzrb5EaNpWr3H
 bUddaTjfGpu5tT3L7qwi/eJRPyneLl9IppBZIP71EBNSyo09dge4hfZYEA5fB9l/Hfiu
 N6Bw1kNulSUJ4WIbP8QcFLvnNztj5aVlEUcqsq6c2WgwigL6S8etZcXhf/3a1xg5rrBw
 JGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776461549; x=1777066349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RdytHEJNq2b8qwksSfnD+lzh/+ULx6ZcQWcNHRMd1E=;
 b=J5yYUmgqXhHLiLRygOxXZkkU9tFFcd5pDacYx5xtl4geg+xSO9dkYczaKCcwAfl1yG
 fJUdIUUzb+0INiWYZB782V6dtxKRUN+N3hJ3ZZXfkYvPrNE9+BffInoEXox0cA+/FZ4i
 N8KsGm/13sjY+W8c/bKq0XsZdL9QqX/+rkkLrvLXpnW5zWRGISvADaU/FWtx1Tus1bLZ
 9tfveF3JPWKuy843j+uombBYIksO2cLatyJHFAF1Luu+9+u8TnLdkT/HFUbxSYK6lMWv
 oRrB97FDretwhsI+c7qySc/q65oQ/eE40gesm1wc2h4AgFGQyTzclG2ujszCGw7ON5yK
 ADwQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+edqOiVnnn0fSF4djO7Z8ulJojmk1Ipk/utdZ5KQkpWxC33cCto1ZTRsGR1Z5/WhnZu1lwigqTNbM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzC0VRKA/WB+u/Rj64oRTMNmXFPzZOOIVm2N+2FSLgh7R2mk+6X
 Q+h2UQJccU29TpN4ta/H71u7ViGoTrkGjSQLqebUYOYHIYZK+ZKYz5o3
X-Gm-Gg: AeBDietbU2LKjPwThsuDCgWnBpbrcMe9/7LlcDxGkJ5vRnzS03eCF1AQhsAH8ImY1wX
 NBOpKCZZNQk++R8zQjmBGLZG1oApOYlAIvK/ZlgyJ7nwgt6ArAhcfoX6jV7182Qiup08rUPqGyK
 FzGoHQ+YuHDFJ0F54XeXD7ayCHtwzkfkpiyVbT1QrVq1rDTGRIbJKMYl1vgPSYgT2zvWDZDMPaP
 MNycgXG58YV7dMz2IgfFgI09fl0LmxPDxFm/BaQLTL+cZe0CEirFruJe0CxpH/ZR8JBUANpCewu
 cRqVMv7mJLZkjeauU3kH8JIMHSTPmpmeZqi5h2KKlm4Hichs3ideZ1CZvmdeCIIgeMdSTE8lEIp
 H0fr46gZvi5gfg7UKSQgNCKOe02RW8+TCz24axSK9nciy5BjY1oNWN5ImrDJaQskvE17D+WDleB
 M4jCAdPyjYnNQ8eS60WFClryZ9Q9ds1I3NGPjbaqG9jpX9+9v6A/IM4nDqLoqOhCwFm8xg28HG2
 gUsXKgPp3ba2FhEOPzd0HKoF7KqOJA4P+h3RSYKkV02vbDECBOlC8SVGIH+8dA17LbCt1ZhCXj3
 H4ak0ay5/Hrm6iOVzSmqYsNsSiUCeA==
X-Received: by 2002:a05:651c:418c:b0:38d:e977:554b with SMTP id
 38308e7fff4ca-38ec7ab5eccmr13449501fa.16.1776461548747; 
 Fri, 17 Apr 2026 14:32:28 -0700 (PDT)
Received: from lilia.home ([46.205.200.78]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38ecb5f6666sm6746911fa.15.2026.04.17.14.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 14:32:27 -0700 (PDT)
From: mjgajda@gmail.com
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 dri-devel@lists.freedesktop.org, "M. Gajda" <mjgajda@gmail.com>
Subject: [PATCH] drm/amdgpu: allow unprivileged read of GC_THROTTLE_STATUS
Date: Fri, 17 Apr 2026 23:32:21 +0200
Message-ID: <20260417213221.937722-1-mjgajda@gmail.com>
X-Mailer: git-send-email 2.53.0
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

From: "M. Gajda" <mjgajda@gmail.com>

GC_THROTTLE_STATUS is a read-only hardware status register present on all
RDNA GPU generations (GFX10/11/12).  It reports the state of the GFX
thermal throttle finite state machine:

  FSM_STATE    [3:0]  non-zero = GPU currently being throttled
  PATTERN_INDEX [9:4]  active throttle duty-cycle pattern

The register is never written by the driver.  No side-effects occur on
read.  Add it to the per-ASIC allowed_read_registers[] tables so that
unprivileged userspace can query it via the AMDGPU_INFO_READ_MMR_REG ioctl
(libdrm: amdgpu_read_mm_registers(3)).

This enables monitoring tools such as radeontop to display GPU thermal
throttle status without root privileges -- information of the same
sensitivity class as GPU temperature, which is already exposed via the
AMDGPU_INFO_SENSOR_GPU_TEMP sensor ioctl.

Register offsets per generation:
  GFX10 (RDNA 1/2): mmGC_THROTTLE_STATUS  0x2032  BASE_IDX 0
  GFX11 (RDNA 3):  regGC_THROTTLE_STATUS  0x1b0a  BASE_IDX 1
  GFX12 (RDNA 4):  regGC_THROTTLE_STATUS  0x1b1c  BASE_IDX 1

Source: drivers/gpu/drm/amd/include/asic_reg/gc/
  gc_10_3_0_{offset,sh_mask}.h, gc_11_0_0_{offset,sh_mask}.h,
  gc_12_0_0_{offset,sh_mask}.h

Public ISA documentation:
  RDNA 1: https://developer.amd.com/wp-content/resources/RDNA_Shader_ISA.pdf
  RDNA 2: https://www.amd.com/content/dam/amd/en/documents/radeon-tech-docs/instruction-set-architectures/rdna2-shader-instruction-set-architecture.pdf
  RDNA 3: https://docs.amd.com/v/u/en-US/rdna3-shader-instruction-set-architecture
  RDNA 4: https://docs.amd.com/v/u/en-US/rdna4-instruction-set-architecture

Signed-off-by: M. Gajda <mjgajda@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c    | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/soc21.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/soc24.c | 6 ++++++
 3 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 7ce1a1b95..80594c793 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -352,6 +352,12 @@ static struct soc15_allowed_register_entry nv_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STALLED_STAT1)},
 	{ SOC15_REG_ENTRY(GC, 0, mmCP_CPC_STATUS)},
 	{ SOC15_REG_ENTRY(GC, 0, mmGB_ADDR_CONFIG)},
+	/*
+	 * GC_THROTTLE_STATUS (offset 0x2032): read-only thermal throttle FSM.
+	 * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
+	 * Defined in gc_10_3_0_offset.h / gc_10_3_0_sh_mask.h
+	 */
+	{ SOC15_REG_ENTRY(GC, 0, mmGC_THROTTLE_STATUS)},
 };
 
 static uint32_t nv_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index fbd1d97f3..8c2472bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -304,6 +304,12 @@ static struct soc15_allowed_register_entry soc21_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
 	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
+	/*
+	 * GC_THROTTLE_STATUS (offset 0x1b0a): read-only thermal throttle FSM.
+	 * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
+	 * Defined in gc_11_0_0_offset.h / gc_11_0_0_sh_mask.h
+	 */
+	{ SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
 };
 
 static uint32_t soc21_read_indexed_register(struct amdgpu_device *adev, u32 se_num,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc24.c b/drivers/gpu/drm/amd/amdgpu/soc24.c
index d1adf19a5..617ee0a4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc24.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc24.c
@@ -130,6 +130,12 @@ static struct soc15_allowed_register_entry soc24_allowed_read_registers[] = {
 	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STALLED_STAT1)},
 	{ SOC15_REG_ENTRY(GC, 0, regCP_CPC_STATUS)},
 	{ SOC15_REG_ENTRY(GC, 0, regGB_ADDR_CONFIG)},
+	/*
+	 * GC_THROTTLE_STATUS (offset 0x1b1c): read-only thermal throttle FSM.
+	 * FSM_STATE [3:0] != 0 indicates the GPU is currently being throttled.
+	 * Defined in gc_12_0_0_offset.h / gc_12_0_0_sh_mask.h
+	 */
+	{ SOC15_REG_ENTRY(GC, 0, regGC_THROTTLE_STATUS)},
 };
 
 static uint32_t soc24_read_indexed_register(struct amdgpu_device *adev,
-- 
2.51.0

