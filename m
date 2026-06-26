Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D987ECDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D4010F46E;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="WXjh8aBX";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88DA810E2A1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:51:25 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30b9e755555so1358307eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782442285; x=1783047085; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yq2opASfg/ddj/DpE+EyMQATEY25HCM9sOHt/sCT3XM=;
 b=WXjh8aBXiK9962QVd7z2o0X5xdOlRO+Uqw1Lb5n9vOD4wKd5rA0Xw8hL9Z4gZvdUnp
 31z1DtioUafPEXwmMifZDlbabUHG7ai706grS5QsVBzGZt/vA0Qtreg+R5AMuCa4UV7y
 H8CgT+ZyARhNhQVK4qCXCUYquBRwkpKFuL82Mrv0TXZ3/ZjYUOjyh+c04+4tdTD9Ixbb
 6pzTKUBYS1niMVBimGPHoHd+u0qso+dQFSy/177MMivs/abP78LylUf+2O93qI2uMy7G
 yQhpAYP4nzvxXAeEXmujgOxBn73yY4sdomrq8LB/aJcru/D91brAsA018Da2xd3Xx+YR
 xg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782442285; x=1783047085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Yq2opASfg/ddj/DpE+EyMQATEY25HCM9sOHt/sCT3XM=;
 b=CjHJBEcqy5p9a7VDlabRo1hLVQx26PBSfcPm5Wc99/yh+OvujAnAaHKMVTYJVsGEbi
 7oGGE5yn5AIswRUiGDj+bHrRJnflRbwIK4jxNwi/Dy/nGn3mE1Vu5kF/pi5DO58GQ+6Z
 OQxYa2tO4g5SbU0rG46PXMkMndeeJxTZb4PcYzj4tHWplZYiBJ3MZybuEzSxUUhu7phR
 U4uaBYB9b6CQnjfSogyn6kkxgunFOj88B8R5dDD7fQSL6OtB2IPy0HLvHCUQZRbXoq+X
 xTpii4kzdTdzTnNat1w+tZNchAJY2QW0f3GREtvRIvDVxQKRgFFIoz20+HIXfq0/vcPA
 ORvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqNP8rY+9vi5fhRYlnm5cufCrnl2h1zeMeblqf1PP3CGP3gKpgOXljZVG3Xs2axOLwJAgxF4370e28=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQCTbIm8C7DZ9OvNnTRfyaOOi8PCA53FkhSQFlqZZGQ9V+a3oJ
 JSi/OdWoa6KKY9oQpoe9TM/SY6CGOSQJiQs0gIW7rlwrcYSlKVBrLoHeUgF9/VYenPYA2kZkMoQ
 +TmDHdRQbkw==
X-Gm-Gg: AfdE7cm8dhHhQMSqAgoJEhVyxSDCC3q+H7rQU7sIHk70bz9DpJGcvkMx7Li6RVg1khO
 AfNSzg2tp4h/6obg+qke2Hhw5tmdbCLzUMU6HKAT6x5AvIBX/ft9Um5KRB3jWlSYkPIUSKcdto7
 Z+DK7GzpeBWHvqxYzAi99n93YsCajEW9D3yBBVIs03EP6K+o7smqWpFlkWdQk55boQPhMKpWCK3
 rlMLLuobBgyNsnFOPKa5iZJGEWkK5fwlMwpKWYevxHJR4uhQ5zRwPijuOL4am18tLeqxvFMInXi
 qeEFmLFtd5FejhXyAClakPoBpa09oLhI/zHAA07y3s926gv7ymGyWjLGH/exh9g15rUw6Ltfmm6
 3ig2O3Fu2Tzkex2xroxvw8tGNliA1m02RMJRreid8dRwfZ3/8ZKWlRy/g1o6fmJmW53TbE/cFBM
 SpmWqrgMvqgRGaZN5vZt2VPSU2SlUWLo3sgGwx6x7s4ZLVAKGwzXuIFBBn3OpsA4dBNxSrzA==
X-Received: by 2002:a05:7300:7b91:b0:30b:c40f:de0c with SMTP id
 5a478bee46e88-30c84bfeac9mr4973357eec.10.1782442284740; 
 Thu, 25 Jun 2026 19:51:24 -0700 (PDT)
Received: from voyager.. ([179.119.40.186]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca438ddsm12905797eec.23.2026.06.25.19.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 19:51:23 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: amd-gfx@lists.freedesktop.org, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/2] drm/amdgpu/jpeg: deduplicate jpeg_v3_0
 process_interrupt
Date: Thu, 25 Jun 2026 23:47:23 -0300
Message-ID: <20260626024948.19131-2-tiagodourado@usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626024948.19131-1-tiagodourado@usp.br>
References: <20260626024948.19131-1-tiagodourado@usp.br>
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

