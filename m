Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEA7C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 687A810E914;
	Mon, 29 Jun 2026 14:15:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gK/zcrGh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D954Gsyg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07F210E914
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:27 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATBxL2647640
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 a5dTcTvvgFtuYY8IdP0e2ZZdOifQtCiwUe5JOKtT+Rc=; b=gK/zcrGhI6jOF5de
 JHQEWGBuiIlpFeGaJIqpAE8VlEH90Y/h88KBhUINCaTQwpD5BBTBTtIwpdiA2vG9
 2WdnMVeBj1m3/IkNVREFopv/1/bM9W2IckhvtOaV3xAUekZhG098jsY4hk7gKuWp
 IAek45Wb+G19MtOCgvnhLM35yrbb3wcQxw3+EEOCcot3cYe9RT16o7DVjm9Xkd0K
 ZDicFWYdabtMeNBJdW+CE8/GPNOw+pyUEuEw28uwmgdcBCVzzvH9eVf20PIAbqlX
 hLsIus11EWjjkwbcFjQIDQIajH4G3xmyidetc6CIkadz/Cc6DiravPtU3vy9+D4h
 VQHT0Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kyjhnvw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:15:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92d1cae5939so365681085a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742526; x=1783347326;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5dTcTvvgFtuYY8IdP0e2ZZdOifQtCiwUe5JOKtT+Rc=;
 b=D954Gsyg3FbqrWX/aXeKrs2qPQKN/ZZcbXvniVExlwJr4NbHVrUQXO4Y13itsxpzSA
 G3IxwMseHDLwo05YOBTHPa9cdMpUuXYVmuq8Gukb84zw2rsTABS84FwT+hkGTcXDJVoH
 QJQcC8/cGV9crYiDB4dsrVbHFWX3DJY4pzX3YOYzUGH5y5MaV3RUgB1rvsYsxcTmRBjI
 NwZfEy7uE6zitwg3EQgoDr2s+6NEO7KA30D9fRc5YBUnjSjEbCjOvli9DbU9+9rOucDY
 jz/cbubH3NrRWrhnrdTZGzJofmRBPj6uL5o57ogf/p6CcKzEu1sFCd9KjweESWgiF27C
 2jdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742526; x=1783347326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a5dTcTvvgFtuYY8IdP0e2ZZdOifQtCiwUe5JOKtT+Rc=;
 b=o06rqlbZX9gxi9Fln82cyyfsQ3cE3dDtW4HBcF3GnMV5f1oqWSzTSiATTzN7K0Nu7i
 ucMM043OaRyjemWWVqD5JVEoHzzodivom/C8dcvl+6kk5Lzck5fwZxHXIrKwv2F7Bxyf
 klKdolRlLjiuwqBkIxX0/wbeZe68Za0baF7AdLQaKC8c8iGRUSMnq8hIKhxGtChI7+l1
 RstYwYxHsHcDKuUu7SvYWRBCCJ7pDPM5B1VzDdvzm8tOQ3IQHbJ7mcHMClqDmmkQwVYu
 hccF8tlPd3fRQ6Izh0j2y9prMP4tmKB58P/irrR41Tz8bR7w9+XYVnWkUFQGdTHE08yl
 Sv3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OgMBuSCZOUT1IGZl5wR3tIWKsVEg6P+uNeD/l/PvvNAtkDmoxdWk4bRWUZZQAk4FNT9NTyEY+ES0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrHvvxlODH6iOjMHtTonK+9THplnlzgBeXPvp78vcM9/7cuKta
 QsXflsDwEmh3UZxJcHcv5tDiNU5ExodqX5XfmBHw1NT2RcN1Xm4yxyz9t+kK3gsy82YiuTFwR7K
 KIKeUvZ+mskzik4qbyOv5dHiJDM7RtvDLmxNtLK5q3MxVmTfNst2pf0W6lce+f2cejThd+30=
X-Gm-Gg: AfdE7cmVoqENnQMKXBaM/H7gshGO8UE/KVwCQRVWJeb6VC1j7Ks+O4JdkhRM9qNZu1x
 Fo7EpWeyN/lOyf+jiy07xRRG59ENGQYCpHN+ajuPaiN3MVn0HUIjw5Zni2GlwMSKEPWgwWB4em6
 lQ6+QOXLIfDj5kWm5fK8aA5lXncMdHz9JGOYxHHaSLoeUMppbnEbfuVlfWlE4f3RoBtcFaRPKnm
 LnEVcgLYysQdB6+mG39PlWFjtE5opSEwdkTZ7kMbMegC+w33rOdJB7hEWIEw2UwXrP6K2tVE6K8
 T41XTgxRSgjdBtEDygUtdqLrnxoLd7hummZzkHwdVu29I9IulAeYYPk4zQ6yuxCDruSNahpkPQm
 n0KP+tAnojZ01uaa2I2UbPjrYBpZq/7T8kt6eZG6vE3+hu2CUDDCjgIquWYuFEdqAFfs00g==
X-Received: by 2002:a05:620a:170e:b0:915:c4de:7ac2 with SMTP id
 af79cd13be357-92e5f18b310mr138667285a.30.1782742517695; 
 Mon, 29 Jun 2026 07:15:17 -0700 (PDT)
X-Received: by 2002:a05:620a:170e:b0:915:c4de:7ac2 with SMTP id
 af79cd13be357-92e5f18b310mr138632885a.30.1782742515597; 
 Mon, 29 Jun 2026 07:15:15 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.15.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:15:14 -0700 (PDT)
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
Subject: [PATCH RESEND v5 03/25] drm/msm/dp: Add support for programming
 p1/p2/p3 register blocks
Date: Mon, 29 Jun 2026 22:14:24 +0800
Message-ID: <20260629-msm-dp-mst-v5-3-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=12081;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=7IzLV7p7fRpuHOYKSsckuJf6muYlm+ZMBp5oLG6WV9M=;
 b=ObmGnEi+xCqhRKTUk66sWo9Nwd3S6pKEFU4jey0D0LbmOveYuDEVZlv+KB359H5ccPjcoN6kT
 /Vx2fNKt2P6B6LYbsflEnF4tE7CbUdYSV0AcMgrw0X+IK23ua8+uE/Y
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bhd-SR-L_LOug9hWsMn29ZpzufzWkhJp
X-Proofpoint-ORIG-GUID: bhd-SR-L_LOug9hWsMn29ZpzufzWkhJp
X-Authority-Analysis: v=2.4 cv=Ftk1OWrq c=1 sm=1 tr=0 ts=6a427dfe cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=4aQLaHZKxtSMBsMh2sMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX8Fai9Ek8Sf7Q
 f8degZvuelSQj0zIUmN9sBINaHnOsx+xiP+5415yiFGGvha3Cl98o2jct8NqJmDY4/uVilAoLB0
 qxBlIJFBh796gGi8QGlnRVejb4zo008=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXzT04aG6LlJg0
 lOCOz5Q3gFKmazia5tIptyAhuoyRv7dm43B0/0PAl4JqaZFY9kBnvnj/cAT/Nyme1jOIk//+H2k
 Q+7+uQMrN3Fcw7KDOdBfrU8/IgTO0cUIZ7pYVZRn+r03E+LJW8pwLbwIg3Cv+HJ/zc2XBlJwP+g
 qKzmz16cM6M/mw1ib9HCMpQ47dU6x3+vqQHgLrR6YiR6wMr/9aPerYGEA2CXzAFCSCxlfjJqP0N
 k6aFisaiV4D4Vsr7TybLXlTv4i1oQiqS1oJQTnIpiKHYzEtxJKfE2KJx1W53cPDVlJtdFuBWA3r
 YoYaj2RXdv3a7P2ZpJbETEXxvXyUSkS1HHMpFpU1WPtDvlyN+v+SNEqNxMt3f/FLpOUT4uSniMT
 VpJylHgwQ6ymXwY6asWL9ojBwsl9mA7HLTxjA8RwuGqifhFweScxKd9U0Fi2BaIerX4icPwApQv
 4jUBTx4uY5Mo6pJveXg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
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

Add support for additional pixel register blocks (p1, p2, p3) to enable
4‑stream MST pixel clocks. Introduce the helper functions msm_dp_read_pn
and msm_dp_write_pn for pixel register programming. All pixel clocks
share the same register layout but use different base addresses.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 40 +++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_panel.c   | 82 ++++++++++++++++++-------------------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  2 +-
 3 files changed, 71 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9cd243411e44..74f481a18164 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -85,8 +85,8 @@ struct msm_dp_display_private {
 	void __iomem *link_base;
 	size_t link_len;
 
-	void __iomem *p0_base;
-	size_t p0_len;
+	void __iomem *pixel_base[DP_STREAM_MAX];
+	size_t pixel_len;
 
 	int max_stream;
 };
@@ -564,7 +564,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		goto error_link;
 	}
 
-	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
+	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
 	if (IS_ERR(dp->panel)) {
 		rc = PTR_ERR(dp->panel);
 		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
@@ -850,8 +850,14 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
 				    msm_dp_display->aux_base, "dp_aux");
 	msm_disp_snapshot_add_block(disp_state, msm_dp_display->link_len,
 				    msm_dp_display->link_base, "dp_link");
-	msm_disp_snapshot_add_block(disp_state, msm_dp_display->p0_len,
-				    msm_dp_display->p0_base, "dp_p0");
+	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
+				    msm_dp_display->pixel_base[0], "dp_p0");
+	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
+				    msm_dp_display->pixel_base[1], "dp_p1");
+	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
+				    msm_dp_display->pixel_base[2], "dp_p2");
+	msm_disp_snapshot_add_block(disp_state, msm_dp_display->pixel_len,
+				    msm_dp_display->pixel_base[3], "dp_p3");
 }
 
 void msm_dp_display_set_psr(struct msm_dp *msm_dp_display, bool enter)
@@ -1131,6 +1137,7 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
 static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 {
 	struct platform_device *pdev = display->msm_dp_display.pdev;
+	int i;
 
 	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
 	if (IS_ERR(display->ahb_base))
@@ -1160,8 +1167,8 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 		display->aux_len = DP_DEFAULT_AUX_SIZE;
 		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
 		display->link_len = DP_DEFAULT_LINK_SIZE;
-		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
-		display->p0_len = DP_DEFAULT_P0_SIZE;
+		display->pixel_base[0] = display->ahb_base + DP_DEFAULT_P0_OFFSET;
+		display->pixel_len = DP_DEFAULT_P0_SIZE;
 
 		return 0;
 	}
@@ -1172,10 +1179,21 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 		return PTR_ERR(display->link_base);
 	}
 
-	display->p0_base = msm_dp_ioremap(pdev, 3, &display->p0_len);
-	if (IS_ERR(display->p0_base)) {
-		DRM_ERROR("unable to remap p0 region: %pe\n", display->p0_base);
-		return PTR_ERR(display->p0_base);
+	display->pixel_base[0] = msm_dp_ioremap(pdev, 3, &display->pixel_len);
+	if (IS_ERR(display->pixel_base[0])) {
+		DRM_ERROR("unable to remap p0 region: %pe\n", display->pixel_base[0]);
+		return PTR_ERR(display->pixel_base[0]);
+	}
+
+	for (i = DP_STREAM_1; i < DP_STREAM_MAX; i++) {
+		/* pixels clk reg index start from 3*/
+		display->pixel_base[i] = msm_dp_ioremap(pdev, i + 3, &display->pixel_len);
+		if (IS_ERR(display->pixel_base[i])) {
+			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
+				     display->pixel_base[i]);
+			display->pixel_base[i] = NULL;
+			break;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 745ee6976897..238920c45261 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -25,7 +25,7 @@ struct msm_dp_panel_private {
 	struct drm_dp_aux *aux;
 	struct msm_dp_link *link;
 	void __iomem *link_base;
-	void __iomem *p0_base;
+	void __iomem *pixel_base;
 	bool panel_on;
 };
 
@@ -44,24 +44,24 @@ static inline void msm_dp_write_link(struct msm_dp_panel_private *panel,
 	writel(data, panel->link_base + offset);
 }
 
-static inline void msm_dp_write_p0(struct msm_dp_panel_private *panel,
-			       u32 offset, u32 data)
+static inline void msm_dp_write_pn(struct msm_dp_panel_private *panel,
+				   u32 offset, u32 data)
 {
 	/*
 	 * To make sure interface reg writes happens before any other operation,
 	 * this function uses writel() instread of writel_relaxed()
 	 */
-	writel(data, panel->p0_base + offset);
+	writel(data, panel->pixel_base + offset);
 }
 
-static inline u32 msm_dp_read_p0(struct msm_dp_panel_private *panel,
-			       u32 offset)
+static inline u32 msm_dp_read_pn(struct msm_dp_panel_private *panel,
+				 u32 offset)
 {
 	/*
 	 * To make sure interface reg writes happens before any other operation,
 	 * this function uses writel() instread of writel_relaxed()
 	 */
-	return readl_relaxed(panel->p0_base + offset);
+	return readl_relaxed(panel->pixel_base + offset);
 }
 
 static void msm_dp_panel_read_psr_cap(struct msm_dp_panel_private *panel)
@@ -367,34 +367,34 @@ static void msm_dp_panel_tpg_enable(struct msm_dp_panel *msm_dp_panel,
 	display_hctl = (hsync_end_x << 16) | hsync_start_x;
 
 
-	msm_dp_write_p0(panel, MMSS_DP_INTF_HSYNC_CTL, hsync_ctl);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PERIOD_F0, vsync_period *
+	msm_dp_write_pn(panel, MMSS_DP_INTF_HSYNC_CTL, hsync_ctl);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PERIOD_F0, vsync_period *
 			hsync_period);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F0, v_sync_width *
+	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F0, v_sync_width *
 			hsync_period);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PERIOD_F1, 0);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F1, 0);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_HCTL, display_hctl);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_HCTL, 0);
-	msm_dp_write_p0(panel, MMSS_INTF_DISPLAY_V_START_F0, display_v_start);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_V_END_F0, display_v_end);
-	msm_dp_write_p0(panel, MMSS_INTF_DISPLAY_V_START_F1, 0);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_DISPLAY_V_END_F1, 0);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_START_F0, 0);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_END_F0, 0);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_START_F1, 0);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_ACTIVE_V_END_F1, 0);
-	msm_dp_write_p0(panel, MMSS_DP_INTF_POLARITY_CTL, 0);
-
-	msm_dp_write_p0(panel, MMSS_DP_TPG_MAIN_CONTROL,
-				DP_TPG_CHECKERED_RECT_PATTERN);
-	msm_dp_write_p0(panel, MMSS_DP_TPG_VIDEO_CONFIG,
-				DP_TPG_VIDEO_CONFIG_BPP_8BIT |
-				DP_TPG_VIDEO_CONFIG_RGB);
-	msm_dp_write_p0(panel, MMSS_DP_BIST_ENABLE,
-				DP_BIST_ENABLE_DPBIST_EN);
-	msm_dp_write_p0(panel, MMSS_DP_TIMING_ENGINE_EN,
-				DP_TIMING_ENGINE_EN_EN);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PERIOD_F1, 0);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_VSYNC_PULSE_WIDTH_F1, 0);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_HCTL, display_hctl);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_HCTL, 0);
+	msm_dp_write_pn(panel, MMSS_INTF_DISPLAY_V_START_F0, display_v_start);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_V_END_F0, display_v_end);
+	msm_dp_write_pn(panel, MMSS_INTF_DISPLAY_V_START_F1, 0);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_DISPLAY_V_END_F1, 0);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_START_F0, 0);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_END_F0, 0);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_START_F1, 0);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_ACTIVE_V_END_F1, 0);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_POLARITY_CTL, 0);
+
+	msm_dp_write_pn(panel, MMSS_DP_TPG_MAIN_CONTROL,
+			DP_TPG_CHECKERED_RECT_PATTERN);
+	msm_dp_write_pn(panel, MMSS_DP_TPG_VIDEO_CONFIG,
+			DP_TPG_VIDEO_CONFIG_BPP_8BIT |
+			DP_TPG_VIDEO_CONFIG_RGB);
+	msm_dp_write_pn(panel, MMSS_DP_BIST_ENABLE,
+			DP_BIST_ENABLE_DPBIST_EN);
+	msm_dp_write_pn(panel, MMSS_DP_TIMING_ENGINE_EN,
+			DP_TIMING_ENGINE_EN_EN);
 	drm_dbg_dp(panel->drm_dev, "%s: enabled tpg\n", __func__);
 }
 
@@ -403,9 +403,9 @@ static void msm_dp_panel_tpg_disable(struct msm_dp_panel *msm_dp_panel)
 	struct msm_dp_panel_private *panel =
 		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
 
-	msm_dp_write_p0(panel, MMSS_DP_TPG_MAIN_CONTROL, 0x0);
-	msm_dp_write_p0(panel, MMSS_DP_BIST_ENABLE, 0x0);
-	msm_dp_write_p0(panel, MMSS_DP_TIMING_ENGINE_EN, 0x0);
+	msm_dp_write_pn(panel, MMSS_DP_TPG_MAIN_CONTROL, 0x0);
+	msm_dp_write_pn(panel, MMSS_DP_BIST_ENABLE, 0x0);
+	msm_dp_write_pn(panel, MMSS_DP_TIMING_ENGINE_EN, 0x0);
 }
 
 void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable)
@@ -439,7 +439,7 @@ void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel)
 	struct msm_dp_panel_private *panel =
 		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
 
-	msm_dp_write_p0(panel, MMSS_DP_DSC_DTO, 0x0);
+	msm_dp_write_pn(panel, MMSS_DP_DSC_DTO, 0x0);
 }
 
 static void msm_dp_panel_send_vsc_sdp(struct msm_dp_panel_private *panel, struct dp_sdp *vsc_sdp)
@@ -629,7 +629,7 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 	msm_dp_write_link(panel, REG_DP_HSYNC_VSYNC_WIDTH_POLARITY, width_blanking);
 	msm_dp_write_link(panel, REG_DP_ACTIVE_HOR_VER, msm_dp_active);
 
-	reg = msm_dp_read_p0(panel, MMSS_DP_INTF_CONFIG);
+	reg = msm_dp_read_pn(panel, MMSS_DP_INTF_CONFIG);
 	if (wide_bus_en)
 		reg |= DP_INTF_CONFIG_DATABUS_WIDEN;
 	else
@@ -637,7 +637,7 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 
 	drm_dbg_dp(panel->drm_dev, "wide_bus_en=%d reg=%#x\n", wide_bus_en, reg);
 
-	msm_dp_write_p0(panel, MMSS_DP_INTF_CONFIG, reg);
+	msm_dp_write_pn(panel, MMSS_DP_INTF_CONFIG, reg);
 
 	if (msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420)
 		msm_dp_panel_setup_vsc_sdp_yuv_420(msm_dp_panel);
@@ -701,7 +701,7 @@ int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
 struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
-			      void __iomem *p0_base)
+			      void __iomem *pixel_base)
 {
 	struct msm_dp_panel_private *panel;
 	struct msm_dp_panel *msm_dp_panel;
@@ -719,7 +719,7 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
 	panel->aux = aux;
 	panel->link = link;
 	panel->link_base = link_base;
-	panel->p0_base = p0_base;
+	panel->pixel_base = pixel_base;
 
 	msm_dp_panel = &panel->msm_dp_panel;
 	msm_dp_panel->max_bw_code = DP_LINK_BW_8_1;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 50a721401751..218a09a2fa65 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -102,5 +102,5 @@ static inline bool is_lane_count_valid(u32 lane_count)
 struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
-			      void __iomem *p0_base);
+			      void __iomem *pixel_base);
 #endif /* _DP_PANEL_H_ */

-- 
2.43.0

