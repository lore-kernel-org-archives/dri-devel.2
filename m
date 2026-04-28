Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3F2FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12CE10EB6A;
	Tue, 28 Apr 2026 12:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FavAcvIf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBAB10EB6B
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:43:14 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B707661146;
 Tue, 28 Apr 2026 12:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648BEC2BCAF;
 Tue, 28 Apr 2026 12:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777380192;
 bh=sGu6CTVPzirUUCc5JiSYDfSxPlZrDUgh6IQwgRUcA1s=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
 b=FavAcvIf1v39Fa3H+MhGLDIwHiad8KyT/IuwaU29YVyCH+PwI7HR26iuG28qlkWIz
 s7gujzWFLJIXvhini36L92rLeQfZ/AaL+ZHDpSTD2Bje/Myl377MepZWR7iYmdWLJx
 8Qb3msQIX3y13qSSb0VGDTUBAHkYE6P+6WjbbFXQTxGTdzqfesh4d6xJoJWU02APwI
 GLhicsSuJy24MOvQkU6m+O98FFh7FRTaFWUCEKU/48uuro7nOzaLjR8+1iUkD7Vxsl
 DTd5ypfoP/98T8D0iey+zmN4/lFH6ppTDWy8v/y1usPh1QjqtBfodhYRrqCCMjM8//
 uSFivjANtNPwg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 28 Apr 2026 14:43:07 +0200
Message-Id: <DI4SOY5IQR77.1D97MMFEQEOCW@kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: drm: fix unsound initialization in drm::Device::new
Cc: "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alice Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20260428-fix-drm-1-v1-1-755057178066@nvidia.com>
In-Reply-To: <20260428-fix-drm-1-v1-1-755057178066@nvidia.com>
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

On Tue Apr 28, 2026 at 2:20 PM CEST, Eliot Courtney wrote:
> If pinned initialization of drm::Device::Data fails, it calls
> drm::Device::release via drm_dev_put. This materializes a reference to
> &drm::Device, but it's not fully constructed yet, because initializing
> `data` failed. It should not be dropped either. Instead, if pinned
> initialization fails, make sure drm::Device::release isn't called.
>
> Fixes: 2e9fdbe5ec7a ("rust: drm: device: drop_in_place() the drm::Device =
in release()")
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

There's already a patch from Lyude for this [1].

That said, I like the approach with the ALLOC_VTABLE.

@Lyude: Do you mind if we pick Eliot's patch?

Thanks,
Danilo

[1] https://lore.kernel.org/lkml/20260320233645.950190-2-lyude@redhat.com/
