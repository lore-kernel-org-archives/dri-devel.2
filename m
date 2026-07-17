Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 121DBC44523
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44FB10F5FD;
	Fri, 17 Jul 2026 20:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SzgWMNtd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="amKsCPSc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD0FB10E4F1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:05 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtRLv2751810
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=L6JvWLUmlfs
 jBa14lcBw1BoSx1fLycflHxKxG02lUBQ=; b=SzgWMNtdFSoIESyCO5ht+jZrHyF
 O5sn/pAv092HvPYZWgrMVeoKHhKhpf34fXHihPIblOapjZRvlQ5/RPiO0MGqFKKt
 F3WT2T+LyS+pofMxyvDHMMawCa7bVZ4CLnl5Pf4Sdmyr1Md4R7qzHdvqymUObzI8
 b8AXf/Be9SIvGpkBmJBXfFPgLzC9NxpSct65KQ0ZWKRQvSveXSXzbu0sH1hdPwoA
 ECGQi8dQnCHo24mM53GrX7NHJWUMNuTkFX/FLwp7tjSMvMOTUHioUkNghPpPIhNj
 5AYJRGRTi2Aw6KWFO3sqYQqsCQQv8ukJv8N44PNLmD3Imww8QXhm4Ko247A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug1awu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:04 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ce7dff6253so15450635ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321344; x=1784926144;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L6JvWLUmlfsjBa14lcBw1BoSx1fLycflHxKxG02lUBQ=;
 b=amKsCPScf+H089Y0EfhZ/yeWOcvJ74OHBX9Gx8eWRykeT7cde45L3IhCJmIxAUAHTr
 0NSq5EtWsHAeTyOuzF4RC5Dumx5I5quIjgZv+hREbQLe2+p5vySyKw4NXoEFes7fBIsU
 +LPxXE3T8rZ2v41NtyxxiTK6HJb7WyQKKbS7TpNsL/MA2rCTNX7HNakK0mP5pOlNYDXB
 mnTnb20f0a15uDPKq7oS2Sz/pXgeyzSh01gn36oKLd4J1kIHgGEFfYia4SQnMG0+Dg9B
 +4dGzYM7iJnE1LR7ZvE1Wr5V7GhYe7pr5jfIDXuvE/Bwlgggm+mxJB8O/x3a9kbKG+YF
 2zRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321344; x=1784926144;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L6JvWLUmlfsjBa14lcBw1BoSx1fLycflHxKxG02lUBQ=;
 b=RasY5n5vphfkL1cxINjjAaoRikGbnoHRV9tIariXktsreE3vra6wmC8vLoLLggChWu
 f7Ds3zUlGbYdW3NpuXdYwINxAtRG6pKo5FoRJjX4t9onmxv/lg2UYa6CyCJSImaca5tB
 vT68mBtvDEUhKRWGFNguOr85ZI+fO3l0tDaUUPTKClsLQMcCaLapxLXztKxRXMFT6xFs
 M9+3UCLlwNkOg0ZBG4Z300CBwwg9PDDiGNOMtSE/H2SLGWoFtxtzjgczpkB++spMxGEV
 k6DBlIs7G+29xFo0N10hGxuva5mR+X/PDr/sdU5dTQUaZ5yjgElkiWHxgzcMw0ldyOtr
 RBmg==
X-Gm-Message-State: AOJu0YzUhtIMuPNvG0NVY5efjUwiC5INfQDu3Gt3F7Te2kY6WXl7fYJV
 JMtAqCIJ2Dl+6PX6Y6b1lgVJfmHeMjJki2L/hQ99I0vnTgkAvWciD/a1P3cwmEobaoo4CH/w1p2
 yZ1S9ty7Z9mOewdZpANoiK9oNZSlexcMroeuSyPgM7kcZC4XgNidlnhb/8hEFxWzMWMgY/aoYa6
 86aPg=
X-Gm-Gg: AfdE7ck3L/wL7coPMed9I0yaNM53PTgTw3KTQkJyCbOy6wmMGkLVOvKOv9m7pR61xBa
 sC3kKLCdfnubAq0bNEgd5/otFrq/aEdYgsLG/+ZLq1d/vQhif5IypiUGDhIEtEbxozbrbygWmbk
 kRMwACLeo3rWEajrCO0PdjGcLapIqbUyZI/L5Lqs4sxPNOkcdhdaPoyKTsW2WYnnCqTUPo7wEav
 zcfwlUoLR7LyuzRqOpkopvK+bYC28bCKObrL9tk2nqyqeJwPJ8vhh9lhnuJtSoc9uoxAzKNzJEs
 JqfVwMH6CncVchaVxUMnr8EDZHTrdRJR6iHV1v7kR1DKFHDq2QtGoQ+0aHUXqVhxAx04Xc1dJyD
 yeZNuH0e0oUuJESur/ljeTm4QE1KELJK4p06VfANa4Pp1Q4E=
X-Received: by 2002:a17:903:2ac6:b0:2ce:a6a4:451b with SMTP id
 d9443c01a7336-2cf1f2e71eamr96843025ad.11.1784321343728; 
 Fri, 17 Jul 2026 13:49:03 -0700 (PDT)
X-Received: by 2002:a17:903:2ac6:b0:2ce:a6a4:451b with SMTP id
 d9443c01a7336-2cf1f2e71eamr96842585ad.11.1784321343258; 
 Fri, 17 Jul 2026 13:49:03 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf344b1ef8sm17884615ad.21.2026.07.17.13.49.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:02 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 09/16] drm/msm/gem: Remove useless locking in GEM import
Date: Fri, 17 Jul 2026 13:48:25 -0700
Message-ID: <20260717204841.26120-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX5IyoU01NIbi/
 Iq0u9BqVty9Jvp5QYZPHcGDp9kuYFSV5i+Ko4gwN5yPP0oZlBbkeFx446dgWqotS1jcVTgqubFQ
 Zw6HEBExKrnQeJKeyIN6CAJcK9briozYczCa5y4f1xk3NXNCGsmgCX4TR0cclCwE/F6WGO1aNyE
 HReEl8RWXeX/PSgsl0EMQ+14ROZRP3/h8T7zs4TBJ/WH0v0S7Z1H+1yg3XzwYgrv2NGXKMK9eeU
 hzxBzEFkHPp1XNlR9qgQvcjHAlj3CvP99lXQ/HwERenpjXqCaHv8O/ZH50a4uRn+dPl5DrRzqnj
 QfhbptxOkkwlHTEUsc1feRucVAWCkXltYan9bn7lLKk6tF8aM1egEY3PApGnMLa1s5m/Om+Yyjf
 NJW8r0olKtQ+uATJSJkqaTBRM48IOp5VTTl0YLAzIXHnHIQtxqJZfCOuwccMHdga3QNVuKRyJa2
 y1pyntrd0El28vYgpaQ==
X-Proofpoint-GUID: S6Cj3VX-ncS9XNVYCMdOct4d3eK3D9Xd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfXwgyhMrzr6ndz
 t+kyNR6bbpQ5dobnq/K4GcLv3R3p4y7i9hlQilBRvGgqba9VvwECFrFll7qxYjnGd3kEw5EOagQ
 9Taq/czC83O2fyZAM74aSDEH/K5nJic=
X-Proofpoint-ORIG-GUID: S6Cj3VX-ncS9XNVYCMdOct4d3eK3D9Xd
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5a9540 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170214
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

The locking has changed a few times over the years, and this extra
locking was the mistake of evolution.  Harmless but useless.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index efd3d3c9a449..1aa844ce4f2c 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1301,23 +1301,18 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	npages = size / PAGE_SIZE;
 
 	msm_obj = to_msm_bo(obj);
-	msm_gem_lock(obj);
 	msm_obj->sgt = sgt;
 	msm_obj->pages = kvmalloc_objs(struct page *, npages);
 	if (!msm_obj->pages) {
-		msm_gem_unlock(obj);
 		ret = -ENOMEM;
 		goto fail;
 	}
 
 	ret = drm_prime_sg_to_page_array(sgt, msm_obj->pages, npages);
 	if (ret) {
-		msm_gem_unlock(obj);
 		goto fail;
 	}
 
-	msm_gem_unlock(obj);
-
 	drm_gem_lru_move_tail(&priv->lru.pinned, obj);
 
 	mutex_lock(&priv->obj_lock);
-- 
2.55.0

