Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF858606A336
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tgc6s1DL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ub8vkq2o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A292210F266;
	Mon,  2 Nov 2026 22:04:38 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6CA10F23B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:25 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K6CPL1746250
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LhftlRe/CSU
 kquCFXDIS3K2FDp/8Q4a7FKAFxyGfNM8=; b=Tgc6s1DLZF1+E7qBWHc6/9jfRNr
 jljhhd4stOaEuwbamP0X9tI4+c5iszgkoRx5uYHx0+lHnb5mDZZvpMfpxaxDinVv
 yGbfCpHpY0a+VtcLXSVfamuZkw1dRnQXd2OPxeEneQ45DQnRil6BrRFiXRNavlVD
 YEgJjIu+NZsGENap8T+4DI2QV/QJjHFfH5JO9bvKQVRqCOpAkUs3BuosltzeB+o6
 BJnSK0JIlxgha0KXThLzPVNamHGvuExgx8tejw+/w6fIebJ3cdHKwn8VHU0mmhv1
 +Pg5ZfT73AgG5ceO3UDlM2kO/MF2vmWig8yserdTADb86iinLbAll0QDesw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpqmvu3mm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:24 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a03834d8ffso4430558b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657064; x=1794261864;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LhftlRe/CSUkquCFXDIS3K2FDp/8Q4a7FKAFxyGfNM8=;
 b=Ub8vkq2o79CGoZpKa1HMOtJGdveSzGGD6ybdeOf0K1RjV2txYotSAYYXW92lLsPQa3
 LDCVSBpm8xZjPWlg7IfIMvnX53b3nnvzMehjURSc3kmEd4DUGmU4+uREwy4+aOx1jpdS
 Gs/whqEUFC6yUm9wZHnti/iOnkpQlmWRaHPo0Ao2CnNWQ0xSpTEvMPyncwjHTVgbn73t
 AiKbxE/1p1BZF++4t6eE18zBi1oSAcqAmerHVZXDP0/UMxcBLj0lPDMsJYhNlwGXaHz8
 78lliALDE1a43NB2baBe/lLbNHjojBBEkJcPn3aT2MhmpSuZMXihMDEfUq+0EOLtKiN3
 ju2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657064; x=1794261864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LhftlRe/CSUkquCFXDIS3K2FDp/8Q4a7FKAFxyGfNM8=;
 b=2RDKsR+BX6oXnpOhO0heh2alqoFgBbfKm2muT8sMTJRfKCh/taRCHUOzfqzttuqam8
 NiXtHuQjew60vJRz8BBiystuI+2pgNTnMYXU9a4Fs6ZbOLw/rtPXWe0TNWs+EJEkGGbr
 3pTmioSKm1XEHnlvwkdDvwNGht51CYJQ9yZxt5ztRwF9p5ay3Yh7n0PVwb4E8N83nM54
 688Mrd0VwlAqzBMgsuCpDvEo6ubLzo1ekFqDb1q6ZUdec0oZf7n2Y2Q1dau623geC4NS
 nYQ2/pC3UJ7OuD4jY1L+y6fPDK0OTASrYcHzsECO3qZZhro0MBJxKNCjLJhYNJR7Uzjh
 DqAQ==
X-Gm-Message-State: APuU4Z8z86gI6kT9wrNoKG40GmjirwOI17PD5cty5EhQP4UqzKqxeZz/
 sRyrI9M2d/xk28HBaKfH1xT4IIiwfXvKTWFZYjZDxj75qPxd6VcP0N5FL/09Xl33QDOSreXRDg7
 USczVIQu7wM2EfCaDhSYNe9krUCSDOjmfs+/h6kXiGZgd2LvHYau0jbakPgkc7R8YbHXsJVr8Eu
 wE9B/7kg==
X-Gm-Gg: AYBFou3USsM3NKSj82NHk2v4uPD1KqyNeKKFePzYz+PtKDNhSo/1PMLEtbLZUaXOsLE
 wsXiyL+QBMjGE/9xGEvg/WHxJCGmS6Pscw1zuv/S4aCTQFGAOcBplbEydh8scsCN8Xdx9JawUJZ
 UqFhILIjhu28gWvPd0UUAcEjkzFrKu07GewBpweKXC5dWC7TJ4BD46U0UdenC7bWnSyF8kp6ysm
 nt1RUF8p5T3A5MUIdzu2zTfNFqICDbbQPmC3AWvWvKQPwpA1D8LnxPkmfzvOWRzFaHkAI7ZVaai
 WXnscMVfMa11BTXCk269AmUAC6GW4Eg9R+aeTCOoSQZQAIAWv+rsgszSaL8rHvEqtSykc5VJD+n
 kRB25ysPfej1N8TZ/wGHHVVccEJfsODEvZvjzDLsBXTsOlWKHt+lgXnvivLPniJRCVOzPI57A5h
 3s256Jy5rxYnRIVDBq0UEBbg==
X-Received: by 2002:a05:6a00:1bc6:b0:882:8aea:fbc with SMTP id
 d2e1a72fcca58-8a9be1a0cf8mr10090902b3a.16.1793657064261; 
 Mon, 02 Nov 2026 14:04:24 -0800 (PST)
X-Received: by 2002:a05:6a00:1bc6:b0:882:8aea:fbc with SMTP id
 d2e1a72fcca58-8a9be1a0cf8mr10090880b3a.16.1793657063749; 
 Mon, 02 Nov 2026 14:04:23 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8abab0c6c6esm2037507b3a.48.2026.11.02.14.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:21 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 02/15] drm/msm/a8xx: Export aperture helpers
Date: Mon,  2 Nov 2026 14:02:46 -0800
Message-ID: <20261102220405.30730-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
References: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TMDQ2Fla c=1 sm=1 tr=0 ts=6ae908e8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=58qa3DtRz-ucCGMA3goA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: RIvGVUZKL5FjH5blSsA6Gaz1b-flLpXo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX2FCTCj5jX9Sh
 l1Pv9tpYVq1kWbGo1q/Ovd6hlt7J0Zpx5mVQrlICDHij5ae5RTRrs+OD6nnkYWf51UW6Anh58hL
 KjF6MZYtU00/n+S6lDs0Gef6AGkhSAE=
X-Proofpoint-ORIG-GUID: RIvGVUZKL5FjH5blSsA6Gaz1b-flLpXo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfXwUli2nAHnr7e
 5xud0Zmoy2SMGWwn436iWok8bZ3UCrk2846ypY82vOsmfZx4QLB3CqBtVyjA7TLkhg7gDatGavb
 Uwvq5LLv8MpKDloZEh8kTH23eq4098rfdGBDan+iNybXflj6Wcm1NxJYh7tYPcz8/HZ9CBXrvt7
 qbrDr2zItT8PkqEh93ZGO+SKf8Z5+j+WFIE5ZrhBveefMegfb3aL9AAnlQDh08xshGR89TGn+gO
 AzFjq30mBus2h1P4vZbxUl75mcLeVcZVevCpivnwxVu5B2hwwICCvtnb+lC+YGdpE3A3/CK41Li
 5jmKLVLcnV8wJRzDYyKnNWL3NYC7u3klgeUSIbwSoUcQU9HhYPczXRmAGiM1K/+neB9lVLZoNKd
 RQCTR7R6z/eGD9EYF22wV2pFiUoXfvBGPZc7GeYnz/EUJjuhYWIuKbAEL40DKl8jmbTB73Sx2ke
 pQAHOpP7qHN91YS6CKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020087
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

We'll need these from gen8 gpu state snapshot code as well.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 3 +++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index cb0ac27dacba..46e2b921f4ff 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -349,6 +349,9 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
+void a8xx_aperture_clear(struct msm_gpu *gpu);
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
 int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data);
 void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index ecf15a8f68de..afb115c3d7eb 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -32,7 +32,7 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 	a6xx_gpu->cached_aperture = val;
 }
 
-static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -42,7 +42,7 @@ static void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, un
 	a8xx_aperture_slice_set(gpu, pipe, 0);
 }
 
-static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
+void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
@@ -50,7 +50,7 @@ static void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
 	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
 }
 
-static void a8xx_aperture_clear(struct msm_gpu *gpu)
+void a8xx_aperture_clear(struct msm_gpu *gpu)
 {
 	unsigned long flags;
 
-- 
2.56.0

