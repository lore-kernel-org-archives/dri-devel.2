Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52095CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 15:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B488B112029;
	Wed,  3 Jun 2026 15:00:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sug/L9WI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NUouiJKj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B731112029
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 15:00:14 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653EbhdG1476767
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 15:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 18c0uCFR0Vx98Z6gn2p5TRyfVjWTgQskztRp85wyJKA=; b=Sug/L9WINtQNcSA+
 VWzI4NBOLDJYWHDxbR1Q2y52ks5mWmpK/zQDBuk1kYiiuIe749UqP8HxcnCXSNfF
 +k4v1Z5ISAxbWErr5WJj3qbI83sK0npm7bm3T6/lBt8fFS/a7ke9CeXLBm0KUaTr
 ITw9IjYS2woEBFMtwqR2B4ZZHW0Euind+QTa160zVwp45K2jPM3h9ma/DBZDwUPl
 r4ZONSuc0YhF1FprECN2KA/DFYpRX7pLFZXHWuZcnTzLV56SVYM3fvcYiYIjD52T
 EeB2ULUr97u5snKtDVXW6Ig6esFb66y+3cqYs4GkTmfZzwazR/qiOlE4vd2mBwP/
 ym8XPA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nr3dv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 15:00:13 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-84233efcaadso2808842b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 08:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780498813; x=1781103613;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=18c0uCFR0Vx98Z6gn2p5TRyfVjWTgQskztRp85wyJKA=;
 b=NUouiJKjRXjYHWcISl7tQr2YLniVAM6USRo4c05uJ8oR9vgLFk3dlDySmcJGCVG/87
 kuMEFEwPDQ2tSbcs+W3Iyn+dOPsw5dj703eG5EPLxd0gJUFfYAAwHJ2N2vgnDlUr0TDz
 CqU1Ueg5XayKPCH7rXnQI38mpOoKmq+YroN5mh6EyyYmOrsu/QYd2PZ6GCJUktB3ewGZ
 KTj2/yOHJ+F9fFZAKT0dOStaN4WIRJNxBfL6PuAKvM5rNn6uXexOksvxYzmeQtwbhriS
 cTkyqX0D5w0zXdhWyRTQkZSaFWuZCBpykzllLJrawRowWqUiXFZijw+SZkKH+gmh61G4
 X3oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498813; x=1781103613;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=18c0uCFR0Vx98Z6gn2p5TRyfVjWTgQskztRp85wyJKA=;
 b=iDfFiCBcgZAOmCfvviwYcGr9kH0wvS/jwUQK95JEibX7sxspWEQM+iOh8mv6Sc+dvC
 m6aBUfITAvFoKOv+sV1or5YUsBd3Kaal/9kW7pizNzXzGrXcIpvqhWipYBf3BjyiApeY
 4BkqJbef3AzGt/U5JlzZoU4Opww7W4iREbRJ2U0P16U2NT1ofaRHK6v8wNslHqqybF0M
 qBbzlL8B2yb3A4jD4c1ZWqUDR5UDrEl2jUzCllgF4dnqSdIota8vGuV/r/Sjop4Iezsw
 /FGynhAC1eneksRYExfozggqNKOMpz8wTiX8KXFz4VlTfVWNw2nnxxNcS+VS8x1O7oN2
 NdGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+R5nrscqJSYjO/VCKmSOLvt6DVPEjyEne/YQlH7Y7e84TH0lUyv6sX0Z0GAAm0J2sIGf7yVlW1B6o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfM81C1nhcJmfBSJx2BaJ+NYvyKhsvmY63+707z38Yt68h+fys
 VhF9ozhak/eAr6DnKzM7RuTGTuSvhAyjyTgNaGRree1YkCjVJbltcx3VDsYhjqpsCiZl+GYSxOs
 EYfDlw46J2BKtxJ37fqG58xg18810Hnuj2qnuSpNu9N7JQbEXsik31XTs3yw9L7wvoLEI+zo=
X-Gm-Gg: Acq92OGNuy75W+n+Nu7oWN3hFZxuHbCGVNWZjqTupyIGxrLHrjf3BnUWDM0/PwzUBII
 r2DNYYUvO5ZzMSiOiuKpYpgzelMpdhC1vsdd/yDCb4PSWq993BMvrm1R/XhlskVsKdn2H3PT3+w
 5ftol0YwZek1RTY7+VcTC3/j5iqPbWXbOYj4kLBLuqxNpCfpdZ9FR2O1NLcguKir6iz/HF3pjWl
 o6SQ3wC/Jw9kKkWHJpXvSekhnYiMn/e3XCyLWR6rKBLMfB2hLV2HxxKXJ8Fx3Jp+eOr/wDHwTzS
 bZgUJtvbvUwUSTkxwM87sNE1tVAdTwb+eELp3kqo3cQPjtLOinOj3V+FelhgXj6NMbpoHbBK8CE
 N0cBf2gF21ZC3oMidVy2j+5lWvpdFqaFlQzTsDE5lLJMvSEUMhA96fbA8Ddw=
X-Received: by 2002:aa7:8887:0:b0:834:e5a2:d089 with SMTP id
 d2e1a72fcca58-84284f1bdfamr3771759b3a.33.1780498812828; 
 Wed, 03 Jun 2026 08:00:12 -0700 (PDT)
X-Received: by 2002:aa7:8887:0:b0:834:e5a2:d089 with SMTP id
 d2e1a72fcca58-84284f1bdfamr3771679b3a.33.1780498812312; 
 Wed, 03 Jun 2026 08:00:12 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.08.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 08:00:11 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 20:29:29 +0530
Subject: [PATCH 4/5] soc: qcom: ubwc: Add Shikra UBWC config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra-display-v1-4-aeac1b94faa7@oss.qualcomm.com>
References: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
In-Reply-To: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=988;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=a7vBq7QV/0yauiv4Qm+n0KSEd9tQP2btOuvl9/RRzPk=;
 b=LODbReeosUf6ztstgUJKlWgizfw2G5LN5Ygs4s0z7okzEppVrZbtrF8DieJuyRHJDpr2KhVsO
 X+HJ7VKFlFUCz+q/m7DTxr52OcTpVegvlvq5s18YKs1fSb0RScsxD/X
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: v53enQCtgPLgAw0hwl675YkwKX8qEU5_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX360/2SLg0cXF
 DoEbU9dSoGjOZ3SwW3xpqphcHZ8JddquhzX6lyS373vUfk18JTs/rFZ+c9bQx7Js77Iu4Lv+YNC
 I29k8t0gspMOy48CHWqgt9p/uVLVRIy1Lb77dx9O6tVtG2OARbh3JaSV3cZzzCHsHOGztgN3eXk
 0lBtNO96Xf4I/RERUHYInEi8dEr5pYVyj6/yjVtffJVXNZE3N1IoMmM0YJspRHGMoLLo4xUAjwJ
 ocNt/vj9jfZZvxxukRUI5ucZTORziAt7GKdBR715b/AjpKmpR4weFbNBxDsEoYZXr0fuG7Q1S0P
 mQ96U8JaATDaNi+Blx2134sdXCB9PUH7tSGg2m+z6ctfsNHX1aQxrsB5HXCZF4l3wFVKPT09gmZ
 w8G6377WKMPHX9V1RwqWbSxq6vNVDq/Puapbf96gb8y++BVRCKkchtXEkyb1En9n7f1IazYzq0D
 xj+JcAdo+VhGYOcF0kg==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a20417d cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=4nfEs0z1Wzubab7DKycA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: v53enQCtgPLgAw0hwl675YkwKX8qEU5_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030144
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

Add UBWC configuration for the Shikra platform. Shikra has no UBWC
support and no highest_bank_bit setting, so use no_ubwc_data.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 3fe47d8f0f63..01dca97e2671 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -278,6 +278,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,sdm660", .data = &msm8937_data },
 	{ .compatible = "qcom,sdm670", .data = &sdm670_data, },
 	{ .compatible = "qcom,sdm845", .data = &sdm845_data, },
+	{ .compatible = "qcom,shikra", .data = &no_ubwc_data, },
 	{ .compatible = "qcom,sm4250", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6115", .data = &sm6115_data, },
 	{ .compatible = "qcom,sm6125", .data = &sm6125_data, },

-- 
2.34.1

