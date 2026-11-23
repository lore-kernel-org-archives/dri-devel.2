Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228C760A2619
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caJRJWUs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79DF10F191;
	Mon, 23 Nov 2026 19:38:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1941610F18D
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:38:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 018784590B;
 Mon, 23 Nov 2026 19:38:22 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795462701;
 b=nqCtOFIZq2fuuQBoKbqPR0SeJvQflqjstNy1Q+yu9ylg1FY4UxfSoD+wKdbEWh8JdqEf
 g9uUNauMYMKsgts8eS3YSYLEZiEBZLIFqTVMk+O/otMnNaCn12EE6V0EdPO2uRX+bEuOT
 nTdA357WfESVArHbIylMksLt8Ebtapegzr1lfpRhd1eg8IUq8rXil0/01y5kiG0kvlhsF
 pRbqhTuw/5uGGgXaD1b3HEsyG5ZPDO/Y5XKqiMCQYm6y6c8p9VLQ1M2dQARY4zY5xF/7v
 ZvPl9FxjSl2C/nzKYy6FDbJfEUQVbqR8t9wjYFD0CFG4VrLyCmStiLhM5X9t2Le4jaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795462701;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
 b=pnfoyib6qL+Sq2MnUAHw7+/a45LP6yZIoWhWqGCoR0MknPLYPuBC/JRwK5iUKfRcCmaM
 xJeNoKRZoG3Bt5Crk/UWAKJBc/htFtGtAAw3qsJy4CGpJ0C8TBV7D3KjIO0pptyvd1BRC
 qBFixdFrKYrsfmudCTNX+KeCgqzz/ua2EoHx0hIJGcDvsYSpICDhkvKi6pOrZejOKSDZN
 TMLgFpVa0ikXXPk1CXxF36hKkU0klx2D2Ull/ceihF5yNpPf3WQKpRBdX5e5nZ7ApAxHB
 UaSTM3eRWO9ADpi5mZCKmXapI0pasOricN6BCwIBn90Yj1FqQX9u+sfDuuxpc2UVu9Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id D62061F00A01;
 Mon, 23 Nov 2026 19:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795462701;
 bh=5kSP1RnWMSJEJYYJkds0+nXtVqYjbTw1JaXsnE/LlyU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=caJRJWUsM0119vW9sfuTSKZO6Xwf4QnFuUuK+qleWeMQehyvozhHLMX6jhHMwAdQB
 5Qpolqb+qPEDDWgCGeVuSu8hF8cwjHW96lH1h3LIu5zDLdnFrFfbys+rr8ggZVHjiP
 nkbOa1snbLrL88W5S0iCDflXESygf2svm/FdPJRRxdMTIpMiToMQaOUGNGbLZex5bm
 P+X9kjBS6gQgkLn8SuYmaFWKqgOe7bW8HgBRHlZxm5pY7XyJRhv81Vg3v5I/xtTIMa
 5hd/ErTz4y1AJqaiMAb47xko5ZfdpJfaclDaezQE17MxKpXHzkGlvr1B3CgwTtIMhh
 5JvcwLjZlq11A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C38484C6B1;
 Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:42 +0100
Subject: [PATCH v4 10/11] arm64: dts: amlogic: Add HDMI TX PHY node for
 GXBB
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-10-3fb94f5534ca@aliel.fr>
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=JfeJFGsdjuVYuSpN9bsRq2rmNT9JvKzwp64cluLxjAw=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNJGeb/GPL23k8rp32FN6et1so+Lwfu01jE3iEakL7
 gnWb9HqKGVhEONikBVTZOmfa3ni3eWjZ77uUU+BmcPKBDKEgYtTACay/xLDX5kH8nGXV+pFLZmY
 dNysvVR8H2eScVndjLJpnXe3OO9K6GL4pxP1/Pyij5vjzY8et4w7VpPzYe1R1UUFl/ZWc61amHt
 hARcA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Content-Transfer-Encoding: 7bit
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
Reply-To: linux-kernel-dev@aliel.fr
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Describe the HDMI TX PHY as a child of the HHI system controller, with
the amlogic,meson-gxbb-hdmi-tx-phy compatible and reference
it from the HDMI TX node through "phys".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5c2fe9dc4f80..09ad9790ebc2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -316,6 +316,7 @@ &hdmi_tx {
 		 <&clkc CLKID_GCLK_VENCI_INT0>;
 	clock-names = "isfr", "iahb", "venci";
 	power-domains = <&pwrc PWRC_GXBB_VPU_ID>;
+	phys = <&hdmi_tx_phy>;
 
 	assigned-clocks = <&clkc CLKID_HDMI_SEL>,
 			  <&clkc CLKID_HDMI>;
@@ -330,6 +331,11 @@ clkc: clock-controller {
 		clocks = <&xtal>;
 		clock-names = "xtal";
 	};
+
+	hdmi_tx_phy: hdmi-phy {
+		compatible = "amlogic,meson-gxbb-hdmi-tx-phy";
+		#phy-cells = <0>;
+	};
 };
 
 &hwrng {

-- 
2.56.1


