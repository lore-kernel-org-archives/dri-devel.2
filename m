Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6B607CD30
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEgcTbPo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89E5A10EC5F;
	Fri, 13 Nov 2026 16:19:05 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E66A71126A0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 16:18:58 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so273690366b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 08:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794586737; x=1795191537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HMJ+dwPb/3PV0iTHWqAgN85Hf/aWfKjSW+f/zVf9g0U=;
 b=sEgcTbPoeCnC1aL2BDOQ7i9pxBgr/sdFcrejYOpDrH0eGRCGQWcbEUO6xGzKtQtM2Z
 REFjC8X5gq08QhqBUhYNtEMjCe9cosD6EgPdTTj5//8btQClAAc+xNl9vOgKdqHEWew0
 7DljlPTRF4BXxTtpEMHBB7hCysCgHG2xctxxoCm8fNhO+UcuyyyJ5En+jymDCwPc99A0
 OPBPkRyhqjuCCKzt6TXov54suA2vcJc193fIfBGJfmUjL6ScfYuHtTeFIHl7rf9D3G4m
 8Fr6e+sr9N2I2IzJyWPXdZ9DsYFHrkNziXDl6YTslxySFxroHKH0cEtlPjoeFEYpvEyC
 iccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586737; x=1795191537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HMJ+dwPb/3PV0iTHWqAgN85Hf/aWfKjSW+f/zVf9g0U=;
 b=SAUxIWoJ3iJDQEau6X2T9pmtADJ5dSnxNbWYzQHXROXx5xjbuHSt79hLkdYjTCfCOS
 nk20RKs6/XkAf8E+hAcN6MmPipQNu2uzzErwUGSrFqOHCve0ZVSYwAfayudbziJrYOcH
 3YGCXvQ0ML9rMHcdADP9j+HREY/m2eM2PdUXb0rQoyZ6iTq0RwdhA/fIueselaLbMZAz
 Y9YpIFc5icdQ8BAuyV6yKMUvddEF79V7jzP+DrHh40RQCyig55u4fglnS/hCMsn22m8w
 TGc7sn1YdhqFrH4ws5pvVogOToVAKwdHxSvD3mp/paOBtgmc9KXrK6IFZttJVAGYlkZE
 2uzg==
X-Forwarded-Encrypted: i=1;
 AL+hErG7Q1ZCMWv5fr3JAK9PNFNPhhTaZuVMVJiw3SeizlPPIrz4Q2udaJ9RNaMFEABwmdlaVDchytnit6M=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/gBUvh5lLYXV0EaRsX+NFETAhI2gijvLhE0HqpqlbYpuA9Bh8i
 +TF3diZgGRe6fbwKMkeGpL06KJk3JHxkU+9en7Dx8zoKni8Ox5T5TqF5enaGSA==
X-Gm-Gg: AYBFou3MfuO/7ZaT2P4FU2p704M+i9KHZIsDM5BD9IBYSagsFIkG51kHVyq7eADj1R7
 iZuyZjl3LSQs/Q1iiAINA2mebk7/N+5akg7y5faBuoP6+8EETZiRyr1ZIUx4AYkD/7DvsIZl3ga
 cuqmq6qVTA7rO53fVdpRxiZFIc3njlvo1kO8829mdZqH1d+GCvLr+RHVxqm5TZ1ZvXYHbMU4Qhc
 GIgzGxOjDgoCw4xTEDVmtXfztFDDsbvbe/8RguV4JG129kvclmKcPtyJ6iSz8H1q1VArYFidzsA
 K+5gQT2hsAlAN9lXFfkTZJDpAqfQGTkhinVdoY1ufyVsJWWWAD1Q6QhtRj1Z2LTnTbhLCkrUikV
 fS3Fw6AcYGLiGMJfaf5XQ5KgaR2BBfjxO9FPlszg09HB6yzNEVn5PRizPenXgTFT65QkmKl+QBN
 vwAzO9bXNdwzXZqqmY0MYP31xpuNQdeRKpSLuxMpiplAxw9flHFyg4FQbQDJtNUYN9AJqRp09+r
 Fjhm4j4FMygpagg1Rcxp+39+gjQ0r4escvE72Uo65zhAHHh/wSfly50zGfXFE408kiV8uYhAnFj
 QsFhE7IjMXYcl8g/xhBsCwRN1/n2bQ0iHAsPxLJUWRWozSFGaoHBvSf2HPfrMa9LBj6OGXSZeov
 JEMnI430m/sb4YksgIovvZfuWoCmvVdg=
X-Received: by 2002:a17:907:3f20:b0:c46:c3ad:e1ca with SMTP id
 a640c23a62f3a-c5096396effmr277155866b.9.1794586737209; 
 Fri, 13 Nov 2026 08:18:57 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b24b88sm122297266b.16.2026.11.13.08.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 08:18:56 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Cong Nguyen <congnt264@gmail.com>,
 Faisal Mukhtar <mukhtarfaisal03@gmail.com>,
 Dan Carpenter <error27@gmail.com>, Hungyu Lin <dennylin0707@gmail.com>,
 Hao-Qun Huang <alvinhuang0603@gmail.com>, Yury Norov <ynorov@nvidia.com>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v1 09/10] ARM: tegra: Remove fallback compatible from Tegra30
 VI node
Date: Fri, 13 Nov 2026 18:18:18 +0200
Message-ID: <20261113161819.36847-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113161819.36847-1-clamor95@gmail.com>
References: <20261113161819.36847-1-clamor95@gmail.com>
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

Tegra30 now has its own specific compatible string for the VI. Remove the
Tegra20 fallback, as it may interfere with the correct configuration of
the device.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra30.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra30.dtsi b/arch/arm/boot/dts/nvidia/tegra30.dtsi
index 1e51da329f310..e1f66240ae552 100644
--- a/arch/arm/boot/dts/nvidia/tegra30.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra30.dtsi
@@ -150,7 +150,7 @@ mpe@54040000 {
 		};
 
 		vi@54080000 {
-			compatible = "nvidia,tegra30-vi", "nvidia,tegra20-vi";
+			compatible = "nvidia,tegra30-vi";
 			reg = <0x54080000 0x00000800>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA30_CLK_VI>;
-- 
2.53.0

