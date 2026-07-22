Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 025ABC4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 499E710EC6F;
	Wed, 22 Jul 2026 06:37:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z600wpQr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dpw61WdD";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F16AB10EC83
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:18 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53vuP3663214
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /N2h2fNm8ptXyOm9YpJtPlGRvCQAMisqL9rrCQy59TI=; b=Z600wpQr42PqCRaK
 R5PYakpOn2H7heJPepSj2P1XrX767kHw2/APlfzlpvOT18ox6/s69pxbdDpgzEAM
 43u/ZWkSXGE4fWhD7u72sTMl+U3fB4l6ouwpX16SeA7NHA600QXSkK4Hbvvu96BS
 56MJr8Ot9izmBR4JA/O/Ms9MBhFyR1bdMhDcuRIoc5c/USs0e5cOw6VAzaLuAta7
 UIDVF5LQslOEkLwTnUwC+tjXXfnLO0EEsEebhG4gH2NNhLUimT/Z7LjZN5ffHa8W
 4KcwpD0EmgJEmBUfQqaAP4wNdXa7yGj1M7JnOR7KiuQ1zkXUMTpDCRRF0sGHD4Z1
 YHOA2A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2jqt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso247028271cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702237; x=1785307037;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/N2h2fNm8ptXyOm9YpJtPlGRvCQAMisqL9rrCQy59TI=;
 b=Dpw61WdDmU7BK/eFGRBt4Vfrmuyi2Ya2om/BsfHqoCNZI9GP+CzQgUXxcboye3Nc0J
 rx4W82ILPo4gQVWQ4KwpbJ+3g8opzuUUhdUSuhP9qV2iw0KvZqG1aKTb/1faUJNZtPfr
 cJ6+vEvgfwRIcP5YY83LVDIB9g9Y+0QDIsbjkhXWGMLIB4zECrsWdb8yTrcQ/uibVTEg
 +qSYOpBShhLGvmTrzbfdzPrmdgSbVRh4f11SBZvoS3OUw8AyjUzVTU0fkaq7Ge73HGZ0
 Aa6OSG8Y/nYfoKbhJt/MHz11FmAXEwdzW3kyLw0fN8zIwKy71Doq+Wwb/KOZ+xQULp3j
 tZQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702237; x=1785307037;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/N2h2fNm8ptXyOm9YpJtPlGRvCQAMisqL9rrCQy59TI=;
 b=l63XvsdYkwUIviBtZYB+amNJ8K3RGkZGlnYDNAi/vYChE8bzMd+5ne77kzo9ovryEW
 bUai7Hz9WdO5QKjGGMueuUhtqTVIUhuYkfsIZLwh79iH8AvvDT6MQ8Q2FrV2JPKJreqq
 dXXkjKRsxcuryBgapde2FYf8zLgIKZu4ibWFTiTwCWeSlpsuOgIwuTfTX6sbXqY863Wp
 ScAAAMG7nR2T8dRnbCzRwu3OBZwWbg4jqjDjOp0LHo2l6ZPnE+5mfrHF93BpW6QtBQn9
 Xuk0ndFRUQO2xwjwaN5l/E5gJQDzOVg7x4blCOKDJJNumazEeDrg6kIkk6YHOlZ2g4I/
 zvIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrE1NPo3wzfHkHdv+c7uM9QFGGmeeQGnrbifR4q6L5tJzHPsM1b82Gu3PzIMd4f2WqD9Q92+IkPs8c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSNuy5HSVuOWv6HeRetI+nLvEsIPb9tMns8jsAMcjEKMMGcy6A
 vcav2iZeqMlZZysd4tpW0sZVnLrrPfG727PRIprdN425X3ZY3XkB9dc4DCosMXemLE+o9HXBY7U
 kp4WXh9U1jxM1xJvvg2T5/RvQUF6t+EtRIFwl+RFzhEDNrcGlwLHsDm+Z3n3DUd6Tz5wD9V0=
X-Gm-Gg: AR+sD12mrb6WhS04nkE3154oWPINzBNogOqbVB5Wuiw5y793SyeCRlL19w7NvNhR76P
 VXDSWYHnl+aIyc1dzBajse49U8cbrsZagllRylxuyfWgWaRME1Clsg/jLZ8C7XKCZZ2o6tDhzAa
 4pxSKA+hTU8e9hf+GRWoTkmLwkau+ZQWxLSRwNupyBWIqcA0OcUCta92BDV9fg7jonCaxGwd2in
 tHudOdNIn6+vHSaKO5cw3Z0WK+4gQigWsr4pvy1i2HfzDb/rJw1QWbnUXUcnoK0wMCe9PvL7cAZ
 3Y6/IQ0lSYV50myBxGjZjqvXRNDCO1WuGr0afgBFfEt13JR4Cj5HjjUezM5//hNKUk2rDI7aHfW
 quym/dO2eBFpLszsfRhiMiMMUiuwABxF5aEB/Ke8CoNRHvXdziJ13Aqbp+oW/yRoVt1VDM6OlkY
 QDaAAjwZ/m2d3fMQ==
X-Received: by 2002:ac8:7fd5:0:b0:51c:7b13:62f3 with SMTP id
 d75a77b69052e-5213e67ff0bmr204841331cf.73.1784702237306; 
 Tue, 21 Jul 2026 23:37:17 -0700 (PDT)
X-Received: by 2002:ac8:7fd5:0:b0:51c:7b13:62f3 with SMTP id
 d75a77b69052e-5213e67ff0bmr204841141cf.73.1784702236771; 
 Tue, 21 Jul 2026 23:37:16 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:31 +0300
Subject: [PATCH 16/24] drm/msm/dp: remove cached drm_edid from panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-16-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9357;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=tau2awtWuAhs2tDJVOVXS8J6tZ80ehQO2Hh63gIguw0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGToa8nXbs1RicH6gBraYnP9JzFOBMrRiwAON
 Mqvh71MJ/6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6AAKCRCLPIo+Aiko
 1bb4B/9qpoCq1AiOg5pzEiaXhfFa6eogR32uUrVitujIIG3Ogd4BhYdJC6jzRnhJuOurjUbIDHd
 GqNOWwWsvDqUgluPij04jh3/uSGqZf1z8iHXwMFkDeurfScOH0fKGCNnwbG9k6x3YGn0MpbVvOI
 XcDuuG2FSJK4XGuhJwk+xyYWT2+TTHngLI+xq0OukFkdiw2QS8mFng0QQSI/gMVO7lChJD6ZucI
 XYaR+Og3idnNgE4i4Y4KGm3T9pOSI3B/1wj8N1tE8lklTvv4Vh8jV7VVrAoqIjO9e5pN4UZKvu/
 DRMnnajjYtmmFdUBxfPIXnZgNoomrht60t1FsNnemRjhEJ7p
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: iasKGFqfJOOX4ZQGGhySdf5eOeu1cKFT
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a60651e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=afWckrBw7P4RIPHO5CIA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: iasKGFqfJOOX4ZQGGhySdf5eOeu1cKFT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX5NaodDFNL1hY
 S5rvPpxtbB3NdQ3Hw7wfVrfJRn4z1Z88qhh1GJ/gWQ6WWgdwsWy+TOddgd86Ucv+oClpDnmQLdP
 bUcBJpfr1uyszbJe2VeorVONS/42BNkT82Do/dDdjpkUytw8mIJ06B7ympUHk+jU9HSdhM5taBT
 5rYjycALuGC82+VkklIA2esqdfdundYy/p9maLknk6cGirYsSYL7sJd1SByc3dd1FkThbdfdC15
 o/knoKdU3o39dhWDjdd8HjrBXlB2WKGC3YaJKm7EdZb90lD0pJaNxjFEdratw+2uLXFVW38Mfjq
 Bl/38qn5wCXvlldeorxTMClIXgKzS0dcb5hqdujO4qwvcaDJiXsQZJCObEj60q2YY3rkThJBvlc
 aYuPmoQfZ41B+6nS7cL6JihQN8GqDctnxscUaN0sKZ3+xFhUDihO3MRDeiAWkLLU2PQeXD5MpfW
 0ya5xZgKgH5b+qiOqjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXy+enACHfYNxD
 VB2nUGcr8GYHdB+vcgwgWXz+dJA1qAQtvXN4rUGzZPSwrUfw1Nn27O+P0I4bpUrwo2NTI0lXMMR
 GvEXCtpw91MJFlK/yWcKe7/1axGHyog=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220060
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

From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

The cached drm_edid seems unnecessary here. Use the drm_edid pointer
directly in the plug stage instead of caching it. Remove the cached
drm_edid and the corresponding oneliner to simplify the code.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++-------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 59 ++++---------------------------------
 drivers/gpu/drm/msm/dp/dp_panel.h   | 13 +++-----
 3 files changed, 27 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bd1354f2c15d..cd4923d1a17e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -272,6 +272,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	const struct drm_display_info *info = &connector->display_info;
 	int rc = 0;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	const struct drm_edid *drm_edid = NULL;
 
 	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
 	if (rc)
@@ -279,10 +280,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 
 	dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
 
-	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
+	rc = msm_dp_panel_read_link_caps(dp->panel, connector);
 	if (rc)
 		goto end;
 
+	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
+	drm_edid_connector_update(connector, drm_edid);
+
+	if (!drm_edid) {
+		DRM_ERROR("panel edid read failed\n");
+		/* check edid read fail is due to unplug */
+		if (!msm_dp_aux_is_link_connected(dp->aux))
+			return -ETIMEDOUT;
+	}
+
 	msm_dp_link_process_request(dp->link);
 
 	if (!dp->msm_dp_display.is_edp)
@@ -294,7 +305,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	dp->msm_dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
 
 	dp->audio_supported = info->has_audio;
-	msm_dp_panel_handle_sink_request(dp->panel);
+	msm_dp_panel_handle_sink_request(dp->panel, drm_edid);
 
 	/*
 	 * set sink to normal operation mode -- D0
@@ -305,6 +316,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:
+	drm_edid_free(drm_edid);
 	return rc;
 }
 
@@ -456,7 +468,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 
 	/* Don't forget modes for eDP */
 	if (!dp->msm_dp_display.is_edp)
-		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
+		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);
 
 	/* triggered by irq_hdp with sink_count = 0 */
 	if (dp->link->sink_count == 0)
@@ -518,7 +530,6 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
-	msm_dp_panel_put(dp->panel);
 	msm_dp_aux_put(dp->aux);
 }
 
@@ -569,7 +580,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		rc = PTR_ERR(dp->ctrl);
 		DRM_ERROR("failed to initialize ctrl, rc = %d\n", rc);
 		dp->ctrl = NULL;
-		goto error_ctrl;
+		goto error_link;
 	}
 
 	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->link_base);
@@ -577,13 +588,11 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		rc = PTR_ERR(dp->audio);
 		pr_err("failed to initialize audio, rc = %d\n", rc);
 		dp->audio = NULL;
-		goto error_ctrl;
+		goto error_link;
 	}
 
 	return rc;
 
-error_ctrl:
-	msm_dp_panel_put(dp->panel);
 error_link:
 	msm_dp_aux_put(dp->aux);
 error:
@@ -755,8 +764,7 @@ int msm_dp_display_get_modes(struct msm_dp *dp)
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	return msm_dp_panel_get_modes(msm_dp_display->panel,
-		dp->connector);
+	return drm_edid_connector_add_modes(msm_dp_display->panel->connector);
 }
 
 bool msm_dp_display_check_video_test(struct msm_dp *dp)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 5b4954e7cb74..bde4a772d22c 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -232,8 +232,8 @@ static u32 msm_dp_panel_get_supported_bpp(struct msm_dp_panel *msm_dp_panel,
 	return min_supported_bpp;
 }
 
-int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
-	struct drm_connector *connector)
+int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
+				struct drm_connector *connector)
 {
 	int rc, bw_code;
 	int count;
@@ -271,36 +271,9 @@ int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
 
 	rc = drm_dp_read_downstream_info(panel->aux, msm_dp_panel->dpcd,
 					 msm_dp_panel->downstream_ports);
-	if (rc)
-		return rc;
-
-	drm_edid_free(msm_dp_panel->drm_edid);
-
-	msm_dp_panel->drm_edid = drm_edid_read_ddc(connector, &panel->aux->ddc);
-
-	drm_edid_connector_update(connector, msm_dp_panel->drm_edid);
-
-	if (!msm_dp_panel->drm_edid) {
-		DRM_ERROR("panel edid read failed\n");
-		/* check edid read fail is due to unplug */
-		if (!msm_dp_aux_is_link_connected(panel->aux)) {
-			rc = -ETIMEDOUT;
-			goto end;
-		}
-	}
-
-end:
 	return rc;
 }
 
-void msm_dp_panel_unplugged(struct msm_dp_panel *msm_dp_panel,
-			    struct drm_connector *connector)
-{
-	drm_edid_connector_update(connector, NULL);
-	drm_edid_free(msm_dp_panel->drm_edid);
-	msm_dp_panel->drm_edid = NULL;
-}
-
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
 		u32 mode_edid_bpp, u32 mode_pclk_khz)
 {
@@ -324,22 +297,6 @@ u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
 	return bpp;
 }
 
-int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
-	struct drm_connector *connector)
-{
-	if (!msm_dp_panel) {
-		DRM_ERROR("invalid input\n");
-		return -EINVAL;
-	}
-
-	if (msm_dp_panel->drm_edid) {
-		drm_edid_connector_update(connector, msm_dp_panel->drm_edid);
-		return drm_edid_connector_add_modes(connector);
-	}
-
-	return 0;
-}
-
 static u8 msm_dp_panel_get_edid_checksum(const struct edid *edid)
 {
 	edid += edid->extensions;
@@ -347,7 +304,8 @@ static u8 msm_dp_panel_get_edid_checksum(const struct edid *edid)
 	return edid->checksum;
 }
 
-void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel)
+void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel,
+				      const struct drm_edid *drm_edid)
 {
 	struct msm_dp_panel_private *panel;
 
@@ -360,7 +318,7 @@ void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel)
 
 	if (panel->link->sink_request & DP_TEST_LINK_EDID_READ) {
 		/* FIXME: get rid of drm_edid_raw() */
-		const struct edid *edid = drm_edid_raw(msm_dp_panel->drm_edid);
+		const struct edid *edid = drm_edid_raw(drm_edid);
 		u8 checksum;
 
 		if (edid)
@@ -757,10 +715,3 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
 	return msm_dp_panel;
 }
 
-void msm_dp_panel_put(struct msm_dp_panel *msm_dp_panel)
-{
-	if (!msm_dp_panel)
-		return;
-
-	drm_edid_free(msm_dp_panel->drm_edid);
-}
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 9173e90a5053..53b7b4463551 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -33,7 +33,6 @@ struct msm_dp_panel {
 	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
 
 	struct msm_dp_link_info link_info;
-	const struct drm_edid *drm_edid;
 	struct drm_connector *connector;
 	struct msm_dp_display_mode msm_dp_mode;
 	struct msm_dp_panel_psr psr_cap;
@@ -47,15 +46,12 @@ struct msm_dp_panel {
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_deinit(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en);
-int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
-		struct drm_connector *connector);
-void msm_dp_panel_unplugged(struct msm_dp_panel *msm_dp_panel,
-			    struct drm_connector *connector);
+int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
+				struct drm_connector *connector);
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel, u32 mode_max_bpp,
 			u32 mode_pclk_khz);
-int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
-		struct drm_connector *connector);
-void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel);
+void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel,
+				      const struct drm_edid *drm_edid);
 void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable);
 
 void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
@@ -94,5 +90,4 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
 			      void __iomem *p0_base);
-void msm_dp_panel_put(struct msm_dp_panel *msm_dp_panel);
 #endif /* _DP_PANEL_H_ */

-- 
2.47.3

