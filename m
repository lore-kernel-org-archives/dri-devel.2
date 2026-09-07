Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12460C79F99
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 17:48:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3586810E056;
	Mon,  7 Sep 2026 17:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YqQJEem/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3A7210E056
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 17:48:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8038601DB;
 Mon,  7 Sep 2026 17:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5E81F00A3A;
 Mon,  7 Sep 2026 17:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788803295;
 bh=bS1qZ/XIBX3jq/MS6/8/SYsogjn2xT0pzwijJAZpnT8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YqQJEem/l3sQWCzKDHeiv2Zn/9ofYsiWZL7n06Rgp/+XURvoYGgUTQ+WBYiw9qx/5
 Ce0cpFy3pLkoU1nq1dRKMYbKLg1R0m/jNYfon+cUau4IAmc7Ceo5zooRuSzugsVO6N
 vwHcw0zoelak7tQa2DnNyfB2qmZuQvtsE97672k5GHeKyVrLIcc9yf62UbzMFyxwAf
 N3QnVnKzN5QdjC3kLq9JmRsz+8Ezd1wWAvlw0agsEDvcAVVYcGT3HzP0UiXWyhIT/y
 kEvmfNpUFmn7Pdn086fVsM//Ry9WbtJh6AycgGX40r5DNwYmIDB9CYawGDmSCd30/Q
 jDW8r6Cw/JMyA==
From: Danilo Krummrich <dakr@kernel.org>
To: Philipp Stanner <phasta@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>, Burak Emir <burak.emir@gmail.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v11 0/2] rust / dma_buf: Add abstractions for dma_fence
Date: Mon,  7 Sep 2026 19:47:30 +0200
Message-ID: <20260907174729.3669166-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905085343.1827305-2-phasta@kernel.org>
References: <20260905085343.1827305-2-phasta@kernel.org>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat,  5 Sep 2026 10:53:41 +0200, Philipp Stanner wrote:=0D
> [PATCH v11 0/2] rust / dma_buf: Add abstractions for dma_fence=0D
=0D
Applied, thanks!=0D
=0D
  Branch: drm-rust-next=0D
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git=0D
=0D
[1/2] rust: Add dma_fence abstractions=0D
      commit: 3282d5916019=0D
=0D
      [ In dma_fence_callback(), split combined unsafe block into separate=
=0D
        blocks for container_of!() and pointer dereference. - Danilo ]=0D
=0D
[2/2] MAINTAINERS: Add entry for Rust dma-buf=0D
      commit: 7aa432f5121b=0D
=0D
The patches will appear in the next linux-next integration (typically withi=
n 24=0D
hours on weekdays).=0D
=0D
The patches are queued up for the upcoming merge window for the next major=
=0D
kernel release.=0D
