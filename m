Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482B9FF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A224510E67C;
	Mon, 27 Apr 2026 10:05:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lk4CtEEc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C9D210E67C
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:05:12 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id CA23760145;
 Mon, 27 Apr 2026 10:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03ECCC19425;
 Mon, 27 Apr 2026 10:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777284311;
 bh=QrWsEYCgvit+VBFvtOpAUWKb/WljKu24XitkfaEkIP0=;
 h=From:Subject:Date:To:Cc:From;
 b=lk4CtEEcFWELuw0QjsSjwksKgZXgGMmo5H3RKhrIYTqDYmQ7J1GUvCeiui5lu/yLB
 qPsGMOz2fl07xUN6ItRzmWnML+tX8SfoV89rp7mT+zC7gyocsLTwWYDpsuH0Y66FIm
 CRVZhB6yVI96szbGO/R7RPDZNuHS9DfCV+vqhVbAn545r4d9ge7OBNQhVsNxmbAv46
 ocTdT0GQU2bm5kmJ/bynS3INCko+ABZ8cL9xcCN1hTsNUQJM+ssrxqnZq5zme59XUu
 FeApvdBfGSmZchOyh1NBFEBt3U0Bu9hpn+mUqWSECr/lqPTRdH37cmq0tz8BGBFzpp
 mo09doyqNS/4w==
From: Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v5 0/4] dma-buf: heaps: Turn heaps into modules
Date: Mon, 27 Apr 2026 12:04:56 +0200
Message-Id: <20260427-dma-buf-heaps-as-modules-v5-0-b6f5678feefc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43RzW7CMAwH8Fepcp6R81FCOe09EIc0cWk02rCkj
 TYh3n0pHMaEVO34t+yfI+fKEkVPie2rK4uUffJhLKF+q5jtzXgi8K5kJlBsUYga3GCgnTvoyVw
 SmARDcPOZEnCUqpVkm04YVsYvkTr/dacPx5J7n6YQv++bMl+q/0AzBwTBsSldBht07x8URzpvQ
 jyxRc3iWdIrkiiSqpUh0oRba18k+StJlCuSXN6kpFI7LqxG/SKpJ0nyFUkVifiuc6ZGpXjzR7o
 9jhjpcy7fMj0uyVqTCGwYBj/tq6w3HKLlpfn2A/ugDIfLAQAA
X-Change-ID: 20260225-dma-buf-heaps-as-modules-1034b3ec9f2a
To: Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2302; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QrWsEYCgvit+VBFvtOpAUWKb/WljKu24XitkfaEkIP0=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDJnvTU6f41bqdb5efztwhWDBwUazN7/spvtsSbRMtf2R2
 6lznXlbx1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZhIhTJjrZSA/NdN/NzVh85W
 l3SrTOtuNTzu96B3xokAc9ugnYK80QYfGVPmmh8LkdUquGlYfj+ZsWF5RPHs+IAP7QocbLEO7Mc
 1kl5xvz0vqnPmr5nMNN6K9Wfrn7zfNIP3x7MfZ+bZcN/UtwEA
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

Hi,

The recent introduction of heaps in the optee driver [1] made possible
the creation of heaps as modules.

It's generally a good idea if possible, including for the already
existing system and CMA heaps.

The system one is pretty trivial, the CMA is now easy too with the
reworks we got in 7.1-r1.

Let me know what you think,
Maxime

1: https://lore.kernel.org/dri-devel/20250911135007.1275833-4-jens.wiklander@linaro.org/

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v5:
- Rebase on 7.1-rc1
- Add a patch to enable the heaps in arm64 defconfig
- Link to v4: https://lore.kernel.org/r/20260331-dma-buf-heaps-as-modules-v4-0-e18fda504419@kernel.org

Changes in v4:
- Fix compilation failure
- Rework to take into account OF_RESERVED_MEM
- Fix regression making the default CMA area disappear if not created
  through the DT
- Added some documentation and comments
- Link to v3: https://lore.kernel.org/r/20260303-dma-buf-heaps-as-modules-v3-0-24344812c707@kernel.org

Changes in v3:
- Squashed cma_get_name and cma_alloc/release patches
- Fixed typo in Export dev_get_cma_area commit title
- Fixed compilation failure with DMA_CMA but not OF_RESERVED_MEM
- Link to v2: https://lore.kernel.org/r/20260227-dma-buf-heaps-as-modules-v2-0-454aee7e06cc@kernel.org

Changes in v2:
- Collect tags
- Don't export dma_contiguous_default_area anymore, but export
  dev_get_cma_area instead
- Mentioned that heap modules can't be removed
- Link to v1: https://lore.kernel.org/r/20260225-dma-buf-heaps-as-modules-v1-0-2109225a090d@kernel.org

---
Maxime Ripard (4):
      dma-buf: heaps: Export mem_accounting parameter
      dma-buf: heaps: cma: Turn the heap into a module
      dma-buf: heaps: system: Turn the heap into a module
      arm64: defconfig: Enable dma-buf heaps

 arch/arm64/configs/defconfig        | 3 +++
 drivers/dma-buf/dma-heap.c          | 1 +
 drivers/dma-buf/heaps/Kconfig       | 4 ++--
 drivers/dma-buf/heaps/cma_heap.c    | 3 +++
 drivers/dma-buf/heaps/system_heap.c | 5 +++++
 5 files changed, 14 insertions(+), 2 deletions(-)
---
base-commit: 5e9b7d093f3f77cb0af4409559e3d139babfb443
change-id: 20260225-dma-buf-heaps-as-modules-1034b3ec9f2a

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

