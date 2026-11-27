Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB7606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duV2URsl;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZzUbL5zo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC260112D4F;
	Fri, 27 Nov 2026 19:45:37 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF5CD10EA81
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJBZmF2762929
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hi2RgCzxsniZkcpizYBKzBTqqeH5jvUpama9Qmo6TGQ=; b=duV2URslxQonYqnN
 90AHfyEuqeukXJcKdOegFzUbAv298WpYy8WXqN6MLc60Z9iCQBJwegXRVyZnqZxh
 6lO7eFBvWqBawflDt4TeseIN8eLX4URm93LZEWieyHdo1wQWDGCbVwOuo9djqplM
 WQ5YUEErnUy1spneq0yuto3Lw8A7u9x5cG9WghPJgwlwrA9qsZQKvNXwdhUk16UL
 9JXxYxKk/NAM1lpkIVzvTmIdRiblhJTsGxNgw2jkU3FWazh2edpxHH38p+tR3tEV
 qh7M+gEMAAjFGquIpNDQ57y4eKsmHeSEujaz4BqUiPKallrbUDpnp1KUNGNcDqfP
 C/k5eA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j756kam7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:45:09 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94a1db3cd3cso174531685a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808709; x=1796413509;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hi2RgCzxsniZkcpizYBKzBTqqeH5jvUpama9Qmo6TGQ=;
 b=ZzUbL5zo691RRjsGBTEELbvA5vqldMkb8lm9NBlowh/XQd/bQ6IP7MrEvUpy1q50FW
 EKKBl5yK0FCXd5srxzZVqT3uclHVqDGTbrOMVyp6vpgofCTpo7iVgLy+gdHEeWtZp5BM
 i8K546LZpPkPkQ+kQP1w6SpvqPRCC3K93L1f+h/XEcrl68RueRU2q3NwtAH1+HEVylje
 ST0w4ON9cLD8IWwwbiOordK0PBswPnVYk+4gEbFXy7y08vgi45Hd6mo30+7y6VSnY2R6
 +XcV8wGCzLRXrxvZrH5Tb9vV92AUFqucQigucuIeselApWgZVi5sU9+sHbugUpH4lqGC
 Ojcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808709; x=1796413509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hi2RgCzxsniZkcpizYBKzBTqqeH5jvUpama9Qmo6TGQ=;
 b=ImctQiQozpP9QNZtQ6TbjCLJxmmU9t2BoU8Kv4Ah+mWvsEiUhLu5fA++lmDrgfzZoK
 azSxraaU4LlIs8lufEWCtMeDNelG7t7thCrFyqXdDBwo0sz8W9A1tlJlOR+dHUJEa7xO
 UDxhKFFA+TSEz53BNV3GQO0qB2klKzgk4tOPo0Dw7vrwU8NNim7WsQ+v4AfGQ01Fa9z8
 eqjhvV4ZKm1/ZlcEsbPoTtazKQaxv0YR47hxf1DCEsaxhi3OZvKTL3T+x+a/p8dcFQIY
 RRnRJbhW/GiqLHTMLzly66670CLJBnCBDhAcyteSydunG8vAMqSp0OklBx+TK5o74slg
 g/kA==
X-Forwarded-Encrypted: i=1;
 AL+hErFtDLcqpZyFL/OcDxEDDzvDMXvA81cgymLCkrE8It4WgYuu4An5RApyEI4qfwU+UCluP/o9jar818o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z//M7QNZ+fO0+zf0nqOKQWxNAjK1nfPLpudNcqbBHXXXk8dgJyD
 WgE+iWmZsVBurykPEZ7pDWam5/2af6R3Pn5MzDZWcOEts+udX3vac9D6Jyg2qPs16OV9xgz+LGp
 0dUZbBeFQmgOh5UbExLQZ4DvyMq9/sn0ppbkjGCUMf/RrOx5H0rXLW9XoIcU+KYveBVcD8AM=
X-Gm-Gg: AZFdTZdbdI5SzCPXGD3NXk5q9cPs8lf+1Ea+yY2AFHgBnVdt4LyQSr50H7wYe5QWOnE
 L7fGOxLDp9BqGiDHGPQKdytGHCIPUQuiSm2pqsSgt4m8j+ArWDQRfGB/PpzgaSCVxJGk8qRjklR
 DAsw9dH6YT6VJPzEiAs8D9oYNyeuE9arMJMr4ed2POv1iPtgXGyI/qRj6toxvabVde0Pm7aOLcy
 Xar7TZlMgJeCfGeexxvkZ3DjbdjA9IIecp9MyaB1zcdmYO50PqYmMMV0GEfs4NkhlCjX7FWTPQP
 66WfmF7BsQ9jLMhJKUxPMLpLipMwcIqEmbUuCXcYGNGiLPVtBKu86kSylfdBkagcisd64KsIiyx
 Dz1o8gqw7QeU/PQBqlji3TK1C3r5c7oZt+xGk2fhcFQicU29eL6hpDOi2NptUIEoWTrgYW7joql
 vvj3VOuv1dt/uPvYbAuSxlR25KYueawZiHk4cbIqhd+J5SbjqU6N+1NXjA3JMEQw==
X-Received: by 2002:a05:620a:5394:10b0:949:bda2:194d with SMTP id
 af79cd13be357-949bda21c95mr3243192385a.83.1795808709053; 
 Fri, 27 Nov 2026 11:45:09 -0800 (PST)
X-Received: by 2002:a05:620a:5394:10b0:949:bda2:194d with SMTP id
 af79cd13be357-949bda21c95mr3243187585a.83.1795808708535; 
 Fri, 27 Nov 2026 11:45:08 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:45:07 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:23 +0200
Subject: [PATCH v4 10/14] drm/msm: tear down only a successfully
 initialised KMS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-10-242b0a3f8e47@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4504;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=v7Mlp0RWyEHoJHxf2OONOylgsUewN5Mb0W8CnMnixnE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2mkBra9+DbLS1cq/6zB6w6gPspz7g9Yw5Od
 9ZA497Hp12JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndpgAKCRCLPIo+Aiko
 1U6WB/0YngWOTcYQOCIvcyFPXNqfa9S73l1L1PGsWaAGoADnOfA9OtJZ2oBnpRJre8A8AY7pIW0
 btpxh5lXs58eIttKIA/4wVaoVdZjA676k86qto2NxMRlny+P44GLs9UnIi2wa6C80mkG7BviJy3
 PUYgSYhHGfpZ9L3GgMWS12JZR9d3hHjM0Nk0AYoXz/BOh3uIYfAyEYBYPTzGc0Cex0QJuUdCJju
 TxPUg118fUz1Vb4CIKYfAWHXRoiN6Sfa7R70OQFrXOKeyU1szC6EYCW/MDrKTnOnTx/K8UbE/m7
 87iGJXiwFwoBcjQGnfcGj6H2rcZwSOlqrkaT495ChKBaBBrm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX0UTvTGMUwoT0
 YxSofMEB2oXbrYZPOja0HQtuGA4rgEKYmhMVyoKtra8t1nAYh3acDhoiEk5ykBNyrfiHNrc983w
 cm/dNEwEvYIxZ7lGF5Y34VJrRQYE9SpG/aUv1G1LbbKQoRhy9Xiwr3kPn+IE8JD5zBl4Ho12qRd
 9KVD4aihxqmuSqocwxmtOMkR8HlTr0wY9WhkFKeUssOeb9AB3JrdU7cEQQnINEgxUZt/rvdqqJJ
 gLJZo8z5fln4+18e7E1c4NykDucQxb4FpP46PUovQzTdoOPQDJFUxsIOS74q3ECb2UCPhg2RqsC
 FRJItaf95ebfbDwupzgECiXmF7q1B+MxBxP/Ofb4WC9S2EePxkbK3IUV+xPW2XrJTDOceNIdtcd
 Kwv1WUNW1yXqvHc4pffA6Eg6LMsp+dnYF8y9sLQODSM+KRGlz68zhdkbSW1UoGcqslda+99WZQL
 jOe5d6ido27JDMsis0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX1kcQCdi12U+i
 o5HeHtatY8YwHaZBNnAXCT/HpxjJ1V1Q5QGvyhX3PFVqsFc2k178Icz2hTFtvIoXopr2TfHxG6q
 5PTUn7Fprm+GKmbU/VsoWo80M3uhVkU=
X-Authority-Analysis: v=2.4 cv=ebWo7LEH c=1 sm=1 tr=0 ts=6b09ddc5 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=kQpT_P1mV4N9NWRngdgA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: l7fgYiLyV1O_kQSy3hbh-j1nNZoqfcWw
X-Proofpoint-ORIG-GUID: l7fgYiLyV1O_kQSy3hbh-j1nNZoqfcWw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
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
index da9ba8583420..838bcb2c9e19 100644
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
@@ -347,10 +337,8 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 
 err_destroy_event_threads:
 	msm_drm_kms_destroy_event_threads(kms);
-err_destroy_kms:
 	msm_disp_snapshot_destroy(ddev);
-	if (kms->funcs)
-		kms->funcs->destroy(kms);
+	kms->funcs->destroy(kms);
 
 	return ret;
 
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

