Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D66ACC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB2210EA61;
	Tue,  8 Sep 2026 07:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ae/v62/I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CUZbQplU";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0263910EA66
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:11:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LrIF2154198
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=; b=ae/v62/Ia/7o/ONV
 uPTVJrnFMxE2KJ1Y4nwTly7EVJi2ddlRmjJ+rtVX0UdVmn4K441X+MOAVw6c8uyF
 kpneSqlrNGKJ6z0+41PpLx2ejHkBdH5C3//E/k279cH1lUUIWDC7STcDh1GLtJkb
 jxfUk1krGFylMz0Lnr4FSMttLzGSoX5T0p6n0WfmMcxgtv99T8Yds6xlBRsuvILb
 gga6sq60qiAFoPR5wOo1HO09nx7N/z12inrNYUsZf4zGkqRjW++/ZB95wo+hqdwT
 vN2sJ5MgqSKto+whf3EA3/xf7hcXLDHHtQKEVbK2XcPjZYvMwEj5VHr9FbXbl8o9
 vNv81A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gj1rwj5uu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:11:01 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-936e393061dso552704885a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788851461; x=1789456261;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
 b=CUZbQplUlJoJZQu42MZkXViWau0R072FLF/3UugAfyrW4Ugz+nPUDu3Uys3yE1RqaR
 57v2y1itL6qgvP00hqujL+5KCJI7gnE0HvHx/GbvddG85EskpVEh/Dd8RY1GgKXdXCjc
 +kVBluyHmSo79B/wLCF9xoJRE8WlBJLriVqT8uPd4lNp9ySFqc1Nl5jT3Q+Ji6IE+xew
 BSnvfHqX5UoT6Nuxw8n+1ioGjZ2wvTt6qVHI0Ixgy6mXY8Jzn5JeJ1vaYwczN9FNdB5G
 9+hKO6ogb1aUjj3UugJddO8rAYQzCDjtts/DVuh515fa1Czt4gy6wh6rPwX9GZOft2VN
 f4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788851461; x=1789456261;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HH0NlUkAHggOm55GmMCsiEP7bNk66V1yTa1Hyg0NTUI=;
 b=QCrI2amG1JckhrjJk370SeILxa7Qi/vSnCEBAd0026lGEKvRhoT4A9JBxDjkaYZ0cC
 gk8GESK2kn9GgAX7pLycPIcX3TPAR4RBjU0rvKe4NIoz5pPFe2081HK7imz13yejuyHA
 7FCBV2lxol8NEHmOkiDXkpIqekFtKSSo2tA8mMEeCXfwxYgSc7PgyWBfvrazXE25zSyn
 8xXtLzt5ES8/ATpqZDuYgsGC+M0YqKR8DYuQT+FSuD8hTEcC0B8fQWxMfVRsu6u7VlwZ
 RNQDnsIscSg6gfUeirxsWJxzKRVatXtxV4kHYf/RwqOi1tGgn4V9RYXIHHP8tI3akQs5
 wORQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/rho+keItGGYuc4mJM5U+HYkVeTee/KKcdIYOvCo3hvhX5ENriEGOiWbu+r1vJiJdKQN4hL+i+84=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nHSODxgr7FTHIwz36Grne3H5ONFgC23CGYhRL/PhaKhEQZkPgR
 N8U7WTnro31fr+8KjdLq4OBkDjsQpL81uI8/+8gfq5sk/WOAUWkAVilchLIfa7n34J2Ke3hNekw
 QunLPo+7fJ+7hzYFJmbPUHYb3OpIAwsiljxXNVtsUWT7Li1AJD3JynB9sGyplrtQyomSSn3o=
X-Gm-Gg: AYBFou08qRcf3fj9/9twPZHYo9a34+/XU74RSkytJAROEmPeIHBXbZdtq32sFiDSoSF
 5qjMPX5HLlgI6p3c+7HQXslEnjS4rvZn5f12XTSYfeDwmkOg0+v0RKcDdosNrS2I7ZWGSJJS56Z
 7N4qjDs3EN7D1mfW6qHXFM2bIGYPcmBx1ZLLX5ox0F0domFKo+QAR53IOArUI4loE7lHdiWWGmL
 FojuWyZ1+BmWh7wOyDyP1lXayL5Lwa/dyL6Lic/Z5l7ws9Ey1F731EdnYKbiORh5wbfW4B7BjiN
 O7TjTwNRR9orMiVgGmQs7ygKv+gZSxeh8HniMC+SJwsp8CWd+xPQ0lnVKOUWWOTxH2mCtG1Pwf5
 Ot2vTVr76l3SBEb/V1VS4aqM=
X-Received: by 2002:a05:620a:1998:b0:939:2940:6368 with SMTP id
 af79cd13be357-9398037189bmr2454041085a.19.1788851461249; 
 Tue, 08 Sep 2026 00:11:01 -0700 (PDT)
X-Received: by 2002:a05:620a:1998:b0:939:2940:6368 with SMTP id
 af79cd13be357-9398037189bmr2454035685a.19.1788851460804; 
 Tue, 08 Sep 2026 00:11:00 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce5927b68sm453173805e9.1.2026.09.08.00.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 00:10:59 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 08 Sep 2026 09:10:42 +0200
Subject: [PATCH v3 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-2-dcf8956878ca@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqn7T47t9PIoGOvtY3A4jGlgUHnqVJUTLHI1x0C
 PyFXomucWeJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCap+0+AAKCRDBN2bmhouD
 107ND/9wWvZWNvTtHTd/hKE/PbowEdSQof1zsPcrXjmwUH8OWj3bH1OjbaqDUNcULYAqqfb/r4l
 nUWbjdLAZ6SQHG3bXBueBsMpUu1jq7MMHUfseJj2CNNlgqDH+i7hNlXqXAYHTM6NlThoPOuWg/O
 qa1I+8NX+9dgncWQCQO9VL1DR4Do8TdX7M7uzJ+XqC6IPb9wygQw1P7OMY+0XhvY7GJRwDf76FN
 M0xqKxVyNJMOVJQkOJ2Dq1eSBVWM91sFSMDYnjVtef8tY5RwNweHiEFf2dK2sFAV2SQo+nXYu3e
 1te6/w8V52dr+Xf0SXg4ibI+/OEFMShpqrLYCh2/Anm4evONOc2HuNZOi0jeY0dpzCAm4LSSnNE
 ilWieia8LghXhGIXO5HAr+VCGzsmkKYJt2Q8seeuFkabnskt6H0IUD1XX9fWQL1lWDXsDl1SQEv
 CAuvaOBT76B7G39PFZ5jwQQk/Fry+AAJrRyPZfEH7VW8I8bYsplCOQZjYOLYEBcoH7I+3Kv49vz
 bE/HzBYaYOJCs9a3IohQnKLSCzkcy31sNhUzn8YDydxS8A7lr+14fO/dhtKSBRiF6s8jpG5vC+w
 USgHJ6OmNlmP4onu8C1WMoL0Xf0VdwvYHCuS2o/76Mf1sgU7hgFYMxQ2Ci/F0TWQdQy2HSJ0hxa
 3AcmKaInUP1iWrQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=Ga8nWwXL c=1 sm=1 tr=0 ts=6a9fb505 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IzbfGf_HrtPdoiX6LZ8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfXwPzUBO3Q/BfZ
 CE5j73cuj9duuXkZHNu+ofESlO9h7durj1yAAle8nC3ml/BANjyE5o8Kor/qSSgrv+RTPOpiFjX
 imT+7ilAk5Ulp6ToGm1XjJQTl/gQ+K0IB7eu/ZV1wS8QVrOCvC+7LT0jofuyaH84fy5OtmTLhbX
 +ATU0pz3Ih7ljfEWHOpILGABwCyUvFvfZUbnwoma1eAF3g41wN1eiR+mVoi0i99lS9HuBLZA1LN
 rk3O50opc6bNzwIxuw38U+mTzr69/9+tgQ1OZ7FA2bwJwssEn2zsV4DiGKPf7Me7HT3umpnhJAw
 6dJiY0hfmFOl8P4dg7QOC8+iLi0cc4eFgA/ked/+dmnXqqRwaUWESZx36OkjhQxw1ph1pWkzT/D
 jnpG9aY5FkFJ2Jfy6W+CTaCB4fySaz8vMvwzAEaZH137CjoB9u27JW2EspiGbtZupKVJdgw3OY8
 AcnyrUPJRzHJDjBwoiA==
X-Proofpoint-ORIG-GUID: bP9mts-KhphhcwyZA2fVUFEYbti9UkDB
X-Proofpoint-GUID: bP9mts-KhphhcwyZA2fVUFEYbti9UkDB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3MiBTYWx0ZWRfX7gYdhr8BtMRP
 9oshnUPKJQfN4JNQVu0PDL+wmBcul8P6e/j+lk4jC6YjsI5YgqA6dk0KzsQ34Y4aOso8wX4es4G
 l2tu6Z13jy2ENrR9se2RVgb7fMPjoX0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080072
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

