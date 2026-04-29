Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BEEFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 08:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C68410EEB8;
	Wed, 29 Apr 2026 08:03:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ktQByFEQ";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8A4810E0B0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:03:05 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-488c0fcc6deso79177455e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777449784; x=1778054584;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VEG/I8pPPYBATQ/hJAtxhRYJOnBvxSA+K2ZLFC/1AAs=;
 b=ktQByFEQTtkVhAXGhXHlpjNaBHKY6+MoOiSXC/0xs3VYaAjLvALIkVIlnZr8pg83WT
 nXg7ciYB9/VuT0xlYWEwmz7Wy0x24nOAG7eD/LKmseae5FnIM1enOmDq8d1H7NfPUPhm
 02Gfffo2d14d70K2MDpPkIoil49uST/gj1UnpG4wPrBdeoYT+YmLL6GeszATgP11Ox7w
 zejD55AyksxgpJWd4xQUjHyoIiHx67wWTCdh0KXBkJ+r4Yi7E+LBHlNVFMJlKS6Ltx0G
 XctSz0h8Msfs+gdVN990oYK7JJT6/P5YFfKNCxAM8o67LYe7KcF390RLJiLMy+bFVxO5
 y/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777449784; x=1778054584;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEG/I8pPPYBATQ/hJAtxhRYJOnBvxSA+K2ZLFC/1AAs=;
 b=kKSjFG0CkCWsEn8wKq7E9o4AxVWTPKURcu51pBE2OnbdW933A6r3mduZDymjIPVBml
 +qr+sF8oAd9f+MKVBMrFMivMqTe1zsgSNWJ1Ozz2TZfjtJtjYseht/Fcr7+n9pgmvaOI
 klVnogS1GnDPwFehW78e8QF/3ayTG5AEWSe0h3EVfj83Y4BBHHRjUTU6erOD52knd0OB
 xczQjlEtStQ5XIwHo+oUFGz7fatyR6jatx8Xhks/sHg10+BRHXoPCnQacKiHCmXkvxpj
 DWqMzkKZc1Fnc7JJ05t3XgJCaKjrCZp6hgirRRTSZ0PtcfW56SV6GvryoZAEq11Pa6PE
 ndSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ80rmtn0Iw7+z7JD/N+j9J4FnXdleYitduSiAW15XXUWYwIAK2ZIDa9+MztYI1qRm7ahYEbqfJqbDM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6c+ngHr9LwEzmPEz4ZRlkaaaUgweNN8QGt32jmiEVAxu3Ftpn
 n6FTNCv5jyQrKuvhUa4GACxJMQwV/uMYSRgtL5Tv+Bn+iEr7c7pDoPFzE9mIechkdREvJ+vK5/M
 +DEDPwzpDP2oB7lyxpA==
X-Received: from wmdd17.prod.google.com ([2002:a05:600c:a211:b0:488:c696:8bf2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d1a:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48a77b04774mr98771505e9.12.1777449784107; 
 Wed, 29 Apr 2026 01:03:04 -0700 (PDT)
Date: Wed, 29 Apr 2026 08:03:02 +0000
In-Reply-To: <20260428-fix-drm-1-v1-1-755057178066@nvidia.com>
Mime-Version: 1.0
References: <20260428-fix-drm-1-v1-1-755057178066@nvidia.com>
Message-ID: <afG7Np4Lmv9k7D1U@google.com>
Subject: Re: [PATCH] rust: drm: fix unsound initialization in drm::Device::new
From: Alice Ryhl <aliceryhl@google.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Alexandre Courbot <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Tue, Apr 28, 2026 at 09:20:21PM +0900, Eliot Courtney wrote:
> If pinned initialization of drm::Device::Data fails, it calls
> drm::Device::release via drm_dev_put. This materializes a reference to
> &drm::Device, but it's not fully constructed yet, because initializing
> `data` failed. It should not be dropped either. Instead, if pinned
> initialization fails, make sure drm::Device::release isn't called.
> 
> Fixes: 2e9fdbe5ec7a ("rust: drm: device: drop_in_place() the drm::Device in release()")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

For the concerns about duplicating vtables, could the temporary vtable
be a stack variable?

>  rust/kernel/drm/device.rs | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
> index adbafe8db54d..78ea0eb12535 100644
> --- a/rust/kernel/drm/device.rs
> +++ b/rust/kernel/drm/device.rs
> @@ -111,6 +111,13 @@ impl<T: drm::Driver> Device<T> {
>          fops: &Self::GEM_FOPS,
>      };
>  
> +    // Use a vtable without a `release` callback until `data` is initialized, so init failure
> +    // can release the DRM device without dropping uninitialized fields.
> +    const ALLOC_VTABLE: bindings::drm_driver = bindings::drm_driver {
> +        release: None,
> +        ..Self::VTABLE
> +    };
> +
>      const GEM_FOPS: bindings::file_operations = drm::gem::create_fops();
>  
>      /// Create a new `drm::Device` for a `drm::Driver`.
> @@ -120,12 +127,12 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
>          let layout = Kmalloc::aligned_layout(Layout::new::<Self>());
>  
>          // SAFETY:
> -        // - `VTABLE`, as a `const` is pinned to the read-only section of the compilation,
> +        // - `ALLOC_VTABLE`, as a `const` is pinned to the read-only section of the compilation,
>          // - `dev` is valid by its type invarants,
>          let raw_drm: *mut Self = unsafe {
>              bindings::__drm_dev_alloc(
>                  dev.as_raw(),
> -                &Self::VTABLE,
> +                &Self::ALLOC_VTABLE,
>                  layout.size(),
>                  mem::offset_of!(Self, dev),
>              )
> @@ -133,6 +140,10 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
>          .cast();
>          let raw_drm = NonNull::new(from_err_ptr(raw_drm)?).ok_or(ENOMEM)?;
>  
> +        // SAFETY: `raw_drm` is a valid pointer to `Self`, given that `__drm_dev_alloc` was
> +        // successful.
> +        let drm_dev = unsafe { Self::into_drm_device(raw_drm) };
> +
>          // SAFETY: `raw_drm` is a valid pointer to `Self`.
>          let raw_data = unsafe { ptr::addr_of_mut!((*raw_drm.as_ptr()).data) };
>  
> @@ -140,15 +151,14 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<A
>          // - `raw_data` is a valid pointer to uninitialized memory.
>          // - `raw_data` will not move until it is dropped.
>          unsafe { data.__pinned_init(raw_data) }.inspect_err(|_| {
> -            // SAFETY: `raw_drm` is a valid pointer to `Self`, given that `__drm_dev_alloc` was
> -            // successful.
> -            let drm_dev = unsafe { Self::into_drm_device(raw_drm) };
> -
>              // SAFETY: `__drm_dev_alloc()` was successful, hence `drm_dev` must be valid and the
>              // refcount must be non-zero.
>              unsafe { bindings::drm_dev_put(drm_dev) };
>          })?;
>  
> +        // SAFETY: `drm_dev` is still private to this function.
> +        unsafe { (*drm_dev).driver = &Self::VTABLE };

It would be bad if this ended up being a reference to a local variable.
Please use `&const { Self::VTABLE }` so that it doesn't compile if this
occurs.

Alice
