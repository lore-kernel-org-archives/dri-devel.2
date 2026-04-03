Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3320CD730AF
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 07:28:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7708910F214;
	Fri,  3 Apr 2026 07:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="bCqPcf3h";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6017110F295
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1775201286;
 bh=Jzk7/Gtny9pL0AE0z9y8UsAICmwzjMtbca3hpmIcLtc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=bCqPcf3hrxsM6ZrdP1nyQmXNiJVGP7HP0a8vbVSpMxMr19aoRjL6M07jQQ36kpwzV
 AI4cx0L2077wTgpTizF5g1CN/iBwnDqsrIgox94pfC3koeiJdvt8zA8nJdTOUyV1sh
 75UTnlmV0sjeHJUKgk71r47EVkXnEKyUCts/WeE70I9eqTPPXfRFVxwomUNMe3BHOE
 H66qF9cIIBv0L+5NSV5AL4YuVoHAktXpgJnN3s4FrX3zXCNQXKrsabLpulWf3zWRkn
 H9xfygMr2+ieqOn+WWZKEDBmfXNFXPsO6VfS9J5ysvLw5iWF72JVMvfDZWn521gjKF
 1T7dwIZnbmSjw==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 944B617E8632;
 Fri,  3 Apr 2026 09:28:05 +0200 (CEST)
Date: Fri, 3 Apr 2026 09:27:59 +0200
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
Subject: Re: [PATCH v4 3/6] drm/tyr: Use register! macro for JOB_CONTROL
Message-ID: <20260403092759.5d9aabe3@fedora>
In-Reply-To: <20260402-tyr-use-register-macro-v4-v4-3-96a8d42f8bd1@collabora.com>
References: <20260402-tyr-use-register-macro-v4-v4-0-96a8d42f8bd1@collabora.com>
 <20260402-tyr-use-register-macro-v4-v4-3-96a8d42f8bd1@collabora.com>
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

On Thu, 02 Apr 2026 16:35:33 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> Convert the JOB_CONTROL register definitions to use the `register!` macro.
> 
> Using the `register!` macro allows us to replace manual bit masks and
> shifts with typed register and field accessors, which makes the code
> easier to read and avoids errors from bit manipulation.
> 
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  drivers/gpu/drm/tyr/regs.rs | 58 ++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 50 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index d0f99a433dfd1f55b855744abfe26ff9b429f179..54145d90d4922b895a6ebbbd2cda4fddb8488e1a 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -28,7 +28,6 @@
>  #![allow(dead_code)]
>  
>  use kernel::{
> -    bits::bit_u32,
>      device::{
>          Bound,
>          Device, //
> @@ -893,14 +892,57 @@ fn from(status: McuStatus) -> Self {
>      }
>  }
>  
> -pub(crate) const JOB_IRQ_RAWSTAT: Register<0x1000> = Register;
> -pub(crate) const JOB_IRQ_CLEAR: Register<0x1004> = Register;
> -pub(crate) const JOB_IRQ_MASK: Register<0x1008> = Register;
> -pub(crate) const JOB_IRQ_STAT: Register<0x100c> = Register;
> -
> -pub(crate) const JOB_IRQ_GLOBAL_IF: u32 = bit_u32(31);
> -
>  pub(crate) const MMU_IRQ_RAWSTAT: Register<0x2000> = Register;
>  pub(crate) const MMU_IRQ_CLEAR: Register<0x2004> = Register;
>  pub(crate) const MMU_IRQ_MASK: Register<0x2008> = Register;
>  pub(crate) const MMU_IRQ_STAT: Register<0x200c> = Register;
> +
> +/// These registers correspond to the JOB_CONTROL register page.
> +/// They are involved in communication between the firmware running on the MCU and the host.
> +pub(crate) mod job_control {
> +    use kernel::register;
> +
> +    register! {
> +        /// Raw status of job interrupts.
> +        ///
> +        /// Write to this register to trigger these interrupts.
> +        /// Writing a 1 to a bit forces that bit on.
> +        pub(crate) JOB_IRQ_RAWSTAT(u32) @ 0x1000 {
> +            /// CSG request. These bits indicate that CSGn requires attention from the host.
> +            30:0    csg;
> +            /// GLB request. Indicates that the GLB interface requires attention from the host.
> +            31:31   glb;

Any particular reason you didn't go for

		31:31   glb => bool;

here?

> +        }
> +
> +        /// Clear job interrupts. Write only.
> +        ///
> +        /// Write a 1 to a bit to clear the corresponding bit in [`JOB_IRQ_RAWSTAT`].
> +        pub(crate) JOB_IRQ_CLEAR(u32) @ 0x1004 {
> +            /// Clear CSG request interrupts.
> +            30:0    csg;
> +            /// Clear GLB request interrupt.
> +            31:31   glb;
> +        }
> +
> +        /// Mask for job interrupts.
> +        ///
> +        /// Set each bit to 1 to enable the corresponding interrupt source or to 0 to disable it.
> +        pub(crate) JOB_IRQ_MASK(u32) @ 0x1008 {
> +            /// Enable CSG request interrupts.
> +            30:0    csg;
> +            /// Enable GLB request interrupt.
> +            31:31   glb;
> +        }
> +
> +        /// Active job interrupts. Read only.
> +        ///
> +        /// This register contains the result of ANDing together [`JOB_IRQ_RAWSTAT`] and
> +        /// [`JOB_IRQ_MASK`].
> +        pub(crate) JOB_IRQ_STATUS(u32) @ 0x100c {
> +            /// CSG request interrupt status.
> +            30:0    csg;
> +            /// GLB request interrupt status.
> +            31:31   glb;
> +        }
> +    }
> +}
> 

