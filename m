Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4523C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A70110EE61;
	Thu, 30 Jul 2026 09:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hnJq6KaE";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9686E10EE60
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:23:12 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so1436891f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 02:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785403391; x=1786008191; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=19dWbdtDz3PuL5QLyRHvpa2qFjaBjIFM+A1PtZ3dpCg=;
 b=hnJq6KaEgboH1ECWIEWXnftN5cWXCBrH3x6Qy2vSWDinvDetsrcOMGv6g0M0lf6JGb
 ILT+/R/zSwz9eC3ov/Gpk2S77XRyHyla+Ye94cZMQj006QOoEn6MZfI3zKeVXrU+A5hK
 8jz5QSkehTq5pe1ntK/gp8VZRfAGth2BOx/CYcqRKBLtt6vs/csZNyoWvN3ktCtsHeaF
 0OUGRRbsXJlwX6nZg0VS1s87gnH9/kKJqLW/dei0Cdm7NJSkBGOOrMfRnnJ6Ax8ev84f
 WWS34/BEeLhuLyu4NYqjz66yiyTbcU4HdHEyfc9e6orOgi6hFDkVA8CZ4tnhMIDru6B3
 SfkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785403391; x=1786008191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=19dWbdtDz3PuL5QLyRHvpa2qFjaBjIFM+A1PtZ3dpCg=;
 b=EArV+8SUxC9ojaIE2Mq1SK9b9prYz8HNXbK6P9USAqgNuv6snOA/+Rdz/pANTWdIWC
 EZUo7rSakRHOUKdYihmLZ81fj48ZCqasd8s6Q7/cy1idvg87tlArGKT64wyfo0yypVDV
 gB9cQ6V+BiEO/SdELRynalbQog5i2LyQKs6A1SqBxQu9gGRKpK8YdD8dpsPJXH03wP5c
 QfSSf9Dipr7bmdfcgkjgR8fKbQSxsvZCLXYH8gsHeZJflcx3PwtHCoJwv2/4INq7KyDG
 0ZK+NzLwXKo95YhCJvxzj4PPPwuHthA8J3+V4Vq9Wct1jJ9AlCUaQRVS7kT3ME/fW2/h
 +mfQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkI1BE1kciOzvUPKzAjKmkDmQVcHQ5fnrjXrULihjUwPJVTI//GZiDq3m9DreUdBCAkT52Y9lbcIk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJAxSS8a2f647A9vfg2JN8eBi/K+hIyour83MiFjKNp3PGaF8A
 a7ZjtlUge0IEyshSK2Q/rMfi6dz8MP0OBFD9/QSRuH2/faysMEGTK5N+
X-Gm-Gg: AR+sD13mg3XZwqbQJf+ONqWm9oecKRMKeYhmR3QZgS4mlYtVcWp+ltfR2qMPLwzNOJF
 TwggcvQ2YDG7n6Z4LieP5GupTPYitfTjvd6gQpysSCK7+hTDYl5CTlvOIeLasAKBnRT/Lp/fSuH
 yqSu9a2D7WsPOoQkpRVcmnCSUU09HOFgave2w7df7MM1ysvYAZtsKiq/2Ra8RZz6GwwgOcSnJG4
 MPuy2xQ9weAiP5F59h0qXxMSPABRuFAufVcfE7SfaGf3fL08r18eAHy6PYIwugNayfb60CuwpKA
 vtaZrblzM+MsBwOt3ffES/R3wvuzmNU/laY28vCTnc6pOWzbKTwF6F+7aObYe2cdCGPBFuoWhui
 xpt+XWJvajm2oJADBEpRLSc6AC5b+GJdj+QaNmzi1GA/blg/sKTRn6PeDBOCgzYRmmXsgVwD6cc
 kXRgNK97WanoCoq0I9I1N0xMkwXIcfozPxvRkEMqhReceEnhT5GVqlhR7RdkCrHXvacCK10R9Fo
 0oyF4ECDyvsHMb/KuleDn/D5T8uC43hxg==
X-Received: by 2002:a05:6000:1a89:b0:47b:5f25:7c59 with SMTP id
 ffacd0b85a97d-47fc822dcf5mr2420000f8f.38.1785403390868; 
 Thu, 30 Jul 2026 02:23:10 -0700 (PDT)
Received: from fedora.tail6d6c39.ts.net ([82.77.79.56])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e64d5sm4308425f8f.15.2026.07.30.02.23.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:23:10 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH 2/2] ARM: dts: ti: omap: Fix TPD12S015 node and endpoint names
Date: Thu, 30 Jul 2026 12:22:45 +0300
Message-ID: <20260730092245.52034-3-egbostina@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730092245.52034-1-egbostina@gmail.com>
References: <20260730092245.52034-1-egbostina@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The TPD12S015 node and its internal endpoint nodes are currently named
with unit addresses ('encoder@0', 'endpoint@0') but lack corresponding
'reg' properties.

Remove the unit addresses from these nodes to resolve the warnings and
align with the core schemas.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts | 6 +++---
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi  | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 46270ed87..1ac9c13dc 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -152,7 +152,7 @@ hdmi_connector_in: endpoint {
 		};
 	};
 
-	hdmi_enc: encoder@0 {
+	hdmi_enc: encoder {
 		/* "ti,tpd12s016" software compatible with "ti,tpd12s015"
 		 *  no need for individual driver
 		 */
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
index a2a654ef4..ed8d3eebf 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
@@ -121,7 +121,7 @@ hdmi_connector_in: endpoint {
 		};
 	};
 
-	tpd12s015: encoder@0 {
+	tpd12s015: encoder {
 		compatible = "ti,tpd12s016", "ti,tpd12s015";
 
 		gpios = <0>, /* optional CT_CP_HPD */
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
2.54.0

