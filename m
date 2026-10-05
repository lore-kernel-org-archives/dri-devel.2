Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23DBCA5FFD
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 07:24:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A8310EBB4;
	Mon,  5 Oct 2026 07:24:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XkSw7MVn";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GOO2o9+h";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A418D10EBB4
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 07:24:55 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69510YHh093994
 for <dri-devel@lists.freedesktop.org>; Mon, 5 Oct 2026 07:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=; b=XkSw7MVnCRbphMuK
 bjyoLMG4IFBKNvkz5dp1xf8EmtvTgIegmXBih6xGCZao19vXMC0G0lVWvWqlTJpD
 VxdteYmfPABtRvGquSTmTgOp7eQlDeFmpkelPqo4TsYkxR1ot0OcFtpUlJtUCR9c
 Kdh45OvTLFr5saHHmTPS8YuLSjitewlTVtaEhyfGfsD8odAE18+fmsJ9uPNZmTs/
 ZgJ2+Vi/aKPJfMQHXmzDKV1keVGOuUz2L9DB9JhkNCh7T5/bcu8ecBq1PZtTzGb0
 vVOIwF/Ra1iG8aLnxeW3ZLqJqHX75YP+WQUdsUfgsmuFqcX4IuH3TyBJa1/nFaYA
 KpmNCQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssu4va1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 07:24:54 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38f97b3f853so1864548a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 05 Oct 2026 00:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791185094; x=1791789894;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=;
 b=GOO2o9+h5j9Qs8scI6JmUfp21ucgjp57nYQGCulbwVuTvQ1LRL6+b8XXrs7SCxBYs7
 k9B9MAfieegcpoJ8is4IgpY31dtWaJmHaX3eEdeOiSuEMfjQAOT7TRJUORoAhQp+uVuk
 t6V3nuaQLD5CbqYC2EGpVGzWZoL2TgMnvnonNktZdig5fWQ6R8BtnuPhmF4+zs4kLbDN
 KyLxCRIwu5kF/EnbPUbx9oH7TZh6LOTiZ2h0c/eQl8bR7KQLdK0P5MZ6Bx+O/RgtJoKT
 bMgzyZcasD0bMQQUGOAdyuMKz2e0ZHtw8ka20VfAU5zOWInx7uAT/kMzHtyVHX51mvoJ
 jrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791185094; x=1791789894;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dPFKGiQSvhld/TyaGvBhCd19kvDTSFSpxWvqUbaR+ZA=;
 b=jXzsYMXQf+EaCELWM3grwpOyclXYblltZ8iRzKeG8aQ6Ix6BmLn1pDHC4hyO9PdZfr
 UeF6OJlHC27z0NSSdGyH3UXaZ/HbY4jJkfMcxFbJTQBV+Am7J3yROBTB2efjOWtUqVCO
 TRCqUMUHwnQON1/xoxtXXY+qdVdNGqH0Wo8PsT4ezSRQUMLGUTZhClhwSVLCRJ7pBSBi
 i55zKAcmYSHAtyEwfFqr4eD9fvcQ4/lfOLqauEa/q7QMRwQZ8/LfuJILxVODEqfclTg4
 zrYwfsELpLgf4LEjpJ0P6n6V4oO9w/E4I24kN48FRG6f3Y3CpgJUcxOan5z9RgkK4k8m
 wobg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxA8a3SPouQzmOK2qHYLxuCtFYw3m+s6/0Vs3+h9+8hSsJYOVpfpyzVRWKy6t6xVtHFlgGF8CKtko0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJNSVOZGupSg69GWEIFqzAkbBL54QcsbzkuWuJSY7VHdoZT0c+u
 tVqsqUZZrggzaM5Wt6zDv6A5VjvUSh7cGWv825dfsGCV6HXHpTcX5YmS+PGu2wFsgRCqTVJg9IG
 JKWY6fkb1s1b3HBJgcBxGGP8G914R0SPfXCzLBcRMEuprhUSmCfFv2woOQpjCIFUtSnoOysM=
X-Gm-Gg: AYBFou3ctS7hJ/59hEsFhaqaOQ4nvXuDWCnj3IcUmCfp8tMaKJC3GmVcOUW3DzmA/tl
 xEiM+t5j45Yst4Eac3QSrhh0+hjx2nIuSUBa5I2hK5WK43e492nVl3Dnv7vLs79o8DveJ7zt5Xx
 KCCge9UnAXQI86jmGYQS2eOJ6h6OxQht1CeuXpveL0TYbWzMZbiBckSALpOaMdZ66AZy5Y3YRgC
 iLEEbgzx9fXURdS5xve90/aqhoDGLwHXq67OLnXYReLWKGNzPY7FuylG3PcjlJ+//gKqC1Ht2FX
 SkJpl8AzXqHfAIArV8b2Vyj/OZoPc8vqwgA41pAA1VGFhHj8RGRj/Kq+DU6FZnRzOkRYKNh2ZdU
 cH4XLWa0n1GyrWriq9qKMD9Rq7ycNALmA5/M=
X-Received: by 2002:a17:90b:4d85:b0:39e:d36c:ee54 with SMTP id
 98e67ed59e1d1-3a6ce606acfmr9757575a91.5.1791185093670; 
 Mon, 05 Oct 2026 00:24:53 -0700 (PDT)
X-Received: by 2002:a17:90b:4d85:b0:39e:d36c:ee54 with SMTP id
 98e67ed59e1d1-3a6ce606acfmr9757556a91.5.1791185093189; 
 Mon, 05 Oct 2026 00:24:53 -0700 (PDT)
Received: from hu-bkalkond-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4f3911sm9901421a91.15.2026.10.05.00.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 00:24:52 -0700 (PDT)
From: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 12:54:27 +0530
Subject: [PATCH 2/5] drm/msm/dp: Add DisplayPort controller for Kaanapali
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-kaanapali_dp-v1-2-6faeac3a6d59@oss.qualcomm.com>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
In-Reply-To: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791185070; l=1543;
 i=balaji.kalkonda@oss.qualcomm.com; s=20261001; h=from:subject:message-id;
 bh=ATHzw5/SdPmSlyNoH0Ua5Hf2It3tpnIynG+5Y/cT+DI=;
 b=Kcb1zhiybcDNR4q998sqyDvMcDS09D0UYeshRH/axXfPBe0mY6anWRqVIVQM43Ns2l0nEO2W3
 MB89awjeoXaCpCa0gpmyZEQrdYSkoqJ4PLWYkI24+SIVymXdOlpSKtQ
X-Developer-Key: i=balaji.kalkonda@oss.qualcomm.com; a=ed25519;
 pk=U+unGox551qPLS2mzIlN+b5cHksxTMGPnDwePd6KEnI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX8X+7k08DC+vb
 5P8rc44XAoygP/vPQ6VtfoeoLLe64kl1uQOg4aMMSP1g7ppqbpzDIqVi9E6GHrx30MWoV3snWoq
 HbkG8OVc5W3E9HN3HdmFd7D6/8EeVY4BH/WGEk0jmaujmOnRwjsM+73r/Ko8Av5TCChzdLIkjh/
 jTIpBNBbvlIGeHqyFzEfn0TtBgzZIZnsot7hn6NIcjaLKgMkAxYoSSF1ZoCZIQ019fkpiHYfRfw
 Okd6vw+TnDgP6UqQsMs5nKL1pApp1PjFoTD/pxhjY0qFEtLKYYLLOZF5zEvdBgroPscxeXVuztY
 eQOMRXipYnbQ5rr0rhbbRMAh1eAH1V4wK5GEwypPk25hE38Vxzmec8Stg6yWd4fYVgG+IxUcbJO
 GwBDP0zet4oc8EaJHre2TmL+LTj/nakjx0x/nGZJx08ROyn473AgPsQLDRNzVoxh5vDZ/urJf8k
 VB3wFKP9c1DkNkaurJQ==
X-Proofpoint-ORIG-GUID: JTApYY55HQ_I0pXt6R4jXIxD4kgdqasg
X-Proofpoint-GUID: JTApYY55HQ_I0pXt6R4jXIxD4kgdqasg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyOCBTYWx0ZWRfX0M9cVpxMXE0q
 FIUZRGmh4hCVHDVIjCCreEaBNHiK4Y1e8sxSDtqmdGwTKMJKwKQBOnFtYhuaGieUOBCj4DfMtaZ
 KggBViqLykSWD/NidxdVLuaEEdIk7uY=
X-Authority-Analysis: v=2.4 cv=XPSl2ghE c=1 sm=1 tr=0 ts=6ac350c6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=-Dt519yxSYS-YsuSjdkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050028
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

The Qualcomm Kaanapali platform comes with a DisplayPort controller
with a different base offset than the previous SM8650 SoC, add support
for this in the DisplayPort driver.

Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9299ce616fdb..348eb6967abf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -158,6 +158,11 @@ static const struct msm_dp_desc msm_dp_desc_sm8650[] = {
 	{}
 };
 
+static const struct msm_dp_desc msm_dp_desc_kaanapali[] = {
+	{ .io_start = 0x09ad2000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
+	{}
+};
+
 static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
 	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
@@ -168,6 +173,7 @@ static const struct msm_dp_desc msm_dp_desc_x1e80100[] = {
 
 static const struct of_device_id msm_dp_dt_match[] = {
 	{ .compatible = "qcom,glymur-dp", .data = &msm_dp_desc_glymur },
+	{ .compatible = "qcom,kaanapali-dp", .data = &msm_dp_desc_kaanapali },
 	{ .compatible = "qcom,sa8775p-dp", .data = &msm_dp_desc_sa8775p },
 	{ .compatible = "qcom,sc7180-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sc7280-dp", .data = &msm_dp_desc_sc7280 },

-- 
2.34.1

