Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD173606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 05:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=T0DDcq0n
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3134610E09E;
	Wed, 21 Oct 2026 05:54:50 +0000 (UTC)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E7AC10E09E
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 05:54:44 +0000 (UTC)
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c210c66672eso26568666b.2
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 22:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792562082; x=1793166882;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oPtFhbSnZ7731aXLuIJiHjV7KNwM+FeYkV7XoCnepXM=;
 b=T0DDcq0n9F2k48Zv7vZu/0d7GtxI8w7uvZN3CErPj+qhSolL6fKV3MMJPnM9ZRHsv8
 mJUnpF7ftc3jZvVFVGK6mC3VH/xEn1miNGlNlIbkfOLNqaqEGOCs3CQHsRdxN51DLchB
 n+Cl6j6fqXVqmpv5BO1qhPp2Yoecalzo5CmUgwSrFQTF2gg5OKTib4tG+YfXCbbOX5R/
 z2Xnxm9Bh5IFK93JTtxHCtslYfGyMEc/busP+8Q0yWjzXksu8toiWvSTqS+Y1VZhULmT
 aRvBY5LDFs8rwy0ExhZa616QNRYOb7R7ZQNto7PXc0JilK4c8EqRx879hDS1nF6csL+A
 csUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792562082; x=1793166882;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oPtFhbSnZ7731aXLuIJiHjV7KNwM+FeYkV7XoCnepXM=;
 b=aRrDWd/jc4Cq+8LVxWTpi3o3NBWji/GzG1NZXUmIamwFcsRi3V6Z00LcXGh/aMsaVI
 sypw9vwZtc4Ylu2i44/Va2TLTErNvjV+dikZK3Q4WZwEM5Hf3Sa2ZbSCIVdNSSmG4BQ+
 dYC9cifYtn83rfhhAW/5HWvsQftz04d61X0GoVHwWJPIkRoJM48xRgU1FC0O1ZPQ89RW
 Lq3YAAJcKPGNX5HjbfYAy4spekOTEtI0n6KGA1qfkaTemNAWG/HT5EBjzRfeLYIUfKi+
 uqp/N7ERQx8VIu5UcZ8o8iDzNxhYuAtsTWcVATI+oHP+AVeca/DSh2nxLDlZzHBBX6nV
 W1ew==
X-Forwarded-Encrypted: i=1;
 AKwUvByKZ9CBICH8elEqdHXOISUlR9/GcLINDLG9YYUHKau8tTz0YFneN9SSd5xl8Dw7WzqQIwLp5puesgQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLf0jMBcwFaNkBItI3+EBnymMeVdqTq93Xq62IeVuNNv4LfdWtH
 STm6sPEuJ0Qinub2p7Y94tZCbLKYsbPi6CXkRxtsczAE0aR3Me372CHQ1svWONk3vE6hfP83omB
 7ZslqOPx1IzB2kb4FgQ==
X-Received: from ejec2.prod.google.com ([2002:a17:906:1702:b0:c3b:9071:bf1e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c499:b0:c41:f29:72b1 with SMTP id
 a640c23a62f3a-c4679b52fb4mr81117566b.47.1792562082098; 
 Tue, 20 Oct 2026 22:54:42 -0700 (PDT)
Date: Wed, 21 Oct 2026 05:54:40 +0000
In-Reply-To: <20261020-b4-gpu_info_intobytes-v5-1-3e0c7c93223c@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
 <20261020-b4-gpu_info_intobytes-v5-1-3e0c7c93223c@collabora.com>
Message-ID: <athToIRyTjSB_jVg@google.com>
Subject: Re: [PATCH v5 1/2] rust: add zerocopy to bindings and uapi
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 Jesung Yang <y.j3ms.n@gmail.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 04:47:48PM -0700, Deborah Brouwer wrote:
> Make the zerocopy and zerocopy_derive crates available to use when
> building the bindings and uapi crates and their tests. Also make the
> zerocopy and zerocopy_derive crates available to rust-analyzer when it
> runs on the bindings and uapi crates.
> 
> This will be used by the Tyr driver that needs the traits IntoBytes and
> Immutable to safely copy the struct byte-for-byte to userspace.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Miguel, is this something we can take through drm-rust-next? Or perhaps
you want to take both through rust-next? Let me know what you prefer.

Alice
