Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9229DCD5BD2
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 09:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050DD10E617;
	Tue, 26 May 2026 09:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="klDfg8DW";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D88110E617
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 09:57:48 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ba6485d219so79658435ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779789468; x=1780394268; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=62ASa2L/nhpOgPRME3/DR39dM2q2Ujo48JV3eKd2yRs=;
 b=klDfg8DWuL1j6D6Czkc1K5dySOpW0pEKVcfL5A9iNI5A91aPZfJtFF5okKpzMaseBe
 3J7J60S3ynaqjlOB9VgkwUdrib8prceDxnLVvxZDEGbW5CMj9rbDJyd7vF0ALl+zQ7a/
 ZDfa5oSr88Fe8ujNfiqS2ffCLe8nyqem+IZZgY6Cve/D6lamFrmTAfR7jHVQGHTrR2tE
 lqXKJreaSNnDVCvxZsnAWlrGTitDb60+EV/LEQpRj3dw/gmYmhcgOzjZOVj5zM9ue32R
 t6bEzXy6tZTtIo5eGeyOBemCcqeQpe7fDksj7n75YMDJKBZRW/QK5b5lYTubYzxaRH7F
 zsXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779789468; x=1780394268;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=62ASa2L/nhpOgPRME3/DR39dM2q2Ujo48JV3eKd2yRs=;
 b=JSKnemZ/qn/HbpTiL97CjZ8aGiNtgcctrbESIB3ig+KZuxIU37YTUDtqUtKgIW+01+
 X+qhLG73MwbtYStn45tY9HMod+c8KJ9qgbdqZe/wgeWc4vJHISLBD+mOBeMZwgsNodGf
 v16fI6fI82yL3mihEqS4T2IPb2pgIuoCVYA+F8c35vZDAwenq4XsnIMW34dQFz3ulptd
 Yh/mnyR83GpcuyuU2Cp8pOGsCjtEW/p13+ZPAOtOZlmJ3xIy4AkMRP2/U1wtXb4hz4m8
 BHP7A5aKlHqnSpILYzNDSPLgHiIot8kPXOtdZoxDVn+2xJImou6y1XnRZNSh6QzfhvFn
 weGg==
X-Gm-Message-State: AOJu0Yxk4GUECm/STq57j0tDtn3ABSt88LDUH5t99QrBt6fJAtFUFlgA
 JI+0BeWckF50ZzKS+HBgH5Ai1TpDYpoq4Mx0SvzAKHNuIs9ldeKRctLV
X-Gm-Gg: Acq92OE4/9yNCHsZniL9JXwNovEX29z8UuKXos6IGaU6eO1672Gfj595xWTmb5Yxg8Q
 zxWHYAV6vr7wupXvxP6l/Zma5dtHnZx8dP/PhAHo8++3Ma/lkmuUVuDGsN+rBLoAt42moYcxzGM
 b1dHCcoM/FhOokBt5n5cW892wM2s+3zoSnm1XYVpm8cQ3LqG2xzZAWXNk3cQx3TlFrH808qPiM9
 /XF23YAopNE1wjyQCFfeCoUQKTqs7k0AGjQcZ7K4Lq8HOYihgjn5q2YLeGsB4CdYd8iBz2GI5ej
 Q8bFTX1fVSEcL0ilduGr2TcqVUucRcrV29XJS4X8suMu+sBECkNGZ/9F7Z/+4hf9jFt/ckPHNex
 W3PbuZ9Qw75mB1ituWlM0oSrPACqs0XVQGi21R4Et0555Jz3rVwiOOTgtDe8TrT5ZkbcwDwR8nL
 rPYkdEX3zBJunGlqEL+mxzkwUVnQU//9mw7JLvm+Qd2SodgKfP8NX5mvbDHAkLQcQq2B2jBHQOi
 JOsRv9mT62osazMS1qg6g==
X-Received: by 2002:a17:902:ea0e:b0:2bc:dc18:35a2 with SMTP id
 d9443c01a7336-2beb05e48b8mr214421815ad.26.1779789467793; 
 Tue, 26 May 2026 02:57:47 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58b2d47sm147055165ad.45.2026.05.26.02.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:57:47 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Tue, 26 May 2026 17:57:16 +0800
Subject: [PATCH v2 1/2] dt-bindings: display: mayqueen,pixpaper: add
 pixpaper-426m
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-bar-v2-1-c66df9a840c4@gmail.com>
References: <20260526-bar-v2-0-c66df9a840c4@gmail.com>
In-Reply-To: <20260526-bar-v2-0-c66df9a840c4@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779789463; l=2062;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=xjDcQrcGN4gLcGwZrUgVzOpV//jSntMqaSVLUFyRwzc=;
 b=9OxnFEpX/rDY/kyYQ+ru5PXaNK8aV3Goml65+mirmTqPlGZrjRZb0dmKJBVU1DXEiIU5m0VWM
 eCUPwCLOT93Dptjfco11526Hz7ScEQkQH/ge6MapV0GMtS9Zk7IsgFO
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

Add the compatible string for the PIXPAPER 4.26 monochrome
e-ink panel to the Mayqueen Pixpaper binding.

The new panel uses the same SPI and GPIO properties as the
existing Pixpaper panel, but it is not software-compatible with
it. The 4.26-inch panel requires different panel-specific
initialization and update command sequences, so use a distinct
compatible string.

Document the new compatible string and update the binding
description accordingly.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 .../devicetree/bindings/display/mayqueen,pixpaper.yaml      | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
index cd27f8ba5ae1d94660818525b5fa71db98c8acb7..68a6157114604a8308259191e55d1e2d15d76c11 100644
--- a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
+++ b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
@@ -4,22 +4,25 @@
 $id: http://devicetree.org/schemas/display/mayqueen,pixpaper.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mayqueen Pixpaper e-ink display panel
+title: Mayqueen Pixpaper e-ink display panels
 
 maintainers:
   - LiangCheng Wang <zaq14760@gmail.com>
 
 description:
-  The Pixpaper is an e-ink display panel controlled via an SPI interface.
-  The panel has a resolution of 122x250 pixels and requires GPIO pins for
-  reset, busy, and data/command control.
+  Mayqueen Pixpaper e-ink display panels are controlled via an SPI interface
+  and require GPIO pins for reset, busy, and data/command control. Different
+  panel models use model-specific command sequences selected via their
+  compatible strings.
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
-    const: mayqueen,pixpaper
+    enum:
+      - mayqueen,pixpaper
+      - mayqueen,pixpaper-426m
 
   reg:
     maxItems: 1

-- 
2.34.1

