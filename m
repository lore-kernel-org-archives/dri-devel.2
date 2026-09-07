Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD172C79FA0
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:30:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B92E910E733;
	Mon,  7 Sep 2026 09:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="sac3TfrM";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 280FD10E72E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:30:27 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3D64F13BA;
 Mon,  7 Sep 2026 11:28:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788773331;
 bh=E4l62o+sxS+bPEPN3Rlb+RatxgF6zDPhb0MAy+QFUv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=sac3TfrMtL/YnoGEyRE99e4FuwRIwyvwInDD4Fg3Hzae/FYlilpFrskO+5D4RCEku
 vHqQVZFppIb94hH6G9FdppMmKxclWRqEV1lx8ZtCBpXZyfSsxjY8agiV+RTFSWFgbP
 rt9a5L5DQQ6MuzwdBNHY+G8xPgN5r6RsqZy+kC6k=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Mon, 07 Sep 2026 12:29:44 +0300
Subject: [PATCH v6 5/6] arm64: dts: renesas: sparrow-hawk: Enable
 DisplayPort by adding DSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-rcar-du-dsc-v6-5-f8ef711a7494@ideasonboard.com>
References: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
In-Reply-To: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=spwA6S6xpukisy7pkedqiZJctKlACrqVu7cRL2eEc4Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnoQn7hRat5DOSUGwCtbdOIXjldd8M3qJfHJGT
 3xoeFRziJOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6EJwAKCRD6PaqMvJYe
 9QYyD/4sh1tijIaSFJDVKns8PpiUK1txHmylyBdSsKfVBI1B8PrvZefNjcllEPDed5Z3j24T0fL
 yPppCCavEWQC1F+Y5lxAMqmseVNYhl8RQniY8FjoIiuM0igjf5+E5r7QFXopivep/NmUu6tSN0Y
 zvzNKhf0QJm7A99nv9LL9yARd675O61RlVAqtO1AMa9YecU96+KGFAPQedfHcphv4gvC7RDo5s2
 zzlCrKbsnVKmiW0i4ESMnJv9yEmQMD8+Ub/Sqs7qYkU9Q5TquNm0vIAyVnEAYAZ/VdbyXG67aSU
 0YOsigUY1u/ro9FSEbjJ8kooUZyuzkwc2Cvwpn9ELgQrJ+xwAFCI1KPnFaLZxU2eLKBKjMUUO72
 xZWdZnSabyu54gKt2B2cOEUiPu2QA00uL1OKsbzRMJkrgLyONxjh3tN2Jf5d4+mNwHYiqW6MHmm
 C6ZmYMNHyLtuRpQEGnwuQJnRy+QBsmfzF/5O64xozyIFnED2oSNhmOuzFzBJB1f/62SIGjsK8ON
 RLMw6F9v987V1DNecRZjG3ZDaFp8nIn8yX3c4N86H3sxdEaK81S+b9L2b416BxmNelA3Xsm41p/
 Dsz5SS9mQq1zBP5N2csSnTYN5Z1mti2OVSWE8lHlT4XYNUokZu5UyFNbvNTi4z0lsgUZEH6CLmG
 uhELzpYbbdHiGUg==
X-Developer-Key: i=tomi.valkeinen+renesas@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

DisplayPort on the Sparrow Hawk board uses sn65dsi86 bridge, which in
turn gets the video stream from the SoC's DSI1 port. DSI1 pipeline has a
DSC block in between the DU and the DSI1. However, there was no DSC
driver in Linux and also the DSC was not defined in the dts files, and
thus the DisplayPort output did not work.

Now that we have DSC defined in the SoC dts file (r8a779g0.dtsi), we can
enable DSC for sparrowhawk.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[tomi.valkeinen: separated the sparrow hawk changes from the soc changes]
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index af680290ce81..0a5ebe0460ca 100644
--- a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
@@ -288,6 +288,11 @@ channel4 {
 	};
 };
 
+/* Page 27 / DSI to Display */
+&dsc {
+	status = "okay";
+};
+
 /* Page 27 / DSI to Display */
 &dsi1 {
 	status = "okay";

-- 
2.43.0

