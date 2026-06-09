Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205AACD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CC6910E205;
	Tue,  9 Jun 2026 09:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bcMbUK+F";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QDkq6nAi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A4010E205
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:24 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rcpJ2034759
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gKV7eY6x0GdZCgdZALVmHOg4bVdpjbHHZgfJ+wEnO1c=; b=bcMbUK+FG6jhBOPc
 NdtnDvNFtKdCu3wqtOBvbd5FpdivZQsF8qJ5KpD6RY1ituoVJqt3/CCksejQjjue
 SNjeNtNKYc2viccLaMFp5fAADE9uH4SEQWoGnMxPMUDMnuTaAibDwNOZSIIVksLA
 fZnw4PkEo+Aqa9E8ZeuZKcacvx7xukeFUxShB5G/EW0YVa8PBMLE0b51PTC3IEdA
 93fIPmB4K7ZIra2DTrbQUPp2otQdgNENkjr/ToljuC49gf/SqOrR3dGENJfuo+8A
 xDqBdu9CHOjOCfh7o0UFvlvVrvHm20HQWrNUz8KXZr9x9p45PjEPX09PRpjgvT6w
 Basvlw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeearjn0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:47:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915b9dd020cso708808785a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998443; x=1781603243;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gKV7eY6x0GdZCgdZALVmHOg4bVdpjbHHZgfJ+wEnO1c=;
 b=QDkq6nAi2HcsULGmckkmi13BHXFYYOfslZ+peVfzVBZgf+xUGQDda4oo8u7AiZN0dd
 Y/3t0ZT996cG2Gp4k+ZhwpnZxvjGbFOomlgA9bR4jGhFNL4K5tXG8pViRChBOMBhQoO3
 J//Cio/RRdfR8ptHQT3Z6lfLqjW9Fm1ElBDDJUfRJydzQsvMS1ePBFJEES2h+S5xmEBO
 SK2Nj7OT9BuLLjGROIrCJpoqPYwLqXpueRWB5Ls/u3HAi6+rn1tnaHTPpg/6al5gEF08
 q9ENITQoJQQB9qGMOG+tW+OXoREBv94jUdw3yaWA7BEF36HtDhfV8OPB+RJQWjOJWSi/
 KTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998443; x=1781603243;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gKV7eY6x0GdZCgdZALVmHOg4bVdpjbHHZgfJ+wEnO1c=;
 b=LXKXq3Dl6WzpTdt4N2SvyvpnWyxDaE57QQgqPMuYuqrlK3V7IXC0PlpFc7M7i551AK
 luZYCfS/npLN3PyqYKtp9akXSUM5VJe59RBCofuiXX2WMdkQbyPh7EpqKbVJQzZtuMpt
 BlPEufatNNHmWeKdliNftGuqOVsZKeRjF8tCEpUBbM6nulFngbJsLNbLGWYCyqNBP2xm
 09E33uXaiuo8yv0GQoGpU6LP5/T0K2nsDyh66pYvgsm9pZsOlvRftXLo8xWLT0YU668E
 mruZMS4Vcngsr5bzw71VLQ11Fd0M+gP6SduiqB/mVhRHx/oXBXkRjEIE9RlFLhTr1VQw
 qDvg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0i/xPMxkREfaSh/mF1uHmk+wZhhoP4suqZHYvEoUDmaVh+V2fvsGXad2kn/SZS7zKUtrs50Wb0OY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEmqzZvHJq2KNVkFShCL68dQIWbvRxqcg8WOC5Vh6s/Vl5biMM
 N9M6YEdg1Eu327OJS+bfsXsXE4+c5dd9b9wfpSuz//PAeJ46Sm5kI+iPpDtF6RqA/kRv3OTb/dK
 VWmkKDwUJDAYvIMA4zDeFeO3T+iFkdVli9egod35XD99QKz4bISheetmTaLDa7i/K0B6daFA=
X-Gm-Gg: Acq92OFiY2Z8jCN/3UdpzHGYQk7Rce7rRWOcQbj9oz8oFS4yCwP9Eav+xib/dHxT/6q
 g3gFsdKOeZ3NRnRyuIRgaszohzx4Nj1V9Em3YqrbRi4TjPj5Ck52GS+8/jDBRToGgipxIFQKCs+
 vAvqgz6nzEwhRzsvVxbR98PXL5dcPu3M3wci/9AnzkGl7dIK6lGcPfo3n3nJSgMD2b1YBau4JLS
 OsLPqqL1fUaNt3JTJ+jOFFxCwpOGDiTUH04za9dj36t7OEe/8zL43BBbl/9kP0LH3NpNqME0Ewt
 hqJgA1x8s63M6XVnLWaWPOjLrYQEiRVGmqKcZ1JeM9q8yEjztorD3wB+uF2g6ywZ9daVDk5D2w5
 2PB2EWx81qD49jDAbRkVv4lbvsvOgLjNrlgNPi3e3Q5AnFJL+xQTvsxFkhCURIVe1H5irPy0UFv
 +nPBklSdNL4UguHabiRA==
X-Received: by 2002:a05:620a:3181:b0:915:e8fb:acc0 with SMTP id
 af79cd13be357-915e8fbbd51mr258056485a.23.1780998443069; 
 Tue, 09 Jun 2026 02:47:23 -0700 (PDT)
X-Received: by 2002:a05:620a:3181:b0:915:e8fb:acc0 with SMTP id
 af79cd13be357-915e8fbbd51mr258052985a.23.1780998442532; 
 Tue, 09 Jun 2026 02:47:22 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:47:22 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:31 +0800
Subject: [PATCH v7 09/15] drm/msm/dp: re-arrange dp_display_disable() into
 functional parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-9-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
In-Reply-To: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998393; l=3890;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=IBykKglaoFNzwzYIynAYX/xNxF8GBX7vWe0UDGG9/JE=;
 b=3H9FfXTCb4VoYZS/ebi0VLBBMD2YLcwDaShY5OWsGKF3aQ574dbqjntxQT6BwaQ4rDhGuMf36
 lh/3dFbZgM3Cml1zghEi4KrjuEX9heKx1rv9IqZtP1a77C9lbSuN5Nh
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: ty6rV1t1vDyQOeOPxsUp1BCiAu0_COc2
X-Authority-Analysis: v=2.4 cv=Iey3n2qa c=1 sm=1 tr=0 ts=6a27e12b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7LH33tsxRIP6uNRhSrAA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX2SvzvRFLOuwH
 VBdQbD4X/hVjKK5mXadGtcP0aHY6epoEe15BgIPkydRoK/WxmVblB/ZfO7LeEIbFmhcF/3ejf3B
 9sSNL68rGZPY9g283KCBEc9ecliuboULyyzs/oEfwy8ceyxiWFRDqreKOVrSvrzNlQGGa3aOcyl
 azlMbd2PTxG7qEXd1IY7Tj2wDda0drYvvfnxQGWbKFb+xWxAamexZTkfphN4FyTR2+H2kUGE0fk
 FNMcdWS5Yq0Bih8dxuvHgsohRbgoRocrjn9NR0MDEMXyuv96P33B0lMpw9GPmLZDDsPSwnGBLYc
 RtXt0ZXdPmmE1Lzw1AYMXyne39mFBsUnSvXoh+/eY5VwMa6XBDEeQf4vhydS3uvGchTGoS0CLwu
 B1+SOHGYDqMWEh5RuzBgR5e1CK9kAVJ3ehfI70bgVIuZgju/cWZ2H3AfR4B6zp9ma5jcFQ7+rnH
 8ivpCmjtZnn+LYXKx4A==
X-Proofpoint-GUID: ty6rV1t1vDyQOeOPxsUp1BCiAu0_COc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090
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

dp_display_disable() handles special case of when monitor is
disconnected from the dongle while the dongle stays connected
thereby needing a separate function dp_ctrl_off_link_stream()
for this. However with a slight rework this can still be handled
by keeping common paths same for regular and special case.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 19 +------------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 10 +++++++++-
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 546d899dde23..626b95d4d015 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2598,7 +2598,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	return ret;
 }
 
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2606,23 +2606,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 	phy = ctrl->phy;
 
-	msm_dp_panel_disable_vsc_sdp(ctrl->panel);
-
-	/* set dongle to D3 (power off) mode */
-	msm_dp_link_psm_config(ctrl->link, &ctrl->panel->link_info, true);
-
-	msm_dp_ctrl_mainlink_disable(ctrl);
-
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
-	}
-
-	dev_pm_opp_set_rate(ctrl->dev, 0);
-	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
-
-	phy_power_off(phy);
-
 	/* aux channel down, reinit phy */
 	phy_exit(phy);
 	phy_init(phy);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 1497f1a8fc2f..5d615f50d13b 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -19,7 +19,6 @@ struct phy;
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train);
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl);
@@ -46,4 +45,5 @@ void msm_dp_ctrl_core_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index cf859f880943..b8dab3f8a7c2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -714,12 +714,20 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 	if (!msm_dp_display->power_on)
 		return 0;
 
+	msm_dp_panel_disable_vsc_sdp(dp->panel);
+
+	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0) {
 		/*
 		 * irq_hpd with sink_count = 0
 		 * hdmi unplugged out of dongle
 		 */
-		msm_dp_ctrl_off_link_stream(dp->ctrl);
+
+		/* set dongle to D3 (power off) mode */
+		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_ctrl_off(dp->ctrl);
+		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
 		/*
 		 * unplugged interrupt

-- 
2.43.0

