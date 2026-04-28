Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC09FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:44:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B6C710E508;
	Tue, 28 Apr 2026 11:44:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R46NEpFH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NB9l6ixy";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6B3510E508
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:44:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63SAKNr61329060
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:44:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=09BroutM/9gDoJOGvfmXR5
 KlUs87eYX6swD5gKnzJ9o=; b=R46NEpFHaQxzelKZ3rLK2p0ApMzcbhCCEPBoIo
 rGMdM6dn2PRO35xJS1p/RDlUXy/4awq6oJGFUldereMCLRnDXFLJ0PfAK/88ryhv
 NG5L/SWAK47pyMHIyqvWePPbSXZ8xN2bnWxq+mFX3bXMF2HSAvUKgfIN/ldg7oBC
 fTEwVHQdUPsyVSUxOMFNfkSTS4dxSubkN+fDgoUCLU9t99MPvAWjN06tyR8IbJeN
 UPLVChFaws720jVPgq9hEk6CHe/LGQ1rszYuoSMLxVeVERVDPGbEDAZmDeGWA78t
 GS6lyHpsDolv02vEoFZkXuD9WDoKAl26XbGcvN51fRSWEmGw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhahne3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 11:44:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b242b9359aso113712845ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 04:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777376682; x=1777981482;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=09BroutM/9gDoJOGvfmXR5KlUs87eYX6swD5gKnzJ9o=;
 b=NB9l6ixyHN3oH1Otxfm39AncqnnM04pO9v0yu6zTAmbCP4gxt/vDE9/cR83fP2rbNJ
 p1nXXDIN+HrQDspSZi3ddB1ESGLnDBeZ09JNoax8jyFjpnE2jbYiidhGq38hCOA3de8f
 aAzAH2e4EzXpfHPw08O/419MhkTNDqpOlbLeJhl+zBVmIfe6hBiR7p4s2zWmziNJPWbk
 MDeHE5ff2PMGkaVRvimQb04E+NHsj9hSGebi2H8YUBl9HOyjiDVqzqg1fZtPvYcl/t8R
 KLJqFd88s6BZmLq10g//u+sod2xWhhSmVEWjdWIW2bHwE1kcAygyxYrNd7shKynPUZ4k
 7Fbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777376682; x=1777981482;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=09BroutM/9gDoJOGvfmXR5KlUs87eYX6swD5gKnzJ9o=;
 b=cPJP9Toy/ajkyD66yFf1FVEfSn4LxGfKlU+xfGJZblHV7CGrcwu3voijOkJeZ4cgi3
 Gxrb+gTQulsvwIQsCsbDIUVIcftrqU11MTM7fYyeU9XrfzQDHVGuwIORNk4OtqhqJIvl
 +P3v1Hfn4x90siyP/FTpSUdNCEKcBOTp3VxMTuNWKUlDMOuEuzHNzNWys7O+ppUH9/Ic
 JGJ2VoZk+C4kP+qce9W/8U/Pm8Z6USqLYBIJlfvUhq2RWbemlcR6UhFNkB8vttQ+rZQ7
 ysgKQl/ICkLCISxTK5GQz6b4AmcQ7GZFGovsW0IJi3xQueRYsDtErpcP+xFMAwq4oCYt
 dWSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Lqyd3L2FP6a6sdXy28Y3RDOll/UnUZfq9rmOpb4PGYmbf8Cpw0QxWqxWOYNsOctJI6TDlBxUU3aQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9mqeZacBn94oQdiWYnsu/rR1cF8qx95qJ7QK3vwcaL3cQ4H23
 Btaq+1Vl0OxqNuyIHQo8Oqd2QHmWlLPVvFBo0Y7pvsQXYRs/KD4O5Z578Qj8OdsaibJfQ7dh//a
 kaSAxauVri2y3s/uvSmJcr7v2gsS5gFPFXbGyYS0XcyKIzCQ1vE7kUpOROAZcqwAtUykWxhE=
X-Gm-Gg: AeBDiesRK18fl48/fUaJpsRDFP2bZu6Ps4SDaaWcF+wWBKVXq8f9lDSaeMfzpd5RfLP
 nR474LNBpfHF90CPQ2luBbx6w19YETmO2CoCfVTm/dgtF9PFX/0zgTTBV+EL/sIUbKHVKmJAY2X
 jMXL+RUY12ll4HUl/SbdjAQup3oeMTHvin/71QZVvFEiEKztdswU6kSR6qt8K2uLVOHMO7UAe4C
 1VSDZJc7lzGgQUHRPwTO4w/Of3rZsD+DEMlL/qPOkLzLyJ8MnTKc7Yj1RjU0QQwXklV4CV8lU+t
 Xu6HMjycNbgwAPCj/4udmSizz4nDhOOV+FYQT7gp0Rla0Xv4GUWYGYzNSZd0d2YtXvRCVAneT0C
 7i7G/EoRf+ESipYRVEEiAl6gnSfNOcf0q9dLZcKtiufCncZSWshoGJLG1VLs=
X-Received: by 2002:a17:902:e0c6:b0:2b2:49a7:a5d0 with SMTP id
 d9443c01a7336-2b97c43c7d4mr21606425ad.11.1777376681873; 
 Tue, 28 Apr 2026 04:44:41 -0700 (PDT)
X-Received: by 2002:a17:902:e0c6:b0:2b2:49a7:a5d0 with SMTP id
 d9443c01a7336-2b97c43c7d4mr21606195ad.11.1777376681241; 
 Tue, 28 Apr 2026 04:44:41 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b97ac79344sm24929735ad.42.2026.04.28.04.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:44:40 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 17:14:25 +0530
Subject: [PATCH] drm/msm/dpu: Fix Kaanapali CWB register configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-kaanapali_cwb-v1-1-51fdb2c65498@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJid8GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyML3ezExLzEgsSczPjk8iTdlERDg0QDU0tDizRjJaCegqLUtMwKsHn
 RsbW1AItL2lFfAAAA
X-Change-ID: 20260428-kaanapali_cwb-da10a05918f3
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777376676; l=1593;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=Mc8FjzNqLYO97VrVnYWJLdHqaKywApqHm6a8Iy0XDew=;
 b=WpSvQEIdc9OGOio+CXTzxeFmNzf+MqRABXzaCHKZggT5hQmx1zke2pAiOD2YPMzuCllhHumgS
 KlIbH3aEGS8A5XE60zVpzNMgeru1WQI5Zt6tBV8XbaCLPllwh6Mz+IF
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwNyBTYWx0ZWRfX1nOmcnS3sbtj
 bBYhDnGZ2zb0W4mg5qOSKxcf/3nuV6xTQp43iZupnoqBPZfcsrk9G5n8+3F2cjJSil0NEfeF+hL
 TEi5+dNifPEdbqD9+fiJAFRmD64eSuvhrnIkop/6d4B1pQmXZmCUA6tQ7MFtYXOF+Im3zz+TUdO
 PBao6R1a9XvHcnWrsgna4i0gQbhdJYlKHyL0pDvCUE3rdSEAhIQFMDp2SxMCzHsssiZpNe8/U7H
 xvDthJWWlkdrIWliUr9p/QeIdKwWEDmc0EgbWyFIzw+CTGq9Og2FxFzsmLjsaNx5l9M+y8JPnp6
 p3YysBNN6toto3pXSIXSIRtjIqB+lMLrMnw489m+/abIvQQ53wPKQiiciNCV6Z/0N7TJDAbzTt4
 wHr+hkkLA3T5eqUQgYZARkBvBgpThElcxxaMYQm3WOpTff1T4fW0UGkvGAKzFEBgkZZZ3y/PhUG
 kM1x9UYRHEhqbWbH4hQ==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f09dad cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=R4znKvNRx4XoUvq0kpoA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: ppC3-ljKUuuBL0M7Pd6L8AO2YnC75546
X-Proofpoint-ORIG-GUID: ppC3-ljKUuuBL0M7Pd6L8AO2YnC75546
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280107
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

The Kaanapali DPU catalog defines kaanapali_cwb[] with the correct
CWB base addresses for this platform (0x169200, 0x169600, 0x16a200,
0x16a600), but the dpu_kaanapali_cfg struct was mistakenly pointing
to sm8650_cwb instead. The SM8650 CWB blocks sit at completely
different offsets (0x66200, 0x66600, 0x7E200, 0x7E600), so using
them on Kaanapali would program CWB registers at wrong addresses,
corrupting unrelated hardware blocks and breaking writeback capture.

Fix this by pointing .cwb to the correct kaanapali_cwb array.

Fixes: 83fe2cd56b1d ("drm/msm/dpu: Add support for Kaanapali DPU")
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
index b7b06e45b529..06da1583fb1e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h
@@ -480,7 +480,7 @@ const struct dpu_mdss_cfg dpu_kaanapali_cfg = {
 	.wb_count = ARRAY_SIZE(kaanapali_wb),
 	.wb = kaanapali_wb,
 	.cwb_count = ARRAY_SIZE(kaanapali_cwb),
-	.cwb = sm8650_cwb,
+	.cwb = kaanapali_cwb,
 	.intf_count = ARRAY_SIZE(kaanapali_intf),
 	.intf = kaanapali_intf,
 	.vbif = &sm8650_vbif,

---
base-commit: 39704f00f747aba3144289870b5fd8ac230a9aaf
change-id: 20260428-kaanapali_cwb-da10a05918f3

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

