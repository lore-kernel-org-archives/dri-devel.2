Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CD7CD4851
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:56:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FD610F45B;
	Fri, 15 May 2026 07:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BLH7KkRX";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E6A10F456
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:56:44 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2D0718FA;
 Fri, 15 May 2026 09:56:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778831793;
 bh=5x7Ln4iaXdF3MSB6XJc9r1qugg8DjCeCJV/XznDnxs4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=BLH7KkRXByjpKTqdiiNG0jC4Y/Y2WJ0TrN0Ql2omAR1JbpoCejkKTamtxXuZpBEMv
 Y1Xkp5zWOSPaB0dDgVNiaGJM23H/14cApmtKsfPoDkGH8KiXg6MPmtt4J6yCkYRjgB
 p1fZoyHux6+DtTQeyo80GCsx/kPLe+QsoKmjP16o=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Fri, 15 May 2026 10:56:14 +0300
Subject: [PATCH v2 1/5] clk: renesas: r8a779g0: Add DSC clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-rcar-du-dsc-v2-1-f6b9240a1240@ideasonboard.com>
References: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=929;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=Sa58pHpMpn9uJbYQtT/HcZDpP5JrbrhbJQzUT3AA1cQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBtG2U9cU1ezkVTjg+KIlD7zGzcdR7RQsVSAuG
 dCHqlOgIQKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbRtgAKCRD6PaqMvJYe
 9WtKD/9TBSO8xPGVzKWm80tuSnVIdAilfZTNvmiMKO/LQk+QIfGqTbe6IhVRouBUJ4EB9mHTfJ2
 oxEdISJFctAvGUIcbXPrVNHkw+cAHe0PzL2hlbKcp/TYx4aXxgaX9InHh0VtfD56RueQaYgXGnq
 QjAWOrDQbRaDrrFeoYtjUC2sQpToT9ICpc1AXLnrpHZNkZiGBN/Nou1Zw+2gygUz0aplcLo45Fl
 SUnOL4g7I0Bc+ZNuUSjtjJk6OpC8rWaehpq1G5lvPXuJiye9Z7PlyHkilkhKspVbnk2zFXbeVyI
 l+UIu/jeVQJ8SPNCvHDIALH3QdmyWutjA2upFkVl5CuI+ohZ04IRyFL4RMfkaJY8wb+u0fF2F3G
 OlrCHFVVq8rR1Hp+5c9yPJe45xoDWIwATBwwJLMU0n8YlHH3ftEq+5BUAEKhRqKmVTOrDJSHq5f
 IUnXzvSS4Lrn8/KU8jTSwwjJh1QAAYhuXbO6ilhiX5+DQ/YvjXypCJrd/eIf53hLB9E6cpFJJWa
 ent1HrwnYSoyZzBgOrHIbEbMRoWiasMly6FKbOnZrJLDPgbFrfJNq5OhmIbWjXGj+MXv1QaXGlZ
 igiRll3Jrocd1T/8UKMSCZBO4pSrDHy3WrXZ/puCrhxsgmFPScawUvpdQkhWtmzKE4ZOZffhgV2
 0St/9gVWiFhFgwA==
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

Add the DSC module clock for Renesas R-Car V4H (R8A779G0) SoC.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index 015b9773cc55..54ba76ff5ab0 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -245,6 +245,7 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("fcpvx0",	1100,	R8A779G0_CLK_S0D1_VIO),
 	DEF_MOD("fcpvx1",	1101,	R8A779G0_CLK_S0D1_VIO),
 	DEF_MOD("tsn",		2723,	R8A779G0_CLK_S0D4_HSC),
+	DEF_MOD("dsc",		2819,	R8A779G0_CLK_VIOBUSD2),
 	DEF_MOD("ssiu",		2926,	R8A779G0_CLK_S0D6_PER),
 	DEF_MOD("ssi",		2927,	R8A779G0_CLK_S0D6_PER),
 };

-- 
2.43.0

