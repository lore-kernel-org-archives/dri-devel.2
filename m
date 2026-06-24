Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9358CDE001
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 07:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD33210E056;
	Wed, 24 Jun 2026 07:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FZ2ty3L9";
	dkim-atps=neutral
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com
 [74.125.82.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B343310E2A2
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 03:32:38 +0000 (UTC)
Received: by mail-dy1-f193.google.com with SMTP id
 5a478bee46e88-30c55adcf66so560852eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782271958; x=1782876758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZ3tnpLmuxVn6RG46V9wPX6GdF132bX99ersePpQd08=;
 b=FZ2ty3L9RYw0JXc3JwkJbd8Ol4DvsRAcOhsmW9Y1CsFPDAVNpF60SkYo4+2VgDkuwM
 JKs8CJGCwI0wkVIW8D9cQ1EPpvMyXIHHveV4Zx7o34E1kk3Q0xaP4RNVysO9SYS3jtpC
 g4Q81hVAq6KxklxLQfG1Osh7w/75kdQIBk3qgqKsNhiNK96/iqc7eCZaWcjpoqLSj+qF
 /rs+doWpYlnFYsswIGE3cmTu+3Gdwu9jiP8KQD+EJIleVnopo8+SGLtlKjKPJ6sJbya3
 M1D/++TNazU+2pREb/SGP21Wn3jtlhx5iTX4hf6lJX0LGFGr027qZs1jWMHf8XjD2R1j
 6FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782271958; x=1782876758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HZ3tnpLmuxVn6RG46V9wPX6GdF132bX99ersePpQd08=;
 b=ImBefslECxdrhO+ITzqmORjg5f+sZpx6YYdqIKNJFdHFkA2HF+zBlKd+EQ7HCYN2i7
 el41h1Gij4Te4yrNSxao3p8X60sGqPgey4AqyD0XRphLIOnzqz5ArfTMKH1sccGdSq9t
 bpKVJgRIydO+t2fXZ9nMsTETORV049Q/ky8ehV79e2y70DqKalUf9QVG6YqhMoNwmH7r
 GSB+xPcQjMQ2ywzZIywpQQEUAvJ/cldlSWQsaJu8YxWPbdBuZ9ExhkQ0vjrX0RCbFfBO
 hTJGPw2h85fGh8M8th7NcUNcQsEwC+F9DlHNg/SV/UHCeRjJR+fY9/Na6rDR3YJpAb6v
 9siA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/41hWEGIiQE6a0oeV69xuHB5PUDN8nZdF/kpfnC54Ahwxi8/nd0Vqpt/MEwoKnkgvP/x3Me6+a0ow=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdHD8DQQOmQmTY0kaNiK6IN2261olrUMnNBibT+pZ8ZcGG4cYP
 7kmiwNsugqH7WvkO6hwAhwAYJjQTdU6/dH1QBKUCZtQL4X2sNK7p+/Mu
X-Gm-Gg: AfdE7ckDBeTYCOT/RjOJ6AKlqela9S5bwslIO8eJbTBcDYLkPGAftzYM+PicvaRE8Sp
 5wdPHHdSoEY7ofBPkEGbcvp5KBesk1j8mgqxi7hSkPIBhF4pbCkphuIKt+9DeQft8yVTMQOe41n
 tlK2BM8P2U4B3S4ZZfsH3AZiJNsAVeSEpkAWSdVSx3tJkBQY5BtkvyKldJ5o7mwBw0nv3cZMhIA
 BYsJBz+HQZ1XyKbz2hGbzG0Hl//INC0PmPw2dsPl7af4DudTftSC98OlyTzOqNVK0rbshhfQlHk
 r3H4ZgsguCXDq2VpysMvkLJXs6Gu9ZZtPN9dQig9hPXXhJIEOIKHDMGfcnaedoprUu2JyC2LGCO
 xZoZNOd+h1g6uqOXjdpgbX9lg5YULajZXPb3i7eO4qd5oGjq0BKF75aF5xRqA1FG8CKB9P5UYWk
 vh1oKfD/wKB63/nACnsVfM
X-Received: by 2002:a05:7301:2c89:b0:307:156f:268c with SMTP id
 5a478bee46e88-30c691d1f16mr1764404eec.13.1782271957751; 
 Tue, 23 Jun 2026 20:32:37 -0700 (PDT)
Received: from andrel-LOQ.. ([2804:1b3:a541:e9d3:3282:951c:63bc:a264])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba57db7sm18875285eec.7.2026.06.23.20.32.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 20:32:37 -0700 (PDT)
From: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch
Cc: Andre Luiz Batista Bueno <andrebueno.mac@gmail.com>,
 Enzo Furegatti Spinella <enzo.spinella@usp.br>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH V2 RESEND] drm/amdgpu: deduplicate JPEG v5.0 interrupt routine
Date: Wed, 24 Jun 2026 00:30:30 -0300
Message-ID: <20260624033134.145561-1-andrebueno.mac@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CADnq5_POUhiOuusWBXgZMLCUhoRutMoH0NaLJgjWqapXd0eRcw@mail.gmail.com>
References: <CADnq5_POUhiOuusWBXgZMLCUhoRutMoH0NaLJgjWqapXd0eRcw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Jun 2026 07:47:57 +0000
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

