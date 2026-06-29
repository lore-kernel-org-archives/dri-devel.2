Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14EE9C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438C810E92E;
	Mon, 29 Jun 2026 14:16:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHK5ezpF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BrG0lvro";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E3E810E921
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASu432603465
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T3ss0vjFpNbgbDRhLDHRKoVJrgStQ6KKT9k+hgeLDjU=; b=dHK5ezpFA9t782c+
 0F2Bx78154ND81E8diSkDLR0TNgjcNmslM8pde7u1amTd9q78KbA1NUzU8U3LyPF
 K3nWanZOJ5CXWSlBSmfXi0KPXJteUadto4B8dSvWPCyRgmAGgi89GdB6WS5kah+C
 FnAjGGlr3rCsCZ1Juo/J+MPpTG9JcgXoQlHxbv4OG3jyjpRrobMrUTvkQTSkW1jZ
 OZWF6ZjQH4DNeL/cOAu+gMnZV4mCo6jGohJLVdEGRS3Umuk06idJZlG6lp9rCgUg
 VXD5QYFNep7XePapSuJfNG310YMQ7b0cDvbIa0oCpSATzllzt5e8w/7j5IkIMm7U
 jqE5/w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq8973n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e61b38eddso1599085a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742574; x=1783347374;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3ss0vjFpNbgbDRhLDHRKoVJrgStQ6KKT9k+hgeLDjU=;
 b=BrG0lvrohXaBSa6F+2Zah6Nz0dhCZEWRncz4wJPNaXqCWQYBVwo8QitX7URjf2k1ry
 chemafTETNbvX6TwdGsmA3DkRVPmIJJJgxAr8we0glEekQeV17JQ4QMNugMMa9pf06Rj
 B5Pb22XN1BDmrRCJvCZ1/9NY/4yMvYb/buZVNplc5S9ATywKt18CBzQATiGdQGO4LCaa
 no4yqeAN4XF/PyHnGJv41aMZp8QL+LlBuwMRBxe3xb3dMQqqN0CN/1ypfCblJpmjay5K
 RWFlH54doBo0NCS0MFrv0y8rXI60d+aeIdg6acO+zgF5xQXeAiMfHa6Fg+cmNg3KUqky
 fTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742574; x=1783347374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T3ss0vjFpNbgbDRhLDHRKoVJrgStQ6KKT9k+hgeLDjU=;
 b=CAZ0ebI/Qr3nyghAuNlNDW4JOUoyAZIO10IxktHh6citjrzDSuo0koE4YrIR63KoMH
 v862KVTBjAFZWhU5MT4EAdlgCIT5mMLFMkYlIfh6vrgVx49+3S/q9b2rGkHwvX+RE/jd
 cN2zvK6DjJUknlhMqMmEdem670wmtI4FAbD7mBdjbkQGCGIeQ8+eyriMLd0PI/OIj4Xq
 dC5aE3jsnlIqIkCI+PxGYB33SJv5VDFgZ1sdm/P5JfYEnMTelEcBKhQGsXfoTdXOeUuo
 DRyUzm6ACer+LYzcpvtaekqgWtAgfLD744lgn8FOU2XdG6V8+nNNj7zDBQLpl+DbULBR
 sXug==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ZAfxeKJLEHtBB0YHY7r2N92MGWsV2lCjbm8bbPT4JBGeZASj3Hl795/zXsebyw233Cov799vazBk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG0dmpTeCBtRYWYRYFzYZb6bsH/LScQWSVGuzSKNTObCv4nxJp
 srSKvndTotdzTynwxIyXz5/n5r3BGpzvH/96o2TCmUPWKGZq/FEpH0d0wW9yuxlsT7oESP/LA8u
 VVhST536bdHCN0MrRFjiloFkywJ+Rtzci9OPfVcfbGOZlQ50Dt+rSRD+oaC4YJafLYPajF6s=
X-Gm-Gg: AfdE7cknq8lK5fYYnVirbzcvqIjzOFn9KZXAc0AMMRlLWafYRP7Vc6dER5lq7ZkVOyv
 MwUwQ4Yw8qNn46hlpmD8yM1kXx31BmigYDZJBI7anKfpq+KaSFqfPmsXokiTwr97e6KncGBykzq
 II6SfK3Lsmb5hMh6qhV3smk0Pyt70Y2CwAj608WS1bavxgzMAuPbbjydzwurObySoprM/VuBDOl
 A4HW/OvaJ9gSC2VtnbbynUb2HqcggrgbAWmvAOiKtwyJXrGDQLcKn3gvEQUXOf2xgd7KDJzY+XJ
 suB+SspiF3hNqOG+IbP/j0KYiTN5hrcPU66zKy6a6KF9Pglm/EAmpSIdoLTbGZVf3wjnPlmcfn3
 7yzjCZKM5ZbtFEKEwuNStTBbC9GrtqVgCxycDUIlsFR2LlGS/API5i8xboe7D1ekYyOnEjA==
X-Received: by 2002:a05:620a:4409:b0:923:8612:f15 with SMTP id
 af79cd13be357-9293bd3b210mr2439032185a.18.1782742573175; 
 Mon, 29 Jun 2026 07:16:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4409:b0:923:8612:f15 with SMTP id
 af79cd13be357-9293bd3b210mr2439016385a.18.1782742571663; 
 Mon, 29 Jun 2026 07:16:11 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:11 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH RESEND v5 13/25] drm/msm/dp: replace power_on with
 active_stream_cnt for dp_display
Date: Mon, 29 Jun 2026 22:14:34 +0800
Message-ID: <20260629-msm-dp-mst-v5-13-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=4734;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=qyaa9q2aizh+9xuBgPhFHv6SP6/o/UrGrHkmxoK5AgY=;
 b=UgHZC2uWpKjq6WlQr39Ul6beQkEn2XYnnMjGlhjWpIjVoqrTQAOEP0+EUP259R3FXtddl2s71
 AEglTWRoyhNCpbfs7vyTrmoSwkLK0BlHFoigltEYTAPb/3Bj1FLE7mP
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 56GPhVn2bzAQSWEKpWU_TTjm9gq_yVUL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXwOpMocc+KsMN
 KWFVQDaJy3wKn53uLMIlOoyF4VC6vazPec0bPGPMFsROlLBBk9VN7RyeeYesK09r7gJJX4ho4PW
 uDBDtHdjthly1T2WY+NuoFs/SU5Ozh0=
X-Proofpoint-ORIG-GUID: 56GPhVn2bzAQSWEKpWU_TTjm9gq_yVUL
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a427e2e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=n0N2oAcnmnxAXiYSG7kA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX/2fnkN3j7Q/r
 MaBTUqKWZpPz2HXHF0yDhPi2FpskasiIdlszpMTJn6r/oQ/jH1mTWEI8QEP+a8ONPOC7aKUganK
 EczXvvJaOx+g4Sy8zqy3DeSSx9ESYzpKPxcEaIk4wlTgflsRxuxvs+3yBDoRqd+j4fS2Tct1oUK
 1YLUDjIvfNOOQH/FpBicOT7tNjA/Cv9fjTeijwzi16bUUWPWvc2cc8stZtYk0jWQ59BP8I9epyq
 Z6CeALdjifWJTjKAT3iDeqoAovtmQVk78qy5stEZ2veYjen3/KVjSb7O8ZzqbFas7vhELJC3I46
 EtODpNSE2IDgSEWEwURPKFQgAlmYH4XivsHaX7NiTsc1fseI9Rlqgny8+z0+T+VvK5VOsqfExBZ
 yFkM3JzAsCrKYBrxC9KPgJKLdEPQzaL/2qofp1LWX5a7uSgqbSFqDx0x5v/sDvm4AZ2hQZh4Ast
 P5Iy6HI2QZ5+rdzRyDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290118
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

