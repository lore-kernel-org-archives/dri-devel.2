Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A928606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nTyRvRbU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6847810E7EA;
	Wed, 18 Nov 2026 14:22:13 +0000 (UTC)
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B99C10E7EA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 14:22:06 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49febef74e3so14044735e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795011725; x=1795616525;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=2X2NffGsec/PeOgMoOFFc2QFkD6CeBxkedqmF186r8s=;
 b=nTyRvRbUM/dM7u9HD5pHwBWq+heF5D4gyUGrxzQAh9d3JN2wxHiNjSw8zqg7VepaKW
 XjvLKCfCJLZFQo3bC/o7yTuZU0E5YNgfanCGE56o4jCkWBs9vx4YUtf7l5A3lgIiDLKJ
 zOtnp9TBSbEsqQU8BLgk+uUrVbj1+Gg91l33M5wRij9zwTsSmSrKLbaa0nhs0+5nFtWM
 d/lNx4q8RA4v9nKXeDRKcv4cyVr5dFxRUsWxICQ+rnVC88jzy+bwm5Bsm/6O/urmYc0A
 kwtuwOmCT1R48i8YnP+tiy3RbpfT2Ua1fBJTP8NMcH4rRuLcRQKZnZllyiT5iGtODawm
 ih/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795011725; x=1795616525;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2X2NffGsec/PeOgMoOFFc2QFkD6CeBxkedqmF186r8s=;
 b=dquHDT68X5MyCjn6WjqDS6DoNJswN27D12XWOHkyNNUvIuCN9Mrr/Ii3jyJW6uaVmF
 ecXciZzfA+x+KJxZiALze9a9lVZq4kYfQGOrwD0ZdXsUutHNypD1H65VC9cJqEkSW6Ai
 8x90HOaUVHSMNq9YXTXtB+7m9EsiMcpjTmiMHny+qLEMDUtzu3mgw7LtSal9f2Baa3sG
 kmUo05RmRRgljrB60WTYXZR1GwLSBiTMdqfmOisMnM0LFi1FYWI6nzPMNZztvKUTQcHE
 41czbX0fBAyEPuFUDwf2QQLkI/3vdhJv7wE/HDYPtPxJKGJZZ0z15dbZ0OJQVue+XE+e
 7noQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGrgG3jclKvlDd9Q/86SLZ3NipH0l2FCZ2YeTirYNDDmtF5OHNtWU23HosLwEYWnbE9l8Rql4hd4H8=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8NBigayZaxdLzSDkS3DBmtfpJQEMyoNmN7DR4FgeT/j4FI8Z2B
 nbOtKsqeymfMJAcvaa6vKBxd6QW4rd5LKcdpdmeMcyRcrBY/Ya70+V9Z3upRruCZUzqQwaf7cRC
 rUJZI28uXx8BHREl6kw==
X-Received: from wmfu2.prod.google.com ([2002:a05:600c:1382:b0:4bb:6a03:8800])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:37c3:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4bb7d6cd4ffmr49219565e9.2.1795011724035; 
 Wed, 18 Nov 2026 06:22:04 -0800 (PST)
Date: Wed, 18 Nov 2026 14:22:03 +0000
In-Reply-To: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118142203.711097-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: gem: shmem: do not leak pages when sg_table()
 fails
From: Alice Ryhl <aliceryhl@google.com>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, 
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
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

On Mon, Oct 19, 2026 at 08:21:52PM +0000, Sami Tolvanen wrote:
> `SGTableMap::new()` takes a pages reference and maps the table before
> `Devres::new()` allocates. If the allocation fails, dropping the map
> frees the table but keeps the reference, and the next `sg_table()`
> takes another one. `drm_gem_shmem_release()` puts only one, so the
> pages leak.
> 
> Take the pages in the initializer, after the allocation.
> 
> Fixes: 616c229ab010 ("rust: drm: gem: Introduce shmem::Object::sg_table()")
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Applied to drm-rust-next. Thanks!
