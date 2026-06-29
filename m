Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB7C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183EA10E8C1;
	Mon, 29 Jun 2026 13:17:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FC/0TDpV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AQjnrOuK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2442E10E8C1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:40 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATEPA2579138
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T3ss0vjFpNbgbDRhLDHRKoVJrgStQ6KKT9k+hgeLDjU=; b=FC/0TDpVic6gKg8P
 A5tl1eBUrA1Gb846LWtPs9xIKFgnOt9KTJGnAoznlVL/e22O6B3c3JVIkPNSfSWY
 K6J98r4sh1qXLClmQuXJaXKB4hMQpksA8rRoVgHJwKl9NBCZfkC5VbeELnW96LVJ
 zzvmHjQoht6H+PAQ9XoL0TBwE3Utn1uoPqTuMC5DJFdRxQEMI7SLPaULL0sFFv2E
 f00eJkKr6bXc/AGTnWl6iWhdR+OHUdgz7O9ZCLzqSBsaTSASJW3RN/xCYJ1gB/qG
 arAOlMvwjgEqiqm4+3Oo62zexK3VE+Tmkd6cskPEEO1IbzDLy7oamrh4orHYzhlP
 PzkL3w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hg9s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f113592bf3so8863206d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739058; x=1783343858;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T3ss0vjFpNbgbDRhLDHRKoVJrgStQ6KKT9k+hgeLDjU=;
 b=AQjnrOuKed0YU1rG3ZJ4W+7SGHKYPlwLam+RJuCki/UcTqPOmKXPsMQ0jfjkBbKmF+
 Yh9tKGCGooHR8YIFXE8PwuhNyNWI7zwHz6B4B9VsN8NsLP9o7KK+hLm7tBXkTWJP3wwB
 RBSisju7aNtuXMy1uQgwmP81lojjZBuoS13ShKw/L0XYMvdkXEdorR6f8a4XsRlmFaRn
 X8jNTzzKyDJUtlYTWNjowHzMTzW4CK+B3nJ8JyEnxI/xkyUM8AVhYhjjCOoi+LDmMbSC
 DbsWZfif1B3cp/esqE+mpc6P66wldu2eBzwTPs1viGJ99b0pev6nipy9sq2txloPHfPq
 HHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739058; x=1783343858;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T3ss0vjFpNbgbDRhLDHRKoVJrgStQ6KKT9k+hgeLDjU=;
 b=bKesnq39yDUvnHwAyGKy1hQrYJsjBMjjqbbu3BtZ9LBmt4a3KtyZwlDYCQ9vHVFGQf
 Au9NX1KxpR30ImFqvee+6trADdeLVtFq+tr3ViEKklHfMr5cuT7RIyeWjXWlITBLF1e9
 ZQnpjLtBM4gWHO/hVZvqOPCH5Tf+jEPbK9Eb+Ir/cabnPCWRowT3PiCtoHl+IGbCv10V
 Y9GOziic7Lv7W7j0RcrxwI3bXrp4FfBPFZSc0JN9m2wSS05uIiFQKp4vzT5VWi1gVdPt
 I3lo/9kAG2vz65k9HCAxgPU4dCQppZRDb7pS57CKrZgCH2vyCjZFLrsG2NQ2aTR8QiVJ
 TSJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDmPXtilHioP+zW5JBb8PUlMz+P69o2XoHbd3krbo34nZP7uqsH8gZQvQfjtYbInakSoGOc7VWlks=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ6OOP5pVIkz7nLtAI5NJeAk7YkDKXBGgsKRMXYnAdsHu6zfyq
 feNU426t71orOQfiKl5MxFHzk9vPnqyDaEgDVUWmegMosWY0Wr5aA2AZLEdTzeUqw+0mvgnJKo0
 qd6sEWnRBG2gpmLi54gDjrpRDNpY/sbf1/mVUzyj6Pa6aDgBKTjYTOScQFMiYPaDxTIsLO40=
X-Gm-Gg: AfdE7cnxZpyH1xAm7eb8fX6QBxGlHCyW9KqcReMYHwmMxy8/YafhdlgGROIgomhxmcp
 Cea2hhAhL7DOSJS9AzWx2bGTeTuwY45OZuT8Z758WRb2CqnOAMHBB92IY4S9X5meolGfEqvNFNY
 oxCcna/1LUzEr50KNktqOeglfhEs8hKNrjkTrSBK4StDauTXFILqS4f+LL6fHvTiBqYPjYMVMBv
 tINfsu/2Y5e1IHnl/fVKiEAzdZ4LiaE6TOCDLzTa/iKoD6Yz4n921T7pqaA0cV595PlY9/DKXaN
 66M+T0xbmVQFO+J7sQIYCtnkWYDOBJdAeTbPMsdHVQLKDOlR9LyTW1UTGxTxyaK53roQadtwmXS
 gyz37mRRFMXJBZETIQKi7lb9gUrjylIySq4YJbm7a22nSn7DSPWqVUIFBrXdn37kZ9Mbqr42kLg
 ==
X-Received: by 2002:a05:6214:3213:b0:8db:1179:d180 with SMTP id
 6a1803df08f44-8e6d8103a36mr287554086d6.23.1782739058315; 
 Mon, 29 Jun 2026 06:17:38 -0700 (PDT)
X-Received: by 2002:a05:6214:3213:b0:8db:1179:d180 with SMTP id
 6a1803df08f44-8e6d8103a36mr287553156d6.23.1782739057652; 
 Mon, 29 Jun 2026 06:17:37 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:37 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:31 +0800
Subject: [PATCH v5 13/25] drm/msm/dp: replace power_on with
 active_stream_cnt for dp_display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-13-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=4734;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=qyaa9q2aizh+9xuBgPhFHv6SP6/o/UrGrHkmxoK5AgY=;
 b=exGqe+aKROmq4l0EXEWy42Omv/43/D3zuejKFzAtM12LiOH8oVbRDQisfi8c9ela5/3dZ2Ezk
 Psp8YOt089ODV+1HvTPMJtHfqxaCFTk8UdT+aEw5Z+M2dUXiRAMaW+w
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX3miLqyyScXp7
 aYzChaSZUjIdWmb8LdjnH4iUXooe52WlIC1sgpJES92OFIQhzOUql1LNNyHaa5jS98eveA59d50
 gEyh109p64mzbHKsKNy7kVnuYHMoB1I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXzwzPD9Uvpadd
 CEniklqQBrWOCjAqGKdbFoolbmUOd1ibYFzl88NJNCQxzMYWC3HxB8pat6PgEaTw0sKqlj39Hiz
 NJdCODL4ldb7XwP8IcxxyMITuR/qCroWF9EWzR/yS8xxEuqqd97e4DXxe+S/yGZyUuxtZB3ba26
 rgedQEunbR222HsDJz3cITdW4/OG0b+1sx7Nr+S+j+sZ8glA10gnpkIfXpLKi5+EsN4fpT00gYV
 riEc0mzS5z+EaVIu/t7un2qLtxDZFKlwJqSFpAUetB9rbOW/xaGqrz2axlAVMtHw4r6jKnarTGR
 f08v/ItgkkDad3kan6q2BWp88fYJtRhNA/GGzzjm1zzagsmje/qkIvgxJG4N8GkgrbegWg0T1nI
 ZlprAl9kzXnhmjeCR1NI+TPmq6whf8N4wdrocwRuA5gp3hNMl/R4HwmMgHTD91DZFCxN3i8Sy+Y
 qLKjo+Y9HN7+PujuQzg==
X-Proofpoint-ORIG-GUID: 5SdBoBQnVH2Moz_fUOEZe-uYn2PEAxgD
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a427073 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=n0N2oAcnmnxAXiYSG7kA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 5SdBoBQnVH2Moz_fUOEZe-uYn2PEAxgD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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
 drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++++++++-----------
 drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
 3 files changed, 19 insertions(+), 13 deletions(-)

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
index 0e432f35cc51..d0081ea9f5cd 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -650,7 +650,7 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 	if (dp->link->sink_count == 0)
 		return rc;
 
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display->active_stream_cnt) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
 	}
@@ -670,14 +670,10 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
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
@@ -726,14 +722,14 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	if (!msm_dp_display->power_on)
+	if (!msm_dp_display->active_stream_cnt)
 		return 0;
 
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
-	msm_dp_display->power_on = false;
+	msm_dp_display->active_stream_cnt--;
 
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
 	return 0;
@@ -850,10 +846,10 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
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
@@ -1535,6 +1531,11 @@ void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!msm_dp_display->active_stream_cnt) {
+		drm_dbg_dp(dp->drm_dev, "no active streams\n");
+		return;
+	}
+
 	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);
 	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
 	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
@@ -1555,6 +1556,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 
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
index 55ffa22bb233..75dc40261723 100644
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

