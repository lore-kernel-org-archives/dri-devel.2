Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19249606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSsF1Fdm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FAAC10F06B;
	Thu, 19 Nov 2026 17:55:02 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99EB810F06B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 17:54:50 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4a33359c1b3so1874897f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795110889; x=1795715689; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vt2sq8M4zEW0Jl+PkiArkaZv9si52iHkUjUxiJyG5ok=;
 b=mSsF1FdmsDaAXcGloKYztVVS42nfzlghrIPh/gG2mc2z1OzCQXtBaXKZYZDZ5E8mgh
 lHQqD3znyusKAqIbwqKfs2u0aJBYoRhFDn/NZRtfbnod37v2PlsG/7X/+3SPtwBKgI5s
 +S1HCROI2txYN37DufAIS/fVHwG52sBQQnIfH9PkBuT/pFgzpvjcnYGqvJbSl/LpVcC7
 RPnZ/BRbFockUVPfm5o1dqkeYqj2/r38nl28y9Cnkfu+V6TwmFkEPfGbLrZc3wMNnBkN
 lEzCJ9WLRtc8LCEfVPccxSdZcMtR0tc3I7co7+YjGj8/943B/hrbKR83So+zuQrhGbYV
 wJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795110889; x=1795715689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vt2sq8M4zEW0Jl+PkiArkaZv9si52iHkUjUxiJyG5ok=;
 b=yOTQOrxRfbGjlppsjr6Q3HGaVbEVeKn87WVAkI8IaYt6xYecoahcPYtdWAkUhMJehh
 UtxIdDU7zS0uaZhlg/QlbmjRbFkOeBsI38FMEHJ789MJzydDIPWEhCKiRcxmthKdP+zX
 BKhxLgxRoDx2BJKwIcdDOySeUVrm93a4hzUlHhbgsL8y7WzG2/Tx9Z3HWJtxF238C5k9
 ApJJU4VT4P1H7juSxRwALgsTxaSzpvetNKkj4cIvFiFJOIAdHEqZvTbFf6UQ1tNEsjGQ
 icdCCpSf6rw5wJaEi6LReRsULDuPhXw5JR6sIsq+Fr+b7xvnAgFKrUarPQhQb8Py8hwo
 7GGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG47qL7kM5T5rbynBBdc3bWcprabb8+3NvX4pBwP4s4gRmmt2R4//P60CmQKx7fblUPihmLCownXe8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z99+xuQ+uDsBjENN8mvdPU9hF0+09tuMuScI0af0FBUudjfvv0X
 a6t70SvY6xWTCjaiBqDmvEjKxB4fJpwqlVw0t1fbU4qo+gFGvntBtrmv
X-Gm-Gg: AYBFou3g8zwIl2tC9mzfp+oMhAgWLcEZLYbJIgcSPyfO9rZdenc8w1v8PAPD2sEcPf6
 nmsgvTeTYa7eq9wPXb/pdrvQ2R7qU59fQFtlzLToJKp88SDFQBntfQuXzDEvPUCMk9RrEaVpLp7
 PypVyqagUvH+OI67EFbZ5Z+F3xPxfWK/iWFKUauZB7mBb6poGD7JK8ytGGiB5gFX4VK5gDzit3A
 tJc/S+ZMjPAB0C3H6fHzC1r+bjYOcC/7pgoLh3tMeFrWWijZ4jmpSJkmDEff6Z8O0iVcRPAtqP4
 fPHzljZ+cKy423KUfNYGAbKrtubtMf16Eds+CsA2FcR7rvgbNuYJtAukCnXAFgbLeajacWij3cr
 84m8XY7y0QE9YGvxjHn7+WeMciTq5KBS7J9oItZsxPAYdoICkHmGORg0RdHjc8RTEzG6ikSnpXn
 /6T3tlbToii9+LO63JTH6+M928li6akw+FFpVjligohz0aKQQgwch1Qs+LLS0NMhrrpMoQ3RGdO
 CFIKfiZqguE04ezGm4wx5ujcBTlZgXIArbImqeUZXfNdEZMPWo1bQg0TFjjD903dCU1LSqOpUJZ
 RXP6nSzH+vcUzBINZ+c8v0fKL85aYlLG4Fs+zfErvRSPRj+98RUe2Ym1XOS7kIA29jrZlGJtgwe
 PApTUXR2AfelM9diysUO3jvSJLmh+UoCG5AujaT5ddJpQHZSX6l0qjMJYlUUqOlokRDgNCDt85e
 ORAQkMbP+Mt/nSSu5vyu5bAfODiklzYsQsyk/S+W2lCntFShQPLfK2BLWak3lXydJwpExP8kICI
 9idsNfw91RnwDJ8inP3DRZdNc0wPlDvElGU8/NU1M04W7pRAf146E2L
X-Received: by 2002:a05:600c:a11:b0:4bb:69f2:87f7 with SMTP id
 5b1f17b1804b1-4bb88812c92mr5507015e9.18.1795110888897; 
 Thu, 19 Nov 2026 09:54:48 -0800 (PST)
Received: from jernej-laptop (95-143-148-21.dynamic.telemach.net.
 [95.143.148.21]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb84e50512sm29390035e9.3.2026.11.19.09.54.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 09:54:48 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] dt-bindings: display: allwinner: Split H616 DE33 layer
 reg space
Date: Thu, 19 Nov 2026 18:54:36 +0100
Message-ID: <20261119175437.2520400-5-jernej.skrabec@gmail.com>
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

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

