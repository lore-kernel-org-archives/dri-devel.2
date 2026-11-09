Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0548606A33F
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EeacYlH3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BAC10EE62;
	Tue, 10 Nov 2026 08:33:36 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726FD10F225
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:24:06 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-491971ac844so770284f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 04:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794227045; x=1794831845;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d64Eeo6OXmswUP7TGcLfAo+FgU+WY3FNmOxdthXmfRc=;
 b=EeacYlH3+kpWD1h35+0y/gXqsa0XHCXcCAj96hHbYgvYDcPwTw7YAbP2HFqggqqMt0
 q919pQ+8eW0z+oufUBJxTzOMDp5dUEQe7ETnAJHa6Q8UwIFI50TSlsZ9sFUDONZsNjqh
 48EsUPjDcOTWSD9ji53RkcM6KdkeURNIaYA+JewNkAaKElz17JkGtVnYNDZR9VzdVSdU
 OSnSIxJAognN9SVwfBZRCmejsnB70khHyGuuUHGOs6CkQQLdl4TSosien3deB5aJ3Mwf
 3iVimQNULAjdwV/P9PXERKDC7q+JgJKx2nMvT58N+7b53gG9VmyqdpdkPtpRleSKwjYL
 TFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794227045; x=1794831845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d64Eeo6OXmswUP7TGcLfAo+FgU+WY3FNmOxdthXmfRc=;
 b=vBtPiTciigoUl/ClcS1/VIw27Dl5lJiuTWQ7iOShGeLU7zfAwDnXF9PkR0hu5IrJgu
 oOwlPfXENVvsQqA8w+LuIA3p6dL7JrNG5pJqZrOQMTvHXU4VsFn+FCo0eQegreo/JQWF
 jPD8e9CEJIt3ZJSpm70WFbjh67UePndBbANZlmPzSwKmvd9OAFSq0AR49adgS4ABMIRA
 SQOdyyVX1vobVrWg4agEDqeWLEZ2IfBhuDqwlMBKezWxaQBAgD88JYOhtEWJqfJGppnY
 sUC4L81W0C1408vLHk5lOxZY5bE44jEmaFh7tdiva7SO5DUcw4gGt2K8B9QZY46wxFdx
 AKDg==
X-Forwarded-Encrypted: i=1;
 AL+hErFTnGgKoEmkdmRO249cfNGgwGfYRwT361RSIDjMXI0or1DCxI88NrN0QqqpYsXdOYBwcZXGp1AIRDY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+YuszlcKPW5URy03ABQ9M3JXDdLmTZrO7NLrDihMZxN2x6kDyC
 D03J10S3Vs/rEtpvBJXDqNpjsFWz5dc0Xu4c1NXOPEbWAa3nIOwz0nQ/2amn6pbERbI=
X-Gm-Gg: AYBFou1D7dGmA15+Qjp7nA3eiFgg1fa3y9fUybT1y94k/zasIy9/jK4t1oCGqRa0Qrl
 BfQ3TH7mMiYfZ15/oLW/zr5upr1hJPBWkggiBit6XSI/KxTDyPf7WZe6pGv1fjhJFxNlXLbLqVH
 Y2Quk6ieZ6rQUNEtiZ50qg2mispWZZfVxUQkNsWTwicsphsnv5iATiWbcEfhcmtMnbjYeL3qxqD
 gsYA5GTe2m6h9zkuAIEBh+uO0zBdBwvFgpsV2IyfcFB10Hz1ZQsI4tNbq4Omf0/L+VkXP6rgTWy
 oLAJh2RSqTWU+n2nQbH3d/FRoTPiFC24wjdV2wnhEKmHXOQhNsbpD3KVFRHXH9/E5P4LiTtTWe0
 jb5WlBYdHe0Bb0eXnOC2wHdB3wSePHQhycI6zPfvTHV6/TtrqGTDMjkHJqdEtkAWzXGsLZRUnnV
 QvJi7YC1tvzSuuzYWhQQBuMTmuPMEcLrALpLpICZkg/xxX41sn/g/u1B6m9919JyDOmEG6x+Qt4
 ZVxceaTYe/YEiZvw6Ciz902u1stwRzUD+gamWQNWDZj2bXB2XwWtA5o7kpmNJMBgTGlv489nPKU
 hNPuvvlyK0CeRgqPyCrVYYhA89nR+Pjpu99jvVBzOSOHI7VLzViEGFvNNxQdL2E749s7X++mlMU
 N6j3a/PMFAqQ=
X-Received: by 2002:a05:6000:2488:b0:48f:db47:6ebf with SMTP id
 ffacd0b85a97d-495852178b9mr6692780f8f.38.1794227044813; 
 Mon, 09 Nov 2026 04:24:04 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597652ca7sm10500318f8f.39.2026.11.09.04.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 04:24:04 -0800 (PST)
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Frank Obergfell <frank.obergfell@bytesatwork.ch>
Subject: [PATCH 4/5] dt-bindings: arm: fsl: Add byteENGINE i.MX93 platforms
Date: Mon,  9 Nov 2026 13:22:49 +0100
Message-ID: <20261109122250.720757-5-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
References: <20261109122250.720757-1-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 10 Nov 2026 08:33:28 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the compatible strings for the bytesatwork byteENGINE i.MX93
System on Module (SoM) and the byteENGINE carrier board.

Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
---
 Documentation/devicetree/bindings/arm/fsl.yaml       | 12 ++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml         |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c8290a83205b..d342930981d2 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1555,6 +1555,18 @@ properties:
               - fsl,imx93-wireless-frdm   # i.MX93 and IW610G WLCSP (Wi-Fi + BLE + 802.15.4) SiP FRDM Board
           - const: fsl,imx93
 
+      - description: i.MX93 boards with bytesatwork byteENGINE and bytedevkit
+        items:
+          - enum:
+              - bytesatwork,bytedevkit-imx93
+          - const: bytesatwork,byteengine-imx93
+          - const: fsl,imx93
+
+      - description: i.MX93 boards with bytesatwork byteENGINE OSM Modules
+        items:
+          - const: bytesatwork,byteengine-imx93
+          - const: fsl,imx93
+
       - description: i.MX93 boards with Toradex Lino Modules and Verdin Adapter
         items:
           - enum:
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ac2f54adde73..95f386db1d01 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -285,6 +285,8 @@ patternProperties:
     description: B&R Industrial Automation GmbH
   "^bytedance,.*":
     description: ByteDance Ltd.
+  "^bytesatwork,.*":
+    description: bytesatwork AG
   "^calamp,.*":
     description: CalAmp Corp.
   "^calao,.*":
-- 
2.47.3

