Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F615606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UqscSC7o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B18F9112D6C;
	Fri, 27 Nov 2026 20:11:57 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC97112D6C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:11:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8375261DE8;
 Fri, 27 Nov 2026 20:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDDD1F00899;
 Fri, 27 Nov 2026 20:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795810309;
 bh=xQkfae/SKeVDaBhKJZUuyKSaF2mzk809NAHAXx7sAak=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=UqscSC7oRfjgaDALeV44q7rOHH9jFsHctIWjLb1BN5foFIH/610yWIZT4EQ6WdKzm
 CHHwiKAeVNcA7A7otdwvnTthdgJXwTpB8YbUWzEoqCksc5Ru77+oBOq0/bveio09mk
 WXqqfYX/K2Wwy7w4Bxse6DlzXiKrUX7RXEETn0Q+cDeYAAm8GUD1bma0aesuTpFGIo
 jA2b2evqxl5e8xExYPx50NFRdGMnYEyVsXJoGPBIFDZATPb8HNqMbL4eJxYab9hxDQ
 f/xrrDJnBSaCUkioZsmWDGgNV+UJLYJzZMaXdGgMN3ZFo9fisCte0bGT1n0j+96t88
 2wyaPTpdrX+Bw==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 21:11:44 +0100
Message-Id: <DN69MGXVNYTK.3QKU099BIJXHQ@kernel.org>
Subject: Re: [PATCH 0/2] rust: dma_buf: add dma-fence signalling sections
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Philipp Stanner" <phasta@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linaro-mm-sig@lists.linaro.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
 <DN6838W1WF2T.2FLQ4AOZX5B40@garyguo.net>
In-Reply-To: <DN6838W1WF2T.2FLQ4AOZX5B40@garyguo.net>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri Nov 27, 2026 at 7:59 PM CET, Gary Guo wrote:
> Do you need it being a guard? You can do things like
>
>     let a =3D SignallingSection::begin();
>     let b =3D SignallingSection::begin();
>     drop(a);
>     drop(b);
>
> to break nesting. A closure-based approach wouldn't have this issue.

I also think that a closure-based design would be better.

Another nit, "signaling" is much more common in the kernel than "signalling=
".
