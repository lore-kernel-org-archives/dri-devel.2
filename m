Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FBFCD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 06:48:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95AA210E4D8;
	Mon, 25 May 2026 06:48:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UsRfe9Jo";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA83C10E41C
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 06:47:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 69BE04340F;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3ED05C2BCB7;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779691676;
 bh=kj5kq9WD/UeIGGomDPvQJ5qz0l33I6XGMyKKg4VQXdc=;
 h=From:Subject:Date:To:Cc:Reply-To:From;
 b=UsRfe9JoPHyRpOhu0zxGGR0t97QML2dwoGLwM4dpJ8dWLCzm0m3q1kqwk6OW95e8S
 B096Rb/bSoFz31uu4JPQDf4o7ShLNqvQbGjcz3j0dPWK+GSP4FGHVxZUrXK7aw7WT1
 6bKX3n2UYWbMuGrUQSjSQdikX1YK0bI2qwF/O4KbHlLGRF14RIRGdaA8xr2c23JgXJ
 dvHAp2niUkkqCC7GdVkpiy3ZhQk4b2VjNSEt4doOgon36BbwYrttI4cpBo9tz5Ua0q
 T81REJt2CwjFSZ0IaUID/+IBQEeBsQI5V0nat4zSWwO6VqyCfRNPC9+ACCvDyaGGCp
 7qAtMPPpy/sfw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 26BACCD5BC0;
 Mon, 25 May 2026 06:47:56 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] arm64: tegra: Enable DMA Support on Tegra194 QSPI
Date: Mon, 25 May 2026 01:47:43 -0500
Message-Id: <20260525-tegra194-qspi-iommu-v2-0-a11c53f804b2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7RgKbY2uvIdhge0UJrEUW2w0h
 LtbOYDL95L//gqJIlOCS7VCpMyJw1SgOVRgxn4aCNkWhqZudK2EwoWG2IuzxGeaGTl4/0KSJLW
 UVjnroCznSI7fe/XWFR45LSF+9pMsfvZ/LwusUZ2su+vW2Nbq6+B7fhxN8NBt2/YFvaqvCLYAA
 AA=
X-Change-ID: 20260515-tegra194-qspi-iommu-e4e4644d5fdf
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Mark Brown <broonie@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 devicetree@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779691675; l=1598;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=kj5kq9WD/UeIGGomDPvQJ5qz0l33I6XGMyKKg4VQXdc=;
 b=FgtyycY/WO9UF+dLOgSpwlPMx83PaD2wpdDr/spM/8ugUqsL+0skVAlc7O0wcEJkKGlESI3Kw
 FBcCnN0pvl3BDr1dCFTbv6fFITPSScZWnGo/y30gVf/9lkMVfN50TJU
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

The reason for this is to properly support the spi nor chip on the
Jetson Xavier NX module. Prior to this, it would time out on all
transfers and sometimes even trigger a cbb fault, locking up the entire
unit. With this, reading and writing to the flash memory works as
expected.

This also fixes the tegra210-quad spi driver to properly use the dma
memory space instead of the spi controllers. Without this, enabling dma
on the controllers results in mmu faults.

The driver change has only been tested on tegra210 / p3450 and tegra194
/ p3518 as that is the only available test platforms. Tegra234 and
Tegra241 should also be verified. I have p3766 for tegra234, but the
qspi flash memory is firewalled by mb1 on all publicly available
bootloaders, and no other spi devices are part of the devkit.

---
Changes in v2:
- Drop bindings patches
- Add patch to use dma memory space instead of the spi controllers when
  dma is enabled.
- Drop iommu properties from final patch
- Link to v1: https://lore.kernel.org/r/20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com

---
Aaron Kling (2):
      spi: tegra210-quad: Allocate DMA memory for DMA engine
      arm64: tegra: Enable DMA Support on Tegra194 QSPI

 arch/arm64/boot/dts/nvidia/tegra194.dtsi |  4 ++++
 drivers/spi/spi-tegra210-quad.c          | 29 ++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 11 deletions(-)
---
base-commit: c1ecb239fa3456529a32255359fc78b69eb9d847
change-id: 20260515-tegra194-qspi-iommu-e4e4644d5fdf

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


