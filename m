Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02265CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 06:29:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07B710E1F4;
	Mon, 15 Jun 2026 06:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WLyuF8aw";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7273910E1F0
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:28:57 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A4BC31D98;
 Mon, 15 Jun 2026 08:28:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781504904;
 bh=E4l62o+sxS+bPEPN3Rlb+RatxgF6zDPhb0MAy+QFUv8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=WLyuF8awwFeoYvwZKLpYH9y0PJvErUl+91TigkV4jfTSLmJc9+OblHvvo0ry8nCCg
 jcLp+n55UgJ8O230G5hVfmW4yfrfgyfYi1tV2DQMaAa56tnrrSPGsuhHy1AhfEnyeA
 pRxC4N8nr1uMC7mo8k0PpLnOZ8Sa03DDsJY7Ca+E=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Mon, 15 Jun 2026 09:28:11 +0300
Subject: [PATCH v4 6/7] arm64: dts: renesas: sparrow-hawk: Enable
 DisplayPort by adding DSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-rcar-du-dsc-v4-6-93096a1b56a3@ideasonboard.com>
References: <20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com>
In-Reply-To: <20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=spwA6S6xpukisy7pkedqiZJctKlACrqVu7cRL2eEc4Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqL5udr6kMkE9rW3zTY1IfRXRLULQ213D5gnyk/
 YPyuCaBP8iJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCai+bnQAKCRD6PaqMvJYe
 9fqKEACfUmSjtK5rDF096H1Fl8WIafdcfvsmEYL1HofTrHd4j+WmoJVBEKaqLxFJJEU8XYHUmgB
 X6YtbnRpozVWq80K7R2EqK+nMAX7VDk4karnA6ogZPRWTebYV/OjdxyA8u0oPPMjho87QmLRgO4
 RYN4aJe8LsiELk5VPsmQ8JlfvEJ8ix/lOJ6NounHSzVy/TWWgPw0uHyggcoQalLZZ6w83nd6xII
 EIvqnGpHnGV2/jRqmcG5DDqil16BBvBkW8LMtR31VtboH0MNneZNFK+bixO+43LIR3vBotNHDe5
 27+452HJLklUMrvl8LBqU/Rj9Lmmfqg3JVZsi2bJIE7JmOB/l3MLVSRBiORyxk1/uyTux6gKJVZ
 hy3cIuicBxU4vSPLEiZr2BAaPMzHhXBF0LB0R9kopFDS50vAqkFksViCtsRMQlQXI1uI7dwI/2m
 TJjzLVGYePJmEcKpmbX6QkPZOMTzlNbacal5ruq16Ygzgl9VtPVi3I2jZrXNTE+XucG5patIryi
 bu/q9BosGM97W7cctLSCo0gXqS9WGLQIWDpIP2jkcurDBGaGY74RDS01CXlrytlr7XjswIBZvDB
 BDo3AiRg16Qt0hpqt53NvsVP+ut1MhmG4yGE4Yio0fMo9g+4r+TbURvuMLpT9g2GPOcIcwclsmy
 i5iB8AMU7E2/jAQ==
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

