Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66C10E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:35:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C031E10E914;
	Fri, 10 Apr 2026 09:35:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JGBCT/tN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FgsIwQc3";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A90210E91A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:25 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6Koqj2867026
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eylchszgY26qM6PjUr00qPnCImBgD1BjMnTdcXjom3s=; b=JGBCT/tN9BOTUaE4
 PwZ3tC0KZRcYjucRA0ohlvwFAW9kC54UzLZxKfLQE1RoYv7u3Fga9EqGUeDtQBy3
 I0FvGZKUSqUSpdXmjJzpkx+PPQurE8n20COdBFK9TJeOASqckwhITfxqpBRRKqeC
 n4ClaJbS7rhMmr8ORBaeQvJdQV16yzQXMKcQXV6O/kOVoKMxkQIKIaV6qW1P5MLv
 kFu8MqXYCe5mPgxmZ6sA0rcwJ6DSMdRmRKcT0beJTctC+z23ht85OzngLZ8IhTJy
 PcH07U41fsTwIS9LbZu+1OazjwohlPXDSfqm81KqjySghf/B05u3SPtDTuCku4a7
 DYCySg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decaykt12-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8a1f96bf221so62759136d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813724; x=1776418524;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eylchszgY26qM6PjUr00qPnCImBgD1BjMnTdcXjom3s=;
 b=FgsIwQc3DgSgS8IqislypGCLKPWEMm2cdqJUXT5JeJEvoZ5Qmrhf0a+SEkBeif228p
 j/+/ZMbBJk+eiCH5yQ6uXo6krDpfyaHMdQU/WBn6tKCO7zdwFUbuQB98wkD7r6qXW0uq
 7F4TYaGk70Q0cBkGnYbnIX6R9jvSt5FYBmES0tv3goU1J3E6S1kvdft4HxTVYpGgOSaB
 Mg93Z50flKDmnFKeXKKdVsGsU84oahbfotLuzurWuqGhvgmCIaltKCDP8JVmk4AutL0f
 kPMwyGrKAuePjUBS2muZi5tsaC1QsMJFjxZj6Bu9Ilwk6R/dCAZ1ytKHLpQdP0DIhfhO
 yBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813724; x=1776418524;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eylchszgY26qM6PjUr00qPnCImBgD1BjMnTdcXjom3s=;
 b=g9U5aFvwuUB/73sQRpviuG9FMm2403d0CU8pQwNhJaaw4u17/sdI0m77/pQTodgFim
 rAf4H6IX06wTaEFiW0JqKGnFJTM90qNpfT2THd1iejxjmUDNQlBo3akYBTHxYBL9QVxj
 98kmbB68hV21cmm+uq716xaTyq2qlcv3OHsVuRne6qDWAce6pzu/RUTePlUSyhG6uQj0
 7s5VThE7Wb3nQn9h24d2eikNSpwEE7iQDILKzLZ2pV+ORBS7z6LCfI44pnYnqveuBuWq
 UxMjA93u+fRSz5cpDC1+hZYOaaiV8PKgKdVZ9i2RdaTvObJLK6w3nJlUmOarotgVdNDO
 TxBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRKN9vwV2sgHJGwi1+GU1DxLwtMXzB9Jm4NgGT1pAg3ijS7K10r6KYWJ0VqSk9QpwMpyLWw9Z/uLE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRDnn0jpMsoqDKn2igNoLEqe7K+pDjVgY7lNegfgyi/CR7bukn
 HhTomDlTYF799ZSbS+MRoPzKd9roJ0Ry+wy8pOnuPf2nvyf/kEopunOd2gnGY36ymnErfBNDXnv
 mDju4Gt8ZvhVPCKXAzx2RxhwyK1C7RjvT6wp36SYNwqyAGWKt18YDZ8QHvNgz9sKqUDRyCDU=
X-Gm-Gg: AeBDiesPhPVj7QXxEcE6vQovHggm7iQPUEFgIxdLMIUtdOMQa/RvVvzL0Y43hebaAs1
 FGfTBYKvLgHMcGf1rIelE+PkdbEMOWeq8OJ5Ti4oNlGfZ3rnuEoDvT83hckIHQ44ZkUOB9w3RPO
 1XYMm0hiCSNIL3DSlp+7CLDdZSG5kvppqct0M5NkTmU/G1fm2R/jRUuvXZ9q7rwqhqBp44iY8U+
 dltGd+YjHrKgx1mhaXDJtsEgQdc6IJ8/qslAaPDPjpZoWxYxudoYPmXDxzU7cp9AmH8bd4YOywj
 g4un8lMJJ+2SL9s+RRK8+spMiZiRdcSNRe3LzDxucQ3za0yudVjclwnTTFtUTkJ29GlorbtiTnS
 i5n5L87ZhAULvS0IMM2pkpA7lHASir577Mqat2uXvDrcI2FTjqMQrneesIqtDkt0LRCJGKxfv6+
 T4f0DTZxU=
X-Received: by 2002:a05:6214:5546:b0:89c:5c84:36 with SMTP id
 6a1803df08f44-8ac861a235cmr31669506d6.14.1775813723871; 
 Fri, 10 Apr 2026 02:35:23 -0700 (PDT)
X-Received: by 2002:a05:6214:5546:b0:89c:5c84:36 with SMTP id
 6a1803df08f44-8ac861a235cmr31669186d6.14.1775813723407; 
 Fri, 10 Apr 2026 02:35:23 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:23 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:53 +0800
Subject: [PATCH v4 18/39] drm/msm/dp: add support to send ACT packets for MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-18-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=7120;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=CemO4VmQ+98B+fw3BBYwaBPR2qapVb0Nx/wFZyKNcvY=;
 b=mL1DFIaKSk/UmFz41yhSYdIOdGIAQciObVOfoWp5juk7DNKUuIkF50DShPaNUYwqV3ha4bU+l
 wxTl1fUOydmDFtDr+Cun7RNi+ogpKYTDMLwrY7yWdpPLZP8ZIhK+nZg
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d8c45c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=WyzI5VeO30yZZBqxhZsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX+dHSVKXIrkmN
 XvvlrJFdwY3aKxop3D34xBYV7/KRdAfUxQpWzVjeuuht+W9mLQj+EGlCCFw7WV19Q6JJGyE6Ndc
 KtDbbi0DWrnfycdeWfn+u6Z2IARbmbYz5LdVXqCKkgf9fP/KVlgZt1SnL4LEZ4yl4fVipOirXIw
 WfjOiAcxGgqaY1eciOcuZumghgcnIYK0OAhXJWYKLkgXbSuXds0a+r+xBHEmOGDFPvliDBOPjaS
 YchKCs2p5f4cBLjRx9GQQi53lzIUwySJFLmK1MVfUuVF94/gptBvkA5OPf7DGYTKnmG1UXp+FQB
 kZRpq9eAjc3nhJgwnk0dVws+EfNUIaiTHHugZRk9msowWvjnghHOkDanyO+PHCIhm1ME92FMs2K
 aWtD2IvqgqnhT4d1n5cSm6q3UtiknVK2he2T1T/WNSxjYowoYyC3YQ8jqpiKKEETH72SCdPTfdd
 zzUFOtZF+sspydSUuaw==
X-Proofpoint-GUID: h2SWWsx70fbWH5nYvA9i9ugCoseWvYMH
X-Proofpoint-ORIG-GUID: h2SWWsx70fbWH5nYvA9i9ugCoseWvYMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
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

Whenever virtual channel slot allocation changes, the DP
source must send the action control trigger sequence to notify
the sink about the same. This would be applicable during the
start and stop of the pixel stream. Add the infrastructure
to be able to send ACT packets for the DP controller when
operating in MST mode.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 43 +++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 drivers/gpu/drm/msm/dp/dp_reg.h     |  2 ++
 5 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 1109b2df21be..6f25145ef214 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -143,6 +143,7 @@ struct msm_dp_ctrl_private {
 	bool core_clks_on;
 	bool link_clks_on;
 	bool stream_clks_on[DP_STREAM_MAX];
+	bool mst_active;
 };
 
 static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
@@ -228,6 +229,32 @@ static int msm_dp_aux_link_configure(struct drm_dp_aux *aux,
 	return err;
 }
 
+int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+	bool act_complete;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (!ctrl->mst_active)
+		return 0;
+
+	msm_dp_write_link(ctrl, 0, REG_DP_MST_ACT, 0x1);
+	/* make sure ACT signal is performed */
+	wmb();
+
+	msleep(20); /* needs 1 frame time */
+
+	act_complete = msm_dp_read_link(ctrl, 0, REG_DP_MST_ACT);
+
+	if (!act_complete) {
+		drm_dbg_dp(ctrl->drm_dev, "MST ACT trigger complete failed\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * NOTE: resetting DP controller will also clear any pending HPD related interrupts
  */
@@ -2081,6 +2108,10 @@ static int msm_dp_ctrl_link_maintenance(struct msm_dp_ctrl_private *ctrl)
 
 	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
+	ret = msm_dp_ctrl_mst_send_act(&ctrl->msm_dp_ctrl);
+	if (ret)
+		return ret;
+
 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
 end:
 	return ret;
@@ -2277,7 +2308,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, ctrl->panel->stream_id);
 	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl);
 
-	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl);
+	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, false);
 	if (ret) {
 		DRM_ERROR("failed to enable DP link controller\n");
 		return ret;
@@ -2357,7 +2388,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
 	return drm_dp_channel_eq_ok(link_status, num_lanes);
 }
 
-int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
+int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active)
 {
 	int rc = 0;
 	struct msm_dp_ctrl_private *ctrl;
@@ -2375,6 +2406,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	rate = ctrl->panel->link_info.rate;
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
+	ctrl->mst_active = mst_active;
 
 	msm_dp_ctrl_core_clk_enable(&ctrl->msm_dp_ctrl);
 
@@ -2654,6 +2686,10 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_write_link(ctrl, 0, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 
+	ret = msm_dp_ctrl_mst_send_act(msm_dp_ctrl);
+	if (ret)
+		return ret;
+
 	ret = msm_dp_ctrl_wait4video_ready(ctrl);
 	if (ret)
 		return ret;
@@ -2693,6 +2729,8 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
 
+	ctrl->mst_active = false;
+
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
@@ -2876,6 +2914,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	ctrl->link_base = link_base;
 	ctrl->mst2link_base = mst2link_base;
 	ctrl->mst3link_base = mst3link_base;
+	ctrl->mst_active = false;
 
 	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl, max_stream);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index e72d501ac1ce..f82fd96e412a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -16,7 +16,7 @@ struct msm_dp_ctrl {
 
 struct phy;
 
-int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl, bool mst_active);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *msm_dp_panel);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl);
@@ -51,4 +51,5 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
+int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a924fbd825f7..80bb5fc4003f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -660,7 +660,7 @@ static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
 		force_link_train = true;
 	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl);
+	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
 	if (rc)
 		DRM_ERROR("Failed link training (rc=%d)\n", rc);
 	// TODO: schedule drm_connector_set_link_status_property()
@@ -1547,6 +1547,7 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
 	msm_dp_ctrl_push_idle(msm_dp_display->ctrl);
+	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl);
 }
 
 static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index b0cfdf215970..fdbe6e4871d9 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -19,6 +19,7 @@ struct msm_dp {
 	struct drm_bridge *bridge;
 	bool audio_enabled;
 	bool power_on;
+	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_reg.h b/drivers/gpu/drm/msm/dp/dp_reg.h
index 1c2d3d8d029d..237325d52dbd 100644
--- a/drivers/gpu/drm/msm/dp/dp_reg.h
+++ b/drivers/gpu/drm/msm/dp/dp_reg.h
@@ -156,6 +156,8 @@
 #define DP_CONFIGURATION_CTRL_BPC_SHIFT		(0x08)
 #define DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT	(0x0D)
 
+#define REG_DP_MST_ACT				(0x00000500)
+
 #define REG_DP_SOFTWARE_MVID			(0x00000010)
 #define REG_DP_SOFTWARE_NVID			(0x00000018)
 #define REG_DP_TOTAL_HOR_VER			(0x0000001C)

-- 
2.43.0

