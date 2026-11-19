Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF5606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJEDimph
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64A6A10F089;
	Thu, 19 Nov 2026 17:55:15 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADB6810F07C
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:54:47 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb72b44a97so19920555e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795110886; x=1795715686; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HyRQC7LCLt2aLLScf7p5/WBb90iUzNQpHgR+zoYi5DQ=;
 b=RJEDimphZJ/UUajqfBanZrDtOWSRgio+3I0q/jL4ulw9PKk8QkXAQ2PankWRDEcREv
 fPio9ER/TXqoT/xn+C/BBlDk7KLYu2tugAxg7qzVrdeNOZzxS7VQx3CWLBU42l9TPUL2
 JZeYbVUDz3U7eOtkTCRkqIy3CXKAaB6tQtjMRIJMOWXBE2Yy8i5AT7SC0YXl6BwDKnBt
 uSYiOt+/Xa6kQRRu/AkEIbjUoR/jMPnI0JZAre5KY5dmrRaSSp67R7LnMuCDD+a2tFQF
 y/mTrEelP3CjylgsXPo1gWnXckmAY81pIbmD9sbu3QGGXzyj318DDC5GbcwDTi5Pvys2
 r6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795110886; x=1795715686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HyRQC7LCLt2aLLScf7p5/WBb90iUzNQpHgR+zoYi5DQ=;
 b=MFT/HhS36Lu0FVLk/xWOa7oQ2Ue/1Jc9EmeLPehVwo3x6EophLQ8/4cZ2OpR+wkf0/
 RyjIwUTkdzy682v/bTcf6uFq++82/a6MDEWOjaGdR43346hA/mNNglKYtv24I+y0y0VQ
 EipDuNxzxsekHfSZfBjfxU/1y7lTPoFlwaFfQcB15S97QOCmmnLnDLzkBpaV7l8aXyZs
 Iaw7pfL1ZIduVWuspoYli/TKN/KXGRsVO37609MPVCk/gvKfPJSfQ+K78i7xSRFtapdK
 Ep+VVOOB4UrQ4wfmg3fSYaIomS3XhEfm+wMU//BdOxQwafRkALX40PChDogOGcR0fPmY
 cqfw==
X-Forwarded-Encrypted: i=1;
 AL+hErEEFid2oL2XuEOK6e2DItEFByueFs0QmBrtPQsSyESq0z/a8GhkQOwcytHx0CB/MLqz24AV/omp8x4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+3JukL66AcIlazq22sfhq9Er83dwTsEPuixjBr4+X7jnDwRfVD
 MuRbpkxhR9QnHqZ1yjhUsfkEIM+pDfjheRWw2MfIC0ONH82uVpm1MlcA
X-Gm-Gg: AYBFou06OdJoWDhSH7E0eaQvqdz35Tzs+FzufYcq81vsV0ev70CnlVkNMos3OKVfsui
 +LGpAf2htlRkNsJIGtLKNhG87L7NFWZ4pN3rwCMsWfL6LE36f4D7hUTg5CgMX2+GBheQWmZsF3d
 gYECrKwkkO1u+DC7gL6NNC9AYYUnLbU/O4dpokeBgkD25h4AVOn6Md+Z2wcCw9t1OFosgG4rnVq
 ePq0H5ICDfjUZqhfeJF/LvneD1P9uj1qLt6u+uMvbb2HkWI4C+oi0LllDvbTZTTH4W0AyaNu73O
 /rbRPzQJj0mQzdIumjONgDJDHcv1GQtnuJ4N4PSny4yEUSKw6NfkMhX3yuLVR07T/ge7HayMlen
 Yy1bQaGY9GgiKxdvdf8y3p/JT2iSYD0oTrZecx2ovwrpTAqDBiML1DhWqkhMtHdHRtwjlZSGqM6
 U50QTCXOFjAM6IKGLd9CERAJDyXFyn1lqbnmn0g5HPlx4psFeYOYj9IMvOgCwNmKvvKxSmT2Lqs
 1i45MzUh3fpH2wbcgVcrlL+G5egnerEFw0EMQIqQtIAMylxWfNzJvmqw9rjj8zmJ5jM+iXyrhXT
 9ldLSmuTk97T78uvU35vT0Tf36a0HtvoVEuJmpUSXC7UFC8GTcfNptAYH7gsSvij57zC8RZ4axt
 gzqyl0QFGWItAIQEomndAEyXfikNW3wAh+yJwG3thv/9yHmYsz0rRmE97TzVQ2eITtE4xdXuaIJ
 /aBZAAjQG9T0kC5gaXuNjJWAuqw7k1MkfmA4zXMn4Ya7LOYQSzjYdRi+rJQrNjkzyWtQDCHBQe9
 xMwFZpZjVBt9qWHIl3XR8ci9d466gVaZq0xfbAemEA6MT0c69Dno+or
X-Received: by 2002:a05:600c:a55:b0:49f:ce78:356d with SMTP id
 5b1f17b1804b1-4bb88827db0mr6257205e9.30.1795110886049; 
 Thu, 19 Nov 2026 09:54:46 -0800 (PST)
Received: from jernej-laptop (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e50512sm29390035e9.3.2026.11.19.09.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:54:44 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 2/5] dt-bindings: display: allwinner: Add DE33 planes
Date: Thu, 19 Nov 2026 18:54:34 +0100
Message-ID: <20261119175437.2520400-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
References: <20261119175437.2520400-1-jernej.skrabec@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allwinner Display Engine 3.3 contains planes, which are shared resources
between all mixers present in SoC. They can be assigned to specific
mixer by using registers which reside in display clocks MMIO.

Add a binding for them.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../allwinner,sun50i-h616-de33-planes.yaml    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml b/Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml
new file mode 100644
index 000000000000..0a07cb8a5f79
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/allwinner,sun50i-h616-de33-planes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner H616 Display Engine 3.3 planes
+
+maintainers:
+  - Jernej Skrabec <jernej.skrabec@gmail.com>
+
+description:
+  Display Engine 3.3 planes are independent of mixers, contrary to
+  previous generations of Display Engine. Planes can be assigned to
+  mixers independently and even dynamically during runtime.
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun50i-h616-de33-planes
+
+  reg:
+    maxItems: 1
+
+  allwinner,plane-mapping:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle of the device responsible for assigning (mapping) planes
+      between mixers.
+
+required:
+  - compatible
+  - reg
+  - allwinner,plane-mapping
+
+additionalProperties: false
+
+examples:
+  - |
+    planes: planes@100000 {
+        compatible = "allwinner,sun50i-h616-de33-planes";
+        reg = <0x100000 0x180000>;
+        allwinner,plane-mapping = <&display_clocks>;
+    };
+
+...
-- 
2.43.0

