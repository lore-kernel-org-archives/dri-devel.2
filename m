Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F83EE9905D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC0D610E923;
	Fri, 10 Apr 2026 09:36:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OcszaN9y";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCWRQxoD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95FED10E91C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:09 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oR0n1925453
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iFueMn+8HWN8x0UHaMCVey0IAB+cckhf9QVqLC5vzOY=; b=OcszaN9yhwAtA1/t
 1s+PfCVhzgSha5JUzZ3iUG81jlOiNkQN2/mlElhUVQzSeNkPdUkbITl/VowIHZxs
 6fTqmh8cAeqbtTgTcLbgGowIuclUDavqG8hKcjTtLsyRJy5elTWHrgy6BxDZ9pxP
 5dAQMUPeOgFie0cthsVbiNgi2pM+WSy0dJ1O1JFenC1GJcjcvEb51Fnf0FVSXOjO
 0xtFTNOOmkfZg8DaEj+yfmckieKO+5sm+ElLzuWmSDXwGhjklgc/R2Qp1qmbISKT
 iErsCi5EUmwtW4CnqRFGfWxevii/kx4KaEjZ0v+D5Xixl+7oPDU2MSuTSv89JQrC
 QxJvuQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjrt9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:09 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a965acd0b3so54764096d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813768; x=1776418568;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iFueMn+8HWN8x0UHaMCVey0IAB+cckhf9QVqLC5vzOY=;
 b=JCWRQxoDaOWB49EeC94VNnQoibmae5n678H53Tb3MdXSpVKLLeazp2cSc50Kbt2wxY
 YNUwBUrG+Wv9tw+vbD/TBJPmRqGkcTsdFF6P1q2pfhBZhyxmWulL/gJ9NZetZQ8excpz
 1nuvNyCRVKl5aQWnTm7QEUcx68i1bQ/sbCT0IQ99EFFO+HEeRLnUI5GYGs5BPnAi/R2b
 Sr854cxyIuqxj89xbowLRDtKljD72JfkXz7tAquo6PPSv7vkL3KJKONXkLaXw7xPp9aQ
 8zxCFCH00x1KzqqShQHrJwpa7XaNcABFdwRlUu1IgLID0ya8gVaKyi7z1uhGx2D5EthV
 u2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813768; x=1776418568;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iFueMn+8HWN8x0UHaMCVey0IAB+cckhf9QVqLC5vzOY=;
 b=CC6avZewXsLFxrjULu41Xpw55Dauq68UgAV2xp4dHnR0VFi8O44vbs8nKvNTMunS7H
 ywmfOLj2ImSUbrUoT0hkgYtobdXSqd03EAmy49irfnKTBEjZzfYkzBjvRYlPtdVmXvzk
 LuJ4s5BbnbNX1tMQ6cbv4P/K2pehPkNHXNw1/ynm33HeEr/FW67gfGfRMOZ/W98rie1h
 ZwAL1zHn28o1eohQx4jql6nI53YLJnJ437zhIfS7GylLEz2X3JNXmRmhMEwUqYcXi2DN
 f3HsPDHp8aK/D0KQVS8rrzOvorLkijQ8q0AsNqDfVvG5CD9gJAH+5ceJlgNGup8awhqP
 K7aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWk/cnFT7UpTRXpb++ujORjGGf1q1t6ZZE7bWSossovSCAPP8ygTXHASVKiYSyEZVHG7vuZwi6FeaQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzNLKCdrqlAzmlE7tc8wMJ++sqyvcaTj0IR+ExS/6fvPqlvVgYX
 SGueIrjdbPKNzqgbFv0Nf5svo4/Y6ka5DfJ5tEabgs0vSImVEL2g+Wh/cjC82JaMYxv7XbJLgts
 Ka0rraIQjnkepUklClDv53JdICp1KxrSL/pIjqCr5RL2BMesBop3c2ihdpf0z47DuEL69UZY=
X-Gm-Gg: AeBDietxO+diy87MMYGdGYXW7GcYsdjeZV5EI4w+Q+32QrJd1YaQMOxP5STEJS8H+qG
 E6xbx/ouSCdc2p6uopSjqP1kXa13lGZSqT6j3wvjELiBoRWh4hMX2cWBQWWz4Mb//8jfQNxBFZF
 KwEMRPbcLn4k0XecThooeY1beoSxyyrTEcQ9ZGJ+hjxoi1dSu77lPeJnN5xzRbJGxLnuXpusgZH
 JWA3KPZiF9ISer40sLLKpTPFrl4bHEkKO3d/pzbkeMVTQkewFo6Sn+TfyB6PlvIvVo7sTRoiNC9
 ZspaOwjVk6dDR/eVzH6s/prnWZ7zn6q9qRXCS7emzNJjI/O6ORKaBtExd6g71eHgQzUWoZ5YaDf
 RuhJFp4vdNnD4Nvh2s3WhA7rI/g/k6A9a21BFIoXAc5MGg9WLqUqaNUmT7/dEf5+XeJfzmn6AF4
 h1grGkthg=
X-Received: by 2002:a05:6214:5bc2:b0:89c:6bc6:e4fd with SMTP id
 6a1803df08f44-8ac861ad30dmr31320266d6.19.1775813768110; 
 Fri, 10 Apr 2026 02:36:08 -0700 (PDT)
X-Received: by 2002:a05:6214:5bc2:b0:89c:6bc6:e4fd with SMTP id
 6a1803df08f44-8ac861ad30dmr31319836d6.19.1775813767658; 
 Fri, 10 Apr 2026 02:36:07 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:07 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:02 +0800
Subject: [PATCH v4 27/39] drm/msm/dp: replace power_on with
 active_stream_cnt for dp_display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-27-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=5086;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=T7AuGwM525jy9tPtlyOcI8WxJAFrYZ1AUQ93J0+g1t8=;
 b=l3Y2tAadTSRwKptwOTi2mlGRpIW8mjcGxaoQJv+A5SVxTTz9GD+aqQ98abL4nHYdz9/WyRIQT
 12Aw3V3ukKEAPWg2uHQFPPniYDwwPrKE9qCPRLqXTnR1l9JqsGYRy9r
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d8c489 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=viFl3JHUHTzxIaEVkEwA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 7QYFj6VOHxpU7vpOnN806dCkQSnjnA-k
X-Proofpoint-ORIG-GUID: 7QYFj6VOHxpU7vpOnN806dCkQSnjnA-k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX6HSAcGHYHEiD
 q9Wb5xGUiN/0Q9m//B2PxCyq4Ra9CNwoaUVR8Bgh6auKX42P/sW5uYA4AeXFjQCYsjqeomYuSVm
 be6UyoVb6A9/BsLTwSE4rdD61MgfCAFUDcnjf8LAsPwKqbvWMakED6DWPMbzMlpdBJjuxURp8El
 FL/eSQllQFdlnX1F2/FjODLclnbroFtykvRmyCeRdV+eGkBrbot9EddsjKnlJhxjQS6zNN2DaLX
 n9Sdy9q9wVsoFJSrb+eTtzCRk9Ayi54+rGuzVa3iftbFo5vvgVatge2hlnfFt2a+Up33YXtxbWW
 efygPEKQ4LFX2w+2ZIiDiXMo0yIR/TzRjdmqbmj93Q8smJRbgbMQ7tEAnsEbLmxfLrg3dMAWk18
 e4h1Jtsa4IZx9/7MrbUXzCie41+p36cqz9w/8TCBHLs1QqtkcQpfk7NoDJXc/tsoAyp8JFXSrCf
 2OW/QlOmFulS9BTr5BA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
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

For DP MST, the link clock and power domain resources stay on until
both streams have been disabled OR we receive hotplug. Introduce an
active_stream_cnt to track the number of active streams and necessary
state handling. Replace the power_on variable with active_stream_cnt
as power_on boolean works only for a single stream.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 38 +++++++++++++++++++------------------
 drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 41018e82efa1..035e230201fd 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -284,7 +284,7 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
 	 * such cases check for connection status and bail out if not
 	 * connected.
 	 */
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display->active_stream_cnt) {
 		rc = -EINVAL;
 		goto end;
 	}
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 33d8539afee7..e6ecbb3a688e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -657,15 +657,15 @@ int msm_dp_display_prepare(struct msm_dp *msm_dp_display)
 	if (dp->link->sink_count == 0)
 		return rc;
 
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display->active_stream_cnt) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
-	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
-	if (rc)
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-	// TODO: schedule drm_connector_set_link_status_property()
+		rc = msm_dp_ctrl_on_link(dp->ctrl, msm_dp_display->mst_active);
+		if (rc)
+			DRM_ERROR("Failed link training (rc=%d)\n", rc);
+		// TODO: schedule drm_connector_set_link_status_property()
+	}
 
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
 }
@@ -674,18 +674,12 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
-	if (msm_dp_display->power_on) {
-		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
-		return 0;
-	}
 
 	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
-	if (!rc)
-		msm_dp_display->power_on = true;
 
+	dp->msm_dp_display.active_stream_cnt++;
 	return rc;
 }
 
@@ -731,16 +725,14 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
 static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 				  struct msm_dp_panel *msm_dp_panel)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
-
-	if (!msm_dp_display->power_on)
+	if (!dp->msm_dp_display.active_stream_cnt)
 		return 0;
 
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
-	msm_dp_display->power_on = false;
+	dp->msm_dp_display.active_stream_cnt--;
 
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
 	return 0;
@@ -876,7 +868,7 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
 	 * power_on status before dumping DP registers to avoid crash due
 	 * to unclocked access
 	 */
-	if (!dp->power_on)
+	if (!dp->active_stream_cnt)
 		return;
 
 	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
@@ -1559,6 +1551,11 @@ void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!msm_dp_display->active_stream_cnt) {
+		drm_dbg_dp(dp->drm_dev, "no active streams\n");
+		return;
+	}
+
 	msm_dp_ctrl_push_idle(dp->ctrl, msm_dp_panel);
 	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
 	msm_dp_ctrl_mst_send_act(dp->ctrl);
@@ -1579,6 +1576,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (msm_dp_display->active_stream_cnt) {
+		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
+		return;
+	}
+
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 0ede5505be58..2548f67cd441 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -18,7 +18,7 @@ struct msm_dp {
 	struct drm_bridge *next_bridge;
 	struct drm_bridge *bridge;
 	bool audio_enabled;
-	bool power_on;
+	u32 active_stream_cnt;
 	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;

-- 
2.43.0

