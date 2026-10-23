Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90CC606A337
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fy7A2sLn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f6f1ipdA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C174112D2A;
	Fri, 23 Oct 2026 23:20:47 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32FB510E746
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:32 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvBZe297028
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 88pPbfRA5zc4GwTj062kzD+FGSbESoy/XcuBiUAQT94=; b=fy7A2sLn6QPuMTdz
 SzaZV3WUx6BB9wF3Rlh//zJqXm48EHdbcAYTc6l9Kh8FLB/iLm8fVex5RObWgpFP
 s5OuS4jpEV+hC/vNbRXzBKGesRreX+X+DTC8x9mhhZoA5wWcTB+H1spEcJ4tD2ng
 /pHsF1v0OEBi1lTBX939YGAh8Jd8OlKJTpk8R26d8abot4vTC+ZRHPN5kdgCYrdK
 yvebG2CDtKCF91qNt0BveJceR8wYFZeGCVee1CAGQFvrQLwtHvXWjS9pC0w5AZ3u
 TnQcyFZ0wPYlJ5mq45NYn3qSN5sHQ+zhcBD6shjaLnvCchukGy2vSpaJId7UGvao
 nVbQMQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgaruhc2r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f33438950so316550185a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797630; x=1793402430;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=88pPbfRA5zc4GwTj062kzD+FGSbESoy/XcuBiUAQT94=;
 b=f6f1ipdAmuu8sxD41PBZf2kOX8m9kgNdL9IH5mLbkN/cgCbTeUQnLOP8jzd/ojvlRL
 cQqzm1MdagwxZ0kbuWyyu0ThLujQHwWGUloyHF30t9bdIaX+NxtAnAR/4HSNWeyKWOJ5
 63hQWaAJjbAw7mOyk/S4XFmQfcoaxV+Oaga1LLSr9Rr23qFmb67Uk9wzThoBUZpupO4L
 jqmdheV0YMbMs3o6Olfe8jYaXSM56S5Ze6IHU22oO5ESY2yenyjAxJa7xF5ikr9znA7e
 9ajxJrVK+Bd8Xmo9UGst6pVk4VlyuPkB38vg4LeOQexUIPQSpFdGEIMmw/4tCyNCeHok
 KJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797630; x=1793402430;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=88pPbfRA5zc4GwTj062kzD+FGSbESoy/XcuBiUAQT94=;
 b=ORrb2yeQ9Luqsogv0qHejnozeVwW+Qsy07Ihsr0X+OOCCxx/2iNbKJinzpAA8EuipA
 4a4WqkvAx4B2+5MR3axVMJjzmKdbMtjPw9tY4dtodLrySoYYLQRUWLLOPs+AC7YnUdQb
 Ip+0/Sj789ia7Zmc1DIUGhDeeLvWNHfz2vP4dJXH0kw/c/XTe2PUN5A2F2f7z0jXXh3N
 93AVLkT+r5yzOB9d1fqwu5rfopnON45jHjBTqIP8bC56IvPCz8QnorrKZj7QH1IOyKUC
 IGJ99fO1CX7sChYa8QgJiT9gz5K0T6eZt1CWc7tZjAodLdQ9uhBmXzTaDnUXguVHkKdV
 Ceqw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwIdIbhvshSKwWwJZqGHeTNcZXfylqIAlZatH77cdCSTQBYSaLIDSi/CdfBfNcio9oY4P0MHrsFbYw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIsWvFnE8+FxHnbEBJrwvH2Rb0z7V++OHQBGKSHFTxiaBKnezEU
 eaZqzgc/RDL+M5TTE2ykiBgPcyqV3rgt1QDs5KyrX+LnRj1AHgvSWWp0i7D5IYGVI4AmvosgPa4
 lR2DJOKmwzA2UfWsTNWiwWoElhj51BmNf4wxN3k9mxxouZCOeb/3lmv95ovqzkpA5QDHiOfI=
X-Gm-Gg: AYBFou3sWdtuGECAXlo9C+zw3Dr9mpHsrGMe+gshdsNo+fqzmhszOY1oN1dTKHi392a
 ygfkOUuDi8qhO0lVhoJqsfQdbExYiLtg+/TiIcQdws8NZGGvGfi4f0k2dvG/f8ICtw8UZEMfQy9
 fnWJK3ES+PF6T8vvL1JSR+ENffSUc9krQ8/OxYViBPSYr49gJq5SgEhmoiR+LLProuuMSETxwYi
 lI48fLVAYGlmWiNZdy9Fx39VSBA16fICBoO4dWTUOGECI1S6ixtIqh9zxiPlAaUBapdfF5cXca+
 ynUTQJff5GGMKerNPT2BnpVyNzP8unJrqPrnHTcytltVX7qN6P+2dFBKEE9UY/k3sC6ULc/ra1s
 077bJsSp5yFnz1hRk1To/7seRh85y42sfWdR9fKWIszw/MuCHf3af7c6y9m2xV30cF0sYRzQFhz
 rmQTRfMv836+Ki
X-Received: by 2002:a05:620a:178d:b0:93e:6b9e:6167 with SMTP id
 af79cd13be357-940ef8fd205mr91187685a.16.1792797630037; 
 Fri, 23 Oct 2026 16:20:30 -0700 (PDT)
X-Received: by 2002:a05:620a:178d:b0:93e:6b9e:6167 with SMTP id
 af79cd13be357-940ef8fd205mr91183485a.16.1792797629433; 
 Fri, 23 Oct 2026 16:20:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:26 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:43 +0300
Subject: [PATCH v3 10/14] drm/msm: tear down only a successfully
 initialised KMS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-10-66a30120a5ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4509;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ME7+CIOAsEStPCR8dTr5EHiDhPg+iGJaaA80Q9N32Jk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uVDtLmXeAXGWMPg3cih6TFix+O8APD/LUrl
 Hn18697CkSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrlQAKCRCLPIo+Aiko
 1T9XCACOITNUrJb54voiy1yXLyomCqoHGHeeGkipObDQXe7iGzRoeCp2+o8KBTkjSaRgMCYTqaN
 yTYorg/8Df6pff6oQtwb5Byc7ayKxt4RTwJVAC6qauAdZFv7mPYbI9wQzq1SJjGrkwHuCt2yanQ
 8HfFkTGmGcN1eguWr3722FVfWjIKfzFLkLy0MuPzKZfNQ3LWXdWFt/GiJBO5Krd82hRs/G1TTy+
 qrQB9C1ofV1Gh8sfsvcNtqh0GMaCFEJmWO5TzRf4bmPgtI0MXr/0oE6yGy4JZbDuNTVhOdR57N4
 UmhSaswDXTGKdLpiZlftjoTOiuzKI4o4AW5DFb3fi5h5tPq5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXxf53ezFil6RQ
 9Jcrae6mIKVE/7dw0TevMiYDFrdBqAprAxmvQsHsmOvrVMJmmYHr7THX7fSmL1cVrzllMT+bnul
 MvmY59mjwnRt47/3yp4/XP3v3/i7LoE=
X-Proofpoint-GUID: XwXBrHZ7OEcp77JOkDCtwjyZD989jQgl
X-Authority-Analysis: v=2.4 cv=SK7Xx+vH c=1 sm=1 tr=0 ts=6adbebbe cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=mlEQwpWygrYFFZNu1HYA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: XwXBrHZ7OEcp77JOkDCtwjyZD989jQgl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX3hjhxfalIN45
 mCtyaGkDP9JJzpXZSUGQYu1vcAgRMDH+febwuhik4fexV60FOMgu8aGVaMrC8WrDG+DnCE8k2Ev
 YI3GaMSRvr6yNT2FFBrcrAxnTFUXiGjSJa7220stQJmduNRfhJNMVjEnDT4IgPQRH51ocgsYmkz
 GpG5tI6GJFDxSxMUxhB9hdhoTSbkc011k7TZL45CVzHvCfDzgukFntkP4UudqeiXqlUL0woWBEx
 ATFHr/7JfnLKEU3CcJDQeUT0BE6y1XslJbk9JXSmY5myO7XyJoFPVxwj5sied/Vmy76lc23/2kg
 PnAN+mPV8wzdGkUvEDm5I7gVU8ZhSXcNNvKZ2ZMWEMh/tW6SkC4eFfvALJdq1cU3WH8/Ty2qp7d
 ui6TwXLfJZV/SIT2ZI6uTHoUaCI5nWkjG0pM5/rEaBa/ehXmiTBY+ckSdIBP6W7+yIh7EWCumjs
 3E5ml/fQcXrtGVMlbKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
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

All the kms drivers now undo their own failures in kms_init() and have
folded their hardware setup into it.

Drop ->hw_init(), call ->destroy() only for a KMS which was initialised
successfully, and remove the flag which let the drivers opt in to that
one at a time, as well as the handling of a half torn down KMS in
msm_kms_destroy().

Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c  |  2 --
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  1 -
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c |  2 --
 drivers/gpu/drm/msm/msm_kms.c            | 16 ++--------------
 drivers/gpu/drm/msm/msm_kms.h            | 10 ++--------
 5 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 255beb83fc94..65ba8fa697e9 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1290,8 +1290,6 @@ static int dpu_kms_init(struct drm_device *ddev)
 	int ret = 0;
 	unsigned long max_freq = ULONG_MAX;
 
-	dpu_kms->base.init_unwinds = true;
-
 	opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
 	if (!IS_ERR(opp))
 		dev_pm_opp_put(opp);
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index c2172e5f9e85..c1f61ecf800f 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -409,7 +409,6 @@ static int mdp4_kms_init(struct drm_device *dev)
 	/* TODO: Chips that aren't apq8064 have a 200 Mhz max_clk */
 	max_clk = 266667000;
 
-	kms->init_unwinds = true;
 	mdp4_kms->dev = dev;
 
 	ret = mdp_kms_init(&mdp4_kms->base, &kms_funcs);
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 30af8ef51e4c..c349eedd55a6 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -505,8 +505,6 @@ static int mdp5_kms_init(struct drm_device *dev)
 	struct drm_gpuvm *vm;
 	int i, ret;
 
-	kms->init_unwinds = true;
-
 	ret = mdp5_init(to_platform_device(dev->dev), dev);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e4d61935a6df..9a207c1e8583 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -293,17 +293,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	ret = priv->kms_init(ddev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "failed to load kms\n");
-		if (kms->init_unwinds)
-			goto err_destroy_snapshot;
-		goto err_destroy_kms;
-	}
-
-	if (kms->funcs->hw_init) {
-		ret = kms->funcs->hw_init(kms);
-		if (ret) {
-			DRM_DEV_ERROR(dev, "kms hw init failed: %d\n", ret);
-			goto err_destroy_kms;
-		}
+		goto err_destroy_snapshot;
 	}
 
 	drm_helper_move_panel_connectors_to_head(ddev);
@@ -347,9 +337,7 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 
 err_destroy_event_threads:
 	msm_drm_kms_destroy_event_threads(kms);
-err_destroy_kms:
-	if (kms->funcs)
-		kms->funcs->destroy(kms);
+	kms->funcs->destroy(kms);
 err_destroy_snapshot:
 	msm_disp_snapshot_destroy(ddev);
 
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index 2f097e23e2e9..b5e1cd38cd8a 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -23,8 +23,6 @@
  * for constructing the appropriate planes/crtcs/encoders/connectors.
  */
 struct msm_kms_funcs {
-	/* hw initialization: */
-	int (*hw_init)(struct msm_kms *kms);
 	/* irq handling: */
 	void (*irq_preinstall)(struct msm_kms *kms);
 	int (*irq_postinstall)(struct msm_kms *kms);
@@ -149,9 +147,6 @@ struct msm_kms {
 	int irq;
 	bool irq_requested;
 
-	/* set by the kms drivers whose kms_init() undoes its own failures */
-	bool init_unwinds;
-
 	/* rate limit the snapshot capture to once per attach */
 	atomic_t fault_snapshot_capture;
 
@@ -214,9 +209,8 @@ static inline void msm_kms_destroy(struct msm_kms *kms)
 	for (i = 0; i < ARRAY_SIZE(kms->pending_timers); i++)
 		msm_atomic_destroy_pending_timer(&kms->pending_timers[i]);
 
-	/* the kms drivers' ->destroy() also runs after a failed init */
-	if (kms->wq)
-		destroy_workqueue(kms->wq);
+	destroy_workqueue(kms->wq);
+	kms->wq = NULL;
 }
 
 #define for_each_crtc_mask(dev, crtc, crtc_mask) \

-- 
2.47.3

