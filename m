Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E86606A338
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KgV1aEOr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 588FB10FB99;
	Wed, 25 Nov 2026 11:27:01 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9750810FB93
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:26:40 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-6b87a92c17eso7907226a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795605999; x=1796210799; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mQWld2rf0aUSCLxpuKReQRUF3uIzkNsM8ey4gCHu/88=;
 b=KgV1aEOrSrgjoILd8IL5AXqoQ6gM8U7yKq6m40xlOm+5aO7XTuTNMTWQF0/Rm6MiZn
 RSOU7BD11LTce0KK36/4J8rxJ0uoDOSmxxWQV187ctTf1OQsdEFYf2WJE24yZUxRUOJO
 iGcgNsjCTx0fMCSwp5we9FJqJcVyl5C7hoVt9iveaVtabvV/te1oTRDj8vNQ60gZF33m
 Avgw59EgjQRQfb6WQCcdjeDSSVrhpDasaMgvRGMeLurkn4NYi//GViBgszO/zDgA6aqx
 AuM5sDYtGvzCuMuI/C5GKSEvfMkmsPAgewt4ADJmx3nw8TUwlj42XVIYk33c/I1yvzFP
 uqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795605999; x=1796210799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mQWld2rf0aUSCLxpuKReQRUF3uIzkNsM8ey4gCHu/88=;
 b=PCXKf9AQpsEgW8X3AeE108Yo+jiCH4nd2CDKLhiEEXq6OhBVBU1AdrwcS0PmNw0iiy
 yqABQc3QSO4DrhdLH4cioyyV9927PuBllgJSwK5RYkOjiXSEzpjEWjJdRl+I1XnltLXy
 zMxYYfvnS81QxRu8Prtz0k5sR56UfVREniclpgFzYHQ6opzXVemIV0azen3/utcNeX0P
 1ykpDoIEPKiKF++CE/6RRigyEs4f6N3pdEZBDp4fbf0YgpoxpC6Cb89OMMY6vzn5dvND
 pDtImJrBHwSerd3/Ee7/4UbiXE49jXTlL6U7AHGANfQhq+uJqdYn/6rWDD7vwN9OJFSM
 9ICg==
X-Forwarded-Encrypted: i=1;
 AL+hErFQuMzXyvCxvIPj4UDG4jzmVIkcLC8pf8q+PnUY8ihIj2DwCZJ09JENrzW7QhFmJccNfPvepzye0To=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/64RU4sukCKpLHRGTAJiwe6+602sbmvyvvz/OdouMQMV4Ws+m5
 87J+BhkL3hx2iD7E1EVmMnep2kSwdRKAnAHdj3OhUZkeDdM2PAyZwKMY
X-Gm-Gg: AZFdTZfiMUvmtZNgZRJ06fIP6L0hAof6sIzYWJ30zS3rkkDq2hVdDCAe5ocFxvioi5Q
 SE62DHdZoPsP5SXFXQ5dXEfGh/cLdD65NvuvNkKep6NyQp4XAguZLtJ7D0MyUSERaX85zx9TDt8
 /NAgYrdMcYII9o/efNMWWEHhj6/+qr5GTGaLh6R0kYd+23M+wxabwf1Zu/o+lyCIAdV1KMSaFED
 PbZ7gBiOBDdF9TIvl1E41iJuUdNgAOaMlpW/IvLPAH0dRlbKijVFgAMRJJQGwuvzL530t1iX2cF
 f2DMqAhKsWdLANANCA129j4GiU75+7x2t5WknNv4DHQVylrI/KQ9QCjZ6T93Xlo4NHK94ateMUn
 XCyeiF4bhvtGA4pveRjjYOusFOLcudcYnN2EBp2L5SAMwX70VteKr6TSnqQOGRwDZlfJq9tw1G4
 3P1bt6GE7CVWyLDAVZVBPDAjohopFybeSseT9iC9f+mQcT3up239lFVTBaIBUjLw+1gSPLYQwxW
 xyx5i9QOQueAgrzsekh9c+g5oJtDv36QtU+iVCAGtZrC6TF+S0ebbRRkS1HxJf6NMX84B5Q65Yq
 rWsO/yBku+ENZr70MyTXu5uEaIsHnF56xsFkSWYzM5NUqQalUmkvF7kb7lpstcKMO/iyBkXHVH+
 Rbr0NxaWKag==
X-Received: by 2002:a05:6402:4009:b0:6b9:c43e:19df with SMTP id
 4fb4d7f45d1cf-6ba37ed9a8bmr12269161a12.41.1795605998897; 
 Wed, 25 Nov 2026 03:26:38 -0800 (PST)
Received: from xeon ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6bb1b93a8efsm1202907a12.7.2026.11.25.03.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:26:38 -0800 (PST)
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
Subject: [PATCH v2 7/7] ARM: tegra: Add CSI node for Tegra114
Date: Wed, 25 Nov 2026 13:26:13 +0200
Message-ID: <20261125112613.237333-8-clamor95@gmail.com>
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add CSI node to Tegra114 device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 34 +++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index f2766c11ee6c3..61120658f0687 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -53,7 +53,7 @@ host1x@50000000 {
 
 		vi@54080000 {
 			compatible = "nvidia,tegra114-vi";
-			reg = <0x54080000 0x00040000>;
+			reg = <0x54080000 0x00000800>;
 			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&tegra_car TEGRA114_CLK_VI>;
 			resets = <&tegra_car 20>;
@@ -64,6 +64,38 @@ vi@54080000 {
 			iommus = <&mc TEGRA_SWGROUP_VI>;
 
 			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0x0 0x54080000 0x4000>;
+
+			csi@800 {
+				compatible = "nvidia,tegra114-csi";
+				reg = <0x800 0x200>;
+				clocks = <&tegra_car TEGRA114_CLK_CSI>,
+					 <&tegra_car TEGRA114_CLK_CSIA_PAD>,
+					 <&tegra_car TEGRA114_CLK_CSIB_PAD>,
+					 <&tegra_car TEGRA114_CLK_CILAB>,
+					 <&tegra_car TEGRA114_CLK_CILCD>,
+					 <&tegra_car TEGRA114_CLK_CILE>;
+				clock-names = "csi", "csia-pad", "csib-pad",
+					      "cilab", "cilcd", "cile";
+				power-domains = <&pd_venc>;
+
+				assigned-clocks = <&tegra_car TEGRA114_CLK_CILAB>,
+						  <&tegra_car TEGRA114_CLK_CILCD>,
+						  <&tegra_car TEGRA114_CLK_CILE>;
+				assigned-clock-parents = <&tegra_car TEGRA114_CLK_PLL_P>,
+							 <&tegra_car TEGRA114_CLK_PLL_P>,
+							 <&tegra_car TEGRA114_CLK_PLL_P>;
+				assigned-clock-rates = <102000000>, <102000000>, <102000000>;
+
+				status = "disabled";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
 		};
 
 		epp@540c0000 {
-- 
2.53.0

