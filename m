Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1087ACD3427
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 15:48:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74CF010EB60;
	Tue,  5 May 2026 15:48:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="emRjvAxm";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B51A10EB60
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 15:48:49 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-676fb54c0cdso5016654a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 08:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777996128; x=1778600928;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=88jGTJt1jUBTa9gUMTrSJbkV2SqxUXuXjo+gX1FmdT4=;
 b=emRjvAxmXKFDUU4sQGqa7jHwPLdn1t1ACCkMyacynB+xJp9vZvtG8qvrH22XzZ/aew
 vR0Gc7SBZe95z02TPeT+lDw3dsDEC8tCLxTEeJprXPDt/LJixzBhr/IUA5TEvt2uWpyE
 LQKs/B/tWy8A/BDGtNtNq5JYuUsnn2YQVN+vMv6QzP2eujAb+TvWDntjV/dr+yXSuhFi
 X8ILdLMk9AyzJ3iCLa6ZF8D0q6D4Xp+Jg4dBxzbxKWRKMDds2qf+SmAxuLPcCOHmaukW
 KQ5n7il3JG8HR03KC3leNjCA0Iuct59hUT6R4tsYhsWd7O0skSn81zA4agjX5aV0vP6e
 gPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777996128; x=1778600928;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88jGTJt1jUBTa9gUMTrSJbkV2SqxUXuXjo+gX1FmdT4=;
 b=W1tQHdbuuvRIx4CoxqxTBRvXAowxsG+WTysAaG0yDu+f1O6EqN/A1vBBHSCHJJj1rE
 4LkwEv3diRQXlcTE1wnGwy0b9gBggekW8BbO7Qx9xR7eOe+6Ed7VfeXRBktpJWUvLBdq
 F/ZMk6znY1LiU6ayhTjCzb4ckl7PJ8nBmOKp2DrAv3SwXj3licI2r5AixpcvzpQKiN1/
 3n760gRyK4XsCvGSsxeoLYt3i8a0SOG2NvymAHNCpqGWbdlp+M1iFFanqa8UgA118hyM
 0iadSafsqyj/WW05/ipmr9AtX4GNOTTYy8o69b+qciEVpF7e1s2jCaVI4xZB6d7Ot5kY
 o2gQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b50LWL5Q25ywk8ANq3Jh8aA1HSVmNi0ijv2k7N+rUctwahmkmBhq42ytEum0R+7laspyLb4noPQk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXc+ZcnWhaKeXiO4ubFalsC7lawMSzFcpnT8c41THAfKIF6zaQ
 yydKBS1xlgspgPe9zSztyQa5AuQQwhyHdGbZSXcFqpAsvGZV5ldwLJHi8w1nTGPLmwNmXeaN1zG
 aH6Xj6mb7nm3jQYXgIg==
X-Received: from edvb16.prod.google.com ([2002:a05:6402:1390:b0:674:5a86:ecaa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a0c3:b0:67c:ba33:c605 with SMTP id
 4fb4d7f45d1cf-67cca92e19amr1615859a12.6.1777996127373; 
 Tue, 05 May 2026 08:48:47 -0700 (PDT)
Date: Tue, 5 May 2026 15:48:46 +0000
In-Reply-To: <20260505152400.3905096-2-dakr@kernel.org>
Mime-Version: 1.0
References: <20260505152400.3905096-1-dakr@kernel.org>
 <20260505152400.3905096-2-dakr@kernel.org>
Message-ID: <afoRXrwKjZAJuMaQ@google.com>
Subject: Re: [PATCH v2 1/3] rust: alloc: add Box::zeroed()
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org
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

On Tue, May 05, 2026 at 05:23:07PM +0200, Danilo Krummrich wrote:
> Add Box::zeroed() for T: Zeroable types.
> 
> This allocates with __GFP_ZERO directly, letting the underlying
> allocator deal with zeroing out the memory compared to
> Box::new(T::zeroed(), flags).
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>  rust/kernel/alloc/kbox.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index bd6da02c7ab8..c824ed6e1523 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -19,6 +19,7 @@
>  use crate::fmt;
>  use crate::init::InPlaceInit;
>  use crate::page::AsPageIter;
> +use crate::prelude::*;
>  use crate::types::ForeignOwnable;
>  use pin_init::{InPlaceWrite, Init, PinInit, ZeroableOption};

I suspect some of these imports can be removed when you add the prelude.

> @@ -256,6 +257,27 @@ pub fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>, A>, AllocError> {
>          Ok(Box(ptr.cast(), PhantomData))
>      }
>  
> +    /// Creates a new zero-initialized `Box<T, A>`.
> +    ///
> +    /// New memory is allocated with `A` and the [`__GFP_ZERO`] flag. The allocation may fail, in
> +    /// which case an error is returned. For ZSTs no memory is allocated.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let b = KBox::<[u8; 128]>::zeroed(GFP_KERNEL)?;
> +    /// assert_eq!(*b, [0; 128]);
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn zeroed(flags: Flags) -> Result<Self, AllocError>

#[inline]?

Alice
