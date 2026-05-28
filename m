Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238BACD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8284910EFF0;
	Thu, 28 May 2026 10:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DGfo0np6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QPU8DdDR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4483F10EFF1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:31 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vS1f4184444
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bmW5IAsVo0Q40l7XHu8+8e2aqWRn+l01qYhv/DjWm/w=; b=DGfo0np6G1mSreoa
 zYZbrd3lp6K5155byMekgKn9m3i5jX8tPns20xAfmlq05q+OVEm4P2J6C+6yUJgE
 EiG80IGQxz7sb+DNsL0DlZl2I3mSeBLU3xV8BFOx66fKDr0unZkShQD/Y+juBtan
 0/Btx+cIH/Xz6kYFT2F7LWMTMC0c3SUttGXJkZiBroHPOM+azf/s7Z9vuZQuz2iA
 /Xes247HaRn8/39tdtRuM1B+lEWoijiPJb1sNxP9DB/LcYM6CUzvKFEMuxR/gzEh
 eV3pNa6uMghT/xba496hikDVDWmyDBibJQv3xdriB3ISiCHJFz1mzpe1GgsZNEsF
 HzHC1w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yf2e2q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:30 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-90ffa709073so2605764685a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964890; x=1780569690;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bmW5IAsVo0Q40l7XHu8+8e2aqWRn+l01qYhv/DjWm/w=;
 b=QPU8DdDRzYXX9+SpsD3xc8f20xNiGYNPZA51YokSYScKHtc+G71pMCBZnKeYa3At4y
 1HmkRCUdwaQBtMfptCw9z49F7Pjjf/MD5ar3hFlEM7+6bb1vxa0brMhegcuPHbc6JBwx
 9oKXpLEgWdJ42iH8FFl1Iyb5vWeDrDrffqnx5jOReoddEjO4JghwOb7u/DASKe8u5AqD
 wZBWw02OdLx6DX4o8vYgIDNvBUjnIe/nRrmpMAGb1hbPC8PC6HQW4AQyiPHZU56qOj92
 1ydPSaKV57kePASAtFW3ETJtLzbOpyaYlh8NorgcHg4v29bDwLkWlVqbryX2MmZHTFsh
 WBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964890; x=1780569690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bmW5IAsVo0Q40l7XHu8+8e2aqWRn+l01qYhv/DjWm/w=;
 b=fooq5aoJZmZjVswFVt+7R0ojp1yfgr31Utj6nMAGkvBYNapwcxAYpwkv0Iqf5egOdQ
 Ng1q4qFdp37FX5iqFV+Vf/oMrbaTX5eurqB4yyEtswyjb3Chh7G8bsz9pWj+AQ4w6Xni
 ph1KdljkWKskuEkQJNUCy4Oyb06e48AhmHtCghKl4cCQylw1jaa2/p07TBtMWhpaNvyr
 jj/bukc3ZwNxcKTUEr5XaJrxxSHdCiBVl836MyI8GE2xBT4aSA0SH3fle5FN/GLGMviJ
 2uuCiwLiIGs1B3UUoPvOmDH1pGBxJGSOj+3fNS6WUSQjPIZLKjUh+qR+gdxjhNDrDAzB
 F7iQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ92g11aD23sHHreSGQWy5LAwE82aIux84dcp7HcgpsKJrQy5wqhU/7oQfSseEDePW4/wCy2S2g3qbE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBsuyuBEic5AEVrsU9H2LM0jJ6EHBljMqsGflAcfAHa1VjgwQH
 AU9pW0Gn+BvPo31E0ia78FpiUx0VOvhQ9ji1J4i4ylug99s3Vi/8lnztuz5DZfzKJvKFzQ2wcsl
 w0A18E9Cwacjti/Ws+2ZgMENxxYBBUJ6zIBUi8LRZiKfX7AHGVBbmytbnInwFIND6XVbFrSA9YE
 0S8ijLCQ==
X-Gm-Gg: Acq92OEzhvUXuqvlYsTHf/tATpHPKbhhqEQf9+9sJ/Ei9cS8w8VYB5IvXrWlXXZgvia
 JB1IJtd9ItZeBDjlH+46Vn3gzdq90WynP/LkaWmEbNr+3YlIpQR+si2PX/AMSf7XtQm3fMrLm4V
 skhbpz0BGLtzgFFfESXja+lfzWzu/V9H7dS3E/BDiDTm5KBwstGeKamCJbcEwOtvrKady3oO7pV
 vK4ZS09OfSgbVWbScriGluHans4LbIf6PdjTetT5j6Ila5E7UamLROVrlRUEmJ8RYH9ymZFQUBO
 A5BLy0SUl/5kuCJEa3Wkx2wUiAUmyRRjuV2DD29LJMZRJEQeyeNTSdc66jqOQrpULzoeulSb7z9
 Vfcx485cOLMlSUh9VKMCYIW5f4ANNz6oOK5OtKf4cCEFfEdhFctziGuYt/scjSLoGBg1UiyDeB+
 hfnxnpvCKavW7GYcEOjw==
X-Received: by 2002:a05:620a:d93:b0:90d:6234:caa2 with SMTP id
 af79cd13be357-914b49ba1f8mr3810964185a.40.1779964889858; 
 Thu, 28 May 2026 03:41:29 -0700 (PDT)
X-Received: by 2002:a05:620a:d93:b0:90d:6234:caa2 with SMTP id
 af79cd13be357-914b49ba1f8mr3810960985a.40.1779964889301; 
 Thu, 28 May 2026 03:41:29 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.41.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:41:29 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:32 +0800
Subject: [PATCH v5 11/15] drm/msm/dp: split dp_ctrl_off() into stream and
 link parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-11-a9221c1f1f3b@oss.qualcomm.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
In-Reply-To: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=3896;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=vWRaeaHEINP+1viyGh71nSeufwciiMtgzzvwLnLdxKY=;
 b=gyhRfjc06bG29IAATYKBIv8SueLwWVsgEECnmKEbHZ96rKKa8jxFVwZOazQkUCaxKwq8vct3G
 i/zqGXFtvJEC9D3O30CuvA2hJgs+btaySIHnIc0jFs4J9RBV2R0p3Fk
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: zIsrbt1Za8OTdxnPPiHbMikvURSrYRYE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwOCBTYWx0ZWRfX08aK+gHIMWCt
 +0pAv/9Tip31lb3wXthVKuX9VCJhYnGuVhtFmU78yz0yLYYPS+7kTgwM/FVnCuE4TGTYJdegA9v
 0PmE5biWKRg33CWqUu4HENtIWmwd3Lu2h1QvNQjkwrgJjhIdkIOrKC05y2Oahpy3Xcgyv9dI4vs
 lDFYL7ATEtbVqunKmb2iHRWzibVfCvJzPmVSurN8xkOylPOw2Ld22h5BRuqvI1XmVGaS5TVg4WH
 rQoDsTWW2ZnP9iIFCSdX98QTfPIkiy+EJmZiwMqVs21lgD0tsH+s0650AG5MlFvtAKkjKU1qr2/
 WelogX9hAEAHtWdsZ9AWnIMf3uyU1xHrkUhYbWDV64mcMjeUvvaa623Xt5Yg7y8pxbePzxiymtX
 sqd1aDfd2jc7SZq8UpqTfkXU4R2SY5SkFHWVYzg+sbAGSW8UALf1GYIJbOwwQwHI0wfjpfLbwA0
 5i7meFt8mMXM3WJ6rFQ==
X-Proofpoint-ORIG-GUID: zIsrbt1Za8OTdxnPPiHbMikvURSrYRYE
X-Authority-Analysis: v=2.4 cv=G8gs1dk5 c=1 sm=1 tr=0 ts=6a181bda cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=2kxiPxfbkJi5fZIrDGYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280108
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

Split dp_ctrl_off() into stream and link parts so that for MST
cases we can control the link and pixel parts separately.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 10 +++++-----
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  5 +++--
 drivers/gpu/drm/msm/dp/dp_display.c |  7 ++++---
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 88b6f4b8a598..6e78dd62fc1a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2213,7 +2213,7 @@ static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned l
 	return ret;
 }
 
-static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
 {
 	struct msm_dp_ctrl_private *ctrl;
 
@@ -2242,7 +2242,8 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	 * running. Add the global reset just before disabling the
 	 * link clocks and core clocks.
 	 */
-	msm_dp_ctrl_off(&ctrl->msm_dp_ctrl, panel);
+	msm_dp_ctrl_off_pixel_clk(&ctrl->msm_dp_ctrl);
+	msm_dp_ctrl_off_link(&ctrl->msm_dp_ctrl, panel);
 
 	ret = msm_dp_ctrl_on_link(&ctrl->msm_dp_ctrl, panel);
 	if (ret) {
@@ -2636,8 +2637,8 @@ void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl)
 	phy_init(phy);
 }
 
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel)
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel)
 {
 	struct msm_dp_ctrl_private *ctrl;
 	struct phy *phy;
@@ -2651,7 +2652,6 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl, panel);
 
-	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index 00b430392a52..5902cf7e746a 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -22,8 +22,9 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 int msm_dp_ctrl_prepare_stream_on(struct msm_dp_ctrl *msm_dp_ctrl,
 				  struct msm_dp_panel *panel,
 				  bool force_link_train);
-void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl,
-		     struct msm_dp_panel *panel);
+void msm_dp_ctrl_off_link(struct msm_dp_ctrl *msm_dp_ctrl,
+			  struct msm_dp_panel *panel);
+void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl);
 irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm_dp_ctrl,
 			    struct msm_dp_panel *panel);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 230e14615a23..8f472633da82 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -725,15 +725,16 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 		/* set dongle to D3 (power off) mode */
 		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
-		msm_dp_ctrl_off(dp->ctrl, dp->panel);
-		/* re-init the PHY so that we can listen to Dongle disconnect */
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 		msm_dp_ctrl_reinit_phy(dp->ctrl);
 	} else {
 		/*
 		 * unplugged interrupt
 		 * dongle unplugged out of DUT
 		 */
-		msm_dp_ctrl_off(dp->ctrl, dp->panel);
+		msm_dp_ctrl_off_pixel_clk(dp->ctrl);
+		msm_dp_ctrl_off_link(dp->ctrl, dp->panel);
 		msm_dp_display_host_phy_exit(dp);
 	}
 

-- 
2.43.0

