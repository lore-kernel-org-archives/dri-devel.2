Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDE3C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A51C10E185;
	Mon, 21 Sep 2026 09:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Amup60Fy";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E76310E5CF
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 09:57:44 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48583cc7ab1so1277590f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 02:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789984663; x=1790589463; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A2xc+qsQafrugpGNmAo+OH/htlYRtASP8SBfEBu5jl0=;
 b=Amup60FypIVzil15xOMkZBLXWZH9WsPZ208lsE9rerOmS2BqQw1LCH94aliKJe8wy9
 U48IUBwC4Zi2VLtatHowludUR4SZSo3M/IG3yl5psWe9tkJ48/3ZidEtpf6PZoSKrEvO
 5tMvUR8L0WKLhyouGzxlr1YozFNpp11tU1X9DMRPVkS46qJPeIKLWkrmz+f0acBDE7eP
 tUtl4wfg1AbaZqPWyd3hmtIuv+7cTnmVhdXg8P966SWb9USfkH4ACPufwNMVzWkXKPin
 i34DENb7o8bNQCQ4HPF9oK3v54hRSEg9tPkWYBGydGX9A3jf1OlPe7Nig+p22voc94dK
 HnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789984663; x=1790589463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A2xc+qsQafrugpGNmAo+OH/htlYRtASP8SBfEBu5jl0=;
 b=FmoqBMV+k4apFTNcv6NjzGmu5xnag/Qlthg9yU35Cec+L16oe1UQWFJVm+0pG8q6zW
 p6b+HJ88f7y/xR/2NQYof0StKVpkSVeScrDwGzS1IHl4zzcpoYSAHN7T+xHcQfOkxjdS
 pROqra1y5Ab39ZYeYEEci5wejC79DzNtNDu4cd4fgMMcQRIBhM6DsiBqyel8GsXGLsKR
 22LfXtL4G2y48jaPL2oKSHxaMUsJb5PNrEnYtl+cHINBiS6SQMzOIxnhXbgbHGJZQhUN
 rsLjZ739Q1A/tvUKRLEvXQX/P3Dr9+BR/p1kz82FXHDu6Gbca5PrZarcD1gDuFdVRoPZ
 gH8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRdRu2S5NGw3ogBDNSDsNtPZaReBpBCS6G8BLDIF+oQZtUlwpw3AkFZ2/mgCWKZb1HQKrTfAXtPQQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nNAoDB++kNlT/qYfKoFIR5EN8OAIy8B+Pk6tqrmQ+NmoKHNGFf
 /7XEut8R+/nFXrl95Jmb/Gx/wqNq235YfstR/i9ITZkHlGADFL0moQo8F6Am3ihkU28=
X-Gm-Gg: AYBFou2fkcuKAn9Dn+EtuEl9JEWI1JVKJxeIB3q17B+6CBPQZg9EiqXFuWntkGcmKgo
 rN/MBJTbT1XunKKuazDeB3LnnQmSG9Yhq+MLAmHxtrv0/jD7nJap92TLchLUMIR3vQvOy5Iw2KH
 3HcZsepLK99UjvjuXHj+V11ktDqxYIAyA2MbXIxVftAF9uEKljzvf0/nR3qNTIRqpak3yP3vFoe
 9BWJQ85g/mQTJVB2CPvrDHS/iY6VYaFeuY5CcgsMTeH9gYSkVcUxaI3NoSqbU/iaF1Cr/diT+7u
 Cu0vBCwip1Sfky6Hi4IfWtlVyWjPCL+/IW/vWAT8d+KNesdoUgInMTRQ1HAaSwSCfOc69/6FThs
 AliyrkmyBHtZjxvHTxDeRiebo85vuO266/PXJEdfVFXeRrROjfFFWW2tVwTr6jz630o7H7AN3Xp
 Qr1cKmLMY59GCSaPB8CKRPkwMcC9kNl0uNzGq6FiiyA0z8sAzrrjut7R+ByLdAwJZsTm9KOFkcx
 OThuO/FYO8zZ/GMPlM=
X-Received: by 2002:a5d:5f4f:0:b0:486:f4ae:72a2 with SMTP id
 ffacd0b85a97d-4871e2131a7mr14971582f8f.1.1789984662478; 
 Mon, 21 Sep 2026 02:57:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-487243cede9sm23826513f8f.0.2026.09.21.02.57.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 02:57:41 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 21 Sep 2026 11:57:34 +0200
Subject: [PATCH v3 2/2] drm/msm/a6xx: Use CX AO Counter register for
 timestamp on a750 GPUs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-topic-sm8650-gmu-a750-timestamp-reg-v3-2-2b9015106553@linaro.org>
References: <20260921-topic-sm8650-gmu-a750-timestamp-reg-v3-0-2b9015106553@linaro.org>
In-Reply-To: <20260921-topic-sm8650-gmu-a750-timestamp-reg-v3-0-2b9015106553@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=g8ArJ/OKChRPzb8qhim0ptPdcxny/b3SFpmVWrXASoA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqsP+Sfg9qJ/ZVvzGxGlJdiPX0JbGHW7fcR4nvmEuR
 oOVvyweJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCarD/kgAKCRB33NvayMhJ0Z/pD/
 0bggloxuYi0GcmMUXzlQAMYt0+k4/uwsup8W0CncampfsIwDSTPe4CLw54pq5pYeh/95EW4S7OfZfi
 HZoqM5zuA6pdxsc1TIlSvnvyyhTe1jFPlzYLMR08tMbFjtn8AoQ+3FWPGRbbpGzUoCHE8mg8FB9bD9
 rzC6D6Y/ikMh54rurR/UWqWdXjLTNGNuzLMxfEQ3YxwmKFOTPIQ56YTv3Zzb1FS2CSUsYa/z2uiM18
 B7DmYa+yz8PNgPR26+EfITAJyPFZsgME+gI2Ne9h+SXS4RyJgZWKu5WRsYb75xl9R4uY5DXv7Pziy1
 HPLz+kiedtOcn2VraI4sKhN70aUoV5vAWquaFEbgZhelRCiDMzf+LztSoXXh3yKHhHbO0SZGd00FKa
 +FFuNtWxT5TyLErGH35QmIr1/HsimWsVFnrgQmvXbPlSmop5elxOb/3Nzt043h6mO4G8+WAzfyyr/B
 heeKChS9GvWg7SOJeR/gnMeEBhmMhjMxtvY8Tyg+l5xbMt/fFiP7eBCMKQnSpYu69ho+EmYu5HhP3X
 qkbjc32OXOeobIo/iqZP2UURjpxX8uZk5G4s3UfBSxvbP5gTs+20BSythfEojbKh69ghMEDf1HUOyI
 yf5xIzxmEARPOPGbIsVGW0V7ztHsUDlqRdkdLdsuMwdWqP452Ni4XNDf1ZSA==
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

Fixes: cfc8b48649e1 ("drm/msm/a8xx: Fix the ticks used in submit traces")
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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

