Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA1CCCFA13
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 16:14:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3E3910F08A;
	Wed, 29 Apr 2026 16:14:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="adwaPxQN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FO3iYDpK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A157892ED
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 16:14:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TFTjnQ1641981
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 16:14:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QlIuh8BM0Sa
 SyTeAREDnPHaWMXvZjHEGYrSurFk/U6c=; b=adwaPxQN1ZFLAoj5evhUxLj8Dub
 gQzwmrMQs6MKYZhkYAg85k5YXLDNXCttNlXn+hKBLMJdI9GgMACVPujLb+6/1Izp
 UW0vdfGT5a5liZ9LTWnwFm5rbs7wmB3j7jv3Uhvb3llXqB0CSLXuP4D9Q19ZsoxA
 GDC8cksxVQv5T/jW04qUiJKBV9/WU0CLRqI2uko3JP1CsnDtRynkT95VczHZ54wr
 mtnQXkq4PowTF1OVbQkCE3U5xpZPhIVPidMLdA2eAVDzTUWI1W4uh4xEf8TEfce1
 gB47Dua0eYb6FNxWDUI/DhbNawh24OfStpfOCdoxge/dwBEqFyuAvXKLoAw==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ducj82de0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 16:14:56 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-56f6c90b142so20515078e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777479296; x=1778084096;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QlIuh8BM0SaSyTeAREDnPHaWMXvZjHEGYrSurFk/U6c=;
 b=FO3iYDpKCsxvuXgPlo6xchQexhAY6cypQKD8GkEqer/bWUoC8pHFsykAE4JUDZrbHp
 pbd3c4peFtmWf7oJHOFi3vEhsnilrmUaKTRB6c/CnxQCf3md8VjWB8Cbbs+cScAHBwxO
 BMD6LXWou7yqzKogPLEQKvlHCuXgDQGsXlzMcHhy1J/yxzgoMvE/qNp12BmfBny8EvwR
 qBfJXjBb+7SRPvrPcViipqGsR0duIeKavYluaSDbBtGTQ8+rAM/fU0NzYMdTs6h/xFS+
 IfytL65u9U5b15Iu9HUb15FEw0eO9caLTnSuj+QwNBvxlKmnMEhE6uPF6GHcvZY7vsP9
 GOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777479296; x=1778084096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QlIuh8BM0SaSyTeAREDnPHaWMXvZjHEGYrSurFk/U6c=;
 b=atb5vTvOqPLnDzMovgIPfeVmLY4jgrnoqmd62GJ11FOXXLwwBw2Ol0Q5OJP9DO9nGf
 Kdrk2kEJVU4iQ6w/zJh42vc/I2o9BCadtYyIsgx9f6NCRA/4H1VgUs6ZQ4rLt0FyFpMW
 aM1KOTr2Nq1IxHUl+C5T+RcWw8begL6oelY+AQ307P8aE8eFO5lSHv6ile+89MWuUs2p
 +fLIwVtYrB+jnHIApRlhEhxzDFl17FG/1ulx8uImqfnqJlGxFONOCIZiOqMC+6UiVQKV
 oXvPdBdaUIcDafKu+HnRuYefrtv8BnGTMcG1FeJeMwR58cwG+OCZSdBsvEnEHJDPB0FD
 fQkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OcVtfgCQfuJaAR+G5PD3d4U1r1jYDDYeZSvLN03nzZ4I7JwuKfXeNYQIZxDzyndT2jR18Mu/8+iE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCExOddrsp84J1zCJntqv6K23OF+Onv+UbkiwgczVy6Alb5LWp
 nshrYXakXgZlJ1CZAFkgJM0/rnMLbkG/ppaXeyAPPe8rNxqZ0qUf9ssr/NessRVmyQ3a7JHPku6
 VobIwg0UycFynhUNdBarsJzD9KPcasw1grHFiL2ILdnefz8Q+58VQMMmsJ36DQwZjv43C5tI=
X-Gm-Gg: AeBDieunA6M5s0Pss6pQD8ZiB8AUZVmRZHZAZGh2ViWzXB9gVkzlfKYLQ8cfxv0X8M0
 gLc3hluj/fAqdNCnmzsi+XeoUfik4WkqWC8Yu546E05MvRcoJ4YoQtdyCE+GEk5s6GgqlsabdWh
 JuqMkeniaorjDe1mGxRhR2sHwhCLs0oXavZj3Qt9CK1CkFOviitBMZ19PX8ak1fKabQ8uXIP9Jn
 s7pzyHG5Gsm/dCDhgBRmAMk2m7IjUfSxgdaZpEmmRfubWktIFkN3PkLgGfChYHhfPX6iA++n1Og
 LxF7bP7RYfODeCY0Sz4lAnGo2V++YviDrFUmZH13QONLlMnQXgApJlaV4wdv6pqyeN8D4QFEPXf
 8xCQJStgTxg69ySNxY43FQGSiirI4fGLi+QF94sfCixcjt+clvMlQ0SjWxgUu
X-Received: by 2002:a05:6122:24c:b0:56f:7c7e:f33a with SMTP id
 71dfb90a1353d-573a52eea5dmr5244109e0c.0.1777479295844; 
 Wed, 29 Apr 2026 09:14:55 -0700 (PDT)
X-Received: by 2002:a05:6122:24c:b0:56f:7c7e:f33a with SMTP id
 71dfb90a1353d-573a52eea5dmr5244024e0c.0.1777479295316; 
 Wed, 29 Apr 2026 09:14:55 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81ed659dsm2438525e9.2.2026.04.29.09.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 09:14:54 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, daniel.lezcano@kernel.org
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
 etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE GPU IP), 
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU IP)
Subject: [PATCH v3 08/11] thermal/of: Introduce cooling device of_index
Date: Wed, 29 Apr 2026 18:14:21 +0200
Message-ID: <20260429161430.3802970-9-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
References: <20260429161430.3802970-1-daniel.lezcano@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wlsRf09hIc2AX2r0rcTaY8vh3jClql3j
X-Authority-Analysis: v=2.4 cv=RI6D2Yi+ c=1 sm=1 tr=0 ts=69f22e80 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=kkni0TwwaAke5k-tc94A:9
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: wlsRf09hIc2AX2r0rcTaY8vh3jClql3j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MiBTYWx0ZWRfX9/JNlIX57HgV
 kknAa1apkimGBabQqq0qbEYMtxNOTB0iQxHEEJWQ92KmURvOJmG2vZjiMg17C14vDOjB8P2S6Dk
 p/ZqM4dQOJdlusmi8VdRdF4BV5VbwFuENSvcOeJ2WpYZbu4r4N/RoZ1mUml48bS7jRoOg7Yahl/
 gAvadyWz7efkFR/hSpl4FEbX0yI2HUWsDW3SDDv/9BGjZbV00ekDcJqWmG8U9vmAOUcE7WuCA+v
 oF0pHEypjNv7Otab9fFRxH7Lzn4vyGtuq/7DuSL1kBnzPK0ikZGcVSlLkMs8mJ8ntVliG7QHCxU
 5biRtMPiQVUFoR5o6OCijZ8Yh01QpIAO7yyUFXR5H+o19uE6nZgG86iShFSBFs3CeairzdXhQ7X
 I6NvzVTzcsxKrE37shQld6+NjrLIWoVdbCthmASpPlUBZR0LFp/14ReHvOKvQLADAYPyMWy36dT
 Lc9IqmYqh/oNwxpS1Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290162
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
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c |  5 +++--
 drivers/thermal/cpufreq_cooling.c     |  2 +-
 drivers/thermal/cpuidle_cooling.c     |  2 +-
 drivers/thermal/devfreq_cooling.c     |  2 +-
 drivers/thermal/thermal_of.c          | 21 ++++++++++++++++-----
 include/linux/thermal.h               |  6 ++++--
 6 files changed, 26 insertions(+), 12 deletions(-)

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
index cf60ac64db54..b38623f6b89f 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -511,16 +511,23 @@ void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_dev
 }
 EXPORT_SYMBOL_GPL(devm_thermal_of_zone_unregister);
 
+struct thermal_of_cdev_init {
+	struct device_node *np;
+	int of_index;
+};
+
 static void thermal_of_cooling_device_init(struct thermal_cooling_device *cdev, void *data)
 {
-	struct device_node *np = data;
+	struct thermal_of_cdev_init *of_cdev = data;
 
-	cdev->np = np;
+	cdev->np = of_cdev->np;
+	cdev->of_index = of_cdev->of_index;
 }
 
 /**
  * thermal_of_cooling_device_register() - register an OF thermal cooling device
  * @np:		a pointer to a device tree node.
+ * @of_index:	a cooling device index in the cooling controller
  * @type:	the thermal cooling device type.
  * @devdata:	device private data.
  * @ops:		standard thermal cooling devices callbacks.
@@ -534,14 +541,18 @@ static void thermal_of_cooling_device_init(struct thermal_cooling_device *cdev,
  * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
  */
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
 	struct thermal_cooling_device *cdev;
+	struct thermal_of_cdev_init of_cdev = {
+		.np = np,
+		.of_index = of_index,
+	};
 
 	cdev = __thermal_cooling_device_register(type, devdata, ops,
-						 thermal_of_cooling_device_init, np);
+						 thermal_of_cooling_device_init, &of_cdev);
 	if (IS_ERR(cdev))
 		return cdev;
 
@@ -585,7 +596,7 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 	struct thermal_cooling_device *cdev;
 	int ret;
 
-	cdev = thermal_of_cooling_device_register(np, type, devdata, ops);
+	cdev = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
 	if (IS_ERR(cdev))
 		return cdev;
 
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index e39bec84b2b6..26e33c0236c4 100644
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
@@ -201,7 +202,8 @@ struct thermal_zone_device *devm_thermal_of_zone_register(struct device *dev, in
 void devm_thermal_of_zone_unregister(struct device *dev, struct thermal_zone_device *tz);
 
 struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np, const char *type, void *devdata,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
+				   const char *type, void *data,
 				   const struct thermal_cooling_device_ops *ops);
 
 struct thermal_cooling_device *
@@ -224,7 +226,7 @@ static inline void devm_thermal_of_zone_unregister(struct device *dev,
 }
 
 static inline struct thermal_cooling_device *
-thermal_of_cooling_device_register(struct device_node *np,
+thermal_of_cooling_device_register(struct device_node *np, int of_index,
 				   const char *type, void *devdata,
 				   const struct thermal_cooling_device_ops *ops)
 {
-- 
2.43.0

