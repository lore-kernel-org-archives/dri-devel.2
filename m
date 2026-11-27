Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A883606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=diX0+uu9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SlvIjuZv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E6F7112962;
	Fri, 27 Nov 2026 19:45:27 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 940CC112A17
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:02 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJRCEi2668737
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vwHK2NwzJ1u3eOofNhjZ4qX/4NLFqQ4ZjqBKdqGu4XQ=; b=diX0+uu9fRpKMXzT
 2vLJ9MZrXIDr0iLqDb+gsJDZ5Y3XwqCl5tcJFAbZgkZ+ex5tx5c+zoTQNTkoqVmr
 0VkNX11TFqygWHT14kIsJ72XVLfwqSLJWpLGfkiW5OSSt8zr04lAbV2NPwHQETXa
 y8VklIAGI31pnoxcx1e6JReeCCDD1FGDFqnlAoEKQtnY4PDDJhhHwx5kiGdlk872
 hApluVY8fHRbA907fWywgO6ziwzl7m0WZ+2NTfb25+GSbE+Xrr8Qa3pfIFunIkaQ
 Az/ieJ9IbQRFin7VmL5QExfRpSoVqItm5/i9ULD+s2o8bWtslWibOTGxyXdL+gwV
 YG3x6g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1jg1bv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:01 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-947a607ec40so841771185a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808701; x=1796413501;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vwHK2NwzJ1u3eOofNhjZ4qX/4NLFqQ4ZjqBKdqGu4XQ=;
 b=SlvIjuZvRl8No3QVn1eA0m21YyNsplPBUnFMV1Y8h2MV06hu0Kuad5nSnZcM98tWyE
 JBmnVt9Kd2r/JBC8IjFEt261V3aijleeBm2x6K0clfODPFfdhzg2q7VvOJ+UASZQiNZA
 4C577zfCM67yApgfVCbITTqu6O+Lkv/FYnZdBz1O9OVyUX0NnlKedsUNbqo+mQTdy5Xf
 x5Yhkah5NCCmShxOC2uwGOtpwypjxbk2pFCgd7Yefw+BBu36GTZAYPymUOBWvfwetQ1+
 DSe4JN/2LgFQP+GX9juvN6X9O7ABmL7bOFMDu9H/CARizc1+SfGt87y4Dlo3AJ485FKl
 WtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808701; x=1796413501;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vwHK2NwzJ1u3eOofNhjZ4qX/4NLFqQ4ZjqBKdqGu4XQ=;
 b=GW3+wqSMSsALXUu/5T/4yClImku/jCBXLmsWxQntNdCtD/r+QtGRyJfHJZzgKTJbRx
 rQU3krld/j6bDL5g3b1U2/wGKeGPJ0Ry1hfJytm4LFdOP38HEZdPAVSlZZ399Adjywi2
 CcpSkPyPcG6YoH6bkf5LMfs+4bgYTQdOUNC3S/vK29tLRGXk9VKSbS5hDNpgOvkhqQ+D
 cOtwZgPSI/SOA3K4A/OIfTXk3umFqYfBoRCWzDf7tjGfk17vDJI3N4gIoYBQrR2EAoKS
 I+DECgY5dInYXbOTIc3FfqDZP2+UZKKQyaxkGI9dLFbsdFIrUzEuJk2zMzY7zSJ6lTjx
 YzXQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF4inNOdufqKrDR32oBofNakrogWFFazG60odE7F289WgdYitt7QywCjnUkVXwGP4N4KQt1pDbMBV0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jvMFD6R1OM7cWvQ2Rj0xByfGPyvWwSAjyriNzndLt3wRM0wwY
 8MF4il4PEnyZMaMk6V2VGJCjVFHDV59rTWecaF04Jv/5aa035qB0bKnF7AAsCyHCU+h33RymeMc
 fh+PH9rJZD38n6isZJ9xyEj6AFQpEtE+ScV94Guwmo9uNjl195OzZciVYsK5xT73vOfO0Fdk=
X-Gm-Gg: AZFdTZfd+NSWqnUDXzUdxneirs8nmVeZR+nWE2Dhp4ozVo1phid85e6zN1NH2Flc9WC
 jkHr8OMg9szTB7HGmDIBcNTCTMEZ9IjjC3hbR4s4tvZNcl2vxFiVZHEgrfPA5LFP2VaiD/RNg+d
 GCS7EEGiG4ex17b7utqgnmzgzEZJq7SiqU4xNcPwtwD8mQUaFnItCaABvnM8g+FMvpG8c1U7cFY
 UjkV0+t6p5E3r7bfseISIzLulqe2vtyoRAElSI2/DvnwsfeQ7QZkAma4br6lmVmp+++Dt6Az7cE
 Z1GSLUdE6jLmNxPNBhngwjdYJjuM7VgqzT44jtXPo4lxoBhqjhgcP4TvpBNaaod+6ZTMWSM7UEj
 0cjCNpbGV4KR2QBskCNQGIn7SxBHfvPOALf22pg7t4JiOuFAKQ7TMURds+aSLRQUuBb/C1SWArD
 v/UhR1d3DCs65iRU+1UbvqNfinCmeJH9TCyz2IIsidrp7UAsU+3Q1LDSpQfW/kwA==
X-Received: by 2002:a05:620a:a294:b0:94a:8bf:19a8 with SMTP id
 af79cd13be357-94a08bf1c7amr1490675485a.53.1795808700825; 
 Fri, 27 Nov 2026 11:45:00 -0800 (PST)
X-Received: by 2002:a05:620a:a294:b0:94a:8bf:19a8 with SMTP id
 af79cd13be357-94a08bf1c7amr1490669885a.53.1795808700239; 
 Fri, 27 Nov 2026 11:45:00 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:44:59 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:18 +0200
Subject: [PATCH v4 05/14] drm/msm: clean up after a failed msm_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-5-242b0a3f8e47@oss.qualcomm.com>
References: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
In-Reply-To: <20261127-msm-kms-destroy-fixes-v4-0-242b0a3f8e47@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Vinod Polimera <quic_vpolimer@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2848;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9LvocUvveUXjJ7V7mUbGxGyvjqVgLW4tn0dUlZYBOKg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2dA0wvEU9DrIrxbsaxbbCCnxVXZAzZ7DyXj
 aKvsL2ghKqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndnQAKCRCLPIo+Aiko
 1R9fB/9tiQx5NuirsjRk7yFIskmYugbCs2hiVZeHc5VjzeDtPFVOwYiL4iWj00kuHcJboF/sES8
 sxr4/E3ItLyH/Bt5vnvPhAxBzxf0UMveLrDfSXsWe3eGvCo+3pe6V46JYeC0iWkdwyQUg7Zv2u4
 Yt6lZLsjd1nQjz+C26yhnfXc3ir+YTv9va71u+ZR41mWVffeL5H2JLzTiuIZaj6VhLH6C9vwE3j
 GhHwCkclnDkUGBbCJdsuM0QylMLo9TCSI59j9OeeN78lm3XGabBZQ37zUQgap4Skki4pJAr2FYu
 d4CRCsuAVXCc+uqtFiwbSUYeyA+xBb9s0IPbsFUgpVlergJL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX90J2GZOLrcWU
 XmB9hEvwASnEogzd64LHCPkxFs8WZxuwqZgIVtVlmv7ET5mZHJDeiUDWNxmJtNc1WAayA6AKaYc
 GazaP4Fp/iXVJBH7+qru+kTYNROosNeelcd/cZyx3uPDi+2VYzA1Ffv/IPV4NWgv6x/hahyL43b
 PUZpOgDxm5FO2AP102UfkSwRqQQRLvkEUf8aRXJPew/467mTlvR4IBiJMI+poU9BnP5KrYQEW2D
 5NeL9sHiX1DsEjF5/OUzpPqDRz2gowd8hge0IJHzQOskR8MY6V74h6df2PGMo5+5NERdrYU6nug
 i6y76959q3gZiEz9DS/PwD1T5zJj1If7YYRW+49FAv0DvYACj99p5MbUq56z9A5FGKn0K/6BgGA
 bv04TfcIWc13LHisjLhOGD4fQnO6zjQZdCpwv4n6CjPZiblI4yePX5DxmGCou3rqJHA2T/yzDJV
 V/LaBtzk373lnpxatAg==
X-Proofpoint-ORIG-GUID: WJIlwh9iXV_Z8mgCsZSwX4HAkPEfSRZV
X-Authority-Analysis: v=2.4 cv=QpzLTlyd c=1 sm=1 tr=0 ts=6b09ddbd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=MHPtEXvVaziToaNGM0QA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: WJIlwh9iXV_Z8mgCsZSwX4HAkPEfSRZV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX0tcTQDWVG2cE
 QsEFAIrhvrtBAPjX1tlQo9JwNHuQIXQNL8aaFQTQiJEa3C70h6IaC4ooaCWNk+1iG2hAZ8QkosZ
 md3Yde9csj5jomm5dWhnCXZxXf5G+OA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270078
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

