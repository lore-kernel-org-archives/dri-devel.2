Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8216C60A261F
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOsp0udw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7854112CAE;
	Fri, 20 Nov 2026 19:00:01 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8278D112CA7
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:59:49 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c4cac7a7d3cso191910266b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795201188; x=1795805988; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jeNmj5ZEc17RCrEqMZFDITOByu/mJAzOv4t4PwqFZds=;
 b=gOsp0udwhwYT6oKT9hCupHnDSt2eiDbWFdgTGLeR1Xn+amkV5GyPMCCOJLiWVrpKGK
 yjiMyY9mDi/eQVet1Z3n4BoOYnOupZb1yeayHSdKv5M8G8uVr5/Dmojvx+X3hLOrAZXL
 OBvTVd4f8FWG53EVGY55hkVD+SdUyu4ba550L+e8gXpv/SLTcL2tmUbw9BqSiV2bh+60
 vMC5ENO71SBMSObF1duDGtItHUWsrajNaeTcan5l/09q56ESL2c+phMAwchpxX9vAZJU
 k8K74g33PWkAaWVrnH4gfa7RDjbF1Sff/uO7dsJwYqqezxpFrDLS8l5Y8nN3CuHsd1YU
 At8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795201188; x=1795805988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jeNmj5ZEc17RCrEqMZFDITOByu/mJAzOv4t4PwqFZds=;
 b=MHtC+YKistgv10imYqQc3PiXUXRYeDMm0HDoMkQBXdSSGam2sxfW2lHe53BUnIPGmh
 hwb9VtyI6OKwuE4UonMCEOVEb/QuUuVdcIu0QbWTAD1nzfe8fii6d7VI6t3yP5rmWEpV
 PkCjPZ3bC1MJ2oj4PKOL8SDdf9g0XXSQsmnAdP5bdwscgVfapd0ZI0Hpv+Cz5YYvD6Gc
 n33Brk9piEDxMrpgTpNNH7uBK8tAYGIS8dmrEB6Pjk+lnbj9pb01fpcgminC+y+Mj4yb
 HngtSe7A2F8Z/2DjtL0F0LJm8iOXRZLN5dqUdE0UK6qm4QyRl+zI408lbzgodGXakVtK
 QbBQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEmfCe/9v1sLqVCMLlyAETP//QU8zVFVAq63yYwfbCeohguYn1WYJrgyKaTSNua3ZmDpbiGx0gSS2U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9JHUwYH7CUcpEbRrzNI/P6WuxV0ls8Ky27esQwPvG/LiJZOxPA
 4B1eGq9eLoYLKCi/VSKiVi6QRo5uTtuRthmaiejviXNMbkzUcfwbseyuClmaFtqp
X-Gm-Gg: AZFdTZfT0gnEpkf8iCuhOsFSREfh4Jg9u4Guwm7t4brvtu95cN5UiOwLbdfycVwy55P
 iFr2Ve/KRzZQTaf630ySNl/Q19zTQfrL5iodOdkq6NmBJFPfyb7blBMjZW21yRt6U4Z3pPRE+Ib
 +noqa7i9SlKCfgVstlcoSI5RY6cTmS8+XJV9qbStTfZPP7fnl95ehqz3sP6ngQZajAY7YPJpeqC
 XOAgS2UbvcJDi5UkQNakHqdMHlWtD9Oe0cFPhH8NwNlo544iamFK+263mT50/Jw7hzvoA/TjrvZ
 Wbs8UeHetF1zVVkg12MQpcJ9FuDSUUVaPEQO/raTySgFN5RcvOGuw5REveri21pc9a2V9ptoTw+
 AHxLiwkIibvgp0TCHg/b3olxjBFvO6dOWolmPSOZo3CdNAoLp6FYPSVDdY0eJ1vRpvJl9SrQrVp
 Jyw89+CJNI/JNEq1kivlNzGpRt/sJ7mrEdOg01qkEumoSTtDta2P7mwc5l8ULkZj83Mq0Iq9T+P
 5Ge3wuPaFKRkqaeK0ihXHUZierDG97AqM20/MMVz4nsY+nQjNax2AoPF8XygDxoHkl0XbU/lXW5
 29cl+Wm9wlyLmpa6rE3mxFjjk+b4XzksfQmGIYYygZz5jqAEn7tEyUJlQWYzzA==
X-Received: by 2002:a17:907:a890:b0:c2d:c739:30e1 with SMTP id
 a640c23a62f3a-c513ab14a58mr450503366b.32.1795201187683; 
 Fri, 20 Nov 2026 10:59:47 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:59:47 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: vigneshr@ti.com, andi.shyti@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, aaro.koskinen@iki.fi,
 andreas@kemnade.info, khilman@baylibre.com, rogerq@kernel.org,
 tony@atomide.com, jmkrzyszt@gmail.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com, phasta@kernel.org
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Fri, 20 Nov 2026 19:59:11 +0100
Message-ID: <20261120185915.150228-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261120185915.150228-1-apokusinski01@gmail.com>
References: <20261120185915.150228-1-apokusinski01@gmail.com>
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

