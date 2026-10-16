Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC21CCA46C
	for <dri-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:07:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C59971128C9;
	Fri, 16 Oct 2026 16:07:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E871F1128D5;
 Fri, 16 Oct 2026 16:07:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E3B942E71;
 Fri, 16 Oct 2026 16:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EC51F000C5;
 Fri, 16 Oct 2026 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792166823;
 bh=OruC+xVMUOjeQ0CCeCTlrwXSIelR6KAByPpIlRqyTfk=;
 h=From:To:Cc:Subject:Date;
 b=nvN/Wjbo5/6SUmUglC+oaP9HXTRyaQEx6EkhnKmEZc916Ohdgbyh63cA1IL+hyWwQ
 /I8vZpAU1qsb2NZcWq0rczGwe/cnY0xA2eQAGCJgSSvno5N2zsbXYzDF91lbqMRUkJ
 labZHPSKPsl1bpf4Q2UxA6bBGrHFzqYJZKMSmRhPrHTiwevwNrfW5Sg0c/NBsiwwTD
 /PMEG1kiMTjJhlSSbb0Pf0EqVRRNNyQgsgF4vLH2y+k7aBjQF3z691/iswQf1NWlzV
 xcuMRYTUeb5BkfBbfc9FCCWmjijS86ZCzj2NoS/oXlcvUUbuCYay82GhN4OvmrOA7E
 R+AKrhnfLmSMg==
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
Subject: [PATCH v2 0/6] Keep the fuse clock enabled while the Tegra GPU is
 powered
Date: Fri, 16 Oct 2026 12:06:53 -0400
Message-ID: <20261016160700.3831336-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Since the GPU on the Jetson TX1 was enabled in its device tree, nouveau
often fails to bring up the GM20B: BOOT_0 reads back garbage, PRI reads
time out, or the first register reads stall until an SError. The GPU needs
the fuse clock running while it is powered, but nothing keeps that clock
enabled: the Tegra fuse driver only turns it on around its own fuse reads.

This series describes the fuse clock in the GPU device tree nodes and has
nouveau keep it enabled from before the GPU rail is turned on until after
it is turned off. Patch 1 makes the fuse clock required by the binding and
lists the exact clocks for each GPU. Patches 2-5 add it to the Tegra124,
Tegra132, Tegra186 and Tegra210 device trees; Tegra194 already has it.
Patch 6 makes nouveau use it.

nouveau keeps treating the fuse clock as optional, so device trees that
lack it continue to work as before.

On eight Jetson TX1 devkits, the GPU failed to come up in 27 of 109 boots
without the fix and in 11 of 291 with it; patch 6 has the details. Aaron
Kling reported that a Jetson Nano that almost never loaded nouveau did so
on 3 of 3 boots with v1. The Tegra124, Tegra132 and Tegra186 device tree
changes have only been checked with dtbs_check.

Changes in v2:
- 1/6: List the exact clocks for each GPU, so that "fuse" cannot appear
  twice, and make the fuse clock required (Thierry).
- 2/6, 3/6, 4/6: New. Add the fuse clock to the Tegra124, Tegra132 and
  Tegra186 GPUs as well (Thierry).
- 5/6: Add a Fixes: tag, as the nouveau fix depends on it.
- 6/6: Disable the fuse clock on power down even if disabling the
  regulator fails (sashiko).

v1: https://lore.kernel.org/r/20261013145210.103565-1-sashal@kernel.org

Sasha Levin (6):
  dt-bindings: gpu: nvidia,gk20a: Require the fuse clock
  ARM: tegra: Add the fuse clock to the Tegra124 GPU
  arm64: tegra: Add the fuse clock to the Tegra132 GPU
  arm64: tegra: Add the fuse clock to the Tegra186 GPU
  arm64: tegra: Add the fuse clock to the Tegra210 GPU
  drm/nouveau/tegra: Keep the fuse clock enabled while the GPU is
    powered

 .../devicetree/bindings/gpu/nvidia,gk20a.yaml | 52 ++++++++++++++-----
 arch/arm/boot/dts/nvidia/tegra124.dtsi        |  5 +-
 arch/arm64/boot/dts/nvidia/tegra132.dtsi      |  5 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi      |  5 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  5 +-
 .../gpu/drm/nouveau/include/nvkm/core/tegra.h |  1 +
 .../drm/nouveau/nvkm/engine/device/tegra.c    | 22 +++++---
 7 files changed, 69 insertions(+), 26 deletions(-)


base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56
-- 
2.53.0

