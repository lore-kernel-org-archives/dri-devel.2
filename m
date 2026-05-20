Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B58FCD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7178310F0B1;
	Wed, 20 May 2026 14:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A3oGLcOg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f6h2XZPs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0056310E43E
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:28 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64K9oWgX1178224
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Jnv3IJHVveO9Wr2l9i2vrKyKNiwoqkqE7X6w0Obsuxs=; b=A3oGLcOgFF1lDnCL
 pTtPs00VgH8TCriDXW1SOGfOpuZ4EtAwE1wL1q0nCKImvfS+DmjcbyfRjzhuElKI
 NHaQHOm4y+kSG6ODc2+Vpu+Y+BngCkyPQ3OEZHq3rfapNdo3gT3dx7ymqZq/j/xa
 uWcCZ53KKk8yQhfJjuhlQ9gaZ7/I7bdvhDX09hHd98Qfef3TAEcXIEFN9nglKLvX
 dV8fe41F52LT+jFnNyZRPTSeDNX3fd7YtOsuBWQ5mNoWpmQzNBFthNOAjpEGjVzZ
 4Tge3U17OKPrh4OIkiN1491spQwJdpkCHj4d8KB5yLUxIvqbn/a19SL+hh8PMsoD
 2ANB4w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ap6s3hf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:28 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-57584c23424so13263351e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288687; x=1779893487;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jnv3IJHVveO9Wr2l9i2vrKyKNiwoqkqE7X6w0Obsuxs=;
 b=f6h2XZPsMC7s4RKbfiTRmhGFHdPQzx8LKqi8m+RcYiMAb4Zq8O9U36s77K998Zl01M
 qGq5gbZ79aONUU3sJ8ut68j8DZNuLaDJxamyr8rlY4t598VFBLDlUNiMnMTjSMkiokcc
 39NpRMdYfUGATxdbO5b3vQBvDeZ1yauZl5ZP8U1ChwDHlOd162NgwKZT92Or9pRMkp1H
 JYx76CsqtZ+P9/moZjrqVz9N3G6MJsIJH7QCa7k3qfh4+Zemzc8kNRmqGVEn6hablfQG
 PRFMyFPuaoBJi0EMjZCjSwiKKLpC9GPeEWB2MVjlb4fJwvFI90ZBbxZHdqTKS6CS+x8S
 ANSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288687; x=1779893487;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jnv3IJHVveO9Wr2l9i2vrKyKNiwoqkqE7X6w0Obsuxs=;
 b=I2J/lkEC+2Een1iO4w94O1Uf/lBtf+VpSDxrRAxFlL7yMyqUfRsRJjo5dFyIKhu/g2
 63/43z0FAkN6jht6C7QdlFwtf7x553IZcQ260OVjhTMHpiBLvdslpiP0jfRlC/1Z5AqG
 eVsxpCiF/jjiFAf9zodt7gDs3IACOCVg+MtwH55Q8KQhBLWOkgW886j5B36h2Q/beKw9
 MynWZvPOOtffQy5hays4wMVkIXifJYikeahOhMVoMMfq40VZGlvyK+ZgW8m6X+Pxdl53
 T/APekaoSOIBirMBpOfYCWV4cqjPLkCFQO3wwz/6byBSVtTlAsrk4C0/AhvneOUSqPam
 XOkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8AZnjgODeOEHNN2l8Gt9vzbix2g9nSFONBPM1J7DppYygYkGwqG19InkiaKne858A+lhCrwJsjJUQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwqKRmV7MIxCFlIK/eaoU8viuU5UL9RrDp+d16ARrKAsWCCQn62
 2qLpqnC+8gnk1SkfTmsM4x+PLKabEDI9J/VOaPDqXdUdy0q7phOYdDUMdQF8xB1aTKoQmw42Pwx
 sZ3A5RAkiMNIz7VSnfBrhq5b43EUAbvr7WVW2yw4EOZfZxB7uwCZwi0ZTMeca4kGayKeQQHc=
X-Gm-Gg: Acq92OGvBHA94nivvKi0jbWAg4PCNanZ7Rp2fLqZYYvvdrce8U4rP5ue0E84oMZX5LN
 PIxVTpOGBnZd0T2Nek04kjPC6c0sIYwwV0MUbUxJmJByp6wcKK+9TNH/RKyZ8fQIAX9B5dpgBFI
 P2Z/dXamf4O5YRYUVM8larq7PUR91qVD/L7gmd6I72QM03VG4XdNZl5vTQpA+YpUPvH6hL/IvuC
 8w2t3hnAWsrlKdSti0ebqI2WPHNKgHRoOz09fVHOpzNXg2+om3m5KOT8PLSoiUEx/fDMgKT3O6M
 bfsRDidZ2dK9Wx27VuVDwQ1OP9W12QL7iIo9SQk+nwX2S2X+7Rmg2NxwSN3OSIRvQ/NHo8L6mGg
 EvXkL5RNCiKFVjnY65gONG8YesaUrSt2USZjM5Rp1iGDfta9ejCqkEmrm63RBaHMVRFvIPE3vQa
 UL8CX4diIs4u33cMgAQ3E1BehX/9PPynDVTLo=
X-Received: by 2002:a05:6122:30c4:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5760c1c8c1bmr13737875e0c.12.1779288687434; 
 Wed, 20 May 2026 07:51:27 -0700 (PDT)
X-Received: by 2002:a05:6122:30c4:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5760c1c8c1bmr13737803e0c.12.1779288686682; 
 Wed, 20 May 2026 07:51:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:09 +0300
Subject: [PATCH v5 02/28] soc: qcom: ubwc: define helper for MDSS and
 Adreno drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-2-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1061;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NJiVsMMKzJws+Cks3lRdvlT1mL0gwv+c/6r+WaGQjLw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpm80cDP5L52G3Lw0/8I+QpNhHqbG0OnWv2Y
 CS1v/Lono6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZgAKCRCLPIo+Aiko
 1R0/B/4wJHR93HM0x2ZMQYcL1jqZ9gJ1ccKOlBjmw+4s2qEGoANYjZ6aU5+QpnzKKfmyAmwCmdu
 jFtFii/XfvruQbGABUsPVE62vw/eLlactl5vWdsHLv38kO84S/daBvc2O6t4lz39eO+C9pY3geF
 bCH85Xq1B1/KxGysYvR4YKKFF94quMjxFMRaoEaMiLDPDjuv6RhN0bjZ/OIrHzGJzthMr9DAYOr
 nbyJyMuk+TJO4oFm36GT0/z2I1PE66tyBrrgPichLyMI5sR0wIAtqd0xmvy2yb3+YgLQJqWH9ok
 jydOHrQh3pY56EQuOJ1ucA5K9kPgky7Oyq5IGvgSfV/GBlgh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 5kukhD3El4uD9ySCNzwgri5FcKfrVGuK
X-Proofpoint-ORIG-GUID: 5kukhD3El4uD9ySCNzwgri5FcKfrVGuK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NCBTYWx0ZWRfX+9iE/jylLGpt
 q0+lF/qnN2HcOSb9UEn73IMNdF4quKmd8flmPchNQopLXYN/8qZsIPm01m9qBttbarEeBsp9roC
 Qo4FwxFLOYcgY/vBRMTJ48FV/tlGG23RITH5botoeR4+B6gV+l1cnW5vUtJNa8y2U4cn0v/FfJK
 4lQzr4lJGdSDPzo8l53hglJXdjN1hBehSBOJjPQrzQDy/YVwn0DR63+SvNpJZcFZ7WYGWvZsY2R
 CmUqmOuPuu4UN3jWIZCvw3J1aCsZt2ihz/ONtUzXj41J3JUBaV95nBMO0wR4nWO/wB8Qj2Njivw
 XgmtrgkJIcnBXYIUogOgmAkWbOd1jBoXFjnSqbuWjYoWVcpOxSxcZO6STqqk/rJ3ZCcg3UzJwho
 MEmWHOD9fGXJFW224uOD4jMWKTgJu9CXK7b4cs5on1IsH2AXmWwBQ+P2I0IwSwzHRr0R6FcBsQZ
 3teAZoUIAh3eGPlMEcg==
X-Authority-Analysis: v=2.4 cv=FesHAp+6 c=1 sm=1 tr=0 ts=6a0dca70 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=TXJx5zmxIxDbTTGRO54A:9 a=QEXdDO2ut3YA:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200144
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

Define special helper returning version setting for MDSS and A8xx
drivers.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/soc/qcom/ubwc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 319caed88775..8355ffe40f88 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -100,4 +100,20 @@ static inline u32 qcom_ubwc_swizzle(const struct qcom_ubwc_cfg_data *cfg)
 	return cfg->ubwc_swizzle;
 }
 
+static inline u32 qcom_ubwc_version_tag(const struct qcom_ubwc_cfg_data *cfg)
+{
+	if (cfg->ubwc_enc_version >= UBWC_6_0)
+		return 5;
+	if (cfg->ubwc_enc_version >= UBWC_5_0)
+		return 4;
+	if (cfg->ubwc_enc_version >= UBWC_4_3)
+		return 3;
+	if (cfg->ubwc_enc_version >= UBWC_4_0)
+		return 2;
+	if (cfg->ubwc_enc_version >= UBWC_3_0)
+		return 1;
+
+	return 0;
+}
+
 #endif /* __QCOM_UBWC_H__ */

-- 
2.47.3

