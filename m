Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C1F1091937
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 00:15:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABBF110E8EE;
	Fri, 20 Mar 2026 00:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="hwMWAsIl";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B5410E8EE
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 00:15:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1773965723; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=md45O2KgzDazV0EzwICd21D803Vkz90BZ2Xj4WfGfViuHrLl94zP4nsDksDOK1GXL7HAOBVTz4y4kfeGvdGQtd9G1qVwf2+JptA8ZSj0clsr9iHrcgZv527p4q946KjBiuRoGLQnh5b/hXByxuacoJSmh2Ajkwz2EyOppEp1vqQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1773965723;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=nIkzBV1upShf1ic8G7ImiVkHHjiLBzj/SiksVSgVnjQ=; 
 b=bwEsFrCLqhvUio9MuaURYMzo/T9UV8UwdJntuiSlj5jRdYMTnTmgKhaZrZchkeG0F/WHC4b4/1KrnMV4XowXQZJUentW9LOVC3L7+OrgLJ2TZEMXor5VFqMS2sGlZMxHG1belWMSAVX/mXNGMUFA1u0lvpSQpbGJJ687G3MvAeE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773965723; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=nIkzBV1upShf1ic8G7ImiVkHHjiLBzj/SiksVSgVnjQ=;
 b=hwMWAsIlyb/bQjRkIBCt7z4PvZDJrxEYHCHTyY1BM7pdGQaxsjushH0vpEUmqwg+
 hxH4b5WSmgwzlHzSNAWP6X/mDkExgVj6REtz+JC/DwuGJHCJsK0qtN+ipYvRETbTm2w
 QSx7V/9M8Ae/912dlOa1YlKXvIeXy9K4/ACTDE78=
Received: by mx.zohomail.com with SMTPS id 1773965720860622.5815621050441;
 Thu, 19 Mar 2026 17:15:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 17:15:19 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Dirk Behme <dirk.behme@gmail.com>, Boqun Feng <boqun@kernel.org>
Subject: Re: [PATCH v2 1/5] drm/tyr: Use register! macro for GPU_CONTROL
Message-ID: <abyRl_v-X8IsQuLy@um790>
References: <20260311-b4-tyr-use-register-macro-v2-v2-0-b936d9eb8f51@collabora.com>
 <20260311-b4-tyr-use-register-macro-v2-v2-1-b936d9eb8f51@collabora.com>
 <DH5KX6V4OK45.3LFJYY71RLOV0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DH5KX6V4OK45.3LFJYY71RLOV0@nvidia.com>
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

On Wed, Mar 18, 2026 at 12:14:26PM +0900, Alexandre Courbot wrote:
> On Thu Mar 12, 2026 at 8:03 AM JST, Deborah Brouwer wrote:
> > From: Daniel Almeida <daniel.almeida@collabora.com>
> >
> > Convert the GPU_CONTROL register definitions to use the `register!` macro.
> >
> > Using the `register!` macro allows us to replace manual bit masks and
> > shifts with typed register and field accessors, which makes the code
> > easier to read and avoids errors from bit manipulation.
> >
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > ---
> >  drivers/gpu/drm/tyr/driver.rs |  26 +-
> >  drivers/gpu/drm/tyr/gpu.rs    | 211 ++++++--------
> >  drivers/gpu/drm/tyr/regs.rs   | 644 ++++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 687 insertions(+), 194 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
> > index 611434641580574ec6b5afa49a8fe79888bb7ace..10c212a3a01910858f02c6d637edff8a263f017b 100644
> > --- a/drivers/gpu/drm/tyr/driver.rs
> > +++ b/drivers/gpu/drm/tyr/driver.rs
> > @@ -13,7 +13,10 @@
> >      devres::Devres,
> >      drm,
> >      drm::ioctl,
> > -    io::poll,
> > +    io::{
> > +        poll,
> > +        Io, //
> > +    },
> >      new_mutex,
> >      of,
> >      platform,
> > @@ -33,8 +36,11 @@
> >      file::TyrDrmFileData,
> >      gem::TyrObject,
> >      gpu,
> > -    gpu::GpuInfo,
> > -    regs, //
> > +    gpu::{
> > +        gpu_info_log, //
> > +        GpuInfo,
> > +    },
> > +    regs::*, //
> >  };
> >  
> >  pub(crate) type IoMem = kernel::io::mem::IoMem<SZ_2M>;
> > @@ -78,11 +84,17 @@ unsafe impl Send for TyrDrmDeviceData {}
> >  unsafe impl Sync for TyrDrmDeviceData {}
> >  
> >  fn issue_soft_reset(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> > -    regs::GPU_CMD.write(dev, iomem, regs::GPU_CMD_SOFT_RESET)?;
> > +    let io = (*iomem).access(dev)?;
> > +    io.write_val(
> > +        GPU_COMMAND_RESET::zeroed().with_const_reset_mode::<{ GPU_COMMAND_RESET::SOFT_RESET }>(),
> > +    );
> 
> My biggest piece of feedback for this patchset: replace the const values
> with enums and use the `?=>` (or `=>` where possible) syntax to directly
> convert your fields from and into them. It associates each field with
> its possible set of values and guarantees you won't use a given constant
> with the wrong field (and also that you cannot set invalid field values
> at all).
> 
> It is a bit cumbersome at the moment because you will need to provide
> `TryFrom` and `Into` implementations between the enum and the
> corresponding bounded type, but it makes setting fields easier and is
> the way the API was designed to be used. The `TryFrom/Into` derive macro
> work will remove all the boilerplace once it is merged.

Ok, thanks for this feedback, I definitely didn't understand this syntax
for the register macro and will use it now.

> 
> >  
> >      poll::read_poll_timeout(
> > -        || regs::GPU_IRQ_RAWSTAT.read(dev, iomem),
> > -        |status| *status & regs::GPU_IRQ_RAWSTAT_RESET_COMPLETED != 0,
> > +        || {
> > +            let io = (*iomem).access(dev)?;
> > +            Ok(io.read(GPU_IRQ_RAWSTAT))
> > +        },
> > +        |status| status.reset_completed().get() != 0,
> 
> Here you can do the following in the declaration of `GPU_IRQ_RAWSTAT`:
> 
>     /// Reset has completed.
>     8:8     reset_completed => bool;
> 
> and change this line to just 
> 
>     |status| status.reset_completed(),
> 
> You will probably want to do that for most of the single-bit fields,
> unless their semantic is different from a boolean value.

Yep, I will include that in v3. I have checked so far all of those fields
are just 1-bit boolean flags.

> 
> An alternative is to use `into_bool` instead of `get` to at least get a
> boolean value from the single-bit field.
> 
> <snip>
> > +pub(crate) fn gpu_info_log(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> > +    let io = (*iomem).access(dev)?;
> > +    let gpu_id = io.read(GPU_ID);
> > +
> > +    let model_name = if let Some(model) = GPU_MODELS.iter().find(|&f| {
> > +        f.arch_major == gpu_id.arch_major().get() && f.prod_major == gpu_id.prod_major().get()
> > +    }) {
> > +        model.name
> > +    } else {
> > +        "unknown"
> > +    };
> > +
> > +    // Create canonical product ID with only arch/product fields, excluding version
> > +    // fields. This ensures the same product at different revisions has the same ID.
> > +    let id = GPU_ID::zeroed()
> > +        .with_arch_major(gpu_id.arch_major())
> > +        .with_arch_minor(gpu_id.arch_minor())
> > +        .with_arch_rev(gpu_id.arch_rev())
> > +        .with_prod_major(gpu_id.prod_major())
> > +        .into_raw();
> 
> It might be simpler to just clear the values of the fields you don't want.

I'm dropping this part in v3 and will just print the whole register.

> 
> > +
> > +    dev_info!(
> > +        dev,
> > +        "mali-{} id 0x{:x} major 0x{:x} minor 0x{:x} status 0x{:x}",
> > +        model_name,
> > +        id,
> > +        gpu_id.ver_major().get(),
> > +        gpu_id.ver_minor().get(),
> > +        gpu_id.ver_status().get()
> > +    );
> 
> Note that the `Debug` implementation of register types will display
> their raw hex value and the individual values of all their fields - you
> might want to leverage that.

I gave this a try but the "Bounded" around the values makes it a bit
hard to read i think. Compactly it would look like this:

gpu: mali-g610 GPU_ID { <raw>: 0xa8670005, ver_status: Bounded(5),
ver_minor: Bounded(0), ver_major: Bounded(0), prod_major: Bounded(7),
arch_rev: Bounded(6), arch_minor: Bounded(8), arch_major: Bounded(10) }

> 
> > +
> > +    dev_info!(
> > +        dev,
> > +        "Features: L2:{:#x} Tiler:{:#x} Mem:{:#x} MMU:{:#x} AS:{:#x}",
> > +        io.read(L2_FEATURES).into_raw(),
> > +        io.read(TILER_FEATURES).into_raw(),
> > +        io.read(MEM_FEATURES).into_raw(),
> > +        io.read(MMU_FEATURES).into_raw(),
> > +        io.read(AS_PRESENT).into_raw(),
> > +    );
> > +
> > +    dev_info!(
> > +        dev,
> > +        "shader_present=0x{:016x} l2_present=0x{:016x} tiler_present=0x{:016x}",
> > +        io.read(SHADER_PRESENT).into_raw(),
> > +        io.read(L2_PRESENT).into_raw(),
> > +        io.read(TILER_PRESENT).into_raw(),
> > +    );
> > +    Ok(())
> >  }
> >  
> >  /// Powers on the l2 block.
> >  pub(crate) fn l2_power_on(dev: &Device<Bound>, iomem: &Devres<IoMem>) -> Result {
> > -    regs::L2_PWRON_LO.write(dev, iomem, 1)?;
> > +    let io = (*iomem).access(dev)?;
> > +    io.write_val(L2_PWRON::zeroed().with_const_request::<1>());
> >  
> >      poll::read_poll_timeout(
> > -        || regs::L2_READY_LO.read(dev, iomem),
> > +        || {
> > +            let io = (*iomem).access(dev)?;
> > +            Ok(io.read(L2_READY).into_raw())
> > +        },
> >          |status| *status == 1,
> 
> Why not
> 
>     poll::read_poll_timeout(
>         || regs::L2_READY_LO.read(dev, iomem),
>         || {
>             let io = (*iomem).access(dev)?;
>             Ok(io.read(L2_READY))
>         },
>         |status| status.ready() == 1,
> 
> ?
Thanks, will fix.

> 
> <snip>
> > +        /// Layout is interpreted differently depending on the command value.
> > +        /// Default command is [`GPU_COMMAND::NOP`] with no payload.
> > +        pub(crate) GPU_COMMAND (u32) @ 0x30 {
> > +            7:0     command;
> > +        }
> > +    }
> > +
> > +    impl GPU_COMMAND {
> > +        /// No operation. This is the default value.
> > +        pub(crate) const NOP: u32 = 0;
> > +        /// Reset the GPU.
> > +        pub(crate) const RESET: u32 = 1;
> > +        /// Flush caches.
> > +        pub(crate) const FLUSH_CACHES: u32 = 4;
> > +        /// Clear GPU faults.
> > +        pub(crate) const CLEAR_FAULT: u32 = 7;
> > +    }
> 
> So this should really be turned into an enum:
> 
>     #[derive(Copy, Clone, Debug)]
>     #[repr(u32)]
>     enum GpuCommand {
>         Nop = 0,
>         Reset = 1,
>         FlushCaches = 4,
>         ClearFault = 7,
>     }
> 
>     impl TryFrom<Bounded<u32, 8>> for GpuCommand {
>         ...
>     }
> 
>     impl From<GpuCommand> for Bounded<u32, 8> {
>         ...
>     }
> 
> Then `GPU_COMMAND` becomes:
> 
>     pub(crate) GPU_COMMAND (u32) @ 0x30 {
>         7:0     command ?=> GpuCommand;
>     }
> 
> ... and everything becomes easier, as you can only set valid commands.
> 
> I see you also define aliases that reassign the roles of bitfields
> depending on the command. I think you can harden that by having an
> `impl` block for `GPU_COMMAND` with constructor methods for each command
> taking exactly the arguments it needs. These constructors could then
> build the proper value using one of the aliases register, otherwise you
> are at risk of setting e.g. the `Reset` command on the
> `GPU_COMMAND_FLUSH` alias.

I'll add this to v3. So, instead of implementing a default() for each
alias register, I will make those alias registers private and force them
to be used through GPU_COMMAND methods like this:

impl GPU_COMMAND {
        pub(crate) fn reset(mode: ResetMode) -> Self {
            Self::from_raw(
                GPU_COMMAND_RESET::zeroed()
                    .with_command(GpuCommand::Reset)
                    .with_reset_mode(mode)
                    .into_raw(),
            )
        }

and use it like:
 io.write_reg(GPU_COMMAND::reset(ResetMode::SoftReset));

> 
> > +
> > +    register! {
> > +        /// GPU command register in reset mode.
> > +        /// Set command to [`GPU_COMMAND::RESET`] to set reset_mode.
> > +        pub(crate) GPU_COMMAND_RESET (u32) => GPU_COMMAND {
> > +            7:0     command;
> > +            11:8    reset_mode;
> > +        }
> > +    }
> > +
> > +    impl GPU_COMMAND_RESET {
> > +        /// Stop all external bus interfaces, then reset the entire GPU.
> > +        pub(crate) const SOFT_RESET: u32 = 1;
> > +        /// Force a full GPU reset.
> > +        pub(crate) const HARD_RESET: u32 = 2;
> > +    }
> > +
> > +    register! {
> > +        /// GPU command register in cache flush mode.
> > +        /// Set command to [`GPU_COMMAND::FLUSH_CACHES`] to set flush modes.
> > +        pub(crate) GPU_COMMAND_FLUSH (u32) => GPU_COMMAND {
> > +            7:0     command;
> > +            /// L2 cache flush mode.
> > +            11:8    l2_flush;
> > +            /// Shader core load/store cache flush mode.
> > +            15:12   lsc_flush;
> > +            /// Shader core other caches flush mode.
> > +            19:16   other_flush;
> > +        }
> > +    }
> > +
> > +    impl GPU_COMMAND_FLUSH {
> > +        /// No flush.
> > +        pub(crate) const NONE: u32 = 0;
> > +        /// Clean the caches.
> > +        pub(crate) const CLEAN: u32 = 1;
> > +        /// Invalidate the caches.
> > +        pub(crate) const INVALIDATE: u32 = 2;
> > +        /// Clean and invalidate the caches.
> > +        pub(crate) const CLEAN_INVALIDATE: u32 = 3;
> > +    }
> > +
> > +    register! {
> > +        /// GPU status register. Read only.
> > +        pub(crate) GPU_STATUS(u32) @ 0x34 {
> > +            /// GPU active.
> > +            0:0     gpu_active;
> > +            /// Power manager active.
> > +            1:1     pwr_active;
> > +            /// Page fault active.
> > +            4:4     page_fault;
> > +            /// Protected mode active.
> > +            7:7     protected_mode_active;
> > +            /// Debug mode active.
> > +            8:8     gpu_dbg_enabled;
> > +        }
> > +
> > +        /// GPU fault status register. Read only.
> > +        pub(crate) GPU_FAULTSTATUS(u32) @ 0x3c {
> > +            /// Exception type.
> > +            7:0     exception_type;
> > +            /// Access type.
> > +            9:8     access_type;
> > +            /// The GPU_FAULTADDRESS is valid.
> > +            10:10   address_valid;
> > +            /// The JASID field is valid.
> > +            11:11   jasid_valid;
> > +            /// JASID of the fault, if known.
> > +            15:12   jasid;
> > +            /// ID of the source that triggered the fault.
> > +            31:16   source_id;
> > +        }
> > +    }
> > +
> > +    impl GPU_FAULTSTATUS {
> > +        /// Exception type: No error.
> > +        pub(crate) const EXCEPTION_OK: u32 = 0x00;
> > +        /// Exception type: GPU external bus error.
> > +        pub(crate) const EXCEPTION_GPU_BUS_FAULT: u32 = 0x80;
> > +        /// Exception type: GPU shareability error.
> > +        pub(crate) const EXCEPTION_GPU_SHAREABILITY_FAULT: u32 = 0x88;
> > +        /// Exception type: System shareability error.
> > +        pub(crate) const EXCEPTION_SYSTEM_SHAREABILITY_FAULT: u32 = 0x89;
> > +        /// Exception type: GPU cacheability error.
> > +        pub(crate) const EXCEPTION_GPU_CACHEABILITY_FAULT: u32 = 0x8A;
> > +
> > +        /// Access type: An atomic (read/write) transaction.
> > +        pub(crate) const ACCESS_ATOMIC: u32 = 0;
> > +        /// Access type: An execute transaction.
> > +        pub(crate) const ACCESS_EXECUTE: u32 = 1;
> > +        /// Access type: A read transaction.
> > +        pub(crate) const ACCESS_READ: u32 = 2;
> > +        /// Access type: A write transaction.
> > +        pub(crate) const ACCESS_WRITE: u32 = 3;
> 
> Since these consts cover all the possible values of `access_type`, you
> can use the `=>` syntax for it and implement `From<Bounded<u32, 2>>`
> instead of `TryFrom`. This will make the getter infallible as there are
> no invalid values.

Thanks, that works.

> 
> > +    }
> > +
> > +    register! {
> > +        /// GPU fault address. Read only.
> > +        /// Once a fault is reported, it must be manually cleared by issuing a
> > +        /// [`GPU_COMMAND::CLEAR_FAULT`] command to the [`GPU_COMMAND`] register. No further GPU
> > +        /// faults will be reported until the previous fault has been cleared.
> > +        pub(crate) GPU_FAULTADDRESS(u64) @ 0x40 {
> > +            63:0    pointer;
> > +        }
> > +
> > +        /// Level 2 cache configuration.
> > +        pub(crate) L2_CONFIG(u32) @ 0x48 {
> > +            /// Requested cache size.
> > +            23:16   cache_size;
> > +            /// Requested hash function index.
> > +            31:24   hash_function;
> > +        }
> > +
> > +        /// Power state key. Write only.
> > +        pub(crate) PWR_KEY(u32) @ 0x50 {
> > +            /// Set to [`PWR_KEY::KEY_UNLOCK`] to unlock writes to other power state registers.
> > +            31:0    key;
> > +        }
> > +    }
> > +
> > +    impl PWR_KEY {
> > +        /// Key value to unlock writes to other power state registers.
> > +        /// This value was generated at random.
> > +        pub(crate) const KEY_UNLOCK: u32 = 0x2968A819;
> 
> Note that you can also create constants of the register type directly,
> so you don't need to reconstruct one using this value.
>

I'm going to take this constant out for v3 as Daniel requested, but
will keep this in mind for future registers.

> > +    }
> > +
> > +    register! {
> > +        /// Power manager override settings.
> > +        pub(crate) PWR_OVERRIDE0(u32) @ 0x54 {
> > +            /// Override the PWRUP signal.
> > +            1:0     pwrup_override;
> > +            /// Override the ISOLATE signal.
> > +            3:2     isolate_override;
> > +            /// Override the RESET signal.
> > +            5:4     reset_override;
> > +            /// Override the PWRUP_ACK signal.
> > +            9:8     pwrup_ack_override;
> > +            /// Override the ISOLATE_ACK signal.
> > +            11:10   isolate_ack_override;
> > +            /// Override the FUNC_ISOLATE signal.
> > +            13:12   func_iso_override;
> > +            /// Override the FUNC_ISOLATE_ACK signal.
> > +            15:14   func_iso_ack_override;
> > +            /// Maximum number of power transitions.
> > +            21:16   pwrtrans_limit;
> > +            /// Core startup throttling enabled.
> > +            23:23   throttle_enable;
> > +            /// Maximum number of simultaneous core startups.
> > +            29:24   throttle_limit;
> > +        }
> > +    }
> > +
> > +    /// Power override mode constants (`pwr_override_t` in hardware spec).
> > +    ///
> > +    /// These constants can be used with any field in [`PWR_OVERRIDE0`] that ends with
> > +    /// the `_override` suffix.
> > +    impl PWR_OVERRIDE0 {
> > +        /// The signal behaves normally.
> > +        pub(crate) const NONE: u32 = 0;
> > +        /// The signal is inverted (on when normally off, and off when normally on).
> > +        pub(crate) const INVERT: u32 = 1;
> > +        /// The signal is always kept on.
> > +        pub(crate) const ON: u32 = 2;
> > +        /// The signal is always kept off.
> > +        pub(crate) const OFF: u32 = 3;
> > +    }
> > +
> > +    register! {
> > +        /// Power manager override settings for device manufacturer.
> > +        pub(crate) PWR_OVERRIDE1(u32) @ 0x58 {
> > +            31:0    pwrtrans_vendor;
> > +        }
> > +
> > +        /// Global time stamp offset.
> > +        pub(crate) TIMESTAMP_OFFSET(u64) @ 0x88 {
> > +            63:0    offset;
> > +        }
> > +
> > +        /// GPU cycle counter. Read only.
> > +        pub(crate) CYCLE_COUNT(u64) @ 0x90 {
> > +            63:0    count;
> > +        }
> > +
> > +        /// Global time stamp. Read only.
> > +        pub(crate) TIMESTAMP(u64) @ 0x98 {
> > +            63:0    timestamp;
> > +        }
> > +
> > +        /// Maximum number of threads per core. Read only constant.
> > +        pub(crate) THREAD_MAX_THREADS(u32) @ 0xa0 {
> > +            31:0    threads;
> > +        }
> > +
> > +        /// Maximum number of threads per workgroup. Read only constant.
> > +        pub(crate) THREAD_MAX_WORKGROUP_SIZE(u32) @ 0xa4 {
> > +            31:0    threads;
> > +        }
> > +
> > +        /// Maximum number of threads per barrier. Read only constant.
> > +        pub(crate) THREAD_MAX_BARRIER_SIZE(u32) @ 0xa8 {
> > +            31:0    threads;
> > +        }
> > +
> > +        /// Thread features. Read only constant.
> > +        pub(crate) THREAD_FEATURES(u32) @ 0xac {
> > +            /// Total number of registers per core.
> > +            21:0    max_registers;
> > +            /// Implementation technology type.
> > +            23:22   implementation_technology;
> 
> Here as well you will probably want an enum type for the values.

I've changed all the constants to enums for v3 which I will send
probably next week. Thanks again for this macro and your review.

