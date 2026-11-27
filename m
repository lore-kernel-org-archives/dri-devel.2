Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B658606A321
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 08:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=d-silva.org header.i=@d-silva.org header.a=rsa-sha256 header.s=2025a header.b=G1bBQy+r
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE68711283A;
	Fri, 27 Nov 2026 08:29:17 +0000 (UTC)
X-Greylist: delayed 388 seconds by postgrey-1.36 at gabe;
 Fri, 27 Nov 2026 08:13:26 UTC
Received: from www.nmnhosting.com (watt.d-silva.org [119.15.109.137])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3ADB10E00B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 08:13:26 +0000 (UTC)
Received: from Hawking.lan (hawking.lan [10.0.1.4])
 by www.nmnhosting.com (Postfix) with ESMTP id 16CCD4C97D;
 Fri, 27 Nov 2026 19:07:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=d-silva.org; s=2025a; 
 t=1795766821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/ihj9ZaLmQ6are+i9ZnLsHqIUJCuh85LNDTNIUPYnE=;
 b=G1bBQy+rEdSQei71uD9/p/Nl4cDoRP9BFcZcbHbJ70isNLRQhlnxoALZSabSBHgmCYXGDI
 6fKYMTuFTsNxJGmN1xsl/ReJ+KQibYO43Yh8oCHsTjAXmp3SorNzfluhSYwH50AJDE3zVf
 Q05ozVOG2dzYk6+HjjMcuOkt5674HBEetOAuqtT6NMqrs2UWlXjuPC8jmKkmaSWORyf3sL
 jwkEERLnjQi3iHJ2gkiktJkfuwMcQKuJ2wr+2++k1ROz7zUKiZOYwlgglsNUvr1u+LOWSx
 tQ4PaUXyCa7qLbbiEJhEdFDV1ToMuPQ1ydNSXg4Ndvre8MDZ2VZzBafYgMnN3A==
X-GPT-Reason: legitimate; the email is a technical patch submission
 ("arm64: dts: allwinner") which matches the technical nature of
 the mailbox (alastair@d-silva.org); the From domain (d-silva.org)
 matches the recipient domain, indicating a personal/professional
 correspondence; and there are no phishing indicators, urgency, or
 suspicious links.
From: Alastair D'Silva <alastair@d-silva.org>
To: Hans de Goede <hansg@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, Alastair D'Silva <alastair@d-silva.org>
Subject: [PATCH 2/3] arm64: dts: allwinner: sun60i-a733: Add PCK-600 power
 domain controller
Date: Fri, 27 Nov 2026 19:06:48 +1100
Message-ID: <20261127080649.1982883-3-alastair@d-silva.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261127080649.1982883-1-alastair@d-silva.org>
References: <20261127080649.1982883-1-alastair@d-silva.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 08:29:09 +0000
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

Add the PCK-600 power domain controller node to sun60i-a733.dtsi.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
index e062b08006da..509d0cfea160 100644
--- a/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun60i-a733.dtsi
@@ -4,6 +4,7 @@
 #include <dt-bindings/clock/allwinner,sun60i-a733-r-ccu.h>
 #include <dt-bindings/clock/sun6i-rtc.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/power/allwinner,sun60i-a733-pck-600.h>
 #include <dt-bindings/reset/allwinner,sun60i-a733-ccu.h>
 #include <dt-bindings/reset/allwinner,sun60i-a733-r-ccu.h>
 
@@ -595,6 +596,13 @@ r_i2c1_pl_pins: r-i2c1-pl-pins {
 			};
 		};
 
+		pck600: power-controller@7060000 {
+			compatible = "allwinner,sun60i-a733-pck-600";
+			reg = <0x07060000 0x10000>;
+			clocks = <&r_ccu CLK_BUS_R_PPU>;
+			#power-domain-cells = <1>;
+		};
+
 		r_uart0: serial@7080000 {
 			compatible = "allwinner,sun60i-a733-uart",
 				     "snps,dw-apb-uart";
-- 
2.53.0

