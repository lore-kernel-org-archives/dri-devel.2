Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB060C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3ED10E6A5;
	Mon, 20 Jul 2026 06:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0BaR6Wt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YLiu7y8R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F45610E6A5
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:41 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNsh2n1911729
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ElnWA0oWQD3Q2jSTrrP2J1EEOEKI1Sa6JObzupzNEE=; b=T0BaR6WtlyxIiA6F
 CCsJRbJXsB/55wSHJiZQRWoI2+3kIghp+IIyF4V0Z9j3xAW5l6L4Smb76bRAkW7a
 ERajE6Gdq6LGHeCdYyZZ1F6HLG9ofAgIwpiADkIJUlccvDnZgJo4RfHgE0D2m1xM
 IS3MCFKJpmFq+dNtoH5kmmqlaSLGRtT4eDWfIaJwJGhd8dW9we/R7SynXaLfhqqG
 UoTSTINxcp/l3GqAlf+DCKjaZ1+R4xYNsgfpRHvzmqDKiVey5CppgtDGoExw81Vl
 COdnPfy181thoq3fgb2ms94HJAlkYVyJmi7b8brVT0LlgIZj3QCRt3XxhJytlfhE
 OXdcTw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aavmmy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:40 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so161834736d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527900; x=1785132700;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6ElnWA0oWQD3Q2jSTrrP2J1EEOEKI1Sa6JObzupzNEE=;
 b=YLiu7y8RRUd02LEhCdIMnN2YhIiXZYEXwWs7jAS7HW4j8O1ML+6w19+qn5wG8Wbx6C
 u0EOqV9vu9dxtuLGN4NERzFaDC+YD/zV4a+mUU1x70xx1MMmZYEwJOOz1J/z2lv9v8P0
 Lmp/1e0gDBrIJ8+mxQSilZL3fcmNCTqiRzmDT+QWq0N7v9QjqHXcRqclKAlDjXxJOD84
 4m4dTrzWFtIXig+5NpX89uCcA2f3sg9fFsSXKiQdjV4PICv07Nmj6U2Pog3E8IRSLxQv
 4vV5SvT8Fg7e8OTUvtAM/8IVRxszGSSmxcsNCXV5QDSeXUkLNbpCTlY1G7Ca0izJhtj5
 nnTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527900; x=1785132700;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6ElnWA0oWQD3Q2jSTrrP2J1EEOEKI1Sa6JObzupzNEE=;
 b=GqOxghf4qFkP64r8pU/WBBD7wWnP46EOUel9d4oitG18S339UUO7d77mUaLTIAZ8hO
 JQ5XfWLNlqj25M0V3FeLqommEWGgttlYz9ZBAR54p5xvcdFUrbms08KlEdHX3m3gMCm5
 XPVUCmQAmUT7/1whRrLYRS1PwdtZ+eaRG3D8WRs9p2ptoVLjnHBfxuV4gJK77hJW8F46
 m4t+C1Z46o8qEtxVDPMjb/e3u6oKwcpQPkiMW164RvlSwuHT7qLlARpSPLiZ8DY6o7eS
 co+EPdGO4RNpFqDRDjOr40QbTjTnb9RTeyGv7Fa3GWmJ2aSk7uZKQ54d9jDg7ynbVJpe
 xybw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVMyhIwRUkUo8XBY1M08RkF3BUIccibPJ8uTi1eWVCMNzGAfwBkLRamGgqKZ1xgNM46gpHk0Ym3XU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxs3ha6oYG5RalQCoeZGFHxyeIRExnHv5AzqKa4mVimnt37dr6f
 6lWfQOuLJndNgBXwbfsQEuZdM8sYmNJ/gn5PtgUlSuWJnd2OIrce0ESQKmw9mbZny1mXnzMksxc
 CoFqDReuEOQQEg/3mzpcSjDez4gfuKllNn63/86PKndt1XL4gwMsGkaDduDV4avDzGeMdjd8=
X-Gm-Gg: AfdE7ckPVRn6DkwsKV/8VL5h3yMxjaK9yGlbiIw3bZEfYWcfyzr1l7iXI8pQxd7uXNN
 9PNkUwxKo0UrU2BSiM3OpuvodC9s4rYDutsZiWBM1FH2GvEtWnFQIqkaNOmX/s70wVlIj4Tmkcx
 R8YqoMz4xkC+rJjX3zta+M4UxSBKOdtLwaG5MigUzZzMTGLGZDfdno4VNFsVzdQSH0W6fYNbGLa
 5B2x9FrUDgJNixFKdLAuNqZjK5mTymAD/mYHHy4vSRm01Gc23e/nJZiu0Uf5zvn9Be1PMo+B4eC
 G4gCAD1eoemyFpofB2EA7OTYU7dFNU5dq7qgam8GRmmIqdo22bP0JSmX1aFXto237clIyPDTDPI
 MRSLGD5bziGBGWlQ0rLLkff3N7fPx3OJx47FS4Npz/1YsqUEX22wnqLFvFjc1O3Q=
X-Received: by 2002:a05:6214:5a07:b0:8eb:eb8f:a37b with SMTP id
 6a1803df08f44-9077835b93dmr140028906d6.24.1784527900016; 
 Sun, 19 Jul 2026 23:11:40 -0700 (PDT)
X-Received: by 2002:a05:6214:5a07:b0:8eb:eb8f:a37b with SMTP id
 6a1803df08f44-9077835b93dmr140028786d6.24.1784527899666; 
 Sun, 19 Jul 2026 23:11:39 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:39 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:18 +0800
Subject: [PATCH v8 11/15] drm/msm/dp: split dp_ctrl_off() into stream and
 link parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-11-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=3896;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Hm/Z28jFbNNIpMkSUALvMx+PzLChWdRQ0AfWWBpGnus=;
 b=ODlZsMU1OSad2GOkqijy6Bi+SzBmkedQmePHZbWrIu547duYgTj9QlXP2kEZGI3zp/oV9xFpv
 LnKYiY411WKBEVKGMhH9hKl8NKiO4HwRIGQ79KgsGz5GSNqaKuhAx0C
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: Kce9V4xNK2-tz5TP7UsxuGsWq1BdK9_d
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfXzkcBsCPY+KSN
 AbQJAP4WDap+BOZh5Fz+YVyFEpIkUh6B83q6ValLRrelGY1qKprcXsgjI0PH6W0ueTtfVspjJ6s
 p9dTZT9Z1ezzaS8ww8+8o3OC/mMtiUk=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5dbc1c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=btynFov_yHAME20h-3wA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: Kce9V4xNK2-tz5TP7UsxuGsWq1BdK9_d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfXxDIKOJmJfA1Y
 YaFp0dpv6FDX00kWFhEsIvAyA7xdcn+CcMdYGgJ933fSgOQpGGV5KuS24ZsUO9gzu2HCaAfq1gu
 pEMZrVNzG9m1by7jnFzd7+17f6qAGZIkvYJUzm3Y8YBzeQ5imgIvE8bJgormp01LM0UV/j1rdgN
 6EpLyvflOsoMs0Wg3V/5GN02rKGMr7BuhTc7Dtzq6e7SvKh2e/saxc0nH/qN9wZKLJbKYCfvSF7
 +7kLOOAPVI2+aPvEnFYvPRvutnQXSP6I0hJj4n2843p0XMIsFVul5DiJoaJ3KKxdiG6Ns5mk8iy
 ZnoENmeSWCrqCLi8ZNaXxV29o+KsqrjHNYtmFKCvjUpFwIQzlEgy03W5z8+UAm8Qm/kOdI3cWcI
 hA7MPwXEhVaTAMzNDcQCoafHiYrruEbKIH+/eJ6vuVoZ2d9Vbu3nlaq6kHFVQXbSTxNng+OM392
 rttO5+RnBO6MxlUezWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200067
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

Split dp_ctrl_off() into stream and link parts so that for MST
cases we can control the link and pixel parts separately.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 10 +++++-----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 +++--
 drivers/gpu/drm/msm/dp/dp_display.c |  7 ++++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 207643fa7306..fc3fbc40b118 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2212,7 +2212,7 @@ static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned l
 	return ret;
 }
 
-static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
@@ -2241,7 +2241,8 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl, panel);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
 	if (ret) {
@@ -2637,8 +2638,8 @@ void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy_init(phy);
 }
 
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel)
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2652,7 +2653,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
-	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 00b430392a52..5902cf7e746a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -22,8 +22,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  struct msm_dp_panel *panel,
 				  bool force_link_train);
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel);
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel);
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8694f366623d..1ecd700a474f 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -727,15 +727,16 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 		/* set dongle to D3 (power off) mode */
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off(dp->ctrl, dp->panel);
-		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
 		/*
 		 * unplugged interrupt
 		 * dongle unplugged out of DUT
 		 */
-		msm_dp_ctrl_off(dp->ctrl, dp->panel);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 		msm_dp_display_host_phy_exit(dp);
 	}
 

-- 
2.43.0

