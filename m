Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4767ECD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1F3B10EE42;
	Wed,  6 May 2026 17:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OivMl99T";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HLYuphbT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05CA410EE42
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:11:46 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6469xtOQ1985549
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QpEOCCW2frO
 5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=; b=OivMl99TIdvd6nhFOLOP//OkGBR
 HsseTZsMnMJohRoaz6tMCR5J+QnNHTZlLGlZj3GuGU22pm6Dfr1qf6KqOTIXAqi8
 o76Hecpwwvo6WA/p9P/afRpimk9sOm+nLP5gq+9LwHFdvue5jvwrfQ7CM9BiY62A
 F0oXbl4u8RX/Of9RemnVrrUB5uk2RUHNBp6bCNtQjHU1o4E42RbnpLyZF9niKpER
 lDu0D5eu9FC4MEVG0Y3L4Jbec3VavTRCrC5Fi3rkRhAHNx/++mNVupt5mS40BkMU
 uJyakgrxn3Vh+IGyQIX5NGecIzVWfUs40Tes39S7zjURdwgbweQGxyzJV4A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03gp1kg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:11:46 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c70f19f0f37so626924a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087505; x=1778692305;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QpEOCCW2frO5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=;
 b=HLYuphbTTbmxFj1835LO0UGcGCdtr6P8H7CvPsUzp3EvdVYe7QtnIpwGCCGcS93hQm
 uiz6X9MAQ3dFF7nRfHgJapambBVGAkpQ4lsME4fi+dLJQyjQXVDW9Xv6tONohk7yyV8I
 465QJzG/L3jrQ5H6GiYPmgjAIIvQCvYcBXb0N6ZbTFcoe7o5hnt5eNHy5eADcmAJGrH5
 2rLFFLQOTBA10QlmA7yTcBSEaIAQTgQpvHXwVnVKG5+xmDGuIlZPem1aeD86Q0g1pH6Q
 oxWl0BL5V+aPcoFKqKoMt74l4ZsmYVWVaJhP3s+zUKm/G9jDVP8A2lrWQiAUX//lql7j
 lN7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087505; x=1778692305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QpEOCCW2frO5RjDS7yw8Uzvvr6ebtp3PdlAzKWnUJ/s=;
 b=flKTb4qB5ABRaIkWC3wcSaWXs5MCmWGYs6UO3upPwDH7S5SD/THQ76XDkSnG4J22r9
 nLmsnt/lsCICcU7byOgox11gDrOVylVOTuZgCR+XrNhu2GvQ/b6bprP4QchsvoeM/VOU
 QuRRf14spjaCsXilMgut+WIekhdnYMage2REk/Zp4Q52xlEbZU5ToXM9GpnDaKwwOKgW
 1RkflcB2zba550JoRE3Ka0vpR3RDPrVqci0CvuVIeG7cFDBbRsPMcj4q6F/E3iMmLixi
 Ykh1mC2oSSh9SgNbfjZxpWlbzgHmX7RyfuZk5Pcwlnx7H7H3bRaJOSm4WrUHIh6GvqP1
 jJvw==
X-Gm-Message-State: AOJu0YwV7DywWm5j1A9HBjj09UKikUp8wItTEkLoAHPgt0VQktSR6wD+
 I/nNW2O0aH1xoJwxL/wVXIiTyHM4J1J2z5/PNSulYbeOybq2J0QKNtrjTwybgtyb62O7tevP6pd
 /Ymat7lAJwX/p54Cn5Fr07Nv5c7NtbVflBjR38ldwY+FgCGcLWY+ueKzDG3XcNfDNmqEsoNSkXE
 6Kcg0=
X-Gm-Gg: AeBDiesNjqs6morbgzpyBiRvVsf9cg3CTghLfl9eajs0JFwHmB9MIshbXZfV2rQNHKP
 p+kKcOGvXMXv+CJcUVo6N67WfcO5sju+mKXuJDMZSjVg2N0Zoic8ie6QSmr7OGz74rVx85/fhiE
 kPXg/aBR4ObjC25VD8xaDiDpnB+eoh8lOTHesbEN20FqbZS5wCCH/Pc59FHCYnnLTruhzTHRqKj
 7hAknDoaTwTKjvh4munCc9WFn70QKVHLxAyUijUZq+zEy7YreKDLTqLpbv63Yj0aMPKyYEUcmvV
 p3rn4e5nKAjTFkDb2wvcA4ptX0Ps/wpqhjPAZWw76CHNKZRzkydQw/tM6i80flyBciiezMTKEjt
 DYuk5waVJXOok6qUGqs5DmaC0bKK3//NuF83dnCbZM6E=
X-Received: by 2002:a05:6a00:4c9a:b0:82c:9c90:6ea0 with SMTP id
 d2e1a72fcca58-83a543f90e8mr3635790b3a.3.1778087504830; 
 Wed, 06 May 2026 10:11:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c9a:b0:82c:9c90:6ea0 with SMTP id
 d2e1a72fcca58-83a543f90e8mr3635759b3a.3.1778087504254; 
 Wed, 06 May 2026 10:11:44 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839659498f1sm7685226b3a.17.2026.05.06.10.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:11:43 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Wed,  6 May 2026 10:10:26 -0700
Message-ID: <20260506171127.133572-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfXwQaEzxjEf30J
 9VeRhpIe9e0r9j83pgQ8TJgIP2R+S+2yQFHftKlDFpEiJgNH6ImIQDFMlTPVLv2A3BD2FCLIdcQ
 uP8O7gkMKLCqwO38924lzhZR+fcth2U59zs8Gz/Ih1CG6C8gmN/JPtHHUXkLTC7Z51YUnb2w0Tl
 kSHtmjNnXgG03NwLPLHEuKDy0OdZZtPhrD1ydi18zpDKLJViDWVfodEp3rwGJ6+gxWqYbLfP7jU
 4V/xIJgiuN4A0fxSWPbevSJ44RxXgenUieFps31z0xwA0pGPmb1juRBU4jEaCdQVcJv3sQ9ffck
 2Umxv5XHWXmuYeQxGxWDcjXZUIYi6YUB+WLlLGOlf5YkbTArtY14W8EoqecdEdDnP+4n+1qtgKn
 ht1er/ZR8IRzI4jdTScV+xAZCSO0qc8uYDiI9Pg6X8afAtWQ/qIcvv2w/nSZk/IEXRtxtORTN3m
 yE++etmyIYpSTg2pmTw==
X-Proofpoint-ORIG-GUID: 2phpHdBXR4Po-ROad5MrqREOjGjB09a0
X-Proofpoint-GUID: 2phpHdBXR4Po-ROad5MrqREOjGjB09a0
X-Authority-Analysis: v=2.4 cv=W8wIkxWk c=1 sm=1 tr=0 ts=69fb7652 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=ZRXlmS4ShPoOlOK7p90A:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060168
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

