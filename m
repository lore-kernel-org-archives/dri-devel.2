Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C89CD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E6810F0B4;
	Wed, 20 May 2026 14:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FhJ8HzQn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d+H0jvUa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69CBD10F0B2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:37 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KCktNG1725708
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6XloU2OeEBOoOyp9QPMtaZvH32CoTQEY7LmlmTrejM=; b=FhJ8HzQnAmcIwAuj
 1X0LwOcccEEvagGW8Y0MIp96vJFC9XUVXrG0J4iyjBa3jPJ+BWfKvPI61efvT07n
 dNq2DjOpK8TNHn1CBpbhA1yYjzlNgank1BGLxBtRqShKLlIOvJAXKOJM17tR1bvO
 XeZqqonj8U7PmQhoQkAE/s6vWeIO9nvB6jGL+SVeUG5kAAD9TKXmXmmw4uOx3Gw1
 TiIQGr2sg/xpjf6NJopd/7BCD8JdsnipHX7AI38E6lCyXhU6+EzL0C6HMyn8SnVo
 56Lxh9xsgwc+Rc5Jc2EZUIVZLCdcrw2dXWOzlGjwkweHBDyu5fWuPwVMbxsM5wAS
 SGQBAA==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3qn8ux-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:36 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-6322654bb6eso8493679137.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288696; x=1779893496;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=A6XloU2OeEBOoOyp9QPMtaZvH32CoTQEY7LmlmTrejM=;
 b=d+H0jvUa8uddfF9GYY+abHKoZviCU+4QgEt4wNNjaqkFQoZUTLlttTuXsjdhu8ftyV
 TFJSFOqO1ncc0NrJ3u2xrQuU2KJfp+CpMpwzIWDbeRwX4q/Gll0oh3ilSkaglPlm7Tc8
 KGosrMi8Ma/Zq7zNqV/LrSnusFxsR2ZuM0GixG6sGHPiIk9f+TLhPZJ3Ej1I5XaYqTIw
 6RUU0Kc63kuoERzglXPmObT+9+8T1/WYSxGGYyA2iHsbO6iToG0kEipKIM6A//wdphe8
 S2EWD3XKeTs1YxlPlV2t1+oRL3oz6m31zWEmIpYr5fkGFniw0tgbBsC6T/TqHRyy8n8M
 lKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288696; x=1779893496;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A6XloU2OeEBOoOyp9QPMtaZvH32CoTQEY7LmlmTrejM=;
 b=l6dv/g4JldDvU42EypHy57vFgjBxI2CLSb0BZZ6TdVLwx8JJ9AyXGqbMf3iNJRYfv9
 ltXYMPhhV96Fk7Q6k/UQIQVeGBbSanQ3M7/wEDO/eWm1nRRDGgN/dgkdlJTKBWEp72mL
 b7DLDN7bdXPpUVEbSkZ5q5GUVOBfDN6O1S8ExgwrLwQsAFJimV1D5QMTGUWA3SZmkDCO
 ZkXnbUJUl3oj4Ilbezvn7BQnYpiw51gse+H6atUNHGGxGsZpJcEJyv9nAPMuHw8is21a
 VD/QzxJnh3GmZ5eCH510Brdr6qXCkzDFO27jHZAKGbS218y3JuCNFUWzI4EN0/sv27wr
 uROg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8yls1KFKj9UsOqKKEKqSBD7w0b92r5/OG0uG1k9W635HNJlvSdyYQj6pVzdHfBP6aTmFLJ4RgULhs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1QkSn+328reUgyHv30Idiegpv7uQHLd8tpvn8KseZq+6pYplM
 nRi+AXhWyIcH3/ue4RdxcWu8uAhcpw8zkuZwbPSXwF+IZVJnGYbzPaQ6E+S6qTrpjGNBt5UGrUM
 RKFeEIc4IbsC+TfqtuNT28Jv3SFsgaYuidI2nVLh+tmgJR929WPAe/wceGrTeYwaUWOWRPTc=
X-Gm-Gg: Acq92OG7zIx+M0dW6WLrMGgOKJWlQdoHI/2FLY+yfqDM+IVYuvvG6X+GE1WZGYXoqmu
 /Iik0UMiXIsK2xtYGW44gTQj7+Ri7KXBxKHBGtXDNtYWENmofrEBEvBhin0wHhBRtRvZ/QlKWIQ
 xuAeQ6Se3i4Yz1AY1eMhrkIpZxau6Y+QKPfcplCOIbw5ieghqfVui6sDSrc+2bEeVzoNgr/MmnU
 knwO8jMA8D+XzLmW2Xm0oaGHqQEjyXAWmOANCmeMIzwLa8PrYAn1r2Aixf21uJsyqwb52n3VfEN
 06Pmb7XjjVo/ZBWpFIvJ/Soviia3FkZoTAsCN1mcQkGPgJ0FipwGi5iJuYsgKYNaH4YHgBdln6J
 7rxr68SGCq6auO3xXGzIfZby407xZyoFbGIAxYnel34siYmQ6LVEAwwO7mVMBH4eCnsER73qfF3
 xzjIPBg3tb+LTs5MiDr5f5jGSTveuzp9WeOk4=
X-Received: by 2002:a05:6102:5e88:b0:633:c6c4:b32c with SMTP id
 ada2fe7eead31-63a3ee7d510mr14583171137.15.1779288695855; 
 Wed, 20 May 2026 07:51:35 -0700 (PDT)
X-Received: by 2002:a05:6102:5e88:b0:633:c6c4:b32c with SMTP id
 ada2fe7eead31-63a3ee7d510mr14583149137.15.1779288695410; 
 Wed, 20 May 2026 07:51:35 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:34 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:14 +0300
Subject: [PATCH v5 07/28] drm/msm/adreno: use new helper to set min_acc length
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-7-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1349;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=HMBD+zQalz6ee/fp488Ht0p3cICpZxvH9sX4/PHcPpY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpmOk/QDc5BszdG1Cy99moG6bYTjHAju/kgl
 KoHccTJntGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZgAKCRCLPIo+Aiko
 1c9hCACEfZlXYi2usBJHOpyfQdxGSG3YqIcwolWkdRupnez7HJd274TK42And+zpnTeQnr3PQks
 k+vKaiv+L87o3ehRk5twOG1CwhoT4KKxBtLcRYe+NIkoWLbmXLitdUAAZT2Ov0ZP6FzldJ7mWbm
 +PCia4irpP2/x9BYaDdojgVOnN6qqBaHpr1FXZZcL64XuMTQxnzJTOz6igCPSnO1FbqfcBSN3C0
 1t/PZ1jYQi0iWwwB1s0A8ucn09FfC7oZNWOjK39LcjywIJR74fXo1dEBFgweJFcZulVjnaJPHbQ
 zybs44gIetawaIcy9Vfch1k023ifY5o2j2Ud0rFy67445cJ3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX5T9JuvC8YxxW
 ZYA4ZyVMURieTNw3MSlvDnXBpjtO3324a7KkngpA6y4HYsWNU1E0bGFoSa3LVXwgWHXPuuN0q1z
 cJax/D0p3j8TFoSRdplR7RKAVK4zl/Hry3lXKijWXhHV1ygm5zpk9wlU0Dhm9jZy6fYkQmdJS24
 Vn830wYG5QQJXLWWzVrAcRKJ3SHkGhri0fPQZPhDQCsUk8VFA0ly0oHkdzcA1pWUizyf8MQEQ8Q
 dmS2qRy0tKFbB64oS9vi2WHxRKBag+MH97eG//1IXdorkNoEM3sGM3wxzAUEOgR/fRJ+UxZylLH
 ESyElIlbmfZM7rnaKy2H4DRr5agE5m604AApZiXkVTKABLKPyOVLwtTT/ygjBdJ+FhmQhG4O53w
 CcTm+kGa0MVbeJGrDCBfcB19gXVLkNo/6pvvCRtLwFM4LtN9Uk2M3tUl8AvOnsIPmcplFufUZFv
 J5H9ybZkE6Axvkh9hjw==
X-Authority-Analysis: v=2.4 cv=N9cZ0W9B c=1 sm=1 tr=0 ts=6a0dca78 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=X-e67srwgh_QgMMAbO4A:9 a=QEXdDO2ut3YA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-GUID: g1CVvgWFov_YHpNcKQHtvqBRyYdBSTeo
X-Proofpoint-ORIG-GUID: g1CVvgWFov_YHpNcKQHtvqBRyYdBSTeo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200145
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

Use freshly defined helper instead of hardcoding the checks in the
driver.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 90e814c64c6e..45c966610511 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -748,7 +748,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
-	bool min_acc_len_64b = false;
+	bool min_acc_len_64b;
 	u8 uavflagprd_inv = 0;
 	u32 hbb_hi = hbb >> 2;
 	u32 hbb_lo = hbb & 3;
@@ -756,8 +756,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	if (adreno_is_a650_family(adreno_gpu) || adreno_is_a7xx(adreno_gpu))
 		uavflagprd_inv = 2;
 
-	if (adreno_is_a610(adreno_gpu) || adreno_is_a702(adreno_gpu))
-		min_acc_len_64b = true;
+	min_acc_len_64b = qcom_ubwc_min_acc_length_64b(cfg);
 
 	gpu_write(gpu, REG_A6XX_RB_NC_MODE_CNTL,
 		  level2_swizzling_dis << 12 |

-- 
2.47.3

