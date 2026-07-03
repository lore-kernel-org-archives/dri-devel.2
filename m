Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63404C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 21:29:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9380710F956;
	Fri,  3 Jul 2026 21:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YaBF/qet";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0210910F955
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 21:29:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 35F7F600E7;
 Fri,  3 Jul 2026 21:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29CE1F000E9;
 Fri,  3 Jul 2026 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783114165;
 bh=eeGmPiCUrx3tRv7prGmGNvbbmUHuuabvRiwfxaKx/PI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YaBF/qet379T/gqDqz+jcfD91Vru683MyiAxtDa1on3YG8KHN6I0bMDCL11mLLOiq
 fy1+rYToW/CrHThvSkkdlu5Fu92fKvhBlkjrHKz2m7Ab03Cd0N6E9OLrYGpVln3Vss
 TGJ68ZYfvyWTwWz+LpOP9pDkVZgzqz86q7zlrYqpoME4wKUhWq8EnjeVfAt6hiuCLB
 b+gy2KiaFIitzXUKomEs2WC2oHb3HAWr1374ypGZJp+qfLemUp+v75mQlkR4FOG2L4
 B29UM8IHpyrohp9VBhJ+D5LhgL4H278tjVNLTy0xMO0HEnlOQNNZpAtftoag2/ZlrB
 Jd5KWc+Udgcmg==
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] gpu: nova: fix rust-analyzer generation
Date: Fri,  3 Jul 2026 23:29:18 +0200
Message-ID: <20260703212918.1200823-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260701-nova-rust-analyzer-v1-1-5209f486f10d@nvidia.com>
References: <20260701-nova-rust-analyzer-v1-1-5209f486f10d@nvidia.com>
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

On Wed, 01 Jul 2026 15:40:51 +0900, Alexandre Courbot wrote:
> [PATCH] gpu: nova: fix rust-analyzer generation

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova: fix rust-analyzer generation
      commit: 78900738d981

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
