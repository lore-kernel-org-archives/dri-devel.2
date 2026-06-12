Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201F1CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 20:55:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 702E110EB77;
	Fri, 12 Jun 2026 20:55:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GwfR6cu3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A7CC10EB77
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 20:55:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C25B460008;
 Fri, 12 Jun 2026 20:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0431F000E9;
 Fri, 12 Jun 2026 20:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781297735;
 bh=yqWg3ylmi4Zxh9izaVfot+h+usLj7PAF0qm0lQ4XtrU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GwfR6cu3URoizczM2Bg5gXkGyOdGNrhS8X7QZf3X062rm5zzxctJCXviv6yfsA0Iv
 QwTFY8Qr0KQzvQOZZWeyHyQnda4CQJiwqYLTmTPeHYlXQYs0Pc1nWq/XRxqvabdpUK
 B9lygZZuCcjBAwuOMS+dcdNzwr7anm7rrZc+0G229Z2hA7FhCONJIAwYxT95aiJFtQ
 e/N02HiHvMNtZxkEqGrOvOGDpYn0HDPxwIwO5TDl+Bl5mPHMEVYQbWqRnh0HWYLrqM
 zqW5R1DJVRvhjPaKPCB2HxP8GNGRPbUaoaR1oXxvsJ8CiLq0fLnMWmH7Yp690Aux5P
 aSMFpY6nm1byw==
From: Danilo Krummrich <dakr@kernel.org>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 laura.nao@collabora.com, samitolvanen@google.com,
 boris.brezillon@collabora.com
Subject: Re: [PATCH] rust: drm: gpuvm: add SmContext lifetime bound
Date: Fri, 12 Jun 2026 22:55:25 +0200
Message-ID: <20260612205524.836204-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610-gpuvm_smcontext_lifetime_bound_v1-v1-1-531e7d2ee7b4@collabora.com>
References: <20260610-gpuvm_smcontext_lifetime_bound_v1-v1-1-531e7d2ee7b4@collabora.com>
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

On Wed, 10 Jun 2026 17:04:31 -0700, Deborah Brouwer wrote:=0D
> [PATCH] rust: drm: gpuvm: add SmContext lifetime bound=0D
=0D
Applied, thanks!=0D
=0D
  Branch: drm-rust-next=0D
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git=0D
=0D
[1/1] rust: drm: gpuvm: add SmContext lifetime bound=0D
      commit: 5f7410aa2652=0D
