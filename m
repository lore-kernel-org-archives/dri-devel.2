Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDBDCC43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E9910E481;
	Sat, 11 Jul 2026 06:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="Zhji+Fru";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="zCuCf5AQ";
	dkim-atps=neutral
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de
 [85.215.255.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C7B10E40D
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:02:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783749744; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=PR1nHFc/QTqY+8hJVt2n1XSc8RSndpL3dJcVeJbTVYupGbSxEx8+IdKq0jW851lDMy
 Fb1OL1qYyjm0rry27iYDx9oVVr8WJnH+FGZOEfp10EKfLPK08+y2D7arl+tOfsWuyiHM
 MuKxA1uEbFgRTmC+NKcZiX9ujqAzDf633fe9IbE8lAJnk8oyn2NCUP5L65LcSHBFb7tp
 LTIzJ3aMk84+yc2Qsiw6ll+fFzZiXGjyv3Fv4Fxri4VduNcOI9pUX4soGBjusB8E3jLF
 BjlczD38d/LpCsHCoAOa9i3Kx3birvPMIFhJu3zTukod8E0rasrztihvczZIJskOec1B
 j4Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749744;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=hz7dWutT/qhmVRNalsYplqBc+0PlAjZb59MfOBNTMdM=;
 b=B55AYc3/CiWoSmm0ewOMOylZKiox5tJZ8moAzxu1QA1GxA3jlJL7N4AeHBmi+WEUfv
 0G03dm8zIi43QpfwfO4q1XBsT9NNYsYFTwkKNjp8QFaN3XDdyYO0TUmj33vvPzwmlx0e
 RHuwcAEQVIW43CZ7v1Ctdo+IbGaFDH1ff+5ibVwjjh0DEINqNw+hvrk7OUyUw0qgIiGR
 4bc6h9D4teQ5MMIudFPdAgJAiuYHb3Tgob5Okp1FmgN/XFizAiCA3lonc583jKPssjwk
 /eyvrQlsIxw0EWMJTS5mNMj4r0ts/V+EdreNDaffHhsVQQNVenJBF1KDwuA5IRAXdMbU
 NVgg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749744;
 s=strato-dkim-0002; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=hz7dWutT/qhmVRNalsYplqBc+0PlAjZb59MfOBNTMdM=;
 b=Zhji+FruYjtrExERO7SrSZF2ktV6BXHMG6nFLQw6JxfER1ygmuRuKHQ8W4GWjh8vrU
 sZLSgQy7qmu4CU3KTW2L/JgZ1+wzgoI8W3r8xSqIkKZK31vghaSHjMRWAP86FcUopR3r
 uptdedwaZu9HcOgEgoYTUxQny1XML+MsoOkX69rG6xD6O1a1ZMibAdn8alk/PypHD9AD
 gJqcbXhcnoAUkI/ifROQtV/IMzkebsvdvuFGP0vn9B3ywlkeLtwfe69zqlKa3CG1qaWb
 oG3g5Dgss/7Lxsu2iJIzU4y96cCXnYeZhtOwqWMZA6ckg6FWxrnSaGvlBgOVCPvWyVJV
 +zZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749744;
 s=strato-dkim-0003; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=hz7dWutT/qhmVRNalsYplqBc+0PlAjZb59MfOBNTMdM=;
 b=zCuCf5AQ74RZRR3454ckpV2ZuySuLSyvn2wqrvlKki4HgJirIrNwTdc7KDvLkpElY7
 T1I+KXo3MgT3AXba0YDg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.5.6 AUTH)
 with ESMTPSA id Q4b76426B62MGhy
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 11 Jul 2026 08:02:22 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Grond <grond66@riseup.net>, Stefan Leichter <sle85276@gmx.de>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>, Richard Fitzgerald <rf@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Niranjan H Y <niranjan.hy@ti.com>
Cc: letux-kernel@openphoenux.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 kernel@pyra-handheld.com, mfd@lists.linux.dev
Subject: [PATCH 13/16] arm: dts: omap3pandora: create new DT node for the
 sound card
Date: Sat, 11 Jul 2026 08:02:00 +0200
Message-ID: <e21be70f6ac6691c4a42808693215ed2f58eace2.1783749722.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
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

From: Stefan Leichter <sle85276@gmx.de>

This means that the sound card driver (snd-soc-omap3pandora) will get
loaded by default.

To make this work, we also add dac pcm1773-codec and widgets and
routing as needed.

Signed-off-by: Stefan Leichter <sle85276@gmx.de>
Signed-off-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../dts/ti/omap/omap3-pandora-common.dtsi     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
index de9860526b323..13821d926afb0 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-pandora-common.dtsi
@@ -47,6 +47,45 @@ dac: pcm1773-codec {
 		vcc-supply = <&vsim>;
 		enable-gpio = <&gpio4 22 GPIO_ACTIVE_HIGH>; /* GPIO 118 */
 		status = "okay";
+		#sound-dai-cells = <0>;
+	};
+
+	twl_audio_clk: twl-audio-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+		clock-output-names = "clk256fs";
+	};
+
+	sound: sound {
+		compatible = "openpandora,omap3pandora-sound";
+		status = "okay";
+
+		label = "OpenPandora";
+
+		amp-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
+		amp-supply = <&regen>;
+
+		widgets =
+			"Line", "Line Out",
+			"Line", "Line In",
+			"Headphone", "Headphone Jack",
+			"Microphone", "Mic (internal)",
+			"Microphone", "Mic (external)";
+
+		routing =
+			"PCM1773 DAC", "APLL Enable",
+			"Headphone Amplifier", "PCM1773 DAC",
+			"Line Out", "PCM1773 DAC",
+			"Headphone Jack", "Headphone Amplifier",
+			"AUXL", "Line In",
+			"AUXR", "Line In",
+			"MAINMIC", "Mic (internal)",
+			"Mic (internal)", "Mic Bias 1",
+			"SUBMIC", "Mic (external)",
+			"Mic (external)", "Mic Bias 2";
+
+		sound-dai = <&mcbsp2>, <&dac>;
 	};
 
 	gpio-leds {
@@ -724,6 +763,9 @@ &mcbsp1 {
 /* audio DAC */
 &mcbsp2 {
 	status = "okay";
+	#sound-dai-cells = <0>;
+	clocks = <&mcbsp2_fck>, <&mcbsp2_ick>;
+	clock-names = "fck", "ick";
 };
 
 /* bluetooth */
-- 
2.50.1 (Apple Git-155)

