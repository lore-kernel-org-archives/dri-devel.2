Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F858606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UWWpK4yR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4840011227D;
	Thu, 26 Nov 2026 10:03:10 +0000 (UTC)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A33B11227D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 10:03:03 +0000 (UTC)
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c4d4d132bbeso636895166b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 02:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795687382; x=1796292182;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z+D36NsUsNKkqF7ketqLvXXyv+j/mhnbTnZNBUdnCJ8=;
 b=UWWpK4yRmrKOqQ+mz+oAzOLDvNNKhPbiNUW9j1fUj9/DwY0Y3c2AigI18sDrlZmpg7
 g8Ab4ajq1Jo17Mxm1kXD5jh2civgI+GpjvbymQMmKqN0grSeUoTwWI76UnSnhOoyUFTj
 YcCtB4IK1ArojscUjQYRJOJDw/rd6wni+1rYBfb1cbD/rMHi3IVbFl8hNOfBMGl906zU
 Eo0qhrMpVXKTojNTgkC372j3tszZRCAIG4lXOsoY1y0CYUtVKDpgUyeEVuBp8D3nQgcb
 dunHsptqVk3cRYpep8AUZxJPnbAbg/TORGqpkY1R+Ahz9R8ZSg3MyRmCdUCJ+tRQI82I
 AE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795687382; x=1796292182;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z+D36NsUsNKkqF7ketqLvXXyv+j/mhnbTnZNBUdnCJ8=;
 b=q3Lz32B4tmsxre3wlQsEd4t2V4odiLQjENh39zesWAJ/qrjWQhR+XuQraU35waQHZh
 5WFRCmUhMC8Fh0gqFQrgMq/ZMZsALPPrW0TpkgJb17bYfjLiX2MaoWl3X154btQr1WV0
 j4NRhIy0JNIrC6n04sRbeO9fdLaDhDZxCneXcL+H9nPu6pCDKa53Oq1t4lxMfXufOIgC
 7DL8Ncu0ka5MJv2DeBLZ5tkzWOFZdHSQCUTyaaDZ+NPUXAQF4mMedqSTKrWS1Mg0jXXQ
 x2LwlQSK9wowAsC+fzzFbK3ofZq3lpjZPOjGuFLzF1K14aWq/PUNAmuYQxwk2W6jgZyp
 BZ+g==
X-Forwarded-Encrypted: i=1;
 AL+hErFGiKTvkpnfNyvGutvPXN24cMm1cUW0b1e1i4lISyT1yHWpHFMpoWxJODqh1vkTban7KDqrujRMQLQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+TWTCIn0ImYWNTaZsoowaGbsl1P1kN2HXLeo80NAUH7cWFYBoF
 PSBze9feDlr/e544IHdn97K5STSazUhDBLZl64uBsANXBYgnzk0u8QRrcgOLVseh3rWLG4YWS6a
 gbDYyOD9F+MXTA5Fw5A==
X-Received: from wrmd16.prod.google.com ([2002:adf:e890:0:b0:4a4:8b97:27fa])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:b0c8:b0:c51:5384:eb0a with SMTP id
 a640c23a62f3a-c515384ecf4mr1127711666b.3.1795687381470; 
 Thu, 26 Nov 2026 02:03:01 -0800 (PST)
Date: Thu, 26 Nov 2026 10:03:00 +0000
In-Reply-To: <20261125-rust-drm-gem-shmem-unused-unsafe-v1-1-d6c5cb0b391f@jannau.net>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261125-rust-drm-gem-shmem-unused-unsafe-v1-1-d6c5cb0b391f@jannau.net>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126100300.3642738-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: drm: gem: shmem: Drop unused unsafe for vm_ops
 assignment
From: Alice Ryhl <aliceryhl@google.com>
To: Janne Grunau <j@jannau.net>
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

On Wed, Nov 25, 2026 at 01:24:28PM +0100, Janne Grunau wrote:
> The assignment uses a raw const pointer referencing the static const
> drm_gem_shmem_vm_ops from C side. This is safe since Rust 1.82.0 as
> stated by the #[allow(unused_unsafe)]` attribute.
> This was added in parallel with commit f32fb9c58a5b ("rust: bump Rust
> minimum supported version to 1.85.0 (Debian Trixie)") for Linux v7.1.
> Drop the unsafe, the SAFETY comment and the attribute as they are always
> unused with Rust 1.85.0 and later.
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
