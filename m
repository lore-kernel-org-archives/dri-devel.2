Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF99C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C921510E684;
	Mon, 29 Jun 2026 13:17:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tgh0+XBA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="U4fssdgu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C71710E8BD
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:25 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATGH02628186
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p1CONgWJ01NtWeyqUGCMrIIJYd+vBD6kZt60dnrceag=; b=Tgh0+XBA0usTA+OQ
 PFfudKejC4khUe0VaZYcX2XnvuX8dbZGKscKwsPsN3YDOS8ADM/8XNNAquQE9lhI
 6ZhdUE/+wqWIm4WAsj1YFVUY7j5Vkt9A8R4qRD6lM8PmwMOdcwfIGQofAL/sp23Z
 f4Nmh80DANy8u2SE6SUnp50rkry/8UwP6tmo6sHougmsQnT3TIq5nxgoPDmn/ArW
 zeyV/4Ol482qkDOALghkfMs7/6d8S6LYekq/9ssM5tYNfsEMSv34XgxjFQG78h6j
 3gswxV5PmaXLGN5FnM8CCB6f1tB640heoYPRW0O2NEmYAyUKtKJVBWDp58xfcYw1
 7teY/Q==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgs1tk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:24 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f0caedba59so15362436d6.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739044; x=1783343844;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p1CONgWJ01NtWeyqUGCMrIIJYd+vBD6kZt60dnrceag=;
 b=U4fssdguNl5MWkx6vww7TdJRoSrC2M6D4KjMfYHKClAYc1bERcOF/J7cbi2pi3Qmk5
 jl0u1flpVtZ45baPc4fuQF7mQTwE+vKoPX4ondJzzPig5Nt87I7S8oK+DJvTI+2q8SkC
 MXelGWseuCcy6im28OtnrFFpQvNyF662JY7MeJv+1Ex2dBwenPCE+0AISomjInqwGSEc
 SjgawsoXfj8lQr7OgEMvLWZJs1etMlYpOVFkDVIP8usqglARfZBcOAeBl8CXep522nKX
 ErDyuT3sltiSLXTuaOFI3iS5WIkmoFOjf3BOORqAxX+7UyKf/wLhI20wxCN+I3TlBHz8
 096g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739044; x=1783343844;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p1CONgWJ01NtWeyqUGCMrIIJYd+vBD6kZt60dnrceag=;
 b=iX4eRH7HgKFSdF1v/lrHUUZ1H9boApNi0zHVzfaI1DgsnPdlumxRMrONZZrb0OvMzd
 Rh6JGXmv4xiQIy9datlo+ZJbhGVvQvMfYmARqYd8PbIjTcCctL5ojcHsGpVKFsAcyniX
 oUAkqTri8PCTL4mkM8LQDkwGv5MInCqTUtIBwU8XngP+aT4nj5WfMUV9wdmY4IG7OwHC
 PXssUY9ja3rdaeo/6IgHDeGhO1ZI5PXD+278Yek1+Ov616iKOtW9twgD4wjMHdi7qaB1
 VfuiU9VIuF7xs1TpcRnzI9A96iODmxIQYmWGVkrEgIQygMo3Xu02UPOQIgb7IFLfMoGY
 QIVg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrO5kD5LfD9ADHLX8OMRR8KMZSt5cO67MLKfPH9QP2nDlHxGEXtcWwx0i2XxMuLp6gv7rM92/gY6mw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvAd+yLJfCN3h33xLf1VMKw4knV6F5BwzyN2I7aVSf7LLcP7OE
 YqnqnBw1QsLhJSbMZ0aI5gfzcHsu/E9lDIR+UHx0LdRe+mgyQ1kkFZBJdySdj58lB9xC1a3Q+hY
 tMkqFQyxEfyZpNaRkVYKxl9ozw6cB40tJAxvx8aFw8x6iG+n0nxSyVprmfVaP4T8yx3t26mg=
X-Gm-Gg: AfdE7ckgYll87iEH7+ZT68ZPHxIulmQbE3kK3uliqUE+b3TtHlUt1ix3mB0b14fsq4z
 uu1Phxzk9Rg5U143//Un9+pXPnFym7JeHBadD4z0LseE5o8hsh+YFOjRZVslHvDbdW4ZNyUPClG
 IOBuWOC4AuQgk1JROiXFZbmF7JNmgm18+WcY4KJXJ0/jMqUqFzWY6bD5wME5BNebUkvtaDQaoRD
 d5ead7BOP6Xy0S2sX1Dgo7zHbHGuoPK0dYYCMk1VYooKAeNDBBnpn9Kwtqcc8yU1GHpQoLuRI9f
 uRq+3yNy/jz7TGjxG9SB2zd2vwxhK474ahKU9zbuBsPUJGijRmXEuT5i5kPFO6vTs7nJiv67dmp
 urfbyRfcGCAEdqrgUYgAY1ypL2SuE9sUutY91O1Jb+OFLenUFAnCYdJ9+5/UH6qXUe/b2t8x43w
 ==
X-Received: by 2002:a05:6214:4506:b0:8f1:2fef:78c8 with SMTP id
 6a1803df08f44-8f12fef7aeamr15307536d6.19.1782739044030; 
 Mon, 29 Jun 2026 06:17:24 -0700 (PDT)
X-Received: by 2002:a05:6214:4506:b0:8f1:2fef:78c8 with SMTP id
 6a1803df08f44-8f12fef7aeamr15303756d6.19.1782739039914; 
 Mon, 29 Jun 2026 06:17:19 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:19 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:28 +0800
Subject: [PATCH v5 10/25] drm/msm/dp: Always program MST_FIFO_CONSTANT_FILL
 for MST use cases
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-10-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=2539;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=NN3ZQ7RQKQ4IPtPV9Psg0vrIOb4voIVZosbAYDy6STY=;
 b=zoYI8ASIaci6SW3dWtVfeAGjeqiz/AA12sLnqxeR3dMWUSxJSZHjHaVl6t5c/HKemz6HBBCkB
 nb4kmM7dGd1CPdo/K0cxgUXMFla3WttajkYNsyR5u/UMjtR97uxJ0bv
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: r1o3dfDCFU5CwaMoLgAsBQzckK5xP81G
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a427064 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=_o_Q1azn2oY438DeJ5EA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX2Unw1S7Hv5v0
 V8Uj6P0C6qQ1DPh35Lo4AVNcRNam/8999eXG2zyctaH1JzlphOMG1AcIx7d7nhmvFunCT4fU+fc
 KBf0ZQgRRB4LMkWRevNGsi6CpXMUF4g=
X-Proofpoint-GUID: r1o3dfDCFU5CwaMoLgAsBQzckK5xP81G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX75MCO5D/RU6k
 QGLkcnoQ6z7IR1j/Fuj9s4YVUUb4N/zmqQedUz7bZQmGJQNGzt8QYk1wZKrX7ucjNG63ok6eOG/
 6kCNc32E6O1GNkLdlL4qmXFW7Q0h/kvdX4DNjKObJaCdn5nkVFFPpyrOX/RZR/u9ECZ75GxzaOv
 7q8NX1na8yTus3Sy1NgO/wbjS9DVZUnwk/ZjXCDgCmC/Zhzt3/MmFhuzQtNcLkqwgeyFDn30Tj2
 6/JqM6RFe76DzCxT/Sr+Oq/IGkfwqOF5XQvD6mpBnOUN9mqKGdshGtj7lbQQkY1UdmmoZICVfN9
 PNf5wbno260l/9HoD87roZmhYGGLJnLIwAKv27cN7Kw0IQTFWhE4WnSJ8SOON4eC/p6dvTRU48G
 YYJT9L3WCvw72U2JK8A/PmFhPcZB/tDIP/1WU/Wgm7ph6SNAJUfvjFq7kG6myhzCzTwpejoH7jr
 MajETifu3aswz2XzWKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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
always be programmed when operating in MST mode. Ensure the register
is configured accordingly.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c  |  2 ++
 drivers/gpu/drm/msm/dp/dp_panel.c | 12 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_panel.h |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index c4f1a68b1210..80116e19fbbf 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -677,6 +677,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_config_misc1_misc0(ctrl, panel);
 
 	msm_dp_panel_timing_cfg(panel, ctrl->msm_dp_ctrl.wide_bus_en);
+
+	msm_dp_panel_mst_async_fifo(panel, ctrl->mst_active);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index cbbcc0dbf652..ba5ee2ad8924 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -741,6 +741,18 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 	return 0;
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
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
 				 const struct drm_display_mode *adjusted_mode,
 				 u32 bpp)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 3e78af9e430d..edc39ee5268e 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -73,6 +73,8 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
 void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
 
+void msm_dp_panel_mst_async_fifo(struct msm_dp_panel *msm_dp_panel, bool mst_en);
+
 /**
  * is_link_rate_valid() - validates the link rate
  * @bw_code: link rate requested by the sink

-- 
2.43.0

