Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C72160A261D
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TQ1MsoRm;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YVzIXBNF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E0F10EDC3;
	Tue, 10 Nov 2026 04:56:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2112810EDC4
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:05 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4AAbo2919666
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hvMgLa0MYW9wbki1F8tn6DWOHCXs9IbHwhX8WJ2OVcE=; b=TQ1MsoRm61ZaPCbH
 LXhIkwGj/z9/UtquHGok3I1nE2F4IXw+MgA6q2mZBhGf+UakOKJ/ZP0auoVRKbEA
 KpZj9iaxgGx0ojjALAZ09GNkZ6h89i3oHjg/eQYnWRC7AweShxXIStU92VvKw47P
 w6lCxwRqwqUm8XJfY1y4+4xZHP0KpcXjsDuTKgxA2+tChiGzAk4lMDWh5KMpjb8H
 DR5KqfSm4hggix3/G0zRKT+BcYcW+zgTGTw4/lV66qVA7zPEjclvvoGg8DmMOQ/t
 plnnrpF/f/bSfrupRxFRoEtqapvf0YbJMMVsRbN84Os1PJ9tw7yww0E7m82kMhQ/
 0ftsGA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg1qwy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:03 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-946811b8f8cso170595785a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286563; x=1794891363;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hvMgLa0MYW9wbki1F8tn6DWOHCXs9IbHwhX8WJ2OVcE=;
 b=YVzIXBNFgUykoBcctJj5V6/wT3pnh1F3yiT7K0/4ctHxBUehOWvnrzy09ycHfLnd/y
 gwBSjceCHsIFPDCW5lcf2pdal9RfPJc3KoEObwFo2Uoq2AY5ZsrUUAjJmtlCxfswNHPA
 6X7IBtdWuCbO2c0Fd0rQhKribW46u+AKsbfDsEkKzkdzoSWanmxyIs8DqqGReG0o0W7A
 hn6Am3xYsuFjFSkVF27AdCjiRCNLEUknnmRpKK0BAeS2NAkBsELMn2+TmqmcytqIcK0b
 oiYnJkw5yeWXBf27S4n/0cF4OE3JQd5fHBL4Q1uIfGeWNzybLm9nKeUP4uqdNZMdO/Tx
 xRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286563; x=1794891363;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hvMgLa0MYW9wbki1F8tn6DWOHCXs9IbHwhX8WJ2OVcE=;
 b=maoSEcYKvJ89IGcJYHPAbNNOLE2lE+EctpeMNlRcqniWkMRJEivp7YIVE5GPkzAVSe
 /OuiQRZ/BqXGDl6FbsWoJsOAlEEfxU7hGrDJWWvCjUi5vdiMatu7RqU2asNVhtpo78R4
 LN+aQqak77635Cdnu8QiOAvfwXgnScZwyN8GZi/kEHRSqoZpGlNqNsLGgrIbxea5fM6l
 9DGoc8TzWMr7w1j4BQLBu0TqNcPcXiqZ6t2zWGj3LTLCz1dTLC5cnlDj8niUG30GzWbc
 7/as4drbf7xoEKgnVQrIRnMvQqXUTf00oncql7LyU62al19eeFM4DV5QZJ7J9q6rWbuc
 Cxbw==
X-Forwarded-Encrypted: i=1;
 AL+hErG1r/HVpvo0ZaMvEJ1ZIzGfF956DYNU6yf7pJXcrWT4HQTvOmDbedJxT/XqCWORpA1ejmf/j93gF5Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Ubxde+NMxsLk666T+a1Hg1Wv0WlUo8tMOCCLJIMFUijfxtFNJ
 WlwjNW2cq54o0XMDeMMLiJWNXkmg8a2qRhEL6+GKYFL+Cmb9G30XtScLXgmJizMwj/tc70NiJ/h
 cmKy3cI53lDggbvjXSWDAtS2W1rI0Yjkgr2SCCwwuNUmtO/m883b7BAWy04VCqo9z7z/EJpI=
X-Gm-Gg: AYBFou0/MTlXZI5HsIchxV/pS+i9EO2QCvJN3rK4DDzNMk2bziqoOMtu+Wha0H6lf3i
 Yk5XhZ5gKUnoS06bsw4U+o9BH3/OdH0lA4BgaxFf50c7+cZUO2XJ87C08/+oikDQNXwNkv2EdYd
 P8W1mwMVJPRLY5kkznfZL1hoRi93BeYQsvaAHqfK0IOzmluADBo1O5inh/AFDEyQ4xd6EPvxr2u
 pzGgtMlhLWLecJQHO3pK7S/6yi8fX3Am5LoWVREyo3Fb/Lngc8WT30q2sR4MQcm+Pn/s7yFHjwl
 6694GpbP3XVR9fd6SHKSjY0i1ZiBzJk1Y4TAZOJ9X7nab2D5wKqKeGEkKTO2gJFBU1Wso22Su37
 Zm8k18ChfNSriEhHRuTlEa+sr2yoyuSwSyiHTS7EnLht72OcOzb0L7DUJ4D32NwUu6PNf/4/d8z
 /8Ngc9QiSkglcXhICASxPCqwq8exFGuMNafsxD
X-Received: by 2002:a05:620a:370b:b0:944:9dd:b6 with SMTP id
 af79cd13be357-9479f38e472mr256311985a.80.1794286563138; 
 Mon, 09 Nov 2026 20:56:03 -0800 (PST)
X-Received: by 2002:a05:620a:370b:b0:944:9dd:b6 with SMTP id
 af79cd13be357-9479f38e472mr256308885a.80.1794286562592; 
 Mon, 09 Nov 2026 20:56:02 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:02 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:39 +0800
Subject: [PATCH v8 18/29] drm/msm/dp: add atomic stream handling for MST
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-18-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=17263;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=bSy4akCHmwL0aCueMGp178tP2mownq/AFah6yYdVPa8=;
 b=UT7B2Fhivbh0gd3+jzG4IhnU1AhFDEnvrnos/InaWnCCl+o4h2U+DhyXwmdpPeGBENVZOAzj7
 Cj2DYgfd+LLAa7Td6rhkeJ77pXD2irvYMkAmIAYO9oBIEH7GOeIoupg
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX/MBRLmRQKmXt
 tHcr8DJv9BKL4RoEz6eTBux59C5M3PkGocnap64hGwx0CcMlBRZxltl7dKrWGf1BpiiDwPxG7/1
 rS6RaccGFv+TE0b899uouIfj+3i/n+uhICpBw6G6G8qUYMx4WPR+3W+YFAcv7kqigyZ1oUv4mER
 l4gb6ibvUvYXQ8Bk33AEhNY0DE3Xm3PrdBsLy2SGIVl1JyUjbdulU/UNIOH/8MG1223epC2T599
 6uyCCj+gbf/W4k4qllYK//60MUb1ysYOj7ri6qRZ6rHixdegWZJroUIRRpWPb39c/cr85JIgara
 9NZL69HLDgT4DBHsTOR9QW09L9bY3tPZ6Cn6kgto0OlOLdsXjdUNVEFgXRpgFxY2GZMkQO96Pgd
 ozH5DO/h5al1sxVoOZK7v87tgEqlstxRhdl3TPVC9tfyVcPLp15oxIqHDmjqnLpCpnrLKCMBfE2
 1+O7NS9S1HxMO5HJTjQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX1JrkH73pNuu5
 HNF2RnvKlzP7V3iZLD3hDwGUDcGKAyTLLq/3U/NRMbBeoIAWJZb6jVYSuxaZJddXE31oPDz2KwZ
 Gw9ogfcWqP/13hSmyzV43DuPaPPboos=
X-Proofpoint-GUID: u5QOTJY7SSWKoe4N9rqRZy97i7I5bDOZ
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2a3e4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5XbiwH4P-ntBLZg0oosA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: u5QOTJY7SSWKoe4N9rqRZy97i7I5bDOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100019
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

Add the atomic check, enable and disable operations for MST streams.

Reserve VC payload bandwidth based on the negotiated link parameters,
and update the MST payload when enabling or disabling each DP stream.
Serialize stream updates that access the shared MST link state.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  11 ++
 drivers/gpu/drm/msm/dp/dp_display.c         |  45 +++++--
 drivers/gpu/drm/msm/dp/dp_display.h         |   7 +-
 drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 197 +++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_mst_drm.h         |   3 +-
 drivers/gpu/drm/msm/msm_drv.h               |  20 +++
 6 files changed, 264 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 802cb62fc010..edf30d7d3d16 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2745,16 +2745,27 @@ static const struct drm_encoder_helper_funcs dpu_encoder_helper_funcs = {
 static void dpu_encoder_mst_atomic_enable(struct drm_encoder *enc,
 				      struct drm_atomic_commit *state)
 {
+	msm_dp_mst_stream_enable(enc, state);
 	dpu_encoder_virt_atomic_enable(enc, state);
 }
 
 static void dpu_encoder_mst_atomic_disable(struct drm_encoder *enc,
 				       struct drm_atomic_commit *state)
 {
+	msm_dp_mst_stream_disable(enc, state);
 	dpu_encoder_virt_atomic_disable(enc, state);
+	msm_dp_mst_stream_post_disable(enc, state);
+}
+
+static int dpu_encoder_mst_atomic_check(struct drm_encoder *enc,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	return msm_dp_mst_stream_atomic_check(enc, crtc_state, conn_state);
 }
 
 static const struct drm_encoder_helper_funcs dpu_mst_encoder_helper_funcs = {
+	.atomic_check    = dpu_encoder_mst_atomic_check,
 	.atomic_mode_set = dpu_encoder_virt_atomic_mode_set,
 	.atomic_enable   = dpu_encoder_mst_atomic_enable,
 	.atomic_disable  = dpu_encoder_mst_atomic_disable,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1d8eef466e79..af8d22fd4fc5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -457,6 +457,16 @@ static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
 							plugged);
 }
 
+bool msm_dp_display_is_plugged(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display,
+			  struct msm_dp_display_private, msm_dp_display);
+
+	return READ_ONCE(dp->plugged);
+}
+
 static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 {
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
@@ -1302,7 +1312,8 @@ int msm_dp_mst_register(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	return msm_dp_mst_mgr_init(msm_dp_display, msm_dp_ctrl_get_stream_cnt(dp->ctrl), dp->aux);
+	return msm_dp_mst_mgr_init(msm_dp_display, dp->link,
+				   msm_dp_ctrl_get_stream_cnt(dp->ctrl), dp->aux);
 }
 
 void msm_dp_mst_unregister(struct msm_dp *msm_dp_display)
@@ -1564,28 +1575,34 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
 }
 
-void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
-				  struct msm_dp_panel *msm_dp_panel,
-				  const struct msm_dp_mst_slot_info *slots)
+int msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				 struct msm_dp_panel *msm_dp_panel,
+				 const struct msm_dp_mst_slot_info *slots)
 {
-	int rc = 0;
+	int rc;
 	struct msm_dp_display_private *dp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	if (msm_dp_display->link_ready) {
-		rc = msm_dp_display_enable(dp, msm_dp_panel, slots);
-		if (rc)
-			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+	if (!msm_dp_display->link_ready)
+		return -ENOLINK;
 
-		rc = msm_dp_display_post_enable(msm_dp_display);
-		if (rc) {
-			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-			msm_dp_display_disable(dp, msm_dp_panel);
-		}
+	rc = msm_dp_display_enable(dp, msm_dp_panel, slots);
+	if (rc) {
+		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+		return rc;
+	}
+
+	rc = msm_dp_display_post_enable(msm_dp_display);
+	if (rc) {
+		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
+		msm_dp_display_disable(dp, msm_dp_panel);
+		return rc;
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
+
+	return 0;
 }
 
 void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 7b6d76f33ac6..62400547e01a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -46,9 +46,9 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
-void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
-				  struct msm_dp_panel *msm_dp_panel,
-				  const struct msm_dp_mst_slot_info *slots);
+int msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				 struct msm_dp_panel *msm_dp_panel,
+				 const struct msm_dp_mst_slot_info *slots);
 void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
 				   struct msm_dp_panel *msm_dp_panel,
 				   const struct msm_dp_mst_slot_info *slots);
@@ -66,4 +66,5 @@ int msm_dp_mst_register(struct msm_dp *msm_dp_display);
 void msm_dp_mst_unregister(struct msm_dp *msm_dp_display);
 struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 					      enum msm_dp_stream_id stream_id);
+bool msm_dp_display_is_plugged(struct msm_dp *msm_dp_display);
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index ef5fb70863b8..eae82e857c84 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -31,8 +31,11 @@ struct msm_dp_mst {
 	struct drm_dp_mst_topology_mgr mst_mgr;
 	struct msm_dp_mst_encoder mst_encoders[DP_STREAM_MAX];
 	struct msm_dp *msm_dp;
+	struct msm_dp_link *link;
 	struct drm_dp_aux *dp_aux;
 	u32 max_streams;
+	/* Serializes concurrent stream link-state access across streams. */
+	struct mutex mst_lock;
 };
 
 static void dp_mst_connector_destroy(struct drm_connector *connector)
@@ -135,6 +138,42 @@ static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
 	return drm_dp_atomic_release_time_slots(state, &mst->mst_mgr, mst_conn->mst_port);
 }
 
+static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst,
+							   struct drm_encoder *enc)
+{
+	int i;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		if (mst->mst_encoders[i].enc == enc)
+			return mst->mst_encoders[i].dp_panel;
+	}
+	return NULL;
+}
+
+static void msm_dp_mst_collect_slots(struct msm_dp_mst *mst,
+				     struct drm_dp_mst_topology_state *mst_state,
+				     struct msm_dp_mst_slot_info *slots)
+{
+	int i;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		struct msm_dp_panel *dp_panel = mst->mst_encoders[i].dp_panel;
+		struct drm_dp_mst_atomic_payload *payload;
+
+		if (!dp_panel->connector)
+			continue;
+
+		payload = drm_atomic_get_mst_payload_state(mst_state,
+				to_dp_mst_connector(dp_panel->connector)->mst_port);
+		if (!payload || payload->vc_start_slot < 0)
+			continue;
+
+		slots[dp_panel->stream_id].start_slot = payload->vc_start_slot;
+		slots[dp_panel->stream_id].tot_slots = payload->time_slots;
+		slots[dp_panel->stream_id].pbn = payload->pbn;
+	}
+}
+
 static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
 					struct drm_encoder *enc)
 {
@@ -147,6 +186,158 @@ static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
 	return -1;
 }
 
+void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
+			       struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector =
+		drm_atomic_get_new_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp *dp_display = mst->msm_dp;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+	struct drm_dp_mst_port *port = mst_conn->mst_port;
+	struct drm_dp_mst_topology_state *mst_state =
+		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_atomic_payload *payload =
+		drm_atomic_get_mst_payload_state(mst_state, port);
+	struct msm_dp_mst_slot_info slots[DP_STREAM_MAX] = {};
+	int rc;
+
+	guard(mutex)(&mst->mst_lock);
+
+	drm_connector_get(connector);
+	panel->connector = connector;
+
+	rc = msm_dp_display_set_mode_helper(dp_display, state, encoder, panel);
+	if (rc) {
+		drm_err(dp_display->drm_dev,
+			"[MST] stream:%u set_mode failed rc=%d\n", panel->stream_id, rc);
+		return;
+	}
+
+	rc = msm_dp_display_prepare_link(dp_display);
+	if (rc) {
+		drm_err(dp_display->drm_dev,
+			"[MST] stream:%u prepare_link failed rc=%d\n", panel->stream_id, rc);
+		return;
+	}
+
+	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
+
+	rc = drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
+	if (rc)
+		return;
+
+	msm_dp_mst_collect_slots(mst, mst_state, slots);
+
+	drm_dbg_kms(dp_display->drm_dev,
+		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
+		    panel->stream_id, payload->vc_start_slot,
+		    payload->time_slots, payload->pbn);
+
+	rc = msm_dp_display_enable_helper(dp_display, panel, slots);
+	if (rc)
+		return;
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+
+	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
+}
+
+void msm_dp_mst_stream_disable(struct drm_encoder *encoder,
+			       struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+	struct drm_dp_mst_topology_state *old_mst_state =
+		drm_atomic_get_old_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_topology_state *new_mst_state =
+		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_atomic_payload *old_payload =
+		drm_atomic_get_mst_payload_state(old_mst_state, mst_conn->mst_port);
+	struct drm_dp_mst_atomic_payload *new_payload =
+		drm_atomic_get_mst_payload_state(new_mst_state, mst_conn->mst_port);
+	struct msm_dp_mst_slot_info slots[DP_STREAM_MAX] = {};
+
+	guard(mutex)(&mst->mst_lock);
+
+	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
+
+	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, new_payload);
+
+	msm_dp_mst_collect_slots(mst, new_mst_state, slots);
+
+	drm_dbg_kms(mst->msm_dp->drm_dev,
+		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
+		    panel->stream_id, new_payload->vc_start_slot,
+		    new_payload->time_slots, new_payload->pbn);
+
+	if (!msm_dp_display_is_plugged(mst->msm_dp))
+		return;
+
+	msm_dp_display_disable_helper(mst->msm_dp, panel, slots);
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+}
+
+void msm_dp_mst_stream_post_disable(struct drm_encoder *encoder,
+				    struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+
+	guard(mutex)(&mst->mst_lock);
+
+	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);
+
+	if (!mst->msm_dp->mst_active)
+		msm_dp_display_unprepare(mst->msm_dp);
+
+	panel->connector = NULL;
+
+	drm_connector_put(connector);
+}
+
+int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(conn_state->connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct drm_dp_mst_topology_state *mst_state;
+	int bpp, pbn, slots;
+
+	if (!conn_state->crtc)
+		return 0;
+
+	if (!drm_atomic_crtc_needs_modeset(crtc_state) || !crtc_state->active)
+		return 0;
+
+	bpp = (conn_state->connector->display_info.bpc * 3) ?: 24; /* fallback: assume 8bpc */
+	pbn = drm_dp_calc_pbn_mode(crtc_state->mode.clock, bpp << 4);
+
+	mst_state = drm_atomic_get_mst_topology_state(crtc_state->state, &mst->mst_mgr);
+	if (IS_ERR(mst_state))
+		return PTR_ERR(mst_state);
+
+	if (!dfixed_trunc(mst_state->pbn_div)) {
+		mst_state->pbn_div =
+			drm_dp_get_vc_payload_bw(mst->link->link_caps.rate,
+						 mst->link->link_caps.num_lanes);
+	}
+
+	slots = drm_dp_atomic_find_time_slots(crtc_state->state, &mst->mst_mgr,
+					      mst_conn->mst_port, pbn);
+	if (slots < 0)
+		return slots;
+
+	return 0;
+}
+
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder)
 {
@@ -286,7 +477,8 @@ static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
 	.add_connector = msm_dp_mst_add_connector,
 };
 
-int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
+			 u32 max_streams, struct drm_dp_aux *drm_aux)
 {
 	struct drm_device *dev = dp_display->drm_dev;
 	struct msm_dp_mst *mst;
@@ -298,6 +490,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_d
 
 	mst->mst_mgr.cbs = &msm_dp_mst_drm_cbs;
 	mst->msm_dp = dp_display;
+	mst->link = link;
 	mst->max_streams = max_streams;
 	mst->dp_aux = drm_aux;
 
@@ -312,6 +505,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_d
 		return ret;
 	}
 
+	mutex_init(&mst->mst_lock);
 	dp_display->msm_dp_mst = mst;
 	return 0;
 }
@@ -324,6 +518,7 @@ void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display)
 		return;
 
 	drm_dp_mst_topology_mgr_destroy(&mst->mst_mgr);
+	mutex_destroy(&mst->mst_lock);
 	dp_display->msm_dp_mst = NULL;
 	kfree(mst);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 3cbd2a674675..822d34cd6ff5 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -7,7 +7,8 @@
 
 #include "dp_display.h"
 
-int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
+			 u32 max_streams, struct drm_dp_aux *drm_aux);
 void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index cc665888ce7f..597728ec6f3b 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -362,6 +362,12 @@ int msm_dp_mst_register(struct msm_dp *dp_display);
 void msm_dp_mst_unregister(struct msm_dp *dp_display);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
+void msm_dp_mst_stream_enable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void msm_dp_mst_stream_disable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void msm_dp_mst_stream_post_disable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -415,6 +421,20 @@ static inline int msm_dp_mst_attach_encoder(struct msm_dp *dp_display,
 	return -EINVAL;
 }
 
+static inline void msm_dp_mst_stream_enable(struct drm_encoder *enc,
+					     struct drm_atomic_commit *state)
+{}
+static inline void msm_dp_mst_stream_disable(struct drm_encoder *enc,
+					     struct drm_atomic_commit *state) {}
+static inline void msm_dp_mst_stream_post_disable(struct drm_encoder *enc,
+						  struct drm_atomic_commit *state) {}
+static inline int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
+						 struct drm_crtc_state *cs,
+						 struct drm_connector_state *cos)
+{
+	return -EINVAL;
+}
+
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP4

-- 
2.43.0

