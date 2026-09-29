Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22768CA5FAE
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0ECC510ECA8;
	Tue, 29 Sep 2026 04:27:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iqzQj4ZA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AkN8WCvJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CBCB10ECAB
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T475Iu3390853
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EdkXDqWxRD4i1VWXd4Haq4U6gn4wnuanLlD7mZRKGRU=; b=iqzQj4ZAn1mxFY5R
 ouFjSA9zwTldIEuCqEhKa9fh2IgVC1374FN5lt1Qkwg5lLvgVATwowa/F1R40k/J
 V6ck9a7JCcCVaM1RSayENuNSBQXLmZBX31WRm/DTmQVi5cPQ+nK0d5aN1w9/K0yZ
 QCAm8L05alOFDrl33xPZqhptrzUEJkjIqZdpAUNoP8mGxzeE5fAkb3O/MbJv56SP
 VEQw1pB2mDAPPbQjknBluN03+VRp0Q4FMvw0Hn4wJQsm1Bjw8ebkUP1A1zJTkRVw
 4c3V/PRmg1c6KS7azOcrS5EdpKwqvL4jRgr/ao1HZAfgC3PAYvknSTu407dwGjsD
 3CqXXw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h01vkgvey-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:27:35 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91431adf55eso69544896d6.0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656055; x=1791260855;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EdkXDqWxRD4i1VWXd4Haq4U6gn4wnuanLlD7mZRKGRU=;
 b=AkN8WCvJJ83ugqAk9944HcKJ2aYxd87zFanPjXWL4ahjwLZ8wYyI0gKlg5XxWO7L3R
 Bj8CI65xaaiEkWa1jWBmOdvjgiysPL5xynUnWHZbuTGATXwKVtkInBANbzhnsbzSiM+s
 n/SDGZTFpX2amjJ1GuSNlNrFEyVffhnlnNeQ2NTV+fSzZ9Oszqy5mJmMNJkjIgiKUO+S
 3j4xYl7WTMgrKjMkTJuW+YIg8M1OykwAXJMmW1brW8zk0MpblSpBu3lLuWkyEnIBGTEm
 rKgG3BpG4X7uGi9d5RJ9Ryxvjriu4+YTHgp1YdwdD3RfcgJHWlwxScafmbMLRgYUFoCG
 PXUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656055; x=1791260855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EdkXDqWxRD4i1VWXd4Haq4U6gn4wnuanLlD7mZRKGRU=;
 b=ADERu7hXBVl2U0twzmGWD9hP4Bvd+swUqOOkQJu8WpvIQrPuZ6uSaI02S4odQUYsd2
 VEn8KKMOcmRGqDMB44A+dfZ7YttRrkKG5mfHGE6gGHEvHctl+nN/Sxz/rJcYo15jiasG
 +j96qzvucfLlN0RlhO8fXyVbSuAaf1dE+X0ejATBfsBbspu9q5RYCkbgqqybYT09npNw
 /cXsrHn2UbveHOKuo6R9xLwKf6rRZBRncOZV90AA//ZOm/aeQjkI/MW+cobtnbx2rPba
 k9wFAduFn7eiK++pu2VldPCt9tpY+Yy/1dBvf/4XqIBTuEHDweUeZRYbpXfFjARV66wx
 CkxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRcs9el4Ek2dbuBckE4YjmqnPqnJyFu7Hi08QbGB+DsvDIrMCq9+bEAwD/XFP3pwZr4w78/rkJNvU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nLVhqBqk5/CfuNwxhfN/BGhEB8P+ebCK2e0fxQr5sRBJDJJNCZ
 bQbb/o8dzBBYYzzZjfo2EopS69P/bgCzmZcRqIexSSaSUcHIkGwT0TpwlfplLLov2qyF9gII8cb
 XyS3ria4xfCG2LdsJAA8eF+pHaCWyeMjoCSjWwmXSm72sb2q0LSKp/vf61A6M2u5gykiVYFI=
X-Gm-Gg: AYBFou0LALysCffOSCqvtD7nungeIKoHBb1cj8BfAEa3UYMHW7lF0mKScdHAdfq0mmU
 gOQtnYp6OV/stTGWEhs3j1dizEK0CgdrkjuePJC2PkYH66AaaQLb3YIXSWkbYE6DrZE2Fmsb0nj
 OyYgekWiT3IljKOODgbjgB60aJEzMCuMAQBcoytpP6N2Ffc6S2t+rE/7XseQXj00BoyYtTAwzNp
 x8gtynzlzYlydJjUHZErZwyz7s2w7Cr7MMmdpVoWsICuyZ4L0sgQ0QaPnV6SVU3cb1G9JPUG13H
 sPcg6BkiI8CuIGdz3LLHXf7Nhs5i+qs2ZSwFgDZrBYBi8w39ogS2QSMvSk1M9g9U2n7OhHC7ewx
 Zm3B78A+JYkOfH7Bmez5vfL7FLqbp1tl1GOEht6RIeIRyGCCX507Wqk8ea43poIY=
X-Received: by 2002:a05:6214:f2a:b0:915:4229:17a3 with SMTP id
 6a1803df08f44-915422924a5mr124882556d6.25.1790656054990; 
 Mon, 28 Sep 2026 21:27:34 -0700 (PDT)
X-Received: by 2002:a05:6214:f2a:b0:915:4229:17a3 with SMTP id
 6a1803df08f44-915422924a5mr124882246d6.25.1790656054467; 
 Mon, 28 Sep 2026 21:27:34 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.27.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:27:34 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:38 +0800
Subject: [PATCH v7 14/35] drm/msm/dp: replace power_on with active_stream_cnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-14-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=5066;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=67v7m0nY3ZZ469SfH0snYnVSm8decmV7B6bVBAo55no=;
 b=6QWRsfVGCVfo3Eg3TNc9E2pM+LvzM4J3dzvOJZKRlvVZ/As1QXfMZJVNqNovwtBSw063eN8sA
 NgEg3IvL1+0DWGq7/YRNf4ZcYNSIB2eQY4lORoga/ev7gSq0+f9IAQn
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXy5W+P8Wt67j1
 Pks7hEFQ0fba1p/iB0rANb9oaN9COXCd+BL/wwcZM67hcUFThn0htPPFb1Q8MPRBdLW182+RQqa
 UnkjKQwSfnHlIOVpuucalBekaTpu0xUNRf8K8gZJaPWbJPAbf9qU/zlUxaf+KV33tWmpod7pmpj
 IY6y4NLe7Xz8J1E2kkSH2HqplVXkAbQuDV10ZFVsRYt4vEsoD2XQ4N+wxAXoOzIopvX0RXY3MNk
 vzUP30+a4iMn5Aip0k64r+suDlXOGc/N8o71TDqEtZFpyG6kKaFH3xLiDqKxG7ipQjpHVwL57No
 CwkwoXathYHeVm4o4Ae/qYVZYlt948Ov12Vc8AtdARi2jUkVsZhWip8QsM1mPhRgmmsr4/0HC9V
 mIcOlKutHPy9C4wobirj0C2A2XqwQsigGxQ0fcIXn9Mwe40zBA/bStfawu4JdA64zSVuUvyqgsS
 14fvvOlL9NBkvOzFZXA==
X-Proofpoint-GUID: v6mnftcVttw4_IDcpzLr88d_ACaz-1sC
X-Authority-Analysis: v=2.4 cv=VcVir1p9 c=1 sm=1 tr=0 ts=6abb3e37 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pA7EhmVi1NdrnwtGoTUA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: v6mnftcVttw4_IDcpzLr88d_ACaz-1sC
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXxmk5rR8KO+Ck
 hlXEZXx5ggOQIujikgA5HfawtnPrXKpCUzw0U8YY9XhK+cf1cpSUMSVVZKXCX4mS09/RxzUjNry
 OBJJ3UGfKJB7fUDtGZb5rDagDr/NK3I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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

The power_on boolean cannot represent DP MST, where multiple streams
share a single link and its associated resources.

Replace power_on with active_stream_cnt and use it to track the lifetime
of the shared link. Link initialization is performed when enabling the
first stream, while link teardown is deferred until the last stream is
disabled.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 38 ++++++++++++++++++-------------------
 drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index df222943ae57..8118130a3220 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -284,7 +284,7 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
 	 * such cases check for connection status and bail out if not
 	 * connected.
 	 */
-	if (!msm_dp_display->power_on)
+	if (!msm_dp_display->active_stream_cnt)
 		goto end;
 
 	audio = msm_dp_audio_get_data(msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 471803457b14..8756e45eece5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -645,16 +645,16 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	if (dp->link->sink_count == 0)
 		return -ENOTCONN;
 
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display->active_stream_cnt) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
-	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
-	if (rc) {
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-		// TODO: schedule drm_connector_set_link_status_property()
-		return rc;
+		rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
+		if (rc) {
+			DRM_ERROR("Failed link training (rc=%d)\n", rc);
+			// TODO: schedule drm_connector_set_link_status_property()
+			return rc;
+		}
 	}
 
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
@@ -667,14 +667,10 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
-	if (msm_dp_display->power_on) {
-		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
-		return 0;
-	}
 
 	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active);
-	if (!rc)
-		msm_dp_display->power_on = true;
+
+	msm_dp_display->active_stream_cnt++;
 
 	return rc;
 }
@@ -723,13 +719,12 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	if (!msm_dp_display->power_on)
-		return 0;
-
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
+	msm_dp_display->active_stream_cnt--;
+
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
 	return 0;
 }
@@ -854,10 +849,10 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
 	 * if we are reading registers we need the link clocks to be on
 	 * however till DP cable is connected this will not happen as we
 	 * do not know the resolution to power up with. Hence check the
-	 * power_on status before dumping DP registers to avoid crash due
+	 * active_stream_cnt status before dumping DP registers to avoid crash due
 	 * to unclocked access
 	 */
-	if (!dp->power_on)
+	if (!dp->active_stream_cnt)
 		return;
 
 	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
@@ -1538,6 +1533,11 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	if (msm_dp_display->active_stream_cnt) {
+		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
+		return;
+	}
+
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
@@ -1550,8 +1550,6 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 	else
 		msm_dp_display_host_phy_exit(dp);
 
-	msm_dp_display->power_on = false;
-
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 317c19b809ec..7bd510cecb44 100644
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

