Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D372FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BBA10EBC6;
	Tue, 28 Apr 2026 13:22:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kszh/63M";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B35610EBC6;
 Tue, 28 Apr 2026 13:22:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id F0BA461119;
 Tue, 28 Apr 2026 13:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E17AC4AF09;
 Tue, 28 Apr 2026 13:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777382568;
 bh=9rjTYTuP7L8sLjc7X69kwiggXB2C5UsAdNVY1jH4Pk4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kszh/63MBzQJEBmRrcmOOTYxhbiH13kOw4r74yEHr2fPGmknb/wxFKK+mPYoY0GER
 gajWe17zROcN87QMYobkstYdeaU7QjKWxTkg5CN5v12MLTMG+8PSmrRItUxUKAecXe
 J53yiINuqNVAZOGRNUKY4SydOjZvhlyTyRD1Bn50JgBrhGHcOYNyaFV0i9p2UorAJ/
 jfwlXFH0ebYuCb5q12m19COHXFOQidwX46t2g0iSXekZgAgvt6cRHqN8jcTnjbaTk2
 VO5oEvlFOpsHszFelT3A5Nr7qKMNK+PyOdeKk81+kMprCMYXrnLImb5xCLhVqIWSTH
 Fida1mVcj3kQg==
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
Subject: Re: [PATCH v2 07/11] rust: dma: add methods to unsafely create
 reference from subview
In-Reply-To: <20260421-io_projection-v2-7-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-7-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 14:10:12 +0200
Message-ID: <87qznzp9p7.fsf@t14s.mail-host-address-is-not-set>
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

> Implement `Io` for `Coherent`, so now `dma::Coherent` can be used with I/O
> projections.
>
> This allows the `as_ref()` and `as_mut()` API to be used in smaller region
> than the whole DMA allocation itself. For example, if a ring buffer is
> shared between GPU and CPU, users may now use the `io_project!` API to
> obtain a view of the buffer that is uniquely owned by the CPU and get a
> reference.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



