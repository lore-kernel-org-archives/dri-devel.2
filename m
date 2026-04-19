Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BA1AEA7197
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 18:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37CE510E008;
	Sun, 19 Apr 2026 18:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TtI/BbYq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lt7NZaMd";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 677CD10E008
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 18:22:57 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63ILjNCH2379609
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 18:22:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=mBAk+Sm+mnO
 5DTzI9lKqPEUkJ5P/e03TPLtapt4NgHw=; b=TtI/BbYqpUab5NfqgQhMFLclp+1
 vB8QQKaUZdB3IKVwvUETKTX7BPZaM0leoiaXakCLo+BH3SBzBCFmCiehpHxoXYZM
 pM+ImQCuUPJdNay9rYSFyPJMflKv5KATqG+qDw2CnQof6stTseqGtop+jqw3YtnZ
 2gi3MuZITOPyCcC6+OKw8mhoS4FlFGH01J9J1DJWArEuDb1xPztJyEWE3Q4x2X0r
 uopJsMioEiWd4ImnyLchni5JQEAxGVeXYiVpiEMMAhVIKdWvyR+OscjBxdOoR6Yn
 CBQVZ3tVV3rJ20/nTm6ZzQzaW2GNfuEN9zMxaA5rJKuFOGUAEkWSM1c3rtA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm0wr35ga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 18:22:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8cfc1634e43so242430885a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 11:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776622975; x=1777227775;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mBAk+Sm+mnO5DTzI9lKqPEUkJ5P/e03TPLtapt4NgHw=;
 b=Lt7NZaMd+TsfKvUL8U9kfqDtx1jGEFP1lIkZRii6xxkcBvF4BTN8rM/Lk7nadlObWf
 wOAfkz4oqI4lA0n8+3eQGGGIcMkUYowx9Dg8wVFT9Rhu5BNHzHfLH315zxdrKxWs7GtW
 +jzwsQwDhX8LFEEl2AiJW9SlB62+QqJIwz1iCG4Z8bdoBkMo6tpSrTOeBZQGj0FMfSqt
 ilypwTqFItnPnXPcx2jQrvkyrJihIukv6sfZmUBZqMgHmTt9Zn9L/wvOYOCE9W8QkwD+
 XNJ8IKANaNbQnU3RX91AtmK6m2l45cT05IoCTt4kTnaxUyzo0ZiTERxkZv6NusCAx6B3
 dHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776622975; x=1777227775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mBAk+Sm+mnO5DTzI9lKqPEUkJ5P/e03TPLtapt4NgHw=;
 b=rRNJZQuvzH7BLUwToVaAY9pJ4Dy/OiSG1TM0G7GaT+4441JFPePkfGaDYuR/egwUcL
 XuKMNaOKyx2vhTrlmqK6qLvx/desOOiJOt1CTVNXJKJqHP2xdQ0z0byKOk6wDaCCDdtY
 xyKN/kKNUwXQdXC4/OES//w4Vhct9t1kQtqxz6s4lrBdeGLaGsOyZYmm3nZvTMRaY2Bi
 SVRjShXHY7jmzt5xHXy4UdjmAeH1a5W+aLd5kRweNmb2urBgByNMptqCetyxBJNrSh6c
 I5U5ejXrJDEVbsWwRBaH2z2TfE0i7oN/gcM3GfdcN+aIx4I2ODpAG2nNipN5q2NGNz9E
 hENQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Da9WNy5zymBEwEN8hIFLAfHenPoYC7C7xucbk0jcviwg0jSBoKojwni2Qo9+F6G3E1lQN+7yeLOU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVAMt9oYNcBhN2rMJQMq3DsFC3D7BR7yJyWhXCfQ/I9pAJ2l25
 jfpfb1rO7iDady1bqIbaDQoSFv8o7CS140NiX7gdWSJOEvQIinmCQhrJLD6YlBw+0ZakkBc+TXT
 vspl9MaGz4B0Qy5Sai1wFzZahIO73pJNuBjx5PGgOdiN20e1PLIATH/zToZsjZs0se9r1srY=
X-Gm-Gg: AeBDiesEbAdjBEBjZ/ixHU1ZK51w6tlxOkgczMAgtPqZ08blOW0G5vka/NQ0HgurRNt
 sXtxHiXoVxhL/mU2m5GYGkyMyzcxyzleLC1e0ijgkWzgtN03aYj+lmD51Wn9ckI2PPRG18aCVL9
 0EGRdnaQn+/054GZAikTljrQ83IKNdXh/ZZU9JiGTp/gpba1XM2lvz44YaH+9eWQp7P4d0Eizu3
 qYzkY2uWRoT23Gdrh7miC42jL9i+Uja9rSG9jNsraEIFpIs9QjMPvO3XuoW1iRphNKee1a4om2V
 FLf1DEkFTpmD/MrDRrqXaWfPtW/9YRogTVSNCISUnNQtYqR1KRbB/FfPF8qgprn6mSy6Kptkksw
 cOsgXYnX4MXoJUv7WKsTzouq/Ijdd4+eDLShTzeo3Iy72RCY162T9hMtKZzX/
X-Received: by 2002:a05:622a:5c05:b0:50b:4755:94b9 with SMTP id
 d75a77b69052e-50e36c77202mr167950741cf.56.1776622974648; 
 Sun, 19 Apr 2026 11:22:54 -0700 (PDT)
X-Received: by 2002:a05:622a:5c05:b0:50b:4755:94b9 with SMTP id
 d75a77b69052e-50e36c77202mr167950031cf.56.1776622974124; 
 Sun, 19 Apr 2026 11:22:54 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e59f97sm25723070f8f.37.2026.04.19.11.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 11:22:52 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: gaurav.kohli@oss.qualcomm.com, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE GPU IP), 
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU IP)
Subject: [PATCH v1 11/14] thermal/of: Introduce cooling device of_index
Date: Sun, 19 Apr 2026 20:21:55 +0200
Message-ID: <20260419182203.4083985-12-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
References: <20260419182203.4083985-1-daniel.lezcano@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE5MDE5NyBTYWx0ZWRfX/hI79IPxGK3m
 SWAkcQ4gw0DwdrcuYVzRnz+F/dMIPeoICJVSuTnhhPXVTrHE+86a2rcVOTzaKNQF9RpKlhLdV5W
 wZ+dA+Q7xJtBhKUvVu1asx3W6dE4LM2ioaocGu93tdW8+CoDqH53VMH38tF086pti8VePHEDWLP
 xlwNzraBMGLJ48EqVshbpAUv/pgVTc21PLzoP1tlgkJ291vdL/8aq75U2JF9yq4jeANpDWvAsP1
 lDFZYsrDuVm70/juyJfpgqfXEjZy2WhxL7BNdJsimFSmmPbf0N+IHGnJ7kGgYn/J39MqgWhOmp8
 f8yH+9kRso8ggD2HymSN6CdiBi8x2Nct/qw2CGc/oAHn26iKHJR8lN87rh8wK93C7WsmgKoxsB3
 uSdrTTa6K3dUrfZNH6KrEbcRMh38f1EeGXPSbSby+Waebj63Oe8FbfbElxJYx0iR5qsOqepxVvK
 V9HtRJCerRp1xKW/Rpw==
X-Authority-Analysis: v=2.4 cv=G9Ys1dk5 c=1 sm=1 tr=0 ts=69e51d7f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=UUaV7nkyxFtcjw1PROYA:9
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: XGUtpaQNdU1cTSQYx26vGqdfUEKBO4o6
X-Proofpoint-GUID: XGUtpaQNdU1cTSQYx26vGqdfUEKBO4o6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-19_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604190197
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

As described in the previous change, the new incoming DT binding will
describe a tuple device_node + cooling device id, instead of child
nodes.

Let's augment thermal_of_cooling_device_register() to receive the
cooling device id and propagate the changes to the four remaining
drivers using the non-devm version of the cooling device registering
function.

Add the id in the cooling device structure and store the value when
registering it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 2 +-
 drivers/thermal/cpufreq_cooling.c     | 2 +-
 drivers/thermal/cpuidle_cooling.c     | 2 +-
 drivers/thermal/devfreq_cooling.c     | 2 +-
 drivers/thermal/thermal_of.c          | 6 ++++--
 include/linux/thermal.h               | 5 +++--
 6 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index a891d4f1f843..a965cc0633fc 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1791,7 +1791,7 @@ static int etnaviv_gpu_bind(struct device *dev, struct device *master,
 	int ret;
 
 	if (IS_ENABLED(CONFIG_DRM_ETNAVIV_THERMAL)) {
-		gpu->cooling = thermal_of_cooling_device_register(dev->of_node,
+		gpu->cooling = thermal_of_cooling_device_register(dev->of_node, 0,
 				(char *)dev_name(dev), gpu, &cooling_ops);
 		if (IS_ERR(gpu->cooling))
 			return PTR_ERR(gpu->cooling);
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
index ba5093f612d0..a728da1f4e56 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -514,6 +514,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
 /**
  * thermal_of_cooling_device_register() - register an OF thermal cooling device
  * @np:		a pointer to a device tree node.
+ * @of_index:	a cooling device index in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:		standard thermal cooling devices callbacks.
@@ -527,7 +528,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
@@ -538,6 +539,7 @@ thermal_of_cooling_device_register(struct device_node *np,
 		return cdev;
 
 	cdev->np = np;
+	cdev->of_index = of_index;
 	thermal_cooling_device_init_complete(cdev);
 
 	return cdev;
@@ -579,7 +581,7 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tcd = thermal_of_cooling_device_register(np, type, devdata, ops);
+	tcd = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
 	if (IS_ERR(tcd)) {
 		devres_free(ptr);
 		return tcd;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 6535353ae83c..9813f02db088 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -134,6 +134,7 @@ struct thermal_cooling_device {
 	struct list_head node;
 #ifdef CONFIG_THERMAL_OF
 	struct device_node *np;
+	int of_index;
 #endif
 #ifdef CONFIG_THERMAL_DEBUGFS
 	struct thermal_debugfs *debugfs;
@@ -201,7 +202,7 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *data,
 				   const struct thermal_cooling_device_ops *ops);
 
@@ -225,7 +226,7 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-- 
2.43.0

