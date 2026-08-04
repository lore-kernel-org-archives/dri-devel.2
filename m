Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3029DC55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 08:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A799C10E921;
	Tue,  4 Aug 2026 08:56:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D42suQQr";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A49010E91C
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 08:56:05 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 55A87600AA;
 Tue,  4 Aug 2026 08:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2EA2C2BCF5;
 Tue,  4 Aug 2026 08:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1785833764;
 bh=goWIcnvl16p6Hy5rNc9ISB637rHTfcV7JGaLd5HxRQE=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=D42suQQrVOZYdjug603egLVBJY/M482Eg+jdCCxYKvhrX0RRJCGOueJSOsjPt3wjk
 D0Hbw9iztr7WxVKZ3CGPC3Q3kNINvE9fBw5lAfSM37OZFsgnYVFK4B2cHSB8Fh4yfU
 eUpn2se8pMQt66rt6+EH/Dh8IKOfga09IZaaku2CTlBr0RjZIfh1rytvBEbjZ28sms
 HvKXM8EJ+92ErK7ts7D50VygL5aaS1BY07UFCz2dfe5GMtJUrkhtnINN8syNAVUBjC
 4YsHDyBiYNqED/mg+nHn8PFCfPLPFGV5WXPUZMjf9ppQuAS6etFyjEcCKXyeXQ431o
 j8Tiel69A50Jw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DEC60C55172;
 Tue,  4 Aug 2026 08:56:03 +0000 (UTC)
From: =?utf-8?q?Dawid_Wr=C3=B3bel_via_B4_Relay?=
 <devnull+me.dawidwrobel.com@kernel.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: add the Xiaomi Mi Pad 5 Pro 5G
Date: Tue, 04 Aug 2026 10:55:54 +0200
Message-Id: <20260804-sm8250-xiaomi-enuma-v2-0-9dd0486f1155@dawidwrobel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7ZhStBRX3sOwKHSQSSw1rQKG9
 O5WDuDyveS/v0GkwBThUmwQaObIfsogDwX0o5nuhGwzgxRSiboSGJ2WZ4ErG+8YaXo7g6RrPch
 e6FNZQV4+Aw287tVbm3nk+PLhs5/M5c/+780lCiSrrB66plFKX61Z2C7Bd/Q49t5Bm1L6ArLfJ
 ES8AAAA
X-Change-ID: 20260730-sm8250-xiaomi-enuma-e878f2c08413
To: Jianhua Lu <lujianhua000@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2597; i=me@dawidwrobel.com;
 h=from:subject:message-id;
 bh=goWIcnvl16p6Hy5rNc9ISB637rHTfcV7JGaLd5HxRQE=;
 b=owGbwMvMwCV2qrTGfeXVd28ZT6slMWQVrlRK8An+9WPKqTO8p//N0vg1o+y0QIHvHNe3oS/va
 FwSE58f1FHKwiDGxSArpsiilxa0xyr45fd3L36Hw8xhZQIZwsDFKQAT+fGa4Z+17YmDdhXbFV5c
 vLF/hpndMf9u2bSTufzXd0pHVVq8SE9lZDg3e4HTkfqW/I9h/lwNB1+EZcfcbCk8+0HD7zh3lda
 3RewA
X-Developer-Key: i=me@dawidwrobel.com; a=openpgp;
 fpr=B64A778E0E64049A70C831C8B7B81FA12B282A92
X-Endpoint-Received: by B4 Relay for me@dawidwrobel.com/default with
 auth_id=901
X-Original-From: =?utf-8?q?Dawid_Wr=C3=B3bel?= <me@dawidwrobel.com>
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
Reply-To: me@dawidwrobel.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The Mi Pad 5 Pro 5G (enuma, 2021) is the modem-equipped variant of the
Mi Pad 5 Pro (elish). The two boards share a design, so this describes
enuma as sm8250-xiaomi-elish-common.dtsi plus the three things that
differ: the board ID the bootloader matches on, the panel compatible and
the WiFi board data variant.

Unlike elish, enuma shipped with a single display variant, so there is
one device tree rather than a per-panel pair. The vendor device trees key
the touch configuration to a display maker, and enuma declares a single
entry against elish's three:

  https://github.com/MiCode/kernel_devicetree/blob/elish-r-oss/qcom/enuma-sm8250.dtsi#L309
  https://github.com/MiCode/kernel_devicetree/blob/elish-r-oss/qcom/elish-sm8250.dtsi#L294

The panel itself is the same part elish uses: both trees pull in the
same dsi-panel-k81-42-02-0a-video.dtsi, so the new
xiaomi,enuma-csot-nt36523 compatible falls back to
xiaomi,elish-csot-nt36523, leaving room to handle any difference that
turns up later without requiring a device tree change.

The WiFi board data is already upstream in ath11k-firmware as
bus=pci,qmi-chip-id=0,qmi-board-id=255,variant=Xiaomi_Pad_5Pro_5G
(QCA6390 hw2.0 board-2.bin, commit 235d09a5e111).

Tested on the device: the panel and WiFi come up and perform as expected
under postmarketOS.

The fingerprint sensor, PCIe2/modem and touchscreen this board also
provides are left out here; they depend on bindings that are not upstream
yet and will follow separately.

Signed-off-by: Dawid Wróbel <me@dawidwrobel.com>
---
Changes in v2:
- Dropped the "label the WiFi node" patch, folded into device tree patch (Krzysztof Kozlowski)
- Link to v1: https://lore.kernel.org/r/20260730-sm8250-xiaomi-enuma-v1-0-ed6d8fb99668@dawidwrobel.com

---
Dawid Wróbel (3):
      dt-bindings: display: panel: novatek,nt36523: add the Mi Pad 5 Pro 5G panel
      dt-bindings: arm: qcom: add the Xiaomi Mi Pad 5 Pro 5G
      arm64: dts: qcom: sm8250: add device tree for the Xiaomi Mi Pad 5 Pro 5G

 Documentation/devicetree/bindings/arm/qcom.yaml    |  5 +++++
 .../bindings/display/panel/novatek,nt36523.yaml    |  4 ++++
 arch/arm64/boot/dts/qcom/Makefile                  |  1 +
 .../boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-enuma.dts   | 26 ++++++++++++++++++++++
 5 files changed, 37 insertions(+), 1 deletion(-)
---
base-commit: bd94276d96726a82700d85ad3b32892f45809d3a
change-id: 20260730-sm8250-xiaomi-enuma-e878f2c08413

Best regards,
-- 
Dawid Wróbel <me@dawidwrobel.com>


