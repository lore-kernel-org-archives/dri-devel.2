Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE96C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 544A310E933;
	Mon, 29 Jun 2026 14:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EjtrbSou";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bgJOW+AE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6301010E932
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT72C2618944
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jg3KQF7o+VLEpzr4rtd7xV5y0tUXL2CgXc+z/83VRd0=; b=EjtrbSouwwGO2Jbg
 NlzBqUavK2Y5Y5BbKN6R+OEBh33Wh3m0Nl+fA1UY/I6h6gZJk3QSHzVVC3jRpNbj
 zyMrqLpj87sNhzD3Qz0/EC234O5rxm+TSYpWZWZuZNDu5dF/NTDWGDQi56psWM3e
 IV+Uv81lVtX2NMLGi08GSqBitpA3TzKzRyJvhd4c29EgD1WFAFaIKBkPcPdnGC9v
 05vwk+lEQ+tNIZsZP2XxxWWI9og393DyJLceuj0tX857sdCPWG//zEHtoms94Py9
 TOuBny5jCc0eZG6WMnb8d7HzwYPshy983k7kmhPJF0jAzS/8V6jGjUSKPF+ooxUR
 VOLWFg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdks017-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:35 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ee2847cbd4so44749076d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742595; x=1783347395;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jg3KQF7o+VLEpzr4rtd7xV5y0tUXL2CgXc+z/83VRd0=;
 b=bgJOW+AEqEa6dIES7Kzmy6/2gwdtTQN++mrCxK2s0X6egsDXaR3KmPj2aQD9vioQx8
 5Q6Q8bm8TQF23f+CRziXeqPEb5Z7rcXpzOIhzwc/Vb5k65965P3RHZ5Qk0Jl/f1fbSFM
 vgpEpT5auCEPN3fzEbSMNcJAfPfxnj6H2/VgZGW64O94D5n6+msMFmnqlxfpFmDjq6lr
 igmbBqOA2HaX11bAMwa9AzCeLjCfitQv7Ltuu0kEzhCie6bfGTwIpOyE0OEopmW/KIsY
 OdUks4opxnRa+AXw9L249C5CUmCkei4u4LH0ow1LnVUPSu252qucCJBmj1ARO9pn/eDN
 GEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742595; x=1783347395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jg3KQF7o+VLEpzr4rtd7xV5y0tUXL2CgXc+z/83VRd0=;
 b=Hjvpwj9om7AtdBfwecIvxFM1XttLbqga3RDiVsB0SiUEa69vrQibXrNEsCsiFMQKUa
 DEuLWE/NU4daddQfvH5xD+1NzZcA1yHlWvhVWX+JcGZzgmFo6NXm3i/EvLny/kuoyGrC
 G5VdunOpT0QGfZIa53HtAy0rjROCUuJ5Yepj9L8NfJ838nMpymLzDP4g1NF8iDO0JP7Y
 zbP1wsnbOaWduBb0vjxm19PFprikCO334bIXjCXh6VVsYHugTHtiwmdq+q0grO/R8Ck5
 Rdiecj0IYymReSDX/CN985YruCf/ohD0ZBKzxZrMelkddFxo+rT/cToWWt0taKsfcA4b
 eIBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8J5mPnTGgzqt6la8JNlxEofzoFNMg513HrzrYTr4STzY3AII5+47vgKBG8iJbnZndf4lFbsAQ40bU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsXFR1YBKbe9qV0ppuuDd2dxsZyTGUc0a6nxBkctRQLydGo9pI
 2l08bCHZQ8tOvjIHnuJfzdBwRoLSDYnmcdsvsBh+zB7xScrrlQTu7ewV5mTPtu6qZE+ftR0sFX8
 r7dxO4dgtHEcVyxZdG4dQ1SlKy/njZ4NcjzcY3d4sWziza08VXeZbeERAcIOQDrdfPDysLMg=
X-Gm-Gg: AfdE7ckrhyZgJbWTOYm37lSw7KdAk6FKRo/DCkM5aG3fz7MVGb1aeMwfX3eUpWKNd0U
 tNqyrH66M0KYq4GJV5H3gFAq+tX/y9QYrL1efesMNuasOaHyFIssEjxmwE/3x8pml0e7QjoMcQS
 CKzx+lWd3140DkSPJTA/Nz1QogLpyIB1IHSbsp5dwNP09z38yMgPjEfrKJid86RaxvvdfE9RV/0
 3Z7A4vFoqiSFHJrRX5ZzOAaGmPgZbeLoQw71M88huSVzuJnl9q5+98naMfdqTGK7BVqXqcKtpP5
 98BABPLVjyCKOB9Fu3gkEh+EQVMgolP9Wei+z0jkMVL/QPmMwBEmnzdvpqm1AK8Zcn5FXIJI15U
 GATrlKbz7TCW5wplTFRktCJKu5VHeCOOJz54zlsGU9B845JLyL+OhBDTCCKUgtkivtDADTQ==
X-Received: by 2002:a05:620a:628c:b0:92e:46e5:8f12 with SMTP id
 af79cd13be357-92e5f0cb023mr151359385a.30.1782742594066; 
 Mon, 29 Jun 2026 07:16:34 -0700 (PDT)
X-Received: by 2002:a05:620a:628c:b0:92e:46e5:8f12 with SMTP id
 af79cd13be357-92e5f0cb023mr151353985a.30.1782742593296; 
 Mon, 29 Jun 2026 07:16:33 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:32 -0700 (PDT)
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
Subject: [PATCH RESEND v5 17/25] drm/msm/dp: add link_ready to manage
 link-level operations
Date: Mon, 29 Jun 2026 22:14:38 +0800
Message-ID: <20260629-msm-dp-mst-v5-17-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=4047;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=RzJquXKOi3YyeF66FrBYDSkGWZjxoRxULVA0FumTtYk=;
 b=4lTkIB/+mfgRy3oKSPUd6U7GIl6THwmLYLseJgxvSFXaQ6qEwFwXGPJelyLthuOAbw2NhlUzh
 Vq9yiQD3kmKC2LhTAbmyfvT9B9QrlQCLCx7V/W8FnBM9R2PdExPJO1i
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a427e43 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=r0U9Mmpn2XdHegFmGjAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: DhQY_7dWn5LXK7O7bXfn7tW89pTxWMh4
X-Proofpoint-ORIG-GUID: DhQY_7dWn5LXK7O7bXfn7tW89pTxWMh4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX5heuOu2voL6Q
 gXoGqUfaaqUnWVF6QnaC9+k2mSMANOEcT7PFk5+Z4sFEPjN39xEZHsuCy9p9qiu82eIv4WOesxN
 cZ4A9sfvK8B6WkzhGBU04Sc9VEugv1uEv9wUULWfe7hsbACP4ipU8hsB+bnhBBMNeK9z6hlHBmD
 EfUgqN+jo3ElsMIvS/Ty1ykjhouNS7v4b7QNCU8BGjMSQ0zyQS/ZgnB1S4m/qfVQ0TrmkThVFJ7
 kRgI5W8xtzHf4vRgbJ9wOacBRNfJA33PopjRfnP4BGIeF5USUujCYmDNZ+iHfN7oLH5uXKx8xKk
 s8zG+Aj8k1xhP975xRCKCfh3Mw8flB0Er7rbtrccnxMq3JgR/WzH2Dl6n33tCH5aS2+EQkdr18l
 ybG6sL14nUQ+2Y+TRsaEIE6x2YxKxFoGgvMjL0EmMi7N+KFV5a/93ZQNeZhidghrGyct084nYb2
 rkVYQplkBw+L1tUw6yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX5yJHvEOUK2hY
 LeSG0N9qPP+WRZ/yggUSUyTjsCMrDWXMKIM9hnaKTi1sYztEOdZsUCGOThCV3ILBydIRcke7TiX
 6KZcPdb8YgnuwQI2/qu1Vu33WjjcqsY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
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

In MST mode, multiple streams share the same DP link. Track a link_ready
state so msm_dp_display_prepare_link() runs only once per link and
repeated calls are skipped.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 42 ++++++++++++++++++++++++-------------
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 2a74302bcb7c..d56ee10ee065 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -702,6 +702,9 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 	if (msm_dp_display->is_edp)
 		msm_dp_hpd_plug_handle(dp);
 
+	if (msm_dp_display->link_ready)
+		return 0;
+
 	rc = pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
 	if (rc) {
 		DRM_ERROR("failed to pm_runtime_resume\n");
@@ -714,14 +717,18 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 	if (!msm_dp_display->active_stream_cnt) {
 		msm_dp_display_host_phy_init(dp);
 		force_link_train = true;
+
+		rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
+		if (rc)
+			DRM_ERROR("Failed link training (rc=%d)\n", rc);
+		// TODO: schedule drm_connector_set_link_status_property()
 	}
 
-	rc = msm_dp_ctrl_on_link(dp->ctrl, dp->panel);
-	if (rc)
-		DRM_ERROR("Failed link training (rc=%d)\n", rc);
-	// TODO: schedule drm_connector_set_link_status_property()
+	rc = msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	if (!rc)
+		msm_dp_display->link_ready = true;
 
-	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
+	return rc;
 }
 
 static int msm_dp_display_enable(struct msm_dp_display_private *dp,
@@ -1566,16 +1573,16 @@ void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_p
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_display_set_stream_info(msm_dp_display, msm_dp_panel, 0, 0, 0);
-
-	rc = msm_dp_display_enable(dp, msm_dp_panel);
-	if (rc)
-		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+	if (msm_dp_display->link_ready) {
+		rc = msm_dp_display_enable(dp, msm_dp_panel);
+		if (rc)
+			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
-	rc = msm_dp_display_post_enable(msm_dp_display);
-	if (rc) {
-		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp, msm_dp_panel);
+		rc = msm_dp_display_post_enable(msm_dp_display);
+		if (rc) {
+			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
+			msm_dp_display_disable(dp, msm_dp_panel);
+		}
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1624,6 +1631,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
+	if (!msm_dp_display->link_ready) {
+		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
+		return;
+	}
+
 	if (msm_dp_display->active_stream_cnt) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
 		return;
@@ -1642,6 +1654,8 @@ void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+
+	msm_dp_display->link_ready = false;
 }
 
 void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 676213a48089..0464f8941e8d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -22,6 +22,7 @@ struct msm_dp {
 	bool mst_active;
 	unsigned int connector_type;
 	bool is_edp;
+	bool link_ready;
 
 	struct msm_dp_audio *msm_dp_audio;
 	bool psr_supported;

-- 
2.43.0

