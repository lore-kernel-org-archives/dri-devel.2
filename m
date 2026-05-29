Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F02CD6E43
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 10:32:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0593410FCBA;
	Fri, 29 May 2026 10:32:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aC0Qjyp0";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8F5210FCBA
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 10:31:57 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-836ebdeb969so6103829b3a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 03:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780050717; x=1780655517; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1wnSFbHu6NNjWF/TbmbEaSgsNm0hwZHiTpIBFqP4Jso=;
 b=aC0Qjyp0s2QmdT6x5b0B7f6wglIbw5VLyFVBJpC3xC3KsQO5saFZolviXMbmqcghjb
 O0DVTuipkMllAo17NPykndtd6a/wqlGTwBYaAlvDWlo9J5bwez4hlX6F9RdbtIXZ5l2r
 7Rz246GlpH2qd3VIdEF9L81TOsNMO2pltogbV38Ru8ZvZPegUdzETeIgY72Vlc8Flqq4
 PcYeWRbBrr8RQgSztwe4TzffIvqnZBrZ6oirk90EBCncLbpVefI+KVJt2+cCrs7SIPwm
 Gy6nhKvaXsz0GjKLQ554pfLtFYkHdbttVzVYOLHjYiQr3xTjFO9bOQQFafhjHJoFFdSL
 Ti5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780050717; x=1780655517;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1wnSFbHu6NNjWF/TbmbEaSgsNm0hwZHiTpIBFqP4Jso=;
 b=H+SX7YOP+8FQ2UmtSbCDNQicegoDBRYLQ/Lqu+8Kx4HY6uy0XaQOHvHo43l3u+6yYW
 Wq6sU2kNyNztOJEvHyTYvcMhT8W0CyK1WcDue3PfHLOD+DCv/lF/SwiWvMtvNf2ZMgGD
 o2uU2h3POeQxZzxqHOeVelgSs1a42kbiYd2XbHKusCrJPrlJWdJEGfJ4WWYYPBLH+ynq
 OYd7Gdv5TXYd9hzgm+NDJLG6E/dOJmCnGTnOKBNl/rxoIRhLFAGvjmUCQQcbbZiPBkkX
 bYLLrJ0JvEQU298dfz10IGI9+Md2hM+RQtmhCnPK5mEhFNAgqbSe5CGSwG7mWIJy1oEx
 1drg==
X-Gm-Message-State: AOJu0YzkI7F/xilePVF3QH2lxoeHX9yEggX+8rtkWzNaxzlLuhF+rvlR
 AwZNXCCRzVNb6uc99EcOrdXzB6BVQ3OXaDUFFy941XKDu2ecmfdgIxda
X-Gm-Gg: Acq92OGzFWKT7rk264al4VdeRyjBkIE96VY+9s44uWub/r24Bg8Jb6Geu4D6pNqtLye
 IVp7udX4OXp/Rb/B656WRulM8dYDuT0eeGJS1l9QdGrPJg/FbX9ZxnH0a4LZ3Xu9nSQBWGLxbuQ
 Y3F/7/dcF3zyZPPM5HXH9KDSW7h6RAv4dXRvus/2wG74Qab58aMGpkGJUhXQ785GUI2Uzqs8d0M
 1QTMI8WE8ELbV+gpiyEft/u5GaGJ64APWuOZPRRgdoRtaDumHomQp8axg0TwThQQu0mrr47tWn5
 iDiw4qiQ3GCEvEBpkpSk9/ng0fX/wuf8hZF0tN7UeQwvdC5w/oyO5Tg5FxMzzN4v9lxdbLYtOgY
 osFVLDqTn3mehzDFBCeZHjYmb93y00YcOypUKLItzaoFVF2qjm35IK7Civyn/BJ95kHCzOrPx3H
 LyrHYTwIDr6214a5aqeehqXD8bx02ixeC2rg0gc0SAzG1jJ8u72n2VRo/QPbyxRMawYYYJn/pAU
 zzjpTKh0hz2QCMKUYSSqw==
X-Received: by 2002:a05:6a00:6c9e:b0:837:666f:8fcb with SMTP id
 d2e1a72fcca58-84212c38b01mr2540661b3a.5.1780050717326; 
 Fri, 29 May 2026 03:31:57 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84214b30711sm1418512b3a.16.2026.05.29.03.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:31:56 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Fri, 29 May 2026 18:31:51 +0800
Subject: [PATCH v3 1/2] dt-bindings: display: mayqueen,pixpaper: add
 pixpaper-426m
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-bar-v3-1-5c2ac1c751ee@gmail.com>
References: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
In-Reply-To: <20260529-bar-v3-0-5c2ac1c751ee@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, LiangCheng Wang <zaq14760@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780050713; l=2115;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=g9m9+6NRdwUwaTmmaAQNYjvkbYeWVUTBiijRvF+0Fis=;
 b=yce1xB25ZrB2pve/MPW9tT4u0W4HKp43LjwEY+8Tjlc1RJexIjjLBY9jnb7BH2S5Mv6viRWtY
 WApzVgwHHkoDNMAznw7y/7bg8CVQRNErpMd/Eb1mYxnGlHNCjHJHNO7
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
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

