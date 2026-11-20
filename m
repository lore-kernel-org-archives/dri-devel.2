Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA160A2627
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=APKehGdJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D43A5112CAC;
	Fri, 20 Nov 2026 19:00:01 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 024A1112CAC
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 18:59:50 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c4cb6834eaaso220892166b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 10:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795201189; x=1795805989; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
 b=APKehGdJKn0GPP4W6Ljf4gs+ncA96+mDYYnb/G1PRx8SU84k8mRZf+c891GMPLbbj9
 LGe2BDAEAWt9hk3ev+iBe8Dz4ZQpDD5DoNOSzTpeqsapiFV/AZXS/F0swt61Jev4JdLy
 n/5mRkp4kIpqP5nMe009ipAZlYd9bvnoNeqcVJwH7gLJU7AnlgWWL1A8zBs/Zk6gnZW/
 IybfKQfDnZwlmCur+4FByZxPWuLwr05x8cRFBCWt8w20KV0Eo7T+zT9q6g4vLj8i4SP8
 xXoLjfu7nMqCa1WLF4T+J51L6oT/BmYq8P3FXAs6D0grlSoCwI7uHzAqoPKm0BSimTCA
 H/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795201189; x=1795805989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
 b=dr/zViJPt2Bm8V3zkZYw6SFqlE388YmEngKd+/5L4UBVDfrOqjQUAEHrN5fvuTRftg
 iRvYB8KwD8hwCVOX9Afzc58rFYBXC8FiGio1v5vAjGAfyWzvl/r0hEb9RRb5tzOaUQTs
 NwOJaXipHm66e0xCBv13i7RIMqNOU4FV0BrBRsbV035xLeUyBY5UT/yQPYIG+DvSQkIb
 uecCu9UG4MLcvY+g94+4uQHPJNtalI9ldPntlqxDX0ZblVM0tsy/UDOTCcdJs28Z0pDy
 CXOdIBfKsI/v5ABQ0sM6dfIJtjfRfGKAeTcnOgf6nmH5xtZrefO79YWROb+g3EOym96c
 osaw==
X-Forwarded-Encrypted: i=1;
 AL+hErGH2WsPaDJYqzJyz5B7FxjTAOIvgjX8g4VBbRWhmS8PemKyO0BKxLIgo85g4rzZd8Hu66CKIbjiU1I=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/uneS86fDIPL185OdNUy5Utqa4KojDyKkbxUrgURG2HSq4qxv8
 btFy19HcsMcC0GZM1WhnKkuK1aovpp/PSXnyLei6Mcy5wZ5bT8yLgmP7
X-Gm-Gg: AZFdTZdKbC0dPSBg9DrvIOUGUsQllrXMEQGGCNCgpPD48OUkThgqXyiIkUO8LA/oSqH
 tCtdt48Uoxycrka+OeLHeMGfE1/6bo3KwFlBul9WHUvMdNSkbplS2vAFm1Pq1a2YvEg/dAdJkwq
 SiGlXof3i0I1rgeiPa+8qhe+8GCkm80Fy7Pzxl4s7fClGsctUjX2UOAYvDHbtSandQ8qft4rJEw
 RzEedUAsiGvxIw0wBOI/Y8wJRpRy8N62s29ZXbpjUpIJQWxGyyjeuw88wBrywn9kkYKQSNxpFvP
 lvmI68GZNhwGtVseXILRUScCOmwJhGmmSQWeVSEoxMJwHCy0xZX/Tm6kGJbDVq3D1yr5jY6JsdL
 BNWSJs8TIJ36baYuMuXoYe7ygOrk4OASPXsTTNFue9H43lGDorQNOC4yPB0E0lZTPHAN9/FdJzh
 7v1l0x4xudc1k22jXMNSz0zxTTGB2vysJrJEnEDB6Kn+c9FE8Htl6ivjVPBRXZXyoxAK7ms8BaC
 RkbgO9hnKlbwH/qM/ZwRUoKd1xBdaKC2FqKHwC8PKL+kpA4LvZER6pLs7sW/kY39bWAjJvjIbjw
 0y4zen5O9qF4M80ufM6sk6GudmRSfdt0cLiAHbSLE1PWix4iVePGe9WBvSSJCAdYGNp5At+tq7R
 5zPrsCt8=
X-Received: by 2002:a17:906:f583:b0:c51:3c8f:55e8 with SMTP id
 a640c23a62f3a-c513c8f658dmr365847966b.46.1795201189284; 
 Fri, 20 Nov 2026 10:59:49 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513b02de1dsm125205266b.85.2026.11.20.10.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 10:59:48 -0800 (PST)
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
Subject: [PATCH v3 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C
 controllers
Date: Fri, 20 Nov 2026 19:59:12 +0100
Message-ID: <20261120185915.150228-3-apokusinski01@gmail.com>
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

The i2c0 and i2c1 controllers on AM33xx support TX and RX DMA
requests. Add the EDMA request mappings and DMA names for
both controllers.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
index 57a45609f9f5..89fb1d1eb049 100644
--- a/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi
@@ -239,6 +239,8 @@ i2c0: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <70>;
 				status = "disabled";
+				dmas = <&edma 58 0>, <&edma 59 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
@@ -1189,6 +1191,8 @@ i2c1: i2c@0 {
 				reg = <0x0 0x1000>;
 				interrupts = <71>;
 				status = "disabled";
+				dmas = <&edma 60 0>, <&edma 61 0>;
+				dma-names = "tx", "rx";
 			};
 		};
 
-- 
2.56.1

