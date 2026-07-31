Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F25C54FCD
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF8F10E2C4;
	Sat,  1 Aug 2026 07:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j9grPtub";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 665CC10F431
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 21:50:52 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1104443f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 14:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785534651; x=1786139451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=luqMKmTQhbao04KxZsM9dM3mm5nhaixuuCx8YNHFEpY=;
 b=j9grPtub6Po7vD2VfHcEimCIhLsaC4MG7sv1RGebujOxVB9PIoHg8wLdOGzCdf3JFx
 zaZc6g9VTsk+cyyrJXNyAClUyWi34h/wdJ/i571/4PfeGiXkzqT8dZxDk3vex8M+MzXx
 QYZ87f2JXR+PkOvowWvK2eBApAPMTa2MygqYXyGrIcuMHHT6DfDVWIYUZRXsgTEVJayx
 XS4h3mBIAwlbIjn2zOk+UP5aF8ANh4jIYcMIFzySZLHHHelr7IQuKcOzc8ZxExOkydnF
 Z/0yvHnBAMOo3pYEsfSl4B69QxBFQ6CSYJlH5V6Coar8vS8l4lYAiwGef2hXuQ6CcUkn
 sQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785534651; x=1786139451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=luqMKmTQhbao04KxZsM9dM3mm5nhaixuuCx8YNHFEpY=;
 b=YFaD1/4fyzRAVfE8nmD2ZJKFcQdZf2YqNLoPsigPjUfcxEQEir20Hi39nm6Me7Q8OY
 WzioKwyl0J4Tyg5UHajVGUaqC7/t351RfsJkxh+6nwI4RaYbBAgU3erLfpK5HmQ3jH/J
 dEQinIbAcz8sJedc7DQqXDAUioWKT8Afa/Lf+SSjAepHXg8tvo6k1TqDR67U0Nc0z/XF
 dTXqKTTX3m+JDkwMrysodInRjdOqN8uZcd4BOjTR+63Cjv2tsAESnTDvpptuS9sZMMWp
 kzjbPnT9dOwF5uKYRDaCYXzsjpnIVSgKm8icngWPCI1r5zweoayC4AE5SGM5994eyY2R
 hKTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5Z3Fi52RNM7BoL+oVqvMCYqmwy6Evvu1CM6GOgGdFlHdSNjRez3BHYkDaX5etzcHD9p1dXvkVH14=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1LsRvismCf0LhtBqAPGtBchqy97xwW2C9IcQpkMwwfTTZtpUV
 seASumKghK2dDyudfDcF/ZiHc9NtanUTA0mt11DOyvVulabyjyNq1815EVxS6P9v
X-Gm-Gg: AR+sD12yL0HoYn2cXnYssRiJx6/IbO0Y+EnfP/MiYgGfsKo4a9segBa1kpBYgHOSFrB
 vXn3byAo7QForJvpuB3hnrWe0SGD/GZr87pr9yBczYbU7Vxig870GiAWYdDlBlNNVreQm5BTgvK
 JdGmz1/uHNwnW1UeuQhRBeH8F8P35lnbjY5FUla5l9GRg8h2jeAXphHaIsXoOSE70wf3fh/z4yE
 Te+m49n066IQfMkTty4AqFU/LXvnTA9fmt2K4umP0Hb6ZB4YAbEYOAdDRkxqtHEYgk5oiy/PQWn
 N0yJeHzSI8VeyJKe3wT47LKbhHzIEn2bbwsYnWtoAB6SPyHeJvFKnURD9knxQGHwzhnELFgcxWm
 SUQDWKhh8sLWiE7N48jeYIuzi8nqugLGJL/FPNTmiz6yttd4w36Qby6vPtpHnV5dlqcG/ZAMDoh
 57b68FP1oxRfxL3sP3bVMaYaXEN+jKFAXFwdF6XgKAI5mjqDHqD6R1ZhBMC57a/CcuK7H84PezS
 Xf48bztWaPF4kfRQ7JO4bWV
X-Received: by 2002:a05:6000:2404:b0:47f:9557:8daf with SMTP id
 ffacd0b85a97d-47fd7329f01mr2280434f8f.61.1785534650742; 
 Fri, 31 Jul 2026 14:50:50 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.116.62.64])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd41e2484sm10186342f8f.11.2026.07.31.14.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 14:50:50 -0700 (PDT)
From: Max Pedraza <maximpedraza@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Max Pedraza <maximpedraza@gmail.com>
Subject: [RFC PATCH 4/6] dt-bindings: display: allow the boot logo in a
 reserved memory region
Date: Fri, 31 Jul 2026 23:50:41 +0200
Message-Id: <20260731215043.30392-5-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260731215043.30392-1-maximpedraza@gmail.com>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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
 .../display/linux,boot-logo-clut224.yaml      | 52 +++++++++++++++++--
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
index 10845378d..c40683f3a 100644
--- a/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
+++ b/Documentation/devicetree/bindings/display/linux,boot-logo-clut224.yaml
@@ -54,6 +54,23 @@ properties:
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
@@ -85,10 +102,17 @@ properties:
 
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
 
@@ -106,3 +130,23 @@ examples:
                          0x02 0x00 0x00 0x02>;
         logo-centered;
     };
+  - |
+    // The same logo taken from a region the bootloader filled in, centred on
+    // a panel whose usable area is not the centre of the mode.
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        logo_mem: logo@9c000000 {
+            reg = <0x9c000000 0x100000>;
+            no-map;
+        };
+    };
+
+    logo {
+        compatible = "linux,boot-logo-clut224";
+        memory-region = <&logo_mem>;
+        logo-centered;
+        logo-offset = <0 120>;
+    };
-- 
2.39.5

