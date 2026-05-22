Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AD60CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:34:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 654AC10F608;
	Fri, 22 May 2026 17:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="B1JMWk55";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fEdEyqc5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE3B10F5E9
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:35 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MFX9qf1816086
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uZWxbq16V5d
 ge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=; b=B1JMWk55GaHgiWCzPuJxLZtkRd6
 YlokSf+1ZlCWA5czwzoleWZ1AnL5mKFJJ2sFcOLqwixvEErfRDo63Q9vsd6GpW2u
 OrtVcMySfUES9/YqbL+IwQWDuWi68nXNK/1+5nBNt0PS7lbNEVUm4U1AidJMIVNU
 0HMsBO+KeV6U7P+nwJutgyetySDJibNy9tUR76ifcGjp0EQISKffeGAgO4Yxevlc
 XUb9sCRABJhO4NYMI+Wsiias9AKTYNjbVt3tY+AmOjKh+3/9ArYDN6RBYr562ni2
 Ui1M4FRk4U60lUXb66wVd1Qln8PL5oG7hEjF4WyVRdxj41d+EaYXJmczXAw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrm35ha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:34 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-369467ab5bfso6642552a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471274; x=1780076074;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uZWxbq16V5dge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=;
 b=fEdEyqc54Dta+nnIyWibLhgwALOlXH9jvmOwjb4QXHKbw99kph+3PfyQ1QTFwgEZGV
 fJs529bfbSsKONGkAhoBETlSJEL3SstoLMXZBYeaUdQvdVHYBhwzxBWd+vLI3ciBLr1Z
 47ckKFXMP+YE2xvojWJxcdgkILV174a3mtmYo6slkXAAIKxfm1XpvIqh9xrJRd0XjmD2
 dtQhZDH1HdfViamJgPwEWvKZvk/Qjsdk++3QXuCY1MxatQvRpdpKruywMSTySBDTmXZS
 2/Bxm/KVZAaWEAH/PgGVqdjMm/tvQm/VOyDnDqPG0jv1lxoqW6mnlfdiR1W7HOgdc7tu
 IrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471274; x=1780076074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uZWxbq16V5dge8U1KgQgWh7So4/tb8nUVOkQSVzqIs4=;
 b=Cm7EISpQbqyjLw9UR6bywQqf95gCTQOYZGyRm4LL8vDjwqx2rg5tram04rzLI3irrr
 rky+6lnlt1hjUS/AYLO/lAINsIzwerxK37eYNwVc0SADTz25i0dRgcVP/4tbuE+8zzA+
 cw6m3sS4ObrA/ktzLmhriAikyN8OlNiGfnpClZJutWqmsMrrv16pQUmh3sMWF506EmME
 ucNC5YcF5L4YTGrbseYdFosdqwkx5ZOeEiFK3XRF0FaMBwEMfLmiW4ePygrl+xFWFSKJ
 WDSl2HDSd7qdE8PNxcu6XQ0yJisJe6WzbwKm3zIUd5n0rTE+YFZckIdO6PsZfTt1Ru4L
 NEAw==
X-Gm-Message-State: AOJu0YwQJGqiMaBaIcY7NHTQ276ANWN42pnd7/skK+uqMyFBzDOPq8Jv
 1vV7+YB/+mJi8zTXLfZ3h8nBrnP8SF0sePU3+u+P/qtGbKzEFwvLhmAheTuTaIDm4/MjGaJY1aU
 NtNoK3LVoikWdZM/ZWDnjgxJHkxcTpJNdTpOinGxnE1FsHfa49SM0HmVL+m2CT5xKx5PJR5RZ4/
 gVE44=
X-Gm-Gg: Acq92OEjiuf6xTVcVw8wWb0WiqOssx6utO0XJ5obllKDOp9YzY8Z5kxY81fPwzn6q0Q
 TfFIeT8p3sCZn10DAc//RXI84H3grnoY1bTsXD93tquVBWA2ibXTZq0pdl27HPonPkCTaYX+1Tc
 akK2dTbmo/HJjydDb9kw6nRFKbjqHHlapzrFVEQBfQ2tzn4MuxzmmcNqPeHpi6YZiFLdPUQuGVA
 VEFnH1togrYp7aMqyhNzry11p9E/NqSXQYZAsH7YB/svfeQivhj82xlJ1Lr4bX9OnT4Ve+xqlw3
 TFhlP+DcMtGvOgnPecActyO6hSz0EvbeTb79Jf5klJ2DMpQSo4z9iKr5PecAQoGHvX+gC8lIurJ
 O+mGxQOzuPXFopWa+RjtiXGfHWaqoidIe
X-Received: by 2002:a17:90b:4905:b0:36a:7c8f:1423 with SMTP id
 98e67ed59e1d1-36a7c8f15b3mr1889235a91.9.1779471274024; 
 Fri, 22 May 2026 10:34:34 -0700 (PDT)
X-Received: by 2002:a17:90b:4905:b0:36a:7c8f:1423 with SMTP id
 98e67ed59e1d1-36a7c8f15b3mr1889189a91.9.1779471273526; 
 Fri, 22 May 2026 10:34:33 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852057f9cdsm2063203a12.32.2026.05.22.10.34.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:34:33 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Fri, 22 May 2026 10:32:48 -0700
Message-ID: <20260522173349.55491-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
References: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jowgErO14LN6Mh5_ikpJ5r8N2vxgPNIy
X-Authority-Analysis: v=2.4 cv=Zekt8MVA c=1 sm=1 tr=0 ts=6a1093ab cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=RIk3oTIWcAeXYnX0VHsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfXzoYuXS4vWw9B
 cMN+T/5zMXl4uSoj1pYxHJW4bnDeeCwqV4EM8vBLuVFzN3iGq382/9wY/ZzzFkE2jDdIL0dIPYt
 N0W4Zj8pxqJxdi+N8hHfNH8kvatD9VCDqZl4pI+vvA9nhOrUFMm173G7FFOM2S6aqaSYHS13pe3
 sIbDydRNWR9R7eKMAATjG8saD+2SiFfNM1uWPS1cxT8Egq3HrgLaU9Bba/mHu90aYJ1TEtA1Qbv
 +Ao5xli9+mch9xCn1RSBeEXJy/G3dJSapegaMk11kH5uKsdnNM2nHJ9JHy2xPMU1Bqs3THJjjo8
 Trey4QQCBVrYxw5mgjQqLvfPQsANYgrYONfKuOU2ElGxzy+BGX+tR0+HYrIrX96vuyUXz5Ylo/v
 onfzf7DCAPlwsgx4LHFjRV2QLYuyrs6ym8jcB6hx/+yADSmivwOTTIy5KPyU7N84sA2H4py4pMA
 dBSnXsDilga2XUcKHmw==
X-Proofpoint-GUID: jowgErO14LN6Mh5_ikpJ5r8N2vxgPNIy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220175
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

Use perfmon_capable() which checks both CAP_SYS_ADMIN and CAP_PERFMON.
This matches what i915 and xe do, and seems more appropriate.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 66f80f2d12f9..72b71e9e44f0 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -494,7 +494,7 @@ int adreno_set_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	}
 	case MSM_PARAM_SYSPROF:
-		if (!capable(CAP_SYS_ADMIN))
+		if (!perfmon_capable())
 			return UERR(EPERM, drm, "invalid permissions");
 		return msm_context_set_sysprof(ctx, gpu, value);
 	case MSM_PARAM_EN_VM_BIND:
-- 
2.54.0

