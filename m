Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49498606A330
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=h2fS26MW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4359710FAAB;
	Wed, 11 Nov 2026 10:45:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3AE710FABF
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 10:44:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KgXc300708; Wed, 11 Nov 2026 10:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z9WAY9BVT8G
 kV5/VMSqB+07sjKcm6ZD6dQUC1S4lS94=; b=h2fS26MWRFdGrTn9FcezD9CwjBt
 sejGYCWdHcoZitOosM3YPzYFPeyUY4JsU9buUN2F+uYxbGVJfYm3FL7gdrs/ZNWK
 GtrBw08mvXG6Y3Hx+jReH4iJ4cGnMnlXX+rPLWMP7Ezwwx55ERO5+Cv5U5yVUUY3
 7Fh7JIEX3im0s8Z/usH2QgoTlEWO+BSs6kM3zfOYOEQyx3KnWtYy1myAj4D0yUuJ
 4+C9Dif1Ep23OLN2n1FwWv6pv/3XfOaWE7eacCKsI18iX2zkBD/WMNiBgYmnIgpR
 p4ED0He0AS+I2OSzMLLpikmugaiW5cMAjrqMmYl0XtGR/+fispua8SqOHww==
Received: from apblrppmta02.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5kva2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 10:44:49 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
 by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ABAillG2709791; Wed, 11 Nov 2026 10:44:47 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-vnama-hyd.qualcomm.com
 [10.147.248.182])
 by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6ABAilOM2709781
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 11 Nov 2026 10:44:47 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 4857718)
 id 548F121CAB; Wed, 11 Nov 2026 16:14:46 +0530 (+0530)
From: naidu nama <naidu.nama@oss.qualcomm.com>
To: vkoul@kernel.org, neil.armstrong@linaro.org, mani@kernel.org,
 robin.clark@oss.qualcomm.com, lumag@kernel.org,
 abhinav.kumar@linux.dev, jesszhan0024@gmail.com, sean@poorly.run,
 marijn.suijten@somainline.org, irlied@gmail.com, simona@ffwll.ch
Cc: Saurabh Anand <saurabh.anand@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 quic_riteshk@quicinc.com, quic_vproddut@quicinc.com,
 quic_mkuntuma@quicinc.com, mahadevan.p@oss.qualcomm.com,
 naidu.nama@oss.qualcomm.com
Subject: [PATCH v2 3/3] drm/msm/dp: continue link training downgrade when
 cable is still plugged
Date: Wed, 11 Nov 2026 16:13:55 +0530
Message-ID: <20261111104434.2222182-4-naidu.nama@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
References: <20261111104434.2222182-1-naidu.nama@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfX4cZz8bve78cf
 WoSJEeaCUn8TlSKEZGjuwgERiILFn1auTOzfUaqA9fzdna+CIwcTQLLAwcFWCvZCB0RoBvMEHez
 LT2GlYJ7OwTHv0be05LvX+o47E/+lAA/YydlaV/cqFD6LJCcn8i3TxDTOakoBrsRd/m54WvcXg0
 Yw/a3GaAs+QV5J+B2UW8QdWsj7/KZm1yt8EhzqiEv3BQxgqWuAPrXHgEpnLFdQElV0RpYI/jJO2
 hIBPtrNH8M3Kx2Bt37OFTNh2PnbKDG46cJGLf+vABj0WwtFOZiVfRalT8Ea/L7Sf/9O/lWUdyVE
 6MO0OgOBUIClysUximwu1rUtVMHi41c/OSej0wJbUaHtPxqyemiPsWGa6V2e9/QJ5g1eqJObeoe
 Oan9g6AUTHAWABsTbs3qNRUCGisRIRve3QLw8DoNj9mjy3iIU9uCP7NMtKVyCRc4lEmVrB5xbEX
 3+iBOYAkG16MRSd+zHg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0MiBTYWx0ZWRfX9+fiwvmmL185
 9uyPwSA4eQcnZoPfn3ghvH8TnL49AsdjPMrRKYjMMljaWKINwMWFLc+X/rolNTbS6x+eoWz/3rT
 yFMCW0T39BmrXZ4Tr+im8CVF8J7IX0k=
X-Proofpoint-ORIG-GUID: xbtQgbdhcRCiD1Q0ryHkf1X4rS7OwFQd
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af44722 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=We3yMw5etD2gDBR9kbUA:9
X-Proofpoint-GUID: xbtQgbdhcRCiD1Q0ryHkf1X4rS7OwFQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1011
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110042
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Saurabh Anand <saurabh.anand@oss.qualcomm.com>

During a Type-C reconnect the AUX channel may report link-disconnected
transiently while the physical cable is still present. The link training
retry loop in msm_dp_ctrl_on_link() was aborting immediately on any
msm_dp_aux_is_link_connected() failure, preventing the rate/lane downgrade
path from running.

When the display is known to be plugged (msm_dp_ctrl->plugged), an AUX
link-disconnected status is likely a transient glitch rather than a true
unplug. Allow the downgrade loop to continue in that case by requiring both
conditions before breaking out of the retry loop: AUX reports disconnected
and the display is not plugged.

Signed-off-by: Saurabh Anand <saurabh.anand@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 15 ++++++++-------
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  4 ++--
 drivers/gpu/drm/msm/dp/dp_display.c |  7 +++----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 6b9d9a76ba05..f8a6bd7b0d10 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2274,7 +2274,8 @@ void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl, enum msm_dp_stre
 }
 
 static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl,
-						struct msm_dp_panel *panel)
+						struct msm_dp_panel *panel,
+						bool plugged)
 {
 	int ret;
 	unsigned long pixel_rate;
@@ -2293,7 +2294,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl, panel->stream_id);
 	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
 
-	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
+	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel, plugged);
 	if (ret) {
 		DRM_ERROR("failed to enable DP link controller\n");
 		return ret;
@@ -2310,7 +2311,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 }
 
 void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
-				     struct msm_dp_panel *panel)
+				     struct msm_dp_panel *panel, bool plugged)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	u32 sink_request = 0x0;
@@ -2325,7 +2326,7 @@ void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	if (sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
 		drm_dbg_dp(ctrl->drm_dev, "PHY_TEST_PATTERN request\n");
-		if (msm_dp_ctrl_process_phy_test_request(ctrl, panel)) {
+		if (msm_dp_ctrl_process_phy_test_request(ctrl, panel, plugged)) {
 			DRM_ERROR("process phy_test_req failed\n");
 			return;
 		}
@@ -2377,7 +2378,7 @@ static bool msm_dp_ctrl_channel_eq_ok(struct msm_dp_ctrl_private *ctrl)
 }
 
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
-			struct msm_dp_panel *panel)
+			struct msm_dp_panel *panel, bool plugged)
 {
 	int rc = 0;
 	struct msm_dp_ctrl_private *ctrl;
@@ -2427,7 +2428,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			break;
 		} else if (training_step == DP_TRAINING_1) {
 			/* link train_1 failed */
-			if (!msm_dp_aux_is_link_connected(ctrl->aux))
+			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
 				break;
 
 			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
@@ -2452,7 +2453,7 @@ int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
 			}
 		} else if (training_step == DP_TRAINING_2) {
 			/* link train_2 failed */
-			if (!msm_dp_aux_is_link_connected(ctrl->aux))
+			if (!msm_dp_aux_is_link_connected(ctrl->aux) && !plugged)
 				break;
 
 			drm_dp_dpcd_read_link_status(ctrl->aux, link_status);
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index fc884038182f..3edf954cc805 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -17,7 +17,7 @@ struct msm_dp_ctrl {
 struct phy;
 
 int msm_dp_ctrl_on_link(struct msm_dp_ctrl *msm_dp_ctrl,
-			struct msm_dp_panel *panel);
+			struct msm_dp_panel *panel, bool plugged);
 int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *panel);
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  struct msm_dp_panel *panel);
@@ -28,7 +28,7 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel);
 void msm_dp_ctrl_handle_sink_request(struct msm_dp_ctrl *msm_dp_ctrl,
-				     struct msm_dp_panel *panel);
+				     struct msm_dp_panel *panel, bool plugged);
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev,
 				    struct msm_dp_link *link,
 				    struct drm_dp_aux *aux,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 169938ba515e..551d2c63ef8e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -399,7 +399,7 @@ static int msm_dp_display_handle_irq_hpd(struct msm_dp_display_private *dp)
 
 	drm_dbg_dp(dp->drm_dev, "%d\n", sink_request);
 
-	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel);
+	msm_dp_ctrl_handle_sink_request(dp->ctrl, dp->panel, dp->plugged);
 
 	if (sink_request & DP_TEST_LINK_VIDEO_PATTERN)
 		msm_dp_display_handle_video_request(dp);
@@ -648,11 +648,10 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	if (dp->link->sink_count == 0)
 		return -ENOTCONN;
 
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display->power_on)
 		msm_dp_display_host_phy_init(dp);
-	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
+	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel, dp->plugged);
 	if (rc) {
 		DRM_ERROR("Failed link training (rc=%d)\n", rc);
 		// TODO: schedule drm_connector_set_link_status_property()
-- 
2.43.0

