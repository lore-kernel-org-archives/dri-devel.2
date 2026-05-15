Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FD2CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:10:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9340E10F4AD;
	Fri, 15 May 2026 09:10:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SJn3QliH";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EAA610F4A5
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:10:07 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5E68F149B;
 Fri, 15 May 2026 11:09:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778836196;
 bh=DWzkqIRHTRJjknXuzOwZzjBG6UpC2H2U3Eys36fgkuw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SJn3QliHDVG7fpTW6IRqUrfAcW/cldd6vO9J9XYgMUabJRkFyyRuTg9UDzH23EB+Y
 ESbxPsenT/gFa8xNMwaRM8p6U0Ra0foQKHymXO92PwIk7Lv7Q93CG+FK74W/yrMqrd
 KmyXZTgk9nmBDXfjGZjLhh+sj3bqqWcPrM/Vjq/4=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Date: Fri, 15 May 2026 12:09:31 +0300
Subject: [PATCH v3 6/7] arm64: dts: renesas: sparrow-hawk: Enable
 DisplayPort by adding DSC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-rcar-du-dsc-v3-6-164157820498@ideasonboard.com>
References: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
In-Reply-To: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1235;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=ANA0pOGvbcFJPr/oOvpf6RijEfVZm+6cIfmd0bzB3rU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBuLixs99OiDBbPEBME7nzu5haOunCYoH1ekQl
 gzt6SydVyyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbi4gAKCRD6PaqMvJYe
 9ZpMD/9DlDWjvfmRl9pal1YS9gznGFBYEbhF0VK98Vh8FbWslthU/g0aAcXjV0886b8jBdgg5co
 9DDr0IBIC24+xj0Nz1fpeGMGGT5NHZmuyibIN0zC/7amHJdoHI4ltG1k7/g1YwLfT8VVELoxleE
 TN9xSbpVldcxg8vDS/UXk4Lw7c7RfHCjxP1ATbK1FS1H13KJZWd1mUz1mKUuhgFFpsRHMZQ+/8V
 PoQp3m7WhUTrQwm1ap9WRme7S0/Oaoa+blW0sQaWN/tgDEV6JQbfP2WlYJ/4hp/9PyU8b+rtZK6
 7vHttNcVy4P/42TldMwlRiMiqrAx1ojXl0LU0sD7aPlv6oRwOlLWajtHltWGXaWZWWO4S5MxPrt
 W8qdbe54gAw8tExtMmdFUiWs8B6RWofyVroObMziMFgKkwrgiAnRwlXqxfwHsgyyUh5uKI2Og7K
 NxjDYHvBfKmwgDQatnA7bzNhy67qk4o+XWbjbugVidpboJhLfHv+kTASevdxv/Zl6pQvKp3bpjB
 mFw9kVRf7i900eQFO4mIMY9gc2Dsmo+OXMi76cIq3tYjJrdQaRGZ4K+Y/naGztEzKsUXQvTglC2
 J4InDyqhVJLoL9yTEXyJi7pBUgJOcQoWfVPMQlX+qAKksY9026r0r9K75IcHHjYuQ+UFKGz7NDp
 GJ9VtNliej134hg==
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
Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
 arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
index 812b133cf29e..f418998c6b05 100644
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

