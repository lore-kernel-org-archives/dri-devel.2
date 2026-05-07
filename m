Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7FACD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA44610F0E0;
	Thu,  7 May 2026 13:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n9b3PVLS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hqCSj4+s";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 757C310F0DC
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:20 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647A51sc026544
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l4shwfMjGLnh2T+SL6QX2H/uv+6YZBYhzZVvBdIDpp0=; b=n9b3PVLShnKv6Sub
 2va3HJAJ8W+6JqjBAfRI7bUiojgvER9zWnItOdTuGEhmedATYSmIYiqLXN74gdWl
 yBF8CEtycNSR9BUc5LKL12sI9MYE4eNLJWBG7DtzL6JjCI6qWAsLT6qeDzIyF5vu
 +D3q1bwtC2isCguhQChFZAQpvmkcH6sIKBu1klQ9VPhMVgrmgOFoQ2DmmS0OCPas
 3lYh5TXkK3D7fUdMBkt7aNBqWfICI9ZmWE7aLRLiKc+321Ruysg2/2EznDAr2Tja
 NKuwbSV3ahAMMhqW4ZnsUo2AgpChEbDSYOVITkDTvRX2mdmh2DQAtTUavwdNuj0u
 mmSWnA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0k1t1yqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so7567095ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778158998; x=1778763798;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l4shwfMjGLnh2T+SL6QX2H/uv+6YZBYhzZVvBdIDpp0=;
 b=hqCSj4+sB4HASrg2r1SUSjGjlwAMlro7cQ1p8UspBSCSNmNqYXDL/i9oVVAd2KSJ/l
 JJ5sHDgNC3r87OFAivuqOu0RfDw8PG/s8fIxQ5VjJ0GX6WKNZRSi035vRadBhb6/5BvF
 B31FZg5Vq5wszY6R8uY/gNELqJUUt5PvReOmbmaComNfVAKlHvi3RfgBzxm7Een3T4yp
 vh6RFClLgRKnqPIoNZ7YNieOhtcm1jXxBCGaiypuS0myLd6s+cfP1Ag8WunffPBVFU9f
 yQQ8kw/cMUl5X68Y4f+46kot8PdttWQe+/2NOsmO59zFUA3fzHuM59dCwi31ljYkM8uI
 JNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778158998; x=1778763798;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=l4shwfMjGLnh2T+SL6QX2H/uv+6YZBYhzZVvBdIDpp0=;
 b=HF9ZFFWIDYAc/ZaNv5qViyaitjhciYiI4R4bjlkrk19TP5RAPdH3fgQsT85PR42Z3Y
 AdOoRL18vQF4ZyRdU/UADgIu9xBSTu2OFNXTo49jThHarRQV/q6rMkEp7fxn4vl90wze
 LM2wql6OE40b+Rj6VeNbeufbnX9h8vn0hQ2cKpOzXcn3mGYsB7RSdLoWKQ9OGqrQMMVJ
 IfOKxb8pcwsl3uWi5mNumwDbs5o/gw03FgA5/pryhPrOAqFo4iJIS1dnFV4rw6b9A17d
 J17+nJ4skuEfHHUnpY/DB0VlYkxYnISleU0wjEiGpCNvvW9kxe5OP9tx6TUD1GFLvk3q
 kelg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NoHoLepSgwsB03t3Wk+tu+YSkHucVvhUx+zcyc0vYtYKdfc4dFTa6Xk3ttheqb3ehr21K/IEEJEQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyci0jFbB3JAACstVYXPAE65n2fL/Ny2PBibzKDmtuH0xgpLRPg
 EnamPtvkLhsVl6s1+8AS5gOpBTNF9KaULxu2FcMbw77L4GzmbETHsxUquKjiuVGTijwpJQfEGK3
 XQvtCeFSWIEj+aJC5w6xF5K4qFFjjq+vz28zYleIBzwHQ+dTQOXppuNubAWIV3nHlNq+pbqk=
X-Gm-Gg: AeBDieuA+qyJ0Dho/Mu4f0x+DdCZG1cJrkHjQPPxqitpX1B0r2jgIrshiS/sprhDPmp
 LaCQZnUczvKgiJTgzoItOHMfxImu+EOP+UVGMOVc7cn5y7A0NE1v9vsSTNyCpgCtgFsVu0oNPyF
 ugkHTutPNrRCitMrooYv7tW6SvFZv0O68FZpzpVVDchssNSsyrL9749Fx99s0KRirHNHa5PNq0a
 g58fpK3Ewku/JJWSMJS1gXQV4k3BYz5rSKuUZOoH+LePe1vm+53NZ80X027xRVTL+bnvuBGdKHF
 QOrkZSKOsWZYmxVX/7WDNWLt1ys7DnSxpFKG896GBG+da+siiDbEMHwh4mJ/T2mGd2sNRNQYVhi
 eR7s5G+wCTps+jTVRzuu3CV27ef4GXbPPCi+jO8nxts7Vac/3iE3FuscgAGKLv9F78TQ+ueLvif
 BpjVDHH0147CAKZfs7td1ijWYHtY6efsCZMkizdCmKE4Sqcg==
X-Received: by 2002:a17:903:24f:b0:2b4:5f67:5914 with SMTP id
 d9443c01a7336-2ba79becc18mr81503725ad.33.1778158998297; 
 Thu, 07 May 2026 06:03:18 -0700 (PDT)
X-Received: by 2002:a17:903:24f:b0:2b4:5f67:5914 with SMTP id
 d9443c01a7336-2ba79becc18mr81502835ad.33.1778158997623; 
 Thu, 07 May 2026 06:03:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:00 +0300
Subject: [PATCH v4 04/29] soc: qcom: ubwc: add helper controlling AMSBC
 enablement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-4-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=758;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DVzUVHYL1LwQyydsa5bse8Qdux0+ATejKvt7PdcnILs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2EKmwuR6fxUI++RhBWUv+l2sKNuJCq0IGpr
 K6Db76TRTeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhAAKCRCLPIo+Aiko
 1UwfB/4i4Cv+HSxLkStTNKa/XWbofh+QJ0Gqz3qoZKw6T7FhwdmpiiOolnFkFF5AEE41sAPxg0T
 i0vsFUSQ2ntnpMeKVF0bXJnJC5h2fNCpEWYBbVO2b5ASRno9xQz8K309j/bfAYdJtrHRhVQMqbq
 48VSEj68PZAIzKKdCUkFwVaxpIT++76uST4OLalKIOUzAqplAk19wQcRjGfCTL+J3o+SnhcDeUy
 uVjDyT3q36qtKOyVk6dVcGf6yuwomuHe+54wfgDePNlm7kOCgXU5AiG9EJMI0aVKOJ7teOmKe1i
 y06GqyY1qb9ah2mnoXoKkR5NWDmrm9tJ4ZMvWi2KnKcRcIJ+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=EoPiaycA c=1 sm=1 tr=0 ts=69fc8d97 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=WuC1ZyUpIfxNvbBu5HYA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: ufONYJcZ_y1BJ-sOX2DMJqpNVscde2Hp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX6GcI+Dnc/kNF
 SLxyx7hhBnaPV3h6icuQzGEXrqHHYKAkZzA27QxVxxSU00ghMBEkHm4CHWFCAoNPSbJpzvPOGyg
 a/gsYhRGNKRX8k9Oe2EX+tLhe6gpk4/y7QXtNYnxBe7T6HlZJ9Y3k6a+BfpOTWTHhQl4y34Cjh/
 Hiii4SfcuYT21YBrmDcT3XqKm0kj5j/g9H9wHGMt5vTAHRg2fEL8W312FrKtlV896gDjQKHy+Oc
 qsOcuup3wz9lUmdMl/9gInSdPHtu/kUkFFajLktu01A/RFAmyVvZxRUzeNXFy0ly59ULEMUXBhW
 BBM1QyWafygZbZSSwZaojUC0Z0Y8cQGAhDGJcRQxcFPVEG2O+Km2LJFjiLAAKLbD/KvBLmMzTTv
 WDQYlyVsW9Z3RwuL8Gv2mcHhIW5UGTdFqwBdFwEi76WA0cOd4K2oLMfeUKjCSqB7X6/JLosfQ9M
 O0ngsUU9AorroKW38CQ==
X-Proofpoint-GUID: ufONYJcZ_y1BJ-sOX2DMJqpNVscde2Hp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

Adreno and MDSS drivers need to know whether to enable AMSBC. Add
separate helper, describing that feature.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/linux/soc/qcom/ubwc.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/soc/qcom/ubwc.h b/include/linux/soc/qcom/ubwc.h
index 8355ffe40f88..83d2c2a7116c 100644
--- a/include/linux/soc/qcom/ubwc.h
+++ b/include/linux/soc/qcom/ubwc.h
@@ -116,4 +116,9 @@ static inline u32 qcom_ubwc_version_tag(const struct qcom_ubwc_cfg_data *cfg)
 	return 0;
 }
 
+static inline bool qcom_ubwc_enable_amsbc(const struct qcom_ubwc_cfg_data *cfg)
+{
+	return cfg->ubwc_enc_version >= UBWC_3_0;
+}
+
 #endif /* __QCOM_UBWC_H__ */

-- 
2.47.3

