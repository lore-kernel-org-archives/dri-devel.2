Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D427C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F2B310E923;
	Mon, 29 Jun 2026 14:16:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvBtcp93";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OKwos9gs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D50F10E922
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:09 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT32H2646911
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9svuRAUWKf4Cq1A1NpmrcreySoHCCAmo74eRJpf7Vus=; b=FvBtcp93s60t70/g
 rDJHI02+YFKeFdjKddP8ayK3ki6gyiIpgIXkpCkIp4h45xyP0PdGxgYWfDFTOFsA
 L7jaQtPKeIqu6ulLAFFnH289+kKxeXZIefSf++XMYnUUjSgxPzDe2tnMyUlsX0Yf
 w6GEhxo4eceQ3rZaM7S8EthwbsjM6HmTxM1vywsfDoZfMOmsQ0ehg/ia1CfBTgKL
 lAnGwcflsNydJp6hiTgoz6z29JAIJcQ3kXHZu2Q2W7beJ1ART39mXLd0yVxEzUQE
 GiS+pExAKOOtlqkmyJJboBd4N0UDuQILcD0d3QQRDx7G5pB5AXdurumBrJ8kOdwk
 5R8Qkw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tsnrh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so47637285a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742568; x=1783347368;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9svuRAUWKf4Cq1A1NpmrcreySoHCCAmo74eRJpf7Vus=;
 b=OKwos9gs7C34LpM+7qysLdsl4EPq0vTUXhYgYublF+NHtnyj7509TZvplR4+028JO4
 Naa4a0SruZBiPC7hmcMKFzLsPI7jKtKcsp76vyPdFT1f177wQ5jc6ebZiruX/8t20RfQ
 kJXxyJSefcGju0dN8b8DLg6wuaO4cfUfCwB/EWNT89IKYJSVoe1KCYwqapWDjWPHoG2H
 4vKv/OWFyVTgLa6z6zIyXool73me/ESPfRXLYFxBE1EDUiaQRCMJgGKXVdtJlKSpLtts
 WT7krNjQFYLxSV+KkOe8tKT7Dhrpz5m/YvaiHoyZJc/aSMh9Sd9yUxUPne1BpcB6SWJ/
 /3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742568; x=1783347368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9svuRAUWKf4Cq1A1NpmrcreySoHCCAmo74eRJpf7Vus=;
 b=rlDP3/Px7lpbG+9OlFaUNIYVsZSp3VTj69HGe1GIR0M7qvgYSon6rH/r90Oris87Wz
 YDIYXFJHeWamXPMlZsLKh7WXucFwJHIkJ137Rz6HhJOnEUeHNVjIemOYnM+GpLzBXLjO
 qNJGclB+IF0dp2PUEow4DpC8MfiNMrD5Xe2tuDFxb5LhL1NmOIM3wtRxBj51a+Ft3sRz
 NlJ3VenER+pj7x1uQ6CTCSKrfCtPjwHxFe23F7roC4K0N0EDDWCgo75S5WZ/cSDBugRb
 z1HB/nSWjkLI4qjvbirwNn2CBu0cYkziZcA4HfgbcLXc7me2NcRjIjO6wwNKdu5sX3iU
 crkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ85QEwt26H/uhyw8ZoJYz9b5l1ii8/3Uc1aRZbhC68JPkCyTiXnFYKvW/oSp9HN6wa8aPuz7MB1o88=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybII5SH301FfzUMkzUZ0zi7Y+CTvqpFdi9tnt7OiQjBmlE7Ezm
 E8o4Mq8KsuCt1QUM+TVDKnuvdhzfOEeOy1F13TKS6efmu7izw2sCYPTBo81JjExcD6FCouhVSAn
 fynvn38bha50Tqu1rdq0XsuA1i7St2slSDa/LjcHo3BdNJL5trRZnG8W2qnvxpafx4MYQr90=
X-Gm-Gg: AfdE7cl7ZaIyoIzVcQdllgCLJ7Bm5NkSQIQLQb9V8vIjSe+kMb/budSBjeCnyJ4U//S
 NmnpwP9uPJxHrcO2RD4GkN0jRzlIKM0lKg3AW3tKevZQBqrmcDsMiXBVYJRhLLQUIjQEGTSzwdk
 ZJY592eTmldoipDnuS85Zlr2GdWIbiaXOG/Y1Gmpk3Fr+9BCEO+blI6bfCxDO8cFLSiVFpKJbw9
 3O/cPzS/tdpTMfJNuoAoKlEFtHLJTzvTwfFZ/4dy1/gB3KtCydUnTstMB5RL9JG4d4fgx1zdyDY
 HSYXQXJHZzszzO9u70RJ13LYNR1oLdROI3So3NGd4Lkd6bC6NuIlBrOswY4bP0tLg5Cwqo9NbxD
 dvAs3KgviQnDQ1TGHtRFmrin70rRAAJegFJvNeHK/u7u0JIsXtsEPG3Ez9S5t+lofUAzcpA==
X-Received: by 2002:a05:620a:649c:b0:92e:583d:245f with SMTP id
 af79cd13be357-92e583d2685mr226504285a.9.1782742567419; 
 Mon, 29 Jun 2026 07:16:07 -0700 (PDT)
X-Received: by 2002:a05:620a:649c:b0:92e:583d:245f with SMTP id
 af79cd13be357-92e583d2685mr226495485a.9.1782742566595; 
 Mon, 29 Jun 2026 07:16:06 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:06 -0700 (PDT)
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
Subject: [PATCH RESEND v5 12/25] drm/msm/dp: factor out _helper variants of
 bridge ops accepting a panel
Date: Mon, 29 Jun 2026 22:14:33 +0800
Message-ID: <20260629-msm-dp-mst-v5-12-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=8495;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=euWeALUbmMzdGUkiE/Q/aV5WnjeW32f7QOdos3tj6qM=;
 b=fAjkaZpkbNRnCfGR5EIRi4ljXey4d1pcgi2ob2hEyPJ0JJRkcBeLFHuUbSQnQ2VBsT8iEQv/i
 JABrtDm7QI0A/k1lX8pD9lt6J9xFwwpzN4lugnnTzmJFTjFrHMPbWRD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX5HZs77gDYEjx
 xKQsTPy7CwevirMpMRcPi0IwHcmo15lg8GkTRe0UmsXLfwot48dlbYDb1YahlMcMPtqeccsQPVo
 Xd5pDLaKdGfg+sBdeU6gWbTivyEUHCElnZyDuzyU5xBKgCYQa2XxZFyc9V1q01VDVZjd63ZIGwC
 MK1wcFEVErArTxPkzdNFsJHoT7b+RQ6BhHyPB1jENR5MTKDrTBCwREL0n9wlk03CIPFoKuG4A+M
 OI3nPrPewaGcIaU/R6i1a1bYxbpbG7dsYQDuZ30cL+11ysO2s3vMZpMLLrONdXTcykLGC7rlJtJ
 tJLJ0HjlLahWzwazImQ3AO7SCJrpALuy3CBM6voJBaYIs3kZXT/F85NNtHOWBaVSN+IxgVdbDVh
 y+uCPdyCUxhcA63WjlaqDyg1hqqST/vdWvaT3XVhq3Y0dUbeP2IWhyKy2Z+8tRlK9euILpZOHo+
 8psay6X4GFW0LDTBucQ==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a427e28 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mu3EkBhnCEQeHIwj90QA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX2r6jlx/iWegJ
 NiDGTa/nE7Gw/ljQInJAEMghrSypFTcFN4FmqT/G9/7kB+i35HdDpVWrh2mmsA/ivXzjUhI2dZt
 LweixjFxiIlCohPEIHR7Qbz/eREEWsI=
X-Proofpoint-ORIG-GUID: 2F3PsZfItnABXfAs100hCifZNfjWHRdb
X-Proofpoint-GUID: 2F3PsZfItnABXfAs100hCifZNfjWHRdb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

The atomic bridge callbacks (set_mode / enable / disable /
post_disable) on dp_display currently hard-code dp->panel. For
DP MST every stream has its own msm_dp_panel that the MST
encoder owns, so the same enable/disable sequence needs to be
invokable against an arbitrary panel.

Introduce *_helper variants that take struct msm_dp_panel * and
reduce the existing atomic_* callbacks to thin wrappers that
pass dp->panel. No SST-path behaviour change.

Also drop the static qualifier from msm_dp_display_prepare_link()
and msm_dp_display_unprepare() and change them to take
struct msm_dp * so the upcoming MST encoder code can drive
link-level prepare/unprepare uniformly through the public API.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 93 +++++++++++++++++++++++++++----------
 drivers/gpu/drm/msm/dp/dp_display.h | 12 +++++
 2 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1680a67284a7..0e432f35cc51 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -628,12 +628,14 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	return 0;
 }
 
-static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
+int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *dp;
 	int rc = 0;
 	bool force_link_train = false;
 
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
 
 	if (msm_dp_display->is_edp)
@@ -1457,69 +1459,101 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
-				   struct drm_atomic_commit *state)
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state,
+				   struct drm_encoder *drm_encoder,
+				   struct msm_dp_panel *msm_dp_panel)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
+
+	crtc = drm_atomic_get_new_crtc_for_encoder(state, drm_encoder);
+	if (!crtc)
+		return 0;
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	return msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, msm_dp_panel);
+}
+
+void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state)
+{
 	int rc = 0;
 	struct msm_dp_display_private *dp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	crtc = drm_atomic_get_new_crtc_for_encoder(state,
-						   msm_dp_display->bridge->encoder);
-	if (!crtc)
-		return;
-	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
-
-	rc = msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
+	rc = msm_dp_display_set_mode_helper(msm_dp_display, state,
+					    msm_dp_display->bridge->encoder, dp->panel);
 	if (rc) {
 		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
 		return;
 	}
 
-	rc = msm_dp_display_prepare_link(dp);
+	rc = msm_dp_display_prepare_link(msm_dp_display);
 	if (rc)
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *dp;
 	int rc = 0;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0);
+	msm_dp_display_set_stream_info(msm_dp_display, msm_dp_panel, 0, 0, 0);
 
-	rc = msm_dp_display_enable(dp, dp->panel);
+	rc = msm_dp_display_enable(dp, msm_dp_panel);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp, dp->panel);
+		msm_dp_display_disable(dp, msm_dp_panel);
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0);
+
+	msm_dp_display_enable_helper(msm_dp_display, dp->panel);
+}
+
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);
+	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
+	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
+}
+
 void msm_dp_display_atomic_disable(struct msm_dp *dp)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
-	msm_dp_ctrl_mst_stream_channel_slot_setup(msm_dp_display->ctrl);
-	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
+	msm_dp_display_disable_helper(dp, msm_dp_display->panel);
 }
 
-static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
@@ -1534,11 +1568,9 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
-
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
@@ -1549,7 +1581,18 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
+	msm_dp_display_disable(msm_dp_display, msm_dp_panel);
+
+	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
+}
+
+void msm_dp_display_atomic_post_disable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_atomic_post_disable_helper(msm_dp_display, dp->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 45e2cc2d6add..55ffa22bb233 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -45,5 +45,17 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_mode *mode);
 int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
 				   u32 start_slot, u32 num_slots, u32 pbn);
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				  struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp_display,
+					       struct msm_dp_panel *msm_dp_panel);
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state,
+				   struct drm_encoder *drm_encoder,
+				   struct msm_dp_panel *msm_dp_panel);
+int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
+void msm_dp_display_unprepare(struct msm_dp *dp);
 
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

