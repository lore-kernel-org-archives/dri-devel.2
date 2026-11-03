Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873D606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcdIlHEJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED45D10E1E3;
	Tue,  3 Nov 2026 23:52:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB07A10E1E3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:52:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E4F8660D81;
 Tue,  3 Nov 2026 23:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E6D1F000C1;
 Tue,  3 Nov 2026 23:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793749946;
 bh=OnPyf4DsfdGQnmVoQBAPDlL7/w93YlPd+SQ2gkHHEGc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=OcdIlHEJPkEBA0v1RhFTf+JxevlaJmzv8EdsdkhJd0dPlhMl82to2kYCx4jSsGGFT
 oJDxWNLlCnQ+hdK5/8TmTT3AWXBdZ0dtQw+YcEZiy6qtiRZEgW/Wsu4AIah6rKPs5E
 Q9UNhsmIXOwkWSQOGdLYkNDsrSlUbXEhgQIsui/IUBZHmEbcSrelhfA/C9vyTyeciF
 /CsQaqEwWgJQlULUwaYR3XZ8JmzPs1XsP/CZWkcX8H5zBTBmZEHSLA0JBpd5UnwgE1
 Ea4K7/WeLYi1o8QljfqDp1Pzi+vttB1vODrxZU7XFKCBSVJBLxoQaiYWOqGiBM9GaA
 yHLPdab51YduA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:52:22 +0100
Message-Id: <DMLZABRA2JIK.1T11DDWNFKGJM@kernel.org>
Subject: Re: [PATCH v3 2/2] gpu: nova-core: add support for GPU timer block.
 (v3)
Cc: <airlied@redhat.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "FUJITA Tomonori" <fujita.tomonori@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Dave Airlie via B4 Relay" <devnull+airlied.redhat.com@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261103-nova-timer-v3-0-0cf9bbae8fd9@redhat.com>
 <20261103-nova-timer-v3-2-0cf9bbae8fd9@redhat.com>
In-Reply-To: <20261103-nova-timer-v3-2-0cf9bbae8fd9@redhat.com>
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 3, 2026 at 1:33 AM CET, Dave Airlie via B4 Relay wrote:
> +// struct that just holds the sys timer offset
> +// after initialising the GPU timer block.
> +pub(crate) struct Timer {
> +    sys_timer_offset_ns: i64,
> +}

I feel like this should actually be TimerState, as it is not really a timer
(instance) representation in the sense of carrying the HAL and providing me=
thods
to interact with the hardware (which we do not intend).

I'd suggest making Timer a unit struct and giving it an init() function, i.=
e.
something like this:

	struct Timer;

	struct TimerState {
	    sys_timer_offset_ns: i64,
	}

	impl Timer {
	    /// Initialize the GPU's system timer.
	    pub(crate) fn init(bar: Bar0<'_>, chipset: Chipset) -> Result<TimerSta=
te>;
	}

> +
> +impl Timer {
> +    pub(crate) fn new(bar: Bar0<'_>, chipset: Chipset) -> Result<Self> {
> +        Ok(Self {
> +            sys_timer_offset_ns: hal::timer_hal(chipset).init(bar)?,
> +        })
> +    }
> +
> +    // this value will be passed to GspInitRequest SYS_TIMER_OFFSET_NS

NIT: This should describe what the returned value represents, although in t=
his
specific case it may also still make sense to give a hint how it is used.

Please use intra-doc links and markdown where it makes sense.

> +    #[expect(dead_code)]
> +    pub(crate) fn sys_timer_offset_ns(&self) -> i64 {
> +        self.sys_timer_offset_ns
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/timer/hal.rs b/drivers/gpu/nova-core/t=
imer/hal.rs
> new file mode 100644
> index 000000000000..fd702867b470
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal.rs
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use kernel::prelude::*;
> +
> +use crate::{
> +    driver::Bar0,
> +    gpu::{
> +        Architecture,
> +        Chipset, //
> +    },
> +};
> +
> +mod gh100;
> +mod tu102;
> +
> +pub(super) trait TimerHal {
> +    /// return system timer offset ns

NIT:

	/// Initialize the GPU's system timer.
	///
	/// Returns the system timer offset in nanoseconds.

> +    fn init(&self, bar: Bar0<'_>) -> Result<i64>;
> +}
> +
> +pub(super) fn timer_hal(chipset: Chipset) -> &'static dyn TimerHal {
> +    match chipset.arch() {
> +        Architecture::Turing | Architecture::Ampere | Architecture::Ada =
=3D> tu102::TU102_HAL,
> +        Architecture::Hopper =3D> gh100::GH100_HAL,
> +        Architecture::BlackwellGB10x | Architecture::BlackwellGB20x =3D>=
 gh100::GB100_HAL,
> +    }
> +}
> diff --git a/drivers/gpu/nova-core/timer/hal/gh100.rs b/drivers/gpu/nova-=
core/timer/hal/gh100.rs
> new file mode 100644
> index 000000000000..a9d46bdd2527
> --- /dev/null
> +++ b/drivers/gpu/nova-core/timer/hal/gh100.rs
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::TimerHal;
> +
> +use kernel::{
> +    io::Io,
> +    prelude::*,
> +    time::*, //
> +};
> +
> +use crate::{
> +    driver::Bar0,
> +    timer::regs, //
> +};
> +
> +/// Timer HAL for Hopper and Blackwell.
> +struct Gh100 {
> +    /// `true` on Hopper, the only architecture where the FSP ucode can =
predate the fix for
> +    /// bug 3957833 and hence the sys timer offset must not be programme=
d. Blackwell FSP
> +    /// always includes the fix.
> +    fsp_bug3957833_war: bool,
> +}
> +
> +/// FSP ucode version from which on the fix for bug 3957833 is included.
> +const FSP_BUG_3957833_FIX_VERSION: u32 =3D 0x44c;
> +
> +impl Gh100 {
> +    /// kfspRequiresBug3957833WAR_HAL: returns `true` if the FSP ucode p=
redates the fix for
> +    /// bug 3957833 and hence the sys timer offset must not be programme=
d. The RM implements
> +    /// the version check for GH100 only; for all later chips it default=
s to `false`.
> +    fn requires_bug3957833_war(&self, bar: Bar0<'_>) -> bool {
> +        self.fsp_bug3957833_war
> +            && bar.read(regs::gh100::NV_GFW_FSP_UCODE_VERSION).full().ge=
t()
> +                < FSP_BUG_3957833_FIX_VERSION

I'd move this into regs.rs and make it a method of NV_GFW_FSP_UCODE_VERSION=
,
e.g.

	impl NV_GFW_FSP_UCODE_VERSION {
	    pub(crate) fn is_bug_3957833_affected(self) -> bool {
	        const FSP_BUG_3957833_FIX_VERSION: u32 =3D 0x44c;
=09
	        self.full().get() < FSP_BUG_3957833_FIX_VERSION
	    }
	}

so you can just call

	bar.read(regs::gh100::NV_GFW_FSP_UCODE_VERSION).is_bug_3957833_affected()
=09
This also keeps FSP_BUG_3957833_FIX_VERSION local to regs.rs and gets us ri=
d of
this HAL function.

> +    }
> +
> +    fn timer_time(&self, bar: Bar0<'_>, time_ns: i64) -> Result<i64> {

Can't we just use unsigned for the argument and return type? None of those =
are
ever expected to be negative, no?

The invariant for the argument to be non-negative comes from Instant, so I'=
d convert
before calling into timer_time(). This should avoid the corresponding as ca=
sts below.

> +        let mut sec_hi2 =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_=
SEC_TIMER_TIME_1));
> +        let sec_timer_ns: u64;
> +        loop {
> +            let sec_lo =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_S=
EC_TIMER_TIME_0));
> +            let sec_hi =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_S=
EC_TIMER_TIME_1));
> +            if sec_hi =3D=3D sec_hi2 {
> +                sec_timer_ns =3D u64::from(sec_hi) << 32 | u64::from(sec=
_lo);
> +                break;
> +            }
> +            sec_hi2 =3D u32::from(bar.read(regs::gh100::NV_PGC6_SCI_SEC_=
TIMER_TIME_1));
> +        }
> +
> +        // The system and the GPU timer are both free-running with unrel=
ated epochs, so the
> +        // difference can be negative. Both operands are < 2^62, hence t=
his cannot overflow.

I think we accumulated a bunch of those comments in nova-core, I think it w=
ould
be nice to consider whether we want a prefix for this, similar to TIMEOUT o=
r
CALC. Maybe OVERFLOW? But this can be a follow-up of course.

On the other hand, this is a fallible method already, so I'd just go with
checked_sub().

> +        let sys_timer_offset_ns =3D time_ns - sec_timer_ns as i64;
> +
> +        // The offset is passed to the GSP as an unsigned value and, lik=
e in the RM's
> +        // tmrSetCurrentTime_GH100, is required to be non-negative. With=
 wall clock time this
> +        // can only fail if the system clock is set behind the GPU power=
-on time.
> +        if sys_timer_offset_ns < 0 {
> +            return Err(EINVAL);
> +        }
> +
> +        if !self.requires_bug3957833_war(bar) {
> +            let offset_ns =3D sys_timer_offset_ns as u64;
> +            bar.write_reg(
> +                regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_1::zeroed()
> +                    .try_with_nsec(((offset_ns >> 32) & 0x1fff_ffff) as =
u32)?,
> +            );
> +            bar.write_reg(
> +                regs::gh100::NV_PGC6_SCI_SYS_TIMER_OFFSET_0::zeroed()
> +                    .try_with_nsec(((offset_ns >> 5) & 0x7ff_ffff) as u3=
2)?
> +                    .with_update(true),
> +            );

This looks similar to NV_TLB_FLUSH_PDB_LO::from_pdb_addr(). I think we shou=
ld do
this in the register impl:

	impl NV_PGC6_SCI_SYS_TIMER_OFFSET_1 {
	    /// Creates a register value from bits 60:32 of the offset.
	    pub(crate) fn from_offset_ns(offset_ns: u64) -> Self {
	        let nsec =3D Bounded::<u32, 29>::from_expr(
	            ((offset_ns >> 32) & 0x1fff_ffff) as u32,
	        );
=09
	        Self::zeroed().with_nsec(nsec)
	    }
	}
=09
> +    // FSP PRI space; the timer is its only consumer so far.
> +    register! {
> +        base: NovaRegisters;
> +
> +        /// FSP ucode version, encoded as `major.minor` in bits 11:8 and=
 7:0, written by the FSP
> +        /// during boot. (`NV_PFSP_FALCON_COMMON_SCRATCH_GROUP_3(1)` in =
the hardware headers.)
> +        pub(crate) NV_GFW_FSP_UCODE_VERSION(u32) @ 0x008f0334 {
> +            11:0 full;
> +        }
> +    }
> +}

Hm...I feel like it should go into fsp/regs.rs regardless.
