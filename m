Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E946606A325
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hk2zmtRB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB1A810E00D;
	Mon,  9 Nov 2026 21:33:57 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13EBA10E00D
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 21:33:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BCA91408BA;
 Mon,  9 Nov 2026 21:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7FC1F008A3;
 Mon,  9 Nov 2026 21:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794260030;
 bh=TspYkeq/ltNSvbUw9A2uME+mbBcIwO89KXv0aSgqfzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hk2zmtRBKNeqQ/yGAx/Di0O/ommbHKqI2xzUv008M55uhxL7R8/tUc3SdbhcTUnKs
 v4jImBuc8VfMyMasLCFoIBTrK0zPqUStSBpl0asCuiVcKAysgQfO68sNQn+e7maPN5
 b/8wYHD4zHsEag4ySC2Ww3QUYaOg6HXAQQP9U9awdYHOhCUuLfHcBqbbq/pW2kAW91
 yt+ETo2itEQfvBfN751ef2ZnWvpPYyYFNBsp5RJMIttT+htx9F0QYNtKgpkGlI1eQ7
 BWfcv3Gmzp7r0f0eCBK7MTR2bAxs/D7i4jKArs2X0fgblNkI6j4vVZZw6kdM6EvCq1
 lJzef1WeJFpug==
From: Danilo Krummrich <dakr@kernel.org>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>,
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH v11 0/5] rust: Add support for reserving of
 ranges of IDs
Date: Mon,  9 Nov 2026 22:33:40 +0100
Message-ID: <20261109213340.3944816-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
X-Patch-Reply: applied
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 17:32:48 +0900, Eliot Courtney wrote:
> [PATCH v11 0/5] rust: Add support for reserving of ranges of IDs

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[2/5] rust: gpu: buddy: use Alignment size constants
      commit: 1937c07c9f83
[3/5] gpu: nova-core: use Alignment size constants
      commit: a7cdb17ca0d7

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
