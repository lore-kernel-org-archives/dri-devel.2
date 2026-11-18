Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DE606A334
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 18:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=N1oYNGH0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE2410E32B;
	Wed, 18 Nov 2026 18:58:42 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6425F10E32B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 18:58:36 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4bb62d40736so4175e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 10:58:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795028314; cv=none;
 d=google.com; s=arc-20260327;
 b=QvVplkGX5e902V7aw+tNoj9X6n6bFEt0wctNizSmgEqvtf5XEBUijAeO2z1GHPjdjz
 h6eBUpr9xn4fOWsezr5WDXBqUNTvAYhe2mzCTgZencm/BCUHWOCx/qgtcvoXSmpNEN6f
 KM9CmE0qSju0krvjR5zZVBvn8XbMmggUHU69jbkhIj6EAQoiLVFpXNSONgQmwnilG+GS
 DycpUdw+P7CY6TVplN/gEoQXJKslzf+QB6F26rBLjdAMAqQ3PgBXC8SCZsUSrG3q/ZvP
 19ILoNSTo2iBJhC4autPCws1p5qAayxJu2rLJNh7VmG0MxNAuTXnaVDq7oseHx7VGuXF
 K8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=sANgHflY4l/Fe7eOmc9nVUukAbjG9FRan2mAzBkUStg=;
 fh=Nx2dv8qXqyInvb+nG9e6dA7+/768r+m4XDvHl9FAA1Q=;
 b=VvkM6UZXDKgti+b/sxMeOzc1dDSgM1jbaMFvbwlusDKXk5vtWuS/QlW1B60hUorl/X
 qDZTEO/MEtMS5o2lBqJ/s4DjEpGtPTepgPh5w3AGGa7n3hTV00JnWzKr+Wtj/HtRZb/j
 I4Qg0asAGym5+A8WngpRynkioft8wd+7m3zSkbuyOwKibGOjR8yQUQHw7sjlMDXQzvVz
 qRuVj/cgxa7Tu0dxfZtR416OJ1jcS2+R78QT5VPtFNJv6R0Szn0mwwiuqX3C2eUjkfEK
 ww+qj5uXWPTd7XlZXf6j8dezyrqgmIBlWCavN6hv70LnDvu6DZY/lCn35PAMiR6Sl0WK
 j43g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795028314; x=1795633114;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sANgHflY4l/Fe7eOmc9nVUukAbjG9FRan2mAzBkUStg=;
 b=N1oYNGH0KTsAi75pVXEuzuAVtIKXvf14dCCCYFnxrnOEPmJIaIYtDvXn+47f8zk4Hj
 wzqSjlFY1geko2C/8ygl54Y7OwrcvlM4CetRykPUOmI+Ti2CZ6j97OgUjNNAQ47yVCcO
 lx4nQCE7O2W0oN6aJ1KYjMynAQWePiFFc+fCoe/ZS8Y8ObdBKmc1AFufcZHpUWZNc1GG
 CEJbT7rCljnwNRCqVc07lJYOgEkv5fXtDOpaOig/KPr8ZT45FxQR68v2xDLiKtLfJ15I
 fFox5li+rO/G5i/aBS1a5QX5in6pSOh63kaQwVU104rYS2gT6fxaKeN1sEsmDnMyLTaA
 PW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795028314; x=1795633114;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sANgHflY4l/Fe7eOmc9nVUukAbjG9FRan2mAzBkUStg=;
 b=hha831sB8Exs1QHNx1kPtJcaDm//lZ40IwadMZ/fnirL5P1+M1hvyOoIh1hBVA/vit
 gR5FDjxPSywPi0S6rJ7oa3v41uprox6NKDkNvG0s+pwkUV34qWVRl/HUrXotaBmXhqGp
 Or0CAFuDRnjsHwgZK3qhkxxaOHWxQyrPO1mxHC/ZgD34qf4Ro/XXSSmLmlH65TdKd6JV
 ZbuscBNRQjin99hizwdbcbozfLV9rxwul4ACvZNxvGl/w/iW7JA4VAApDFKuiLvvEVS6
 1ik2BJbnezD1N+0dDwClYiWCIeSdKF63EJSS2k+UNu0kiYr8BpEZYVcvqkb9YY40oZtC
 QAxg==
X-Forwarded-Encrypted: i=1;
 AL+hErEFlQ9QsbvOmLYpFxFfU8CS7XFFMY+9htcBspBSzJ9Yq7H3WzahU3B7uMZ4CQTAR4TpW6MPG+f3RgM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8WkGgHt7mxC7x9RQNNeI3Jc/jfXQFrQmtkdvixUFqCMatxnBNo
 hkQ1fWr8jHZClHfYefIM4HQ7avQWXPrpo2uFjGV8b5i4tl9IdcXe/sOJY7P6er/XxwVni5NfYOP
 XafiQWahwYoK3z2ENnh4LHcp2Jdp59+3OHCZ9HbBf
X-Gm-Gg: AYBFou3SPZmegx9S0bioHCa7ic7cqKa+fUSendzco0aau81CN4EzaZC6LNWW5zwwHIO
 l3rh+kAnTeBOePkANXol5dfWZFBfsR5uiBg+dVamJ+68YChbz7ZMgUpO2ViaVv9Icouv6kHXMEa
 YLr+fZnzP7hOTaozfYMBDpqj2/B2RMBBMTCyP3cawqxASWuTHu0do+6rw69xaU01qpI7VgxjAMm
 ZGKYCw2+SNunwFuFvw6MAXg+hPuiA1C4nCtQo9H9TyyF5Dr9EQKopVGGMCj47hr9aIt1IqAXfAN
 PF2ZTpuIn5wAFE9IFjaX4hjTWUoyBUh9OQgKaYBlCdrUtNCvNJFcRrLB3PvTcbh7eXVMR+7TxY7
 2RmjeHqE50AungvmpW8ZVWU5C5Ovj+hRBXGzqzLAG45V45n57vxBgjprwQoWy/aVDNqm7qICiEs
 eP6hoxmjN7sG9d
X-Received: by 2002:a05:600c:840c:b0:49f:ddcf:45b7 with SMTP id
 5b1f17b1804b1-4bb83c9025emr23355e9.10.1795028313968; Wed, 18 Nov 2026
 10:58:33 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
 <20261026-rust-drm-gem-shmem-imported-sgt-v1-1-36f15ace04b1@jannau.net>
 <20261118114102.490384-1-aliceryhl@google.com>
In-Reply-To: <20261118114102.490384-1-aliceryhl@google.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 18 Nov 2026 10:57:56 -0800
X-Gm-Features: Aa3M54rtfthEgFiAPOcV53y3ZwydiRtVUQnZ06u4pa0OMeOurh1hyDTgkerw9LE
Message-ID: <CABCJKudrDOu3sD6J5LN4o3XF9JrU85pZK4DUXNH4d9iC363bEA@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: drm: gem: shmem: implement gem_create_object
 for prime imports
To: Alice Ryhl <aliceryhl@google.com>
Cc: Janne Grunau <j@jannau.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 3:41=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Mon, Oct 26, 2026 at 12:14:08PM +0100, Janne Grunau wrote:
> > From: Sami Tolvanen <samitolvanen@google.com>
> >
> > For a prime-imported BO with no `gem_create_object` callback,
> > `__drm_gem_shmem_create()` allocates `kzalloc(sizeof(struct
> > drm_gem_shmem_object))`, which is smaller than the Rust `Object<T>`
> > wrapper. A later `container_of!()` from a `drm_gem_object` back to
> > `Object<T>` then runs past the allocation and corrupts the heap.
> >
> > Provide a `gem_create_object` callback that allocates the full
> > `Object<T>` via `KBox::pin_init`. Move `obj` to the first field so the
> > returned pointer is at offset zero, satisfying the `kfree()` on the
> > init-failure path. This is now compile-checked with `const_assert!`.
> >
> > Imported BOs have no userspace creation arguments, so extend
> > `DriverObject` with a `create_imported(dev, size)` constructor and
> > implement it for Tyr's `BoData`, Nova, and the in-tree KUnit driver.
> ...
> > +    /// Create a new driver data object for a GEM object that is being=
 imported
> > +    /// from another driver (e.g. via dma-buf).
> > +    ///
> > +    /// Imported objects are allocated by the importing helper, which =
only
> > +    /// provides the device and size. There is no driver-supplied
> > +    /// [`DriverObject::Args`], so drivers must initialize the per-obj=
ect
> > +    /// state without those arguments.
> > +    fn create_imported(dev: &drm::Device<Self::Driver>, size: usize) -=
> impl PinInit<Self, Error>;
> ...
> > +        // SAFETY: We never move out of `self`. Ownership of the alloc=
ation is transferred to the
> > +        // C side, which will run `__drm_gem_shmem_init()` next and la=
ter free us via
> > +        // `free_callback` (or `kfree()` on the `__drm_gem_shmem_init(=
)` error path, matching the
> > +        // C kzalloc fallback contract).
> > +        let new =3D KBox::into_raw(unsafe { Pin::into_inner_unchecked(=
new) });
> > +
> > +        // SAFETY: `new` was just produced by `KBox::into_raw` and so =
is a valid pointer to an
> > +        // initialized `Self`. `obj.base` is the embedded `drm_gem_obj=
ect` the caller expects.
> > +        unsafe { &raw mut (*(*new).obj.get()).base }
> > +    }
>
> I ran this through a review agent, and it found these two things. As far =
as I
> can tell, these are valid concerns.
>
> 1. On the `__drm_gem_shmem_init()` failure path, `__drm_gem_shmem_create(=
)`
>    calls `kfree(obj)` directly rather than reconstructing `KBox<Self>`.
>    Having `obj` at offset 0 ensures `kfree(obj)` frees the start of the s=
lab
>    allocation, but it skips running `Drop` on `Object<T>` and `inner: T`.=
 If a
>    driver's `T` owns any fields with non-trivial `Drop` implementations
>    initialized in `T::create_imported()`, they will be leaked if
>    `__drm_gem_shmem_init()` fails (e.g. if `drm_gem_create_mmap_offset()`
>    fails).

I agree, this looks like a valid issue.

> 2. `Object<T>::ALLOC_OPS` also sets:
>
>        dumb_create: Some(bindings::drm_gem_shmem_dumb_create),
>
>    `drm_gem_shmem_dumb_create()` calls `drm_gem_shmem_create()` ->
>    `__drm_gem_shmem_create(dev, size, false)` -> `gem_create_object_callb=
ack()`,
>    and `DRM_IOCTL_MODE_CREATE_DUMB` only checks `dev->driver->dumb_create=
`
>    (not `DRIVER_MODESET`). So `T::create_imported()` can also be called t=
o
>    create a non-imported dumb buffer (`obj.is_imported() =3D=3D false`).
>
> Instead of implementing `gem_create_object`, what do you think about
> exporting a `private =3D true` counterpart to `drm_gem_shmem_init()` (sim=
ilar to
> commit e3f4bdaf2c5b ("drm/gem/shmem: Extract drm_gem_shmem_init() from
> drm_gem_shmem_create()")), implementing a Rust `gem_prime_import_sg_table=
`
> callback on `shmem::Object<T>` directly, and setting `dumb_create: None` =
in
> `Object<T>::ALLOC_OPS`? That way `new: Pin<KBox<Self>>` stays owned by Ru=
st
> across `__drm_gem_shmem_init()` just like in `Object::new()`, so `Drop` r=
uns
> normally on error and `obj` does not need to sit at offset 0 for `kfree(o=
bj)`.

A later commit in tyr-dev lets drivers opt out of dumb_create, which
addresses this part. However, your proposal sounds cleaner and fixes
both issues, so let's go with that.

Sami
