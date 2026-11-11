Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D33606A327
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=bD0PzXTK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5609F10F971;
	Wed, 11 Nov 2026 08:22:49 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E0CB10E2B6
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:13:09 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so23704785e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 00:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794384787; x=1794989587;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y2y9kbz82lKQZudwoFQR8NgKli+kQJ6rKGK4CSSNZVM=;
 b=bD0PzXTKnTUKuOTVwU+kF9rxlzIi9hrMWxwPlV7w6QtTcnuvG7PTU+0TUqKj9zSU29
 BCdeWPQ5qEQ3rfylnDgmFsPrh3SPWLZgbsIH2lFzrUZeQOc8tencq8bmPsYQIrADBQux
 DERXcUvqZ84o7ot3L+IDzLwb3LzVFqRgucMjVCL4yt76Co+Kjoo2kr4OYCjhUu99hK0a
 uryxDIYK7CSD0f3S/0ljDXeT9spiAoJ6A3zhvAoLu4sKi21uWP/x883jagQR+RxZMEny
 9P3JK3LTKxD4aFM1qcC0Ljpj0I7g14M/AOuXbnIEOJtipHN3EvT5YraXJ5sxWWdgvoul
 AVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384787; x=1794989587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y2y9kbz82lKQZudwoFQR8NgKli+kQJ6rKGK4CSSNZVM=;
 b=yCDIvW2D5am1AyEUk1LWcnbZp9jSLduM2S4LRHtYQwFGPcX8oWMSsUv68p3hhafEWr
 dJWCRy9gxzHORRI2eBBAr+MqNvL/2/6Ytqy3jmP6SgikiQCX9byeM8noUik6c86eGnN4
 dS92CLEmaJQC96JafFcNHpu3uzCSF3nXQykJF8mUV+lEmMk45Ffs7tR5P7NzFvMWqKHp
 A0m2TD5PdUZIAb26Y2YMo1cNWtB0rP6FA0AmWFk6oKFawf6TP9e9TNSQZhC1YGwfsPFk
 nOE+TPbGJlap5EydtEm/gXSosCC/Ll/lbJFbuYOb/hlOwh+UQev/Zo/Dx2E168z1aZvf
 niHQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF9ZVkBzw2NO+x9akpIVevqbjJHtI5xo/AIPg36wApwVNjxD0i5On+Mr5THc190b18bl1QRUqROyuk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z88Kcg919XjfQ+oX7yDwsxIYmbZK6NSx3TWSZ5Sn3+olGtXiILP
 fI97IejvsB6gX/GYhwDB51ZHd9KYzRBh64MsKDLdhyuQJn2kC/Tm0fs1vzaaLczRdQc=
X-Gm-Gg: AYBFou1zk+yZmPY9DP3xFnXrugQT671SdaDUo2PgxTO94Hpf7jhshPXGaY9k+VcQMJX
 pCltHgI4rAPKaKPUQg24kX99eZ2jN9iANk9aaqU8hbtCY2rvb5U3P3WLS9ZxjUuqL9PNYqBTz30
 QYAwyNxMq/aygTzMTbHVEJHOpCeRGIePbm+MidCNwd2vCnonEpnca/Md1J/rDnHkLnd66vPwzrZ
 2ZrAuwb09yCE2DVnlG9zhB+R22nNJuaHPPDRZ1GpyRahOssUzB7AIunvsqZkbDRBWxE1eR5POgu
 2wYRvnuoWbEmTuX0t27+a2p9eKShGLVE6RsFznUauVpnnnMmXN8+hJ9o9CzT3QFtgbxTMDOcDol
 pbjyYZrV5q4v/jTNWcktGoUckzoT6PC68G7LjKEAjJf7IetKKE94NOmhM+bmjkZZRdHx7KrzGwI
 zu94W8vwErVDfsqlaJqE2vjuyZF1phzVjcXnSDly9AqP4tQXxmw1KZFGsaFitdBh0itftpe+dTs
 LxLT8+WlYN9pf5aVO1BNTHC1HhEYOjYLpRBXkRroTH2OBq4DJzfvEmZw/cq6tvWmX6Cdpc5aOmq
 TI6Z29mbHTK1l+JqoQJFJDN9yVqWKEccpT74mPL8/q5wRgDmKKzOTFxIaSKUxtR1DEt89xcvrEQ
 BrvUex0Yyqg==
X-Received: by 2002:a05:600c:4f46:b0:4a2:392:9de2 with SMTP id
 5b1f17b1804b1-4ba0937bce8mr32273765e9.28.1794384787479; 
 Wed, 11 Nov 2026 00:13:07 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02242bd9sm113233815e9.15.2026.11.11.00.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:13:07 -0800 (PST)
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
Subject: [PATCH v2 1/5] dt-bindings: display: panel: ilitek,
 ili9806e: Add Youritech et050fw01-kt
Date: Wed, 11 Nov 2026 09:11:46 +0100
Message-ID: <20261111081150.950272-2-frank.obergfell@bytesatwork.ch>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
References: <20261111081150.950272-1-frank.obergfell@bytesatwork.ch>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Nov 2026 08:22:47 +0000
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the vendor prefix for Shenzhen Youritech Co., Ltd. and add the
compatible string for the Youritech et050fw01-kt panel.

The Youritech et050fw01-kt is a 480x854 MIPI-DSI LCD panel with
physical dimensions of 68 mm x 122 mm, driven by an Ilitek ILI9806E
display controller.

Signed-off-by: Frank Obergfell <frank.obergfell@bytesatwork.ch>
---
 .../devicetree/bindings/display/panel/ilitek,ili9806e.yaml      | 1 +
 Documentation/devicetree/bindings/vendor-prefixes.yaml          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
index 2080d9e0ffac..c2e442c20c0c 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
@@ -19,6 +19,7 @@ properties:
           - densitron,dmt028vghmcmi-1d
           - ortustech,com35h3p70ulc
           - rocktech,rk050hr345-ct106a
+          - youritech,et050fw01-kt
       - const: ilitek,ili9806e
 
   reg:
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..ac2f54adde73 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1979,6 +1979,8 @@ patternProperties:
     description: YSH & ATIL
   "^yones-toptech,.*":
     description: Yones Toptech Co., Ltd.
+  "^youritech,.*":
+    description: Shenzhen Youritech Co., Ltd.
   "^youyeetoo,.*":
     description: Hong Kong Cybodev Tech Limited (youyeetoo)
   "^ys,.*":
-- 
2.47.3

