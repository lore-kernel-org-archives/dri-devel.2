Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20B5CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:05:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E0B10F2CC;
	Thu, 18 Jun 2026 12:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D9eYSOCb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9E810F2AE
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:05:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7C2BF60008;
 Thu, 18 Jun 2026 12:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358E71F000E9;
 Thu, 18 Jun 2026 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781784312;
 bh=/7m6pRIAwNnhYn30G/uLruR9I/DO7DY2hq1NVxPJLqQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=D9eYSOCbhz717Oe7mMlWbPYXyCs1C3gwcsvyV7DF4heD7D5/1gaNIVypVYvCsMamF
 5IKsyJqxdMpwxKGq7aFcbkQymxw9mTFgcLKruBUls24gZuCg3+vcf1BFQc88HtOu5C
 nTq5q2CwEnxksL0kqYfR8i9BTEEBkgD70Q+AjA0VG3DRWmbikCM4QMC9nRdZUXy1zC
 UCI1F/wa3vbMYA0ORLphpra9J21PimsprbIhUmBK3gDRqIi4ZiqRF76YDpWgJyc4dA
 HYnhwUu/EkJ/X8qzzzATFiEMyEwbMp3AAthW0nERlFaGZ6LzGnlWciiihEDh+oP8Qv
 lFdSJ+GZa5zdw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Breno
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, Alvin Sun
 <alvin.sun@linux.dev>
Subject: Re: [PATCH v2 1/7] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
In-Reply-To: <20260521-fix-fops-owner-v2-1-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <nwii7SN7dp9LYlpqQ_H4e9xoec8GK9pzGOYZXi2CEEqSgKU9pTnK_3jgpBToFSsmcAX8XxgQUJt_O1UY1vaNEQ==@protonmail.internalid>
 <20260521-fix-fops-owner-v2-1-fd99079c5a04@linux.dev>
Date: Thu, 18 Jun 2026 14:04:59 +0200
Message-ID: <87ldccf40k.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

"Alvin Sun" <alvin.sun@linux.dev> writes:

> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that
> modules can provide their `ThisModule` pointer usable in const
> contexts such as static file_operations.
>
> Move the `THIS_MODULE` static from the `module!` macro into the
> `ModuleMetadata` impl, and update `__init` to use
> `LocalModule::THIS_MODULE` instead.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/lib.rs    |  3 +++
>  rust/macros/module.rs | 34 +++++++++++++++++-----------------
>  2 files changed, 20 insertions(+), 17 deletions(-)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b72b2fbe046d6..f0cf0705d9697 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -184,6 +184,9 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Erro
>  pub trait ModuleMetadata {
>      /// The name of the module as specified in the `module!` macro.
>      const NAME: &'static crate::str::CStr;
> +
> +    /// The module's `THIS_MODULE` pointer.
> +    const THIS_MODULE: ThisModule;
>  }
>
>  /// Equivalent to `THIS_MODULE` in the C API.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e2075083..b6d7b3299fbf9 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -497,28 +497,28 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
>          /// Used by the printing macros, e.g. [`info!`].
>          const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
>
> -        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
> -        // freed until the module is unloaded.
> -        #[cfg(MODULE)]
> -        static THIS_MODULE: ::kernel::ThisModule = unsafe {
> -            extern "C" {
> -                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
> -            };
> -
> -            ::kernel::ThisModule::from_ptr(__this_module.get())
> -        };
> -
> -        #[cfg(not(MODULE))]
> -        static THIS_MODULE: ::kernel::ThisModule = unsafe {
> -            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> -        };
> -
>          /// The `LocalModule` type is the type of the module created by `module!`,
>          /// `module_pci_driver!`, `module_platform_driver!`, etc.
>          type LocalModule = #type_;
>
>          impl ::kernel::ModuleMetadata for #type_ {
>              const NAME: &'static ::kernel::str::CStr = #name_cstr;
> +
> +            #[cfg(MODULE)]
> +            const THIS_MODULE: ::kernel::ThisModule = {
> +                extern "C" {
> +                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
> +                }
> +
> +                // SAFETY: `__this_module` is constructed by the kernel at load time
> +                // and lives until the module is unloaded.
> +                unsafe { ::kernel::ThisModule::from_ptr(__this_module.get()) }
> +            };
> +
> +            #[cfg(not(MODULE))]
> +            const THIS_MODULE: ::kernel::ThisModule = unsafe {
> +                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
> +            };
>          }
>
>          // Double nested modules, since then nobody can access the public items inside.
> @@ -616,7 +616,7 @@ pub extern "C" fn #ident_exit() {
>                  /// This function must only be called once.
>                  unsafe fn __init() -> ::kernel::ffi::c_int {
>                      let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
> -                        &super::super::THIS_MODULE
> +                        &<super::super::LocalModule as ::kernel::ModuleMetadata>::THIS_MODULE

Is it possible we could make this more ergonomic? Perhaps by adding a
helper:

  fn this_module<M: ::kernel::ModuleMetadata>() -> &'static ::kernel::ThisModule {
      &M::THIS_MODULE
  }

Then the invocation is a little better:

  let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
      this_module::<super::super::LocalModule>()
  );


Best regards,
Andreas Hindborg


