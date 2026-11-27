Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0023A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JNojcvr3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F11710EAB5;
	Fri, 27 Nov 2026 02:08:31 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0074B10EAC4
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 02:08:19 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so4330711f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 18:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795745298; x=1796350098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6KzTZReNBeJl6qCru1asKNz/QUPw2Qe74+6vA5RmLK4=;
 b=JNojcvr3Vzb38Kir6qzTs4flQh1vVXq0Pvy/KH0UoxCDAD3U5Rn4uU7ys3nIeMWqon
 oOZ5Ivs9suJEdVlAQTXhiXuR0HhxNW595aKusj2jIPC9z42it5yEFOqMWen6hBgYtqKG
 T+nwlBU1lPEq1sk0I/D6RSJCrQsBqvOtLdBdCcrn3ur8ETSB5JIPc+Mwds+KSb1FeafH
 G5hNaWj/3viQvhu0jFahQMM96IMsMbrnwEdiApepATA7lDdBZXbERv3hZUy/DoqY2/4i
 bBeS8UuG4al/6mBR+Hbj8pW+pB7kqx6L12M0fIRCJ+AoQfDrMpwqh6p7ajOVdB4a607G
 nRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795745298; x=1796350098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6KzTZReNBeJl6qCru1asKNz/QUPw2Qe74+6vA5RmLK4=;
 b=JOK27y5RGGsb/lCyD8MWusAUVYWfhTRM0O3ESp5zl9kGVuA5ynKPxgQQnYKYD0aMmS
 8oPyZm60BmZlfwqkcJBTgWl3NjvEyF2rUkN1HIfFL8AECTf33y3IZvjCeI73PdyMeXwu
 u1/Y0WTo8emu7UD7p142xKmhm4KKFnGEz1gTfGNaF//K9bM5id4jeQuigK+cDDYc66wZ
 VcpBBne97uchROU9suK/IHrvfh+Vt5nuCNMZXXQ7G2HRaLJ7esH5tNnZTU31rwM2afHt
 zuW6NOwesEGZgYKMqxtZcFv21b8+OBo6fES+fCdMfEZQhYQgW54i+hjjntfihmTCIWX8
 KRIg==
X-Forwarded-Encrypted: i=1;
 AL+hErFIB/89zbDLIWnoq/09jRClzmqWpX51C0LouyJRINzTmOJHaNBzHqt5pD2JuptVmUmHe1ToR71tVbE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/50/bjMPUVyccN0Tjpa4qeQfjxrQ/rZ+QIVUxsGU6O4Xq2mHLE
 NcxUW29nU7QXCp5eRW+yVxNklbUNKVMyJUs575nKyVlIWwb8KjuuT0Uj
X-Gm-Gg: AZFdTZfuog1OEKT77e7c8KjncOdIczxJMbjbZRM3LQu/XjaKAQ4EJWcUusmJaLZdnZB
 G1k9EbAJIfqgiAoQFRvCBZ9W+RY8P8UvoIVqumR5B3cBEve/jOCFL6rWZk+TzyNblD2k3qk2PCG
 TtgsuN79mUCurexsVHF3ocjAxONyW2/XZ/Zz94wpbVoFEECbwLyj99rHxq4rNKWmmUMvh6J7z+B
 +TrBUTVNRHmGFSgcXJF6v7CcB+OZ6EC7fQBIVrlstOcHhBD+RSJc7+YIJ6uBMb52XsceVQXxMaR
 eVUfUb4d8mYDYBaZpTzdLFW1CNg+CsCFW7N110VYUwW/uLGIlEguIO+LEuiXVV8UThDEiz+DWDG
 dkJJ39qzidG8O0oSGNIrG4IwUPN6Dybc67AEh6hwXo8OnMgGa8/9c5fWikBYBW8RUzI5L4WsCko
 AZiSky2zORZX9flFFV2Z07XGsmRv4iyaZVtX4CABKCqF48tNR8394oTZcZemeF3XGsumPHcuka9
 +Xoplm/u0Ft3ouV44am7T8fY9OVqQ9+Y/vTrtONQs+HzKt2DtzgXtCM3oXw/v2rTtYxGp+DRM6v
 JW6CP/kxbUC7hn2jANyOoJepQjAnoNL+l5bu2l0b4JAVgfviVVeeYTrcuQO7/dcq5xbgBY8QvNJ
 gqY79yftVm5bxiRRnNh2Mq9npa42+fQXOKFgEXW83QtoUwg==
X-Received: by 2002:a05:6000:2482:b0:4bf:2f54:9818 with SMTP id
 ffacd0b85a97d-4bf2f5498f1mr939131f8f.34.1795745298260; 
 Thu, 26 Nov 2026 18:08:18 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net
 ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6baa3882sm43390844f8f.49.2026.11.26.18.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 18:08:17 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev
Subject: [PATCH 1/4] dt-bindings: display: panel: sitronix,
 st7701: make the port optional for DSI
Date: Fri, 27 Nov 2026 03:08:12 +0100
Message-ID: <20261127020815.1621790-2-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127020815.1621790-1-romain.tisserand@gmail.com>
References: <20261127020815.1621790-1-romain.tisserand@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A MIPI-DSI panel is a child node of its DSI host and the driver does not
use a graph port for it. Commit 2f50e0a0f9d3 ("dt-bindings: display:
panel: Make DSI panels port optional") made the port optional in the DSI
panel bindings for that reason. sitronix,st7701 was not part of it, as
the binding also covers panels with an RGB input set up over SPI, which
do need the port to the display controller output.

Make the port optional, and keep it required for the SPI-controlled RGB
panel (anbernic,rg28xx-panel) only, as that commit does for
ilitek,ili9806e.

The Allwinner sun6i-a31-mipi-dsi host links its panel through the child
node and has no output port, so the Miyoo A30 panel added next needs
this.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 .../bindings/display/panel/sitronix,st7701.yaml       | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
index 044b84d8638d..3ca9aa215b7f 100644
--- a/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
+++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7701.yaml
@@ -54,7 +54,6 @@ required:
   - reg
   - VCC-supply
   - IOVCC-supply
-  - port
   - reset-gpios
 
 allOf:
@@ -69,6 +68,16 @@ allOf:
     then:
       $ref: /schemas/spi/spi-peripheral-props.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            # RGB input, controlled over SPI
+            const: anbernic,rg28xx-panel
+    then:
+      required:
+        - port
+
   - if:
       properties:
         compatible:
-- 
2.43.0

