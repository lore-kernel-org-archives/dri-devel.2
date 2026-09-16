Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B762C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:36:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB0510E754;
	Wed, 16 Sep 2026 07:35:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="BUTxWAZV";
	dkim-atps=neutral
X-Greylist: delayed 50067 seconds by postgrey-1.36 at gabe;
 Wed, 16 Sep 2026 01:59:52 UTC
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026B610E0B4
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 01:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BW
 0xL9oOuUagOkBoGGchsZiOagcsUoaE1mg2KKNypGU=; b=BUTxWAZVv8VfMEM9g0
 O4NME5qvxfFwE0rGzUx6Dgw3iGb8N+iqvIyC8LSpHYiAEkVFAufZGDhkHV3tmp/5
 G553oHJnO+/pVoppHGVLIlvgundWPbmdNpk4Ek0Env0/DjkTEyxIhkwl8AtGinE/
 TAJRgNvo29dYFeiJJu4mkz0fg=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wCHlXrK96lqbYrfAw--.61328S3; 
 Wed, 16 Sep 2026 09:58:37 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, quchaosheng000406@163.com
Subject: [PATCH v2 2/2] ARM: dts: ti/omap: drop unit-address from tpd12s015
 endpoints
Date: Wed, 16 Sep 2026 09:58:33 +0800
Message-ID: <20260916015833.112753-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916015833.112753-1-quchaosheng000406@163.com>
References: <20260915120327.47114-1-quchaosheng000406@163.com>
 <20260916015833.112753-1-quchaosheng000406@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCHlXrK96lqbYrfAw--.61328S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr48Xry8uw43ZFy5Gr1UAwb_yoW8Ww45p3
 s2vFs7tan7WF10kr4DAw1qkF1qkF4DuF1akF1UWryUCa13Xw1rJF1xtwn2kr1UCa4fZw4j
 9rs5WasFqw1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirHUDUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAA02q2qp983XgAAA3+
X-Mailman-Approved-At: Wed, 16 Sep 2026 07:35:16 +0000
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

ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints

The endpoint nodes of the tpd12s015 encoder on the am5729-beagleboneai and
the am57xx-idk carry a unit-address without a matching reg property, which
the device tree specification does not allow.

Drop the unit-address so the nodes are named "endpoint".

No functional change.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 76bfb3647..f40017a0e 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -168,7 +168,7 @@ ports {
 			port@0 {
 				reg = <0x0>;
 
-				hdmi_encoder_in: endpoint@0 {
+				hdmi_encoder_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -176,7 +176,7 @@ hdmi_encoder_in: endpoint@0 {
 			port@1 {
 				reg = <0x1>;
 
-				hdmi_encoder_out: endpoint@0 {
+				hdmi_encoder_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
diff --git a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
index 5eccff3bb..4e8a5820b 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
@@ -135,7 +135,7 @@ ports {
 			port@0 {
 				reg = <0>;
 
-				tpd12s015_in: endpoint@0 {
+				tpd12s015_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -143,7 +143,7 @@ tpd12s015_in: endpoint@0 {
 			port@1 {
 				reg = <1>;
 
-				tpd12s015_out: endpoint@0 {
+				tpd12s015_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};

-- 
2.43.0

