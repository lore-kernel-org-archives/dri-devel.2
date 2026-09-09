Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F49C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2705F10F104;
	Wed,  9 Sep 2026 13:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k2ItTXBB";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12D7B10E554
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:07:45 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485b1d2874aso176093f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 09 Sep 2026 06:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788959263; x=1789564063; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vhQ8dnMMSXYBO5z0OmAAA57hjGRa0PP2+u3YEd9RJZE=;
 b=k2ItTXBBUG0biaS+ivLf/ZVFHT9BxIrbHzOwJj1LZodQmbfa2KZLyf/kqLUw8YAgoA
 HuhnVX9BCh1ZUPOO+LqB+HD5GC4D6+P6ZnBoMKySVnFODhk4bxG1vU2rq1OP4eyTyeuI
 v6R5mOCMOiLnj6nyzGPAKT4NPFUT330u6xj+5gyIhEzVj9tK01h156ItXJEJHp50lM53
 FmkdpgCTIFIItur7CVHARMfbalyY9BUTOCksALDfBKYGByHXybdLw1UPukwX3XQFnOMW
 sbX+tOob/qk7VNXeF5zMMsjGO0nNeB53RngfLPHtV4u40sMTDPnloZ9+cji7vmDDTV/C
 SBJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788959263; x=1789564063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vhQ8dnMMSXYBO5z0OmAAA57hjGRa0PP2+u3YEd9RJZE=;
 b=Xmi2Wdp3EqvybfIrex/3ElXxGBGh6hY4vV2xGDz24ZHaqv4P48+BztXs5ybae/wuzY
 3JZK4HWI+wR9JxAowsqh4rZy2lGgMqIuNAjGY8lQ1/gk2XeJzW4F1adFC93wKdysX4kC
 MLoYtGLXO/RSe+RY1xJLxzwjZHzy07WUXLPpu8L7tUCPwYSEAktckrx5guj+WCsZZznG
 ZdDEdVIQnKSypApj2+ZUyBHgFDXpIdCbYsJs9xXdhD58osy3vE/peCwJ05uUDJFxSocr
 DB1sy1lwgS9slW0t7eNloHBJX8oVoG/tarXk4KPA5tbPEpB5BGoV8nR71eej4JGehQ8Y
 tAEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzp6RXZ84NY+EDr2uqsNBgJuWNmu3g1bf90NkTrm6eT/F2kCthw3gl0xQ9Q02RsAhgT9N0ShS8PdiQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kqcKA3foKzIERINLCaK4OBqoZ/VVcfBtpZAhL1Z2RoDlmZg1eU
 mx8UlfXtTl4adasT8EEp+ktC+tyVjQHH091G+U2PcCiOcv1eHMAzm6vj6Ky76iQqiKU=
X-Gm-Gg: AYBFou299JLjd4S9/IB/tBx2JYWcR4vsFPZ/atwcGAsuN9kfCQbPp1lHmIq7Lu2V3Ns
 YI4BNEqTvORq2nvqz0d5BzqLvbMueY5YRnemgJ0c/IZJyuY4V76PQZngmVOCJyhnfZKBJA81RVX
 KWaLTMcpFx0aBxwEv+L6P/oL3yHGW0Ayfw4WSE5VoL82rXgAyTy9AA45ojN6+Ee1bM6dhlHri6Y
 Lyde7IkMfSfuF7uqnuT14p9wS7zimvNFfdhK4XXJGMYSn2agbOLDcl/+1UNTyWc3SUkher1fTST
 BdWjN9VuV2aBh0QhzP4CvEPag9V7bg03M728JORbaP39YuJUgy7wzCHxPxurAWL7MvMxW/0oSXp
 xmdNUaXjJawaJpJ7yBjvM+2VpcOdZ6I1X9tYJIJpoJpxalwoLv9herJbE52isHjvRSv+RuVzwDH
 X5D9WI3DIr4iYETLHQ7FHaC5UTau22FhAkzJasS/AfyoLWzBxoaNuMALEb8+VMIESoV0nPn+UyE
 PkIFk2OQJQIG17c5Ds=
X-Received: by 2002:a05:6000:4801:b0:482:f61c:7cdd with SMTP id
 ffacd0b85a97d-485ba5ac39bmr3264342f8f.4.1788959263366; 
 Wed, 09 Sep 2026 06:07:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883927a3sm34031175f8f.11.2026.09.09.06.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 06:07:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 09 Sep 2026 15:07:38 +0200
Subject: [PATCH v2 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-2-091d74958951@linaro.org>
References: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
In-Reply-To: <20260909-topic-sm8650-gmu-a750-timestamp-reg-v2-0-091d74958951@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1668;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=E/My9ncjedyj86RSIW4IqQNhl5mZctXdRI+O7IRN0Xg=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqoVobWagEdlOIJeGoAoJPEc+PsgA62XSekFt8u4+f
 NGykKkOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaqFaGwAKCRB33NvayMhJ0UCLD/
 9/68Amb6nPQBbNDUn9tZp6XTD/MFUbly5GKO4KLPe49oaJZW+c11rEhm1ovfjdxqDfpQJAlPlCwPmS
 Kmh9meLsu/ducAS2/94ZtoCdvB5+Mcoc1xj6vIn16ieX9NwWKXEYAMhmbW2om58IJDCBEjzxmNoHqQ
 5BWLqRWAKUOmD2xmyVml87hCBuQVD2esSDtvqdLHp97IaN8QwyFaH9edtkrvfjCEg4sQZ9MiHOSp8G
 qKTDYb5LLaxBRY3Njsj9AbLvaEe8aVJfOJWhAGhcsS7g+76oOVyPKUrgX5UD//WNcSLL10mKLpU2kG
 PZzyQGIMPbdAA5eqVUBdtMHwTvBcdcuh01t8PPOYtx3fIoUtsowBTgD5R8xOWerK5NbJX/de4tT4QB
 RCthPJqJnkTJJiL77e15WuBNsw/3jSHenieNdSHspCz2L/T3OdvJMR4iDkJlM/o/HyfbESFv8qHR2U
 O+igVfLnjGS/02pmHwPA3/QpwD8kSOH4/mv/Yr4vsvCoiS/+HpaxB4cK/VSRRTMeKWM2YfZFQ3Mvi2
 SISu9F+RSk4krwGgYk+unRMxsVypJRcFsHGAFpQYByz3lMeFTx66cgpjt+Wjm78U7fAyAmXk+xLaj7
 1bQM2lmU9+QPTZPgKPGqLL+/BN5ef4DyvRHgnnEyd15DS8eT5FdCWmuGn7dg==
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

The a750 uses the GMU CX AO Counters instead of the GMU_ALWAYS_ON_COUNTER
register on A6xx and other A7xx GPUs, use it when running a A750 GPU.

The GMU_ALWAYS_ON_COUNTER at offset 0x1f888 doesn't seem to exist
on the SM8650 A750 GMU and returns 0, but the CX AO counter at offset
0x1f880 returns some proper timestamp data.

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

