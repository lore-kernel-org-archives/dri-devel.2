Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0AFCD98F6
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84A7810EE3A;
	Wed, 17 Jun 2026 07:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="TquJnotm";
	dkim-atps=neutral
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15DA510ECFA
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 18:43:17 +0000 (UTC)
Received: by mail-qk1-f173.google.com with SMTP id
 af79cd13be357-91562bf6c12so572973885a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1781635396; x=1782240196; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Dd83DKF3frqmG4DXmGPzNS34lS70vyOR5YrJhziAaCg=;
 b=TquJnotmrTH2YNFI75AnpJzkBg+P8iwc46FjiIKaFgT5Id+NiAwyhPvtM5t/UDgfat
 NhGDk9KdsxsDwlmq/vzDT88j3T6n0E9rbNG0wxUnC4nAK8pRt8rDmDTm4u5NjFXYFhsV
 6lTcHjT4FC43bBf2UI/V1gOdVGZXW77Vfv12MiuGjSxGy3co5V5fLjUloEmdF3HN4BBU
 zPlmM/YDww8sdsS8712HZ/MmjczNnW1wxKzHSfUHiOHIt53EtkB66nndIH7ogfwubjyM
 yHe/MbM3GmzPE61KMATy2204tsnlVbbgO4aiKe/b2Dj8OaFEsBvmwRSYrjfb9vTI6z/8
 ItwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781635396; x=1782240196;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dd83DKF3frqmG4DXmGPzNS34lS70vyOR5YrJhziAaCg=;
 b=pMQqtpFsYSUPMnU1cPZJLQMub2zKiJ3uUZzGrnZURxRWE4N26I05TAlh3TTfcr1u/p
 ucPIjQ9mrW/RxvtEqIAM18lrIII0Tg1tkzKvsjRL04cisBFESZXMxXAu1wY6kc0W8s15
 ZiEIvVXr1/cDtuGjj6G1I1T1c25G61gRV5axUbzRGe6CE3XBKYmFzgcQq+zFvQzhmdOR
 Hi9OaY6bdm8GSsoB81k7tAmLWFN7Lh2+28gW1/+0LtrpSH2K7m7lJPoyEpNe/aXMF/q2
 QQugLfGKZHCP65jkaOdUwx7JPJZqwoi2rOxUDmdPMXotQ9QwH5PQWSvFG7r/7WdS3vJ5
 /5zQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rbl7mbHd9I7R4KP5rDhzjbriwdveeSApYHLC1VdgNCMBMZyDO5bmhTADl0bxRq8V7e8pY4s/tR3k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwN33qwuM3egtnhzNe4bVXD34/Hf4C5vPUP+nbbOKiykC8A4VG5
 m1/R/NtFSFlQiIp4bG0GZcQk57yScWMhz8g5jznQCyXs1fKUcgOEKuSRbMSn5dH0X+w=
X-Gm-Gg: Acq92OHc+T1j0HPaHPaYJR0Z4gY1Th2QGDMMUzAmJdOLE61rjWPPAezsL2JZSBn35jE
 dg/NmIxVdZ9rtCGtAszhAXQi5WCGdiqjVkGPbUocuxns36QYHV/dnfwUvKB6DLsnfPCnDaxm8CF
 J+r1J7q21MUJLOnMTE6xuvLU9IKsmB9rzDTvWIUD1zWogJ9gL1I10yBk2hFItDzLbM7rkulktA6
 cWi949t3Q6b6E7Y24efaUOP6BXd+ynBbylgKFdHlndFqiwaQjL7T8kLa/IiK0l6+fxbAcKHMY43
 RhAFwUQ37SQTo56MuGiVMmkCwVUO79Ddn7uk7S4rWkMCPBTukdQmTnAnRD44mOnuNa7rCbIE35N
 5B2fvAyIoDyFmq4rX8Sjj5iyOk4YnE7Bii6/D1sh0KYdvExVPuz2Vb8J807V0BMDs05s23T1Nqi
 0=
X-Received: by 2002:a05:620a:4727:b0:915:86c6:8432 with SMTP id
 af79cd13be357-91db9a804aemr31412185a.14.1781635395939; 
 Tue, 16 Jun 2026 11:43:15 -0700 (PDT)
Received: from arch-ideapad ([2804:388:d03b:e57f:9ee:2b4c:ee76:e0e])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91619ed7f16sm1504660285a.1.2026.06.16.11.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 11:43:15 -0700 (PDT)
From: Ryan Oliveira <ryan.oliveiraf@usp.br>
X-Google-Original-From: Ryan Oliveira
To: alexander.deucher@amd.com
Cc: airlied@gmail.com, ryan.oliveiraf@usp.br, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 kaikycintra@usp.br, simona@ffwll.ch
Subject: [PATCH RESEND] drm/amdgpu: Unify vm_fault_interrupt_state logic for
 gmc v10 and v12_0
Date: Tue, 16 Jun 2026 15:42:09 -0300
Message-ID: <20260616184209.18014-1-ryan.oliveiraf@usp.br>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:07:22 +0000
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

