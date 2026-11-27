Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RD6jAZCp;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cEQnS1jv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AACE10EAC0;
	Fri, 27 Nov 2026 19:45:26 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E7A110E622
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:54 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJRLwE2668944
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TKuPNZpIkBV0dFXAtfaO3ujCnQ6rFmYD+WOoPws3IrU=; b=RD6jAZCpxEiVXyUM
 74p2G/2G0EwU2V95VpOQOXHAn5vH7SFpHaQlp2ooFBPkv7rS9rUspnyLXmALNckp
 gyZXbRyuIv26zGdXebFOB6EH5d7DmhHH2YRpMptucfDio+pKQmr4VYuMlEABXlr7
 oFXeKnyVo+QFmjkMAj2kpv2OACQdxx3lPwFfhyeQEJmJvbclKaQRZhxgeDR4BStG
 iHJ60RvBwgbdmRSmfNx50cE59DQKkK+KLCDyrVHVWmlnxxgyX0oKoAH7R5kn5SZQ
 gGgmJyPnv+Hs70a1XUD65aCess8ZDEzU6qoGmSvvflQi0TvDRHxAjtReBU9rff36
 tO03iQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j7g1jg1b2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 19:44:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9210a12765eso123933376d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 11:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795808692; x=1796413492;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TKuPNZpIkBV0dFXAtfaO3ujCnQ6rFmYD+WOoPws3IrU=;
 b=cEQnS1jvqTHwYtlM2Vo1O7iFafix2h7OAmwRjPoJCE7CZx4WZ1anSA6I9z9r887cKo
 J8XhcFKSCrS/easX1fq7ObCnEJlLMmOU+QiFV1UC3mNrFINdfvZGdI0lf++tV4siicWD
 ApQ07bfASZXQZM00qtSZPxzZElM6hVxcfA+VxBG150WbiPQ9D/ykSMTw6PBbWGVmD9Ag
 H9UBNq9mSJrYM+qYPyOlQahze0nchwsPLkxuuZZPfK6Kqm4W9U0vBqsREqcRwcLUEv5p
 GgWOzsFSUKGAGhXpQkksUC/DVeJmBJr0BiIhRuM79ItgYvHrYX++ytd1MEVDoEPoQweg
 z8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795808692; x=1796413492;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TKuPNZpIkBV0dFXAtfaO3ujCnQ6rFmYD+WOoPws3IrU=;
 b=sVefr36IraqVepii3PqqIBtsfSgqGdcQTu7biaFBSSdsTJzf1lNqmEnF6YtF/5RaL4
 fBRrBc0oD92BPoW1OmalSAlSAvgLNq4UwG+DK2BPSRRacPtE14EKziysWHeVCaImBzXL
 Su8eaSuZkyCMxbdnzFZij01soEveZDqst5SM3YsU0Iv9eeFhtpqP5OC0Bi5dSRn2LOH0
 MRB3t3plyqJHpdGxmbq7hUoaScMZai44U6Cx5TSWr6KMPXq6U7EkcPc9g0XXkkFTfSKt
 urVpTPwzcPO5WHPgcL5RCDFGGtJ/mAdovFr3GfQwZmPDY1Gc6czQ1FBK4TqV6zi7Pxa2
 qLAA==
X-Forwarded-Encrypted: i=1;
 AL+hErGUJ4qiL7Gz+OHDh0mW+ZAtlFoH1TOCMkhmSzS+K2OJatpPYb8z+ZCcBZvz6WZSBjq7D/gdKOh7FKw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8+9apYu4ckeiB8LWsCSoniRXbiLKnVNnVUpPHT+siezefUL11
 4RqV/QT74s8vSbw/tbyHJuXIfPpQBd6WS+Vjdr+uc4CnTueRsrRaB0ncgVP3y8IskMOqmZ0/zay
 fjzO/o7UT2f+rCh1YtOkvEFK8tWVuvgOSu15YgeJL/3q4U42NWy37lEDcz9x15Mx+teFhS/M=
X-Gm-Gg: AZFdTZd68D+K29/WZNi7FAzNtzKQGnT2C9O7UM/wsEsbybjmIz2qZesIqVIZHiF2MF8
 JKOD83q6JUZl4aD2JzM6xZR/L3KNjvFxn3S4v4SDyG6jZDt8T7g6VFinGgA480ZMbLhXDolTIm8
 le09kOeobke0xDByw5Vf0aqmEIJmO1w7yJhzmott1NGcjT7uKM4nQicF+6haRcE1uXHQpRyxRRC
 E3fHP8ougclGm/LTpwnFfbUYW1Nvmmuds6WxvEPvVKSkpAUkwE9Hq+psbMYqfCrAupCL8TPSj2d
 wRLNkicc7c7Vaerl9wqOuxKEgcSktOTFXehDoaHCqQGIlPl7+acRE+FzkACcHd02ZN7WKnpYqsO
 fmnFu72MRFcettkFHavuhSX4+gUQp4TO2csne2i5tl4jh4OswYVGza41Fw100bs7/zmEVFeTsdg
 v+29OizJRHSt4QqN5J8u4tOOBi1OPOwfNDEyDCz9y6+GwzIVqGdKq/Jy4A814XyQ==
X-Received: by 2002:a05:6214:1244:b0:921:7f62:ae41 with SMTP id
 6a1803df08f44-9217f62c58emr180026676d6.27.1795808692405; 
 Fri, 27 Nov 2026 11:44:52 -0800 (PST)
X-Received: by 2002:a05:6214:1244:b0:921:7f62:ae41 with SMTP id
 6a1803df08f44-9217f62c58emr180026336d6.27.1795808691927; 
 Fri, 27 Nov 2026 11:44:51 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae805575b5sm59655571fa.34.2026.11.27.11.44.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 11:44:51 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 21:44:14 +0200
Subject: [PATCH v4 01/14] drm/msm: fail the snapshot init when its worker
 cannot be created
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-msm-kms-destroy-fixes-v4-1-242b0a3f8e47@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pn8k9pjAdztDK0HTVppUIDnbe3Pz6r2PeItof1YOjaM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBrCd2W80S0Cp0LSz+DYTZ/QxL8NtAGZUTfC5FwU
 u66PmNVkEuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCawndlgAKCRCLPIo+Aiko
 1YUUB/49xsKwx/IInER312BWj+eV3B/o/aN7cqaV5VcaX09DRU2gdIkhOyGzwaXSbdyAjF+81lu
 MIzAbawHBjdYXL1FkOOHDMn/6v87u0B3GEiKIe27skcJfENn/QW/X+3+bjlMjQT7vnUeGLRteIm
 N37kdGOiCJCy0BhzPNXnl9gRabS0xqtc2s4yOyL9OhEbrcvs7f7XvsZ9JafzuyI1En8DzZE0Lwy
 XY+jrSSwINP+4DJQ7IRabQTuySma9xR4ZOambUz1V4yqEMVuvQC8snnqhfMIy0XJRzlbfw+zQHN
 z8uoNiUZuXYObfCyTNU/tQuHpK1sfZG3+KVvDKNV60hUEDRz
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfX4v6FGKsaACoQ
 b7BIGNwihAHgPcACZI0q9XqB+yhg7oS3iaQ0WtC58Sd16dWLv+3r8EQWIU9O7/rEMnKcldGa5on
 JaOmyoJSh788G/3pmmAkGnncTu0rIUuOxmCauzYtiuRr4LRiT9z7YcYaH10Dr/HJ1/lCh7iX+fb
 GswuKdHPoyYqKa2JbvKm3/CHNMThfavLOfv60RBBKVenehTYIJOLopM5qyIUDLwWMt/R+PdVPgu
 n5GMTB2//ue9DQczDtm/n+RpHq20nog01xIgOnMcgGApBZ56U+m9uUolDmvp49b8Sqz9LjGvKf4
 HkQd+tqdKAHSW87RgPAE+AFmUlwgP5NFbo6OdYjCJM8W2tIWQSgHRgszzd/4V+fRFtaxf7BTsXu
 cD+2PL/EIWamOCsG8sw0oeSE6HJFJiRCpDuktO9tWzTWLBR9BFZuHkDiVCcFzSRn7I8I5vRfycM
 /+0kocKyQsaMQ/ZkmIg==
X-Proofpoint-ORIG-GUID: cQr5WVXIKRRdvCfryf3__F6EadIW3j8S
X-Authority-Analysis: v=2.4 cv=QpzLTlyd c=1 sm=1 tr=0 ts=6b09ddb6 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=7Wt60wlDe4M0s1bRQVsA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: cQr5WVXIKRRdvCfryf3__F6EadIW3j8S
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA3OCBTYWx0ZWRfXyBGcpEEPFRwL
 ijWeIVlgn1iAuehVrgLOrRNVmlVQHYSxVBZ/nJzf1pj/0bdAZQMPSQq0QhqYEbxFeefg/ya+RUs
 3mRV7OeeGD1u0zgVZNgzD7dm20TSqCI=
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

msm_disp_snapshot_init() only logs a failure of kthread_run_worker() and
returns success, leaving the error pointer in kms->dump_worker.  Both of
its users then dereference it: msm_disp_snapshot_state() queues the dump
work on it on the first display error, and msm_disp_snapshot_destroy()
only checks the pointer for NULL before passing it to
kthread_destroy_worker().

Clear the pointer and return the error instead, so that the KMS init
fails rather than leaving a snapshot facility which crashes when used.

Fixes: 98659487b845 ("drm/msm: add support to take dpu snapshot")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
index d99771684728..6045daa785c5 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot.c
@@ -98,6 +98,7 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
 {
 	struct msm_drm_private *priv;
 	struct msm_kms *kms;
+	int ret;
 
 	if (!drm_dev) {
 		DRM_ERROR("invalid params\n");
@@ -110,8 +111,13 @@ int msm_disp_snapshot_init(struct drm_device *drm_dev)
 	mutex_init(&kms->dump_mutex);
 
 	kms->dump_worker = kthread_run_worker(0, "%s", "disp_snapshot");
-	if (IS_ERR(kms->dump_worker))
+	if (IS_ERR(kms->dump_worker)) {
+		ret = PTR_ERR(kms->dump_worker);
+		kms->dump_worker = NULL;
 		DRM_ERROR("failed to create disp state task\n");
+		mutex_destroy(&kms->dump_mutex);
+		return ret;
+	}
 
 	kthread_init_work(&kms->dump_work, _msm_disp_snapshot_work);
 
@@ -131,8 +137,8 @@ void msm_disp_snapshot_destroy(struct drm_device *drm_dev)
 	priv = drm_dev->dev_private;
 	kms = priv->kms;
 
-	if (kms->dump_worker)
+	if (kms->dump_worker) {
 		kthread_destroy_worker(kms->dump_worker);
-
-	mutex_destroy(&kms->dump_mutex);
+		mutex_destroy(&kms->dump_mutex);
+	}
 }

-- 
2.47.3

