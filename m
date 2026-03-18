Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B90F103E199
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 15:40:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B13710E027;
	Wed, 18 Mar 2026 15:40:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TctQZorW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FD310E027
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 15:40:22 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0DEEC60097;
 Wed, 18 Mar 2026 15:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2528C2BCB2;
 Wed, 18 Mar 2026 15:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773848421;
 bh=HaDlN4m9XrRAyVtC/LuCH3iWArwi4yOF24nx6g0nWhI=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=TctQZorWRzTScSkXt00pdUMV3qYtMQhck0oMz7N1ozP5Ye1C7DwSg5zjcsTJc9g1y
 Tz/fpeIEqwq0gq/vEADxrt2bK/HGHpJ3wBmF5J6J9SwCnhY2HlIMSJ7rsr4RHvrZzj
 YoRPqj0xAc97VUSj7ypj+VlqGTIeVAWWhi0+NzQjLlZPskozj3irBNbDwOsU90xaB5
 KRxHBHgS07jtUtIt+J010pWUe05L0KVh3A9JZonUEbsQL6VNfyChHB91jm8qdwQOd8
 SPxCnc81MSq1TsdYrFQDUt3MtTZguPJ4ZfHCAd8/bbqvPy5ehRJG2Y8OaWBmEPdDYk
 z+QSH8HhvqTNw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 18 Mar 2026 16:40:17 +0100
Message-Id: <DH60S91O053Z.1DDUJSL0D6NQQ@kernel.org>
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Zhi
 Wang" <zhiw@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: gsp: add mutex locking to Cmdq
References: <20260318-cmdq-locking-v5-0-18b37e3f9069@nvidia.com>
 <20260318-cmdq-locking-v5-5-18b37e3f9069@nvidia.com>
 <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
In-Reply-To: <DH60IMOXP3O2.26EAXOW3BC7S4@nvidia.com>
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

On Wed Mar 18, 2026 at 4:27 PM CET, Alexandre Courbot wrote:
> On Wed Mar 18, 2026 at 1:07 PM JST, Eliot Courtney wrote:
> <snip>
>> +    /// Returns the DMA handle of the command queue's shared memory reg=
ion.
>> +    pub(crate) fn dma_handle(&self) -> DmaAddress {
>> +        self.inner.lock().gsp_mem.0.dma_handle()
>> +    }
>
> Just noticed that we now need to lock to get the DMA handle. It's
> inconsequential in practice but a bit inelegant.
>
> Since the DMA handle never changes, and is only ever needed during
> initialization, I think I will just insert a patch before this one that
> adds a `pub(super) dma_handle` member to `Cmdq`. That way we only need
> to obtain the handle at construction time and can get rid of this
> method, which keeps the public API focused on message handling.
>
> No need to resend, I will apply this patch on top of mine and merge.

It is a minor inconvinience, but it may indicate that dma::Coherent should
probaly support locking, i.e. you want to protect the data within the
dma::Coherent allocation, not the dma::Coherent object itself.
