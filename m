Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066EED58B17
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEB910E24F;
	Sun, 15 Mar 2026 11:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nrmbrqTl";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A50E310E18E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 21:46:30 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48538c5956bso31120915e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 14:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773524789; x=1774129589; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WouhV1wJdcqRp0ZqWSI8CA+UTeojrOgDEfJ5Sm8iumM=;
 b=nrmbrqTlyxi/f5dJQsu6KQkcpe/EifQD7kkz3yimYp/rjkmbIfAsfJ7+dgeW0GJ0Pn
 K0yvaE7N8NPn505WAUmVW2eDMDKWllDlnNweeYR7cijLiXT9wnivr7s9lafb6wnBFZEx
 fl1hZ4+zwOr4TcMiS3BgJXwlXnS6N0sMj5h2h6tf16H/UcBF7zSktOiYD04LvvlG2F4Z
 Khn6WuO2QeC7J8jXEwW4edrL0/AQq5y7zyQd99m2mCVcdhOtWvzKRIM+kB00JUhcvsan
 i/EZbVGMcw7ouhJYbNKGTOXBpw1a0UIIoL9/tEm2NXQ6CcuKYAGnpF7OlIoQF/ELwyRw
 yqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773524789; x=1774129589;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WouhV1wJdcqRp0ZqWSI8CA+UTeojrOgDEfJ5Sm8iumM=;
 b=O3E/Shh5GURIJO7zcffbY1u6v7HpzpqZcu01Ho0vIsNAJXf3enz9QXLal0DKa+vV1I
 hBuXSGoGyixAyxnuKSvAQbzeCoL7qXYZwa1HC7T7FYfIXu2J3M5+oh0zmUO5l5CBpjqq
 SJMEPbsNyRtyIhDGCcFTkJ92ZidSqt0GYYL4z3ocg2tcbDMVAUaM9AiR/cDccpCrYo44
 QbAFq6fuUPJDJOXW/McxeKpOCgkeV3VrABydjRc/5JL49lj6mzCnzW3OlNWmsx8Rcz5b
 2p/3UwR/D9nIKWGJEVzQwVfOIgR/pqynXm4c8G2qkKqO7umzphvTqaicJbVVTY1wadUy
 FqLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVziKTKsgHjIQAuGbrRU3c6PgmtBSiCH6FQnsX2ijalsKS9qLNcrYPFvEMWWFyEMCveUPUIlgPx7Tk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAU1FOSmWtC/XKjViyyH/5yVzuZmRgTEZWDzGS5I9GNs1lWsLz
 kZX5Wiz14+BksN7jXteuMfuaZLWgOnLOQNevZsV51oXBiyjCGqMcOQOP
X-Gm-Gg: ATEYQzyGwW8heROD70MLMEY7ozsOtKwOr/iFM8dhU3SuS81GvXtOsCF9VZMMbkVgDLR
 IEaqOfDaHdcwXao97WkK2jzGjn8Y9iAaWBZYag1Cq3mAbn4JGOMW1cZy00nkTA6+3/FCTsrDmPn
 xv7drMHD95h5TmrQ2hmGl70FhCwPMgBXAxfqxKl5IFUDrru3DyWfo3HaZ4vk0WDXFMZmHakg5//
 kIA6ImcGHdnYHAuXZRBVLke/6syT9guKmi9ohoIplsO9mAR2r2CMESABooRionq8gZGSDYwe3Sb
 QeBkwJrsYYY2gKoqFxCK941pds1xasWl8go/aJ4WwzJVUg6FAkRrKTARRkXSfxLW2FpSeIuG7so
 EgxBnS/x0y1GiUNXU+2RXdc2PAL5mmLizlgUxBYtjbfvYMwn01ebsuS5x1LsP/scEwRGI4Kead7
 k7k1wTXj8oyLU5aBwCm89bx+I7+HvZNm89C2lDjKqSndrstLNpUqxVeKzJ1oXg8zw=
X-Received: by 2002:a05:600c:2295:b0:483:a2b0:d210 with SMTP id
 5b1f17b1804b1-4854f56d693mr146590025e9.7.1773524788919; 
 Sat, 14 Mar 2026 14:46:28 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19aec5sm28756221f8f.4.2026.03.14.14.46.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 14:46:28 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Date: Sat, 14 Mar 2026 23:46:21 +0200
Subject: [PATCH v4 1/3] dt-bindings: display: panel: Add Samsung
 S6E8FCO-M1906F9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260314-panel-patches-v4-1-1ecbb2c0c3c8@gmail.com>
References: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
In-Reply-To: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Kamil_Go=C5=82da?= <kamil.golda@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Yedaya Katsman <yedaya.ka@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773524783; l=1325;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=HuTZem6WD63BD435M83j22Zf/cfFLJrqs3suzghbsJU=;
 b=xtreJUwAcy92CqVk1xHYCShCK+Jg73BZ0BQMe9255qqbRrr3GsfgqWIc6mOmasBBAXN7FBBEk
 jSuFlUctZmnAsixaABv59Wd0hoJ9EYftBq1fI0I1Y16SzmbAb/eSIeD
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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

Add Samsung S6E8FCO DTS binding used with the M1906F9 6.09" 720x1560
panel found in the Xiaomi Mi A3 smartphone.

Co-developed-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Kamil Gołda <kamil.golda@protonmail.com>
Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
 .../bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml        | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
index eccfc66d7fe24fbe86e3c25f35beb0855c4fcee6..05451c1b00dbfee9034a05be7be50c3820d3787c 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa5x01-ams561ra01.yaml
@@ -8,13 +8,16 @@ title: Samsung AMS561RA01 panel with S6E8AA5X01 controller
 
 maintainers:
   - Kaustabh Chakraborty <kauschluss@disroot.org>
+  - Yedaya Katsman <yedaya.ka@gmail.com>
 
 allOf:
   - $ref: panel-common.yaml#
 
 properties:
   compatible:
-    const: samsung,s6e8aa5x01-ams561ra01
+    enum:
+      - samsung,s6e8aa5x01-ams561ra01
+      - samsung,s6e8fco-m1906f9
 
   reg:
     maxItems: 1

-- 
2.53.0

