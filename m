Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72494CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:35:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88E9010F6F3;
	Fri, 22 May 2026 17:35:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GseQe2s3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="clGpbCYg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D756310E2D3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:35:03 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGbHiQ1734187
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iwPf7oJ62+a
 JHGIAyfRJce0NdbfHJ0BsASuIH0Plg9o=; b=GseQe2s3QLBUxzv3ggRxO++52ne
 wABQLquVe01M6Fhht9f8epU2X9CiZpjAHuoh2fxBvO2A9Zz/DR9Y205R4ASenNbW
 iZCJLqVb5SGG5Si5oR5Bc3R1Ag8qID1ApPXn9ekKcVd7Pa3h8XASO1dHEKudIrC0
 iTYnPouzrx+vaRQUqbUz65MUxVuHvulyv58y3csjwNzIyWCDxrR4jKjIRV4V6UVq
 RtQ045piv64SSSlBAAV2FkDKIwKPzFOvns0dqpRoNYR8Bxbv3ZkwsnkE5k1Yiyrf
 yQGD7hy+Ub6xwmBXGuAScVmY1UNMEY/lSOQ0VWuNUl3PcnIZ1v+taFPOF0w==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eattq8854-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:35:02 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba86e35aa1so123501865ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471302; x=1780076102;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iwPf7oJ62+aJHGIAyfRJce0NdbfHJ0BsASuIH0Plg9o=;
 b=clGpbCYgO4w5dbat7tJL+thjglWi2jsUxNb1CqLWNurtkRyiA5uVMqNL4Uiby7TKlj
 ou8nFZaBx6jsfOrc523+Dk1swR+u9Db51FaH9DFpDa83g7qmJiqyz5MGYyDD0UY+chFl
 6cieQQ3PjwJ+cAXK3etVb1OhRfkMnQ42bg4ZwSlKyih15LUx3q8PmqxAJY2b1wtz7zs/
 1/P+sO751+R0HDgzdU0/qtevVkjnwBso/42feUB4P9o9s0uwLCw+1xBe6HtPJQH88Y+w
 kobLyu7Z/Qi/3vNGB4Nak3MVmhMJzEMeAUG+vjQO6d/fEvcRJ1wx7+i5NheJWrbyOPd5
 VeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471302; x=1780076102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iwPf7oJ62+aJHGIAyfRJce0NdbfHJ0BsASuIH0Plg9o=;
 b=DL322U5m/rfJdYzTHjuQGMx0Zd1k+goM78vSyvaknBFuO+WR8U45k+RPplt618cuwV
 AnPLDQda7m027pezJJILP65J7uL6/4tqvTFmo5ndYkUNoslKbdvv3ff4Vw7Iy5XrmE7j
 ypnI7AV96QAn/lomTbiZA+/ox12Zql26XtdCroZ8sMrj+2p1nYaE5lXoXgCU7gUMXUJN
 yOCPqwCARPW6BnWYYDu57i8MCF26EvBODcFs12WznjyfQAWPxNyUA6ElzRXUprLHAe0t
 v0FxKhj/of8bQBTMskPg3ry+uETNJ29jpmfxGZ8/RI1jNCDulrNjtfzB93wP4SBVzoW3
 3wWg==
X-Gm-Message-State: AOJu0YzxUt5ZTiTcMnK79o8viDsPTyde8p4GM6aAeo7swrw+t6QFOrF0
 7pYS3a9LYHUhsTiIed+HaUTNtyUe3HT3IwV9CTEzOaldzrGu0JwH7ft8/CU8gbGPo8vmUB4ve6U
 QWUJalO8iLuN5mdnFtfYpmO/+2g+2SoVNEg7EUUpKncOdYFDyRzdJpmOxbrA2xGDTGUphRTsmEU
 eF1yk=
X-Gm-Gg: Acq92OHn44an6cocx+mntbxcRm1d7f0hoP4WsygwcOThSZ9/K0j8xN3VTuNwf4V9SxC
 pfmuOamUw/tDiqQQL++Uwg6ah9/vGtP6iYmWLlrCFt3GDvdh2Cb5Eyf7TpeT5b/lMCtlJub2p02
 +DB3FyJ6jNZXpHjKEpPpEJIY3aVaLB+i6paQ8gSM0mCk/9U8lsjH7WJequ1FWOUmJ8OiW6vUALx
 aWb1FUZfV9go4gsPOgMl2lHKzoz9QidujzcGJTAN5+aMn7h5gTjuvVqnD9fnjc12+nxIFg0FodL
 hliOg9tKuYhn7zV5TqxudlKVfso6iWhxb9ifqiOgkUQWARu3hsqBAVpXKHMrzrCVTH4KIibwHl7
 6gziAZLyIVVerY6rN3Vj2VD/nV4FWHeRnfZKh/lgMTts=
X-Received: by 2002:a17:902:ef10:b0:2bd:6732:6817 with SMTP id
 d9443c01a7336-2beb05e291amr47621745ad.23.1779471301975; 
 Fri, 22 May 2026 10:35:01 -0700 (PDT)
X-Received: by 2002:a17:902:ef10:b0:2bd:6732:6817 with SMTP id
 d9443c01a7336-2beb05e291amr47621415ad.23.1779471301483; 
 Fri, 22 May 2026 10:35:01 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58c31a3sm22677045ad.55.2026.05.22.10.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:35:01 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Fri, 22 May 2026 10:33:00 -0700
Message-ID: <20260522173349.55491-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
References: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfX5eIUPbydiyuB
 //ogDcr6Og6TInGrs2I9D9IrzD2Xr8S9bvzo0loDtvpkTpaMEDFkASHOuiGySeBNQbPkJWZmDXD
 vdue8H2toSsMJwfmhIFINQgKWUn88rdrC6wsR0G4Y1qUifhxks81Xyq+fQjU4jCiWEFikam8rBj
 RbCg+Hrqmh82R44fBzM5zyHw4P8i74j1pW1ZHWO7Ik5CNQMfZvNZjarI6Mc1Z2fnKe46KPu2Vj/
 bm3qAmiCGZULZU2vxh77zW+cBDdAnl25eNEYQ56en0gsaTQjQ1cdP3J4JCoRL8dN0cYRzl24FUm
 rTEfcNrqR4bL08hO3Mwc9lN8Z8RdXgJAbFn9/toxeY27EPeiv+ItTGH12MLKtFJEnJnIsfDDa1D
 +s1cicwY0IdJqYOCIRVUu04pr+imEPjR6BqZdwvLS9cVkF0amxRlcMmhcdLxx8xqLiuC1KbaFLv
 ssXP6NglSa0EUiq7yBg==
X-Proofpoint-GUID: l4AHj7__Dbuglvhshjhp7ZfCZhaZ36_y
X-Proofpoint-ORIG-GUID: l4AHj7__Dbuglvhshjhp7ZfCZhaZ36_y
X-Authority-Analysis: v=2.4 cv=S/zpBosP c=1 sm=1 tr=0 ts=6a1093c7 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=QVKJPBlc5dbYwvk_-wwA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
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

To make room for appending SEL reg programming.  Without increasing the
size, we would overflow the pwrup_reglist at ~190 counters on gen8.
Or possibly fewer, considering that some gen8 counter groups also have
separate slice vs unslice SELectors.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a329d20033d7..e6c362c55dee 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1183,7 +1183,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
 	}
 
-	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PAGE_SIZE,
+	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PWRUP_REGLIST_SIZE,
 							 MSM_BO_WC  | MSM_BO_MAP_PRIV,
 							 gpu->vm, &a6xx_gpu->pwrup_reglist_bo,
 							 &a6xx_gpu->pwrup_reglist_iova);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 3491a24a9320..d3f0b40787db 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -96,6 +96,7 @@ struct a6xx_gpu {
 	uint32_t *shadow;
 
 	struct drm_gem_object *pwrup_reglist_bo;
+#define PWRUP_REGLIST_SIZE (2 * PAGE_SIZE)
 	void *pwrup_reglist_ptr;
 	uint64_t pwrup_reglist_iova;
 	bool pwrup_reglist_emitted;
-- 
2.54.0

