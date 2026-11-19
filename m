Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504A8606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=U9pr4hZl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67311122AA;
	Thu, 19 Nov 2026 11:17:56 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD4511122AB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:17:50 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-499ca65ae87so366136f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:17:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795087069; x=1795691869;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RlZOdD7i7xCpjMBuRImGfpZl+cJFA2YqI8GZO6zioDo=;
 b=U9pr4hZlJZfENJ9AvUVHJJ0iPy8sbcNysctDycVrZctN8UfSSkzi4o6G8BFLEzrjWa
 a0ErSeHaqPR74sxgDME5XtfH0pKpTGh2qgeW5x+A/A2Tl/jPaij4PKeIb4ItMFycqAoI
 X8OwWkk0Y0GzqQGI52ghxZG/HN1SAetTwaD6PAWOxpfrfvIbzLrQbFIAdMBlaYRDs0Xy
 3iQdrKNyeyAmxu2yDnXc7ot54XWk/vLa2lpAPawVeTL2QxEdHmXbJLy14fXiPTwjCbnv
 R8T529Y4V0Jf01uj/OBnmI8P5gdTdDTF0Q8+7c+LNDiLh4JJOnE1u1kULv7ub4IdtEoh
 rryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087069; x=1795691869;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RlZOdD7i7xCpjMBuRImGfpZl+cJFA2YqI8GZO6zioDo=;
 b=AvVzgtnG6yYLrd50ZycWZbKZPa/HvrkWnS8gG41fUMsuu/sGYgDPQWucTbIDBQxdxU
 8jIS3Op4oeFH3EQdXrDZjRDmvOLpB4Fe+1ih5rwvTBzBOseYb72C2qlJI5KxAHcxrYey
 G9DyYGfHrwHFSuTXP+1SZwZ76LODIp0ZIPS4+S5yxQ7ATmLHNtt9iOkSiKjo8J3+AcAb
 nYKYDT3hfngpIDixYCzrdEOVCryNSUm0iU2JrBfn5EbU3Ql1ZB1wsNTYgGFMIyn+d8/P
 tSMXsw15GIIoOjMT1GZGLnga7w8Zc14VPECWlZAhLsaan9lFYqq02XWEXkOuFvtuC0bK
 IbjA==
X-Forwarded-Encrypted: i=1;
 AL+hErHSkLZTAEaxDgNWyDQyqnv2SBPsd79yAKoA5L6yNuFIcQaOedL/hQHvQElpQYCXRd1DoRUofac5s+Q=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8TX2y8SbOReoRko6YQak3cCUHNvP/coAI3Ed77mc4QWJQQVPy1
 ybYtdtqMvApcBOFyyrApG1rRuHDQXvZMroYwdHUOGfgbDmTM9DMZh04vCncYLkA70E22CybxE/D
 OlMFhuzr0f/oRXLhb6g==
X-Received: from wrwi10.prod.google.com ([2002:a5d:55ca:0:b0:4a7:4b90:c045])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2c0d:b0:49b:b94c:e8e8 with SMTP id
 ffacd0b85a97d-4aa544edba7mr2116016f8f.8.1795087068558; 
 Thu, 19 Nov 2026 03:17:48 -0800 (PST)
Date: Thu, 19 Nov 2026 11:17:46 +0000
In-Reply-To: <20261118181245.2583303-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261118181245.2583303-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
Message-ID: <20261119111746.3049044-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: remove DRM device private data
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, airlied@gmail.com, simona@ffwll.ch, 
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org, 
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org, 
 acourbot@nvidia.com, work@onurozkan.dev, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 07:07:35PM +0100, Danilo Krummrich wrote:
> Driver::Data is owned by the reference-counted drm::Device and can
> outlive device unregistration and driver unbind. Driver state belongs in
> RegistrationData, whose lifetime ends with registration teardown.
> 
> The intended model is that, after drm_dev_unplug(), surviving DRM
> objects (e.g. through remaining userspace handles) no longer require
> access to the driver state. Thus Driver::RegistrationData is available
> (and sufficient) for all DRM callbacks into the driver.
> 
> Remove Driver::Data, its storage and Deref implementation, and the
> unused workqueue implementations that depend on it. Drop the data
> initializer argument from UnregisteredDevice::new() and update its
> callers.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Makes sense to me. Both in-tree users had `type Data = ()` anyway, and
nothing uses the `WorkItem`/`HasWork` impls on `drm::Device`, so this is
a pure simplification.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

One small suggestion below.

> -        release: Some(Device::<T>::release),
> +        release: None,

[...]

>  #[repr(C)]
>  pub struct Device<T: drm::Driver, C: DeviceContext = Normal> {
>      dev: Opaque<bindings::drm_device>,
> -    data: T::Data,
>      pub(super) registration_data: UnsafeCell<NonNull<T::RegistrationData<'static>>>,
>      _ctx: PhantomData<C>,
>  }

With `release` gone, nothing ever runs `drop_in_place()` on the Rust
side of `Device` anymore. That's fine today since all remaining fields
are trivially droppable, but it is now an implicit requirement on the
struct: anyone adding a field with a `Drop` impl (or a pinned field
that needs a destructor) would silently leak it.

Could you add a short comment on the struct along the lines of "no
`release` callback is installed, so no field of this struct may require
dropping"? That way the next person adding a field knows they have to
bring back the `release` callback.

(For what it's worth, I checked the lifetime-parameterized `File`
series [1] against this: `open_count`/`open_count_wq` are both
droppable without a destructor, and the two merge cleanly, so no
ordering constraint there as far as I can tell.)

[1] https://lore.kernel.org/r/20261118163203.2483856-1-dakr@kernel.org

Alice
