Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B4FCD5BAA
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:52:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCCB610F0CE;
	Wed, 20 May 2026 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H7lGl3pm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V0Tv2ekK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E22C410F0C3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:56 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KDuVVE3680313
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/qLGSxqXwwwVGUcv6G1OqxzPF06V6e0wxfns8XSMAw=; b=H7lGl3pmZ7DeVKvR
 t3KyEof3XnqrMGQhsI32Y2hv86/XWqFckrOLv0sG7YiftZpm16D2NnX3UspeXRPX
 jf/Ca8aTn+nfMJDz+zo+WQE57IsGXW5CHm+Dh2NWxORBA8mfkQMvCBF0nKerflDQ
 zrI4ERZvF3jkxeJA3UswS8zfR0o0UhTTZmLOAcMs9hGaSAPFjd6d4I8h2/8HHI3m
 NxRiqQr4c5VwcOgD2mXHcpNO/2gTg4VCZZ02QxhXlftK5SYcc3BXGIpnCQU5bPXw
 Ch5ciyQizL4qXzelVhm1OfnEsVIKnaMGLx2tJgkOdA3W2GOUNcMA2+KjBRObzpZx
 YzEjQA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9e9j07qa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:56 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95fd5da382cso1952583241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288715; x=1779893515;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i/qLGSxqXwwwVGUcv6G1OqxzPF06V6e0wxfns8XSMAw=;
 b=V0Tv2ekKmcbrSNJmehN+BmfyZWUOsjaNcoNCGf/4rAiIVKU6JqqhNs5ytHdXCDAyiY
 Tzu7GPP+znWcwwaoHyz6vzFOG09H/OanER0Vo50S3BUlAoxivY6iDr/E1MPopR6+T3DU
 izyp+3pG6AZEJ4JhSZGpI8GXQAo3Pl0Vc8edeNXkMwzGgWyuFkoR8I+ZX/U+NJVI1gi0
 ZYfJU/2u6VOC1WSjk3wuQCVTFjEljIJvIUMFT0i4prhqfJ0xGpvHoiiB/HGLykKaIGcS
 bwH/YVuhHQRFNc6jLj1C4KnPU2YwOsyjH1GM+RuEkadq8Avbe7F9tpwgnL3xCfHVMTim
 yG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288715; x=1779893515;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i/qLGSxqXwwwVGUcv6G1OqxzPF06V6e0wxfns8XSMAw=;
 b=ahDDh49VsQhWk5P8NBJpvuuRJLOclM2X8x4IIelnGhHmlgazPbNRGBl6BEumF9OILk
 1YJi/CBvyWyO/yORy2SXEGlxcxC+8PtHWYI1IneHEENOuGguhyLAnM2RPQpz2+5y+RVn
 ZSzTq0aTDWJVqTy2m4GAyMILG4Rs6yufYvYLw9Oy4BvmYlEkwxOB9mj/pvweiuuTVroo
 s0/jeBugbhS/CzamM1Ndjm9/BONtGn1wPEanip4R/BJ3mC9XbbhG6j1y4fMjIbnwJHNQ
 6YNY4ju2A2w0XJimxMD8mRyr86ooohtUNKJnmkl97DV2/UNsfGvSqNoU9L5FCI4SXHXr
 3M7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ++4YCkevXM3ZRlgarSLE22eY4WIzbmi1vybfYE6KWOc4ED/VyE1UMINMpyqm+cajB9TqH5PDliy/0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzhC5DeLAbL0S4LgxAzTIr/ACjrAbBuTSqQnZHtKIA3kDbIfWkD
 K8z9Ep/jinZF6ePECYATEER9MzqaIpBPjR+KFByAhueqXQyppeckmvB71oHI2IbDjjbfq0mkEI2
 QNojSuyLStkCfFS1aI40rlC5tMeyVyFI45eshAvScWsk2CezUZrigVtjnkhiB9/B1AFdLMsI=
X-Gm-Gg: Acq92OEUucvfS6f/VG6wA+LABbTpdjRgWoDTPD9y637LwBimFfeZMRBKyqU0OJu7oSS
 p8ADBSwJJhyiupGBm510cXz647BJ37buh+8t3/2QNacQN2QUJiLTOKp/kLjQBr3meyibJSsuLNY
 7x+oebTB2VaR76Hv/skeqR9L5SpfUttoEfEoPv10L1F5tFFPQytUeEFfGe6lHFnW265ABo+Y8kx
 lXZ6HwNzvG1362Nqp3dMFSKUv9EfhkN/rFrIg/6G1zNtlTV1k/NrN/9W+RiKZqlgDb8iMGBsLXt
 oznLiGC4f2HY53Zm4ATzc3t2jemVGSSxFnfcdwzvwhRMecxb0l1Bup9amoF6kem8tUm5w9uhLVY
 Wc8odXQgQ3TIwTUTu/eQ8hPTqqojbMGv7/zTVzzqBQzqEnaiGOc9lJv+PkvsyI/IwKRflY0fbld
 Tb2fuZ7Z6Zhf2UDQ+uhIbGjMHHZs8V0QVL5xY=
X-Received: by 2002:a05:6122:4006:b0:56f:b2df:1791 with SMTP id
 71dfb90a1353d-5760c043936mr13265741e0c.9.1779288714749; 
 Wed, 20 May 2026 07:51:54 -0700 (PDT)
X-Received: by 2002:a05:6122:4006:b0:56f:b2df:1791 with SMTP id
 71dfb90a1353d-5760c043936mr13265675e0c.9.1779288714078; 
 Wed, 20 May 2026 07:51:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:26 +0300
Subject: [PATCH v5 19/28] drm/msm/mdss: use new helper to set amsbc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-19-72f2749bc807@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=892;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Thp/IJnKPd7xQIcLEgMC3qoCNBhsyqRUJiNUBJx6MWM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpoFFRI3WyfXSK9O95QsuMY1666C12cCQb7a
 cD/xKpr2YyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KaAAKCRCLPIo+Aiko
 1THkB/40gP3ZEmrupD44oloIguqfQaB2fi4+QLN1aH7nBjip3cOq11gm87Vp0WFIBe+F9Dbr2ik
 RVv6dOM4i4vQtKJ9cTcnnrpUDyQFZHq5Pad+CeWuo2vAD8Bt5haj/ZBFjchASZelUuXKl8PUXfu
 zpy8U2ASXM+rLmn2kHEpIXkGHzy7b8fQVUfVOU4yPB+HfwVdM8QbMEOnURihVImmq7/QS4Jz3R1
 EEz+7h3zF6EYtcNle3X1EFHhOE8f0aH0QgPr++PbXeLi4HkLc1qUMkc5Sx2yc8r2c65k6HOOSFB
 Toc+jMm2Q6gSRXpf/0kW3+gsX4yScm/XS7COufOKU7Kn80IR
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=bfhbluPB c=1 sm=1 tr=0 ts=6a0dca8c cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=o_KNKqYLTMeQBHdYLnoA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-GUID: EuYE5LYV6RMyKTh9RyPAIHnfRGR96xOL
X-Proofpoint-ORIG-GUID: EuYE5LYV6RMyKTh9RyPAIHnfRGR96xOL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NSBTYWx0ZWRfX3to0t0XO0ObL
 1rE2reovDXkdajwu4G7dWFr1DeDo4+DRdpnzqxH2EbOjtzL2G8Xqs8E2xD+4Y+/HmqKA6tREi1z
 Y5tCsHgBMO6Ng3RSbgMHYxKPUypyrUODHtxE+P/4qPQ/XaHvUQt0n8gurX5GmXc8I3C+djVfWY3
 ci4Af97FMjxhpKn6A0X5bNLiYnMEfHTNWtBeW7P6kCQtiLKRtyq5ppKdEQEcOzK6PXSNJ51QNXa
 9X9AVxyiEKlF90GEJvOhbUuowid921l4FKZCkdAezwOPULBDOJVoE5XUOKIaQrPmfnLtbKLhged
 8cPFocrhJ4UM0L63tgBz8VlpWJrNmXlzr/mvkh9NsjXLfvFdYrpIVio2bsORcxH2PIEW61uLM1K
 iyt7r62/XvfhczU1bGXKkshiRpzQ2YBiEdYPoCn2XVsHO/P16u24wYh9PY8UNL+MQS/M+bH9WZe
 TCR3ibK6Tnx2jzPbOoQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
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

Use freshly defined helper instead of checking the UBWC version
directly.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 3c1f04f12c3d..4b230868ed90 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -188,7 +188,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 	if (qcom_ubwc_macrotile_mode(data))
 		value |= MDSS_UBWC_STATIC_MACROTILE_MODE;
 
-	if (data->ubwc_enc_version == UBWC_3_0)
+	if (qcom_ubwc_enable_amsbc(data))
 		value |= MDSS_UBWC_STATIC_UBWC_AMSBC;
 
 	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));

-- 
2.47.3

