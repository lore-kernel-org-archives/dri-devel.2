Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F363C44501
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:13:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D678610E7A1;
	Mon,  6 Jul 2026 07:13:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gurudas.dev header.i=@gurudas.dev header.b="gxzDANV1";
	dkim-atps=neutral
Received: from out-06.smtp.spacemail.com (out-06.smtp.spacemail.com
 [66.29.159.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACB1E10E10C
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 01:02:00 +0000 (UTC)
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net
 [107.194.158.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.spacemail.com (Postfix) with ESMTPSA id 4gt8Mn0CXjz6tkM;
 Sun, 05 Jul 2026 01:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
 s=spacemail; t=1783213318;
 bh=2qJqLI5cYmY6XssOjT5mS6RQt8tME0zYaMT/RBuKHhI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gxzDANV1JQoWbSrlTIw2Hbb83lUzmrjW19c3OZvI3lIFLUx0NWjORGAdcrfZ4Iy1r
 8iyC/nftZCN6RsgyVPXhGqT3xB7lKhDTIYvv4mPgt23HneL2vlZdPZGvj5/AKk5Pfp
 wZfKzZkjQvogs3VONlJW1oADetqYF+Z1IsjAZyW86GXa/ntxYiqBXIBTcI8TBWs5qC
 6LphD9AsDF1QQyi7SDc//YsSj4N4PrmToDXekNK0bsPhGwCiGJIgQfdhGPqBLM/i3q
 aiuUXbswiQh086BPfvu9FQvRyd8BtJCb/XDmrMZaTKsgOjTHbYsMvyE/xBsne6r0RG
 gHli7e1+IvGdA==
Date: Sat, 4 Jul 2026 18:01:55 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
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
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
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
Subject: Re: [PATCH 3/7] cpufreq: rcpufreq_dt: use vertical import style
Message-ID: <akmtA7EbVBdhRAOq@gurudas.dev>
Mail-Followup-To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Jens Axboe <axboe@kernel.dk>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>,
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
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-3-98bc71d4810b@gurudas.dev>
 <f0ed588a-6cfb-4079-a2fe-7c14f1b42727@oss.qualcomm.com>
 <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=SQK7pd-fj+4MOb=E6=R-DHCcLcuCvN=us2E5o7Rcy2A@mail.gmail.com>
X-Envelope-From: linux@gurudas.dev
X-Mailman-Approved-At: Mon, 06 Jul 2026 07:13:14 +0000
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

On Tue, Jun 30, 2026 at 10:35:00AM +0200, Miguel Ojeda wrote:
> On Mon, Jun 29, 2026 at 2:43 PM Zhongqiu Han
> <zhongqiu.han@oss.qualcomm.com> wrote:
> >
> > If the preferred style is to place each imported item on its own line,
> > shouldn't imports such as
> >
> >      cpu, cpufreq,
> >
> > be formatted similarly as well?
> 
> Indeed, good eyes.
> 
> To do what we want, `rustfmt` needs the `//` at the end of that level
> too (in the future, it will be without the `//`), i.e. the patch
> probably passes `rustfmtcheck`, but it still needs to split that line
> and add the other `//`.

Hi Zhongqiu, Miguel:

Yes, I did run `make LLVM=1 rustfmtcheck` and it passed on this series. I will fix
the missed ones in v2.

While investigating this, I found that that adding this config `imports_layout =
"Vertical"` to the rustfmt options would fix all the imports automatically, including
the ones I missed. I ran it locally on the files touched in this series using rustfmt
nightly and it correctly fixed the imports as desired:

    rustup run nightly rustfmt --unstable-features \
      --config "imports_layout=Vertical" \
      --config-path .rustfmt.toml <file>

But unfortunately, since `imports_layout` is an unstable option currently [1], it
cannot be used straightaway.

However, .rustfmt.toml already has a section of commented-out unstable options kept
as a reference for when they stabilize. Would it make sense to add `#imports_layout =
"Vertical"` there? If so, I can include it in v2.

[1]: https://github.com/rust-lang/rustfmt/issues/3361
