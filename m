Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD16C88E53
	for <dri-devel@archiver.kernel.org>; Sat, 12 Sep 2026 18:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450BA10E771;
	Sat, 12 Sep 2026 18:22:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V5p1hIS8";
	dkim-atps=neutral
Received: from mail-oa2-f9.google.com (mail-oa2-f9.google.com [74.125.231.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8371210E771
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 18:22:35 +0000 (UTC)
Received: by mail-oa2-f9.google.com with SMTP id
 586e51a60fabf-47cf5b09bf1so652108fac.1
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789237355; x=1789842155; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v8//usBnau6Q5Lsbg3Mie+mt/Y8AKS+7lUlJS5zLltE=;
 b=V5p1hIS8EDu+3/GAnau/hf191W9tZS79pOuV6IcFElHdPBIySSvB39ALWrSLFgYGI4
 r+1sEa2z+pNXZBNEXGg87Z5fwcil9WdCLr7jDWreDOteu9U+8sljZ+kN62y4yCjF3Nbo
 ptbUK4Yeq1/47CFXULIQ7GvxFGKN7ElDQH27/Z4Ug+t1qvs8dD43lLIJPaMtuiJacuhU
 uc1PGNhCIoVh94PG5jwmrcNmDvoDGWPM9BPQ8Lt5Yuk8DDbJvzY8LcRfxXMZw2PmPbFi
 ZMyJZIz6LVna7LUOLCuumpvlL+TYyr7nBHNNOU61h9A+PhWoFXVBlSUn59ZzCUhI73wj
 lxsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789237355; x=1789842155;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v8//usBnau6Q5Lsbg3Mie+mt/Y8AKS+7lUlJS5zLltE=;
 b=V+P/IvWTm+usEDYXEZy408xY5n11Xwj5G7F00KDNrxBOJEZd8ZqzjXVKguoCSWWmA5
 jEobhIBzLwXGb44YHwFsWjnphBOqV/VHsIz7f9z6/J3eXxN6iC3V6vZtvduaGi0BPSaG
 /pfkCJTQo8SA1ac2b+3zhzKEXnUFcl4M3i6otmmT4IK1SGcP+pE87mLuZ6LJO/Mqe7th
 /mpNq/KYfHAdYnZ+rJ7jRizpQj6Tc+XNRxz9vgTVt9XBhf6Uo/88sqsJIX3ZEUi82j9M
 kwZTQ4U2JITGjAREAg7+5nmEwApiaY647eyW5+nYBTpS6ItjoXyUDszgQAJOIZ8ih2F4
 jW9w==
X-Gm-Message-State: AFuF++loG4ilBG2AEYHI/db28A5pqWPf8sbxYyU6V1cM5ef01X8rmKWz
 m2Eo+OfC0x40egRWlfab7imKWBxSGFVQPorW+OJ33dv259RhvnnA4EoJ
X-Gm-Gg: AYBFou0WDptoAI5G6D0WrgMxvJUHSsFngVHqoPfFC5VHnzLm889vn24hqKV90Jxz6Py
 3PDnDe4BC9nuCiCk8I1HDs9CneINUVBf8yfSZeF+Gia6xUs425hNOFic5svjiOUtME8ROsT13ai
 pTQFfbTwysY64mhBAYwBYw2nBYmjDmCS0SYhTlOYLPXTHb0H0Bnptb1TMd2h7PVLYaTEBBvniUa
 GoGCfDOiEY72lW4znF9MvudM7jnzeuNMbQMtSsetIfo7afhVb/CxAPY2UEpqiRwtpAfuhpEJWP3
 0xUJRVtYUL2+NPVX9M3cSSeRhP1afON7bekhal71KA+gFw5Itdwo/iuG470VI2z7VmO6u4Sr5qH
 h7mWB3rbJxfeTCN+I7g13Gn7+rw1ysjqssKvQ08+bHLcvB3jpINGu8xaSXICPKbELUAKteB5l5a
 opFXmdYAf2PzqxEDXTGzrevviPTowrFK5mMv+r9mrCyZS0OpKis6hFo2xOlOPnqCEKZgE=
X-Received: by 2002:a05:6870:450e:b0:447:1ceb:7cc6 with SMTP id
 586e51a60fabf-47de872a0e5mr7271993fac.15.1789237354689; 
 Sat, 12 Sep 2026 11:22:34 -0700 (PDT)
Received: from [192.168.18.164] ([2600:8804:5716:d800::b712])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df64d89b9sm5413898fac.1.2026.09.12.11.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 11:22:33 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sat, 12 Sep 2026 13:22:22 -0500
Subject: [PATCH 1/2] dt-bindings: display: panel: add the BOE TV101WUM-NM0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260912-add-boe-tv101wum-nm0-v1-1-3057a08e8b80@gmail.com>
References: <20260912-add-boe-tv101wum-nm0-v1-0-3057a08e8b80@gmail.com>
In-Reply-To: <20260912-add-boe-tv101wum-nm0-v1-0-3057a08e8b80@gmail.com>
To: Nickolay Goppen <setotau@mainlining.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789237347; l=2359;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=Dk5sO8sprqfKcj5v0A3UNo8voXa9iGbs8EHVHYJth8A=;
 b=B8ZBDlitIgMNBtTa8hluOWFctV75BBpAS9/F9ERZR0Xsfyvo30XET1S+jTjJXlCf6SYkKRVAc
 uazXohGolAuBhr88BfOgJA8DimO7G/7HMjMOMH/Z5bpdoO34uROKAio
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
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

Describe the BOE module fitted to the Amazon Fire HD 10 (2017), an
MT8173
tablet, as a third NT51021 panel.

The methodology for finding the part number for this glass is notable,
since it was done by process of elimination.

The vendor firmware chooses between a BOE and an Innolux module from two
board ID straps. This means whatever the two are, they are mechanically
and electrically interchangeable in the one chassis. An Innolux module
pulled directly from one of these tablets was pictured with the part
number "P101KDA-AB0" on the back, and that part is 216.576 x 135.36 mm
active, 227.926 x 143 x 4.4 mm outline, 51-pin MIPI with four data
lanes, a four-string WLED backlight and a 3.3 V supply. The BOE module
therefore has to match those specifications.

Searching through BOE's panel specifications, only two panels match
these constraints: TV101WUM-NM0 and TV101WUM-NM1. In particular the
number of pins and the dimensions were the greatest discriminators.

Measured on the available board (BOE), the tablet's LCM flex is
silkscreened 1 at one end and 51 at the other, and the area was measured
as 216 x 135 mm, and its backlight regulator is configured for four LED
strings, which matches the TV101WUM-NM0.

Finally, a replacement part listing for the Amazon Fire HD 10 (2017)
device also names the BOE TV101WUM-NM0. The NM1 was released later than
the NM0, but is the same mechanical design and would take the same
programming.

Even though the part number was not physically read from the test unit,
this module is absolutely not the boe,tv101wum-nx0, on the pin count
alone.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
index 550aefaead46..6045385ce1a7 100644
--- a/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     items:
       - enum:
+          - boe,tv101wum-nm0
           - boe,tv101wum-nx0
           - boe,tv080wum-nx2
       - const: novatek,nt51021

-- 
2.55.0

