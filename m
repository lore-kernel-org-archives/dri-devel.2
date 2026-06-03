Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E7ACD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 22:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CD3611244E;
	Wed,  3 Jun 2026 22:52:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NOJpCWW5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0433611244E
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 22:52:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C471440E51;
 Wed,  3 Jun 2026 22:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6169C1F00893;
 Wed,  3 Jun 2026 22:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780527174;
 bh=lr2rNHkX39BthmBN26RYq5EGbd9Vpj+dbof9vb9JbBM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NOJpCWW5S+zR1CjgarInVOSGbK1POCG8KfuAmZVYNWnZdTknulf39I5hVMeBffJI9
 4F824DNc5BetasTq1PRRP6nGgxBhzmWiq9rxLCzKtlis+Yc2L5epsNyh2jgw2s1hn1
 NcYSbO1nqBDfX1NpOimzsuR/1BlMxM/lxhS7kW1c4hWlsgwixMYUiIVjv/12oZMRiv
 vVkiXKmHsfkad+bDDbKOkLP9KgDkZSBakWJyn1tG73/5cvX+STRX/eifsPIp6fof4E
 EyFrCQCxwKF9MzYce7a/Z65oIckBVZfutQYW4di8ewUjgzraqglJSQFmINMHyWd8rg
 xZUbIf6Kl/+4Q==
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
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpu: nova-core: move lifetime to `Bar0`
Date: Thu,  4 Jun 2026 00:52:48 +0200
Message-ID: <20260603225248.2604794-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602170416.2268531-1-gary@kernel.org>
References: <20260602170416.2268531-1-gary@kernel.org>
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

On Tue,  2 Jun 2026 18:04:07 +0100, Gary Guo wrote:
> [PATCH] gpu: nova-core: move lifetime to `Bar0`

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] gpu: nova-core: move lifetime to `Bar0`
      commit: 99676aed1fec

      [ Rebase onto latest drm-rust-next (Blackwell enablement). - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
