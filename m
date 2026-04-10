Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE305E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF5410E92E;
	Fri, 10 Apr 2026 09:36:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XwD4BP5Y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYZ+q+N/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E6510E92D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:44 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A8bGEh115435
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 c/JQ4O1JtPDBy7JT5LgEbzoON2gdWQyDSPnNkHGbQrM=; b=XwD4BP5Y0L9alJSJ
 XEZJKsKLyngNJKVtJVBw8Db4qyJTWxlTAxjH6noBmte/QcYUyT0mCG8GP7vRYGFU
 0StFKSwbujW8by1FVvJHW15TTIZkcnJa2uvipVf7sqMo4dCRaM56HNTFesyUi8HP
 nui0tH+iwBdi/ZQ8QFc/1zaLf5kcdrY2unzFIWoEd/Pkmi3z+FtYZHpZvOrD0kmW
 F2hS0Q4/mcY5s9wwVWf3Y3IF+PJLA2OH1VUMU/j5W9LJ4ZzkK2p3VI5LYk75H0Wu
 zpQrwm2ksc07HOAbE39qY/1BFaQ2/3YlKMXCdSojO0tmuzK7L5sm7SLBSKBOPC5U
 CHNnCg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dee8xb951-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:43 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8950562d351so40713606d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813803; x=1776418603;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c/JQ4O1JtPDBy7JT5LgEbzoON2gdWQyDSPnNkHGbQrM=;
 b=aYZ+q+N/17+Fnh/NEOjAaSFFNU+BTjLPG6FlShfZVIjb30B5S2+jIhZRiD0cG0gtq6
 wOE6fpABRKUqAVQBkiuQpNhqiOLRjSfChHMPec3OvR6yrtlwABITS+GqCc518aZs2uVW
 SWSBHIUhtQ4x1o1kXePOu0BH/7yYEWIMz6om7btUyd/kCPHbqVTTAPndcotpBol9Qekc
 V6TnhN2xeLr7cVCW/fknt0UyDTCP+nGh0Svczs/gxkOQ3Lq7Obt4fD/+ijwDFWzFSC6X
 exqKXWj2gYe/x8UHaEHAZMQI4jwgr8DrrvK50suRQCmA77Bus5zaWomLc/Zw4fYrsCFA
 z3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813803; x=1776418603;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c/JQ4O1JtPDBy7JT5LgEbzoON2gdWQyDSPnNkHGbQrM=;
 b=K10Z0Jx9SlfVLMSB62AC05vBbvHTFMB7a8mwaIt7DDF8WELEbrCxWj+9sql23yozs/
 s9kOjMj/XMFf3KBHfqypFR6XGZeBhSdlUY5+rNZtIDo+WtfrK9myJ62NN8UssN47cGYO
 uPToU7uhrCFGivrVNMiWYoENmN6DxvlQoOh221I7bBZEeeixnngMg0c/t6PaHp4n1ecH
 Gld+6qGFGB5sjDBedmF9mmkIjWzDqnCVlKqCL68exsf/TlQs+a8P1kAlq3VUqEiG7YAz
 /yFxgHAjzVovpgCu5Z71N4A15sDmsfL6Li9bMMBQo2rVLPKEnfep2RI0014sXKInpeHb
 /i9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1WRocsGVrh6Wgdga5asRJorZ8MG4pa6kN5ccHSwAuMUigApZSZeaWTnvgcELQdzpwjhalfPPfZMQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwREQLVzxsoAu8yyp3BnN/wqzevBuoKx3AwXjtY3hhGI4DrmDTQ
 V4v536aEqMvSOBUV0YiXpAysJuSExDPhh/ElMpFtSU32RYVjaAaTzIJIjTuNGbXbYctaVmrsstu
 wPrBbGsc3p6mdke6N/Gsg7vdE77HnMDvcRTkAPACGWt6JqY6fuPgjko28iEROIA8p+WYaDXY=
X-Gm-Gg: AeBDieu18vNpI/k2oFw9iVRvsek4x4LwiFvjW0KLQQGZ+QGnPspkhbB4dgGWVSZyr+E
 mypyk0v/mjIFnzUn7LFFzzqGPM5FBkwQ2WB9jLxox0vwPo/hu6dhO1555ExIYpZ4zSVNyiaCwHU
 RTA+WDkr7DeqJo+NNJFYw28jKjp/rO9M8u5VvrU3WYZIjsTIZJ6YXPgANKcIycSHVrmODSBgyJD
 UoLb62mVSuXHONOVmPNinbEYZKkis9kVk8CYJX3wSMdsgfJD9zkKg3PUw/ZmrzYQ4bxfMa39dS6
 KGGWG+qrOuigGqVmQZ4L/cL1rY0qGXfDMoKopWVQ1Ndm3034925OBHD4iO6yqyOuQhpr+2jM5Cr
 iboN0uB5v6q6Q20FJvU2SJDd+za4Q6aBIyf7xSEMDMZPzHdvFDGjZpPCtnQnyQG4DvW4YtEbID8
 vOHLOS1iU=
X-Received: by 2002:ad4:574d:0:b0:89c:df61:7a06 with SMTP id
 6a1803df08f44-8ac862f56c6mr33040256d6.48.1775813802879; 
 Fri, 10 Apr 2026 02:36:42 -0700 (PDT)
X-Received: by 2002:ad4:574d:0:b0:89c:df61:7a06 with SMTP id
 6a1803df08f44-8ac862f56c6mr33039946d6.48.1775813802357; 
 Fri, 10 Apr 2026 02:36:42 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:42 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:09 +0800
Subject: [PATCH v4 34/39] drm/msm/dp: add dp_mst_drm to manage DP MST
 bridge operations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-34-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=18036;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=ZA0ZDHazW5mLfSOyJreDBYX+tdkXRc4M9BjgDDcv31I=;
 b=bH1LF3A1hbnaw1FlsgJBsySUzWNryp4VsT5r3PNmo/tL8238u+Qr2+DOAb3mFtsNjfVXwtoo+
 77EAl981zXxCD5P66EMQyLJlnNgTw/Ye+rOab2pNa6n/FmJDdj8OSQE
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX3zmrprlOQuW7
 V5sDeYJ8vXF7AyhBKmGUbFlYS+L0QY4RMKFW0alzQiqiuSrFYCZ4KOCixYWAqzsfm8XnP0otzle
 N0GYN/c23utV62GZnxX/9Y1A0+VRdgqL6yp1KIO6OcRwEZ9IoRU9hRGgQUIB4bR3BniPGUzOhw9
 7q9s+/Ukpv7SGaKXUxpm+NFpEAuGae3MQ0BMTbTe0pXyQdzrL3a8G3fdiPgR4FmAIX7ea+etHKV
 MqoweIRSFOOechQnZqBNE4Gv8EGw3FfaRNWn1bGZc6pv+JQxLqqja50CXjcZnXwpMhWJByl48DB
 4q7PKSwAvYp+eZ8Q5QObB7Jt5+KNEtG/A7kv/Qqu6FruO6fSgVcXo1+RqYavBH8zmGH+Np85naQ
 K6qFOxW9HGfqw3IQzAC/9f+HRcuu6zpGN8rfbnruDwDOlCtN5akPnyy5U2CPIC3gq8EhgTbz4R0
 X9Q+oh3oziWltTQs//w==
X-Proofpoint-GUID: S7bSnzVSbI3HEOq5t-Xkm3psfoQm9ZzH
X-Proofpoint-ORIG-GUID: S7bSnzVSbI3HEOq5t-Xkm3psfoQm9ZzH
X-Authority-Analysis: v=2.4 cv=O7YJeh9W c=1 sm=1 tr=0 ts=69d8c4ab cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=tQpwhndg4eEXWrdZBYkA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100089
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add dp_mst_drm to manage the DP MST bridge operations similar to the
dp_drm file which manages the SST bridge operations. Each MST encoder
creates one bridge and each bridge is bound to its own dp_panel
abstraction to manage the operations of its pipeline.

Keep the connector/panel association in bridge private state for atomic
assignment and release, and mirror it in the bridge object for runtime
bridge callbacks.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |   6 +
 drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 459 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_drv.h           |   7 +
 3 files changed, 471 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index d7ce13a4586d..89868443c0fe 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -692,6 +692,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 					DPU_ERROR("encoder init failed for dp mst display\n");
 					return PTR_ERR(encoder);
 				}
+
+				rc = msm_dp_mst_attach_encoder(priv->kms->dp[i], encoder);
+				if (rc) {
+					DPU_ERROR("DP MST init failed, %d\n", rc);
+					continue;
+				}
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index b6c7b8211025..4df3ea5e36d0 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -13,8 +13,47 @@
 
 #define MAX_DPCD_TRANSACTION_BYTES 16
 
+#define to_dp_mst_bridge(x)     container_of((x), struct msm_dp_mst_bridge, base)
+#define to_dp_mst_bridge_state_priv(x) \
+		container_of((x), struct msm_dp_mst_bridge_state, base)
+#define to_dp_mst_bridge_state(x) \
+		to_dp_mst_bridge_state_priv((x)->obj.state)
+#define to_dp_mst_connector(x) \
+		container_of((x), struct msm_dp_mst_connector, connector)
+
+#define DP_MST_CONN_ID(x) ((x)->connector ? \
+		(x)->connector->base.id : 0)
+
+struct msm_dp_mst_bridge {
+	struct drm_bridge base;
+	struct drm_private_obj obj;
+	u32 id;
+
+	bool initialized;
+
+	struct msm_dp *display;
+	struct drm_encoder *encoder;
+
+	struct drm_connector *connector;
+	struct msm_dp_panel *msm_dp_panel;
+};
+
+struct msm_dp_mst_bridge_state {
+	struct drm_private_state base;
+	struct drm_connector *connector;
+	struct msm_dp_panel *msm_dp_panel;
+};
+
+struct msm_dp_mst_connector {
+	struct drm_connector connector;
+	struct drm_dp_mst_port *mst_port;
+	struct msm_dp_mst *dp_mst;
+	struct msm_dp_panel *dp_panel;
+};
+
 struct msm_dp_mst {
 	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct msm_dp_mst_bridge *mst_bridge[DP_STREAM_MAX];
 	struct msm_dp *msm_dp;
 	struct drm_dp_aux *dp_aux;
 	u32 max_streams;
@@ -22,6 +61,419 @@ struct msm_dp_mst {
 	struct mutex mst_lock;
 };
 
+static struct drm_private_state *msm_dp_mst_duplicate_bridge_state(struct drm_private_obj *obj)
+{
+	struct msm_dp_mst_bridge_state *mst_bridge_state;
+
+	mst_bridge_state = kmemdup(obj->state, sizeof(*mst_bridge_state), GFP_KERNEL);
+	if (!mst_bridge_state)
+		return NULL;
+
+	__drm_atomic_helper_private_obj_duplicate_state(obj, &mst_bridge_state->base);
+
+	return &mst_bridge_state->base;
+}
+
+static void msm_dp_mst_destroy_bridge_state(struct drm_private_obj *obj,
+					    struct drm_private_state *state)
+{
+	struct msm_dp_mst_bridge_state *mst_bridge_state =
+		to_dp_mst_bridge_state_priv(state);
+
+	kfree(mst_bridge_state);
+}
+
+static const struct drm_private_state_funcs msm_dp_mst_bridge_state_funcs = {
+	.atomic_duplicate_state = msm_dp_mst_duplicate_bridge_state,
+	.atomic_destroy_state = msm_dp_mst_destroy_bridge_state,
+};
+
+static struct msm_dp_mst_bridge_state *msm_dp_mst_br_priv_state(struct drm_atomic_state *st,
+								struct msm_dp_mst_bridge *bridge)
+{
+	struct drm_device *dev = bridge->base.dev;
+	struct drm_private_state *obj_state = drm_atomic_get_private_obj_state(st, &bridge->obj);
+
+	WARN_ON(!drm_modeset_is_locked(&dev->mode_config.connection_mutex));
+
+	return to_dp_mst_bridge_state_priv(obj_state);
+}
+
+static void msm_dp_mst_update_timeslots(struct msm_dp_mst *mst,
+					struct msm_dp_mst_bridge *mst_bridge,
+					struct drm_atomic_state *state,
+					struct drm_dp_mst_port *port)
+{
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *payload;
+
+	mst_state = to_drm_dp_mst_topology_state(mst->mst_mgr.base.state);
+	payload = drm_atomic_get_mst_payload_state(mst_state, port);
+
+	if (!payload) {
+		DRM_ERROR("MST bridge [%d] update_timeslots failed, null payload\n",
+			  mst_bridge->id);
+		return;
+	}
+
+	if (payload->vc_start_slot < 0)
+		msm_dp_display_set_stream_info(mst->msm_dp, mst_bridge->msm_dp_panel,
+					       mst_bridge->id, 1, 0, 0);
+	else
+		msm_dp_display_set_stream_info(mst->msm_dp, mst_bridge->msm_dp_panel,
+					       mst_bridge->id, payload->vc_start_slot,
+					       payload->time_slots, payload->pbn);
+}
+
+static int msm_dp_mst_bridge_pre_enable_part1(struct msm_dp_mst_bridge *dp_bridge,
+					      struct drm_atomic_state *state)
+{
+	struct msm_dp *dp_display = dp_bridge->display;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(dp_bridge->connector);
+	struct drm_dp_mst_port *port = mst_conn->mst_port;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *payload;
+	struct msm_dp_panel *dp_panel = mst_conn->dp_panel;
+	int pbn;
+	int rc = 0;
+
+	mst_state = drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
+
+	pbn = drm_dp_calc_pbn_mode(dp_panel->msm_dp_mode.drm_mode.clock,
+				   (mst_conn->connector.display_info.bpc * 3) << 4);
+
+	payload = drm_atomic_get_mst_payload_state(mst_state, port);
+	if (!payload || payload->time_slots <= 0) {
+		DRM_ERROR("time slots not allocated for conn:%d\n", DP_MST_CONN_ID(dp_bridge));
+		rc = -EINVAL;
+		return rc;
+	}
+
+	drm_dbg_dp(dp_display->drm_dev, "conn:%d pbn:%d, slots:%d\n", DP_MST_CONN_ID(dp_bridge),
+		   pbn, payload->time_slots);
+
+	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
+
+	rc = drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
+	if (rc) {
+		DRM_ERROR("payload allocation failure for conn:%d\n", DP_MST_CONN_ID(dp_bridge));
+		return rc;
+	}
+
+	msm_dp_mst_update_timeslots(mst, dp_bridge, state, port);
+
+	return rc;
+}
+
+static void _msm_dp_mst_bridge_pre_enable_part2(struct msm_dp_mst_bridge *dp_bridge,
+						struct drm_atomic_state *state)
+{
+	struct msm_dp *dp_display = dp_bridge->display;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(dp_bridge->connector);
+	struct drm_dp_mst_port *port = mst_conn->mst_port;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct drm_dp_mst_atomic_payload *payload;
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+
+	mst_state = to_drm_dp_mst_topology_state(mst->mst_mgr.base.state);
+	payload = drm_atomic_get_mst_payload_state(mst_state, port);
+
+	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
+
+	drm_dbg_dp(dp_display->drm_dev, "MST bridge [%d] _pre enable part-2 complete\n",
+		   dp_bridge->id);
+}
+
+static void msm_dp_mst_bridge_pre_disable_part1(struct msm_dp_mst_bridge *dp_bridge,
+						struct drm_atomic_state *state)
+{
+	struct msm_dp *dp_display = dp_bridge->display;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(dp_bridge->connector);
+	struct drm_dp_mst_port *port = mst_conn->mst_port;
+	struct drm_dp_mst_topology_state *old_mst_state;
+	struct drm_dp_mst_topology_state *new_mst_state;
+	const struct drm_dp_mst_atomic_payload *old_payload;
+	struct drm_dp_mst_atomic_payload *new_payload;
+
+	old_mst_state = drm_atomic_get_old_mst_topology_state(state, &mst->mst_mgr);
+	new_mst_state = drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
+
+	old_payload = drm_atomic_get_mst_payload_state(old_mst_state, port);
+	new_payload = drm_atomic_get_mst_payload_state(new_mst_state, port);
+
+	if (!old_payload || !new_payload) {
+		DRM_ERROR("MST bridge [%d] _pre disable part-1 failed, null payload\n",
+			  dp_bridge->id);
+		return;
+	}
+
+	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
+	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, new_payload);
+
+	msm_dp_mst_update_timeslots(mst, dp_bridge, state, port);
+
+	drm_dbg_dp(dp_display->drm_dev, "MST bridge [%d] _pre disable part-1 complete\n",
+		   dp_bridge->id);
+}
+
+static void msm_dp_mst_bridge_atomic_pre_enable(struct drm_bridge *drm_bridge,
+						struct drm_atomic_state *state)
+{
+	int rc = 0;
+	struct msm_dp_mst_bridge *bridge;
+	struct msm_dp *dp_display;
+	struct msm_dp_mst_bridge_state *mst_bridge_state;
+	struct msm_dp_mst *dp_mst;
+	struct msm_dp_panel   *msm_dp_panel;
+
+	if (!drm_bridge) {
+		DRM_ERROR("Invalid params\n");
+		return;
+	}
+
+	bridge = to_dp_mst_bridge(drm_bridge);
+	mst_bridge_state = to_dp_mst_bridge_state(bridge);
+	dp_display = bridge->display;
+	dp_mst = dp_display->msm_dp_mst;
+
+	/* to cover cases of bridge_disable/bridge_enable without modeset */
+	bridge->connector = mst_bridge_state->connector;
+	bridge->msm_dp_panel = mst_bridge_state->msm_dp_panel;
+
+	if (!bridge->connector) {
+		DRM_ERROR("Invalid connector\n");
+		return;
+	}
+
+	msm_dp_panel = bridge->msm_dp_panel;
+	mutex_lock(&dp_mst->mst_lock);
+
+	rc = msm_dp_display_set_mode_helper(dp_display, state, drm_bridge->encoder, msm_dp_panel);
+	if (rc) {
+		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
+		mutex_unlock(&dp_mst->mst_lock);
+		return;
+	}
+	msm_dp_panel->pbn = drm_dp_calc_pbn_mode(msm_dp_panel->msm_dp_mode.drm_mode.clock,
+						 msm_dp_panel->msm_dp_mode.bpp << 4);
+	rc = msm_dp_display_prepare(dp_display);
+	if (rc) {
+		DRM_ERROR("[%d] DP display pre-enable failed, rc=%d\n", bridge->id, rc);
+		msm_dp_display_unprepare(dp_display);
+		mutex_unlock(&dp_mst->mst_lock);
+		return;
+	}
+
+	rc = msm_dp_mst_bridge_pre_enable_part1(bridge, state);
+	if (rc) {
+		DRM_ERROR("[%d] DP display pre-enable failed, rc=%d\n", bridge->id, rc);
+		mutex_unlock(&dp_mst->mst_lock);
+		return;
+	}
+
+	msm_dp_display_enable_helper(dp_display, bridge->msm_dp_panel);
+
+	_msm_dp_mst_bridge_pre_enable_part2(bridge, state);
+
+	mutex_unlock(&dp_mst->mst_lock);
+
+	drm_dbg_dp(dp_display->drm_dev, "conn:%d mode:%s pre enable done\n",
+		   DP_MST_CONN_ID(bridge), bridge->msm_dp_panel->msm_dp_mode.drm_mode.name);
+}
+
+static void msm_dp_mst_bridge_atomic_disable(struct drm_bridge *drm_bridge,
+					     struct drm_atomic_state *state)
+{
+	struct msm_dp_mst_bridge *bridge;
+	struct msm_dp *dp_display;
+	struct msm_dp_mst *mst;
+
+	if (!drm_bridge) {
+		DRM_ERROR("Invalid params\n");
+		return;
+	}
+
+	bridge = to_dp_mst_bridge(drm_bridge);
+	if (!bridge->connector) {
+		DRM_ERROR("Invalid connector\n");
+		return;
+	}
+
+	dp_display = bridge->display;
+	mst = dp_display->msm_dp_mst;
+
+	mutex_lock(&mst->mst_lock);
+
+	msm_dp_mst_bridge_pre_disable_part1(bridge, state);
+
+	msm_dp_display_disable_helper(dp_display, bridge->msm_dp_panel);
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+
+	mutex_unlock(&mst->mst_lock);
+
+	drm_dbg_dp(dp_display->drm_dev, "MST bridge:%d disable complete\n", bridge->id);
+}
+
+static void msm_dp_mst_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
+						  struct drm_atomic_state *state)
+{
+	struct msm_dp_mst_bridge *bridge;
+	struct msm_dp *dp_display;
+	struct msm_dp_mst *mst;
+
+	if (!drm_bridge) {
+		DRM_ERROR("Invalid params\n");
+		return;
+	}
+
+	bridge = to_dp_mst_bridge(drm_bridge);
+	if (!bridge->connector) {
+		DRM_ERROR("Invalid connector\n");
+		return;
+	}
+
+	dp_display = bridge->display;
+	mst = dp_display->msm_dp_mst;
+
+	mutex_lock(&mst->mst_lock);
+
+	msm_dp_display_atomic_post_disable_helper(dp_display, bridge->msm_dp_panel);
+
+	if (!dp_display->mst_active)
+		msm_dp_display_unprepare(dp_display);
+
+	bridge->connector = NULL;
+	bridge->msm_dp_panel =  NULL;
+
+	mutex_unlock(&mst->mst_lock);
+
+	drm_dbg_dp(dp_display->drm_dev, "MST bridge:%d conn:%d post disable complete\n",
+		   bridge->id, DP_MST_CONN_ID(bridge));
+}
+
+static int msm_dp_mst_bridge_atomic_check(struct drm_bridge *drm_bridge,
+					  struct drm_bridge_state *bridge_state,
+					  struct drm_crtc_state *crtc_state,
+					  struct drm_connector_state *conn_state)
+{
+	struct drm_atomic_state *state = crtc_state->state;
+	struct drm_connector *connector = conn_state->connector;
+	struct drm_dp_mst_topology_state *mst_state;
+	struct msm_dp_mst_connector *mst_conn;
+	struct msm_dp_mst *mst;
+	int rc = 0, pbn, slots;
+	struct msm_dp_mst_bridge_state *mst_bridge_state;
+	u32 bpp;
+
+	if (!drm_atomic_crtc_needs_modeset(crtc_state) || !crtc_state->enable)
+		return 0;
+
+	mst_conn = to_dp_mst_connector(connector);
+	mst = mst_conn->dp_mst;
+
+	bpp = connector->display_info.bpc * 3;
+
+	if (!bpp)
+		bpp = 24;
+
+	pbn = drm_dp_calc_pbn_mode(crtc_state->mode.clock, bpp << 4);
+
+	mst_state = to_drm_dp_mst_topology_state(mst->mst_mgr.base.state);
+	if (IS_ERR(mst_state))
+		return PTR_ERR(mst_state);
+
+	if (!dfixed_trunc(mst_state->pbn_div)) {
+		mst_state->pbn_div =
+			drm_dp_get_vc_payload_bw(mst_conn->dp_panel->link_info.rate,
+						 mst_conn->dp_panel->link_info.num_lanes);
+	}
+
+	slots = drm_dp_atomic_find_time_slots(state, &mst->mst_mgr, mst_conn->mst_port, pbn);
+
+	drm_dbg_dp(drm_bridge->dev, "add slots, conn:%d pbn:%d slots:%d rc:%d\n",
+		   connector->base.id, pbn, slots, rc);
+
+	if (!conn_state->crtc)  {
+		mst_bridge_state = msm_dp_mst_br_priv_state(state, to_dp_mst_bridge(drm_bridge));
+		mst_bridge_state->connector = NULL;
+		mst_bridge_state->msm_dp_panel = NULL;
+	}
+
+	return 0;
+}
+
+/* DP MST Bridge APIs */
+static const struct drm_bridge_funcs msm_dp_mst_bridge_ops = {
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state   = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset           = drm_atomic_helper_bridge_reset,
+	.atomic_pre_enable   = msm_dp_mst_bridge_atomic_pre_enable,
+	.atomic_disable      = msm_dp_mst_bridge_atomic_disable,
+	.atomic_post_disable = msm_dp_mst_bridge_atomic_post_disable,
+	.atomic_check        = msm_dp_mst_bridge_atomic_check,
+};
+
+int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder)
+{
+	int rc = 0;
+	struct msm_dp_mst_bridge *bridge = NULL;
+	struct msm_dp_mst_bridge_state *mst_bridge_state;
+	struct drm_device *dev;
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	int i;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		if (!mst->mst_bridge[i]->initialized) {
+			bridge = mst->mst_bridge[i];
+			bridge->encoder = encoder;
+			bridge->initialized = true;
+			bridge->id = i;
+			break;
+		}
+	}
+
+	if (i == mst->max_streams) {
+		DRM_ERROR("MST supports only %d bridges\n", mst->max_streams);
+		rc = -EACCES;
+		goto end;
+	}
+
+	dev = dp_display->drm_dev;
+	bridge->display = dp_display;
+	bridge->base.encoder = encoder;
+	bridge->base.type = dp_display->connector_type;
+	bridge->base.ops = DRM_BRIDGE_OP_MODES;
+	drm_bridge_add(&bridge->base);
+
+	rc = drm_bridge_attach(encoder, &bridge->base, NULL, 0);
+	if (rc) {
+		DRM_ERROR("failed to attach bridge, rc=%d\n", rc);
+		goto end;
+	}
+
+	mst_bridge_state = kzalloc(sizeof(*mst_bridge_state), GFP_KERNEL);
+	if (!mst_bridge_state) {
+		rc = -ENOMEM;
+		goto end;
+	}
+
+	drm_atomic_private_obj_init(dev, &bridge->obj,
+				    &mst_bridge_state->base,
+				    &msm_dp_mst_bridge_state_funcs);
+
+	drm_dbg_dp(dp_display->drm_dev, "MST drm bridge init. bridge id:%d\n", i);
+
+	return 0;
+
+end:
+	return rc;
+}
+
 int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
 {
 	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
@@ -49,11 +501,16 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
 		return -ENOMEM;
 
 	memset(&msm_dp_mst->mst_mgr, 0, sizeof(msm_dp_mst->mst_mgr));
-
 	conn_base_id = dp_display->connector->base.id;
 	msm_dp_mst->msm_dp = dp_display;
 	msm_dp_mst->max_streams = max_streams;
 
+	for (int i = 0; i < DP_STREAM_MAX; i++) {
+		msm_dp_mst->mst_bridge[i] =
+			devm_drm_bridge_alloc(dev->dev, struct msm_dp_mst_bridge, base,
+					      &msm_dp_mst_bridge_ops);
+	}
+
 	msm_dp_mst->dp_aux = drm_aux;
 
 	ret = drm_dp_mst_topology_mgr_init(&msm_dp_mst->mst_mgr, dev,
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 5f73e0aa1c2f..03bedd15fe02 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -364,6 +364,8 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
 int msm_dp_mst_register(struct msm_dp *dp_display);
+int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder);
+
 #else
 static inline int __init msm_dp_register(void)
 {
@@ -390,6 +392,11 @@ static inline int msm_dp_mst_register(struct msm_dp *dp_display)
 	return -EINVAL;
 }
 
+static inline int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder)
+{
+	return -EINVAL;
+}
+
 static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
 {
 }

-- 
2.43.0

