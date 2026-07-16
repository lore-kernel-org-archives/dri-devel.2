Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFF2AC44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 20:16:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E5AB10F3DF;
	Thu, 16 Jul 2026 20:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z1jx/h6E";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XWeg3Uxi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C83D010F3D2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJoY4d3728722
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lVmTyponL2t
 d2Vgd9VyadgypYllVDsYovlktjbjmFb4=; b=Z1jx/h6ECaP+0UGsopfv3e3DiHm
 kZaweQRbd1+x3BgyE/UNPXYUEQT0MHEjj7zmL5Q/Jt1gBWwjFZkjGvnlj1DXY8Hf
 GvTHW9XVhzW2jDiwV1fEC/txUDFbG2li6kGYBkWxgjUEvMOCImV8TQris7CYLxzf
 p43BHp9QCHSqwdGMkM/szJKvPr1TZn2fo8iHJFbGqSJpQKpmNxH9Yr1slKi7zIS+
 4bJ3CLC+rOIcHBcCSPhBhHYHofxyKBDzkxOPpqAL8jfWLlbVr3+fRTAYts5yJxZG
 Eg08bXAyzUzn3YQrsjdwINJWbxuNPs8cu8J/LRe0dhHUsE3/Ipa02xdH3IA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2s2xb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 20:16:01 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so133732685ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784232961; x=1784837761;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lVmTyponL2td2Vgd9VyadgypYllVDsYovlktjbjmFb4=;
 b=XWeg3UxiNG9y20zJdqYPTjHvfyjxOwDo1F9WiaukI0fkYX3QFsUoiydUeZpa0VMMaQ
 P03C3b35HDD57zCkgD2C1Rhj6nCZH02Ejh1+yiOn1BsP6yZWz7bElRH7RJow2EDUnJ6e
 W9IkqDxcAQj3GwW6MiyjyBQ0/Qbq4dONMAz3lzlqcaci4Z5N04AMEOJav590My0tgKai
 4Xpb5eHxTkzvxTJWvOAm8uPu1QaVg1sMNNUbD81RcDI3PAci1B7oqdvn9nxj7kS5+LgX
 yT2a3UTW8CT45dMXJAQAlxeIDR2tOXSvq+1JS2MvRqQ9LuPvx3Zp+3Nx64XQFma0M3Zn
 6Q7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784232961; x=1784837761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lVmTyponL2td2Vgd9VyadgypYllVDsYovlktjbjmFb4=;
 b=nVRUx75Lng2dM+6tPiZWHQlPvVkHUERGhwffdN2RtF5tlMairYZikjCA6dz4E2lsBB
 ULyAR6ufjI39pwIKxI0m+J5aY6/r0C4TGxtJTiH2H3z0xvwP9xeIEXu8EK8FovkztroR
 D0FzYH3VS3FTPWalX7c8RozFlI17PX0hetuy21Vhv2uj0ZdCpDHl5VwsKTbqKWHzLqvo
 LVNl+dr3ntUMe+r08YA+sBI8ryi3GVc5DieEcDvdfOYcqKOmkJONqm37cgEiL0RoRlfs
 zKcDLclfUHTsAzq3xctfqbLDaNJnfGx3Dpd/I7AKrwdxp5qHAoU9OB9YQ8RIbEDi8RdI
 gZhw==
X-Gm-Message-State: AOJu0YxwsjKS/wByjFfHJhgWOmb7c2VmBy4j9/iEE2a/SCfGmvMrjz2P
 vO38QSLG4f+YfSBhbN/MXYu7zvnizhUp1gfWJPJKKHPS+VE5X/iv1IE6hZgzFoDzSevD19QMueW
 HFaO/ZYzr+wPku8RT6TkIZN/GhiX3VChIREx8ZUr4vwDp2L9+fvXZNotUVAypF8Y03uPKmd2uCI
 TDmFg=
X-Gm-Gg: AfdE7cmabgRlyxpZfLddKwnh54VwaEHi3STH/DFl4CH/8yapH1+supKhNa+JfBKsgs4
 l9FEWCgzsuFvhfyCpTFKwUpU354AahuuqGpXspIehCugpeeEtltFnARU7UTRFYHJKWlLFBU5V3h
 zNkYSGaFUvO7J78qdrCqfz2JRdT6/E+21c4IrHG6nJwRJrYs12CoYNk0cDSj02whbAuZ/2+A736
 +3/fUY2uV+kPx3je76e/hOrX6FCnFGJatbzNlXJPIl14IkCiKkKX8r19hh+0cRO08POYo/BLRrN
 NSYHwXGyJtQipNov8x194DcFA5x3BG4ziDLc8QBJAvGf3PqdWRAwYNNR7I4AcJU2LizNk4DgT5N
 SEFPJA9XtJhSiRXTFi6gCXGabYF/6hzhdmHkc3ABQXwNJxKA=
X-Received: by 2002:a17:90b:4c45:b0:38d:56aa:6f32 with SMTP id
 98e67ed59e1d1-38e17f9e673mr12368740a91.38.1784232960547; 
 Thu, 16 Jul 2026 13:16:00 -0700 (PDT)
X-Received: by 2002:a17:90b:4c45:b0:38d:56aa:6f32 with SMTP id
 98e67ed59e1d1-38e17f9e673mr12368705a91.38.1784232960145; 
 Thu, 16 Jul 2026 13:16:00 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e39e1b8c4sm1804137a91.6.2026.07.16.13.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 13:15:59 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 08/10] drm/msm: Validate lazy VM in GEM_NEW
Date: Thu, 16 Jul 2026 13:15:31 -0700
Message-ID: <20260716201538.365824-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
References: <20260716201538.365824-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: L2mzRo8Y9QLNOI48QFDjoO29QiZyb4Zp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfXxmDMRlgO7zAQ
 tLX8qW89jmMPE3t80oZDXZmDGqRbJ4bdQZYds45gIJK0Hdfljp7ktH2pNuvbfXak0Okd5SYbkPY
 I74cwPttQMCh2gKx/b/18wBP6goXqGk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIwNiBTYWx0ZWRfX98L/LCLxsUcQ
 m169mt5Hf9bkp4ammiYxFZl7s6mG56AfMwXio2M0/JtjSJa1Y2MDZuLV9ONZ5j/ptyQF3n2n3v/
 DB+x6v3k3DNWgfvRZqwPLSQoaDwUbFfkqhCfFDvCRNh7PoaXDQjZFa+Hm4vreGg9HEqBlg8Y/cr
 UqTRhVIUQKt/HTwKav3304DLkclfrxsGrqmJiSA3TeMfiUE9oefJJi3WYREAIm9ym1RUsMXJ/UA
 rx1NNQ29Cm+2BmXtlHCW2xNgFqnEDJN+0zgSz12LNl+RvwYuUfpnwj4eyq7e3LlyMSmnlFqCUg+
 ThpJT7j2qzVv4HjxaXgSD+RLRXuJbymra9hCInysybERahIuHGPihD3Hu4LMPjYUZH/f8YK8PYf
 uFW6n1EBz3T0WcVfh3YxEClbxC4o4ydmAGD82AaoBTeC772nneQfeKW8MaS9Cwm+4O2nQppgcp6
 UJDPW+Ousu+Fqkr5gHA==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a593c01 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mcLY6QNbnPi337aWdgEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: L2mzRo8Y9QLNOI48QFDjoO29QiZyb4Zp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160206
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

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: b58e12a66e47 ("drm/msm: Add _NO_SHARE flag")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index efd3d3c9a449..afe0373f693a 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1146,8 +1146,16 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 		msm_gem_object_set_name(obj, "%s", name);
 
 	if (flags & MSM_BO_NO_SHARE) {
+		struct msm_drm_private *priv = dev->dev_private;
 		struct msm_context *ctx = file->driver_priv;
-		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(ctx->vm);
+		struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
+
+		if (!priv->gpu || !vm) {
+			ret = UERR(EINVAL, dev, "not supported with shared VM");
+			goto out_put;
+		}
+
+		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(vm);
 
 		drm_gem_object_get(r_obj);
 
@@ -1157,6 +1165,7 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	ret = drm_gem_handle_create(file, obj, handle);
 
 	/* drop reference from allocate - handle holds it now */
+out_put:
 	drm_gem_object_put(obj);
 
 	return ret;
-- 
2.55.0

