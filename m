Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92980606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SPFf4zFP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DECD10E231;
	Tue, 20 Oct 2026 07:36:37 +0000 (UTC)
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4FED10E9B2
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:20:36 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-157fe9d771bso500270c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792405236; x=1793010036; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5cb5xsu/Ek8DjIcHOFj6xTziW0Tc8RenZR8/LpBW7iE=;
 b=SPFf4zFPXJW6xjrPbVqwU5az1zs3nJIDNPHuf1AOIlVwnAyktd+5p1s7kL7wSkd0tY
 SuFmh1LRyVJVst+TdcChx3cdkvKunnXobzAjQ1U/3CsV4hg3UJhTIx3xkHq5ETsibl8U
 rdFp52i/+zWSVEHlWP5jBeV9JBuyb54BCBRfDPRL2SpaO8uJe/pCVSJD1FB8bzPAhthi
 /1d4y6KhtbuFmCQcNvT+JMAP1KLvlKPXg8l6+5jns6rxgK/FqcCMmTdBT2ez2IMT+Pqw
 i7yflotxoBeiEYNryt1b5yx59egWMsqm5SY01vBiIJEUutxolkQvid5hXJpQdWUpCLAn
 5Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792405236; x=1793010036;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5cb5xsu/Ek8DjIcHOFj6xTziW0Tc8RenZR8/LpBW7iE=;
 b=ojW2r8mtEpz2n57rDcrS/AisHY1mYE/LINNq9CPKYgRDhRCLSlD2DN+O6lFk6m0rJD
 sYXAPPNvrmQUJxotYTCaDBNDhrx7V+MXGjziBO2aPEmmhs4h7mReVM5UvU8D8ZwrLf5v
 BpN+4RBzLBh+jmJqP6whWPSh+1F9j5n/NeNuiAhvkyv717Md0y2JgtTTRnk2FAHJtcEw
 O1qNwpsUa9T0Q4MIQmQX74GslmfiQ7JgnA5m92OQTwBzC5cSzjMJTWrNGejtf8BgDeS0
 oEfrXNNMhIbqWtJj1Jgemq5tGfqmJGk1dsuxfAm0xitFRsxF5or6TWgxPPmnsjsUDYfa
 zniQ==
X-Gm-Message-State: AFq9FYLz/Wqoql5fRW9v9nRr4zVwuImUE+Nq38gZYNbYvLbbJVxh2Ce4
 9zzJ7hqr/d+ZO/3J0dvKYl69HgfI05+/GWxLJIUW/1WQt8QEz0E1vK0J
X-Gm-Gg: AYBFou0tQJmi37+uRt180C2rRk6qImP1oak5urO8MmHhwPLDmAxLp1gnk/CaHMMe8o+
 O7qMElGNS79pnEAiPeOZgDXi0V8Gv42MeM/3XNTPyz3pgM/fjfBYK077Ao8n9QzbOBo8EIQE+RX
 ik0u0UnJmBJ9+QrwpVKG7CWIiebdHyl/wjfaHsFNqeUdkXFRcB3iAdMb+lCFVJLK3/ZH2CH3sIR
 vGUlvMKqE+1BPrXSgwshL9yDYBKTO6SfbXD8L6ShG2xRv0tbP2Jywm76QzzR6iC8qwmqwT7h/ts
 XHHpq7QMivFg8o0hDBSb1LK/MIOxJAKJTy8jojB4VIILhkwVmKjelgZOUG2cAXCXVKsALR6QyY3
 86nohIyF9bq/wBOJaoeWtTyVfl6C5F3cuRLZjjNN57syZvHXJLFEPuBTL9Lmcrp7xDLmMH/hkcM
 Iz8+IXS7SygUhb6OxzHeqSvIkBe/eokobCrD+2CWiApkE76zfJpdWDovS9MQWi/ZLclJniQo/JL
 XA=
X-Received: by 2002:a05:701b:4348:b0:14c:96a4:b631 with SMTP id
 a92af1059eb24-1851453fc8dmr10504406c88.30.1792405235442; 
 Mon, 19 Oct 2026 03:20:35 -0700 (PDT)
Received: from [127.0.1.1] ([67.159.246.222]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-18319d3b880sm26324251c88.10.2026.10.19.03.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:20:35 -0700 (PDT)
From: Leonardo Costa <leoreis.costa@gmail.com>
Date: Mon, 19 Oct 2026 07:17:14 -0300
Subject: [PATCH v2 1/3] dt-bindings: display: bridge: simple: Add
 data-enable-active to dumb-vga-dac
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-v2-apalis-imx6-enable-vga-v2-1-ef6a3a780472@toradex.com>
References: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
In-Reply-To: <20261019-v2-apalis-imx6-enable-vga-v2-0-ef6a3a780472@toradex.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Leonardo Costa <leonardo.costa@toradex.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792405217; l=1828;
 i=leonardo.costa@toradex.com; s=20261001; h=from:subject:message-id;
 bh=PF05NXBIDireg6ZUuKSrsvk0d/GOH3dnTBdN38H+03I=;
 b=HD53baHT8u8/D5pbXuDGQl16Aht+8414McxB843sMyEC12qLowhQ0jc1HnfAvNB3zgF23VEb/
 NDRwdc+iyH3BM2jB6dL4/ITgsqWwfg90tizY7oL/Djh99ux42ruW1MI
X-Developer-Key: i=leonardo.costa@toradex.com; a=ed25519;
 pk=4xvoVLDt+NxIz9D8BJHhT0fD43Ig6XgSDw4jRN/gHzk=
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Leonardo Costa <leonardo.costa@toradex.com>

Some simple VGA DACs may include a data-enable input that must be driven
at a specific polarity. Add the data-enable-active property from
video-interfaces to the input endpoint to describe that polarity.

Signed-off-by: Leonardo Costa <leonardo.costa@toradex.com>
---
 .../bindings/display/bridge/simple-bridge.yaml     | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
index 7636c24906ba..b1b23d41245d 100644
--- a/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/simple-bridge.yaml
@@ -43,9 +43,18 @@ properties:
 
     properties:
       port@0:
-        $ref: /schemas/graph.yaml#/properties/port
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
         description: The bridge input
 
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml
+            unevaluatedProperties: false
+
+            properties:
+              data-enable-active: true
+
       port@1:
         $ref: /schemas/graph.yaml#/properties/port
         description: The bridge output
@@ -65,6 +74,23 @@ required:
   - compatible
   - ports
 
+allOf:
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: dumb-vga-dac
+    then:
+      properties:
+        ports:
+          properties:
+            port@0:
+              properties:
+                endpoint:
+                  properties:
+                    data-enable-active: false
+
 additionalProperties: false
 
 examples:

-- 
2.43.0

