Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AADB606A887
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NZ2jUCMi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PHjyu9Dg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78B6010FFB5;
	Thu, 12 Nov 2026 10:16:14 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D8BE10FFBE
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:03 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AC9E2wd480282
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hnpC1o4w+tOv95d2csXSbIs144vrlpYd+10v5+15MJM=; b=NZ2jUCMiHpSqqMx6
 zlYsMBe4yryxiEmUOxgaAidd6FJWGTieuc+L6GVydo8BBcAeKKXxYhxiphp2qxCC
 ZT5aSfLUQyEgqOa+FxU+37WESK87eivItemtJu4bGeHh2XXVAYkq+84HFcHW0lJV
 CTRnxlhQN5puNUYN5R4rSoWhqTAy5VN+l/Fl20PdyPltEv73uGxLZO9WZhksqh/w
 DXBcToxupO4ZqTooLp4cjUHzw/HLipafsP2QW+fycch2FFdH0CMtDRqEOontvkKz
 0YT+rOW+BpcHl3F579u4UOTtjDZKM6oJCjRm1Wjbp0oM+K0VBKlbjQvHA4HteyMJ
 XWJW7w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwan4r77p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 10:16:02 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8b69d1f2a18so638336b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 02:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794478561; x=1795083361;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hnpC1o4w+tOv95d2csXSbIs144vrlpYd+10v5+15MJM=;
 b=PHjyu9DgUfNPuK6WGzOX+zvbmhKrqO2obCEzBpP9iWc5xJVtR+xNaf/XTdVM10o+Wz
 BBOFV4eEIDypBUnbAgd2C8O7JsoANL/+aDxVeX6LpaAqdMELeHhZagh5ssmB40+wSwH4
 tA+U5WXknD3hbbqzvVYq5MiS4OdQyZYp3inWxUqPfMd1uLJIppVL/7FdFF14xYAFn+ma
 2IZ9+FgpDw5poiWFsCd5NCvmktwZjB1LT3r/Z5G4wggyiMzYb4kKpzx37qiOPXLimo1R
 b0+pZSesiG4/VIWnJ0vvOlTB8uXjswhT8MoKD8Qx/xYePzPILh8mRiIZ0S7Urxd9NGVY
 72oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794478561; x=1795083361;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hnpC1o4w+tOv95d2csXSbIs144vrlpYd+10v5+15MJM=;
 b=2kAFlRrNsk9bGp5cLdH0BaWi5vzN9E6fPvT7y78z0foTyc8jKrofHP0IEmUa3kwYEe
 1UTmxMaIRqVJfnojbmcsVOMjbfzsZrVfr6Ro6kBZtEfXK7XMOs1x7xwLW7y4Cdw2Vpj/
 WSOaFnmmaNpkaj2Zv4WUYsDr2rO9ldNg4E5fxlzuphA5wb8pKwMlV6+VqvRN0+ae59X1
 EVzj9m1O7Yi701eZkCCVxwXXHGOtxBLSJWduq5voUwGNIip+3yKUnjmd/kfPTeoSxhle
 /INWZDdsekgI+mQGMz6xfBOEOZRx5wq+8YthdTYeXeBcKYYMMzChJ6BiqNLFhgNpstps
 XHBg==
X-Gm-Message-State: APuU4Z/QIyTSva67wsgGkJ0jZXSpRuljhrp/nfBIhieIoIOzydR9gea+
 EwWi5vnmRFO8PPMQrEIjqDNml4iOfSetpXDY2cqDgyWHh3STKMtxaDW0iqO0d22588z0aLn75Lq
 emkmxarI/3Md/L/IrPAvHh/2qyO1Yq4DNEByXpD17aFSy4TChEl/5blhpFMh6RR2j/3wQkTE=
X-Gm-Gg: AYBFou2cnZO1DnfR265LaQ8ZjjqXVIGQJ83w/HSLQjCjJjQgp8COnf06RLI1FRK8mwp
 Eg0C3tTN963qZ2kvTlm8CCAVZDQK2NrgTk5yIH9cugWLJXW8Te+zfO6D24WPENiRoVMJZzH3dyr
 02FDzD8cSpTTx6nfGf+GcQ8c4pUxcDc6Myu510qsUg92/6P7SIEWiYe2tMEIBemKUBbQQoizxh/
 cZWOIwGw2Rr8T9iCw6ciXZyEh2iXQJ3dbuvwJ2iJzdfEY2GCbKl2U3wyOmLhYAc5tl65vbDskIj
 sGH6cWxRSFZ+vZVyqwE0tfbRKCCVCKO9aITSoYDzzsfnUTjweyD/DQL23InTLhS2jLQLnUkqhLL
 MCZm3Ipy56UfVIuhkQmeCJu9x/mCXkKLLdQjys1c+ZzvMpzSC9qewyQ0LcoFeaallbDKKfRORd4
 Ju
X-Received: by 2002:a05:6a00:10c9:b0:886:490b:f1d2 with SMTP id
 d2e1a72fcca58-8bd5d258143mr1421612b3a.23.1794478561018; 
 Thu, 12 Nov 2026 02:16:01 -0800 (PST)
X-Received: by 2002:a05:6a00:10c9:b0:886:490b:f1d2 with SMTP id
 d2e1a72fcca58-8bd5d258143mr1421596b3a.23.1794478560481; 
 Thu, 12 Nov 2026 02:16:00 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8baaae3e110sm3185872b3a.36.2026.11.12.02.15.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 02:16:00 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 15:45:35 +0530
Subject: [PATCH 2/4] drm/bridge: Add a driver for the Parade PS195
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-mahua-hdmi-v1-2-b463d7b1dd7e@oss.qualcomm.com>
References: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
In-Reply-To: <20261112-mahua-hdmi-v1-0-b463d7b1dd7e@oss.qualcomm.com>
To: Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794478537; l=8398;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=Ev1YoXF6RmFg1bXBqI4pX+IenS+MD6ysl7ouGSoK85M=;
 b=bKmVS912mH3Zn5le0h7vNkNM7Ei1aVg0ZHVin3dKBPU6VFYoYmw4pUVNvFhRRTsjZhnZ79H8o
 LtwTg4KW2UZA9PJ+ZxjrUNYa2tFjqVWPo7YMWv/KS8qu3VDxDjYc/Qq
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: _oN6122VisVd8RNAKf7tcp94V65e3vaV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXzeYyOhTe4gyT
 AvF6eLk67A35mvT8Mvb+vKgKU1KhbWkdswmPwgD6R1cl0cfEWtiQCr0O0qqrQVYx12UVQiQhu/F
 lOuEEbWx1N/BR4hBJna5l+exIRRxbJk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA0MCBTYWx0ZWRfXyuZaekP8zd8w
 BTagfKxRf+7NGKZBHdAC66727G9ocBgucLi3Nz/4HvRAxoPg9N8wvUNaqBEgz4ds6E2DziqK32H
 gFXQ9d0qgti5gkIGsqbotZBUom8OceFmBBCQmxq/YKmFZGRto6FZz833IqU7ATIVs6VAJOjOI31
 YQ82ZT+MI+izMeRFHC5NIYRA4fmaMAQKx8OYw6H0eYH4HSPLJ5T84/k2TIyTiMh6ee68o6pgHTz
 lhaOJQ0RqraauOFM/HtLQXhDIiyK+2UmQksz6WbFLFcdRFrxEUSWqNccvrIffxUAiNpz8uFfoAs
 8I/lU0YS/v4euaesG6racLhxOaWAUxR2aTokESMOtzLuaIQK/Ge49pWDKIg9QMW0fMZxy5LUeG8
 /hgMYB1Rzn5kBZ1i/hePoT2MmKVchlRiR431WVo2pidd2C2i/03Iq0Sv8VaRe/kxH678Z5TGpH5
 9zCfhYYEVre9EO8UZTg==
X-Proofpoint-ORIG-GUID: _oN6122VisVd8RNAKf7tcp94V65e3vaV
X-Authority-Analysis: v=2.4 cv=Gd+CDgXL c=1 sm=1 tr=0 ts=6af591e2 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=cm27Pg_UAAAA:8 a=_PMkZo2J1_9kd9osg98A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120040
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Mahadevan P <mahadevan.p@oss.qualcomm.com>

The Parade PS195 is a DisplayPort to HDMI converter that runs firmware
from external SPI flash. Add a platform bridge driver to sequence its
power supplies and optional reset GPIO.

Keep the bridge powered for AUX and HPD handling between modesets. Use
late suspend and early resume to order power transitions around the
display controller.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 MAINTAINERS                           |   1 +
 drivers/gpu/drm/bridge/Kconfig        |  10 ++
 drivers/gpu/drm/bridge/Makefile       |   1 +
 drivers/gpu/drm/bridge/parade-ps195.c | 197 ++++++++++++++++++++++++++++++++++
 4 files changed, 209 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e1db88ec1c9..cd83b47d9f85 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8586,6 +8586,7 @@ M:	Mahadevan P <mahadevan.p@oss.qualcomm.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/bridge/parade,ps195.yaml
+F:	drivers/gpu/drm/bridge/parade-ps195.c
 
 DRM DRIVER FOR PARADE PS8640 BRIDGE CHIP
 R:	Douglas Anderson <dianders@chromium.org>
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c7da6b02d7b6..abb1aa36ce3d 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -273,6 +273,16 @@ config DRM_OF_DISPLAY_MODE_BRIDGE
 	  It exists for compatibility with legacy display mode parsing, in order
 	  to conform to the panel-bridge framework.
 
+config DRM_PARADE_PS195
+	tristate "Parade PS195 DisplayPort to HDMI converter"
+	depends on OF && REGULATOR
+	select DRM_KMS_HELPER
+	help
+	  Enable support for the Parade PS195 DisplayPort to HDMI converter.
+	  Its firmware handles the display protocol; this driver controls
+	  the power supplies and reset input.
+	  When built as a module, the module is called parade-ps195.
+
 config DRM_PARADE_PS8622
 	tristate "Parade eDP/LVDS bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 15cc821d85b7..425722c7becb 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v
 obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) += microchip-lvds.o
 obj-$(CONFIG_DRM_NXP_PTN3460) += nxp-ptn3460.o
 obj-$(CONFIG_DRM_OF_DISPLAY_MODE_BRIDGE) += of-display-mode-bridge.o
+obj-$(CONFIG_DRM_PARADE_PS195) += parade-ps195.o
 obj-$(CONFIG_DRM_PARADE_PS8622) += parade-ps8622.o
 obj-$(CONFIG_DRM_PARADE_PS8640) += parade-ps8640.o
 obj-$(CONFIG_DRM_SAMSUNG_DSIM) += samsung-dsim.o
diff --git a/drivers/gpu/drm/bridge/parade-ps195.c b/drivers/gpu/drm/bridge/parade-ps195.c
new file mode 100644
index 000000000000..beddb23c38ae
--- /dev/null
+++ b/drivers/gpu/drm/bridge/parade-ps195.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Parade PS195 DisplayPort to HDMI protocol converter
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge.h>
+
+/* Enable the supplies in this order and disable them in reverse. */
+static const char * const ps195_supply_names[] = {
+	"vdd09",
+	"vdd12",
+	"vdd33",
+};
+
+struct ps195 {
+	struct drm_bridge bridge;
+	struct device *dev;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(ps195_supply_names)];
+	struct gpio_desc *reset_gpio;
+	bool powered;
+};
+
+static void ps195_disable_supplies(struct ps195 *ps195, unsigned int count)
+{
+	int ret;
+
+	while (count) {
+		count--;
+		ret = regulator_disable(ps195->supplies[count].consumer);
+		if (ret)
+			dev_err(ps195->dev, "Failed to disable %s: %d\n",
+				ps195->supplies[count].supply, ret);
+
+		/* Allow discharge before disabling the next rail. */
+		if (count)
+			usleep_range(1000, 2000);
+	}
+}
+
+static void ps195_power_off(struct ps195 *ps195)
+{
+	if (!ps195->powered)
+		return;
+
+	gpiod_set_value_cansleep(ps195->reset_gpio, 1);
+	ps195_disable_supplies(ps195, ARRAY_SIZE(ps195->supplies));
+	ps195->powered = false;
+}
+
+static int ps195_power_on(struct ps195 *ps195)
+{
+	unsigned int i;
+	int ret;
+
+	if (ps195->powered)
+		return 0;
+
+	gpiod_set_value_cansleep(ps195->reset_gpio, 1);
+	for (i = 0; i < ARRAY_SIZE(ps195->supplies); i++) {
+		ret = regulator_enable(ps195->supplies[i].consumer);
+		if (ret) {
+			dev_err(ps195->dev, "Failed to enable %s: %d\n",
+				ps195->supplies[i].supply, ret);
+			goto err_disable;
+		}
+
+		/* Allow the rail to settle before continuing. */
+		usleep_range(2000, 3000);
+	}
+
+	gpiod_set_value_cansleep(ps195->reset_gpio, 0);
+	ps195->powered = true;
+
+	return 0;
+
+err_disable:
+	ps195_disable_supplies(ps195, i);
+	return ret;
+}
+
+static void ps195_power_off_action(void *data)
+{
+	ps195_power_off(data);
+}
+
+static int ps195_suspend(struct device *dev)
+{
+	ps195_power_off(dev_get_drvdata(dev));
+	return 0;
+}
+
+static int ps195_resume(struct device *dev)
+{
+	return ps195_power_on(dev_get_drvdata(dev));
+}
+
+static const struct dev_pm_ops ps195_pm_ops = {
+	/* Keep AUX and HPD available until the display controller suspends. */
+	LATE_SYSTEM_SLEEP_PM_OPS(ps195_suspend, ps195_resume)
+};
+
+static int ps195_bridge_attach(struct drm_bridge *bridge,
+			       struct drm_encoder *encoder,
+			       enum drm_bridge_attach_flags flags)
+{
+	return drm_bridge_attach(encoder, bridge->next_bridge, bridge, flags);
+}
+
+static const struct drm_bridge_funcs ps195_bridge_funcs = {
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.attach = ps195_bridge_attach,
+};
+
+static int ps195_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ps195 *ps195;
+	unsigned int i;
+	int ret;
+
+	ps195 = devm_drm_bridge_alloc(dev, struct ps195, bridge,
+				      &ps195_bridge_funcs);
+	if (IS_ERR(ps195))
+		return PTR_ERR(ps195);
+
+	ps195->dev = dev;
+	platform_set_drvdata(pdev, ps195);
+
+	ps195->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 1, -1);
+	if (IS_ERR(ps195->bridge.next_bridge))
+		return dev_err_probe(dev, PTR_ERR(ps195->bridge.next_bridge),
+				     "Failed to get output bridge\n");
+
+	for (i = 0; i < ARRAY_SIZE(ps195->supplies); i++)
+		ps195->supplies[i].supply = ps195_supply_names[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ps195->supplies),
+				      ps195->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get supplies\n");
+
+	ps195->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ps195->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ps195->reset_gpio),
+				     "Failed to get reset GPIO\n");
+
+	ret = devm_add_action_or_reset(dev, ps195_power_off_action, ps195);
+	if (ret)
+		return ret;
+
+	/*
+	 * Firmware drives DP HPD and services AUX, including EDID reads,
+	 * before a modeset. Keep the bridge powered while the system is
+	 * awake, including when no monitor is connected.
+	 */
+	ret = ps195_power_on(ps195);
+	if (ret)
+		return ret;
+
+	ps195->bridge.of_node = dev->of_node;
+	ps195->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
+
+	return devm_drm_bridge_add(dev, &ps195->bridge);
+}
+
+static const struct of_device_id ps195_of_match[] = {
+	{ .compatible = "parade,ps195" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ps195_of_match);
+
+static struct platform_driver ps195_driver = {
+	.probe = ps195_probe,
+	.driver = {
+		.name = "parade-ps195",
+		.of_match_table = ps195_of_match,
+		.pm = pm_sleep_ptr(&ps195_pm_ops),
+	},
+};
+module_platform_driver(ps195_driver);
+
+MODULE_AUTHOR("Mahadevan P <mahadevan.p@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Parade PS195 DisplayPort to HDMI bridge driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

