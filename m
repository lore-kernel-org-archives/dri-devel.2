Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ACFC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:00:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B4C510E7EB;
	Mon,  7 Sep 2026 13:00:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="larfk0Wl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fJ6ziPkc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7486110E7E8
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:00:38 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687AvMcc496196
 for <dri-devel@lists.freedesktop.org>; Mon, 7 Sep 2026 13:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=; b=larfk0WlpEup5H3m
 Ee/0P6ULDeJf8uBNe18+jf18aEKhu9xGfIFxIttialr25DSZEavIL/551vZ+uQaC
 OwZkD8yPg4ifSq+CuBuLFWbu4ShJZJL0YErS8nT3JsBzyo+uJppopbv16l8ZdCfx
 d1X2nHP3uiglbrC09FSelq8LJEHPGUEFbl6oMDgZ7PpJDOpie9rBIA+p6W3LoPo7
 ptfIvNap0Ql4lPEzqHzptAWl988S07yxFFTTLxvyiI8yX1sk0NIKQZucN2ttjHKn
 PAMYo9Lgmt/bu6poZlLRhwWd/MRH8IvLEW8yiea2kA+wp9C1ziZKcrxoyOiEhXFM
 JVWMsA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghuyk8d6c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 13:00:37 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-744e7890eceso367178137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788786037; x=1789390837;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
 b=fJ6ziPkcQ2UHTNlPFSm/boODiDRejZgwNIxPe1t3T7bEk0UI58YXcZ7ni8ANsmcAi6
 Vkr84/Yz8Hm9UpzryI96v3Om/sLWDlSuEhdSFefrupM53OB4zxjMsZ8g/OBEpSHP1ol/
 sOMQ4PfjV3RH2ZfX6DYp28TiZ7XPh+FGbv7KMUs/H0YN+rusl51rEo6FMMczOFZzK+TW
 nR6624EirTBejVLPp5gU2aC2FDzGSO4UwezFtvtU6qkqwc1tDg2zET1AIRAZWqFYYYqB
 5Yismr1tCk+TsxZ/1Ds+QpkM+xgOotgMXP02B0zoL47VUnwQigzbWmmFCuoCnb7XsxJ/
 PcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786037; x=1789390837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
 b=TeuIqQwHnWRu67WPaHSByJR9tJqlHGbO8iwF3jt8ang1IyLtrRyEiDPErJ9x7JcNL+
 rCXR0R45a/RsAfREqvkMuvsOBs6+/sv9Of9RnuVvnVeYxAi2KfQbaemupqKLQR5Ipt0r
 IQyJFnbINjsO/jOozjHFmLB6ZdcwV9YKIg4zwrt2xfF6eAu6J8FUzGS4NuBPGnIQXAMi
 c0+iwuAgQMGoA5d6kLw5gVkGZqdAGIaZFY63iyauuwIktsRbiAEWIG0H4kmspZXz7BDh
 FI+42CPbqpUuVSY7MubAcP9lm9QAEC6KpU/Ao3a9cKgN7W2fqdw/QBKiMjwAl6xt82ES
 NE6g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZez4c53ARyMQzCDWoKH9i/i+4MCacAuC0Akly0vBSQMkFSD+T3yOruIv7yOAyeazGsyuLc/Ckczs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kvvZlUmAlArePv4YCcxc6c4X4FA0CKQEE357MNrC6pxudXl0LV
 Rji5rBb+Ggsie2T7bRoazngK/K2CroTt0etRz5UvHGA3O+9z/UFMqSVwZ4qzTIkYqTaM0d626h8
 IdhnPboXYtQvVu7qyo8IXvRJ8ltJBJEIOJVqAopZ5mM6ji3FcbpEL7fg70RduAEnROr1ZlsA=
X-Gm-Gg: AYBFou3EIIB19UM5R1PAAiKPZIy3IKwCLIDgmuu2qx7dZBoh5eOMUHP7wjqte8NTMyp
 woVM4Tlm1/0DwNcn3fxKAy0GzXECs9fboiU9xihEPv3gbmkUNyYeS7crAmOzr02LZId83SuYOiw
 afmmT7kkIxjrRuZxvRoxrKQ9kQK29Q/qet8qhFwXq1Yp2sq2RmWB3+pgUp/v/hTuw5jy5T7SecF
 dxPXxwbKUcZoEVXVzXEapLMW4eWXk1FfHXRcW+IFcQi+ESVYq3p3PCJ8XNJhqgrEBZHp7a/qh9j
 S3X+BSeYB1UQZccLAzXVqqgUK+LglE65uAcnBTFWTAauRHOuOOo7eZHJ1/tTFKgJk/LYbfupabS
 8j7L5vqzMd57LbR3JFkPfmcc=
X-Received: by 2002:a05:6102:5091:b0:78a:8a0:7126 with SMTP id
 ada2fe7eead31-78a4aa97d5bmr6957328137.10.1788786036762; 
 Mon, 07 Sep 2026 06:00:36 -0700 (PDT)
X-Received: by 2002:a05:6102:5091:b0:78a:8a0:7126 with SMTP id
 ada2fe7eead31-78a4aa97d5bmr6957293137.10.1788786036018; 
 Mon, 07 Sep 2026 06:00:36 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cff81c9b5sm198751205e9.4.2026.09.07.06.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:00:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Mon, 07 Sep 2026 15:00:16 +0200
Subject: [PATCH v2 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-2-b097cf1eac77@oss.qualcomm.com>
References: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
In-Reply-To: <20260907-drm-msm-hdmi-fixes-before-eliza-v2-0-b097cf1eac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2516;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gCPjQLee8IZ6ZI1o3PKvV9FFsQQqDDwLDIvAlHVSnmc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqnrVl5qXohDCURU+NBjhbzxqePcwXPR42atlwW
 MKZXfnzXIqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap61ZQAKCRDBN2bmhouD
 13MLD/499ImyZNhv8KqXl37bfiQdgVu9Me30Y0fF1ckmJODd9Kkx2yUhO9VjmaeT7PgdxTDZzxu
 flb9jXTKAnkw0NGD1hd42UsH1Qkh1qJ6oD9EyqdPFwt2U/jhZFYCrA4O6GQiqAgjrgtHKOxx/HX
 f4QQ/+6h4ALMYtMDlSboskVDJy/L3QNA/hVVqhhp6qv+6Uoo932d8kCe88jVAbvrtxRfls/nO7z
 oR/mIRFUIJ9ly1p/4DTJgWgWADs/cIQAw5uBUszxsg+jvJkK9quTp7cJ7a5nXqoehBajDaj+SpI
 HMQKNWX7WfkQoMyUNGRmt71fAOvRb9xbfU9YUnhg7MpH1KANwJWU6XlKzhKnKFs92lz+Tky7MYz
 wjI9BTQ30YdhpON4qjuotYrA1JMnmobv4lpY4ODuTqxndsik8+AYPtMRB/q8R6xTHvhHbhM0cim
 UnnvfML8SJdnU1nkbl8KKH69Xj9FxIy5ztYtzng8ys7YQfXZ0hxtMKw747WPyGPdrI9JwYr1zDa
 hbhVIiTLQ6DitBSoGJRCXcU8up8kDjabFU/OpK4vAt8M6DkjH8/w9mYhT7dnGbX3a0gsqAqvxXm
 qJL3p/bK1iZivrvdLFe6O1r5cwRor9QBOxn2kF2DCx/hA2vjSDDYRKBOPDoyiLo3I7IsJSOYWEb
 QgNRexijnPWjaaA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfX7n+nihrtMRR+
 mEV7h7dcvieI9oANoCmT4VF/eMo3Lw5AJ4T6LZw1iYGd8WkgGb7HP7vNkSxNm94VmFXi4kxYIsL
 bCNNf/EeaeT3MRwgRNDbx8k6u1oO9bc=
X-Proofpoint-GUID: mD-GY-NzGM7k2epPiQoAMSBGJzBSyaYh
X-Authority-Analysis: v=2.4 cv=ObSoyBTY c=1 sm=1 tr=0 ts=6a9eb575 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IzbfGf_HrtPdoiX6LZ8A:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: mD-GY-NzGM7k2epPiQoAMSBGJzBSyaYh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE0MyBTYWx0ZWRfXx73XZTeT5Ki6
 B/CVdYkpUNXy1EQAwxvrrrkdSHgJDtBkiqZROX4H7hPJuHiGhtj0xnm5cs7dPiCboZ3ZCq7/7cR
 +vGJoC5yw/PNZeCtqWkIRFedZm0S7Zr63kaaS9kFgb2XYjJKC+0KLCdO6UY8+yhfC5SVQmBAx9O
 LM/4YMpHrOgjRLaJP034h5bVINiuJHH57xcx5XLhJSPboQ2cWONTYJcy+zZV9CMva5izEeG89tl
 DpXZHxhwAD0m/Su1hcX72uzsI28CMYD9EvRwwo+VtBP57l3CMzdrQnk7rOfVHfFsLIhCq40k57Z
 F2cDUSoP3zOnpM2dWOdJksZODtvK9oI5FRFkoqQo8aWADjhnACCCQr5z01ZnEgnYXpiKDHyGYB+
 h6qTDQoR4JAi1/sxrV5V1nEeesjqU7BrJ7c2lMIjLz3RN4V4D1yDTcG/RB/8sg0NsqRstiiyykJ
 JoODGraBUE2X64p0lbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070143
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

Properly handle power up failures during .atomic_pre_enable() by
aborting the .atomic_pre_enable() to avoid accessing registers why
blocks did not bring up.  Otherwise this could lead to imprecise aborts
when accessing MMIO while entire power domain is off.

Cc: <stable@vger.kernel.org>
Fixes: ba3d7bf3a7ab ("drm/msm/hdmi: Convert PHY files according to new design")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index 157f19bd90b4..db85400e574e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -13,14 +13,16 @@
 #include "msm_kms.h"
 #include "hdmi.h"
 
-static void msm_hdmi_power_on(struct drm_bridge *bridge)
+static int msm_hdmi_power_on(struct drm_bridge *bridge)
 {
 	struct drm_device *dev = bridge->dev;
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 	int ret;
 
-	pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	ret = pm_runtime_resume_and_get(&hdmi->pdev->dev);
+	if (ret)
+		return ret;
 
 	if (hdmi->extp_clk) {
 		DBG("pixclock: %lu", hdmi->pixclock);
@@ -29,9 +31,14 @@ static void msm_hdmi_power_on(struct drm_bridge *bridge)
 			DRM_DEV_ERROR(dev->dev, "failed to set extp clk rate: %d\n", ret);
 
 		ret = clk_prepare_enable(hdmi->extp_clk);
-		if (ret)
+		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable extp clk: %d\n", ret);
+			pm_runtime_put(&hdmi->pdev->dev);
+			return ret;
+		}
 	}
+
+	return 0;
 }
 
 static void power_off(struct drm_bridge *bridge)
@@ -287,13 +294,18 @@ static void msm_hdmi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 
 	msm_hdmi_set_timings(hdmi, &crtc_state->adjusted_mode);
 
-	mutex_lock(&hdmi->state_mutex);
-	if (!hdmi->power_on) {
-		msm_hdmi_phy_resource_enable(phy);
-		msm_hdmi_power_on(bridge);
-		hdmi->power_on = true;
+	scoped_guard(mutex, &hdmi->state_mutex) {
+		if (!hdmi->power_on) {
+			if (msm_hdmi_phy_resource_enable(phy))
+				return;
+
+			if (msm_hdmi_power_on(bridge)) {
+				msm_hdmi_phy_resource_disable(phy);
+				return;
+			}
+			hdmi->power_on = true;
+		}
 	}
-	mutex_unlock(&hdmi->state_mutex);
 
 	if (connector->display_info.is_hdmi)
 		msm_hdmi_audio_update(hdmi);

-- 
2.53.0

