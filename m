Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C891CD37B6
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 19:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48B4210E3F0;
	Sat,  9 May 2026 19:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YJGNKCHA";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F37A10E3EB
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 19:00:31 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-44da2de25f3so2027560f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 12:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778353230; x=1778958030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPkvMBVXyvicDPmrKpPPSuducOnxVL8vyxeJt4rQ8ag=;
 b=YJGNKCHAsw0O8JarSNeFzjVY2oglo2xGCx7kRqNIJxm1+HN5v0eGVW3xHYTGtK3lTx
 wpt6ypalog4dZQrgQ23+mvu1XHp8S29P6BkGKw4kgztNV77PgddnEgBFr6PIz10e/yrx
 ifTlLn0gzQc+zTfP1EQzieBDEW5elRygiOyktyvnSdu3MZXsycUSsB5P3voyK3lwZZF9
 iDQESqXNhrP6g8kTgyc+xQfmRSs/z21nmps00t6u0waPropcxmkv9KoFKYa/Jp5txiUE
 8HK3yfIepOvfL21HGaZNNzd4u5YEgienu2GmdoLjglaAe6OPIG4DgQGZk0LSCCTIKyvn
 FlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778353230; x=1778958030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VPkvMBVXyvicDPmrKpPPSuducOnxVL8vyxeJt4rQ8ag=;
 b=Tz/2JIcERHhaisR9ys3JhAcY7nhc3NyCZthHMQlWuEFvNcg2tFSYOCDhir6nzz3ZD7
 OpUMW8ROPbolM4Ty+Wqx0bcDfdj6IBmhzaaUDodIlE37hl0liKiR7EI9uNdPSm/O+5Ss
 /RBaXiJAJ6wk6nygY/9LatrZslhyPKlKaWmK57Ga0NjP6v3XKwsnAQOsHlfByg6ice5S
 H6DWOScaY3wslMD3N5WazoYnMsUfMpluvJKtNJb4OMP76GBZliWz3duHvJgZRAsvyUwk
 v4gor08+7nBsCpc+qIY0Ok5NmtwBJeSgKu5YCbBfINl+S/qYhHUZ7p1VvUCfT6VA2o8b
 hKmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6CR+5h7uYwaLkcTl7qqsw/gmi4bLQLpeALXgNRFhPq5Se5RdaynD3/aNpDCqnA/TuUrvJQSBDkAo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmZg5iq9DrMZ3z/xecTeF9TIos28JUlbSA0jLkKF9sckVwF8BJ
 5tEac9zzmVASEJatA8ZGsDRB1LI2fk1rhfeqJfC8RX1mLyBNKiqZ+kPD
X-Gm-Gg: Acq92OEfhmWtLkVZUgQ7WMCanRzzjhnIljJL2/FuK9IzOIRwtleqyg9/FIFxnp+yxSo
 3WFEwmu98g0x9mjlvuMJA/YrkXZYnLFkAOl7mO4iqQc2/y2NaY+M77uxsZ3GhCSialnNeOHRQOP
 tJr5Vaaj0SPIMhaNsjR02d/rZqIXjKi/sAJK25CHtuYyupLTDomkj2Fqexsg6sEPErkPa5/pPoF
 awaW8MHGHRoRVA7r0tTkEU8+QYF+550nRmZO1o2Tct5YG5s9F2vESW3Szym3HuKECUuGWbPzyUJ
 3uHp62emvfZH/Wv/oBVWQT+rcH/I9/5cSbHX3JTXr7B3NaHc6L4TeyCq0+nT19bY8rjuvHv641D
 qO1LGgN9Pptne3p2WTCdETtDJntvddh2u+fqzXxmp8Fd6TGiEI9U12d0TvB8Qy8kPw8hvcnrYsS
 TFye7GnTHUfeIy5SUw9q6nvV+YMBmB/zEm38MY7u03LrK+7zrbJLxUAzgzcKg7m4Cx7xY=
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id
 5b1f17b1804b1-48e676a4e03mr117153245e9.16.1778353230046; 
 Sat, 09 May 2026 12:00:30 -0700 (PDT)
Received: from jernej-laptop (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm13254407f8f.19.2026.05.09.12.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 12:00:29 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
X-Google-Original-From: Jernej Skrabec <jernej.skrabec@siol.net>
To: wens@csie.org,
	samuel@sholland.org
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 jernej.skrabec@gmail.com
Subject: [PATCH v2 7/8] dt-bindings: display: allwinner: Split H616 DE33 layer
 reg space
Date: Sat,  9 May 2026 21:00:14 +0200
Message-ID: <20260509190015.79086-8-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509190015.79086-1-jernej.skrabec@siol.net>
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

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

There is no user of this binding yet, so changes can be made safely,
without breaking any backward compatibility.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes in v1:
- update commit subject
- reword commit message

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
2.54.0

