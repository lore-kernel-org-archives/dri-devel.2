Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBA7FCD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:13:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40EC310EB48;
	Tue, 23 Jun 2026 13:13:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W/iifiGe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94DCF10EB48
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:13:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5564A406E1;
 Tue, 23 Jun 2026 13:13:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF4D1F00A3A;
 Tue, 23 Jun 2026 13:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782220396;
 bh=g5mc2seyBJ1pVIiIaXg4bERPFOr66pMuwtVwk9IXTQw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=W/iifiGeQ+aI6lAeV71CEqax9mMJWJCFwgoBoQoIXt5uDLfWF2eopH8ndgqr5khmL
 ETCbgXqUuQLrRe0nw90m5Y1k/nWjyo/F9LvE0c0A9jPuFsW6g+yW9pteF6cL5KfxKm
 6gsTB1cF8sSKT8xWb9CUH7u2G+WpMr5QrWkbkcR/0vltXolw6QZiMIyDgOog42tKMz
 +FstpuzGaoX6FoBosQztfPgipJpx2kH42sKLMG8FKKd7zao4S1oih9afeLeAIwUgyI
 5IWt+x5Kqr9Gmam/rVWXq/uNF1ViiAoavSb7we+Cbe6vy6rHcUnEUYAx0VyPJTwgEp
 X8PyHtZfF+/Ew==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Boqun Feng
 <boqun@kernel.org>,
 Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, Pavel
 Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>,
 Oliver Mangold <oliver.mangold@pm.me>
Subject: Re: [PATCH v17 02/10] rust: types: Add Ownable/Owned types
In-Reply-To: <ajE5c-5gZtJRoadx@google.com>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-2-7b4c3d2930b9@kernel.org>
 <ajE5c-5gZtJRoadx@google.com>
Date: Tue, 23 Jun 2026 15:09:04 +0200
Message-ID: <87h5mtpfnz.fsf@t14s.mail-host-address-is-not-set>
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

Alice Ryhl <aliceryhl@google.com> writes:

> On Thu, Jun 04, 2026 at 10:11:14PM +0200, Andreas Hindborg wrote:
>> From: Asahi Lina <lina+kernel@asahilina.net>
>> 
>> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
>> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
>> `AlwaysRefCounted`, this mechanism expects the reference to be unique
>> within Rust, and does not allow cloning.
>> 
>> Conceptually, this is similar to a `KBox<T>`, except that it delegates
>> resource management to the `T` instead of using a generic allocator.
>> 
>> [ om:
>>   - Split code into separate file and `pub use` it from types.rs.
>>   - Make from_raw() and into_raw() public.
>>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>>   - Usage example/doctest for Ownable/Owned.
>>   - Fixes to documentation and commit message.
>> ]
>> 
>> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/
>> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
>> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
>> [ Andreas: Updated documentation, examples, and formatting. Change safety
>>   requirements, safety comments. Use a reference for `release`. ]
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Overall looks good to me, but two nits below. With them fixed:
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
>> +pub trait Ownable {
>> +    /// Tear down this `Ownable`.
>> +    ///
>> +    /// Implementers of `Ownable` can use this function to clean up the use of `Self`. This can
>> +    /// include freeing the underlying object.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that the caller has exclusive ownership of `T`, and this ownership can
>> +    /// be transferred to the `release` method.
>> +    unsafe fn release(&mut self);
>
> I'd make this take a raw pointer because the pointer can be freed during
> the execution of release(), which references don't allow.

Ok.

>
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index 4329d3c2c2e5..4aec7b699269 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -11,6 +11,17 @@
>>  };
>>  use pin_init::{PinInit, Wrapper, Zeroable};
>>  
>> +pub use crate::{
>> +    owned::{
>> +        Ownable,
>> +        Owned, //
>> +    },
>> +    sync::aref::{
>> +        ARef,
>> +        AlwaysRefCounted, //
>> +    }, //
>> +};
>
> We removed the types::ARef re-export, so you shouldn't add it back.

Looks like a rebase failure, I will remove it.


Best regards,
Andreas Hindborg



