Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A4BDCD3426
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 12:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C903310E30B;
	Sun,  3 May 2026 12:21:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b7pE1hx/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EAB10E30B
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 12:21:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 814964443C;
 Sun,  3 May 2026 12:21:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27177C2BCB4;
 Sun,  3 May 2026 12:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777810910;
 bh=1BXcDviF4zSUJSTg/STgwuPXEr4+vGruBJXtASu+ZX4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b7pE1hx//qw2Tk5rH2OpK6yCmpzNWEj45E8c8ONAmLj9ertHLo0ESTPLYwQvkANKW
 FDYb3f+s7kgBYy4u7FgImM00PcPfKkjLyKxYtKks9mSG/btSe8DaPvPi6n6EqSqkEA
 5VmTc7D34clAZB7LCB84hqYRWxpg1e6fQqBD5v3EDoDvtW1NJK+xrCTXt0ASuhZqH2
 Gpp9G7f/qLTLFUJm9tZ95j29m9aCsNjT2pepJqM8pk2ZYT40kcwaUjExAeyvdwgPLz
 9JWpB/x4Es4IdUil3OrXhooVyoUxqr2etLHMpKSrQebfMhQ7YpbDtRSGh6t8eX4L4F
 KA6edIctuXYPw==
From: Danilo Krummrich <dakr@kernel.org>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: drm: fix unsound initialization in
 drm::Device::new
Date: Sun,  3 May 2026 14:21:44 +0200
Message-ID: <20260503122144.1115392-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260501-fix-drm-1-v2-1-5c4f681837bc@nvidia.com>
References: <20260501-fix-drm-1-v2-1-5c4f681837bc@nvidia.com>
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

On Fri, 01 May 2026 19:49:37 +0900, Eliot Courtney wrote:
> [PATCH v2] rust: drm: fix unsound initialization in drm::Device::new

Applied, thanks!

  Branch: drm-rust-fixes
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: drm: fix unsound initialization in drm::Device::new
      commit: 0a69ac25bd59

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for Linus's tree and should land in the next -rc release.
