Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276B1CA9EC7
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:45:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15B3E10E810;
	Sat, 10 Oct 2026 11:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="nHgVfZhO";
	dkim-atps=neutral
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08F2C10E9B4
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=SU
 2hOrP3XkxbQgBianI5yCRcm1GVQm++rhoG9WeYkXY=; b=nHgVfZhOjeIx/PWWkK
 vNM7E2m3qCDjooBWbYQqG2WnDr5kDDGylgxZTZuhL/0hUQNP/ufUhK4E27M/kuv6
 E9yk5HhcP4ozepd7uVSqnoFDADTiEe2rS12+xbhxcR8WoXF3T09A6p0bntJ46iQM
 QOMoc02NGIUr0fuXjtJEf7MLI=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgB3vmvUx8hqvTiFDg--.2548S5; 
 Fri, 09 Oct 2026 18:54:14 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH 3/3] ARM: dts: ti/omap: drop unit-address from tpd12s015
 endpoints
Date: Fri,  9 Oct 2026 18:54:12 +0800
Message-ID: <20261009105412.300338-4-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009105412.300338-1-quchaosheng000406@163.com>
References: <20261009105412.300338-1-quchaosheng000406@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: QCgvCgB3vmvUx8hqvTiFDg--.2548S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw1rXry7try7XrWDtw43ZFb_yoW8CF4kp3
 s29Fs7tws7GF10kF4DZw1qgFyDKFWDuF1akF4UWryUCa13Xw1rJr1xt3sakr1UCayfZw4j
 9rs5WasFqw1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEBHq3UUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDABfzaWrIx9e6MQAA30
X-Mailman-Approved-At: Sat, 10 Oct 2026 11:45:03 +0000
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

From: Chaosheng Qu <quchaosheng000406@163.com>

The endpoint nodes of the tpd12s015 encoder on the am5729-beagleboneai
and the am57xx-idk carry a unit-address without a matching reg property,
which the device tree specification does not allow.

Drop the unit-address so the nodes are named "endpoint".

No functional change.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts | 4 ++--
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 76bfb364777e..f40017a0e414 100644
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
index 5eccff3bb4b6..4e8a5820b05c 100644
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

