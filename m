Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B17606A321
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 21:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TFrREZdy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09D9110E365;
	Mon,  9 Nov 2026 21:21:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACA6510E365
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 21:21:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A81266020F;
 Mon,  9 Nov 2026 21:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D781F008A1;
 Mon,  9 Nov 2026 21:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794259295;
 bh=WyHVIDHJ/2Uw2pBXQmf2I1fjIXFBYI3F63G5dUMgJqU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TFrREZdyiw8ZcekW651SSuOQIbYIMj+/ysqqU4+XNdpaVGWHxCP7p3wcDCxsCgmJr
 5Gfji6xGBYcTEQ2iKKcRLCpEfUjHg2dLeenL7f6NdYStMKgahaKmuqXEw+wSthHNmd
 C3e2bqr+d9kZZDUai01yjMsB0T1aFCQBJ0SOFELXNMXns63L2VFarlePNTXqV0YhIZ
 s9KY4+vfjqE3bWUEHYUiUrchvMilKFrmWejUS/vnshqu20xCrXr7hjiJnII9amqFgL
 4gf4yg2IPdS4iD7l8EZ3Dep5i672wvJi/5qQAFkbQ6Slh1R3UJUbuypi93BNhziUiY
 mzOlYZZud02Nw==
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
Date: Mon,  9 Nov 2026 22:21:28 +0100
Message-ID: <20261109212128.3911661-1-dakr@kernel.org>
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 09 Nov 2026 17:32:48 +0900, Eliot Courtney wrote:
> [PATCH v11 0/5] rust: Add support for reserving of ranges of IDs

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/5] rust: io: use Alignment size constants
      commit: 4d1f2b176df7

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.
