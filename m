Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6881E9A779
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CA6910E5E8;
	Tue, 24 Mar 2026 12:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A5BpoCf1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43CA210E5DC;
 Tue, 24 Mar 2026 12:33:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E676140842;
 Tue, 24 Mar 2026 12:33:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466D8C19424;
 Tue, 24 Mar 2026 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774355602;
 bh=jd8iVirtHQ4a5z51jmWDeiI63f96fl/GYIMFhoiXT9Y=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=A5BpoCf1CuEzAIZr7XecZLh1Rcjabh7TpKaVKGTqVHRJxv4ehXOrffc+r9SrLlUnw
 uoLfiHcP+XUkQP+w5nHstdGab3j/yEN/RstGQRIm89vbdoD5/dtc2NSZlh7gNJYW42
 SHPWWusNQMhrQSjwvf4H7hfWL/nbpaLqUf5lDPBaLzGFuNFWXyfRiPKMmqNijTz5ZH
 p2M3SD2WjFwkvysh0Dzy91RTuUjdJJjYNL+k+iQQUn/2c9Ku4gya7K48owBayDba5Q
 kSGoAkdFDTbY/Px9SISKl8hIUFTwokDuB5i6MPOTH35ix265XBaEpk9XEb20F5m2bZ
 EqVzdC6Bgjx4w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com,
 acourbot@nvidia.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com
Cc: driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH 0/8] dma::Coherent & dma::CoherentInit API
In-Reply-To: <20260303162314.94363-1-dakr@kernel.org>
References: <9A1gWen63AbJmi06Y_vu_qF1S86nj3fcQEil9RzLAn8QkIYpCOrLMNO7JcgIP0BccPHhzaYaQ_te1S_gKuHRgg==@protonmail.internalid>
 <20260303162314.94363-1-dakr@kernel.org>
Date: Tue, 24 Mar 2026 13:33:13 +0100
Message-ID: <87cy0tqueu.fsf@kernel.org>
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

"Danilo Krummrich" <dakr@kernel.org> writes:

> This patch series introduces the dma::Coherent API Gary worked out in the
> context of his I/O projection work.
>
> Additionally, introduce dma::CoherentInit, a type that encapsulates a
> dma::Coherent object before its DMA address is exposed to the device.
> dma::CoherentInit can guarantee exclusive access to the inner dma::Coherent
> object and implement Deref and DerefMut.
>
> Also add Coherent::init() and Coherent::init_with_attrs() so we can directly
> initialize a new dma::Coherent object through an impl Init<T, E>.
>
> Danilo Krummrich (5):
>   rust: dma: use "kernel vertical" style for imports
>   rust: dma: introduce dma::CoherentInit for memory initialization
>   rust: dma: add Coherent:init() and Coherent::init_with_attrs()
>   gpu: nova-core: use Coherent::init to initialize GspFwWprMeta
>   gpu: nova-core: convert Gsp::new() to use CoherentInit
>
> Gary Guo (3):
>   rust: dma: add generalized container for types other than slices
>   rust: dma: add zeroed constructor to `Coherent`
>   gpu: nova-core: convert to new dma::Coherent API
>
>  drivers/gpu/nova-core/dma.rs      |  19 +-
>  drivers/gpu/nova-core/falcon.rs   |   7 +-
>  drivers/gpu/nova-core/firmware.rs |  10 +-
>  drivers/gpu/nova-core/gsp.rs      |  65 ++--
>  drivers/gpu/nova-core/gsp/boot.rs |   7 +-
>  drivers/gpu/nova-core/gsp/cmdq.rs |  55 +--
>  drivers/gpu/nova-core/gsp/fw.rs   |  82 ++--
>  rust/kernel/device.rs             |   4 +-
>  rust/kernel/dma.rs                | 626 +++++++++++++++++++++++-------
>  samples/rust/rust_dma.rs          |   8 +-
>  10 files changed, 619 insertions(+), 264 deletions(-)
>
>
> base-commit: 1195fcbda62f12108dc9be56fa4173897905b90c

What did you base this on?


Best regards,
Andreas Hindborg



