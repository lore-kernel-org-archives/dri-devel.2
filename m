Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D781FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:08:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EDD10EB3F;
	Tue, 28 Apr 2026 12:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DKwT5p8s";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34FDC10EB3F;
 Tue, 28 Apr 2026 12:08:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EA11E60121;
 Tue, 28 Apr 2026 12:08:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B8AC2BCAF;
 Tue, 28 Apr 2026 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777378118;
 bh=bx1ifRArObM42P8yCs3Ae3LAphgQ1Y9Mfvr1LOcdNP8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=DKwT5p8sXqLksai0T4gDZsYJaBgGe5jxxcx4RdviKe4CnegOWRIq6oeEFJ96xctcA
 HNpcFq0+xxHcc9Gtt0BkKVn3a/ff/5P31tYFcbr7fSLFi8sB0M+tkoJo6XPykqee8J
 Ssn5NHe6xcqGqLS10l5SAK4FOig28JEOzReRi2lA28uPK/RYRuhBxNhlq//T2uZsVp
 t7STRp7Nk4KMLQgBxzDqOSAJRLpW3PYptqwXyAbuw8eK3wuRVGXj+wQAxD4/fa0wys
 OmUUfrBT5XX4rAsNkOWeYSHB125rLT/HpcKoPCAV1GOKs/IvPjCvhQVfDLbFBQJBbQ
 yOKz9vYE7a1+Q==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Gary Guo <gary@garyguo.net>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel
 Almeida <daniel.almeida@collabora.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy
 <robin.murphy@arm.com>, Alexandre Courbot <acourbot@nvidia.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 05/11] rust: io: restrict untyped IO access and
 `register!` to `Region`
In-Reply-To: <DI4QT2U1098S.3K9K7INQ86M0Q@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
 <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
 <vYp32vOGPut322JQ-5jSBZQNd6eXvnOvg8b6YDhYcYzBqTBVUvSajCJng33oXSQ9wiMvb62VLERzLYSa4g2pJQ==@protonmail.internalid>
 <DI4QT2U1098S.3K9K7INQ86M0Q@garyguo.net>
Date: Tue, 28 Apr 2026 14:08:05 +0200
Message-ID: <87tssvp9sq.fsf@t14s.mail-host-address-is-not-set>
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

> On Tue Apr 28, 2026 at 10:02 AM BST, Andreas Hindborg wrote:
>> Gary Guo <gary@garyguo.net> writes:
>>
>>> Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
>>> `Io` region itself is typed, then it might be weird to have
>>>
>>>     let io: Mmio<u32> = /* ... */;
>>>     io.read8(1);
>>>
>>> while not unsound, it is surely strange. Thus, restrict the untyped methods
>>> and also the register macro to `Region` type only.
>>>
>>> The way it is implemented is by adding a generic type to `IoLoc`. This also
>>> paves the way to add typed register blocks in the future; for example, we
>>> could use this mechanism to block driver A's `register!()` generated macro
>>> from being used on driver B's MMIO. The same mechanism could be used for
>>> relative IO registers. These are future opoortunities, and for this patch I
>>> just restricted everything to require `IoLoc<Region<SIZE>, _>`.
>>
>> Does this not prevent `usize` from being used to index anything but
>> `Mmio<Region<_>>`?
>>
>> It is my understanding that the following would work before this patch:
>>
>>    fn do_read(io: &Mmio<u32>) -> Result {
>>        let v: u32 = io.try_read(8usize)?;
>>        Ok(())
>>    }
>>
>> But I think this will no longer work with this patch. Is that the intention?
>
> Your example would always fail, as you're reading 4 bytes from offset 4 from a
> region that is only 4 bytes in size. I suppose you're trying to say
>
>     fn do_read(io: &Mmio<[u32]>) -> Result {
>         let v: u32 = io.try_read(8usize)?;
>         Ok(())
>     }

Yep, that was my intention, with the assumption that final offset
becomes 8*4. I think that is also what would happen here as we would
invoke `try_read::<u32, usize>(&Mmio<[u32]>, usize) -> Result<u32>` with

  usize: IoLoc<u32>
  Mmio<[u32]>: IoCapable<u32>


> ? In any case, it's intended to be unsupported. For types regions you can use
> projection. So the same code can be written as
>
>     fn do_read(io: &Mmio<[u32]>) -> Result {
>         let v: u32 = io_read!(io, [try: 2]);
>         Ok(())
>     }
>
> i.e. reading from index 2 instead of byte offset 8. If one cares about byte
> offset they would probably want to use the register macro instead or having the
> MMIO region untyped.

Right, makes sense. Again, my thoughts were not around the byte-offset,
but the `location` parameter being in count of elements of `T`.

But why remove the ability to call `try_read::<u16, usize>(&Mmio<[u32]>,
usize) -> Result<u16>`?

Best regards,
Andreas Hindborg


