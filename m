Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA6AC88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:37:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7F2A10F091;
	Fri, 11 Sep 2026 15:37:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQFT4JWx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PCFHUwd6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B36410EDA1
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BEmEWw3780626
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nYhdb2mrR8nU9aigfyRID84GWgE0PGCAeGyhWEowOUM=; b=NQFT4JWxD+1csMZw
 ESk1TX6Fhzc3vBHA16zM/ySR1/pGO9JtHUtWv5Yi0YuuBHPcd5QO726I4J/D7yPH
 5gz11IHQNNI958H5RP6ItWVF+ua12yg9fDDD7WBIa8nZtFPa96o0pzLjOTOSpwKE
 3azZWpz6ZRBCIl2Y/4udZ1p3+4XD5f7amVejkCQo/fTY8iV76XJLqZopreRtxD77
 9XRuF4BxM/9sBT5nO+XZLlCaB4C/IqbhxawfKYuKKvhMbaZjb1LXd1FoOqaWts4W
 4r1+2wDNG+GhbKBZA4Pmr53Sx3YFT845zFabXet0Uy2RE8T49awBPLHZfLNxKAzf
 axps6Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmcgfj7qm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:50 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-4b98ca6c270so2259867b6e.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141070; x=1789745870;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nYhdb2mrR8nU9aigfyRID84GWgE0PGCAeGyhWEowOUM=;
 b=PCFHUwd6ejUciwp9jRmZ+owjHKRlCysZ3DO3AgwLjJO50RM3bk/d2w0JHoPmcciNKa
 9TWlSwi0wB/z8W/gSUY5L1fvTVDpZEZSm/prEnyeVDWNO6YEvW91RCMeb78uKXPBlXY8
 dfYi7S4xvDioYCtlhb4AaBUZi4sB+D/pPHORSSbTpiyj4VW8l2VoOBgDL1qYoyc6HyPR
 8YCBVA6/FUivUU+o1WrbMNAtgYPHUeXKt6l+Q9Z/7WfueJUB7gIsNaWpj8hotoDa6EGf
 RAUyKtrGk+GxyNwIGCYUHxDSCPlXKJW6icp1JGWzZLDmw5j+lyIN/0b8Bzh61CRELj0F
 RZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141070; x=1789745870;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nYhdb2mrR8nU9aigfyRID84GWgE0PGCAeGyhWEowOUM=;
 b=RPpArGrPz5YwWkLO3acSF1JdHUEsoYq22FPb162Jq6MqDtX7iclr3KeKyhfxHotqew
 lcgDty4MDkk1LuHtsj0cXfC4sptUSQ0R3gdKuq2xIH4b4Mlv8RzKPPChw40MVbVIkAiq
 Xo4/UnONi2o7nMF/lFDuPKcbq0+4u08vu+tRDJ0aXwAQtQjdX5pisfHbWys9m+BN64zN
 xBE7gIzl2BT/JAb0rb2IZSo1ck7OY1sHuRdkn5+Ugs9APabwOd9YhLp9IeQUy8IE6L2M
 u79hVsnR++3BZ+GcOiucRO9Z9GdkEvYEjvE7CQ78QHXjIW+Kf4v6sWAm1GUnUARJfdZc
 0bFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwrJhh0f97hMa9QxGJqcftlYiJEbAobbZ+OeO98iPxATQEpa1ZfpP22PL5M5HKYouAsDa9pVKh+x4w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kV9xk7oGAzv5wq48z0U1iTgUrIpwWz3gK6nL+ve7ZFpOuvTF2k
 /5jhfkaE7Dhb6HiodMojU+3v/DB7Z7U+tbcdLst37KpstUW9sEZa4xTA7S1hdR1zVXuhmXqP7Xp
 /9Fpg/zfvZaKa+4xzu/VYITXoT/HclhfRU2nFJ6Xrcs2vsQX5Vwk0eJ+wXY45rKfim6RtszI=
X-Gm-Gg: AYBFou3rPunJWifpskmp+Kp+50VI4FmuijGwzMbgqUZrz1NGOwWHn53WpLlfSWTOxny
 L31qCLZ1u28bg2U+XhFz2qc6wL/Ynl9vt2v2VdPE7HWpyQVda5iS1TCTdLdLTPGWhpwLhDE8TwD
 zuRxzmugQunsOo59Y/JFxNELw7E/qvuouRvcTCRXiCrtST1FiKS29MICvCb/eD/x9NxXu7fA1ZC
 fqZcQh86VZr7nZjG3onkhnXdubDNY+8YvXGdwpgx+4lJyH0gJH3M0M3R+UsigOUdwOjazZNu1D3
 uU8fn1t3JoibiEy7tl4SHVohCd1sPK3s9RVO09nFRjYP2zMHo2SK9imKUuMuH26ppFcZNHoPfN1
 SH3ts6beACdfARYACCvceqqLJURw=
X-Received: by 2002:a05:6820:f005:b0:6be:7d9:b05 with SMTP id
 006d021491bc7-6bf43d77bf7mr4867251eaf.9.1789141070073; 
 Fri, 11 Sep 2026 08:37:50 -0700 (PDT)
X-Received: by 2002:a05:6820:f005:b0:6be:7d9:b05 with SMTP id
 006d021491bc7-6bf43d77bf7mr4867217eaf.9.1789141069612; 
 Fri, 11 Sep 2026 08:37:49 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.37.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:37:49 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 21:06:36 +0530
Subject: [PATCH 05/17] drm/msm: mdss: Add support for MDSS on Nord
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-nord-drv-dt-v1-5-e25c073cf1b6@oss.qualcomm.com>
References: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
In-Reply-To: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=1053;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=WJisw/+zpwludqPzeBDoVioQTucO9qU4qbNXUeHxKlM=;
 b=hHol8Y26136yGC56A15G8+99pmm0imVUMZrkON09gKnyKhZyWkvuSsE1wnklhdgr/TgMl5aFo
 LUoP58xTe3yDUgCeCcV0N8aIyNtvHvGVIvyQl7IeHl1K38J5/hl1Xk0
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX4RoH6cRmz1Dq
 VA5bWW5TyjmEsiUC5xrLjGWHdYYgohKc3hvmI7WL5cY1WP0exz3OG7NGldZmRays6xNmQ0lPuVM
 HtoKS42wOvETs8DqgL0kHGmJAe3oCCDved3Lwz7pqIU/lj9aQ/eZrdjEaQomjH3u5SyU7vN5EX3
 pCjyprRZjDi4iXOCy9KNwYSeI/bFn/Hnfq4Z21RdcVz+OAgrSBs91CV/W2jzUZCFUaWlIcCDOZk
 SsZrv9IG1LDrAkGXfTIlURZePIUI4G+4q+xlDigDZoucZKrAQXU9E/WTs91M2K/4b2taxtg53A0
 yoDQ6wW5YA0Ho99eGZzBByidY+DcP7Xp5ygVRfOpx2cfz71dwzM4ArPzMgmQ8BfoATBM3cepVt0
 Gzig9XJDtqu/YRixu0pLthsTf68o3S0p74yqpSVc/CuZZiBvjg2W9uGd2Aq+MxR1h01M02E28fK
 K8g+7BFk1Ywe2g35bPQ==
X-Proofpoint-GUID: amn7RpNnsNuuhC1Dbp4wkOD6Pcq-AEap
X-Proofpoint-ORIG-GUID: amn7RpNnsNuuhC1Dbp4wkOD6Pcq-AEap
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX7i/b3EKTVyJD
 iIhWDc//8rUB69XkgUKBenI28Ncp5g2NR2rUvqPZ4XWFalvWOPoIb5cUPGhaH2lQafGoPWaZWIe
 j1Be0lROQKTa/r0NRs3pwOZmxLjB9Zk=
X-Authority-Analysis: v=2.4 cv=ULtIjyfy c=1 sm=1 tr=0 ts=6aa4204e cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=p9I9VcFEeIzhw9_517AA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218
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

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

Add the MDSS compatible for the Qualcomm Nord SoC, reusing the 57 MBps
register bus bandwidth setting shared with the other recent platforms.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 9087c4b290db..90bcc8c28dc2 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -531,6 +531,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
 	{ .compatible = "qcom,milos-mdss", .data = &data_14k },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
+	{ .compatible = "qcom,nord-mdss", .data = &data_57k },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcs8300-mdss", .data = &data_74k },
 	{ .compatible = "qcom,sa8775p-mdss", .data = &data_74k },

-- 
2.34.1

