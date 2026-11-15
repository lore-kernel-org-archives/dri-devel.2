Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4B606A323
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RiaZxr/a
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7439210E251;
	Sun, 15 Nov 2026 06:11:56 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34E6E10E079
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:11:33 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so27711455e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 22:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794723091; x=1795327891; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=togVOXp+Ydg/br8KT/x6g+AKENI3qvKeU0FFIYM4R/o=;
 b=RiaZxr/agST8g1XPlJvi2VPqAaEf38I/DiVBj4f1CUV7tiO1N21pFXPEJmp2jyw0Yp
 CetklSvGTD1HnFGyvOOWWbnxbvAqPxcWeiiq5Te2CtveO+lov3wtfE51vYNK7lbqCTSy
 YUBe72S7Geof+Tddsw538QjbdN2YoclECu8Z0qmav272IMpb5BSR5RwEUcsIT+rzUrcL
 7JfZxWCN34j3QtOlWr9ON8ROx8tTkBNafJzt+QWY920skZav/RrhtxwpKPzrzBmBoGDk
 05fwt+Eof+Jxbz3SghSan0A8R+KMk5IfeizVWe6qnbGdEN+lwtIwFhvmNuPEgxgqLGqc
 H48g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723091; x=1795327891;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=togVOXp+Ydg/br8KT/x6g+AKENI3qvKeU0FFIYM4R/o=;
 b=Ik4wZ6tTJZJbtT/vCYesBnU39cs/KnLEUGc8NqBU2+hGpEZmFQl1B6h+6PP7lN3gwk
 4vKRgDkIE0zBLP/gbqV4bdlSx+CbrBk7Ea7dZ8GKU48WAPe5vganFpRpCz11xg1tp2dA
 Fp6EZNl6uMdJhIt2iKIHNfjry9JUoDIYLmW1cBD/EfUWOzLQVtzBtcID5UwZWzHX/sfi
 zb/I/F7G68WtTAgxrtvkj+r5xvqHOSjLhz4FInvNzyz9Nq/BE4xpA+c5fd+FZyynzT7V
 y5Ucp4TsOTcTr3S2phuQKdg2zglSa/09hY/7N3mYchQO8FkA6gjmFouv0Oa2IDWAAkFe
 Yo0g==
X-Forwarded-Encrypted: i=1;
 AL+hErGSsMh/jSpaXsQ6of0fgcnwmBYyAlsLh2jxZLV8tOiZSb1lRDwy/b5E7HHbtzoN3JWeqU0GxZFaSdk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+xEL8nV/zFikBkH9G0EwMswwMJRVIewLSseBI4lcP+vsDOUYiS
 TnyTOseLrNuKBKp5BOxhy+P3lhxTIdcIZTevi9mTqiUYcYbq9wCoNly0
X-Gm-Gg: AYBFou0BfRVz11kk/sZLMUNnUURdvqyZPNz2e14exaMl6Y+A3vhRMi7IgkuVRD96/xA
 +xOsiXObC+SsOSkPG4vDKVBSYsiwnl1W7Zy1SIX5SD18g/+R6Vx/Z8F0HnPI93qHaHFs0tYq4Dp
 e9jU6/bFuPE5ExTYI83lAr7O8AT5dwDogy53XAwyMO/VONbpXi4Eus+Vz+b8EauWe59CDuhi/bA
 nc5P9w377WwahC703wbNRhIdju8yf6okljIcU+R7VqjTWN8tCg3dPkZbmX3FZpt8aZQmPKEII9p
 3KdpF55FPoEe55gP0PPM9CKs+LwqsSojx2vnsk3NNltn4M2rqCT/FDFwBME7QyWdP2WVYkp14dO
 92V1P+6smN8TPELBVydmrGnao/C2QvMx2VXEm1y9nEgc9/cn4XSdGBqZsVbaQKWzdykmfKDZR+S
 2i4zMRaM7ieRH3F7OwAhgz4dkptDekmk5hGO4hSgFJz4mjbf9SoXBrFshxJtCx0yrf9vSKzfmqe
 gkJphbmbdgwoG3d1t5GKwEC/WpvBHk4BT0zBL8Wzwx5498SR2mQrcoc3RysqWvtLdodT5NCodTR
 V2v4hX/7Td57pCXxkf8jTPeUb+3QWnYPwaQzybDWUJ5t61I/9LxNT+0/kw+GKHr44lRcgCUEeOZ
 HncRh1VqDgKGN+zmB1yAwmP4c1SbEju86zkKrwXgTAxUW+XR3A6Ejpxv4vqFOxi8Njpq41hgCg1
 oONHp7tOzo+f0eDjxtTiWKuZDGY8br9ZgUuFCY2pK/jwKKV84NdBz2aVhuREPa0LEyWKC9ky6oB
 hGqHNuHU4vpXQ==
X-Received: by 2002:a05:600c:3112:b0:4a2:150f:1607 with SMTP id
 5b1f17b1804b1-4bb55a4ebfbmr158351435e9.13.1794723091535; 
 Sat, 14 Nov 2026 22:11:31 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm139331075e9.14.2026.11.14.22.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:11:31 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 sboyd@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 7/8] dt-bindings: display: allwinner: Split H616 DE33 layer
 reg space
Date: Sun, 15 Nov 2026 07:11:01 +0100
Message-ID: <20261115061102.229680-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115061102.229680-1-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
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

As it turns out, current H616 DE33 binding was written based on
incomplete understanding of DE33 design. Namely, planes are shared
resource and not tied to specific mixer, which was the case for previous
generations of Display Engine (DE3 and earlier).

This means that current DE33 binding doesn't properly reflect HW and
using it would mean that second mixer (used for second display output)
can't be supported.

Remove layer register space, which will be represented with additional
node, and replace it with phandle, which will point to that new, shared
node. That way, all mixers can share same layers.

This change is intentionally not backward compatible and the old binding
will not be supported by the driver, for the following reasons:

- It can't describe the hardware. Plane register space is shared
  between all mixers, but the old binding puts it in the mixer node, so
  only one mixer can ever claim it. The second mixer can't be supported
  with the old binding at all. It also has no way to reference plane to
  mixer mapping registers, which live in display clocks register space.

- Supporting it would mean keeping a second, mixer-local plane
  management path in the driver, with hardcoded plane mapping, which
  doesn't match the hardware and which can't be tested, since nothing
  uses it.

- It was never used. Upstream H616 DT has no Display Engine nodes and
  the rest of H616 display pipeline (TCON, HDMI, PHY) is not supported
  upstream yet, so the old binding never produced a working display.
  Vendor BSP kernels use a completely different DT structure and no
  other known DT consumer (U-Boot, *BSD, Zephyr, TF-A, ...) implements
  H616 display support. Only out of tree WIP patches used it and those
  are updated together with the kernel.

The driver will print an error, asking to update the device tree, when
the old binding is detected.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../display/allwinner,sun8i-a83t-de2-mixer.yaml  | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml
index cbd18fd83e52..064e4ca7e419 100644
--- a/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml
+++ b/Documentation/devicetree/bindings/display/allwinner,sun8i-a83t-de2-mixer.yaml
@@ -46,6 +46,10 @@ properties:
   resets:
     maxItems: 1
 
+  allwinner,planes:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle of Display Engine 3.3 planes node
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -74,22 +78,22 @@ allOf:
       properties:
         reg:
           description: |
-            Registers for controlling individual layers of the display
-            engine (layers), global control (top), and display blending
-            control (display). Names are from Allwinner BSP kernel.
-          maxItems: 3
+            Registers for display blending control (display) and global
+            control (top). Names are from Allwinner BSP kernel.
+          maxItems: 2
         reg-names:
           items:
-            - const: layers
-            - const: top
             - const: display
+            - const: top
       required:
         - reg-names
+        - allwinner,planes
 
     else:
       properties:
         reg:
           maxItems: 1
+        allwinner,planes: false
 
 required:
   - compatible
-- 
2.43.0

