Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D02F99C6C
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 21:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1EC610EAAA;
	Fri, 17 Apr 2026 21:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bf3+Wn14";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B020510E07E
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 19:48:51 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5a10d130b37so1013689e87.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776455330; x=1777060130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4RdytHEJNq2b8qwksSfnD+lzh/+ULx6ZcQWcNHRMd1E=;
 b=bf3+Wn14ZOhAVaoIqO3vuCzYaC5SciybXNKi6q3J6yHRJSSwG19WbB6n+wu66KzqQH
 MobfZS4paGkegxnliVcHUVFdmAI9fqRVqRO0vUJGZQfcdHVaULP0/2Fm5O7szpGad86H
 jKYSIBl8Zc4AimrI8q0K4UpPESBUtJD++0vjaOQfB5RENGDXvh2CZBa5GQevlQwRoG0z
 fbZv9M5F4+OM9wIHFxW8jHi8yDrpmqHzExRVxYhaDfwlYQg3hPZVOnEoQW5kQEGyDvPk
 ufcRvZ/9PG7ZWIb38SBoD8PVyRGcXxSr+65h+4NPL6rns+1JLnAkotBE2foStj6bq9fJ
 CHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776455330; x=1777060130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4RdytHEJNq2b8qwksSfnD+lzh/+ULx6ZcQWcNHRMd1E=;
 b=BMeVlljeILZJFkeD49OpGWm5IjoD7J847o0gpftJLlhvT6dUAHIIdYLddXRPWueyKt
 qF2C47AAayagCQ+KpoYE+XMrF+lbwaO/Lf7J0Lua58IywtSZTwS+Zsx8qLEOud3aObbp
 +F96DnoIbxAqRUJoITGyLwm6Kvs7eHoJLubXDhK3mdUYUgFnjp9q1vV3EOD1B1T2fmIW
 a/t3A+9rRGsDUS3DqqCvo3ZYqyWaprR3oNNxhZ4y1+p9QWvqlnO/IGQtnrVPzQCRFau2
 L4yXpEup4muY4cr7g+WWE0L1ujOaxDrBiVoedg3+dyn1NlQFlSCr9mAWEaFj5zgEgA5m
 DD7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9DbagCebzj27bJ9ysoMw//NTehhWDOhuSWq8MLgucicZokbFPqrbs63feuLXJDeTaMm/EhPIQ3iSU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjY6z9wI5DiXIdLH7I2IyrUxjgcweqyKORMvNkWVBf8lkgof13
 tmSCgXCn7zV3smo+vXimSmZm9yoTnxtyVyEQG+hnzdXLguLxueRTPYhS
X-Gm-Gg: AeBDiev1fyzOa7eN8RyhrQql8gd6nz2mKy4SkcLyjXZ0t1dHDSensVE/5A2i+oIqR61
 N/V9iKE71P5S8eI4XpBOnpwpCYw5qqOOEQVM7Ujn4VlaamhzSlcW8fN0zliKgdijuY80pvexCTx
 Z0OFZaDNyUKTCtJ0e0Hcu9mUG67vnCrj4eWp1Nde795wMyOsblw1NOgcEuB3Wx9EPkkrXnbWPcX
 gZQwM8xa5RJs/ag7DHVmyW5BmBUmtDxFXE23ihD/0VLg5pNsE+yyvQ60uTeZOBpji0QZwEuqjbs
 N9LFWNiA686FzpKsmDK/wMDaXXtvCQtNUdcUuz3jTnczQx/vTH0+oaYyGmpNvN2IiPZDbhEdx9u
 rgicNhuAkTwCjB65YCqc6E9aP2dp9Jg4DcG3DocCMKeyS/zmy0dD2ko6GFNCJ7pB5VqkulvKYJ8
 kYUER5yfeNEuD+T23JdYW6bsEcmjjc5aBxQnEbS9L46rqRH1XvU6Vwr2QUEgzM1fAi6B3ThO3md
 Q6V5wpZERIOWeBchO1OClSUj1wTxYBljH75cYtjm6MC+PRodFRExN35bKJD+nM3eD/wIpUAMCzQ
 CMvIWVUUj/rLd6e0EFrWh+ZG4JNeqw==
X-Received: by 2002:a05:6512:3b0d:b0:5a3:f0a7:2f72 with SMTP id
 2adb3069b0e04-5a416f4c333mr1152842e87.0.1776455329659; 
 Fri, 17 Apr 2026 12:48:49 -0700 (PDT)
Received: from lilia.home ([46.205.200.78]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad0d0sm667857e87.5.2026.04.17.12.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 12:48:49 -0700 (PDT)
From: mjgajda@gmail.com
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com,
 dri-devel@lists.freedesktop.org, "M. Gajda" <mjgajda@gmail.com>
Subject: [PATCH] drm/amdgpu: allow unprivileged read of GC_THROTTLE_STATUS
Date: Fri, 17 Apr 2026 21:48:35 +0200
Message-ID: <20260417194835.792023-1-mjgajda@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 21:55:06 +0000
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

