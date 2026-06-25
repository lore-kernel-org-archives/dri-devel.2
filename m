Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1FC9CDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F037110F485;
	Fri, 26 Jun 2026 07:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jKXn70O+";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0EFF10F1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:45:00 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2c80810247dso499065ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782380700; x=1782985500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eWFRHwCJWqyDwSA9g6vZ6qYM6bFdwonDXcZifiRo3bA=;
 b=jKXn70O+Z9yRP3O44CPh93VQbbY7OID1cws7Di+S18ORiFqhgzULGA5NkWbUlGviih
 a25FCzVPPO43Oqo0GAFW6+x1Sc3uWf9ieTeTQlPrCCFl/59kGc3gG4/df5S3NppewofF
 K5C2OAKwmPbMQQPgsvCIvobXUrnqVnuOPGIbJjOvyS5W0qpdBStds1J4uAfyE7rKVWAq
 jMzzWqVPX96gFbKVCVhRrGESNDRvI0ALM2hdXfj8mQLX1YK03pk5uIwI86Dxh9pQIlOv
 GYuc3JePDKbnd11O7JFTtXvK98DX3EEqqSk7c5B9wo715FC0C35x+F11bi8CehfN4Mq7
 hDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380700; x=1782985500;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eWFRHwCJWqyDwSA9g6vZ6qYM6bFdwonDXcZifiRo3bA=;
 b=HzC/dsqgE6CnNxjGDl6mzxzGxezM3++yjd2XBzL9iJfsJAFoFWQI7VuD16y6NFjsxk
 ZId0M9YVomoRStfY1wr4SAVM1S0UvNcyLqWT4bTgOc3BCGDRvmqPebB25Du7NN260WHL
 FJgfpUPqerP72C/J9BtkeBxKwJ4sjpGGfcVLmE47AUFVn7GNHtjZINfibn9pZ/SC69Tf
 wg6dXAgRz0dCy6HkDMkyhQ8lTwMQog5bYVXoq8RmMTYRg5jbcfy8ByOt4o0+58q8vleW
 ISDx3BLYVMelNQwHD8fNsyf1naFqZL/1DE0z7kNuni3xL6Li6VOZ6iFUOfSL/ppEzub3
 ZcTg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXc5rpwCbifZ+4jTJWxL5NZ4Ykc/sAuBranWkPqnO9BjDbqagNhzKWEhLdERsPnkS3LVOtzwh2vmw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywq4waN6HOMwqiE4W8lY8v4qlcVeHVkYbeoRfDzpXE/5+z8k4iG
 K4G28x62nQxTMgQO5BkbP9+W+fqgUL0iONnthEuj8xCvIjvEWWN09oVG
X-Gm-Gg: AfdE7ckrIHi5AQ6O1gRqp+eyW3WxpBJQMcSD+71Wmi4aZoEIdwvIIUj4qxfw+PNXp+o
 A9/WwaeD/Ox+HCDRZBhsdrF2GS4VfCber70Vc/ZCk9xmtPOTeP/3/vWsATTZ7DUbsbV+nlOoz5Q
 ytPqGI8XXY6dd1EhBZnY+ZWDCruP7xqjffcOwt1umkF0xcKWqvnF4mTvYc8YhOKPr4bEstI9S3V
 3p0tXE18weVe8p4KapvkVOQ8LbwHwVerPghLHXZ1TFmOHyJaIL1UOztkvU0BHgnAJw24ae788vR
 q3UWyzDxz3AUQne5Ge8Dzno3DKlqU1fnBVi3bX+hhnL/G78BhMM7rRFpt1Ew/6LKWnP9soi+F8O
 nikH2FL1zyITluzmZlPeiOSu4ONaKfT4CWA5BGHT+I8+RZzfB4n+XCyOVw3IlN/NF50ObstYL9E
 d7n89ywirU35GH3BQI7PyF8ne/O6EBusG3D2upfsuN3WRPUUcoQqr2sdtCx1zVm6L4bx7VM5shk
 Rq4/no4CcIw
X-Received: by 2002:a17:903:19e7:b0:2bf:23c3:34ba with SMTP id
 d9443c01a7336-2c7fc7948aemr19245855ad.28.1782380700312; 
 Thu, 25 Jun 2026 02:45:00 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8c26sm16614995ad.1.2026.06.25.02.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:44:59 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 1/7] dt-bindings: display: verisilicon,
 dc: generalize for single-output variants
Date: Thu, 25 Jun 2026 17:44:43 +0800
Message-ID: <20260625094449.708386-2-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625094449.708386-1-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

The verisilicon,dc binding was originally written for the T-Head TH1520
SoC carrying a DC8200, and hard-codes five clocks, three resets and two
output ports.

Add the Nuvoton MA35D1 DCUltraLite (nuvoton,ma35d1-dcu) to the binding.
The DCUltraLite uses only two clocks (core, pix0) and one reset (core),
with a single output port.

Use allOf/if blocks to express per-variant constraints rather than
hard-coding the DC8200 topology at the top level.  Each compatible's
block constrains the clock and reset item counts; the nuvoton block
additionally overrides clock-names to the two names it actually uses.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 .../bindings/display/verisilicon,dc.yaml      | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
index 9dc35ab973f2..1e751f3c7ce8 100644
--- a/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
+++ b/Documentation/devicetree/bindings/display/verisilicon,dc.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - thead,th1520-dc8200
+          - nuvoton,ma35d1-dcu
       - const: verisilicon,dc # DC IPs have discoverable ID/revision registers
 
   reg:
@@ -77,6 +78,62 @@ required:
   - clock-names
   - ports
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: thead,th1520-dc8200
+    then:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+
+        clock-names:
+          minItems: 5
+          maxItems: 5
+
+        resets:
+          minItems: 3
+          maxItems: 3
+
+        reset-names:
+          minItems: 3
+          maxItems: 3
+
+      required:
+        - resets
+        - reset-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: nuvoton,ma35d1-dcu
+    then:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 2
+
+        clock-names:
+          items:
+            - const: core
+            - const: pix0
+
+        resets:
+          minItems: 1
+          maxItems: 1
+
+        reset-names:
+          items:
+            - const: core
+
+      required:
+        - resets
+        - reset-names
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

