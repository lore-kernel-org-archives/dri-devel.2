Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63343606A326
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=aZxIFDjZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 959D510E1C7;
	Wed, 25 Nov 2026 15:03:22 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC9DD10E1C7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:03:15 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4a370217dcfso5463175f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795618994; x=1796223794;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8aj9nTYzj6cuyNzNLusXOllcp3z+nABWrRwzBA+BFgQ=;
 b=aZxIFDjZyNGdfSekKOXPp/LFxPYDaGxiBtHMH9Dg3y/5YeaW+sK1NXTnaAZcKykKGo
 U7YsMNHqlmULBqDqk1hKzs3RM7hbywArRzy5B3JDG/YIqlu6lY3OcOrv8ikHR70tOp+y
 7VkHA+EcVdlXx4R5oKUI5L9+kOWNMQf+BTce+PPCQVIN3g1IZHbnZXSQ250iq+UhNd7x
 qTGK1vFhkVN+dyLN3A1wOmG/NDIdauYY2jcE6lel9oBv6NsQjpcnVIEYq6MkKMfW3VsA
 I8ZP20XXnubBH9upym2EIaxDuPUvp/ZPtRypZIztOVQfRgSosQ5NbeGNBId5N7EzBhi3
 kvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795618994; x=1796223794;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8aj9nTYzj6cuyNzNLusXOllcp3z+nABWrRwzBA+BFgQ=;
 b=OjPe3sUD0z1BBJ3DBxiRUaU2OuW8w6Tz9iqUXqd7VtDoujqnMpugfcs/Kg/qC2kmOu
 Sd23CqCN0fLAZr9E3+wlJsCx10n3JFqnHrpaxbN2ILJ49I5mtWc4dm/jYsy07w3JIyy4
 U3n/Tv457ZNHeVnXncoAFWL8ODMM+e5iUhYK6J2nSVzbLJXkXrMseWeTw7r5YuPXsQg9
 1HYYyLn2SDlULBj6DrSnqLV/6B2432Yhu1Sz1bB7i6SP8RIQThZr+zasfQlIA+tjVEYL
 HBvxscNdY1r+aURso5E6E21rzKXpULiGZwXpRZ1osOQH5oEQP36ZclOa8qMi5KQ/wLHX
 zZRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFu0oYPNTG3A0zWlstaKWMoQ06isYOt4NBtaRPqj4XgZz9OXfNx13eIJyM85WcxOKSXYLBu4Y6fPxM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8ZcGUzqo01balTGXvyBIlf4utpnhf0/WxZssK39eXoH9qgvRf3
 usrjHx+Y59H890Gf1aGxMwqGeUL8Orndo393rXoOo5sX83ALdCpBF5sr6+g7ukrgxYK7YwpJatw
 vItJizE1RJVLTvQ11MA==
X-Received: from wrzt4.prod.google.com ([2002:adf:e104:0:b0:4ac:99cf:5a0e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:29d3:b0:4a2:6542:989a with SMTP id
 ffacd0b85a97d-4abb4b85a5cmr21029290f8f.52.1795618993824; 
 Wed, 25 Nov 2026 07:03:13 -0800 (PST)
Date: Wed, 25 Nov 2026 15:03:12 +0000
In-Reply-To: <20261124-rust-drm-gem-shmem-imported-sgt-v2-1-000f7a9ccb8d@jannau.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
 <20261124-rust-drm-gem-shmem-imported-sgt-v2-1-000f7a9ccb8d@jannau.net>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125150312.1587642-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 1/5] rust: drm: gem: shmem: Do not use
 drm_gem_shmem_dumb_create()
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
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, stable@vger.kernel.org
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

On Tue, Nov 24, 2026 at 12:37:43PM +0100, Janne Grunau wrote:
> The existing gem::shmem using Rust GPU drivers (Ashi and Tyr) are render
> only devices which should not set the dumb_create callback. When a
> driver with KMS functionality is added it probably will not be able to use
> drm_gem_shmem_dumb_create().
> The Rust gem::shmem::Object<T> wrapper should be allocated and destroyed
> from Rust code. DRM drivers have a `gem_create_object` callback which
> could be used to allocate objects from Rust. The C code will "destroy"
> objects with `kfree(object)` on error paths which is unsound if the Rust
> object's DriverObject contains fields with a non-trivial `Drop`
> implementation.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Fixes: 80df573af9ef ("rust: drm: gem: shmem: Add DRM shmem helper abstraction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
