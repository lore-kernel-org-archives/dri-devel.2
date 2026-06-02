Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12C8CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40FEB10EDAD;
	Tue,  2 Jun 2026 09:12:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nc6DvaV6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hdj23Gq+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2380310EDAD
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:12:07 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6527qUvc3132999
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Re9bQbGzhFUu/DwhaF7px31nxHQNbIQ8lgyi807eAgQ=; b=Nc6DvaV6tvosR4JA
 oYrChKsp58rejt9+eaHJ0rJ2iCgrOF33GM4I0Bv+z1OmU7e/sTSDIwDug/yw5u7i
 TTXi6qJoKf440aE0AjBzsLr4xT6epgHORMcHZjP6JFm4pmOrv7oyYsgg8ae4+f1s
 fjWkHnwnkTTrSHE4+KL219MhkrufEpodNXSI6OyBHJ+dTZccRXbuzZzIaYikUd6m
 8paOO1b5y0tCkx9bHzbIcHMeUst330fhjUUK0QBf+iajXJ4i8nTAu0lqrZ5v83xs
 U5KZ/REABHG8Xj8MJzCjAH5EU2ISSY0K+e034u/bbSscPPTa/Amz4EcDd6Zhny2m
 EXKlCA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehu5wrb0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:12:06 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-516cde13e8cso240838561cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391525; x=1780996325;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Re9bQbGzhFUu/DwhaF7px31nxHQNbIQ8lgyi807eAgQ=;
 b=hdj23Gq+QCkXPXpStdxLHtqUsDBIencYWJe9VoXbDkNZXUXjHoR640HN1IqQqJxgC+
 yL+gl64sMdF37jGTDPsQseJ3o6yA0M4sFvci6oD5qCGHYIZRPskBzXqr+HXJOGA1w7hR
 kDOr/9O5SHAz9982WGPh8Bv+HC5RB/IdLqqzq/mrBSxGWrjKK6JXrmXSA9mWvii5aFaa
 HotyMwLSuJL3HPZBNX/kQMZUBLfJqsAdcdoMymJePhiQFOQ+tEHhtSkoM6Df6cePKsQG
 hGxdkslorQVxefPDAyLXkANYmokh9ef/cbM5jvxxKZ3WMHkHz2VCtyfvZx3PFkFenUIE
 FDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391525; x=1780996325;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Re9bQbGzhFUu/DwhaF7px31nxHQNbIQ8lgyi807eAgQ=;
 b=LCNqGB83d358wvrPUFyvuuQ3aT+v6lum9PZb6SYF8Nx+KRBm3sfBZRyl9rF0PKg342
 GjZokWvfX8DlRucQtXMF/oEk6aXEGNf5FJVQnjm0Nv6XUVqrHZxiJ8Jj/9n7VyVxPk65
 lDDlwjY+4uvQ+OLKg8cbzh4Euy/BibpzrKcrVHd4YkAgUozF4tcEwbd9wvn/Fj4ZSWzW
 17mrOwaghp3HoDrncdUpV1RQ7FQJwtDL/MRGQ2CKxvQ247RPxg+ouCscLkzuJf5DfjQs
 5wqQIRN4VV2Pq6rfq8DgFqRZ15d/4zuv90nGHssaDoILEzRzriGreX36NjCoe3TS0exG
 VnZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9sWpI9Nu6cglda9PY2jzMOlJvrt8w+V78Hs2qJCVPuG7GYeuE98Xz3Xstrb2GPElL3A1LR/rdZ5IM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywv9f2i0EIM1Kf8XiCWLcIENFqPufPAPhW6vezqgrY+u9WU1ZUg
 zG51q/bUtKjF4TR8pGGJ86e62XWdjs1wHI6aq6kzNjFdfq1+yUA9vXArlnkMPF1whsv6IRDW0eb
 1JCHVJLMdxmMPZ2ZoR4j2EHYIvQ9JQPaUcJVYwmJ1UGhIxppH7Jo0conIjjFx1a+6uUgvBHQ=
X-Gm-Gg: Acq92OH8z7wTdWUrvmoG0w1eu8zJ085RkR74+SDW5P9n/SD7E4k7wMWcGdNyuws4S2F
 XyOfVsPAdotsboZONigrh7W/iYzAFYQMdEpm3MvIJwrLy5fvWE9900kTHnqaX6aTkdzo0K4l3YU
 F1IYGnhLHO5o2ZbcQ8cK9A6Exj0+XT/0I3+6ESmZhj63Vb9e0Rd5vtvqeI1/w/obggRLYpQ8lwV
 yxuQBQ6+bYPJxZjS1VtkKLItJroWLxZyVm4trYiU/xCsIkhiNvL7lGNFqG6Do+U6raxu8IVhoR3
 o38HaA7kPc7QFwdpS01pehWrAf/xZGoq1n1kUPIQsRTbtbCi6NENwNmxXSJ1IoUp5G5F1knEqQj
 StASO+MeKjq88J/mmefHIO8kHMlk43WJzBQVgMYsOm7ddFVDiuW/8iwaIupsXX6BIJq/FUzURiB
 EfE7bVFfDEikqSvOsY8A==
X-Received: by 2002:a05:622a:2a99:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-5173a817bf7mr147694441cf.36.1780391525595; 
 Tue, 02 Jun 2026 02:12:05 -0700 (PDT)
X-Received: by 2002:a05:622a:2a99:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-5173a817bf7mr147694191cf.36.1780391525127; 
 Tue, 02 Jun 2026 02:12:05 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:12:04 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:21 +0800
Subject: [PATCH v6 09/15] drm/msm/dp: re-arrange dp_display_disable() into
 functional parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-9-2c17ff40a9b2@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=3890;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=4Wm5dEjIlmt2dcJEpToKqMf/8eYUPZtjPLztPMLreZM=;
 b=q9czTavEj55EDD0AC9Z/pXgndqDGASyPrB0KPxwVGUMSDYpltbQSYpgN4VQ52U3vd4U83sncs
 RnAAe8Hddw3BAlPxYuDw4b+ZzuwYkZXgka4Ug2HDZ4cKBumqFN7Lib/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: NSlEXrpVsyMZ9S-MzMaB3twKkJdqlPou
X-Proofpoint-ORIG-GUID: NSlEXrpVsyMZ9S-MzMaB3twKkJdqlPou
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX+EKVTzd1zFa4
 PtFQy7bpS4kbx9qdVKGnP8IdYeRCUHV0S/q4UpMpYKofpYZ+lrX29/UEVVGML7vpMmbfQXAZB4u
 LGm6kYFE+vOkkeLlJWJpeWiuIb2nG097NciCiHOvTBe/kjUvkACBFzgf4K8LRegPtVXSp7B10kq
 M8hHIRLX69zVQxvO5qJJVEjVml9KkKLhjclIiNm4en7Q1RtqxVCMlskuDOd9JiKA+lRQJES0UDq
 F15RSxAnVPf1UUpzEKqsPYRsbz948ZdBT8MJZblM4GxSIYM5Xq1qQi5m8cgU5t2dHfRkB0SdHic
 +w2hxZfb8U5g8MK/10Ou+LrSjHh4qEIbAvo4jU5IhEG0ZrdyB1wvSwHhLKZCoXpCni3tD+j/aWp
 rIRBjU36fzy3F/RnWF+N9WSIqn9elDhXLsU50wk/3g112CigOaUKH0wHNN0zejbqvQ9RLx3plwA
 eC7UL08S2NTFw1MaVBA==
X-Authority-Analysis: v=2.4 cv=M/R97Sws c=1 sm=1 tr=0 ts=6a1e9e66 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=7LH33tsxRIP6uNRhSrAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020086
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
index 002141a02073..d0c5ffb907e5 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2599,7 +2599,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	return ret;
 }
 
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2607,23 +2607,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
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

