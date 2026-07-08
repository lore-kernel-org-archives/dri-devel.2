Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EA8C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 17:34:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955D010E657;
	Wed,  8 Jul 2026 17:34:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDO7R5h1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QEGDZQ2o";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7191F10E63D
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 17:34:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668GLKMn3387179
 for <dri-devel@lists.freedesktop.org>; Wed, 8 Jul 2026 17:34:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EhQM9yoBxVO
 cZmBC5qd4hROEhHqhjZj00aJ/HtUenEY=; b=eDO7R5h1OuGhxKu3dSrkemvFIxD
 x65fp7ISvzqP0aEiy94TX1nRtV4ITGlqkFhFWTr2zEKfFkI8JbpItIhfgZEYO/5b
 BayJiS3GebAZ2VcHklou5UhFennNVuDBhsGYmjuD2mb+LTXRtpr8DwB7pUiYw3NY
 SPn3aNcpku0XXp2ddKHi0thMtsJ8in+YtFVzUW/9hc3BaMV8uH56eez/CnuGlUat
 Cgncs8wjOq0Ikys0JaSLt+ef6TYzMG3cQayrA7EfmWMwqeBiBah4x8PfFQWORS/I
 4rsdKPdjjkYE/PIJtj+/9jACLAgcAqBUQUsIzkkUHZyGTiO7LEAzM5Yhhqg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswbswx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 17:34:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cce02cb769so12548195ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783532077; x=1784136877;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EhQM9yoBxVOcZmBC5qd4hROEhHqhjZj00aJ/HtUenEY=;
 b=QEGDZQ2oySDyGhumJm5e8ZsbRHKLqlMtJ8egO48PJI2aCP707KtzNUZkg+cRTEEEYS
 Efz0UmkReI3ysk9h31ejRIjCyfW1R6sG7JHuKIhEAcYlerYNBLXX00I1z5ahXn5GwYxk
 92y5SD9vYAx0TAGCnKYA6iCOxZP0m4Sa/9mMAEQRr9lSCa6BEwjR+qwQAd9/02pyjEJ8
 Y8+x9lfetbGiahDxmx8R7/Swz5ck3Woko+xEwL30wviiPCfN3K1StTAW5MCETfBo7sWo
 UYsR1guKwS/lGsb2NG+h7YQRtfsC+fMuZSbrj2RYLcWFAeiyex8EygMsoqMTILPDaULX
 ENEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783532077; x=1784136877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EhQM9yoBxVOcZmBC5qd4hROEhHqhjZj00aJ/HtUenEY=;
 b=B3iqbd7Z7YMNYZJhAZitnuZACeM4uqU4Tl1hLXgcqR6ig93N7CiCCN5CRpMumswTRe
 Khyf8NpZE9Tbe0Xq38aVV6ZPLL1+i42179kT+UYjICqNhl5dYQ1IlQ+1bRKSM+jcl8oc
 SlKojqEJonyJUaqZ3cZRJziquS8FIR4XvjFIe1J1HvjXLMtA8sjGVcQ/zerrMXVj5rfS
 +XLMeuCvGH0J14GdKAz/nwmp08qC2HOS1YeG2+z9hvPraOsdjvdCfug3Q1zZzaSGyXKw
 GD3G4LJF+W37CfLMuQUH4IpK9rithNQwFfdvv8QIA9f99U0veROIiu8SdeZQfQJr8ruF
 mJ+Q==
X-Gm-Message-State: AOJu0YxQn6NbGsLXVYEUJX2rV0ZTLuDMU0Xyx/a3VHPeWVTjSgExJgMW
 gH3+DBwQFybiJz0JJy5IuHXiedSuWehWiJUpo/pD2yWgY54fipDbqHRgNAwwgSMQVmOs4uu45zS
 OgKaEkJ3+k8yy+MbcLvHebKFHHuzWluVMDgtb4e8HfNwWTWBEZNnrMZw2hA7tYOfNm9vC8yaff7
 SySGU=
X-Gm-Gg: AfdE7cnKJfBy1Ozoi+FBgrj6UgcvcmyBzZXOWh2U+xE2YEJ0edrZsbNffb5QPn45OKV
 2DdsEibOa1X6Ue9xbpKxbDgDjLIRJNXwhGScdmYf4dDeZ5eIHscPCNi1T7/TM2YITHPDcRlmlkw
 CrEYuf/xDGjWr5I/hkNf78NWuSJROD7AGeCsFTImgdmS07IchITFcXnkUIbEyzi4iD3rWBvZlSE
 pIM3Xjnezjxs3XzL/dxZ+SU3jqtXwKuuLKRTPzoOMAqaA0nUkI12ITX12DUkKGauSHls23YMo9X
 Qy2FZ7+NJkIfClHEV6H97lxnYfjrGbjg1Y0xQcRH9ILEIYuH2PV1UR6F0WZhh31ctS096AgJ9R4
 EZJmX2E29LAB7FYhnXAlzndQrJM3UqOqx+p+YJEJz2gx5RHvHAVfsfzvrZA==
X-Received: by 2002:a17:902:d48f:b0:2c6:a981:b591 with SMTP id
 d9443c01a7336-2ccea40c7b2mr36562175ad.30.1783532077029; 
 Wed, 08 Jul 2026 10:34:37 -0700 (PDT)
X-Received: by 2002:a17:902:d48f:b0:2c6:a981:b591 with SMTP id
 d9443c01a7336-2ccea40c7b2mr36561855ad.30.1783532076592; 
 Wed, 08 Jul 2026 10:34:36 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9d3d57bsm30956125ad.59.2026.07.08.10.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 10:34:36 -0700 (PDT)
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
Subject: [PATCH v4 4/6] drm/msm: Validate lazy VM in GEM_NEW
Date: Wed,  8 Jul 2026 10:33:52 -0700
Message-ID: <20260708173356.578713-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
References: <20260708173356.578713-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: QHVlguG_n6COcRxfZBz3c4BtD_9MoWyL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX6EofyyazG1o/
 u/wx88sihPFHzud1teAwiOPSi568anNiAFmdJuWiXJlG7lNUxOLAZcqkGCApvX/xz1G+qLaDeM1
 N12zKmfxJKpJUn0pC+RAKys6BTaEGzY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE3MiBTYWx0ZWRfX3DsUmiJFC9ar
 Jyzn/8SCgHnQlXuAqLjr502pYKE/M552/nOonK+7ETbsIuPEDOL0LCo94hXbcd6coejXidF1EmG
 g+mdor2pIP9jW86Hd6ge/LjXRH1HK5KFuiQgxQY3kR3U5bViB96FVAaOHPokIqBtUOsMht2Xs70
 YHY52guT/GkNId9Ea6AqN3zE8pBONRKUhXfyJN3H/bfjzBWk0xTPUTAn3BEEQBcchgpHudJZi0l
 p/1ra/E+GCbwsBj2RYQt25Cts0rUvFwpQRnXvY1Bq5JHogAKCyDAEaRFKR6vQ5w/C1C3dMztEpd
 b34HL0qq6piH1Tb0FGlgcJ8Y+4TeKS+JiAWX3K4TCzwbWS/SPHkAEDCRO0wn8QRYXEjxMPNlQ5n
 KcX5+wv5zPquvzfjP+UCKtyUYw+y9vCEQmR3+FDizHgyQpi953vTCQ0pXzVWDClpZjQrDLQ7gph
 Bt56LsXHunR390qLPmw==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e8a2d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mcLY6QNbnPi337aWdgEA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: QHVlguG_n6COcRxfZBz3c4BtD_9MoWyL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_03,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080172
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
index efd3d3c9a449..4442cfa55b00 100644
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
+		if (!priv->gpu || (vm == priv->gpu->vm)) {
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

