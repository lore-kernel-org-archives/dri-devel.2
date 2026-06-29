Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E45C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:07:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB1E310E256;
	Mon, 29 Jun 2026 14:07:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=lunn.ch header.i=@lunn.ch header.b="sPe3Iq+2";
	dkim-atps=neutral
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CBB510E256
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=AK6FrYtKSIh8cngqIV8WnN9GXpQxjhIF++nUuJZfwbU=; b=sPe3Iq+2B0cNSg858/MXj17mqs
 nGlNw4jzWt1Blm83SZhOTLuScCneipEQxYrk7fXoJmwYNeCbx8QSg1zGqipMB+jk5FPKkzUkyFMIs
 HpGichrCIBqHOm8y6SCjU5HgKkXaATkMgoXLLY+KqvXdNOnkRWFnviWgOcyKmCa5rfCU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1weCdA-009lYC-UB; Mon, 29 Jun 2026 16:06:36 +0200
Date: Mon, 29 Jun 2026 16:06:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, Michal Wilczynski <m.wilczynski@samsung.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Jens Axboe <axboe@kernel.dk>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-pwm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-block@vger.kernel.org, netdev@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/7] rust: Use kernel style vertical imports in various
 drivers
Message-ID: <c89a1bc8-6cc1-4e16-ac95-add389e45a2b@lunn.ch>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Sun, Jun 28, 2026 at 08:38:14PM -0700, Guru Das Srinagesh wrote:
> Came across a recent commit bc58905eb07 ("samples: rust_misc_device: use
> vertical import style") and found a few more locations that could
> benefit from this cleanup. No functional changes.
> 
> Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> ---
> Guru Das Srinagesh (7):
>       samples: rust_dma: use vertical import style
>       pwm: th1520: use vertical import style
>       cpufreq: rcpufreq_dt: use vertical import style
>       block: rnull: use vertical import style
>       net: phy: ax88796b: use vertical import style
>       net: phy: qt2025: use vertical import style
>       drm/nova: use vertical import style

You have multiple subsystems here, so you need to split this patch
setup, per subsystem, and submit them separately. Maintainers only
accept patchsets for their own subsystems.

For netdev, please take a read of:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You need to get the correct tree, and set the Subject: line correctly.

    Andrew

---
pw-bot: cr
