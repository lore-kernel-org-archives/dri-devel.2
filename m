Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C491CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:56:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABF4710F4C3;
	Fri, 26 Jun 2026 07:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="dLNPlVo4";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 709E510E2A1
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 02:51:28 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30c8b23420bso848296eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782442288; x=1783047088; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JtS/kmZ/uTxQKqZxPH1/+2V/jDxVEHNoVXNcZX4R18E=;
 b=dLNPlVo4zZTTbMISZiCax6utHH3x98j6a9NExigEtydem6RYEfj2aO3V6CaCx49lOT
 ke7wU6U+IXyJ1c0C7ylzOg82/2ZkgTI+qxjZ40QDURM9Qq5XMvelGReO3NicA5Gqlwwk
 tcFjry2T9DojLVXku6zvmFJ/bpxdnxLlLIgQkg5AFtsdMvCVWe6tEiIk+dgU/4loISrS
 kpqoTYt5yCNdP/CaJ+3ul0riFTho15jv46p5NQMnyk5HRjhuZJJFUBqzgqgk+mINR5DN
 40Jo1CxHxEwfumcptSu4fY0Hy/lX8iLVeVT5TGQwUKhgBpchb9bHjErnmVGjNYNQY4Uv
 7jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782442288; x=1783047088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JtS/kmZ/uTxQKqZxPH1/+2V/jDxVEHNoVXNcZX4R18E=;
 b=ju/PKiAj/Zv4S5pNP2tHmgCNMV3m6Y2fKWF0kVTxX9sgvBNSqXNYvHfLhFvSSn5kv5
 azrHy3PvgmKlk82/24v5LF1VG2cX8y9/3Kf2WAzvpFDfY3TKvCbzz0Rp7e1viIo2aS0f
 n1eGxlx4eNjSuZDcKd3w1H/ACfLX6CduvI2+Pv4l5tAkdQAjgeg2/8g2kO4QuvIN5MiM
 WTHpGBaMk3a0j+RcE+h2BkOflMRPw/MQ88SK+0x78jow09e6n68Ofh4hWXgRmvvM459i
 TqFvAS4OzXjB9x/PE9ef1kjG/HdohttM7ZsxFN3yp/UC+Txtx9/WtchqBvU5KgNprs12
 yBnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqbBYdNAwyWYxe//Db1k4o9jDqjKAYvm3ViUm3GlUhA0yZaA916kHYMbUqBNtm5gfZLTIzVS2QZZ3Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybfIa0vWYQ0ZZ8axk740e5y9oPdepvR1kCY1ZF8G9Kk1RUDb7q
 SU+tKROwA1TKJ42PT0QB4OzC8R+uKOPujXFgwDci4NJAdmGpY7Vf65iDdnVDcWsZ6rVujC+37HV
 nuOTBWKWQSA==
X-Gm-Gg: AfdE7cnI5DZwN/aCjkAoOIrULiNmUfDwLC+xEl181RFb8tTOAufgh6iYyZR3OyGp+GZ
 he9QMRA4kNWwXi9QpXMeULiSn7oZ8BfNLI8Yjf1RYWNytUH4HQQjwQqU+SA5kXdYI9IrMU1S4Aq
 HE454vmNbSzN7Fkg/bQTz1Sn+RrvmLa7Mr9XfzmKpDu2rOUwSs5YCFjwLA1BpOrMqhIad7M3T2m
 14v/BdrhRnTB8dPW0B9vE6aq36ovc7FrHuF/lBgd/+21giHRhsCoYZvyY/sldITfg+nLplUL8Qw
 T4Gocfy63JOZDVDD8lNd5CR/7v12ND4sCaGHsV0wk9awUlP3/NmLvyFSESjwEKS9SUV6iMbxah8
 yoUkdZ1KHtplb8UorsmODBjbcfGqRC4TRG+2QD9icgXNDugmOFkRh5btvduR8Sy1INYfrZpZUJj
 xG4Y4CcOR+wpqjC/6fHyrrPfUTKiGihumcPvfTmNz1A6m2yBQcptHjowldv4u6Z7VfFWU5mg==
X-Received: by 2002:a05:693c:88c8:20b0:30c:9cea:563a with SMTP id
 5a478bee46e88-30c9cea5670mr469061eec.24.1782442287594; 
 Thu, 25 Jun 2026 19:51:27 -0700 (PDT)
Received: from voyager.. ([179.119.40.186]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7ca438ddsm12905797eec.23.2026.06.25.19.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 19:51:27 -0700 (PDT)
From: Tiago Dourado <tiagodourado@usp.br>
To: amd-gfx@lists.freedesktop.org, airlied@gmail.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, simona@ffwll.ch
Cc: luiz.f.f.fernandes@usp.br, Tiago Dourado <tiagodourado@usp.br>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 2/2] drm/amdgpu/jpeg: deduplicate jpeg_v5_3_0
 process_interrupt
Date: Thu, 25 Jun 2026 23:47:24 -0300
Message-ID: <20260626024948.19131-3-tiagodourado@usp.br>
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

The jpeg_v5_3_0_process_interrupt function is identical to
jpeg_v5_0_0_process_interrupt. Remove the duplicate implementation
in jpeg_v5_3_0 and assign the jpeg_v5_0_0 version directly to the irq_funcs struct.
Export jpeg_v5_0_0_process_interrupt through jpeg_v5_0_0.h to allow
cross-version reuse.

Signed-off-by: Tiago Dourado <tiagodourado@usp.br>
Co-developed-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
Signed-off-by: Luiz Fernandes <luiz.f.f.fernandes@usp.br>
---

v2:
- Assigned function directly to irq_funcs instead of using a macro.

 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 22 ++--------------------
 3 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 46bf15dce..4575d1f9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -625,7 +625,7 @@ static int jpeg_v5_0_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
+int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
 				      struct amdgpu_irq_src *source,
 				      struct amdgpu_iv_entry *entry)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
index 5abb96159..4eeb0c147 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.h
@@ -32,4 +32,8 @@
 
 extern const struct amdgpu_ip_block_version jpeg_v5_0_0_ip_block;
 
+int jpeg_v5_0_0_process_interrupt(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  struct amdgpu_iv_entry *entry);
+
 #endif /* __JPEG_V5_0_0_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 1821dced9..a67c6e916 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -32,6 +32,7 @@
 #include "vcn/vcn_5_3_0_offset.h"
 #include "vcn/vcn_5_3_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_5_0.h"
+#include "jpeg_v5_0_0.h"
 #include "jpeg_v5_3_0.h"
 
 static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
@@ -608,25 +609,6 @@ static int jpeg_v5_3_0_set_interrupt_state(struct amdgpu_device *adev,
 	return 0;
 }
 
-static int jpeg_v5_3_0_process_interrupt(struct amdgpu_device *adev,
-				      struct amdgpu_irq_src *source,
-				      struct amdgpu_iv_entry *entry)
-{
-	DRM_DEBUG("IH: JPEG TRAP\n");
-
-	switch (entry->src_id) {
-	case VCN_5_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
-		break;
-	default:
-		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
-			  entry->src_id, entry->src_data[0]);
-		break;
-	}
-
-	return 0;
-}
-
 static int jpeg_v5_3_0_ring_reset(struct amdgpu_ring *ring,
 				  unsigned int vmid,
 				  struct amdgpu_fence *timedout_fence)
@@ -696,7 +678,7 @@ static void jpeg_v5_3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 
 static const struct amdgpu_irq_src_funcs jpeg_v5_3_0_irq_funcs = {
 	.set = jpeg_v5_3_0_set_interrupt_state,
-	.process = jpeg_v5_3_0_process_interrupt,
+	.process = jpeg_v5_0_0_process_interrupt,
 };
 
 static void jpeg_v5_3_0_set_irq_funcs(struct amdgpu_device *adev)
-- 
2.43.0

