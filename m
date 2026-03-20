Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0DB10987AF
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 16:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9ACF410EB85;
	Fri, 20 Mar 2026 16:42:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QeOzfQdf";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F22B610EB6B
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 16:42:03 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so1493118f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774024922; x=1774629722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wDx7nIMupZuya6kEy4r0T51ugjRAiOlO9zel+//9XXQ=;
 b=QeOzfQdfyDyms1rtjWmsTaZqgzK2rgdEAo6ZzDHkJPctdp4mFQ8bi63beHUI4oxN1b
 qMPkF2Ymtn3cPvwp9iPb9PPXUy+zDkXZ9OhOzepKsKnXUbauOHbdou2e9raGhslLFgpu
 6c8JQDHhEqj7wn3VNymzVwkSwZFI2bOgkqaC7VCpkCG7Y5xANhPjetCgO10hZeqAzpHn
 TktNKgAm9348FZDKlFyDMpuac9Fuq5pb20GeJCXRNWLelyZiTjw099hkbmZmAwXARGkz
 zFJX5DBQXisp1aBsNjfuiW+vWNFNhsipahNXCRWnf5IpP8wHJRylQfyaMwugbG6LQw+P
 bc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774024922; x=1774629722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wDx7nIMupZuya6kEy4r0T51ugjRAiOlO9zel+//9XXQ=;
 b=EwdX1wlk+I46YSynkuqeaoVAKy7D2Ts/6EV3LY43EA7ee16ovZAZcvO3sCZVAY6AA7
 WUSCaCoFk718/ihFoLhBRGSZOzVpKyMSXjolkoryN7/xZMxDpALHSErmdyuiB1BRVdq2
 c69q7xMne+cAMySxGVyMHsD6asV12H42va7jL6DRYZzDvU2MqBc47ExkFq1T8+3SgsqK
 fDyOwvkJe+suJDX6hBvPWtGlBGzRAu+h2ekj5Kqy+W+KukGcXKB2IJzFQcfqhwawkv8a
 NW7st6kCcJMVHim6LMkywCf8dB74wMEkEOb/8h8gspvzn2JiS/tNkd2/y3fg/oWUm71o
 DWog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUP0IgrV8WT6V8JHRhT+2c3SDUbSNhBtfMF1TMTEnNqN2vtnkAHPEeFENvoR0FKF8VkiHay+tb0no0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYkd67j94LO1NsybVVMhpRZngdCP9EKVlct1by4wFq6HSpxWTs
 qEmx0hEwBB6ZIsNSHt+A/GLttt8vvllZ+yxhneiG5pHQGmNehUUvwvEi
X-Gm-Gg: ATEYQzwpHWfpzcztfi6fbuh1RElTV+Zu0t8f5JR5ttMJ+cuqoCLzCiWC9ojsq28TX4Y
 NjVvasdAJXQIXZqFwFAhYDWzm2NIRrcOWUT3cPaneuwwh6iv3a3JwnriOC/UgG/f6VMG8JgFCat
 Fw4b/mCRJVdaR6BT3VMe2IcX+aU930AEkwxUs1VU8l67OwrR4kBa/DHr4PYYEWLmR2rtB9n/Q3t
 6Ug8CSAPi7mqCHCp1DNywfGfLSYgqQGgoIVRnnCRjS7yNkQk/Hij0gG1qC8v1HjkWTaIPiLTI/r
 9n0yWj1HDXFfZpZFeosOorMA65rMrr7HIa3enx7vdLCN8afmP3fHA2QzTWthBXGskKhR1uHc7hT
 X26+4yVGMFh2eb2C5sdJGpOtuu6DVDbzJmYwBo5twcyqzVnBSYTnZVEHg/5W16ZR/xPdSTNyktp
 EdhhxYKoqO8g/MhnF45KT0QWm4ZwLLLpc=
X-Received: by 2002:a5d:5e88:0:b0:43b:4461:7adc with SMTP id
 ffacd0b85a97d-43b57729635mr15672004f8f.20.1774024922158; 
 Fri, 20 Mar 2026 09:42:02 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:5b93:d2b1:bc5c:9231])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b64703650sm7016575f8f.20.2026.03.20.09.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 09:42:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: gpu: mali-bifrost: Add compatible for
 RZ/G3L SoC
Date: Fri, 20 Mar 2026 16:41:47 +0000
Message-ID: <20260320164158.487406-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
References: <20260320164158.487406-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Add a compatible string for the Renesas RZ/G3L SoC variants that include a
Mali-G31 GPU. These variants share the same restrictions on interrupts,
clocks, and power domains as the RZ/G2L SoC, so extend the existing schema
validation accordingly.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Collected tag
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index db49b8ff8c74..9db9f84ad964 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -26,6 +26,7 @@ properties:
               - realtek,rtd1619-mali
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a08g046-mali
               - renesas,r9a09g047-mali
               - renesas,r9a09g056-mali
               - renesas,r9a09g057-mali
@@ -150,6 +151,7 @@ allOf:
             enum:
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
+              - renesas,r9a08g046-mali
               - renesas,r9a09g047-mali
               - renesas,r9a09g056-mali
               - renesas,r9a09g057-mali
-- 
2.43.0

