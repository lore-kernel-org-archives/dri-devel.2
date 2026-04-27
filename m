Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E6CFF8861
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:28:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B17810E6EA;
	Mon, 27 Apr 2026 11:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CKf7kjVa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CECDA10E6E5;
 Mon, 27 Apr 2026 11:28:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B6D7444413;
 Mon, 27 Apr 2026 11:28:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48676C2BCB6;
 Mon, 27 Apr 2026 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777289325;
 bh=t8qbdGApkXc67C5NnjZ7tvOcU2R+JY87tSW+zpj3HpA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CKf7kjVaGTbyarud+ThC4Vxiu8xbySQouSnNVb/Vmzb1AWQR6AmGBbWlgljgoQzB4
 LW7crYz45tOqZ9D85aVv+f2uqFy/SO2IHk+sFtbb2oInLixMS2ezG8ZSAGOwhYkVD7
 W32cfeHWob0h39EEEo2xJkYjbfy8c9MM+i0dxqBMmmEtNwMkhj6BW4fxdoSd0MpvVG
 /lVb0IFO0ewg1qMpHZr7VDmt86BZps2ybG+B6Q813TXyiJpCO2fQhQvaTyQOCx4dTM
 +w+rPl/+gPc4BH3+v5baSFY5BLzzXNYmRkL2lLSALBeJ78T+zzkJWyPeFd+YE9eSoL
 K5U8sVVf59wOg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Danilo Krummrich <dakr@kernel.org>, Abdiel
 Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Alexandre
 Courbot <acourbot@nvidia.com>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Gary Guo <gary@garyguo.net>
Subject: Re: [PATCH 2/5] rust: dma: update to keyworded index projection syntax
In-Reply-To: <20260415-projection-syntax-rework-v1-2-450723cb3727@garyguo.net>
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <Y_UaWMYTo9Xb8viyPNggy28srKaFUvKR9HjIcL1PpalkyTdjVdIgSU_O-zU-kbfo7QT3pyp6v8v03_EeVCUNEw==@protonmail.internalid>
 <20260415-projection-syntax-rework-v1-2-450723cb3727@garyguo.net>
Date: Mon, 27 Apr 2026 13:25:58 +0200
Message-ID: <87o6j4r6ex.fsf@t14s.mail-host-address-is-not-set>
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

> Demonstrate the preferred syntax of index projection in DMA documentation
> and examples. A few `[i]?` cases are converted to demonstrate the new
> variant.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


