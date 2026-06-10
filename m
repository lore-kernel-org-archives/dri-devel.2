Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAE1CD98C7
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 19:09:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E7E910EBB7;
	Wed, 10 Jun 2026 19:09:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hZGtlUi8";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2ECAB10EBB7
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 19:09:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DCB9241B0A;
 Wed, 10 Jun 2026 19:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC371F00893;
 Wed, 10 Jun 2026 19:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781118545;
 bh=HtAPuYXNsOgrgpLVDAT45ANshg0FE4v6rtaR6L86Euc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hZGtlUi8+XcjYz9AFTiNgjdqO7trcW3sEoWDhpUw36dWDpZWL6yBgGgnvv0Z+Im8l
 0iYizRRqTK1hULNGPaICOyAl8NycCcsFh6gjGVT/L0dxMMlSc5fmzcblfR8vMXCNl9
 6SOt1fUFYSS7YHMf4QGpvOJEZ0jtdyFbjkFwHOY2acVi3qp4oKqHEaw0woRp7ICRk4
 HhEV18m4K/CQmPUg094cdnaBCa8wg8F5S0Y4HY0IW11tca8a4mSymU2ObR8gnpL+I5
 wYl90U3TExWnMdiOlPp0C6pxQXrWTJ/TC3OB0p58niO3TTWTYVWfPSEDia+VfEtn8Z
 0kG/N3C55IIEw==
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpu: nova-core: remove imports available from prelude
Date: Wed, 10 Jun 2026 21:08:57 +0200
Message-ID: <20260610190857.65190-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610135716.1013688-1-gary@kernel.org>
References: <20260610135716.1013688-1-gary@kernel.org>
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

On Wed, 10 Jun 2026 14:57:14 +0100, Gary Guo wrote:
> [PATCH 1/2] gpu: nova-core: remove imports available from prelude

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/2] gpu: nova-core: remove imports available from prelude
      commit: e453072df254
[2/2] gpu: nova-core: use `c"literal"` instead of `c_str!()`
      commit: 550dc7536644

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
