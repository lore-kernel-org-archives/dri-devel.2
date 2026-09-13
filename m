Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287F3C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 23:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AC6D10E38B;
	Sun, 13 Sep 2026 23:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rptv7zTd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GXfwiZlV";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF03010E38B
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:24:41 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68DK0f5S3041925
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:24:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=pqoDxiAWKMV6OWyFAmtNvQ
 kBFPSx0EJAqZSSmJxGHNY=; b=Rptv7zTdTM+CZXQo3fIFW0bzhbJwJX5HjtcDA1
 Msdu//DY0G8APlLv2cOn0cz75TAoJBk5fKnOFPhs/nuSk/xtGHuX3KzL75zk93XK
 EdIQR1w737K+2hrwhrOi8A2LOBWsqvp7ete19ayuSim9aOicc/y5fEnKJ4HdYu6h
 lQh90la7zaoR0xi3nNVx2daYrBg5hQztZ1LAo2HQ4EPdPGMfsc787Q/zkSc23c8q
 2QB15adTfTFnPFyAnxL3lyZ4rGR/RT+kdCa+c3fZTYKt3x6A6D9zpyC+AZ9eRqKk
 nT6ZJpFsQefeXfx9SAZtw1uG9PjD62HIGU1nCYCZAD2vR6Pg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dmchf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 23:24:40 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c846dd12ccso1010013e0c.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 16:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789341880; x=1789946680;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pqoDxiAWKMV6OWyFAmtNvQkBFPSx0EJAqZSSmJxGHNY=;
 b=GXfwiZlVoH5n6XcDRNX8rj5lKpiECv5mUWlG1vlxstgaxFx1/TE6BNAo7YAqVXeeHo
 X8aQKvVHKBl6mNEL2KCb5jqlpgZz7wGV3BOqU4xsAmXJ4bOTkPE5hZ/Jcao26G0/fshw
 lXNlv//whTTcGn0iWFVOpVxwaP8Raexy1DAccwbZmPcGELUu8uc+l9RnObPKxqqAiJ+N
 nOYSaMKEtdOtiI3Z8RSdyTBTyUjmpq2HpDFMgX5416GE9KzFvHqk8xf96JfCRm62qnAc
 LJOeB5GpeBHvTKhOUcUpd2t3Fy2Xjv6M2afEZnHo+sb0o/gc7WyI9WsgVj5scXmHyq08
 QDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789341880; x=1789946680;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pqoDxiAWKMV6OWyFAmtNvQkBFPSx0EJAqZSSmJxGHNY=;
 b=cVHaFURl+F1Fdol45tJMXyKquHTLzlQlmv4Cx1VlErdRPlvdOx8U9ryrADI8UB4YZA
 7GMtgwKmKlUnKTHl+Rf6sj9S0FB8LXYC9jPNp5J2RZUkgpJgqRoqAq/3EVkTy3LrSFNJ
 BI8m0Hoeu/0l9+lGfXV4Ge/bOwb3rzCChM8eslmzC0S9LPeFsjnj2vwjHQqRIcLokKaf
 1XqrB3v+s5wl9sStEcYKLeKqQO1bS8K3ryu/ZnMw5ieb4HrfwhgrCF0HHwRpC1IlmOrU
 rPP9eSUYnJEJsooFRnkvc+K+yzyUEBD8o5OAqeEIl5dlJDhg9M4u6qx2wShVp3hzkWUt
 0Xrw==
X-Forwarded-Encrypted: i=1;
 AKwUvByT7oPU5KBncti6nF0Kkduiom8JErG1pMTjMkk63m88PjRaesNF0GS6/ghpis7IrQCJJF3x6I4CvKE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kPvHcTgCIk3ujcpasaWkaRNKV5s6CEtQhLK5pw+2RK0LbT7qYt
 Ro18KMY1LBr6+MD7lW3ZI+3s6tDY/JlluJ81kUZsMLWW1k5TdCYKA0Hu4obkTHhgU2sIrbyjdvn
 O3AUJN4SMchtinEW+u0ZsaocQxEL2DHrX9ItogZZNrQi8D5znGaxkiFYj87X608LZJoUMgOY=
X-Gm-Gg: AYBFou2b7gyjdlKFXsVlKsfHngM3A11agAx2ESZi0FHTesP1bkQUI0N4PK0DT7reM+s
 BBhemsiDumu4OrWLZxXGzwZv8/5bnBhF/VCNiOZzbDpk/aW0W0VZMPPkq52g/uo+zYWDVxhliRW
 bf9hi9wRN4KcC+r9UaQa5j2WBv4ymh2RpaLok+r03bYNngUwgX5qGQ7x0WRO/oDrARdk/1YmcWW
 mTkz0LB7mTDX1RwAnMVLSucVYnARunyAMXwJeViQWkLMxvAaesmAt0iPaZuiH2Ig1Rwxiti2m04
 iFPq0wF1772j0ENuURp8dclMFl4EFAlFqRcRW1rkvV8HwM5sU1DgW7ZNPCYq7GVnOZJ263JYTW/
 wmLUpPKxXTS5R775PPS0ckqC1WIV+8bf2GvDoixh0Y1M3+vbUy5UIkDA2FuzkzGsjyUtufn+cNw
 QDFODa2XgU6dPM
X-Received: by 2002:a05:6102:6045:b0:785:e069:6c5 with SMTP id
 ada2fe7eead31-792ab142074mr13116125137.8.1789341879641; 
 Sun, 13 Sep 2026 16:24:39 -0700 (PDT)
X-Received: by 2002:a05:6102:6045:b0:785:e069:6c5 with SMTP id
 ada2fe7eead31-792ab142074mr13116106137.8.1789341879102; 
 Sun, 13 Sep 2026 16:24:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a33263c7sm21394251fa.21.2026.09.13.16.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 16:24:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 02:24:24 +0300
Subject: [PATCH] drm/msm/mdp5: drop cursor pipe for msm8x76
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-mdp5-fix-cursor-v1-1-9fba3ace6cb9@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKgwp2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0MT3dyUAlPdtMwK3eTSouL8It0kC4NkE2Mjg1QTi0QloK6ColSgLNj
 E6FgIv7g0KSs1uQRkjFJtLQAlru6+cwAAAA==
X-Change-ID: 20260914-mdp5-fix-cursor-b80c4320e48a
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1218;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=EZeVNggLDFp49i+zFbHcRV8kVa7+aob18truUbB8RGU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqpzCygNfJ9UNU9zLgqJpF9/2PjHAJzuKsAhPZG
 3LxNqonhfqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaqcwsgAKCRCLPIo+Aiko
 1RntCACEchaO2I6uPRA7XMlyzZfX0Ov464yDKvDo7gS8KPUInfvd2AlsLqtrsD3BxCFwb5cgUCj
 fCx14rf0WEhxch3k2/3mU/Cvo9Eq4fhkjqAOSzpKlRM4TVLMGcio6//C6bwx76ehJcE03D8IU03
 wTR7vWrMl9mx0llpwAlSQBcubP6vjhXVa+1lNEVI0WyxtuuEIUAXAiUoi2/qRDrXzn2D5URkwjP
 VzPUI13/wjnHj1Uv2IhF/s5vR8wLobpGZpaVwiqOZ1AMFQJz9m2aPiL1niapIAHVXwYUroo+EGe
 fn9ys61fvLlBJ2YGC2EZvMFXahi9FWxrfrKwcAgp78+CMxSn
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEzMDMzNiBTYWx0ZWRfX3ALhkNNQD3mo
 v/8iYSbHPKTAlzQTcMo36Gpg8Uewz8sxFhQAKfCRRE/mU5BX2lgWSV7xm3ALO+/FP/6fuxm8OYf
 hTBKORg3UCB6MLMDG58O8+SJ4Hku3UT4Z+PgsyoFUC1pC1NOWxNkwJpEgK6U0TOY6UNClyUm3lP
 FtFrxsqm9t6PKmVd7qOr31gLWZ/s6vdfmoxK1c5IG+WkTR7WoVmtFi5F04LbIQfMXZv7rQEBJ1w
 RnEppx+y6jPlHhlaavxunwBu+FAmBq/bypV/CL/zPtGw0aV318SRwxs1DYMebO85kOVRca3i42W
 2kH4aclkI1Bth0tziL9ihSONrqkJl5vjQF76CAnO/csf/fR19q47NS81vjGZ1CAHPb8TE9aQOc6
 t88q2VTN/TfV0caEdYL8MNGFu7ESnbWkfwfHaWWfCztzynVFnqtHiOSolAcfp9jW12JCJb2B/5n
 rvGx8kDHBgPvlVXhaCw==
X-Proofpoint-ORIG-GUID: 8eMHRXXp4hON_zWR09FnmF42AxUHa5LY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEzMDMzNiBTYWx0ZWRfX8WX6Uez5WwP0
 ZDJzPyC+LIqSBHzQhLMiwpoFEmJKs5BKErfrIBmoIy3Fx58ur/mVpcBSGGKdr6x1NOOLfTNmzvp
 r4bY0EWTc92LjXu1rzlkI2gMHRi/MGE=
X-Authority-Analysis: v=2.4 cv=Y6htIReN c=1 sm=1 tr=0 ts=6aa730b8 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=uEdjA6kzdaZioO8ovbUA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-GUID: 8eMHRXXp4hON_zWR09FnmF42AxUHa5LY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_07,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609130336
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

The MSM8976/56 family of platforms doe't have a separate cursor plane.
Instead the cursor is a part of the LM block. Drop the erroneously added
pipe configuration, letting LM to provide a legacy cursor instead.

Fixes: 1860f2a8b8b1 ("drm/msm/mdp5: Add configuration for msm8x76")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
index 7c91fc1915f3..389d74ff7516 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_cfg.c
@@ -698,15 +698,6 @@ static const struct mdp5_cfg_hw msm8x76_config = {
 			MDP_PIPE_CAP_SW_PIX_EXT	|
 			0,
 	},
-	.pipe_cursor = {
-		.count = 1,
-		.base = { 0x440DC },
-		.caps = MDP_PIPE_CAP_HFLIP	|
-			MDP_PIPE_CAP_VFLIP	|
-			MDP_PIPE_CAP_SW_PIX_EXT	|
-			MDP_PIPE_CAP_CURSOR	|
-			0,
-	},
 	.lm = {
 		.count = 2,
 		.base = { 0x44000, 0x45000 },

---
base-commit: c68a982815dcce5464e3bf2a31ac94f5146c04ca
change-id: 20260914-mdp5-fix-cursor-b80c4320e48a

Best regards,
--  
With best wishes
Dmitry

