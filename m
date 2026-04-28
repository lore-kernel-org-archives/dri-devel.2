Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B7CFF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACC5610ECD2;
	Tue, 28 Apr 2026 13:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OiiW3wML";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE3710EBC6;
 Tue, 28 Apr 2026 13:22:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 155A461119;
 Tue, 28 Apr 2026 13:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8093CC2BCAF;
 Tue, 28 Apr 2026 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777382562;
 bh=M1huU9amtIwVkVET6Mnt5+JELOvaJpGXaOgvuKFhvMs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=OiiW3wMLHpl4S5Wz4DZtog1aQWzIYgBsMSYspKvyKB8CIWD91tcGzzeyTNYgfv7wf
 mEgvRbMt7A+3wgGvh/nT/1R/D6EEjoq2kBU10hxHwg2jU0AK03H4vC/HJMrQsFJVEL
 BSjhkvwvmNJjhI701K9k06IuP+iBAwShkzlAk8sLRQQRsP1s71TghxfnVEGXtWeuE6
 hZHcu+uD0LgWthhMv08g/dEyRIFqd6HpV6j0FmpAHpdig823kFoWsMvT1nstacs4jc
 fBNE8/dPdy20V+za2VdbCqfOE9Dq9a6MKUNCSs99wR0pziJSuU6jIL89Df4j8mVInb
 luRTpuL2qYUpA==
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
Subject: Re: [PATCH v2 08/11] rust: io: add `read_val` and `write_val`
 function on I/O view
In-Reply-To: <20260421-io_projection-v2-8-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-8-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 14:53:39 +0200
Message-ID: <87o6j3p7os.fsf@t14s.mail-host-address-is-not-set>
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

> When a view is narrowed to just a primitive, these functions provide a way
> to access them using the `IoCapable` trait. This is used to provide
> `io_read!` and `io_write!` macros, which are generalized version of current
> `dma_read!` and `dma_write!` macro (that works on `Coherent` only, but not
> subview of them, or other I/O backends).
>
> For DMA coherent objects, `IoCapable` is only implemented for atomically
> accessible primitives; this is because `read_volatile`/`write_volatile` can
> behave undesirably for aggregates; LLVM may turn them to multiple
> instructions to access parts and assemble, or could combine them to a
> single instruction.
>
> The ability to read/write aggregates (when atomicity is of no concern),
> could be implemented with copying primitives (e.g. memcpy_{from,to}io) in
> the future.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



