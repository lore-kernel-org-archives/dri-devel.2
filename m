Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67572C43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB6210E417;
	Sun,  5 Jul 2026 19:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SmC6Nbu6";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 899D410E359
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:40 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-493c733f15aso23263355e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278879; x=1783883679; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C8zcaiL31SCCh1YPdlPY6GbxJWdviTylW/ogJ//b4zE=;
 b=SmC6Nbu6TbcHRq34dgZhUYMcGXtq/evx24YdVaehyT03NzMLBb/iTpTgHjap07Gafn
 pfqzhMtu4ukRf30COc8k8bV4IoNhr98EJdrTA3GIzMzGRkSCynd2NXQdPgncjOMau/SD
 qWTA+eXQxqnk5qCljlduesKMpg18A/Khx/P0/1kAU4YujEwScQ6J2ROAyqPs462fgO6o
 3ptec2ffcymyNlFDuh5SI2SGDKW2mie9SYTbFPcgWvpurw/rKmJGQBvsSzRhxz/PFfrv
 POBdqlm+DWL2Pby3nu7NFdpQC/f/ZYI3KMKt3L5LWO2/keXwD0+u4pcgK3Qb4Csc7eWe
 le0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278879; x=1783883679;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=C8zcaiL31SCCh1YPdlPY6GbxJWdviTylW/ogJ//b4zE=;
 b=jvejAY3aipOJTWjneF/rwIL3nFHHbR036sTfEZXXAbUsn1AkE+0JJhcDKM7/t4dwmx
 ssnHQGJOuXUm3Rhd0Xpwh9bj0Un2td9Zl+TtIOrw9EN+48a8rP/ydy1Qtsm7c24RbI+I
 dsSu8EJkpy3QaPDv4JrX2fh9WFkJfIH1SEwQ0TgAdI4W9EG69/z6aMgESfKnP9O7YaBw
 jKIrM0i/eC0iv/DoYjHuNwxfK2vcqUyibn8t2+Homi6dJoHDVJWumSjlfWGX5vCuZzoA
 sCCXvcQFggpCqfqzmbJjQSoCLjpdLVq9s7H8XDTBFn44CDDK5CMZ1/JUzu6kPzG/NMhH
 /A+A==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8sgTl1UzOCDjxzNntPZjrZTHiFmMhjmAIOr7iWfJVuMwv0Oi2fobkrTeyyd/F/PYJvHsImhsTJJk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVWd+zY/eZjvXRSrtsfbbzHigckrL6tluKctnJFXcE76JmPHs4
 P/v1iv8wFiEXXijL4Cd1dOOxj3RtLmkuNmNA4RlTMoaAZ1FG50DaVp8=
X-Gm-Gg: AfdE7ckJOjurfCCJH0KRei/iDLvU704M2x6i3IiN+nS1WwkZXLOZwGr+Z9xrB5vKXIk
 pxJUhhIlOfK1kEKFdeennLc+lpzVRH204BqBjFgR1D9fiZVJmKfXvn+lMCnQ3LiRXnkdpcMCsJ+
 yU6kqzWLg+ygWhu6w21xKlDH5hERRkrWSCTZQgi2lPbe1iHuuBs+4yFgD+ykoEJ0rf4tWk61IZn
 JjSqX9XeDz8e2Vl0cSW+YzybxsAc/Rz4bUQuAjA3QNFXht5r9vbWF+G8pJyOxMxmr0gv/YnwApu
 YMqaTQ79LKvED+oZPNa8AcGxmdyWG+ysvKDw5ndcJSll4D6sRw0a1RK+RNhIpkAnWANxsEA150S
 t3DxiSAepxGGdV6X0AItzyuapbhEaXPc2WXbufUZFXV5aRJT1Kx8r0GlVEcnUAarLHHvvFQM7MO
 vw1RQolDxPRsrpMG4=
X-Received: by 2002:a05:600c:c16f:b0:492:523f:a3df with SMTP id
 5b1f17b1804b1-493d52ac417mr60885215e9.5.1783278878843; 
 Sun, 05 Jul 2026 12:14:38 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:38 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:47 +0200
Subject: [PATCH RFC 13/13] drm/msm: add lpac ring to devcoredump
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-13-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=2731;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=wmCqgt9bbc7y6girDLeQUG/lasgVe98klmVzcoHOM/o=;
 b=PVK05TezP6oByIlmJqXX6RCKZc0Sfa+FvqbaJD2D2MNQt18wh5zplyqPzMUoPj4wq2v3x/AHS
 ORhKtsBbYDeCcbFNugaM2rR3PLhNr8TrJkg/x8sEhnkPAzo9vnVPIw+
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

Add the LPAC ring state to the devcoredump for debugging.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 19 ++++++++++---------
 drivers/gpu/drm/msm/msm_gpu.h           |  2 +-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 94dbec9464a4..030bb1aeb7ee 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -782,25 +782,26 @@ int adreno_gpu_state_get(struct msm_gpu *gpu, struct msm_gpu_state *state)
 
 	ktime_get_real_ts64(&state->time);
 
-	for (i = 0; i < gpu->nr_rings; i++) {
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
+		struct msm_ringbuffer *ring = i < gpu->nr_rings ? gpu->rb[i] : gpu->lpac_rb;
 		int size = 0, j;
 
-		state->ring[i].fence = gpu->rb[i]->memptrs->fence;
-		state->ring[i].iova = gpu->rb[i]->iova;
-		state->ring[i].seqno = gpu->rb[i]->fctx->last_fence;
-		state->ring[i].rptr = get_rptr(adreno_gpu, gpu->rb[i]);
-		state->ring[i].wptr = get_wptr(gpu->rb[i]);
+		state->ring[i].fence = ring->memptrs->fence;
+		state->ring[i].iova = ring->iova;
+		state->ring[i].seqno = ring->fctx->last_fence;
+		state->ring[i].rptr = get_rptr(adreno_gpu, ring);
+		state->ring[i].wptr = get_wptr(ring);
 
 		/* Copy at least 'wptr' dwords of the data */
 		size = state->ring[i].wptr;
 
 		/* After wptr find the last non zero dword to save space */
 		for (j = state->ring[i].wptr; j < MSM_GPU_RINGBUFFER_SZ >> 2; j++)
-			if (gpu->rb[i]->start[j])
+			if (ring->start[j])
 				size = j + 1;
 
 		if (size) {
-			state->ring[i].data = kvmemdup(gpu->rb[i]->start, size << 2, GFP_KERNEL);
+			state->ring[i].data = kvmemdup(ring->start, size << 2, GFP_KERNEL);
 			if (state->ring[i].data)
 				state->ring[i].data_size = size << 2;
 		}
@@ -1001,7 +1002,7 @@ void adreno_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 
 	drm_puts(p, "ringbuffer:\n");
 
-	for (i = 0; i < gpu->nr_rings; i++) {
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
 		drm_printf(p, "  - id: %d\n", i);
 		drm_printf(p, "    iova: 0x%016llx\n", state->ring[i].iova);
 		drm_printf(p, "    last-fence: %u\n", state->ring[i].seqno);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 263dafeb9652..4fbf0dedc334 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -639,7 +639,7 @@ struct msm_gpu_state {
 		void *data;
 		int data_size;
 		bool encoded;
-	} ring[MSM_GPU_MAX_RINGS];
+	} ring[MSM_GPU_MAX_RINGS+1];
 
 	int nr_registers;
 	u32 *registers;

-- 
2.54.0

