Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE58C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB7010E2B2;
	Fri, 11 Sep 2026 09:20:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UvDbJz+X";
	dkim-atps=neutral
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 528E810E2B2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 09:20:02 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767b782so6132635e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 02:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1789118401; x=1789723201;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NZtTwWLqkTlApSCCjwtFSfuFmwluELYL36xqCuH39yY=;
 b=UvDbJz+X5sKSsGOfStLzixcrmtemE03/CYeiSiuidSn3lEwKwoMrKX9WgSb9FCI0wY
 ssGXYgNeG8MvldfteAt7gvCE5T1r0Vr4txtn9fzYY5trlu07kQrhJ/30zg+2oLLw8man
 cWK+CPQfqhwrQQkPlYxZj2rIDB7uMaHMdMNCJlxk2ghKE7F0+Lba1PSUx0a2fX/IBdQe
 A7quojlKphNaWrhCh+hTZvgUHP2YokOY1jv8uuym4l46RmU+56cwaQzI+4wP4V5fdRwH
 pFZAa9vBwjiC/FYezLgTtXGquojLZXVEt6YeDWWcwPKI/aC4JjQWRX0irpWpfdGmvVYw
 zEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789118401; x=1789723201;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NZtTwWLqkTlApSCCjwtFSfuFmwluELYL36xqCuH39yY=;
 b=OYWgI3eDOX77DMUMGP9/cHPuhTh8GH49g8QxJLjzb7ruusdgaJ1XiZKqYDlGHAogIk
 I+GHucUP01XbNppzkzfoVheqzy1SfBVbTKHNF6MRYNsBx7FiiuoXFyxZJOPQhftBRDXS
 0q9Snqcif/aIaLbryvHXRXRp3nvyhMzNFoYYiiIZUBrCwbxj6xoWqzbGa4QVA/JofIFz
 UhFXCUpBWuHptyF+RMGv1L2Yh6qTlFOerjM4Hiu1jPWDv81TXjX9kWBWWBxIwIZxVmcg
 DytYG0tDYIK794pRheVhlJnsr8XJWFO4T3dmms7PddvFtatGTgn25gKJi1wz6Dp8PRxb
 r8Og==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNI43QOScc00KlrUaat4Ib5215ZDAxSIrVmIExBtSfwjhTTDl9DphCKce17RUcH3n1PO7FtI2jFOU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++maniE7CJyQwf8v60JdVJoarFL8WqRFrAvaG3T9K1YisQ5Pb2qf
 cTikgTXcenTnRyXn98V7CB9Tscnk137j8v9FCnBZxtYNlBa0ln5D6LQB8xFwYLcE3vUtRPPP9hk
 JONJ014VFSQCmr4tWrA==
X-Received: from wmga6.prod.google.com ([2002:a05:600c:2d46:b0:499:b8f0:3186])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8490:20b0:49d:e0c:e560 with SMTP id
 5b1f17b1804b1-49e61983771mr27226365e9.4.1789118400242; 
 Fri, 11 Sep 2026 02:20:00 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:19:58 +0000
In-Reply-To: <20260910-unique-ref-v21-6-e83257373062@kernel.org>
Mime-Version: 1.0
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-6-e83257373062@kernel.org>
Message-ID: <aqPHvi1xFnMXvYLW@google.com>
Subject: Re: [PATCH v21 6/9] rust: Add `OwnableRefCounted`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Lyude Paul <lyude@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>,
 Todd Kjos <tkjos@android.com>, 
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Philipp Stanner <phasta@kernel.org>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org, Oliver Mangold <oliver.mangold@pm.me>
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

On Thu, Sep 10, 2026 at 11:00:10AM +0200, Andreas Hindborg wrote:
> From: Oliver Mangold <oliver.mangold@pm.me>
> 
> Types implementing one of these traits can safely convert between an
> `ARef<T>` and an `Owned<T>`.
> 
> This is useful for types which generally are accessed through an `ARef`
> but have methods which can only safely be called when the reference is
> unique, like e.g. `block::mq::Request::end_ok()`.
> 
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Fix formatting, update documentation, fix error handling in
>   examples. ]
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

>  /// Types that specify their own way of performing allocation and destruction. Typically, this trait
>  /// is implemented on types from the C side.
>  ///
> -/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type. This
> -/// is useful when it is desirable to tie the lifetime of the reference to an owned object, rather
> -/// than pass around a bare reference. [`Ownable`] types can define custom drop logic that is
> -/// executed when the owned reference [`Owned<Self>`] pointing to the object is dropped.
> +/// Implementing this trait allows types to be referenced via the [`Owned<Self>`] pointer type.
> +///  - This is useful when it is desirable to tie the lifetime of an object reference to an owned
> +///    object, rather than pass around a bare reference.
> +///  - [`Ownable`] types can define custom drop logic that is executed when the owned reference
> +///    of type [`Owned<_>`] pointing to the object is dropped.

This diff looks like it should be in the patch introducing Ownable.

> +/// # #![expect(clippy::disallowed_names)]
> +/// # use core::ptr::NonNull;
> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
> +/// # use kernel::sync::aref::{ARef, RefCounted};
> +/// # use kernel::sync::atomic::Acquire;
> +/// # use kernel::sync::Refcount;
> +/// # use kernel::types::{Owned, Ownable, OwnableRefCounted};
> +///

This newline will appear weirdly in generated docs because no content is
shown above it. Consider not hiding the imports.

> +pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
> +    /// Checks if the [`ARef`] is unique and converts it to an [`Owned`] if that is the case.
> +    /// Otherwise it returns again an [`ARef`] to the same underlying object.
> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Self>>;
> +
> +    /// Converts the [`Owned`] into an [`ARef`].
> +    fn into_shared(this: Owned<Self>) -> ARef<Self>;
> +}

This trait provides two methods that have very different conditions for
existing, IMO.

The into_shared() method is so likely to exist, that I would almost
consider placing it on the Ownable trait.

pub trait Ownable {
    unsafe fn release(this: NonNull<Self>);

    fn into_shared(this: Owned<Self>) -> ARef<Self>
    where
    	Self: Refcounted;
}

On the other hand, I think try_from_shared() is more likely to be a
tricky operation you cannot necessarily implement, and as such it can be
on its own separate trait like you have here.

At the very least, I can easily imagine that some types can never become
unique again after having been shared.

Alice
