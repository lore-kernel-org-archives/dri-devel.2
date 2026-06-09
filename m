Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DD4CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD7810E1F0;
	Tue,  9 Jun 2026 09:47:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bS8dsvnG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iAgnVKnZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F89210E1F1
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:46:59 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6598Wgw72129851
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CP5bG4WCek6MUN3KRDCTosp+Uu7SRi1xM31/3kH0myc=; b=bS8dsvnGYp8BTe+Y
 hIbR9TZ3sauMMQDPvIwEYiYYGw+1D0M2q6jHZnkFdhSC1hPMytsRU+mHtGNVVFpG
 9hzuwYysa8kfpMwcrwATCg14S0xKrW7QKaRZJv21JwEr+kjY0TY0XTkTiv2IKnu+
 k/l1Og4Qg3IDeTFlPOXWLDJoC+sLPV6DOCWq2OGhbICF0Q6rZyVOIth+rVYvhVL5
 ZfWgmCOQnVx2IjP3GQKUD3knqTPfJBG5JjmqIVVEE5ZusxWdXkF51N35esd5eJNh
 yQhjA4/PsugeeweSQQkBCS8rQi0zJCM8ubu0G7d/5XcN3S87wd77LqSjUyXgdVOd
 +aKkPQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epfdt0a38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:46:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91574ad681eso788313885a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998418; x=1781603218;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CP5bG4WCek6MUN3KRDCTosp+Uu7SRi1xM31/3kH0myc=;
 b=iAgnVKnZZDSFC/uUFeIERnKkcYXAx1Cywtzt3WHNgUreGuH1ANaf+rtYvP0yLu5zNf
 tnKDIZzpOq8b6lg79YijlBi/yMNjMiE8B3SxybK3YK8IJHaM53KMxEqW8EYQr1rpNqAp
 OoI8Hp6yiw3fbLvmvWlay8GV5rBITqp3ypnnDJcFTKJH/YciQXfuus/i2R/8TdBo6qOO
 LaBZq6GfBRoLlrgYUOVGN0ISEDdSzQN7bIDaMIWQipaqRg2wT6gvOYA3fVo1t+h8sLwg
 7vG+tmUWrh+iNXoC8CrVR90Omxw/POlRJ2JAuTw8g5v1c+nHyoMz2XRvc75+jDf7GRu2
 JV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998418; x=1781603218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CP5bG4WCek6MUN3KRDCTosp+Uu7SRi1xM31/3kH0myc=;
 b=l4nuo/htlzpmq6RZWrq/bJavvCUQjWT/YJ9avNNPlU6GM/sqaTLzuYaQ/yKdvUaxYM
 zbRPvnCKMRAl/5lRO+Jg2RSUPzJtUe63yf+EQJZzN9gXrCZ50KMFJ58/0XlUC5E+n+S+
 HLp/gxESnckDFwUrFL3tmHQ9W1f2BelTUTinQkXwh8fhgfWSKXakBRRJPaqWlQuw47jO
 9lVcQTrDN3mw4Ajc611BoqKOh/sWE3Dj5huA3Dmfu39iN8s+KFABTZLi7p4aR1OdSJJH
 mltcIEkaWA4646vZjqdDlQDF+JIwDbnCkEXGbeZtlYNW1wl9VdbVDL2eazMv7/WiScLM
 Dh0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lAqZYhe8xGHjnayXhrRDnpyXUBSGCTTZQTNziZFtj8xWbuE36cUKdKXCDAwK7g+lvPegVPcxxYNo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYqCJekO/bXJXDYwrkosIgstQp9/36x36yF6w7LJ0oTBzwF1H4
 /nHFcLI1pH7U/FkFfTANsbeLUKIIVRwW1Tx11LqI0fqAmjzy2HW3FIC7jMghTs2WSmCXONN6ILu
 /f7xg4zm0XGlkg3oX9JWiLp1Wd+pBhKcM76LjpxOcT9Czr0mkKBKGZydccDwu4Q/0Rly1p8s=
X-Gm-Gg: Acq92OELKaU5Jj07ZEkE9l4Fv7CF4+QoGTae0tarBMFTXjwP+mZh+TvknEh7zgdxbnU
 fkPcIe/YrsFkMgRUKaJgRPv570gkJBfZ5qdlV3IbeEEwD6nzJ/oyhTRF3BaYalqmjarJQOf3R9q
 lk09YETpu1N6MAnXCBpXEOlXsVb9EMCN+ZF83oAExIwyIgiXKTH+NgXxV6bPGnav2Ld55QLRaPM
 lsGZwSfR1K8XGuq3+E2fjIceyrIIkhr5sYsZeE/xuCHGUPL9buq39v0s0t3e8C7EWVGplbRviwG
 jxf2Ujyu/TGm1jJwmxBpZH8pCepuzSHPs2tuIS5ycSc6yGtDqIVmCDUnUjgqLrO0V3jHsg2l45s
 lV1JNwDTlA+WhPfHY0VlAwJpqSREfeTmLZ66uy//rlzNilo/Z+hksQe98DIFJXm050yoBLBpbYC
 4KMmsw76IxRdGQ2aW1SA==
X-Received: by 2002:a05:620a:4508:b0:915:d10e:8c4f with SMTP id
 af79cd13be357-915d10e8f57mr1444066985a.53.1780998418567; 
 Tue, 09 Jun 2026 02:46:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4508:b0:915:d10e:8c4f with SMTP id
 af79cd13be357-915d10e8f57mr1444063585a.53.1780998418082; 
 Tue, 09 Jun 2026 02:46:58 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:46:57 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:26 +0800
Subject: [PATCH v7 04/15] drm/msm/dp: split msm_dp_ctrl_config_ctrl() into
 link parts and stream parts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-4-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
In-Reply-To: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998392; l=3833;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=iMxmvh12Ai7OvQmfN+ngrN462Gqpte4TcdsH7pCGquA=;
 b=P4YjPxAtov+3XhLaRO1sHEGTtCxAfU1L5ZurDw0/+zRJss+yCB2WdkxIHiQTrc0fW7J919oJ9
 v/1yQ8riTLxDek0sJx68eogrhNhBOkA6a8Uph4142mXJ1iOIy7E6TeC
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: Q8VssYqNOk0akfvN4Rp7BUzUkJ2hwmZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX+PwVWw67caUM
 oPN2GBve+lSlnK4sxkagjqOjBQtcfiQ+z70bxZBIBvBRUu9mkxAe26+unod1KgANkKL9nrQV/N8
 P+a0VtcW3wdKYqTrIeJaoPucHzLqfwDGl9Ij0Us3Gt4tRU+sleFiXheRWn2CPA4cVIJNqxREAiR
 YXjmdJwRjXr46eOKqiK3ulSI47y5ITxIWH4S/sORra+gsaUdouMcp35YEtuNOBDg+FB6Xyc+uZm
 OKwShy0FOk3vul/fcB2iOSJ1gYDMqghQz9/xtAtE2RoJyNs2+UbAyK761++0INiDs/Fg3DvKesQ
 4dJrPv9x7kRcKypWqUT4hY/Yhux6NBkcoaGgsZBeSb+t5xCQ+JokscqExGwbHLObPTdwX95Gjn3
 t65ReA0ktZc5Fflff/7zfFgWdWwO6zIQW4HREbzf+zgUGEzzCx7Kx5C5ct5FZGWzgltNwo6bKzk
 igWGjFzir944KA/GWkQ==
X-Proofpoint-GUID: Q8VssYqNOk0akfvN4Rp7BUzUkJ2hwmZG
X-Authority-Analysis: v=2.4 cv=doTrzVg4 c=1 sm=1 tr=0 ts=6a27e113 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=N4WGanfLxQUAwF0MUGsA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 46 +++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 86ef8c89ad44..ed2ba47881fd 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -388,26 +388,44 @@ void msm_dp_ctrl_push_idle(struct msm_dp_ctrl *msm_dp_ctrl)
 	drm_dbg_dp(ctrl->drm_dev, "mainlink off\n");
 }
 
-static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_ctrl_streams(struct msm_dp_ctrl_private *ctrl,
+					    struct msm_dp_panel *msm_dp_panel)
 {
 	u32 config = 0, tbd;
+
+	/*
+	 * RMW: Called from atomic_enable(). Serialized by the DRM atomic framework.
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
@@ -421,10 +439,7 @@ static void msm_dp_ctrl_config_ctrl(struct msm_dp_ctrl_private *ctrl)
 	config |= DP_CONFIGURATION_CTRL_STATIC_DYNAMIC_CN;
 	config |= DP_CONFIGURATION_CTRL_SYNC_ASYNC_CLK;
 
-	if (ctrl->panel->psr_cap.version)
-		config |= DP_CONFIGURATION_CTRL_SEND_VSC;
-
-	drm_dbg_dp(ctrl->drm_dev, "DP_CONFIGURATION_CTRL=0x%x\n", config);
+	drm_dbg_dp(ctrl->drm_dev, "link DP_CONFIGURATION_CTRL=0x%x\n", config);
 
 	msm_dp_write_link(ctrl, REG_DP_CONFIGURATION_CTRL, config);
 }
@@ -450,7 +465,8 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 	msm_dp_ctrl_lane_mapping(ctrl);
 	msm_dp_setup_peripheral_flush(ctrl);
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
 
 	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
@@ -1628,7 +1644,7 @@ static int msm_dp_ctrl_link_train(struct msm_dp_ctrl_private *ctrl,
 	u8 assr;
 	struct msm_dp_link_info link_info = {0};
 
-	msm_dp_ctrl_config_ctrl(ctrl);
+	msm_dp_ctrl_config_ctrl_link(ctrl);
 
 	link_info.num_lanes = ctrl->link->link_params.num_lanes;
 	link_info.rate = ctrl->link->link_params.rate;

-- 
2.43.0

