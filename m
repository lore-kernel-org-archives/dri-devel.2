Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38937C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C31D10E92F;
	Mon, 29 Jun 2026 14:17:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="P2wTpEwj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ULJhPohU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5742A10E936
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATCO02647678
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DAKaqJFhKPCGDQ3R8sGusebfry2IODdhGk4iYzmSg8E=; b=P2wTpEwjhb28cgQQ
 A94F6y0ygsFRnrrKKEwX/TR5J11JGOUa/Di8nFe2oHHEPPljRSj5M4Y1s0rlE5el
 eyvdzk+zIS3MIgT2NmRydTxiz2d388rp7TjFkgzkI8ZxUxc5RV1fdMvcJcfR9AJ1
 3zv6tScADrAeANS69QW3+UhqQrjjKgCIsrB5NOPhR9mFBCwwWOMIYqyTvJ4+mm5F
 +VtythobCR5GuzQFt9TyjLhRhExrb7MkI/HRA6sj2r+Biu0wxPiHnzTWwz8RsrFJ
 +zusx7m4JgLS9a01TU3urh/vmTH2BKZLwOgr9eiREnwxPHdJnbPXrYgM8tOG2aeJ
 CB/zdg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhp5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ae405b5eeso425539585a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742628; x=1783347428;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DAKaqJFhKPCGDQ3R8sGusebfry2IODdhGk4iYzmSg8E=;
 b=ULJhPohUpITSgg2c/3HYlMOnNb2yUA1qPYjJYoawO8gI8MBwK69ZiE6A0/+YP3yiJA
 z1N6cVmQ54o0M+x5bJYBiZbnn9qmgRzY/lIsAD1kWOQRn/yaHhCyWoeaSF5choOf/ibD
 9FXfR2gnN3aaY+iSxefHJ8kMTyPtSTY8nEQPS99VtK4Mo5HMGYjjTDtxsVHHtYlFwmTS
 UTS+CDa9qW3063oFU9HAEAeOHYBzxxum+sSupeW2kGwN8l/HzKnAHpxUzvAtDvaET290
 BygvAGCpfSTPhvqGzI2BrXLKNDXep7zieo4KyGjRd+65fAizXkWACKUrbjUufCwAXO8p
 Ah1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742628; x=1783347428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DAKaqJFhKPCGDQ3R8sGusebfry2IODdhGk4iYzmSg8E=;
 b=ORIg7NLpDZiaN3ghH8sskOQI8jjlrIyg3xwexs1Bg8oSd2j9DL44VChgmKd11dwGRf
 squDhwB+oElDKrjEr3Xqtz1ZWj+HNw0hbpYhXXtRTDLD98pW8TMIHrV0PDLZb5bQO39f
 gxFVBtZ2+n2AKiAqYwPPTyd2i3I1TLQloAhgh7crgY/YhRFJQqHhR2MCHih3p2l2Lek6
 LWJ06hTRFru7Lva2tMaAes5sZVCsLDrQ7T7dehV+sLjjbQ6eoh2f+l/qI4JfL57UFAld
 JhAWFVfF67uED9dmnD906KEcUsJLXDJZGSVSJxEt7zIFGZ3EqNHHJvYCLm5Cl6Z2NUKL
 W7Tw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/yj2t25oEyzNKcsPk5OcCBlNazJa5QyGsU7IKoI0yWFzZy+CnrAY6aCpWdKolWesXex9wp69tAeFQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxZzCOTNXlxUOwwvwjTNCYdNDN1Wz7YFyC+UQE+rM6JuuoHFnCi
 TX77ACdj9LG5XV8VZWQOulZlkX4UGj2+DQI5M3bEy9hEMaU0bc992MhJ2zrDP4l7oyPdC8d6H95
 DYpEG6TkakcOagWLXRLVGUG7Fj91R0TM3nZyCIwtO9JQg7hu64MAy71Uglvq8qcAoJAdRLR4=
X-Gm-Gg: AfdE7cmEk9y/2rkVdjXZtiZo1/I0C7aiRRty+NSERGsWz3iIZdoQBuDir+OvTAtiJnw
 Ztn5w+UsOIx1DN1zhI4nJgEoAbdQfuLh7DjVsBVDWTGi0gR+DnIHUdAxs2P9GbC1++bkROVw9wy
 fmUKB62vzyHg4QyKRJXX6NlPmEtA7ArNWKlp58MbPvg1BM3n020kaEXjet6RI9zAuSxYlqMytYQ
 oe46Ore4SpIfJZjRxT5MCtfMqSc4tXF3GneBy43T8XtFSsr894fddlbFSyTeL4COdq2oDImFKsp
 UL7qzSm0xfiQ57whwtlpXFWLxACm+jYOrtXpLUTzMGkIAEJsEkxbOOBIB8IxrHHPMfq1MyXk3fK
 jRHiEQ6psOZTRUOEsJdqmXgN8xTZzvaL8crCZnmKo61jq9GH/xIdmMp7y6AB2qhsxg4m/PQ==
X-Received: by 2002:a05:620a:a193:10b0:92b:6805:91a2 with SMTP id
 af79cd13be357-92b680594b8mr1017591585a.74.1782742627364; 
 Mon, 29 Jun 2026 07:17:07 -0700 (PDT)
X-Received: by 2002:a05:620a:a193:10b0:92b:6805:91a2 with SMTP id
 af79cd13be357-92b680594b8mr1017586085a.74.1782742626646; 
 Mon, 29 Jun 2026 07:17:06 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.17.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:17:06 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH RESEND v5 23/25] drm/msm/dp: add dp_mst_drm to manage DP MST
 encoder operations
Date: Mon, 29 Jun 2026 22:14:44 +0800
Message-ID: <20260629-msm-dp-mst-v5-23-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=13405;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=8Q0kaRXdJPFTHOcwRknvKY1GOQFvstfIBVRZDBLDPzg=;
 b=B4J+q46lV8xP4CI7gkndX7lKxkZ49Y7QsTY3sjZKtnNb0qF3vgBhomFvlYbKn5SzE4KJ3uAWa
 8Oc+Pb1sl6cDtAs5rsVSfUTunST41qlfonu0Odcjy0/K75yKAYz/vOz
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: OBIemY7fsPDaK7E7hkWE60vgFcPpR5rw
X-Proofpoint-ORIG-GUID: OBIemY7fsPDaK7E7hkWE60vgFcPpR5rw
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a427e64 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9C1gJ3GtsS6FW9a-24MA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX2GOxSN4ivi1g
 qKYXNUNYgT+jVgngvgccc1f+GlIJ6F4GQZzVicfafE5nIvwOeZ57u4bRrjFgJSgZOwRFZ4zZqZ8
 6TA4BbNuyCTHXnfITyxw1momK+Z8IhM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX/6op5yEcPa8c
 IhcWtysw0DTlMnqe+pc/4B/F8AwKRENw/zz1wTRrsGqLjST8tjCgPEDEFqvhRYzxBwayDaOO5LJ
 7lpfSCBE8ak7cPzMQMown4XxIek0XQ1Jui19JtWlbfgYjiY5lF6SyK/7j9Ice1cgdJCgb2+r2NH
 dqzJWkq6PMLHQlebn2v3CAp4w+jDd9/JGoxMz8qTEIhXvdaqZziHa66xX5T0jSiqV/0Sei/3VUs
 Jy9qxQyGSqDuPdyHGyKH+oVuGd8UTisUpdfEoECwyPnJ1UftxJaMsWRHxJUBIqIX6yxyTGnh0BY
 oKAtCfSbcB8Qk65uPt6bSo60sxh/SJ0Ci5KWEr33hjajIRrn4v39/kxwsNRpEDLbgsYqmMjScAU
 0XrUekMZHXprGg1MJ4iwC2V7YL06YJdFyYoKCx8HFntbYKg3pPnUV6OmGkkdD+8LhPbi94k7ZoA
 iNH/oSXafKBl5RaGuHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

drm/msm/dp: introduce dp_mst_drm for MST stream management

Add a dp_mst_drm layer to manage DP MST streams with a clear ownership
model between encoder, panel and connector.

Each MST stream is represented by a dedicated drm_encoder. At modeset
initialization time, one (encoder, dp_panel) pair is created per
stream_id and remains fixed for the lifetime of the driver. The
dp_panel thus carries a stable stream context, including stream_id
and pixel mapping.

MST connectors are created and destroyed dynamically on hotplug and
are attached to a dp_panel through atomic routing. During an atomic
commit, connectors are associated with encoders via
atomic_best_encoder(), forming a temporary binding for the duration
of the commit.

Encoder helper callbacks drive the MST stream lifecycle, including
timeslot allocation, link enable/disable and payload programming.

A per-MST-instance lock serializes operations on shared link state
across multiple streams.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |   6 +
 drivers/gpu/drm/msm/dp/dp_display.c     |   9 ++
 drivers/gpu/drm/msm/dp/dp_display.h     |   2 +
 drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 245 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_drv.h           |   7 +
 5 files changed, 269 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index b32ecd5b0777..ac5dc844fead 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -696,6 +696,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 					DPU_ERROR("encoder init failed for dp mst display\n");
 					return PTR_ERR(encoder);
 				}
+
+				rc = msm_dp_mst_attach_encoder(priv->kms->dp[i], encoder);
+				if (rc) {
+					DPU_ERROR("dp_mst attach_encoder failed, rc = %d\n", rc);
+					return rc;
+				}
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index fc9c1e3e57ab..6eac390af2e0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -601,6 +601,15 @@ struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 	return dp_panel;
 }
 
+void msm_dp_display_set_link_info(struct msm_dp *msm_dp_display,
+				  struct msm_dp_link_info *dst)
+{
+	struct msm_dp_display_private *dp =
+		container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	memcpy(dst, &dp->panel->link_info, sizeof(*dst));
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index a185819ec57e..fb6bdd372b52 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -63,4 +63,6 @@ void msm_dp_display_unprepare(struct msm_dp *dp);
 
 struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 					      enum msm_dp_stream_id stream_id);
+void msm_dp_display_set_link_info(struct msm_dp *msm_dp_display,
+				  struct msm_dp_link_info *dst);
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 78b8dffe111b..6a77fdef85e9 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -4,18 +4,259 @@
  */
 
 #include <drm/drm_edid.h>
+#include <drm/drm_fixed.h>
+#include <drm/drm_atomic_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
 
 #include "dp_mst_drm.h"
 #include "dp_panel.h"
+#include "dpu_encoder.h"
+
+#define to_dp_mst_connector(x) \
+		container_of((x), struct msm_dp_mst_connector, connector)
+
+struct msm_dp_mst_encoder {
+	struct drm_encoder *enc;
+	int stream_id;
+	struct msm_dp_panel *dp_panel;
+};
+
+struct msm_dp_mst_connector {
+	struct drm_connector connector;
+	struct drm_dp_mst_port *mst_port;
+	struct msm_dp_mst *dp_mst;
+};
+
 
 struct msm_dp_mst {
 	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct msm_dp_mst_encoder mst_encoders[DP_STREAM_MAX];
 	struct msm_dp *msm_dp;
 	struct drm_dp_aux *dp_aux;
 	u32 max_streams;
+	struct mutex mst_lock;
+	struct msm_dp_link_info link_info;
 };
 
+static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst,
+							  struct drm_encoder *enc)
+{
+	int i;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		if (mst->mst_encoders[i].enc == enc)
+			return mst->mst_encoders[i].dp_panel;
+	}
+	return NULL;
+}
+
+static void msm_dp_mst_update_timeslots(struct msm_dp_mst *mst,
+					struct msm_dp_panel *panel,
+					struct drm_dp_mst_atomic_payload *payload)
+{
+	if (payload->vc_start_slot < 0)
+		msm_dp_display_set_stream_info(mst->msm_dp, panel, 1, 0, 0);
+	else
+		msm_dp_display_set_stream_info(mst->msm_dp, panel,
+					       payload->vc_start_slot,
+					       payload->time_slots, payload->pbn);
+
+	drm_dbg_kms(mst->msm_dp->drm_dev,
+		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
+		    panel->stream_id, payload->vc_start_slot,
+		    payload->time_slots, payload->pbn);
+}
+
+static void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
+				     struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector =
+		drm_atomic_get_new_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp *dp_display = mst->msm_dp;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+	struct drm_dp_mst_port *port = mst_conn->mst_port;
+	struct drm_dp_mst_topology_state *mst_state =
+		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_atomic_payload *payload =
+		drm_atomic_get_mst_payload_state(mst_state, port);
+	int rc;
+
+	panel->connector = connector;
+
+	guard(mutex)(&mst->mst_lock);
+
+	rc = msm_dp_display_set_mode_helper(dp_display, state, encoder, panel);
+	if (rc) {
+		drm_err(dp_display->drm_dev,
+			"[MST] stream:%u set_mode failed rc=%d\n", panel->stream_id, rc);
+		goto out;
+	}
+
+	rc = msm_dp_display_prepare_link(dp_display);
+	if (rc) {
+		drm_err(dp_display->drm_dev,
+			"[MST] stream:%u prepare_link failed rc=%d\n", panel->stream_id, rc);
+		msm_dp_display_unprepare(dp_display);
+		goto out;
+	}
+
+	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
+
+	rc = drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
+	if (rc) {
+		drm_err(dp_display->drm_dev,
+			"[MST] payload allocation failure for conn:%d\n", connector->base.id);
+		msm_dp_display_unprepare(dp_display);
+		goto out;
+	}
+
+	msm_dp_mst_update_timeslots(mst, panel, payload);
+
+	msm_dp_display_enable_helper(dp_display, panel);
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+
+	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
+
+out:
+	drm_connector_get(connector);
+}
+
+static void msm_dp_mst_stream_disable(struct drm_encoder *encoder,
+				      struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+	struct drm_dp_mst_topology_state *old_mst_state =
+		drm_atomic_get_old_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_topology_state *new_mst_state =
+		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_atomic_payload *old_payload =
+		drm_atomic_get_mst_payload_state(old_mst_state, mst_conn->mst_port);
+	struct drm_dp_mst_atomic_payload *new_payload =
+		drm_atomic_get_mst_payload_state(new_mst_state, mst_conn->mst_port);
+
+	guard(mutex)(&mst->mst_lock);
+
+	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
+
+	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, new_payload);
+
+	msm_dp_mst_update_timeslots(mst, panel, new_payload);
+
+	msm_dp_display_disable_helper(mst->msm_dp, panel);
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+}
+
+static void msm_dp_mst_stream_post_disable(struct drm_encoder *encoder,
+					   struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+
+	guard(mutex)(&mst->mst_lock);
+
+	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);
+
+	if (!mst->msm_dp->mst_active)
+		msm_dp_display_unprepare(mst->msm_dp);
+
+	panel->connector = NULL;
+
+	drm_connector_put(connector);
+}
+
+static int msm_dp_mst_enc_atomic_check(struct drm_encoder *enc,
+				       struct drm_crtc_state *crtc_state,
+				       struct drm_connector_state *conn_state)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(conn_state->connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct drm_dp_mst_topology_state *mst_state;
+	int bpp, pbn, slots;
+
+	if (!conn_state->crtc)
+		return 0;
+
+	if (!drm_atomic_crtc_needs_modeset(crtc_state) || !crtc_state->active)
+		return 0;
+
+	bpp = (conn_state->connector->display_info.bpc * 3) ?: 24; /* fallback: assume 8bpc */
+	pbn = drm_dp_calc_pbn_mode(crtc_state->mode.clock, bpp << 4);
+
+	mst_state = drm_atomic_get_mst_topology_state(crtc_state->state, &mst->mst_mgr);
+	if (IS_ERR(mst_state))
+		return PTR_ERR(mst_state);
+
+	if (!dfixed_trunc(mst_state->pbn_div)) {
+		mst_state->pbn_div =
+			drm_dp_get_vc_payload_bw(mst->link_info.rate,
+						 mst->link_info.num_lanes);
+	}
+
+	slots = drm_dp_atomic_find_time_slots(crtc_state->state, &mst->mst_mgr,
+					      mst_conn->mst_port, pbn);
+	if (slots < 0)
+		return slots;
+
+	return 0;
+}
+
+static void msm_dp_mst_enc_atomic_enable(struct drm_encoder *enc,
+					 struct drm_atomic_commit *state)
+{
+	msm_dp_mst_stream_enable(enc, state);
+	dpu_encoder_phys_enable(enc, state);
+}
+
+static void msm_dp_mst_enc_atomic_disable(struct drm_encoder *enc,
+					  struct drm_atomic_commit *state)
+{
+	msm_dp_mst_stream_disable(enc, state);
+	dpu_encoder_phys_disable(enc, state);
+	msm_dp_mst_stream_post_disable(enc, state);
+}
+
+static const struct drm_encoder_helper_funcs msm_dp_mst_encoder_helper_funcs = {
+	.atomic_check    = msm_dp_mst_enc_atomic_check,
+	.atomic_mode_set = dpu_encoder_atomic_mode_set,
+	.atomic_enable   = msm_dp_mst_enc_atomic_enable,
+	.atomic_disable  = msm_dp_mst_enc_atomic_disable,
+};
+
+int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder)
+{
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	struct msm_dp_panel *dp_panel;
+	int i;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		if (!mst->mst_encoders[i].enc)
+			break;
+	}
+
+	dp_panel = msm_dp_display_get_panel(dp_display, i);
+	if (!dp_panel) {
+		drm_err(dp_display->drm_dev,
+			"[MST] failed to allocate panel for stream %d\n", i);
+		return -ENOMEM;
+	}
+
+	mst->mst_encoders[i].enc = encoder;
+	mst->mst_encoders[i].stream_id = i;
+	mst->mst_encoders[i].dp_panel = dp_panel;
+	drm_encoder_helper_add(encoder, &msm_dp_mst_encoder_helper_funcs);
+
+	return 0;
+}
+
 int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
 {
 	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
@@ -27,6 +268,9 @@ int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
 			"[MST] failed to set topology mgr state to %d rc:%d\n", state, rc);
 	}
 
+	if (state)
+		msm_dp_display_set_link_info(dp_display, &mst->link_info);
+
 	drm_dbg_kms(dp_display->drm_dev, "[MST] set_mgr_state state:%d\n", state);
 	return rc;
 }
@@ -55,6 +299,7 @@ int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_au
 		return ret;
 	}
 
+	mutex_init(&mst->mst_lock);
 	dp_display->msm_dp_mst = mst;
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index f71200a790f3..854dd08eede2 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -358,6 +358,8 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
 int msm_dp_mst_register(struct msm_dp *dp_display);
+int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, struct drm_encoder *encoder);
+
 #else
 static inline int __init msm_dp_register(void)
 {
@@ -384,6 +386,11 @@ static inline int msm_dp_mst_register(struct msm_dp *dp_display)
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

