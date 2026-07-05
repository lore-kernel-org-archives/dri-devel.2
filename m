Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E6BEC44501
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698B710E376;
	Sun,  5 Jul 2026 19:14:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pM61iAg1";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E0A110E376
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:38 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47d6c634f45so422213f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278877; x=1783883677; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nZ84WH17cmaqhOLzZnVtdcV+4jwRY2Bo5WKI6TnLcX4=;
 b=pM61iAg1U0ipuIMEo6eM8ZN6a+yMepYtel1tPrTk0x1w8rqPN11jS+5yv0RJmvonEh
 COK8kjlEtxybE6U7BL0QmbbS9FemxqSSsRvhRVILWKOTLuyJeglh04eYhsqFYhRueaWE
 QLEoAc6+bGR76YzF1UsMbCQ8Tyd5/NlpYjaeXHtZWYehjuzu4d2Vef6FRyy1Rwd/zdsw
 mf2rIoFjqJlzph4HUIehrlCSWH3GYWAFv+GuRBpJ870FUVKCX+ePMGFsDuv6M7WpIVFP
 gVlhOxWPyNsum57O0EFmOLq+Wfip6M8zUE9R410y+6hGr5lyyNtmfKXxh23hzWMqXIqy
 F37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278877; x=1783883677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nZ84WH17cmaqhOLzZnVtdcV+4jwRY2Bo5WKI6TnLcX4=;
 b=kgiqWL+BpZTQ7fkao6aMHJi/Z/LrNeI+bxK1EgVqQbDjIZRUx+nYTCCGIZL1B0vWUL
 ziZP1mk4Sl8lmC1x9C4PfC5DXhBNYv2mWv2s8GPIeEyzKisxJZAf9pUY+cF4JsziN/fZ
 TNX1DC5/4j6sTIb2kmn4PymYP/jL67J86Z0R5QDC5A3pvonrp8F0186zGhMW3TteM5zS
 TaGP/SGsn4PS2WMnJvaHIPkY86RSszKhO5C3TCk13ZgNC0p2+i4fFyaqi9qJqYxwbMBC
 Jsa2uLbCNdFpO1vKsXzW0VUyNIwwail31/0XnAM79vhIQ2axf7gymv9B4003FShbDWcd
 tlgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rov1eWkgIKge8QpIi5Ds/1A7lFe4dlzR2vEZs8rVCpHMMoZ3wQpqizgGLQbXy21xTlujk+ByrUxVhE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyjzdecvlZjELHoBK/75PvkgbWudIiCMDwyc8dQNMgQXVNUzkqY
 WK5EGoHRRex1F3s8OHukluGVYh/RRcCxtWETCBzKIjXFikiccrY3SKs=
X-Gm-Gg: AfdE7cmjU4+ZIFU208bCEQFsTNqTnSm3U/nQlTKtRECioC04GTA94TwzpBomg26VMBP
 ZphO1alNdQJXL/c1EFt/aBvC7Gym8FI4GMkTCrBch4zm6fPDHS6WcTqraGGWKmgjPXElxXLCUfd
 raj3F2hAe6jkKAwkIhhir3j3GrU9Ity2knS3eD+fTkbSngp0/wcGjYV12j6fV6ojUA+ClIx/U91
 aqDVM+mYnR85GfR455GaUfqYu0ej4iOKmSYAzxzjioe5vNMADooQGYug0z/z0GTGp/AW4qFM8M3
 AB62Xz1ukcahW9fq3doghy9eBjbi0QeOCnhX2eo1V3jJqFHl2/Unjp9fH9hlgAYO61spYElSxri
 3Br9FubaS8f90GvL6f2ZDHNu6pcbSDfaay8trncF6oMvwKsUjeHeJd1toahEoUA+DlVeiVcTjsF
 dbm0h/bHq6MC0AAE+6t/xhq6l1ZygD6Q==
X-Received: by 2002:a05:6000:1846:b0:473:cefa:98da with SMTP id
 ffacd0b85a97d-47aaa60de86mr8534994f8f.10.1783278876921; 
 Sun, 05 Jul 2026 12:14:36 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:36 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:46 +0200
Subject: [PATCH RFC 12/13] drm/msm: set ctxbank and asid based on ring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-12-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=1658;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=GNmboLcpB1u+4sbu+20YXtJhFgR6gBIC5iE7jNeRoQc=;
 b=rmC2QQUsBeGBctekJrkX9Bu4XpWytNrOy081NaDsxEdKs3EL5tzPk65CpjizWt1u9+G71Ip0Z
 pqDS3aq7HVdCwtuw5G8Lc0fcU6h3n5cTjmCTycxplXu/JrouOa8zMbf
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

qcom-arm-smmu always maps asid and ctxbank 1:1 and lpac is always 1

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 4417a9d04d7c..a8a061652ec2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -247,7 +247,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	phys_addr_t ttbr;
 	bool is_lpac = ring == a6xx_gpu->base.base.lpac_rb;
-	u32 asid;
+	u32 asid, ctxbank;
 	u64 memptr = rbmemptr(ring, ttbr0);
 
 	if (ctx->seqno == ring->cur_ctx_seqno)
@@ -256,6 +256,9 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	if (msm_iommu_pagetable_params(to_msm_vm(vm)->mmu, &ttbr, &asid))
 		return;
 
+	/* qcom-arm-smmu always maps asid and ctxbank 1:1 */
+	ctxbank = asid = is_lpac;
+
 	if (adreno_gpu->info->family >= ADRENO_7XX_GEN1) {
 		/* Wait for previous submit to complete before continuing: */
 		OUT_PKT7(ring, CP_WAIT_TIMESTAMP, 4);
@@ -313,7 +316,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		CP_SMMU_TABLE_UPDATE_1_TTBR0_HI(upper_32_bits(ttbr)) |
 		CP_SMMU_TABLE_UPDATE_1_ASID(asid));
 	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_2_CONTEXTIDR(0));
-	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_3_CONTEXTBANK(0));
+	OUT_RING(ring, CP_SMMU_TABLE_UPDATE_3_CONTEXTBANK(ctxbank));
 
 	/*
 	 * Write the new TTBR0 to the memstore. This is good for debugging.

-- 
2.54.0

