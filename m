Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBDCCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85F610E907;
	Mon, 18 May 2026 19:08:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CNXTESBp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FoJaiCKn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C83A10E907
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:03 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64ICFuCd2701025
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=r626fk8GTYQ
 7mVDurnFWdbX+Kfuz+zSekrPETuLYfy4=; b=CNXTESBp47U1AEyP0/C8RdCk/Fd
 ackEbQ4Rot206/j24X7xEnrghkdCQHZJO4J69LbGUe6hLYAwYeflzWwUa2Rx6Iow
 a40P1PFkkaNtRaYl1eFRTVJpTxbOEgsO9zv/JimfjZjWDU7YhaxQTKFNU2erp7ny
 +AGllerARffASgVWrm1RnmtZ17OeR6r1Hfqplluq4B3Q6Lgtn0ZkkLA/5v8yUlms
 05rQa9ZRTtHfsZnrbAeBtSqFaoXJQyS1Vh1gOpU7/g5ne9i4q/KqgcnGh/5dFIIY
 PP3yir8P5PIXi5ynyc+mtSsDNUhP49uz6qQRjrPqSJLgxwWuSWUUgSIOstA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e82mehjwp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bc763c7256so64381485ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131281; x=1779736081;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r626fk8GTYQ7mVDurnFWdbX+Kfuz+zSekrPETuLYfy4=;
 b=FoJaiCKnjXYQe6HS2DSgctRmfbjuJVR7LmN9K1YDJwYQfOCxJSeDuVBo/dcIwgzznN
 gzyEbCpZCyKq0k+wRZFqPEjl7wCedk5EyOjMv/0xwFzPZtCkTy0xqhDUz2o2Uz2oZy4U
 /cnRoM7VLI+4zpy7yiY5UQZFYMHKdnyH70hXWoZWmUz5hjsEWVjz8XQkLDdxW7/CArFE
 afMg3dzOOaVk/tLVRLQt8Y4XI5H8X9FD3BP4bMqrqk+fRpFi6w2bxtTNMqgwL2xa9O3u
 Rx4zNTNCB20prFklHTwMRGwP0XKeanrlxzh+ENX4H4vcArwYh8LUl+BHronfTOQWIXf1
 OOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131281; x=1779736081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r626fk8GTYQ7mVDurnFWdbX+Kfuz+zSekrPETuLYfy4=;
 b=IzzE2oioBxlP1mNOLJ6fCvq/TB05gZIj/kAvu3JIO7prNJeKoeg4CQaJSmvinsYmA7
 6iVpaH1h/TzwrgqO8LCNy0iKLnWAykbggoBc+OiBylvqdQ2RIQ55eDK2BkCd61jdPchY
 ocpY4Xvb0sgGacAkLQbXrgphCdmk/zqR8+JGhcv9jkN/lpyPHNQRTOZTo9bFsNe2HfFV
 UVUhvQQwAq/O+VcFdlBGxhfsGCXAuYgAWfqK9Rkm9jOEA3NvnvJpeGgEPMsb88SV8K/n
 H+AeLEzBURy970lqiKIG59mgaNIkFrWLs3GrqqRJ/boLapHSPhVTQLOqXvoApwGHcIJB
 qMFA==
X-Gm-Message-State: AOJu0Yz9PepcbO1EcWiMBjqZA5eB/kW1kmtX8HPzYcCUvC0tWkQYlW2f
 6EFzMPlf4Lw9ffwquakru5EvD6nDsuMOVG8FbiYC3hX1EfiBOI6Fnd/acEKDjQ+7o2lU0GBsLaX
 B+YcjPSPLozJfIcBDjhD1IBSeWeelcyrBCkNxQi8V4QfP+jBjUxzMOebiIA9JDlr0jGq38Bxdd1
 1kq/A=
X-Gm-Gg: Acq92OFLgXPCtifI74Eo19BcJW6J14R+g76Z3ISf4rqtIjd7WqQku+VJgAykGrGB8cD
 R+ZIGE0k3Yob3U2ONaEJwLi9XwbZXDT0yisJuNe7NpSOVfl8Y8ivxj+uQ6xQHyIS6t4Ll3/QmEy
 uGvbKDX6qM9NXGMfbPck0pE3md4N0Xrnb2iIQfFvw1xYAMDpTAJEDwhULit13SjjtLJWZW7TdC8
 0/bhBgiyTIpOcgXtYSRSRLZnS2fUc+TufF4POHNocq6q8mXJTImcYWzu8XE1hwUrcgwWdBn5Z/p
 /mCy+vMZ/k3VpSszovtpehMKfT+lSxpOSuepn4PCCnzEhqbiOJ9U8VS4P4tpjGvcpOlMUv3hzFX
 HPkgFpvNPqIDNVML95vmc6uunk3xl+32w
X-Received: by 2002:a17:902:f38e:b0:2b2:4d36:7aa with SMTP id
 d9443c01a7336-2bd7e8cbc80mr136657755ad.35.1779131281370; 
 Mon, 18 May 2026 12:08:01 -0700 (PDT)
X-Received: by 2002:a17:902:f38e:b0:2b2:4d36:7aa with SMTP id
 d9443c01a7336-2bd7e8cbc80mr136657525ad.35.1779131280870; 
 Mon, 18 May 2026 12:08:00 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5bd5ef27sm202768495ad.8.2026.05.18.12.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:00 -0700 (PDT)
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
Subject: [PATCH v7 02/16] drm/msm: Allow CAP_PERFMON for setting SYSPROF
Date: Mon, 18 May 2026 12:06:29 -0700
Message-ID: <20260518190735.16236-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Tr7WQjXh c=1 sm=1 tr=0 ts=6a0b6392 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=ZRXlmS4ShPoOlOK7p90A:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: mWzVZitvTUgrWbzTap68NW_zQO7t0qQ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfX29Ya2oy9uVzu
 oXvalnhxe25062Vw3p/J4nbpIfkgVOb5L7o21b1RvKsR36iJ7uY0voTdStcCZqmxBxb2sgh0pfY
 XTbW41s7mPp9F9Y5UBTrGnjihh3PlZtnb2mehI9dhPLlAlxTT5fXXdoqqO7ixPIDRN+BRwuzkiZ
 pm6VFBa+xjbZfw/UaJH9j9k0Jw4b0ZWb/Q37uFpsvLknNRkfHMGuZN2VHCrKzmJKZ9dHHY+f1/G
 GM53KB6ul4B8TQq6qq2ns+q99lTxCbDtgTyc1GQO/sOCEBKUM758KBkYX/Rw4b6S0nTVPElBDJw
 lhui1LdV4RWY6t1LYwFrYDQ/B/5S9OhT/8wqJDZgQvqtVREaW0HyvWR8srj4PcBIksZ4EwERiA7
 0lfI7rEza0bZPXO07SBSQJuvRdbTYC+Fne8OFizRh29UP/NmyJqx+X7Xm+M4o5mU0q7rj7S8VBK
 F9bVbQS6Wnt+tfiMlOQ==
X-Proofpoint-ORIG-GUID: mWzVZitvTUgrWbzTap68NW_zQO7t0qQ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180188
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

