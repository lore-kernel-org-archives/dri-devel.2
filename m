Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1079606EE89
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=a7znpuLq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tq4woLgv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2118B112D92;
	Fri,  6 Nov 2026 13:44:51 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23919112D92
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:44:39 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6APK8B114681
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 13:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yUx2/AYYER6Z8PqhV9YutBEuv6ASg82KLIs8XoRfhp8=; b=a7znpuLq80oOBKNk
 NsZeHARw5grGYGT4I2oYsByT8gT/CRhrQWCMLU6RSLIalSMqE0EbUbV+Ns7goVXD
 A/8tFCpf+288VZYCWiZYhhshsvxXmgBNXXinsfg+iR6PgeWB5E4NlxbSCJ5OjUhm
 aaxEoVX3aqSQEq5eKfG8bM91K83NVpR0r8v5bbel34EJ3EAmZUZrClQ26Uu4wWj0
 IMMEovNmabTHheh9HU5foeEM0oTNlErOv+e7c2TNhwNijBFtLFi0WNwvTb3mO6/P
 SmOxI5tiEpjkg+QGHBTQK14S4/9S9SjI6tWpTfnbJ+288Py71MONGb3kmAboSspc
 gxyC7w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3patyve-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 13:44:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e49a1d3b1so84107585a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 05:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793972677; x=1794577477;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yUx2/AYYER6Z8PqhV9YutBEuv6ASg82KLIs8XoRfhp8=;
 b=Tq4woLgvCNBfQX8P/OORZW46ClFZ9XJOGn0C5cil9q08892bcpR7EfIASjWuAYKa4+
 wROr89qgMZjiunrUTBuWvi/CWQHPsfJlsoT1Plt7wvIIyYoiJHmY7TEeu1EaWfmwL5qd
 SPtFERGab+0UJuWiAIzhuCHpSMGMjr8nbjiAiRMnsPZnYml3uUVikkxsioKw/RKzUegi
 iRTstC+O2guejKXc4M2y3HPBgce0J4xb1AALyX4IwWJpLPpChxLLK9XB2dE16dncEbNW
 QlnolCY2TQUyY03EsmTASgDCggVWgpw7zIqJEIpD4FQsLPLQkV4wBmFX+nFAby8AUXGv
 5aHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793972677; x=1794577477;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yUx2/AYYER6Z8PqhV9YutBEuv6ASg82KLIs8XoRfhp8=;
 b=dKfz1KEWr8pHSeaqSK7pri/t5ga8HvQux+Q7Ze3PFot84x9SRj4FVYHQCVHMf9g54d
 gxS3MrI3iIUh7oS1tj4nwAHqrz3t5G+DnzetaWzvz43VsgnuPdGsrHHBKuILEThpSzyZ
 wZAJXyEKZvD5kMOl/qjXBZdu9feGJRNhAGBRVni/wIAcNRgoOAIukJTjQ/n9ArWQG79p
 L8Tr3lEoSiAHQ43KXCCTAU9hiycXbt5jDSsR72sXYiDA82yvcCqzIRg9frAQI2sgNpjA
 7xI/2Otk2hEpPjrQd53MU/qRBGNk+pl0mjEzmWpykathfOFFRuQQmUaSb5BdbsejkBs+
 JXyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxsL5jdqEimxG2ysksqnKU9I6MfVRoF5x8tV1Lo/PmeWQOYLctooxFCZTsd6UqAWfy+sAZoArDox4c=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/YzaR8H3tAXqOj1G1o6iDEraIYhTlHUwTdDBRI/Dq3UtNgTrSl
 M/t9OJtcMrihj/tLOy6NOG9uDzPmJHk9u+i9fo7+ihOUskHEeAac9zDzw2UgYMO1+79C+FY3WC1
 BgxYusUxcklb0fj6ihUv6Jkt/VrlG5mB/zPAM0QSDOMQiMwdF6VlZaU8VmpBIrD0M2ZJGxew8j/
 HMOzw=
X-Gm-Gg: AYBFou2O6wx99Kp/qiSSHzvQlcKGCuIEOYu0/r1r3J/UF1Y+ulJZykof/0I6vHO+8mi
 IrUQWMx3VDZWQ2OV/jVXWjtkcFNZ7o3/CAclhUcr4DYdt6EX4QcnCgeOZNYWEFuX0hUVuZjU62Q
 0SlJB1UDBHatwtGFEyQ51S3mTJeqtGNl3MUctbnajzLetCUR6awQwM66cwElikLLm0YUdlu91e2
 3ssvY0pTrGPAnXuq+EPaxzz5ulU8v4OMiuoO9U4AvGy6jYl0UqmLOUSRU1tc3yYyaXVDm7ldde8
 dGA2+dKXZ/AhY4rPPhxBzBHCoav0IrRFSxieZiNVuSAxBrMCVkXrKv5d6dmBEEDAM7YXA50ZLm5
 iEP0Xv3nCEIrfkbPEyCMn+eUZ4GKo0eSPy7YgQ1oATLJNR2zmQJuUeHbz4c5M6+w9t4merjJJ3A
 aoYUN1b0DbHsA3D+VxJtJ+2uuLpPcDUYj4EI9au6v1RBSRff36OGjG23fvOxpMLQ==
X-Received: by 2002:a05:620a:170e:b0:93f:5445:c661 with SMTP id
 af79cd13be357-945f34ee9f8mr364103985a.57.1793972677282; 
 Fri, 06 Nov 2026 05:44:37 -0800 (PST)
X-Received: by 2002:a05:620a:170e:b0:93f:5445:c661 with SMTP id
 af79cd13be357-945f34ee9f8mr364099185a.57.1793972676777; 
 Fri, 06 Nov 2026 05:44:36 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c003055a5csm382747e87.13.2026.11.06.05.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 05:44:35 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 15:44:08 +0200
Subject: [PATCH v2 2/8] drm/msm: separate compressed P010 and P030 (TP10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-ubwc-format-docs-v2-2-82949f88f030@oss.qualcomm.com>
References: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
In-Reply-To: <20261106-ubwc-format-docs-v2-0-82949f88f030@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Bryan O'Donoghue <bod@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-media@vger.kernel.org,
 Nicolas Dufresne <nicolas.dufresne@collabora.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Robert Mader <robert.mader@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3944;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=KC7RvkMVOgn+4H42iwyDdp1mol1keZJGBSWmjNCy+fo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq7dmx/XJ3HXoJCOTo/Rx/s76+HuJ9CHm0wd2J9
 drWRDWw3IuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCau3ZsQAKCRCLPIo+Aiko
 1bpaB/9BVzsaVMl5o6civqjjKYdgXyX/hWDiKPEk7ycyeUP+lqIFAVpA3iAeJK371V0PdI+pFJD
 URgYhFm8fp69l22JEMwuODGNgDubRyJo0gprS0L0RQ/yR+y2do3NvLq0RnB/P+Rp8MiXhAqj9qN
 JTRe9Cn/uR94bQ6XDEtJPkg602QP6VSVqBVfsajUo3VJ1dneHctp9WTBRhQs5A82gPWsIbt0Y7U
 SVF3+Dm3JZpX//2A4PNOOs6o7eUutmGdTt0WRHgyiCKG/9v6DGrh4xyi9qmiTy29CFCjFEXgsF4
 FsdWDbNhz+E0n7cnMVP36trbhsXZXjwQDXyRVr87ytLXtAKc
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfXxhJEs2T6PxY1
 8zS51p7S4F2/6y290fERlsark4uQ7/cqnm4jfdHAdChzmXsWO/R+dM3iR49IU8sYHc5w2+aZLzA
 Yfh6xgL/t/m6Ux4Zqeu280SSu6CK4kCSEQ3F8Uw9+tok9Ia1TxQvd9bjp+MivMjtVgQru/55x3T
 I48aBM0jgjZJah/h0tz88sdoyfV8Jj0mEFgiOl6aVXYouRV2j+4FHE4TBIrWzKZsv+ob+mV3bZ2
 re8f7IK1jmp1UwXBTpetPrIQvlnz55o5IDH75LJeMM3PgbLIsa1SgI4ykpZiCwvU3MtrQ7Bmi9E
 DQSKBevTQUlV1gVbrKIg+z5ePKmNu7O3NT+nJn3x8s+3HTrjLLanFtHjws3WuO3yak+DuV2PgjA
 lL8BFQt/sllJkCEx3muoCDMGATvH9Um6GdaU+POZUSbbQT7QGDdaGCYMM3D7BlO0G7Rm0MpX058
 XOL8tCsEZv1RFkdeSGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1NCBTYWx0ZWRfX51I0S89c6I8w
 iIEMx5nL9wMLm7yO0Pqz+I9hbKJABFA2rcl3SMaItnwpnxlXeex7cAYzNOIEjZvpheaYyrc66ei
 X0JZ0Te7DtcqMTs7L1CWxCksLbkyQHU=
X-Proofpoint-GUID: o48XplqBnPTjTB9PItKlScGVif5Lpg_W
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aedd9c6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=fSef4fKgGNmnkmXS94sA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: o48XplqBnPTjTB9PItKlScGVif5Lpg_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060054
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The UBWC entry for DRM_FORMAT_P010 is set up for P030 (TP10), three
10-bit samples in each 32-bit word, the layout the video decoders
produce for QC10C. It doesn't match P010: compressed P010, as the GPU
writes it, keeps 16-bit samples and is scanned out as garbage.

Use DRM_FORMAT_P030 for that entry, compressed only, as the SSPP can't
fetch linear P030, and give P010 its own UBWC entry with 16-bit samples.

This changes what compressed P010 means. Nothing is known to depend on
the old meaning: Mesa and minigbm never allocate it, the vendor stack
uses its own modifier bits, and the only user found is a draft
GStreamer merge request.

Fixes: f07c9946cc1a ("drm/msm/dpu: Add support for P010 format")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c      |  4 +++-
 drivers/gpu/drm/msm/disp/mdp_format.c          | 13 +++++++++----
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 107150a8553f..f755c0d57abe 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -173,6 +173,7 @@ static const uint32_t plane_formats_yuv[] = {
 	DRM_FORMAT_BGRX4444,
 
 	DRM_FORMAT_P010,
+	DRM_FORMAT_P030,
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_NV21,
 	DRM_FORMAT_NV16,
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 1a471cdf767b..09146023d13e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -68,6 +68,7 @@ static const uint32_t qcom_compressed_supported_formats[] = {
 
 	DRM_FORMAT_NV12,
 	DRM_FORMAT_P010,
+	DRM_FORMAT_P030,
 };
 
 /*
@@ -1779,8 +1780,9 @@ static bool dpu_plane_format_mod_supported(struct drm_plane *plane,
 	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
 	bool has_no_ubwc = (dpu_kms->mdss->ubwc_enc_version == 0);
 
+	/* the SSPP can only fetch P030 compressed */
 	if (modifier == DRM_FORMAT_MOD_LINEAR)
-		return true;
+		return format != DRM_FORMAT_P030;
 
 	if (modifier == DRM_FORMAT_MOD_QCOM_COMPRESSED && !has_no_ubwc)
 		return dpu_find_format(format, qcom_compressed_supported_formats,
diff --git a/drivers/gpu/drm/msm/disp/mdp_format.c b/drivers/gpu/drm/msm/disp/mdp_format.c
index 33da569eae5e..2712a73e5783 100644
--- a/drivers/gpu/drm/msm/disp/mdp_format.c
+++ b/drivers/gpu/drm/msm/disp/mdp_format.c
@@ -298,8 +298,7 @@ static struct csc_cfg csc_convert[CSC_MAX] = {
 	.unpack_count = 2,                                                \
 	.bpp = 2,                                                         \
 	.fetch_mode = MDP_FETCH_UBWC,                                     \
-	.flags = MSM_FORMAT_FLAG_UNPACK_TIGHT |                           \
-		 MSM_FORMAT_FLAG_YUV |                                    \
+	.flags = MSM_FORMAT_FLAG_YUV |                                    \
 		 MSM_FORMAT_FLAG_COMPRESSED | flg,                        \
 	.num_planes = 4,                                                  \
 	.tile_height = th                                                 \
@@ -606,13 +605,19 @@ static const struct msm_format mdp_formats_ubwc[] = {
 	PSEUDO_YUV_FMT_TILED(NV12,
 		BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		CHROMA_420, 0,
+		CHROMA_420, MSM_FORMAT_FLAG_UNPACK_TIGHT,
 		MDP_TILE_HEIGHT_NV12),
 
+	PSEUDO_YUV_FMT_TILED(P030,
+		BPC8, BPC8, BPC8,
+		C1_B_Cb, C2_R_Cr,
+		CHROMA_420, MSM_FORMAT_FLAG_UNPACK_TIGHT | MSM_FORMAT_FLAG_DX,
+		MDP_TILE_HEIGHT_UBWC),
+
 	PSEUDO_YUV_FMT_TILED(P010,
 		BPC8, BPC8, BPC8,
 		C1_B_Cb, C2_R_Cr,
-		CHROMA_420, MSM_FORMAT_FLAG_DX,
+		CHROMA_420, MSM_FORMAT_FLAG_UNPACK_ALIGN_MSB | MSM_FORMAT_FLAG_DX,
 		MDP_TILE_HEIGHT_UBWC),
 };
 

-- 
2.47.3

