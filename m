Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1864BCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B9CA10EFE1;
	Thu, 28 May 2026 10:41:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fkl7es++";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GOhH7DJR";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A352910EFE5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:56 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vUNL3203255
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Gr2EDNFY0bB/CkE5VFTvCv3redMXxtxC722xjDFOpI=; b=fkl7es++ceLPClkI
 kuIGujljJ5DgQ0jRRS1KCHlZcCksXYce8u9nSPrnuKEOsXtD7zCTxEkLn0wWJo+s
 dgC/mZ8Gh3HtZxXno8Scj8T6Tcv1afih7bNzEvF2uRDEldYZfMdtFTvstMQEO0j/
 G5SsHeJLcmB3o2TkCa/bHfbTxYie6HRM1cUwLD02uxdJO2zgAL9D3qtaDm+j2L2E
 nJRElhWD0HVhyjIjAuSaoe74kKWcj475qr7Hr4MwA548zh7Qo8gtmZLoBZDMXdkV
 1wrZ2s6TYhjwv57Tza1jXA7Dy/KIts6mIxiYEEJ5KcV8Jz2uYWhcesFlhCQ0cmtK
 oEIxMw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynje38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:56 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-914ac72db7cso130779785a.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964855; x=1780569655;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Gr2EDNFY0bB/CkE5VFTvCv3redMXxtxC722xjDFOpI=;
 b=GOhH7DJR8u7iQeYQYqT9IDNlmxH5+Z3gqjxDlttaQB8JpsOY0ubQ+n53eHThWFEAfL
 RUR3+8BzpR9P2jdVRghTSTigXoKOsv49B4Zg1/pzpaJDdg98Tbt9ZDJgUE7ftBXO5nq/
 rr+NwITfAcNyZoDzLltw+mgng7OgKSFdmuKF7Cm8xu9dKtJekoDJ0uWjAUR2IcXlI528
 9Jwlp5btp6Fql/Dh8gUdOSiWP+ZwEpiUqeU/hTHpYVrfWsSvz8TFo5LHqUIQMVfOfeQH
 UqrwSO/o4OlX5iQBY0jPEe8/h+3OUBQwpTh2Xi1V4fN7X5mebTicth5piArisnwtGxLW
 KZcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964855; x=1780569655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3Gr2EDNFY0bB/CkE5VFTvCv3redMXxtxC722xjDFOpI=;
 b=NylgsN3eQqDHmwYpnI5sQDFL5pFTbrUI5dChFUMfdb1FGJ9ofPNvdjT4q7uiTr4OtJ
 s8qoW9gkNUZij4sRJV5WnGwABVqZMAv+rZjt55mzH+0bqkzI3swkBhpaDs4k0OEWyNU+
 GBkeBCiWg3qCF+RmrA31HvuVHgv1M8MjWszOPWD63irm2ARuQJWx7BhkErDpiXzqPy/D
 lzlzasgKFip/QyDp8B+rnovDs9w1A//+zI4cE9UUVa9Df5nvfAs7EHoE6tQFgSSM5VNM
 N78eLGTLI2ZQs1xLhjHzcp1bFb0j1P+8Pk/UrsXptcBqdAe4emENCAa7yYlIxLHNsNQd
 lN7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+HSzghizBxmzdiM7ZiyO2rDCo1RZvNoAhyRf9fM7Nbkgzu/0EV2WClwzMX3fyMqRzSTpL7/GLhtmk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRJfghT5TeSmzuyEoF8/fQ0xO1ghFOAT7a3H2I5yesBRqGwDeu
 sgUeQXN3vIx/5g9Ol1xcqsWlhHVPAbisj/QcPG2LUCgIkP0OSj6yQ61ukd1mnQgtCp6a1SbV4GE
 xC2YMcUHsowt5alBF2YXKbEfBJ6cOWNuiQGCHRPO+2QaHKsuVPHM5Ztfmn/DrH8c/OIR4DoCU9N
 sOWCWjmQ==
X-Gm-Gg: Acq92OEMxJnfSuJDexbvBAhO3xrgcbqLT6qReQAjB74RMyyEuvx2n7e7Bz22u6q7qno
 2AUFSZkCn3u/GnWf5VnaIDpO6eeQ6HEja+Nss1n2IkPEyaZoKEQmrUaAqFHm7KTpTYPVniPP26F
 5Yz5Ykn0iXOWreC+r5jnTAXIPxm42/hKwMlpk7DCbDb5ispYfrvqpeJqAspMCi9EexGUSmS1j+Z
 b79tb4JsRmcDKmI3mtNBlXW12KN2ugpkZhXVp+pNq07IKbWUhPYyeeRWJVYfZecIyUQv/nKEV6F
 x2SqauWnPj0B4Z/EzbcTp76xaa6JM3gInf6X9VtpQl4+W1ekH7Usde56hbBZDKt1kfLmsdZL+Ge
 atSuyEodQrd2fa2xJdMcpyGPFacthtQCnaVQDZU/u0NDzJmr84ykYEtx3OuI3O1SOGC3wqP1sGo
 6Z5O7wYU5ajRM18z8cMg==
X-Received: by 2002:a05:620a:2b45:b0:910:3078:5cf6 with SMTP id
 af79cd13be357-914b497bdfdmr3946451085a.44.1779964855173; 
 Thu, 28 May 2026 03:40:55 -0700 (PDT)
X-Received: by 2002:a05:620a:2b45:b0:910:3078:5cf6 with SMTP id
 af79cd13be357-914b497bdfdmr3946448985a.44.1779964854789; 
 Thu, 28 May 2026 03:40:54 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:40:54 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:25 +0800
Subject: [PATCH v5 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-4-a9221c1f1f3b@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=3827;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=VluQ+GSUC9CfNFLNLvLHc58jEW6kFKOO2mES+jvgQeg=;
 b=psov3Sj3O7eYFrJBIUaTQxDLdd/VTAk5+SUcq8dNSTo6AIN9r86zWmEEgcrnxXRhrXWkLCVBQ
 lPET6FJ7PCRDK4E5sPuK4gWzA9PZNsaocJZ+Stf+rZNCag/61aohQuH
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwNiBTYWx0ZWRfX9PuDypNOaH17
 h411ZOpi5zZ6AVwGPTq0QhQv7mQWVq4o/nY+U6IxvTysD0dJtoD6y0wCzIkND8867WOUvMdmVSE
 KYKDaY/afqikhkMOCnxxJIeBruviKs2qDz1pBCAJVRrdthxzSMl+GgrBogFSxNnzq+FB6LbbHCI
 sXH+sY8w4AmSURDXzSC56IZWv2f1XCwRVpRot/z2Da4JMXWIaUmrRyFS9ER4JrwxH589uIQ7nEV
 5Zv7kffDYpMWcI9OByZ/3tFWHOyw1PA49C9gqiioH2RHTT+CfflspzGS7Zkc5yA6XkqUMwvGiqd
 lFy549noL8AVCy2fvEZ07PfFZylSL6tUDwz5KoxljRT4FqVfmS/yutCMCh9Acj0sHjrHEtPv3S6
 jva8IJeQyLA7fLUJa89rargTiG8594sAfTQdzKXhvEfyTqK6KqeyN09hsmsCU/wVtLdoaiRw3LD
 VaiFllb3p4fg7S8OdIA==
X-Proofpoint-ORIG-GUID: mMvqur2ledBldTPa8bYpmqFIMxo9OPsP
X-Proofpoint-GUID: mMvqur2ledBldTPa8bYpmqFIMxo9OPsP
X-Authority-Analysis: v=2.4 cv=EdL4hvmC c=1 sm=1 tr=0 ts=6a181bb8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=N4WGanfLxQUAwF0MUGsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280106
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

The DP_CONFIGURATION_CTRL register contains both link-level and
stream-specific fields. Currently, msm_dp_ctrl_config_ctrl() configures
all of them together. Separate the configuration into link parts and
stream parts to support MST.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 47 +++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 86ef8c89ad44..cc00e8d2d6c7 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -388,26 +388,45 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
 }
 
-static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
+					    struct msm_dp_panel *msm_dp_panel)
 {
 	u32 config = 0, tbd;
+
+	/*
+	 * RMW: in SST, config_ctrl_link and config_ctrl_streams are called
+	 * sequentially on the same thread. In MST, caller holds mst_lock.
+	 */
+	config = msm_dp_read_link(ctrl, REG_DP_CONFIGURATION_CTRL);
+
+	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
+		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
+
+	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
+					      msm_dp_panel->msm_dp_mode.bpp);
+
+	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
+
+	if (msm_dp_panel->psr_cap.version)
+		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
+
+	drm_dbg_dp(ctrl->drm_dev, "stream DP_CONFIGURATION_CTRL=0x%x\n", config);
+
+	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
+}
+
+static void msm_dp_ctrl_config_ctrl_link(struct msm_dp_ctrl_private *ctrl)
+{
+	u32 config = 0;
 	const u8 *dpcd = ctrl->panel->dpcd;
 
 	/* Default-> LSCLK DIV: 1/4 LCLK  */
 	config |= (2 << DP_CONFIGURATION_CTRL_LSCLK_DIV_SHIFT);
 
-	if (ctrl->panel->msm_dp_mode.out_fmt_is_yuv_420)
-		config |= DP_CONFIGURATION_CTRL_RGB_YUV; /* YUV420 */
-
 	/* Scrambler reset enable */
 	if (drm_dp_alternate_scrambler_reset_cap(dpcd))
 		config |= DP_CONFIGURATION_CTRL_ASSR;
 
-	tbd = msm_dp_link_get_test_bits_depth(ctrl->link,
-			ctrl->panel->msm_dp_mode.bpp);
-
-	config |= tbd << DP_CONFIGURATION_CTRL_BPC_SHIFT;
-
 	/* Num of Lanes */
 	config |= ((ctrl->link->link_params.num_lanes - 1)
 			<< DP_CONFIGURATION_CTRL_NUM_OF_LANES_SHIFT);
@@ -421,10 +440,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
 	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
 	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
 
-	if (ctrl->panel->psr_cap.version)
-		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
-
-	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
+	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
 
 	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
 }
@@ -450,7 +466,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
@@ -1628,7 +1645,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	u8 assr;
 	struct msm_dp_link_info link_info = {0};
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;

-- 
2.43.0

