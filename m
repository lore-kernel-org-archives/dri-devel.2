Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0318CCA5FD4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599E810E604;
	Fri,  2 Oct 2026 14:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="oxS9WC2X";
	dkim-atps=neutral
Received: from mail-ed2-f31.google.com (mail-ed2-f31.google.com
 [74.125.228.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A78810E204
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:49:56 +0000 (UTC)
Received: by mail-ed2-f31.google.com with SMTP id
 4fb4d7f45d1cf-6af85996a92so1265293a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790952594; x=1791557394; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q9dINPrQCPR0iqwn2K3Vkhxxuj3wUNi7Zp3ZQDcumLQ=;
 b=oxS9WC2XGg5XxZbxf2drieU/roGQBrDut0xGeX9pcf9aNP9uCtS2QrTkjofhc4vajo
 m6KqLH7m7s+ucbAzte75bUevHCz5NCNH0cxTj/UWKtHjp8inhXoEXIbeAyS8dyVOZl8/
 1nPYeZAhglFNAjLOnnxYX/V6H9Vo6dpCN35mV75kzpmvlatM5P7UBjIhO8JLcFJ43shY
 73zG4wvcpGSQMwQy1Xa572IqpZMsb8Z2DrmzmIaCuEwzQuU70D3b70/A9X9GXtcYZyPM
 SfInYPvkf4pdHbRW2EhIFx6ne0r250AXb10YI55xbt3YoIOXMwE5y3QihMrLJJ06GOj7
 RFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790952594; x=1791557394;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q9dINPrQCPR0iqwn2K3Vkhxxuj3wUNi7Zp3ZQDcumLQ=;
 b=wgZHVS8oSxY74fR634PVNHivTn+HFpptGAshM4tBN9Fym5iNXZWL4eFk5qZ+FlMqYu
 G64S2mdAOn26lFxMtGBXCH8bX5ZMCuRpPbKuU0GNWj8za6s8yhpBt1jk2cIpCQk+jRMO
 /qG5Px/y8gmsHbH9wDcjM5LjSjxO7gRjEbmJDZL0Qh5oAVceEQ2vCxpln8wXUnI7F84h
 ZkDfa3/yaehr/A5UZOiSXIAYNe3+Yj+BnIRhTw19S8lfZf6k/TEHDgxBqaTuYLOXtIy9
 eq0D1Rui90izwTLiIwmJ4Kt6RIW5/Mg7YvW9YObO9IMWSLpRgVQFCvw4/ySh6Zal5wz9
 g5gw==
X-Forwarded-Encrypted: i=1;
 AKwUvByd8BUYUt+ALbfjVe2Yologo2RYKroDIxCrYhb0JcUZxZWuayetM6zGThoFuUUFqzHTzxQmt8ZbWcw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtVll4eneB9eXSdajX8HeSkllglh9H6I0/f9LLHZd0YZWl/soD
 FvVliLPIhoe3bryM54ocnyCY159zIFJvtjC87YaEcJXjXeFUryYlZHXwuDfYy0OLQAY=
X-Gm-Gg: AYBFou0DaCcjrG76HgFT61UJC0EOZjsBI3OvTy+qinn4zrHgoK3tJsf16tTU5Bx8xgU
 8sX9jQXo6dQxo+XJLNiITcvKJRXfslfWilsOPo+sV2WEEErJu/UiGYVsh5bIsHtaKQKLUB4cNB2
 HiOzQWW8Z0TO9xm/r/YuRuMotMhESL+q3Nno4KLri2nULymAYCFk95PTYF8PBZRPnufiV6ib6tS
 os/25TJKs/j7csUPjZrlCWZUJEvi4uJr0sGCaW3CuzRBXS1Ey1a2h6j3HQuZ+7vPZz/l7xwS3BY
 4lXpDNlk00FuIU1TZnLWsEuKZycCmbmKCMPLS/rzEab/QV34F8s+hHyVxAL3yj/nXMsbMp5m+cA
 FbrDndqgveK2yucPrt/E3hhZhXzT6+9yupRFc8td4cgLXdyBhOiXmI2f9tElkn3afq2bbg1TrGT
 dtPY1sEM+Oz4OhSaJbYNu1LowLdakotpjnCRiKA++98I8tYMH7Jcr70Ua3OS+rlcq2Xd06EErwo
 VCWEjetc5PBv7IwF6C3F+LkdwHWpkJlWJF16a+9jb8Y/q+LYmqR
X-Received: by 2002:a17:906:ba87:b0:c2a:4847:231b with SMTP id
 a640c23a62f3a-c2e4ae235a3mr249670166b.24.1790952594706; 
 Fri, 02 Oct 2026 07:49:54 -0700 (PDT)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e4cfa656bsm94539066b.74.2026.10.02.07.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:49:54 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 02 Oct 2026 16:49:51 +0200
Subject: [PATCH 2/2] dt-bindings: display: panel: himax,hx83112b: Tighten
 compatible matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-hx83112-compatible-contains-v1-2-d558635ab7fc@fairphone.com>
References: <20261002-hx83112-compatible-contains-v1-0-d558635ab7fc@fairphone.com>
In-Reply-To: <20261002-hx83112-compatible-contains-v1-0-d558635ab7fc@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790952592; l=816;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=UFIj2wMvo5XUOBicWCPYVsxIWkd4wo9mTw61yb2XBXA=;
 b=PdkVOKEXFAm0sgIKoBhGPzu1gFBftu0qHcNL1NRDXWSJcJrDJjbnmsITJ+q/d43jScGvZmi84
 7Ed2SsdoD+nCXXCG78S/8INaau1afyaoLL/nPkm+xz2NKKuEYhhR0vd
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

The compatible was defined too wide, we just want "djn,98-03057-6598b-i"
and nothing else.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
index e58bb3d45331..34e97003d293 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
@@ -18,8 +18,7 @@ allOf:
 
 properties:
   compatible:
-    contains:
-      const: djn,98-03057-6598b-i
+    const: djn,98-03057-6598b-i
 
   reg:
     maxItems: 1

-- 
2.56.0

