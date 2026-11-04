Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD178606B216
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C77WedBR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aNnQiCCt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 046D110FDCA;
	Wed,  4 Nov 2026 17:59:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5075E10FDCB
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:59:43 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FjASP3208829
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 17:59:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0kJtna4wcqE
 grqLio7JSNBMwkN8kE/YoYszBIkhjqHQ=; b=C77WedBR525RLOfK76SBeQoQLYt
 RhDUArQRz36WE7CR6PRA0L5hu++WCgbceSaEA8JQ3Nm+chcxSm6W5o5q02h+msJh
 k976oYHHOYxm5ahJdee2WQyXbj6ln6CLDZK9BMy1wCS6DQ3galw/Q1eSmwOyjJMc
 RpFfo2SVuOYW67qdCS1MQnY6PaybtzxvwKblM7ZoqyzApW/NZ+iMUuDnWpJXgCAT
 eiQeZQwYwwRaqE8GyEqxfG8j8fHUKy3ds3K8j0we7ikmNC61lqvc3hwLMy/2Wfhq
 AHzmTsdX43Sr3l3CfBJCtKVtdeWK1Z5uKcpyZZb7u/apWcbzZwLu6sNdj0w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bj0wvc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 17:59:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ade5b3ae97so772570a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793815182; x=1794419982;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0kJtna4wcqEgrqLio7JSNBMwkN8kE/YoYszBIkhjqHQ=;
 b=aNnQiCCtWq8WxYgFlknzhPihrPhpmF/HlQ+m6+3p9un/bJdwGVWD1tTB87+sFNUY/m
 PJtkcyI1yyzWcbi+UiXzBTK5dxWB3vpudo2reSj6CF2MCZpL9ZmZy/3QcOTMgA7lOVQj
 +18Bn0YDSA5TINO1q1HlUH9JBnkp4SVlQZYAYc9nSdz6Xgnk9r2RsDxKI1iVJha/tq8X
 vdJXsQ6dd5XtGzIWvgBUM5sn7ELsLYzNPmxFOeEpKzdtXuzHq6TT4lbuGP7bQEYWJFOW
 DWmolCTS8TNIg4WVxzo8dKyT4rPxBo8Jy9GKSkHleX4u1tiYvRkgnGhLAyYBCkiOhjku
 PfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793815182; x=1794419982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0kJtna4wcqEgrqLio7JSNBMwkN8kE/YoYszBIkhjqHQ=;
 b=SLdEz/ohkYI85fRYTPvT8s9UnVfZnQ5unz8kX/jXEbOmEv+J1TY6R+CeozhaCD9jxr
 QPkMMmwPwQw7geR/Rw2y/hdhl6qcsMatdQ5zSCJM+TiAS0r/h297jPqDOtpJLbXuj7UB
 C562BPNV56ZB2/wnf93YSGT4GWuqwpd9ex1Vg1bxNpeD9XVIDxMqa1Ohs960OTiF7kBF
 eQaTJg0q4UQkX4Tjmdt/OS9+NRqc11RBwk4q5LqEEcLP3Er1DxEtqMQvsY4lm2eofOjk
 FxTcmVjkxL7W/xhV3JX08oadJLklmoY1d2x6WtigdKG+krlhjvu/Yfw+YHseGbnqZoXv
 qVGg==
X-Gm-Message-State: APuU4Z8HY7rj9fbWrkgFTH3BRZCHgFVu+PTk6x3+pVfnkqO51W3ARfCi
 y3gkMGFHs9Y6/HKHSWcOHfTyJa5KCrXiuC+lWfFdijgH1y59w7aYrecjqClghlqJedmAlw0787a
 awZuvQlJr+tnq2Jo85r6ycSHM7Rea0KGpkOiNUgQU8YgyuWtNdyyVLUih5noN7ZmeosRUk29jC1
 64mixxKg==
X-Gm-Gg: AYBFou3wfVd8XCjhotrq6LMlR+AIqDsj+gN+rZ7NV//RmuiI6U0NhYlsdDTxvhW3mpR
 ZYKTukP/oaxvCoWWxCBv8Vx7jVFkSEMyUhmm5hFWqOEZhucWFLrX78usLN2D7sb0/sHops5RG+G
 8FrBl9IzjNAEyT/iCak52KrxTZI8Gk+2kzaq3zHw9YYbrqVKceO1rGhVIfyOgL8GhsrbpA4t4G+
 lJnIjJj8blzURGuD+CaSoMXYBphUwV/53P4vvOPXBEVUxz+EY9T7h/vqG7I+NdvvDrR4Q55gmXf
 iiVUkiYWZClpISijhT76VfB4b+qskkpdkq0eo34Ub2axASQym1h7OaceaBgwAhbGwfwVrwBSRbg
 I0wxWieDA281biCxG9kgY1P0ygn5DWkvgDcIKA7NurIRuIaFO4WO6nhnDzmOz6Q4CCi6rju5GCE
 6gAcV+QmWO367SvUWCcPMdWjWg1Rw+1DupfCoaDHypACZ8YmpZJMWKyCc6Aw==
X-Received: by 2002:a17:90a:d884:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3b0afc2932cmr100929a91.16.1793815181981; 
 Wed, 04 Nov 2026 09:59:41 -0800 (PST)
X-Received: by 2002:a17:90a:d884:b0:3a7:96d:feaf with SMTP id
 98e67ed59e1d1-3b0afc2932cmr100917a91.16.1793815181490; 
 Wed, 04 Nov 2026 09:59:41 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b31638fdsm46607a91.8.2026.11.04.09.59.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:59:40 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 4/6] drm/msm: Add cleanup help for disabling IFPC
Date: Wed,  4 Nov 2026 09:59:24 -0800
Message-ID: <20261104175931.28475-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfXydqdm1nusr/m
 CdsCJow4+pXniRKj/5349K8SGbQi0UsuiKsq8Ait1leYnXmoXsdlM+XMTW1PrrjHfRCdQzXa81e
 0aCrdFFqbh7xOrVWtYzVkU/nUVtSG1L1KGvjkA1aNeurJ7eVByJqTI/ZrwWj1Nlmj+dekf7npcV
 WrF79+OLSB4pv3K71s02adRKhYwMln7lN5ZWCklMAsS4PWy134fYkxz7IgEr/SUs9qNF+LzA2E2
 4baVgrUT8OSiQaYgVlamPGltUzqkAVMBg2ew3oIugpqHUxhaqYFUpCGACoWe0xC14b2TQ+Z2F8H
 1cDx6McahUvcmznEQLo760GOQ30BPhiLSRfn9r/b1HfyqE11kIO/IMIDpOZPQCX3njxeLct/cQn
 fsoq1xMK1XY9dWVBMadS1qX5FRL6cWnqQpFYtRqC53j87vmWLhwZeCDgwFpJSZ++ok+f6bwHQxJ
 uWbWaQNwGxoCwRPuPqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX0k9EFDqM3nER
 O8Oz5Rp45J4QenhSLzOlxtJ+SgaWzn4kI4CC+n5oCOdijLwdNY0lW8XMt4OIxC6r8Sd1eN7Drey
 5AJBcS0GliRt76dK+On+p8nZ8tHgdjk=
X-Proofpoint-ORIG-GUID: 2wPWLQx_FFT02wuKnKazCkPLVE5D81jN
X-Proofpoint-GUID: 2wPWLQx_FFT02wuKnKazCkPLVE5D81jN
X-Authority-Analysis: v=2.4 cv=N/u8hG9B c=1 sm=1 tr=0 ts=6aeb728e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=6dFaWfunYbwioYd2EdAA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040071
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
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
index 8c2454627a8d..65d202e12bf3 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -266,7 +266,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Inhibit IFPC while accessing registers: */
-	msm_gpu_disable_ifpc_get(gpu);
+	guard(ifpc_disable)(gpu);
 
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
@@ -302,9 +302,6 @@ sample_worker(struct kthread_work *work)
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

