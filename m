Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637B9C55ABA
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 20:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E81C10EBD1;
	Tue,  4 Aug 2026 20:56:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BA0c5ENI";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC63C10EBD1
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 20:56:29 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954aff6088so2281085e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 04 Aug 2026 13:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785876988; x=1786481788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SHxdaaypANO4SJdv7vjmn9Syq8V3Ebhk1vARZd9Mr0s=;
 b=BA0c5ENI8d58RFPcR946dBZL6TuAGoeLKpYUhhzt29hQ9USxaO3uDhcQRMmjzgATFA
 Z6uLfgfq5lGuOhS2woRTII986Vpm/++gXZPuvzDuisu2uWNrtKGosPBehezs5K5Cauzt
 l+GpxAHVLf99lvtVdZCUlXTedLakTpyX1u7yjxFk0cBPDnoYCbfUkPrN5ntQUa5k8WPM
 B1uRDLUXPK39tCGs6ZQgdZvJyshFFonuqR9ChwCiAYr8pJF+kKH/C6NRAxMLuUxwo6ZX
 xaQ4Wk4s03Bn8UU3w1BWtT6Qw3RyMDTov92q6Rb2BL7lwmkn591yL9cNKiUqmRVjiyI0
 Z7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785876988; x=1786481788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SHxdaaypANO4SJdv7vjmn9Syq8V3Ebhk1vARZd9Mr0s=;
 b=a866KxIwR0PIMauVPUnLCcuCMOmjd+KzUGkCWHpjVK5paMm5QLniBOXIZOyk/3QI9v
 QFrcs4L02322NHGIWBeV25lVTWBogSkrc3CUUEGzwl1EJbwcZb7/xnraJW6JXm9O14TI
 T1zre1bFvRjWedkGxEPWaTHmpDDfF3MXS5H0iHeJ+3ZoeHMF6vfP1HleeWPhm6I0NaW6
 Lm4GuSRtjNl8RA87uYM/p/NtXSkEVgs96KgnR5WBgYXSILhEtgMMvXJAHnlLaijTF6/L
 /pdHNktOaJkJtRcxMMZzNlWv4Y46tNiYu+lfZz6LK2uw0jVd11aEKNLFX8lK9yX2UfWD
 uPFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1hVAfWdsIJ1FATWPQ9bKu6hBLHuRnESbWgLY6b+CJnC43qTTNzfmGXez9aknAg/ugaUTmi9YPkqY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9HXU6C8RdhxFOo6QmWS8+PGwY5tMU+CepPGsN+T2Q+GL+TdUg
 iqhzse5ZrOTQ/7MDoYTpihBc/CdxLrYX6Tsmy4pHZxDLcJjA5uKfbz8t+Em1lg==
X-Gm-Gg: AR+sD10bXWFyBTYvapIRz0AM38pccdEuzu/24HCofbSt5b7k6hoZvjjeQj8iZ7XUCEE
 OdRgtCekIpwEFcf6rJpk+sSGowVpTFoGPg1KqmGkLDR9J9WKpUlu3IbfqIsLuF9AK/PzshwtFEt
 v9fkYbNyCbggtOTyPX0xTgpOopfSHiAxX+rK3GxmkeToH7HQ9T/hc0DtnY6wBYCLTs6j8Xdg4c/
 9vUV7P4R+yV/uCoCumoLvg25grnlWVXIEY9m6CCRzKq8a3YdLuQevgipXd12oers2H80c76MRqN
 q7fmsNFchkx53IitBMpvHh3L6YDfo3Go5WVVkjxh8Cnwn2eao47pg6x9r3iuhdsYsqR54UhmLca
 qiEnlB/6TCAqJDQQFl5JWj/F8n0PMpT7bRf2I0e4jr7m+XsmPcAPLBPxN3xDvQ0t06qdk4rFpIY
 wqu2U4Y9dgANzhvzqxaHSb74F2YfeOBfgxR8a8kqYD6FDpPLEFgf/zYLfgurawyJk2fY4qTTil0
 mUfqPSk/BN3xQY=
X-Received: by 2002:a05:600c:1d22:b0:495:6338:1453 with SMTP id
 5b1f17b1804b1-4994e7cfdcfmr12133965e9.16.1785876988197; 
 Tue, 04 Aug 2026 13:56:28 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.176.33])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994e4bf820sm12070645e9.0.2026.08.04.13.56.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 13:56:27 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Max Pedraza <maximpedraza@gmail.com>
Subject: [PATCH v2 4/6] dt-bindings: display: allow the boot logo in a
 reserved memory region
Date: Wed,  5 Aug 2026 00:56:15 +0200
Message-Id: <20260804225617.264861-5-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260804225617.264861-1-maximpedraza@gmail.com>
References: <20260804225617.264861-1-maximpedraza@gmail.com>
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
a size to validate against. The two ways of supplying the image are
mutually exclusive.

Signed-off-by: Max Pedraza <maximpedraza@gmail.com>
---
 .../display/linux,boot-logo-clut224.yaml        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
index a6a206964..7aec0cc2d 100644
--- a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
+++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
@@ -59,6 +59,23 @@ properties:
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
     $ref: /schemas/types.yaml#/definitions/uint32-array
     description:
-- 
2.39.5

