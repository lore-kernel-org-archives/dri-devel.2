Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A92C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:01:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A0A910F3F3;
	Fri, 24 Jul 2026 15:01:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ze8SCKY8";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 698A310F3F0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 15:01:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784905290; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MhBl9wCiOdt0PWEmJN82plIJO6Mqcu4/QwKj+vLLOaWKOt6pBtE/b6pHf3KxOhRBpSkjKKiN43F1YFiSVMujIkAHTQ+zXSMLM/zT4mrPUCBMm1P0KR1JHb9Kb1l9fTU9l8Ur/LSVsfPCPQ3Ysq84vKMsPjj0FXvIgig5nw71kEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784905290;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Yk/E13MgLnZM4nHNEMw88+zVELrflrNqKS9+Pqp746g=; 
 b=iXpNuvYt9J46/2WENix9fmXKMnbZaQO0zaNfx856fTaB03gRgFlp2bVuwQRkNG/v4rcQG++7qXNn+FIENTNzff6ZIlobKhKdSCqfKvwuacjUtsVnYrK1pBvMtw12ySWdj49NpEJsnM4ApIAxO4T1qqK9OJ32y1qW+NksCYwOKzA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784905290; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Reply-To;
 bh=Yk/E13MgLnZM4nHNEMw88+zVELrflrNqKS9+Pqp746g=;
 b=Ze8SCKY8QywAfJuL9SQnZfgtM9aoOwfCU0qlSVylAuKpjt0yPUqFsjQnPN5P9Wzr
 UeUvkHzaV+d1wWegfxGBIU6igpE6h7izX74VaHsQdMbeoD5qnBoLpjW7OXl1hsIWgaL
 8fQac/0ZPo1gz/jYKCAXnFoy/atXCuo3ac9gqZcA=
Received: by mx.zohomail.com with SMTPS id 1784905287570210.90200384796287;
 Fri, 24 Jul 2026 08:01:27 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v9 0/7] drm/tyr: firmware loading and MCU boot support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260722-fw-boot-b4-v9-0-8669d2a02590@collabora.com>
Date: Fri, 24 Jul 2026 12:01:07 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, samitolvanen@google.com, lyude@redhat.com,
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev,
 laura.nao@collabora.com, beata.michalska@arm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <B5C39FB7-F5DB-4CC3-BF87-EA683E14F898@collabora.com>
References: <20260722-fw-boot-b4-v9-0-8669d2a02590@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 22 Jul 2026, at 20:54, Deborah Brouwer =
<deborah.brouwer@collabora.com> wrote:
>=20
> This series adds firmware loading and MCU boot support to the Tyr DRM
> driver. It includes:
> - A parser for the Mali CSF firmware binary format
> - A kernel-managed BO type (KernelBo) for internal driver allocations
> - GPU virtual memory (VM) integration using drm_gpuvm
> - An MMU module and a generic slot manager
> - Loading firmware, VM activation, and MCU boot at probe()
>=20
> It is based on drm-rust-next but also depends on:
>=20
> 1. [PATCH v3] rust: iommu: add device lifetime to IoPageTable
>   =
https://lore.kernel.org/rust-for-linux/20260703-pgtable_lt_b4-v3-1-e738e1f=
513a4@collabora.com
>=20
> 2. [PATCH] drm: Remove DRIVER_GEM_GPUVA feature flag
>   =
https://lore.kernel.org/dri-devel/20260421084701.24227-1-laura.nao@collabo=
ra.com/
>   This patch is in drm-misc-next for v7.3:
>   =
https://lore.kernel.org/dri-devel/20260702-powerful-successful-raptor-eded=
34@houat/
>=20
> A branch with all dependencies is available here:
> https://gitlab.freedesktop.org/dbrouwer/linux/-/commits/fw-boot-b4
>=20
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> Changes in v9:
> - reuse SlotData when reactivating a slot
> - add fn seat to SlotOperations
> - don't allocate gpuva for full unmap_range
> - add small sleeps instead of busy-wait for hw
> - move sparse address space test to constructor
> - use infallible pin_init! for registration data
> - add fw stop() to disable MCU and call it from drop()
> - check page alignment in parser
> - validate firmware header and entry bounds
> - allow firmware sections with no VM mapping footprint
> - clear stale MCU interrupts before boot
> - handle various errors and clean up
> - remove various unreachable code
> - remove trailing newlines from dev_ prints
> - Link to v8: =
https://lore.kernel.org/r/20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.=
com
>=20
> Changes in v8:
> - kill the vm if firmware does not initialize properly
> - write to JOB_IRQ_CLEAR after MCU boots
> - check that a mapping request does not run past the end of the GEM =
buffer
> - check that the SG table gave us enough backing memory for our VA
> - make the KernelBo gem object field (bo) private and add an accessor
> - return unused gpuva from remap()
> - always provide three gpuva to unmap() instead of two
> - be stricter about interpreting MAIR bits for device and =
non-cacheable memory
> - preserve idle slot data in case subsequent activation fails
> - clear evicted slot after eviction in case a subsequent activation =
fails
> - wait for flush and lock commands to complete before proceeding
> - rewrite SectionFlags with the register macro
> - use the InaBits conversion provided by the register macro
> - rename the slot data argument to vm_as_data for clarity
> - add various checks for size, shifting, truncating, sparse values, =
overflow etc.
> - return errors instead of panicking from unwrap()
> - use dev_* macros for all logging
> - Link to v7: =
https://lore.kernel.org/r/20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.=
com
>=20
> Changes in v7:
> - slot.rs: don't print an error when all slots are busy
> - change all allow(dead_code) to expect(dead_code)
> - use LockedSeat type alias in VmAsData
> - shift the lockaddr_base so it fits properly in LOCKADDR
> - replace core::fmt with kernel::fmt
> - make SAFETY comments clearer for map/unmap pages
> - fix arm 32-bit build failures
> - release gpuvm_unique lock before calling deferred_cleanup
> - Link to v6: =
https://lore.kernel.org/r/20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.=
com
>=20
> Changes in v6:
> - Move gpu_info from drm::Driver::Data to RegistrationData
>  and remove drm::Driver::Data entirely.
> - Remove the extra drm::Device ARef in TyrPlatformDriverData
>  since drm::Registration already owns an ARef to the drm::Device.
> - Stop storing platform::Device ARef in firmware since it is unused.
> - Pass a generic kernel::Device instead of the platform::Device =
through
>  firmware to Vm and pagetables since this is all that they need.
> - Link to v5: =
https://lore.kernel.org/r/20260708-fw-boot-b4-v5-0-7792ab68e359@collabora.=
com
>=20
> Changes in v5:
> - Reduce the scope of this series back to just MCU booting.
> - Drop the CSF global interface, job IRQ, wait, and arch timer patches
>  since they will be sent as subsequent series.
> - Add lifetimes to resources and store them in TyrRegistrationData.
>=20
> - Link to v4: =
https://lore.kernel.org/r/20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabo=
ra.com
>=20
> Changes in v4:
> New commits:
>  - drm/tyr: program CSF global interface
>  - rust: time: add arch_timer_get_rate wrapper
>  - drm/tyr: add CSF firmware interface support
>  - drm/tyr: validate presence of CSF shared section
>  - drm/tyr: wait for global interface readiness
>  - drm/tyr: add Job IRQ handling
>  - drm/tyr: add Wait type for GPU events
>=20
> The existing commits from v3 remain unchanged.
> - Link to v3: =
https://lore.kernel.org/r/20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabo=
ra.com
>=20
> Changes in v3:
> New commits:
>  - drm/tyr: remove unused device from platform data
>  - drm/tyr: use shmem GEM object type in TyrDrmDriver
>=20
> drm/tyr: select required dependencies in Kconfig
>  - Rename commit since the dependencies are not limited to DRM.
>  - Select new RUST_DRM_GEM_SHMEM_HELPER instead of =
DRM_GEM_SHMEM_HELPER.
>=20
> drm/tyr: set DMA mask using GPU physical address
>  - Use register macro to read pa_bits instead of separate helper =
function.
>=20
> drm/tyr: add MMU module
>  - Switch MMU code to typed register APIs (TRANSCFG, MEMATTR, STATUS, =
LOCKADDR, etc.).
>  - Use MmuCommand enum for MMU commands instead of raw constants.
>  - Minor cleanups and renaming (MAX_AS, AS_PRESENT handling).
>=20
> drm/tyr: add GPU virtual memory module
>  - Extract VA/PA bits via typed MMU_FEATURES register.
>  - Update the VM code to match the new GPUVM v6 and shmem GEM v10 =
APIs.
>=20
> drm/tyr: add a kernel buffer object
>  - Reject zero-sized KernelBo allocations up front.
>=20
> drm/tyr: add firmware loading and MCU boot support
>  - Use typed GPU control registers.
>  - Pass iomem by Arc into Firmware::new() since we store it =
eventually.
>=20
>  - Link to v2: =
https://lore.kernel.org/rust-for-linux/20260302232500.244489-1-deborah.bro=
uwer@collabora.com/
>=20
> Changes in v2:
> - The whole series is rebased on drm-rust-next including v7.0-rc1.
> - Each patch has its own changelog.
>=20
> Link to v1: =
https://lore.kernel.org/rust-for-linux/20260212013713.304343-1-deborah.bro=
uwer@collabora.com/
>=20
> ---
> Boris Brezillon (3):
>      drm/tyr: add a generic slot manager
>      drm/tyr: add Memory Management Unit (MMU) support
>      drm/tyr: add GPU virtual memory (VM) support
>=20
> Daniel Almeida (1):
>      drm/tyr: add parser for firmware binary
>=20
> Deborah Brouwer (3):
>      drm/tyr: add resources to RegistrationData
>      drm/tyr: add a kernel buffer object
>      drm/tyr: add Microcontroller Unit (MCU) booting
>=20
> drivers/gpu/drm/tyr/Kconfig              |   5 +
> drivers/gpu/drm/tyr/driver.rs            |  68 ++-
> drivers/gpu/drm/tyr/file.rs              |  11 +-
> drivers/gpu/drm/tyr/fw.rs                | 321 +++++++++++
> drivers/gpu/drm/tyr/fw/parser.rs         | 588 +++++++++++++++++++
> drivers/gpu/drm/tyr/gem.rs               | 134 ++++-
> drivers/gpu/drm/tyr/mmu.rs               | 120 ++++
> drivers/gpu/drm/tyr/mmu/address_space.rs | 511 +++++++++++++++++
> drivers/gpu/drm/tyr/regs.rs              | 135 ++++-
> drivers/gpu/drm/tyr/slot.rs              | 404 +++++++++++++
> drivers/gpu/drm/tyr/tyr.rs               |   4 +
> drivers/gpu/drm/tyr/vm.rs                | 937 =
+++++++++++++++++++++++++++++++
> 12 files changed, 3203 insertions(+), 35 deletions(-)
> ---
> base-commit: 337c44a2f50c9008273a338f518cc552f6b08567
> change-id: 20260708-fw-boot-b4-f07706a265c7
>=20
> Best regards,
> --=20
> Deborah Brouwer <deborah.brouwer@collabora.com>
>=20

For the whole series:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

