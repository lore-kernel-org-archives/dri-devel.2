Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B17C531FA
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 00:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC96910E0CB;
	Sat, 25 Jul 2026 00:27:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z+hxp7hD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401E410E0C6
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 00:27:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E037E4028F;
 Sat, 25 Jul 2026 00:27:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCDA1F000E9;
 Sat, 25 Jul 2026 00:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784939259;
 bh=x58oxA3VeQVlOdDSR3PBBBlT0/UZLNRhOBoFeqVL94w=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=Z+hxp7hD1HwXsVsTUiIJLQK8+VJXKQRdFydE1veSHuCGYBt2KQbCFOuXU+rpc4Xtt
 6M3Nvw0QYXcq2+l5cFJGeAbqQFPEKtkGkDQ0YyiG4WBjmuj4DxARR9YpnrVkFd+QsD
 zQbg9N6vMpeCAv0rFnR+tOyglKE1+kFbq9HMMC1wUJ+LDoi7TGsu5nrGwlMDLrRFb8
 2fNxXJqFiug+5074iGlQ3LyLnRJKq2VQMLKV0A993sZFyShr73R4zcjLkEFVehPwyF
 d8tFwxkIA5pN5ZZF818JxSYYGx5+aRk39W+kgFLnaPGrCguNgO1WBaL/xDglucqFfA
 v1CE90wif1INQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jul 2026 00:27:35 +0200
Message-Id: <DK75LUA4NLGI.3P29AIZQE20V2@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 2/2] gpu: nova-core: falcon: use I/O projection to check
 transfer bounds
References: <20260724-falcon-dma-projections-v1-0-957028a7c0a7@nvidia.com>
 <20260724-falcon-dma-projections-v1-2-957028a7c0a7@nvidia.com>
 <e7ba2c90-6d4f-487e-bd25-56d568ba1f26@nvidia.com>
In-Reply-To: <e7ba2c90-6d4f-487e-bd25-56d568ba1f26@nvidia.com>
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

On Fri Jul 24, 2026 at 8:10 PM CEST, John Hubbard wrote:
> Sort of "conceptually pre-existing" problem, but "handle" doesn't
> quite work as a name, because handles are supposed to be opaque
> items that one just uses to find and refer to things.

This is inherited from the C API where from its perspective the returned ba=
se
DMA address of the allocation actually serves as a handle.

In Rust the actual handle is represented by different types with different
invariants and hence capabilties.

(For instance, dma::CoherentBox does not expose the DMA address at all, and
hence provides access to its contents through a direct mutable reference,
whereas dma::CoherentHandle only provides access to the DMA address and doe=
s not
have a CPU virtual mapping; dma::Coherent provides access to both.)

Both dma::Coherent and dma::CoherentHandle have a dma_handle() method which
provides access to the DMA address; this naming was taken over from the C A=
PI.

Given that the base DMA address serving as a handle from the perspective of=
 the
C API is just an implementation detail, we should probably just rename this
method to dma_address().
