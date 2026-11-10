Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83160A261A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eZf7kGCA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=atTW3z1F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7968310EDBC;
	Tue, 10 Nov 2026 04:55:48 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED93B10EDBC
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:36 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A8nT679653
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5RbNlYp2ZfCh4PdNTYcfUJm9GR1BwtZ8U90BIq8EMQY=; b=eZf7kGCACuq47kgi
 J4NdqWjMvwbwvaDyH7fdPxszvAs1hbRLwahq9IdCCZmFhve8gjJ3ZkORmYuWYZP2
 Iq2m2KNLuzyx/sec7SQcB+HsymixfV0LARLcpZOKRvKBBnNCBKOTLcLsH8tqpuwH
 oE2L0TA/JfCE8zJ6dkqkqhHgfysm5f8qFY1eaZ23vrpgIgknBzNqUq9xHhsIkKI4
 Hr1/UePMogYyRkxHREyfKD4J+vSUzzsduRFPvQbk+Ww85fXJxzNbyIDTqzzwEvvS
 bo5DCFspkP2l8g7dUjVh0xpnCaCenp/EovEedSqBg8DQbxDKmc+xdrO58x/ysYq0
 zmiJPQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hutv48d39-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f3969a2a7so275568885a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286535; x=1794891335;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5RbNlYp2ZfCh4PdNTYcfUJm9GR1BwtZ8U90BIq8EMQY=;
 b=atTW3z1FVIRRK6vnhiFyiRnl3O6QtC98VgBIOs4wI9yKMlvS0vhiuX4ri5JwFA2mbE
 HL6V2sZaNHsd/xD9/tcAOM94Yq2BzWS3HT7CtcUVh48JgFxAkmSj1/oEiWU4PKEkjjry
 T5U+XFQ4g0gf3Gk3iBmu40CUJnmW1hxNtJtSYDYLFJqD5n6mQOYSiOJFEPn5th22WQ+O
 KGZcE6TJzm6lNMrFPsGE1PAY2kbK34yhiHAFeIlE0FO5II5UZalWClvMYW1ihBxvH4gc
 EGkPR5AbYh+wBEZs5CBouSlNO+q9hOQekMYo1GVoS41kW+bGIQVrcixAjrXWnNwNCBNj
 jCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286535; x=1794891335;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5RbNlYp2ZfCh4PdNTYcfUJm9GR1BwtZ8U90BIq8EMQY=;
 b=N/iLwfpLdqTdMpfVW4bDXQBpNuM5GyjfZqRjpuRTTG/xxt7hj29FFVoKf7gxhfDbhb
 eMLp+b0FIs81R64Eftxs2kilwALnzc+BmWpiSLINeKuViPubXWjPeaJitZY+0OHrdBw8
 CYFJaAZDWYweAHc56vfXgLdBNvzjv1p/xMd7gWatvyogUt0XwkcqFmveIrftO+3tFkIN
 J3HLfoGeH4gAW9Chtu5+KEOutK8NiKHwEWckHw8LP1To//Te98HP8sxg+mVv6JP45TcU
 D+UpowZsKIQJ683gGIEqQ+DfRBX1OgN8JeF3z9y/QSZCprjCda4VBNmpYzeFSKAbn3i9
 Nbyw==
X-Forwarded-Encrypted: i=1;
 AL+hErF3i8iS0hD6yIw3rg1OnEm2+B3aWW+YYmaPowq2Jyvrjemjr5SxUcsFovy7BBYdQLtutepnei1LYTM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/NhMsm8f7TMsuPZJNVtgV4rSWcXufJrpMpQYf0ar1eYD7xiuRd
 WH6if3o48eeQ6B6Rhp8DDa/iq3oi54Y1GL29RoT5eRN05CDeZd5jhZV1S5ouuAsj34R4TTM1nAi
 6wIo2p/alnZwFOacyrgdgqN2rNXHjR8RleaYotJ3ercOGbnf1lXtdglLonna/t+GbV1LbYFQ=
X-Gm-Gg: AYBFou2jzT6lFpGi+X3vjZUmwDoVV4bSNFa68moyyQm4XEQK5OgqHJpqyvCYy8x0+LG
 z8gETNkOxEGlODEfCpPeay5E7sAqezOM1QN5MO+r+5/8JPW9+SKFZRTjEMzTD7Fxos360FhByuu
 MjaEaon+EbPSsGMBKp0v2VBT4tNlj26s7nokUZ9pQzEyvnTvx0SVMg9lo1ZarsyJRgmA4oxLWCz
 lMINxmxmT5z+NauCnQjG9+p0oGKICjqCBre/FqXcamSN/9zc4D2z/9HNpe+A7etlCwkNPaNCj21
 YvyHqoyRzIQu3b3XfU0FeYgpy1Odvh66nkkDvCfcHrfIOG2AhUSxXttWfDx8Vm4vnoDRi9BdwYT
 kYZ6ul38h3RBNyysiaTZKjMwtdRlC+4Ebk/r8edh/Y+L7nlNvSrxcyYvAwF1yoUB93cckBfW7Vc
 qOfsxI5ZvVNtfrKAAii2oYRQ==
X-Received: by 2002:a05:620a:17ac:b0:93e:f930:5ed1 with SMTP id
 af79cd13be357-9479f3c0060mr251785685a.82.1794286534924; 
 Mon, 09 Nov 2026 20:55:34 -0800 (PST)
X-Received: by 2002:a05:620a:17ac:b0:93e:f930:5ed1 with SMTP id
 af79cd13be357-9479f3c0060mr251782785a.82.1794286534298; 
 Mon, 09 Nov 2026 20:55:34 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:33 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:33 +0800
Subject: [PATCH v8 12/29] drm/msm/dp: introduce dp_mst_drm module
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-12-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=8782;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=XXHhh/D27K05twrafiTIO3+Qqt/7/RKsGc8JoccfP1w=;
 b=nvncelDlFwbA0GepCEBy1W/mWB95jWvWriZqH9T6q8ghmDDY4y+mROXovU8NvvoahuB/ps5mU
 jS7IQJiizxEDghMPHjtkFXacWnHfL68f00LZifoQgEyBZUtxtr/9ND2
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX++N2Uoh86DLI
 vH+sbCbc5lP1SjYtY3g5NxF6Sh5uIZoXG0PFeuAa1Y5rYWDO0+ypP31EfKa9YMEaiK0YkO2KUZ5
 nvRT9fKkFHHI2ewC7gnDtjSJtmBKwSs=
X-Proofpoint-ORIG-GUID: e1txLZISxy0kySMoYA4phGolfVQsw_aI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX+gHcwdmszrXM
 Y4i5RjD0fHh+rYMaeUKRTGNWot8XG4n5i7C5lHUc9LLSIbqSyMHmadROjChZgP8Zw+9s9mbvMHI
 VMLejr+aTm4N7kutzOZnbi+irmF8WIru4oSSUdWgo+5ZqAljG6gsUZYqoHbamzsSWzb24WFBKIX
 14rVVrrdqWGER1pWQ2PihBGPrRX5smDvAEaj/Gyk06En6b+z82KN+YhjUJcMcYdgsfGq6+hqy0i
 tTKnNH1e3mafZ5EUX21DpXj5RAygnXkrK9A7Vbg1bOf0ngPRKLOGhPP9fhmxyRbt6TbQZbS7QrR
 wnsOnkqRBAC8wz4D7Sq2MIvh1y0uLDz+UuKFtjmMo+WK73AAY+jMu0ioMdxLWd3G89KdaFWHt6E
 csGNvEuMFJ7a22pwSO46+zMJVZJ0elThOg6ztD55SGW+2iaX9PcLQ3aQ6jcUSVhZ1vi9doNp+0T
 Q6I38OoLJn+EZwKBYhw==
X-Authority-Analysis: v=2.4 cv=B54sQ+tM c=1 sm=1 tr=0 ts=6af2a3c8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kqK9UwV0UgyvWCtWq9kA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: e1txLZISxy0kySMoYA4phGolfVQsw_aI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
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

Add the dp_mst_drm module and the core MST manager data structures.

Introduce the MST manager object, per-stream encoder state and the
initialization path for creating a DRM MST topology manager associated
with a DP controller.

Also add the registration hooks used to initialize the MST manager
during DP device setup.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile            |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 22 ++++++++++-
 drivers/gpu/drm/msm/dp/dp_display.c     | 27 +++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h     |  5 +++
 drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 67 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h     | 13 +++++++
 drivers/gpu/drm/msm/msm_drv.h           | 17 +++++++++
 7 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 1e246616f83f3..48640d9bf7cb5 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -147,7 +147,8 @@ msm-display-$(CONFIG_DRM_MSM_DP)+= dp/dp_aux.o \
 	dp/dp_link.o \
 	dp/dp_panel.o \
 	dp/dp_audio.o \
-	dp/dp_utils.o
+	dp/dp_utils.o \
+	dp/dp_mst_drm.o
 
 msm-display-$(CONFIG_DRM_MSM_HDMI_HDCP) += hdmi/hdmi_hdcp.o
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc2..3c3203ca32c76 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -655,7 +655,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 	struct msm_display_info info;
 	bool yuv_supported;
 	int rc;
-	int i;
+	int i, stream_cnt;
 
 	for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++) {
 		if (!priv->kms->dp[i])
@@ -678,6 +678,16 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
 			return rc;
 		}
+
+		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
+
+		if (stream_cnt > 1) {
+			rc = msm_dp_mst_register(priv->kms->dp[i]);
+			if (rc) {
+				DPU_ERROR("dp_mst_init failed for DP, rc = %d\n", rc);
+				return rc;
+			}
+		}
 	}
 
 	return 0;
@@ -905,6 +915,8 @@ static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 static void dpu_kms_destroy(struct msm_kms *kms)
 {
 	struct dpu_kms *dpu_kms;
+	struct msm_drm_private *priv;
+	int i;
 
 	if (!kms) {
 		DPU_ERROR("invalid kms\n");
@@ -913,6 +925,14 @@ static void dpu_kms_destroy(struct msm_kms *kms)
 
 	dpu_kms = to_dpu_kms(kms);
 
+	if (dpu_kms->dev) {
+		priv = dpu_kms->dev->dev_private;
+
+		for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++)
+			if (priv->kms->dp[i])
+				msm_dp_mst_unregister(priv->kms->dp[i]);
+	}
+
 	_dpu_kms_hw_destroy(dpu_kms);
 
 	msm_kms_destroy(&dpu_kms->base);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index fa027659a079f..9449ef692189c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -28,6 +28,7 @@
 #include "dp_drm.h"
 #include "dp_audio.h"
 #include "dp_debug.h"
+#include "dp_mst_drm.h"
 
 static bool psr_enabled = false;
 module_param(psr_enabled, bool, 0);
@@ -1286,6 +1287,32 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 	return 0;
 }
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return msm_dp_ctrl_get_stream_cnt(dp->ctrl);
+}
+
+int msm_dp_mst_register(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return msm_dp_mst_mgr_init(msm_dp_display, msm_dp_ctrl_get_stream_cnt(dp->ctrl), dp->aux);
+}
+
+void msm_dp_mst_unregister(struct msm_dp *msm_dp_display)
+{
+	if (!msm_dp_display->msm_dp_mst)
+		return;
+
+	msm_dp_mst_mgr_destroy(msm_dp_display);
+}
+
 static int msm_dp_display_probe(struct platform_device *pdev)
 {
 	int rc = 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 96be45c3dc923..7b6d76f33ac61 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -24,6 +24,8 @@ struct msm_dp {
 	unsigned int connector_type;
 	bool is_edp;
 
+	void *msm_dp_mst;
+
 	struct msm_dp_audio *msm_dp_audio;
 	bool psr_supported;
 };
@@ -59,6 +61,9 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
+int msm_dp_mst_register(struct msm_dp *msm_dp_display);
+void msm_dp_mst_unregister(struct msm_dp *msm_dp_display);
 struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 					      enum msm_dp_stream_id stream_id);
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
new file mode 100644
index 0000000000000..5d22aa34c521c
--- /dev/null
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <drm/drm_edid.h>
+#include <drm/drm_fixed.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
+
+#include "dp_mst_drm.h"
+#include "dp_panel.h"
+
+struct msm_dp_mst_encoder {
+	struct drm_encoder *enc;
+	int stream_id;
+	struct msm_dp_panel *dp_panel;
+};
+
+struct msm_dp_mst {
+	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct msm_dp_mst_encoder mst_encoders[DP_STREAM_MAX];
+	struct msm_dp *msm_dp;
+	struct drm_dp_aux *dp_aux;
+	u32 max_streams;
+};
+
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
+{
+	struct drm_device *dev = dp_display->drm_dev;
+	struct msm_dp_mst *mst;
+	int ret;
+
+	mst = kzalloc_obj(*mst);
+	if (!mst)
+		return -ENOMEM;
+
+	mst->msm_dp = dp_display;
+	mst->max_streams = max_streams;
+	mst->dp_aux = drm_aux;
+
+	ret = drm_dp_mst_topology_mgr_init(&mst->mst_mgr, dev,
+					   drm_aux,
+					   16,
+					   max_streams,
+					   dp_display->connector->base.id);
+	if (ret) {
+		drm_err(dev, "[MST] topology manager init failed\n");
+		kfree(mst);
+		return ret;
+	}
+
+	dp_display->msm_dp_mst = mst;
+	return 0;
+}
+
+void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display)
+{
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+
+	if (!mst)
+		return;
+
+	drm_dp_mst_topology_mgr_destroy(&mst->mst_mgr);
+	dp_display->msm_dp_mst = NULL;
+	kfree(mst);
+}
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
new file mode 100644
index 0000000000000..7f35e7524cfdd
--- /dev/null
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DP_MST_DRM_H_
+#define _DP_MST_DRM_H_
+
+#include "dp_display.h"
+
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
+void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display);
+
+#endif /* _DP_MST_DRM_H_ */
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 2840e8a5052d7..31ab50f620bcd 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -357,6 +357,9 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_displa
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
+int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
+int msm_dp_mst_register(struct msm_dp *dp_display);
+void msm_dp_mst_unregister(struct msm_dp *dp_display);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -389,6 +392,20 @@ static inline bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
 	return false;
 }
 
+static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
+static inline int msm_dp_mst_register(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
+static inline void msm_dp_mst_unregister(struct msm_dp *dp_display)
+{
+}
+
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP4

-- 
2.43.0

