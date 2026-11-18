Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5492E606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=TeWuc8AU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A377C10FB38;
	Wed, 18 Nov 2026 11:41:34 +0000 (UTC)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7771110FB38
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:41:26 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48e0fc747a7so562070f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 03:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795002085; x=1795606885;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HNjwtMA1cqvQF95bOt7vOmJ6SObUlbZ189r7Lg8dxx0=;
 b=TeWuc8AUiZw+0rDMOapb1Mdj5Bkv4oKFhbqNu4Hy8q7++xs7bdPz5odAc7RZG8gR6o
 T5rD724PXkSporfZ90N5JLSLdG9jvN7tMM/LgtLAgiXV4oTQw5CbHEDV1dWqbvwHk9Wy
 0IsxMhwBp7STzdAKQv6Of6nxOtFvxAJO5R3huwM9mdQaEYIgXuuSJHWdjfTYFSctmsg2
 24b0OaHwoLlgYBu6mUhbBlKraJHmzZLTTPLO0Nm8hJ8wPPE5NZfXQxREs6wM5+UZVkAp
 SADMu96Ogi3+D3SCW5TqtnceC9cfwXB20VTucb9coJbUKPIE9lRW832l/S8gJLy45aFA
 rZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795002085; x=1795606885;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HNjwtMA1cqvQF95bOt7vOmJ6SObUlbZ189r7Lg8dxx0=;
 b=PIqjmZJ0xZmHDrNgWWk6FfbiHWjD3P9ipsL1BxpUgyN+7UaIoEU8aaSu54zB9sgDC2
 veKdkOU396Rw7q5/pTCRbyx3/IH4BzF8jFjuyx4L/mfdrgous5kUpaRG/IxwwFl7vdAt
 zhs2LL6cf3Ew9Xc/T8cjf/pyJUFdGnNAxxWj0y8Lo8HSywCMbW11+YzRu73nRlWtRaKm
 lZVsDJjZhgPgVhByQOqGqitsLGZlP8nr+1E0a/dzdLVEAz5aJ76XPEpFUogtEncwvEFn
 OtYZDUr5q+SK+D0Q9KqXeq5LR78wl0oCFphULPTn1d/+YHzEpSw9zgxKK6O2/DP4g7rJ
 vAAQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGjoMe9f2EFKYggz0QGidxhXlQg1fI0/Kkjwb9v5G7aUTIsucBWhncftGkGy6+oWeoixQ0EjVnxSDo=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9BOPcev0fr1RxSLph/e79zocb8Qfs3lpWb7FWaEyTihf3sOjN0
 kqA7IAmb9W/OjS2PA04ovE2cvLvKkpIS6+wdORvxAfRHRQ6fIhVESUzINHGSSkxlYDT0kb/yiic
 M708EsmtUNZhJIeuK3Q==
X-Received: from wmpz13.prod.google.com ([2002:a05:600c:a0d:b0:4b2:3c81:ca])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b84:b0:4bb:5dbf:af06 with SMTP id
 5b1f17b1804b1-4bb7da2243fmr49551165e9.9.1795002084674; 
 Wed, 18 Nov 2026 03:41:24 -0800 (PST)
Date: Wed, 18 Nov 2026 11:41:23 +0000
In-Reply-To: <20261026-rust-drm-gem-shmem-imported-sgt-v1-3-36f15ace04b1@jannau.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
 <20261026-rust-drm-gem-shmem-imported-sgt-v1-3-36f15ace04b1@jannau.net>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118114123.490870-1-aliceryhl@google.com>
Subject: Re: [PATCH 3/3] rust: drm: gem: shmem: Do not free SG table of
 imported objects
From: Alice Ryhl <aliceryhl@google.com>
To: Janne Grunau <j@jannau.net>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sami Tolvanen <samitolvanen@google.com>, Lyude Paul <lyude@redhat.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 12:14:10PM +0100, Janne Grunau wrote:
> GEM shmem objects imported through gem_prime_import_sg_table wrapping
> drm_gem_shmem_prime_import_sg_table() do not own their SG table.
> SGTableMap::drop() must not free it since it will be freed on exporter
> side once the DMAbuf is not used anymore.
> 
> Fixes: 616c229ab010 ("rust: drm: gem: Introduce shmem::Object::sg_table()")
> Cc: <stable+noautosel@kernel.org> # no in-tree users
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
