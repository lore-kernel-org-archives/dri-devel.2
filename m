Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C40CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E5F810F4B4;
	Fri, 26 Jun 2026 07:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="YVMwTmFv";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAB110E2A1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 03:00:26 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1397e093f90so1755128c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782442825; x=1783047625; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq2opASfg/ddj/DpE+EyMQATEY25HCM9sOHt/sCT3XM=;
 b=YVMwTmFvu/v8bsFko+Ezhd1RMYodyDz+LMI62zNH44MI1xry3jERMcbyrsxh2D+vPN
 SIxXYNvmQczGIjlJsE+kax+q1vY0XwjZW78GZ3OIFiCPx+QFck6O37nbvHKKuCQsc0sw
 gVm+SEI+r1sWSt7MNsqsSpajGZlBPLq/MU6eiEoEZCX70O5DzY1BLg6L0PTH/RMLofvA
 2o0E7KJGYslry0trnAEa41GKtmBkswiZ84CjAuhC8ZUvPqJy4NWB1dtB9lJaGkbS6yH1
 vcxg26rZe7FMFVPn0kve684dtnvsjQYBOtAjpK3YxRgdR7DaikR/sdkxbInE8kPeebRn
 mxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782442825; x=1783047625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yq2opASfg/ddj/DpE+EyMQATEY25HCM9sOHt/sCT3XM=;
 b=e8qaU8CDhaT8a2qrFtCFuT1Hmgin1ICFkY7gVjHSr2NbS69krN3n+xWXYudtoKJpEP
 mNahpUJE7DkT2e2uxUXmFEruzoi7BCk1nwHP85bymuruuwhK+QRNpT6urAaw3WVGxnhE
 UXYV/333HXi5rPE0jIFN8Kryl4Nw8IdY2QAfdZsbQgMgTgu4r6XjBoH0GPHHFjSNJID6
 DZgji13Jb/8bXjsAQ2BOmfUIFvK2WZD201ur4AgdUA0y3nWZByEN05FZ5XnXFZsvV/Lf
 wraBRwfTc85/PzOkhwbe9GNlYYFfFd5UFq+uRfytLj1OX4JknHu+EuIppcQth3HHwrcN
 4IvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EmjA7+ajkroQ3FcwECPL1l0xN+K0VBe7EHjai9I+MqYdPtdallIOwGEes7QIiTQEyJdfTbVP0KuM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxcjpa9tuaPmzUqQs9+lkB2BuwseqafDKCmW3xS/GwhekLYWh6s
 w138v7Eok8lZypGx+qth5G3lPEC8wQPvU9ymFsQgdtNvceN0vDaXI/7BDXe//s6ae8Y=
X-Gm-Gg: AfdE7cn/RhSxwMOWyZnrXTAX96DnqLviW0nUHO2kqGKSEN6uJWrlQ2NR6Nxxgwwx7Il
 9r91v/eCGU4xJAlxUyFk23AQmyXKRa16UovJHqs+l4yfVhZBwO8pFt6VdMlwlXBGKm4cj6b4asu
 k0bGpXLoYmnT9lsvc6UgYBusipvUBftCYPujWOOUZ1kRN8tuLMrLGSAALclDXOT/glyFU7OLJ2T
 p1tDTy5ltELYZIV6bjg8YU4wtxudjR+lB7lIAJ8K3PCNYuncnecpQVW/yTNLlMbmzFaVc33bV/i
 0qavcAmNnqEqOHzVpKkgVs5uDjI9YQ6mK5wFkn0IRJOaXi8GurDeCwLEp1OALIdeCB12ReZyqTQ
 haNGqKsVzf4t/hBkx01vsfWSg3dKBxoHAYWKEqkbgSzFB3LE93qejnYmADiA64Sw/pDdTkECeay
 e5xutvJ2DCiJE9ykamqcqGwcd/+hXvlth5IVywI3PVpBtjAtXL8SgV5669PdErNyV1/qsJrg==
X-Received: by 2002:a05:7022:390:b0:139:c4e3:9499 with SMTP id
 a92af1059eb24-139db9edd39mr4209752c88.2.1782442824088; 
 Thu, 25 Jun 2026 20:00:24 -0700 (PDT)
Received: from voyager.. ([179.119.40.186]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm13048415c88.6.2026.06.25.20.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 20:00:23 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: kernel@lists.ime.usp.br, airlied@gmail.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, simona@ffwll.ch
Cc: Tiago Dourado <tiagodourado@usp.br>,
 Luiz Fernandes <luiz.f.f.fernandes@usp.br>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
Date: Thu, 25 Jun 2026 23:59:12 -0300
Message-ID: <20260626030013.20569-2-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626030013.20569-1-tiagodourado@usp.br>
References: <20260626030013.20569-1-tiagodourado@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

The jpeg_v3_0_process_interrupt function is identical to
jpeg_v2_0_process_interrupt. Remove the duplicate implementation
in jpeg_v3_0 and assign the jpeg_v2_0 version directly to the irq_funcs struct.
Export jpeg_v2_0_process_interrupt through jpeg_v2_0.h to allow
cross-version reuse.

Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
---

v2:
- Assigned function directly to irq_funcs instead of using a macro.

 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 21 +--------------------
 3 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 9fe8d10ab..9006fc57e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -747,7 +747,7 @@ static int jpeg_v2_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
+int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
index 654e43e83..4f400fb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.h
@@ -58,6 +58,10 @@ void jpeg_v2_0_dec_ring_emit_vm_flush(struct amdgpu_ring *ring,
 void jpeg_v2_0_dec_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val);
 void jpeg_v2_0_dec_ring_nop(struct amdgpu_ring *ring, uint32_t count);
 
+int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry);
+
 extern const struct amdgpu_ip_block_version jpeg_v2_0_ip_block;
 
 #endif /* __JPEG_V2_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 98f5e0622..2f3a5a17e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -539,25 +539,6 @@ static int jpeg_v3_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
-				      struct amdgpu_irq_src *source,
-				      struct amdgpu_iv_entry *entry)
-{
-	DRM_DEBUG("IH: JPEG TRAP\n");
-
-	switch (entry->src_id) {
-	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
-		break;
-	default:
-		DRM_ERROR("Unhandled interrupt: %d %d\n",
-			  entry->src_id, entry->src_data[0]);
-		break;
-	}
-
-	return 0;
-}
-
 static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
@@ -629,7 +610,7 @@ static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs = {
 	.set = jpeg_v3_0_set_interrupt_state,
-	.process = jpeg_v3_0_process_interrupt,
+	.process = jpeg_v2_0_process_interrupt,
 };
 
 static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)
-- 
2.43.0

