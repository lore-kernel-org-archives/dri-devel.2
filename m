Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36223FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:05:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C73910E681;
	Mon, 27 Apr 2026 10:05:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="p5Y3aQ6H";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8298F10E67F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:05:24 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 08AF76014C;
 Mon, 27 Apr 2026 10:05:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6142DC2BCB4;
 Mon, 27 Apr 2026 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777284323;
 bh=SVndXsE+vJSoc4y2vve+10Txah65FmuiC7sQ9fs8HE8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=p5Y3aQ6H388MRcQSXsJOmzF+Zbin0sXYZZt7q8zabS8xAXmcb1ohs9LMpzgKpVp2z
 4GYNFwHort4UgTH+gH6ZhYr7trtai120IYj6dwt75PRg0KR8NWZbQTf2aJVxJ30ST2
 DJPELv7KL2MffykRgEABtrzjEJIWQNxwgb0HFNYOyOZh4Ej9a3bCBgJzubQnHA173H
 wOiEi8h356an+RTQ6pnAohok8pH999HcFEyTGpFDlIJWgqTS7GoYDh4PMsy38fjEFb
 DIot8Y6VNuUkjwZFs1z6DJM0Jcn3cLYc9g97CS1RNfbYNADVHZrmFBdGei0KyZrw5q
 bovyz6vkxKlBQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 27 Apr 2026 12:05:00 +0200
Subject: [PATCH v5 4/4] arm64: defconfig: Enable dma-buf heaps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-dma-buf-heaps-as-modules-v5-4-b6f5678feefc@kernel.org>
References: <20260427-dma-buf-heaps-as-modules-v5-0-b6f5678feefc@kernel.org>
In-Reply-To: <20260427-dma-buf-heaps-as-modules-v5-0-b6f5678feefc@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=mripard@kernel.org;
 h=from:subject:message-id; bh=SVndXsE+vJSoc4y2vve+10Txah65FmuiC7sQ9fs8HE8=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnvTa7kWk5615wvcTb0/pRpj5dwVL3MeMGr63RFIeF67
 ATGk+XlHVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAi8f8ZG267Jr6UuCmx/qjX
 4eIlm+R55sVfTElyqVq48FLK2ZM/Dx+p/C647KLZ6ou6j1e+P1r15D5jJePy+fypp/cvt/oQlOZ
 cJVWpkMX9/82/0EX7lz9gsFl/Us58XuXPirkFmRtZzj7u15FhAQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Now that the system and CMA heaps can be built as modules, enable both
as modules in the arm64 defconfig.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d905a0777f93..f33193b50e6b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1409,10 +1409,13 @@ CONFIG_RCAR_DMAC=y
 CONFIG_RENESAS_USB_DMAC=m
 CONFIG_RZ_DMAC=y
 CONFIG_TI_K3_UDMA=y
 CONFIG_TI_K3_UDMA_GLUE_LAYER=y
 CONFIG_STM32_DMA3=m
+CONFIG_DMABUF_HEAPS=y
+CONFIG_DMABUF_HEAPS_SYSTEM=m
+CONFIG_DMABUF_HEAPS_CMA=m
 CONFIG_VFIO=y
 CONFIG_VFIO_PCI=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_MMIO=y

-- 
2.53.0

