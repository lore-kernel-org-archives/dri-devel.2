Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B31C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6160510E51E;
	Mon,  7 Sep 2026 21:06:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CaoOipGM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59B4E10E51E
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 21:06:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58D47601DB;
 Mon,  7 Sep 2026 21:06:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9161F00A3A;
 Mon,  7 Sep 2026 21:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788815206;
 bh=90F9gpIn6ahg1Sh32fek9TE5xaVsZqJW6WdR2q7nJtE=;
 h=Date:Subject:Cc:From:References:In-Reply-To;
 b=CaoOipGMy+LRNytnbxmP9ZFmgaCGRcVpuOcDUxNDoNnDM+chAKVS3z/SXqC61FkUo
 hU5DbovmMj5tFB8LfDtshTKDvvGJdBPkrfS0YAj2pmLNy2AgCEyhsXk67NccTBz845
 oISqnvxdR/VOFI6UfhjeoO3O5Pu2gTZG8TzN2jYS0+MW58cq8ZUjLJL1vfChPKVAX4
 VvZkwdVgN7soN9BkH89HPHNFtn5ckczW6lmCuht7erv7PdPJ9CU9m6ObULR1/xi1wS
 RbNl564Rg+zj66OfqyUmjs2TD8gunPwNniUK0TyuOE32AKpROMJx9fLuku2w8wbovB
 rnv5+kbJs1aOw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Sep 2026 23:06:40 +0200
Message-Id: <DL9E2EFLN138.3DMBLYEZRFW1R@kernel.org>
Subject: Re: [PATCH 0/4] rust: dma: tie DMA allocations to the device's
 bound lifetime
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <work@onurozkan.dev>,
 <mmaurer@google.com>, <driver-core@lists.linux.dev>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260906153753.3207797-1-dakr@kernel.org>
In-Reply-To: <20260906153753.3207797-1-dakr@kernel.org>
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

On Sun Sep 6, 2026 at 5:37 PM CEST, Danilo Krummrich wrote:
> On Sun, 30 Aug 2026 21:37:12 +0200, Danilo Krummrich wrote:
>> [PATCH 0/4] rust: dma: tie DMA allocations to the device's bound lifetim=
e
>
> Applied, thanks!
>
>   Branch: topic/rust-dma
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/drive=
r-core.git
>
> [1/4] rust: debugfs: drop 'static bound from ScopedDir file creation meth=
ods
>       commit: 9dc6cedcd971
>
>       [ Remove unrelated change from Self to T. - Danilo ]
>
> [2/4] rust: dma: tie CoherentHandle to the device's bound lifetime
>       commit: f6b56da8e1b8
> [3/4] samples: rust_dma: separate driver type from driver data
>       commit: c3d4fd0e9d27
> [4/4] rust: dma: tie Coherent and CoherentBox to the device's bound lifet=
ime
>       commit: bed87375f90f
>
> The patches are in the topic/rust-dma topic branch and will be merged int=
o the
> corresponding target branch soon.

Merged into driver-core-next and drm-rust-next, thanks!
