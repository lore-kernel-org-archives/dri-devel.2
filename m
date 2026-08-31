Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDA60C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0612510E72E;
	Mon, 31 Aug 2026 08:18:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqkyT/yU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JZ5gSos9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1289810E711
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:56 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xs8e1844173
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oaPo5M0vubGIPHWKFbNCSUTBOWK/L1ss5J8dnWQ1Yq8=; b=WqkyT/yURbFc9YKJ
 VEuDbdgm8yet2/5k9rfUiJiuoDWxtpwvYSp1HrkiG8eHGnEIQH1vq/+Za7Ol7iT6
 uV16MSm/xWt5gVzKVusE9NJd8ZzuqjTZ2NcDyPk3RPHFzfFN8QlFeS+zI2VaUrjL
 9xdSx9cvUQnKLt9Up1nTnkopynSSJMC81RtFJGbastY0Y8MnxHyziBtEa7odcvox
 ukIiHNnL7+PnfD1op/aranYaH1Hdz+34CBeixKbOuqQXZ+KeB0LxXHtmfBQ+uIWg
 Cto5SCnfLXLCjYrifNGoetjOb8QCDN8/o3Zib2FSG2D9LRTtAB07nBc7ir2XH0bJ
 zn++/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrkgw6rs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:17:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936e393061dso348841685a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164274; x=1788769074;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oaPo5M0vubGIPHWKFbNCSUTBOWK/L1ss5J8dnWQ1Yq8=;
 b=JZ5gSos93GKNLaYHN2zyIn2I0g58fycF/YKcytyN92fVJiStNpFpzo+/8vRkHf0ME3
 FD7JgSmSuzZZUYoLQvAVs/RV5+ziyTFShU8QYzmCatOhnUYvszx9fbCraLrTcbrzaATh
 K06UAGL5gAOhFTm7dxsAJtICDPt+1hRTcqqyhUTZC0CmRHOrOXo2WTw78HI7jyzjVQZz
 HSvZYPzZhVEQmHxjiCjJRuXkoI/j0mxw4/5lDV+4fB52ksmdFPOXEVQISASVr0EXQBDv
 xoUAMcnqDEh7LFaqhY4fyAND2SsimE3aDbjNmk5MR0ats40gHiQHY9yxEHh89K4ShZDD
 9lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164274; x=1788769074;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oaPo5M0vubGIPHWKFbNCSUTBOWK/L1ss5J8dnWQ1Yq8=;
 b=KfTtyhXYRvYAzj0DmB3x1VOordHFWD5QI4iI/WypR/FRlDHsShGTkZGPZkm6IPHlRG
 KtanN8fmbdyytg6w5GGS37rz9Zd/GifOzBiot8yCLnOAZWgYOvrmflp3ouccrIfrdzL5
 LDQZl4x5DGfVyVnUXPkFp7uE1TaewhU+SA+nJY/1Z5TTf+wIIUrJfOGdaLUHN66TIvC3
 zy4lg1YzabLRv7N/RhEUs3Iu0ZUAvoxYz6fqrvUVKCI/wVpvk1yYEzORemEKf4ujQIXD
 aACrBsdI+TDqBsPTTX94O2uiHke83z5cl3UYaprJlu9PFRkYlFTkqbZ6rAsjw6xjmMf4
 8sTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDNANe062zvV8u3RK0L1G90y7S48AYmmMlsy3YnsLyvs+NL48+3PIAGmeD9+4OVgiB3qIqXRe0BNk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mHz0hapDnmYZTWLZK4wlbGZvecprrjhd73fGEw8Qahe1X0XoEG
 qikgjEsnEnuuASIAfa0LTl0EJHJuAFsYy5d/RwHUeW3y8CiqHTyQE8zMztCGmRhZs8VvhA4y0ku
 JMb3znXJQN0zFfm+WRDJ8MkQmb5q6UwOa5v+pa3zf9IDj+slg2lVnO4wKJfvMKeDOhkNIF4g=
X-Gm-Gg: AR+sD10ALI/ZMQg9IRZhvHBLR7vlsYfzoYuVkGiW899j9BgH8Q9CWP/HMrA5rbv5ZZ5
 Lxxa1RgtIRkRvI+O5uWZmEI5uHReLKAAXITeAubHA2EcuGEpyrtuF/F4no00lSKqUrxejsy4A9b
 IxrB3yo6EYVCKeFek8vus/V9Z7DVs5C3QRXCUNYqs5ar5cQBzPnXvjf30RSklvMl7cSo7XjupuP
 O+dxda7y+ZwLfvfqnkL2icyYaas4qI1n/dfMVwve8MESJ+Yc1++Ltc2OPlA47mlHfjkjGeFRPFN
 8l0qQpawEKgA585JTajQI8P0jV7qoyVfMSawmiku9AIcYvKDAVTgi1hCjb0iCeiHBDw/DEAUN/n
 vhx0OW9AuJ5fGrUQHatI4M/+ajpbXbl00ifbRNLrZHN5j3IkXxNm5IEHd+J+dVBQ=
X-Received: by 2002:a05:620a:319f:b0:939:1d86:94aa with SMTP id
 af79cd13be357-9391d869669mr2124993485a.39.1788164274226; 
 Mon, 31 Aug 2026 01:17:54 -0700 (PDT)
X-Received: by 2002:a05:620a:319f:b0:939:1d86:94aa with SMTP id
 af79cd13be357-9391d869669mr2124989585a.39.1788164273726; 
 Mon, 31 Aug 2026 01:17:53 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:17:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:21 +0800
Subject: [PATCH v6 04/29] drm/msm/dp: introduce stream_id for each DP panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-4-c91d35d6fb9e@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=10495;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=9yWO//dmd9+SjrW9QTJuYbxJVK8QFQv2ebQc1xIgTYI=;
 b=KeF0x8R7r0JhV1TenlHi6ews2zmvtR6F24xSWSAOnlkutPzvNyQ0dfHNEfc7C3LHszzXgZUqy
 tHh1PGwmEjrCcZr8s6UDzuPQ6aJIJde8KeQFcZbkmi1naXeGPItjM8y
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX+G4SiJK2dFHW
 dC4n/MZ4vb/4pj+2GlXp2VNUyB+Hs9ljWQ0utJKf81NCFkwuuErJInn84MQVCbyDhYouMbCnfGQ
 JhysR+cqqaQB6B03ISgMaWVQyNJJL7qswRKUZZ3RyGbYKqtbl/aw2L5WAzk3GVsSWetN0jUPEfG
 rJdNiHWJdmAu5dJhHx0+GQ3i57Jsghg5B1j+39z3bVEXBPK2lCra5fAFzPT8P1XeCXtAJUHThE4
 TLNkMgON0aoblUSXthBF56tCyNIKIhx8egeo3fJNkJNqvsbEXa6Eo09McdFrvaxykgxiankMMuo
 /Ax2sLmb8bMXeJaNlU2U+UJo2k9Xq+fFTsw/umvwieiJwEusot94QtC7v4JBaq1S4tQokM4WOE3
 53Xh/+rdYE6IQuPmmZD1z3urRhUo8LqDj6GnrSyZWv6zGnF+Owgf2cZ/HlAHHDKpJwCz8GoEmLN
 u3hn4lj6eEHUPV7zolg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX4GS1BVz203RC
 Q9xPbMDCAp5phIdudH7cmRZaXyouYKU9nF1jHusIj7NwZCfYYwp85i/6a8O+tGaJwzkCaw0EfF2
 6wpoJ5OFcnqZ5FC6qijhzP3wSya9IfE=
X-Proofpoint-ORIG-GUID: 5g00ErNMgeQ88mHESt36N1BdFHZeo1H9
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a9538b3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2DdK-DT3ArwjwnIMWYkA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5g00ErNMgeQ88mHESt36N1BdFHZeo1H9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310070
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

With MST, each DP controller can handle multiple streams. There shall be
one dp_panel for each stream but the dp_display object shall be shared
among them. To represent this abstraction, add a stream_id field to
struct msm_dp_panel and introduce the msm_dp_stream_id enum. For SST,
the field is initialized to DP_STREAM_0.

In the MST path, each panel will be assigned an actual stream_id at
stream-enable time by the MST layer (added in later patches).

Use the stream ID to control the pixel clock of that respective stream by
extending the clock handles and state tracking of the DP pixel clock to
an array of max supported streams. The maximum streams currently is 4.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 70 +++++++++++++++++++++++--------------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c |  2 +-
 drivers/gpu/drm/msm/dp/dp_panel.c   |  1 +
 drivers/gpu/drm/msm/dp/dp_panel.h   | 11 ++++++
 5 files changed, 57 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index e7bb9558c0b4..67f1da46b973 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -126,7 +126,8 @@ struct msm_dp_ctrl_private {
 	unsigned int num_link_clks;
 	struct clk_bulk_data *link_clks;
 
-	struct clk *pixel_clk;
+	struct clk *pixel_clk[DP_STREAM_MAX];
+	unsigned int num_pixel_clks;
 
 	union phy_configure_opts phy_opts;
 
@@ -138,7 +139,7 @@ struct msm_dp_ctrl_private {
 
 	bool core_clks_on;
 	bool link_clks_on;
-	bool stream_clks_on;
+	bool stream_clks_on[DP_STREAM_MAX];
 };
 
 static inline u32 msm_dp_read_ahb(const struct msm_dp_ctrl_private *ctrl, u32 offset)
@@ -1750,7 +1751,7 @@ int msm_dp_ctrl_core_clk_enable(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	drm_dbg_dp(ctrl->drm_dev, "enable core clocks \n");
 	drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
-		   str_on_off(ctrl->stream_clks_on),
+		   str_on_off(ctrl->stream_clks_on[DP_STREAM_0]),
 		   str_on_off(ctrl->link_clks_on),
 		   str_on_off(ctrl->core_clks_on));
 
@@ -1769,7 +1770,7 @@ void msm_dp_ctrl_core_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	drm_dbg_dp(ctrl->drm_dev, "disable core clocks \n");
 	drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
-		   str_on_off(ctrl->stream_clks_on),
+		   str_on_off(ctrl->stream_clks_on[DP_STREAM_0]),
 		   str_on_off(ctrl->link_clks_on),
 		   str_on_off(ctrl->core_clks_on));
 }
@@ -1800,7 +1801,7 @@ static int msm_dp_ctrl_link_clk_enable(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	drm_dbg_dp(ctrl->drm_dev, "enable link clocks\n");
 	drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
-		   str_on_off(ctrl->stream_clks_on),
+		   str_on_off(ctrl->stream_clks_on[DP_STREAM_0]),
 		   str_on_off(ctrl->link_clks_on),
 		   str_on_off(ctrl->core_clks_on));
 
@@ -1819,7 +1820,7 @@ static void msm_dp_ctrl_link_clk_disable(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	drm_dbg_dp(ctrl->drm_dev, "disabled link clocks\n");
 	drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
-		   str_on_off(ctrl->stream_clks_on),
+		   str_on_off(ctrl->stream_clks_on[DP_STREAM_0]),
 		   str_on_off(ctrl->link_clks_on),
 		   str_on_off(ctrl->core_clks_on));
 }
@@ -2190,38 +2191,39 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
 	return success;
 }
 
-static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
+static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate,
+				    enum msm_dp_stream_id stream_id)
 {
 	int ret;
 
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
+	ret = clk_set_rate(ctrl->pixel_clk[stream_id], pixel_rate * 1000);
 	if (ret) {
 		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
 		return ret;
 	}
 
-	if (WARN_ON_ONCE(ctrl->stream_clks_on))
-		return 0;
+	if (WARN_ON_ONCE(ctrl->stream_clks_on[stream_id]))
+		return -EINVAL;
 
-	ret = clk_prepare_enable(ctrl->pixel_clk);
+	ret = clk_prepare_enable(ctrl->pixel_clk[stream_id]);
 	if (ret) {
 		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
 		return ret;
 	}
-	ctrl->stream_clks_on = true;
+	ctrl->stream_clks_on[stream_id] = true;
 
 	return ret;
 }
 
-void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
+	if (ctrl->stream_clks_on[stream_id]) {
+		clk_disable_unprepare(ctrl->pixel_clk[stream_id]);
+		ctrl->stream_clks_on[stream_id] = false;
 	}
 }
 
@@ -2242,7 +2244,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, panel->stream_id);
 	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
@@ -2252,7 +2254,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = panel->msm_dp_mode.drm_mode.clock;
-	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, panel->stream_id);
 	if (ret)
 		return ret;
 
@@ -2546,9 +2548,8 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 		   ctrl->link->link_params.rate,
 		   ctrl->link->link_params.num_lanes);
 
-	drm_dbg_dp(ctrl->drm_dev,
-		"core_clk_on=%d link_clk_on=%d stream_clk_on=%d\n",
-		ctrl->core_clks_on, ctrl->link_clks_on, ctrl->stream_clks_on);
+	drm_dbg_dp(ctrl->drm_dev, "core_clk_on=%d link_clk_on=%d\n",
+		   ctrl->core_clks_on, ctrl->link_clks_on);
 
 	if (!ctrl->link_clks_on) { /* link clk is off */
 		ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl, panel);
@@ -2586,7 +2587,7 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	drm_dbg_dp(ctrl->drm_dev, "pixel_rate=%lu\n", pixel_rate);
 
-	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate, panel->stream_id);
 	if (ret)
 		return ret;
 
@@ -2643,8 +2644,6 @@ void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
 	phy = ctrl->phy;
 
-	msm_dp_panel_disable_vsc_sdp(panel);
-
 	msm_dp_ctrl_mainlink_disable(ctrl);
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
@@ -2714,6 +2713,13 @@ static const char *ctrl_clks[] = {
 	"ctrl_link_iface",
 };
 
+static const char * const pixel_clks[] = {
+	"stream_pixel",
+	"stream_1_pixel",
+	"stream_2_pixel",
+	"stream_3_pixel",
+};
+
 static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
@@ -2747,9 +2753,19 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 	if (rc)
 		return rc;
 
-	ctrl->pixel_clk = devm_clk_get(dev, "stream_pixel");
-	if (IS_ERR(ctrl->pixel_clk))
-		return PTR_ERR(ctrl->pixel_clk);
+	ctrl->pixel_clk[0] = devm_clk_get(dev, pixel_clks[0]);
+	if (IS_ERR(ctrl->pixel_clk[0]))
+		return PTR_ERR(ctrl->pixel_clk[0]);
+	ctrl->num_pixel_clks = 1;
+
+	for (i = DP_STREAM_1; i < DP_STREAM_MAX; i++) {
+		ctrl->pixel_clk[i] = devm_clk_get_optional(dev, pixel_clks[i]);
+		if (IS_ERR(ctrl->pixel_clk[i]))
+			return PTR_ERR(ctrl->pixel_clk[i]);
+		if (!ctrl->pixel_clk[i])
+			break;
+		ctrl->num_pixel_clks++;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 5902cf7e746a..be0d89d60914 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -24,7 +24,7 @@ int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  bool force_link_train);
 void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			  struct msm_dp_panel *panel);
-void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl);
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stream_id stream_id);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a7b0196bb1c7..fb6607f65ded 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -720,7 +720,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
-	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
 	return 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index e76dad0f6663..745ee6976897 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -723,6 +723,7 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
 
 	msm_dp_panel = &panel->msm_dp_panel;
 	msm_dp_panel->max_bw_code = DP_LINK_BW_8_1;
+	msm_dp_panel->stream_id = DP_STREAM_0;
 
 	return msm_dp_panel;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 4519ac374220..50a721401751 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -27,6 +27,15 @@ struct msm_dp_panel_psr {
 	u8 capabilities;
 };
 
+/* stream id */
+enum msm_dp_stream_id {
+	DP_STREAM_0,
+	DP_STREAM_1,
+	DP_STREAM_2,
+	DP_STREAM_3,
+	DP_STREAM_MAX,
+};
+
 struct msm_dp_panel {
 	/* dpcd raw data */
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
@@ -40,6 +49,8 @@ struct msm_dp_panel {
 	bool vsc_sdp_supported;
 	u32 hw_revision;
 
+	enum msm_dp_stream_id stream_id;
+
 	u32 max_bw_code;
 };
 

-- 
2.43.0

