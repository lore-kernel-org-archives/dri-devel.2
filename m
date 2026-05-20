Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43C3CD5BA6
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 06:45:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D930110F216;
	Thu, 21 May 2026 06:45:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="PZZPPhAG";
	dkim-atps=neutral
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com
 [209.85.222.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B438810F16F
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 22:43:17 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id
 a1e0cc1a2514c-961556c15ceso208667241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1779316996; x=1779921796; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dd83DKF3frqmG4DXmGPzNS34lS70vyOR5YrJhziAaCg=;
 b=PZZPPhAGCvVENZERFvGOnNncyhMUJTmfGgCwgR8AbrC1wnXEAwO1oFpvxz+tLnYJNX
 /mXYSGC3OeP4Isi7qXSjmFciURPC965URQulcNxpIJHWE/2MxGQ8Mr99pWUXceJNctfP
 vSmYBIrp/f7TmdzxNVRKArZbFD5QFJ0u4YVY6CSF5INu7fYAuivQCTPd2BXzCEm3HoR+
 e9SPrzN/VXpH8z/Wg/GR5WQqlFxEsDm885yNVuVFFrWOChGPKjSNcKucM/lZQdDuQDC8
 rWDhp/wxTfb2F2UaERs8ClYttGcpvcznle862KY3gV00wQojw1pvK1UqI6LjTNVleprB
 FBGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779316996; x=1779921796;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd83DKF3frqmG4DXmGPzNS34lS70vyOR5YrJhziAaCg=;
 b=FETMqSWjZR98MYUEAqh15oi+TFsym3/A1dPcEe/qGssJCin6R0EkGAFVz0nOHRmmAI
 Dn3qNtHN+1liKZRSc2F9YdJcJRW/FWrgfeAbjX0iMxYGPs3PxpIIxeSxSH3niL/HFdER
 /LDiN1P8qTbE3prV2cHA0LCI21acEyjgzEmAEZFM2sY+R1/RngixbdL2WGEZugVLmhDh
 J/Xn0bnokqYYlAbm72CaLtOitfD87hCkTW1nNDyxXLbO6Jsmin0XzeVXWIx+bj0Xyq1G
 d8mGmzCGRgItXhelg8h1spUpu3adk3Bs7S5yPX6xVjEEr9QWWRsgNXGrTdat9XkJrHYz
 MDGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+cY+tqDC2Ef/bGRvO3qXqPBBp2gugGExCsR23Qob3wBFJTgRloxVvU2WKPzogLQrtlkfsQHieW28Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIRXAnE6L7D9vagpHipvMx0yedraEgPm8u5XVZvKtJDK9BoEzF
 uMAVLd1Gs0izZu5PJN3e/Iy0SWm4BqQKm134OKpG2MAppJ2CjfaOhI+T7ybKZN/1B4Y=
X-Gm-Gg: Acq92OE4QrLSRCDADpK7xCgQAUu2IimffDAYNdEPP0RZghgfgfzJDmaAuQ/8ZtdXqyv
 Uc9UPWH7g6PnJ7hyPz0I7AVEMBu9QhXaRX3mnuGPb0YJvXTWugrBGe6xyTNZqt0jVe7W70Cs46P
 wpqvWoF7vPXO/BBY6LA5LUvrqF4pQTRLvi8Ky5n/Kw41tY0wAn1K/K50lc+TcXwZYlv9ryU2lNa
 jmiz9pzheAB0ZcPxwqegTjDyY3smuGM0JG+aflFNURRao+p3SA7gpMf1Wikc5xdCoR0b38/cvAG
 6pg4Oispa86POKw2UQafmkqVeVA5zOqEQjILwgqaNsmr8dp6SlklO1XpvgnW0WL+PZLnZjSO5Vo
 1TDbrSTA8cPhkaf5Mv7Y0fPT3A56mtG/+g9fCJUyoI40JTrEao53MklerLwIuuXZwtjh6TeM+Wt
 kaw3smBsJgIg==
X-Received: by 2002:a05:6102:f91:b0:633:3040:ca5d with SMTP id
 ada2fe7eead31-6738e4da513mr294017137.9.1779316996343; 
 Wed, 20 May 2026 15:43:16 -0700 (PDT)
Received: from arch-ideapad ([2804:7f0:3df:2617:4b61:1102:6d3e:92b4])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-95fc29cda8bsm11281113241.0.2026.05.20.15.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 15:43:15 -0700 (PDT)
From: Ryan Oliveira <ryan.oliveiraf@usp.br>
X-Google-Original-From: Ryan Oliveira
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Ryan Oliveira <ryan.oliveiraf@usp.br>, Kaiky Cintra <kaikycintra@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Unify vm_fault_interrupt_state logic for gmc v10
 and v12_0
Date: Wed, 20 May 2026 19:42:13 -0300
Message-ID: <20260520224217.17615-1-ryan.oliveiraf@usp.br>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 21 May 2026 06:44:53 +0000
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

From: Ryan Oliveira <ryan.oliveiraf@usp.br>

This patch consolidates vm_fault_interrupt_state handling logic found
in gmc_v10_0.c and gmc_v12_0.c into a shared helper function inside
amdgpu_gmc.c

Since the v10 and v12_0 implementations are identical copies, moving
this to amdgpu_gmc simplifies maintenance and reduces code duplication.

Signed-off-by: Ryan Oliveira <ryan.oliveiraf@usp.br>
Co-developed-by: Kaiky Cintra <kaikycintra@usp.br>
Signed-off-by: Kaiky Cintra <kaikycintra@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 37 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 39 +------------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c  | 38 +-----------------------
 4 files changed, 42 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 13bec8461cde..eebf5c17efb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -590,6 +590,43 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 	return 0;
 }
 
+int amdgpu_gmc_vm_fault_interrupt_state(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *src, unsigned int type,
+				   enum amdgpu_interrupt_state state)
+{
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		/* MM HUB */
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), false);
+		/* GFX HUB */
+		/* This works because this interrupt is only
+		 * enabled at init/resume and disabled in
+		 * fini/suspend, so the overall state doesn't
+		 * change over the course of suspend/resume.
+		 */
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		/* MM HUB */
+		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), true);
+		/* GFX HUB */
+		/* This works because this interrupt is only
+		 * enabled at init/resume and disabled in
+		 * fini/suspend, so the overall state doesn't
+		 * change over the course of suspend/resume.
+		 */
+		if (!adev->in_s0ix)
+			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev)
 {
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 676e3aaa1f27..386e5f292c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -437,6 +437,9 @@ int amdgpu_gmc_handle_retry_fault(struct amdgpu_device *adev,
 				  u32 cam_index,
 				  u32 node_id,
 				  bool write_fault);
+int amdgpu_gmc_vm_fault_interrupt_state(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *src, unsigned int type,
+				   enum amdgpu_interrupt_state state);
 int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 8523833a74fb..4aaa3c65e186 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -59,43 +59,6 @@ static int gmc_v10_0_ecc_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int
-gmc_v10_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
-				   struct amdgpu_irq_src *src, unsigned int type,
-				   enum amdgpu_interrupt_state state)
-{
-	switch (state) {
-	case AMDGPU_IRQ_STATE_DISABLE:
-		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), false);
-		/* GFX HUB */
-		/* This works because this interrupt is only
-		 * enabled at init/resume and disabled in
-		 * fini/suspend, so the overall state doesn't
-		 * change over the course of suspend/resume.
-		 */
-		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
-		break;
-	case AMDGPU_IRQ_STATE_ENABLE:
-		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), true);
-		/* GFX HUB */
-		/* This works because this interrupt is only
-		 * enabled at init/resume and disabled in
-		 * fini/suspend, so the overall state doesn't
-		 * change over the course of suspend/resume.
-		 */
-		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
@@ -168,7 +131,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 }
 
 static const struct amdgpu_irq_src_funcs gmc_v10_0_irq_funcs = {
-	.set = gmc_v10_0_vm_fault_interrupt_state,
+	.set = amdgpu_gmc_vm_fault_interrupt_state,
 	.process = gmc_v10_0_process_interrupt,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 586703ec0dfa..d3eabe3b6dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -53,42 +53,6 @@ static int gmc_v12_0_ecc_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int gmc_v12_0_vm_fault_interrupt_state(struct amdgpu_device *adev,
-					      struct amdgpu_irq_src *src, unsigned type,
-					      enum amdgpu_interrupt_state state)
-{
-	switch (state) {
-	case AMDGPU_IRQ_STATE_DISABLE:
-		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), false);
-		/* GFX HUB */
-		/* This works because this interrupt is only
-		 * enabled at init/resume and disabled in
-		 * fini/suspend, so the overall state doesn't
-		 * change over the course of suspend/resume.
-		 */
-		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), false);
-		break;
-	case AMDGPU_IRQ_STATE_ENABLE:
-		/* MM HUB */
-		amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_MMHUB0(0), true);
-		/* GFX HUB */
-		/* This works because this interrupt is only
-		 * enabled at init/resume and disabled in
-		 * fini/suspend, so the overall state doesn't
-		 * change over the course of suspend/resume.
-		 */
-		if (!adev->in_s0ix)
-			amdgpu_gmc_set_vm_fault_masks(adev, AMDGPU_GFXHUB(0), true);
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 				       struct amdgpu_irq_src *source,
 				       struct amdgpu_iv_entry *entry)
@@ -160,7 +124,7 @@ static int gmc_v12_0_process_interrupt(struct amdgpu_device *adev,
 }
 
 static const struct amdgpu_irq_src_funcs gmc_v12_0_irq_funcs = {
-	.set = gmc_v12_0_vm_fault_interrupt_state,
+	.set = amdgpu_gmc_vm_fault_interrupt_state,
 	.process = gmc_v12_0_process_interrupt,
 };
 
-- 
2.54.0

