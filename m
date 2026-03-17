Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994E5FCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C251A10E74E;
	Wed, 18 Mar 2026 08:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ts5wpEq6";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAA310E5DC
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 18:50:41 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4853e1ce427so69061105e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773773440; x=1774378240; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/DKiHHhW4IpTIdEWa3aiwC66PJec1HZ20IV3gMhmB/E=;
 b=Ts5wpEq6RzBIIpuGMeWwOWO10dLST5hwC9pUTZQYqd3nwugNbZWTE4f0m/iHMtwlFb
 BTjKSwPRLCa8qDRwrFEk0dhdVFLr7iEr/TCG8qBV1L+DWnXIhYrowTVXeBNJqduxCAYw
 eOmm2w8wmRJpe3GwlZ2WkyN1Yl92L4eddAdx+H58t+Wd/UFeGYv6kYOTE1aDHzIQ5KUp
 EwAhX4ObVgP2ZjhIFYJEs3V2pyHrTt7bRn3y0p8to06wexjovnL3d2MihbhyoDkFvz4f
 u2jOa03BoH8vKYe6EpjZc/FflP1pYX9GnKsO52/5WK51bVvTHv+ADdMqBF5r1toQf/N3
 QwpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773773440; x=1774378240;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/DKiHHhW4IpTIdEWa3aiwC66PJec1HZ20IV3gMhmB/E=;
 b=NdNavEYy+6om2siZn5G4pg8rEdOzHtNz9rnYE/SJd/QC2gM3uu32mrBTlzI29cyw54
 PU0MP66xdluqH5xvrWEf8lxkGvkFDqVCqLRw2zKWGTWkvmKS1VtUB9iQUfkva+DiBWYW
 WPaG3sq6/njbKIIs2Vvlu+V3fKZPm6bq8MvluKA1F4vjd0/pYEvRu7yDXcnAAp6KblXR
 Mn6WmR8OwrkuqDjnWJXLtk7A1qZGHquJOAZL70IIeVZ+npZbh+ogGG718li5jkSXWrOE
 kNJzRvPWS751n+HJEfPttJeWaQ/pzoAFmXkCi7F7P5UdMP4wJgVyyUn0D5MG30OZzvNz
 Uuvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZMgI83AjDeyLUrfi+YQfOx8ioGGDDbDJyYby8CgEnjOS2l5Yi/mFSfPguEsjO8R23OKoRQ4LZB38=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzU2+/6ShZvrlsp4sIhXbpFCr5FALsgiDJ7Lx10oBTS2f+TgGwg
 a1U2T2i4gDvHIt79fdfzRq3bn9e1T2iopVlXzOPxdpdpNSmLRGu+504D
X-Gm-Gg: ATEYQzyP9YJ/M+wm07zsDh20UeF4Q3PdZxCOoGONkqBQV8RyBn0S1zxsiFVF45I9Gj1
 rL5RXBXZco+Feiy4tkNJPc5e8QmBVeCs4XJfp0aAX/A5JF/ROx+23RZvoiMOEPvhvIwICh5Mj6u
 CXcHAc+EOYAkKM3gFWxk0HfM29DyhrrpbF7HudXUlkR1A9oMNWgL8ioAR7l1pGO4ubUoxjy1SsE
 As7nqfa7ASytX2s5YXIJgAoztpJ22lGGvbiMPqAlKDwey60kgxk9GW8uBvd73kNuW03OiMej+uh
 PUO7JXOJCPLW872wuRLp6B2kgY3gFs2gDJWR1z/wp8W/AKX/w3/+3aXeiXxNiB8jnAIcuziiVLA
 E0Ib8C4LtVfMMWQTx4Gc6GePbE9WUi7Mic7E7xe17SLDpU8at3BHsaktDeid3NOPXdibqpVVbOx
 oc0v1/pAD10JuSAH9O6CU+PTpa+qu5bBgaubc301ookpMtFdRgSCbmM/rKcqdgbVI=
X-Received: by 2002:a05:600c:b8a:b0:485:34b3:8589 with SMTP id
 5b1f17b1804b1-486f4570873mr11068705e9.31.1773773440252; 
 Tue, 17 Mar 2026 11:50:40 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea8fb0dsm152863595e9.3.2026.03.17.11.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 11:50:39 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Tue, 17 Mar 2026 20:50:29 +0200
Subject: [PATCH v5 1/3] dt-bindings: display: panel: Add Samsung
 S6E8FC0-M1906F9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-panel-patches-v5-1-ef99f7b280da@gmail.com>
References: <20260317-panel-patches-v5-0-ef99f7b280da@gmail.com>
In-Reply-To: <20260317-panel-patches-v5-0-ef99f7b280da@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Kamil_Go=C5=82da?= <kamil.golda@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Yedaya Katsman <yedaya.ka@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773773435; l=1325;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=Za75U3v3+V3X3Fwu3C6KSoWJsyv9mKaunMybFhFCtn4=;
 b=TZx/v52umP+9usaTTk4zKeDPsS507pIZ4B3HkCgcUrOc9nx+Uw3xh9sW8h6tffUC5rA56+sYW
 QxD8Ma8NnomAdz3IJsJpFL8HbpgkBH3odn+O3ISBMWr+8p//HMB8JHV
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

Add Samsung S6E8FC0 DTS binding used with the M1906F9 6.09" 720x1560
panel found in the Xiaomi Mi A3 smartphone.

Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 .../bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
index eccfc66d7fe24fbe86e3c25f35beb0855c4fcee6..b271de575e15071bc8370466428bedbf41a93d11 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
@@ -8,13 +8,16 @@ title: Samsung AMS561RA01 panel with S6E8AA5X01 controller
 
 maintainers:
   - Kaustabh Chakraborty <kauschluss@disroot.org>
+  - Yedaya Katsman <yedaya.ka@gmail.com>
 
 allOf:
   - $ref: panel-common.yaml#
 
 properties:
   compatible:
-    const: samsung,s6e8aa5x01-ams561ra01
+    enum:
+      - samsung,s6e8aa5x01-ams561ra01
+      - samsung,s6e8fc0-m1906f9
 
   reg:
     maxItems: 1

-- 
2.53.0

