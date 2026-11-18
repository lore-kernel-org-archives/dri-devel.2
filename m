Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1BD606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xX9ahJ3/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A26D310FD2A;
	Thu, 19 Nov 2026 07:49:06 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E11F810E192
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:53:01 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c511cdd5a82so126688066b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795035180; x=1795639980; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
 b=xX9ahJ3//I1qP2fWFEt3zixPa1aaax+P/fzZDR1jXf5doFN0C81QzOcWgpoWHm8PAw
 RbE7zEx/qgAvDEBuCaOgj/bl2aqZARc1C/1MnW816guBeWU3/pqZvtaMOyn7xIM5gzOA
 Vd2mvCtGAz5PiyDHD3sMeMuz3u4xgIY3RoPiQmqHlLnm5mtnCTJS0p4Qnrch836eCkIq
 llGUm42ya8o4Xe8vhsYgxj0C+AgKgsaFnXP+8qf1YaJPdgX2Hnwb8Up3ERNvwq/4xjLz
 aLd3qAGYLgDz9bxUuG6TVUXp/oVpA4+zYrJaFjLiCsevoVPYU1quXGCz0jT/dmeJnGrE
 s9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795035180; x=1795639980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XRZdj8OAA5IgBUgIXtKpGdWFleIEtSggcmllPJz2aKU=;
 b=cDKjWyhla13Z/OFnnRRB/rTJfrFNu6GP2x3+RH2TvFBESXBQc7gnrI4ihzaAEsjVbL
 9ArtRpOTEUmHtY+P2ILRwBWCJfPqdr9bEBd4os+aiEZBEnPMydRNHtfrnOxBMzB8yLzn
 wxtdPhLUXoBuMKl7iwFFguwcra5auTxYbhJ78qCUUekDxqBSiVm0+WpwuWpwaGwPhnwH
 NafHT6oiHX/qZMMrpaQI7SYFLKQVBHW2g+/+xphgKE+60hsEr3zRSxAIZlSx74v5jFJQ
 z4ORdjN77qhegn+iR1LU7yoI9tApM9t4yVI9QtPj7A/TBuCQE4UzHN6ncipm2kTd+R54
 0h5w==
X-Forwarded-Encrypted: i=1;
 AL+hErHVqv1VaB8Xkvdy8mtQqMSCv9RNPeAyVKdbvF/gM4HwKuytevwXra1dykxxCE5p0t94pddPIarcVz4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9YLVxJKaUfwE/zOfUD80pXRIRwKkQ+DScf5rKOAzBG+6VxoprM
 /O5WcIyeyyAWP5sg//2jNMZ1C0y2CrN1m0nsAP+PfC5slMO2y8PGyTjI
X-Gm-Gg: AYBFou3fd9C4uKrtijJiuCo0DCE7tBLA1BwIBJFcPXiD9JIkopl8G/tbcaSwoP0iE21
 H8QxbHuimb8hGsZlcTUJnpd6547k8V+MnejunCz2f0On1mQN7KxGz8SH+/7LeslWRLeq59ZypaD
 aEvkMqUKGIiyNc/JiY2ZxEhRyqp7OMBJQPuPf1WDxNs+H9tjUaVakrTriQ3DicSv/aBL20eNo+t
 uFIoAChVM9e5qP7MqxwS/5tb5l7Hh7c/NGdqD7pngisKYCOCheKID0YQz83LNzmApwfidTIARmy
 tyVUe/X065PfZHwFiI9d+7V+FYJpwykiZGMyjYpkVHBoWA1+v4jZxK+t3brKqKFNDLcivPaCFzv
 DNBqZ63PuM7S4em13LkMEps631YYwXNBXPpIwDKpc2x+zfvRXA4qYbfOqGb+Xxz9oYAK7DNxwFk
 6GwYBJpy23atSg/Yad8SZ+yMq1Wv9t1/Qa4136mRqLXU1QsOzYE+nh2i91POy+T1P83AyUo47Jz
 oHIx2tpi8GM+/4S2tSQ3aWKr0fVnUBg2mwq0pen2mN2HpqVT+PMDbtTcW2F244WZjLyEjUrISIo
 U9dvxfFTkOg8ipjeeOsmr71l8O9TC9DC4yBoYQ3CWQAfKgK/pzEmt7c1yF16aGH1WrmWRCTc28P
 tnRgsVFE=
X-Received: by 2002:a17:907:6d1f:b0:c46:8b87:c1f4 with SMTP id
 a640c23a62f3a-c510e2d4ee1mr357637066b.20.1795035180171; 
 Wed, 18 Nov 2026 12:53:00 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.52.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:52:59 -0800 (PST)
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
Subject: [PATCH v2 1/4] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Wed, 18 Nov 2026 21:52:04 +0100
Message-ID: <20261118205213.88778-2-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118205213.88778-1-apokusinski01@gmail.com>
References: <20261118205213.88778-1-apokusinski01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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

