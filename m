Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6D0606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cN01Gzim
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6876410FB35;
	Wed, 18 Nov 2026 11:41:29 +0000 (UTC)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 348C110FB35
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 11:41:23 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-49205554e17so586325f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 03:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795002081; x=1795606881;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6D6rhu+SkVFybLm4YEOF9t8UdzNLA6IBCbMCQMMTO+E=;
 b=cN01GzimBA3IevPqikRn9+U/gvjfnF0+HxA4/HarlV45bgVhY5fLHGIPbeqkcGQUXr
 dDEI80h2Mm/WSnH1Yp6u1K+xTaiFJtOnp7paGZ/mix3yR1F9f9bDdSIulwl/C/1DhtOc
 /tb1rv+W4hwIUSm4JaOGKkFAMGH6hdILdC1BTlaOhuBOTowxatFl3H2oSa+HrjqBkkC9
 VkP/SFQcBblr/6nai0qT0cgloScu6cqRl25oU8uwj3rTTGW8gKtTcIyCHVuoGO8S81WH
 AiviqCUkicoIbnbKsXR8Lhwee0Yl/nlyCH6a/uudi5rcZAUqPGnAYhgWXMRYUv3WoYvW
 aDTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795002081; x=1795606881;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6D6rhu+SkVFybLm4YEOF9t8UdzNLA6IBCbMCQMMTO+E=;
 b=1hDQKORqT19XqQ+S2U/lR7n214Cr/cpa4JRJKzbT4u2tbnAT5p3lakATcQ6qYWduMo
 Qp+5HLYRQ7ZrvtIc5QpvTFvv69jeUlpWM20X1TCvFdspKtWmgYa+NPNqZqrjQk1a41/N
 T69AWzwt2PzZOUo1RmX5B6YiaXqMK7CWgFmqoeBioOFMYK1gUJvjiyvNiX3jPTHqgQG6
 NHkVxBye4+Y7uomVJBVQWMsGt9EJoxZUMqgwwrONv1o83ew8TYTtaJ0VgvRDHRGT1LYe
 aPEdkNbipWhzKnkiru5oaMapsQ5TGHnXUPOteFZMfm25iRHPh0CF1c5zzb9wgkzAetUV
 Jpzg==
X-Forwarded-Encrypted: i=1;
 AL+hErHkATu7L6bgbS4kp/rUuevontxsOZObIz3OWDiXDGbhRt/8sNUg+r/kbC8RBgKxDhkx2IrgRz0yflE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+F8rBf5akZsBfzoDulCfW3FSolwYK+fUzX3uWcpqhnyu732z34
 WlIPkhziQ/ngnxqS7goNMO/AwlQfD9tKPCnY9GQLuFC3vNzsqLOXGxBNbHYr1WXHVG68UVBJdCb
 Zwm0SHEm2Ps7tTBi5OA==
X-Received: from wmix22-n1.prod.google.com
 ([2002:a05:600c:e556:10b0:4a2:11fa:1981])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e56:b0:4ac:86c9:b09c with SMTP id
 5b1f17b1804b1-4bb7da1b40amr42014765e9.13.1795002081244; 
 Wed, 18 Nov 2026 03:41:21 -0800 (PST)
Date: Wed, 18 Nov 2026 11:41:20 +0000
In-Reply-To: <20261026-rust-drm-gem-shmem-imported-sgt-v1-2-36f15ace04b1@jannau.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
 <20261026-rust-drm-gem-shmem-imported-sgt-v1-2-36f15ace04b1@jannau.net>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118114120.490722-1-aliceryhl@google.com>
Subject: Re: [PATCH 2/3] rust: drm: gem: add an is_imported() accessor
From: Alice Ryhl <aliceryhl@google.com>
To: Janne Grunau <j@jannau.net>, Sami Tolvanen <samitolvanen@google.com>
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
 Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, 
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

On Mon, Oct 26, 2026 at 12:14:09PM +0100, Janne Grunau wrote:
> From: Sami Tolvanen <samitolvanen@google.com>
> 
> Drivers need to check whether a GEM object is PRIME-imported.
> 
> Add BaseObject::is_imported(), wrapping drm_gem_is_imported() through a
> C helper shim.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
