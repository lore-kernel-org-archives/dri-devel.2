Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DABE9A75C
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:09:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8A5110E5EC;
	Tue, 24 Mar 2026 10:09:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="cFcLr+WM";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4404B10E5EC
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774346985;
 bh=EmSK1NmODGPTmWsvl2Dg9Urj+SEymU4OA3hU/sFRKrI=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cFcLr+WMGQlg+lshHwi0TQDl/mtB3kwNqDWqebTgVn1nT3INsiiUhBc7/shweQryQ
 lgGA8ghDyPCxGKhCOkzjC4ZhPDcwnqxUSh0Ap3EQKXeA+3WQF3LQug2xkt3TOXHhz2
 AaMcRyUyc9Cqeb4xwEwzn0KE48WT7KGyAOMv6huXcFKTLhp/hV2Qz+8u7Mw2mlDGnb
 bmMJr6/kzxCZZQ7M0aS+0RiPJ2cap3E0I2SBKYfmf8r1lt2WdtVIMoWA/V4rT/v3lo
 UqVCbpj+WtS9oUBW+RMvvPNYzG3F6U2N4hgLIITM2slFIIrPVnSHzgLQmiwPPLTG+I
 bugaWfDq/bg9A==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3EDD917E59A9;
 Tue, 24 Mar 2026 11:09:44 +0100 (CET)
Date: Tue, 24 Mar 2026 11:09:40 +0100
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
Subject: Re: [PATCH v3 09/12] drm/tyr: Add fields for COMMAND register
Message-ID: <20260324110940.7076a26b@fedora>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-9-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
 <20260323-b4-tyr-use-register-macro-v3-v3-9-a87daf9e4701@collabora.com>
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

On Mon, 23 Mar 2026 17:18:11 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> The MMU COMMAND register accepts specific commands. Enumerate those
> commands and use the register! macro to ensure that only those commands
> can be written to the MMU COMMAND register.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Though I'm wondering why we do that in multiple steps. I'd rather have
a single commit defining everything MMU related (basically patches 5 and
7-11 merged into a single commit).

> ---
>  drivers/gpu/drm/tyr/regs.rs | 47 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index 9bf2723ab6412034be9a77930532cc89d0adb128..6fbd6268724eb6b2ea8d76c5d991353dcbe87068 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -1048,8 +1048,53 @@ fn from(val: MMU_MEMATTR_STAGE1) -> Self {
>                  63:12   base;
>              }
>  

nit: do we need an extra blank line here?

> +        }
> +
> +        /// Helpers for MMU COMMAND register.
> +        #[derive(Copy, Clone, Debug)]
> +        #[repr(u8)]
> +        pub(crate) enum MmuCommand {
> +            /// No operation, nothing happens.
> +            Nop = 0,
> +            /// Propagate settings to the MMU.
> +            Update = 1,
> +            /// Lock an address region.
> +            Lock = 2,
> +            /// Unlock an address region.
> +            Unlock = 3,
> +            /// Clean and invalidate the L2 cache, then unlock.
> +            FlushPt = 4,
> +            /// Clean and invalidate all caches, then unlock.
> +            FlushMem = 5,
> +        }
> +
> +        impl TryFrom<Bounded<u32, 8>> for MmuCommand {
> +            type Error = Error;
> +
> +            fn try_from(val: Bounded<u32, 8>) -> Result<Self, Self::Error> {
> +                match val.get() {
> +                    0 => Ok(MmuCommand::Nop),
> +                    1 => Ok(MmuCommand::Update),
> +                    2 => Ok(MmuCommand::Lock),
> +                    3 => Ok(MmuCommand::Unlock),
> +                    4 => Ok(MmuCommand::FlushPt),
> +                    5 => Ok(MmuCommand::FlushMem),
> +                    _ => Err(EINVAL),
> +                }
> +            }
> +        }
> +
> +        impl From<MmuCommand> for Bounded<u32, 8> {
> +            fn from(cmd: MmuCommand) -> Self {
> +                (cmd as u8).into()
> +            }
> +        }
> +
> +        register! {
>              /// MMU command register for each address space. Write only.
> -            pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {}
> +            pub(crate) COMMAND(u32)[MAX_AS, stride = STRIDE] @ 0x2418 {
> +                7:0     command ?=> MmuCommand;
> +            }
>  
>              /// Fault status register for each address space. Read only.
>              pub(crate) FAULTSTATUS(u32)[MAX_AS, stride = STRIDE] @ 0x241c {}
> 

