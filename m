Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80946C61DB9
	for <dri-devel@archiver.kernel.org>; Sun, 30 Aug 2026 19:39:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C5010E0FA;
	Sun, 30 Aug 2026 19:39:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LIAcc3TV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88E7510E0FA
 for <dri-devel@lists.freedesktop.org>; Sun, 30 Aug 2026 19:39:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9A2642D9B;
 Sun, 30 Aug 2026 19:39:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87E011F000E9;
 Sun, 30 Aug 2026 19:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788118748;
 bh=fLNwrpkdSyF5CJbc3fw4p3nVMnS/vZaro/92PCXSWU4=;
 h=From:To:Cc:Subject:Date;
 b=LIAcc3TVFroExdYUUvX+jRTjeKMNzyPvmNR3+0H7p+5ENDGGJAqfdKkJgId1MadCo
 f8wf8dZFDiM5A6nFSkr0LyRiDQi3QJp3KCzV9rjZyzRbI+WyWxYvSsot6+9urDmXHI
 rGA+PiIAYIfsTfiZ9h2yd17IGYXG0/Tvpc8RB2pFi82zUxkjhk80dQl+JgFTCleIj2
 PYTBvUsEYaUnThCBsSJ4eCiImsopS7RCT4yM5Wg/EysJa1zGNEcWnxpGS9Bz7IMhjt
 6fBFlgANTpY5KRlI6D0Aq+uesJ7VEw4ahmVPbjz6dgbSohAz+uh4aOkC/GQC005/kX
 3YewMWB0voZEg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 tamird@kernel.org, work@onurozkan.dev, mmaurer@google.com
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 0/4] rust: dma: tie DMA allocations to the device's bound
 lifetime
Date: Sun, 30 Aug 2026 21:37:12 +0200
Message-ID: <20260830193824.471089-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
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

DMA allocations carry device resources (e.g. IOMMU mappings) that must not
outlive the device's bound lifetime. Add lifetime parameters to the DMA
allocation types (Coherent, CoherentBox, CoherentHandle) to enforce at compile
time that they are freed before the device is unbound.

Since DMA types with lifetime parameters are exposed through debugfs in the
nova-core driver, first drop the unnecessary T: 'static bound from the debugfs
ScopedDir file creation methods by formalizing a type invariant on FileOps.

Danilo Krummrich (4):
  rust: debugfs: drop 'static bound from ScopedDir file creation methods
  rust: dma: tie CoherentHandle to the device's bound lifetime
  samples: rust_dma: separate driver type from driver data
  rust: dma: tie Coherent and CoherentBox to the device's bound lifetime

 drivers/gpu/nova-core/falcon.rs               |   2 +-
 drivers/gpu/nova-core/fb.rs                   |   4 +-
 drivers/gpu/nova-core/firmware/booter.rs      |   2 +-
 drivers/gpu/nova-core/firmware/fsp.rs         |   8 +-
 .../nova-core/firmware/fwsec/bootloader.rs    |  12 +-
 drivers/gpu/nova-core/firmware/gsp.rs         |  14 +-
 drivers/gpu/nova-core/firmware/riscv.rs       |   8 +-
 drivers/gpu/nova-core/fsp.rs                  |  20 +--
 drivers/gpu/nova-core/gpu.rs                  |   4 +-
 drivers/gpu/nova-core/gsp.rs                  |  30 ++--
 drivers/gpu/nova-core/gsp/boot.rs             |  10 +-
 drivers/gpu/nova-core/gsp/cmdq.rs             |  35 +++--
 drivers/gpu/nova-core/gsp/commands.rs         |   2 +-
 drivers/gpu/nova-core/gsp/fw.rs               |  12 +-
 drivers/gpu/nova-core/gsp/hal.rs              |  14 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs        |  16 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs        |  34 ++---
 drivers/gpu/nova-core/gsp/sequencer.rs        |   6 +-
 rust/kernel/debugfs.rs                        |  26 +---
 rust/kernel/debugfs/entry.rs                  |   4 +-
 rust/kernel/debugfs/file_ops.rs               |  52 ++++---
 rust/kernel/dma.rs                            | 141 +++++++++---------
 rust/kernel/uaccess.rs                        |   4 +-
 samples/rust/rust_dma.rs                      |  30 ++--
 24 files changed, 241 insertions(+), 249 deletions(-)


base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
-- 
2.55.0

