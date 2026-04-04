Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E43EE63FEC
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 17:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B9110E0FC;
	Sat,  4 Apr 2026 17:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="Ud3T62Pv";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16E2110E06D
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 06:40:21 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-56db1b3626bso757952e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1775284820; x=1775889620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NM+YgMZ3VPSp8HAw6BysCZ3QXJispP0X2NnMfKbHGEw=;
 b=Ud3T62Pvx7Jp92tXbcLRxU1Mr/dmUGN78hMcfUytV6udlU/6bhgbuS9jtiF89mzTDU
 xk7EFyzc/MOnjmvivev1YrC6snpgVRcePuEYfkMs4Pc+MMYIE4rRmVNBTqRzpbbpnNWd
 t7uDnbgbtMixh6A5S4KrO+Ykf6ukRGJ857PbVit/6oNK0fVlmq4dEuqHVWLmL15acaHQ
 el6pDEJTiXzRs72Hwn8Qho0eT1RsFA2W2gxZo7lV4i3Muz2lvbWG0Cy1gZCDhaRCu2oT
 A35Bdf0OinJXnnQTfaommZA50YjuR9F/8sEdzEZg7CYkgbOw+RLSqu0b+k6nTpA1yhhu
 aU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775284820; x=1775889620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM+YgMZ3VPSp8HAw6BysCZ3QXJispP0X2NnMfKbHGEw=;
 b=g4HwNQ6KV6n1OvYf+krpQYMGV/jTPyLfL6p4dS8Gm11QRb//BQyj2xzQcQlWsKw9Bi
 Rrr0YHQq4Yvku3WG5JXqcZGXi+jyxpj0JgdxrDSbY5+y7VsmLmHU9nv1Opt7LFx+csRa
 Ovp0VDeRuQw/RBD6BDndGfHAcZW6ukUQzVj+VIP9ezveEqRPBpmIXF192w0bDARHdyee
 a+c4hooWKwBnyw1rtWGDtuWLhiNeDl1UTMsi7ghIIN+oM2I39KFKYD21xM1llzks8Rmj
 KS0PZKX9SNjwUAdvK0NLGUu9IHLWcNlR8sR8FANYGByvZRMer0xn9SUey7MH8Qi5VXe4
 pcwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFv/2v3bcSCGmjZiGyqOObfPN+6FeCi11AsXQ38Zkb83gZAj37q5lg2keWRT8prq6iMvOhEd8lfrA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwlPbqntZSdxfWkwgJSOS6Knn5PY0GskcDrM5sBzZ06RyWT9iNE
 vjOtNAZDuDfurWDOEXtmjqvQ0eFtViZ07IoyCEa9Jbpym8ukMSEWb/uGF/cnI9QBzfw=
X-Gm-Gg: AeBDiesihTBDT0eH7Em+fOCgOoLlQxD1rihqQCoWzrfKCiTUYJB6WOW/kbItC7dv5qZ
 C/ywEBykma0jNk7W0W9yNGFPlrRs1WOGE8dcJ/quxOV0CtyRYtbdMyyTdCb0dDKBMpmLzFhRAiN
 +IPVwCxtvx3j9+eH2cm3hL8n6Bx7B6jE3uj6uCbhMiIesS0Rgj0s3wmBciLS1wlk7GLNScfxDWL
 XofPJCHyEXWrLRJYusVhjeWWYHs4Sz2qp0+NHZTfnPBls875/QjyvcCMnAFMdmX2gswTZ2Yhozg
 1HPMaakYZyzUUSpNyxL33Kk8Goz1pDKW/0YEt/x+TNWKB/8TnlHbUEZw8Amut0rsFW5k+SSUxCT
 lvD8Atn9hiyYbnyyYbNCQzfZ7wiZ5ll/LAN+2ukWXGzhrcz8QPTFPFRKFMrILzUuF0CuMdIG4HX
 JlsIeleirsUJgA0GKfVr1q9awffxJK5CtBH8jYSWs8pAwz5cOWEj/+kIzZ9b38VPmzbYW0EfDY5
 frX60Mvjp9jURivUaedZpwGU8ir3CQrqllCpNhRE3m4xXtc9g==
X-Received: by 2002:a05:6122:7c8:b0:567:433b:e903 with SMTP id
 71dfb90a1353d-56dab87fccbmr2066447e0c.6.1775284820640; 
 Fri, 03 Apr 2026 23:40:20 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d9bd2106csm8843708e0c.18.2026.04.03.23.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 23:40:20 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, guilherme.bozi@usp.br
Subject: [PATCH] drm/amdgpu: use named SRCID for JPEG decode in VCN 1.0
Date: Sat,  4 Apr 2026 03:40:03 -0300
Message-ID: <20260404064003.94877-1-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 04 Apr 2026 17:34:02 +0000
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

Replace the hard-coded value 126 with the constant
VCN_1_0__SRCID__JPEG_DECODE in jpeg_v1_0.c.

This improves code readability and maintainability by centralizing
the SRCID definitions in ivsrcid/vcn/irqsrcs_vcn_1_0.h.

Also fixes potential confusion when handling JPEG decode interrupts
in the VCN 1.0 hardware block.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c                    | 6 ++++--
 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index b5bb7f4d607c..52a329773467 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -31,6 +31,7 @@
 
 #include "vcn/vcn_1_0_offset.h"
 #include "vcn/vcn_1_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_1_0.h"
 
 static void jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -443,7 +444,7 @@ static int jpeg_v1_0_process_interrupt(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: JPEG decode TRAP\n");
 
 	switch (entry->src_id) {
-	case 126:
+	case VCN_1_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
@@ -488,7 +489,8 @@ int jpeg_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	/* JPEG TRAP */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN, 126, &adev->jpeg.inst->irq);
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_1_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h
index e5951709bfc3..d97883a88b0e 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h
@@ -29,6 +29,7 @@
 #define VCN_1_0__SRCID__UVD_ENC_GENERAL_PURPOSE                 119     /* 0x77 Encoder General Purpose  */
 #define VCN_1_0__SRCID__UVD_ENC_LOW_LATENCY                     120     /* 0x78 Encoder Low Latency  */
 #define VCN_1_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT	        124		/* 0x7c UVD system message interrupt  */
+#define VCN_1_0__SRCID__JPEG_DECODE                             126     /* 0x7e JRBC Decode interrupt */
 
 #endif /* __IRQSRCS_VCN_1_0_H__ */
 
-- 
2.47.3

