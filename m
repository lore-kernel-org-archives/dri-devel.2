Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD4606A331
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=stEUFMN+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EACBF112C88;
	Fri,  6 Nov 2026 09:19:22 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E3E810E295
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:07:16 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so16925205e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793909235; x=1794514035; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZwrKsB6tOpT/G+EQ3qCbOkWdsaYoyG0ZDwls387/DiQ=;
 b=stEUFMN+NpetEHNpPGnTwbwz6zYlGIsN5J5DkWmOPsYZDzJTeNLY2HI0EsqVP/NjU+
 CQ9IjAS2vxoIWxpA0e96R+BtvxKGDHGRtRvFPvg8yjltnBP1+O67f2wX+UK9joae4q/S
 YD7oTeGmA89R5o8I+Axb6YJaVk6IxerOx+7IwjIkzzF1TjgGSLhWFCNFz8k8SDiVZ4A2
 Xl7nX//sbSYzT1+SOKAhsm2Bu81LhvY1KXsP1zkktSuU/ni3DjrnKsfrKmmZgmNDkd/R
 51D5GRbpplEp4UyWxqDVDIS6TfPgFq8A3N0y4+ya/iVZkuxocqJqzPq64xF2I0jKGVf/
 w3Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793909235; x=1794514035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZwrKsB6tOpT/G+EQ3qCbOkWdsaYoyG0ZDwls387/DiQ=;
 b=xN92v5cq+meELCTPh1pakys5rThmQS07n1FcYhTkcxXW2IEs/a+PoWgS4mJjtOW6Yn
 oBF8DsaP9Lt+Qmkfz33Zgen3zf8Hyc/Yb+NlMeLtDd4r6Q251axkSgtDr5jCqnTLzamZ
 nhm8qpab4s5CmtTAdWig+d0UbBRhYmcnapoFXXwEKoCD3TUP+1sPHim2CoNNWQvddKH7
 PaSxZ7Q/QePgaPGeVtPD0i6WszrdSCROG9ambrQ9NF6QMirOV6cWhp1Thkn0WIzzeL3r
 zqHth1BoMk119IWtD242TaUmEFzGM/bJIAkjldw+vqOhQPMx/3fN70ewewWLx+Qy1Krm
 0TfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3GkPv2kYv2MBkCPI1DOC6VmFW1ZAe2aAc/muJrc2kSv0fLNkl7gOygGmqjAtILPYl/y9//yOFv+k=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2aGhQV7Ns/dgDbrx+zNA0jZR8sB/NICjmm8zntglKL/quzCdR
 UVOb3gvYPesHPBnx93eD5zfD9QPOif31+KWYBj+cpdo0PJMPiLzoi9/6
X-Gm-Gg: AYBFou0F9HYfpDgniSmVdr+8/2VilccpxSzXYVML29sNQnxBC5gTClPWGZCvt+Swqf3
 CE8psf+GTHKZMvM95spYkuRNHX8gm2bVbB8AsbxlmVJ46XcQYqLoyHEFVMglOXHxWMwKQ7jdNq3
 qEltXXbgPo58TIgPuvlepW9HbSvKhIJ5IByKYPZRi0dHxKXrghH2VGL0Mk9i3kSkoXvkmj50g68
 j/v/x5w2MBwutAGxZdC4SQzaBTUF9z6vsJ3EQ7xs3uXxaqtMjmb/JNxTT4o08y93utw52eOlXw9
 bowwl08A2z5a6SpMEnQW7UEWhoMkVHnGvKORpGZzAx1Z11VckjbZb7JrpxUpCX5ihUkE7CiWWmQ
 BqjX4hPDdqcMHN7oU0JGIkMa6c3nngcUcbe4RdxvNq3GOL/4OHcyYaM/aPfivFsUJrr94fAlEvb
 6KqQLv88aDCeK4L/oH/0mAdSsFLDTHF2/sxF4hZ2wy9JlV71d678egiOrloYC5OTKjYXDW/6BQw
 sGEX0MvgdglmJRayx/pdqsPLJybe7BNhedEwMgcT9PuCNhC708A6rIikbXslMThhXMr/WfsOlOC
 seDdyUD2hj4sLGDVrZZcOPwg6aWkVNT6D94mI407VSnKfSEh7SxvNWPBwws=
X-Received: by 2002:a05:600c:6387:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4b6de1c6450mr3686705e9.19.1793909234959; 
 Thu, 05 Nov 2026 12:07:14 -0800 (PST)
Received: from antoniarch (78-212-29-45.subs.proxad.net. [78.212.29.45])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b433ebd278sm131671835e9.3.2026.11.05.12.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:07:14 -0800 (PST)
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
Subject: [PATCH 1/3] dt-bindings: i2c: ti,omap4-i2c: Add DMA properties
Date: Thu,  5 Nov 2026 21:05:52 +0100
Message-ID: <20261105200556.34240-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105200556.34240-2-apokusinski01@gmail.com>
References: <20261105200556.34240-2-apokusinski01@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 06 Nov 2026 09:18:40 +0000
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
2.56.0

