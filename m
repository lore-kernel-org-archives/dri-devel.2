Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF80FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:02:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25B6110EA70;
	Tue, 28 Apr 2026 09:02:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G4uy1uyk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3FE810EA70;
 Tue, 28 Apr 2026 09:02:48 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2E76860142;
 Tue, 28 Apr 2026 09:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48643C2BCB9;
 Tue, 28 Apr 2026 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777366967;
 bh=fxgbGHVRz1ywfeOSWG9/OADuVPypGsAnHakjAZLrTgo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=G4uy1uykTjJRtJifi3TnPMVrhH8Gb3uQuVBFXarQGQ+BxBKIs7aeGa4YcVa5yg2BG
 MuEI5KuJ1ZUIkWhSwrZzPfO9JxSdxf49ZFZeWcvyCfm4AULtXvW96UTDkYggbbn7u8
 gkyanPP3HCQ5eAa86YK0D0KBU7TVZibE0dvxpGr6ZwcXQEP3rWqzU9s0yg2hX+TLTC
 MfXguyzOPJWql8yGB4rLI7UGfSYnvlnJlUO0RZKYoZyEbcfINdIj1i9BOYZL9Zh1kb
 pWwqKWuzUg/O6VYUrDPlRTV+d7V2R/efjHSAszax6DKhVO65phE5PptniMAZ60xmIo
 uNvb/zpuJNxbQ==
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
Subject: Re: [PATCH v2 04/11] rust: io: add missing safety requirement in
 `IoCapable` methods
In-Reply-To: <20260421-io_projection-v2-4-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-4-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 09:16:16 +0200
Message-ID: <877bprr1vj.fsf@t14s.mail-host-address-is-not-set>
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

> The current safety comment on `io_read`/`io_write` does not cover the topic
> about alignment, although this is guaranteed by checks in `Io`. Add it so
> it can be relied on by implementor of `IoCapable`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/io.rs | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 1682f2a0d20d..c6d30c5b4e10 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -216,14 +216,16 @@ pub trait IoCapable<T> {
>      ///
>      /// # Safety
>      ///
> -    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
> +    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
> +    /// - `address` must be aligned.
>      unsafe fn io_read(&self, address: *mut T) -> T;
>  
>      /// Performs an I/O write of `value` at `address`.
>      ///
>      /// # Safety
>      ///
> -    /// The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
> +    /// - The range `[address..address + size_of::<T>()]` must be within the bounds of `Self`.
> +    /// - `address` must be aligned.
>      unsafe fn io_write(&self, value: T, address: *mut T);
>  }

You should probably update safety comments at call sites in this patch.
For instance in `Io::try_read`:

        let address = self.io_addr::<L::IoType>(location.offset())?;

        // SAFETY: `address` has been validated by `io_addr`.
        Ok(unsafe { self.io_read(address) }.into())

But the documentation for `io_addr` says nothing about the return value
being aligned:

    /// Returns the absolute I/O address for a given `offset`,
    /// performing runtime bound checks.

Best regards,
Andreas Hindborg


