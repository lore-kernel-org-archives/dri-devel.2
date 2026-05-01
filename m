Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D1DCD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 14:46:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 871A110E1E1;
	Fri,  1 May 2026 14:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kL0E5rIQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEC010E1E1
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 14:46:01 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 81E8543A2D;
 Fri,  1 May 2026 14:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D7B7C2BCB4;
 Fri,  1 May 2026 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777646761;
 bh=lMo6vIJzORAxdZpMWmFhIapMK4zC43Mfyu/lKG6p3kY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kL0E5rIQ4c6TO86H9i/B4XTuqcLsoMsdGJLDxfYgbzii6T1waUjGj21vwKKd8y8sA
 ZnG2+m8oRn/Ql+rHE0x2eSbNboerASNN2XAggoHDEapGaZvSG5oxLRi0uu4kV6hvFq
 8KKWCp8E8hNzGEZtJ4pSlxNIAKfNpfHGDhIzbOpyqzMkLrwfX2+PYQgGp0oixuf0Cf
 swNspcndZvZshlE26bP0TrXEPgZhHmXZ235dcO+jJjxBU2jMGxxBxFpJYg6yx7wSJL
 WshkGgNWlxx2dIhPhDqkJrcDiLd5OJfNb6ho6yNqTt8hOZXCb3npRhsd7UEy2CP7nY
 nswo59aV02d/g==
From: Danilo Krummrich <dakr@kernel.org>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: drm: gem: clean up GEM state in init failure case
Date: Fri,  1 May 2026 16:45:30 +0200
Message-ID: <20260501144530.4193621-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260423-fix-gem-1-v1-1-e12e35f7bba9@nvidia.com>
References: <20260423-fix-gem-1-v1-1-e12e35f7bba9@nvidia.com>
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

On Thu, 23 Apr 2026 21:36:52 +0900, Eliot Courtney wrote:
> [PATCH] rust: drm: gem: clean up GEM state in init failure case

Applied, thanks!

  Branch: drm-rust-fixes
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: drm: gem: clean up GEM state in init failure case
      commit: 2e42a17b8f6b

      [ Move safety comment closer to unsafe block to avoid a clippy warning.
        - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
