Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77237C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEF1C10E8A1;
	Mon, 29 Jun 2026 13:16:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D9sieNi1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cpKPkwgK";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AB2910E8A6
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:16:42 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASuHv2603458
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eErWUES5lcasuhvm6WPQHNkgN01/Ssy72Sz66KPQZic=; b=D9sieNi139Ib95CD
 ESCCPZhlZ8Ney2NwGWBR0aQ47ISUV3CJ371rmQ5laUV8tpNmaFvgrrjhtVejmh5R
 qUKGYbiUO7ToRkBbKukrcdAONioo0Eni2DJFSh9BmvEidUDXvrDjigXlJaVtwl4o
 J0ozoTaNGzOhm56SgQXF5P2i4mi5uNalfmfCeRs33ObL070PXqlRfsiP3JNhDBVX
 sRCSO/kabEA4/zsPapztkTwop6IdxMgVZYHPJQT6iKRhnOxbLANfJHKPXPCqDnuV
 3FOe5c9/Gm6O7OWSYHTjI24sJzynSEnf6Hwn3qocg00S8lGJgV/OOEvQNtFO3wjh
 hO1MZA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq88xwk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:16:41 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-809ed87d66eso60526707b3.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739001; x=1783343801;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eErWUES5lcasuhvm6WPQHNkgN01/Ssy72Sz66KPQZic=;
 b=cpKPkwgKraktxMfRnSDqQqrH9RMo8h+TFOZgeHMqCETz/H4RsVD0pKwHsS15EgaQRs
 mMXZ/D2qXe6/5KVKiOq5kYOklmNyh08mq3ZwfbMFCiH8WumkEp4Lvrc9Rr3inLhDyIga
 fVyhHh6G4iBc7FKZgxIhTNKETCQtWmtgRV0atei1cRS3p6hQX4QtrGlEW3HdCn+mxFTo
 i2GeylnzhE6jkn9jfnfWIUZZHW3/VTprFp3vto7QaE9eCEJvvX1S+Q6zWNZ9aCehQ0K1
 1lwNLYPzcut8UKYX9CLAbyPKPdS9O7Cqxex6G5GN5kKCxplJNDtPW/NuSvRh7ROHHLgM
 Yljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739001; x=1783343801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eErWUES5lcasuhvm6WPQHNkgN01/Ssy72Sz66KPQZic=;
 b=noBc9JgN0FwRExI9BJFetMhIGZsWniEstAhUcTT94Gr52+nVP2GTfinxndlrjmMuS0
 LXKT/3G0Rzsv5G02hqZTIiv3wjsckJXN2AxygalWY2Zgnwg1DHJEyO+dIdWoJoZIc6mo
 NeBOQGtGlVNlXIO4gcc++bjzw8pyBGD7hWkkx/Dx5OSL80VdsSnJsUR+wiZ3Kpe0UL+Q
 hjmXS/gAJLZci/EgdR5eCJ8p2+otMFDxAqHomhGp94/9iCHoajapUTxKnvjpIylbrcFT
 ZSPEszeLoKkxy4A6wdd1yHU5QvZ6QR5yOcSTLJEsK/QnOrNYiF1QpB3ADqA5D+bEcJp3
 ZvaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqjp5U5vzOAKRBuHHyoyO44dyeMKCIPn+b0B6GIrWZI3A4Fxc71PmY0zqcsM5+iWe7Irw9vjR7hPNg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxmKw2ho1RAmhe8BCsX0qayR8GNkej1908uF3QaQaBwXuiNZd66
 elMfLzeco/l8Q3AB3WBs7pmen7lLVYudXER95RpHm644jQWs+RbbRFukGBtaQmwW+V1Ug7dQ71K
 1pqTE8I+juBD01ChBEU8UuxkW+x4Hul0rRjkXn7vjGygM4XkhA/COZDd+QJClZ2qYW2uEmnI=
X-Gm-Gg: AfdE7cl4vxcUTb0cCXeU3qNGOb4wDe6Lf+srZVNgPm56Qgb1Ut0+02iolsiZSYLanoH
 1fVrMVAJ1+egOGwmjW9s5b4hkxuTM/jGv5RIZp4cOCv61hmH1QZhqNTjhupXoQNLqGNXO29pFhR
 c7aUn1lQy+o7l0p29jERW6vDYU+vzpzh/xdly5LqGToxdaTIvj0/oDNtt6L3HAwZoKHikCaoq+Q
 k01JpBtZAhq7NGzewAJ5j5aofQ+KxPEM/IhicQ+YjjTyK5FWJHSsxRT4G+v2mlSUU3QFWxeaf6h
 dTEyev/0531t8UcJ2ZfKSf/nAOCBueQsQE/x2+sqAnMtjGQIZG9V8ZnQ64Efxo+qqYVV+D7pStQ
 x5lQ8Hv/z2g+sTZt22XdcTmU6sqDidXB3/w1TXC/s3OJGEMwBIygRwOi+TSGUucMSZYNOt6NS6w
 ==
X-Received: by 2002:a05:690c:7408:b0:80b:d5d5:1aa with SMTP id
 00721157ae682-80bd5d50715mr105681537b3.1.1782739000535; 
 Mon, 29 Jun 2026 06:16:40 -0700 (PDT)
X-Received: by 2002:a05:690c:7408:b0:80b:d5d5:1aa with SMTP id
 00721157ae682-80bd5d50715mr105680927b3.1.1782738999830; 
 Mon, 29 Jun 2026 06:16:39 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.16.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:16:39 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:20 +0800
Subject: [PATCH v5 02/25] drm/msm/dp: introduce max_streams for DP
 controller MST support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-2-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=4176;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Aqo+NoeQSRVWiAKg7eVou998ouelemJcrlt/SprmKw8=;
 b=TIYTkfX0XafmUOXJSWn8NvOtut2IsgrSuWaPzmMGqkxhCMAVZH3hBe2UK9x5WiMFmJkj83b0S
 vXL7oooXhRqA4q1K6fSIt4ZTI/7QkpQWPO+dO7SV9iymhDwEwdSIc0R
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: RG7PJPEjKu2c-Xa0zphNplrawzIPLF5H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX3Q5WxT2NFBuu
 KFsqn7BxFj9a5VrAGMWi/7AYbO8KvJB20RpFcT4671HBcLWRBW+8ftB/BnkctvB1DhZmnFyBEZZ
 58s8Oqip9xD1MVNz8pbf5Ojol6mBWWg=
X-Proofpoint-ORIG-GUID: RG7PJPEjKu2c-Xa0zphNplrawzIPLF5H
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a427039 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=lhQZdvDDsnZ9MB6dQpsA:9 a=QEXdDO2ut3YA:10
 a=WgItmB6HBUc_1uVUp3mg:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfXwIhBNJncQEE/
 owg7MiXAHOXSpW3mVGRAGPH34C28nWyqEqNYtoKgXIHSevuqwZat/zytfOsXasr2lcWsCOA4XKN
 wL/k/EfApBdgCQ4BgqlSmepPXDAxFkvT7ZZ7oUHgzpsF7xJQvhBz8YhEbjDFyOGXB574HIozEnx
 EnTk6slgDTop1O1hdasNt2NIN8l05JiGZUf4wj7vwy8Of6SkSGgRpsgk3RG8aszp+IPt+HpTWfv
 SuWZLDKwtXDtm7yrTibkg4jJFQB071XDoGTi3q88OAFX2OhV1jkSw1hwM+4JSA06ASQh50gTLY1
 tMLh/d6WaG8XZLd6TR9EuzGXgmlXQm64gDtiaYhE/JUTCLLYsfn0FoajaJUTfX+NtO0DvGtJblA
 VIag0qoF3YuydsIYq/ge7nKFdAiCfCG8KxeA8//pftJGoihUr8WQo5AhAZ5DvNdC9UMgtKVDnKZ
 ttBOrPZtXkxtPeOpB0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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

