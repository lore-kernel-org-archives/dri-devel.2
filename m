Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDDD606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytesatwork-ch.20260707.gappssmtp.com header.i=@bytesatwork-ch.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=f9NzdRc2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B87CF1120F2;
	Thu, 12 Nov 2026 12:55:53 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC6A010EA1D
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 13:31:41 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1931274f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 05:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytesatwork-ch.20260707.gappssmtp.com; s=20260707; t=1794403900; x=1795008700;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MqrvWQFAmvLweRdhffijQ7Kj1AgA2ef8bviYk4Ix9o0=;
 b=f9NzdRc2FTVDBaQkR781k+Bbfo68lW15mGDbqXmnWRutNCxAVUeLK0nRfBbBKPR0Rm
 q/UJd8VKGRHL+zA0HaU+usok+UkkXnigA43YodeCBO26nMSQxt4VAM89bc9gg5V7DogJ
 i/w3LNjDA+HfrhdG5ojvCPw9Lo6MLw2/jcIhHhXzwtxu5rsBlvva0+aGuVuY9aB4RLpX
 uTcfVxlIDoP0wwahzjyRrndsgp/TEtjZy5OIpSpsQM8C19xmOP7xbRIesoDxGxuLAgSM
 OQN4LvYkFtcd7GY1zGIrwpeMittl35d4qwWifC1N/KMHICw5xtOrKuaFjTNx2ODNs5j5
 T7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794403900; x=1795008700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MqrvWQFAmvLweRdhffijQ7Kj1AgA2ef8bviYk4Ix9o0=;
 b=X0FXVN8Alvr1moabrXIuj1tFA1ZHRqXvGWt9KQo+xCiqYKX2vMkhb+C9YolhoICxv3
 f27jOrMjZ7EEh5dy1dKibCho8BwssBIe8A6qqVqSxQNOqbKrpjUNYlzL+5rOVR7vhOlB
 JtttA27UDOsdgndgCbO8y363KRVAeXk34tKhLw2sF4jQ8JbJAqnKvFtZ5aCgS98b//rh
 K0QL/yu9ysXRDteek6OhD7s4OH2j9arheEvCSe1ToFjX5+7wDvOj3vPsO7biuL4mvlf5
 /yL6a5WHuNf/a1IAKmZEdmtNsDegusNGG4VfO9WSZBIC7lYjhiSiu55F9f5JFusPOHYu
 lEpw==
X-Forwarded-Encrypted: i=1;
 AL+hErEqPsH5Cdy+2RB6Cv6aRhRuFRjPpbLUEhZcyPw4xejuYU2tnZDKiMutERtzVWvN37ZZZlweE7nJiHI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+1qYl/j4FgDvb9A71lShCIoY7XZweLx4rhrt9oeB6edCfpr61v
 vBDEiuz49ObyniQe/0/qH6Mh3FcFMd8TQachr/dVm9VHVmFnyrYJpSVnBfm1zrvmFRQ=
X-Gm-Gg: AYBFou1Ssd6C+Uzr/OQPL/ACOfuYlS1Z4PpKmJb1Uv3/XCpfzPq2nN1ie1AuWUx96QI
 8UVGTFJSOHF8PfFxz4x8pXIZX61hl+unBRISBTMqrHNVCVWyEkJmbrcjbsuoXFLhY7W2YBWcTYp
 vidVeKwYf+8GkWrdaxcg4S7ims/nm+B25Xo0co5G3DWFs/5S9xlcC+CcTIAHaIzIyUF3090iXBT
 a55hgjpR7SPsN7X3cx2iSezvIhyf4qDt4yo4i2Zze2ewAwRCMIscfufDLZstzNvQSa63pI5qMr8
 knVrsNTGk/gD02FRG1/oeoe/+zw7ePDq8pQASnmSe0rtJqh08PseIGQVuj7a+5XcK8+CtaxieV0
 Ms+GrgpBbywGd7cg7oSZXr73j2qSURStc693xaP7tnsEppjdIbyoMjd1SkGMoRNKNt+e4yXPW92
 GNMA9CCtgO6uaico8rDvrcRG1FdegyC803EB4b3pJouPnE0T2JBwozrDl+a0oHFfDl3imbespNy
 1GVURQjfo+lldwIrYtVqvA3PTjoWwWUVDdbnPYC2Y2gqFWEbZsEykP3CYptn5Hvr//3Qo4bwH5L
 CqGNViOxkR8+O3GN/YkfR4qS27Wlh/wqYBzdfFnRT2J0g5nLVQxaXpfV0uf6IdbxxTUZu6ymi1J
 +zpamVeBojw==
X-Received: by 2002:a5d:5f47:0:b0:493:690c:8364 with SMTP id
 ffacd0b85a97d-499c3ba0637mr4190729f8f.3.1794403900138; 
 Wed, 11 Nov 2026 05:31:40 -0800 (PST)
Received: from frobdeb.bytesatwork.ch (162.40.150.83.ftth.as8758.net.
 [83.150.40.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498363df7a5sm11089358f8f.37.2026.11.11.05.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:31:39 -0800 (PST)
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
Subject: [PATCH v3 1/5] dt-bindings: display: panel: ilitek,
 ili9806e: Add Youritech et050fw01-kt
Date: Wed, 11 Nov 2026 14:31:15 +0100
Message-ID: <20261111133119.1063210-2-frank.obergfell@bytesatwork.ch>
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

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
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

