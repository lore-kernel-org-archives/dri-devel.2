Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71726606A339
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FamBoo+Q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FHq7FH4b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68D310E75F;
	Fri, 23 Oct 2026 23:20:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2293610E723
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:15 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvWeh3983729
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=; b=FamBoo+QM+jouzaf
 QwgZSjQ2o5IuyE/1WgfvZUAaVQEG4q6CaGv915YJiG6Uj4fKosiQKuwXdgvlFKhZ
 1um4dp2HPn05C95mOz4ShaiTAEHGlD0cfB8gXoeTxvKSt0Y2fPuAOoePiYbcZogz
 HWwBAvXfYZEk8Ws9+keFaSFqkpExANIJeNJQz0JIEMCIumjVOoJN2HlOf8NTirAH
 hrGsWU15Vsnv6mMJ6CcpYfniYUu7rw5mrkuNOpBYTs3UYMvnUWN0qi+ipE+gxLxg
 RkGyGSKN6kQIewBWcxiTskjSH6XIvOpZp1TjaqsxNv5RUM03M0LkAH7PLcNt58HJ
 XOrXBA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgart1cxg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so86635085a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797613; x=1793402413;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=;
 b=FHq7FH4byjWpn6ja3H9nY73poGt73xZmCw2dNnhq8iVQyt9IEOnldbLwLv1RRNnBDn
 LwB+9ifFWbvsVlKLJ0qGVhQYaPpP7LJ49bSr4tlOL34bIwwxjuxI+P0+S1siox09Po/g
 TqmwC5iZbJ4tjHmgurBzAb5AR4BsNN1inWhEnXVfxit/HXSuC55HbdyPnpddLVCz8Cw3
 xpYOCoT0fY+CvuQjNAWxqjHmlkPerqC2BNfLO7eVWmIFPUKBi4xQniiYeYlx7jadbJE+
 1W2O80nrLCPjGqH8z0Qlqls+ins4ZBN3GpqvVEuGh5aQqkRtRJtJpQRCtyQvdPMbEZpf
 ZM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797613; x=1793402413;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=;
 b=NNegjUZyg+PTdkgG+IICFTHh8NWXNsYH+xOom1zLhwLUkkqT1uKtnPc0RflhmVPRwy
 Lc65KvFgleGa7RlVm68/6cyjTmkNeNH9mMsFkkMKZi36AvnF8wfbnJo0X6shhq/mMmKQ
 wJB+GzEr+YdFPcWjTzpeTvmNuyWYV4nbdlNeoPOhqewJkqNnoyI7cXtgsDyTHa7ACOfK
 wKPtYYsrqt8G77eHds/fWQuG9cf4b4+Nvre3f6GyJuJikLSHz7aSyEexd71Wuy3NdGw2
 ocpGHAbUHTL9XPbaSJyBcoZdP6aTkdYvbt7sSZL7nSzQ2mp/H/LDaDe3TnI/4llOs9+b
 HKHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLQeQkGi+Nwc+XaCaAJ++gP/sVf2jjr2o35D2T5aLYvFHsLKeh7qXRp4GJNdROqN2UqNqpvCQ5vVk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKFYsjtUSH63DjK6M0Px4jdYB/lY2d5toHPHw6vsoVFY9QkUxR/
 EFmRgtm2d7XACE4Bxnb7bTkMXX/OoOMTmZ+sChQfMvQWNLLmwdrzVTv3OeMZut3SxLootEORCSg
 z9SjHU7z+YRSKY5y6JF6PpArmcqY6sQzXoqvJJRuOVqbJVNd7ZuiLCJdCu83JolR7ibx/IKY=
X-Gm-Gg: AYBFou337ax2iEGA8kEAiFecvRckJ/9J/GlG2VXDkXSSoCcH6dzlRiel6dhporPj45b
 ER9Bw/gwbcUd9KmTfN2nSqqDR3De/+W3SPvmdLEWJoW25fjhOWPvSxoQPGgHnuoaW4I9tfxjd4j
 vuoawpgVpH7S5uk9/LNLlTE2k2VtRNtIPnINCJbuOFPiacC9p53wGhLAMaX7RpPKIKWQBWKMeYb
 uqyQ9TSHtpejIGdXP/sNgQkPd3NN97RM8d0p+MRp9ZI+4uohYKMvGfujdHotvFzlefKvgbea5V+
 T5/zrZrc6cCvM8cva5f8F+R0jK3lb2skz9/BT/RhFH9PAdxC7JjFH5BMtA1YbO0soKXV+di4t1N
 lNaPyD98mHOnw20deyBj3kvyZ1ezrcdcqQl/iClPsTeLay09wdOnFO/ijQPMZ5CdHZZTuGv3w5a
 EIPGVQvka4L8ao
X-Received: by 2002:a05:620a:3726:b0:93c:c96c:a592 with SMTP id
 af79cd13be357-940ef8dab65mr88815285a.36.1792797613274; 
 Fri, 23 Oct 2026 16:20:13 -0700 (PDT)
X-Received: by 2002:a05:620a:3726:b0:93c:c96c:a592 with SMTP id
 af79cd13be357-940ef8dab65mr88810585a.36.1792797612759; 
 Fri, 23 Oct 2026 16:20:12 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:38 +0300
Subject: [PATCH v3 05/14] drm/msm: clean up after a failed msm_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-5-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2787;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=AzyBqQgyuR3fL1mDrTwzGfxEu1JDwGk4Yz8+Ubw/F28=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uR8rE8nzwcjZUwaBr5DwKR7NVyeqjeMLsVv
 Vqq0nv5XhSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrkQAKCRCLPIo+Aiko
 1Wu2B/4j2CjyFmT70LGToRdiCNpx/ClnA9Igr/DVSD0jfugSNU065df4A0XXYoY6xXdor441vHh
 YywVurXkdyJud37x1YLSEFwkBSbZyW/IGm46osx6lJmIS15t9RAC0647u4+VaX7GOjsmZR36Job
 Cb91a+mIqjwx0VBeuOEzDukqX30kMcqP79CZIMdCFbSTF0je4cIsXIRIrtJ2fKwSheBmhoZLQqo
 Myaqlq+BqizUmy3L2L/6s4lWIOuEP+2fVKltnWTPRPgre7zyk9k67UYhmz6RSe6pm3iitOfaDTT
 S1XhZZ9uyzUCAI8PP3K3lGZI7Bmgy0vo6K8RrO53EvaiyOCb
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX5szAAzUcjsza
 uRzqTwjORYGoddNom+WEBNhkS1YGvBtQAMVKrYxaQcTU74WCLspvWj3fF4yqoSWXfPUGodV2BaM
 QAR7pBBB1NCUr0abXFhxtfoQvx4B1b7WHFob74aeX4H8xn2e5GUXX+Apn8ca8M152XGPtSnxdM9
 z1p/2ecrPKZc6xpcMEHdPWRxEkxx01jJUsCHRLgGU9CVeJQ2SDrVBqRMBWoQSExYaqWBAFiz9a+
 L1ropca2fM017R1bNFS4dRQfL25LVEq0Hjd7KxrTXz0TEtWzuN8uhkcVEuBjbtDItLQn6p/jGT5
 KO8rti1BzG9bDJywisGkJ0c4CE7yIi//wSuvXtoRw1ObrKwPc7FOhAhNRtKQzMMtEaQDgUfOWC+
 AetutoxIS/uHWWmcKbJ67ma9tCkAE3aLJucOKCurnTeeWgAtD14gfVBLf/sYgd7xN8mMSi8Paro
 4iw0PAD0SUi4DInDmog==
X-Authority-Analysis: v=2.4 cv=JI+uIMKb c=1 sm=1 tr=0 ts=6adbebad cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=MHPtEXvVaziToaNGM0QA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXyEmpfvJQK6Sq
 XWU6SwiQyCq9Nlz6YHP7RXQ0p7za2XUPoLTDz16SuArvlNTTqjiFqHklrIRmB4NCybmIKXMRn4o
 +zkNtp7ZKJMC89mpZNyhkhvut/VVoq4=
X-Proofpoint-ORIG-GUID: 92CJTC0j0Pbm0s-5IO51RIibCJsked9G
X-Proofpoint-GUID: 92CJTC0j0Pbm0s-5IO51RIibCJsked9G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230092
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

msm_kms_init() returns early when it fails to allocate its workqueue or
to create one of the pending timer workers, leaving behind whatever it
has already set up. The kms drivers' ->destroy() callbacks still run in
that case and reach msm_kms_destroy(), which passes a workqueue that was
never allocated straight to destroy_workqueue().

Tear down the timers and the workqueue created so far when
msm_kms_init() fails. Until every kms driver has stopped relying on
->destroy() to clean up a failed init, let msm_kms_destroy() skip what
has already been destroyed.

Fixes: a409b78fcdf7 ("drm/msm: move wq handling to KMS code")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_atomic.c |  1 +
 drivers/gpu/drm/msm/msm_kms.h    | 20 +++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index a8babf1dbe0d..c26b0c7acdfa 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -134,6 +134,7 @@ void msm_atomic_destroy_pending_timer(struct msm_pending_timer *timer)
 {
 	if (timer->worker)
 		kthread_destroy_worker(timer->worker);
+	timer->worker = NULL;
 }
 
 static bool can_do_async(struct drm_atomic_commit *state,
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index f25b31e502d2..ee98393b9855 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -175,7 +175,8 @@ struct msm_kms {
 static inline int msm_kms_init(struct msm_kms *kms,
 		const struct msm_kms_funcs *funcs)
 {
-	unsigned i, ret;
+	unsigned int i;
+	int ret;
 
 	for (i = 0; i < ARRAY_SIZE(kms->commit_lock); i++)
 		mutex_init(&kms->commit_lock[i]);
@@ -188,12 +189,19 @@ static inline int msm_kms_init(struct msm_kms *kms,
 
 	for (i = 0; i < ARRAY_SIZE(kms->pending_timers); i++) {
 		ret = msm_atomic_init_pending_timer(&kms->pending_timers[i], kms, i);
-		if (ret) {
-			return ret;
-		}
+		if (ret)
+			goto err_destroy_timers;
 	}
 
 	return 0;
+
+err_destroy_timers:
+	while (i--)
+		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
+	destroy_workqueue(kms->wq);
+	kms->wq = NULL;
+
+	return ret;
 }
 
 static inline void msm_kms_destroy(struct msm_kms *kms)
@@ -203,7 +211,9 @@ static inline void msm_kms_destroy(struct msm_kms *kms)
 	for (i = 0; i < ARRAY_SIZE(kms->pending_timers); i++)
 		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
 
-	destroy_workqueue(kms->wq);
+	/* the kms drivers' ->destroy() also runs after a failed init */
+	if (kms->wq)
+		destroy_workqueue(kms->wq);
 }
 
 #define for_each_crtc_mask(dev, crtc, crtc_mask) \

-- 
2.47.3

