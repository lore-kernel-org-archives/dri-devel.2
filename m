Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE1B606D808
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 23:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=oFr14maV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4112F10E5C6;
	Wed,  4 Nov 2026 23:05:49 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AEA010E1F6
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 23:05:43 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4jKgyq5ZYHzMlMf;
 Thu, 05 Nov 2026 00:05:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1793833539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MR2cYY4Q14cb1mTzW3PW6d96tfmpHwQ/1UzDZFdsFbU=;
 b=oFr14maV/xph0azj+VRd+Nhmtar/Ej08MYiElqrREJDJg8Z+9X7ULd3usML13RV9A13d7c
 ZoQw/16gQdiWVEfH0iSlKdGVLZ6uBkrnSF8rujd2NSqx3mvRQ1tAi+TlFdNGcWBMD46sL8
 3xBEQgAZOjQjM70HfvUrTXmflauHbVmMANeYZrGMSvb2LXIHKXrnhxCZNag0CaOvEk6rqW
 xNtg5zoZTTxEFiYmo9qdeK+52uxWvmusFMWwZmQec1YcdCGgboYUdSVWXMDuL9MyT8QnQp
 /RWpupGuvf96jQppfZHi0euoIrVqiQiC8uER3qAuvVHe8YDd+bwhKSuRj15+6A==
From: Maurice Hieronymus <mhi@mailbox.org>
Subject: [PATCH v4 0/7] samples: rust: add an EDU PCI driver sample (MMIO +
 IRQ + DMA)
Date: Thu, 05 Nov 2026 00:05:31 +0100
Message-Id: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XQwW7CMAwG4FdBOc9T4iYZcNp7IA5N44CljXZOG
 zGhvvsCQ2ITQhx/S/6s3yeVSZiyWi9OSqhw5v5Qg31ZqG7fHnYEHGtWqNFrbywECzLlEYaOgeI
 EUbiQQENOx4AxtjqpujwIJT5e4M225j3nsZfvy51iztOnZDGggZqE9s0Et3Ld+2fLH6E/vvayU
 2e04B8I9UMIK+RT9H5pE3bG3kPNDVoafAg1FXJRB+dWlhyG/9D821voa6p/HK/l5/kHj0tqU2U
 BAAA=
X-Change-ID: 20260614-b4-rust-pci-edu-driver-3e50db2dda0f
To: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Maurice Hieronymus <mhi@mailbox.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793833536; l=7850;
 i=mhi@mailbox.org; s=20260525; h=from:subject:message-id;
 bh=tjN14DZJEDbWu88sp9xGlCDPZD/MWKiGBNaWMN5FgVw=;
 b=4cNaSjA3o64G3TwvLCa72Zdi/5/QEue8+2W1+1jH4sveFv8pO9yiVVuBiAR9ALcYaSmy6xX2d
 5w97Q2d7wYzCTj3dpZ2flVtCCguzbwOQG/UYJVDgX6x76bAFH+jCgmD
X-Developer-Key: i=mhi@mailbox.org; a=ed25519;
 pk=AHlEkGG3hpXZHntlEzF42Ip/LFyXWOgsNUvaHqAnV80=
X-MBO-RS-META: r85b5xyrfd8ayp4369pqbao5z6m41phr
X-MBO-RS-ID: 3e67244dc2d316f77ed
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Rust sample drivers currently exercise PCI facilities in isolation:
rust_driver_pci covers MMIO and rust_dma covers DMA, but there is no
single in-tree example that combines memory-mapped I/O, interrupts and
DMA in one driver.

This series adds one. It targets QEMU's `edu` device -- a small,
well-documented educational PCI device that supports exactly these three
facilities and ships with any recent QEMU (`-device edu`), so the sample
runs without special hardware.

The sample maps BAR0, reads the PCI configuration space, and runs a set
of MMIO self-tests (identification, liveness, factorial), allocates an
MSI vector and registers an IRQ handler, and performs a DMA round-trip.
The IRQ and DMA tests wait on a `Completion` signalled by the IRQ
handler; the factorial test polls for completion.

As requested by Danilo in the v2 review, the sample replaces
rust_driver_pci, which it covers a superset of; the removal is the
first patch.

Prerequisites that had to be implemented:

- pci: rework the device enabling API: replace enable_device_mem()
  with enable_device(), which returns a DeviceEnableGuard that
  disables the device again on drop, so the enable count stays
  balanced across unbind/rebind. This follows the design Danilo
  proposed in the review of the standalone patch [1], which this
  series absorbs.
- pci: keep `set_master()` on `Device<Core>` and require a borrowed
  `DeviceEnableGuard` for the same device, preserving callback
  synchronization while ensuring the device is enabled.
- pci: add PCI_VENDOR_ID_QEMU (0x1234) to pci_ids.h and expose it as
  Vendor::QEMU, so the sample can match the device.
- completion: add complete(), so a single Completion can be reused to
  wait for consecutive events (e.g. back-to-back DMA transfers).

The series is based on rust/rust-next.

Note: DeviceEnableGuard drops from a bound scope, so pci_disable_device()
can race the pci_dev bitfield word as discussed in [1]; that race
predates this series and is triggerable from sysfs today. The bitops
conversion is under way separately on linux-pci [3].

Tested with QEMU `-device edu`.

Not taken from the v3 review (Sashiko):

- The IRQ and DMA completion waits remain unbounded; missing
  interrupts can block probe.
- enable_device() uses pci_enable_device(), not
  pci_enable_device_mem(): it is the single enable API Danilo proposed,
  and enabling I/O decoding is harmless for memory-only devices.

[1] https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@kernel.org
[2] https://lore.kernel.org/r/20260719153631.559341-1-dakr@kernel.org
[3] https://lore.kernel.org/linux-pci/20260714-pci-dev-flags-v2-1-a1d7dc441cf3@mailbox.org/

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
Changes in v4:
- Drop "rust: pci: make Vendor::from_raw() public" (and its R-b tags);
  instead add PCI_VENDOR_ID_QEMU to pci_ids.h and expose it as
  Vendor::QEMU (new patches 4-5) (Alice, John).
- New patch: pci: require a borrowed enable guard for the same device
  in `set_master()`, retaining `Device<Core>` callback synchronization;
  convert nova-core. This enforces enabling before bus-mastering
  (Danilo) while addressing the concurrency concern (Sashiko).
- pci: mark DeviceEnableGuard #[must_use] and enable_device() #[inline]
  (Sashiko, Fiona).
- completion: reference complete() from wait_for_completion()'s docs
  (Gary).
- samples/edu: turn init() and the test helpers into methods on
  EduDriverData; rename init() to selftest() (Danilo).
- samples/edu: initialize EduDriverData in a single try_pin_init!(),
  holding the IRQ vectors and registering the handler with
  irq::Registration::new() instead of pci::Device::request_irq(); run
  selftest() via pin_chain() (Danilo).
- samples/edu: make the magic and DMA base constants local to their
  users; check the magic via an IDENTIFICATION constant (Danilo).
- samples/edu: describe the DMA and test IRQ bits as fields of
  IRQ_STATUS/IRQ_RAISE/IRQ_ACK instead of a DMA_IRQ constant (Danilo).
- samples/edu: model the DMA registers as a struct accessed through
  io_project!()/io_write!().
- samples/edu: compare the liveness pattern via a Not impl on
  LIVENESS_CHECK (Danilo).
- samples/edu: replace `as` casts with safe casts (Danilo).
- samples/edu: return IrqReturn::None for interrupts that are not ours
  (Sashiko).
- samples/edu: depend on 64BIT for the 64-bit MMIO accesses (Sashiko).
- samples/edu: expand the commit message and Kconfig help to describe
  the sample's coverage, QEMU usage and the 64BIT requirement; mention
  the MAINTAINERS entry in the commit message (Sashiko).
- samples/edu: ack stale interrupts before registering the handler
  (Sashiko).
- samples/edu: spell out why the IRQ Registration is not leaked (Ewan).
- Drop the dependency on Danilo's irq Registration rework [2], now in
  mainline.
- Rebase on rust-next; adapt to register!() `base:`, Option<&IdInfo>
  in probe() and the Coherent read_val()/write_val() API.
- Link to v3: https://lore.kernel.org/r/20260812-b4-rust-pci-edu-driver-v3-0-5d0b5594e52b@mailbox.org

Changes in v3:
- Absorb the device enabling rework [1] into this series, redesigned
  around DeviceEnableGuard as proposed by Danilo; convert nova-core.
- Remove rust_driver_pci, replaced by this sample (Danilo).
- Add access to PCI configuration space (Danilo).
- Rebase on rust/rust-next on top of Danilo's irq Registration rework
  [2]; register the handler via pci::Device::request_irq().
- Use vertical import style.
- Link to v2: https://lore.kernel.org/r/20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org

Changes in v2:
- pci: Vendor::from_raw(): collected Reviewed-by from Gary Guo;
  wrapped code identifiers in the commit message in backticks (Gary).
- pci: enable_device(): collected Reviewed-by from Fiona Behrens;
  made enable_device_mem() #[inline] and added a cross-reference to
  enable_device() in its docs (Fiona).
- completion: complete(): tightened the doc comment per Gary's review
  (emphasise "single", drop the internal-counter detail, drop the
  complete_all comparison).
- samples/edu: take &EduDriverData instead of &Arc<EduDriverData> in
  init()/test_irq()/test_dma() (Ewan Chorynski).
- samples/edu: simplify wait_until_compute_has_finished() to forward
  read_poll_timeout()'s error via inspect_err() instead of returning a
  hard-coded ETIMEDOUT (Ewan Chorynski / Miguel Ojeda).
- samples/edu: Rebased on rust/rust-next and adapt to the updated
  pci::Bar / device::Core lifetimes and pci::Driver::Data<'bound>, and
  obtain the BAR via into_devres().
- Link to v1: https://lore.kernel.org/r/20260614-b4-rust-pci-edu-driver-v1-0-e3f2471b595c@mailbox.org

---
Maurice Hieronymus (7):
      samples: rust: remove the rust_driver_pci sample
      rust: pci: rework device enabling API
      rust: pci: require an enable guard for `set_master()`
      PCI: Add QEMU vendor ID
      rust: pci: add Vendor::QEMU
      rust: completion: add complete()
      samples: rust: add EDU PCI driver sample

 MAINTAINERS                     |   2 +-
 drivers/gpu/nova-core/driver.rs |   9 +-
 include/linux/pci_ids.h         |   2 +
 rust/kernel/pci.rs              |  45 +++-
 rust/kernel/pci/id.rs           |   1 +
 rust/kernel/sync/completion.rs  |  13 +-
 samples/rust/Kconfig            |  14 +-
 samples/rust/Makefile           |   2 +-
 samples/rust/rust_driver_edu.rs | 475 ++++++++++++++++++++++++++++++++++++++++
 samples/rust/rust_driver_pci.rs | 198 -----------------
 10 files changed, 547 insertions(+), 214 deletions(-)
---
base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
change-id: 20260614-b4-rust-pci-edu-driver-3e50db2dda0f

Best regards,
-- 
Maurice Hieronymus <mhi@mailbox.org>

