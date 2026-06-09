Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BABCD8CA7
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4914910E208;
	Tue,  9 Jun 2026 09:47:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dzxs3kCY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KdbpIdVT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDDB410E208
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:47:34 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6597rdmu1958611
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oLgp/E7dZZ3XA3/5TWWpxvhDXhHZaG1LDXI6Ib9fI60=; b=dzxs3kCYfS5+IF8o
 6Jmpdl01PaM95u5tVC1n2Putc3k7DS4ZnRBQQKUaXJaG3ghxmlBx+DnZK9PBB6tP
 jDVVyF/eyALmXfIGQbfOmK69DA4+UKS1Y9BKuTsIUB9Te87ozAAPBYoLcgRzhPF9
 vGQsakE8fPUlMk1gZVDLLZQL5yyKxfb7MEvAYTXD+mXpRx9RxjLUVSKz83+E1sdh
 RGrBvZLtZiPNJYmFNSnkAYDoB0U0aaPpZXRdEr27dTDXFDhvYMKCbgvPrI85DFyA
 6sri2AaRxaLMEA/Mi1KTtYmgstkZoIMnQ/AZKpj3NXU3cE9WEhfZknb7x2xRN9iv
 ynzwXA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epdds8vkj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:47:33 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91578c374easo1125987785a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998453; x=1781603253;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oLgp/E7dZZ3XA3/5TWWpxvhDXhHZaG1LDXI6Ib9fI60=;
 b=KdbpIdVTht1VBkHZv+qXmo4VKNFSjWrARpA/0wDjKUJrZpSdDLmd0RJOsUWxS1emqm
 6MfZgW5A4AQNqRe+/NfGuAibJlNnNFJC+cIXtJChKPAzKUkj5kefAv7YJH4cPgSWvJdA
 FTm7WUcwPR/Spq1i182OFuH/1HKv3T5d7xP2jHEi4k5YVBkZCDfBJ4WYthAp3q9hgxRm
 XvaVOTNZRtPMoJ3wQgZKv8gv8sR6Xs20DDZpcDyMOMUUANVO5TP9GpwThaCqcgotDPcS
 fCkOQLqzmMydJJy+hV+G7UNG7jVoE9kibmGhsTlyQdVvKcjblN493UaEcGuoK3YN9axc
 8HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998453; x=1781603253;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=oLgp/E7dZZ3XA3/5TWWpxvhDXhHZaG1LDXI6Ib9fI60=;
 b=cp1kdiNBWM6f03mHoijZqvgLYQw5dM+4KRnZlgHbXZePZ4o1+FAnkpneEgozoos1ok
 FwP27UCsSScD0DdV3HwVcnDzIqIYuFBTQ6bkcb5kxx71n3DERlM+83yDh6h8hQaXebks
 Egxb30kaR9KUn0WptpNl99lCgINaLp5spUEfjNZYXcpjLGC69dSRcfRzjFQqD1Qx4XF7
 oCBLNaaDFl7ZarSCdFWzYvyye13/gwUJ6fxe9mhywpeJdbdKG7/cE0uE3jdYZVK4SQ5S
 UZG3cKGSY6IIR/pz8vii9ZK8iBFL9I9D1ZWPn5by4mJXdnQO8kkWl/v+NyyZKM69vIh0
 cJVA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TecE3VWkUhQHByZAmCSXrI1Yxc5TBOtrZWfUvcEIOc3yEP5kZzlBythr7fMzFiEiaod6/6qVa+O8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFMCAPMCgI9KothbN62QotkdDZp8Xmv8AMY69BOWtflwjN9SzR
 qDPCD2PaZ/cDQDBIO1KXIQZQVOHT1+VUHwqUaw3pw9+vOrtBL/LEO5JTM5lASZRvSsqZf13RCGK
 4MLYzFLUStLmKUamAi/7cPpFXuLTJU7lRHT1UR6iq1a2UdBoqDhaO1X3GNluW8VewlyaWAtI=
X-Gm-Gg: Acq92OEz8KEi9ZOuKGJiZcKGQ+9mVC0iVeQ1D7GQl+STHY85N88ZazDFfhtvwzNezDu
 uOGl1s894g96Xer/BOiSze69w5wY0G3vWYuUW61k5QQwPEPgMrtJsmItL/rPcF1IdTwdrVoXPmy
 4GOsxJBYqhs8YBJ7mhX4b2gHLGgEbW4W21gUJ/Nc6Cos8Z+D85hohkFau+xpxOq+leeUAqffJAB
 C6iZEnQnKEXEFRLy1LISoWTfp3/8dAXfpF+97eF9whYQjzm2ygQNMIPq7/XVhJ/wAJSRG6vodsn
 tbdiDDv0ffv/iVV+A3Lr5apXdcBvIthLBoLBjYrrSApc89P9IyhK1Tlwz4hCiuXZ6pJka3V17pM
 1VX/apfvy7RevEQQRxSo3igbAioJG1ZKz4NnHjNUXurx3Lc4S/C1HM1vtPz+O7pNPWs9FiNzToe
 CylYnAPasrnatrjzLiAw==
X-Received: by 2002:a05:620a:439f:b0:915:94f7:55df with SMTP id
 af79cd13be357-915a9cb224fmr2865692085a.20.1780998453304; 
 Tue, 09 Jun 2026 02:47:33 -0700 (PDT)
X-Received: by 2002:a05:620a:439f:b0:915:94f7:55df with SMTP id
 af79cd13be357-915a9cb224fmr2865688985a.20.1780998452904; 
 Tue, 09 Jun 2026 02:47:32 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:47:32 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:33 +0800
Subject: [PATCH v7 11/15] drm/msm/dp: split dp_ctrl_off() into stream and
 link parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-11-ea04113e8233@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998393; l=3896;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=V50+Rq87Zu55c599ZG/HVdfIbWqRw5QteR34CLOzRzw=;
 b=8JtMKVjwvmt+e2ppGSAUvJQoPjq3T1WtagBOkM/lfK/BuBRO77wxwYY/FIO5Pab9ahzN7h6gP
 LMLAdP9NbyyB/maC8ARI2xEfYlKpWMkyhoso441SKCsASyP2Aetvwnj
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: OC_LeLTq4PPLN3TVVfxegSHyqF9Q0DWk
X-Authority-Analysis: v=2.4 cv=EI42FVZC c=1 sm=1 tr=0 ts=6a27e135 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2kxiPxfbkJi5fZIrDGYA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: OC_LeLTq4PPLN3TVVfxegSHyqF9Q0DWk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX8GFbzqwiQsmJ
 mrEBNzjUiGgBKDaolGzls6vg3m/21CJm7YOQoDIwGKjLsSbuXY6Z0vlL9jUFl37do92V2x2PtVv
 OvZr0LPyX7AehEOBsHfzO+Rc45ndfYDU5ZWL3yaR1wugVQYSIJIO4eaGHjLGCWhJQyQKkryEQ9T
 gzrnGqPGkeF87UshTrksZaXIMLwS0tsaxtc8Bj6JQisIRvOKOfk78FfRinm5bPMQBVK/ONqwNnO
 Sl+yJYmlN/wurOS0tKKYhELkfoDW1/ciK2yUxLgETWnbdKC00oKC6/Gnj2LDXgcSzfHjkY+Cco/
 0B90rzFbJactWx3KdTSlk05X860NjyiEtSLk5Lqr3qrq3Pf68YX0+7ZoSu3jTnr+HR5OQ/+dXnq
 /Gdxg5SCf/g+2xlUw03xaFgWyKzD083+SzqYutgCyh6mFoc8mvCvIjThD0pjk6xAfr2V6X6JF/O
 X1fZRv5jNv2ZVwdVE/Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090090
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
index 87c3a5517911..90fba03de7f0 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2211,7 +2211,7 @@ static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned l
 	return ret;
 }
 
-static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
@@ -2240,7 +2240,8 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl, panel);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
 	if (ret) {
@@ -2634,8 +2635,8 @@ void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy_init(phy);
 }
 
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel)
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2649,7 +2650,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
 
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
index 230e14615a23..8f472633da82 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -725,15 +725,16 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
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

