Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB2581098792
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AA310EAC2;
	Fri, 20 Mar 2026 14:41:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DR3c32jw";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5877310EAC2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 14:41:50 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so14987735e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774017709; x=1774622509; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z9Ej4pASsqYp2gOGlmVa1Dopz4W2+LI/x1nMQtFrz0U=;
 b=DR3c32jw4mqnkb1gTvYOqfFU1XluiaFuE4p6d9vy+Ol5Ch4pj9ebGx/y/olqgtWdh3
 2WUa099qcWlkC6GqT72L0l6Etd1Bf7mbuErAriUWK04YHkYrKhovPxc4t3joMWKKZ/Uu
 1Da+TbNtuBH9AijIisVoYROjAZi5R9F8mQYw3wmKEo3fbnLcQlOhKlw1fxL5eVK3NMO8
 9prRR7WZNhKl5CQCUekAGTaTwJobGmgfSNmPJIYwopSudOYULY1fEVN+sJ0c8lSMKL6M
 lU12y/rTvhEhVJn1xoCemv6TzIxX3uXFFe6aJT65MYuQe9sJtbfhtykfxWfOeb3Ub7Da
 f4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774017709; x=1774622509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z9Ej4pASsqYp2gOGlmVa1Dopz4W2+LI/x1nMQtFrz0U=;
 b=L3YdpgexJhqdZnL+ptAFeN5qRfeej73wTDST3Cdht8AiR7iIthzxzYm1DEcVgu0wzM
 sGyLa60YmegIQuoE6UmPx7azsE287WkzxR6eebQcWFfnui/Jx/66vKkZ8md97k0K8txh
 EEbeBqM3O7pJ+ZcXki/qDS3CadEIQSaVWJDhA3dSRLLAFcO12Yo9bhzt+gqRB1Gi05Mj
 nNizglSnTy3R/Nah1xEp+FR1SCtR+l1UoVnf1LzHkNSVfg3dzM+0Pj1FwhdmR4PaE8tj
 OizaGteeNYV21CCMgT22DsBu/TZMYtTIpSAlbEMTYGBW7xepWED5vLuvhXTq6QEc8DDH
 GYWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrk/mg2NFcshQ+TTY1ifoBgV/icyxiURZbwzexed1RLtAbSOX3S6QbBMAITomq3kaoMfh+iWRx8Xo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyDj5S90uaBRQ7gxkM9MVsTox/aRIbUKUYdCfyx04YTxT+NgXTz
 Y2Qc05KDlMWhkMc6466pTlsIGKSXWhc52tysxg0PosiErsysNtO9oWPcVh0MTTjL
X-Gm-Gg: ATEYQzzJYd6aiLaPJ3VCNNIQMDaR8a0ABGGQzQ8zMALhEV7H9VH5WX5UBamXmAv0SEM
 EE/DSzabq5lRnteFK/N6FDEybjkRrbybWa6tELPotlfm3/nqZgeFnqqqfustDVu0fiFIq1fA0Tq
 h9voFnksxHY5Olw6dg8vz5d5yArgSeve6j7gjg7qU1AXYF9k7Lzd0Q4J84PCASf9aijHrv0Ubbp
 PpleUmfxnX5/HgVT5BR+3qUw7WtKh2wKYR9c9UNSz8D12ERfxpC5iPJNqJz5hVpWP2w+7Jk0KIb
 +11ajyfbH1LSUhFKc/ZGJCcteyptojhSvaiN0mmu5gn6AAfOCNokh+8rJ1ikIKLD33T+VeU2HHD
 ctY4zLokt+63bxrLqo+KSGkaMDzPDjvfQ17WP99re/qZXgwHF39Nq3yiSuy49mlWGgiBP2lZ9wI
 rh8YdWtK1VisxEDI+kbaCoStZh8yBSbSflSzPilQwG1sE0evh+ijhnKu4KdNC10c8=
X-Received: by 2002:a05:600c:4705:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-486fee0983dmr51086015e9.17.1774017708638; 
 Fri, 20 Mar 2026 07:41:48 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b1fe65sm130648835e9.5.2026.03.20.07.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:41:48 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Fri, 20 Mar 2026 16:41:38 +0200
Subject: [PATCH v7 1/3] dt-bindings: display: panel: Add Samsung
 S6E8FC0-M1906F9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260320-panel-patches-v7-1-3eaefc4b3878@gmail.com>
References: <20260320-panel-patches-v7-0-3eaefc4b3878@gmail.com>
In-Reply-To: <20260320-panel-patches-v7-0-3eaefc4b3878@gmail.com>
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
 Yedaya Katsman <yedaya.ka@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774017703; l=1398;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=Ns/WNy0Z7rKIF5KEEaOQ5y4gyFT2BopG513lDTCUOlE=;
 b=XpIs2OcjqEG0kwK3wW8POn+gnlHDANJIQ4sIneTR12hoxNhYKjaoyFsaAgphcR8f2uJpzGufb
 V8hHXGwDPfbDp9PdBfgmYN/lwavA5WLin9fiVAgLgfQuAN98DvbFCSx
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

