Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81922606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OPp6rYL2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C8A110FCDA;
	Wed, 18 Nov 2026 13:48:44 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8BFB10FCDC
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:47:50 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4a82fb7e71eso180250f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795009669; x=1795614469;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=tbHSrCrWbtManjiZm8yvLdlzikeM8PecjfjtsmyrzGk=;
 b=OPp6rYL2KNCy7/XiS8qAmdcG2Snhk2mF3O23IzxeHnz+267NFBDVa5sJClGT7XCyic
 NbN8tw0KZQ7tdwCQEDO9eF1ckQYU/gwDSdlp8kuLvfG30PJ8CZUWCv+jX1M/3WyDUCvO
 6gostj1+VHbT6WFHxHd6b7V+hTXdlG14NmY2VZr/3yl/yWuXzZeHMLCx+pZLObpc2xOm
 z4foB3KX3ohNYhO/PXrFqg9e3+rbocIAbapNnn+zZpxrGL72lO5fPzLTGXd6C3REP3Lk
 Y/HTqF7vWj3wxGlXmVwxAVxPI9+2Txmyx0xSHdsbMXPM14gKJime9Ar+qJKA71+edj8x
 2oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009669; x=1795614469;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tbHSrCrWbtManjiZm8yvLdlzikeM8PecjfjtsmyrzGk=;
 b=AC7K+4wjZxRULlwdVrGtlDOOPvWw+wgKhcc7DTePLpvvjqnJlPP6CJ0POOkl/FUwAx
 1IhXnOtwHMfXfZU4mXFIfY4eA4FurZKa/sg2CFkt5iYe5eHq8a07GGwBilVQUCKBiIHx
 VmQDb9swhQSvhJ4wUlW8MMlPqNco6jpDliFc3FKrcPlfwlbNkHnxpVonf0Qk/XwjYOyi
 lGWJkhJwc464mlBlS5KlaaLFERetKGJ3lYXuZ/Yz9AxpmEcQWqTYDrpbORNINTaEnzrj
 Rj76KiKkCLdcNuYMJmL4YKxTjj4otx5uaeQxj4WehVWuos1/CYt/04pZw1RU6Ok0KuSM
 xZcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGd+5lpe/UGdIxl8tGBBToHMNahNuFPr1frekrAeTKgeuDubIDl9xh8ffUoap8Qe7VWEZhJ5lEJk7g=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ixdAJ+58GIe91bHq0konNc2BleYPdlLIv4zoc0aa5raITAx2V
 9rDZQ/Huo2ypdny+jj0dZAaxm5nvdqftmXuLaIgVpu0fxK9YA85ALfoblpfqtz/mW+QK6DO3LYz
 rvlknBN8LOvnVkyOHrQ==
X-Received: from wrop10.prod.google.com ([2002:adf:f20a:0:b0:4a7:5aab:c222])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:41c9:b0:492:b1c5:6db4 with SMTP id
 ffacd0b85a97d-4a63bbc379bmr5187806f8f.26.1795009668616; 
 Wed, 18 Nov 2026 05:47:48 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:47 +0000
In-Reply-To: <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-2-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134747.658063-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 2/7] rust: clk: replace `OptionalClk` with
 `Clk::get_optional()`
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Alice Ryhl <aliceryhl@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Drew Fustini <fustini@kernel.org>,
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 "=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, Jerome Brunet <jbrunet+clk@baylibre.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 "=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>,
 Maurice Hieronymus <mhi@mailbox.org>
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

On Tue, Oct 13, 2026 at 02:07:41PM -0300, Daniel Almeida wrote:
> +        /// Behaves the same as [`Self::get`], except when there is no clock
> +        /// producer. In this case, instead of returning [`ENOENT`], it returns
> +        /// a dummy [`Clk`].
> +        ///
> +        /// Equivalent to the kernel's [`clk_get_optional`] API.
> +        ///
> +        /// [`clk_get_optional`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_get_optional
> +        pub fn get_optional(dev: &Device, name: Option<&CStr>) -> Result<Self> {

rustdoc appears broken here (putting the URL on the same line as
`[`clk_get_optional`]:` avoids splitting the link definition).

Otherwise LGTM:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
