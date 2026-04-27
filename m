Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E2BFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:07:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95FD10E325;
	Mon, 27 Apr 2026 08:07:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="TrNUXc8F";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDB2310E325
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777277230;
 bh=CCMqQN2VJBT7WuSG72/R/wV36D+EamYT4PUew6KuDX8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=TrNUXc8F2KbQSgnvz1mDsxNrpiHNGhU/ObG8AkraI8shTKwF85TT7phDMcz+hNCk+
 gYnvYK+kYXtqZeBJB8RJMFl2EgXytQ0xIg7IHHr573bVyNFzqxvPK2IPsV4bbwdYco
 M2P6Yxu+YCkzed2VVrDH4bx67GoE5Q2N3mDg1xmI8XVu2kXlP9rDJ5v5Pk98AiSb2o
 rw5dS/WyR14EqVS69yZNd2Y1Q+yNo1y/QgOr7MZs8s9Jk0mfe0nGZ5IGoicRotT06D
 PgxTvPcCbWZSAiXSOKW1+qa45fN8GY6N5F1fXr8q2vACeaDBKOLBsmF7Qsnn3I2ZJ1
 PZmUyntC+sxUg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 71C5A17E0D23;
 Mon, 27 Apr 2026 10:07:09 +0200 (CEST)
Date: Mon, 27 Apr 2026 10:07:04 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Alice Ryhl
 <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Benno Lossin
 <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy
 Baron <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com,
 work@onurozkan.dev, alvin.sun@linux.dev
Subject: Re: [PATCH v4 00/20] drm/tyr: firmware loading and MCU boot support
Message-ID: <20260427100704.02190859@fedora>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Fri, 24 Apr 2026 16:38:54 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> This series adds firmware loading and MCU boot support to the Tyr DRM
> driver. It includes:
>  - A parser for the Mali CSF firmware binary format
>  - A kernel-managed BO type (KernelBo) for internal driver allocations
>  - GPU virtual memory (VM) integration using drm_gpuvm
>  - An MMU module and a generic slot manager
>  - Shmem-backed GEM support for Tyr
>  - Loading firmware, VM activation, and MCU boot at probe()
>  - Initialization of Command Stream Frontend (CSF) firmware interfaces
> 
> Dependencies:
>  - [PATCH v12 0/5] Rust bindings for gem shmem
>     https://lore.kernel.org/rust-for-linux/20260421235346.672794-1-lyude@redhat.com
> 
>  - [PATCH v6 0/5] Rust GPUVM immediate mode
>     https://lore.kernel.org/rust-for-linux/20260409-gpuvm-rust-v6-0-b16e6ada7261@google.com/
> 
>  - [PATCH v6 0/5] Introduce DeviceContext
>     https://lore.kernel.org/rust-for-linux/20260320233645.950190-1-lyude@redhat.com/
> 
>  - [PATCH v5 0/6] drm/tyr: Use register! macro
>     https://lore.kernel.org/rust-for-linux/20260409-b4-tyr-use-register-macro-v5-v5-0-8abfff8a0204@collabora.com/
> 
> Other Prerequisites:
>  This series also depends on additional prerequisite fixes not included in
>  this posting. The full stack (base + prerequisites + this series) is
>  available here:
>   https://gitlab.freedesktop.org/dbrouwer/linux/-/tree/dbrouwer/fw-boot
>     
>   Development history / discussion:
>    https://gitlab.freedesktop.org/panfrost/linux/-/merge_requests/56
>     
> 
> ---
> Changes in v4:
>  New commits:
>   - drm/tyr: program CSF global interface
>   - rust: time: add arch_timer_get_rate wrapper
>   - drm/tyr: add CSF firmware interface support
>   - drm/tyr: validate presence of CSF shared section
>   - drm/tyr: wait for global interface readiness
>   - drm/tyr: add Job IRQ handling
>   - drm/tyr: add Wait type for GPU events
> 
>  The existing commits from v3 remain unchanged.
>  - Link to v3: https://lore.kernel.org/r/20260413-b4-fw-boot-v3-v3-0-b422f3c03885@collabora.com
>     
> Changes in v3:
>  New commits:
>   - drm/tyr: remove unused device from platform data
>   - drm/tyr: use shmem GEM object type in TyrDrmDriver
>     
>  drm/tyr: select required dependencies in Kconfig
>   - Rename commit since the dependencies are not limited to DRM.
>   - Select new RUST_DRM_GEM_SHMEM_HELPER instead of DRM_GEM_SHMEM_HELPER.
>     
>  drm/tyr: set DMA mask using GPU physical address
>   - Use register macro to read pa_bits instead of separate helper function.
>     
>  drm/tyr: add MMU module
>   - Switch MMU code to typed register APIs (TRANSCFG, MEMATTR, STATUS, LOCKADDR, etc.).
>   - Use MmuCommand enum for MMU commands instead of raw constants.
>   - Minor cleanups and renaming (MAX_AS, AS_PRESENT handling).
>     
>  drm/tyr: add GPU virtual memory module
>   - Extract VA/PA bits via typed MMU_FEATURES register.
>   - Update the VM code to match the new GPUVM v6 and shmem GEM v10 APIs.
>     
>  drm/tyr: add a kernel buffer object
>   - Reject zero-sized KernelBo allocations up front.
>     
>  drm/tyr: add firmware loading and MCU boot support
>   - Use typed GPU control registers.
>   - Pass iomem by Arc into Firmware::new() since we store it eventually.
>     
>   - Link to v2: https://lore.kernel.org/rust-for-linux/20260302232500.244489-1-deborah.brouwer@collabora.com/
>     
> Changes in v2:
>  - The whole series is rebased on drm-rust-next including v7.0-rc1.
>  - Each patch has its own changelog.
>     
>  Link to v1: https://lore.kernel.org/rust-for-linux/20260212013713.304343-1-deborah.brouwer@collabora.com/
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> 
> ---
> Alvin Sun (1):
>       drm/tyr: use shmem GEM object type in TyrDrmDriver
> 
> Beata Michalska (1):
>       drm/tyr: set DMA mask using GPU physical address
> 
> Boris Brezillon (5):
>       drm/tyr: select required dependencies in Kconfig
>       drm/tyr: rename TyrObject to BoData
>       drm/tyr: Add generic slot manager
>       drm/tyr: add MMU module
>       drm/tyr: add GPU virtual memory module
> 
> Daniel Almeida (1):
>       drm/tyr: add parser for firmware binary
> 
> Deborah Brouwer (12):
>       drm/tyr: remove unused device from platform data
>       drm/tyr: move clock cleanup into Clocks Drop impl
>       drm/tyr: add shmem backing for GEM objects
>       drm/tyr: add a kernel buffer object
>       drm/tyr: add firmware loading and MCU boot support
>       drm/tyr: add Wait type for GPU events
>       drm/tyr: add Job IRQ handling
>       drm/tyr: wait for global interface readiness
>       drm/tyr: validate presence of CSF shared section
>       drm/tyr: add CSF firmware interface support
>       rust: time: add arch_timer_get_rate wrapper
>       drm/tyr: program CSF global interface

This series starts to be quite big, and it seems new features have been
added to v4 (interactions with the FW). I'd recommend that we extract
the uncontroversial bits (I'd say patch 1-2, 4-7) or have them applied
to drm-rust-next right away. I know it's tempting to add features
between revisions, but the more you do that the longer it will take to
get the foundation merged.
