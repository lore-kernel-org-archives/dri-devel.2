Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434C4E9D804
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 15:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7B4C10E165;
	Sun,  5 Apr 2026 15:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K93rGjgy";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E679710E165
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 15:15:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B2A4600CB;
 Sun,  5 Apr 2026 15:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDBAC116C6;
 Sun,  5 Apr 2026 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775402149;
 bh=iG6y+N88VDviY9Rc8PGy4cWFbqc/+Z7HoEe1Aq08Tio=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=K93rGjgyqEHODDP0Drag0+382z+24YYshWvzwJhbyWwtE936cm95Ml4IUorpRnNcQ
 8v0R8/9uVaYltiw+U6q9pHWGwrvlb3yQ7U+hZPc0LIyp5wAzpZkr/rjvU7jNEVN0w2
 +vekJYVLaBOeaDQwpPJ6PsXZUDXqLWCmQ31d6SOF+liBnTCJv5FzqinRLMZQjr2yc8
 9LIwyat2VQGpJKVChOwQO0RW68wzEsMB2YpFxVA9I7fB0hgkxlFgS6thPsOODxtPu5
 jqsJXS0weu4ujOj4UpPAXoFS/9F9YIi3uZQU0kWyeIFvkj30K9H1OHvGLnOTZYUHf3
 rlmkEqkiPRZJA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 17:15:44 +0200
Message-Id: <DHLBJ9NMLXFB.5H53BZ132FHG@kernel.org>
Subject: Re: [PATCH v2] gpu: nova-core: falcon: pad firmware DMA object size
 to required block alignment
Cc: "Alice Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260405-falcon-dma-roundup-v2-1-4af5b2ff9c16@nvidia.com>
In-Reply-To: <20260405-falcon-dma-roundup-v2-1-4af5b2ff9c16@nvidia.com>
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

On Sun Apr 5, 2026 at 4:22 AM CEST, Alexandre Courbot wrote:
> Commit a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
> dropped the nova-local `DmaObject` device memory type for the
> kernel-global `Coherent` one.
>
> This switch had a side-effect: `DmaObject` always aligned the requested
> size to `PAGE_SIZE`, and also reported that adjusted size when queried.
> `Coherent`, on the other hand, does page-align allocation sizes but only
> allows CPU access on the exact size provided by the caller.
>
> This change runs into a limitation of falcon DMA copies, namely that DMA
> accesses are done on blocks of exactly 256 bytes. If the provided data
> does not have a length that is a multiple of 256, `dma_wr` returns
> an error.
>
> It was expected that all firmwares would present the proper adjusted
> size, but this is not the case at least on my GA107:
>
>     NovaCore 0000:08:00.0: DMA transfer goes beyond range of DMA object
>     NovaCore 0000:08:00.0: Failed to load FWSEC firmware: EINVAL
>     NovaCore 0000:08:00.0: probe with driver NovaCore failed with error -=
22
>
> Fix this by padding the `Coherent`'s size to `MEM_BLOCK_ALIGNMENT` (i.e.
> 256) when allocating it and filling it with zeroes, before copying the
> firmware on top of it.
>
> Fixes: a88831502c8f ("gpu: nova-core: falcon: use dma::Coherent")
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Applied to drm-rust-next, thanks!
