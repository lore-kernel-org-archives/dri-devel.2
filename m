Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD9FCCD98E2
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E667B10E401;
	Mon, 15 Jun 2026 13:12:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="V404aCNr";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C6310E3F7
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 13:12:29 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 937E1AB4;
 Mon, 15 Jun 2026 15:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781529115;
 bh=/uF0APLHA6aMnb0M1XzW8idRNbCMlTaZWelbnpWF4Io=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=V404aCNrafmxbmoKXDHzz9QCQY1DY1n57+OwDoOLtq+6qg65wGA6bppg/ncr1ADHJ
 bp/dDGqis/rLrg8pjzXMHYHe8XpWZYGn5OzT7aS6m/XIfZTXUgMcusICAL3H9e1Z+t
 nOLAtHM+uUkmGqRJYm5QWGEqxd22e5TQD03Sy4SU=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Mon, 15 Jun 2026 16:11:54 +0300
Subject: [PATCH v5 1/7] clk: renesas: r8a779g0: Add DSC clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-rcar-du-dsc-v5-1-aed1a28610e4@ideasonboard.com>
References: <20260615-rcar-du-dsc-v5-0-aed1a28610e4@ideasonboard.com>
In-Reply-To: <20260615-rcar-du-dsc-v5-0-aed1a28610e4@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=dZH6uQVQWsB7Gxixy1guTeTNEQ4KvrhKnhcrz86t38Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqL/o2tkLgrBcRSet/lFbuq6JFOVcsM5msqcC0k
 rOxLAsXIoyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCai/6NgAKCRD6PaqMvJYe
 9QjZEACAfKeb7on6/HA7zbxpy0/z2IPbPJG5CT3MQLV/NUdhWESbE6bJ3CRHqxzwYb69u+10H2k
 uXhwbbTNdHZQWMXYvxJGHvjvgQ5jA/RcTIuMPnYKMB5Hc2ZwEdE2Cn+440xi1izEYbRc3bs52hN
 VMXuCVSQr22N2+90Y9+sm5DdADJszJ0H2V08xMeyvx4nHZb7DwHCkf8EzNlzjnUsmzWFBW4KXxX
 n2negvNnaXjHRciR0SCHx/W243uZ5/ZnLKXEC75mmir6/pHvkuN0QtLQmVhbUmG61SI2NW9Pqut
 MkoCSSXm3nJAO9zkY+vHIolZcWHh4mvJprCBuvXfBMCzZPwN7IwVr5xDIdl7ioorFtteEy0v2jF
 eY3b440T3A1F1xZ/pcjpbeG8/I916wXwFNn+Rhe0a2ziIsw7joLjtlJY9Rx6L9FHPMbfiWcUkN4
 pnCC5wgAyXpalyoduU0sokpRdwYKfufFVJpVOdX64c7pfNR2zSaRThhHtzRxZojmkJiP9p7A1Ln
 0eXVPtv9T/Prdrm9+rnYv5Mz4c3eq2nW+zWIAPrfmSZ78HHMewgMOhzgQBf0gtg8c7wZ/l8FBJ3
 2uU2dN53B82NOBLdrjcFw/dv/YNDQA48SZWW/6UoMe0M48KWPpw6Z9ti/PkLo51+vGhnHtgR+YH
 MWgLdXIoObtavLQ==
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
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

