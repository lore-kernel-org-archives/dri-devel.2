Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858A606A33E
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J1vxiLkK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PtakQM8A
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B64310EDC0;
	Tue, 10 Nov 2026 04:56:08 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3904010EDC2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:55 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA49vDd2297594
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 j4YaO0ZYpT/FRxBM0qcc+7tzTgK+KPS5LT6PmLgtxE8=; b=J1vxiLkKB63GZxCA
 +bNgGcQyAHx9r84Oh4YCf5CCHL/V9NoOQUa9xEUjjnl332xs6tTdGU0r3mAqvRaX
 ElprVDRW2Lo0N/ytfWrtKrTqrueOAp5RKiKv2V8cOgDvUDzWGXRxn2ytH5obuFo6
 Xs7Tdv1v2QjP6W31r2C713iQf7oxA/S5TaBqT3n5g24sWXlTDFUOMk5jUNKnoARr
 3xqYgr651HCDRXgfWnnNSluOV8/RaLrpm7IoFn0YikM0gDuxmwRrmumCVTcev/g2
 bkfG+UfCXFa6iWW7mQ3QV/b1ZKtzAVcJiMgAf4xaixAAwEyJuo+ajDQIzXC7DS6Q
 YjXi+Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2n0hx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f6f4fe531so299856985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286554; x=1794891354;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j4YaO0ZYpT/FRxBM0qcc+7tzTgK+KPS5LT6PmLgtxE8=;
 b=PtakQM8AZcT1UeLrmotabndYZ1pDV5e2dM80W770mz+pMKfeW7pJNtO2pkrIxG1Y03
 ypaKFuJ4ZIeS/hDYLPEMc81kBQ7/+LSb1TPpseOp72lYbg7la5hq48RF6hzNEyf+ifZw
 CCtiiAWlIUilsNnuIr8u66/eJkUmVTa19LxygeUClgC7onTaE9BzdLbQOfawh6dn3lBa
 HwVkrshp2jcPQayRRufrwtd05WN+2ff2cTNyZwAAQHsydlhOPxsoNArF1DdPhSVEY7O8
 KmAiABXXXLJxP6l5JFFCof0mJDpcUZIx3K3l6ZVwROjVAOhKnQDxzSnnuYBj/3NgfJEy
 8QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286554; x=1794891354;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=j4YaO0ZYpT/FRxBM0qcc+7tzTgK+KPS5LT6PmLgtxE8=;
 b=zHI+MhQojEm1YDyrkirWZSJB1w3dfGmdVWXGLXmLJ11IYfvu76LkjcvawO0FMW9QU+
 GHr4NxY/aq5U+Tud6XsyNEGa7hHzPlYRNlu/HVeKJ1/50POzocwdhigOUZCKNNrJIh5R
 6eInbuppH+gP4muz8BHET6LUvl/Hejy3Trvx+SD0afIsH3ilAg+4afVkx/4icdv0/+rt
 oe2rnmk9zOz3RoCkHL0r/OPS5rc5Lm/JoE/kPbcomySathZN7D9yRVCXfLWagHZLmna2
 +cKnPZ6J6C/tX2wwoCY9k/TSsh/+0UcOz2t2BvlNsVddE6v5Iobvfgc4esjroAXkEjJm
 +mNQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE40937jaPdYANxLXlnq078FpeAJZC6ht6qP4CicvGJL9ynk8mzvou4Cs9gwRZcIT8YixbLzh5CM5Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dTiPwjBycnWbYhBIA4S9ZSfwWEYMTdeTeAl2KBznGOMwva3LU
 mYpkIoFNdJCMrAhlpeY6DY21sWrm5OYphaDUFiikKM1NBHnRsU8hfYVH3xq6q1MVjDG96B5qWCf
 ddEOyL2na99EH3vhvKjiYCoMXgZMpAEwmmyyRMgcjhpq4K7eCb4qNEq5zB3ufqk2+hJkUvV4=
X-Gm-Gg: AYBFou3cmCb8aJxSANHx/ZXyQg4aOEUvgb0C7VuonqZCyJOdkUiF3ZL/jA8wLCbGOUa
 Z9OeEtKKBiAJq88Sjj0G1ceQArzUCPHtTMpNRzG8rnFr1sJqt/RN9cGqi3ZAIONLNPjMIdNTSVC
 jAZccTH58jrcFAvQpLbqY0u6NFUyhtms76A6sH9+8l3NF6eEJ6JFSYW/ZfqcdEbIoXsSiHfCbN9
 mIu4dVv02hRuRtypyz/ZBpraJFMC2XvffPIeLt7/O/isUF+Rjy+arhRwxKKPPLx6XRZoFyddzWg
 Maf3uZ1OKUMTgSBQgcwJTesvYvBEXk5etDZVNwk7V1d2oeoe8e8Ppv7dXdb7lQzqVNsi/KRnM1U
 Rm6LGLR0aL5HRIpEawf14Jhnrpo8vA+epzonaEI/l5q1A2mH7bEtWeK8gqpXBfD7jqccCIvRW/K
 ++lsq76zjArannUsTtVYHK+ypcoM2yw2sv/BZ+
X-Received: by 2002:a05:620a:4692:b0:93f:2a95:a503 with SMTP id
 af79cd13be357-9479f3e3a74mr250381885a.67.1794286553582; 
 Mon, 09 Nov 2026 20:55:53 -0800 (PST)
X-Received: by 2002:a05:620a:4692:b0:93f:2a95:a503 with SMTP id
 af79cd13be357-9479f3e3a74mr250379585a.67.1794286553104; 
 Mon, 09 Nov 2026 20:55:53 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:52 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:37 +0800
Subject: [PATCH v8 16/29] drm/msm/dpu: add per-stream MST encoders
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-16-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=5908;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=y5jRzeNla1e8Iwt1s5LRc06RYsVeZV4O7u84IZgL2qk=;
 b=OMiZVYKrorqRLdXt0pB2BcKW+8Rfcnq1n5wPUzOTOnM+aq6+4uuxSnfetnEni0UVjZ5X5PpPq
 35lD1huP+QXDC2Kb6P3jggv2OVad2pJKwAsqN9aaUVc9WB5sfqv9W6E
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af2a3da cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=aoVTMipVTiCx4Xnk7jUA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXy7mukQVmqYT9
 8h59NSemJDBeOGaamqWX4801oQflZwxxcuDMGFThVc1HitDhmAPRwkHqp4aFC1e7wrOHcDIFBgU
 Sq+EOOmwm+gXRZSWZeL6x81ksESYPR5QhaF+vMzXvT+fNih1uBPAS6r0nMlUymyNi4jsItrnJ1n
 7JnWrY5zWPfugJek5OwrctF+fdWlS6ZUfnTMYC+tyLpsQJdKDjBNiPWNKZoYK9J6Cf2EFWWcMnJ
 BzowxKwK67tr6jekTZN0ImStjF/7t9UmsYyd8YzAEk455YYdLvMyOMX4C6VZyY+Llpdntqdyv5J
 hGPZK8mSgQHMO+aI8qf0ZtGHBl5GcMweg7lmuef8/VgAOl+crWLyhAR+RDGzHnA8twlK1mE7mLm
 eGYzQNhRRgbVA0n0+N0KbdZ2JHjrIaIDrbRMaFqNBAV0DTA2YCxCDUhJsYW0Z6xPcaQKWjI6lIs
 MkIvAP5OFXq1N+i1E0g==
X-Proofpoint-GUID: PDhKhpuhlOri3kdllsJCPjyLNd8hLqDD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX8jgKc2hBEcSV
 zma/STQrAY5b9D8ltjjIAdNBZQYBuCInLXw5s/7a8LaB/hf/bOXDJRKnAOExaJ6iqyvCFpWzGr/
 hhN0geND+KG3LNENt1G1PuNSVd60tdM=
X-Proofpoint-ORIG-GUID: PDhKhpuhlOri3kdllsJCPjyLNd8hLqDD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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

