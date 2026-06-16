Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92ECCCD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F10AC10EA8C;
	Tue, 16 Jun 2026 11:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qO/dWV0u";
	dkim-atps=neutral
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com
 [209.85.208.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B6C10EA8B
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:54:36 +0000 (UTC)
Received: by mail-ed1-f73.google.com with SMTP id
 4fb4d7f45d1cf-68f9f08cfcaso4074558a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781610875; x=1782215675;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=Fkz/8WHSlc5z8mgSFYgivmaJvolb4fXApnGq7F/IsFs=;
 b=qO/dWV0ug4avwiqcoRFY7BztTUiHWvFmb6tCydmPYBnmSwUwkSLDCH5XEbcq8ioUv/
 p7NFTX36fIVmD47INcZINFQ2LYZ6jWs2B7PGM4g/xRZ6ZsyZbvptHt4XtnFOTgdBu50Y
 9R5wbuu7tfWuf6q9pR5p6KXvA+ac3BewE4tuLBzUahYe7xzQYacFDtXOkF54fxDfwl+z
 gMBw0M6WHuDg8td9zpcd+3jiYEXoiXav0PRjlDSEDgN7EWbWlHLcjUN6Cy0C20bdgCmv
 6qsAg4lCX1pKu7Y/8/Q92cY3+8u77MJUa9swjhTTImSRfOHNVGSJGM2GCTs5fdW+Wdup
 gwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781610875; x=1782215675;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fkz/8WHSlc5z8mgSFYgivmaJvolb4fXApnGq7F/IsFs=;
 b=ARL5sPdHyHhvQ1x1DSuBLEf9kB7kxxtG3TadxRoWYbdLownjH8ZshNNs8Q0pSQytiu
 NhB/Hptz2QABdQE2ijgpJ0+eWV5VbLPAVfw6uchTOtRKgSGcp+YG8tLmgFp5YN+G9i8Y
 0G2vxd7E6ZtFvkkDzux452yiTAWWECFz6UDQ4x3cXONLjyJVBse7YB9yXcFeQBnyh5MX
 C1TMGj6Is8ZZs5jiXKbFltzz4G29LPfW9zHk0hWf0cM60EKEWxtozdqqqs50dOmSJhN+
 huSGAR89emnLCGiLS0bDaxr7kfA4/DdHVHuZ3jDnhIlNskByg9f48KwGg00FMGKO2WOG
 qrZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oa+ri5iySupuEG71cFN1KGz3bdVJSN/PEGDpb/3mk57ftlNmcakYDEerD4nZrHIq14dqMpaDdZ8c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAlLJFueUhgOr3TYZX86eh72eAOZAXMMfmLJUsXxESZ+B3B1yU
 mIGe9Heyw4Stx5EV6kzgDKes1n6+0PJVH6IlAnUYlF4HPH4qwjv9cj71b6Pd/SDmhuzlrbycZbd
 c9xG2poMgyidrgaD5Yg==
X-Received: from edrc26.prod.google.com ([2002:aa7:d61a:0:b0:68d:205:9a90])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:35c5:b0:695:865:47cd with SMTP id
 4fb4d7f45d1cf-695086ebec3mr1540972a12.7.1781610868582; 
 Tue, 16 Jun 2026 04:54:28 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:54:27 +0000
In-Reply-To: <20260604-unique-ref-v17-2-7b4c3d2930b9@kernel.org>
Mime-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-2-7b4c3d2930b9@kernel.org>
Message-ID: <ajE5c-5gZtJRoadx@google.com>
Subject: Re: [PATCH v17 02/10] rust: types: Add Ownable/Owned types
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 "Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
 Asahi Lina <lina+kernel@asahilina.net>, Oliver Mangold <oliver.mangold@pm.me>
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

On Thu, Jun 04, 2026 at 10:11:14PM +0200, Andreas Hindborg wrote:
> From: Asahi Lina <lina+kernel@asahilina.net>
> 
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
> 
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
> 
> [ om:
>   - Split code into separate file and `pub use` it from types.rs.
>   - Make from_raw() and into_raw() public.
>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>   - Usage example/doctest for Ownable/Owned.
>   - Fixes to documentation and commit message.
> ]
> 
> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> [ Andreas: Updated documentation, examples, and formatting. Change safety
>   requirements, safety comments. Use a reference for `release`. ]
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Overall looks good to me, but two nits below. With them fixed:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +pub trait Ownable {
> +    /// Tear down this `Ownable`.
> +    ///
> +    /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
> +    /// include freeing the underlying object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the caller has exclusive ownership of `T`, and this ownership can
> +    /// be transferred to the `release` method.
> +    unsafe fn release(&mut self);

I'd make this take a raw pointer because the pointer can be freed during
the execution of release(), which references don't allow.

> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 4329d3c2c2e5..4aec7b699269 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -11,6 +11,17 @@
>  };
>  use pin_init::{PinInit, Wrapper, Zeroable};
>  
> +pub use crate::{
> +    owned::{
> +        Ownable,
> +        Owned, //
> +    },
> +    sync::aref::{
> +        ARef,
> +        AlwaysRefCounted, //
> +    }, //
> +};

We removed the types::ARef re-export, so you shouldn't add it back.

Alice
