Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07131CA5FE6
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:27:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E5310E725;
	Sat,  3 Oct 2026 00:27:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aWZxoaVH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ICW9VvdR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D1D710FA56
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:27:33 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NdvJ33883811
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:27:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ut7y+HUxqTEIDuhai56prmejHDpJMRa+tq3A8RiGqhY=; b=aWZxoaVHFjf2FsMK
 ZbkPi9jZiZW/8mihMdg53UmcWCysn/M0alswUCuCW6snS2tBKN9BQ5miSvsJV97m
 cw6pC1MaWrFkwxa9Fhy5WxL5lJmsGkkeV1Uq8Kk0/wFbaajZrwEAMIJlwVwMChOx
 ncyYzgwhvuKf8KLdwkHPWUt1Gf+76J/2EpZMiXGDA2HHkYUbQ5mnAAd5wIB56VRI
 hHnntnWPbJE8GnGXXoGOFludkXV2JawS3y8908LNoy8/k46jtofUCTtYbIQNpHCq
 kvAgkrqEie6nfeEzawe8PH+SuOiynYVdrejZH6pAupYREwE/w4m8u/9NL4xOFrT2
 S/GuUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h26bp40ku-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:27:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf7856ffso34678685a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987252; x=1791592052;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ut7y+HUxqTEIDuhai56prmejHDpJMRa+tq3A8RiGqhY=;
 b=ICW9VvdRinJjULt5NGTJQFenoLad/laU3CDkw6aHW5gP/c730HUmqRZKRScF+A6LhR
 UtOHbGjDWYc3orWWp8PPFDoXIWUmBKdsMjGr+mYlOYUmOlbIdjmmZl4BG8Etq3Q4+sMk
 VznYOF05kumNPXRri20f6lKfOsG2sNbACiZdlkBYRgs7EY1r/2uMkBwHLZTJqF4EHuBd
 CUVNPcOrN4pR0Nt+knSXZExFdYQShsFFj80bu2bTkakeSTzLvVp6TdQTxeGDnyT0Uqta
 WrKgrMAuEtQfqsQrptCJQloHgHmkFrJmgC7kWA96O+p0hqVKhgWT1DudQRjQ+Ddg8bhd
 a/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987252; x=1791592052;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ut7y+HUxqTEIDuhai56prmejHDpJMRa+tq3A8RiGqhY=;
 b=zRCTIWmruMsOWgE8BUrS/fpyU9KPk33GFtkcAft55/4jzMPxEvmfMfwkwmg+uWYoJ7
 368C41B4X8v/alH9B8jn2+waeR1vyTR8XJhFZrQN42pjm6Pbnnzh6VenTa1SZ9qjMdf3
 EWaaB6NPlYi+Cgl8h0US2Xifnrk840UoRZTW62UF/ZJ+fCs62NT8iUxyTsxYwn5wZ3qr
 N7VQdsIS34E6ePVXcIPrXMKijMTcd/xB1yBiv4rVXeoLo5L4ff4509CkcJOEv457KQU2
 5+iLH8IVosdTAWTFUHnugdHMcgQgyyD6lubC2eqJhAgRXn6UZ01gx0EeblRGvj+Cd+9P
 lVXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyjx87brgsQGRGvUB7yya0+U6FkWkjj0Mn72byLNpDW70mkhIN/PMIbCNOfpRCLAieDZreEBHiql8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kRPiObnV3gfuKPXfaP/ZYVrpPQG8DJRNCjUJkXVti9FD6l2vW2
 A9S+jzLcOtVpZteVxukZI3pGkPfim4RORY3TvwkbktUCzoyhAWQWnyCgBMXNe+IqimpdzIBD6OZ
 qIwFxp0UlbGxrACk9YFE+eBNNUKGC+LWLH98L20LbO27bGEkFjKLtLERAgMewIro9lQT1/ok=
X-Gm-Gg: AYBFou18KptwAbpo9cTH/FM6O+hzwbCaexIGgAOH/KRSfm8JWcXqAcQ/vMBp78wb4Yc
 3VT/Vm39kXupWBD9s+sL67VqTtfVgdQNt+8rHWMYfOcBN5SQYMCDBGUmCDub3cJW7+rqdX4Ugzr
 ee8084lApH3FtS3y8cHCOQ4Hsp3jlUjwYI0xHXTytLhnlgRijDmyCQb+nq4GbhVo8zFoTj3J36a
 F5PS7pwbihNpD5Ro+mr6gJQRnQ46aP0HCx5iM4uHVr4A3WTWD5aN+GDoEzAGDypvCgBRHkbgy/L
 rE9S5S6jkuowyBqyZW7XCHKPBow+coQbR7E7PaCLSssDhfnv9MX15jdIEYdyFgy4g7I0W0W7MtC
 HCQWej+3A5llccGOlzzS5IWVSEXzmGtY6g08pZ2vtcBeEt5NITA0D61Za/F8VHoaGcFnnBnJJo9
 eAWCEGFDNqYMNu
X-Received: by 2002:a05:620a:4726:b0:93e:50ab:10df with SMTP id
 af79cd13be357-93e50ab118amr253161685a.5.1790987251687; 
 Fri, 02 Oct 2026 17:27:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4726:b0:93e:50ab:10df with SMTP id
 af79cd13be357-93e50ab118amr253157485a.5.1790987251222; 
 Fri, 02 Oct 2026 17:27:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb86e68806sm1120705e87.4.2026.10.02.17.27.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:27:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:27:18 +0300
Subject: [PATCH 10/11] drm/msm/mdp4: disable the vdd regulator on teardown
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-msm-kms-destroy-fixes-v1-10-e062b7dae77f@oss.qualcomm.com>
References: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
In-Reply-To: <20261003-msm-kms-destroy-fixes-v1-0-e062b7dae77f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lrbGUFq5rE3s0mK6C/Uo88Hmym+VLyyN33zg+VL8wlg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEvhZBgZsYnMv/q+O85BaenLBmoTKt3Jg2Tlv
 mXhqOhiHuOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBL4QAKCRCLPIo+Aiko
 1YQFB/9y22H0Fd447dhKrunt4rK19joJt5jP5kS7BxDUhbmLS/klG4P2H5woAFgN+LUsIVClbSt
 0tzkRl9r8gB54vtT5p5Zpv22DYeNNVEMovdTczntOp+UkZZCuS2fXByXhsEgRnVEKRuN/uUPIdf
 4HbZsOQD52i5XZ3/kkAUN3xJqAXfeqehhs4Wg6fzlLUZMHnKQrmr0KtQhH6VJaJs7aZnrc6yIGd
 n/KMXfbhEOFuIzwwGj4KFbfwWjGnWFKPyxnmz1xh31nZYla+st5uKP4P4Wxr4+xtmKUHGyo8SMm
 SS/cGFG+oXcwETjCb74lHm0QcBZgInI4qPNuCXwMp8qVmHAd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=OMqyTiaB c=1 sm=1 tr=0 ts=6ac04bf4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=m8q_D-2G2n8EEWQKP4cA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: JaPspxMpDoSQr8vJZz8CicptxVJdwsO3
X-Proofpoint-ORIG-GUID: JaPspxMpDoSQr8vJZz8CicptxVJdwsO3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX2egcFKnvBW9I
 pM9qs8fguar1uUyDov2aHwRbeubqJ3D/gOYfPDyhjAEcuzid5L9lFGXB80UxB9tgLoyZA9UkRvm
 WUYZSGOm9kfMXEbBpABAsAp9IRCZdcU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfXzSP8jeGdsTWQ
 x45uIJIrRdwJqG08qLF/Iu3xjhA0hfmr6qRTBm176Uzaw387QWLaInr9iBA4DU16pypGgGjaei/
 vdUSGe1xy2pdvo1BKCYKEi8cAZUOVRPMbX8X5agqgfdY5PRuFZttspZKrunyDD99c9igQ6+ADII
 TzT766L5lNT0VrMgRUgRb8/GjwzQLa6O8faU2lpo1qwKes8Pbs93TZFzuTBysc9bAYglv6RDxJY
 MmZHWUiNyUDwzw72qs66dWkzTWUqITwEdU5X4bp7IhXyGYwBzsWTAm1HNStShy7Fz+jS8c7v50+
 bhFY0/CvyZ99TkxaUPdT8yixOqzAi2yIwKv4rTBkxpB/RxG3lvmSB2GCkaX/m1NpjulSbz1Cyn7
 E6X5Zx2uElz0MU9uI5cR/rxhJVrHHyGLKMlC19prLDp03W5332UGS615jO6PbW6J9tSdyoxJyc+
 iGGKaUzw3/S55jmZ2kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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

mdp4_kms_init() enables the optional vdd regulator, but only its error
path disables it again: unbinding the display leaves it on, and the
regulator core warns when the devm-managed exclusive handle is released
while enabled.

Disable it again in mdp4_destroy().

Fixes: c8afe684c95c ("drm/msm: basic KMS driver for snapdragon")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 62a79bdfca19..8529e7b2008d 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -137,6 +137,9 @@ static void mdp4_destroy(struct msm_kms *kms)
 	if (mdp4_kms->rpm_enabled)
 		pm_runtime_disable(dev);
 
+	if (mdp4_kms->vdd)
+		regulator_disable(mdp4_kms->vdd);
+
 	mdp_kms_destroy(&mdp4_kms->base);
 }
 

-- 
2.47.3

