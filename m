Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07AE8C44501
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:30:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA3610E3FA;
	Tue, 14 Jul 2026 03:30:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m5o09Zo8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515B410E3FA
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:30:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B1C5A601DE;
 Tue, 14 Jul 2026 03:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3362F1F000E9;
 Tue, 14 Jul 2026 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783999823;
 bh=Gi5CcI6HzZw+xP5ngjuiVMQCZE13XT69R61GZNfW5D0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=m5o09Zo8nKkpZMphcU6cTFhMziwuL03akLJLdFsgPsF4j5idIh4vkLVBhDzIArKLS
 d7U7QmNqgouoOnQO0GlhNJEK0chaAKD0wBRtxf7uoMC7vKgMpS9HmqFCd31PoT3Yna
 uyRjww1bRaUPu4kvKa7ws6EoO2kzoPAX6qLmmzsGEDICWEWBpRSJqkLaF1woUHSrzB
 0eidn6IWT0dtDoVb+mABYSQcERbscmHBGUbH6cmwt8jej59RB/6nVnWEsLDAcR9lPf
 OfwzxI0vK0lqfEQQkhytZP+uQkMsdDBlZARYYQ0ZaOeikdJR+WNPgE1FVwjemH+JEf
 4D+PpXTLXyTnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/7] drm/tyr: add Memory Management Unit (MMU) support
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260713-fw-boot-b4-v7-3-afd8dc1494dd@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-3-afd8dc1494dd@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:30:22 +0000
Message-Id: <20260714033023.3362F1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] Early returns in the MMU eviction path on hardware timeouts sk=
ip hardware disablement, leading to a use-after-free of the page tables.
- [High] The MAIR attribute parsing logic incorrectly classifies valid Writ=
e-Back memory as device memory and Non-cacheable memory as Write-Back due t=
o flawed bitwise checks.
- [High] Bit-shift panic and integer underflow when `as_start_update` is ca=
lled with an empty or wrapping region.
- [High] Hardware AS slot assignment fails when the AS_PRESENT mask has hol=
es because it maps a contiguous logical index directly to a physical slot.
- [High] VM updates crossing a 4GB boundary fail because the calculated loc=
k region size exceeds the 5-bit LOCKADDR.size field.
- [High] `AddressSpaceManager::as_flush` does not wait for the hardware `Fl=
ushPt` command to complete.
- [High] `AddressSpaceManager::as_start_update` does not wait for the hardw=
are `Lock` command to complete.
- [Medium] Creating a VM with unsupported `va_bits` causes a panic due to a=
rithmetic underflow.
--

--- Patch [3]: [PATCH v7 3/7] drm/tyr: add Memory Management Unit (MMU) sup=
port ---
commit 3d38e41a867c897b123982cd2a02b0eb472ce1c9
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add Memory Management Unit (MMU) support

Add Memory Management Unit (MMU) support in Tyr. The MMU module wraps a
SlotManager instance to allocate MMU address-space slots for use by
virtual memory (VM) address spaces. The MMU's SlotManager uses an
AddressSpaceManager to handle the hardware-specific callbacks. For
example, the AddressSpaceManager activates and evicts VMs from slots by
writing commands to the MMU registers.

Add an implementation block for the MMU's MEMATTR register to provide
a method for translating the Memory Attribute Indirection Register (MAIR)
format from the pagetable configuration to a format understood by the MMU.

Create an mmu instance during probe, it will be used by subsequent patches
in this series.

Wrap the iomem stored in TyrDrmRegistrationData in an Arc. The iomem
is stored in the mmu through its AddressSpaceManager. In anticipation
of the iomem also being stored in the firmware object, set up shared
ownership of the iomem now.

Update Kconfig to add the new MMU and IOMMU dependencies required
by this MMU module.

> diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/t=
yr/mmu/address_space.rs
> index 0000000000000..20dca96f4a1ee 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/mmu/address_space.rs

[ ... ]

> +impl<'bound> VmAsData<'bound> {

[ ... ]

> +    fn as_config(&self) -> Result<AddressSpaceConfig> {
> +        let pt =3D &self.page_table;

[ ... ]

> +        let ina_bits_field_value =3D 55 - self.va_bits;

[Severity: Medium]
Can this arithmetic operation in VmAsData::as_config() underflow and cause a
kernel panic if a VM is created with va_bits greater than 55?

[ ... ]

> +impl<'bound> AddressSpaceManager<'bound> {

[ ... ]

> +    fn validate_as_slot(&self, as_nr: usize) -> Result {
> +        if as_nr >=3D MAX_AS {
> +            pr_err!("AS slot {} out of valid range (max {})\n", as_nr, M=
AX_AS);
> +            return Err(EINVAL);
> +        }
> +
> +        if (self.as_present & (1 << as_nr)) =3D=3D 0 {

[Severity: High]
Does this logic in AddressSpaceManager::validate_as_slot() fail if the
AS_PRESENT mask contains holes?

During probe, Mmu::new() sets up the generic SlotManager with the total
count of present bits:

Mmu::new()
    let slot_count =3D present.count_ones().try_into()?;
    let as_manager =3D AddressSpaceManager::new(iomem.into(), present)?;
    ...
    SlotManager::new(as_manager, slot_count)?

This assigns contiguous logical indices (e.g. 0, 1, 2) to slots. If the mas=
k is
sparse (like 0b1011), checking the physical bit directly with the logical
index might falsely fail validation when as_nr maps to a missing bit.

[ ... ]

> +    fn as_disable(&mut self, as_nr: usize) -> Result {
> +        self.validate_as_slot(as_nr)?;
> +
> +        // Flush AS before disabling
> +        self.as_send_cmd_and_wait(as_nr, MmuCommand::FlushMem)?;

[Severity: Critical]
If as_send_cmd_and_wait() times out and returns an error, does the ? operat=
or
cause AddressSpaceManager::as_disable() and the evict() path to abort early?

If eviction aborts without zeroing the TRANSTAB registers, the hardware slot
remains active and pointing to page tables that the OS is about to free, wh=
ich
could lead to a use-after-free of those page tables by the hardware.

[ ... ]

> +    fn as_start_update(&mut self, as_nr: usize, region: &Range<u64>) -> =
Result {
> +        self.validate_as_slot(as_nr)?;

[ ... ]

> +        let addr_xor =3D region.start ^ (region.end - 1);

[Severity: High]
Can this cause an arithmetic underflow and out-of-bounds bit shift panic if
AddressSpaceManager::as_start_update() is called with a region where
region.start and region.end are both 0?

If region.end is 0, region.end - 1 wraps to u64::MAX. addr_xor becomes
very large, leading to region_size_log2 becoming 64.

Later in the function:
    let lockaddr_base =3D region.start & !((1u64 << lock_region_log2) - 1);

Shifting 1u64 by 64 will deterministically panic in Rust.

> +        let region_size_log2 =3D 64 - addr_xor.leading_zeros() as u8;
> +
> +        let lock_region_log2 =3D core::cmp::max(region_size_log2, lock_r=
egion_min_size_log2);

[ ... ]

> +        let lockaddr_size =3D lock_region_log2 - 1;

[ ... ]

> +        let lockaddr_val =3D LOCKADDR::zeroed()
> +            .try_with_size(lockaddr_size)?

[Severity: High]
Are valid VM updates that cross a 4GB boundary rejected here?

If an update crosses a 4GB boundary (e.g. from 0xFFFFF000 to 0x100001000),
the XOR of the start and end addresses sets bit 32. This makes
region_size_log2 equal to 33, and lockaddr_size is calculated as 32.

Since the hardware field is 5 bits (max 31), try_with_size() will return
an error instead of proceeding.

[ ... ]

> +        io.write(
> +            LOCKADDR_HI::try_at(as_nr).ok_or(EINVAL)?,
> +            LOCKADDR_HI::from_raw((lockaddr_val >> 32) as u32),
> +        );
> +
> +        self.as_send_cmd(as_nr, MmuCommand::Lock)
> +    }

[Severity: High]
Does this code need to wait for the Lock command to complete?

Since as_send_cmd() returns immediately, the CPU might begin modifying the
page tables before the hardware has actually locked the TLB, breaking atomi=
city.

[ ... ]

> +    fn as_flush(&mut self, as_nr: usize) -> Result {
> +        self.validate_as_slot(as_nr)?;
> +        self.as_send_cmd(as_nr, MmuCommand::FlushPt)
> +    }

[Severity: High]
Does this code need to wait for the FlushPt command to complete?

If as_flush() returns before the hardware completes the flush, the CPU could
proceed to unmap or free pages while the GPU is still processing them, crea=
ting
a TLB use-after-free scenario.

> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 831357a8ef87d..eae9213fb1c2b 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs

[ ... ]

> +        impl MEMATTR {

[ ... ]

> +            fn is_device_memory(mair_attr: u8) -> bool {
> +                // In AArch64 MAIR, device memory has bits [1:0] of oute=
r nibble =3D 0.
> +                let outer =3D mair_attr >> 4;
> +                (outer & 0x3) =3D=3D 0
> +            }

[Severity: High]
Can MEMATTR::is_device_memory() incorrectly classify valid memory attributes
as device memory?

If a buffer is mapped using a MAIR attribute where the outer cache policy is
Write-Back but No-Allocate (e.g. 0xCC), outer & 0x3 would evaluate to
12 & 3 =3D=3D 0. This incorrectly categorizes the memory as device memory.

[ ... ]

> +            fn is_writeback_cacheable(mair_attr: u8) -> bool {
> +                let outer =3D mair_attr >> 4;
> +                let inner =3D mair_attr & Self::ARM_MAIR_INNER_MASK;
> +
> +                (outer & Self::ARM_MAIR_WRITE_BACK) !=3D 0 && (inner & S=
elf::ARM_MAIR_WRITE_BACK) !=3D 0
> +            }

[Severity: High]
Does MEMATTR::is_writeback_cacheable() mistakenly identify memory as Write-=
Back
when the inner cache policy is Non-Cacheable?

For an attribute like 0x74 (Outer Write-Back, Inner Non-Cacheable), outer &=
 4
and inner & 4 are both non-zero, violating the requested cache policy by
mapping Inner Non-Cacheable memory as fully Write-Back.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-fw-boot-b4=
-v7-0-afd8dc1494dd@collabora.com?part=3D3
