Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26679606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bt0aNUML
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5978D10FCEB;
	Wed, 25 Nov 2026 15:03:38 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37CAD10E927
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:03:17 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4bb66fc3aa6so50325945e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 07:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795618995; x=1796223795;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N4O2DbAYKqujXPOE3qGC4/NB1PRFQz/yrJhP3BnWqGc=;
 b=bt0aNUML1lJvZ3wCL59azuBwmpaFBlp8nh18gjRxzRKal/dBYAEt8+A+QYfAEYg2Gd
 zv+eJltNr7tOenT6t8fE+eALT1yDKits91fvuqk3OXtnmERgY5nEeZs1QcBjvAsF6Djm
 fhyGtFNkWW2g/ZOPoinQOXWq8P1d+pHDmxPJTrayweI3vgNeSEwzEsYOJDtP9mY5WlQF
 hY0pfzX+ilxFtrPT7ui4k48jEWkpuAvmRzsqx3ByD+E919CcF2xWB8N3hrPDRIPoxE0j
 s1mKbO4rheIk7Dfk+exihx80PqwmcPG4KotsdOU+3GhaACOJy0mx3wsXnw510iU0G5x0
 NvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795618995; x=1796223795;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N4O2DbAYKqujXPOE3qGC4/NB1PRFQz/yrJhP3BnWqGc=;
 b=ybVnJgsdkRDcmG7OWxSiiA4ELK8e3OK9s3DmXJGz2bm3xBTFBcPAC7ugDcEEkIAE2q
 2zKoN6cQFGPSjQ6nNHrTrqKSnchoPAg7SbRLSv+UuhN1x/lQBqpEtnQz+LIPVbO72Po5
 Kh2iwjR3ZWz/Dh4gSi1x9NqSsf4dQiTeX2NJA+e/+NWWB32QeTq16OCvPYLvl7b5VBLh
 gUm7faQPCqMfrdpsiQihz1W5cYQdVc/QdlG41qtkELUUOFlpr1mQfF+8fYeBaXYujl7h
 yXsXqN+Z+7lWd+XuVqOKn73pOVMPqPrS9RUCFQ5Ck1Wr4BnrMlqe6FHQI1sA7p4C7ElZ
 nyzw==
X-Forwarded-Encrypted: i=1;
 AL+hErFsZ37WNza1VHQ86P+mMMJks+mpr/MeeaqLeVOGLRSbvE5KbU9wGxcBW4cRBi37qV2qUgHLx1xdiA0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/l2l6/LAzagJGQLLIssmJYpBzj2+hKKQI/ZlXvQVEDqNKfQAod
 72Md/vpu5SBEQ48W5WQKxIkUI6mUeGNk37jraUaT4XwbBZpQloJvjlIzEqbcoU7iD9RdQOhVSEL
 w8cyo1rtLqt0ZrZrmQw==
X-Received: from wrpy15.prod.google.com ([2002:adf:f6cf:0:b0:4a4:8614:8907])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6748:b0:4ba:761:97a1 with SMTP id
 5b1f17b1804b1-4bb888251bfmr350875475e9.14.1795618995334; 
 Wed, 25 Nov 2026 07:03:15 -0800 (PST)
Date: Wed, 25 Nov 2026 15:03:14 +0000
In-Reply-To: <20261124-rust-drm-gem-shmem-imported-sgt-v2-2-000f7a9ccb8d@jannau.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261124-rust-drm-gem-shmem-imported-sgt-v2-0-000f7a9ccb8d@jannau.net>
 <20261124-rust-drm-gem-shmem-imported-sgt-v2-2-000f7a9ccb8d@jannau.net>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261125150314.1587795-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 2/5] drm/gem/shmem: Initialize private objects via
 drm_gem_shmem_init() too
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
 nova-gpu@lists.linux.dev
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

On Tue, Nov 24, 2026 at 12:37:44PM +0100, Janne Grunau wrote:
> Rust drivers need to initialize private gem objects when importing
> DMA-bufs. As with regular objects the ideal way is to allocate the
> object in Rust and initialize it via the DRM gem shmem helper. Expose
> the `private` to the exported drm_gem_shmem_init() function.
> 
> Link: https://lore.kernel.org/rust-for-linux/20261118114102.490384-1-aliceryhl@google.com/ [1]
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
