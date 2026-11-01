Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C946606A325
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TvnYnr/j;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MNeRogzX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AE310E204;
	Sun,  1 Nov 2026 17:47:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3E810E20C
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:46:57 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1HQAxY2020005
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 17:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rxoPTuCm5jn
 Mt/VDeTNC1QYpW68FPUdXFuvA3Ncyf5g=; b=TvnYnr/jScdaUcXnfFxUXJQZc+v
 Uarw1ebjlVOFEmTIn/HVkonGPRcHPLZv4m3fFrFDyHF58yHuzK96URKITSeOU6wE
 V0BWUp0sKxVocg/iu6EVGdVkPDwhuRpjFAigAouruPpvZv6KK9iBVactzumgKG3p
 y4GDeak6+QoOEH9dMV+N9S9tKmpmzQE6nvjBYoHtuqmM0J1EEDptfOAee3PywLBH
 y8sC2OAo3Yeg11Kz1iJqAnXv0f58A5WLZhtG+Hp8mZHCNdYTd3QbdNOrHtzaSxsu
 WEQbGBpWjgHthv4/1kqI07oMheIOnXlO4BOlNxFatVmhjcC9L0/qi2oK0+Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7b6kyjk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 17:46:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdb061cc4dbso1375239a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 09:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793555216; x=1794160016;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rxoPTuCm5jnMt/VDeTNC1QYpW68FPUdXFuvA3Ncyf5g=;
 b=MNeRogzXjyS4VvXgHyx0UHmIOPU/mIeynsmL5sqC1kWJzLoqQBSOtrH600UtZ56Vz8
 UmBaHwJTQ++icjFukOKz+KwNU8vxC2JxIdfmqOPbF4GEVhj7R7TL7jnu8h1Ma0UmZvsU
 bwEMobzGBdfgXbfEZg/ZiN2pqWWYBXQbAse7eld+jNNt1yxIJXIfGRkwAcRMySboQ+P8
 dtMUf8gwG63cm7Fx25ffCDuIa/7kQnmRkRL4YQtoaXqwFRVzev7ZG7Gpco2jguGuR3Z2
 d9Jt7xuBNCCi0kS/qeVVlp+bvyMMfkIz13kSIX8YBM5rHo55+KohLiZHzaOIOKc32q3N
 kZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555216; x=1794160016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rxoPTuCm5jnMt/VDeTNC1QYpW68FPUdXFuvA3Ncyf5g=;
 b=2MI3lwKTTfvepBICKR36dogv9kHefQcVPgyiephZdS5W3YGKonxHv/zOo7/WiLUCqg
 P5tql/bGxKWWuFs7rSbO/+Cb3CT4r1lruvrRmUFBNCZ3te4BPZXbTkPyw4jBMGszS3ib
 HNRTLOB0Au7qd98FChhOh6OQuiZlqf1lULs2Ct6KJJIm49vo5GBvLlrxOdGQw+CHnI56
 pCSSspQraB2j0NuB2nAJ+oSouGdVWjvqwMBscxzoLw8OCYXFZTZWi6mgUYOCqsxoWf2k
 yQv/arwmaERKuYRqnmm2hZyQbvvR37BMUWAlnIrDuqcv3OfI+CJef0JT9PTyiwdxr0Rj
 98Nw==
X-Gm-Message-State: APuU4Z9bsbmyOMZViHewguaWMjfqPcNCZSg90eLqFlmY7YhUZ1YQ2kIj
 +64TPGfqz3IBjBm825fZAmcWjDbzdVa+P57Q2lk5Q9HFMKXNEeJyvfhR8kmiM/ca0mFvlXVYRI4
 WzgZYj3+OpFikLmW+mquBb4LPiITc8UVkKJLkGhRxpvwXsaBqsysISBBY9cfHCG7MS4uHY7ZiSE
 d0ct9BgA==
X-Gm-Gg: AYBFou2A2RL9oboLIF5rrr1S094zgS7/+XQkLISfVH+12ELQ+wsq0nM9YlU3n1dOJeA
 +ouUrHpYlI9YSgi4B6FpMXeyfIPPB1k2XehmYlQnllUc9WAtF7YEbhXQNVYTocjHUOtxbqErYMf
 drJiKO7S9a+bRJUYupksyWIr3h9uxb+P9rBl6Gk7g+LfL5yls+guSbrVgqCQHTq04DXQZ0ZEBPW
 R1bCPMLaQ9+VQSV7Hs9H7p6nEgC/cVBkn2ubBcnfmlk7MbRN0Hik+yhuidC9lMXFaEdSdE8zIq2
 GSE8X6KCFS4BCji49eqLfqCBizbyQRG5g1Nir47hTKtxv7976pT+Io4URWkrUFh9VuiEfSiNxcG
 C4/AXUDAvWjDLVy7xZVVGI08U3WG+QiYpUhlBNi5XR4xIdz3oZ1+WL6lsyJCJHwI1UOkJq2XwqM
 z8ihhqTJ5KvX035k7A8jN+9A==
X-Received: by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265 with SMTP id
 98e67ed59e1d1-3ae897585bamr4535985a91.26.1793555215825; 
 Sun, 01 Nov 2026 09:46:55 -0800 (PST)
X-Received: by 2002:a17:90b:4ad0:b0:3ae:3e9b:5265 with SMTP id
 98e67ed59e1d1-3ae897585bamr4535959a91.26.1793555215136; 
 Sun, 01 Nov 2026 09:46:55 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85cb91e5sm6133348a91.0.2026.11.01.09.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:46:54 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] drm/msm: Add cleanup help for disabling IFPC
Date: Sun,  1 Nov 2026 09:46:26 -0800
Message-ID: <20261101174631.23637-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 43lDzVyJIZpOxb2XG4_B5Y3kyQ2Fvl5S
X-Authority-Analysis: v=2.4 cv=QuvLTlyd c=1 sm=1 tr=0 ts=6ae77b10 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=vTD2gfctXtM-Q-VHBdUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: 43lDzVyJIZpOxb2XG4_B5Y3kyQ2Fvl5S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX50sosGH/6LV9
 ioUJzK3W5eyMN6ZwimoaGYJbWsWFuK3yzbD6zRTjzOKs1mqr5wxlwmFqfEA7cKjHAVNhCB9FLFv
 P8DGxnYb7W2Kg9eHe8zH7TRn2b6QEeE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfXy84ATBQpbVoP
 eV0GZMCunm1l1cufUBdkELFKmrVKquIKWhTMKPKUtA0WqxZCsHBMEBnhQVzzMOEb4UkLCHLFu67
 SvvhgY8MfXGdZ0GzMb2rdwpgJghmfDPguG9GzVm8Nm9/sisEEoFU9ZTySpcjhQ6Pm3HI9yiTqI1
 aol931E6LN1jPD7845KNM+40jeUXcg5jsJO6QoAuQjJjCMbhovOlEKVXWZfZux2WtzaaoTybCGU
 dpVBHA8nJZyaA7P8xR2dTDewADc+/uMoHWcwxlFNCrN3crPuYLDieTECxhpzwrxaCpPxpCQV9xP
 CgcBzzlvFUSyQ53z0DZGvK5LWreWs4qNnYjkD1JlY//+4DJr8AytFTzvTnep6klBOOqfMuqM5Mb
 IeNMN0aFqGl5WXgN7zXY8APpuHEwvAZDmY10zzxu2lq1AXRmI6EPf/sX+sRjWW4ItwnGCMPboZB
 mJKCP7cdSYoNGXyGBwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010070
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

Simplify error path cleanup for IFPC-disable critical sections.

Note that this moves where we re-enable IFPC until after the
wake_up_all(), but that is harmless.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu.h      | 4 ++++
 drivers/gpu/drm/msm/msm_perfcntr.c | 5 +----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 0334a0f604ac..e7912d2180a5 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -399,6 +399,10 @@ msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
 		gpu->funcs->ifpc_update(gpu);
 }
 
+DEFINE_GUARD(ifpc_disable, struct msm_gpu *,
+	     msm_gpu_disable_ifpc_get(_T),
+	     msm_gpu_disable_ifpc_put(_T))
+
 /*
  * The number of priority levels provided by drm gpu scheduler.  The
  * DRM_SCHED_PRIORITY_KERNEL priority level is treated specially in some
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index 867dd476ed88..995857273aca 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -259,7 +259,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Inhibit IFPC while accessing registers: */
-	msm_gpu_disable_ifpc_get(gpu);
+	guard(ifpc_disable)(gpu);
 
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
@@ -295,9 +295,6 @@ sample_worker(struct kthread_work *work)
 		}
 	}
 
-	/* Re-enable IFPC: */
-	msm_gpu_disable_ifpc_put(gpu);
-
 	smp_store_release(&stream->fifo.head, head);
 	wake_up_all(&stream->poll_wq);
 }
-- 
2.56.0

