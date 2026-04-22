Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85165FA1FDA
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 17:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E424A10EEFA;
	Wed, 22 Apr 2026 17:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lUqpt0hJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jFEpnNAs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D257C10EEEE
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:43:40 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MGqZX11218425
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:43:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=RPB74rjHmio
 iPv8T6HjThisH0Pt4yN6/d8eSpZWAlsw=; b=lUqpt0hJTHzrhLdMaxsXr1yL/Fh
 QIO7xd91xuTaR1uBj9aRW4uYyAghxi5e2s46MWED1RA1pwtw86fPuQowXyVZl/53
 zJi3+nUZAPEtRGBoWl0gc3aQZpHIaeef3IXzFAOOAro9tMFlEfYrs1qpm69nbK2Z
 Kpauw5EHQsA+7sRPj3r/CWWCdI9N2Eip0Oe1CRikzNElMqHPzycVstu9WhRbqUno
 bS1jYHZF9P+XWq66kwucSubbHwmb7956UtbgzAy0ODQWUCNmsSUw91OlNm5s90RC
 RSKyjFItBcb5NJ/cmcjeznKRQmtA9KKhofw0Kg7ndPzBTqoIZHjAUoR4HAg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq282r5u4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 17:43:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50eb8bad331so17642651cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 10:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776879819; x=1777484619;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RPB74rjHmioiPv8T6HjThisH0Pt4yN6/d8eSpZWAlsw=;
 b=jFEpnNAsYxo+kgLfqxB4esf6yfHlQMA+dX0gLbMR2kjfgfothTuar+0FNrknQOwG43
 ROz6ZUjVAz5mggOM0r0GDl56/MQxiGwddLIY03R8vxPBDCclsliNOViRgDFAhbONUQ1V
 FiDcEB7izCVW+WLmGuYNSc9+w5AmcuFK+4tSX5IyqnD7LKP5hq9V5f7yw88FHVfJilVA
 744gbDGOI92Bx5MIR+riZJe490eR/9n7gVWIpw8v2OY5/Zn+S7H1xRSW0rolqxB2MNSL
 7/B4F/mQ4e4SX3iVohKr8TuVWnl0SQ1J9BLs212yC1tXDo2V/PByEbE0iPKznQ4JA46I
 YW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776879819; x=1777484619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RPB74rjHmioiPv8T6HjThisH0Pt4yN6/d8eSpZWAlsw=;
 b=c7MFOKTmOjBkM1H2a9JWjwzn6Esr9rHuYIChahqgwBlNfBDxRFOa2jdEaBJeu70Pk/
 +I8O0rRo/MkPSjNTMv+RIXFJEum8x2uD/riS6LSGkeYF0/5wogiBH9yN3Fg0CBX8DCr3
 6RiGJisY0fRo1f4Y7ZA6AQ2Arove7s7439ycOEfovpKyzj/JtGG0MsTvm9MOzMibMxpb
 QF8KlJ5cNBAvbOtsfDwVG1HxzJr2ecM+eQJ7V+3Czk9osWAxBQ2NQR0XC8XybuuHeklU
 j6JH/7S08on8xp6mWOD9xgQRNOQrNVxxkQ/JTlFrphpolkoADKaCce+G/3l1AT7ODJ0f
 ia9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PgSbEowS96mhxqiKFB1g6u9dJ2TL94IVjzfmZxy0wuFwVGYNW+3zOL7aAhu2+gVSMYVSLe1t/Jng=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyI7nBPtIJ66wiqrMUeKVu4BN3fPIgNhMcgGSQ5PjsNcL7kcMLw
 M830MswXcgqy0hkmD6Ggq2bszne+sj9JMcJq43kpuNEmJE7nZxFsxpylanU/vWbMwsFOHnLmpMm
 jN6YEflXtgRm3b0ZCkDw95M5x2OalUcwrCAPjOZ5doNmZFT17qUSSKByEdENJVnTjqZgtSQQ=
X-Gm-Gg: AeBDieumRFIoOFYTt81TwK5cyQtcOBSLWol9vTH4gFQ79DHrqWNJoMhUQ23OeYjS7vI
 pcXDo6mAdsSPdC/TdfQGE1znu/4NU610pHH0Q+7zyjsdnLPH9k59b7Aj4BZrEjmaxpO/qIOa8d3
 gQr9u4fLf6VXGJJQ62vwoReo+T9tekExh/Q+rw/+ZxJOTibXFZKJSdbOE3/URBCyGfAwkUVyT4T
 5wGUR+sP83DJgKhaI4fiJKB4ImJrPzI5hNuvkcni1jtfGgxarCiW5/kQTM9dz1kvoqheEORPMzy
 RjNbgz+1S8ljffe4rp2FOJLz34BeB5mvl5LzB6xokOZxh+0XbMyi3KaMY4p7YoLPj1ERf768wMZ
 bZLixGM6TfgInqe7Uzz+Wnijtrhu06iBYLPII7rUEQ4AxVRnUxCkCVfLvKxIt
X-Received: by 2002:ac8:7c46:0:b0:50f:bdc1:3bbc with SMTP id
 d75a77b69052e-50fbdc14892mr80055011cf.45.1776879819040; 
 Wed, 22 Apr 2026 10:43:39 -0700 (PDT)
X-Received: by 2002:ac8:7c46:0:b0:50f:bdc1:3bbc with SMTP id
 d75a77b69052e-50fbdc14892mr80054371cf.45.1776879818424; 
 Wed, 22 Apr 2026 10:43:38 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:ae20:597c:99b8:d161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7a051dsm142511965e9.18.2026.04.22.10.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 10:43:36 -0700 (PDT)
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
Subject: [PATCH v2 09/12] thermal/of: Introduce cooling device of_index
Date: Wed, 22 Apr 2026 19:42:58 +0200
Message-ID: <20260422174305.2899095-10-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
References: <20260422174305.2899095-1-daniel.lezcano@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDE3MSBTYWx0ZWRfX9dICdFfn2w99
 Q95bjOB2bRptcOAeOZbN9LE6ihcPgYGxJKjoNbkD7OFc242AkUid//mV1FLu5dJRD0JLf7UNPvu
 XWFmfVl72ByLi7kxljEoy5YiLLPnxmrtJb6/fLk61QXResZcPEvvzZHFx6Z2WytNPpJyHJvZH5D
 dndUHeIabQ2dV3TCOTgPgGAhNj4hk7naXFrCAME7xl/JERpTsB++gjeIX6zbIFt5YVbkLunaSB8
 IYYUQM6V6OETlrx3OjGj1VxlTsVsWT5CXO4K7aL1VMJJLh9LW0woXv6SXIahfsTwXcoxu4bkx4n
 5g/Blb8zrS/JpOkefK6EfYkC5QaSHFMLbOR1/S2G6nrGsyjF/6w6bhPmo8Z+mHJJuQS+JlQxxIc
 hY5onWtb1djpihYeejZHoBkEdU0pJUPKXq5qux+2G9cyIY7I4d0eMHIvOCTFWLHdv5L8JERiD4r
 vQ8fa7yz7ExVsc1cOvg==
X-Authority-Analysis: v=2.4 cv=Zond7d7G c=1 sm=1 tr=0 ts=69e908cc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=UUaV7nkyxFtcjw1PROYA:9
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: iVmvAvhUorm1Z15K4uDp4AtHNg8auRKA
X-Proofpoint-ORIG-GUID: iVmvAvhUorm1Z15K4uDp4AtHNg8auRKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220171
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
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 5 +++--
 drivers/thermal/cpufreq_cooling.c     | 2 +-
 drivers/thermal/cpuidle_cooling.c     | 2 +-
 drivers/thermal/devfreq_cooling.c     | 2 +-
 drivers/thermal/thermal_of.c          | 6 ++++--
 include/linux/thermal.h               | 6 ++++--
 6 files changed, 14 insertions(+), 9 deletions(-)

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
index d06487bb5e67..a9319ff81d1d 100644
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
@@ -582,7 +584,7 @@ devm_thermal_of_child_cooling_device_register(struct device *dev,
 	if (!ptr)
 		return ERR_PTR(-ENOMEM);
 
-	tcd = thermal_of_cooling_device_register(np, type, devdata, ops);
+	tcd = thermal_of_cooling_device_register(np, 0, type, devdata, ops);
 	if (IS_ERR(tcd)) {
 		devres_free(ptr);
 		return tcd;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index b3c448f7d919..070dcf7f77b6 100644
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

