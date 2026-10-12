Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD94CC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 542BB10F595;
	Tue, 13 Oct 2026 07:53:11 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A190510E4E0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 07:25:43 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a161d9b8c7so9669235e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791789942; x=1792394742; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=d1QWTDb/oOVddYpnAN188VwUYCPxgfGwS1G3xLd3LyU=;
 b=AQjvnYdLhWk37RHPQ6niYCn4BSZchoSg5gjm2IUhDpWwf3/0DGKa6wW3OstNxMEHLt
 KcwC+msQdwfha+qhvZXNMAKF/FdjIOYQv7mqougGCVrfEZTOSCxtO/B28CafUA1sJBnr
 d4OfgdVCY4WN2W4Pw1mzwUFzXNHa6d2XeX8tnwtRxDBO7wHMjwebeEEOhOy5CiC3HeH3
 Pf7kgPE+PoKYiGYq2q471OL5Kf3g77LuJRqzvFbQZjQsu8spIS0OtgGjF8KktdTjCDY6
 nYbUTiQ3hEg1Mbq2v+EuNyGj66XRaMDIthn5wSPhAxyVIPplSJy6/LUoK040PC1L0OZv
 Ozyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791789942; x=1792394742;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d1QWTDb/oOVddYpnAN188VwUYCPxgfGwS1G3xLd3LyU=;
 b=kTUzp3SLs4x54ZYVQTj0tpFubn8Lg6D2dB/ohDsWQsJV6WKs4HN+bS44QDlntjQpm0
 He+oXt/gqBnLrYRyA+g0HmUjsCEUZMHsT3NKWVKMdFPwecbzo4KqONVQ2OKn45SOsiR2
 NArUPVTzKhd6OKHvv/Z9dYzPfgxfm+/WfILjrNVdAN+YGKesnu8o/IxP89JkbiN3y1dM
 sYHjDM6Df4X7JNc4/HlTL2yHef5PbZT/o8VmWSx8OYkky0HNvO4Wj9awIIkaVlj2UkX1
 l8ew9P8PLyfKMn8IH2fBjfRO5+9qWsyKoYtcyOGLloeJ9LG6wkMct+e1Sx31SG/g3hv0
 q4NA==
X-Gm-Message-State: AFq9FYKB1y2TORffxyYwPdX8jza88dCZJyIWVgQx09MbcvlAwtPL8P2F
 s1qKrKHiexLcUGJWEu4K9uRQRizLbzjEJ2lkol8kJiggzL4DiaG940s5
X-Gm-Gg: AYBFou3FiQP/ZKxDCe/bciKEJ/bDSm7Gq4UJlnhpoZ6RM8CegImTk5BlWysTdTWdTlM
 at58IQIjP9ssa6XMTN2bvGb+uRIL8CkG/dZXcn2O4omtYGLgof8Y3iRkqV0Fmfra4ApXjFnWPzK
 4GmOZfVPTr0+aOjW4J+L6GmPpYEwdNW1iZsVaASpJUZtxcpE8yb+uJp39pgQZTnWs1sCf1ye/gM
 L9yOqalTAOn8ueIRBw4+vQRaKEDRlnCd7hfayUq5Q3JagHTDdJD8u+olDuCXMtdtOTDmyvBbNDH
 Jnb12dKlMvSaG3Hs6tP+3KOYKMx+zgq/BWqsJltJKXDja58553yxuZVCzI2hB7WusvWkv3wd121
 B+q7V6Z1KzqsX+zKg4NreZFrxagjrCgPD9of5AxO/4N4vvZ+ovGKbA3FvDStlmHwgrn7DxrY98Y
 +NSehL6IN3uS9bMPnx/YHivlLdi5tGMvY2OvtpRODUO1YrE287sp7RFwfKcUvzNwA+WckntjN66
 bxRM65FP92iAYeytwfvwP4Mg0BWxli01NTVm0ce+3IYGWZtjtOK2pdD3GNNqMDu
X-Received: by 2002:a05:600c:19ca:b0:4a1:7e76:d02f with SMTP id
 5b1f17b1804b1-4a18e4ac650mr158677175e9.14.1791789941611; 
 Mon, 12 Oct 2026 00:25:41 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aadf9bsm17523377f8f.29.2026.10.12.00.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 00:25:41 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Subject: [PATCH 0/3] Add VGA support for Apalis iMX6
Date: Mon, 12 Oct 2026 04:25:22 -0300
Message-Id: <20261012-v1-apalis-imx6-enable-vga-v1-0-8905d8746504@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGKLzGoC/x3MTQqAIBBA4avErBtII/u5SrQYa6oBs1CQILp70
 vJbvPdA5CAcYSgeCJwkyukzVFnAvJPfGGXJBl1pU/W6w6SQLnISUY7bIHuyjjFthM3cWjK2brq
 VIfdX4FXu/z1O7/sBKq18SGsAAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Leonardo Costa <leonardo.costa@toradex.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791789940; l=1908;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=oIehZcPpAbqiwfIqG1W31kjdUe0imO5csyH1FVDoC4g=;
 b=6Na6Gpe9E1PvitnwV+dpCDK0x8whlxg3tt6LUG+45ePWH6KHyR7uTPCZpXJvoHbTKeZQq5b6z
 YhrD1XfpN2gDC54bNXQKOrMjPmqjFju0acH+K48bnab3b0Eu3MBtE5u
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:58 +0000
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

This series adds a device tree overlay that enables the VGA output on Apalis
iMX6, which is driven from a parallel RGB interface passing through a
non-programmable video DAC.

The video DAC is a simple resistor network gated by an active-low
data-enable signal. For the bridge to work properly, this series also
changes the following in the dt-bindings and simple-bridge driver:

- dt-bindings: Add a new compatible for the bridge in the simple-bridge
  binding. This is necessary because the existing dumb-vga-dac compatible
  doesn't describe a data-enable signal polarity.

- simple-bridge: Add the VGA bridge match-table entry and timings
  struct, setting the DRM_BUS_FLAG_DE_LOW flag for the bridge.

This change depends on another patch, and should be applied after it:

- https://lore.kernel.org/all/20261002-v1-simple-bridge-atomic-check-v1-1-ef5d8332b078@toradex.com/T/#u

  Adds the atomic_check function to the simple-bridge driver, which
  allows the data-enable bus flag to be propagated through the DRM
  pipeline. This is necessary for the VGA to work correctly on the
  Apalis iMX6.

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
Leonardo Costa (3):
      dt-bindings: display: bridge: simple: Add the Toradex Apalis iMX6 VGA DAC bridge
      drm/bridge: simple-bridge: Add Toradex RGB to VGA DAC bridge
      ARM: dts: imx6q-apalis: Add VGA overlay

 .../bindings/display/bridge/simple-bridge.yaml     |  1 +
 arch/arm/boot/dts/nxp/imx/Makefile                 | 21 ++++++
 .../boot/dts/nxp/imx/imx6q-apalis-eval-vga.dtso    | 79 ++++++++++++++++++++++
 drivers/gpu/drm/bridge/simple-bridge.c             | 10 +++
 4 files changed, 111 insertions(+)
---
base-commit: f5f84daefcd92d7a630066635ecea1433ed5eac7
change-id: 20260928-v1-apalis-imx6-enable-vga-5c7ba6b358fe

Best regards,
-- 
Leonardo Costa <leonardo.costa@toradex.com>

