Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7448A606A338
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U1jgcsrx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=E1uxVRfW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1661A112146;
	Thu, 19 Nov 2026 08:25:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B922D11212F
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:13 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vPbo053035
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wRoGi+ko4pfiJX0p7XmAqIElu01RnwG2HIv7gmybVcg=; b=U1jgcsrxMhLcQ8l5
 pqXVecDODk8xIyp6fd8m6IKCad1u53psHkWpZm5BaN7weABoFgK7t++YnxpryxM6
 mwavuZS/P2DbIFx3w7IY8wVPIXVEuc/UpaGbfuL/G+QY79pSzdpL2CCPVweBX8XB
 3Z9iOVVZn/Lg1/fJybg8BqN2nEWgU5uUXTAOv1cIjJBJHLkGHH7kmCuBzoSBezRu
 60u7xiq8sAT7mfbbLDdPLpVVNAyLOjsUKY8O5ss8oZJG6wncRpeJkLliTO9xhHQ2
 pWid9tjOZFNOQqXZ9Ek0N0vNKjmZvqASTm3OcdRbF3qtazdaLmiIercQ1F21Gvfk
 VuNDJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g3bbgha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:12 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-949b0d3232fso38187885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076712; x=1795681512;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wRoGi+ko4pfiJX0p7XmAqIElu01RnwG2HIv7gmybVcg=;
 b=E1uxVRfWK1PjNpWEpX1+/mf2i1VLCxI3yNtmXO5FkgD7zqnwB3HNcJ11Td+ZRxfAoV
 keekGrqthZWvZrzMDu1Sb5EVti+0DdBjjoWZwPjHv0ozYKVPMjxy0jmgjzJLRrWfD6J8
 /gV/VECo73lY8OhuBOa1Tf5azC9gkjmzBBnR7n5XoVE5YP8D8JcS9la27PkW7TXXccqJ
 KLJ7vwE3AtvXHgs1QZbTfM1du5g3kG0eAHT40BS9NyQl9xzejYaWqOs+SeGVljWd7naA
 r7ldyg3gv5bk3ikB/bwJg2FjWX+W1+nJW1Ldai21cYwFTffMq1IRc2M+LR2mCmowOKmq
 92Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076712; x=1795681512;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wRoGi+ko4pfiJX0p7XmAqIElu01RnwG2HIv7gmybVcg=;
 b=bn3kErPNNnRB/1Z0kJ9IRqqaDbDgTX6Jx+uLEKFkHOZLCZSqloDBI6muezZBtQ8guS
 7B/RBChEamG4Ag4+lSQhyt+A7WOg88fbppfXMK8muj/oO44wfxtOI4HFac1KCbj3Vt59
 cCrUXmdacxubh4eQWDzy0PQ09n2B7qP5vECCnZq4SiQQuJ7QnmbDcfp/SEX0OtOqUVTg
 TCwrCapo2LTdPegB5kF4N3VLRDaHDy0pKX/qW7xEMD04Fy/PYg8J8xmtyCQRN7UVmBa9
 QAKe1OvjKSu7Fly/bxAHipgabpd67EPGnLz+GFOQh7Ye8CLU/u4YOnFni3jkplHqd32Q
 DgqQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHO8zJ4HTHkHQ1GMlImd0+2tCLLAYpjzrcSOnROKoGXNRbWRITq8bPONcqYHv2TUwzBolAqr7LpWI4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8L6qfqWgNg7SRadCJHEvqco7GG7s9Xbj4ZFqQVx3F6jYMJ8EgV
 JvJbwlUJBHfYegSL90j+sqIaQne8wb60iW4DYFnlhyyv2n/NUQxNDEpNGvmDdlOYArURw8PNXW5
 u2t4cXeaqCe4A246CsHBItiYgYzwZea6JQsjl7OvuOE9igjo+LarDuGntA1UFYc760837rwY=
X-Gm-Gg: AYBFou20x1AiOhvbM2F+RZzpFobhY9v3vJbYe6e01/1lbSEopNsLx4bxXNFC+CzcBMA
 dgjuXe8HeLyhbPgjnIkoYBcNIz+SpbZlBYWsqfyGi3aNvy7Jde2Od3GZaGtsvRZGD9aBVROShLz
 Cd9C0B6frsReRe18mKFVo0tvYEjcgwmcsaWkXZdcP7fSQilk6Y8gRHQ/3y6OST3MwaKoDARcawg
 chePC3Z38r6pbcTdQD3/oFmwl+QS7f0p7LhGhkAvNFKuefG17xlMuRriWtKVk7XTOubIdUFzWNT
 RmQz22hIt9DLJMwuPO9wmh9ZNTZNc5c9n+K91nTsvklG3YxJAnOiQKNKX4a/gitPqhub9e3I7pU
 82nsjEPkFU5MatLbcpP1jhTKB1tDozeKLCrT1p+2OyAuOK1ind6fKERzxIKmMECCs7PUpiqoaur
 OarVk/yNzLyDXo/GJdKKJ/NQ8KnvXWzjoYbY8g
X-Received: by 2002:a05:620a:ac08:b0:93e:c12c:4402 with SMTP id
 af79cd13be357-9499b303374mr661244685a.79.1795076711780; 
 Thu, 19 Nov 2026 00:25:11 -0800 (PST)
X-Received: by 2002:a05:620a:ac08:b0:93e:c12c:4402 with SMTP id
 af79cd13be357-9499b303374mr661241785a.79.1795076711265; 
 Thu, 19 Nov 2026 00:25:11 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:10 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:10 +0800
Subject: [PATCH v9 08/29] drm/msm/dp: replace power_on with active_stream_mask
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-8-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=7050;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=tcZD36jERDRUia7uqcbSeMVy5ZQ1xToMDIHFkd6tYro=;
 b=nsMtwPuBEWLD2C1MrMyXzUXTqZidodIWKX4eiK4MS4dBFcCBTYYfeipIfrGXCNF4kDJc8uQPh
 DC7Ebp5J1MCBYt9x97NJlIA3LWg7+vddBGLQr7Tq2hAg00JnX3agL1f
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: TV1PmLEtn65ix9_b6WCSunhaFhJmKOG6
X-Proofpoint-GUID: TV1PmLEtn65ix9_b6WCSunhaFhJmKOG6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX3qJK7XQBLNz6
 Xao5+oPrnPy2aVOvvAVbV57r7Yjg2SjfAiPKuMkk5DRFvKeAFSWKYQB+/AdkNF90vvRg1/P3uoM
 XcuaBwv6HxVxy6rrVH4AF7o9wwNnGsQ=
X-Authority-Analysis: v=2.4 cv=dZQVTnXe c=1 sm=1 tr=0 ts=6afeb268 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=OPa7gS6xof81t_cfdRgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX+YAw/P0WIU7y
 kxirPhjdsG2zPya+tN/V8yDnZdtuCMPUhwS6fHCjzO9HaGXmHfza3ModIFcXy1MT5fGz+gT2zgI
 QzLg3PicuLMOEumb5H7CevSzYu01CeLDoCjsviBR7VZuCQU2G9ZLLWAEMmFbR0Pg94dOaGVy7Ok
 qoAEjdVyCEb1apeVvIdfx+b8RdYUKm6nYhVaKuA1lQaUiS/HVA1OTQ/MetKqqynfuB7mNmkpKCd
 pAIcsvIFIKwg4QEeg1qjijhgyzU5SkzrGAgn2BX6c9hrQD8cXB6p3Dvc7YdOfpE4ghAPzQM9AQY
 rK5ibJbcAwfXwJ0dnI8VQ8TiKqLBd06/yU2KFgeOx6K3qKG1fKCVQ/TGNc2JSirptbsXDkQ6bvQ
 kM2lHT7iorbuetwlcsxcFbHH+TguaYWISK9LzTW/gTxgT8gD3kvGzjfyM9xfq4zeGYZ5sfAC4ot
 6cBQLwdW9NZAwDMLsoA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

The power_on boolean cannot represent DP MST, where multiple streams
share a single link and its associated resources.

Replace power_on with active_stream_mask, a bitmask of the streams that
have been successfully enabled, and use it to track the lifetime of the
shared link. Link initialization is performed when enabling the first
stream, while link teardown is deferred until the last stream is
disabled.

A per-stream bit rather than a count is needed because two callers ask
whether one specific stream is up: msm_dp_display_disable() uses it to
stay idempotent, and msm_dp_display_disable_helper() uses it to tell
whether that stream ever made it through .atomic_enable().

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   |  2 +-
 drivers/gpu/drm/msm/dp/dp_display.c | 56 ++++++++++++++++++++-----------------
 drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
 3 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index df222943ae57f..05972a302e542 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -284,7 +284,7 @@ int msm_dp_audio_prepare(struct drm_bridge *bridge,
 	 * such cases check for connection status and bail out if not
 	 * connected.
 	 */
-	if (!msm_dp_display->power_on)
+	if (!msm_dp_display->active_stream_mask)
 		goto end;
 
 	audio = msm_dp_audio_get_data(msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e046184a30f50..169990c10b367 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -652,16 +652,16 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	if (dp->link->sink_count == 0)
 		return -ENOTCONN;
 
-	if (!msm_dp_display->power_on) {
+	if (!msm_dp_display->active_stream_mask) {
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
@@ -671,21 +671,19 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 				 struct msm_dp_panel *msm_dp_panel,
 				 const struct msm_dp_mst_slot_info *slots)
 {
-	int rc = 0;
+	int rc;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
-	if (msm_dp_display->power_on) {
-		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
-		return 0;
-	}
 
 	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel, msm_dp_display->mst_active,
 				   slots);
-	if (!rc)
-		msm_dp_display->power_on = true;
+	if (rc)
+		return rc;
 
-	return rc;
+	msm_dp_display->active_stream_mask |= BIT(msm_dp_panel->stream_id);
+
+	return 0;
 }
 
 static int msm_dp_display_post_enable(struct msm_dp *msm_dp_display)
@@ -732,9 +730,11 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
-	if (!msm_dp_display->power_on)
+	if (!(msm_dp_display->active_stream_mask & BIT(msm_dp_panel->stream_id)))
 		return 0;
 
+	msm_dp_display->active_stream_mask &= ~BIT(msm_dp_panel->stream_id);
+
 	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
@@ -851,10 +851,10 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
 	 * if we are reading registers we need the link clocks to be on
 	 * however till DP cable is connected this will not happen as we
 	 * do not know the resolution to power up with. Hence check the
-	 * power_on status before dumping DP registers to avoid crash due
+	 * active stream state before dumping DP registers to avoid crash due
 	 * to unclocked access
 	 */
-	if (!dp->power_on)
+	if (!dp->active_stream_mask)
 		return;
 
 	msm_disp_snapshot_add_block(disp_state, msm_dp_display->ahb_len,
@@ -1514,16 +1514,17 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 
 	/*
 	 * If .atomic_enable() bailed out - link training failure is the common
-	 * case - the mainlink was never brought up and ->power_on stayed false.
-	 * Driving the PUSH_IDLE pattern into a controller that was never
-	 * enabled times out, and .atomic_post_disable() then drops the
-	 * controller's runtime-PM reference without tearing the PHY back down,
-	 * because msm_dp_display_disable() returns early on !power_on.  On
+	 * case - the mainlink was never brought up and the stream was never
+	 * marked active in ->active_stream_mask.  Driving the PUSH_IDLE pattern
+	 * into a controller that was never enabled times out, and
+	 * .atomic_post_disable() then drops the controller's runtime-PM
+	 * reference without tearing the PHY back down, because
+	 * msm_dp_display_disable() returns early for an inactive stream.  On
 	 * glymur (Snapdragon X2 Elite) that combination is answered by a
 	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
 	 * There is nothing to push idle, so leave it alone.
 	 */
-	if (!dp->power_on)
+	if (!dp->active_stream_mask)
 		return;
 
 	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
@@ -1535,6 +1536,11 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
+	if (msm_dp_display->active_stream_mask) {
+		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
+		return;
+	}
+
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
@@ -1547,8 +1553,6 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 	else
 		msm_dp_display_host_phy_exit(dp);
 
-	msm_dp_display->power_on = false;
-
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 472429d092009..b163954deafcd 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -18,7 +18,7 @@ struct msm_dp {
 	struct drm_bridge *next_bridge;
 	struct drm_bridge *bridge;
 	bool audio_enabled;
-	bool power_on;
+	u32 active_stream_mask;
 	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;

-- 
2.43.0

