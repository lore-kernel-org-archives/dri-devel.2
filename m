Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF74E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:35:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E780E10E90F;
	Fri, 10 Apr 2026 09:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MSx/zbVU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DwhUgp7u";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4151E10E913
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A7LpDd3934926
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tgPiHrh218C+70LI8IfVK/IDQIbivXFNYVZM0TJalrw=; b=MSx/zbVUK/q7OOSc
 Vsj3h9fBDe8q8a5ft+Ld0+saU6jzU2tiUYt/XSlC3Kmf6JdKZtvodNzo+kZm0Lno
 D3bLKRONq7Ci+3ACP75A4oYYF+IA7aRDa+kvdszL4mBeb0MDt34yQvaDCgWlUli1
 a99lry3oC4tNZBeF0D1CZrPMAkHRKXc3B+VrizjszK19F95iPcFdt7Mja0KZBvDA
 dVCInsC6wAS4xAZcarvXOYt/sQWbgM5s4nqxXenHK2zHPWColeSqeziUwmUvtIyN
 a4y4F/LNVZElM1xcaBm0DeWEaH+Oin4GwCOzc6lmsCKuU79TkK1bMP/E6fBkMXPX
 Gsj6gw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded5sbfqk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:35:09 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89cd8b56114so51598696d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813709; x=1776418509;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tgPiHrh218C+70LI8IfVK/IDQIbivXFNYVZM0TJalrw=;
 b=DwhUgp7uCMcs33K9n8yNN/TSPKf5xMj+a4d89fkkQTMm7tvlxfaCy6N9AQldVQPDG7
 AsalUtdnsCu6FKXN8HPJJ62segLNGBDC7HB6OeEIdaM9MxovlmONrR64ETjhMd45rStd
 ikbw46cmAL3nv2A7Kp8auA3Ty62suXQEvpLbDnRZ/jay+OOLtOmS2conFy88AYQm2vqu
 s6PiL9otzLVO6+WCCatdCTFqjguH2Qs5DR+/6O26ZBnneRSHlcYg/vbxWrr1a7/GSzlq
 IgybGfC2OUvTFuWMEF+2q7g1926IMDquCUCOWcolk0DHdOGlkwh/yhcAv/S9qClCru0P
 XDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813709; x=1776418509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tgPiHrh218C+70LI8IfVK/IDQIbivXFNYVZM0TJalrw=;
 b=rb0NBWcCxNkX29W5nL9b78fPCU3sIlH0Cgqg5h1ilqoAGv+SJdg506wrQ17jgsbuYo
 pK9DXdLORMOprea9QoWmpzWqRQ7h+YyNMmZvM7hkV7zhKwEzqfKLOODg8UTbk3Erj/4X
 ZwyE0jx6W0ddBqi2j91YOr9Abg1Lgl3GQ9zpe6GxHT6oIq8xpuqEi+3hBdnrRTWEvXe2
 5uPkl5qJr5IBzrEyaeo5ZlLvUe74BDL89K/ZMriArM0DRn/LY5dM63LK/nIK/bXn9HQp
 5qeKXVZ16joOOLoGX2okLefcHuF5ecjYu7AUCodl6iokNBQ4Wa05ver7XkoNdzZe7xvz
 rrlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbSVUQW8VR0vBT5qYZT6C5MhUjytL2qFX68fCqxi6Ffa3QznKUprUSiGe5tbmdKVzFdsbZiuZbkHc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdLiUHfJ490MrMLAxSp47uajneVYy/Pk+rrwWWZmg+8diDlGc9
 tOO08x7gnmfUGmprE7jd4mpRcP7b1cS1KIHmBJHvKayOlEmDQq1gEk1QzlEjzPkl15XiAn8pneD
 01xg3iyKndUpD1OLM5TrkT7iWTCHVturVSb0umsFRENk96sQxnvMTIkwrjwdqKmaIniHb4/4=
X-Gm-Gg: AeBDiesOvRlkJQCWzq7rO0cdgKinVpoluUECIFsfZUEhZ8A5mBlUN0dKnJY1qr2jC/S
 po4y612eUxCATPhwuJqMBpbSP5Wzcst/MFN4TOPM547rH60S73xH08YAlfSeCG92NJ52RQC/Lu7
 7fsTcOejg6BK1uz6BzJgFTKKnmK/WP9aNjwrGJMMjG4orAz9u5cV2ejZSeKb0gHZRsIubxdGNZk
 m7ig+twDI8OUtBMDhZGyXvoM0efN9J8gcg6Aff5FveHHfGBcPjCfqqf9TX8UfxsiZkMrRBxJrIv
 gUTMI/WAQERqddLqjbJr6BahiiBzNGys/vuU957VxdmJ2YZCiDFkVaP+2UBNlpWzOG2veDAHqs1
 +SknPWlDwf9vUR7pd+99KYp4FNi8mjTihOu3wzzcM9+2nApSJgDqyVP/+mf0ZEJI5DPoX1PpXPY
 8hHxekxow=
X-Received: by 2002:a05:6214:2603:b0:89c:cf63:438e with SMTP id
 6a1803df08f44-8ac861a0f21mr32065626d6.14.1775813708409; 
 Fri, 10 Apr 2026 02:35:08 -0700 (PDT)
X-Received: by 2002:a05:6214:2603:b0:89c:cf63:438e with SMTP id
 6a1803df08f44-8ac861a0f21mr32065126d6.14.1775813707775; 
 Fri, 10 Apr 2026 02:35:07 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:35:07 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:50 +0800
Subject: [PATCH v4 15/39] drm/msm/dp: Add support for programming p1/p2/p3
 register blocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-msm-dp-mst-v4-15-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=13269;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=MOCjL1zm0UGvp3PTvJVzajVWQ2DVszPdta0rj5MJPMQ=;
 b=FuyO6ioRMH0q6faTAV3Lte+PDjYcPt71lyEUM5KOri/pHm3yrEQDwRlr8XR/NVJBXc5GEKPCB
 qUol2d+J1p8DRy7J9gIIaf2FEK5tJ9N8iEEAZM9XTH7lkK/ie1ecWIw
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: BTaMPsmLduCt7S6I8JXrb6HYMWDR-Yb6
X-Proofpoint-GUID: BTaMPsmLduCt7S6I8JXrb6HYMWDR-Yb6
X-Authority-Analysis: v=2.4 cv=Ko59H2WN c=1 sm=1 tr=0 ts=69d8c44d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=NUdAJ6xLEXsWjxoEJnsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX3INxVJHdRTAf
 s+tN48KACA6PENykdcA558ETMtGl8WQL4q8qxOz/sUxrjTbqRK1hVeqodSHjidNZoS5Bwxd7iif
 53S2o0Bkr9I3wllOQB/Ow3IUb/C/X9JLhfzlAGJ+xJVWvx5MZHlyga0KGgntCvhpbB7zRMZu2Ic
 Kg7Br5Pes1g5DKvM5NZvo2zumajINl+Ic/FsZST3dFRAMeP5s67iR0Fq6HqxMWXhqpOro7NLeGa
 nTlxMHJqeJrWB43UXcfb9bSdFJwuDuwTuRPTwVal2xhedP4X5rC2ON18Mu10ps7LWJsY2BN+nly
 IG+aY8gvxrAHLPwCk3WX8nFPtM5PMjjdHqRN1MXgHgR5zgOSmwwJ/y2xF6t2KcJWIfvJgSQ0qh2
 q8DjJWQwZqEVhZjdPJuB1YyQw2MxiMHkR4UAu/diZkOITBwgADHTBpPMKL2apGQ/hLE4n6YSwKT
 lQNouCHfobheAfbdj1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100088
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
 drivers/gpu/drm/msm/dp/dp_display.c | 40 ++++++++++++-----
 drivers/gpu/drm/msm/dp/dp_panel.c   | 89 ++++++++++++++++++++-----------------
 drivers/gpu/drm/msm/dp/dp_panel.h   |  3 +-
 3 files changed, 79 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7984a0f9e938..ff506064a3fa 100644
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
@@ -561,7 +561,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		goto error_link;
 	}
 
-	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->p0_base);
+	dp->panel = msm_dp_panel_get(dev, dp->aux, dp->link, dp->link_base, dp->pixel_base[0]);
 	if (IS_ERR(dp->panel)) {
 		rc = PTR_ERR(dp->panel);
 		DRM_ERROR("failed to initialize panel, rc = %d\n", rc);
@@ -769,6 +769,7 @@ int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display,
 	}
 
 	panel->stream_id = stream_id;
+	msm_dp_panel_set_pixel_base(panel, dp->pixel_base[stream_id]);
 
 	return rc;
 }
@@ -882,8 +883,14 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
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
@@ -1163,6 +1170,7 @@ static void __iomem *msm_dp_ioremap(struct platform_device *pdev, int idx, size_
 static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 {
 	struct platform_device *pdev = display->msm_dp_display.pdev;
+	int i;
 
 	display->ahb_base = msm_dp_ioremap(pdev, 0, &display->ahb_len);
 	if (IS_ERR(display->ahb_base))
@@ -1192,8 +1200,8 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 		display->aux_len = DP_DEFAULT_AUX_SIZE;
 		display->link_base = display->ahb_base + DP_DEFAULT_LINK_OFFSET;
 		display->link_len = DP_DEFAULT_LINK_SIZE;
-		display->p0_base = display->ahb_base + DP_DEFAULT_P0_OFFSET;
-		display->p0_len = DP_DEFAULT_P0_SIZE;
+		display->pixel_base[0] = display->ahb_base + DP_DEFAULT_P0_OFFSET;
+		display->pixel_len = DP_DEFAULT_P0_SIZE;
 
 		return 0;
 	}
@@ -1204,10 +1212,20 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
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
+	for (i = DP_STREAM_1; i < display->max_stream; i++) {
+		/* pixels clk reg index start from 3*/
+		display->pixel_base[i] = msm_dp_ioremap(pdev, i + 3, &display->pixel_len);
+		if (IS_ERR(display->pixel_base[i])) {
+			DRM_DEBUG_DP("unable to remap p%d region: %pe\n", i,
+				     display->pixel_base[i]);
+			break;
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index bde4a772d22c..c17b87353d1a 100644
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
@@ -647,6 +647,13 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 	return 0;
 }
 
+void msm_dp_panel_set_pixel_base(struct msm_dp_panel *msm_dp_panel, void __iomem *pixel_base)
+{
+	struct msm_dp_panel_private *panel =
+		container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
+	panel->pixel_base = pixel_base;
+}
+
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel)
 {
 	struct drm_display_mode *drm_mode;
@@ -689,7 +696,7 @@ int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel)
 struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
-			      void __iomem *p0_base)
+			      void __iomem *pixel_base)
 {
 	struct msm_dp_panel_private *panel;
 	struct msm_dp_panel *msm_dp_panel;
@@ -707,7 +714,7 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
 	panel->aux = aux;
 	panel->link = link;
 	panel->link_base = link_base;
-	panel->p0_base = p0_base;
+	panel->pixel_base = pixel_base;
 
 	msm_dp_panel = &panel->msm_dp_panel;
 	msm_dp_panel->max_bw_code = DP_LINK_BW_8_1;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 21f7f30e6dfd..fe4ac3e47e17 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -66,6 +66,7 @@ void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel,
 void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable);
 
 void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
+void msm_dp_panel_set_pixel_base(struct msm_dp_panel *msm_dp_panel, void __iomem *pixel_base);
 
 void msm_dp_panel_enable_vsc_sdp(struct msm_dp_panel *msm_dp_panel, struct dp_sdp *vsc_sdp);
 void msm_dp_panel_disable_vsc_sdp(struct msm_dp_panel *msm_dp_panel);
@@ -100,5 +101,5 @@ static inline bool is_lane_count_valid(u32 lane_count)
 struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux,
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
-			      void __iomem *p0_base);
+			      void __iomem *pixel_base);
 #endif /* _DP_PANEL_H_ */

-- 
2.43.0

