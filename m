Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B54FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 11:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 017D010E6E6;
	Mon, 27 Apr 2026 11:28:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hnrflk4Q";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CBA10E6DE;
 Mon, 27 Apr 2026 11:28:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BAD07404C1;
 Mon, 27 Apr 2026 11:28:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590C8C2BCC4;
 Mon, 27 Apr 2026 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777289320;
 bh=0ntWNbklvUzaFLNmsuPMmji7kfRyTy64xl0FVAXz08k=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=hnrflk4Qdm/hoBxk6yOl6mcleMj2mciyydKP3x2TywvalzuNUL2clXmwVx1M01F81
 dHfQAC3sBQEswGY/g59rwWcF9kHVRsO+nIYj2grspkxCLvN8LweCcaeqUfMNpNMzVt
 /V+ythcZMaiVBj+tdJu7kzNhSj6E4d4dXHrlLENZ8046FuAtCuUdDYP0GAavHXauOb
 QFhoCqW199YPKadQcJX7qx50jzNhyrp8Saa4GGj1hkesMPLO+D/6NiIZpM4vF9BRD3
 yF1v6bQ9P+UkMY6O5SXPc2a5Hl3pqnWYEjH+4YwGnwB6LowYXdEr9q1jlKIX3r5FJQ
 AYb6BErMWmYfg==
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
Subject: Re: [PATCH 5/5] rust: ptr: remove implicit index projection syntax
In-Reply-To: <20260415-projection-syntax-rework-v1-5-450723cb3727@garyguo.net>
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <ltBY5QYjK4tx6VmSUSi569gKrxT5ihMyaCPL6NuzcjUQNiX536ppjNAjUP9d5eTTBqcksl_pdY6QQrJ6Oy8rPg==@protonmail.internalid>
 <20260415-projection-syntax-rework-v1-5-450723cb3727@garyguo.net>
Date: Mon, 27 Apr 2026 13:28:01 +0200
Message-ID: <87lde8r6bi.fsf@t14s.mail-host-address-is-not-set>
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

> All users have been converted to use keyworded index projection syntax to
> explicitly state their intention when doing index projection.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



