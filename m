Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2640C5DF86
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3938D10E4EF;
	Wed, 19 Aug 2026 11:23:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VbIvobZu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MEjHo8pC";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1D610E4EF
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:23:21 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67JA7pV42947309
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ai2mpfKZ9Q64U9EcSWq6/G
 Qloh8B5BqPlmOsyedNzvY=; b=VbIvobZuwNYcoLbHhm9rnfvSLkWJsJpoW6sKo7
 UZQP1vQ6GLBdsQHCuLebNZXGJKZ1yDx4ij4oJFykAzctgDVvFfV7kCaoJyQcn0GP
 sSF8IzzFk42PHui9QrSCnwbCGPF4RHpDvUuPqQfdujDfDJCOCAMjq7w6GfzbLSbS
 /cgJGIduusx6VxB4yhsl7vHQ46aojTD5kY8ZmVjs33IAQbn5S2odh69eQ5J8Y/hV
 XOuqooPyQ2vK+7EIXSpAYaMrZJU+aD80GK53onFsdIR8rNB/sXZWnDc4gnqQLaAz
 WqQyWOQshT0DXMGA5RsvR6grZJ+JA+OPAsGOGeNNSR3IyB9A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfkaxyu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 11:23:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-39512608fb1so2378634a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 04:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787138599; x=1787743399;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ai2mpfKZ9Q64U9EcSWq6/GQloh8B5BqPlmOsyedNzvY=;
 b=MEjHo8pCfQFvRvUuTldVdrXiF78qXH7slaN/ovZckMA3q1DDO3XfvhLuDN1+3vJd0j
 NrtZ8wefgIFSSwL3W7cO84/OHJihfCsQ5ecqqgNJvxoVSvvYUCBgDa5GEEN1sdZwFyAm
 x9nrxoNJCOuTTvHR3QGyLOjhJp2kYkPRAl22/EU1q4QhjJtMsN6jPEj3HGNd/6W1BFe5
 xXqGNlFWpW1LmLynfDuH+4XRqPp2qkRFwZfEkfUnxIPi5lc9BZ6k6TCDeqz3sLAYCoAO
 f2zqz8Uy2qYITNcblV8fUsY4OTjqn+Vy2y+9YgDfQca5p5QTktnE9cvj+BLegbEKvz2u
 Qo/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787138599; x=1787743399;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ai2mpfKZ9Q64U9EcSWq6/GQloh8B5BqPlmOsyedNzvY=;
 b=njvQIIngu0RfEHYaEXgvHgqWqDj020ou0yur75/renBo+PN63SmO6rv0gAuGak6RTX
 CgC92f7I8hUmr9ucs1i7HTPYeZl/dJwoLND3Gzn7xNw1gltnmNQDROQX8vYHKhmVgkB2
 wdiuxItKcaX8xereU8kwu790d4Q22beE9ykkCjFFHePaG9uK/kVv1WRU/rwxaT48/XY8
 RAq+0rvs5Ka9/GDMXBSaY8BKKKmoQ/p3+hvsuRJXlDq7vQsJSZBFuFLfdeSI0wgaZOL1
 gTy39QYUDvUTMCZgdcZlXP4zaoOXEXITD9L2DuiM6eDFuyOyaOIGEg9oqGieADkSMViC
 V5Kg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpQ4rl94EYY8euweyl1mFnJKBMp2gA40tGqOq0pLi/5sPM9oHFhSePrvlS8FtRu1QuMeiB9VtgDLfs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mv4e8/vaZjGptvFPivJt/4jjkUqCyqat1jwKv6oB/4XtncmXwy
 FbpWm3arUG6MCUgO3N8g0m1Neih8wvuPoWa3g5h8qnb+8KHeLSAV/RuMp+54qJ+ylM8VvJjGRgV
 QTMBj62PF/oiB8lEE259FkhGfswDjjAcxeou/nlNga2cYoi7dfTfCN6ltaiigUCt0DOo9y/M=
X-Gm-Gg: AR+sD10X1w2BpYEywyP4lazTilua/J5QZr2ZdHxcJE8gcFbAKU2g0tA94RX0MdhKlq+
 VgGx/vD2A1c6m34SXl2LhYpsDMJBl2ykzzBks2JkSA7FcQ9QBa5lLkCaAKbb9ONyG4O8nbpqtwF
 uVlqQyMRYL8VWdgFXjdzE1NTF9a2Exr3Qb3jVMFasWpfAWm/MuSWLdc8XD2G3q7uVLAYG6pxkLZ
 eqvPYSFUOeiWkSNDXFCVwuMI6x4Gnq0anmD/K1NDNokC9df8wzFqKoYZjHqPdzDanxk8/SyeyFH
 5uI2nfHE0tqQUYE9q0gh2LVx1ufQJb4GxPkpExaQyuWwkW7lBYcJWX4Srx8uNSODOt+4vOCiBfo
 f8e6XoEPWJ870Bgf4Em5Qt6CQe/k=
X-Received: by 2002:a17:90a:e7cb:b0:38e:6f90:eabd with SMTP id
 98e67ed59e1d1-39580aa5106mr7138539a91.5.1787138599217; 
 Wed, 19 Aug 2026 04:23:19 -0700 (PDT)
X-Received: by 2002:a17:90a:e7cb:b0:38e:6f90:eabd with SMTP id
 98e67ed59e1d1-39580aa5106mr7138100a91.5.1787138596850; 
 Wed, 19 Aug 2026 04:23:16 -0700 (PDT)
Received: from hu-mahap-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3957f8b9b55sm763987a91.4.2026.08.19.04.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 04:23:16 -0700 (PDT)
From: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 16:53:03 +0530
Subject: [PATCH] drm/msm/dpu: advertise linear-only modifiers on platforms
 without UBWC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-remove_ubwc-v1-1-5357d5cc517f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABaShWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0NL3aLU3Pyy1PjSpPJkXQNDC4OUtCQjSwOLZCWgjoKi1LTMCrBp0bG
 1tQALDeADXQAAAA==
X-Change-ID: 20260819-remove_ubwc-0180dfb2908c
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787138591; l=2024;
 i=mahadevan.p@oss.qualcomm.com; s=20250923; h=from:subject:message-id;
 bh=FtDAmcO0ZVXIA7oxCRX7CLMaibYbkqrp9Htli2LNiN8=;
 b=/2ovlJGUfIk/2/+YH19t36lJKeI7tHFz+uS5EjANvNqYXoR3zYgKg1O4xfiItCC8j7Ajk1aag
 IuTlF7xfbDhA0LlZA4PpgtHXFsN1P/tiUTKHln30FGpOVfoHLSbdIuH
X-Developer-Key: i=mahadevan.p@oss.qualcomm.com; a=ed25519;
 pk=wed9wuAek0VbCYfkANx7ujIG4VY0XfCYrffFKPN2p0Y=
X-Authority-Analysis: v=2.4 cv=PoGjqQM3 c=1 sm=1 tr=0 ts=6a859228 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=DbAw4J9xf9Z7qnqxU7YA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA4OCBTYWx0ZWRfX+mznfsGGLB9a
 MZzTt5bgeCV5cbOn82WkaH7mDzXiyufaTtACaI7UA2t9n6J2mwsTI6HS0Yzji9OcBdZe+cAcxEW
 cFS9yZxzommITPY2xFYwZNg+jAlgMUS5gegSrrXWRutcUtYgPCpEfIq0dxsNO9mQyI7LdTvvLku
 FYHfoxrfovYSg57jTi73lKwH4Mj8MLE9VopU+lHusesBf901JkqZaS434B5+Ji9sxs4AGZTvm6z
 54odQXWijc1OHMeoZSb+4ow/pkdEKDvge2krIC2TEvJKDM5tzBKmvEQ2p0HMgHK26BxIE7d9m7C
 eYnbOeVzmtgrjN3+ZvmUZ2DBuDdTxeBnRM4H9NwCFWoQevZmyQnM4y6Ibq3f+AP7yPLPE27S4GA
 9ddXFd5zI/k/zz+6u+HKKOsVxcHIH2va/NG7ohVOmXhtWf0b2TJwWIg2UBzngTjO4W+eNuX6j0m
 xajSnbf1OL4F0JKfrTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA4OCBTYWx0ZWRfXzCDgvcm58iMk
 dqIgm7us495fMuSVnnk48BKMZB5ab70evkciE3PO+yqjnNw7oRiGejbShTX4IjIZik+WnBl9u3t
 CDHKHf+5bFHyOiFBoiEvFkD7gZwlsYw=
X-Proofpoint-GUID: RklBfaAyftO1OdW95vSXledTHqd0vMoI
X-Proofpoint-ORIG-GUID: RklBfaAyftO1OdW95vSXledTHqd0vMoI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190088
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

Certain Qualcomm targets like QCM2290 and Shikra do not have UBWC
support. On such targets, advertising DRM_FORMAT_MOD_QCOM_COMPRESSED
in the supported modifier list causes userspace to attempt UBWC
allocations that the kernel rejects:

  msm_dpu: [drm] *ERROR* unsupported format modifier 500000000000003
  msm_dpu: [drm] *ERROR* unsupported pixel format: AR24 little-endian

On platforms without UBWC, only advertise DRM_FORMAT_MOD_LINEAR to
avoid exposing formats that the hardware cannot handle.

Fixes: 71c5c23be874 ("drm/msm/dpu: check ubwc support before adding compressed formats")
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index 7b92082d35a6..c8bd034690cb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -94,6 +94,11 @@ static const uint64_t supported_format_modifiers[] = {
 	DRM_FORMAT_MOD_INVALID
 };
 
+static const uint64_t supported_format_modifiers_no_ubwc[] = {
+	DRM_FORMAT_MOD_LINEAR,
+	DRM_FORMAT_MOD_INVALID
+};
+
 #define to_dpu_plane(x) container_of(x, struct dpu_plane, base)
 
 static struct dpu_kms *_dpu_plane_get_kms(struct drm_plane *plane)
@@ -1836,7 +1841,10 @@ static struct drm_plane *dpu_plane_init_common(struct drm_device *dev,
 	pdpu = drmm_universal_plane_alloc(dev, struct dpu_plane, base,
 				0xff, &dpu_plane_funcs,
 				format_list, num_formats,
-				supported_format_modifiers, type, NULL);
+				(kms->mdss->ubwc_enc_version == 0) ?
+					supported_format_modifiers_no_ubwc :
+					supported_format_modifiers,
+				type, NULL);
 	if (IS_ERR(pdpu))
 		return ERR_CAST(pdpu);
 

---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260819-remove_ubwc-0180dfb2908c

Best regards,
-- 
Mahadevan P <mahadevan.p@oss.qualcomm.com>

