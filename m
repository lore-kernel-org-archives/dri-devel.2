Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A87606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cz+enp+8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BQ0T2gIJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A3210E6AB;
	Tue,  3 Nov 2026 18:47:55 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB2310E6AB
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 18:47:43 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IZ2Un3318831
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 18:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yKmSGK1vSwO
 yKiBV/4vQNcT9fTTMd69aRbOdB8aI+io=; b=cz+enp+8NeRPsyQqCo+pZ2rWniP
 Hj6irvUsKPfl2Hxi+Vz5RjIMKmT1zRtWOQQ5PjYlmPy59Ok4QXw4w3NSkeuam0VZ
 cbgNScVhkjb4TAlA56zbdeN5eYhTxeTQmiA6gIAtqGF4HowtyvtBPfY9tgd1AyTU
 XKV/7kUIcrUoOiOr0rKMUW/NULIBchuAbDLJDUq9mP5R6QmxTq3lpmBSXtR4l2g7
 EVBUXNceI1/qjSq0ST05zoFXJ4iUjG1UU7xWucVWwbS5GErewOPTZ1sjdIr2hMnS
 ijfE+zVdzCHtiJyJDBggUbgEHFD42aOF+utv0vCK1/eHe3MsBiNLsmwrsbw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bhapg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 18:47:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso6133057a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 10:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793731662; x=1794336462;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKmSGK1vSwOyKiBV/4vQNcT9fTTMd69aRbOdB8aI+io=;
 b=BQ0T2gIJEoBkIxCBM4iImVgRmJ5mfxQo6YxuVBJjeDgCkkFQsufIsk0GbwvFzcxkiw
 NK4l9QGwkqPbNEYfbKjzL+PvK0Dl1jOAXxPgE+d0Mz25gZAAZG3sICmUtDfuMrY71hc/
 MexMg0n9nrmqWe0WazSKSkYBBIiGyk++e+MwQClqA0PTlDuLlTAozo2ryenqnzthx+eX
 EyqiUItXRX8CoHVWKyBjHFZvMVvk7Fz3nTP8kOD/YgP16prZJCLxmZRuM3NwYJXyiPwG
 uZbYm1ASLOigKfP50U2NPqy1ZRnPJ0KMQ3WcrQOOXbd7RYCo7ODQlEhy18tIRLFy0Kbx
 6RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731662; x=1794336462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yKmSGK1vSwOyKiBV/4vQNcT9fTTMd69aRbOdB8aI+io=;
 b=pHKF97Kt7P/mtKKvDLuZ3O14k5SwlHBjbRk/OGCYype++Jjs12bwobQlrIKkBeGtQA
 yRL1RBX23bhUF9BgHRPxwQQFKJuE8IhcWpIg1Pb+9swVb2xjd4ihs77YYE2MC7bltVoL
 o5oVmBrcp4Xx1JuOe8YlDrquGHi+AL6zKdELBSlik6z7hzW13hRbbBuIO02vNES0Uc5X
 g/rUJlohHUJ0vanXcQv54bGWOzU2KVQfzlsLpT0NjsQhX6EcR3PJJOJn8LZKSkVM+Tdd
 HTjWkdWJ7IAOkCBDZJkT5yw2jjj40Ks+qDnq2w0G7a0l/ZOLPfCmPAVlGJcXb/E3eon0
 oQlQ==
X-Gm-Message-State: APuU4Z9w4l+Zm8Rr+HwYI8Ljzxg32YQ+Y8ClcJETvasw74dKpxrbAzSi
 LHSUmhsHQZYN9FrI/fvf77wrcAkAQsu/ZXsD8Clkz84/8MeSEETZh2DopJSXjsgl9QJ4GP6t4zy
 Tf+nyVk/QFmfZtRfZJPyF1IoLulOZBhsQZh4bu9mvvdK/WQyCNl9NSl9cWLXJGDPgun1MoA0BV5
 zZW1JOdw==
X-Gm-Gg: AYBFou2Brq2Y2yhqQgs8cdziDsGs7AITGUVzQGH625OWs6F+s9DUTBEXf/S+8PMphFe
 mwffrjZlM6WBevsrNubTeeYK+NkAW2R9Y0uclJwFpb/1m3aVwni0CD/h7E2a0y3VCfwHicT3Qgg
 a5lF68J7GGsZjh7AFpMZDI/7n/2ZmGrInXKeua4aYVBAU4Xb+tgeRu4qE8UgZxmgpxoyHVDmt3m
 EdfMmuI/z0I63b6DKkRILpxP7H073pYhSu15+VcyxaqT8EOf3aWM9UTHipi9wg1ZhxY76JW/1Gt
 LfkoOAm/FsSnMDAfmtW/h0PNl6ezqwG7o4XyvdF/iEcIx5du+VgnpKZfD9PICU54Egn3nol6w++
 +q/J0Fp0s1xF2gcQj7OJpNmtJY+M6qqnfvfWXG7RqFCENM7m7QK7XorMYPAo5rAySHMZAU68sO0
 oRPai3qa/zsyxqHZwwXjTNn4gyw4Pxe/6XWKnQfeEA7PbhpuaeADg4On4IwQ==
X-Received: by 2002:a17:90b:4f87:b0:3ae:5572:c4e2 with SMTP id
 98e67ed59e1d1-3ae897e5685mr11081766a91.57.1793731661787; 
 Tue, 03 Nov 2026 10:47:41 -0800 (PST)
X-Received: by 2002:a17:90b:4f87:b0:3ae:5572:c4e2 with SMTP id
 98e67ed59e1d1-3ae897e5685mr11081752a91.57.1793731661350; 
 Tue, 03 Nov 2026 10:47:41 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c7e087csm5545438a91.4.2026.11.03.10.47.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:47:40 -0800 (PST)
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
Subject: [PATCH v3 2/4] drm/msm: Add cleanup help for disabling IFPC
Date: Tue,  3 Nov 2026 10:47:08 -0800
Message-ID: <20261103184713.29664-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
References: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfXzl4K6g8o6Eh4
 b1dF4NU0x33BBXWQ+jZtVkUV9Fgv1KZoZBEBVt5suIg9/lrbhbIDoT3wNl1+iDw9I55sz/wcMTx
 iqb4IOeOWRdxdDM3VqIARGJ3co+OKgE=
X-Authority-Analysis: v=2.4 cv=Xs1vqlF9 c=1 sm=1 tr=0 ts=6aea2c4e cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=vTD2gfctXtM-Q-VHBdUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: JONBBCusUNw15yeul142FSxRvue8MkBh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX2xMz1BYWXFk1
 Qf9qLla/hDgp/pBg5q+IhXBWx1UvtqyeAAQNn37C93o2uGee7S/nR7xheE8AwwSlFNq9c3+qzhV
 5P0kQHFxbtKQvGm+L5kqiDhrh8e68vYb4Bc1FlQb6PBGoO4IH6U+MBmtBAc4fP7hYxPtOunouXp
 P76tt0TocG7NG+UXNMnFZ807WTd7OmdIBr9geUjNxVItUSKaY43BmaCYyzZpy8sYFe+XIoDPKHA
 ws7aOnKN7FwuWwtyIi805XltA8qfaQMsRKSKX0Z/pqibOFJ5x3c7z5JA7I750O2xEke4KpK+UUy
 3K1vCTwsx+3NFDLG7V8+96Wd1TZjLaOVqQO487WWfeTzutSIGQofTSY9D+l61ZZDp1fosPQHbKe
 1cN+wbXNE8+LIjvnIBVaJztyGNnayCbKhjHEf1QrWuK3k+05V04TjRf+/zpH60jppvmos7T2FBw
 53Ntuz3hKCxLSCwd25A==
X-Proofpoint-GUID: JONBBCusUNw15yeul142FSxRvue8MkBh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030074
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

