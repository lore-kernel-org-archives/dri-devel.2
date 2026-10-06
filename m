Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BBFCA5FFC
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 20:25:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 800C310F3AC;
	Tue,  6 Oct 2026 20:25:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="GmUWBh6+";
	dkim-atps=neutral
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com
 [209.85.161.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920B910F3AC
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 20:25:44 +0000 (UTC)
Received: by mail-oo1-f42.google.com with SMTP id
 006d021491bc7-6d68de53053so446150eaf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1791318344; x=1791923144;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=B7d8+d8Jg6e4zgR7b55B5I4HUSkrjz23uBlGgAf5rGA=;
 b=GmUWBh6+pmwPIBtmB3q4KE1yWTIPwAOaQdEadsuaKuFIOlZdNIlmIuLuUiOkm8qVcf
 tux/jiZvXsTBnHsRvAqqaFkygPOBKCErcEduaBqOdzlvsUcTTlru9PUdD2+fGRIPtcXo
 zu1HGpgq3Q3jCabCXDMuZlr+ldOgB2sR4wbhYBKKjop0+o/taoBpPgGH9M5TNQtzGinA
 Rtnb8uodV5sWNLP8q0aF+7fVxteRA4xbcwErBq0no+BdXV97WXe75icbQITDwpf08KxU
 vKhmFjLM4jpO3rAfKpCRPlNTOFMUyU+TBjEpekm5yjtX0LYQ69bcZ5/RIKUrEk6pU0vH
 LZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791318344; x=1791923144;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B7d8+d8Jg6e4zgR7b55B5I4HUSkrjz23uBlGgAf5rGA=;
 b=pewUbP7l1PgkQKo2NrMXBsA5U+/rB+YaOgP36tuyAM1UvLPLQqUrS/zU/tdS7LeKG8
 wravB/OGRvmmM/zdB/QqFKajMf/3VJJtwhGSbfcB+VNv6MciZjjHMNFB5tUQn7Mjqa1l
 cNWdC0RPk0VCTkHMX1zBIukYrOf9ACXo1HOKp7I2Qy4v6Gy2AHimZ3o2PSz2vL+eIDIg
 NW1vHNwQbZa23qYhxoX4V+EP6JVRbfebZlWBcSUcBnLaGlhN31vEEsE+FEtHlkhBDnFn
 tTqXaxiJvkCZqXCw7ByG4jUN6MMpuHQ9+9ptc7+32zonqVbxmdQbzYusuYmXodyjDb9+
 e6cg==
X-Gm-Message-State: AFuF++nrRK5rqzttP4bTgLvLbxVHnB5bfUo1IOsJx3UyIftcd181HGhJ
 rQcSCgrdASniJ2Jx+a8OaIkRZEXpyvtnCbD+qyslXI30ha+Ot+Dl4OHjswTzFE+dypg=
X-Gm-Gg: AYBFou1vmvA5C+SoRaY5Bk2YlmV2dGsdbRDuROmzMzFa36d/Oe0T8V4rigyhymxb0Wj
 7tNAL+EvnfvD3XWygnLgjoJND3Z4Sc0UEUk9OP68zA3Gb4SiSkAJbYLwo/ItlqGussiGMZojzyi
 vQ8OLs6r7EhRfp21+fNPxiZ5/tXInHsqF8pS4CnhqTOhAtGfwfx8jQTXVkHnVIMfQcJMAN68SAk
 Ic3qb6Ej6C5vHoZbIHk6hVOuLsnYjk3sFegS3WCnan1fBMwpXth6AEgtlnGW8ZoUaFP1sGpmz+7
 q3GOSmWt49oYKVDZaCzEiGCHkvuwR7NWV333i4aCPyClgWkfjwU9A7mib4FpMbiP++/pZQ3MfbB
 AwX2SwOij6Te9CZR5nqBUz1tan/YYQsPUqP72F0kSp81BNcP42lXmYvPpJZaUCc5rcscs9FJw07
 wCNfj0d4mmscYEkiWd0E2OAf01avN6rZZU3hlduVoOJzuh/9JP3BtM88OiGi0jicdVS8qBa74Md
 Nw=
X-Received: by 2002:a05:6820:c89:b0:6e0:8fc2:84a3 with SMTP id
 006d021491bc7-6e7a9125036mr295388eaf.39.1791318343680; 
 Tue, 06 Oct 2026 13:25:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:372:3180:ce34:1fe7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e793f68bf6sm463442eaf.8.2026.10.06.13.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 13:25:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 06 Oct 2026 15:25:01 -0500
Subject: [PATCH 1/4] dt-bindings: display: panel: himax,hx8279: add vddp-supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-panel-himax-hx8279-vddp-v1-1-50d884b42aae@baylibre.com>
References: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
In-Reply-To: <20261006-panel-himax-hx8279-vddp-v1-0-50d884b42aae@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2205; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=+6mowQPvO5/qbWu07+JM4tpqCNNR0Oy6FVUyr6NCfh4=; 
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqxVklqqKz9ZZ5EYTPs3b/ghtQnZoefwxQSM+W0
 GisMCHkGeSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCasVZJQAKCRDCzCAB/wGP
 wOHSCACcvVmVgg5xUxBOP/pHIgPMZ2Lhcfg4VZwwLRNcQLQE+uS/SQ4GV4kNd5pon4GVAyGLWMA
 hluJJJ+r7f4HXO+LMEXHe4siAm4FrOxhHWzzfvdZbpAes5TzM2ZzBI35cytFG01QQjODNLk31Ju
 ok2s6QEW3pyKLzVkkCJX1n4NCk4D0Tpcxu+wDjeWatZ49EPobpXz/MDhRyCL5eucimvRxWQkN+c
 q+XA6vMhr3/TSrVZwvozFK8v9/O75FHHxwIqe3DrzkJYxxRzxfNfE1s3Vh2BidaQN4hdgc0/qc3
 88m33Uam4PLXxnMeUHzrcdShGxwdILR/UCB3o87IYotFEd3M
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a vddp-supply property and make it required for the Startek
KD070FHFID078 panel.

The Startek KD070FHFID078 panel has a separate VDDP power input, which
feeds its DC-DC converter, in addition to VDD and IOVCC. On the MediaTek
Genio 520 and 720 EVKs, VDDP is switched by its own GPIO-controlled
regulator, and on the Genio 1200 EVK it comes from its own PMIC LDO.
In both cases it is separate from the other two supplies, so it needs to
be described to power the panel.

Making it required means existing device trees with this panel without
it no longer validate. This is ok since the Linux driver will still work
with them because the regulator core uses a dummy regulator for any
missing supply. And anyone who sees the warning about the missing
supply should add it to their device tree.

It stays optional for the Aoly SL101PM1794FOG-V15 panel, as it is not
known whether that panel has a VDDP input.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/display/panel/himax,hx8279.yaml     | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
index f619aea82bdf..c79056c39037 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx8279.yaml
@@ -37,6 +37,9 @@ properties:
   vdd-supply:
     description: Panel power supply
 
+  vddp-supply:
+    description: Panel DC-DC converter power supply (VDDP)
+
 required:
   - compatible
   - reg
@@ -45,6 +48,15 @@ required:
   - iovcc-supply
   - vdd-supply
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: startek,kd070fhfid078
+then:
+  required:
+    - vddp-supply
+
 unevaluatedProperties: false
 
 examples:
@@ -63,6 +75,7 @@ examples:
             reset-gpios = <&pio 45 GPIO_ACTIVE_HIGH>;
             iovcc-supply = <&vreg_lcm_vio>;
             vdd-supply = <&vreg_lcm_vdd>;
+            vddp-supply = <&vreg_lcm_vddp>;
 
             port {
                 panel_in: endpoint {

-- 
2.53.0

