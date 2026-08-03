Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F291C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 09:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 062BB10E4A6;
	Mon,  3 Aug 2026 09:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="gKNaMr5e";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27AF710E4A6
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 09:00:19 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so2195009f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785747617; x=1786352417; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/MEAqomLnokyVR9AqA64rl9ZYCVmUcv5C80fBRfsQys=;
 b=gKNaMr5eZ9lp13Cf0Q84SoDTamgOMVxrU1ePaXsMIbYadRy4gLNYOhHiVeeQNGldrG
 lYaAjM4OwqHPztZHxD+VvPn+nbV7RGzCnurCxmtIffmIfh2LX3cwQPJaa5zudgC8juC6
 r4TZUDvjRKZt7FLanq7zdSYnSOkDaT5RSu4ylvh18K8zfpOBICeO+wOiDO+9l7qWzaNZ
 f+Y05UMqPQckUFCETfeSjERcul2e//7iv1KqAx5As1jr2nzdqsXqkvmRrzJMH+Ftc1AJ
 +8mBfEmsnIym0kLvvLphOyMRvKm6hC6vJiUjfG5Qgre2R4Z3zCatBcfoOPI4o5eHxcP1
 Nazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785747617; x=1786352417;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/MEAqomLnokyVR9AqA64rl9ZYCVmUcv5C80fBRfsQys=;
 b=XSHEvPOR4B1sjWiFDLTHL/HV0ZoIiAPPeA54+IBrM87HPXTZYLDs/QT53K+5bOkbd9
 5/a+ObAfVt3mfRmGlckIJHNibJ/0u/1sX9nrVA4O0sOZpM7hMy3ItEmIOr9E7IKIGE9+
 rTPIJPHkNdV6ZuEijHOgVXFym4YURKd/IDyhosVCKcc5SNW5L4MKew9mSPyxF7xzxCgV
 NkFtcYaSgRXe6BCopTsPqyV+/01T5aOERQl3gDS+9+gVpt8aRWPwB28XalQTzhmu9hGY
 sVChXWPyCvGutikmZbS9HGN8n6mFpyLsM6OpMNyMlUbyPemylPfCwXFS5BbtlclFlKiW
 rJeA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwBjlKSkJdN4Xn+YjbBqPd6exUMOWVgwTNoks1kRmJiJ8quF8WdOSgrIs3+xo6AGAcI4mn1OHJ+4c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMJKvPTB00Pq680COJen3ppKCQ+tNphWgxunfIoHW2s+glZwQF
 RnGXmHzWBP/sdYRFpHKJbjrpPDRz6Aod2p8S81flAYdasNgiNIMJL2MpPfq44jtkFe8=
X-Gm-Gg: AR+sD10PnUMMQ+jgHnbsQfN+ItcubUyUX27Oq7jE80OjHvv6CJ5kh/U8Jyfv+ap75C7
 u4FU14lLwRLf7yFD+P5geCwWdq2nbKnTbA7JyPdHkCF4kIiwuTIdh+WZOzsNExxdq5krOaVlWBX
 aanzpdkAwiqbVqMevC/fuuqfMj0/OCZfrtscUkFmxr3TohQJuBT2zf6774oe2gG5+9VtUdQm3PK
 3o1hRXHVjcKqRVggaHPZyUACgQPM9Brv0vbLgWBFizfa4VDhDsllPTfhl7bbHJujgLwa3xB+sdw
 jv9Hru1WBTijCiN5acERR3nC5eVJ6HKicZ3+vRz+twkJOIGyc9kg9qFYwaYV5vEGNoapwtzbX7P
 Beo3mnqLwE/408mMsr0nnTBT+p1KtJdZNeDQD69uyuSaa7ceAQyNNAJId8im5SXVVydXQDVrjx/
 wW3kytaNQBcrpOa8/mhxTztvQAXA/9e3qZ91xMx1fvURXKf13ThIV676zmN5NUhUKZVQykbmCMv
 boXW2e7GVVTq/qVspcRWFEnlxo9r3q816s8CqLvNDumhOzicfvfCxGg/aSfnSOOfAZaGwchppbJ
 IXb7/Rql7GQ687ZBJ5h8UT7Ua/Nsy3SHkQFbZz8xIQ==
X-Received: by 2002:a05:600c:871a:b0:498:952:e276 with SMTP id
 5b1f17b1804b1-4980c66c991mr237479075e9.8.1785747617287; 
 Mon, 03 Aug 2026 02:00:17 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807ba13e9sm314596535e9.13.2026.08.03.02.00.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 02:00:16 -0700 (PDT)
Message-ID: <6e9e8189-e27b-4279-9fed-b7da5da62419@suse.com>
Date: Mon, 3 Aug 2026 11:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/10] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann
 <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>,
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>,
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>,
 Carlos Llamas <cmllamas@google.com>, rust-for-linux@vger.kernel.org,
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev,
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260723-fix-fops-owner-v9-0-c1c3af7f7bcb@linux.dev>
 <20260723-fix-fops-owner-v9-2-c1c3af7f7bcb@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260723-fix-fops-owner-v9-2-c1c3af7f7bcb@linux.dev>
Content-Type: text/plain; charset=UTF-8
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

On 7/23/26 4:10 AM, Alvin Sun wrote:
> Since `const_refs_to_static` has been stable as of the MSRV bump, a
> `ThisModule` pointer can now be used in const contexts.
> 
> Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that modules
> can provide their `ThisModule` pointer in const contexts such as static
> `file_operations`.
> 
> Add a `this_module()` helper to retrieve the `THIS_MODULE` pointer of a
> given module type, and update `__init` to use it instead of the
> `THIS_MODULE` static generated by the `module!` macro.
> 
> The `static THIS_MODULE` generated by the `module!` macro is retained
> for backwards compatibility with existing users and removed in a later
> patch once all references have been migrated.
> 
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

> ---
>  rust/kernel/module.rs |  9 +++++++++
>  rust/macros/module.rs | 18 +++++++++++++++++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/module.rs b/rust/kernel/module.rs
> index be242a82e86d2..d713705984477 100644
> --- a/rust/kernel/module.rs
> +++ b/rust/kernel/module.rs
> @@ -42,6 +42,15 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, crate::erro
>  pub trait ModuleMetadata {
>      /// The name of the module as specified in the `module!` macro.
>      const NAME: &'static crate::str::CStr;
> +
> +    /// The module's `THIS_MODULE` pointer.
> +    const THIS_MODULE: ThisModule;
> +}
> +
> +/// Returns a reference to the `THIS_MODULE` of the given module type.
> +#[inline]
> +pub const fn this_module<M: ModuleMetadata>() -> &'static ThisModule {
> +    &M::THIS_MODULE
>  }
>  
>  /// Equivalent to `THIS_MODULE` in the C API.
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index 06c18e2075083..aa9a618d5d19e 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -519,6 +519,22 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
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
> @@ -616,7 +632,7 @@ pub extern "C" fn #ident_exit() {
>                  /// This function must only be called once.
>                  unsafe fn __init() -> ::kernel::ffi::c_int {
>                      let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
> -                        &super::super::THIS_MODULE
> +                        ::kernel::module::this_module::<super::super::LocalModule>()
>                      );
>                      // SAFETY: No data race, since `__MOD` can only be accessed by this module
>                      // and there only `__init` and `__exit` access it. These functions are only
> 

