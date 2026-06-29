Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83036C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6AD310E049;
	Mon, 29 Jun 2026 10:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IApwJdU2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 723BD10E049
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:11:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 98F9460008;
 Mon, 29 Jun 2026 10:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8F61F000E9;
 Mon, 29 Jun 2026 10:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782727873;
 bh=718T54Qng3Y2sDbIyf9X3jGtl0LaVvw6Tvzl0ce34lM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IApwJdU2ZqWbajkTtMUzZ8hkIf1kIkY7rKk4nIGl0N4M7Q4h6kMSQeu1mxubo6xBo
 p/cTwNO/brR3cY9fbWfDHc+UtI+7TwhcbWs9dt6NMezFP0mW7xKcRv3hxEMQHZa9z4
 JxP6jTi/F4VqZEzqNWZHIXk8sM1x/6klaIX8SWi0HynOg+POCH9YkDR8gUDGdRDTw5
 NrfvLOtng09tH/oRFtUZ6qVzGBqbnR8zHTswRMC6beDaAQC90Kf7i5lTDGRFLogITD
 i8g9TB1hE6wM4emGS8/s1XOj8nxYUUDoUHnangvfzgeg6eaC9IBBjWYeiS8mWe+ygY
 K/7gt5xug2HNw==
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH v5 0/5] gpu: drm: nova: enable calling into
 nova-core
Date: Mon, 29 Jun 2026 12:11:04 +0200
Message-ID: <20260629101104.2971305-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622-nova-exports-v5-0-6191773fc977@nvidia.com>
References: <20260622-nova-exports-v5-0-6191773fc977@nvidia.com>
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

On Mon, 22 Jun 2026 22:30:06 +0900, Alexandre Courbot wrote:
> [PATCH v5 0/5] gpu: drm: nova: enable calling into nova-core

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/5] gpu: build nova-core and nova-drm from drivers/gpu/Makefile
      commit: ca524e273c43
[2/5] gpu: nova-core: export Rust symbols for nova-drm
      commit: 3b7b7ad78fd2
[3/5] gpu: nova-core: emit Rust metadata for nova-drm
      commit: 0dc79ddc9f6f
[4/5] gpu: drm: nova: depend on nova-core and use its symbols
      commit: f1bd7119ac4c

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
