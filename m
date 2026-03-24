Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AD5F54ABA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 14:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B662510E152;
	Tue, 24 Mar 2026 14:02:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ASZzrdr6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF65F10E152;
 Tue, 24 Mar 2026 14:02:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1EC87600AC;
 Tue, 24 Mar 2026 14:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45611C19424;
 Tue, 24 Mar 2026 14:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774360970;
 bh=7PpyUgaN+hR/mcrAloIqkwPScbhc6VOuFnHSKYwmy0A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ASZzrdr6G1YNdy3VIWR9h0H2RO8QVyj7F4ekz66mXysHYPnmBf0CCRwv2TQz/vKd7
 lowjFRVVKzhi/0+pguVkixUKuJVDT45+GxZph9cbkMNa4iluXzAaUGIFGzs9BFtJat
 6hO5u1g49YHUDCxiC6tOzTETGItBOKB6o0p0kyw6cGzM4Q/c3u43XdBF36DNw9d0vW
 qfpgMcvLwZKl4Ie1tca7dqy5WwHH/GoRr9bPUY3rCx4G8nXWaXkWPyLMJs8DjBhlpl
 cJ9/uFyvZMLV7TI/8QHYtZF+M+Ms0hE7t0KpwqY9j81ySN7dZjVnFifkhQCf3Aw+a3
 5Ub764AMu1Lkg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com,
 acourbot@nvidia.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, tmgross@umich.edu,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com
Cc: driver-core@lists.linux.dev, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 1/8] rust: dma: use "kernel vertical" style for imports
In-Reply-To: <20260320194626.36263-2-dakr@kernel.org>
References: <20260320194626.36263-1-dakr@kernel.org>
 <IFgpz7BJ1u0FZfIVnNpmhnmvYDK9ZkoGMuAsmVCXaQKcwPA9Mx40rNBRqxfG-PXr_fCNXYsWcjqWSrFvUdzo3g==@protonmail.internalid>
 <20260320194626.36263-2-dakr@kernel.org>
Date: Tue, 24 Mar 2026 15:02:37 +0100
Message-ID: <87v7elpbpe.fsf@kernel.org>
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

> Convert all imports to use "kernel vertical" style.
>
> With this, subsequent patches neither introduce unrelated changes nor
> leave an inconsistent import pattern.
>
> While at it, drop unnecessary imports covered by prelude::*.
>
> Link: https://docs.kernel.org/rust/coding-guidelines.html#imports
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



