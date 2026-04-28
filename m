Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78275FF8868
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3BC10EB45;
	Tue, 28 Apr 2026 12:08:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jJSopcu7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92ACA10EB40;
 Tue, 28 Apr 2026 12:08:45 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1790660139;
 Tue, 28 Apr 2026 12:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC4EC2BCAF;
 Tue, 28 Apr 2026 12:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777378124;
 bh=bOwF+0GUALysM7CRy5XbgigqUCNNq+JTaQXbBGbEwis=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=jJSopcu7jda15HdeY0xhBlkZIwx+pxlClsFUQyJUaur9Cx6PomSExXBNiotCduBKv
 UyLAU3q3OED38hrsZZsx97gkH2Ej6yu+ex2+y0ZY619YfQSS+39Q86Xk9K/ryo5iTx
 JY6irGEZSXTjjfU+vItU855lkPZTbmcSBWY299jeqK8wEoAPB5+Bsjcxf8BN9g2lb4
 zT+dBjFhOwFCxfJ0lL51UhVvBtLq9RLhzLYGAfD+JyT7RHJudnAATVT4yoUbinp36R
 Q/mm+t8MZyd/Eq0lUyPZ2m9qOHtMli+VaE9koZJAn6KZsCzmmYptnCgBCtAY0/sL17
 ylekKk/IrXwYg==
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
Subject: Re: [PATCH v2 10/11] rust: dma: drop `dma_read!` and `dma_write!` API
In-Reply-To: <20260421-io_projection-v2-10-4c251c692ef4@garyguo.net>
References: <20260421-io_projection-v2-0-4c251c692ef4@garyguo.net>
 <20260421-io_projection-v2-10-4c251c692ef4@garyguo.net>
Date: Tue, 28 Apr 2026 13:16:57 +0200
Message-ID: <87wlxrpc5y.fsf@t14s.mail-host-address-is-not-set>
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

> The primitive read/write use case is covered by the `io_read!` and
> `io_write!` macro. The non-primitive use case was finicky; they should
> either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert the
> lack of concurrent access, or should be using memcpy-like APIs to express
> the non-atomic and tearable nature.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg


