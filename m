Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B1A606A329
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ev+b26Ei;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TXmPEaEn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5F010E6BC;
	Fri, 23 Oct 2026 15:32:55 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E1E10E696
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:55 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5v7m4063351
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=; b=Ev+b26EisJVddRi7
 hEWpF7gdn6uWqq53CisKKZVna5nbZDDJyHhxiguJQkYdghEis/Njg/2ssnrfverJ
 VCCA1C2WOTMqbN9HbxwHCZL3NUPa9tP7kOCGihTlHp0nmcGTgSgO5jdr5tbrGIEN
 Oa8ip9QjZYC8XxF0saLSPVTiec3eoMBZ+AN2cJIuGTY0HazBssN2rLibcy7UXOVj
 HmGSq8WYdp15BpMilVYY8l6L1E3gHVtWOnvPHsLOmLHnNLJW7ZO7TEci+cNLY22k
 SD43i3HnZbSxYN0I2B/S2uz5M/7OQXb9WRu5GbKd0hILxpTk5GDm9Ldohugr0C1n
 7SyIsg==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcan1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:54 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7cc23a549a9so872003137.0
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769513; x=1793374313;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=;
 b=TXmPEaEnewQHuxQfsWQP2dxy8Us+Vb6XsaV3GF/AJsDFQkpt3Stqzgz51tly1jT897
 qDzxXe3xVyHgHhnSigOi/TSwPC5h+DxwNFAuEHexBIk2WWZXDoJSE4fWg6vUoFMwQZ8h
 FHbx6g2B7XgouCAnhJ0LbKFogp76fNWcSICu+nLcgdMRBWHbELXkAsl9KHvreJYMVoiW
 VbqYxLySqt0QvFNhbEUDRwMQ9x+p6/qM+hFT2t2xIjVFJMc9SDXjO3V64JhapPwTJUW8
 Kom4OMGY2uBBh9jyXW5gb0F5tk+5PnSvCZfG+Ca6aaVFiFiWe5+NJppOl978yN8D4En0
 SiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769513; x=1793374313;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AOmCgi0lHHtX/LZVSXe9KQ6W21nQTpASIrTek+rkrBY=;
 b=w1rsapy6xH4SN0gevWkQBvGKj+Xj0pLoKrrRPSehuRZNpUVNprGkRs3Zck/MhYJVsP
 kRWtThuJyWpEOOq57VIdWY8qgHZQ6QiKIS2iG1cu/44zHaqz102JAaj7hV/inEYgHgb3
 EEBySQt5q/tzMkY0Qs0fA7iluHruCiFEBlI+qkuUzSwUuMqX+AiRlLRmlcP+1FPIj2SD
 f9ReiS1ApDne4LJmJo0gUwoWZiAINCdqrug36IWPZd4PVZ0Pu710Xvk9Vt1V9Ndyu0AM
 GVJ7HGMilz4LvRJBf48tSZ1BippAx9vxIKvx5MwVk95qdcGJwaBD4xFf+wjLj2ds+BNl
 g1YQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4vKLvVl28HeBRisxc0+IXdQ2IqYreC76kSSRwj/ZkCs7LpGcn0F62LIYWychVO7hug3Cq3hUpeSg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbpXPufyUv6AqJixfxz+//vbfnOmbCAaro2xH493anLde/+Uv6
 dpiu6XsKhAej30qB6VPwCCWR4C4n0xelvDkAwso+mndGJN8eovcmgt9kXTbmwrMxSnTT5r5Bwbu
 mY0pEUJtrSqMCLlxSqEJCi7cOHEcmKzmmQMFdBcD6NaueDD2CEslD7dVtkRO1+BaiZ25+kz8=
X-Gm-Gg: AYBFou0HuiKjmRVmezewIk4vk3hzqvr5n5T7OfFzMSbxx0LRAUE4Qq82juaX+dHBs3v
 rmC+9n9YzFWcm4M8YjkiWE1mCCSxfY0YnQLkZSu0SsO8nFHHPaxUWr7aLxzv7SQSRFGoX7yvr5m
 oHcI7b521lLUPFMUG3Irl9WziHAeDXQIZ8L4ZY3uWFw+tMVGqV0V+OZaZl7j5Z0uU20Puq/OS4L
 rLKPtAU6mrugrpM5nv0sUxOuMNmZ9u5L8zlPaAP4juQ/Scz92ZARJ+ShpumWV9AJQXFcyIfrgSg
 mxE5Nhu+tV1BuMrh2sXQs90G2J0fu82Qx+0WMgF8Nsj9NtKebLzfAMXQMI2z4HxfzjvCsssQIuS
 1Vt7FPHIJgWpvOdcXc3RlbexSNya+fpU1C+egJmbZ91PR8a91PL/MW9XCetUKpiTJ0167XT9S34
 ry5h7+fsXExKJJ
X-Received: by 2002:a05:6102:160c:b0:7cb:bc5e:7d9f with SMTP id
 ada2fe7eead31-7ccc31ef7e2mr1097921137.11.1792769513414; 
 Fri, 23 Oct 2026 08:31:53 -0700 (PDT)
X-Received: by 2002:a05:6102:160c:b0:7cb:bc5e:7d9f with SMTP id
 ada2fe7eead31-7ccc31ef7e2mr1097893137.11.1792769512912; 
 Fri, 23 Oct 2026 08:31:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:20 +0300
Subject: [PATCH v2 05/14] drm/msm: clean up after a failed msm_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-5-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233T94rZy6mVQWxm3EZ+NtsUq6L0GgOszA6bo
 tTTiXV5Gh6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt90wAKCRCLPIo+Aiko
 1RU2CACYjmuPKFiNw4WivWJ1BYX+JPAv8JUi3fHmWkhOmoz9Zqmws6HtzGkKbS1Bnh1ET9i5csn
 SDrS567mfGvbF+m0np74+1CRUbhBDWfaAr9IOmvMgrNhnMdm0huZet+En2ZHrkYho9tLea1U3Mg
 emYAqEXV3+dsPNqtPbq5K59QBqjHuq7DTyIZbvE0gxBAjN/KYDIBKuUeaPE4q4v8NeRAjSZDRqp
 22Bh22MvoX6dPK/F6A7h8phVWKkOWGFBJq2XHEko6ARovPi+PyvogSPApH7hl1O/imSlNXgUbBj
 h/DGiKJ1Sh5K0D8hqakzDG8sQjz35ZOkJ+zqNe01gMeDps4s
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: K5LhwE3-EJZRZbpeGIrc_ROcJLt9Riw8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXyCGocA7zfuBq
 GDah1RThRqjo71uJg9+vCWw04OLz9ep78vFUqRJvsKdYQsMQW1OfAKaAMySQKlTWq+9+QUs4zvx
 m64IUzIV4jikW7YI7EXmFnVDAFhl/eg=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb7dea cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=MHPtEXvVaziToaNGM0QA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX+rc9VwUs7Jpq
 bxy+daA2HIotbFDMOdwPiMG7lEjQxv+bx35eoUAE53l2G7HjrapGLQAzeM+N3zOMH6Ls+/ggj6W
 tjTfci8q0mmwSE6NQOTkbt+D6mXZG93udM9JHfcKqIHrn00ySBqCiEgCpzxxWs5J1rzBK7p6Etb
 LV6VZZbGyHO7OedcIAaBHNWmjdHO3j24isJN2jG8vC4sZ/9eGwtChyi0f6qNLYz/t+pO+wPWudd
 P1bNo6aJaecIgiS7ouxJG5icP+L2ZutFIwP6nogacYpkMCGmfNJ8liV9EWKA3JKHL0sMRP7ipYp
 nzg0vaNa0YtHgc8+jMIpgk3zScI8Xh0PfEcV17yyAJAAySJpcc74cVp6oPzTjx/G2S1dnbjgpQS
 DOe7DUKo8IPeYuMByxzOgUEzysUI2zhf+AN82x+KghH7oPWwA0ovl8B6RT8fQsRMyfzLqgKPjVA
 q3OPX/n3G3R/A63ExOQ==
X-Proofpoint-ORIG-GUID: K5LhwE3-EJZRZbpeGIrc_ROcJLt9Riw8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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

