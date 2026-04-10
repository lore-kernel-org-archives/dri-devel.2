Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C26E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E614410E910;
	Fri, 10 Apr 2026 09:34:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VoCuc0cm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ojuc0oCO";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AF3710E90B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:54 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5oLZx1925369
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LIVCULP6f3HK/Zo4P8FgktdYCIL1UYcA7HDOut07rlw=; b=VoCuc0cmmAoDgzIQ
 hOY+RdxocBZih2ODnLxXUZMezH2C+qMLKWnj1mLY3qPYzp44NgI2RcJdFe1hdjpu
 wOguQJgdPag8EAqZQv4KFJ8i/I2cuTS4/vM2qRwxUIgI6eqX8cg8YqQLoP8Dyifo
 tQtQ1KYPRP2GJtaqQxO8atSl60O6Ogp7Rdper0BdtSuh0KFEcRMF35yaYpwiJJRX
 L5poJXb0uGw0Uv7yiSJajuioID8uG5fYi60XE3COuCIHc+EtXWgmxc8w3NjESmrJ
 533t926kzc6nx+AU+C6n5dfeGC1c4B0R8bsYgCiHne3boHOrFMakB4JkanJYB3q9
 sFTm9Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deudjrt4b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:53 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8a3bc7f5d43so54878376d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813693; x=1776418493;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LIVCULP6f3HK/Zo4P8FgktdYCIL1UYcA7HDOut07rlw=;
 b=Ojuc0oCO5+BoNO5XA8jGQndeM9WXMDRJM3McTgk/Hc00vlCgeH1jA0/9DgyOka7TOo
 eEJnz9TtXbOC71GnjEMaoAHKshAsRTH+NDsEU3WYMhDmSdV1Ek9p2JHnihMnaYbr3tlF
 NIT6/VeUGmoxVbuWZq0p2allzheemIBPb807hGNvKgng3kfpljrfxV19zZJkM7D++DVM
 6NWzGTPafSgnJhm5GlwLmavJPKZSdLOdojip7aAyzwJVR53T9kbKfhVH572Y09S7onsP
 s9uLqYtqbnCRIbM32/G6IroSKhd4NkyFGb2CyH8MHltUiqEs+kCr772Kt3xr4gAeJkAH
 7SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813693; x=1776418493;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LIVCULP6f3HK/Zo4P8FgktdYCIL1UYcA7HDOut07rlw=;
 b=XVJFcr6V5Da1Zcv4F9Mpb/xz/M4OjD2vEKWvZw0/+KDyc8EthucEP8NzdGfNilbild
 DuGrQBt/LApjX3ntXHUBWgDqP8lRYJ0l/qMA+ksIt0dcdqBwV1O0M8vGdmykY8U+XbuK
 6bvsbFKXyuH6tJ93HhhnjRJx7y/VR1dsB1cFTWt8GlstRFzyBjPcHX9P5yVuslY6dPgd
 2PSMR2vFAomKtjZfrQW3kiZ/JHw6WUQ89ozFmSi5+fDftQIdw2kK8spKLqHigCDbb17F
 kjwNTVxsXwrY6r0rmQiFVceUT36jMw8XCw1GP067yeeJ8SKZbSwCfRR6riLGWf5pi7bo
 o44g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/3j84tAeLyUYKhMmgZU3Vzx8+OdE5peQJycguK9RXtfuZOSONbSqUgBucD4isxIvTybl/8RJOQmI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJACqZ159Y6OXHKgC7OH4IkZcnaV7kydL7pyvBk2nqEL9MeJR7
 l0JKqknzlgNNmFgme9y9hART1EmiMJxhlOuVTRAQPQyDigQoEbzw5xIU3wEvwbW28ycA4X/hoJd
 KHCazI4gSUu+89gd1fU2IwyUs4IRkDfxwa6suyTQh3bB0xxsUIhn+mVhWIA/YbNQkAdRCJJc=
X-Gm-Gg: AeBDievTeV+KdwIsMP6xPIYwfvNolBKJj+eUPZ6GARkuaU93u5oKZtJflnbxGH85Qt8
 1DZkPh8nEzjWjQ6ysVvcAtbYZ7rDmJGgrYCfC2EvlP+fxpmKLamjNwgE8fESKNbMaf9YvFQlugQ
 +Uk4mvMHlTywWvci3d1PBDXq+wEz1sZNB/TxlNhI8sgL+wzZMKbyuky6djx2W5OT12zmFsY9P9U
 NCUt4fUaHp6U62yvOi2tuSoYwHrap/5N8S22CAS9Em2+wUiK1MIYUasP+n+MsjHAzj9ZtokP/b9
 3d30JnMB7shtAiSMWFd2g4SClMvOtSlWJ4XoqPVhXTSoGh5pcuxQDNDgeJuo6ehxCaVNLwzAKSO
 fq6J1viADd9qpFDNV02924m/yGnv5yJZNk2H1cCjMuPT5lCIdLJfh9uu5TByR+v0IcuYyh8M5gs
 1gjyf2Okg=
X-Received: by 2002:a05:6214:3285:b0:89a:622e:d32c with SMTP id
 6a1803df08f44-8ac8629b69dmr35344396d6.36.1775813692964; 
 Fri, 10 Apr 2026 02:34:52 -0700 (PDT)
X-Received: by 2002:a05:6214:3285:b0:89a:622e:d32c with SMTP id
 6a1803df08f44-8ac8629b69dmr35343926d6.36.1775813692507; 
 Fri, 10 Apr 2026 02:34:52 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:52 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:47 +0800
Subject: [PATCH v4 12/39] drm/msm/dp: separate dp_display_prepare() into
 its own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-12-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=3667;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=pkwt26S0f/FIReOg+I0P7xE0FOpdJns1n/b9bgzHXMI=;
 b=PJluU1DTZxt5z8FFbdPGJBxUuq3FcsxLc9wLsJPSWazZ2Jtrz1t7Z4BcwcAgE2nRWp4ABaJXi
 QoJh4NbQkuIDt7fOEupyYlaG/B7Hzn1L6d+9ZlRx7J1ujyz78Plz3l9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=X+hi7mTe c=1 sm=1 tr=0 ts=69d8c43d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rHTcTV9uYuKpyGuOXCsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zoCR5uI6xZfGp9TUlZURHeUIzjd_SGfq
X-Proofpoint-ORIG-GUID: zoCR5uI6xZfGp9TUlZURHeUIzjd_SGfq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfXw4y+FPO12CqS
 1d/9Ia+qtQds20+YV2mD/I9286XlTgcB6uLPGGVge3GYs8Ms/WIcBzrGhgfUeihunOWqVoovyd9
 Jh9dkrXNfaIhN6QTizHgVkAD2OvcX8ok15PYUYLMx64JMQXyig+QgFVEDyfq3gjNlHDcjNWMnrl
 VT9sVPlrJO18x9fZwle7UvLcRaS667IRoMZBIqZco1Byi5ykHrYD4PYrnK/4Bmy3XSVB3XXUV7/
 XyzXon/sbGSeYyIvJAs0Osjtj6eKsyIoTFmlhRTudkIuMToIoVGeu8cUpIRm7SS4HlWGqQcbkVu
 G6XYKC9AUcZxQk2zieyhOCkEG8NMZBvyvlMMNOQIssErH5oe/baOKjeyIGmjIUsC/h9dobV8iCI
 HCKP8H0NzJcDe/29t1B6Cg4HycMShFZa9JID4s/SAzac9qkeTh0RYhRcHzZpWVE4FMqQltHl6ap
 w8mjTyOWt6lt/6Hq1+g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100088
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

For MST, the link setup should only be done once when multiple sinks are
enabled, while stream setup may run multiple times for each sink. Split
the link-related preparation out of msm_dp_display_atomic_enable() so it
can be called separately before the per-stream enable path.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 16 +++++++++++-----
 drivers/gpu/drm/msm/dp/dp_display.h |  5 +++--
 drivers/gpu/drm/msm/dp/dp_drm.c     |  6 ++++--
 3 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c7dc861301de..32ad00e326ba 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1417,8 +1417,8 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
-				  struct drm_atomic_state *state)
+void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_state *state)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
@@ -1440,10 +1440,16 @@ void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
 	}
 
 	rc = msm_dp_display_prepare(dp);
-	if (rc) {
+	if (rc)
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
-		return;
-	}
+}
+
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+	int rc = 0;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	rc = msm_dp_display_enable(dp);
 	if (rc)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 1a697fb305a7..295da7ae0047 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -35,8 +35,9 @@ void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);
 void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *dentry, bool is_edp);
 void msm_dp_display_atomic_post_disable(struct msm_dp *dp_display);
 void msm_dp_display_atomic_disable(struct msm_dp *dp_display);
-void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
-				  struct drm_atomic_state *state);
+void msm_dp_display_atomic_prepare(struct msm_dp *dp_display,
+				   struct drm_atomic_state *state);
+void msm_dp_display_atomic_enable(struct msm_dp *dp_display);
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index cb54d7e71f8e..0feb757e2db9 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -55,7 +55,8 @@ static void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
 	struct msm_dp *dp = dp_bridge->msm_dp_display;
 
-	msm_dp_display_atomic_enable(dp, state);
+	msm_dp_display_atomic_prepare(dp, state);
+	msm_dp_display_atomic_enable(dp);
 }
 
 static void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
@@ -152,7 +153,8 @@ static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
-	msm_dp_display_atomic_enable(dp, state);
+	msm_dp_display_atomic_prepare(dp, state);
+	msm_dp_display_atomic_enable(dp);
 }
 
 static void msm_edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,

-- 
2.43.0

