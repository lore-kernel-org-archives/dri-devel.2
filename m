Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB9760805AC
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IhXxMwHp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RoMyZTgu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07F210F073;
	Mon,  2 Nov 2026 16:10:21 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FC4E10F073
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 16:10:11 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2DpK8q2448522
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 16:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e1U31KgLCeK
 QL4tU+C92d9j1+SLTNWPkWcPEyfo81Hk=; b=IhXxMwHp5nk3o/6wKy5aRu+1kLw
 Lxo2k5dQh+5ZEm/hm9jptMBaWQZxWhqX2q2Dhnl8cOVQcz7PE6mpFG24OYGEbM52
 F56wQJJtoxaDpiusSTsUG0k7t242oOQe7Czrz8Qy3NsBU6H4BknMZ4SyxTx4UHbg
 XoVxqAF+ZdTu0YiTFo9IzuiVa9TG40qzS0S7eodbg+yl7+9Cz8qxvJuffBxLJkvq
 76vAvScJkFQORQrv4RMXHaVJgCfjYdP1k9fld86B6gfYgQ2vuFKCeWd3cl5q5kzU
 VEbHXU4IPV4MZrzFbMGL/pnaa+QdEnXMpnQ7wryt4vGE5LpM5JLP3kX3DKg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpky4jn41-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 16:10:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ea785a4decso37674505ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 08:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793635810; x=1794240610;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e1U31KgLCeKQL4tU+C92d9j1+SLTNWPkWcPEyfo81Hk=;
 b=RoMyZTguhwi/knEyzTdK6Xgo6mL/TIarxdnj39rauaeI2GFC23rWV9tm+2VvUzUcLO
 c0E+1PBqCZe1LeCbf+8AUK5UJJ6Vbv6bg6mR3DqKIevntWRYl8E5ue+La4n4xmtWNq+x
 6RNiPLQA1d6yNsqMSVB6fs1E6e+MuW3SPJh2VvbbpQ+7ltGhIDEukrITp6VRmivb11iE
 irDb+PZP0noNL8fwYVMPzt9e4HPCre0f0poAS1ePfKalIgtEc0xmkjac9zAgNcSMN/ie
 H9ZWjv47nXfmSuRSaZ2tE3Ix4dps76CdrMrGCXTayOFcrrbo2+u6LJShXPq0EMZUN+ak
 jQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635810; x=1794240610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e1U31KgLCeKQL4tU+C92d9j1+SLTNWPkWcPEyfo81Hk=;
 b=KkjGRVv5k3YE7T9qosBt/MAhG3ttmKQpkPEN1Lkx4Xf60qDGYmjRN2XdyukNEmYYyZ
 w2q8tD+aQ9zTLad3SpMlQP52b2xxJdh8ZyCeXOHzWOK7+2OFA48UZG7yYdo+lCTNJWWQ
 RRgFUy+rXRIZOCKAja1ik/vqXjbMVXmLOljnvX95j9D6i9Xgkp5J6eCnLvqY6wOt8IW8
 GmJN4w1CfpwPxXIJMzC4KZNe7ePMOjyc1xhZvjqn9MinLe4R4ogFt+bFSj+xenQN8pnb
 FaHLP2Suv2Xme8Tu/RuIH+XTytm1/T01Q4dswjr0kva+h0FpPDwqgh4GHYl6kqA9Pcyf
 WsVw==
X-Gm-Message-State: APuU4Z8XfcXRY5iR3IAnxy6wK5ByX1uygBAeI5BFItkINcr6KI/7/4i1
 CKALGWLXfXhV6YY9fY1t4oGw0HiBSXcaUXSKSyGUa1hoBtBHLusBpHs3JI1q50PxEjCwcBLu0Lc
 qLM2Oy3scwjIC3ae5TwuA1OWb4TMQeriVPQA7ch563ketuW4xXFUsvBX7riSsseYudC+glaCWMr
 TL/ysStw==
X-Gm-Gg: AYBFou0Q1M456YsPSeocT0LuJz4tWvHbbFsTbKQLPXooPN459UPm/mWl8BD5A+vktzy
 UsHv5kUD+Sqsx+ECrWNme9rwRub2ZAZSRtzufYIlRoNE2cILoPWFgfU0atIUq/u77onQrQe8yYv
 x3pe/xanwUAAXiSOIMxE7IIoOWFtz/215zVDSQEoaPWK4stp4f1KGoDRaeL4IJZH8BAgdVZnlIM
 XHhGEICABuWkt3roiX67LkAvbqZRS5D2vxjAfOeVFLYXIqJ4X+9Ox80lBG1Fuw9mI6/rlEK6Mwq
 to4TShe1ZEVzwSGMlckjtcqYOVNcGAokq/RHIkeCCoGw6xBOd2+p4jvZKozsB4fd2EFF62scmSa
 dGx/S82puSCAmIJgJwz/igAzHppU1WVH34UgGE+nDluz8aODbjlV0rTCxMUoFCmJxubJOsF2u9t
 SH9kKVt9BfFeTve03JyJrp4Ps=
X-Received: by 2002:a17:903:3885:b0:2e4:ade3:7290 with SMTP id
 d9443c01a7336-2eb1ac6fad6mr94302405ad.30.1793635809854; 
 Mon, 02 Nov 2026 08:10:09 -0800 (PST)
X-Received: by 2002:a17:903:3885:b0:2e4:ade3:7290 with SMTP id
 d9443c01a7336-2eb1ac6fad6mr94302195ad.30.1793635809241; 
 Mon, 02 Nov 2026 08:10:09 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb39247e32sm30294415ad.27.2026.11.02.08.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:10:08 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/msm/gem: Disallow nr_bos for VM_BIND contexts
Date: Mon,  2 Nov 2026 08:10:00 -0800
Message-ID: <20261102161002.497152-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102161002.497152-1-robin.clark@oss.qualcomm.com>
References: <20261102161002.497152-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4CPL2G4lrxxVJkaCSGhGSPbWk-48a5KA
X-Proofpoint-GUID: 4CPL2G4lrxxVJkaCSGhGSPbWk-48a5KA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfX0cZa9V+HaRxm
 qunTP27snTzWnVy/6nsT6wGNX4A57nmvMYz5eO3Z0wL7KxsBnQ/3WDshGYaljr3dJ58DAbMU5L5
 pq8cm4d8IhOpn3qIbB/4roTma7kesc0=
X-Authority-Analysis: v=2.4 cv=QoHLTlyd c=1 sm=1 tr=0 ts=6ae8b5e2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=5-JVGYL1QLZbPSRHqMAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NCBTYWx0ZWRfXy10dwbyZQkKa
 KlclIEIcCLF9lxaEA1uP6proGq+WsVnTuwTaRJyTwvGUd66v7/s8sdX280DLoOXND5JzH9ZVacU
 yNAoHs6oB/mbe/T5Agt761g9YKfRP83bPDFN0CJcdlDos1AuLpQsBUZAJLKr55437E5+5qsiFFK
 lo1iSoTmgJkljDdcfXQyl+ZDk5LfKB1CzxfqKh2hA4j6O0Uy8cmxJDNXNIcMdM2TMYJnAuIck74
 Xh8/gunFfNjiwTb/K+06tw9YxsUcy2p85d9ArzdqLWVeE9+CMMss0ds/NKYOlA2mMFX4SSCAeQc
 S+yNAdS2hPQk7NHJrku+T/eGt6V4Z0HF56KTHxc2cGS2MxancAQ5AWj5DJRZ4Eg3LNzNc/f6wob
 EBquKyt165Ba13UFLb2FIBVMWB0p8TBYtt9z0+xf9/wn0nO93po2iWtlQCoNWt8o1xH0JhTjWC7
 5R0L69CuA32OxDIomvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020064
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

If using VM_BIND, it is invalid to attach BOs to a GEM_SUBMIT ioctl.
Only the VM_BIND ioctl should be used for binding objects.

Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem_submit.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index ff6cf39587c9..b558d07ed2b6 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -272,7 +272,7 @@ static int submit_lock_objects_vmbind(struct msm_gem_submit *submit)
 	struct drm_exec *exec = &submit->exec;
 	int ret = 0;
 
-	drm_exec_init(&submit->exec, flags, submit->nr_bos);
+	drm_exec_init(&submit->exec, flags, 0);
 	submit->has_exec = true;
 
 	drm_exec_until_all_locked (&submit->exec) {
@@ -589,6 +589,9 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 			return -EINVAL;
 	}
 
+	if (msm_context_is_vmbind(ctx) && args->nr_bos)
+		return UERR(EINVAL, dev, "invalid nr_bos, must be zero for VM_BIND contexts");
+
 	queue = msm_submitqueue_get(ctx, args->queueid);
 	if (!queue)
 		return -ENOENT;
-- 
2.56.0

