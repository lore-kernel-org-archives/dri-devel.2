Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F39CCCF2C2
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:07:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BC7511290D;
	Fri, 16 Oct 2026 16:07:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B38381128E8;
 Fri, 16 Oct 2026 16:07:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2EC3F60202;
 Fri, 16 Oct 2026 16:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B691F000C5;
 Fri, 16 Oct 2026 16:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792166830;
 bh=HoQcf7n8Q8ynNDAuwTEGdl/f27l9+9gdRy/4HNnkOVc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=F/Epq7AM1gSU+en4YO89dvsAJYKFrWxlTyCrAOyJJiNbc6OeZ/X2SNmQ6iYSi2onm
 esSIfTLvS62+8UY9Onu8T823en0EK/29yiaTsTsoMI+TLTYvWyBuDVaYHh7O01yhOI
 v1BiekT1LXDDQ/pyrQUP1EOKhUPfNJVqn94Cu/OK3GxoEE4EXOAbWYX6XEn/fGKyNa
 bqbZ6ixFMf2tSJp0cGSBK92yXZTxYsj4HQLcclbpoIyHRP5coDVgRix7KAo3gKyXb7
 /JDuuI+tLr0uybOzpo0YIu8Acp3Okj+YoNNpWQ4zGiwCsjxongmJGMm5rKTDXHHi4/
 Ul4ClICsVsldQ==
From: Sasha Levin <sashal@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Aaron Kling <webgeek1234@gmail.com>, Diogo Ivo <diogo.ivo@bootlin.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: tegra: Add the fuse clock to the Tegra132 GPU
Date: Fri, 16 Oct 2026 12:06:56 -0400
Message-ID: <20261016160700.3831336-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016160700.3831336-1-sashal@kernel.org>
References: <20261016160700.3831336-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The GPU needs the fuse clock running while it is powered: the GM20B
on Tegra210 often fails to initialize without it, and the GK20A on
Tegra132 is expected to have the same requirement. Describe the fuse
clock so that the GPU driver can keep it enabled.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/nvidia/tegra132.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
index 26cd11a8a4a12..30f0d87aa70c2 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
@@ -195,8 +195,9 @@ gpu@57000000 {
 			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "stall", "nonstall";
 		clocks = <&tegra_car TEGRA124_CLK_GPU>,
-			 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
-		clock-names = "gpu", "pwr";
+			 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>,
+			 <&tegra_car TEGRA124_CLK_FUSE>;
+		clock-names = "gpu", "pwr", "fuse";
 		resets = <&tegra_car 184>;
 		reset-names = "gpu";
 		status = "disabled";
-- 
2.53.0

