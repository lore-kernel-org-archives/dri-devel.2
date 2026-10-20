Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53E606A324
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=MdWyIn4V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D10A610EB78;
	Tue, 20 Oct 2026 08:01:15 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F41A010F344
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:01:09 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1e3efca9aso22719145e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792483268; x=1793088068;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BEQrrvHcs9KsE+y3M9FCOBwSyvA+LmAr++le07P3KGA=;
 b=MdWyIn4VCv4bPwKkLc3GV9XdM8eoE4yfH1XwHzNhbi1+Ui6fSNdGZu2D7nDpwGeQeG
 Tb5jUxJZywgCp/mWLVHKz1Mqmy2TwbM9PpYaxDBUr3Jl6B13R4kc9QIWAmRgET0lx1Mo
 FtO3aaCa3oWzxrD4tged18dGeIbMgwQaxnwJl7+BZWUIh55tUvp0rtzLiKFFc51U5bUR
 FE0O+w7l9PqR7ThnQWOtySsdq7yXBrnH+9AnxVKxVItsEukvWDZeGLs7xeU7apQ6Uw8V
 rPykZ7l1RYIXUvEMSWweDlEiNIZyTOxkleagZ9HXkqIY82K9BmrNkypzo1HgnuDnBTTp
 Dc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483268; x=1793088068;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BEQrrvHcs9KsE+y3M9FCOBwSyvA+LmAr++le07P3KGA=;
 b=fbhEKBBVGbYEFEQ0fTklkga3N6aMexIyzXPUeP2aDe/F1tvjiGP/IhOoB+Qcl1h4gC
 sk0mZ3nne8j5HtH5zt3sStDiAEPyh2s/cSUmCPOXB145hF2Fh/sCsKpj6gstZjyoRwso
 cGiHNDJuOYzVWKrvY5X+a4zzjfdVoWyIpd9Iu1cSRu7MmVe6RUe75g4d+fNVt3z44DA1
 JSsXCtVWPwI4CUviHPRiXus40g3WnJ8cCWw7ZzenZ4WRxilGotz68ZxgpDC1IAR201zo
 iZgUaReJ8faW9ZqUouiUjNHU8+QowoFkmO9rZGmFJqFF7Qt5UqWbEzFcl540bPVi0zUi
 S3QA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzaTn1gEn94TF0leq07ev/Jd97t/rQve9uRn8HgchimCX1xtXoyQ8W5CFF8hy1T01skd6q4EyFMPPg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJCtESpteRJb3YOI3qDYS/YCvMwQ/T2Jo9TJgODCB9ENVGBad7p
 CCIBaPrino0Bav91e6nWYw8NubtkB8McrM5/2I1dpYIBC0GzrbrMCwhLrh++L8TnfXvog8W/2z8
 aXopFA138fqlmfn3y7Q==
X-Received: from wmbid21.prod.google.com
 ([2002:a05:600c:a195:b0:4a1:b4c0:10d8])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:81c9:b0:4a1:ac66:6ac6 with SMTP id
 5b1f17b1804b1-4a1d7612994mr191651635e9.26.1792483267890; 
 Tue, 20 Oct 2026 01:01:07 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:01:06 +0000
In-Reply-To: <20261019-b4-gpu_info_intobytes-v4-1-0bc04df46549@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019-b4-gpu_info_intobytes-v4-0-0bc04df46549@collabora.com>
 <20261019-b4-gpu_info_intobytes-v4-1-0bc04df46549@collabora.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020080106.1742330-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 1/2] rust/Makefile: add zerocopy and zerocopy_derive
From: Alice Ryhl <aliceryhl@google.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 04:25:59PM -0700, Deborah Brouwer wrote:
> Make the zerocopy and zerocopy_derive crates available for use when
> building the bindings and uapi crates and their tests.
> 
> This will be used by the Tyr driver that needs the traits IntoBytes and
> Immutable to safely copy the struct byte-for-byte to userspace.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  rust/Makefile | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)

`scripts/generate_rust_analyzer.py` also needs to pass `zerocopy` and
`zerocopy_derive` in the `deps` lists of `bindings` and `uapi` (similar
to commit 3c847e17225a ("rust: add `pin-init` as a dependency to
`bindings` and `uapi`")).

Without that update, `make rust-analyzer` generates a `rust-project.json`
where `bindings` and `uapi` only depend on `core`, `ffi`, and `pin_init`,
so `rust-analyzer` fails to resolve `zerocopy_derive::most_traits` in
`uapi` and does not see the derived traits on `drm_panthor_gpu_info` in
`tyr`.

With `scripts/generate_rust_analyzer.py` updated as well, a subject
prefix like `rust: add zerocopy and zerocopy_derive to bindings and uapi`
might fit better too.

> diff --git a/rust/Makefile b/rust/Makefile
> index da1a7409d984..f59815fac293 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -361,12 +361,18 @@ rusttestlib-kernel: $(src)/kernel/lib.rs rusttestlib-bindings rusttestlib-uapi \
>      $(obj)/bindings.o rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
>  	+$(call if_changed,rustc_test_library)
>  
> -rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_init
> -rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init FORCE
> +rusttestlib-bindings: private rustc_target_flags = --extern ffi --extern pin_init \
> +	--extern zerocopy=$(objtree)/$(obj)/test/libzerocopy.rlib \
> +	--extern zerocopy_derive=$(objtree)/$(obj)/test/$(libzerocopy_derive_name)
> +rusttestlib-bindings: $(src)/bindings/lib.rs rusttestlib-ffi rusttestlib-pin_init \
> +	rusttestlib-zerocopy rusttestlib-zerocopy_derive FORCE
>  	+$(call if_changed,rustc_test_library)

Nit: non-recipe continuation lines in `rust/Makefile` use 4 spaces for
indentation rather than tabs (same for `rusttestlib-uapi`,
`$(obj)/bindings.o`, and `$(obj)/uapi.o` below).

Alice
