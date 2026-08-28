Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BD2C61DD3
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 14:06:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03EBE10F3CE;
	Fri, 28 Aug 2026 14:06:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="C6zd4Q2V";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZPsAoUYI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A7E10F3E9
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:51 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SDko782970061
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jdhrzVC+BSUYhhqWL5aZLvycJ6pbOt/WUM7DdLQllPo=; b=C6zd4Q2VGmRd2gHZ
 enKHhB574O0Vx22uspUq2ny/Ba1GhjzRrqvYWqOmyIokUhuMWmHlrn6b2qIfZ6nL
 cqu50hSBeBwVAOGUiTkH64A0sMIMuS6lpY1tVBY3HrUS2a0rxnkTZe9PidxaF34o
 DIzjtdma4N0Uvd0U3zPB39LPO6UEtiCWxDGmt/TohINZC6vKbVS+MQnKiopKfDBM
 2/zV8GnWWtLGSSeSjXkqqntxR3YVpf+NK0IBDw9IBftNpBckOO610/SdOg5Ig2It
 LU6pHUEKtkKEwH5qMCtkeBiUVfMuSOnaVDityolZYCXTHgMtB07cO8QaSoUw+m2C
 JpqcqA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3hs247n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 14:05:50 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-97e8be2221eso9575241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787925950; x=1788530750;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jdhrzVC+BSUYhhqWL5aZLvycJ6pbOt/WUM7DdLQllPo=;
 b=ZPsAoUYIrUFoDwqp0Z4QOpcVQRKfAxxSnp3TLBfcqjDKJVlZjKJFUM4RYeQXiYTfi9
 DIMC0qsVmkwUuthlBSaAA3HswcMXQ7AE9poA7Kxuzati0ojjF9VxnDaVLVC5H5MdGpjG
 0V40OhvJEMTRXIZ+0vCIYHUuxeKoddvgIE0WKcDPrpzteychx8T/3iZw8i70lM52w0dZ
 xTKDA/GQVKF4ddWZzlOKhOhOqMBwMX89GuB3S61Dj0hFb+SrHPzv9iw0nJ916IXOVr11
 L94/BRtrXlHMPl4cpYm5KosIFizRtYq+0S5mOhA77lp0mW1JJNYjUmbdMYVgai+o8sGQ
 wjeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787925950; x=1788530750;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jdhrzVC+BSUYhhqWL5aZLvycJ6pbOt/WUM7DdLQllPo=;
 b=SzxuVWRSv9HcIquH+RB9D1tfh9ASIJt9b5agpgPtfqbQcMiouOhF6yeimkv2cQHrCW
 l44b9F4XFmVERJGud43YQM0XTmj97/ZN8kY3NVzRNdU7ikfKF6Kp+N7HiQ4tBPGV7Nub
 9jsJ78RuXGv9Iv2Kn6qVvfuufhk694TD7s7rV6OyqqXKUMro4FcFtrydXv9g+L01IhT6
 z65jrUofG90c33uVFh3qdTciDHr1d2N1BSJt4wxDdeMMA6XBIIeHf06ELE/82L5ARlAN
 yCK/Uh/NKkh/9uupr+ErNfq/Cl4P2QHTnX+PZ0C3QqLYRR7D2KvzETXIcGmuvLS9MiM9
 AC6g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwxyAlFSCMM4fwuYdZ1WsDWk5q/PdIfExM+l0Dh9M8tfVPkWgOZYqDkmLtvx7EyylkgWVPODLDz24=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lO/u0Es3DB5888XI9WMOFgvFmp7x4hd35B4fzTlATHkCh1ggTO
 eppx14+YSY7GPuSi3eVY6PhPfVvaB61XAWG8z14z+Z4CjG1dGUZV032qR5B8hb5TmrO+VTEfEza
 kgtAZ4KASwtlCJI6tBPxsvGuRlDroypVsC4e75383QgY6KxKTAhC+5SpbL26EmCdTz/1bhI0=
X-Gm-Gg: AR+sD10B3jiYKdnVWHupuxDINUP1xA5QxoCQCzhSwCtlKsxYU/3fTS+qL/TGg48qTCI
 SZ4RDb1s4kixMo4x2Tgmq39fjs1Zel7+pKQPJbyj3Zc6eRJbB/frrUDHu4du00cIuARNv3FlvGZ
 /d50gzjvd3cIcHnueoBFlcQg/MlsgY6o4D5vxSCK+AkfwHzw9ePeHDJdsdZr4+21H/9UbHrwqQW
 a1Qmd4WEPMtBhmOfyZayMeHlB5XSXbpzUVyxbYBV7eUupe7ad3ifaXcKZ+tLOFOVWxLMg4eHGBQ
 +1M93+4dFqfKWnAm9aC/yoDfWA2jJ9XCt605jhj0rnSUCF7vhcwUxCy6abPaLbnUa92mjOf0ekr
 hjQNFo/Z30WBWp0iICk4fuOA=
X-Received: by 2002:a05:6102:2c82:b0:785:76cd:ce88 with SMTP id
 ada2fe7eead31-785962b3bbbmr2102315137.3.1787925949699; 
 Fri, 28 Aug 2026 07:05:49 -0700 (PDT)
X-Received: by 2002:a05:6102:2c82:b0:785:76cd:ce88 with SMTP id
 ada2fe7eead31-785962b3bbbmr2102270137.3.1787925949159; 
 Fri, 28 Aug 2026 07:05:49 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbb20122sm3908633f8f.20.2026.08.28.07.05.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:05:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Fri, 28 Aug 2026 16:05:06 +0200
Subject: [PATCH RFC/DO NOT MERGE 08/12] drm/msm/hdmi: Add support for PM
 OPP table
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-drm-msm-hdmi-eliza-v1-8-67843277de17@oss.qualcomm.com>
References: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
In-Reply-To: <20260828-drm-msm-hdmi-eliza-v1-0-67843277de17@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 linux-phy@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2291;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=s+Nis8MuGrrRzdnf1zzhw5BzoyVlhTkXBQ6LijklpUU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqkZWftyhgGPop86RTp5yjaMiBi6zJ84Nk6QwQP
 L25IU3YncqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCapGVnwAKCRDBN2bmhouD
 13HSD/9qtzLXgsXADGdJyZNDKxtY3kCVyItZ5LdngLcsz3tRqh3VkBw/ZQbR2In99azFCMsr74n
 xIApgxejd7thH2CINMUr4PST/uzWZmXHU1YdngZy0A/UUnR4j761zGMUZUlwIGNUyKsF/onb0Y+
 Zf3/t1kmXoJhaIerSpgt0eAJVXr/hTckHwKuVKB4FrqEzrZQeHyUzzhxU7/Mm0ppNIoFiaBK7A/
 40nwyWl/GUkQSdJAMSgudUoXEkOB2FKMIKTexFQAsBaLFhUtpS9BiD1lyLsUgj/WNQmdzgMWm2b
 M0EFEvvl/CtKQ5k1z6+SVojT3vrQVYPbLzHvwHIloQ/u+zsJFIElMAadz6/+FkWhmjNNopn2W6M
 LpGuyXp4qWq0Ma72dlrw0wNU1bdvuyTxcspqD5TJzkw+C4uB2qWszQcCsz7217xRX5Fq+1zU0un
 UHv/lg3ZbaPkJhgWy3/37x+KJgW6UvzL62vejiFkRq2h3PfWvsmORvG7trzL8OcByQNi9holWjc
 BqSdYkMj4XnJ3FEKpJE5kX/kIy8xrdC7j3mtK0n85JrdE6T44gksOAgE9t3nGve6836VVQTS3N4
 kDXA3IMfBTkZQ+U+YmtGaEIasfEoDkIeXPpJytAzFyWuqSDD5g7qZKGOEc4a+k8gRJ3l8JcHw7c
 t9/3G/x/K4As8TQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=XKYAjwhE c=1 sm=1 tr=0 ts=6a9195be cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=a2cU2-lBnuBmNLb9j5sA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfXwCt8+jy4i4lZ
 aIm2dgBc6vxkIVYFK8rOxG6NQ6umVu4rXg9akjE7mvTJpgE3JgjMf8Wh4sy/znYGj3n7teNvs2X
 S+mWpVbLKZT9kH0Ci6BGGaCTIgiXVADnHdommIzweTBXXcot/JpQLFDOPTi7jhKL8sprETSbyO8
 Gl1tL0rs4uDRAI8ubPGxFejSUm8oDpOcv8hP7UX+B3rXW0QjeUY2MYTrvYD4Csy/WeGOtc5eMQ7
 5thncda4b4esla1b6GuyhpAZv7+G7pymyLijlR0uo+4a3gF20yGr89sSaw1edqS3d51Wadypxym
 QcOYIX+SaqmznqQ55RxdqEaYZnsC29eGeo062L7NJwPWEJsj6C/+5vJj9uQyPeMoaR+ynSb9UTE
 gDgMGQRFUdbtUJNZUwwIVPcM9KZnHGQ+cArVgYcSER2NDM1lV6CQkHTwTrU2JLCIqLvSmOFr/i0
 nTPAxjwE1m3IhBNk7MQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEyMiBTYWx0ZWRfX5aZ8F+beL6hV
 5rq+YpFJAhw05AFZgn5VbR+/eoWvJC9Kkit14CssIUj8bkCoB8Epy3lulZKajObbmxyXaSHG20C
 ANRadyTaYEJzmcDubkWDHNzllUMCmxk=
X-Proofpoint-GUID: BQmFLxwwkR4RfFpN8oonuaQ5jr5FoO-e
X-Proofpoint-ORIG-GUID: BQmFLxwwkR4RfFpN8oonuaQ5jr5FoO-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280122
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

Allow scaling the domain rails with PM OPP, which uses the pixclock
("extp").  This allows proper votes depending on requested HDMI pixel
rate.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi.c        |  8 ++++++++
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 10 +++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 474006084633..c46f30063f14 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -368,6 +368,14 @@ static int msm_hdmi_dev_probe(struct platform_device *pdev)
 		goto err_put_bridge;
 	}
 
+	ret = devm_pm_opp_set_clkname(dev, "extp");
+	if (ret)
+		return ret;
+
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "invalid OPP table in device tree\n");
+
 	if (!hdmi->hpd_gpiod)
 		DBG("failed to get HPD gpio");
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
index d0e3b27644fe..621083a97b37 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_bridge.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/pm_opp.h>
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_edid.h>
 #include <drm/display/drm_hdmi_helper.h>
@@ -30,9 +31,10 @@ static void msm_hdmi_clk_prepare(struct drm_bridge *bridge)
 
 	if (hdmi->extp_clk) {
 		DBG("pixclock: %lu", hdmi->pixclock);
-		ret = clk_set_rate(hdmi->extp_clk, hdmi->pixclock);
+
+		ret = dev_pm_opp_set_rate(&hdmi->pdev->dev, hdmi->pixclock);
 		if (ret)
-			DRM_DEV_ERROR(dev->dev, "failed to set extp clk rate: %d\n", ret);
+			DRM_DEV_ERROR(dev->dev, "failed to set OPP rate: %d\n", ret);
 
 		ret = clk_prepare_enable(hdmi->extp_clk);
 		if (ret)
@@ -58,8 +60,10 @@ static void msm_hdmi_clk_unprepare(struct drm_bridge *bridge)
 	struct hdmi_bridge *hdmi_bridge = to_hdmi_bridge(bridge);
 	struct hdmi *hdmi = hdmi_bridge->hdmi;
 
-	if (hdmi->extp_clk)
+	if (hdmi->extp_clk) {
 		clk_disable_unprepare(hdmi->extp_clk);
+		dev_pm_opp_set_rate(&hdmi->pdev->dev, 0);
+	}
 }
 
 #define AVI_IFRAME_LINE_NUMBER 1

-- 
2.53.0

