Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1061DC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5419510E8BE;
	Mon, 10 Aug 2026 14:51:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="h0iBKJiv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Oeb3cGsv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A712B10E202
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:53 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACj02S2206275
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aDFyPqw10Ep82ElDuZGKcT1q4iRZM5kCL+pWZOCaT5o=; b=h0iBKJivkSLJmqBV
 Y+JcftgGcaGnvzQ+Wfkzz+L9SNN+MCGpFTfG/92s2hjvMAI3O0QM8NcaHIxz6qTR
 UvbfhzNT5nqKVX3mIjF4GkZQQ3ASdMY1KSjR2zfWPeSYpy+FOjf2cwyEZqDCt3i/
 TiSrl8Jg3N2Dh1dx6ewpTMkb3G/SbYgF703AQPVJTJIqQukmhE1ruRjQqbaNOnnY
 P4APEQNESwMiybS3RZVNxizROrIT790tQXTyz0WnOqOCbPqCg7TE2FwqOMWYAM3f
 2QCbXSm2Pk2qRBxe100K5hgYc7IHnO0jpFDmxrH03Ima4IV+2BMkrtoqUagFkw+W
 v7eGxg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v3t2h2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:51:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934993d0f39so188550385a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786373512; x=1786978312;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aDFyPqw10Ep82ElDuZGKcT1q4iRZM5kCL+pWZOCaT5o=;
 b=Oeb3cGsv+wdXe4RDe3lBaoO0e9D+o8dS613hvJHiOXiGcmGBcppUvii9QrKAWuGcY1
 aN93gFYTEWEsdr8ltEmMRpkP02BdPDd5qyj3sII/Eme6jwUo/PxNcbdNV9dD3VB6dASH
 Od9Z8g7ZGfIRoTTGFYvtAwf7nX6IIzpXjAppvD4UrtvhsLS2OhYTG/vJWVgNwwRAsQyU
 p8fUDaAGgZmebUrB9yNzLR+JZqFbSVq9i2iVXDOYwbAnjHIZs7g8BbRrocPDM1fiVuvb
 9KSw1T8cKkKC2XL2ck48ZaM/xkJIflbSlji+gjMjeYjJ4WYLxca4+XSukKlTJTWXWhqc
 Y1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373512; x=1786978312;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aDFyPqw10Ep82ElDuZGKcT1q4iRZM5kCL+pWZOCaT5o=;
 b=hRaReFSf4iGd+JMYLPpUlYDAreZ3aQyMTTkFLhmCM1U8XcNxAiSIIh20484VxQOmpf
 S8mhZyOxQBNdRzJ1Kw1nvc6pSyFQxEZdc5zw5nhoUBnEE9PY+RLz0lu1kCLXHd1IFgg9
 pRCi4SescPAwmYrdmk/txIOBKcHpyPxMp3AtyfJifxJIlwFI5UNaFkYleqivWoDPYfZ0
 9/dVUA8oLW23hmQzJYyVWqfSL+Ss3VrAg4r5e2k20Zc8AP7tnXByh7iPcefkUhcIN282
 1+5Vc+Lb/Z3TQuuRo526268e6GB7vaTkJZ8vSV8bMnTIP7qLgkEzNdiAzYh4xIqkCAFZ
 OMnA==
X-Gm-Message-State: AOJu0YxCDzY9C0DSdE17kab6RWD7bt7p3T0lISmA7xXYK6C2AYXSSQkP
 AXuvmw38aD7lUytW+TB4ivtnWEA0SfE7Nc1Qnph+GKFvScGikw9LaB3sAi8LXlgKwGxZseAwCXS
 jBn1NuFQamcI9RycgNV1ySbtvNNsm6eOrZCvCfp+opujgjARVSu1umpQ1iYJWJadH/yJQ2DM=
X-Gm-Gg: AR+sD13tr3Gc3fl8rYJv+OmyDJj3LzsolR66uSvut4AcX8vc421RNDuJXoThAd/kiG9
 nGE1RJIM0DinyEYGcfRQa221kUY9K+6HsR6HVyZqD4n3PAR5D1+5YzqJCCHpqYDzT20sB8pFwo1
 WXswk9VwEh30zZCesvDXjhAVaHghu3Wb5AM4of8uf96NB6RnIV4MFWMLFP9YRk/G1O8jLT451Im
 xYfuj68rviMjrPGI93G6naM5rYCMnc9tFomuGruDejtrdHPmZQRWSrIfComkpJm+gtZrSIg0Uqp
 3EFvlul1knqoW9lfF2cjsX9YZ/8wXNUnVvfVSfiecqmmEqrdH/AtpYP+ar9G6d2E3wXrqej99qy
 Y6SKnSKaGi3NybTYraTnRdzCRwtpaB6S/6p2R/fpZr2sw1BFEVe7fDG67AXythybc21JpL6cMFG
 IdLLSl9LtxnZyUjg==
X-Received: by 2002:a05:622a:2b49:b0:527:6d4a:1970 with SMTP id
 d75a77b69052e-52d20a7bc1amr264405081cf.38.1786373512053; 
 Mon, 10 Aug 2026 07:51:52 -0700 (PDT)
X-Received: by 2002:a05:622a:2b49:b0:527:6d4a:1970 with SMTP id
 d75a77b69052e-52d20a7bc1amr264404441cf.38.1786373511644; 
 Mon, 10 Aug 2026 07:51:51 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39fddd6a796sm22489661fa.36.2026.08.10.07.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:51:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 17:51:46 +0300
Subject: [PATCH 1/4] drm/imx: ipuv3-plane: do not advertise separate alpha
 formats on DC planes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-imx53-fix-hdmi-v1-1-fff9b1b17f25@oss.qualcomm.com>
References: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
In-Reply-To: <20260810-imx53-fix-hdmi-v1-0-fff9b1b17f25@oss.qualcomm.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=r7E8ZVmX9Up1oISda84Old2tqIxw9+NGvdtLAuv610g=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqeeWDVybdK+bajyFR2U9qOC1Id33rHVYsMqrqR
 jGBG/sFn9yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCannlgwAKCRCLPIo+Aiko
 1atqB/9Q8iKGctDO3jyDeWnHHP8qLR6BFfYSRKtvv7cIX14gCWNXxKcaDHsXJ1Eef1sHbQjrM8i
 rC3deEXGiUV1610r+8ro3YZjtsVFpED1MV73KjDSHp7skOMTFskWtM7zZDr42w+VZ0Ym62vcyQT
 4qXT/xUsZE/M8EQixz8cx8/TqdOSl6/zmqjGSBjvPKu0Zv+I0/DDIvKgx6eamKtOp9/8Nx7N8Ml
 Mmisre1dwGHWqBxx3hF2Ub4X7iRhYUMTLFuQN8vMlaB6nPLiqNnVp99lotDQ0emD9PXrNau6OM2
 ilucfD44wB6zE0lkddulgXdP2fC9GQWxudLWE+2Bv518op4D
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: ISccNEwppBlDYLkNsce46Z5CfqtqXIXC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfXyYxkcJTN18vv
 jpDkhErWsdX9pjo8Im//qQsAWhO714K8qa4P3j/aI6Qqpw0YO+gUQiZrj0Nvkg4FELUnau3wS1T
 SqHczmfsicCeZEDMnYZ8lt21FaZSN2hpZHREFuRut7nt430Xu4DdaxSdTEXRugA27+P7KChF6Kj
 I7EM07zQeiH8myJcRTtsec+/tRrIVgHtyvYfFZ+LBuMl3RZNM5loMQp5kAlc9WH5G3SYgghmCuK
 Q0ND6THWpSiudbrHyQeekrKsJ3ElO5fUJvDg+mHc5JnxDIFOuOd7QBZ0YU2VPbac6mYVsnLAdPF
 Akcd5yKmz1M09I5W71Euf24Yur8tLDINtI/9OSLeNq3frafkUCuwBtFXmJFt7T3nfPoOuoOS/Ks
 a4fMwqG8AwSqOIMD1AmCoBlGu0UzV8OJmzNWmgWet2OsAx8ZfAIxyXUt5txlzK7pDplIDRJGYDh
 h71kypNidlfWGU/5WAA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyOCBTYWx0ZWRfX27obZvJVKc5+
 vpkxC6IhQZKFTudFgAWYVY3BKYbA4hO+udgwHG2xv4sw/ClQnfdoL/vnOX4LsyRzS2J/klf2Hww
 Jd5s6E4WBG3szfjEUbsGqRcL8smyivM=
X-Proofpoint-GUID: ISccNEwppBlDYLkNsce46Z5CfqtqXIXC
X-Authority-Analysis: v=2.4 cv=c+mbhx9l c=1 sm=1 tr=0 ts=6a79e589 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=YURt6oeoqR9mFI1qLTQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100128
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

Separate alpha formats need a companion IDMAC channel, which only the
graphics (DP) channels have. ipu_channel_alpha_channel() has no case for
IPUV3_CHANNEL_MEM_DC_SYNC, so ipu_plane_get_resources() leaves alpha_ch
at NULL for planes on the DC path. Yet ipu_plane_rgb_formats[], used for
exactly those planes, still advertises the six *_A8 fourccs.

Userspace picking one of them gets past ipu_plane_atomic_check(), which
never looks at alpha_ch, and ipu_plane_atomic_update() then dereferences
the NULL channel in ipu_cpmem_zero(). On i.MX53 this is reachable from
any client scanning out on DI1.

Drop the separate alpha formats from the RGB list.

Fixes: f6b50ef14ea8 ("drm/imx: ipuv3-plane: add support for separate alpha planes")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
index c7ec09e557c1..a0fd39eebbbc 100644
--- a/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
+++ b/drivers/gpu/drm/imx/ipuv3/ipuv3-plane.c
@@ -96,12 +96,6 @@ static const uint32_t ipu_plane_rgb_formats[] = {
 	DRM_FORMAT_BGRA8888,
 	DRM_FORMAT_BGRX8888,
 	DRM_FORMAT_RGB565,
-	DRM_FORMAT_RGB565_A8,
-	DRM_FORMAT_BGR565_A8,
-	DRM_FORMAT_RGB888_A8,
-	DRM_FORMAT_BGR888_A8,
-	DRM_FORMAT_RGBX8888_A8,
-	DRM_FORMAT_BGRX8888_A8,
 };
 
 static const uint64_t ipu_format_modifiers[] = {

-- 
2.47.3

