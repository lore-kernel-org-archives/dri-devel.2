Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146AFC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 554DA10E02A;
	Mon,  3 Aug 2026 08:59:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="YkpuWsSU";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E95910E02A
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 08:59:03 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso7869345e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785747541; x=1786352341; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FoBzZM7GJglwWICyRFF3DCdpcPLhF81fWV7+YYFxaBI=;
 b=YkpuWsSUCStK5teOSt86Z9XYbwZIOaBG4Cqn9nKVPWU80QMz466AFi77qAIWzGW2/w
 r/dtsw5opBaYHgEuTyxfW4Fmky3y3Di4m5xnwaFhVPIPFq9A6YfNjfGX6Zi9eGRGZp5x
 lEXQV8FfR6Yc/vH0jD5jAh2syza3qk85/MwpAYbMbKk18yZWNHqzL/zsmbpAT1os3VUD
 v17Lc+lY+SROLQsCzibNoQDCGORzMP5HQFKaUzC352PisD8Um4vCLmS2CB5K7zSsNUl8
 xSifvBNg3ShxP5RqylerdnaOUxpTlDa93au0RCblx/fPavqdBeAMDGdHIsMlsoHwaoVP
 a+Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785747541; x=1786352341;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FoBzZM7GJglwWICyRFF3DCdpcPLhF81fWV7+YYFxaBI=;
 b=V16PovSveNUW7gIj4b6oEteJ304q6q7im1xQV5rQ08QSgP1B7ERdrWvV3vTQVS0d8u
 TFNixX6Vytfkl1KPKbuB3Fi5dRoCIE6AaXqz9cS0azZNunbEBxbKNH0Q370ZPfYUTPKE
 DjA3tvoFCzU+9ewQWVJ1aWnwtVTHQOXXCe0oVYCiZIwk9mIEKsnytqoR+1NaozWUCLOq
 D2hBgJ+Sq22rM5DiSecp1+hPpkSKjaS/L27PBPDB8hqFAY0R1Rl9BqvIApkwhMPAxW1y
 DdbQyqL14zqxhASK3rwTKu6/4QFnKtnRDtVlfW4GBpxVZUlf5fctvpxnHHWD33EDf9sD
 5ayg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rondj81wQ6VOVmtWx5nljuBvZ2MDhP5gZFR5YGRhNr4D0gzpyWSJXQGY6bfV9OgVpZL/gwvAduV3u4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxlxh4v/Vq5iP7CjZAUzel2qwoX70gVJFNt3h73u/EreydBVquP
 7CS6Sx5Z3t5OsJkjY99KEmxJDp/s/l0Pb0mKQ2Tn1p/bAKTnAd8OocoVPBwXRMMLuvA=
X-Gm-Gg: AR+sD137ufRx/IfVfCuPxDPEHEgJLQef/IBwNNKZJ14dhs1SD4dGfOb/eHMTe4tBNjC
 r5ECT1Y7J5SkqdGITB97D5SvHM6xfYWi0B+pi55K196JdUE9XuDSSuQRGwCw4SFJy0KjXurcu+X
 NyvooifrAsCG5LAhzV3WRmdeLA76lg87UCw2yMUDVRbFFNu1gT86KkNyUjb5c611SOTxuyayXt9
 WnlMNFyUmnZJPMud4poOwWXAKB/FT4EOAdEbhYk9fJkONw2AmYg1LZCy4o48L9dra28lUbmeGsU
 NBOJGMrhiZcdBCfYQ8x5irxrwlKUhwxzv2omJo+WJPBvlf3UQi4G/fktqt3ksmM+mHBQtVFCr6n
 voJvStoeGFwt6XTG8AgCrdtvg1VU7BjyJjcDM1piRr+vRzIu2fV6lPRJd6oUeG6KOsbC6Lk6s1S
 F7ioBHFRMGEnTmn1tmQ2owP9cBJ2gXsa5YNhWLHQXGJBvFqEyH8tMHd+HYrzel3wQdvogGhiQBS
 krXQhjKDfLLJPIBN+UOqel6+5TvJDXls0jhq/JkfcyPrEK26QmBdwu0ppiDO6zqBKcufFWEgFau
 7PaZBStr8wRdGp/cIpV35tArWID1pk8=
X-Received: by 2002:a05:600c:4708:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-4980eb4e95dmr147582935e9.0.1785747541250; 
 Mon, 03 Aug 2026 01:59:01 -0700 (PDT)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100?
 (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz.
 [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-498081a12a3sm315335175e9.8.2026.08.03.01.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2026 01:59:00 -0700 (PDT)
Message-ID: <30a7f47e-1937-44a0-b8cb-434e8b07ac2b@suse.com>
Date: Mon, 3 Aug 2026 10:58:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/10] rust: module: move module types into `module.rs`
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
 <20260723-fix-fops-owner-v9-1-c1c3af7f7bcb@linux.dev>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260723-fix-fops-owner-v9-1-c1c3af7f7bcb@linux.dev>
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
> Move `Module`, `InPlaceModule`, `ModuleMetadata` and `ThisModule` from
> `lib.rs` into a new `rust/kernel/module.rs`. Re-export them from `lib.rs`
> to avoid tree-wide changes.
> 
> Switch six bus driver registrations from `module.0` to the public
> `ThisModule::as_ptr()` accessor, since the field is no longer visible
> outside the new `module` submodule.
> 
> No functional change.
> 
> Assisted-by: opencode:glm-5.2
> Suggested-by: Gary Guo <gary@garyguo.net>
> Link: https://lore.kernel.org/all/DJFIQPLOVO4T.1K8T0VZM30LDA@garyguo.net/
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Acked-by: Petr Pavlu <petr.pavlu@suse.com>

> ---
>  rust/kernel/auxiliary.rs |  2 +-
>  rust/kernel/i2c.rs       |  2 +-
>  rust/kernel/lib.rs       | 75 +++++-------------------------------------------
>  rust/kernel/module.rs    | 71 +++++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/net/phy.rs   |  6 +++-
>  rust/kernel/pci.rs       |  2 +-
>  rust/kernel/platform.rs  |  2 +-
>  rust/kernel/usb.rs       |  2 +-
>  8 files changed, 88 insertions(+), 74 deletions(-)
> 
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 93c0db1f66555..4a02f83240be3 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -63,7 +63,7 @@ unsafe fn register(
>  
>          // SAFETY: `adrv` is guaranteed to be a valid `DriverType`.
>          to_result(unsafe {
> -            bindings::__auxiliary_driver_register(adrv.get(), module.0, name.as_char_ptr())
> +            bindings::__auxiliary_driver_register(adrv.get(), module.as_ptr(), name.as_char_ptr())
>          })
>      }
>  
> diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
> index 7b908f0c5a58d..24eff08f47123 100644
> --- a/rust/kernel/i2c.rs
> +++ b/rust/kernel/i2c.rs
> @@ -142,7 +142,7 @@ unsafe fn register(
>          }
>  
>          // SAFETY: `idrv` is guaranteed to be a valid `DriverType`.
> -        to_result(unsafe { bindings::i2c_register_driver(module.0, idrv.get()) })
> +        to_result(unsafe { bindings::i2c_register_driver(module.as_ptr(), idrv.get()) })
>      }
>  
>      unsafe fn unregister(idrv: &Opaque<Self::DriverType>) {
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index b72b2fbe046d6..040ae85056509 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -93,6 +93,7 @@
>  pub mod maple_tree;
>  pub mod miscdevice;
>  pub mod mm;
> +pub mod module;
>  pub mod module_param;
>  #[cfg(CONFIG_NET)]
>  pub mod net;
> @@ -139,79 +140,17 @@
>  #[doc(hidden)]
>  pub use bindings;
>  pub use macros;
> +pub use module::{
> +    InPlaceModule,
> +    Module,
> +    ModuleMetadata,
> +    ThisModule, //
> +};
>  pub use uapi;
>  
>  /// Prefix to appear before log messages printed from within the `kernel` crate.
>  const __LOG_PREFIX: &[u8] = b"rust_kernel\0";
>  
> -/// The top level entrypoint to implementing a kernel module.
> -///
> -/// For any teardown or cleanup operations, your type may implement [`Drop`].
> -pub trait Module: Sized + Sync + Send {
> -    /// Called at module initialization time.
> -    ///
> -    /// Use this method to perform whatever setup or registration your module
> -    /// should do.
> -    ///
> -    /// Equivalent to the `module_init` macro in the C API.
> -    fn init(module: &'static ThisModule) -> error::Result<Self>;
> -}
> -
> -/// A module that is pinned and initialised in-place.
> -pub trait InPlaceModule: Sync + Send {
> -    /// Creates an initialiser for the module.
> -    ///
> -    /// It is called when the module is loaded.
> -    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Error>;
> -}
> -
> -impl<T: Module> InPlaceModule for T {
> -    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Error> {
> -        let initer = move |slot: *mut Self| {
> -            let m = <Self as Module>::init(module)?;
> -
> -            // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
> -            unsafe { slot.write(m) };
> -            Ok(())
> -        };
> -
> -        // SAFETY: On success, `initer` always fully initialises an instance of `Self`.
> -        unsafe { pin_init::pin_init_from_closure(initer) }
> -    }
> -}
> -
> -/// Metadata attached to a [`Module`] or [`InPlaceModule`].
> -pub trait ModuleMetadata {
> -    /// The name of the module as specified in the `module!` macro.
> -    const NAME: &'static crate::str::CStr;
> -}
> -
> -/// Equivalent to `THIS_MODULE` in the C API.
> -///
> -/// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
> -pub struct ThisModule(*mut bindings::module);
> -
> -// SAFETY: `THIS_MODULE` may be used from all threads within a module.
> -unsafe impl Sync for ThisModule {}
> -
> -impl ThisModule {
> -    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
> -    ///
> -    /// # Safety
> -    ///
> -    /// The pointer must be equal to the right `THIS_MODULE`.
> -    pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> ThisModule {
> -        ThisModule(ptr)
> -    }
> -
> -    /// Access the raw pointer for this module.
> -    ///
> -    /// It is up to the user to use it correctly.
> -    pub const fn as_ptr(&self) -> *mut bindings::module {
> -        self.0
> -    }
> -}
> -
>  #[cfg(not(testlib))]
>  #[panic_handler]
>  fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
> diff --git a/rust/kernel/module.rs b/rust/kernel/module.rs
> new file mode 100644
> index 0000000000000..be242a82e86d2
> --- /dev/null
> +++ b/rust/kernel/module.rs
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Module-related types and helpers.
> +
> +/// The entrypoint to implementing a kernel module.
> +///
> +/// For any teardown or cleanup operations, your type may implement [`Drop`].
> +pub trait Module: Sized + Sync + Send {
> +    /// Called at module initialization time.
> +    ///
> +    /// Use this method to perform whatever setup or registration your module
> +    /// should do.
> +    ///
> +    /// Equivalent to the `module_init` macro in the C API.
> +    fn init(module: &'static ThisModule) -> crate::error::Result<Self>;
> +}
> +
> +/// A module that is pinned and initialised in-place.
> +pub trait InPlaceModule: Sync + Send {
> +    /// Creates an initialiser for the module.
> +    ///
> +    /// It is called when the module is loaded.
> +    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, crate::error::Error>;
> +}
> +
> +impl<T: Module> InPlaceModule for T {
> +    fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, crate::error::Error> {
> +        let initer = move |slot: *mut Self| {
> +            let m = <Self as Module>::init(module)?;
> +
> +            // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
> +            unsafe { slot.write(m) };
> +            Ok(())
> +        };
> +
> +        // SAFETY: On success, `initer` always fully initialises an instance of `Self`.
> +        unsafe { pin_init::pin_init_from_closure(initer) }
> +    }
> +}
> +
> +/// Metadata attached to a [`Module`] or [`InPlaceModule`].
> +pub trait ModuleMetadata {
> +    /// The name of the module as specified in the `module!` macro.
> +    const NAME: &'static crate::str::CStr;
> +}
> +
> +/// Equivalent to `THIS_MODULE` in the C API.
> +///
> +/// C header: [`include/linux/init.h`](srctree/include/linux/init.h)
> +pub struct ThisModule(*mut crate::bindings::module);
> +
> +// SAFETY: `THIS_MODULE` may be used from all threads within a module.
> +unsafe impl Sync for ThisModule {}
> +
> +impl ThisModule {
> +    /// Creates a [`ThisModule`] given the `THIS_MODULE` pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must be equal to the right `THIS_MODULE`.
> +    pub const unsafe fn from_ptr(ptr: *mut crate::bindings::module) -> ThisModule {
> +        ThisModule(ptr)
> +    }
> +
> +    /// Access the raw pointer for this module.
> +    ///
> +    /// It is up to the user to use it correctly.
> +    pub const fn as_ptr(&self) -> *mut crate::bindings::module {
> +        self.0
> +    }
> +}
> diff --git a/rust/kernel/net/phy.rs b/rust/kernel/net/phy.rs
> index 3ca99db5cccf2..8b7036b8fe480 100644
> --- a/rust/kernel/net/phy.rs
> +++ b/rust/kernel/net/phy.rs
> @@ -659,7 +659,11 @@ pub fn register(
>          // the `drivers` slice are initialized properly. `drivers` will not be moved.
>          // So it's just an FFI call.
>          to_result(unsafe {
> -            bindings::phy_drivers_register(drivers[0].0.get(), drivers.len().try_into()?, module.0)
> +            bindings::phy_drivers_register(
> +                drivers[0].0.get(),
> +                drivers.len().try_into()?,
> +                module.as_ptr(),
> +            )
>          })?;
>          // INVARIANT: The `drivers` slice is successfully registered to the kernel via `phy_drivers_register`.
>          Ok(Registration { drivers })
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index af74ddff6114d..916ed2cb6b70b 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -86,7 +86,7 @@ unsafe fn register(
>  
>          // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
>          to_result(unsafe {
> -            bindings::__pci_register_driver(pdrv.get(), module.0, name.as_char_ptr())
> +            bindings::__pci_register_driver(pdrv.get(), module.as_ptr(), name.as_char_ptr())
>          })
>      }
>  
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index 8917d4ee499fb..9fdbafd53bc21 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -82,7 +82,7 @@ unsafe fn register(
>          }
>  
>          // SAFETY: `pdrv` is guaranteed to be a valid `DriverType`.
> -        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.0) })
> +        to_result(unsafe { bindings::__platform_driver_register(pdrv.get(), module.as_ptr()) })
>      }
>  
>      unsafe fn unregister(pdrv: &Opaque<Self::DriverType>) {
> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 9c17a672cd275..213db32727c17 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs
> @@ -63,7 +63,7 @@ unsafe fn register(
>  
>          // SAFETY: `udrv` is guaranteed to be a valid `DriverType`.
>          to_result(unsafe {
> -            bindings::usb_register_driver(udrv.get(), module.0, name.as_char_ptr())
> +            bindings::usb_register_driver(udrv.get(), module.as_ptr(), name.as_char_ptr())
>          })
>      }
>  
> 

