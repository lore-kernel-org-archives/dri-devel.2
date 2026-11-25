Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD0606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=RAtvSNkl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 340FF10FBAB;
	Wed, 25 Nov 2026 11:38:31 +0000 (UTC)
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA3110FBB1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=ZfR/6lnsUE/pnRQi/PbCLWIsXUsmgZSZZiyw7HHwysA=; t=1795606704; x=1796816304; 
 b=RAtvSNklGjsZtDEb1OTwI+q7msTMd9VS723Q3+2aIqoQ7cMm0sP3c63UWB1EA7nJj7xAn3hdIPs
 ZuZmKgYmmcYHyjZ7WT553lplWwUGzQrmS4Ficw2WPLURVDETngw3Wj/lG78wVdn9xdFzifI/8ODqu
 fOdjbEqSRJA/gMatmVBhr7EJt64//d0/j7dDT44a15f2024emT/kmPEDe652J6F/aqtOdUla9sHcQ
 AA2PeF/HDnovDKNp3Zcvvr0i34QbTEwKx4x0qNfNyRTjPkR5hD446+wUIlcgdiaQH6tIsV3N6oa8a
 wyrJeH8QMUZzrWyIoPBW/EUCXC2RBuwaCgMA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 25 Nov 2026 12:37:21 +0100
Subject: [PATCH v2 2/2] ARM: dts: st: stm32mp15xx-dhsom: fix bridge reset
 polarity
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-tc3-reset-v2-2-32eefcaf1460@kemnade.info>
References: <20261125-tc3-reset-v2-0-32eefcaf1460@kemnade.info>
In-Reply-To: <20261125-tc3-reset-v2-0-32eefcaf1460@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@nabladev.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 kernel@dh-electronics.com, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=987; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=GLBUHsrqFLUlRWZt8GXXwr1nDsTd3sjuIa8AxQT8QUI=;
 b=owEBbQKS/ZANAwAKAYRhRfpAKNzxAcsmYgBrBsicxJ39BdQawPVS1vsqyb5pVVpsEPBznjhCy
 lM2FgQvhcKJAjMEAAEKAB0WIQTY6xCZL0TEE1XHfFiEYUX6QCjc8QUCawbInAAKCRCEYUX6QCjc
 8X6uD/9Scm2vnKjdVnjiK5Wq/OAU/DMB13MUnnPQJBPhn+RvKcdBp1h/Bl4EO4jPp4H4/GoiKve
 vD0lq7mk5bkSwVuIs2Prj/GRLhLE6+689XkMZeMnn/4EMC5KojJKgllX4fsxY/bm3hD7Opy0nI3
 iIh3JeJisk29PvsHfXFjBhMmZyZg4r32CRZ05Mobm4JXdbEuVkk5pKW+r6n7XcGbdJdr6IDaw0c
 cOVlrOPiJ3+MdZmXv/o3Is+prFMav19unYmeqVgHmb6DF1WbxCAMI2dSP+hkHviyqyYWYaiykSG
 HWEEhIABxryHExQPvnGtLaN0qiJbLAg6aAm4B4iLe1Mb1M1TmnR2HNYMBPzPBlvPR11vxPfllYx
 qvzn+vIyJ/T83NAGMyHxx+KGqun/XBG33sH19RzTmV77MfBfOT9JB53BfWpXY+EPdUFbM4grLfx
 fnrNweEdrr/aOIaI5Bi4HVGpU3ADxNV4VvY7YVN56SGRm4TOE0SD6yIHb1vDRVN1XBtpu9gqrsu
 xt/l6fQD9/9o4SAlFtWM879aOj4U4r6GG406AalpbLhdTAz5AyLJEqr0YZ2JVFm8JAqQfK5w/bm
 Q780iaMF1ec4FyGszAoWNk/IyRfXKRqVxumnvmUtkBitCLKy1DqlZP3ZZNGZ8YcORRNI7ImFDSW
 v41YspPCfrD4cCw==
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

Reset is active low. It is apparently set to active high to work around
a driver bug but not to indicate an additional inverter in the signal
path. Correcly describe the hardware.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi
index 518c269a1dba1..6342a6e757c12 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dhsom-overlay-panel-dsi-rpi7inch.dtsi
@@ -35,7 +35,7 @@ &dsi {
 	bridge@0 {
 		compatible = "toshiba,tc358762";
 		reg = <0>;
-		reset-gpios = <&attiny 0 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&attiny 0 GPIO_ACTIVE_LOW>;
 		vddc-supply = <&attiny>;
 		status = "okay";
 

-- 
2.47.3

