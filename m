Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23CFFF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36FDE10E2F8;
	Tue, 28 Apr 2026 16:42:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="dYbBmawO";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B290910E2F8
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 16:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777394499; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HYy/rLMbmbst3Vfjb5hFmZaLPL+TqdQd57PZL7UFGOdqLKDGBtkUD/UOMGXDLTnX7bmW/kFjXC7NZexu8j9x+6k97QhD5Wlt+E8JPdzRfH9mLgpcgEAhIas4LwnJ+h0kylxQ3RareyV8bdV7WRKqtIYOkYuQcSvvcXP4UIzSYSc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777394499;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=8aR5apHjzAUOsN70nMOy/vTKyUTNnpXZ3q7JDGCeIlo=; 
 b=HiX78neaU/HCcbQkTcYd8ivKi9ZRoIlKGdiDcAl9DYg/LEPAgU8X0BzdCG++ZDJgFuvZo/IxS2NTAW42qmlzwyt67QxCCe6WVgkDu9PujhaOlYAFuXLTXff3SopDdA7ANcqZklVIYNBwmLwmCigwwwRu/W1mM691F2qC4hxt1vc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777394499; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
 bh=8aR5apHjzAUOsN70nMOy/vTKyUTNnpXZ3q7JDGCeIlo=;
 b=dYbBmawOJYMS9U8rN0DqCeYIVVt8x9TohsUkpydxedP6MmVCYmdYbAK2U3vEHEw3
 s1y7Y2cBYVECoIXi6MRA1zuSW6CEXzzsQISjvVtDKrvf15RAARxRcyVQ/5iL4Zo2clp
 ciWmcgX3BrHGbvlnr3gTm6if7hifYBuna22QWESQ=
Received: by mx.zohomail.com with SMTPS id 1777394497407263.89744176832005;
 Tue, 28 Apr 2026 09:41:37 -0700 (PDT)
Date: Tue, 28 Apr 2026 09:41:36 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, beata.michalska@arm.com,
 lyude@redhat.com, acourbot@nvidia.com, work@onurozkan.dev,
 alvin.sun@linux.dev
Subject: Re: [PATCH v4 00/20] drm/tyr: firmware loading and MCU boot support
Message-ID: <afDjQMYam_XjGC5q@um790>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <20260427100704.02190859@fedora> <afCSUYIbV2ibZuOM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afCSUYIbV2ibZuOM@google.com>
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

On Tue, Apr 28, 2026 at 10:56:17AM +0000, Alice Ryhl wrote:
> On Mon, Apr 27, 2026 at 10:07:04AM +0200, Boris Brezillon wrote:
> > On Fri, 24 Apr 2026 16:38:54 -0700
> > Deborah Brouwer <deborah.brouwer@collabora.com> wrote:
> > 
> > > This series adds firmware loading and MCU boot support to the Tyr DRM
> > > driver. It includes:
> > >  - A parser for the Mali CSF firmware binary format
> > >  - A kernel-managed BO type (KernelBo) for internal driver allocations
> > >  - GPU virtual memory (VM) integration using drm_gpuvm
> > >  - An MMU module and a generic slot manager
> > >  - Shmem-backed GEM support for Tyr
> > >  - Loading firmware, VM activation, and MCU boot at probe()
> > >  - Initialization of Command Stream Frontend (CSF) firmware interfaces
> > > 
> > > Dependencies:
> > >  - [PATCH v12 0/5] Rust bindings for gem shmem
> > >     https://lore.kernel.org/rust-for-linux/20260421235346.672794-1-lyude@redhat.com
> > > 
> > >  - [PATCH v6 0/5] Rust GPUVM immediate mode
> > >     https://lore.kernel.org/rust-for-linux/20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com/
> > > 
> > >  - [PATCH v6 0/5] Introduce DeviceContext
> > >     https://lore.kernel.org/rust-for-linux/20260320233645.950190-1-lyude@redhat.com/
> > > 
> > >  - [PATCH v5 0/6] drm/tyr: Use register! macro
> > >     https://lore.kernel.org/rust-for-linux/20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com/
> > > 
> > > Other Prerequisites:
> > >  This series also depends on additional prerequisite fixes not included in
> > >  this posting. The full stack (base + prerequisites + this series) is
> > >  available here:
> > >   https://gitlab.freedesktop.org/dbrouwer/linux/-/tree/dbrouwer/fw-boot
> > >     
> > >   Development history / discussion:
> > >    https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/56
> > >     
> > > 
> > > ---
> > > Changes in v4:
> > >  New commits:
> > >   - drm/tyr: program CSF global interface
> > >   - rust: time: add arch_timer_get_rate wrapper
> > >   - drm/tyr: add CSF firmware interface support
> > >   - drm/tyr: validate presence of CSF shared section
> > >   - drm/tyr: wait for global interface readiness
> > >   - drm/tyr: add Job IRQ handling
> > >   - drm/tyr: add Wait type for GPU events
> > > 
> > >  The existing commits from v3 remain unchanged.
> > >  - Link to v3: https://lore.kernel.org/r/20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com
> > >     
> > > Changes in v3:
> > >  New commits:
> > >   - drm/tyr: remove unused device from platform data
> > >   - drm/tyr: use shmem GEM object type in TyrDrmDriver
> > >     
> > >  drm/tyr: select required dependencies in Kconfig
> > >   - Rename commit since the dependencies are not limited to DRM.
> > >   - Select new RUST_DRM_GEM_SHMEM_HELPER instead of DRM_GEM_SHMEM_HELPER.
> > >     
> > >  drm/tyr: set DMA mask using GPU physical address
> > >   - Use register macro to read pa_bits instead of separate helper function.
> > >     
> > >  drm/tyr: add MMU module
> > >   - Switch MMU code to typed register APIs (TRANSCFG, MEMATTR, STATUS, LOCKADDR, etc.).
> > >   - Use MmuCommand enum for MMU commands instead of raw constants.
> > >   - Minor cleanups and renaming (MAX_AS, AS_PRESENT handling).
> > >     
> > >  drm/tyr: add GPU virtual memory module
> > >   - Extract VA/PA bits via typed MMU_FEATURES register.
> > >   - Update the VM code to match the new GPUVM v6 and shmem GEM v10 APIs.
> > >     
> > >  drm/tyr: add a kernel buffer object
> > >   - Reject zero-sized KernelBo allocations up front.
> > >     
> > >  drm/tyr: add firmware loading and MCU boot support
> > >   - Use typed GPU control registers.
> > >   - Pass iomem by Arc into Firmware::new() since we store it eventually.
> > >     
> > >   - Link to v2: https://lore.kernel.org/rust-for-linux/20260302232500.244489-1-deborah.brouwer@collabora.com/
> > >     
> > > Changes in v2:
> > >  - The whole series is rebased on drm-rust-next including v7.0-rc1.
> > >  - Each patch has its own changelog.
> > >     
> > >  Link to v1: https://lore.kernel.org/rust-for-linux/20260212013713.304343-1-deborah.brouwer@collabora.com/
> > > 
> > > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> > > 
> > > ---
> > > Alvin Sun (1):
> > >       drm/tyr: use shmem GEM object type in TyrDrmDriver
> > > 
> > > Beata Michalska (1):
> > >       drm/tyr: set DMA mask using GPU physical address
> > > 
> > > Boris Brezillon (5):
> > >       drm/tyr: select required dependencies in Kconfig
> > >       drm/tyr: rename TyrObject to BoData
> > >       drm/tyr: Add generic slot manager
> > >       drm/tyr: add MMU module
> > >       drm/tyr: add GPU virtual memory module
> > > 
> > > Daniel Almeida (1):
> > >       drm/tyr: add parser for firmware binary
> > > 
> > > Deborah Brouwer (12):
> > >       drm/tyr: remove unused device from platform data
> > >       drm/tyr: move clock cleanup into Clocks Drop impl
> > >       drm/tyr: add shmem backing for GEM objects
> > >       drm/tyr: add a kernel buffer object
> > >       drm/tyr: add firmware loading and MCU boot support
> > >       drm/tyr: add Wait type for GPU events
> > >       drm/tyr: add Job IRQ handling
> > >       drm/tyr: wait for global interface readiness
> > >       drm/tyr: validate presence of CSF shared section
> > >       drm/tyr: add CSF firmware interface support
> > >       rust: time: add arch_timer_get_rate wrapper
> > >       drm/tyr: program CSF global interface
> > 
> > This series starts to be quite big, and it seems new features have been
> > added to v4 (interactions with the FW). I'd recommend that we extract
> > the uncontroversial bits (I'd say patch 1-2, 4-7) or have them applied
> > to drm-rust-next right away. I know it's tempting to add features
> > between revisions, but the more you do that the longer it will take to
> > get the foundation merged.
> 
> How about I pick up patches 1, 3, 4, 5, 6, 7 for drm-rust-next now?

Don't pick patch 1 because it depends on the Device Context series.
The DRM device only because redundant once it's Registered, so we can't
remove it yet.

Patch 3: "drm/tyr: move clock cleanup into Clocks Drop impl" applies
cleanly to drm-rust-next so that could go.

Patches 4-7 need conflict resolution.

How about I prepare a new series of stuff that could go in
immediately and that will at least make this fw-boot series shorter?

> 
> Otherwise yeah I agree it's better to split up work and have multiple
> series that depend on each other, because then I can just pick up whole
> series on their own as they reach a finished state.

Ack.

> 
> Alice
