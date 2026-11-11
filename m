Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C53606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=N8mUH/0W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE7B112100;
	Thu, 12 Nov 2026 12:56:26 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75FA910EA1D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:31:47 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48fd2e38825so1918570f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794403906; x=1795008706;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gDkCPzQ/fTCTlPmLlCXyz89P1VioVc68pLa4Q0ahyVc=;
 b=N8mUH/0WWUA5/u9rpffSD7mUjuKjlYy8M5BtPlH1lryqFd8crvY7YNeWj7qKGiZSTf
 RiLRFR2g+lOefVvnYhKZANRWtuHhHTQZmZtLaPEtwW8BebRgixX4wzbcp+oNDA5LRTZp
 wq1QRa94K9+BxrxXgIgDGN4cSBE0NPTMbwT5td6fQ66oiLZR71FXj2goqD1SxxOYpRI4
 mcUf5tnTXIZkqU4FlFhYQ4V4Jz/l6fsWA+LxDJWPCJU6IHWdjfscWf/4Xp34Fo7TBpMc
 MqSMnFNZjwfF7X6iwPi9Zh1jbROPR1l3H10oE1gZMZdkw9hiDliTry88jM15yKg7qwgT
 UZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794403906; x=1795008706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gDkCPzQ/fTCTlPmLlCXyz89P1VioVc68pLa4Q0ahyVc=;
 b=2rRFGKPJIR3zlnaM1nfIDz50gE7GG78o6lkyNYZSmCkJr9rF9QFSNg7aNsjY1ep2Ge
 No0z64qkVGwiy0ZrtEuUgpy4An52Pz6re9cywaECD8A0kls8IFlojGKL8P17O54+p0OA
 WLYMOFLW2QlQ99oKmXWYGk/AHGeaFpEOl6jp0v002/XVALUg5ZstKZUIRADs96xyAux5
 9dWPXSRp1L6ghCOLgnbU4Nw2mjBauPbgBLIbuk99J8G/Xf55WyhiulHjwoiGwXCV1bOo
 Qm1hzrdzIacDR9uy1vEHkNDjlFARoZn+pBkXTrWwdlyn4l0ktguYXqUCh0YlccckhAPs
 6Mkw==
X-Forwarded-Encrypted: i=1;
 AL+hErECV0gWopSLVUyv0UYIuZMnrh8xF6YDzi8Vbs9kYDbQ769EQ6NWlWkr6xRv4k/IFSU+QWp357UPeIA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z//3J6dk+Ff4FSDX0BwYQ4B+USuTs0LjU8bt/8gr3H38oOrk/IH
 DwYDuCW7S30shb6CSuxi604hlPc/Iwtc+qaR7/NVfx1DvlLVqX6axEVklyKxLXxWtjU=
X-Gm-Gg: AYBFou2yEJxAgL/+i54OiFikt6MGynVNYHFvJ4cikQrmScuZaxWz7b2PvgOvEjpoKo0
 hMMSWokuNgHd1qwECgwv8gxMwjOKmICzX/8+5X0bUjWEKGQdopH9FWWJD5rTPRhlN70gkEfa1Qe
 CJuyrjPpTMAs11wVpmI8wh3+B6SSZscw8qzb2nQtZanKMPedUoOpyOUXJu3FnoX4o3DAb9qdHN1
 Ga8TYtyYH5niPigVU3ylS1VHpzqR5IeNMucp5Vslz5h1mPjCSkBb2klpD22A+b20Ki7gh62ylbg
 cg7jFCpEcvT/ZVPvit0yx5vZjWATR260rseh4nAoUND8NWi8W3mnEKygzZyN+qf+ZTFckwA5mGE
 qzL655Tn124Jwqn/8LiiamfolVkTLCp+4M/+zzUIQJz+BnBeyjRbDCSLwNK9NhWHkKZrJ8jG2uo
 B5HSd4NzMXvGHqL4WGXb1mbONr1DGfsmU874VEKmatL8nb/6Fq3bb9+hYAiz8Rj5vgbNV3VWkGP
 TtxB5p4vxR631tdGGUwCETfigTPXy+NR7E58/cuY3pA9YgCEfmM27QQ6AHGF4UzUuzrR5U4J3YI
 R/I1pbtu9dAXwNOPjO031+W0l20Iuo7LXErSi5vx6kNURVACKr3UwMJb9s1aEOk7974iyyN+wGX
 n0qIrHfyYjQ==
X-Received: by 2002:a05:6000:4688:b0:493:8704:ad42 with SMTP id
 ffacd0b85a97d-49a90b3a0d6mr1095762f8f.7.1794403905804; 
 Wed, 11 Nov 2026 05:31:45 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm11089358f8f.37.2026.11.11.05.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:31:44 -0800 (PST)
From: Frank Obergfell <frank.obergfell@bytesatwork.ch>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Frank Li <Frank.Li@nxp.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Jessica Zhang <jesszhan0024@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Alexander Forsch <alexander.forsch@bytesatwork.ch>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Frank Obergfell <frank.obergfell@bytesatwork.ch>
Subject: [PATCH v3 4/5] dt-bindings: arm: fsl: Add byteENGINE i.MX93 platforms
Date: Wed, 11 Nov 2026 14:31:18 +0100
Message-ID: <20261111133119.1063210-5-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
References: <20261111133119.1063210-1-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 12:55:13 +0000
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

Document the vendor prefix for bytesatwork AG and add the compatible
strings for the byteENGINE i.MX93 System on Module (SoM) on the
byteDEVKIT carrier board.

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
---
 Documentation/devicetree/bindings/arm/fsl.yaml         | 7 +++++++
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index c8290a83205b..e4be6fdb5808 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -1555,6 +1555,13 @@ properties:
               - fsl,imx93-wireless-frdm   # i.MX93 and IW610G WLCSP (Wi-Fi + BLE + 802.15.4) SiP FRDM Board
           - const: fsl,imx93
 
+      - description: i.MX93 boards with bytesatwork byteENGINE and byteDEVKIT
+        items:
+          - enum:
+              - bytesatwork,bytedevkit-imx93
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

