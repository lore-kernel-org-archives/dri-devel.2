Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC0DCD6E77
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 20:10:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1A6110E3BF;
	Thu,  4 Jun 2026 20:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vh/Hkonu";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gMWWeeH8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEB510E3BF
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 20:10:18 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654G6rji1957385
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 20:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ilxmFuDlZLO8catcEmMGA/pntCC0AnEtroDNREYCuIg=; b=Vh/HkonuWet9ZMa1
 vZ90B1nQn4A3WwXoc+N+wGPagdxZzVZe+CP5DC12bSCEDNcHXcwH99K9Ii7SWkEk
 GDKVJbnmchm/DH32w4tveLMTsj9Yo4SW23vCP+F6L1iXuolt2P+EMRqTk8jCS+I0
 INe3n1dB7qZqQW4nC+TzrmfznLhPi2R9pr2qQ+cXM8LpctQknLs3WXSFLtg7hYwf
 D60W4kVKRQ6HchOVecl9IrHYCwJmsVRq4+4F/JvRHMfabuQKPGlntuH1KaQPQEVP
 oUBu3Y9bxwB9rqPbprERVcI16P1cEB9j0DJCH8tZzthJOPlnQv1krjyhclHh6q7/
 BN5phg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekckps5ec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 20:10:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8422ca754d8so788278b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780603816; x=1781208616;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ilxmFuDlZLO8catcEmMGA/pntCC0AnEtroDNREYCuIg=;
 b=gMWWeeH8jh3XPNIaSwjA9k3x3ELFhpoJ/gx/wPhCZ9QAv6nPTWzDEgV7Sy2PR0oY3O
 Dire3voxKNSP4zywESFNAZOTpbBFEGPPr/jLRI9hEI0XKw6lWStprh6WbhiZjp8gQOtB
 PAHgN2VfS1+L0Vlm7XGYbTcWxvBh5kHXP0cuRGohVpkuAt3CZQLGhwgxmHK6Mlx0Uav9
 P+fwAM7cYn9btfcQx2B5DwKvZeTzHU7W2wOcl/dWTtpsxAmXikV/MTsQK6Etryn/Meeo
 COaWZEmczigC/4sSXKsjVNqU0Em0vZoxrP3LuYLmiezIR19n+dz02+pyq+2vFxnNhczt
 AcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780603816; x=1781208616;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ilxmFuDlZLO8catcEmMGA/pntCC0AnEtroDNREYCuIg=;
 b=fiBnI0H8juQUuHuD67KWe0JehXDyAfRG2JDhjur2ED6PPZf75a5uXhyLKoWgF0bpAA
 IuqHT2OBlTM/dLNrCdFAMGEsYPVFcMo1fsysfwVqj6i1/m8DafQxuHeemVVCbIiyWRx7
 +9b0+IZhvM8+BPYSZ3ANHA2awj2mFvIfY4p8+yJrqa1rgUE47Nvn3AzPVQXez6x6E92K
 nc9ityfFv5mI6p5qSQ4t9ED+nhkgIJqBChNd+xalOOzYS/xxealFGQJrUw8K9u9/T2+O
 sP3wbDjy+EtSdLkdyoqs3kpTSZDFpXpLLuvXYTodOXX3Z3uBHmKLwB9Vlv6Br5XmaYUe
 O3zw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FQlqs5SRx7ACo3UXLnEQ7xH6QXxqqd2ya9INPEU4mpXr1w276kdyiqtSwlXTO7GQOcp0tGOLvUsU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwY0ugKPYBOe/bLB5zyUf6bsjIPpxbOjbeuRqOhC7LsB7xuZkHq
 OcoS+L87NE0slbJ1SYoxQ39Hp0p5vhTSqSrAAfmyHreTBMJbe0/dTdxAyFLDW3yw8pDhxqzMKXb
 3VKq393DaFPpQ/8lpIN6Vyr/RwtiaCT6u9IFtE5FShk+ROE2Tvj51wK3QFYC+lP/WpE3Li8o=
X-Gm-Gg: Acq92OF1tt7nOqvSN9uzFAW02lgplQq0c5T2l2Pe7pHA3G/+s0uZiZ6LhM6PIRRpHIs
 8hJ1I1mayWzCjvWepN579NTCim2h4DfONRyKEhqr2noUx9fvymQia4icqUKk6gBpOdiblG+HQw/
 GfSCWiRu4/zv7RzO2k6gIGcSXi0QxiXz5/XISH5jw2ZnWnb3h+tCVs3tyW4CY3uDOa5qGGEwM/H
 Uc1HdmHM6y8SettznOQbZ2k3uHih6JL9YgBqzcgjZkjJqxindVDHGAuIz2kcVB5bJtDDCfg8v84
 FYUHhFtJKGcnZGl5JELFC/8YQnylOW0gFZBlc3Qo+wV1ozZGik0xkRJSD8eve8b0BfPJ5RWJEhW
 wNuBh6uKGLfXJCYqVbDdOC5E/Fq/pUuPtCeutxNZBFWnkchjT79K8BAXq
X-Received: by 2002:a05:6a00:bc81:b0:842:5a18:9af4 with SMTP id
 d2e1a72fcca58-842b0efb8fbmr208277b3a.18.1780603816382; 
 Thu, 04 Jun 2026 13:10:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc81:b0:842:5a18:9af4 with SMTP id
 d2e1a72fcca58-842b0efb8fbmr208229b3a.18.1780603815857; 
 Thu, 04 Jun 2026 13:10:15 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428290067dsm6721425b3a.53.2026.06.04.13.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 13:10:15 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 05 Jun 2026 01:38:18 +0530
Subject: [PATCH 2/6] drm/msm: Recover HW before retire hung submit
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-assorted-fixes-june-v1-2-2caa04f7287c@oss.qualcomm.com>
References: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
In-Reply-To: <20260605-assorted-fixes-june-v1-0-2caa04f7287c@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Puranam V G Tejaswi <quic_pvgtejas@quicinc.com>,
 Jie Zhang <quic_jiezh@quicinc.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780603799; l=1149;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=sCyhvltmN32cvMyVIs4m/if40/Cj5ebIU1UMeNNMVWo=;
 b=dhPyHwxuQ2yTZzxERFHZWt8Iw4FNwVHUnlfxMyfMHEXDatrPKhl7skcv2878t4g440BzWIJnX
 QyOLU9xFtMOD3PE8zqUgAeW7aobGJ82pjOLAe/74FKjjRAR/v7NKWPv
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: NXTjFRlrRAf-0tZcey-9XGz8X-IV_xnV
X-Proofpoint-ORIG-GUID: NXTjFRlrRAf-0tZcey-9XGz8X-IV_xnV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE5NyBTYWx0ZWRfXw+6aOlSOMtGW
 GWwlpv5MdbgL+2XtlYSjWUbxDF9ZyiNS4p57P9uU1vtA8cvCcSKbd2a3BBlIn7tm7s3Xz9310uJ
 lCfJSjKs1gcB+CVIshGtpCeIeNwhLvFKnRpQt5Xvz6bQ563J7Zxauiy57SBQpiI9DimmV9HKtCT
 IcVFufXfO/0agUbbslJgmScIk+XTSWgB3isv3JrHOzT+UqS70eF5dS2GtmSELuAshD2ZRnPVGoO
 GqKtN8vIjjOK1MLC253VAynDJwM/tYOYJ7OJCOf/f9jGUFr68ySSNZzKfjwvUh7cpOG+vaDYXZL
 76aU7jfS3ZWwphruwrQJJzEUgpDDARY9gac2MXqhmpV3baWxEHaWbBtFF6urkAE9tcfJ3j7+zSX
 VnJeWOHNmN/u8+4vLLfhEbKnF6nsJbswlK54FOYG8wXlb489zpakeu5KVlkqxS4sS6zsStpNWLb
 xumEDURFbjy8GqLot0A==
X-Authority-Analysis: v=2.4 cv=H9jrBeYi c=1 sm=1 tr=0 ts=6a21dba9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=-HvVqG6-LJ5utcurNgEA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040197
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

During recovery, it is not safe to retire the hung submit before we
recover the GPU. Retiring the submit triggers BO free and that can
result in GPU pagefaults since the GPU may be actively accessing those
BOs.

To fix this, retire the submits after gpu recovery is complete in
recover_worker().

Fixes: 1a370be9ac51 ("drm/msm: restart queued submits after hang")
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 18ed00e5f143..9ac7740a87f0 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -552,11 +552,11 @@ static void recover_worker(struct kthread_work *work)
 		msm_update_fence(ring->fctx, fence);
 	}
 
+	gpu->funcs->recover(gpu);
+
 	/* retire completed submits, plus the one that hung: */
 	retire_submits(gpu);
 
-	gpu->funcs->recover(gpu);
-
 	/*
 	 * Replay all remaining submits starting with highest priority
 	 * ring

-- 
2.51.0

