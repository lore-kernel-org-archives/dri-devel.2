Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AD2606A327
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VzKmglWb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2127F10FB9E;
	Wed, 25 Nov 2026 11:27:12 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20FCB10FB9A
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:26:39 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6ae305e3bd9so9536806a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605997; x=1796210797; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HMJ+dwPb/3PV0iTHWqAgN85Hf/aWfKjSW+f/zVf9g0U=;
 b=VzKmglWb1DbH7PxNSFVcTaVpPPu9eyLgwQt9O2HjCyTUoN8c3zmbk64Z/+OFLUUk+w
 hny8dlL8E4FfOjbUCHbS9wsSgcIDXZ4Y+YIfigALsRLKMoYTCjsz4i3sfEz25Nu8U3Q7
 sJmBQZKv8fTO10BrFtd1mo2RU1f+HGpYqKEkmuT5AhdKHIzgQeXleiCL4rYka+ayhTgK
 zfEFfkjkm5I6HFCN3fqXibopLSWvwRAK+rjBnWbW7hmUaJ4osyshNS9ieIZ5ER00BC4N
 DMr+ysvtsthLQcpqbpZHAl6sENerGouRHtOUwlFMHWLz1ATMhJC9vMpnfM68tR208U6i
 oZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605997; x=1796210797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HMJ+dwPb/3PV0iTHWqAgN85Hf/aWfKjSW+f/zVf9g0U=;
 b=D1IiRy4r1NPXYP2KVzwB67qIwCixmj7T3eXfAnXSIItgq+zWawOjT+3W6Vbv6KUs9+
 GmHzko5Ww0y1irmzVsFtkkg31jzOtisgWso3AxIXeilopPkfnwkBef1feqhzeJ07d/xY
 ELMSUvRHXZDL3cqoFwYOp45T8Ig8s5WLLY3IltkRuZSKOp1oc0IjAQIBhIZSR7ovguKT
 kCfcaAn8YSmAReDf7tHyDiYM8G8Xha0jSK2+pivn4yiaj6olsIZay0JyKcZSS3B+cADs
 gg/MaAAqpMqDRfZmjnbKNhA0TPqCXSVHwXlhzBS4BTGoH9colVWm55VYZKs0IJbFIH/c
 RfQg==
X-Forwarded-Encrypted: i=1;
 AL+hErFYixUWFFYMTIFhTuDai5U1Nkl1vMwRGwnlOFPCi2Dyyws5IIU1hJJPyVHsvrtu594lQJxDUvqTUuY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/n0m69WXVKJeBP73IWFXkCmofA/DC+Ud7zzjchQqsfrXibhQkx
 0dtPiLpFSuJ5va4BSLolcdEs+dE1uWyFK0z2PujV9p0QcPkTbNet7FSx
X-Gm-Gg: AZFdTZcvxZ8FD8jkeZajNm9IWEbdbbIpsYcm2TNIXATLhUabZHHv0V0rf8MNvbq6+8S
 UoZwB732uRIPcicOjIfiAZq5/Wp0LP6hm2M9T8qozEz7FUsZf8B8Mbj3p8GEB4dypcoJc4Geb0Y
 R5HPrUDmX2gJh6KuPISJ535ZP2J5+Q3cH6LagypKvX2bpjpld6r3lg2Qxa/XL7+WpsP2MlR+t6a
 OgJkLYyYjkwOuqUGi4VSicNVBRYuWAU7jsl+CaV9GS0J4lNyWh1/k1dpnOw+jd8TsK3K63MZwq1
 7fYMLTJKLlCFJ0a7Vo5RtPUeR+5U3fIjFfrOdJUaiBdP1CyyNDdygz1olD2JP3bwynyVjayipZX
 9xMDA3fIdTY3rdymvqvhS1IRpGh6jfisfn34E8qzPR/zcMz+zA6U2NoNNYigFFtie09oe+ydIYk
 Xsp48fiK0gPrlW19d7q7SdUaX3fTeo5wjUBAK/qu0izFXifkatAVaRUn6EguHPMpFNIbzY0nnBe
 ownoLy8Oe2HdOFBOAc8YWMoWANK9otBXRV26kOS1pENH7tRtw89CtYoHQvI6aCQlGOAWFIdFT4j
 Pu0UUI19u/zS/JPFKFUZHBa4MWhDbTvmcKxACEVztI6pTzHETmJnZVn9JziPKCvt60ZVA3Dzwy0
 1hyXDjHQI9L5yDMdVTEfmf4sfUAGrom4=
X-Received: by 2002:a05:6402:1d4f:b0:6b7:dda4:f72c with SMTP id
 4fb4d7f45d1cf-6ba729046bamr8500699a12.44.1795605997391; 
 Wed, 25 Nov 2026 03:26:37 -0800 (PST)
Received: from xeon ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6bb1b93a8efsm1202907a12.7.2026.11.25.03.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:26:36 -0800 (PST)
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
 Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 6/7] ARM: tegra: Remove fallback compatible from Tegra30 VI
 node
Date: Wed, 25 Nov 2026 13:26:12 +0200
Message-ID: <20261125112613.237333-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125112613.237333-1-clamor95@gmail.com>
References: <20261125112613.237333-1-clamor95@gmail.com>
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

