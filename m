Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F54606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=K6Cu0DQS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A660110FCE0;
	Wed, 18 Nov 2026 13:48:49 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F0410FCDA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 13:47:53 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4925ef75fc4so786617f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 05:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795009672; x=1795614472;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zquXBrMDSkgmhzVSBU9n1JfbEE6tjoTWMroKtZE+aJ8=;
 b=K6Cu0DQSqp6IToEpLvaepHvLzBI5PAYB/YVPiGiBZy9k/zipiXndpUOWv82wGtTL9x
 7vyjIQG9mSFezl0DLJtI1nzf5V5kRqYkQFQRjF03OkwQY/4T+22pKmav3fKP/Deto4qn
 qVHymwYp6Tlqy7hKs5RmoLX62Jd16tQB0tbvf6BRidbl4dN9oIsj5JP8M35tit+S4eeT
 NCIwEGd98Y0y6glmNst8sSQGOmqznXFf1DeNjnEqaEjGbY9dyYkeIb1P7UBqi5wMJYuw
 hK8J8Bi9XdPi0vKlFFHKjU4WCKHOhqg2KhftRwKxNCpNDcKwwdB8E3tKbUZAM+QYFmEQ
 XMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795009672; x=1795614472;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zquXBrMDSkgmhzVSBU9n1JfbEE6tjoTWMroKtZE+aJ8=;
 b=y1y6xWz/sdJDBMjLnrBDMlyc3bKdCLW4XqhsCVfYGqYdusD9Zya0MW9Ex7xzjfJ1Dg
 sFwQCN/u+pcY5d1WXRTc1uWik+b2qCDA+iaAbPdm5FVsnYo3QrYTZIBb8u4iLcS1U6xl
 OF/HNW2aUfuxuKFuGdGQoPTVZq666RfuOJ5caEBdfrMdc02LR7CmcG6GoxN+lGwrs38U
 zS68R1UzutkEylxriIA2u5XwsL93Yk1UpFoD9qUjedidPXuuzj0wBYNKK+aBX9mMWnxB
 ndJ4qXj1QYTmllXb2ctY+nPX+blgzrfruqLCDIsoyQMXzqKhge7wDcyx+6811D4azwnl
 7B0w==
X-Forwarded-Encrypted: i=1;
 AL+hErE3cxGQwJWs8ZChHyOXcV4Ch3bmj1ydfyznCd20+4Uk+SyPxk3QuK8NdmtdYEvvzWsLO9k8UN6G7mQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/1LUd9lQjSQx3leDfLDTn0V1rl68JveQ9qpePnXs8mYQCOPO7+
 kknb4+YTw2xH1UJ0Oq8koJp9zzOWBa0IQ4QTuoK6EbwXWwa5+xSy7HHWv0Md55F+EKxwrCimqaD
 RyHRt/meE+Vgqe6svYg==
X-Received: from wrqt12.prod.google.com ([2002:a5d:460c:0:b0:4a4:28a2:fcf9])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d84:0:b0:4a7:150e:cfe5 with SMTP id
 ffacd0b85a97d-4a7150ef4dcmr3970052f8f.42.1795009671601; 
 Wed, 18 Nov 2026 05:47:51 -0800 (PST)
Date: Wed, 18 Nov 2026 13:47:50 +0000
In-Reply-To: <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <20261013-clk-type-state-v6-3-a5e9977b3509@collabora.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118134750.658250-1-aliceryhl@google.com>
Subject: Re: [PATCH v6 3/7] rust: clk: use the type-state pattern
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

On Tue, Oct 13, 2026 at 02:07:42PM -0300, Daniel Almeida wrote:
> +    /// Drivers that need to change a clock's state at runtime (for example to
> +    /// enable it on resume and disable it on suspend) can keep it in an enum
> +    /// and move between the variants:
> +    ///
> +    /// ```
> +    /// use kernel::clk::{Clk, Enabled, Prepared};
> +    /// use kernel::error::Result;
> +    ///
> +    /// enum DeviceClk {
> +    ///     Suspended(Clk<Prepared>),
> +    ///     Resumed(Clk<Enabled>),
> +    /// }

Nit: looks like this doctest missed the vertical import style from patch 1
(and `Result` is already in the prelude).

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
