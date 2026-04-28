Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A10FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3747D10EA8F;
	Tue, 28 Apr 2026 09:02:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NAK5XUKF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB6910EA8F;
 Tue, 28 Apr 2026 09:02:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2C4CB6014C;
 Tue, 28 Apr 2026 09:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850B2C2BCB8;
 Tue, 28 Apr 2026 09:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777366974;
 bh=8yzRRXLfiwZ2u7ZWEAZNz76TJ2spxwIMhj+GhPigBKI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NAK5XUKFRmLvqRelgIUloT12JrGj0EmUjRNIskUaTVK2a5V/ox1zt+THQitdNIg9c
 RqGpzHBeqlKpoaJq4I4DoXIo/SECYCRRAqBZcxsYI3YegEMHORAK+l/81mLmRYoki7
 qP4nEhF/iftVYz6t6sSWxhVv63EnzjjbXykiPMSwQxa62dPSmrJH1afsQZoLOkhm/3
 QE83XQUuL+MeT3hqVsqg3QynmRI9RU8UhyjT0l9o/ucbSFZzLgoTR4liXiKzYHweiE
 luji4sr8gPkUUwLuCu+dE49xwvCG4M4W9ED397hh5YoBfZJB6l/rMhQ1z4WHhlhtc4
 +4bziSKpNX6zg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Abdiel
 Janulgue <abdiel.janulgue@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 05/11] rust: io: restrict untyped IO access and
 `register!` to `Region`
In-Reply-To: <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-5-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 11:02:34 +0200
Message-ID: <874ikvqwyd.fsf@t14s.mail-host-address-is-not-set>
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

Gary Guo <gary@garyguo.net> writes:

> Currently the `Io` trait exposes a bunch of untyped IO accesses, but if the
> `Io` region itself is typed, then it might be weird to have
>
>     let io: Mmio<u32> = /* ... */;
>     io.read8(1);
>
> while not unsound, it is surely strange. Thus, restrict the untyped methods
> and also the register macro to `Region` type only.
>
> The way it is implemented is by adding a generic type to `IoLoc`. This also
> paves the way to add typed register blocks in the future; for example, we
> could use this mechanism to block driver A's `register!()` generated macro
> from being used on driver B's MMIO. The same mechanism could be used for
> relative IO registers. These are future opoortunities, and for this patch I
> just restricted everything to require `IoLoc<Region<SIZE>, _>`.

Does this not prevent `usize` from being used to index anything but
`Mmio<Region<_>>`?

It is my understanding that the following would work before this patch:

   fn do_read(io: &Mmio<u32>) -> Result {
       let v: u32 = io.try_read(8usize)?;
       Ok(())
   }

But I think this will no longer work with this patch. Is that the intention?


Best regards,
Andreas Hindborg


