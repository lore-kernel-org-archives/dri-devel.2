Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47008C624DA
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 18:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C9210F737;
	Thu,  3 Sep 2026 18:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iLWz09xl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MtiDXYvp";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72A6A10F736
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 18:37:34 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G3Gkm417619
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 18:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3o6Eb4jJTSo
 LrrYSQ6/wTkfaq0oEFAS72SV9H1raKQo=; b=iLWz09xlxIkF+wp8KxDFiA0gqlq
 vBTYohrPJNGHAzlV0eciRMMxKsyDbaz8ZIRZ/G0qXWTkjVC5ZRYtOeKesfb2D2HS
 GDR31g9DpSU4u229oqSKrN9BK5UhoYHyuKDmTpOHEsGHdqggUXWd6B9hkHxEzfOQ
 y5QIYqJpJq8FJKdSqdi0/hHoFxyfqEKLsvAtSTm9RWq7WEez/IAsds4bINt3luU2
 1UN9YnJDx838vW9yc68hGaIwHR/jAI6gXaJRRWAtE/L/aMrCIGSjuioJN7tjlfdH
 Ze9+tBFtwJ0FThxdjU++kPHB2HnrC3AZ3x5wdy4K2anw2I4YSfusnQ157YA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf51m2ug1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 18:37:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38f57e31b6eso115530a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 11:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788460653; x=1789065453;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3o6Eb4jJTSoLrrYSQ6/wTkfaq0oEFAS72SV9H1raKQo=;
 b=MtiDXYvp9yVzJoNT/TViJAib3uJxTpjOpjPdqgXiH1MjqkgJbVk4tn5Npjc9gs8gOW
 NYK3Aos2RDNRbrtSJHO9jyo47wgPcpdYY7+LylIc+SlcvK/+R6c6Y8Klrl/ZNJhADwiU
 uQlwLXKunxmzsjoh+YiQR+GYIlxztC0xpgwB+YCeHWlrO9V7Gh7qmRyUIWeSs1LppKCx
 F+OZdhKGRDINRxdX5IFamJBfuLfSuBNu+1TbppXbIGwUwOF/c4Lr9/Qn3UXuhu5CBT9y
 QD31So5RU0u8IU7B53xph2n4JCIF58aQcCGJMPvrFiHf2ePB1nOnNVZztTQ8H1vLzNVT
 9mQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788460653; x=1789065453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3o6Eb4jJTSoLrrYSQ6/wTkfaq0oEFAS72SV9H1raKQo=;
 b=f+TMtcWMXDp+hNH9t8HEiKPjXNtLaWeoGrhW8GieVI/23hYW5b2912vpd1y0MujwIh
 o1RBZCr2ljlNa5enDcmU9YVldbbxf0yAxvk1mU+barK+LZy8KgIhzMZ9JUfbEW7AblSu
 Ot0H1oDhuMO9zTpH0FEXDeIx+DkraOlB4sJe3V5UMACoxNxaTtMG6LAeEwkpVG8iH7ez
 WiHzx+RRvVwlwiJ2dyJmLOcGBn3mWhjB5n6RcJUbXvaY6xf9qkpDfGiJXTpKe1j8OUuw
 WdLA+cHaT4D+LdJBgER6jm/FJZCfOUxBFloO+00my1vLXz95aW3GYGIi4M0OgqErdLat
 UZEA==
X-Gm-Message-State: AFuF++n/Rc3rzOOktnv+g8R+5WaYfkUyNeORnpVYX70d1xm5PvP/lLJP
 Vg6VWW8nlVEFaqRXoy3a8mus6dBNq3cFO0xS9vZaxBJML2ekOa5HIw8b2/Gm+NS6u35vmGYPI+i
 mKSsXStY1o7w9ZsXxXD1Q6zNgCi+OybezBUkPTqaFI3BEIloMkYGiEDNuEMt1QvnwjZ1xMR/4cA
 LiFDw=
X-Gm-Gg: AYBFou364wvh1vvfxQe/8GFJEaCAvdf4VE6vMTB7LpCscqrD3PbK1IRZPX3xhYaUWjR
 6oOQjGgMFjYdKXhXwicWsjeX8K8gh9rX4R/uo6lY1H06eu7rRoE/90tqj0JIJeDkdjUkmAhiVad
 aJ78TwgqmunEIdPkR8vwx7NqZPiUB1znRWm3IJ6Reqv+A8244yZyFdGga+6IXjKCl2Q9wr7Pgji
 b6ycgpqchuGw9jNK+iWhZPngIAJCgw304lkvxl/LR/0Pkw65ZX3F88MVCfY2SQDCKaPspnJ3oGa
 ijkNYe/rY95QeNhFP9W7UpYe4yhVD2ylD1BLS3UDY8mo8Zw3Rl93ooBYNxigSaJPJZ5i6n4OLkJ
 yYxzgpj9sAXQNYKY5NoQzN8X/qj8LIyyLGyB8vdlcNMG0hBc=
X-Received: by 2002:a17:90a:fc47:b0:398:9c0c:7c72 with SMTP id
 98e67ed59e1d1-39b2627fe24mr634158a91.25.1788460653229; 
 Thu, 03 Sep 2026 11:37:33 -0700 (PDT)
X-Received: by 2002:a17:90a:fc47:b0:398:9c0c:7c72 with SMTP id
 98e67ed59e1d1-39b2627fe24mr634088a91.25.1788460652734; 
 Thu, 03 Sep 2026 11:37:32 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08ca63b3sm6620095a91.11.2026.09.03.11.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 11:37:32 -0700 (PDT)
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
Subject: [PATCH 2/2] drm/msm/gem: Add modparam to disable shrinker blocking
Date: Thu,  3 Sep 2026 11:37:25 -0700
Message-ID: <20260903183725.15835-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260903183725.15835-1-robin.clark@oss.qualcomm.com>
References: <20260903183725.15835-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: RobTrNO6hcG4dYooC21ytjYgBBZ_OrVT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE2MyBTYWx0ZWRfX/QhvCmV9WpXM
 eXZaHRDh33ywU00YVmHW2f3NiCd36i+e06dfaCwkzNvXmzimzxyQf56HTog2AG3eje1lT6Opp+B
 g1QC32pCII6QQS2ePZBTnqB7GDw9oI9Q1wrWLNb0CkWkBSBNrMqND1/5VFo6BEnzDk4FOg1pzOX
 h0UFQP03Oedn8HkFpPt3slNOa9zzzgzK2zbFmB1OxObODO++FJE5TVYeK8BqsWiXB+Taq9Ozp1P
 dgUQxAOAq/sfp17nGxgs4xozud8CLTaatS0M7m+WfU+0CZeSwAXwS8ZbDNE1oHImlbDkpY0eDXE
 odcyBR9r9S0+rQ6Gx3Qo7XtCbeT04tuAwc5CsN1xhCXKYuIPByTXIAczkMgqWdDwuaJKJjUTe/K
 F6Ap9x3G3qXO2LnUmSOG3nLTOyg9SMRJnamwYfSPSQ1hy7hogVDCzzuYVW/jIWx6bymFSNifqI+
 x4fG/aQN3KDhI2mRxew==
X-Authority-Analysis: v=2.4 cv=X8Ji7mTe c=1 sm=1 tr=0 ts=6a99be6d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=RQ8Jhd0wILkaI2gFI60A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE2MyBTYWx0ZWRfXyLS2CQfEkwdL
 vllclKXolJz+E4f7mM2lLeAE5m4eM7x9pyU6RiqIEgXLPUwC1oR8b2fBdRzeArCKm0gSG3aL078
 Pr2a6Ydw07k9013/ECYuXbE7EWyZjUk=
X-Proofpoint-ORIG-GUID: RobTrNO6hcG4dYooC21ytjYgBBZ_OrVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030163
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

Normally if we are under enough memory pressure, the shrinker will
eventually start waiting for BOs to become idle.  In some very latency
sensitive use-cases this is undesirable.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_shrinker.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 3514d5c84989..83ee032cb21d 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -19,6 +19,10 @@ static bool enable_eviction = true;
 MODULE_PARM_DESC(enable_eviction, "Enable swappable GEM buffers");
 module_param(enable_eviction, bool, 0600);
 
+static bool eviction_can_block = true;
+MODULE_PARM_DESC(eviction_can_block, "Enable blocking for GEM buffer to become idle for eviction");
+module_param(eviction_can_block, bool, 0600);
+
 static bool can_swap(void)
 {
 	return enable_eviction && get_nr_swap_pages() > 0;
@@ -26,6 +30,8 @@ static bool can_swap(void)
 
 static bool can_block(struct shrink_control *sc)
 {
+	if (!eviction_can_block)
+		return false;
 	return (sc->gfp_mask & __GFP_DIRECT_RECLAIM) ||
 	       (current_is_kswapd() && (sc->gfp_mask & __GFP_KSWAPD_RECLAIM));
 }
-- 
2.55.0

