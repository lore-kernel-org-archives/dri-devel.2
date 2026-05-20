Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BE1CD5BAB
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB3BD10F0C8;
	Wed, 20 May 2026 14:52:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YroWFbLN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EHITA6m0";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83E7510F0C0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6UIK119026
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +VuVp/80e3hOAN8xb/50B+5XE90CwHDX5vu23WxKJHc=; b=YroWFbLNV2IdmH/Z
 lLlbiGgWekdNV+qhOp9QsaYlBg1Hq1hoPT3L/Jtsxk0dSt2Qd5qMkJ2evTksv9Ay
 7HGV+e8z5QaRpe4Oh5UMQyw+WAHPkK1dUAqBDU2049uI2jR+HvlqKINGfbDzyZrU
 s/Ee2cjx7nXwNyvBvpqNqCOxm3cW1Usto3/pC+KXw2k+p+sh3C32q4XJlxmiwncX
 NV3Z6u4FHwFB/N3hnM2QoUje7V3zF/AjRlgvb1aaCjLfTHcpWhJklLRp47r6ryOD
 eSQhkLX24QIP6HgKYA9LpzZMq2lgoCZ62KUB+rSCNlNK5au0uO5q/8OJ/4p91JBh
 FoxTYw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886gd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:53 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-57536338b89so3690748e0c.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288713; x=1779893513;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+VuVp/80e3hOAN8xb/50B+5XE90CwHDX5vu23WxKJHc=;
 b=EHITA6m0XBNvT+kZdZhFS2Hcxeu+iTMNS6iZfo0sgPvBbagv+C48q2uo46ta6N+YgK
 vQW84fETYI8pg/1RPVJJxMgxGOQ7DsGjJWHjnKtwlvJSYhnHhZ2DWU7ZBIBo9i5s0Pwa
 bjcFye6b+Dhg/XYj02eARQItiy78LO4HPdkUU4UTfEjaUzmsQ7Wgo+YKd6RowN4IVjhR
 HneyJdrV6jL1sEM5K7BSbpb+t4TU4MBIXsTCg52cPRrD1KimymRf2haG2hZh/URRjdaZ
 TWp0jC55USUaoQwSu5sIM4vQmfCg6EkF7ad8Hp1ckS/ZNl8hzZHxYwW6xMDTVc75gCPq
 IsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288713; x=1779893513;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+VuVp/80e3hOAN8xb/50B+5XE90CwHDX5vu23WxKJHc=;
 b=sZUmL4+7fOagDLqmncPNxfpOCPaTOTRcLoxJaQImx3C6pgNpMadeUZR2FbGl0lULlY
 XXGylxhDh1i9zihNcSqfteLxFr4bj+I8Pw3oT5aBojgvREXAWlUuQAk40ibNg8dsloN/
 9S5wATAcpoRJAeaAa2Nsu0j9CVoeIJi6VvQiS/OSf9+3yJJ7l2/78HEqNhttSAMlYQdW
 pZJNSH+bKT5SxrrJPp09Cv1vwyvO5hVkzumhNnXyFUhLREDKIhkKqdXJAXaxT1fO8KgN
 8hkjFQJviMQRkIvZHaKxAN37V7yXZkGl4celLa1UzkqyQzTmeZuC87vFbRR1sdsdItxh
 Kqmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cfYYFpeGkaVVI9PQoJoLmmIh09h6I6xW3zf1INlJOHeRRKuc/mDJ4VNcV6W+75V56TlNfvByX3oM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw05GBlHg4PqxOVBG1bt2jmCLxmUU/AlH0SfW9h624GL4KESpnU
 pVrKeiPY48G6WCJtEtrlZmZc2oEbskI7yBoRMTkeiPXjFn8jd5TqWiqe3RJy1hDHHP8dEtiP53A
 R8MMHiewAg2legtdQxJTfv7ASFDVTcf8wvoey05OSF118yCS07tMXOp3GY8tmZvievFSBH4c=
X-Gm-Gg: Acq92OE53OUsn75Dz31sMzfrpkBMszVFIvsKFSx2s2zRspAXu45xQXm/niXPNjjgd8H
 wiKVhM4e7SZzzUa90a6tWzvqJNhh2zOkQziOkeUqGuoovvtU1CWmvtZF82+oJCR/M1BfaLb91/p
 mB5OKtILEO+xr+tN2VEUD40bl0UiHsA5s1v/j71rDw46wiLaSkE2b/oUf2NTvrd3VDMuMZwIZPJ
 SN7eBz5EjT/JaqH/am0rod4K97Tt9fNuh7xvqEn4SaaDUiWk8nf1ku84SmKSk5QcEz2hvpT/u7p
 YVUzTiaKfLqPcNf0j2dMP0U91rvDLuRkrZbvLy6lHX5ut4kEEYJSISbZvG/Dwh4DkFY+cGxJ0Pw
 vC76JjXRGxStGymcBp6/LqAbTrgpSde3G9/DtkAm0M0pGf451001ZFCdSX/5J10siIBR+FUQKKq
 EIPmIjgBk0u685XWzSSRDNSbiBRtLAdzBugUw=
X-Received: by 2002:a05:6122:3a0a:b0:56d:3b69:87d2 with SMTP id
 71dfb90a1353d-5760c044d95mr14404929e0c.11.1779288712994; 
 Wed, 20 May 2026 07:51:52 -0700 (PDT)
X-Received: by 2002:a05:6122:3a0a:b0:56d:3b69:87d2 with SMTP id
 71dfb90a1353d-5760c044d95mr14404852e0c.11.1779288712487; 
 Wed, 20 May 2026 07:51:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:25 +0300
Subject: [PATCH v5 18/28] drm/msm/adreno: use version ranges in A8xx UBWC code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-18-72f2749bc807@oss.qualcomm.com>
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
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1692;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=b5eNY9JoK4QxZcfpbnRgSnFL5p8K5UiGKR7ooENUrTw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpo4M66Q9IDlF2Y439GVSdezd9GmSAQpdsjf
 bjph7hW23WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaAAKCRCLPIo+Aiko
 1YIaB/4oP/w6qzkzlHUuNHAX1Lq6DQTlEsOfN9Wm01nFB076Julinc+8W0hBMDNqgb15yZkuivm
 T/Bl2N0UQUaSd9GVoFB4ony7SX27YHl9ouAqRchJ+bB+svmgFKEiM7e05MafpP2vEivykaQebY6
 I997ydNJeobdew6An1apuevgiUvOTYhi8mLzl9z1Nlg6V2DHLKBZTEFALSqVGmlnmP0YySxvSnw
 nP9L5EFvdgl7r0ATcIF9sP1NMezn3Ewsq+KarnpaStAHYxL1vBuraVc3sz1YKkJ4Egf4iD6I2wu
 wn7aOSapnx+cU8TslNzEI7iACiQCgSa3NDxXKTUD78nDBkej
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: dgYb0vfaagD9QyqzvUeL6pvOECTgOHhu
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca89 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=gyY6hpWVHAyQZ-18BSkA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX5h/ceXE6CneP
 aEJzbmMEerByqVOMlmf3AT9z1dqkIoIb09edee/9wy/fKsAnsPWK2o7aUALCfrtVu4f5rDh/QHG
 15Xl9E1yXx6RzdPU6J1IZfWSxF9rw1NZunPlF+wejNSKav+L+FOZmuhpm+BfHgVEpBcPq6ZZCqQ
 v8YAda3jbiwLCmhr4OAf6uSC1ZKHqYoNkmMj1Nt4T11SCGOGtX7+03hR7Of2Unjz13dlheB+iSG
 mxHSUTX/GyYkpiZ6yKF2V+z+8/RPxzo30v20N2JJc8eQXrmU6QPporNSpLisKRX3bmQ9I9LImaZ
 1cmRqaYuCrlXIfKzp6LcFgFjzhux406VY6OBYeZ1BimnanIPQMKtBq6DqTBO0uobZfbAfuokFZN
 mc3gt028tui1asTBjRS/g2p4qyvBFlEYYFY8ggppYSFmmWQdGzOF7CTNFHCcXhM0Ds9gAe6pcGj
 bE7jwBbjRaPiYahkHaA==
X-Proofpoint-GUID: dgYb0vfaagD9QyqzvUeL6pvOECTgOHhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200145
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

In order to simplify handling of UBWC minor revisions (like 3.1 or 4.3)
use version ranges instead of a case switch.

Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 5c73a9ebb22b..29d559fe4683 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -286,26 +286,24 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 	u32 hbb, hbb_hi, hbb_lo, mode;
 	u8 uavflagprd_inv = 2;
 
-	switch (ubwc_version) {
-	case UBWC_6_0:
+	if (ubwc_version > UBWC_6_0)
+		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
+
+	if (ubwc_version == UBWC_6_0)
 		yuvnotcomptofc = true;
-		rgb565_predicator = true;
-		break;
-	case UBWC_5_0:
-		rgb565_predicator = true;
-		break;
-	case UBWC_4_0:
-		rgb565_predicator = true;
-		fp16compoptdis = true;
+
+	if (ubwc_version < UBWC_5_0 &&
+	    ubwc_version >= UBWC_4_0)
 		rgba8888_lossless = true;
-		break;
-	case UBWC_3_0:
+
+	if (ubwc_version < UBWC_4_3)
 		fp16compoptdis = true;
-		break;
-	default:
-		dev_err(&gpu->pdev->dev, "Unknown UBWC version: 0x%x\n", ubwc_version);
-		break;
-	}
+
+	if (cfg->ubwc_enc_version >= UBWC_4_0)
+		rgb565_predicator = true;
+
+	if (ubwc_version < UBWC_3_0)
+		dev_err(&gpu->pdev->dev, "Unsupported UBWC version: 0x%x\n", ubwc_version);
 
 	mode = qcom_ubwc_version_tag(cfg);
 

-- 
2.47.3

