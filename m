Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B0606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OG3qOW4V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F8DA10FB9A;
	Thu, 19 Nov 2026 07:48:41 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78B3410E823
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 20:53:08 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c4cdc606b47so253153466b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795035187; x=1795639987; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
 b=OG3qOW4VfnlRR4htGqribV2dKd8ZN9GkCg+0WEMfThQnOE4rBLwgdeV8d40ViTVCW7
 9OBNnaszrujKhb1NBPT/cSFOX36RAryd/OqYiPBwsH5LYaXdlBXWqoEHWA7n1sSfiu2A
 oKbZ5MD1BXeKhGmkGQWB3Trgw1xSNJb+ksbf0Y5HSB6ra1umVLpt8Pqe1HbKRjQSJXkK
 0Zs4lW9N9RulkyR323q6f3kyrjlydw/yeLsirZ4vvq2EbhOBLztMUNWVuFWJtTVEgYp7
 dkSyO/IgXROL5Pn3Bd1NzurXTJgJFB3oc+K+niaPOD8XGwhTuT1M/7iq75hnjPMe4VUr
 /jJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795035187; x=1795639987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
 b=RsNYOaF4r/qh2nNnzyguceLam6jIpSDTXxd/BYnWDDvJAaTZL2sRYaOjjQOq2pTW+k
 dXios5jQbwav+e5bs/CSQxpi4TODJJTNOYRC1anyIW6d4Bg5Z+8zFVKSqkkgdi7mzTZn
 Fd/2Z+hYV46/LTssG6YfqEP501QvUL4GukxD9HKZ1O1VhicPSDFyPOw206NFlbuhIZMH
 OZm3Lraq2A0UP9esC/xwdBgYEjRvOAOoWghDoRAR1u2KyZQ20+qgFUQXYoZEvalyhauh
 uoEHlPFVZJiWu2/vS23mFu9ZEqWat1HlhfVJ6rbdG37o6u6CHbo9tBnVAX6Tzl3B5yET
 ZGTw==
X-Forwarded-Encrypted: i=1;
 AL+hErGTou/FA5EjZm1IjPfFxypwi7/LpyVsRtTC3bTLtFM2gmYAbR0Ro/K3hFyhAqaT/3AfX6++rFPG/z0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Nzg9pqGIPt6HmQObvX7vqiQ6rYAMU0V/dNnXICp+k0uu6y6tw
 xJQ+2AEYGdM+i1zdbO0AYHwBgTiNoHLqhCS4q+iK6FR8U+TFkARzp6+z
X-Gm-Gg: AYBFou1iXmbrUr7WPrjmuafsytZp3osUmeq9pXYCGfdsK/OEKeypmljmbdqwB+i21FM
 nQHkbECFufSPEMpqy4kGSTjlL54jY+P6sH2x0WgOH96DdRY+WF+QePxvUbFwjN+bnucfbsS/sWX
 jRvAq3hO2gWTjbkLvPcTpevRJcbmXxtOX87Da0u7r1N6S3efcd+a7dNHS5riWkt/CbTKk5Tp2bW
 UF5WD2qVGRx1HzGHzrPL5spt/mxfHa6ZqKHvMHfjHfufA2DREXwWNT/kNDhOUcJBFjH6jl4XmZ1
 b/RnJ3Ua1OmX4Bqd2orJII/vd9Bwm1GBsGrLhWcpUqtNL7zVdO2JwgyO9rsQAfd9CpwO0Xu5zqV
 QjldOhkGegOhyWMPNOprrhq+p+pcmn8zCJloLbsJS8ETE5RdfNtDb+BsRGuDmR1WJh3kxvF7l0j
 wB95lrK4ozskcFHgML+azMeR1g4kXfPCnGpEDnsCA9LMtRSggVgYvCP6bfAVelIdggk0qym3IkL
 gNhojurIcxsWSRfbCazV67pY1Ism7MO6W78TPBXG70ILLWY9ZY098C1ez5zs3vsimyV3z1fTWiq
 pATvWmiA9PVM422zFW8/4z8uQd8q/2LqnIKqCsBOAoFlFn4fwfx3qAEE1HWoBw==
X-Received: by 2002:a17:907:6d1b:b0:c51:691:c76e with SMTP id
 a640c23a62f3a-c510e35c6camr355946066b.36.1795035186781; 
 Wed, 18 Nov 2026 12:53:06 -0800 (PST)
Received: from antoniarch (84-40-238-230.cgnat.inetia.pl. [84.40.238.230])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5123421612sm35303166b.41.2026.11.18.12.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 12:53:06 -0800 (PST)
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
Subject: [PATCH v2 2/4] ARM: dts: am33xx-l4: Add missing DMAs for I2C
 controllers
Date: Wed, 18 Nov 2026 21:52:05 +0100
Message-ID: <20261118205213.88778-3-apokusinski01@gmail.com>
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

