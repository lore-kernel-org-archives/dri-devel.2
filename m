Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163DAF531D9
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E371F10E540;
	Mon, 13 Apr 2026 22:31:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="hmTB2J5r";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ED2B10E540
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 22:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1776119513; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=G+WXdQK8bSfGc/Mk3PzAXJV6HEMehhkcNxp0RCGAB2RiRlQT5DUSQ/bcMpwH/FQBD3BWbU4v3uwn3UOd58BZBlGmAS9thXzo6pdhVxSNC6GWguZ72xgpgv2f96VzZsgA20CXQAdOMH+ZypW2aG6/13Qv7LfPYn3FZIkqMSSJyDQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1776119513;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Q0mcc1RI+eHWJP7rCFcKpHXMSaCslhXelGGa5gsgNBQ=; 
 b=ZHXpBJ3uwbXWOpbNuSSSH4F/mVuVugw6pE4iAV5BsoMgrtyZ/p3z3kvefsJBGfgYkyB9tXguVDcIBgYgq7bPJkqZD0GT+XLKXYRUaD1l2eeXTMRZdCWEEgiv808fN6BV/rSF6APOR3l0bQcYNHP8jpbbx4zhvQV1n5GxhkQt5JM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776119513; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=Q0mcc1RI+eHWJP7rCFcKpHXMSaCslhXelGGa5gsgNBQ=;
 b=hmTB2J5r9Cqp/SX1K1k5h1zeC0IjrmXFVbrQyiQN38ywmx9OY5l5myWKUlN+jFoH
 hl6lBJvGyoIMPjUx+8Kf319/zDDHCgCKHCXTPznCnFfPgtBwEAOxBG+7rhZqGDeQyXQ
 hzlWPUJvLkSZiu8rAPUtpGpCo1p9CN2WPkhhFrHI=
Received: by mx.zohomail.com with SMTPS id 1776119511020963.6976135163978;
 Mon, 13 Apr 2026 15:31:51 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Subject: [PATCH v3 00/13] drm/tyr: firmware loading and MCU boot support
Date: Mon, 13 Apr 2026 15:31:35 -0700
Message-Id: <20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBuwHKS6SrTIGms2GhoVhHdPW
 r7F/y8kjsIJhuqFyJckCb5A1xUs++w3RlmLoVWtUdRotITuRhvCiZfGzpAjok73TkFpjshOnv8
 3Tjl/NrT2i18AAAA=
X-Change-ID: 20260413-b4-fw-boot-v3-864f444839f0
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4548;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=9ZB7s8E9XQ93lS2MDtTq24ocu1HOFJPh/xLHviUxq0I=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJl3865aLelf0Sjj+Nlxf9BcN/vUbZfXr83+8/+eh+BPV
 3YJnVe+HaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAExkThMjw+ZUqxBNa+dVSoLL
 ej+Y+JjKTk+zSP7fuFrIZKeKTUvRO4a/4kYfsyNCLwsa9W60Cp6eeP7aXT1xpbjIM7phP+u3H5n
 ODgA=
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

Dependencies:
- [PATCH v10 0/5] Rust bindings for gem shmem
https://lore.kernel.org/rust-for-linux/20260409001559.622026-1-lyude@redhat.com/

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

Deborah Brouwer (5):
      drm/tyr: remove unused device from platform data
      drm/tyr: move clock cleanup into Clocks Drop impl
      drm/tyr: add shmem backing for GEM objects
      drm/tyr: add a kernel buffer object
      drm/tyr: add firmware loading and MCU boot support

 drivers/gpu/drm/tyr/Kconfig              |  15 +-
 drivers/gpu/drm/tyr/driver.rs            |  67 ++-
 drivers/gpu/drm/tyr/fw.rs                | 272 +++++++++++
 drivers/gpu/drm/tyr/fw/parser.rs         | 519 ++++++++++++++++++++
 drivers/gpu/drm/tyr/gem.rs               | 159 +++++-
 drivers/gpu/drm/tyr/mmu.rs               | 127 +++++
 drivers/gpu/drm/tyr/mmu/address_space.rs | 571 ++++++++++++++++++++++
 drivers/gpu/drm/tyr/regs.rs              | 110 +++++
 drivers/gpu/drm/tyr/slot.rs              | 436 +++++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs               |   4 +
 drivers/gpu/drm/tyr/vm.rs                | 805 +++++++++++++++++++++++++++++++
 11 files changed, 3050 insertions(+), 35 deletions(-)
---
base-commit: 240d78e2b309660fbedfab3663ae63ee0416a40d
change-id: 20260413-b4-fw-boot-v3-864f444839f0

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

