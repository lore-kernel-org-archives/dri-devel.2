Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3139FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A33310EA45;
	Mon, 13 Jul 2026 16:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WyKAnUJw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D694910EA45
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 16:33:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 676E7405B1;
 Mon, 13 Jul 2026 16:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 538941F00A3A;
 Mon, 13 Jul 2026 16:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783960433;
 bh=pTuteeMtWZKH6Y5iqChJ75qGlkMn9FpzzYmPrZJQ6uE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WyKAnUJw5TZvDqjJVvIuLkssi6RuPK8GuIE9UgKX2GBjuha5LXz48xmN/opw6AeTK
 KckaoUaWi/Hu4TcPz8+mJbLkBkBeS5EV1njH3QQzEwKx3Y0FzedP4ebVZ5tymDlqcK
 TNqIlMQFZy4x0Wc3RkSIhHsTYWcO8hfN3qRdDSf3r7t+0J6EsJpv8rkW7HRtLrQYlp
 AoG60WV/Zyw2KdPazkMsojIrzD6M1z852odBx3OY9KLVCe2CPRAXwH3OSPlqNY+OrM
 B5rK1J2vN91pC/OCRGxEfRslE6b/iB5hxOsUlf0osU5beoIj1IGj/5SP9uviP0J3Iv
 y/rWPQ56rRXtQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Younes Akhouayri <git@younes.io>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: drm: Fix typo in FEAT_RENDER documentation
Date: Mon, 13 Jul 2026 18:33:47 +0200
Message-ID: <20260713163347.1525217-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712-docs-drm-feat-render-rustdoc-typo-v1-1-c9df1cbbce4b@younes.io>
References: <20260712-docs-drm-feat-render-rustdoc-typo-v1-1-c9df1cbbce4b@younes.io>
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

On Sun, 12 Jul 2026 15:39:46 +0200, Younes Akhouayri wrote:
> [PATCH] rust: drm: Fix typo in FEAT_RENDER documentation

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: drm: Fix typo in FEAT_RENDER documentation
      commit: 6cb3fdc9f5ae

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
