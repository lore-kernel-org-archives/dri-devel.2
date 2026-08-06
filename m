Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD597C56208
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 21:25:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD47E10F2EE;
	Thu,  6 Aug 2026 21:25:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OhRr/xNG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E02610E3B6
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 21:25:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D32DA43653;
 Thu,  6 Aug 2026 21:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15951F000E9;
 Thu,  6 Aug 2026 21:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786051514;
 bh=3tceK2xtNlYhOcz6OaNWtrjdb7u3B+Z01jO55koQw/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OhRr/xNG+ECcrQHdUYyPQn2zb+sN/O8z1e9koTN9fa9P2ILDYNnf3Hoy3BVlKUoMV
 r9ZTn4iWTqFuBzgLR/qCDaMaq86GcYxNdF2jIHz+RGajLmmyN9YHvqIqnPVaKUtVCT
 1KPiAsLL2zBNhH9PcFRyua/CV6C5FvdE7ssOSagDqwd9lpaBbXAC17yO5Cq7CDeQd2
 XDZqC6XukbeUV6tPvxmYOjtu1eXY5yV7fZlGmu4gyo+HSSrBDspFDZL0ig+QKoNzHl
 vJASPkFYKk4Tuku06FKXJyo4GZD5ZGizIRzKoNaP5YCnqe77lpK/1ZE/rHPnx5eRkH
 GtP5vAbp6M8IQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 0/3] gpu: nova-core: falcon: use I/O projections for
 DMA transfers
Date: Thu,  6 Aug 2026 23:25:03 +0200
Message-ID: <20260806212503.3119449-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
References: <20260805-falcon-dma-projections-v2-0-4cc9f3f13ee9@nvidia.com>
X-Patch-Reply: applied
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On Wed, 05 Aug 2026 14:01:44 +0900, Alexandre Courbot wrote:
> [PATCH v2 0/3] gpu: nova-core: falcon: use I/O projections for DMA transfers

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/3] gpu: nova-core: falcon: remove unnecessary check
      commit: d1dc8faf1152
[2/3] rust: dma: rename dma_handle to dma_address
      commit: 91645a52ebf2

      [ Rebase and fix up build failures due to newly introduced dma_handle()
        calls. - Danilo ]

[3/3] gpu: nova-core: falcon: use I/O projection to check transfer bounds
      commit: 4c9ba407018e

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
