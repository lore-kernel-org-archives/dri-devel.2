Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B48CA5FAC
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFFE210ECBB;
	Tue, 29 Sep 2026 04:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="neNOHP8W";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbXEgET/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B43610ECC3
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47fhj4052905
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JVPFuH2DQkRwMnrIh/KSvlGPv4zX9Dc4RzW/ouSgoAw=; b=neNOHP8WLYdzeVLw
 kb1/2+yET551u1nqqvZYqoi06xw2sRfbzB+vYZLqa8ED4HE4yDsedzxtFbzjWX+N
 iUTE/KttezvndcLrRVEpkqb5xm0diQ3TyK5l0aOrTg3ZYYujuRw5RwDTdO0q77Py
 b6Va1gWjXMKezMyvbJ6KrAZd8TwGtyd9QTvrl44AYcCm5N7ua2hxveBwg1ujqh5i
 VjcZcGyIZKepLfyKEmlaLUwAXLzfQ5/2aennEibS03rIpJrEIl9u/juDG/2srOty
 kpr8cyaROW0iaQ5N26cOsRZst7HYBdeJuu/UpIqRmKioAnuPOanmia4cQ5zRzv81
 5e6jcw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg2fb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:12 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-9143a95c6b9so14029376d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656092; x=1791260892;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JVPFuH2DQkRwMnrIh/KSvlGPv4zX9Dc4RzW/ouSgoAw=;
 b=YbXEgET/wCurHnFOi3L0/MrAJjkjarWeOXbWsABpGexoR1OSEgBnavSRv/k253VTQk
 PBKVuXTcp6/JWLXfzeBOWc3pdTOLjo0W/15bsJS20oVNeTlcvWQRJv3U6v97rFCKpdz+
 9PjoY9L0AnOm197G+d3RdfAiKpmHZjgdo1gRsMJyIVRxRRsq/pBNFyicl2Dsrq+2QlQe
 GxqnQdBKjQPl+PGQigZ1GO0sWJvh5mFbiPYAbHUq61C4hJUsJcYutYutVlPES0/ff5i0
 QZzqRWVkgFrwk8VEKoVKz3Tv+OJygjVLCzh0P/WuxhhqTea5B/Rru2iv+vpqHFPhRPf7
 PVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656092; x=1791260892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JVPFuH2DQkRwMnrIh/KSvlGPv4zX9Dc4RzW/ouSgoAw=;
 b=hCHUgL94zDJALv8RwRowJVU8Ygs0ngnrRlMGN6cZzN0LLRcpT4UtsSJM8b4hV32aGi
 N8V4axBdj4vayN7/Wqvm+NoCu4ElPYHfSIQ2BK85fqexkSaA6PD54XHUR20VG1a8/ZFd
 73AiNJjWzha8rzXVv/Kc58X9YxezE0wBWs3k/KXkKV/zR0mYv4NBnhKieGIamhmRCAlJ
 P4qIF7zTZpoPz8QXmviKVOgde7yz4lq1Bup8LAl/X/uicx0EGd0+1055WhqQfYzntTIO
 YV5kaI++Xe5o37J7DCukqi4rsTdZJ7rLAhbO5hrLtKF9EbuqYfI7JwD1awQqeY/QWfjr
 HL6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxHtD9PpzGhu+0sIbGxIeqrnt7ot2wi0hFP78cDEuwOFXJhau7XBhJV9V6yX8Si1qeKECzXMfrdyqc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIdnuw4haaQdclcfacwQSOFnP48kfNnFzsKc6CMRgYslzL01M66
 fQCGmxo8iO/dKDWAjq2u6H2Ibu89OAHwNbk3Qf3og+/kky3na7Dep8NBVZOckk+UH62eq4WWbtn
 3ST4XFf2BIRmiP2SQPHnmyDQF0JKLXT+1CTewStQ2oszxqCk8YWu0DgGqol0vX8o7OgzNXiw=
X-Gm-Gg: AYBFou2RBIHFMmTOAADN42AOZMbU9La1m+wVVEdfozcfTy2tC3buX5ta90NOHAtTIGm
 1DtVmx5tGxZDL4yjhFlj8SH27thD8cJGS6j4xlw3YgWjmqDbx/4FaVTLv2UZrWUCKQOvdj6l6C1
 AH07AB1wIdsx4ua4yflFSGzNUDyAaXa5/o3Lsn5/e02hRHDbnYAYwSOHwe+FXSLPuOhwlU+E1gE
 ZQ/fuKeUqHTSIx1GVBtD5Jcarbl33O8XIN84wzgOImdxjGRPWIYNu0sJ9CqWlNN3SvE0Jql2Y5Q
 mMIWGXBwTd+Ol4Md1w2FNEIWoO1OuIy4k2bwUzpdjkUKCbkckeCetU/nWI2ekM+nPq2gLWDS2XN
 AgGDb3UmnXkl5YQIG404roMED7X2IblWToUfKSGRN9Yr/IatTuzFq31w5dJwOHuk=
X-Received: by 2002:a05:6214:398a:b0:910:3453:fc0 with SMTP id
 6a1803df08f44-91786490625mr24735766d6.16.1790656091810; 
 Mon, 28 Sep 2026 21:28:11 -0700 (PDT)
X-Received: by 2002:a05:6214:398a:b0:910:3453:fc0 with SMTP id
 6a1803df08f44-91786490625mr24735556d6.16.1790656091361; 
 Mon, 28 Sep 2026 21:28:11 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:11 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:46 +0800
Subject: [PATCH v7 22/35] drm/msm/dpu: add per-stream MST encoders
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-22-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=5908;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=wezbFnUlYwHSAdgz6OuNbhIHKZDuCPLdGEa0D+mcpPU=;
 b=d38Kjkqv3uyhb1W1EuXYnxxylfq+nfXcRfL1NOLPspJ1wgS9R49dtegJhpDri/sQANyF8eNvJ
 RtZcqyKIhtPBTed7NX+hG6FUVxr0WyXdh68EcMFtx3YhSq9hnNBeXT2
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX0DyG9YXnApTL
 ddUfscFaspSpUOUSPZflVh19v7bXNl7rDFALf95VhxcZ8IwfpMRbwC14R6QUdWYCfiWXEBbzS9u
 GIdt/woJu5Ih9P8fMbxE8LfgDmvINSU=
X-Proofpoint-GUID: hEOZpImFvCfhag8ZGh3nTxKLM7qgmgON
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXz94mjN/fR5l+
 21RVUA4morIu5llS4A6cKJnb2//6lRycr2nTJr2HjmpVBGL6hPd2okym0ZTo+xNADulNtEge8C7
 qAJDUdTJZg09z1m/TIGdK3xLsPSVcotTiu9gEloPc9XIW2wDVHvkF6y/n0zfv8jhcU1kviUbYyj
 sYkN+3VuGIKpuSX3DRwU1xrYlI4rXiN08Kh3tYRK3JU5HkY9+vhkX8/YCmZUZhMJYQ3hQzYuF8/
 CdhfKTxDiasnPXHuIhikVpaEkdYXRUG2jOEueazJx/nnL5TJ6w5GloTD/DqTIdGY67GO7oY0Fba
 BZjzO2sMLlNm936KAHidXzDNPKotgur8Jy5OwFbCw8D7+cZIZ+2F2PD7Qt1LMr2pjGsLNBnatC2
 gQI741YPK4Y1cpdjbgfgJH5Jj/FwCU+k3eDZgPXESXk8NUksRn8wlkK/4WrRCSvWFA68cx6h3QU
 qm49VXvDkCf5H0p5hCw==
X-Proofpoint-ORIG-GUID: hEOZpImFvCfhag8ZGh3nTxKLM7qgmgON
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3e5c cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=aoVTMipVTiCx4Xnk7jUA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

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
index 004d5fc460a8..533109b4365c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2744,6 +2744,24 @@ static const struct drm_encoder_helper_funcs dpu_encoder_helper_funcs = {
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
@@ -2769,7 +2787,10 @@ struct drm_encoder *dpu_encoder_init(struct drm_device *dev,
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
index 7ee4e7e4d34a..4e18026cdff0 100644
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
index 169b34f985c0..88687b97ed6e 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -145,6 +145,26 @@ static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
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
index b14f097ae8cc..2ada4a7c1c08 100644
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

