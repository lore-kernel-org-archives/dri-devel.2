Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0F60A262C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mrqMU72R;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kmYlw8qR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE8F11216E;
	Thu, 19 Nov 2026 08:26:31 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2852E112144
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:54 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6wJE61007304
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j4YaO0ZYpT/FRxBM0qcc+7tzTgK+KPS5LT6PmLgtxE8=; b=mrqMU72RwCR8e/Bw
 hpq45S/bOuJOy8zZRHAXsklXiSyFQZLOIkfvloaiiy1NpPFyZV/nOQKK2x2/8t/p
 BFv3fJpYBs+WnEM3s8lNeCMOPLDcaDwlKTQUoZauqs6Zae+DTBz23uwKP+XhRjcf
 KtqNeG4FXe8J+0V8ZHJZgi+GXkp/5VV6iQUJfeIWGXpN/qn5SgsY3BBgATZqcsGt
 IS2xamnHnYILjowomeWqHl3Om7ufMcC9OhnHoK2Kln/g9ivd15jmoF7ZfX0X3D3V
 cC5GiyQ8k16aEQBtHJxlVLs5RohhIlgwTmtCeyUlpm6OMZkOMg0kkyvM5DBX56LL
 qUmN+A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1etnusgy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so384526685a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076752; x=1795681552;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j4YaO0ZYpT/FRxBM0qcc+7tzTgK+KPS5LT6PmLgtxE8=;
 b=kmYlw8qRzl7R4v0dO47NRPflxf/i6l9i5aQyfasmzffPv6C+ntRdgOawbyyl8x0K9y
 PuQsYbBMCdOm1/QVp+5AVEiXwRxb64v8ZW3EByHObjk02zNoyMnd281QSxf+D0LczPuH
 mpsFuuINQXPhOEIrg4LkBfME5Dox3U7uoLaFhfMHBHIoBuB+5QTMbcpJo7GuyzkqnNOG
 f7ZZJKbgX5tHQvEx0AZpGRt+aJR9bKf8F3qrqHSIhnWOyv7azYfDhUopn7AgCLVkvAnp
 jBI67mGooqmfnaVvOchs8QL6PLz2pIXCBy/bnS99osoB+RFWrjLgzhshQZCfdjbIUlyv
 1xpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076752; x=1795681552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j4YaO0ZYpT/FRxBM0qcc+7tzTgK+KPS5LT6PmLgtxE8=;
 b=bgMqPWliK7EnvoCrF084Hr5r88WLtWAljnVmtAzxev5gPoM92Quknj9dOuPZzIPbdG
 WbjZgJ+x0YVLD11t4bl0uFsdvFcduU0B5LkGmYmIuOH6TxWCeRGp8eTIMBCALMGU+4dQ
 ocpY2mupGiKi7XvrFUh219sDHNtKYXsS+6mHn2CMuHNzMEW+ohFAJtl3dkvx6hPd7Zbb
 mp7LtHiGJbSjdHZc+NEyST0T1gkQTd6TJ9h6Mlt5cXD2kQbKDvEttQuyqR8fy4vkWPRk
 Qi2wAWfLHvaj2j0FWCk+59rKuu0qo9TG4My3iv7cGQTQEM55zDAF+q/4OkHmkAZcM1VR
 YGQw==
X-Forwarded-Encrypted: i=1;
 AL+hErHgf/5STxUfHeaTOJCeS7fPZE5lfinveMqQEie1bh9qyEJJMDV0A7/OfrItxSNj7F+qvLtK9+YTKIg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z998n5smp+Mil4lqVazMOpQOJ0zq2SMPKI2tx40yPbNxiyWDHhl
 XOEyRR16DvRbFLxh3N9u9MAaw2u5cO4hBAU65QFnguUam+sIBDp+Bpm4reMIsx4oqv7yisOE9rA
 eZePWUVOO/4QoKxB0sm22nDCzE91wneFalqh10sCn0OM/r995xTo24lKTaEuPXXKxr1sSyQg=
X-Gm-Gg: AYBFou0SQ8nHjLLkWYy2Ega9qxIwTZFCpWV1hDI1d5/HOosV249r4NH7edmC7kusQw5
 +htGcNz15vvJ+6CkgjzEisGTHZc2fTUY76whvglUFmpO3Pf9Vhu6StP84vZON4MQGa7Ok/mpX84
 OiGavy/CFfk7NxsjBlMH9QLbKrAxIR2dMELU3XQ6xU/uVuHo9SSrphwqwWipjP4c4sHdB4EO18S
 2XZVvrntGTVeBrk4ocq8jShxtuQtOSGB6A8VLO3L/+RhRaEEig85hk3GgkF3FEsgispr/CBMSmS
 9IiJOlEFiY0wDG+EYnGyV/Rbcz/VX6SRf85et+WdM/e6vACqGAhCa5QdZQ6k3hxcCNCyBa1Oe0n
 A/6/dA3hSuzebJuHs4Qf5+fdyAyQ75KAiDombMzPa43QY2MfzAIhTfORMnTxe3FlNiBh1y/wMCy
 TvBXjo7UahmvrwgK61r3mFexWN8IA7lOV8FgSU
X-Received: by 2002:a05:620a:19a4:b0:949:7656:ca0a with SMTP id
 af79cd13be357-949995b3446mr967706485a.35.1795076752456; 
 Thu, 19 Nov 2026 00:25:52 -0800 (PST)
X-Received: by 2002:a05:620a:19a4:b0:949:7656:ca0a with SMTP id
 af79cd13be357-949995b3446mr967703085a.35.1795076751880; 
 Thu, 19 Nov 2026 00:25:51 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:51 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:18 +0800
Subject: [PATCH v9 16/29] drm/msm/dpu: add per-stream MST encoders
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-16-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=5908;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=y5jRzeNla1e8Iwt1s5LRc06RYsVeZV4O7u84IZgL2qk=;
 b=YXb7dK2Y0C8iU3tKJ19krcBiKXjTJ99U7QeYpJcArJZQn2kMsv4+pys1oNx8gRqzWQ/VJK9UJ
 81EeLLxFd3+Ak2uIgdhANCJ0+p3imfZlKXhz7ZxJANYeFgQtTaIQwJ/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=b8UncdGx c=1 sm=1 tr=0 ts=6afeb291 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=aoVTMipVTiCx4Xnk7jUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5QlMcJcA6P6dxIgPf38z5lBU5rHdw7iS
X-Proofpoint-ORIG-GUID: 5QlMcJcA6P6dxIgPf38z5lBU5rHdw7iS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXyXv4jQhowBmW
 H1BsAOq+OhzjJ81HwWJfIOLW+N4biCH7r1yNsDe5XLCf70nQeZWMb6Q6wzhutjLPkqTVh8PcOVB
 A8HjEnU82GlntmanPunIb2kb3C4lV70=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX+pByXa9MUfx8
 Dbv4YBd3IH9QD/rkojuVZzlnVogwIjVdS2+iXUzYFuNJ0Dhg27UJR6kYv9TaJYpBsQ/ZQq6ryYh
 1apJJC2074A75hKPwcykWmvgmHNBOgLsqYz4wtlzys2rDD4GHRngbDFsjvThzlleEXTUofaS26f
 jfch4LuMLGWEPDskZ/g5VfqqvWbOq5YgdTXxAmk016YXJNxEanEiVYFbJHmVCGTdOKGmQfayRVu
 2hQg9/sbgsH02poccMnBTp8G3L18+sZo2zPs2AH7oErHO42Klrax6NPLMmrssAn7Ym3DkQt42Vs
 k0v5YC8T6dGMYmAlWwv+FwEttbteiDxt45/sPGgLo0Vus6eLUrS7L8WUj8RpIerrRk9DOF7qouG
 fePpsd3St5+sxSts2PAHrSqNh0hjwL4ZYCMZLBU+h55ZRR/m5LvJwPVTFn1B8EwE3ZhSAjFgvhv
 8aofK0I/6xmwSmKV8wA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

Unlike SST, where a DP controller is represented by a single encoder,
MST requires an encoder instance for each stream.

Create one DRM encoder per MST stream, associate it with a stream ID,
and initialize it with MST-specific encoder helper callbacks.

This establishes the per-stream encoder infrastructure required for DP
MST support.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 23 ++++++++++++++++++++++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c     | 15 +++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 20 ++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h         |  2 ++
 drivers/gpu/drm/msm/msm_drv.h               |  9 +++++++++
 5 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index a8dcc8c684eb..802cb62fc010 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2742,6 +2742,24 @@ static const struct drm_encoder_helper_funcs dpu_encoder_helper_funcs = {
 	.atomic_enable = dpu_encoder_virt_atomic_enable,
 };
 
+static void dpu_encoder_mst_atomic_enable(struct drm_encoder *enc,
+				      struct drm_atomic_commit *state)
+{
+	dpu_encoder_virt_atomic_enable(enc, state);
+}
+
+static void dpu_encoder_mst_atomic_disable(struct drm_encoder *enc,
+				       struct drm_atomic_commit *state)
+{
+	dpu_encoder_virt_atomic_disable(enc, state);
+}
+
+static const struct drm_encoder_helper_funcs dpu_mst_encoder_helper_funcs = {
+	.atomic_mode_set = dpu_encoder_virt_atomic_mode_set,
+	.atomic_enable   = dpu_encoder_mst_atomic_enable,
+	.atomic_disable  = dpu_encoder_mst_atomic_disable,
+};
+
 static const struct drm_encoder_funcs dpu_encoder_funcs = {
 	.debugfs_init = dpu_encoder_debugfs_init,
 };
@@ -2767,7 +2785,10 @@ struct drm_encoder *dpu_encoder_init(struct drm_device *dev,
 	if (IS_ERR(dpu_enc))
 		return ERR_CAST(dpu_enc);
 
-	drm_encoder_helper_add(&dpu_enc->base, &dpu_encoder_helper_funcs);
+	if (drm_enc_mode == DRM_MODE_ENCODER_DPMST)
+		drm_encoder_helper_add(&dpu_enc->base, &dpu_mst_encoder_helper_funcs);
+	else
+		drm_encoder_helper_add(&dpu_enc->base, &dpu_encoder_helper_funcs);
 
 	spin_lock_init(&dpu_enc->enc_spinlock);
 	dpu_enc->enabled = false;
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 3c3203ca32c7..92691d39dcb2 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -688,6 +688,21 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 				return rc;
 			}
 		}
+
+		for (int stream_id = 0; stream_cnt > 1 && stream_id < stream_cnt; stream_id++) {
+			info.stream_id = stream_id;
+			encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
+			if (IS_ERR(encoder)) {
+				DPU_ERROR("encoder init failed for dp mst display\n");
+				return PTR_ERR(encoder);
+			}
+
+			rc = msm_dp_mst_attach_encoder(priv->kms->dp[i], stream_id, encoder);
+			if (rc) {
+				DPU_ERROR("dp_mst attach_encoder failed, rc = %d\n", rc);
+				return rc;
+			}
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index a2900ff3b0ab..ef5fb70863b8 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -147,6 +147,26 @@ static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
 	return -1;
 }
 
+int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
+			      struct drm_encoder *encoder)
+{
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	struct msm_dp_panel *dp_panel;
+
+	dp_panel = msm_dp_display_get_panel(dp_display, stream_id);
+	if (!dp_panel) {
+		drm_err(dp_display->drm_dev,
+			"[MST] failed to allocate panel for stream %d\n", stream_id);
+		return -ENOMEM;
+	}
+
+	mst->mst_encoders[stream_id].enc = encoder;
+	mst->mst_encoders[stream_id].stream_id = stream_id;
+	mst->mst_encoders[stream_id].dp_panel = dp_panel;
+
+	return 0;
+}
+
 static struct drm_encoder *
 msm_dp_mst_atomic_best_encoder(struct drm_connector *connector, struct drm_atomic_commit *state)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 7f35e7524cfd..3cbd2a674675 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -9,5 +9,7 @@
 
 int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
 void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display);
+int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
+			      struct drm_encoder *encoder);
 
 #endif /* _DP_MST_DRM_H_ */
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 31ab50f620bc..cc665888ce7f 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -360,6 +360,8 @@ bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
 int msm_dp_mst_register(struct msm_dp *dp_display);
 void msm_dp_mst_unregister(struct msm_dp *dp_display);
+int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
+			      struct drm_encoder *encoder);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -406,6 +408,13 @@ static inline void msm_dp_mst_unregister(struct msm_dp *dp_display)
 {
 }
 
+static inline int msm_dp_mst_attach_encoder(struct msm_dp *dp_display,
+					    unsigned int stream_id,
+					    struct drm_encoder *encoder)
+{
+	return -EINVAL;
+}
+
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP4

-- 
2.43.0

