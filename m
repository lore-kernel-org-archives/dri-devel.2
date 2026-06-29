Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FFDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:15:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A68510E919;
	Mon, 29 Jun 2026 14:15:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AT/K1r9S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lp5y74G9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62F6210E921
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASqmR2601127
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eErWUES5lcasuhvm6WPQHNkgN01/Ssy72Sz66KPQZic=; b=AT/K1r9Sg0CpPcIT
 maqJQlcJLqZgc62+Db00ai6a9cWriVexCBYeKFuCjZkN7BuyQTu1unmZn85N5mpb
 /rhf2VE/t/GW6Zj2T135lzwPAKZl1v6dGndB5W89/FTmPaGG6cbLALvLyCp04ERF
 d98WNX2c+BGeCHRAtCAu4RoLl8+GPjt23svOUk+OVTJRZ7/4fzlhhewsBDpOjdkv
 +sAsjEXdpPKIaltRUu+TVYSh6UUVZEX7DUIgMTiBy/iUVnM6AYFAoqpnUwX6LjME
 ZHhMNAB0VZRH3UqeyVuM5wOsxFuNr5h9Sex3x8Ede25ivKqY3GMieA95o5uxm1yA
 Uo+KuA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw97hq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8efe7db1c42so23762776d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742507; x=1783347307;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eErWUES5lcasuhvm6WPQHNkgN01/Ssy72Sz66KPQZic=;
 b=Lp5y74G9tgtKUnIRHGNyolG5ZyC9pMrDPkzHMh9fNKrEd0Aw6jUH4wh7SeoYPEvwmX
 v4KrM/3IYNNrI33+t5edUt62Z3ZvWksS4Opz+7fehzIv/n6pYvytDPWx3o1Zz+mj24OU
 MKWwg0qyQUDGSy88zlRrkm0ROX+vMppa4yDQwzNil+uWkhPihKwnsq8WXrWMuHxdyXPO
 QAto9EUYp0N3kqZf4TwZyIyAmKYtzpsKK9hWshWMDiuiK8mMvIFUsmyexQMqJi8qYgJK
 on1xDo8r253nk+KUdDjVnmrXWN9kt8eqUOHQ+UXtaNEqPS0PI8GtBVdoklOwJoAY4hlY
 S8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742507; x=1783347307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eErWUES5lcasuhvm6WPQHNkgN01/Ssy72Sz66KPQZic=;
 b=LU6G/08sY+tv1vxF/ZvzaXO/EP2TP4xP5xQgjhi/Co77vOSRNVbm0W/hZKWM7H3+x9
 b4sUhnU2VD9ujlTmlmvZxNcEVgwHcpmPpL1/vNzpzrgeS1HmH3JZxXt59/Qrnn2rF2o9
 k21OkWr1cqsM64ANQkgvLxC3QffEOdJ+eQny01sgc4R2tbCy8eM5F6Dptqcb0rwcswdK
 Cp7G8uChZ0fG52gABdFd+MfsngydBVh5DPj7Z3VVNsRszS28Wv3RaThahy9gxzhrqZ6y
 uGqXNMpBr1RSZeYAHYicWwkWxvKKYs9CH7lFamIbDF7+xu2SfyxS4rX+2RKoeZ4KPrE6
 DApg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9ADWIRMjETXuzWn22i8t2u/6c13tQhdGnpHZSk37fHBuHpnE4Dllkt7uTk9L75jBGlMecVav1UUz0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwgWny7cdNU0YVnAWoyz2wT2AugTOp0tLQ71Moqq+uZU9+lkRlJ
 Yaj+MfCemnNRo2t4WU0fWBTHeOQyUekJnxEkVHoXx0MH5xUqWFMfpxKywoVlfkMpnWUWALRaazr
 FE8kZSZsiT0Mkc6TMezO+4R2IwJZ9fvKfEqTrhHfFM6cKOu+pphq8Z7eZFO3IWx9ET8aaoLo=
X-Gm-Gg: AfdE7cnE0sssvUlWG24mC4uP3d1jXIWQZTMIxuqAkdebo5TEua2co2WZkfn4isr2LEo
 LiJFtGwhr77MyEfi/iyCjvsrlHITTGyMisKf/CJl6mwUTf58e2b8tOifmWPOS3nl7jxyCwqVd/Z
 cIJscjY9Gcnub6UHorTEPZxXHpcDOEWx18w5wJEiCM6be5+eC8BF//4cGbgbT8foTVAKEw/uu4L
 EqKQRlBt8MM8WEivV/TFRD5kX5wOV79Uyw/ASknk2nlmQmhwtHNU5TrvHavi01Oqi5A/Bk+ee7w
 MtoU/OxXTdQxxFVd1z44g+TGu6OwHatgghI3yrkLVh2D2QL1c/8rOUG5HQ0bkx+mXfs2JaOkY0o
 AaA5d9O96TKpWHLy6rxhSXHd2K2F+WAYKtrItQllGNzYgQM3Io8zlH/xi5oOGcYKl5XZucQ==
X-Received: by 2002:a05:620a:19a1:b0:915:b9f6:719d with SMTP id
 af79cd13be357-92b3da97d5amr1656551885a.30.1782742506339; 
 Mon, 29 Jun 2026 07:15:06 -0700 (PDT)
X-Received: by 2002:a05:620a:19a1:b0:915:b9f6:719d with SMTP id
 af79cd13be357-92b3da97d5amr1656538585a.30.1782742505553; 
 Mon, 29 Jun 2026 07:15:05 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:15:05 -0700 (PDT)
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
Subject: [PATCH RESEND v5 02/25] drm/msm/dp: introduce max_streams for DP
 controller MST support
Date: Mon, 29 Jun 2026 22:14:23 +0800
Message-ID: <20260629-msm-dp-mst-v5-2-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=4176;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Aqo+NoeQSRVWiAKg7eVou998ouelemJcrlt/SprmKw8=;
 b=xrP8SSMsPOs65ifnl/6yyv34YTP3zjglo6mf3Xq0XimtZ/7B5wRiJAnTUrI730coFiRU9qIWm
 TaeGAqCKFI+A44BGtDQibFQN4kjEpgr4++d015+CfNVJDUj3R0/21xo
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX12rK6X724itR
 Fj9/bfQJaSTKp0BixS8X6JQTaV4JeB+TqY4v8UtTY3HYkleUS7yVFEC2TMBH5Np55FLYLgqQEjV
 /L7jAubODNz0BchIkxcQOGvHUtjc8H8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXw1n2jv3GjOJV
 CXQquBYKaHELlN0MaNkZgcRnusIDJIReHw6UtHo0+NTzX/7/7KQPTeQTiMTAddCpRE7hKcDEC/5
 TLnA8/Gp3jKZJh+rTw3+yQSRcSP6KQ+i71roB+a0H+SFFsBzBWesQ/0QrW1S18t6C70KWNfQQBm
 Z6o156WAhP9WjAwaNyu+bdZ3idEuru3TFk7ifewy+0QgOwCY/qenkMrXW9fcXF1fwvzXV5qqAkA
 ef5nSXGppkclLhSIiGwvTwNjdX/MOlkuTz7ASHhVIjrsL3DPWXdDJurv4vbxZDXRyWZIcYhk1/3
 UlDaI6YccwMAEeFIoewQhFnzNrltvw7q6Itx5fPu+eZ0nX1hCvLsc/iHPyVVfGPwsuxldYYmbGu
 6MS+pKaJZfX3PYxwbgNfj6insWrLUeimavPlP7Cyvr9GRqnKAc7E9wTP3hh4QrAZU4H9ks7rXj5
 LCx4g/Z7zC3EKyjkybg==
X-Proofpoint-GUID: djNOFJ28MlQPf3IrKWsMgwztmHn3eXiJ
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a427deb cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=lhQZdvDDsnZ9MB6dQpsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: djNOFJ28MlQPf3IrKWsMgwztmHn3eXiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
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

DP controllers across different SoCs vary in the number of concurrent
MST streams they can support. Rather than hardcoding per-platform
values, the number of available pixel clocks in DT serves as a natural
indicator since each stream requires a dedicated pixel clock.

Introduce max_stream to capture this at initialization time and expose
it for the MST module to use during setup.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c    | 13 +++++++++++++
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
 drivers/gpu/drm/msm/dp/dp_display.c | 12 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h |  1 +
 4 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index a475e787656e..68fb4facb056 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -127,6 +127,7 @@ struct msm_dp_ctrl_private {
 	struct clk_bulk_data *link_clks;
 
 	struct clk *pixel_clk[DP_STREAM_MAX];
+	unsigned int num_pixel_clks;
 
 	union phy_configure_opts phy_opts;
 
@@ -2754,6 +2755,7 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 	if (rc)
 		return rc;
 
+	ctrl->num_pixel_clks = 0;
 	for (i = DP_STREAM_0; i < DP_STREAM_MAX; i++) {
 		ctrl->pixel_clk[i] = devm_clk_get(dev, pixel_clks[i]);
 
@@ -2766,11 +2768,22 @@ static int msm_dp_ctrl_clk_init(struct msm_dp_ctrl *msm_dp_ctrl)
 			DRM_DEBUG_DP("stream %d pixel clock not found", i);
 			break;
 		}
+
+		ctrl->num_pixel_clks++;
 	}
 
 	return 0;
 }
 
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	return ctrl->num_pixel_clks;
+}
+
 struct msm_dp_ctrl *msm_dp_ctrl_get(struct device *dev, struct msm_dp_link *link,
 			struct drm_dp_aux *aux,
 			struct phy *phy,
diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
index be0d89d60914..305add3dcd93 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
@@ -55,4 +55,5 @@ void msm_dp_ctrl_enable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 void msm_dp_ctrl_disable_irq(struct msm_dp_ctrl *msm_dp_ctrl);
 
 void msm_dp_ctrl_reinit_phy(struct msm_dp_ctrl *msm_dp_ctrl);
+int msm_dp_ctrl_get_stream_cnt(struct msm_dp_ctrl *dp_ctrl);
 #endif /* _DP_CTRL_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bb243ab09e66..9cd243411e44 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -87,6 +87,8 @@ struct msm_dp_display_private {
 
 	void __iomem *p0_base;
 	size_t p0_len;
+
+	int max_stream;
 };
 
 struct msm_dp_desc {
@@ -578,6 +580,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		dp->ctrl = NULL;
 		goto error_link;
 	}
+	dp->max_stream = msm_dp_ctrl_get_stream_cnt(dp->ctrl);
 
 	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->link_base);
 	if (IS_ERR(dp->audio)) {
@@ -1178,6 +1181,15 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 	return 0;
 }
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return dp->max_stream;
+}
+
 static int msm_dp_display_probe(struct platform_device *pdev)
 {
 	int rc = 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 43ed79093e24..d3d4ab98089d 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -26,6 +26,7 @@ struct msm_dp {
 	bool psr_supported;
 };
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
 int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
 bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
 int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);

-- 
2.43.0

