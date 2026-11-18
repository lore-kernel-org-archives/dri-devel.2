Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E5606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NTkEQReF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 831D910FCDC;
	Wed, 18 Nov 2026 13:48:44 +0000 (UTC)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DC0610FCDA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:48:01 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-492d47f142cso597446f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795009680; x=1795614480;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=YBVvUekf13M+I2J4OXSpne5JBm6BNzst3m7Bc2T2IGo=;
 b=NTkEQReFh8GZDi93heAa92ZGNl63uZCh5pFKmbuKisGwWFGAgvX+pK/09n0iaiIni0
 gCQ/NpMXdSY9alDwxJMzXTH3wAag25E5GJtlOO0EMxitgOF8uoQ2IdHrxdr1hm6pOE82
 S3/cMIRyvU4yGgBMQqumXHsANOamn3bgXxJzmTxjECw1LqtLkbPQTq+mT9c7sETeYPHA
 T0w2H0VsmQfaCJs8v/zA+dI+WAQ1HeQGjUeuoEkq5LMuxevzms1jdybPtWJ0Oihk16u0
 LUByaDT+VvS6o+kNMzrWhMo38kxsyuqzwoh+AOyzlwq2Wu2xa03ubXbXL/bJ/bZsDZh8
 Yh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009680; x=1795614480;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YBVvUekf13M+I2J4OXSpne5JBm6BNzst3m7Bc2T2IGo=;
 b=iQkhFjqs0fJITAIw1akiUwRmmGYcxN3RDp7wrr0mbujaWZeiksJmGroGSizeKBiSxG
 if2C4gj4xqSsA1EQ8fJeIO3817yfIkl7alCNqV1u5zSqS+k6Qex9sohm94Incid9p4Yb
 zFlRWmisZMlB46u+35lHkNhyeq4lGjeDVkI7xDErhsov6ZdOzFRbmtJSV8G0ABOQpz7q
 H4EA89jLTm0GKphDFjvm4AaZ8eeGYIovW9X29BdbwghoNuekdZI9TuEjzczbUqzHs9BO
 TL8hq09HK02Ze+vItTYNo7P57wmt+OdOLSMiG/Rs0fkfZZlAj8xCKYarlEjiCD7Thyyl
 4b6A==
X-Forwarded-Encrypted: i=1;
 AL+hErFJhdRjxPBaNOTJBKXBdd+MWn3D3ubqoYiS17VclniW+ZMJIVKmtAOUNdD13dq9446JrAwfSboechg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/+GTnVDXnSeSplXipmp79WscRwByqHWOYD7KYyFDap6A36/RRL
 u8VMHPt4M6X1Iwo0b+KS6d6c0EfDIt3EdwOXchzOGn4NQFcCG8Ehdlz+9BzmY425UGAvlj98hMp
 RnAeia1UMVr64iELP8Q==
X-Received: from wrvt10.prod.google.com ([2002:a5d:534a:0:b0:49d:572:f312])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5f91:0:b0:49b:b94c:e8e8 with SMTP id
 ffacd0b85a97d-4a37294840dmr12837911f8f.8.1795009679054; 
 Wed, 18 Nov 2026 05:47:59 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:58 +0000
In-Reply-To: <20261013-clk-type-state-v6-6-a5e9977b3509@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-6-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134758.658847-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 6/7] rust: clk: add `ExclusiveClk`
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

On Tue, Oct 13, 2026 at 02:07:45PM -0300, Daniel Almeida wrote:
> +    impl<T: ClkState> ExclusiveClk<T> {
> +        /// Takes exclusive control over the rate of `clk`.
> +        ///
> +        /// No other consumer of the clock may change its rate until the
> +        /// returned [`ExclusiveClk`] is dropped or [`ExclusiveClk::into_inner`]
> +        /// is called. This may sleep.
> +        ///
> +        /// Equivalent to the kernel's [`clk_rate_exclusive_get`] API.
> +        ///
> +        /// [`clk_rate_exclusive_get`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_get
> +        #[inline]
> +        pub fn new(clk: Clk<T>) -> Result<Self> {
> +            // SAFETY: By the type invariants of `Clk`, `clk.as_raw()` is a valid
> +            // argument for `clk_rate_exclusive_get()`.
> +            to_result(unsafe { bindings::clk_rate_exclusive_get(clk.as_raw()) })?;
> +
> +            // INVARIANT: `clk_rate_exclusive_get()` succeeded, and the matching
> +            // `clk_rate_exclusive_put()` is called when the `ExclusiveClk` is
> +            // dropped or consumed by `into_inner()`.
> +            Ok(Self(clk))
> +        }
> +
> +        /// Releases the exclusive control over the rate and returns the [`Clk`].
> +        ///
> +        /// Equivalent to the kernel's [`clk_rate_exclusive_put`] API.
> +        ///
> +        /// [`clk_rate_exclusive_put`]:
> +        /// https://docs.kernel.org/core-api/kernel-api.html#c.clk_rate_exclusive_put
> +        #[inline]
> +        pub fn into_inner(self) -> Clk<T> {
> +            let this = ManuallyDrop::new(self);
> +
> +            // SAFETY: By the type invariants, `clk_rate_exclusive_get()` was
> +            // called on `this.0` and not yet balanced, so this balances it.
> +            unsafe { bindings::clk_rate_exclusive_put(this.0.as_raw()) };
> +
> +            // SAFETY: `this` is wrapped in `ManuallyDrop`, so the `Clk` is moved
> +            // out exactly once and the `Drop` of `ExclusiveClk` does not run.
> +            unsafe { ptr::read(&this.0) }
> +        }
> +    }
> +
> +    impl<T: ClkState> Deref for ExclusiveClk<T> {
> +        type Target = Clk<T>;
> +
> +        #[inline]
> +        fn deref(&self) -> &Clk<T> {
> +            &self.0
> +        }
> +    }
> +
> +    impl<T: ClkState> Drop for ExclusiveClk<T> {
> +        #[inline]
> +        fn drop(&mut self) {
> +            // SAFETY: By the type invariants, `clk_rate_exclusive_get()` was
> +            // called on `self.0` and not yet balanced, so this balances it.
> +            unsafe { bindings::clk_rate_exclusive_put(self.0.as_raw()) };
> +        }
> +    }
>  }

Only new() states that it may sleep, but into_inner() and drop() may also
sleep. This may be worth stating.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
