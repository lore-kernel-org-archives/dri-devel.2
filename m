Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFC9C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 21:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F7F210E411;
	Wed,  1 Jul 2026 21:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R05xdlt9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13D2610E411
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 21:08:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AEDB84121C;
 Wed,  1 Jul 2026 21:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA721F000E9;
 Wed,  1 Jul 2026 21:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782940083;
 bh=n7TjrDqsTEXkjC3PhmRlxBihqIlnrgHLtJxV5VcmAZc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=R05xdlt97pe/ijbd4CsvgRrK3H0zhwdCFNuSbe6tD5xKdsTmrD9W4UCWmZVq/7G9j
 inXtguiQCUbXXibB4KnH2J5ljgNUpz/Tu3LEUb74Dl8pu7Ym/bbiGSdHXrsYgU6L7x
 dWnOAGypLXu3rwDjK9dIvj3+wnOOCDXb1jUUugyEBANR7nQ8nwcq2U7MBV6OR4dnax
 +A6EbAbdURYNYmNwgEHXawdT3JnfgFCxjszQJum1+FGFDsumdwFeb7//fPO2hgSYWU
 ishEv9Y/n/IV0oeEZ7W4bB5BNxIGYGUBIbvKocmzEQ+r65BA7XMez+qq9nswkMK+rr
 nlfRkqfeMc9pg==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] gpu: nova-core: remove `#[allow(non_snake_case)]`
Date: Wed,  1 Jul 2026 23:07:57 +0200
Message-ID: <20260701210757.334789-1-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260612123401.2684025-1-gary@kernel.org>
References: <20260612123401.2684025-1-gary@kernel.org>
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

On Fri, 12 Jun 2026 13:34:00 +0100, Gary Guo wrote:
> [PATCH] gpu: nova-core: remove `#[allow(non_snake_case)]`

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova-core: remove `#[allow(non_snake_case)]`
      commit: 24d2581fd911

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
