Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6792D606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6tpNY9S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78D310F842;
	Tue,  3 Nov 2026 20:50:44 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9BBE10F842
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 20:50:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 06D56609F5;
 Tue,  3 Nov 2026 20:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5971F00A18;
 Tue,  3 Nov 2026 20:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793739037;
 bh=QACbzjj4ObeQbuqI2hJvuEcx06fQf+krQtbSCsJZb0k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b6tpNY9SjUxExsTeEVkXslwJk+qSf6s3N9FRFYTRE2xZuEn3QCQLRfsDdU9kutrv6
 yb+fOmwAyHderbawOjBDVsCxafa40RDj35JilqYKK4YdBk2llO2de3WrU48uEO111q
 vCN7a9McqtEg0aDrZpjVb656TXxKjtySsHyIp3uO82OY+oJu4JTijQClbweGllfKVl
 FJPP9Kf9ilbi6RCOWvwVNEl3vDSD/kfQVDk/LS3jeag58ftovEc5ARA1tSeZIAMGI9
 1rs1yRkBnpr+ys7gOvtL0TlpDuHg4++ZUBJQPEM84m9A9S/uv0cpj1ZFosA72qozs2
 legeE0ukalxAw==
From: Danilo Krummrich <dakr@kernel.org>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 "Liam R . Howlett" <liam@infradead.org>,
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: Re: (subset) [PATCH v5 0/7] gpu: nova-core: add NVKV codec
Date: Tue,  3 Nov 2026 21:50:29 +0100
Message-ID: <20261103205029.4026128-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
References: <20261028-b4-nvkv-v5-0-ef78909b513e@nvidia.com>
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

On Wed, 28 Oct 2026 11:20:59 +0900, Eliot Courtney wrote:
> [PATCH v5 0/7] gpu: nova-core: add NVKV codec

Applied, thanks!

  Branch: drm-rust-next
  Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git

[3/7] gpu: nova-core: add NVKV encoder
      commit: 440b82a79574
[4/7] gpu: nova-core: add NVKV decoder
      commit: 9898bacda71c
[5/7] gpu: nova-core: add NVKV typed encoding
      commit: 75e32e6e3573
[6/7] gpu: nova-core: add NVKV typed decoding
      commit: 434b46a415fc
[7/7] gpu: nova-core: add NVKV GSP_INIT schemas
      commit: 41871f4ddf71

      [ Fix minor merge conflict. - Danilo ]

The patches will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patches are queued up for the upcoming merge window for the next major
kernel release.
