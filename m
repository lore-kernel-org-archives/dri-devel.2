Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01D5606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=I5BrE27e
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52B110E570;
	Wed, 18 Nov 2026 13:48:43 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9C2110FCDB
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:47:56 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4ba078abd78so6514205e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795009675; x=1795614475;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ReEzbagpHcp/fcY0hMd4fNtM6diXxUaPoUO44vW/qBI=;
 b=I5BrE27eHXL7P3KXhnF3LMexsvJL2pL1Rwpz8IUod5G2mAu6yAa5H5sCuHGFIxG0Qq
 71sOM9iM/gE5b3upq4fO8vIGeXt82vLg3dnLd9QDa7WG1bNSkVJ+5lwHD7lbWVpAY/Ix
 ncUJF/7+4BeVftYVtt7PgzuOvD+8Nrs3JsiZn23QVgyQsz16BNgplne6yw+x+i2+2rSC
 FH+Wik8szkxCWnP7JBpU6VgGa1f2bSo1FDnKUoIeXGGIV5b/c4KyODKClEIImdNeBAmo
 a418z4PA9yLjsmt7gM2vaDAC+23DrjEAFWy2KqJ7AqaFaFSxCDwNQmGxyhQSiOz+CtnD
 MfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009675; x=1795614475;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ReEzbagpHcp/fcY0hMd4fNtM6diXxUaPoUO44vW/qBI=;
 b=H+RMj1R5BTL5EUyyBdfYyqll+tfTfPLHWhe+CnVy2+bmzQX7Y3ogYbXyzeDq/zj5PW
 jaeoZULqWC1+6UrYH0Qgdpd+nOg0xmt8WaGBY0jxi+zZKyStgLwkk2tses8Y2mrPojiO
 O89rUUmT7bgBjMf7WUt7f19zqDfz3uTEiIDSkxDakKpceRlk3xqTMH2VpqUXXqptA1WQ
 scy2qdPUIycXqRvZlbavcCOXshDRF9Wvvp8knPnwYlJlQtAFrVtBRaXsdus7Ex8r+wOL
 bRqYk6feks+y35JCtq8gBptIBIG/lo/+A8vcomwkWC+fgpOFWxq/JP5eeUyXQOVHERBf
 6aRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFuERxIHIuigbMwGPT+NnJaed1gorr4kmviM6r4voDaeKkGr/2/mN/QdO6lMezA7xCgoDHySQo0KRU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/kIEibrxY6+g4aoWALd1VqcjRrgucLLS0AndvIqxYVIvAatZfL
 5NlhR2jE4Nc7Jht69hTv8H9/hGV4Mu27oBjYgAYFLosNgWmTIgHQOZgkAt2NZJdnVdFXZyJojDo
 xlxecitZJ0T8jIbLFgQ==
X-Received: from wmbgz3.prod.google.com ([2002:a05:600c:8883:b0:4a1:811f:6de2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f56:b0:4b7:6c16:7b43 with SMTP id
 5b1f17b1804b1-4bb7da12aa6mr55502915e9.10.1795009674222; 
 Wed, 18 Nov 2026 05:47:54 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:53 +0000
In-Reply-To: <20261013-clk-type-state-v6-4-a5e9977b3509@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-4-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134753.658399-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 4/7] rust: clk: add guards for scoped prepare and enable
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

On Tue, Oct 13, 2026 at 02:07:43PM -0300, Daniel Almeida wrote:
> The state transitions consume the Clk, so a driver that keeps a
> Clk<Prepared> in its data cannot enable it for a short section without
> moving it out and back in. A clock handle also holds at most one count
> of clk_prepare() and one of clk_enable().
>
> Add EnabledGuard, PreparedGuard and PrepareEnabledGuard, returned by
> Clk::enable_guard(), Clk::prepare_guard() and
> Clk::prepare_enable_guard(). Each guard borrows the Clk, takes its count
> when it is created and releases it when it is dropped. It dereferences
> to the clock in the higher state, so a function that takes a
> &Clk<Enabled> also accepts an EnabledGuard. Several guards may borrow the
> same Clk, and the borrow keeps the Clk from being dropped or moved to
> another state while a guard is alive.
>
> There are no users yet.
>
> Suggested-by: Alexandre Courbot <acourbot@nvidia.com>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
