Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA64CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:13:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A74A810EB44;
	Tue, 23 Jun 2026 13:13:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TLxbvif4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D396C10EB44
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:12:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5700460052;
 Tue, 23 Jun 2026 13:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D151F00A3A;
 Tue, 23 Jun 2026 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782220379;
 bh=8Phdfqke0BCmhfc0oBfjNrqGUeVtsij2zEYdCciFrjo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=TLxbvif4peVjybpzPACL2R6+EOftsA4RL/WHYu2NfjIJb4nO+Rp0EnDsa5BN94xeZ
 ZsOQDq2DKWAFC1a5u0Q+k8BO0R7+erFAA6/QI5e8JarlMRkJ1u1iSSIyBJ44mMaLXN
 X1QixsoCdk60pFdaSEQbhkazqlAGZibmpF5HBHKZIgjmIAFxgPcXbHPuZhwsTNqEgn
 vxr3cW01mAE9ooGjLqhBsA6PO7WQVIV2xEnEr/GYA0jnm0OyNpxbAFZNDY/0MCHbkw
 XDn/gxkjeEeTsBiOYrsQx1U99GagLanBoJ8AUSBoZLbyuELioTYmiVVPTeWZdDhm8a
 gBaGy/Nou1o5A==
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
 driver-core@lists.linux.dev, Asahi Lina <lina+kernel@asahilina.net>
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
In-Reply-To: <ajKGv5ioLSassmND@google.com>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
 <ajKGv5ioLSassmND@google.com>
Date: Tue, 23 Jun 2026 15:12:33 +0200
Message-ID: <878q85pfi6.fsf@t14s.mail-host-address-is-not-set>
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

> On Thu, Jun 04, 2026 at 10:11:17PM +0200, Andreas Hindborg wrote:
>> From: Asahi Lina <lina@asahilina.net>
>> 
>> This allows Page references to be returned as borrowed references,
>> without necessarily owning the struct page.
>> 
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> [ Andreas: Fix formatting and add a safety comment. ]
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/page.rs | 38 +++++++++++++++++++++++++-------------
>>  1 file changed, 25 insertions(+), 13 deletions(-)
>> 
>> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
>> index 3bdcee0e16a8..844c75e54134 100644
>> --- a/rust/kernel/page.rs
>> +++ b/rust/kernel/page.rs
>> @@ -10,6 +10,11 @@
>>      bindings,
>>      error::code::*,
>>      error::Result,
>> +    types::{
>> +        Opaque,
>> +        Ownable,
>> +        Owned, //
>> +    },
>>      uaccess::UserSliceReader, //
>>  };
>>  use core::{
>> @@ -105,7 +110,7 @@ pub const fn page_align(addr: usize) -> Option<usize> {
>>  ///
>>  /// [`VBox`]: kernel::alloc::VBox
>>  /// [`Vmalloc`]: kernel::alloc::allocator::Vmalloc
>> -pub struct BorrowedPage<'a>(ManuallyDrop<Page>, PhantomData<&'a Page>);
>> +pub struct BorrowedPage<'a>(ManuallyDrop<NonNull<Page>>, PhantomData<&'a Page>);
>
> BorrowedPage<'a> is no longer needed because it's just &Page.

I'll add some cleaning then.


Best regards,
Andreas Hindborg



