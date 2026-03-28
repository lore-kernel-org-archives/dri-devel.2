Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E266F10F3DEC
	for <dri-devel@archiver.kernel.org>; Sat, 28 Mar 2026 17:16:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B9910E00B;
	Sat, 28 Mar 2026 17:16:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ahtFXnkO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="b8lo4Cta";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3B4F10E02E
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 17:16:32 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62S4djLU1453448
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 17:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=mZD3x0HJuSCzzPyCaSHhq1
 IV7sA2Rf1lOufYvYO5ZeI=; b=ahtFXnkOofa3Tasm2DSOUi7CkJwXbrLqsQZ/u4
 bcHa+JhZx8rR4dQ7d67QZGIooZEMa2E4SShuzuk8dUFdJVuCVMhEdcG5PpRpbo6Q
 yfG74xrYl+wHnKOnrQptKyNZnioqBGlidfpH/L6uwBO2G3LBJB0PvSuW5cGbVxYd
 J0bN/9o92ExLCFMh/CjcTN7eFwNsdX5fJgQlJBUINm7a3Ut1BpRwnKTGhjng8471
 VGdqEFM0ttdZWGfYTnIGXLwUI6EKgPsfjVKGUja4O7TS82pN2vcSkJvcadzB3fcn
 Rb1PSTLIRCKTxnHqwBJsGmO0CPhT1Sn5DRkVgmzkrqu3fWAw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d685h93t0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 17:16:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-354be1b25c3so710317a91.1
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Mar 2026 10:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774718191; x=1775322991;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZD3x0HJuSCzzPyCaSHhq1IV7sA2Rf1lOufYvYO5ZeI=;
 b=b8lo4Ctai/UmDImA28jf7SeI8xIOcE90YKz3T4OBiEqQimrqIQyKwMz91tl5opJ3vR
 Zo3eZtXn5UdwXxVcQIH60YBSlCwVzpjwlH2l8nEHFguwLTLXQfifVMw8AnIicWsJOpGb
 vgRikY5lC6HMWuazinBMozr3Na/q6TyFi5Gldl+3JMoN7ZWdJGRFj0OP2cTORmcCmIOA
 /oqk+sIZjhKOXHhtNBJ0GczIa0aPUi0/9l0kcBYuP4iZdmTe+uWuehDYOE6VCZ/AFa1E
 ZSt5tDxkgWOZOggbIMif0CFmydWLWZWv13mZ+TWOktLrNNDVVRDIlgDcg967uPhBQOGj
 22Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774718191; x=1775322991;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mZD3x0HJuSCzzPyCaSHhq1IV7sA2Rf1lOufYvYO5ZeI=;
 b=pUGXTHqxfQ8KvKeTnEqkuHLlq/CMXtzuT1pkJ4GVPaPfgpTbJr9eEhBe5u+AimNsN3
 5SelqzzBLn5Rb292PuqvaKfCcKtvCUOXfxEza6hnQxDtoGDHWXx1SZIdzN6Z7FBrNh1k
 sT98bh2/ZKotA8aOV1V26Nk+F08Ztl0r+Xg6aFJvZOEHGZ1aRoqQ/2hM+L7HEXoaI+S/
 iMx5W/ul284zF0BxKNLATxSKUMgoD9O7faCL/RSDrLe7QFM7pMhNKm0TfpulhlVmq52n
 meaOOphyIK7SmMlDl/dleVAYKT/AaS2DarKZPHFL+ZQCPFF2KvE7pLZmh6ORslg5SfQd
 9lQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSFJ5/hk3uVKRqhhmn0uHjAkRPqlDd3848tc58wrM7xMWPiksWrdh7gOq02Jo7aG+RRsGlSpgzJJk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzokUXMP1kAXtzI93wMtjWN5k5H0YvYkNuRa+8pHZRS9lk5GTpf
 8hojsQqEnx5L+CUcPptrvPg7cmfJEcMXPx9FwvuZZfy0ee8zK/C4E4cA5TQ6pO7SIKXH9/ahf2B
 qQFecXYNYStET/rN23NdbiFcuytEhnfOI/dbtGVeV9AaGvq3E+W1AZzHvILszxP10ky+CSL8=
X-Gm-Gg: ATEYQzxjgmkSbPvt4vK0W9fbQXkHyU3gGuI5S85Gh1rHcNHGofrSmnXQLMIaCBAPgyr
 VewL3yxLVIkvz6Jhp6xSxtj0rHAYJUXioK3l5AMe4imGhEGG/yMCRq1uU8SjRL4lvb+ZJQCGj7h
 74uNI3TbD+UENLTa6/bXphP2fTe54X9Uw4us/tBdmUM5p1cd/2lxYkKsn7ZepPUb4fEqiC94GSF
 CZPCclpM2WgaJiX9D0yx63lSASmlH+3fxfb9Ntd6COSjdDoz0A3ptSMugsMxjzDXni0/nNDBrub
 iZGJPhAZZNXr8N/yGVqHePrJUy+nAztOmuQ63fHZ1ReBk2e+yxKhcXIIoaiy9drBOvcIQFPnPsf
 Q3C4kpQp3oEJTA1LkprtBSKxTreQMEX2/4znA9TyLH91hulHcH0qhcC4s4Uk1jGNOaLbmhiEtAe
 8KpWKORDzJC2MbI2qSVBV9NKdz8CfRmnNbUbfEpkoAKw==
X-Received: by 2002:a17:903:3d07:b0:2ae:8073:a4ee with SMTP id
 d9443c01a7336-2b0cdcb02f3mr43446535ad.4.1774718191375; 
 Sat, 28 Mar 2026 10:16:31 -0700 (PDT)
X-Received: by 2002:a17:903:3d07:b0:2ae:8073:a4ee with SMTP id
 d9443c01a7336-2b0cdcb02f3mr43446295ad.4.1774718190885; 
 Sat, 28 Mar 2026 10:16:30 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b242642b59sm28773755ad.16.2026.03.28.10.16.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Mar 2026 10:16:30 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Sat, 28 Mar 2026 22:45:35 +0530
Subject: [PATCH] drm/msm/disp/dpu: consider SSPP line width during mode valid
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260328-msm-next-v1-1-12ac4e27c670@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALYMyGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyML3dziXN281IoSXXOD1CQLS7O0NDOTFCWg8oKi1LTMCrBR0bG1tQA
 OeY+IWgAAAA==
X-Change-ID: 20260328-msm-next-70eb896ff64d
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 prahlad.valluru@oss.qualcomm.com,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774718185; l=1740;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=t/2lnWeiTJVLgm11rWwGyHISGzd1lCGdDHW3CjscREM=;
 b=LEiraT7HPFgf31Dv/7Ky3m3a95LyPrjVgKPhAY4+TNIg+1B6G5g3TlirCT4ijQ1PKkJrYbslX
 E0wrI5HhFmgABpSsHgy+Wu6g/tJSaLGqhRbz8D+5msDsbGEVwlmftUD
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=csKWUl4i c=1 sm=1 tr=0 ts=69c80cf0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Z6NFRpVzsh1R41ZnZt0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDEyNyBTYWx0ZWRfX/WWG5HjzKoU4
 u6lpn60+glw/i2flZFTdZ/3UTXFzma88+kPCRfObDNnbCREng2OoVecYYETf1Bsn0wgNK3CrKie
 fkSOpc2yBJ3ls6dXZsvWA/+18uKmVZQoeCR0Uku64Qfeva5/Fc9Thu9p22g5RBL/o2tKm1afE45
 znKN9heeZqERJY3WsR3yB56jkyHry9j3rZvHqEJrVJzBYbg5CkAc8kG0NeaGihaSQ29xJqB5GMI
 04djEGzB8ZzT3m3FJGI/2JeBR00bE9qcPiJmjqw5k3SiicPnrRmvFCs/r8Pdx98u72A8ce0HRqb
 LkI9jr2jhOtuoXUZQmvQBvHW4XXWuaDt+TbTiCBQCQ0APho+mOB3w6ACi5EPyrHbxsQWCRklNMZ
 pzJffDj24CyVoqHJCp07rsaioo1jHlZfPZUNaRPUyoAXafh6Kn6To/36EC6Z1tiRgP4Jkn6P7Gf
 gVco3X01cdydn4fIRng==
X-Proofpoint-ORIG-GUID: ltoztOcY9nOUAsR8p9EDc5WKG7f2yqMk
X-Proofpoint-GUID: ltoztOcY9nOUAsR8p9EDc5WKG7f2yqMk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-28_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603280127
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

Few targets have lesser SSPP line width compared to mixer width,
SSPP line width also needs to be considered during mode valid
to avoid failures during atomic_check.

Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index 6bf7c46379ae..af245c44959d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1591,6 +1591,7 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
 {
 	struct dpu_kms *dpu_kms = _dpu_crtc_get_kms(crtc);
 	u64 adjusted_mode_clk;
+	u32 max_width;
 
 	/* if there is no 3d_mux block we cannot merge LMs so we cannot
 	 * split the large layer into 2 LMs, filter out such modes
@@ -1613,11 +1614,14 @@ static enum drm_mode_status dpu_crtc_mode_valid(struct drm_crtc *crtc,
 		return MODE_CLOCK_HIGH;
 
 	/*
-	 * max crtc width is equal to the max mixer width * 2 and max height is 4K
+	 * max crtc width is equal to the min of max mixer width * 2 and max sspp line width * 2
+	 * max height is 4K
 	 */
-	return drm_mode_validate_size(mode,
-				      2 * dpu_kms->catalog->caps->max_mixer_width,
-				      4096);
+	max_width = 2 * min_t(u32,
+			      dpu_kms->catalog->caps->max_mixer_width,
+			      dpu_kms->catalog->caps->max_linewidth);
+
+	return drm_mode_validate_size(mode, max_width, 4096);
 }
 
 /**

---
base-commit: 6efced27f5df9d7a57e4847fe2898cdd19f72311
change-id: 20260328-msm-next-70eb896ff64d

Best regards,
-- 
Vishnu Saini <vishnu.saini@oss.qualcomm.com>

