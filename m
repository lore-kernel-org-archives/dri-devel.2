Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D45CD98F7
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:12:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C420F10F18F;
	Thu, 18 Jun 2026 07:12:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F0TVBBmN";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A35F410EAEB
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 18:37:43 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84275887a3fso959583b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781721463; x=1782326263; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=HBTeI2fu2gLidQ2w1YzFRkzMgZ3dP5HPVmfeBg+Z4uc=;
 b=F0TVBBmN9B/bORFw5WVAhSnJ8sKOMQzI/+VqRj6JNwCXCteaALuqlcFYyP22b3+C+m
 CXdTZxLzS/hDZlV1T+wh/sltOL79EGjkMxS4/4rtBcwqeVDbUPEYDNslhtql3RmLmsNu
 RQ3eBUIrcFWW5cBz/o1e10qxO8BGvWLylLOCaB0avTuygYjcf2R7b3KMSBeEBj0kJ4hZ
 cQ46rbdi0rKUKmELB1LkztpkBEM/46RCPnT2UD+3uKeMuylIBZAqk1/9GSmWq2eWhPEH
 jsj/irO+LwqSzyWFDalaDlhqRGWghmc91rB9eOA4XB911TwFrOnq7PWdiQUpIa62+LIe
 vmdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781721463; x=1782326263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HBTeI2fu2gLidQ2w1YzFRkzMgZ3dP5HPVmfeBg+Z4uc=;
 b=VVUS4xAYiOtW5gHj76+LZ4TBvqapIQP30xZ47F+lx80GJtvijUlfFWkbNsFRKq1RMx
 6wYoqeREqyKfQhVYO29ASeLEeO4t8cJWCyXETNjSk0Jr0BtpBDQVLdUhSdR5JbkWGoMF
 oA+SgnFmHasppLOESr4Y2Kuluu80sSlOR6XS0fyDiQc2+NICyFqxWKUnN4wNxKq6UJ7t
 RXOdGlj6q09ao0/x2iHb+cMizYu0ug0kQ+4ajN5kS4SOT0h5axi1rTb+XbdC/tKRnvx4
 /q7i1QrLY6yxy4mfOsm4LHG7hdYNcnXwkCIL7JjWG3Cy6F6793iUv5KF0OYWfiudRuXO
 Qa/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gN6KT0RQJg3H4lDIPs7bJ+kGnPop6ospIgsmMvCUsTtefdQ44MO3wfBnsC5f6orG3ZOm+Bphjd+8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1flkRg8r5uayl5rOdCUYpckxHQURUXPb1jkaQsmim4QBUzvnD
 L/7wIhmDKNsRoPV1E9WXcmc/pLINLlePhgGe4XMU7ChgxrEzc+PXsEW2
X-Gm-Gg: Acq92OFgJ8ChQLlu4HAhzPZxLvFWax+T5Wg/KGTfNsdHK6NZao6Q4RC9O/2vebN71UQ
 /MG6btfVrOO4hRBEoTRIXj56j3Csmn9bp8wmymB35LpMSmYakF8AaLGNpCEmDl10SXm/yxQ99Rt
 zU6Wv9IaYnGgGMsD1f6KotMpdxTWQt5bJUBBEMqWM/dGwUqC+uPnbRmNoJCH7QiB0NqNWk93O/u
 2YeqJ/JpS+naCM+AY3DU5kOazpE63RMzNtDmhu/FyTetEGwFcf6eMQABeBM2N0ioAPFtG0WK8PD
 4DXYuCxsbvaAtAPRfgHxgCej20nI/XSV9rD1LvMLXm9kl3BdWxdLiSJwBVbYUlVDIR6eOGfiU2M
 z4tpcan6vDhZlTzkk2FiEcJX9Qhz4zfUppOG0ugbJAZrS0i+66Yd5j9PBNJMlVEbMywppSKxfwp
 1CSEQgRXDjSnB+Ss0y+nVBNShhSIRHx+oZ
X-Received: by 2002:a05:6a00:138b:b0:7e8:3fcb:9b03 with SMTP id
 d2e1a72fcca58-84539561caamr527712b3a.25.1781721463031; 
 Wed, 17 Jun 2026 11:37:43 -0700 (PDT)
Received: from haichao.tail057a43.ts.net
 ([2001:da8:e000:1206:1886:6b7a:3e78:272c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8434accae18sm17380924b3a.17.2026.06.17.11.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 11:37:42 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: initialize ret in UMC error record fill
Date: Thu, 18 Jun 2026 02:37:37 +0800
Message-ID: <20260617183737.1101458-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:12:07 +0000
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

umc_v12_0_fill_error_record() returns ret after walking the pages
reported by amdgpu_umc_lookup_bad_pages_in_a_row(). That helper can
return zero, including when its temporary allocation fails, leaving the
loop skipped and ret uninitialized.

Initialize ret to 0 so the zero-page path reports a deterministic status
instead of returning stack data.

Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 14092150336a5..77a9f6a47d428 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -681,7 +681,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_device *adev,
 {
 	struct ras_err_data *err_data = (struct ras_err_data *)ras_error_status;
 	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
-	int ret, i, count;
+	int ret = 0, i, count;
 
 	if (!err_data || !ecc_err)
 		return -EINVAL;
-- 
2.51.0
