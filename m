Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1A606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=My435PEA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF8410FB26;
	Wed, 18 Nov 2026 11:41:12 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FCF110FB26
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:41:06 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4a7c864000eso232336f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 03:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795002064; x=1795606864;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=vocEukt94wLT/ULjaP2vDLoUIImfQpzcE9D0A8nRexo=;
 b=My435PEAPjzOSZOvlQYd1kQAkjYpFC10gSksmlSssWIyHniSlYdDrdOsej3o/QiJIL
 hAp6DmUp4jAR5VrGgAeMeH+1bAUoiaY1GHLU4YjbJjmGMn2qxJ4ROvoA41+Rzi2kLww2
 ulrKPcGeZ90vYNyiVY7peKGUq709vsFKvck8/xT+f3joDt7zm/O78+0VMPQTgd3dRBTC
 zx1r2skskCisMv9pF8Xg7gAO6Akg98ikzQvfTqoDVwD65IeFJ0gCi+wTpKU3bQRL3vfD
 LqyPX1uZg0+2klFA4wteWXlRIlmfsxONQ3o13yDh1wl3G/MahFkNAWJNEMZNnAYQe6XH
 QjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795002064; x=1795606864;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vocEukt94wLT/ULjaP2vDLoUIImfQpzcE9D0A8nRexo=;
 b=KQA8sBSuzy9FKk4NGdzfeZvCkqBFk21ngyu7+fOcTemlwJYCwihrFyVyeVzA5zOb9/
 Kar89b/vnzjbLWYrXv+S2Q0EUZXA3p1ZT2PPoTDDYMId4GPynfW0nvMgcoQuo+FEnD/Q
 6K55zUY0QqXPiwmSCqhR6xd8IixiWLSc15I9kBuLB8McOMV9paGb3KNh/qOa/gWMXjWf
 s2C7kw597nGvr/HcR1XYvVhS8mvElJnookiC2U12aeeFR9Sj0vaDYuDkSdUYdHyM7sU/
 juqE+COjIeSzH3zopIH8Q4I5ix2HyHiBtqX/dw7X0s+lA9WVIc7BGPeFkQWajn3vYGZO
 KQsg==
X-Forwarded-Encrypted: i=1;
 AL+hErHmGAtlaq5rZIeHENlheC9+i+fa/M2d00/XO0sWx2bYp+iO5vSlqP4YylJpGxSeH/Nz2GnkKFH/4s8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+D0QNumW3ih9Vnm0TQRgXczwt5guz4IIHoEtV2Ci+FtAAeQacO
 O+y3ral5NEU0Rs3RkOuuZdcGzenwrS9Kz5BAlW1Z7rFA/y/ImE86FfT6lC0ZbQLnFk2/PaxEUlp
 oRinccCKP2dQpFc7r2A==
X-Received: from wmbhb15.prod.google.com
 ([2002:a05:600c:868f:b0:4bb:5d5c:ab85])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83cf:b0:4a0:1c0e:b057 with SMTP id
 5b1f17b1804b1-4bb7d6cd41amr41190555e9.4.1795002062763; 
 Wed, 18 Nov 2026 03:41:02 -0800 (PST)
Date: Wed, 18 Nov 2026 11:41:01 +0000
In-Reply-To: <20261026-rust-drm-gem-shmem-imported-sgt-v1-1-36f15ace04b1@jannau.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
 <20261026-rust-drm-gem-shmem-imported-sgt-v1-1-36f15ace04b1@jannau.net>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118114102.490384-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/3] rust: drm: gem: shmem: implement gem_create_object
 for prime imports
From: Alice Ryhl <aliceryhl@google.com>
To: Janne Grunau <j@jannau.net>, Sami Tolvanen <samitolvanen@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 12:14:08PM +0100, Janne Grunau wrote:
> From: Sami Tolvanen <samitolvanen@google.com>
> 
> For a prime-imported BO with no `gem_create_object` callback,
> `__drm_gem_shmem_create()` allocates `kzalloc(sizeof(struct
> drm_gem_shmem_object))`, which is smaller than the Rust `Object<T>`
> wrapper. A later `container_of!()` from a `drm_gem_object` back to
> `Object<T>` then runs past the allocation and corrupts the heap.
> 
> Provide a `gem_create_object` callback that allocates the full
> `Object<T>` via `KBox::pin_init`. Move `obj` to the first field so the
> returned pointer is at offset zero, satisfying the `kfree()` on the
> init-failure path. This is now compile-checked with `const_assert!`.
> 
> Imported BOs have no userspace creation arguments, so extend
> `DriverObject` with a `create_imported(dev, size)` constructor and
> implement it for Tyr's `BoData`, Nova, and the in-tree KUnit driver.
...
> +    /// Create a new driver data object for a GEM object that is being imported
> +    /// from another driver (e.g. via dma-buf).
> +    ///
> +    /// Imported objects are allocated by the importing helper, which only
> +    /// provides the device and size. There is no driver-supplied
> +    /// [`DriverObject::Args`], so drivers must initialize the per-object
> +    /// state without those arguments.
> +    fn create_imported(dev: &drm::Device<Self::Driver>, size: usize) -> impl PinInit<Self, Error>;
...
> +        // SAFETY: We never move out of `self`. Ownership of the allocation is transferred to the
> +        // C side, which will run `__drm_gem_shmem_init()` next and later free us via
> +        // `free_callback` (or `kfree()` on the `__drm_gem_shmem_init()` error path, matching the
> +        // C kzalloc fallback contract).
> +        let new = KBox::into_raw(unsafe { Pin::into_inner_unchecked(new) });
> +
> +        // SAFETY: `new` was just produced by `KBox::into_raw` and so is a valid pointer to an
> +        // initialized `Self`. `obj.base` is the embedded `drm_gem_object` the caller expects.
> +        unsafe { &raw mut (*(*new).obj.get()).base }
> +    }

I ran this through a review agent, and it found these two things. As far as I
can tell, these are valid concerns.

1. On the `__drm_gem_shmem_init()` failure path, `__drm_gem_shmem_create()`
   calls `kfree(obj)` directly rather than reconstructing `KBox<Self>`.
   Having `obj` at offset 0 ensures `kfree(obj)` frees the start of the slab
   allocation, but it skips running `Drop` on `Object<T>` and `inner: T`. If a
   driver's `T` owns any fields with non-trivial `Drop` implementations
   initialized in `T::create_imported()`, they will be leaked if
   `__drm_gem_shmem_init()` fails (e.g. if `drm_gem_create_mmap_offset()`
   fails).

2. `Object<T>::ALLOC_OPS` also sets:

       dumb_create: Some(bindings::drm_gem_shmem_dumb_create),

   `drm_gem_shmem_dumb_create()` calls `drm_gem_shmem_create()` ->
   `__drm_gem_shmem_create(dev, size, false)` -> `gem_create_object_callback()`,
   and `DRM_IOCTL_MODE_CREATE_DUMB` only checks `dev->driver->dumb_create`
   (not `DRIVER_MODESET`). So `T::create_imported()` can also be called to
   create a non-imported dumb buffer (`obj.is_imported() == false`).

Instead of implementing `gem_create_object`, what do you think about
exporting a `private = true` counterpart to `drm_gem_shmem_init()` (similar to
commit e3f4bdaf2c5b ("drm/gem/shmem: Extract drm_gem_shmem_init() from
drm_gem_shmem_create()")), implementing a Rust `gem_prime_import_sg_table`
callback on `shmem::Object<T>` directly, and setting `dumb_create: None` in
`Object<T>::ALLOC_OPS`? That way `new: Pin<KBox<Self>>` stays owned by Rust
across `__drm_gem_shmem_init()` just like in `Object::new()`, so `Drop` runs
normally on error and `obj` does not need to sit at offset 0 for `kfree(obj)`.

Alice
