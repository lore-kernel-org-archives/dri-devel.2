Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BEF606A326
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=matt3o12.de header.i=@matt3o12.de header.a=rsa-sha256 header.s=securedbylima-20230709 header.b=XB19kjQM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F2610E60F;
	Mon, 23 Nov 2026 20:39:58 +0000 (UTC)
Received: from mx1.mail-out.lima-city.de (mx1.mail-out.lima-city.de
 [91.216.248.203])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2CE110E60F
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 20:39:51 +0000 (UTC)
From: Matteo Kloiber <kernel@matt3o12.de>
X-Lima-ML-UUID: 81470204-daba-453d-acff-0be0cfd12c6f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=matt3o12.de;
 s=securedbylima-20230709; t=1795466389;
 bh=9sERvGdC+WVq6w/5sPGXEVVunS+nVPCtaCo9cY0jLE8=;
 h=From:To:Cc:Subject:Date:From;
 b=XB19kjQMutSa+j7g+dgUGuSi9cb4aLGdx+NxbL+etQfWT1U4lhXSzbr0pTBO/g1bj
 Jrav7AG1bUsIPERTEBMYAnPrAmcF5BF8XbPHlxZmNSu58kOQ3KPMQYucequ3XxWkbl
 1Gwhw85+ADfMMJjLzFZxzLbXn+yyPZe4Yg9spZq0mXhCfbPgLGlkrWj3iHLniDqEvj
 om6KaaGVQt5cGifXnnc1BkE0kp/61640dxqxKJXujkdRLGyXw69cpdHFA2PVP+jplo
 ZaOmzawBtbR2fmAEVWV/7kkkD9Y5kzapCz8u62l1c6P8FC75m3rdytSN+GYqDmKpna
 zLJZu4Idy1thQ==
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Matteo Kloiber <kernel@matt3o12.de>
Subject: [RFC PATCH 0/3] rust: dma: require device configuration before DMA
Date: Mon, 23 Nov 2026 21:39:23 +0100
Message-ID: <20261123203926.1787169-1-kernel@matt3o12.de>
X-Mailer: git-send-email 2.51.2
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is the RFC that came out of the max_seg_size discussion [1]. It
implements the DMA setup token Alexandre proposed there, passed to
probe() through the InitTokens struct that he and Danilo suggested in
[2].

A driver now has to configure DMA before it can allocate or map
anything:

    let pci::InitTokens { dma: setup, .. } = tokens;

    let dma = setup.configure(dma::Params {
        streaming_mask: Some(mask),
        coherent_mask: Some(mask),
        max_seg_size: Some(NonZeroU32::MAX),
    })?;

    let buf = Coherent::<u64>::zeroed(dma, GFP_KERNEL)?;

configure() consumes the token and returns a copyable dma::Handle.
Coherent allocations, SGTable::new(), IoPageTable::new() and the shmem
sg_table() take that handle instead of a device, so they cannot be
called before configuration and the parameters cannot change
afterwards. The unsafe dma::Device setters are gone. Drivers that do no
DMA ignore the token.

- Patch 1 adds InitTokens to the PCI and platform probe() signature.
  It is mechanical and the only patch that touches drivers without DMA.
- Patch 2 reshuffles Gpu::new() in nova-core so that patch 3 has no
  reindentation in it.
- Patch 3 is the actual change.

Design decisions (feedback welcome):

- Params has no Default, so adding a field later requires updating every
  in-tree DMA driver. Because the kernel is a mono repo, I think this is the
  right tradeoff. It forces a deliberate choice between None and an explicit
  value for each driver rather than silently preserving existing behaviour.
  InitTokens is #[non_exhaustive] because most drivers will not care about
  unrelated tokens.

- configure() consumes the token even on error, so a driver cannot retry
  with a different mask. dma-api-howto.rst states that drivers should
  fail probe if setting the mask fails, and consuming the token enforces
  that. If a driver ever needs to probe supported masks first, a
  separate query method fits better than returning the token on error.

- Only PCI and platform probe() hand out a token. An auxiliary driver
  that performs DMA on behalf of its parent should receive the parent's
  dma::Handle rather than configuring DMA itself. No in-tree auxiliary
  driver needs this yet.

- Tyr keeps its current segment size (max_seg_size: None, with a TODO).
  Panthor sets UINT_MAX for the same hardware, so Tyr probably should
  too, but I left that out to avoid behaviour changes in this series. I
  can either send this as a separate patch or include it for the final
  patch.

One limitation: DRM C callbacks that map memory on the driver's behalf
do not go through the handle. For those the ordering is documented on
drm::Registration::new() but not enforced.

Every patch builds with CLIPPY=1, and the Rust KUnit suites and
doctests pass on each of them (x86_64, QEMU). nova-core and Tyr are
compile-tested only.

An LLM assisted with the design, implementation, including writing all comments
and text. I have reviewed all of it.

Based on drm-rust-next.

[1] https://lore.kernel.org/DLHH0K25NLX5.616R4D860TXU@nvidia.com
[2] https://lore.kernel.org/DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com

Matteo Kloiber (3):
  rust: pci, platform: pass InitTokens to probe()
  gpu: nova-core: build Gpu inside pin_init_scope
  rust: dma: require device configuration before DMA

 drivers/cpufreq/rcpufreq_dt.rs                |   1 +
 drivers/gpu/drm/tyr/driver.rs                 |  18 +-
 drivers/gpu/drm/tyr/fw.rs                     |  11 +-
 drivers/gpu/drm/tyr/mmu/address_space.rs      |   7 +-
 drivers/gpu/drm/tyr/vm.rs                     |  28 +-
 drivers/gpu/nova-core/driver.rs               |   4 +-
 drivers/gpu/nova-core/falcon.rs               |  13 +-
 drivers/gpu/nova-core/fb.rs                   |  11 +-
 .../nova-core/firmware/fwsec/bootloader.rs    |  13 +-
 drivers/gpu/nova-core/firmware/gsp.rs         |  18 +-
 drivers/gpu/nova-core/firmware/gsp_fmc.rs     |  10 +-
 drivers/gpu/nova-core/firmware/radix3.rs      |  17 +-
 drivers/gpu/nova-core/firmware/riscv.rs       |  11 +-
 drivers/gpu/nova-core/fsp.rs                  |  20 +-
 drivers/gpu/nova-core/gpu.rs                  | 241 ++++++++--------
 drivers/gpu/nova-core/gsp.rs                  |  19 +-
 drivers/gpu/nova-core/gsp/boot.rs             |   2 +-
 drivers/gpu/nova-core/gsp/cmdq.rs             |  14 +-
 drivers/gpu/nova-core/gsp/hal/gh100.rs        |   9 +-
 drivers/gpu/nova-core/gsp/hal/tu102.rs        |  24 +-
 drivers/gpu/nova-core/gsp/logbuffer.rs        |  23 +-
 drivers/pwm/pwm_th1520.rs                     |   1 +
 rust/helpers/dma.c                            |   6 -
 rust/kernel/cpufreq.rs                        |   1 +
 rust/kernel/dma.rs                            | 264 +++++++++---------
 rust/kernel/drm/driver.rs                     |   4 +
 rust/kernel/drm/gem/shmem.rs                  |  23 +-
 rust/kernel/io/mem.rs                         |   2 +
 rust/kernel/iommu/pgtable.rs                  |  24 +-
 rust/kernel/pci.rs                            |  20 +-
 rust/kernel/platform.rs                       |  20 +-
 rust/kernel/scatterlist.rs                    |  20 +-
 samples/rust/rust_debugfs.rs                  |   1 +
 samples/rust/rust_dma.rs                      |  18 +-
 samples/rust/rust_driver_auxiliary.rs         |   1 +
 samples/rust/rust_driver_pci.rs               |   1 +
 samples/rust/rust_driver_platform.rs          |   1 +
 samples/rust/rust_i2c_client.rs               |   1 +
 samples/rust/rust_soc.rs                      |   1 +
 39 files changed, 514 insertions(+), 409 deletions(-)

-- 
2.51.2

