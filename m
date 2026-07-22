Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941F3C4452B
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:02:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00DC110EBF4;
	Wed, 22 Jul 2026 01:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CkAn0hCn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D769C10EBF4
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:02:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A78484131D;
 Wed, 22 Jul 2026 01:02:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59DA51F000E9;
 Wed, 22 Jul 2026 01:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682144;
 bh=ZsahaHbiUyPLImxk655F6B9zR140cP1pWZ5kuD98/94=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CkAn0hCnnPEqwIYxEqxyC/K8ZJLKIoEr8lNpM1aD+T4rY82Seg4ULoL2RobZzPU3w
 q0jTrfLpFY3GvJYT4gR8R3qVPbrs2rkzMfuOmMBVppxaTdSOZPXiOR2RTma3x+Jk27
 wtFaft329B1mshE068znqSBqjC5Cl2rMpO2XcSkYggD02WZoyJrNNBnUToAv8ooy3Z
 MZmQFDxJ9BtzioDhPALDGXC9McRmT88fDmXMltSKf/UZog+lWjFjhGEH2FGsGpW0PB
 xQAwOmBejs28drvP2P5+kyghUuhiW+4db+MzYTi9n2FuR6as5sSQPB+Yq10n7cxrDA
 omvonEy0AEGfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 3/7] drm/tyr: add Memory Management Unit (MMU) support
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260721-fw-boot-b4-v8-3-b28f744581c9@collabora.com>
References: <20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com>
 <20260721-fw-boot-b4-v8-3-b28f744581c9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:02:23 +0000
Message-Id: <20260722010224.59DA51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Delayed validation of the hardware AS_PRESENT mask causes probe =
to succeed but runtime operations to fail.
- [Medium] Busy-waiting for up to 10ms in a sleepable context.
--

--- Patch [3]: [PATCH v8 3/7] drm/tyr: add Memory Management Unit (MMU) sup=
port ---
commit d32ee18da5af7d1944026f776d63573705b0da02
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add Memory Management Unit (MMU) support

This commit adds Memory Management Unit (MMU) support in Tyr, wrapping a
SlotManager instance to allocate MMU address-space slots for virtual memory.
It also introduces the AddressSpaceManager for hardware-specific MMU regist=
er
commands and updates Kconfig dependencies.

> diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/t=
yr/mmu/address_space.rs
> index 0000000000000..add5100b26f2e
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
[ ... ]
> +impl<'bound> AddressSpaceManager<'bound> {
> +    /// Creates a new address space manager.
> +    ///
> +    /// Initializes the manager with references to the platform device a=
nd
> +    /// I/O memory region, along with the bitmask of available AS slots.
> +    pub(super) fn new(
> +        dev: &'bound Device<Bound>,
> +        iomem: Arc<IoMem<'bound>>,
> +        as_present: u32,
> +    ) -> Result<AddressSpaceManager<'bound>> {
> +        Ok(Self {
> +            dev,
> +            iomem,
> +            as_present,
> +        })
> +    }
> +
> +    /// Validates that an AS slot number is within range and present in =
hardware.
> +    ///
> +    /// Checks that the slot index is less than [`MAX_AS`] and that
> +    /// the corresponding bit is set in the `as_present` mask read from =
the GPU.
> +    ///
> +    /// Returns [`EINVAL`] if the slot is out of range or not present in=
 hardware.
> +    fn validate_as_slot(&self, as_nr: usize) -> Result {
> +        if as_nr >=3D MAX_AS {
> +            dev_err!(
> +                self.dev,
> +                "AS slot {} out of valid range (max {})\n",
> +                as_nr,
> +                MAX_AS
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        if (self.as_present & (1 << as_nr)) =3D=3D 0 {
> +            dev_err!(
> +                self.dev,
> +                "AS slot {} not present in hardware (AS_PRESENT=3D{:#x})=
\n",
> +                as_nr,
> +                self.as_present
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        if self.as_present.trailing_ones() !=3D self.as_present.count_on=
es() {

[Severity: Medium]
Should the as_present mask validation occur during probe in
AddressSpaceManager::new() instead of on every runtime slot operation?

If the hardware has a sparse AS_PRESENT mask, wouldn't the driver
successfully probe but unconditionally fail all subsequent MMU operations at
runtime? Moving this static mask check to probe time would catch unsupported
hardware earlier and avoid re-evaluating it on every slot operation.

> +            dev_err!(
> +                self.dev,
> +                "Sparse AS_PRESENT mask is unsupported: {:#x}\n",
> +                self.as_present
> +            );
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(())
> +    }
> +
> +    /// Waits for an AS slot to become ready (not active).
> +    ///
> +    /// Returns an error if polling times out after 10ms or if register =
access fails.
> +    fn as_wait_ready(&self, as_nr: usize) -> Result {
> +        let io =3D &*self.iomem;
> +        let op =3D || {
> +            let status_reg =3D STATUS::try_at(as_nr).ok_or(EINVAL)?;
> +            Ok(io.read(status_reg))
> +        };
> +        let cond =3D |status: &STATUS| -> bool { !status.active_ext() };
> +        poll::read_poll_timeout(op, cond, Delta::from_millis(0), Delta::=
from_millis(10))?;

[Severity: Medium]
Can this busy-wait stall the CPU for up to 10ms without yielding?

Since the MMU is protected by a sleepable kernel Mutex (specifically
as_manager: Mutex<AsSlotManager>), should the sleep delta in
poll::read_poll_timeout be a small non-zero value instead of 0ms to allow
yielding and prevent degrading system scheduling latency?

> +
> +        Ok(())
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-fw-boot-b4=
-v8-0-b28f744581c9@collabora.com?part=3D3
