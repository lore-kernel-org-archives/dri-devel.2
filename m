Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5572CCA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:49:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52A9110E204;
	Fri,  2 Oct 2026 14:49:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="RgNXgWMI";
	dkim-atps=neutral
Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com
 [74.125.228.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A991D10E204
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 14:49:55 +0000 (UTC)
Received: by mail-ej2-f41.google.com with SMTP id
 a640c23a62f3a-c2e32f913c3so19759266b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1790952594; x=1791557394; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=azHVxl5Zr31CbdI5TNnzZtKhiO2dgRAGT9lgdHF1uxw=;
 b=RgNXgWMI0f3OoNK7RpCt2NlYOXNIjf82ZDJk/JT4TjkZIubrUGKM3iCfWcLg4kp76G
 +mvA9tRxAYkXnLTW0LnGKVScfCzHkqiJ8kYSOgMreFcMQHVGgOgXRXorgSI+wXLRhUke
 3V6Nf0f2O57Tg47qFRP5RFw1jai3iGMn43yRTjTeML3J7ggCr+6uOYzxNR8QbDuz5lEh
 wFL/Pek2OuyO0m+B0zKX3FVPnb74PdkHCFrqyvpZwDBTsNQsjrNsODjU6NigK8H3Zt6Y
 zOl5srvQ9QUipiJJ+MpptOTNL+uSUc+b8efS0YVfapT9oxHejdSPwdncS2TFfV1muzmS
 qp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790952594; x=1791557394;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=azHVxl5Zr31CbdI5TNnzZtKhiO2dgRAGT9lgdHF1uxw=;
 b=E8wrLZ85VbSw0hQCCel2ZVgFiszqBpT+WFHzUnH3DeaQs1SGIdU4t/oiBmM4BCeaZj
 UbVAWbL9pWDsG5nlLFKnU/W9L9oPdtjXINSssSZlzU0+lpEgp2ERkELy2/vz0KUc2ozK
 kpn+g6+JIYlqTVwVgzRT/xeYagLSdkpQ10pid/qRin71avkxF2wS9m0YonbSqAls1y6C
 xvngzSlhza+8RzV5vwgKPZ/dFkqus/nNhwB9cVtS71Tmsl8Pw9OB4qgtlZrrBSBcSWHa
 QoDEm9fBTKzzcrRsDCkqOaHEbPTUKD8mqVNANVwqbv3FTCR4X8FM8TKHsqWOTIdHF4r5
 rMiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwZYm0aLrgAnK7aWpsQnkHBQAqI3BPu+LX6XRGGNNGcfO2MQ5gEyG4CdHYUIoRk61C8i/bMOObMKSA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mmUE9YsDRIBKd5VJYjN/Mn6liKq8aeX4T++EZZLUR5vywWOB4+
 wd+WuO4tNha88e4pHMZRU/hqRQ8hIXCvNXKL+NlA6C8Zc54PvKPCBqK3n34gvMSAkqk=
X-Gm-Gg: AYBFou32Ih9ZjKErxK0EDJpBVOUkJ6RcKt9au0AYdcNJLh+38Oe993HGiRujOmsn2z2
 fdCnR1t/WWWbqRgDRBMhZFU+9kHkhlIkTlhOOqYiQwJ/BFOZBnsmCfllehQafntMnSvYtoViX3E
 TcGsg032jY3ZPMkuxcommT6t21b56yO8eKNARQLtH+xEc2W2gsgcQylcT7zZBvZR+7FEyj8Booh
 m+gB5XyHk81X5vJstq2IKleeZd1B1WIdAzfX7h6SktOJufGV8qP9XE+0eAxMsiEYXk1uAComiVk
 nywWpvD36ZGnH7LWz1jIr3+DPsK7hinwo5YZMpB1dudit2W1Z3CAmcf0+0tn3oCqeKYJ26ytc8O
 Na8dHAaYSk3PYiFBy7HEwoTtHkHNkB3k37j6lZ4zKNVXwpu1FYEdnGcir+Z58R4KRa7xCxoWzTz
 Ai5zz+z9f82yKfiZpy0c/gZqMWZ662YQwIUMfdbEdc0zqo4GE1xeYvunCdrFsDWc5PXpmDojQ4D
 wKMXLCKVpsES2Y1uky2cAb1FkMunhqECkJ4CwTQ3oyhrwR2UcVQ
X-Received: by 2002:a17:907:9403:b0:c2a:f8e2:4233 with SMTP id
 a640c23a62f3a-c2e4af31f56mr209928066b.19.1790952593938; 
 Fri, 02 Oct 2026 07:49:53 -0700 (PDT)
Received: from [172.16.240.104] (144-178-202-142.static.ef-service.nl.
 [144.178.202.142]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2e4cfa656bsm94539066b.74.2026.10.02.07.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 07:49:53 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 02 Oct 2026 16:49:50 +0200
Subject: [PATCH 1/2] dt-bindings: display: panel: himax,hx83112a: Tighten
 compatible matching
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-hx83112-compatible-contains-v1-1-d558635ab7fc@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790952592; l=810;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=KsRR3Q6/pxPTL+LOpQhlv999N3C0D2jsPRy7RKoQGk4=;
 b=d1WlKoOFC109aIkEZsjUlraQFJKKd8F3U5nRRs1tjiGq40q6Pq3YfqVmFt5pLUIkq+oIHMRia
 4hFq1w3iyYqAdDwXY5xfl9gr0XD50R9ZuRDHegvB59n4o2aUr+lAUDW
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

The compatible was defined too wide, we just want "djn,9a-3r063-1102b"
and nothing else.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
index 2c60d0cd704e..3dd9b25ff13f 100644
--- a/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112a.yaml
@@ -18,8 +18,7 @@ allOf:
 
 properties:
   compatible:
-    contains:
-      const: djn,9a-3r063-1102b
+    const: djn,9a-3r063-1102b
 
   reg:
     maxItems: 1

-- 
2.56.0

