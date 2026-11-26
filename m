Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977E3606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iRKYnB40
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 068A910E438;
	Thu, 26 Nov 2026 22:19:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A95EE10E438
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 22:19:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 652AE4243F;
 Thu, 26 Nov 2026 22:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA4E1F00897;
 Thu, 26 Nov 2026 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795731577;
 bh=msVtQwJ8MB3TQUWXvhQpkRrmVLPQaGbQMTulmR3wqwE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iRKYnB40rjL1zPUbITPs7GbPCTDfcHy4p+clJnYT+C4QGsXDU+8PG1D4vF8ZUWQ6c
 J6NqvLgYbM8gEZnm/Sm8ABO3WTb5SQNL4ljy1kEnOM5zjiLfRlX/wzqI919zSbZNkH
 Fzm2Xpez91t8wxKY7jNMW3YdfE0owRH+zuMKU4iELYDZnOOF2P0HLlyzpgJ1lTFdUU
 Xl9fZ9BU7pzQ5a3sRHnQq65JO11hYWyKvm7vtBYRJqeFjnhY9E2uRTdAcPl6okru9b
 L8Gye6g+7dc7Qmwnqed5krMzkm0fnjsO9DvdM3LY6+xknKE5T8wGg8StWXHKM74dbp
 L0CFZL/u1DXlA==
From: Danilo Krummrich <dakr@kernel.org>
To: Peder Bergan <peder.bergan@gmail.com>
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
 Asahi Lina <lina+kernel@asahilina.net>, Lyude Paul <lyude@redhat.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Janne Grunau <j@jannau.net>
Subject: Re: [PATCH v2] rust: drm: enable standard fdinfo for Rust drivers
Date: Thu, 26 Nov 2026 23:19:30 +0100
Message-ID: <20261126221930.3790327-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126-fix-drm-rust-fdinfo-v2-1-b1653edf1e4f@gmail.com>
References: <20261126-fix-drm-rust-fdinfo-v2-1-b1653edf1e4f@gmail.com>
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

On Thu, 26 Nov 2026 18:39:33 +0100, Peder Bergan wrote:
> [PATCH v2] rust: drm: enable standard fdinfo for Rust drivers

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[1/1] rust: drm: enable standard fdinfo for Rust drivers
      commit: 02efea879e87

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is queued up for the upcoming merge window for the next major kernel
release.
