Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1739CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D43D10E4BC;
	Tue, 26 May 2026 14:09:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vs1fI3rC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vm6VWSbn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28E1610E4C4
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:08:59 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsaX71575513
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:08:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=G6UXIPhMd/k
 O1OykWot46Jp8kUhSq0VPJM75VskYv8U=; b=Vs1fI3rC53mf8ty4C3MQDoI3NoN
 P2hDWOQWHOUFNlURAtT291LyZkfxAlxLjPGUa1Jt7yxBgSh9+Gs6g1VGmchTxxwf
 e5tShePQN3WboG40OZInsN/be8Vz1GOkCSMHDVFXYAjtgqyPpIoQWGozYZ/Csk0R
 iBnwQz7f37bE83rgEB9HFPvL3x627ScOHFXNTlgJZ4x8RHiIHsHTDja1AZ9opyYP
 iJa1ymeUgb6k9+t3IUzef72h4hH2HLlOzUT4jMWE9xgBurgxoEaGg6jUbxB/iE4o
 IxPeIp5CETqjEBuLlzh7DElD+J/y0wEf8h9YbfWtM3TFyBIJr/mffGGjDmw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqvwvfyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:08:58 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-95fcbf9c0e8so16368919241.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779804537; x=1780409337;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6UXIPhMd/kO1OykWot46Jp8kUhSq0VPJM75VskYv8U=;
 b=Vm6VWSbn9dOXJV9+GzQE1s5i7G0Zzi22NklpYYEFSM0KOvw9aOa8n8v6plrS+MXMMB
 7f9vfKAMb+r1mQJNtG6ZPtuikAD3l6uVx3c1b+Ojvwdgvj+T2dSwIWc8wSd3EzamPPvj
 yQzV7GtA42Yc0C4D+f0j4l4WizaRoC0nThNhkYf47TpgwC0FLoJQS1hO2BfyIW0n8X7N
 rpu+a7TNR+5A517kP9RNQXa0WBnAeaji51I8Z3aHyiCWDpYlAHXBS+qY/Cm7T/wHeNaw
 95FqnmrGBeOODwxLiVrwMVGOlGkis41XjQhJZREDS0a3OlEwMZ6eZVWYz/jhY75r9Hoc
 1bcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804537; x=1780409337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G6UXIPhMd/kO1OykWot46Jp8kUhSq0VPJM75VskYv8U=;
 b=tIqUMShcLeZrYrv4tvIbjv5DIf7CPoYwzbB0BAl/gF6VH3mX7LXyR8to1RZFf36Gtd
 aR+1p6+PpsRyMnaxcJJIrF23X2CRNMLFvvDBGSeUAXMP0DStFkJr4gW0f/Pza+3Z4/un
 pzU3VqZHtIL7zWyfr7tQRWNpXNSbnZQzPCar+C6uUaRcrMm5zSeVGpEQEWj2ZlXVGUIs
 3n2NqBWTm7Lu/FykTO0Ml4RqyOQNGJmQ3fmx46ChWf2y6DEA5AzbD8681MI1JhCZBc7a
 xB7UpiEp95ePEY9RTzE4R6U97TBtQ1M9pfRAyXWH3VrUVI0ZuxwNjxOP6s/dR4eBuE4v
 Q0TQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/o0O45/ASa5O/lSWsKE0DASt5LkTatvWSX3SbKJNooCkb+kH+L/2hDDeYDI92DNVG7b4Tx6XMD1aQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXceJEfrgzJ+1Ae5sejLwiKpbNXnSSQYAGrBD1Zj4qMNPFmQor
 UDdYYQ0u3miMLUaP87Syq8quxYsW/X9K82YMNsYbacdWyh+/h15qjBcIKB6JH0GP3Mw5iZtzKKr
 YQ+MlMlj9GfsZLqzf/eUeEolavgpn78C36OJ/0+H5OWgqlulmXkjaPnhXEj6BdY56csTC9aI=
X-Gm-Gg: Acq92OHXZcfUXV64u4nXn+QUbobDMlQyFe7htjZf2Upjm72ZW+3agUZ/4LsDe4SggV2
 pniBa/oa0F7OkNuQh/U1G06a0Q5Q24C95U6vBMkIVgnF3UR4mfwPsrEs/hNtq016NPF+nmHN9aK
 cczXuou7tUMECOeLP2b5pti/wDST+AldxvEskgvvh9fdgDIrSNgwgsifjg5KKg7RvhQrJ5L7QWA
 EyTYl3YSBzvFqbO80ULgLGphyAFDhbl5TGGe3RY/GdQ3oXfV6C8RPQeLqwdiBQcnc2FUZVI035Q
 9AbB7uVrduzmkogjZBW+BAFo+WVe3PtusvNAqs/do01oFq8XmrEmuPikjOYeww85W4Njr4fTu8d
 bLEeNvKv0DFb6w3dGgaGbkGqsh0XpTxj7xzN8mjPGV4DdHeTz
X-Received: by 2002:a05:6102:3585:b0:631:41f9:ffa2 with SMTP id
 ada2fe7eead31-67c8cba579fmr9659433137.29.1779804537464; 
 Tue, 26 May 2026 07:08:57 -0700 (PDT)
X-Received: by 2002:a05:6102:3585:b0:631:41f9:ffa2 with SMTP id
 ada2fe7eead31-67c8cba579fmr9659341137.29.1779804536926; 
 Tue, 26 May 2026 07:08:56 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:9e9:6f8d:9f1c:61e1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490424aa561sm156266605e9.5.2026.05.26.07.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:08:55 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lucas Stach <l.stach@pengutronix.de>,
 Russell King <linux+etnaviv@armlinux.org.uk>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guenter Roeck <linux@roeck-us.net>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Benson Leung <bleung@chromium.org>,
 =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Avi Fishman <avifishman70@gmail.com>,
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>,
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
 Benjamin Fair <benjaminfair@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Amit Daniel Kachhap <amit.kachhap@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE GPU IP), 
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU IP)
Subject: [PATCH v4 07/10] thermal/of: Add cooling device ID support
Date: Tue, 26 May 2026 16:08:08 +0200
Message-ID: <20260526140802.1059293-19-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
References: <20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6389;
 i=daniel.lezcano@oss.qualcomm.com; h=from:subject;
 bh=dVTi16Ji7zjZVXFk/PV/mKHcJ3PxlBnabFv/88k2YU0=;
 b=owEBbQGS/pANAwAIAagyI4oqT+hPAcsmYgBqFalPNVBQAibKwSwwBkb0vLMg4KKtMGIGLaVT+
 ft/izW2PkeJATMEAAEIAB0WIQQafc3hhXPRY1XIeySoMiOKKk/oTwUCahWpTwAKCRCoMiOKKk/o
 T/s+B/9pB7YmbECtdsq9wJWAQ5z9GQ+XLDNRpTPnfv+MhLef3Q3bBIe64n23M2pGnOn0d+pek/j
 bVoCgQQqhL24FQu4NH5Vj+8/K9THKuv8oh0nc1bDrO7how58z8OQ6MpeOI37vJxJzrl1aOau62s
 o8QRndQqT3P4H1EHDQ472qztQnp9IaBgWAyG7AQ9nTyfV6q+3IZBwPfG8F2CsTxmBiVyYIHzSht
 xlI0oBu9AdUOFHxuOL0k+9xW4vp+iOGIfuH2xAmiaceglj6P8vhj9f+VIlmMyyHnoUSXrgLTrB5
 /oQHsWBTK+c5Y12Yt1DmOc9oWlC6YZPgZDScMMZLtHbgkKxR
X-Developer-Key: i=daniel.lezcano@oss.qualcomm.com; a=openpgp;
 fpr=24D626F253BE9E87E6CE5BF48FF4B8D271675527
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dEybsNDAS3wLNnnZ5P4YtifWM4TOYNID
X-Proofpoint-GUID: dEybsNDAS3wLNnnZ5P4YtifWM4TOYNID
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyMSBTYWx0ZWRfX1+Z/9bJrjRBh
 hd+Pjak43egdw9cPPwrBWRyVRJlMZfL5xQwXV1/5n7klVD1xfnDNZbT1qOEl7rWXlcV7GvBlHs/
 27znDbSmaZ1TFA03mMDcJCKRJsFVgZvoFGAFu4zr5gxC+qnVaRGtpg5kQ5QMw9vjWkrvcZacOxt
 REkGvK53xAjf17aU6LgomSBMWj7YxFZq6NYLejnBcYIbuFYW3Qqq+4eWXy74OnktFaRJ2Aj8YsM
 gTYeoV0mvg7svYK5mQTmRWeNWI/Je9/dPHLFc/YIeZvWsewGafe3bjQp1MoFZvNB8LvDdQE7DLe
 SUYK8PBYRATWlq4ZrJp5+6+bOreVPVMwUCeoqT+KMIkEjdlDIiYKQkI/gK3b5FambEuTKAW3JcZ
 xi9be76DtoTRHYBWDCL+DEcTbIP52LY8X5EXcniRAwkJPNXEmOcFanTn4z7I7IFMISfkmmUv7q8
 ulJ0HQElPqZDk7lUjEQ==
X-Authority-Analysis: v=2.4 cv=M4l97Sws c=1 sm=1 tr=0 ts=6a15a97a cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=M2J-0F0GypFtCefbwVAA:9
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260121
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

Introduce an identifier (cdev_id) for cooling devices registered from
device tree.

This prepares support for a new DT binding where cooling devices are
identified by a tuple (device node, ID), instead of relying on child
nodes.

Existing users are updated to pass a default ID of 0, preserving the
current behavior.

Future changes will extend the cooling map parsing to match cooling
devices based on both the device node and the ID.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  5 +++--
 drivers/thermal/cpufreq_cooling.c     |  2 +-
 drivers/thermal/cpuidle_cooling.c     |  2 +-
 drivers/thermal/devfreq_cooling.c     |  2 +-
 drivers/thermal/thermal_of.c          | 14 ++++++++------
 include/linux/thermal.h               |  6 ++++--
 6 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a891d4f1f843..552631c3554a 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1791,8 +1791,9 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	int ret;
 
 	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
-		gpu->cooling = thermal_of_cooling_device_register(dev->of_node,
-				(char *)dev_name(dev), gpu, &cooling_ops);
+		gpu->cooling = thermal_of_cooling_device_register(dev->of_node, 0,
+								  dev_name(dev),
+								  gpu, &cooling_ops);
 		if (IS_ERR(gpu->cooling))
 			return PTR_ERR(gpu->cooling);
 	}
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 32bf5ab44f4a..768859a7aed0 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -592,7 +592,7 @@ __cpufreq_cooling_register(struct device_node *np,
 	if (!name)
 		goto remove_qos_req;
 
-	cdev = thermal_of_cooling_device_register(np, name, cpufreq_cdev,
+	cdev = thermal_of_cooling_device_register(np, 0, name, cpufreq_cdev,
 						  cooling_ops);
 	kfree(name);
 
diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 425f596614e8..bbd2e91cf5ab 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -207,7 +207,7 @@ static int __cpuidle_cooling_register(struct device_node *np,
 		goto out_unregister;
 	}
 
-	cdev = thermal_of_cooling_device_register(np, name, idle_cdev,
+	cdev = thermal_of_cooling_device_register(np, 0, name, idle_cdev,
 						  &cpuidle_cooling_ops);
 	if (IS_ERR(cdev)) {
 		ret = PTR_ERR(cdev);
diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 1c7dffc8d45f..0330a8112832 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -454,7 +454,7 @@ of_devfreq_cooling_register_power(struct device_node *np, struct devfreq *df,
 	if (!name)
 		goto remove_qos_req;
 
-	cdev = thermal_of_cooling_device_register(np, name, dfc, ops);
+	cdev = thermal_of_cooling_device_register(np, 0, name, dfc, ops);
 	kfree(name);
 
 	if (IS_ERR(cdev)) {
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b59d2588ff7a..0110b195f7a3 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -514,6 +514,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
 /**
  * thermal_of_cooling_device_register() - register an OF thermal cooling device
  * @np:		a pointer to a device tree node.
+ * @cdev_id:	a cooling device id in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:	standard thermal cooling devices callbacks.
@@ -528,9 +529,9 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
-				     const char *type, void *devdata,
-				     const struct thermal_cooling_device_ops *ops)
+thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
+				   const char *type, void *devdata,
+				   const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
 	int ret;
@@ -540,6 +541,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 		return cdev;
 
 	cdev->np = np;
+	cdev->cdev_id = cdev_id;
 
 	ret = thermal_cooling_device_add(cdev, devdata);
 	if (ret)
@@ -585,9 +587,9 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
         struct thermal_cooling_device *cdev;
         int ret;
 
-        cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
-        if (IS_ERR(cdev))
-                return cdev;
+	cdev = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
+	if (IS_ERR(cdev))
+		return cdev;
 
         ret = devm_add_action_or_reset(dev, thermal_of_cooling_device_release, cdev);
         if (ret)
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e6328234a42b..fb7649439dfa 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -134,6 +134,7 @@ struct thermal_cooling_device {
 	struct list_head node;
 #ifdef CONFIG_THERMAL_OF
 	struct device_node *np;
+	u32 cdev_id;
 #endif
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
@@ -201,7 +202,8 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
+thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
+				   const char *type, void *data,
 				   const struct thermal_cooling_device_ops *ops);
 
 struct thermal_cooling_device *
@@ -224,7 +226,7 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, u32 cdev_id,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-- 
2.43.0

