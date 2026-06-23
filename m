Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D213CD98F2
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:12:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8473610EB41;
	Tue, 23 Jun 2026 13:12:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ViufDM0E";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A87C10EB41
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 13:12:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C99EA60052;
 Tue, 23 Jun 2026 13:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922CF1F000E9;
 Tue, 23 Jun 2026 13:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782220370;
 bh=+rzFpQ8O/10QiSxDOc9EPIkCdPQE1on2cJQrgpHbAZE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ViufDM0EZ7iUxbOYXY2wdI5lAjc9KlTZkhijrIJU9IXCwHIq77eaTYi1q+b++HSJt
 jRu44bv9q4fNbTcplpUTdl0GDJZVn840Fzexjq6sM7GPsYSYiTwtSkcLVYnzJSyZXC
 XfMSaa+2lXkLKi3I8GME16fOL0/IlJBx82RnEsWbIgLgfIOVvDS8Fqgg/B4uDOaU0P
 8Yzb+3txaIfMRxZ3u8Rw2Mf2i/3MpTM5foSzb9RR+Z7S8KQiluZIW5EyK08LEoiVk6
 4B8eyMNZnIAxVokQYMJlAOvP7Ap0MNQAr72k2+A6DrfvBqVFG4VbXV4/dMqiiLtFsS
 GX+wqSW8Cjyqg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, Uladzislau
 Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil
 Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Igor
 Korotin <igor.korotin@linux.dev>, Pavel Tikhomirov
 <ptikhomirov@virtuozzo.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 driver-core@lists.linux.dev
Subject: Re: [PATCH v17 03/10] rust: implement `ForeignOwnable` for `Owned`
In-Reply-To: <DJAGDGPKZ4HX.M47NMAU53PCJ@garyguo.net>
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-3-7b4c3d2930b9@kernel.org>
 <DJAGDGPKZ4HX.M47NMAU53PCJ@garyguo.net>
Date: Tue, 23 Jun 2026 15:10:44 +0200
Message-ID: <87echxpfl7.fsf@t14s.mail-host-address-is-not-set>
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

"Gary Guo" <gary@garyguo.net> writes:

> On Thu Jun 4, 2026 at 9:11 PM BST, Andreas Hindborg wrote:
>> Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
>> places such as the `XArray`.
>>
>> Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
>> implement `ForeignOwnable`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/owned.rs | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>> index 456e239e906e..5eacdf327d12 100644
>> --- a/rust/kernel/owned.rs
>> +++ b/rust/kernel/owned.rs
>> @@ -15,6 +15,8 @@
>>      ptr::NonNull, //
>>  };
>>  
>> +use kernel::types::ForeignOwnable;
>> +
>>  /// Types that specify their own way of performing allocation and destruction. Typically, this trait
>>  /// is implemented on types from the C side.
>>  ///
>> @@ -108,6 +110,7 @@ pub trait Ownable {
>>  ///
>>  /// - Until `T::release` is called, this `Owned<T>` exclusively owns the underlying `T`.
>>  /// - The `T` value is pinned.
>> +#[repr(transparent)]
>
> AFAIT this `#[repr(transparent)]` isn't actually needed.

I'll drop it.

>
>>  pub struct Owned<T: Ownable> {
>>      ptr: NonNull<T>,
>>  }
>> @@ -185,3 +188,46 @@ fn drop(&mut self) {
>>          unsafe { T::release(self.ptr.as_mut()) };
>>      }
>>  }
>> +
>> +// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
>> +// pointer satisfy alignment requirements of `T`.
>> +unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {
>
> You should drop the `'static` bound and put where bound on the GAT below
> instead. See how `Box` is doing it.

I will take a look.


Best regards,
Andreas Hindborg


