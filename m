Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F16C79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C3310EBEB;
	Tue,  8 Sep 2026 13:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s6fdLnS4";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E421B10EBEE
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 13:24:25 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49b0d8bc2aaso58204385e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788873864; x=1789478664; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x0TR0sJR5elynErLxudc3GJkwyMUOKu74/0krFherX0=;
 b=s6fdLnS47eH9YbQFLMp370xMbV/92iBW3zC/in/Sa8PEG90kpXP5lOlu8lJhI50CD3
 AC3vGgpX6BgYMYDLeTfXFHq9PfolEt3RQuP4aT39OcovyRBL/mSp1tdWuA/sv5Trm7Aq
 eQnpvEb/9U/nU2KjF73EIaeCXmW4EgLl6CF+XCg6NAmE6oZJ11CqIJhiwjHXqm9HTGCl
 he4zziMWPFiaAZCGChXHrwEdxEukjM5FsvdT5Isi6R4peW1PKnpTjGj2erJeW4Tzb1jO
 XsPZ4OBck7iB6g7xqlX3mOzlkYw1N5bQD+q9jFuAubxZ+pf2VRn5OFPX34vwjWEh3qVO
 gqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788873864; x=1789478664;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x0TR0sJR5elynErLxudc3GJkwyMUOKu74/0krFherX0=;
 b=IY50yaHW7QKUCABCZoOfdr/32fOHp0WazgHtsbEGrmL6iuk7rzqrFmjEeEY3bwUEZW
 KOZre0OlyOKxe1Kiz21IPFc/Y9UCIQ9FRwZndTG0UtzaVk5IzDdJinFwYRv2GeLWAOcN
 ZXIvCgPz6PQzVihd4A+Lwf5FoSo/uo2IjQH3hGx1Iw32ffJWazSdoPAcs2DMFMpP98hC
 1k196IRBDR+fBMLkVfGN9q5F5jTFhm1LJsOLDWvfs1I5gw6LzgbUXCh84qcUnUR+I5iG
 TmpcwgMX0RJ2msAG2WQ+L2WVH5nfB0Dazw4AKMBZTTUWjEPB6zsrumRqqKchPXuDBSjC
 FhcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByvhs+yyfyZKrqnDlngVhFjsm1xD/MiD4lEjY/jRAhGYss1dggOZbvXNtqe6hsxd92Ri4jvtD9/L4E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nhVuOP1mqFCe0WmQwL/fT7+r6pMph/JgWLvtf3XgM3AxAmhK9A
 HDiixyDmHP8Cs8cu/msNwiAgEePWCzksT9IEe6vL2Vj2w7VBHmV0meZHcLL8krROq58=
X-Gm-Gg: AYBFou0dS811UOHxM/etfYPA4d9hSgebm0Nbrg/Rkjxez/h3iIfaLzdCdzV7+NGSlMp
 q45aOKQcsZlz/jdPcgcNbhZTs3Vfqw1J6CAgWcoJLM36LaNEIBjCpA0wDGT+3O1biwbFlGjTupc
 8GHR+aplFZRoZA7EVRE19cEK/u6j7FWQyw6/VGUWKkQmhqibeF3CPg7EudgSxXLyUwzhKXzPxkw
 I2CITiAOWBTZC+P1QBdg4ImcW/5vkLgl/Mw6Zb31I3Wxz7T8pUOKpP5W6Pzt75gcTb93+vI44Dr
 l5a4xygX6SWU3gnnCzcSPodv9nsTfd0RHvRxxGlfNVGLZgwF7l1+mp+mLYUphlcgtaI+Pwhs+7o
 sSBKjvdCcB7k0kJxjDrAtV5oXcbKbXEvl8l9bQqpg1/FFL2/Elc3cuzIlNrq78pBfx0+5dwqTgK
 qGVgou3goOPXRG24oHtbllUSZA2hz3Nr69cmgc8o9J8C3BZaFBOr8Xx0r2ZogrA/Wh6RLTkENGt
 O7J4Qy6
X-Received: by 2002:a05:600c:a49:b0:49c:fc6c:be0c with SMTP id
 5b1f17b1804b1-49cffdc3823mr223604815e9.18.1788873864056; 
 Tue, 08 Sep 2026 06:24:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d07b371afsm298959475e9.9.2026.09.08.06.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 06:24:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Sep 2026 15:24:14 +0200
Subject: [PATCH 2/2] drm/msm/a6xx: Use CX AO Counter register for timestamp
 on a750 GPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-2-284880d6e68b@linaro.org>
References: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
In-Reply-To: <20260908-topic-sm8650-gmu-a750-timestamp-reg-v1-0-284880d6e68b@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lTxs5IQG2/5Kmpd54ZU4s/260yixN2la81LhVDZBsks=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqoAyA4vMrnOAdDDnXQLU8O6CGKN2a6I2XPJXTMela
 hNLPsbeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaqAMgAAKCRB33NvayMhJ0VSND/
 kBS12+xPAnWKPwxOBAPU+LYGk5mfWYdzc6F1rGMbrOGjUuZ1IdlN2lEaerEpIKZZyfmqoRal6xzkJo
 e3g1wv8EglBOGdLCYua952EMQof9eVztL9slS5TzmrMWroAVQt3DoPPTmCr3qpSJf7s95NbOnPsE2o
 8BgAWYsh+0KanTlDewh8SGKfOA8TVcwA/9GHdBjLdj4LkoYjBYUNrJfTWC1tSV+uvW7o9F2SWwONlh
 ncRA0BQA0D44aUtnfhBA66k+sVEU/Wpt9ng6Nft1DM+nJAMOcBdNIeYVAByHXvGYqSybmDw/aJmTd3
 Ys8K4dOMl6awY/FYuLKl1SMXed70tc2zHGjAXA7eFmMQ2b8Qrpl29ORO1AHRaLzsULYqt8TusXrTzh
 JHFVYGu0WrLe7XuPZuXKebgOPOxnGgLoJFBU0SmnzI7k8ZgsVY1fCfLtwdw3q/m1u9RREHTK8urfP7
 1S0VK6O5QJFUpMwgywYshFL9vwLcuy9JCoMNj4elA/uD05+aPLTqsRDCxIzibnNcUI1pDqtFOCYatY
 DDdvL/CCJjtpwNHH2BF8EsH58egBOsfYMJbR6ocfU8ubYaU2HRG6Km4M/IsfoZNVwyjDMjmoHX7/uc
 lmCrIaEGpHQqEgbmiBH1acXwplidq5roHDUpgS/YlbTlwWpNTe5V1HFamfAA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

The a750 uses the CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
register on A6xx and other A7xx GPUs, use it when running a A750 GPU.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f9de9329dee3..081e79ea4652 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -23,9 +23,15 @@ static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
 	u64 count_hi, count_lo, temp;
 
 	do {
-		count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
-		count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
-		temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
+		if (adreno_is_a750_family(adreno_gpu)) {
+			count_hi = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
+			count_lo = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_L);
+			temp = gmu_read(&a6xx_gpu->gmu, REG_A7XX_GMU_CX_AO_COUNTER_H);
+		} else {
+			count_hi = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
+			count_lo = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_L);
+			temp = gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_ALWAYS_ON_COUNTER_H);
+		}
 	} while (unlikely(count_hi != temp));
 
 	return (count_hi << 32) | count_lo;

-- 
2.34.1

