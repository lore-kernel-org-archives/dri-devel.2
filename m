Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB78FCC6B38
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:07:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED7BA11290A;
	Fri, 16 Oct 2026 16:07:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE72112891;
 Fri, 16 Oct 2026 16:07:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC6F560219;
 Fri, 16 Oct 2026 16:07:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E99E1F000CB;
 Fri, 16 Oct 2026 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792166828;
 bh=sqd/v2ur0Dtc6p+7LVSgvGm/XLcvXx5qFoeVZPkfvmg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=COVDp2W7VFw1tqs3UT2/aPQ2P12Nh9GJyP0MPHtbjdgxSx/j9JIL0VqxHmdLqEW3o
 +Q6YatdZs3oQkDvoRILmeu5ASyQCMYsSFSg2r3Kxp/ANLsaNrOhXoCX3yS8x9CXP5e
 Z2GeyBJYAOi56ov3qkgvdyRIuUDPtBbWTf5vL1FAhHlC3gCL6K42/aFyBILf/jiK3y
 +2f8BWqt5G9/N77w46ojwUTMdY7Of/F2CejVGZh1Ub/Uwd6d/iw9T6sk4OTqQloNxT
 Qt7Oi2gZ/mOIj1ctdmfCbiRXbeYJh47lMh40q9bAAZfpTn7nSrN59Nw8U2roHGYAuJ
 tdCo89xQa8W8g==
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
Subject: [PATCH v2 2/6] ARM: tegra: Add the fuse clock to the Tegra124 GPU
Date: Fri, 16 Oct 2026 12:06:55 -0400
Message-ID: <20261016160700.3831336-3-sashal@kernel.org>
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
Tegra124 is expected to have the same requirement. Describe the fuse
clock so that the GPU driver can keep it enabled.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nvidia/tegra124.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra124.dtsi b/arch/arm/boot/dts/nvidia/tegra124.dtsi
index ce4efa1de509b..002acc7357238 100644
--- a/arch/arm/boot/dts/nvidia/tegra124.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra124.dtsi
@@ -327,8 +327,9 @@ gpu@57000000 {
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
 
-- 
2.53.0

