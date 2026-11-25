Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ECD606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TlqTpC+/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 606B810FEFE;
	Wed, 25 Nov 2026 18:48:32 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3197E10FEF6
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:48:20 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c515369b627so641406966b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795632498; x=1796237298; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
 b=TlqTpC+/9xrY+NPIxFdg77Dja9TGdaRoAhDmidpFYRcN0cUeUcF2G4/M1xiSYgZ0Ti
 +7sNjTS09SUrCh4uF2PnkFIR3LJAsnmIMmMhGZAUnotmgEO8ljIYt9onEwwjvAiAGc3O
 FUdClsXTVo6OQyaoV9Yn4J2LUGdu4nrWMC5pp9uL7PiAQyX3EY/L2d43j7ohjIFKvb7q
 u07AUDtqhF4t8ev301tssXGV3fQe5O6/NT80b475SUrg1yWDSSd+NFq+WJ6Iwunzmpcr
 u3HtAapUDoMIBRqbCyVGgZxbQSmWCBXeZwaKgSZhVDusiCyG+6d9g7eh3y4xQdxSRzDh
 r19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795632498; x=1796237298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
 b=P++z5I4d2sgrFbEMu1pLm6fx/uiF/cGOMrtbKvzX4oA1dTrCWK+B1fSeSleUvqs2Hm
 J5igB1iQH/HsnbgwMoPOC2fdenRULznYGxj1SzyxACyU/Qq/m0Dt+W8bSgU5qHIiSkDw
 iBmNIfkl3PyGosPG8IQYlucUdztuvUNZeXBxk4FRFcxOT0+/A65Xd/PF7PtAm1wL5vWn
 kV5kq78N4YiPYZuSe6MEQb6rtcguGQ4oOrs0tYFyfFmCVFRWgjSgJaF2ohQ6P57upTV1
 D1ewWSh9HMoxh7EKFoc5z8h2BSLvoV1Chi3GeDr4lc8hBpNOY9K7CNSTPtpmb1Q99WD3
 PYyQ==
X-Forwarded-Encrypted: i=1;
 AL+hErG3PYX9ybLfA6VSo1rJ7q9efR5DpSIAnd93xRek8KW5+r9V+2OOMwenrt1LZnHJwsAqKsxpmDPYmio=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/wwDLqQr6ljsvDbev5sEGhNrqJhpvps24QBJ+fTks9k8uSys6p
 qMHB7GpoCeTKRRGYziuuHInvgfyjZEiaLSxlWPYhs4Um/haGhENTx4XJ
X-Gm-Gg: AZFdTZeT5Bl3K+OKfn4nXsV1cxSXO5v6KfCLezcd+5+Qy1TIe+03cdYUpOMMGLaSkrl
 OQdHKCFNfXOv5xHkex8xt4eScyxKukGgD4hdhhno2A0rMLATfDHWJIN72MqxgdJ0tgFWABum8Nl
 Uct5oFKBE74ggYgZJOvOH44aJXxO6dpcPosLuGCotKYK8HE74sWmItJc/ycd6DQOKS3MYMN2PHk
 PFXfZxop75hFQkbX0oGdk04HaRF7eumWiaC5+jDnVohO9QtAUBbaqYE882OOMMawInIvceUKhW7
 OZu0xnNkRr+vAEn4Ar8PWMw1fGoZfMP+fa6Jqh4vZkGlmWZLLeJUfdLY0QvshJiuLIS79yWfEPp
 HPT6ufV1xRBnay2rldnH64eL2/TnhXjd04UNss1/G9fyhG7xIMLe1PzltUt86TryY8P47O01Hk/
 4jti8XhN/wXqpmEZsHkhQlXSJ0dFVxnFxGeSb1fvDk5VddD+d7B7DM38PuoS2wuJ705rK/usme9
 0ljiQNxbE6PELNJMHcpKnwhFRUm0r8dlZsfo2PuZQxdHA2K7m0YgNskQE0QqsN9SBHt+q+qEgz+
 IF6ZyxgHnbkQS1/bABZqVmh9Vx6J8LvxpWhZpwDwAGVrlee85pahNAyP8QXg42CiuNlBoTK/7rz
 ug/Cs
X-Received: by 2002:a17:906:5492:b0:c51:caa:607 with SMTP id
 a640c23a62f3a-c513ab0c394mr1129231566b.19.1795632498494; 
 Wed, 25 Nov 2026 10:48:18 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:48:18 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi,
 andreas@kemnade.info, khilman@baylibre.com, rogerq@kernel.org,
 tony@atomide.com, jmkrzyszt@gmail.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org,
 Antoni Pokusinski <apokusinski01@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Wed, 25 Nov 2026 19:47:46 +0100
Message-ID: <20261125184750.57866-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125184750.57866-1-apokusinski01@gmail.com>
References: <20261125184750.57866-1-apokusinski01@gmail.com>
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

Document the TX and RX DMA request channels featured
by the OMAP I2C controller.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml        | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
index 58d32ceeacfc..ff946fdfaad3 100644
--- a/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
+++ b/Documentation/devicetree/bindings/i2c/ti,omap4-i2c.yaml
@@ -37,6 +37,16 @@ properties:
   clock-names:
     const: fck
 
+  dmas:
+    items:
+      - description: TX DMA channel phandle
+      - description: RX DMA channel phandle
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+
   power-domains: true
 
   ti,hwmods:
@@ -93,4 +103,6 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
         mux-states = <&i2c_mux 1>;
+        dmas = <&edma 58 0>, <&edma 59 0>;
+        dma-names = "tx", "rx";
     };
-- 
2.56.1

