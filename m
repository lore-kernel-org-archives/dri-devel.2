Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F35C4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:12:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8292C10E69F;
	Mon, 20 Jul 2026 06:12:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AcE2U1Yl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jXh3aeBO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5925B10E69F
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:12:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNsAr7644493
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s8YKg6IaKC7m0qneFSX4THum9YhnLsBA1sZ5MrH5/YI=; b=AcE2U1Yl6RWq5HE+
 OA3auvOJAR12m2YxiGcGzeHD7HZh4oeUTPJ8cXHS0bVNuAdNqWm6VVwUrlR5DOrX
 kJsISXg+VrpySxShB1exTvk/zG9yD1HsjAWU4abFu3avN7L7nYyV2+V/rPY7coA4
 zaqSGv4H0ztrsYDSRdwVy6F25zH2iRgflEGzK2bnAt4wUUaKnDr34PaIvcF9YdXo
 rGfqcHppUt0HSwYv6mvrjFSzKzu2ldfzPg+nzJMLt+h2Tgd1GP17OXsfozq82SoZ
 nQwd3tzsVMNv2UwoUbGzq6+vJkCj8hWbe4FqaLPggKsFGipxdWSj/4yEsGY0EbQ3
 2L/Gkw==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvvn61-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:12:00 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f1e4e0eac1so166071236d6.1
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527920; x=1785132720;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s8YKg6IaKC7m0qneFSX4THum9YhnLsBA1sZ5MrH5/YI=;
 b=jXh3aeBOlbipE5LHgUYQoWra07xX0unqFqV80Ft0aX5DTyIjDEmhlLkFupsJlDPeD4
 GQi5BL4LgIzqQwjmnCcZPuzoKbw0r/eh5NVengckSTaxKbamV0L6nartKMlkh60h9I0J
 bgkvAzQZayVJYS4mXjc9b23NC/JZ/DFrsLMvPqSw7ZPq3PLuQdFsqV2yexUHgiZIyueB
 e1Q83Sovzbb9Joegr/OSV4EtGz8aNKfM/bMuRt2S26EnWmVEnfJr4kqTjKsj/pdepVQh
 +P6MGP1rgtxyyS9Q0+wWylFlz8y1R+oJLokrGq7js62ygKUIoCEAd8OTA7vLS7vkenBt
 wzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527920; x=1785132720;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s8YKg6IaKC7m0qneFSX4THum9YhnLsBA1sZ5MrH5/YI=;
 b=o8jIzSzRT2dPlpZ7Gt2NEkioE3I4+WQLD6d87uxUHRHmI33ar8NLaQxNl1Oy0+kBvz
 /5FAzq07fXq5YCGDQirESX89v3qpjtAeLgAMHhQ5d4Jwz7PgFHn4J0dphxLzSM/1cSvT
 9qOySbqw7FQueE2SDKqJv6T9zhsgd8YR9PcABSFeIuEXjUmdCnMR/uOnL7dtfUV4EIdT
 n43myjUAQ6wdENLzT1BBzeYsvwn2Adky4gWJa+QqSY0gDG7nUMyRUPftv/xGy9VRV5D0
 5CykSRxwno0KbWs4DMUXPO0h+C1JKcliFfiWWU1XTf27cgwJ0GM4jGL+SvCuGRlu9iWF
 XlSA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2UAGm2QGEjjnQV/W444pQli8gdfVVtT6f9bUD3a1+C/pR8CqG4LM+F2dGdvWaJKPeSLj3Lo/0Wm8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySMah6+jyDfW7Ir/hF3PLrF6HvQJnwHW+QdjAZoNTXccop1+cL
 tgyzkh2l4henon/YJdqdRtor5CM5hm/yDkZ/wOQ1tl5tqm3+cnNyREsOnh/M1PNlQAjqWq2b7on
 ZMyy+pwJEbj1gLlLPGeb71DZxjSzblrhmUOVaffjZ4zem/wAtmBl++Mz/RXabtntGJy7aV7I=
X-Gm-Gg: AfdE7ckOiUz2qMsx8FVq7o2xJENTELrCvkMzwzWmrMIG+CDTb/YfgFzBqlxi/8f3lm2
 GGNllkkhtPwXBPUDRKF2lpsTZhmu7QDoksh4Dy0Ry1hvFeSFo3qDMaJoL1BcouVqjdE37JTPZ/K
 MKIV7D+pRoM4Mv2RxGE39mcDS6enh30Oxj7EYlOzuTVsF3IN8C5JN6jwBRideRNfwS/YRdo48mK
 +4na4Z1yXFOYatsZ2Q/ZmO7dULhbm16VGkR59ZXIbjgd+53cyDNnGJ/tMnT7x1SvhWSHSCL7lAo
 mM5lqOdJ0h6RUEhEzyMkjchhITTfgSnt2VHrt6XTbE4FpLLItU0v+8ANh2Uk7RoNpHBJWgKY1EU
 xKCQdspnI36EuVKETM1SJ7zFM4/FjwdOKbhImupmKh/AGcrr6OQov81ZsCYXcyUQ=
X-Received: by 2002:a05:6214:c87:b0:8ee:efa3:4466 with SMTP id
 6a1803df08f44-907783761bamr126610616d6.28.1784527919817; 
 Sun, 19 Jul 2026 23:11:59 -0700 (PDT)
X-Received: by 2002:a05:6214:c87:b0:8ee:efa3:4466 with SMTP id
 6a1803df08f44-907783761bamr126610376d6.28.1784527919447; 
 Sun, 19 Jul 2026 23:11:59 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:59 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:22 +0800
Subject: [PATCH v8 15/15] drm/msm/dp: pass panel to display enable/disable
 helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-15-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=3650;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=5rx35bWSep3xN4RUyD5mNpeVVVjnUrXou8AE1KSwoCE=;
 b=9efT/qG81EEi+uKNli7LulrsXg3ziNpwjh3xhB+lKuMhE88HpsM9E2ogd6lKku6bcEOAuDMmN
 JoGJ0qHa069B9hoplrk7MPRQCRJ27x7b94BUElUR1otrMC4OpZZKFm/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: TkKn_9jWIkho0wZWJlejR62apTFuykxP
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5dbc30 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=7Bdkmk_NF71dONvui9QA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfXx9kEdVNESIL1
 2wyZz9++ORiIcgyOgnp1BCRq1V2RqPRMzgLvven9GHOD18nWfY9CCa5Ir4ghH0Ca5wULbROvTVM
 YNirfWhIYX3TFz6oiPzuSuMr/nmSELftLEHsSsp3F6+2LQjgdMh817dnNCDJHCleIZXwciV9+/p
 1wE7gPwVD69X2q6Ze/sHuKIhMLk4vBuuxhgBbcU84QBaKL2byS3yiCSpgZIZkDvrIOkl2SIWoTI
 hhtebZkYaQiHvOGjU/5kyczS0GcknrdQb/6lsMIfhYJiTORfUyE88W+JuRshZJLSkSnbINW99JX
 GftYLaJ7CXwmGOKJpd5RQ/QQhYp7q7MSD1simEeRLVjm3tLxSRBlgVQgtOBT7hd9N3FrkpqmYjo
 m+KYEo1eKIVF2yUQhe8If7b9EY/y91QGXy16a7AT081Y58Bsq43vgotYU7mC5u662fSeKljmAB0
 JsxKXb6KyYVfkPq0XJw==
X-Proofpoint-ORIG-GUID: TkKn_9jWIkho0wZWJlejR62apTFuykxP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX8w8MrGR3JSmX
 ZuBnh4SiEfjMx3rjjQCrrJg0oOrd0DgOHRNCV/gKh+0eQn1AAmPMVgqnZjydblEAdwdXCWN0/U4
 P/G+bSHRo+SIvZ8LFAvehA2lTvZYZco=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200067
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

Pass struct msm_dp_panel to the display enable/disable helpers to make
them easier to reuse for MST stream handling.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 74d885e38b8c..c31d155715a1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -652,7 +652,8 @@ static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
 	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_train);
 }
 
-static int msm_dp_display_enable(struct msm_dp_display_private *dp)
+static int msm_dp_display_enable(struct msm_dp_display_private *dp,
+				 struct msm_dp_panel *msm_dp_panel)
 {
 	int rc = 0;
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
@@ -663,7 +664,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp)
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -709,22 +710,23 @@ static void msm_dp_display_audio_notify_disable(struct msm_dp_display_private *d
 	msm_dp_display->audio_enabled = false;
 }
 
-static int msm_dp_display_disable(struct msm_dp_display_private *dp)
+static int msm_dp_display_disable(struct msm_dp_display_private *dp,
+				  struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
 
 	if (!msm_dp_display->power_on)
 		return 0;
 
-	msm_dp_panel_disable_vsc_sdp(dp->panel);
+	msm_dp_panel_disable_vsc_sdp(msm_dp_panel);
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl);
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
 
-	msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
+	msm_dp_ctrl_off_link(dp->ctrl, msm_dp_panel);
 
 	if (dp->link->sink_count == 0)
 		/* re-init the PHY so that we can listen to Dongle disconnect */
@@ -739,7 +741,7 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 }
 
 /**
- * msm_dp_bridge_mode_valid - callback to determine if specified mode is valid
+ * msm_dp_display_mode_valid - callback to determine if specified mode is valid
  * @dp: Pointer to dp display structure
  * @info: display info
  * @mode: Pointer to drm mode structure
@@ -1439,14 +1441,14 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_enable(dp);
+	rc = msm_dp_display_enable(dp, dp->panel);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp);
+		msm_dp_display_disable(dp, dp->panel);
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
@@ -1481,7 +1483,7 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display);
+	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }

-- 
2.43.0

