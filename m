Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D20606A322
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=toT3Z7iq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 385E11122FE;
	Thu, 29 Oct 2026 13:53:48 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E2E31122FE
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:32 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so1785404f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793282010; x=1793886810; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oLv91LE6Hr8ep188oveO3sPSclyk8z8F6MAQFei+jPI=;
 b=toT3Z7iq+dg0pcyl/yE2q+sehBkGvxRQJmmblSNz4HLhfMqgSsUkLSLpMsknTXp97x
 HVBX4y4Jr/mVloLBFjv0k1LcVNtNkcw9MrQZLSyYVDniblc7VtAwu70jbyeR09pbUJHP
 Oy5UjrYq4/32uOYErWCCGh4bH95ewoGUG21TS3my+25j1OZJ9kfc1xkj2G0A/G+Y6RHA
 DG8FVA7TPB2Qtno12ACaHbe/06Ec87XisTcTdoc46ZgDIsSFuddt4BLgfQjXflgRLeD0
 FR9A0/aBdJ270Z/w8c4n2uuq7VccZ4VPVkFifTdv/MRnD5i3wHQ51GBN2zP4FpKNU7Wp
 tihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282010; x=1793886810;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oLv91LE6Hr8ep188oveO3sPSclyk8z8F6MAQFei+jPI=;
 b=BYE2PTuxitOcNfKs4hBuT6rz84Kii7V0gE2TPNnw3vCPbOdSQVu2vxnzlONBL5WrO2
 4AT2UPqkYd6d4DXohhfbmBN+mesjJRbYulfOrgJx864Fls10RSfgTu5HUmoq/HNcNBR/
 5Yy7LjzcYJACzMLjGkCRJFsvKTR8VfTO2C9iG2t1KO+5wCIW9wl4zIjpPspiivat9mDV
 +t5sjqmAipE3NHuohdqaXdMfSPXHtA5Lt+CkHKtonY1ja8s9o6bdL1620x1V8jeyPDtU
 YwzaVDgLvtHbhUjs/Gcz+mjunkg78cnD/1uIV3ZCG0/RmrER7uHpdm7duQz0ZLNAx3Zl
 tiDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUvsYU/zJRjVu6S/m+L2TjnoEhgPWMv0yLfHR/x47ExTCxOrcwzIP/N61dGG02pJDJRQB/zE+/v6s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIGaXPU0dFcj0phPT0Fz+cWPekz9VBjQNpT8RC6ytV5LDyaM2zA
 IzB+u32m0zoNWM7geP0RV/mR0BsjdbLCoi56rMiRERxJFh5sA1Fc8TQ=
X-Gm-Gg: AYBFou1xQA3AMpfaIOsOg4bS6Lusuxcyf8oxchFaWjXWT6O9AdNTHcIP+YG/xLCSroh
 Km+/L6uwjfYXrapx0/xo8ym2ZWIqHg/u4dUqZAgvSoNZpQxtYO6ZYmicB93uj9JPh7dYjs+Jfwu
 2bb714yZ16VE2CQGIaEyHXYnEd9coEnhPWQfr8KGab3mFbpo4EyX3InGflHATKiVxFJ4RZ90EaO
 cPI5INBUTw485flFqzm6dcQ9NPvcyBnclDJhVao8bAPJHHp5pIXkBnpsinL75Go1UE2l+YXY1Hv
 d7YQzSvUEa+s3BJEJWSjRXYOJWyqIHIHh8FVuH/sJsp5A2fkNXJRQxS5apaeqt19Ar+2NBfC3C+
 kwId9x8x1mpzzCilJ1Bc6lI6Ry7Its5kU+mlsiVyt34lLkmrWVWEmY7reL1TdQH/1AI4ccCdPDP
 xjNcYK+MKiFGJ6ACcLal6lJNsvTvXxDKrGpvRPoX+Jia9/UY09yRFnL5ripH3U8rvDbc0JSV2bu
 uIdPDPurjyP6zkqPZRvtROVPoE9v40dPdfveLpjNJzs5rf9mI9cYh4ZrDwcgwrjNiwRKO9Oc2Oz
 vsFFhe03datXSrMAmLYI3DZUImXGj2/pAsMinN3t5/w02g==
X-Received: by 2002:a5d:5e03:0:b0:48a:f354:aefe with SMTP id
 ffacd0b85a97d-48e5d468159mr13722390f8f.39.1793282010340; 
 Thu, 29 Oct 2026 06:53:30 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:29 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:48 +0100
Subject: [PATCH RFC v2 11/14] drm/msm: set ctxbank and asid based on ring
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-11-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=1658;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=JeZ/oDOWBrzzXnhSTsaX5dWsSADptm5HwF/DPV1Xv4k=;
 b=4M7VMbDwjOepIjZPrdycOsvEBkNuot2Ltb1yMKAeV6IZ8onsZj759zJ8VBrGw6EwZ2ETpsOXr
 1DglU23L6d5AIGkk239c64rud6FZXnrAbBlSSiEjCojZ/rkF2k76XQ0
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qcom-arm-smmu always maps asid and ctxbank 1:1 and lpac is always 1

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e82d0c0bc10f..57fc4035a753 100644
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
2.56.0

