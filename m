Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4827C10F2867
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:42:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A053710EDE2;
	Fri, 27 Mar 2026 18:42:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dBpZj9XR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EEC010EDE2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 18:42:54 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ED98E434AD;
 Fri, 27 Mar 2026 18:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A6A7C19424;
 Fri, 27 Mar 2026 18:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774636973;
 bh=R9AHAajVl54S43rOD25tNtqd/iHB1Qz12wrBG7w2KjE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dBpZj9XROKl5nH06ExhS5qHZd5iNeaVJHFdt5izYFCthNqg7QZVcKU40duchyQRXL
 n6Bjzsyg3jVM3jFLSZ2/RbYr2nvpaQd8lVGrOtvdZudWnc1HuGawO/E6T3L8m0nO9F
 Bt/eKJSSOXZQIPbi4yUKf8ct5L2D1fHLRe+YcZ/L5fzXdamEUglYU08VnBtfjYKdXh
 VSl6fHA/gqaxQWAXLNZsqokqkytu8TpNiXT2ycTN7ohJ7+UfkUhtL06Y0TOhaGHpL9
 2qXqBvH1ykv4msmQZJUc22QgwluEZ0mXIEBQHUY/z3lGSyoqc5qPFUpoaaAsID6cWQ
 lmu5thbEFQEfg==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfauth.phl.internal (Postfix) with ESMTP id 5096CF40074;
 Fri, 27 Mar 2026 14:42:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Fri, 27 Mar 2026 14:42:52 -0400
X-ME-Sender: <xms:rM_Gaf53wU_w_vFmN1XR_9VmQF1e9TTRE1rM87oww0jbqKn3zQiTvA>
 <xme:rM_GaXPvT0Z2HQrHgUaQNVTRIVrWLOwO-BgCrV5k8GRfnE72m0QIvotqSXTp_orHj
 2gOytGhfi8Tw5WrIjza2Ip1_8Tik1hvjAcSmd5zwH2MmvzdFnQ12Q>
X-ME-Received: <xmr:rM_GaVKjAVbZbK7E0hlnUpPhDxno_FwWS3alvOVgDWol-eNebJPQxgRTTLinzpUhbU8XuI9F0parELUQLiuRtIH53yHFxQQe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffedutdefucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhquhhn
 ucfhvghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnh
 epgfdvtdefieetieefueetudehffevieffkeejvdetleffledvveetgfeufeethfeinecu
 vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunh
 domhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeijedtleekgeejuddqudej
 jeekheehhedvqdgsohhquhhnpeepkhgvrhhnvghlrdhorhhgsehfihigmhgvrdhnrghmvg
 dpnhgspghrtghpthhtohepfedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehm
 ihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtohhmpdhrtghpth
 htohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepfhhujhhithgrrdht
 ohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtthhopegrtghouhhrsghothesnh
 hvihguihgrrdgtohhmpdhrtghpthhtohepsghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgt
 ohhmpdhrtghpthhtohepthgrmhhirhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhope
 grrdhhihhnuggsohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhjvggurges
 khgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmh
 grihhlrdgtohhm
X-ME-Proxy: <xmx:rM_GadFLMzx4SKFk_EBd2q_cYZurxddg5M3RCp3W13r-KO2-pIw_3w>
 <xmx:rM_GaQwrMngO9IeycAuAvKlG4TKJtWiPzWRRnEJy5iLXeqAcanIiVQ>
 <xmx:rM_GaRzM6IaacdY8NVZgpSijNYfeYjtBiBd74AMcjNC3_VfJbdwB2A>
 <xmx:rM_GaeYlxRTqqcf4hORjoZECWHFuqZSzQ6j1M4n3MsRaTFYdYieCxA>
 <xmx:rM_GabyudvqMVVB43xhTcrM2BV1ORfwR7f7w1i5eNFfiIaXHwurbBMl7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Mar 2026 14:42:51 -0400 (EDT)
Date: Fri, 27 Mar 2026 11:42:50 -0700
From: Boqun Feng <boqun@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Gary Guo <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 Boqun Feng <boqun.feng@gmail.com>,	Tamir Duberstein <tamird@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,	Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>,	Yury Norov <yury.norov@gmail.com>,
 Will Deacon <will@kernel.org>,	Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Waiman Long <longman@redhat.com>, Yury Norov <ynorov@nvidia.com>,
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
Message-ID: <acbPqjBE8mqbiVkv@tardis.local>
References: <20260319121653.2975748-1-gary@kernel.org>
 <20260319121653.2975748-5-gary@kernel.org>
 <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kZH-AX=QQz2V+qCfVzMsUEAPan=o1E=OZOAnivj3L3HQ@mail.gmail.com>
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

On Mon, Mar 23, 2026 at 12:36:52AM +0100, Miguel Ojeda wrote:
> On Thu, Mar 19, 2026 at 1:17 PM Gary Guo <gary@kernel.org> wrote:
> >
> >  rust/kernel/net/phy/reg.rs           |  8 +++++---
> 
> Tomonori: are you OK with these changes?
> 
> >  rust/kernel/num/bounded.rs           |  2 +-
> 
> Alexandre: are you OK with these changes?
> 
> >  rust/kernel/sync/atomic/internal.rs  |  9 ++++++---
> >  rust/kernel/sync/atomic/predefine.rs |  2 +-
> >  rust/kernel/sync/locked_by.rs        |  2 +-
> >  rust/kernel/sync/refcount.rs         |  8 +++++---
> 
> Boqun: are you OK with these changes?
> 

Acked-by: Boqun Feng <boqun@kernel.org>

Regards,
Boqun

> >  rust/kernel/xarray.rs                | 10 ++++++++--
> 
> Tamir, Andreas: are you OK with these changes?
> 
> > -    transmute::{AsBytes, FromBytes},
> > +    transmute::{AsBytes, FromBytes}, //
> 
> Nit: We should take the chance to expand this.
> 
> Thanks all!
> 
> Cheers,
> Miguel
