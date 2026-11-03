Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABFA606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DCItncuV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HuvUmeJJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1156E10F93D;
	Tue,  3 Nov 2026 23:19:15 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2411910F942
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:19:04 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3LKpaO3993774
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 23:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=yKmSGK1vSwO
 yKiBV/4vQNcT9fTTMd69aRbOdB8aI+io=; b=DCItncuV69iznZs6alW4tmTSTXu
 jeKuFkKmhupsaH8qeC5j0stNhCC+tQIHiSGClsutOuOdfdrtz67gDZpoY98MhHaG
 Q0K5+lPR75o5+6u+3fzgq2+Q7T/7Rz4g7y4vFs6WiKbDpvaHRVIfeH9KXhXBDH0n
 51oT8RQX1eX9uGNRAJ0WgndjcLjB97LIWzAzKDauXUPLbY0DR+gfGMbN0I8TGasC
 9NR3033q3wFQm0PeH9t25mj/fHrN3xdiKsBET6bEV1hQ6pDO+CZ+D7NHn0x6JQZQ
 k5LSX3ROjngUls+XmZerBTVbDU8eVoEVUJHuKHzNgIY8z4jaSLmfxf69aew==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8ngvu4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:19:03 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ad30487d55so321415a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793747943; x=1794352743;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yKmSGK1vSwOyKiBV/4vQNcT9fTTMd69aRbOdB8aI+io=;
 b=HuvUmeJJ6eBuOJ2evijN/4qB5Si+bqQntGY3Wb9eBlB83fpxmiK0K4mP4xmbHan2vV
 X70qptS6ySiJqVAq9Y81qgxj8fjelFsbjcfVXwJ7jYRssiV4PrOoHjD5L1heUow3KHNk
 ZkVwISqP6iKDGTgYcxIa6XisJyDOOFeAyYgFzwdKsJ55h/cXaPicq37rtQ64BtxEvjdD
 u+OuKEhupFKsVLpV631/Xoi56SUXZjbe5go6y8GdLZ4JG3bENERxjenpgTs3e32fm5il
 e6MuwLxjYvheWifuoJiWMK8Wawks6+I7IoTUEKUKlRKJ+sjjB5TSWpP41zI1Srj3INd4
 JS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747943; x=1794352743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yKmSGK1vSwOyKiBV/4vQNcT9fTTMd69aRbOdB8aI+io=;
 b=XSW5wyhiQiZVFsVfHqIOBBesa5mNK7NFs2tfTaJV5kwWq+CmTbjS7HIe0nrmb8HAoq
 /cWU6eVBZYpHJlo1EBNzBgxLQns89TkFWt6SiVNVWh1vHFOKB6SUSp4RrcSd3k+G9adS
 PkN8+r/uIVxGOx0xj0JbKNbxG0xYFCsIwFMjW+ZzPM52AYfrjvLf/mRIZmsxaPlVACCY
 fk53mi/R9Z6t2zogFrGCQP/to1BiuS+gKPR/4UMSkVyUf2m7xxi5vVp6x5LlKkjnJFPH
 3ka+9N5Vf8XqxkFHNpzr2+TNzLSpYPJ79BQyYgde1mla6hissV6YjY3aX9nura54YoM+
 fZHg==
X-Gm-Message-State: APuU4Z8JnfPPRselq7gbKU+oUElJV5BVcjUSdZcFnBcq11MaruLqCfMg
 f0FCuzUKYNw1V3FXdIf72bCa76+K85LmHxO5X0wtzI5NrcDf4oDKEXkWvRzYoXn6eOdnATrGo9c
 Jd9quvWpaGzuXeet4UHSMfIf2+yuuuPZ5srlKRpLWTFfgWVCzlPG4f1+73wk8ftLjmoLAhuArLF
 YZ2KQ=
X-Gm-Gg: AYBFou0nQCcSM9x6N0VPAFfo3frtRDchydk+11OewX6dMiXVPyYIFiQGKNPAi81H70w
 aRUKuYhvW/y+r4wDSkR1LFR5D/gx7xdsjDx5FXCFZ2jucEeV0igP/NUXltVF3ouqjTW1x3+757w
 zpfCcsnIU1oP3bypEAV2oDRLJhOxJw7Bf5Q2ZZL7YdiJpJ1JMYYO28wovx/k6LJ0Kn1MT3cpgmL
 iBhdvutHsIw5M/SamxhaCPrx2SMqA+3TL2uh8RtSW2xpKGaVOSWadux8fgwDgF/crX+igGFlX/R
 lzMuvyV5GDHJLzLcTLDGcof5qoD7tBKqzgFCcdOXMb5oF6jqmhrzaUoG/xUvHlT9j4nPgXpyozf
 fPOaM1RsFIP64Bx0RR/j7pSdW6fXq/6YEu7yugPo5BrqkF69UuvlgcyxYL1Vfkxk7r8BSFmMvAs
 G3bszYd6IFsmdECrmSN4NSmUE5WSzmxdNgb/zjq9MDQejkoVqf/S8S3DqM/A==
X-Received: by 2002:a17:90b:5286:b0:3ad:a8bc:20cb with SMTP id
 98e67ed59e1d1-3ae8987d2d2mr12910041a91.66.1793747942839; 
 Tue, 03 Nov 2026 15:19:02 -0800 (PST)
X-Received: by 2002:a17:90b:5286:b0:3ad:a8bc:20cb with SMTP id
 98e67ed59e1d1-3ae8987d2d2mr12910024a91.66.1793747942398; 
 Tue, 03 Nov 2026 15:19:02 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b09452d89bsm501759a91.0.2026.11.03.15.19.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:19:01 -0800 (PST)
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
Subject: [PATCH v4 4/6] drm/msm: Add cleanup help for disabling IFPC
Date: Tue,  3 Nov 2026 15:18:43 -0800
Message-ID: <20261103231850.17493-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfXztau0KNfZ0xd
 Z1PDYIcI2pGT9AQQwDB+dlz26fQR9vV7WfyMDdigelJGEFMIossJdJZVWTMoqR8bLrYtTIePAUw
 FBEYlK1XUKEQJxj2CA2SyzvAtU+ksrxbDxrzGpYF05gHOSJUwj1wdmaGV0lv77XZQXFczxk5bpK
 7z06ITYsSExysq84hOYAiXj3jSnqPzr8Tbrq5myxI391uAlflmyUMcNiFUpTh5nrdPwCkL2DV6V
 vxS7oOs2QzPmsvnBMjX6yd8DU5qiFhGYa70FMxR3e5Vfyd2FxkBQ2Q73LLtxCq5j8XTpkeQoLHt
 qCiZRJZwXkOZ/9Qb/WaLmxtlL5fJKHoQPVIYSxWG0s8hVUoLDYtwzs29fLYLNPN2PgHuYTOhBM6
 +pTR0yj63vbzyStyz+Rqy/Og9kfK4pHydnemGEMpbdsp8zg9Q+E06hel6uf63C7b0CsCU7gezR6
 zV5gEUUFb/zCDRpRgkQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX67LqEI0nqArT
 cRFsCR+C67iGh96dpFmPphJT6NAR9X5W/s49jduyEgRAV+fg7tgquWq765qWIhIL8EOi/KhqwER
 zc41bnMrAtp1ikOfWZRKajaY1OkC0b4=
X-Proofpoint-GUID: FywZKmGKHO2e4ujozdp-ZS72N3pyekVB
X-Proofpoint-ORIG-GUID: FywZKmGKHO2e4ujozdp-ZS72N3pyekVB
X-Authority-Analysis: v=2.4 cv=As17T+9P c=1 sm=1 tr=0 ts=6aea6be7 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=vTD2gfctXtM-Q-VHBdUA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030092
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

