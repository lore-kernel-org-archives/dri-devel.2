Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC785606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WL9BeSYt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E5710FEF6;
	Wed, 25 Nov 2026 18:48:32 +0000 (UTC)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8819F10FEFE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 18:48:21 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c4d5b2db4bbso1170043566b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795632500; x=1796237300; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
 b=WL9BeSYtJZtf/CGQIiMOIxtM4qF+bTvYIKSTn7hSYuf81y3ObFBO+XgHSy0aVTpZ77
 n4iWSZpURwhC1odoUexJQ8HcpASpYySLUZ26MVDWLgvG8Kp65eJrC44sekI4XH7SvE4Y
 viwgN80qSHA5aM+Tlqp6jbYjJryPOFUqKEM1uuDjI3h3lz3FumZfRQQhzI+QDFfuSe9w
 k+f5B0WPA/9px7KcVGpeVcNnkREUhz1Tv1pQ3zwMgiveAuld9yGPjxnZVtJzNF1mm/n/
 Ps2/JusKWYiDmxQ/vlsi2qbtTXIwRgAss2adwPd1FTrnZWCTye3ZBLRc56xUYLtZX7j/
 Tj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795632500; x=1796237300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HLK3d7iXciTA3gYlWpBInCkheLbOB6EwrTlus+ykLsk=;
 b=UxssGCbkrjMmxNxjEJC9A+ZT+Kz/29eAEnNCVEoZ2QbTv1dZUwyDCn/4CBZrRderCv
 M8YgEKPE7Wvv1xBenrVlU9ODukt7L1lFNF8PedQsgroFa0K5ZgGnadOuUUVT0YY/LS3L
 yDvBtEQYP0y4OAiI0HLpotjYxlECOChIWoVE7S5PmmEvaEl914zswGA9bRJqt0Wta3oC
 uGKnNG/8zIX+geW/4Od3HonHO4aqaE1oot14LYhWI7Zc13BbgPZbQ3J1JjFDqlMgisgK
 vcinPwPenfb0QtVRT75yhqccNzI1KwLYK90Vxvr5tI8bfW2Eu8ZGwl68lcrdBVV9QHU7
 5ngg==
X-Forwarded-Encrypted: i=1;
 AL+hErF02p6JUQzYAzNvgooNxpcsdCuOETxMYgQPkIbkSG7bajrKrkBlGSM4rpWsN9ajdVNwCZhw8mz/vBs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/woOH60nprN4klgxaGtnVcFEubPUNEI/nTrYXjl6XE0wdGGigE
 0sghvXJGJieBGWhAj3g8SUgCN91BvUjWNBaJ+iswmo2apsQlJTj+pXrZ
X-Gm-Gg: AZFdTZemj+A8+kgBUAZr0qAwwU03XZQsHCgsU3EeWnCETBI+DK3YUmE1sGiJAwevhnf
 A6GFkuclHQtGQhyGne+I4nHl/yXyJq3NQjOoYFibF1xemlpjuwx+kNck45hidhQVuA00sVmWefa
 m49+QIjae62egha3EygSl/92eAbOJ8HMGLb4yuo58Ymgpz8k6eFlUG5zFTaCKz6eWYkJYRPkt5T
 gCzbjAaQx9kEQCmh8kjOWQUzY392DSbF4jAD3ien2I32iL7wEqonUyOkmTC2bpXPVegy7/wHUst
 ARezyMQbiDBRXJuEXJusfOssz4w9LgoTDvIKxfDk6DcW4EtCZApC9J2Wag7K0Bqu896s/iia3QX
 TF4NOh9J3GHkU7b/XmkR6lqnX6IUQLzVcAFdleKqBqXvAFul1NrqZCEXE9sYOly437dYBNbAPws
 pWzWYZPPpfczWBvW+fUNoo94nfxNc5ieyM1upx5hK+lG8vJN/Amxm0AnZjX/dyknbZHJ+0+i0L0
 QUtCo7ITao6pGi8YJGvWldEmP3eiIxp28Gmv3tdlyN8ykNLcK/gWLdzW6Xexv6JpzhC1/4Rq3AD
 bj672XXML+aw6Kd5gSdvaq6MPlpE6CT6hNGbzeSztSMOklNOvaFJTV1jZrM=
X-Received: by 2002:a17:907:6d0b:b0:c41:1781:a2af with SMTP id
 a640c23a62f3a-c51317e3353mr1702989166b.9.1795632499856; 
 Wed, 25 Nov 2026 10:48:19 -0800 (PST)
Received: from antoniarch (84-40-239-22.cgnat.inetia.pl. [84.40.239.22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c513afc73d3sm677226666b.64.2026.11.25.10.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:48:19 -0800 (PST)
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
Subject: [PATCH v4 2/3] ARM: dts: am33xx-l4: Add missing DMAs for I2C
 controllers
Date: Wed, 25 Nov 2026 19:47:47 +0100
Message-ID: <20261125184750.57866-3-apokusinski01@gmail.com>
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

