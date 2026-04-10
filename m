Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A15E9905D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3757B10E918;
	Fri, 10 Apr 2026 09:36:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GM2YCgar";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H7ZxM4s6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A666410E91A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:50 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oXAW4148794
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yGnq7H3ZXeojJXkq+UiBQOn2BjOfnFsA8n9NKPoeBF8=; b=GM2YCgar0QsWez8M
 Upcgvokco5I3No8cGX3y5TgbCraiv6whSIBaWKCtsAhPmdSYvcCyoBA+qqBK+EUV
 ENoyxltVRlPcdYmoe1o3pouJftS5mfQuWMC5LYLedqsYaxbZrSsBBmhuXz5uIzJa
 /5Gu9lJ/wLypik1J25yKF2611DfFiW0ISrMVD4D/vKBk2tcMXR2vVvuEfTyH9Am2
 /N5xfujlESU25FQQGsGcA94tjo2VcZM4tXlh4EdWYZaugLDVThVXY0xsYjspoY5O
 tBulea6IVro0q9BnZNtG4Ds2aZLwAji6mL52IIukh1Zu6D84eRlCwZDrD7wcNiiV
 CRr+kA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudggsq3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:50 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89ce2a7fef6so50314656d6.1
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813749; x=1776418549;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yGnq7H3ZXeojJXkq+UiBQOn2BjOfnFsA8n9NKPoeBF8=;
 b=H7ZxM4s6JhasLWYdZbjs1R7r3KwNBlEjZU85lRVJJsMur+HuJ9pyV8C3bJJBt0Rlx7
 JzuTnm7shIWRg4PXC3acBSWu6h+umf4iluXOfl1yXS/LVCM2HREK74YKcK6IFvKvLf3B
 voTeziOe6xEhSegta0vvbKdlnIqRUTJIsKbvpPcq5IRBbd6bXhRMviQfymyCPgpjY3ye
 ej62s4pBDAGkNYuIOCVp00TL5kMGoi5pOBYy56lHi+LrmI8qpDQxYUl8mbLv8C4WGcPR
 cp0574YfQw7isPnMjEVMMM+nCpaomd+tDyoL2f/J2u3CTitFb/2D/mFxLrdgLH0BgWkc
 TSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813749; x=1776418549;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yGnq7H3ZXeojJXkq+UiBQOn2BjOfnFsA8n9NKPoeBF8=;
 b=isCV1IBLXQO9hG+daYO1JuXYIXTZl9UWuMliVgNUS0DpTHMdjNHsvR0IKRDNPapULF
 Y6x8ZW+qdQ7jnRe5jBiSFkNaj+VtqeXqYNTddEsAlivzW/FgjWq7oZWO73n4Vd6ZcK9j
 C9vaNb0XMzxpL2L5jGSUWLVWiGa3ysvSMNUkP/8Qd9rIoK9pv8fF1UnKYAT+l92evFxg
 eoMyGhIO3BVEvv2KpXlH6Y8Q/r6SJlik2wp+guCtuW2/HJwQ1S864gk+5pSU3ID3J72t
 LFlMJmxSyPuhKnhkqf1I8H5orlEG5wZV+rvYIPhiTm05NmuBWHnHEUGN48R+Md3R1WH3
 DohA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJCGzHQots2VnKVXZkF+imomYMh+DB0fEemqC4LM6FJa6k4m5+r5qMh6AYGy/CtpHY5FNVgLhIaeA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFJ+zi8HAbeTXk0092qDuDlW+uLezCf1T/OVA62z0Zr1DE4bmi
 NoJkgHkRlKiOo5eflQZKamrGDEpfYKobBT7FpYkB+4aLbGWuVC3Q5ruYBf+M10GoRkwkxFbb48F
 0Db+tB+W/86TTNz9R2uks/y9KYe5L1WeBVypEpt8/2CxR2ABAuDssYS/i1zqhpSbXYwhcX6A=
X-Gm-Gg: AeBDieuTEDEtapDZJUjUY10zA26sxVAMtmZww2sVB59omDYrnV32Y4/vSa+QK58WbQD
 GW5cbF0QNQ1Wc39oucGHvz9xE+gB0IeIiu/Mnx5AjSaPJQtYGWZJx4a9dZhmqkfoA6+M2EJOU/4
 gVSBNqoy+KF0SLTYX11/PoosPWecMjz8N9CCv7KhF0/53Q7Op4tTCbzoYmehO4EBhbWPUiTwQji
 j0yL9ntcARqPth1OStvJe2dGxIw9Aj6hRNe8orKHlcMaJ08YWOXLJ0v7smjf0MsS+QUrkzlyNu7
 XmCfkmysCyL1w5BxaIYTsY17FhokSM8wx9i5wo98BWa4MldRyBj0ImdJ4I0/hyTWaYwE1Zpvh9E
 gHywIrH+KntkbFbX5Uq5GTm3bu9nUaKWZuusL5l4a1kE8J2BZ4Q8WJF5mGJ684tPeZTJvRQqlhE
 SGvggbkb0=
X-Received: by 2002:a05:6214:3a89:b0:89a:c64:c97 with SMTP id
 6a1803df08f44-8ac86285d9fmr32057206d6.36.1775813749209; 
 Fri, 10 Apr 2026 02:35:49 -0700 (PDT)
X-Received: by 2002:a05:6214:3a89:b0:89a:c64:c97 with SMTP id
 6a1803df08f44-8ac86285d9fmr32056926d6.36.1775813748796; 
 Fri, 10 Apr 2026 02:35:48 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.35.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:48 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:58 +0800
Subject: [PATCH v4 23/39] drm/msm/dp: Always program MST_FIFO_CONSTANT_FILL
 for MST use cases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-23-b20518dea8de@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=2580;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=jH0cVfAtP120hSC87AlhdrymlK41cuTeQOw2p6hhzug=;
 b=TtbOcGnnVswOiKEFrkl2fRDSQNtLGseH0eo6Qi9FfVVeScNHdeQbh+Kebi1069Ykexg/gfjI4
 uQhj74dlbysB7fpOEiHFemwt11gXJQVSUyJkUHRGbh0HTUo+lbJWssh
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: p2EQ6Y3y3l56sfOdD-k8PUdeCZoHyxix
X-Proofpoint-GUID: p2EQ6Y3y3l56sfOdD-k8PUdeCZoHyxix
X-Authority-Analysis: v=2.4 cv=H/brBeYi c=1 sm=1 tr=0 ts=69d8c476 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=HaeL3RsyjvW3zFWBFcMA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfXyp/KL6UMHqCR
 j+ozZs+PMHdOe8eAQzUtnX+dkyQ3AYxHCx8veZZN8ToR1JqC1l4u3SoobpetniawP2sTrh9a6Ga
 3k5OW/6GWmswbA7M6mbgCyy990fBHcFwF55f6qRI8v1A74x+ylovLx8hU2dSPreG/KxTd2fkZ+X
 PeJDzUGvNFkjkmQ2mlqkr8fIF4jXBpuqLSqqX2JxiAb6dbAB96tQCi9ndr1O/4JIdI0dbei371F
 81TaYdrbAA7pyxsYRAgALWiocMiiPthEAUFqiyrfAp8mol+9QN6G6YcJWmGwqj4lOdK7hCJNJK6
 YJm+3NwdnFTp0AojGfsqd8oVOeHprjvwedUcfv2CdR0fLonfZQrvjy9cDc1ltIPzs2+Be1p9WD3
 wKUJzrW+6j+V46+24kUdWuUN6qiUdYrY902PgyYOsATa1VV2TPSBMUHeorrMFanLyhvkK26aRSg
 2UMOfqCxn7nLzJBka2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100089
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

As per the hardware programming guide, MST_FIFO_CONSTANT_FILL must
always be programmed when operating in MST mode. This patch ensures
the register is configured accordingly.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c  |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.c | 12 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 9907f2e56e65..199c2806aaa2 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -685,6 +685,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_config_misc1_misc0(ctrl, msm_dp_panel);
 
 	msm_dp_panel_timing_cfg(msm_dp_panel, ctrl->msm_dp_ctrl.wide_bus_en);
+
+	msm_dp_panel_mst_async_fifo(msm_dp_panel, ctrl->mst_active);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index a8a6297b37e3..e05d96f33c43 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -753,6 +753,18 @@ void msm_dp_panel_set_pixel_base(struct msm_dp_panel *msm_dp_panel, void __iomem
 	panel->pixel_base = pixel_base;
 }
 
+void msm_dp_panel_mst_async_fifo(struct msm_dp_panel *msm_dp_panel, bool mst_en)
+{
+	struct msm_dp_panel_private *panel;
+
+	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
+
+	if (mst_en)
+		msm_dp_write_pn(panel, MMSS_DP_ASYNC_FIFO_CONFIG, 0x01);
+	else
+		msm_dp_write_pn(panel, MMSS_DP_ASYNC_FIFO_CONFIG, 0x00);
+}
+
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel)
 {
 	struct drm_display_mode *drm_mode;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 8e7374de90eb..8bab27520439 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -72,6 +72,8 @@ void msm_dp_panel_set_pixel_base(struct msm_dp_panel *msm_dp_panel, void __iomem
 void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
 
+void msm_dp_panel_mst_async_fifo(struct msm_dp_panel *msm_dp_panel, bool mst_en);
+
 /**
  * is_link_rate_valid() - validates the link rate
  * @bw_code: link rate requested by the sink

-- 
2.43.0

