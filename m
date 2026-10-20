Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85BD606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 08:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=RZYxqvsp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9FD10F35B;
	Tue, 20 Oct 2026 08:01:23 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9B210F356
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 08:01:17 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a0228f4a1bso17000995e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 01:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792483276; x=1793088076;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xQxfbDvKliDHyezjEs6HEpfyze+JfozKdYi4BuTrbb0=;
 b=RZYxqvspwJ+Uquhnd7Shvw4RIX7CfAhlpJf4Qdou0KxCawU2oTbImsJ2NsddEV4PS2
 OlzXvZ+9oS/fJYB4Xn/EW36vei+qQ1eaN97x2qO1Yf0L9vcr2wtky3YGlAbtQat4pqZe
 gQUf6xkGOZuxKAic/u3iYFEzlDYLgvc9dF+5qwmevzUWDCxIQkhsglFz31uQG2v9DfON
 j7Wm78EIKo4UXAVZWyneErpj7FzktmxpfMOQozQxjMcb4pKxMPjOdx+UX/e/kQMOI4gC
 6MzQ9JorGPVfDBmm0JMEgL3wYy78pMRIuEUJTXK+DWktcdtyvM8clQoUFLZggQDjiEDi
 ckfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792483276; x=1793088076;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xQxfbDvKliDHyezjEs6HEpfyze+JfozKdYi4BuTrbb0=;
 b=Y23Z32cAO19MMB+7rgYwK6FFtIMFRkb6Cn/Eea1o3H/cyiH0slUWxOd1cirBXWacxt
 KyPl2JP7H0TymOFp5cWqFZCNIdO9S8hfXOFeOmBAs/tgIXBX48DWRZ31S1APjHnOSoUz
 5ZyiExYEfabBw+2NZY2CkW0H7d/AW6dtW8f2V48R1vODMh9XG6V/nAyeVmzv9ol+U/At
 kIRy0GJprRnmU9oY8Wadb9GqrYgTCFzZCF43Tcd7qfuFc6Sr4wxnrXezlnBZZI1ZQqhw
 sS3Gqe4j/dZDIn4r32uQxMcVCKKZSAeTtq6oECBlbFKhXph7kml12RRcPbfzhtQfcqOC
 J69A==
X-Forwarded-Encrypted: i=1;
 AKwUvByV9W8+yBcoY33V1hHNfuNgA3Z6nMzEoL1sFPjRfHtp+Jp+KnCCn6zaqWAiDEZE+UgzajYDco5Ur2s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIxZxjpYKuxe0QBdc/2rV6k3Wq+6gqD3/4xlZJqpcTmrK6T5irQ
 wv+VCry1uN3gYEd/3IKF+J2D0PtT93tEYcSR5cBCOXPjeYv1aIZjqcU0CfGvmLpB2DXCvX21L/c
 dczDKvahRrL4PjFHwyw==
X-Received: from wmlv13.prod.google.com ([2002:a05:600c:214d:b0:4a1:93c6:a7ad])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:82c5:b0:4a1:e575:33dd with SMTP id
 5b1f17b1804b1-4a1e57533efmr134049685e9.18.1792483269703; 
 Tue, 20 Oct 2026 01:01:09 -0700 (PDT)
Date: Tue, 20 Oct 2026 08:01:08 +0000
In-Reply-To: <20261019-b4-gpu_info_intobytes-v4-2-0bc04df46549@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261019-b4-gpu_info_intobytes-v4-0-0bc04df46549@collabora.com>
 <20261019-b4-gpu_info_intobytes-v4-2-0bc04df46549@collabora.com>
X-Mailer: git-send-email 2.56.0.212.g129ede20d9-goog
Message-ID: <20261020080108.1742496-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 2/2] drm/tyr: safely write GpuInfo to userspace
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

On Mon, Oct 19, 2026 at 04:26:00PM -0700, Deborah Brouwer wrote:
> diff --git a/drivers/gpu/drm/tyr/gpu.rs b/drivers/gpu/drm/tyr/gpu.rs
> index e1b04a0c5159..4808bcbcc3b9 100644
> --- a/drivers/gpu/drm/tyr/gpu.rs
> +++ b/drivers/gpu/drm/tyr/gpu.rs
> @@ -28,6 +27,8 @@
>      }, //
>  };
>  
> +use zerocopy_derive::Immutable;
> +
>  /// Struct containing information that can be queried by userspace. This is read from
>  /// the GPU's registers.
>  ///
> @@ -35,7 +36,7 @@
>  ///
>  /// - The layout of this struct is identical to the C `struct drm_panthor_gpu_info`.
>  #[repr(transparent)]
> -#[derive(Clone, Copy)]
> +#[derive(Clone, Copy, IntoBytes, Immutable)]
>  pub(crate) struct GpuInfo(pub(crate) uapi::drm_panthor_gpu_info);

Two tiny optional nits since you'll need a v5 for patch 1:

* `use zerocopy_derive::Immutable;` can be placed above `use crate::{`
  with the external crate imports.
* Now that `unsafe impl AsBytes for GpuInfo {}` is removed, nothing
  relies on `GpuInfo`'s `# Invariants` doc section anymore, so that
  comment block can be dropped too.

Otherwise this looks good to me. Feel free to keep my R-b on v5 with or
without those tweaks:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
