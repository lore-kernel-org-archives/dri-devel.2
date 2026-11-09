Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DF0606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=NTGdNpFJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0925C10EE96;
	Tue, 10 Nov 2026 08:33:40 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 980D210E10A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:23:28 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso5789315e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794227007; x=1794831807;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ovhJqwiGS9k51qlnCtIasc39GdwQ5iWAHEWL5fIwMpY=;
 b=NTGdNpFJhqI9+qffkh7dPuS7B72SGdwawXhme2xXahXZDdJh2eBGI4i3IC8NSfo/bl
 WQD3+xC90g8xozIKzWVzd8sq3lfbpW09VBcs0Kqv18D+5dbslpQA8Yh3FqQd+85gH9iS
 nKg0SSkAU8x+/8qMJkLUezyzvlOJNQu1gkFNOOOjmHr6aFw+oiWOPEZYpWrWo1jMXEb2
 w0GMUsW6kHsELWa0DTsQpvmzsBPRi2zBj/3/UvWMqLY2Ei8ErF3sbMD1g7p5jxlXWn5D
 7ESBPzg1Bc9MTI+/53WA+2kLIPP6q1f4G6HI5M/icyB/A23AwcxgjXZBgjPqgrJA8PKc
 9lAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794227007; x=1794831807;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ovhJqwiGS9k51qlnCtIasc39GdwQ5iWAHEWL5fIwMpY=;
 b=pimAO2bQViXnMvFMoAasUthRU9oIF046x2uiKxNRS8sq6637sahVXoZiVZvXJyIyks
 LZ7YYFCEM6DULS5bwvK5kkxJLNTfQ5sLBax8oWhpbRS0Q5QuwCGlrYT4MK4qzmj4Sy2F
 68gLGMlBzYWFxIuiTGRQaAl7otFRC1WX6bkOEryHWhFIjApop2Qd/F1sJWVG5poBOTZY
 u8GN3BXsoakvt7R7RArfQak9vI+9IF50q10inr+DtcKD9i3mSZckG47hcTKLEA14ltHP
 DxTMKdAbDWaP/oVGRMDwKtKk2Ykem1BpxLT+NKTjTMUqB2a/Ea5erobFtvuj2plZsn8+
 jESQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGXhaEcIDFFMU4IJgPP3nhyPDPaUtcD2iMjmuPj5hQl8vWnoVzSwVMcIzi4awBhf/3VUKVIEKAAK9w=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/CnBeT+NHjeCrwRcmEa8TwdkfXWbaf1QhjNxcyq9Whakl1v3bl
 9qAwGuKhtUu1ZLV1iGUbR1yr8tPeLV0r7i9VfEQ8Jw2wDuWT6DQ5SWKgQ3lgrq9+81w=
X-Gm-Gg: AYBFou1Q5xMzzmNqXIJz1qBRzo6rpGepzFISoETPQjRDchnwQIQS54ervZQuT/Ki6+U
 HntaKyX5JZLJbKbupkH9Txf0ZYN6kGLhoO2KBMqGCv6Hk+foUdL36nTp84dHOcyAcse1AzcOALA
 k91xLbxwwdtvN7BaSbE7jaTvqp6xItJdk6iv7jHVPd6vcP0d9dSnl7hxJYeisPPsNkCRvIAGpuY
 D/lxg659p2qx8vuWdPGtCA2GwEw3i3BiLozcGAhKHLxSY+V26KJmfNg717dWRQo5x1BOo8Wt8sc
 yFb8cc62pfP78AAFn1QrOp/lasxpyGiCLEHxYjzL6iO2zuXxeiwHq0PVBqJ5kq74TXMV0IduYai
 l+M1FD9pQGAJztgVTRIKa+u6B8yF1V8E8piv2U06dJS/3nb6HlzorC1iVrFsh/qD09DMVqMqC44
 e3dYe8zAWC8r+Xd6+SRPENV43x6qX9rSXy7BSbQKIyH8yXuhvhhY/b3WwUaczEys6lX2cq34JZr
 Vds0p5tj7aXeHo0u15H64bvqRaClsfR9UNU7dEaihl84028KHjz+Aa1hLEcTrSvmEX1w/x96FNy
 wfR+XV3bByZQkNbIDjuvukMCW3K5dAwsiXCkoxkKzsgsrn/axbSR5jX+URn2rjoIuLe+c2Pz0kM
 oaB5HPHUQKQ==
X-Received: by 2002:a05:600c:1d05:b0:4a1:811c:8078 with SMTP id
 5b1f17b1804b1-4b963c7585cmr73754505e9.26.1794227006810; 
 Mon, 09 Nov 2026 04:23:26 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597652ca7sm10500318f8f.39.2026.11.09.04.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:23:25 -0800 (PST)
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Frank Obergfell <frank.obergfell@bytesatwork.ch>
Subject: [PATCH 0/5] arm64: dts: freescale: Add support for bytesatwork
 byteDEVKIT i.MX93
Date: Mon,  9 Nov 2026 13:22:45 +0100
Message-ID: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series introduces support for the bytesatwork byteENGINE i.MX93
System on Module (SoM) and the carrier boards byteDEVKIT v1.0 and v2.0[cite: 59, 60].
It also adds display support for the integrated Youritech ILI9806E
MIPI-DSI panel by extending the existing ILI9806E panel driver[cite: 56, 57].

Overview of the series:
- Patch 1: Documents the vendor prefix for Youritech and adds the compatible
  string to the Ilitek ILI9806E panel binding[cite: 56].
- Patch 2: Extends the ILI9806E core and DSI driver with init sequence,
  display timings, burst mode, and supplies for the Youritech panel[cite: 57].
- Patch 3: Adds the MIPI-DSI controller node and the bidirectional OF-graph
  link to the LCDIF in imx93.dtsi[cite: 58].
- Patch 4: Documents the bytesatwork vendor prefix and DT bindings in fsl.yaml
  for the byteENGINE and byteDEVKIT platforms[cite: 59].
- Patch 5: Adds the Devicetrees for the byteENGINE SoM and byteDEVKIT v1.0/v2.0
  carrier boards[cite: 60].

Subsystem / Merging notes:
Patches 1 and 2 target the DRM subsystem (dri-devel / drm-misc)[cite: 56, 57].
Patches 3, 4, and 5 target the Freescale/ARM SoC tree (Shawn Guo)[cite: 58, 59, 60].
They are submitted together to provide full context for the hardware support.

Testing:
- Validated on physical hardware (bytesatwork byteDEVKIT v1.0 and v2.0).
- Passed `make dt_binding_check` without warnings[cite: 56, 59].
- Passed `make CHECK_DTBS=y` for both target DTBs[cite: 60].
- Passed `./scripts/checkpatch.pl` on all patches[cite: 56, 57, 58, 59, 60].

Frank Obergfell (5):
  dt-bindings: display: panel: ilitek,ili9806e: Add Youritech ILI9806E
  drm/panel: ilitek-ili9806e: Add support for Youritech ILI9806E panel
  arm64: dts: freescale: imx93: Add MIPI DSI controller node
  dt-bindings: arm: fsl: Add byteENGINE i.MX93 platforms
  arm64: dts: freescale: Add support for bytesatwork i.MX93

 Documentation/devicetree/bindings/arm/fsl.yaml                |  12 +
 .../devicetree/bindings/display/panel/ilitek,ili9806e.yaml    |   1 +
 Documentation/devicetree/bindings/vendor-prefixes.yaml        |   4 +
 MAINTAINERS                                                   |   8 +
 arch/arm64/boot/dts/freescale/Makefile                        |   2 +
 arch/arm64/boot/dts/freescale/imx93-bytedevkit-v1-0.dts       | 459 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93-bytedevkit-v2-0.dts       | 441 +++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93-byteengine.dtsi           | 199 ++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi                      |  34 ++
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-core.c            |   4 +-
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c             | 158 ++++++
 11 files changed, 1321 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-bytedevkit-v1-0.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-bytedevkit-v2-0.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-byteengine.dtsi
