Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5686C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 20:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD7310F177;
	Wed, 23 Sep 2026 20:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dxBNokKI";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9D3010F177
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 20:11:00 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b91369d18so9264725e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 13:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790194259; x=1790799059; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OHFYvczNQQ8zbB57FCazhQfFZ5fguvDLVHqTQCN5Cj0=;
 b=dxBNokKIBvIVUl2PcXu7B24DMkhFv6qMOXMJ/rk+CCQo3Oko44U2AEUcKfC7kxlifk
 qBNCVIxo8fHbowSZg3/DPGA0gR9fe03xZ8654CGI79mok4GcCFPYEU17kQOj9iF8nLiN
 qQhpo0M68XcgUuYuasV0ELbmUDbiIIhSV0D7RW7D7YeffYwyuGrkii1qW3hHjSYcm/Cj
 e2FHuizUtY4Y8U+iIyVoYQxyJwFliZGcIVKpQ04Jk4kz4wHlb69Qrp/HvdPWmCiy5RUv
 XEkDw4ew0ySaYCAKgPj+nTaLxOkEEEP/pkT/YcSRTCHCedC8nm1kgJjvU+4GZcjez6M+
 2JTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790194259; x=1790799059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OHFYvczNQQ8zbB57FCazhQfFZ5fguvDLVHqTQCN5Cj0=;
 b=v7vdSVT7U2mqNgIqHSeM24JgiYgcI6tD7rfZDpQEx5gDK+8hHJivjI8ah/FRphbSFm
 JDAEP4HskuBNM08VJfeGlOMr594xSNkvclShIT/jknAwxWGhRTcbQpT+6myvxzN2FUXD
 FLYDjtYrNdmZLFvvG2jV+Xy6h9xdMOQx+smoR96jAEY2qjQf3beooGhx1qylAsebrI3U
 /ZdwNuxPG5YkTp9heyN+QZL6Eq4m4OpVV1I9ZdZVsBU+tW7cmmt/3om/engP3G2FAyu3
 iZ19whFqbeK/m30jV8+wT1/+x1j4sKY2kHwQY9/9MhvRk7kEEjRUT/GQnY2TsrcVN9nV
 PeuA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzWfGyOTMCtpHQkQwOpb3pWTiD23QdeRjqXnWw9Qs2WxMsJZzvPITKdB2VzDel851buAAT1N9pkHL0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kOf7OO0Q3j/9EvN1NKT6BCgLgcKnNECf1A4dU3YbQjAyU/Qp3s
 Y4OSbTEJjsPj9FVrngcseSGqQSjCDETk7kA4LdpuOELQ5K+tJf15vuMC
X-Gm-Gg: AYBFou2T3DBLXp/VIOdpZMQ9kcP0ByfPwp5wyzlelCEBykC2o1C+cPE0SCQnJlzx8vo
 NnBL5A7eqU+VhdokGktvDu0ia4EiLs8lQLiSHfl+9jb8tksQBvd+Y3XJAt66UtEDS3ByY9cBMdx
 cdz2ma+eBUCy0OBnIDAHGwNqv7PdZ3N61eFos4WRSgdURxyN0wALdYBnNux/2msrs0a25nCEeTk
 OgJGyEREJmIMl3SxBLUfBhQe1B6UQkZP9Omd+eT3U/kYPd+2dslH1N3zjQlD1jEuYbx6exqJjCl
 r/9ZFclcZjISZHzFzK+eyp+Pf4ljoC9FcQCGcqp+D//rWlunmDHTE87VOd0FeiSmkvelzseybUW
 TLZ2HkyqnNPnrIjThKLexD+BDktQ+78OawB/DruSpFFluV9t/20221pEJgNiU/x9+SgqDCa7aKB
 EwhXR7N/bfk4vn3d+WPfVZJBPjLP8EYEAFOEHrv51FuMpma/zNYQfHt0783mvvte14LTw26Balz
 alE51XQd+ufGxZzUgd6AoYS
X-Received: by 2002:a05:600c:c16d:b0:49f:cac3:c68a with SMTP id
 5b1f17b1804b1-49fe66f9ff1mr4161775e9.31.1790194258869; 
 Wed, 23 Sep 2026 13:10:58 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cd4c8dsm13559295e9.3.2026.09.23.13.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 13:10:58 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v3 5/7] dt-bindings: display: allow the boot logo in a
 reserved memory region
Date: Wed, 23 Sep 2026 22:10:33 +0200
Message-Id: <20260923201035.51007-6-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260923201035.51007-1-maximpedraza@gmail.com>
References: <20260923201035.51007-1-maximpedraza@gmail.com>
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

Carrying the image in the device tree ties it to the device tree, but the
image and where it goes on screen are independent axes of variation. One
board sold to several customers wants several device trees that differ in
the logo; one customer with several products built on that board wants the
same logo placed differently on each panel. The second case would otherwise
mean duplicating the same image into every device tree.

Let the node point at a reserved memory region filled in by the bootloader
instead, so one image can be shared by device trees that differ only in
placement. The region starts with a small header carrying a magic number
and the geometry, so the kernel can tell a logo from an empty or stale
region and bounds check everything against the reservation.

A phandle to a declared region is used rather than a bare address: the
reservation is what makes the memory safe to read and what gives the kernel
a size to validate against.

The two ways of supplying the image are mutually exclusive, which is what
the oneOf introduced here says. Until now the image properties were simply
required, since they were the only way to supply one.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 .../bindings/display/boot-logo-clut224.yaml   | 40 +++++++++++++++----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
index 9dc3471763..a71fc09a7c 100644
--- a/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
+++ b/Documentation/devicetree/bindings/display/boot-logo-clut224.yaml
@@ -62,12 +62,31 @@ properties:
       index into the colour lookup table. The property length must be equal to
       width multiplied by height.
 
+  memory-region:
+    maxItems: 1
+    description: |
+      Reserved memory region holding the logo, as an alternative to carrying
+      it in the width, height, clut and data properties. The bootloader is
+      expected to have placed the image there before starting the kernel.
+
+      This lets one image be shared by several device trees that differ only
+      in where the logo goes, which is what a family of products built on the
+      same board but with different panels needs.
+
+      The region starts with a header of four little endian 32 bit words:
+      the magic number 0x4f474f4c ("LOGO"), the width, the height and the
+      number of palette entries. The palette follows, as consecutive red,
+      green and blue bytes per entry, and then one byte per pixel, each an
+      index into that palette.
+
   logo-position:
     $ref: /schemas/types.yaml#/definitions/int32-array
     description:
-      X and Y coordinates, in pixels, of the top left corner of the logo.
-      A value of -1 on an axis centres the logo on that axis instead.
-      Defaults to the top left corner of the screen.
+      X and Y coordinates, in screen pixels, of the top left corner of the
+      logo once it has been rotated. A value of -1 on an axis centres the
+      logo on that axis instead, which is the only way to say it when the
+      logo size is not known to the device tree, as is the case for the
+      memory-region form. Defaults to the top left corner of the screen.
     items:
       - description: X coordinate, or -1 to centre horizontally
         minimum: -1
@@ -103,10 +122,17 @@ properties:
 
 required:
   - compatible
-  - width
-  - height
-  - clut
-  - data
+
+# The image either lives in the device tree or in a reserved memory region,
+# never both.
+oneOf:
+  - required:
+      - width
+      - height
+      - clut
+      - data
+  - required:
+      - memory-region
 
 additionalProperties: false
 
-- 
2.39.5

