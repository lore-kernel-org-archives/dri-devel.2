Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416F9C88E4D
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 10:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D495410EA17;
	Fri, 11 Sep 2026 10:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJ7JxI8d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IlQUmFO7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C4B810E9C3
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68B7kfCC3844952
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=; b=DJ7JxI8d/CYTDOCk
 h3XPeU/Vt9kTF0Ban3/fyGI8v+8G3Ee99q4z4RXS0tKm3WnjI0dzL8fUL/ywhviu
 ceS8k8+WpGiC3/TrOHnI6w6HAztiA1kBTFarjVYYW1HjGsMG6eAvg30r8TLwZDjv
 8DC9KkWrsExoIaZsmM5bmhwmMO8nqr3JJwW6kjlvhV7P6cicnQvfAfONQlfTBaYG
 qV8FZAgSecDP/M2XUJy4CQg2Xu5cDHxxJ6yJKVQxBN5DOrrpDKmWb1I0iHrFS/jh
 Nv19OELvmyYg9z/hrtFHX3zyVu6MO5p0ouzwNOEe+b5Q2tXWuSh32KSxP9b5aDgs
 uQ+UlA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm5q42dsn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 10:29:52 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-934956beec8so130140885a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 03:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789122592; x=1789727392;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
 b=IlQUmFO7XegUeUYT9B994HY5AXIS5D0Txw9YAtFpQUHpYi0cDtCMbSY0KhEyPdtVSj
 khIQHnBRL1TUhoKOaosRWHcNRaZnAJm7fo6e7tfTwY6Jdvg9ys/Vb9Rb+PNKn8URkMC1
 6E8Rz1O1eS9NlkjYB67sM5nj/sJKkpyrNn7uPgH4y1jn59n0vPVOQTX3aXgvIbKuQzwk
 c6rT/PKZwSUrBQR66n6t5PP0CsYNQpNE+1Mvx+iRCjGPEAAuVNoMzMjMcagJKgwrKAKP
 PDjzZnBjgQlR/VmZYcHd1Ve1O2TqkCCiIxsRJpD+HnMdKdfzNi0dQucuwCMJUKSg1ssy
 KRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789122592; x=1789727392;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
 b=Cg60gpQ3m5cWH5YeK6DBEJrQwbEXJdltAiTNbLP8rd2QqjhZH49f5viF61Mjc3DmBr
 j8KrNlPuDxPQXD6B1bWCdZh1NyDe/az5DbJQkmOmlQdSZOuRpN5oG2hv2WgNZmdKG4N7
 kasTaqQesCUM40dqIBN3ZmnX7HhU6Ere+8oHLVC2KQndzG14OBhxXrNCLM0vy64Im0l/
 M2BDy628ZYyEmac0YK6PRQ7Gl7iaxh3g6sw+IVklSS0ZjH/nJEgGkA3w5RyTfJj+94hI
 04ZOY5Ov3YobvVv7oAZR13puoo2n1pXrO47yhef1XyZz3nU5BVdtWdqBm6VDPkgqTggu
 3ZHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbL/3vras8+8XVq1N3yKSDQ7rkBHxhUS/4uQxYzUhVBR+JQ36facxSRF0hVl1uR6ut3A5PP+r0O74=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kpigS0sYNlNEbp4K2RAp88KyJqQjv9XPOXG9YIX5xugwuYfjEc
 ZBGA43CSPSE2tihrENYmX+kJthlnAuggWFzx9GLlROqAWBvfs8TjWS5qcGQsIMwgnCHxl+glLFi
 L/AcVGfqeG3/6Ij516/9eT0xVL+/skjQpfmO/huO1zwB8Yg08LMNUw7fXT/haF5HcTHItsgv3K8
 Rc7Fg=
X-Gm-Gg: AYBFou3Xal2GvOU6zK5MMsKieSi0WJuhGbMhzR3ae8IHBHwoUtQkvFbPfzvUEGL4v85
 kYX58aVt04+KzYoon/h+suuYnD02z3yDHRZnL0BvW+pLhFD4VL33w/Fcu3ehgq0FpxAcjVr7NDI
 D19t6mpcAJMJ6Woq9kt6G9tQjNmyhmZJTvT5/HzXdmuAHIcQ7vtaijxiDcFavaJI1Vy0/JfYRu1
 u2iQSx4Y0wUxc5Ra3cV3mBvBFafzmKQ1rFYlMH5yynIvfrAsFPmn/pVCjHT619FT7GUYKs1PDh2
 x5/OY5vpf4c+A/fqlW3YYz0aQ7Q3nNVDJztwtRKaHPeFidA+5gR4YCjU84kZrtbde9bVm5ebT2Z
 fQnVeWe5SsxKYvBckeP48EFA=
X-Received: by 2002:a05:620a:17a8:b0:939:9a09:6009 with SMTP id
 af79cd13be357-939ea22929amr417773885a.33.1789122592215; 
 Fri, 11 Sep 2026 03:29:52 -0700 (PDT)
X-Received: by 2002:a05:620a:17a8:b0:939:9a09:6009 with SMTP id
 af79cd13be357-939ea22929amr417771685a.33.1789122591779; 
 Fri, 11 Sep 2026 03:29:51 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm38651965e9.1.2026.09.11.03.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 03:29:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 11 Sep 2026 12:29:35 +0200
Subject: [PATCH v4 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqo9gRkXjI/OEtozReZDeGIxNSRVYnBNLuVDYf2
 /ZVngtGyFeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaqPYEQAKCRDBN2bmhouD
 16cRD/sG7tWVhlh4K+dM3uTjagd7MjwoUd5+LK3+h748V4YfkAkWQ1KjKU0zdiH149YAjT5unRr
 d276FHxWWUtKrbYBnYO6VgdTVxNpLtJgIQ7z6XxkC0L63AgIwRcbybPe9JmZCxAe0iKa010yYUO
 R2HqvL3s93pOmGYGJpTS0Mprn7vXJW6MOMaeEG3hMjo9QIV7+2q+ghbzHFt8C0Xrf6UqpqX57ev
 e/GTTTWuSw5yxLDp6T1/CKjGdIByxbbli8F3yGkr13Cd7uEJGavLV78Tn8pLIU9jXpFxNZNyg5X
 any0DeWtC6WMNi+pUaHvAV1HDPMW35bwN7tNWEhVVw//mZrSjyo4aFRZ2ppTmt9eZQCG2yqf39G
 fttE5Mhlg/bTuQSMMFkJsJR09QhXkFYm9AAU9HItikZxropRdK9CG30pisSAIpJWJGAi/ZAoUl/
 CyVEvpvjOIJUZySzFdGdptEpCQUYdeASISLYjgbG0iydLDAjMLc0x1uW5qhLVPg2TMQHE+0ccVX
 opoRAbJw2ykVwTOpf01GE8HJWA6WwAfyg1+mTfnZjWmYIOUgjxtzk/aLFnEozHTB2beRJIdEsAP
 L0W/XGgb9kYUpha1Lg6al1zfrJILjxyhvLOA4dG8LQVrS6EaSJgiXt4hLMlVu5HXVilf98cIWFS
 hDCRNBJPVxaMpZA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-GUID: ieCov9sd_FlBSlxS8Ig_m19Cn2zb8320
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfXzKW8EDnWerCW
 LQwCZTPvAyji88WHxcfnTgkleTQFXnV9LBjhQWlcg0tDtgioAW0g0GAwSnAPjGeM2SwDKkhZnx4
 98Mfkystr5W0DpBpF7RhKL0oXIhy9Bk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE0NiBTYWx0ZWRfX5werZzaUsex9
 tssNtYiw7xjSG9Wl+JBncoNTwT0g59zILBQOoqtwlUDt+ebbH4GfhRbUu0u1RGieUZZXukvDEmL
 DI0VY2x+H1Z8NM02d7CCRozSBJ6+zyDvSAK/PfExVQcDhqd4u48TadNXnpaAQqLjPfZqJawQTey
 t2lLd+8KOvcUpZAQtfs6bKYTjpN3sYG80R1e/63QuOG2rcOFqdgFiLxblDG2GN2ox023QV8icbM
 ALCncekcLR0PF76UHmHk0HAcAZx7e2n7orlNUIKmyActQC6CKhAJMYe8HThPvRMK/EpB8ghq7+H
 /eP37sSdlgXyQ+w6uWG3a3U+piGTc50ugQM4Ar5x71Uqp+aUKt19BgIfEPUr8d7Nb7sAkb7XCQJ
 ABpJ0CGR8/dE19cWX0b+Lq0/xoZeU+jLizgm5ZWKIAGACAyL/mTATBe3QFyoPufO890to5HhwhW
 DvMggB/F4GkqegL8c+g==
X-Proofpoint-ORIG-GUID: ieCov9sd_FlBSlxS8Ig_m19Cn2zb8320
X-Authority-Analysis: v=2.4 cv=Wsa+otfv c=1 sm=1 tr=0 ts=6aa3d820 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IzbfGf_HrtPdoiX6LZ8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609110146
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

