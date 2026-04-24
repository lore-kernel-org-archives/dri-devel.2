Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF2D6FF885A
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B27710E080;
	Fri, 24 Apr 2026 23:39:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="LEp97SXN";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5662710E080
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073955; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=GHOqLhrKMHrsDD/N7jS6wIZ/r2zr3HfUXMxyiON+rRnpP+NaEvBvPxNmgpb1rReWGYLOXlyu5FC5SreGDFNJKt/bUbagluvOEyS7coIjaSNQv2yQqKCiWvgjMu85s4XG63bkngkekpfYwukZLTsWd6Q72d0TtsQNvmEAp7IIvOw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073955;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=RcWvnCAbCUFK7Lm2LM/nqXTh7dLqCHkL6wDI2q0/+xw=; 
 b=PQ8eBx4sISyaCR7N3vJAzAxF+yT/Iqh4Yc6iLslnYmqjEzTEhHEGJinOXzEf/PGsivrxe15FKFxzi1QliYzqpEEXJQwZgE1LzNADq9YsFwj0PwVhklbJYbO/T3tsoaf/LqpRe2VjvIO2O0okYgfjdLjg5oVYP1KeqXcuaX2olnM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073955; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=RcWvnCAbCUFK7Lm2LM/nqXTh7dLqCHkL6wDI2q0/+xw=;
 b=LEp97SXNiY0zJVIEvEmxf2W/0QL0GmqYwvdo8ja36v83xvPP4FxmW0rCYzRetOL/
 XUqmCF1/Da9WQHxzI+OHGf1j5M7acPpDZpPirl483x4baxCu8UeSQW/0r1PjktukiPq
 jpuWFcKrzjL+7dlQuKYLWfaBUTsWqcZN51+mAHW8=
Received: by mx.zohomail.com with SMTPS id 1777073953870348.13203397773054;
 Fri, 24 Apr 2026 16:39:13 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v4 00/20] drm/tyr: firmware loading and MCU boot support
Date: Fri, 24 Apr 2026 16:38:54 -0700
Message-Id: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQ5AMBBA0avIrE1SNQRXEQtlymxaaQWJ9O4ay
 7f4/4XIQTjCULwQ+JIo3mVQWcCyz25jlDUbtNKtIk1oCO2NxvsTL0IyjVW9sVXNHeTmCGzl+X/
 jlNIH9ggXg18AAAA=
X-Change-ID: 20260424-b4-fw-boot-v4-4b5f09bf13e8
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5755;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=ghNzVyPKU/Kea9FpHetQ6ymOdAd9S1ctNJ6NEXrA21E=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yvc5Aou1VUNkZ5vcMzGX/GwQ7m2/hf+7LfHL5Rbh
 v+t0T7YUcrCIMbFICumyHLW3qhHvOq9ke78/80wc1iZQIYwcHEKwERmrGVkOFWWo+d9+PDGKRPS
 YhQKBB0/HrvtkhKi/fHF0WZv6+qH5Qz/9Ntun31WnVQptm4S/8GFKrIusxdOtZxqxNjMe8hievY
 VRgA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

This series adds firmware loading and MCU boot support to the Tyr DRM
driver. It includes:
 - A parser for the Mali CSF firmware binary format
 - A kernel-managed BO type (KernelBo) for internal driver allocations
 - GPU virtual memory (VM) integration using drm_gpuvm
 - An MMU module and a generic slot manager
 - Shmem-backed GEM support for Tyr
 - Loading firmware, VM activation, and MCU boot at probe()
 - Initialization of Command Stream Frontend (CSF) firmware interfaces

Dependencies:
 - [PATCH v12 0/5] Rust bindings for gem shmem
    https://lore.kernel.org/rust-for-linux/20260421235346.672794-1-lyude@redhat.com

 - [PATCH v6 0/5] Rust GPUVM immediate mode
    https://lore.kernel.org/rust-for-linux/20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com/

 - [PATCH v6 0/5] Introduce DeviceContext
    https://lore.kernel.org/rust-for-linux/20260320233645.950190-1-lyude@redhat.com/

 - [PATCH v5 0/6] drm/tyr: Use register! macro
    https://lore.kernel.org/rust-for-linux/20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com/

Other Prerequisites:
 This series also depends on additional prerequisite fixes not included in
 this posting. The full stack (base + prerequisites + this series) is
 available here:
  https://gitlab.freedesktop.org/dbrouwer/linux/-/tree/dbrouwer/fw-boot
    
  Development history / discussion:
   https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/56
    

---
Changes in v4:
 New commits:
  - drm/tyr: program CSF global interface
  - rust: time: add arch_timer_get_rate wrapper
  - drm/tyr: add CSF firmware interface support
  - drm/tyr: validate presence of CSF shared section
  - drm/tyr: wait for global interface readiness
  - drm/tyr: add Job IRQ handling
  - drm/tyr: add Wait type for GPU events

 The existing commits from v3 remain unchanged.
 - Link to v3: https://lore.kernel.org/r/20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com
    
Changes in v3:
 New commits:
  - drm/tyr: remove unused device from platform data
  - drm/tyr: use shmem GEM object type in TyrDrmDriver
    
 drm/tyr: select required dependencies in Kconfig
  - Rename commit since the dependencies are not limited to DRM.
  - Select new RUST_DRM_GEM_SHMEM_HELPER instead of DRM_GEM_SHMEM_HELPER.
    
 drm/tyr: set DMA mask using GPU physical address
  - Use register macro to read pa_bits instead of separate helper function.
    
 drm/tyr: add MMU module
  - Switch MMU code to typed register APIs (TRANSCFG, MEMATTR, STATUS, LOCKADDR, etc.).
  - Use MmuCommand enum for MMU commands instead of raw constants.
  - Minor cleanups and renaming (MAX_AS, AS_PRESENT handling).
    
 drm/tyr: add GPU virtual memory module
  - Extract VA/PA bits via typed MMU_FEATURES register.
  - Update the VM code to match the new GPUVM v6 and shmem GEM v10 APIs.
    
 drm/tyr: add a kernel buffer object
  - Reject zero-sized KernelBo allocations up front.
    
 drm/tyr: add firmware loading and MCU boot support
  - Use typed GPU control registers.
  - Pass iomem by Arc into Firmware::new() since we store it eventually.
    
  - Link to v2: https://lore.kernel.org/rust-for-linux/20260302232500.244489-1-deborah.brouwer@collabora.com/
    
Changes in v2:
 - The whole series is rebased on drm-rust-next including v7.0-rc1.
 - Each patch has its own changelog.
    
 Link to v1: https://lore.kernel.org/rust-for-linux/20260212013713.304343-1-deborah.brouwer@collabora.com/

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

---
Alvin Sun (1):
      drm/tyr: use shmem GEM object type in TyrDrmDriver

Beata Michalska (1):
      drm/tyr: set DMA mask using GPU physical address

Boris Brezillon (5):
      drm/tyr: select required dependencies in Kconfig
      drm/tyr: rename TyrObject to BoData
      drm/tyr: Add generic slot manager
      drm/tyr: add MMU module
      drm/tyr: add GPU virtual memory module

Daniel Almeida (1):
      drm/tyr: add parser for firmware binary

Deborah Brouwer (12):
      drm/tyr: remove unused device from platform data
      drm/tyr: move clock cleanup into Clocks Drop impl
      drm/tyr: add shmem backing for GEM objects
      drm/tyr: add a kernel buffer object
      drm/tyr: add firmware loading and MCU boot support
      drm/tyr: add Wait type for GPU events
      drm/tyr: add Job IRQ handling
      drm/tyr: wait for global interface readiness
      drm/tyr: validate presence of CSF shared section
      drm/tyr: add CSF firmware interface support
      rust: time: add arch_timer_get_rate wrapper
      drm/tyr: program CSF global interface

 drivers/gpu/drm/tyr/Kconfig              |   15 +-
 drivers/gpu/drm/tyr/driver.rs            |  153 +-
 drivers/gpu/drm/tyr/fw.rs                |  352 +++++
 drivers/gpu/drm/tyr/fw/interfaces.rs     | 2243 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/fw/irq.rs            |  120 ++
 drivers/gpu/drm/tyr/fw/parser.rs         |  532 +++++++
 drivers/gpu/drm/tyr/gem.rs               |  164 ++-
 drivers/gpu/drm/tyr/mmu.rs               |  127 ++
 drivers/gpu/drm/tyr/mmu/address_space.rs |  571 ++++++++
 drivers/gpu/drm/tyr/regs.rs              |  110 ++
 drivers/gpu/drm/tyr/slot.rs              |  436 ++++++
 drivers/gpu/drm/tyr/tyr.rs               |    5 +
 drivers/gpu/drm/tyr/vm.rs                |  805 +++++++++++
 drivers/gpu/drm/tyr/wait.rs              |  125 ++
 rust/kernel/time.rs                      |   29 +
 15 files changed, 5752 insertions(+), 35 deletions(-)
---
base-commit: 52c3c3b7eb11d596526e523bf57f8b3cbdcb24d8
change-id: 20260424-b4-fw-boot-v4-4b5f09bf13e8

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

