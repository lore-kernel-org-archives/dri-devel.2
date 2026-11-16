Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B725606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 12:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uIefefS2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC19F10EFC7;
	Mon, 16 Nov 2026 12:12:02 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 889B410EFCF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 12:11:56 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso20589115e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 04:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794831115; x=1795435915; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pEbQYi4NjQVP0dtbEgl40Tg4qtmWWlkw/cjXJIhkZZg=;
 b=uIefefS2/qzP1h1TTc+5UWhlBJWNbmGIgJktN6lVBxWV3s6GzyPRFikg4SHaeUpqzx
 SY8TOe1h2V7w0JFCkfGpRqFjFdiotbUog4MISflgJ51gE+JivQUE6J9IOFEhQDZbu7w4
 gw09S55lVdDdEc2fZAB4vkB/R4gyhX9O1IX7vxVq+O0M63aSSD1Tj4QWCXE7bhviw0Yi
 utXU+EvMgfdPeskTuwPvkwXKWbpSOg32pw9lDlEPLsmMvajoBlNfi7pDdqjT+Oo3cgK+
 rSaLL4Prm4b96rPYJyHGWwRDkdT7cbAFRUr6twSckEAjA4wtrcRJyGrhkBatVDTj0g9L
 l3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794831115; x=1795435915;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pEbQYi4NjQVP0dtbEgl40Tg4qtmWWlkw/cjXJIhkZZg=;
 b=cTx4ZJ9srq1OSX+3co/narVwxSSs1GAR6QZ2kn7rFX8VFfMda8EJNYfrnnFVoRxkxQ
 QsDN68J+MsYGXYiOA7TppkYQ0tEafEJ6tvM0vQ+4jGIIv+tslBRVodA3xoNBtffiE2v3
 Y02DPn23bX1Yfw8lPUmDwNLGhk2qjbgrrPmg7zTW+D7XPbcrxxN3Vxl/ycl0VUM7pOKr
 qn5NTygBZW2tsZg6xY6PJKEA64Uz8bFLjAjwlvK7tnMtLm0sF9ez4Q1BGO/Cu46bGvCa
 ugR2RqmQGkxnmSq2SiTPyc/rQIjmJ4dPNQ1VPj4Qsqyg5Z9xPqqPpm/8lSGQNAUlQCsT
 jrPA==
X-Gm-Message-State: APuU4Z+C4VxNfJbYYs8o6BNIZM0TijOK7Mm+3efJ7XZRawsq5Fqf3Qwv
 CEh+tewQ1Ln/NjLSm65OEr6R+UOPBuYbCMFtSZPPy1kgWK68SCARLlri
X-Gm-Gg: AYBFou1Yos/T4pPzeOQJ8zq690fMdYFIjYS4IGDcEx285wPp9Ah7+LOhcbkHsiHexkl
 neFrj8EkHk7o8IWcn6jMf801fM8JYolov55M9lBHIKxF7Z0jv1OpYMpAYoIJB3tgNwD+ZazZ1fh
 ohbo9aRFwsOqelOpqTJZX7002tlfoIxirjAUcckXhrUIphGoRhT8MYqQc1BodsnqEF3ocn9pftQ
 X4aLgtHI469jh+XAoqgsESPNz0fztcKDpFiv+gkiRYv4ZwpykYKEYImFCqyndetJKXWFjVeLId5
 ov5pm2HvJUfKqwpuIexfoVAsdyonleNfItKg6n25uqLM2a2TXHDlmal7g+Si1MiM0Jd/+OKcABC
 4lXoe+ZdO3RKfPxOcSWJRN97lysSKkYbIsJeTYzfQ51WbiLpcV1FEmsDV75rZ9Ao2Wwg+bzp+mf
 4KGXNMs3A0Jl+VTWy9iC9D4hO2eymEd8h6kiC/n9Y6GeLYoOarPEcnLIrAawtIxAhYylhSi3MsZ
 x140/GTm6pg8JT1ug4u1W4Oknd3UFptzqrWX/cmCRNpZCt8YJhMGr31BGxA2BDXKwUdoqgxNEei
 QBXeN2MOclgbIZaY1xWcO2HW/+3blo9BL7l9rP16NmCwJKJsNQJcId9wvdI0IMDwvwOvIhP9CkL
 TFEr68Bh8x/Lq6sjQdSS0kuc9BC4jcYWAmV1CsRh++m0m1W9GX/U=
X-Received: by 2002:a05:600d:41c9:b0:4bb:60bd:5398 with SMTP id
 5b1f17b1804b1-4bb60bd5507mr142579815e9.10.1794831114708; 
 Mon, 16 Nov 2026 04:11:54 -0800 (PST)
Received: from localhost.localdomain (80-108-121-211.cable.dynamic.surfer.at.
 [80.108.121.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb70105a98sm61442005e9.5.2026.11.16.04.11.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 04:11:53 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
Date: Mon, 16 Nov 2026 13:11:49 +0100
Subject: [PATCH 2/2] arm64: dts: imx8mq-mnt-reform2: Drive the internal
 panel from DCSS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-reform2-internal-panel-v1-2-765cf8d5ff4f@igalia.com>
References: <20261116-reform2-internal-panel-v1-0-765cf8d5ff4f@igalia.com>
In-Reply-To: <20261116-reform2-internal-panel-v1-0-765cf8d5ff4f@igalia.com>
To: Douglas Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, "Lukas F. Hartmann" <lukas@mntre.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Christian Gmeiner <cgmeiner@igalia.com>
X-Mailer: b4 0.14.3
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Christian Gmeiner <cgmeiner@igalia.com>

The panel is driven by LCDIF through the NWL MIPI-DSI host and a
SN65DSI86 eDP bridge. LCDIF underflows at 1920x1080. The picture shows
horizontal streaks and the underflow flag in LCDIF_CTRL1 is set several
times per second, even when idle.

DCSS does not have this problem. Connect it to the MIPI-DSI host and
leave LCDIF disabled.

Use IMX8MQ_CLK_DC_PIXEL as pixel clock, with the video PLL at four
times the panel pixel clock. The DCSS binding only allows three
assigned-clocks, so the PLL setup is in the MIPI-DSI node.

Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 .../boot/dts/freescale/imx8mq-mnt-reform2.dts      | 52 ++++++++++++++++++++--
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
index 3ae3824be027..31c7428f0386 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-mnt-reform2.dts
@@ -171,17 +171,61 @@ edp_bridge_out: endpoint {
 	};
 };
 
-&lcdif {
-	assigned-clocks = <&clk IMX8MQ_CLK_LCDIF_PIXEL>;
-	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>;
-	/delete-property/assigned-clock-rates;
+&dcss {
+	clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
+		 <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
+		 <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
+		 <&clk IMX8MQ_CLK_DC_PIXEL>,
+		 <&clk IMX8MQ_CLK_DISP_DTRC>;
+	assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
+			  <&clk IMX8MQ_CLK_DISP_RTRM>,
+			  <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>;
+	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
+				 <&clk IMX8MQ_SYS1_PLL_800M>,
+				 <&clk IMX8MQ_CLK_25M>;
 	status = "okay";
+
+	port {
+		dcss_dsi_out: endpoint {
+			remote-endpoint = <&mipi_dsi_dcss_in>;
+		};
+	};
+};
+
+&lcdif {
+	/delete-node/ port;
 };
 
 &mipi_dsi {
+	/*
+	 * DCSS takes the pixel clock from the video PLL. The PLL runs at four
+	 * times the 138.78 MHz panel pixel clock.
+	 */
+	assigned-clocks = <&clk IMX8MQ_CLK_DSI_AHB>,
+			  <&clk IMX8MQ_CLK_DSI_CORE>,
+			  <&clk IMX8MQ_CLK_DSI_IPG_DIV>,
+			  <&clk IMX8MQ_VIDEO_PLL1_BYPASS>,
+			  <&clk IMX8MQ_CLK_DC_PIXEL>,
+			  <&clk IMX8MQ_VIDEO_PLL1>;
+	assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_80M>,
+				 <&clk IMX8MQ_SYS1_PLL_266M>,
+				 <0>,
+				 <&clk IMX8MQ_VIDEO_PLL1>,
+				 <&clk IMX8MQ_VIDEO_PLL1_OUT>;
+	assigned-clock-rates = <80000000>, <266000000>, <20000000>, <0>, <0>,
+			       <555120000>;
 	status = "okay";
 
 	ports {
+		port@0 {
+			/delete-node/ endpoint@0;
+
+			mipi_dsi_dcss_in: endpoint@1 {
+				reg = <1>;
+				remote-endpoint = <&dcss_dsi_out>;
+			};
+		};
+
 		port@1 {
 			reg = <1>;
 

-- 
2.56.0

