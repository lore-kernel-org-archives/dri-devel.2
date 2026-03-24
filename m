Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE58FE9A75A
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:01:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 627A410E5C0;
	Tue, 24 Mar 2026 10:01:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oixbzYeV";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7336210E5C0
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1774346512;
 bh=+O7m1ezI184MmOJY15AamoC8+5m12QihJ0loglR+ITM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=oixbzYeVCygon5Gp/wdNbaYYFjOuiTzZYG0C0Zn7u1wDVb/rJODpn48D8rvprLevo
 uXMQSLS+RERaHGk9ZM5cqtcx7VZYEHJsm8rQlb2SNvuzBpkMu9ap2J21I+1SD/oA4i
 IoRTxqgNBSJuPtidUmXv2mQtYAC5QIObPuzLAWHS1TUerAmWBI0YrvHKpE/6bg+Bf4
 EMJN5GgseuQxrNE5Fo0DwdeATdjRR9ptx0LdwrunfGqYSipI+h7UY2V/Cdyo/4/qgo
 kz8REQOA6no7Fsjmk5XKP5GvkDVfxOHatzG38x7yTIllCBAGzxxXS1q0dT3m5d4vxf
 5nIudhi1RQQxg==
Received: from fedora (unknown [IPv6:2a01:e0a:2c:6930:d919:a6e:5ea1:8a9f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6A4F417E4B9C;
 Tue, 24 Mar 2026 11:01:51 +0100 (CET)
Date: Tue, 24 Mar 2026 11:01:48 +0100
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
Subject: Re: [PATCH v3 05/12] drm/tyr: Use register! macro for MMU_CONTROL
Message-ID: <20260324110148.23fec69e@fedora>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-5-a87daf9e4701@collabora.com>
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
 <20260323-b4-tyr-use-register-macro-v3-v3-5-a87daf9e4701@collabora.com>
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

On Mon, 23 Mar 2026 17:18:07 -0700
Deborah Brouwer <deborah.brouwer@collabora.com> wrote:

> Convert the MMU_CONTROL register definitions to use the `register!` macro.
> 
> Using the `register!` macro allows us to replace manual bit masks and
> shifts with typed register and field accessors, which makes the code
> easier to read and avoids errors from bit manipulation.
> 
> Co-developed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/tyr/regs.rs | 56 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 51 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index bae3f917dd3ad3fe0dfd8425a119347f9d1ebbe8..869bad81d988b4c3d4d65e014d646b6db568e919 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -786,11 +786,6 @@ fn from(status: McuStatus) -> Self {
>      }
>  }
>  
> -pub(crate) const MMU_IRQ_RAWSTAT: Register<0x2000> = Register;
> -pub(crate) const MMU_IRQ_CLEAR: Register<0x2004> = Register;
> -pub(crate) const MMU_IRQ_MASK: Register<0x2008> = Register;
> -pub(crate) const MMU_IRQ_STAT: Register<0x200c> = Register;
> -
>  /// These registers correspond to the JOB_CONTROL register page.
>  /// They are involved in communication between the firmware running on the MCU and the host.
>  pub(crate) mod job_control {
> @@ -840,3 +835,54 @@ pub(crate) mod job_control {
>          }
>      }
>  }
> +
> +/// These registers correspond to the MMU_CONTROL register page.
> +/// They are involved in MMU configuration and control.
> +pub(crate) mod mmu_control {
> +    use kernel::register;
> +
> +    register! {
> +        /// IRQ sources raw status.
> +        ///
> +        /// This register contains the raw unmasked interrupt sources for MMU status and exception
> +        /// handling.
> +        ///
> +        /// Writing to this register forces bits on.
> +        /// Use [`IRQ_CLEAR`] to clear interrupts.
> +        pub(crate) IRQ_RAWSTAT(u32) @ 0x2000 {
> +            /// Page fault for address spaces.
> +            15:0    page_fault;
> +            /// Command completed in address spaces.
> +            31:16   command_completed;
> +        }
> +
> +        /// IRQ sources to clear.
> +        /// Write a 1 to a bit to clear the corresponding bit in [`IRQ_RAWSTAT`].
> +        pub(crate) IRQ_CLEAR(u32) @ 0x2004 {
> +            /// Clear the PAGE_FAULT interrupt.
> +            15:0    page_fault;
> +            /// Clear the COMMAND_COMPLETED interrupt.
> +            31:16   command_completed;
> +        }
> +
> +        /// IRQ sources enabled.
> +        ///
> +        /// Set each bit to 1 to enable the corresponding interrupt source, and to 0 to disable it.
> +        pub(crate) IRQ_MASK(u32) @ 0x2008 {
> +            /// Enable the PAGE_FAULT interrupt.
> +            15:0    page_fault;
> +            /// Enable the COMMAND_COMPLETED interrupt.
> +            31:16   command_completed;
> +        }
> +
> +        /// IRQ status for enabled sources. Read only.
> +        ///
> +        /// This register contains the result of ANDing together [`IRQ_RAWSTAT`] and [`IRQ_MASK`].
> +        pub(crate) IRQ_STATUS(u32) @ 0x200c {
> +            /// PAGE_FAULT interrupt status.
> +            15:0    page_fault;
> +            /// COMMAND_COMPLETED interrupt status.
> +            31:16   command_completed;
> +        }
> +    }
> +}
> 

