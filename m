Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C91077612
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8E0E10E7A4;
	Wed, 18 Mar 2026 19:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jTlsRKVR";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBBDE10E040
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:05:18 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso3855e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773849917; x=1774454717; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z9Ej4pASsqYp2gOGlmVa1Dopz4W2+LI/x1nMQtFrz0U=;
 b=jTlsRKVRWYuqVaxFkJmNw4bd+tl4GQItvmWcDySRIbi2sUzdfzgk0UMe7CYknEuRgQ
 vSdSIA4RIk9bsiHnmi6uqLZNubU/cn7il6Qtae76PCLj2vOlOuyne8wCvTLGJB15KDft
 XqYQPWxQHDSndPsCFLjjKy6gJoOfqDd4D4qN+CAzI11UzTrNdFvlXDrnlcb/AALCMLmf
 r734A5GbyTY9SOPaku+tKLJHfTvbtp8tJDm7y2JIKrw5nrqV/3OLnuac11tij1MvRqPb
 AHzubtM4E4cxMZ2ntiBZc4GAcRaejEELpeUw7rpwwk3gaaa5Zghih7pL1zOi46WHzDnc
 2BNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773849917; x=1774454717;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z9Ej4pASsqYp2gOGlmVa1Dopz4W2+LI/x1nMQtFrz0U=;
 b=JhxfE+zpJx3f2E4st/MnztrOh82tiwyCoebAmw1ppEvLEuJ69EOsE5aLkIUIdOY6NN
 TsvyJ9ty7kQQzl1j9iDfSp2Nznq6taHEShD3gzN/UA+hhz1BhSvw5nS0XO3nJzTqDQrJ
 rMCYMzmGsKmOkaHCVNUGHN8AAZORzKd7aIrOsSsmip3IFCNAReNuuKkpvBNIjgbUmcgJ
 1nLRHGDp8B4+EWfaPRXBQA9NMJK5nHGgtFA3EA0J8t5TOtuTuHl2qjQRY/WGxlgElltD
 7gL+Fq7Nr8IL/OljaYp4lzQrKdnkMRk51HMKzdjDYAkMz0M6plsPuQ1vIn0kxxJ0nMIe
 8ErA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNpZFvImjiAjpHCAIFwZWKe2ar0ogM5Y3VOB1R5yCrt02KxD8l53lGskPIt/XEJZljraIZtNwcme4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3LoecJkQ+3cxXE0MEOQe5QJu+5kNtjf2DCmJtnGwIOzl4a7ht
 URj9hj6xEdXK+PWsuPk0cHOiUvot8nJz2Jecr9jpyBfN38ZGu6TcsHFX
X-Gm-Gg: ATEYQzx0+uwao/JjKjuJ4RbmN3r94TzrncXJ2PzHOO1R7oG3x843s3Ky/FKIhb5j/se
 dtbzFT2p6lecyzF1x8k2ENOOobWQNP9/AGNVOwFDBq9DJ93kPygZS0LohaisSDNypeRLCuGy0AB
 QlNDkMn7B3RYiSHlnDJWunn41CZ+xJgSKf4MsvborLhH4XJUvbeC+18mv8tl6QxLRbMDJjTFpEZ
 zgZDMGuYOFgvhAdftm8D2HoDbto32WLbD8OZnHE8ePe5VlIN4C+m5hCEJuiSJ//3GIF21uD/5/u
 x8STQPhPpTB6kTZ3nplcq5v/7Nng5BWw9YDFCPgwJ2YzPhdpAGkiMpmavU7RCPIVzasQ/Qt5ZGl
 MN51f1QEgThBqqmqTIRUZDTvlH9EFjZD6HqAs1y+8nd/UlI7RHMQT5VQqVDDOugSdFHZyrJDWX2
 dHs8PGsDwptIAwakuJMeMfmroRfbANpc2AWAZl1Vkwgqzx1gp3xr/u1frSjm02nr6hhwUWUvCzO
 w==
X-Received: by 2002:a05:600c:83ca:b0:485:3dfc:57a with SMTP id
 5b1f17b1804b1-486f446dee9mr60800635e9.32.1773849917122; 
 Wed, 18 Mar 2026 09:05:17 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8baec5csm2282225e9.15.2026.03.18.09.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:05:16 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Wed, 18 Mar 2026 18:04:48 +0200
Subject: [PATCH v6 1/3] dt-bindings: display: panel: Add Samsung
 S6E8FC0-M1906F9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-panel-patches-v6-1-7a30c2f85e0b@gmail.com>
References: <20260318-panel-patches-v6-0-7a30c2f85e0b@gmail.com>
In-Reply-To: <20260318-panel-patches-v6-0-7a30c2f85e0b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773849909; l=1398;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=Ns/WNy0Z7rKIF5KEEaOQ5y4gyFT2BopG513lDTCUOlE=;
 b=TQHggHRPaa6/4FzPIkqTMIOpA7S4t9AmV+QlZloldI26s/thYR/QwHca9pFK7MT4G8Ux66P92
 CYVUoKwIZZBCrT54aPY9NRIZiPlIsy+1I6bs2i20fTkzDhL1puXAvRz
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

