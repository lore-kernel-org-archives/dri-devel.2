Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6C9E9A75A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:03:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B29A10E124;
	Tue, 24 Mar 2026 10:03:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="RUomq8Gn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04CD010E5CA
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774346613;
 bh=aPStUC/ZuCndm5j5g0cYb4k81eYgNWqdVUNBtJyi7h8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RUomq8Gnc4HKE5XwWpa+NRDQO9lPcjOyKizw2fPjypG1RtjBLM19bE2RdRwVPzBnz
 Yr8CR173QQZEO4l+sb2k0CK+pQAfAcvGevBms3sS06zuOuWO8u9yRXhvscrRPckgrj
 RX+SXz2NmevK6Zr8nUgKMMV1kV304ghmjt19nx1zyWwAfcxJdew10o9DWf/1bgV7uR
 BRDGuQHPAnI1imEuUKawViwVlPdg3IjrXFzmx5RQhQtvc+Vdk/3z0tD9qFOd/KTwpe
 RlPjwJPlqxOJ35weW1UCTdmInHOwPQBD53L9Yn7IngYrmxuGyn2ToR9qDfW7EEYrpz
 6kSNXqP+5eZbA==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1212F17E4683;
 Tue, 24 Mar 2026 11:03:33 +0100 (CET)
Date: Tue, 24 Mar 2026 11:03:29 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, Boqun
 Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Miguel Ojeda
 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Steven
 Price <steven.price@arm.com>, Dirk Behme <dirk.behme@gmail.com>, Alexandre
 Courbot <acourbot@nvidia.com>
Subject: Re: [PATCH v3 07/12] drm/tyr: Add MMU address space registers
Message-ID: <20260324110329.20b71403@fedora>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-7-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
 <20260323-b4-tyr-use-register-macro-v3-v3-7-a87daf9e4701@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
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

On Mon, 23 Mar 2026 17:18:09 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> Add a new module for the per-address-space MMU registers and constants.
> Leave the more complex register field definitions empty for now; they
> will be filled in by follow-up commits.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/tyr/regs.rs | 66 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index f337d99387417a2eca94cd2d7ce8c8fa38bb1cee..428b6d8c4d6bfd341713bbb7d79e0556a2d04415 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -852,4 +852,70 @@ pub(crate) mod mmu_control {
>              31:16   command_completed;
>          }
>      }
> +
> +    /// Per-address space registers ASn [0..15] within the MMU_CONTROL page.
> +    ///
> +    /// This array contains 16 instances of the MMU_AS_CONTROL register page.
> +    pub(crate) mod mmu_as_control {
> +        use kernel::register;
> +
> +        /// Maximum number of hardware address space slots.
> +        /// The actual number of slots available is usually lower.
> +        pub(crate) const MAX_AS: usize = 16;
> +
> +        /// Address space register stride. The elements in the array are spaced 64B apart.
> +        const STRIDE: usize = 0x40;
> +
> +        register! {
> +            /// Translation table base address. A 64-bit pointer.
> +            ///
> +            /// This field contains the address of the top level of a translation table structure.
> +            /// This must be 16-byte-aligned, so address bits [3:0] are assumed to be zero.
> +            pub(crate) TRANSTAB(u64)[MAX_AS, stride = STRIDE] @ 0x2400 {
> +                /// Base address of the translation table.
> +                63:0    base;
> +            }
> +
> +            /// Memory attributes.
> +            ///
> +            /// Each address space can configure up to 8 different memory attribute profiles.
> +            /// Each attribute profile follows the MMU_MEMATTR_STAGE1 layout.
> +            pub(crate) MEMATTR(u64)[MAX_AS, stride = STRIDE] @ 0x2408 {}
> +
> +            /// Lock region address for each address space.
> +            pub(crate) LOCKADDR(u64)[MAX_AS, stride = STRIDE] @ 0x2410 {
> +                /// Lock region size.
> +                5:0     size;
> +                /// Lock region base address.
> +                63:12   base;
> +            }
> +
> +            /// MMU command register for each address space. Write only.
> +            pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {}
> +
> +            /// Fault status register for each address space. Read only.
> +            pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {}
> +
> +            /// Fault address for each address space. Read only.
> +            pub(crate) FAULTADDRESS(u64)[MAX_AS, stride = STRIDE] @ 0x2420 {
> +                63:0    pointer;
> +            }
> +
> +            /// MMU status register for each address space. Read only.
> +            pub(crate) STATUS(u32)[MAX_AS, stride = STRIDE] @ 0x2428 {
> +                /// External address space command is active, a 1-bit boolean flag.
> +                0:0     active_ext => bool;
> +                /// Internal address space command is active, a 1-bit boolean flag.
> +                1:1     active_int => bool;
> +            }
> +
> +            /// Translation configuration and control.
> +            pub(crate) TRANSCFG(u64)[MAX_AS, stride = STRIDE] @ 0x2430 {}
> +
> +            /// Extra fault information for each address space. Read only.
> +            pub(crate) FAULTEXTRA(u64)[MAX_AS, stride = STRIDE] @ 0x2438 {
> +                63:0    value;
> +            }
> +        }
> +    }
>  }
> 

