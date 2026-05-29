Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA95CD6E4A
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 05:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AF83112712;
	Sat, 30 May 2026 05:55:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h+998ZeN";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89AC112191
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:56:07 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490426d72f7so72248485e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780070166; x=1780674966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ksGpgyBSOY6krVRLLbP0F0NC4KXp/RG/saaAZ0uBhZk=;
 b=h+998ZeNJjhlK4IuyHRPbTIX1y47wd6dzDr/3LnRV+n9ewjTdrsyz5sC5suJaYyNJW
 EX10Et3W76E2ARnL05LBJBomnOeQBbtdxAWiuPu0r+VLsm5Shd/Ges/gvYZ34OKeXJwP
 TO8jufK5UsDnExVxaC8p5PIwcvVrzfefE6cteOc9VYaUkZM50pMztGldNcqRl9uvk7vD
 QVKnjonNLFn1m8eF2CrWFeyQ/C9QixVJZAcdX1br2hnGAqEH3sjzowS7yTRAQbIHp7vP
 HIQxqJVT8uZLUGI0XNw9Y37ztyqfpAJl8DHFlPhqU2x8rKtVipmyzhUqEYJO91CRHBry
 lw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780070166; x=1780674966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ksGpgyBSOY6krVRLLbP0F0NC4KXp/RG/saaAZ0uBhZk=;
 b=OIsQArv+YRferYal1qS6OYU7RdPu2r6Xu28xRiqhKav21Lb9raYS0ZeRcnXkh5Q8RL
 tvrvdX7G6xGVk5v5HdUhlWyvLdKLTx/rlwIHG11Rt4vdOQNrA/y1bcj1etZQYcse94U4
 XnOyXDZridnNV3h3m9WB5cdn9AOWX3AmSItFaqloaukiLhMeOb46O/V5AiBaeFV+rATH
 GPNe9b7wl98HUgD+dCkIG48mnymDZLXonHC1w4YpHQ3ok6CnOJSOB78q3E6PYLzprmOJ
 twvtOwArhNpiyHpYFBOqwC6lSOFFgeM3+UA2jrVgfGS936uS9qS3zAU/+5qSMKS9deFV
 jUZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9GQq1tTuY7cLa2bcmGf/Ywx1KsUQWnDAJ7duTf5oYxNLeJo8TOz5CK7+QMeGjbCF4TpnLxS/I7ySk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5oDor9WoNKogxn8guWg3ZWrkQQ+sk5Sj29+UsET7sxeU05YJi
 JdfETwv/ORlMRo2GcmPcmB8gJy+UWDAWyPdsDDJxxZxdv0+kj1TUPcvV
X-Gm-Gg: Acq92OELnpsSaqG5FHk0i2Ie7EqH4alSTI5uTFV7U9GovmmPrFH77N4N85sHGRhYQLQ
 lAOcTxsj2Zw5hji+AqK3ukm4d0HAFXlXW+p85VUOOKEEZ3djyApIKtaryUSb5shuiViNcUSRq3M
 zy54VhNTbDJEprcJvTB6PR+JY7iEn2L4hZyrnS++vxztAdIjhr83T8jegTli/SQu0rPECJgl3pB
 B8WqaMmpvBQFexx50oHC0yqxKsz99J+TYOtck79dBJ20quVg8cAPRqQ+Ob4rqCoefY1ccILQR5U
 vLiPHXu8wtCcVFUecPbYei//hWXRFbdK4Si1VIuoTkjdI8YII1eUDuWTwOGJNbhOXptUL7kAgaY
 J6HaZ28OO/bi7xzCMLk6ydEnBWnLTGjio6o9qUHjKlWpdXWOANAZ9jeV6ZKWUQRLLGz7EbTqs8Q
 iGy143k1MdGDCroT18X5hzD3gh6ef95OjmNwVu9VX5m/5w0LdsIadtwZGxdB6rgDQ/o8N+5SZ6N
 ESIReJLEpuw+ISLUA1i8rlTMSp2CvJDKvEoec4G
X-Received: by 2002:a05:600c:1988:b0:490:9d1b:201f with SMTP id
 5b1f17b1804b1-490a294d4b0mr2703635e9.32.1780070165977; 
 Fri, 29 May 2026 08:56:05 -0700 (PDT)
Received: from debian.tailb81abf.ts.net
 (2a01cb09e0354cc878d00097536575e1.ipv6.abo.wanadoo.fr.
 [2a01:cb09:e035:4cc8:78d0:97:5365:75e1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909cabfd6esm55150315e9.15.2026.05.29.08.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 08:56:05 -0700 (PDT)
From: MidG971 <midgy971@gmail.com>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Midgy BALON <midgy971@gmail.com>
Subject: [PATCH v2 2/4] dt-bindings: npu: rockchip,
 rk3588-rknn-core: Add RK3568 support
Date: Fri, 29 May 2026 17:58:22 +0200
Message-Id: <20260529155824.3099831-3-midgy971@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260529155824.3099831-1-midgy971@gmail.com>
References: <20260529155824.3099831-1-midgy971@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 30 May 2026 05:55:09 +0000
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

From: Midgy BALON <midgy971@gmail.com>

Add rockchip,rk3568-rknn-core to the compatible enum, document the
new rockchip,pmu phandle that RK3568 needs for the NPU NOC bus de-idle
sequence, and make sram-supply only required on RK3588 (RK3568 has no
NPU SRAM rail).

The driver supports both RK3568 and RK3588 RKNN cores; the binding now
documents both. The rockchip,pmu phandle is consumed by the driver to
issue PMU register writes (BUS_IDLE_SFTCON0, NOC_AUTO_CON0,
PWR_GATE_SFTCON, BUS_IDLE_ST) on RK3568 only.

Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 .../npu/rockchip,rk3588-rknn-core.yaml         | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
index caca2a490..6582a0c5c 100644
--- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
+++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.yaml
@@ -21,6 +21,7 @@ properties:
 
   compatible:
     enum:
+      - rockchip,rk3568-rknn-core
       - rockchip,rk3588-rknn-core
 
   reg:
@@ -50,6 +51,13 @@ properties:
 
   npu-supply: true
 
+  rockchip,pmu:
+    : /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the Rockchip PMU syscon node.  Required on RK3568 to
+      perform the NPU NOC bus de-idle sequence via PMU registers before
+      the hardware can be accessed.
+
   power-domains:
     maxItems: 1
 
@@ -75,7 +83,15 @@ required:
   - resets
   - reset-names
   - npu-supply
-  - sram-supply
+
+if:
+  properties:
+    compatible:
+      contains:
+        const: rockchip,rk3588-rknn-core
+then:
+  required:
+    - sram-supply
 
 additionalProperties: false
 
-- 
2.39.5

