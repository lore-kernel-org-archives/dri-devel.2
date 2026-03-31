Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54F8FF60ED
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 08:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07AD810E29E;
	Tue, 31 Mar 2026 08:46:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f60BSIWf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 766AC10E26B
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:46:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 94AC1600CB;
 Tue, 31 Mar 2026 08:46:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AA8EC19423;
 Tue, 31 Mar 2026 08:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774946808;
 bh=rxYHgzXy8uW1RXLEMgmea9X6qQkdnDq9ItPer1Acm+Y=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=f60BSIWfWX1a8nz3oUKYl4FHOqAO0i27QVF0U0fZ4WGC1Vodlyq7hh49LHu0Lkar0
 buPNfNeHjxpzHRG0wjAUpalo4CduojRU/n6h593q8ZG5/c6CwAFKyiF0cH04tP2nuF
 JFQiddoNXVwt5i/LKvTkkDE7STbqO6zdg6K6r5f2xqRKTlKcgOYWKjBhmNOAFh26a+
 dv0cK9kavWUD9viaxLRG8+FODIb5/TmA6++QqQ4uMBbgnzrUasHYUuO5G4wNf70rCe
 U8k2zHwuwasgVLwCw2zupASN55m0uR9WlJsQeb4Ozv7JnvKRFwI5PTDmaC8c+isinj
 wQp+772ppw+bA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 17ACFFF60D0;
 Tue, 31 Mar 2026 08:46:48 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay
 <devnull+cristian_ci.protonmail.com@kernel.org>
Subject: [PATCH v5 0/6] Enable new features for flipkart-rimob
Date: Tue, 31 Mar 2026 11:47:08 +0200
Message-Id: <20260331-rimob-new-features-v5-0-5fcf42a29c12@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NTQrCMBCG4atI1kYmP20aV95DXKTpRAO2KUmti
 vTuRkEomOX7wTzzIgmjx0T2mxeJOPvkw5Cj2m6IvZjhjNR3uQkHXoMAQaPvQ0sHvFOHZrpFTBS
 E0lK2wtQcSD4cIzr/+KLHU+6LT1OIz++PmX3WH9eUuJlRoMZwKwRUils4jDFMYeiNv+5s6MnHn
 PnKYWWHZ8ey1jWaKSk1Fh2xcjgrOiI7nWwbxKZWHaqiI9eOKjoyO1Bj55y2sgL95yzL8gagDAK
 ckQEAAA==
X-Change-ID: 20260303-rimob-new-features-037944b3a620
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774950461; l=4821;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=rxYHgzXy8uW1RXLEMgmea9X6qQkdnDq9ItPer1Acm+Y=;
 b=d7Lq8wGdX+64IMGaph/XLrXfLgToUvUUf1bzlo598wqGedfh8h8Qw4OU+LBdFKrjw/ZsJDPrN
 cimBusF3qDzA3SUwme0Bda19xbOST5TJgl54S0833T/d6Z8YTac0t/4
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
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
Reply-To: cristian_ci@protonmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

This series enables a set of miscellaneous features for Billion Capture+ 
(a handset using the MSM8953 SoC released in 2017):
- Panel and GPU
- Touchscreen
- WiFi + Bluetooth
- Hall sensor 

Patches 1 and 2 provide a driver for Novatek NT35532 and its corresponding
devicetree bindings, required for enabling panel in DTS. The remaining 
patches are all DTS changes, aimed to enable the features listed above.

To: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht
Cc: phone-devel@vger.kernel.org 

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
Changes in v5:
- Based on dts-coding-style.html ("Nodes without unit addresses shall be
  ordered alpha-numerically by the node name. For a few node types, they 
  can be ordered by the main property, e.g. pin configuration states
  ordered by value of “pins” property."), sort pinctrl states by GPIO 
  index (Konrad);
- Pick up tags;
- Link to v4: https://lore.kernel.org/r/20260327-rimob-new-features-v4-0-06edff9c4509@protonmail.com

Changes in v4:
- (patch 1/6): added a new compatible (since it's not possible to
  identify panel vendor/id), matching user of this device and leaving
  novatek,nt35532 as fallback (Dmitry);
- (patch 2/6):
  - according to bindings changes, make panel driver handling multiple
    panels paired with NT35532 and use specific compatible/data;
  - due to changes applied to panel code, remove tag received previously
    by Dmitry.
- (patch 3/6): 
  - use a specific panel compatible, according to bindings changes;
  - remove 'output-high' property from panel pinctrl, since panel is not
    reset.
- Link to v3: https://lore.kernel.org/r/20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com

Changes in v3:
- (patch 1/6): removed avdd, avee and vci supplies from 'required' properties;
- (patch 2/6):
  - removed "select VIDEOMODE_HELPERS" from nt35532 Kconfig entry, since 
    its functions are not used (but this option is enabled and its code 
    compiled anyway) by nt35532 panel driver;
  - pick up tags (Dmitry).
- (patch 3/6): replaced a506_zap.mdt with a506_zap.mbn firmware name
  in gpu_zap_shader (Dmitry); 
- (patch 5/6): pick up tags (Konrad);
- (patch 6/6): pick up tags (Konrad);
- Link to v2: https://lore.kernel.org/r/20260318-rimob-new-features-v2-0-c1bf8917449e@protonmail.com

Changes in v2:
- (patch 1/6): define power supplies in the bindings as per datasheet  
  and update example;
- (patch 2/6): add blank lines where required between mipi dsi write
  sequences in nt35532_on() function and make use of names for mipi dcs
  commands, instead of hex numbers, to improve readibility (Dmitry); 
- (patch 3/6): move pinctrl lines ibto panel node and get rid of
  sleep/reset state, since panel just uses one pinctrl state for
  default/sleep (Dmitry). Also, update power supplies according to
  bindings; 
- (patch 4/6): pick up tags (Konrad,Dmitry);
- (patch 6/6): squash hall sensor node into gpio-keys (Dmitry);
- Link to v1: https://lore.kernel.org/r/20260308-rimob-new-features-v1-0-aa2c330572c0@protonmail.com

---
Cristian Cozzolino (6):
      dt-bindings: display: panel: Add Novatek NT35532 LCD DSI
      drm/panel: Add driver for Novatek NT35532
      arm64: dts: qcom: msm8953-flipkart-rimob: Enable display and GPU
      arm64: dts: qcom: msm8953-flipkart-rimob: Enable WiFi/Bluetooth
      arm64: dts: qcom: msm8953-flipkart-rimob: Enable touchscreen
      arm64: dts: qcom: msm8953-flipkart-rimob: Enable Hall sensor

 .../bindings/display/panel/novatek,nt35532.yaml    |  80 +++
 MAINTAINERS                                        |   6 +
 .../arm64/boot/dts/qcom/msm8953-flipkart-rimob.dts | 138 +++-
 drivers/gpu/drm/panel/Kconfig                      |  10 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt35532.c      | 796 +++++++++++++++++++++
 6 files changed, 1030 insertions(+), 1 deletion(-)
---
base-commit: cf7c3c02fdd0dfccf4d6611714273dcb538af2cb
change-id: 20260303-rimob-new-features-037944b3a620

Best regards,
-- 
Cristian Cozzolino <cristian_ci@protonmail.com>


