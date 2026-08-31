Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309ACC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E6E10E728;
	Mon, 31 Aug 2026 08:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IYjzDrlX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBoDgsU1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 317A010E728
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:11 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xjxM2419583
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2DfGKdATfOjFFY9gM+0rCf+mT+yAPmvFB+hWTIxVlXs=; b=IYjzDrlXZgOn9ZG7
 204v2FZhOtGB/iI7kQWIG3dMk3vFTskZ2zN4nosg3bwXHIzFMjCL3c7aS1nri9vY
 ZqIhP/opXdc9i/y7oc823v6uxDyAnVZvloX5JuSrZhuNFBHst32N+Upm7bmKHBym
 mhIZWt+YCnGnWyIr4WadFz6FjkuarX2e4aUmLdXc8UHsUyowbn70up2e9uerRzXZ
 oKqS14mfis0xnTbyZYb4MBqmY5Du1fy8+5UhbURT09EvHiQvHR34qkY0CHHnlWAL
 QDkXOOh3/SFJb/mUg5894x+C0x34zC3Y0JFwTgSMN7EqD80guK2po7F1QJBzu88m
 QYUUcA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6nc4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:10 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e52306621so416292585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164349; x=1788769149;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2DfGKdATfOjFFY9gM+0rCf+mT+yAPmvFB+hWTIxVlXs=;
 b=LBoDgsU1dRsOew1RJjdFrWM0gFybtoQZWERntFBUbFkegAIIRVr3CE+fyKnUHuzjuz
 7PVMeExL7iD0dfL3iRrqyqvVlvS8XJdZ4NAufMZyCHJs5B5g7RM2jJvFO7xURL5wdqyn
 u1hoP7j4Rfsht7OqD3KFwCSO+bJziEZ0pYfSDYd1nxqbRLCk7jUq6T6EZtJa9h/tllw2
 ncnwa3bA5LxDmoRgDFhD0BFt+hd299sRsPfYkoMbONclHfHnEBiaMvfrOinz9/9HYQo9
 daqA8E7lJhrMdUhVXPOFKQg9G4HzQDJL5pkNvwj/0li9hasHHWpU8bE9U3RPnlFJ80/x
 uQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164349; x=1788769149;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2DfGKdATfOjFFY9gM+0rCf+mT+yAPmvFB+hWTIxVlXs=;
 b=aEFbhjFQVrLVySqgF4naKew8kE8Gwfz+jgqFcwQ29Qb4pJM/Melgc2MxTsvrEBslT5
 /f/DDGxM4gpC0yXPjh08EOOpprjckUUEFNCRsJTMQI4eetnnBoupnsKoDAl/+zTryP6+
 W7ESO2+iEHhW8dY0VTPcPBhs81P6w/+QLCuCmGGq1W1ZnSOZyBdJAE+tZn8mJ8yVOl4V
 A6EcMcfcIXrM19TlAZgNA1gzQsuIDm1lpeQLZJzN4nFEoojvNFWtJjuQ8LoMnLI56e3E
 d64iIphV4AnizcrQBuxqSBUOf4/hiZwksED87EMvfQsD/P8Rqe9zsB70HR8TZIZ5cF/e
 EAYA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoiYx8Gi9S8NHW84wCss3P557rBSnD5s8GnhbzYEIipMgWZyn2V2pFl30FRxWgfwXtNAPm4RdniaIw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l+hUYqmpKxu5yMox+u8EmtP1NIGe7nv8/U4+EqEmmw2RWaXLlF
 ZN0HjXzDLSIvRKKrJgFdqUKpWBc6uE6ff4G3jRpmSGo8kYN6os1laIgv6injSowkHkZphbhEtiY
 uN/AwqU6CCWazWgLOE2RUeRsZsH2a2843PgJdqNvh9pEp/VJ1BKiJvGWBjjIysGMk4+5AGxc=
X-Gm-Gg: AR+sD116PSe4PF4QTJF6KoDct7l/vwYHluDFVv27fyFt4ybyKuupUAFLqrTzOA8uLgj
 8s1P8qv1ZPBLdaaidVdBf2EuCddStC8WMU1hK1jJj1lFfUSFT3GrJoUEPzGjwPMkZ1OK18y98Rs
 RqwAxIOqWpha8q5AFBJboPEL3J5G7CmMtb5LErKIEOG6w0ndYZkeaYLARrxaHf5Wnhpjh20tb1/
 n75GjDf5wqTdHyqCOys0yfmS+404rP+WPvuCEZ9E4Ypk/4Z8WsM4M0TyImoIaLlfwwaSjLnUfA5
 2NqNj012ch2xFxDJphyrYnRCGo25N59x38fhhh9LHwq342NBZj7igOmatvrDl8guI6yu2SuC11a
 rBqKuVBiy+LnSSbr7HN5h9h1BoNA4fLIaMurRnVogPj4Yv1tWGer1garENGkuO00=
X-Received: by 2002:a05:620a:27d4:b0:930:adac:1e99 with SMTP id
 af79cd13be357-93913988103mr3002957085a.38.1788164349388; 
 Mon, 31 Aug 2026 01:19:09 -0700 (PDT)
X-Received: by 2002:a05:620a:27d4:b0:930:adac:1e99 with SMTP id
 af79cd13be357-93913988103mr3002953485a.38.1788164348971; 
 Mon, 31 Aug 2026 01:19:08 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:19:08 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:34 +0800
Subject: [PATCH v6 17/29] drm/msm/dp: add msm_dp_display_get_panel() to
 initialize DP panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-17-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=3826;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=WB3JEW4F3W0Nb4YZZ57tBhLxCoKYBW7PUps9LAMtJN8=;
 b=CROqjXteH0mUBcQP9g57bVnwYJgCdbRhRQYMKcKyZpYZkrxlX8gamFJM3qttKaqfJoa3b4Ftf
 yaFiAgwOGu1C24Hq+Vp+l/p6ScXCuCHyajbRMmxg4wrwplDbOfchDSn
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: WvuqUEJeetlmw1jD18FPzbTfwAJTFVL1
X-Proofpoint-GUID: WvuqUEJeetlmw1jD18FPzbTfwAJTFVL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX0CXDyLTqSdPO
 SHU7QaiABR6XQOE4FOGrCUAvauc4DsvLSlIZyk/JzrPVHkEm4WdPtyGU3+788xkckqEhGOqv/nJ
 AQz3pu80YV+YEaq214rNUwnlMIpN3/GYR5tTWNzeo6v/VgirKrAEvHQYJxrskmXGV8ftJhdjiTb
 FqALY2tmNG+uSDPLzdq7+na5YtGFeZXszE81dELp8BCMVb5sc5aI26uyZS8KoCHRxgfzcCmP+Ox
 /hUUKBcNjFSAR7TeRC43r2p8RRj71CbTq1gOXnjxgc329W1RU7h3QoM6R3RDK/icpJwO+1BlJPP
 wdAaIKrw9pytdIKPR572E0X3lkA2D0+wsHzRP5tGVHRV/z3DXf1DxuIJRdLJt3r3GyeEgNUgOy4
 rBMUXAos4CISfYmlve7Aw44HHE14zvb+QoVhU4zn/GcmHmA4rdhKRYqcoWD/KIh8P48CZc3/SAD
 Q2n9Vr4N8wyL6mj9gyg==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a9538fe cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kCKOgzAXqFYlHSlaV6AA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX1sshSkVNh3Rz
 bL26m1oTg0kyUOBuuipVG7MwBK5tBjFYY29uZs44g86GSs7kfUBu0Z6suz3KoKKU+sCUhaqkiqv
 EzDombq5Q/SO5EqG4SR2nwSHmDsdlhk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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

Add an API msm_dp_display_get_panel() to initialize and return a DP
panel to be used by DP MST module. Since some of the fields of
DP panel are private, dp_display module needs to initialize these
parts and return the panel back.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  9 +++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 73aabd219125..c4936e8ba48f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -3130,6 +3130,15 @@ bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *msm_dp_ctrl,
 	return ctrl->stream_clks_on[stream_id];
 }
 
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	return ctrl->num_pixel_clks;
+}
+
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
 			struct drm_dp_aux *aux,
 			struct phy *phy,
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index e8b445c552f7..111300784edd 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -61,6 +61,7 @@ void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 bool msm_dp_ctrl_stream_clks_on(struct msm_dp_ctrl *dp_ctrl,
 				enum msm_dp_stream_id stream_id);
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
 int msm_dp_ctrl_mst_send_act(struct msm_dp_ctrl *msm_dp_ctrl,
 			     struct msm_dp_panel *panel);
 void msm_dp_ctrl_mst_timeslot_setup(struct msm_dp_ctrl *msm_dp_ctrl);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 90e3d2c4ef47..6952f83db006 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -529,6 +529,33 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 	return rc;
 }
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id)
+{
+	struct msm_dp_display_private *dp;
+	struct msm_dp_panel *dp_panel;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	if (stream_id >= msm_dp_ctrl_get_stream_cnt(dp->ctrl)) {
+		DRM_ERROR("invalid stream_id %d\n", stream_id);
+		return NULL;
+	}
+
+	dp_panel = msm_dp_panel_get(&dp->msm_dp_display.pdev->dev, dp->aux, dp->link,
+				    dp->link_base, dp->mst2link_base, dp->mst3link_base,
+				    dp->pixel_base[stream_id]);
+
+	if (IS_ERR(dp_panel)) {
+		DRM_ERROR("failed to initialize panel\n");
+		return NULL;
+	}
+
+	dp_panel->stream_id = stream_id;
+
+	return dp_panel;
+}
+
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 51eace1d1346..4d4349068c2f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -59,4 +59,6 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
+					      enum msm_dp_stream_id stream_id);
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

