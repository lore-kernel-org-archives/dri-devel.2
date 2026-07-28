Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1B5C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B92210E85F;
	Tue, 28 Jul 2026 10:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Gs4+pObe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hm2dXKTq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD3A10E86E
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:24 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82FsU2026982
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dEgBbhLWo+6BBjEmNJGllK1JmefhGWnjeDK6DcbRo20=; b=Gs4+pObeTIlv7vmM
 fJ7xT+jRGZk7601Nc412WIS5nAg8BYNGsFAYpL7F7h3C4J2RTf2ObL5OfKq4CPqv
 IN3TNueslBLRBND5ASTQed1ToRyktwJPzmBEOsEA2+KPq4vnabTRGjbc5ifs4iMl
 hgFQZTB2UzB1St3RTzJTnJH3YseZ20kzNUUSfJS32f2gwC5StNSLtwgnTtvm+lNG
 VaQjrzEzbjQ4rydRpuJA7ugi5magUsHaudiAfF59vZymxL7/+NonqLQYCyzmRpjg
 Sg3lNvB0fLNzhS0QftBLXzFF/qzAG3Sr+wtlcinuU3z3QyzhP0vfwC6o/z1g+9v1
 CEk9gQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpq9hgwrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso14894121cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234143; x=1785838943;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dEgBbhLWo+6BBjEmNJGllK1JmefhGWnjeDK6DcbRo20=;
 b=hm2dXKTqIkd91ZYAIWWKnEMvVU5U9CH3kM0zOEbMOMbb6K0MJEYTrzrlqUvU2x7WWd
 +VYccg6jHO5GNt8pik6KhlM/aX6BWGDchkxBEUZfwVLJyD0U2MPIcjFENAgvfMOR+lts
 8/DQO8/PmKgNULMsizffaqJqsYRTlwC6s/mEmf8D21N5XyVeYuqSMSxT5GNe8LYGleN1
 +eybtaSQkceNQKLfdTB5cwwmQ9BvdcPlQAlnR/+3Y68EI8RJA3oszheZ+KqO+ps2hHoC
 rLP34YgyvNRqCTRfZ4ey1Qd86QMCr9yVMpq7iozuhpOGGJY5na0ZqcaWfTjDV81Sh9DL
 Z8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234143; x=1785838943;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dEgBbhLWo+6BBjEmNJGllK1JmefhGWnjeDK6DcbRo20=;
 b=s2LYvIVUgNcloB5z2MB4ce7tDRGQzwcGNrTtZ+Smdr+9hBjLDh+5rqx9YpI05TZyHV
 KcrGLIvXA6yfs0wWC4QnHNVtr77ptK9LS7t9uHfxzeIomjCm/J9zcAF16G2o++//CAcf
 y+BF0nvKkkpvqMgQ4f7AiwwQyd6ETi3cn3EDr1ARKYASGibUBd9SEs3axjz8WzieZ2RI
 JMgZ6LaiRBoDRgC6mzhit4IWOsoojH3OdnunzRkKdFKAv/UnJhGnD7Ja+aekircn8erM
 c2wCmOHxnOOmbC9KEckkGmcdKbWpZi+qj2wmT4n+9s6942qTDb2BxKED32R++JH/T9Ls
 RtMA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPx00kDIFznZfnnnTRnmghU/CKwVos80bDZtP8QCT87Yv/sw1NPkdX6oKDeZOzpPWHTT4Zo58GR4U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPIPe5T3H1MLG8rapFt3cHFBG/OWQfaM88JKoVFCoqkxzXRnY2
 uXnFBseWW3bKh5bfYIJ9Ud9t2gEOgKGzlQ+MmHKJIlLq6kafmssC+s2tDwOGad2HktjYkc3Y1Zh
 /6C+xsaa7ov8dmDKjI+jzwMDfwF3R3V326krm4Oi+2qw9e+T7pM7ViMFU+Z4f8yoXVuZ1mG4=
X-Gm-Gg: AR+sD11uBDSLISXzreDDFRLrPU2CytZIB75JuGTVfZFUqhtktt0lEdMTw9xpQ/Rj1vz
 BBv+s9b6Y2b4j5WaMtH2BNO5pfnHyZQtUlrLX83o3+AS77PJuZQZ32BZsDCN148tHn8gIi6k0XC
 Lc4+qbEZUhwV8nKozwSYAUx5rjyDMux3MqToGl0Xrfv+hx3E+oKet4c1PCccCh+9VMVf4dNEsq0
 TY8uFPSjrInL73Cdx+d/7p1ioKx4ZInRpYrCApBfz22y3r2jiKOlU1zjwjGgWbqGc1neXj63Egv
 n2Fptv/fT5/I0Kk3dnOD9ZojwoQAwKcwi6R4+KkJEXSki8jyx1sA7fQYaDN8NSLSCpB5/iy8mbV
 Zl0IxoGc/25iihziPIdIUef1hA3wvvJ2qa5k52WjgvRCD41omxJYDivfDQ77awVw=
X-Received: by 2002:a05:6214:3d99:b0:8e1:4508:ee58 with SMTP id
 6a1803df08f44-908172b3c28mr17238396d6.40.1785234143403; 
 Tue, 28 Jul 2026 03:22:23 -0700 (PDT)
X-Received: by 2002:a05:6214:3d99:b0:8e1:4508:ee58 with SMTP id
 6a1803df08f44-908172b3c28mr17238026d6.40.1785234143035; 
 Tue, 28 Jul 2026 03:22:23 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:22:22 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:38 +0800
Subject: [PATCH v9 09/14] drm/msm/dp: re-arrange dp_display_disable() into
 functional parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-9-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
In-Reply-To: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=3890;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=RsF+yW3Msa3coKJSAtohUOHV79wFxjILMeiibWSV2AA=;
 b=h8q/J03hPk2xyS9hQcrUH9M6orPLA2Ns7ztzWF6I97C+inPhQznOBHZzwbmGjGzrd8OzbhZfo
 /PD2BTjwKPGDF5+KI/5MB3VVBzcEGWr9cjpLy12+A3fQvMjHCvA8cS9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX9JbFT/gL+rjw
 j0C1dtedrRoUHIj/56mjM9HMAAf9iExmZOXlKINmcNK+N8Cj2OTJAmFYnZXZW7SdXMnAe7/PE3C
 ZJxDovje9ONEGQ+wtn87W+ZaQTtrvAo=
X-Proofpoint-GUID: Lz46vzx_nIct3YQR-IzQDU-_MdLySibG
X-Proofpoint-ORIG-GUID: Lz46vzx_nIct3YQR-IzQDU-_MdLySibG
X-Authority-Analysis: v=2.4 cv=Aa6B2XXG c=1 sm=1 tr=0 ts=6a6882df cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=3ttbkIfPOWFMAE6HwJMA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfXy95M2iTt3MKs
 hbRzWQaSrBknJOTe529kAUgEEc7YnehXD8krmRrFoUvN5R2fsJcBkRw73ViPdJka4EOrI2fhU8h
 ltLYCQaqAw13UQN/h3aNXoyB0XoEbxiCSv/sMDcPRBzYg0g4U+f9epkCiCN6tCdPCCt4W4jB58T
 LUNNaMmdA3ZxuJT1RSXqQtA+SKbmelc+S5uNGWdv7+f9ppQUxASiV1g4njZyLDgJeDXqypY+IXg
 WnI+iXbCs6FNLObPEZuKSkZ1WOBUyjt8GE+aQRcvJ7ZLlBwlYzv1TKMDuLOEL31DUVwdRzLyV5J
 4T0kJyjmr00JemlOBZDiCJtBP1xK9wMlr0rO1zdeOwaJBrMG8gsEsYA4HBWbHK/a6fu4fpxaKe9
 anAPfwOv6W63OlDQ+07OI/LX8MPzwSTIBDW95tWNjucuVjGda3gb81JBToSaZBLktPOmAIL5Cm3
 bzZJMT9m9ikE4Dy5ykA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280091
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
index 43094dda3434..272ac3b25b13 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2605,7 +2605,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl)
 	return ret;
 }
 
-void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2613,23 +2613,6 @@ void msm_dp_ctrl_off_link_stream(struct msm_dp_ctrl *msm_dp_ctrl)
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
index d094d484474c..cd8a3b171d9d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -716,12 +716,20 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
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

