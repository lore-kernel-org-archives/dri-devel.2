Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 662E8CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 13:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C537E10F576;
	Fri, 22 May 2026 13:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hxbZrepC";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B07210F576
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 13:20:42 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4903974854dso16843435e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 06:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779456040; x=1780060840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MxhTRa0jJQh6ofFG9sXlZ7aauhKliKnMeyOlOjmQWhU=;
 b=hxbZrepCT3iL2r90X+KOLV0WpJBKU4IpqbeKnrMlPYwj0+xXuxcNcJvu7dlX32qo3g
 ynphL0rJzkYwx+FG73bLbRlf8U7kbsgxDxAb4x7Roc/iaityaWlivbTby+0u4HEcbbhs
 L/yRCA8v6kpya/i9LBirX8INZozrCgoFNfB0+d0g9np3n8UqLtapGu9EAKiNhOdi+Ly+
 8Ynvv++0hcaM1ATj71mVWtg4EdaWqImdDi9MhfrqDrmzUfH4p3LYT7YlMcB5IzhT+1ey
 aDAspgm/AG27kxZoCQH8NtsxXr8EGqqvvugocUe0vTf3XavL2CzmfBv69uawt5ikgyJd
 6PAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779456040; x=1780060840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MxhTRa0jJQh6ofFG9sXlZ7aauhKliKnMeyOlOjmQWhU=;
 b=f1rSP00PsRncNa8IMUguppVRHZnUtF22EZWjjhX44AeBsCxfBwPZz5TuRZM4nWzOXI
 DbQxWY33t9vWtKZzFIrowfcpImQEjmyA+I74EWktitOUJLsjaZ13sefw67hDoj8oov1t
 EQp1vn9IwvJANE0B+i/RhME3yyz99jy1WuRWP9TF4rQhtGIJZG26e5I4x/kTXlZiEjGZ
 t5DlztNxp0JTRQylpxGRNU3zpQiLOoPtZBZ2/18JArp0Zf57tNrLDil+2PIdDgeM1NvG
 2QaVF/hZqnb5f12n/X7sUt1F56fjhr2bc6pY0gVMNcnQhP1lM/jmXx/V50QIXoHClUqB
 mB0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8iZPOYedlt0M3Yb/EdKXy85J8xdrnsQ00AJCKCeRMpwNfb0eCHH0wSKNufsE4Qpjn1b07y2PL+3uE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0dK1lbXkILlIL1aTCpEzKcOd96Z9By1bZV9ZMvOEJs9euohJd
 EZevsXrS1i+Qvo6EKxVtl0w1DJxk9nYnACjFS8ulKkl6fkkG6Za06KfR
X-Gm-Gg: Acq92OGmZoxVKW7wRjwJNVsZCUnAVIjTpYlCTfKFfI9QXplzNp/GZP2CMYJ3GIZCIkv
 x6mf5rpQOPSOOhIWVsw6CfZE8RPT+8iXQhq23GJXAJLVjhyA7qTpVTpo/jaluBPBStadnRIwfAx
 DdUAXE+33zQp+6m9+Q7n/Ahe4pWZTnwhzQzAq1kXb6o7FroOVBnr3BxQ38pc+aVMN8FxTZe33VV
 oRnc19VbKeeOAuHS4PeK/3Z5U9ufeq76vyRXZ2yEU2SAEJjS56V9LFBeUenuLf6m2luS7ZWZBVV
 L3q38OQnwtH05Mh4z5JHbsr71qUXokexYP3pS4rrSEi5FE5r63JhtFIuKqlATdy7I2VDQnUo3Wq
 /OUAzicMZvxDtnvnMQOUOP5fZX6CmgbJkJ+vGM9z3B3AVoyCdiM1PG83YnxFr1iOrdO6XbANHN+
 OPvIFay7eKJ8L3GnTNiwQDU3MJN5pOjnLGBzj56ew0mQ==
X-Received: by 2002:a05:600c:a402:b0:486:fd5c:2b35 with SMTP id
 5b1f17b1804b1-490426adf66mr39371215e9.13.1779456040467; 
 Fri, 22 May 2026 06:20:40 -0700 (PDT)
Received: from vitor-nb (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0cd5sm52220755e9.10.2026.05.22.06.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 06:20:39 -0700 (PDT)
From: Vitor Soares <ivitro@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>
Cc: Vitor Soares <vitor.soares@toradex.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 03/11] dt-bindings: vendor-prefixes: Add Riverdi
Date: Fri, 22 May 2026 14:20:16 +0100
Message-ID: <20260522132014.226721-16-ivitro@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522132014.226721-13-ivitro@gmail.com>
References: <20260522132014.226721-13-ivitro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Vitor Soares <vitor.soares@toradex.com>

Add vendor prefix for Riverdi Sp. z o.o, a design and manufacturer
of TFT display solutions.

Link: https://riverdi.com
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..bac056d486e7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1403,6 +1403,8 @@ patternProperties:
     description: Embest RIoT
   "^riscv,.*":
     description: RISC-V Foundation
+  "^riverdi,.*":
+    description: Riverdi Sp. z o.o
   "^rockchip,.*":
     description: Rockchip Electronics Co., Ltd.
   "^rocktech,.*":
-- 
2.54.0

