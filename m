Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1386E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0570110E912;
	Fri, 10 Apr 2026 09:35:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MfCONS6+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g3qCXMNq";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1D3E10E911
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:05 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6q8Is1730055
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LOIx/TATXEJZQ6DVuX7THLXDyKxWQ+AzVj0oZiDVfpA=; b=MfCONS6+S6UgPFTV
 5Z2cK5Ge7e+jsV9mjZy4IDSK8NWQ/f2Tm17KDEXYqxb7uoIbYlII9yMnKkwFQ/nG
 VfAvrG0OttuG9RcC+kZdjHqwCazbH8PMXropBECfv4yTRjik1b1BxawqS0fAGAkX
 JwgRKYBoYEy7Ixy/wXEb17+DHKr/TVO2teC331uIPhPL+GRqO68oNaGW4gcUrhLS
 xLb2/0neuu+x9QTtOk88Qh74BAFGqKqFtJkyBB/qZwRabs6CZAcpiePMzW6H3VBm
 HFh5nVxpBiQD2Ke5/6EyX1nkO7km/w1wcWH4GxQ8z/RgTtC9omxVcODo2XLHCC+a
 ujE5pw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxkn4f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ac04b2fc4eso54769496d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813703; x=1776418503;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LOIx/TATXEJZQ6DVuX7THLXDyKxWQ+AzVj0oZiDVfpA=;
 b=g3qCXMNq/+A/KoJvWlIQ0oZKoRd8uHdaa2R9EC+Y8mnbPDanX+Fjxa03gHxPyLwBoU
 T6d2GqdKqe5rtxKd7UApcWxfUF+0VD0GHn59VAuA+jSXQvcXWB2Lk0h7Sj4YEQWtx7C6
 8aWp3G4QJMRUNODS8XVDUhqwJwcwt6O4Hb5YopXxRfKdKxB4b6K8QXE1QLvzY/MzRIiw
 MELdBigeOIo2U+UgxWOq8vIrF0S7E/DXSIZTdiYsH8uN/s1eY2fX2MozZkVhF9e7dDND
 z87lIA7LI86moBWD1YKEC+X9rz/AiI/tH0IKKrgoorEOCXO9jgC9reas/mMc9PFc9j9c
 hV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813703; x=1776418503;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LOIx/TATXEJZQ6DVuX7THLXDyKxWQ+AzVj0oZiDVfpA=;
 b=NwZh0gpzyxoPZ2jjZEdNgNdxYFnbjpTLH9q/qf8FL0eRqP6u3ruXS1/0kKdyL7Ui1S
 w74ZxaVeqVp8Csu+sDZRgZaMKyqx3f8UvBOixhpoBsmLieK1nXLZQzprTbbsI8qB0TjB
 FOKrbKShH1R0TyusY3AOUIe/h5hQecT6w2LG0a9ZBylBRTRf5Ot/0bavHZa+K2BvqSZI
 kU457lwlb9r1EEgSs31KoHa+1tlHnO7TTi45WaV4E+sObyITpQfFAFjcku2pUk2PZI0r
 YvpUsN0AdN/kGwSlkwXrKChTKwInL5mhRp5fIX+Hjqm5znpUr22PXAUvh7dGIjaHrtyV
 PCmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsaYkQcby2WaLg16bKD2M4ZVQFAVILNurAvyVCE3YG6a2Gj/WXsGqHNalJvhAjRQrnFvbYtko5Hgo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJxp/h4F1Av30/z3/KWz+u+gOLD7FyTSq+wXir6g5yi/NWsTJL
 fgUWIGddpm52hYsJyIhWfEB/NSlKikoMm+Pleq69IBEGBu/hVe77qkJvFHPhsAo4ms0nOxWAxRr
 2m+zqyUhkiWjURYpEVlQVc1SVFCwVLF5JnK/avy9GEVJ+PlPQ61P8NH8BUYEKR+VsKB4I7/s=
X-Gm-Gg: AeBDievYANj4wXg27Kt8X+ABMaNsIuftete5xjboy0Bi3teJOnK1a3XdEndSLkt0ZBr
 EV5H9DT+0KmWLrd07aP0oa0BP7fhlpk8haKRUYsIH5VZsXMpHNGEF+YEGSZoJeMGJPe8GyfMVkB
 wR2XOanmI1CvP1QUxbYe3nijXTakz7wgo9I0TmUcy22JaZKAJRvTyOQ5dQFyoqWhbyvFX26K0jG
 8HYhP8jMmsqZ0aSJbolkjm0XN6Q+UPqix3Rq+0bTPx5oCQXbPwcGltyOrt3OvYZBg/0Cq5JdH8m
 3ISCuaxNa8jbV+qNjpujSUp0Uve5gawVnPykN7VOT9nM8OhocU/wjf1MiCisLtJuYPoWs3O5ozy
 4AxXyqeT8HqgboSrs8ajZSZgW7//OpvqrxZprFLTNXgh9LsyQkgRQsIPQn1zDEmtIlMkEc/OxUd
 TPdKW2a5c=
X-Received: by 2002:a05:6214:808f:b0:8ac:801d:c3dc with SMTP id
 6a1803df08f44-8ac860ba87emr32732056d6.9.1775813703022; 
 Fri, 10 Apr 2026 02:35:03 -0700 (PDT)
X-Received: by 2002:a05:6214:808f:b0:8ac:801d:c3dc with SMTP id
 6a1803df08f44-8ac860ba87emr32731656d6.9.1775813702475; 
 Fri, 10 Apr 2026 02:35:02 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:02 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:49 +0800
Subject: [PATCH v4 14/39] drm/msm/dp: introduce max_streams for DP
 controller MST support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-14-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=6181;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=plU7Urx0kW/l+Yq+gBI/qNvhT/6gNugtooXNAjfVfZs=;
 b=Gg3H2ELuh9AzuIzDB66IMGb489kZ2605TppVgxDeuy1g4Nr7k69mz7TAQtt6Txer8Heq7mYbL
 JOMF3iXz7ZtARwpnkcRp9CU6AfOFZv30ENs4bgHHiI/mqSikvRkfLPY
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: dQAbMBqVqMeKOTqUpgCL_A024sMazkN5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX/pHohqrQ8RUU
 z6jn7Fl1xRkYlLZpEDqC3vg+1ImjP8y6ZI9ptcpVLco0ZOX2oey0Sftkabptm1qhO8JmlZ0x/ma
 2LijmD6d/qRWDcIKa53ihVLfqk7VF/bBd5YnVQeULftKKZYKXsWb58ERBkNUK0O+YaFN2TpCCqw
 +j58AA+gI6RpDeW8ND/KDv0MeJf6e6Mqgl7s1kn87GJpnmsIZVrslqkTzkf9/5GxZc9bHAhWzUc
 OYn+DoQ5ElG/VmNqJG5y5mz1vsL8h99yATPimA6Q/D+gwSqzYPBU8XgVgK91g8VshiCyqtTxGHt
 K+AoJOwUQ0izurgFOBJ8/qZ3OFQH61evwz1TLfynoSTxpwvEvtBxDTamaby1ICTP6d/FYOUr20M
 HVryFzsU7DEEpNus2f8tWTWJVclCKZHLagw9GYfsHeaxt8Y39GN/u9NeBVaer65rqxRm3FPUEqa
 UjtocSeDTSpc7UeUt8Q==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d8c449 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Zlm8kRnIXfIeTuhDwTwA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: dQAbMBqVqMeKOTqUpgCL_A024sMazkN5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100088
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

Introduce the `mst_streams` field in each DP controller descriptor to
specify the number of supported MST streams. Most platforms support 2 or
4 MST streams, while platforms without MST support default to a single
stream (`DEFAULT_STREAM_COUNT = 1`).

Also accounts for platforms with asymmetric stream support, e.g., DP0
supporting 4 streams and DP1 supporting 2.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 20 +++++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 ++
 drivers/gpu/drm/msm/dp/dp_display.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 4 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index fb6396727628..1e80d6fc7bda 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -128,6 +128,7 @@ struct msm_dp_ctrl_private {
 	struct clk_bulk_data *link_clks;
 
 	struct clk *pixel_clk[DP_STREAM_MAX];
+	unsigned int num_pixel_clks;
 
 	union phy_configure_opts phy_opts;
 
@@ -2707,7 +2708,7 @@ static const char * const pixel_clks[] = {
 	"stream_3_pixel",
 };
 
-static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
+static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl, int max_stream)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct device *dev;
@@ -2740,7 +2741,8 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 	if (rc)
 		return rc;
 
-	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
+	ctrl->num_pixel_clks = 0;
+	for (i = DP_STREAM_0; i < max_stream; i++) {
 		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
 
 		if (i == 0 && IS_ERR(ctrl->pixel_clk[i]))
@@ -2750,14 +2752,26 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 			DRM_DEBUG_DP("stream %d pixel clock not exist", i);
 			break;
 		}
+
+		ctrl->num_pixel_clks++;
 	}
 
 	return 0;
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
 			struct msm_dp_panel *panel,	struct drm_dp_aux *aux,
 			struct phy *phy,
+			int max_stream,
 			void __iomem *ahb_base,
 			void __iomem *link_base)
 {
@@ -2800,7 +2814,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link
 	ctrl->ahb_base = ahb_base;
 	ctrl->link_base = link_base;
 
-	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl);
+	ret = msm_dp_ctrl_clk_init(&ctrl->msm_dp_ctrl, max_stream);
 	if (ret) {
 		dev_err(dev, "failed to init clocks\n");
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index b9f0705b03ba..6fed3ff3a72d 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -29,6 +29,7 @@ struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
 				    struct msm_dp_panel *panel,
 				    struct drm_dp_aux *aux,
 				    struct phy *phy,
+				    int max_stream,
 				    void __iomem *ahb_base,
 				    void __iomem *link_base);
 
@@ -47,4 +48,5 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 736b621c0531..7984a0f9e938 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -87,12 +87,15 @@ struct msm_dp_display_private {
 
 	void __iomem *p0_base;
 	size_t p0_len;
+
+	int max_stream;
 };
 
 struct msm_dp_desc {
 	phys_addr_t io_start;
 	unsigned int id;
 	bool wide_bus_supported;
+	int mst_streams;
 };
 
 static const struct msm_dp_desc msm_dp_desc_glymur[] = {
@@ -567,13 +570,15 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 	}
 
 	dp->ctrl = msm_dp_ctrl_get(dev, dp->link, dp->panel, dp->aux,
-			       phy, dp->ahb_base, dp->link_base);
+			       phy, dp->max_stream, dp->ahb_base, dp->link_base);
 	if (IS_ERR(dp->ctrl)) {
 		rc = PTR_ERR(dp->ctrl);
 		DRM_ERROR("failed to initialize ctrl, rc = %d\n", rc);
 		dp->ctrl = NULL;
 		goto error_link;
 	}
+	if (dp->max_stream != msm_dp_ctrl_get_stream_cnt(dp->ctrl))
+		dp->max_stream = 1;
 
 	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->link_base);
 	if (IS_ERR(dp->audio)) {
@@ -1208,6 +1213,15 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 	return 0;
 }
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return dp->max_stream;
+}
+
 static int msm_dp_display_probe(struct platform_device *pdev)
 {
 	int rc = 0;
@@ -1234,6 +1248,10 @@ static int msm_dp_display_probe(struct platform_device *pdev)
 	dp->msm_dp_display.is_edp =
 		(dp->msm_dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
 	dp->hpd_isr_status = 0;
+	dp->max_stream = 1;
+
+	if (desc->mst_streams > 1)
+		dp->max_stream = desc->mst_streams;
 
 	mutex_init(&dp->plugged_lock);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index a5c6ed5b18e4..b0cfdf215970 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -26,6 +26,7 @@ struct msm_dp {
 	bool psr_supported;
 };
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
 int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
 bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
 int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);

-- 
2.43.0

