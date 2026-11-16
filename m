Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EE3606A329
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IN5V/NE0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h4ggh67P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 973A410EF8A;
	Mon, 16 Nov 2026 11:35:09 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF76A10EF8A
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:58 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGBLFlt449964
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 McYXQoZTRR4jelBpYJQLXbTjC1H0/Dkidy5fvWiEook=; b=IN5V/NE0Wj3QuPDj
 2wklJ9MTqjKUKIQfxAPHx+aZ8hdGJPnCjQDj76XqLmYl3CRcdPczHp8BkZRJ9znA
 PpfZKM2TiaPd2oV72D/leOkjhLT7to2LdutFNVU9GOaCgP4E9Tluj01dClvLz8MK
 RKDgEpU2Sj+wCwJWM0m3AkkAdVKiwWdnYXb/IrP/ltDCD5bpdEtMwcWLof/8qmBS
 lkgN3SGG35nitvS2hKgSZzyATH/oooTLgWv9E/4C+tm4tQ4uGPlI9esKX8GtSmgu
 KtmAW4mxlPv81oxea0D+AaX+lILG3JJeCKxqODhZOAKHHUa2r7egQBxAZVPb/54R
 u7BRkA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hyyqggaaa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:34:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd0cf3b1c70so1916806a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 03:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794828898; x=1795433698;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=McYXQoZTRR4jelBpYJQLXbTjC1H0/Dkidy5fvWiEook=;
 b=h4ggh67PJ7lFu2EBbzfkme+iXMNQ8E8kg1++IKNhm2Cst4OJa9/t+CT8xe3/qF6iy1
 hMNlXZI38GY4NP5MP9NCkCilG6AJxL8D6AINLiRw0D4+DX7JsajObd4qRjMA3ac0kMIL
 eX6MfwO5rO0lAVIdY9AZLhIM0wCAPilMU59nzqWRFbofhQ5fj0YdsrjjPOrIzeFeCrVl
 eXLwSn7kRJvsBEL0Fm8MB8Vcy1aX8GAiTXz/tsybE5Gk2l7X2UG3Km49Vhy3QeXvIXON
 b6aOYMqLuAaqyPoC8lsD1lQVwOKdGIFbVBUekhR5T8zDZEpIX5siCUc2CX44MR7dzTAq
 Z0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794828898; x=1795433698;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=McYXQoZTRR4jelBpYJQLXbTjC1H0/Dkidy5fvWiEook=;
 b=UgCDdQ7YUuXlWHqFPBEU4xZW45lnhNn3TT6zUQhjSPvQHiXylvFcMAvkwRdzLcrW2w
 NwEH03+vnsZMkAsfj3l3bMTsAHMa/Tpxienn+Wxj3PiI74DQ+X37ci8gDY8Xk6e/kjaw
 b8iUjM+Btb0zYOGJIrxHd7pgaz4hQpRjATnmkguWGrHuM6oG1G7SeGFPJgVI+7Ttr1h+
 V0UuS/HBPqAdSQs7/n1DifuLUdq1iAN2A8TrlwGADeeExLA8fH/ke92diVG8uhpwMY69
 deTd9iMiHUlm5YFe6LJetYYryn+RPkiwsyWitJPhmiNnUkSil/6Mv66gCD5ewQuiyTyB
 Ma6Q==
X-Gm-Message-State: APuU4Z+aIjExe62i8nVciZ21yWYHCP818k/D+o+x4vpy/dN75kkV5I+o
 47sFxNRDz6cqBMUsX3OuK+QtYbfvPwosIWaB2hF9D/y4ws052ggDXTW/y+ItPPOxgfhqfIzHXPO
 ZtbyPPLXpdhPyu9hYTACzbWtbuX0AXUL84+1ZLvSUk5/ekIHz1hRYvxkN4Ps9tB12qHjKKWv0aX
 E/7qA=
X-Gm-Gg: AZFdTZfBhmG5CdwS/fFmC9Zb6F/Vw0MqvTz7ARNNUIirxV0zv/SwC+syPUh0XUgalAL
 W69LbumbenZwWLZiCt6Lly4iy/dP9uZydP2G5p5a0iYc0i2C/yiBA7uLcxGVf04XXwtmFFnZZfA
 A/jrAmcxri9OICvFPz8DUc9l8oE6afb3RC9RpCDg/+VACRHYSY+ZksFxtKCVPpP/1x+GIDI8B20
 UDha3B2i9MmXc9KePQWmfOQWuOP+Rceo4V4xcmjaUpW4VCH1NBABDr0rP2fyJvEqbwhpVaNBP2v
 5XTxy0qjcF+2Y1HHeSYlTq0zqUBhJ9dyV9VaYzmDbykR4c/BlcSecAl7CpcWprJ616hILKJ5kXe
 v+I/xJamiBhiiwVc926k2lmHr5rF7UApJyMcqoEmvxv51bOteq2sjuTYCDUggGN7jjNxKJeUGrA
 g+
X-Received: by 2002:a17:90b:3985:b0:3ab:b39f:41c8 with SMTP id
 98e67ed59e1d1-3b1b0b53626mr9701294a91.46.1794828897309; 
 Mon, 16 Nov 2026 03:34:57 -0800 (PST)
X-Received: by 2002:a17:90b:3985:b0:3ab:b39f:41c8 with SMTP id
 98e67ed59e1d1-3b1b0b53626mr9701256a91.46.1794828896692; 
 Mon, 16 Nov 2026 03:34:56 -0800 (PST)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b197d27d26sm21000719a91.13.2026.11.16.03.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 03:34:56 -0800 (PST)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 17:04:05 +0530
Subject: [PATCH v2 2/4] drm/bridge: Add a driver for the Parade PS195
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-mahua-hdmi-v2-2-0b5af6bf9e70@oss.qualcomm.com>
References: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
In-Reply-To: <20261116-mahua-hdmi-v2-0-0b5af6bf9e70@oss.qualcomm.com>
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
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794828874; l=8574;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=u3JvQjryjspDemBxOKTLJflG54nVSgowfdSpO4RkoPI=;
 b=zJnv6dFaTzzCbDSBBuuxaPG86dZSn7btDV4cHf8Ks9tuuV51Ws3cNSur5+E8/+4E5dWepXDcE
 3FUpOXAtryIB+RL9U9isfn8TkGobkFjTzPxEucJLf9XRxexTKdxirrE
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX47sfM71cpvBY
 qX3sibvHqm6VrDWs+89PR5CSgGXv32QxHoF6DAxthzQ9ElXMypsouZVZgNLjKGn/Xhg65Bb0M1o
 lyQtu+ggoXVzlbk4cgWCTh5arOYLc2k=
X-Authority-Analysis: v=2.4 cv=epRKXYpX c=1 sm=1 tr=0 ts=6afaea62 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=e5mUnYsNAAAA:8 a=cm27Pg_UAAAA:8 a=_PMkZo2J1_9kd9osg98A:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: WrJo6Q1KV2Jq5K4Ee26zSnB6_KPEHwpS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA0NSBTYWx0ZWRfX66Gg6ZgB2dDd
 b6eA9hX54TwkU3qhdvFpqeeMhhFpD7slbNp3VH38f/r4MC1F4HZl9Dtgh0m2ON9RN92RX+MtCZg
 MSKQ5eKjCytGvtGZTWFwDhtEG81hJFZXzH+xtRtANIkcZQvsr4/HontsNOolsS0HVAkOyKOrqJa
 i/c41IDVGONWAg0RiJRF9L8b2KW6XwYiD7sfHG2hcKj6cl6sgSnpg7Jw8/yfHNQrEJiEK9OhXJ/
 glM5dISJrnXrzX5OyyAP7mnvmJFV+8uAhtRj8JOAVxKPICoQgeJOgkHfZptT/ktj/azG57z7zI4
 xEDXefQbkyBxT1Kz+VshqarlM9BIXjreYNFgUOuC/24mf8TKIJJU10OBJHFTeA8WdYmp4eF0rnc
 A4JveOSHLP8meO1mzUe0HTII1u8bGf1jvRobpib7+rbuTuIZY+nShx1DRWbOud6vDNV91smJ/H8
 eNWQABaJ7f5naxOjZHg==
X-Proofpoint-GUID: WrJo6Q1KV2Jq5K4Ee26zSnB6_KPEHwpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160045
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
from external SPI flash. Add an I2C bridge driver to sequence its power
supplies and optional reset GPIO.

Keep the bridge powered for AUX and HPD handling between modesets. Use
late suspend and early resume to order power transitions around the
display controller.

Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
 MAINTAINERS                           |   1 +
 drivers/gpu/drm/bridge/Kconfig        |  10 ++
 drivers/gpu/drm/bridge/Makefile       |   1 +
 drivers/gpu/drm/bridge/parade-ps195.c | 204 ++++++++++++++++++++++++++++++++++
 4 files changed, 216 insertions(+)

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
index c7da6b02d7b6..a14128d611d7 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -273,6 +273,16 @@ config DRM_OF_DISPLAY_MODE_BRIDGE
 	  It exists for compatibility with legacy display mode parsing, in order
 	  to conform to the panel-bridge framework.
 
+config DRM_PARADE_PS195
+	tristate "Parade PS195 DisplayPort to HDMI converter"
+	depends on OF && I2C && REGULATOR
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
index 000000000000..6f92681497be
--- /dev/null
+++ b/drivers/gpu/drm/bridge/parade-ps195.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Parade PS195 DisplayPort to HDMI protocol converter
+ *
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
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
+	ps195_power_off(i2c_get_clientdata(to_i2c_client(dev)));
+	return 0;
+}
+
+static int ps195_resume(struct device *dev)
+{
+	return ps195_power_on(i2c_get_clientdata(to_i2c_client(dev)));
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
+static int ps195_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
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
+	i2c_set_clientdata(client, ps195);
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
+	/*
+	 * Firmware drives DP HPD and services AUX, including EDID reads,
+	 * before a modeset. Keep the bridge powered while the system is
+	 * awake, including when no monitor is connected.
+	 */
+	ret = ps195_power_on(ps195);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, ps195_power_off_action, ps195);
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
+static const struct i2c_device_id ps195_i2c_ids[] = {
+	{ "ps195" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, ps195_i2c_ids);
+
+static struct i2c_driver ps195_driver = {
+	.probe = ps195_probe,
+	.driver = {
+		.name = "parade-ps195",
+		.of_match_table = ps195_of_match,
+		.pm = pm_sleep_ptr(&ps195_pm_ops),
+	},
+	.id_table = ps195_i2c_ids,
+};
+module_i2c_driver(ps195_driver);
+
+MODULE_AUTHOR("Mahadevan P <mahadevan.p@oss.qualcomm.com>");
+MODULE_DESCRIPTION("Parade PS195 DisplayPort to HDMI bridge driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1

