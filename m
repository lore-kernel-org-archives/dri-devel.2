Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC45C43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27C9B10E068;
	Mon, 29 Jun 2026 08:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bmKZe48j";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F07E010E068
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 08:46:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9B824435C9;
 Mon, 29 Jun 2026 08:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D771F00A3A;
 Mon, 29 Jun 2026 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782722781;
 bh=FftD6cxtaLafMa5Abl1ZmNF0gUSqDocLlPF/xc6INGg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=bmKZe48jTpzSYweb3znBgB9zJA0plSnh6pv6hWFbEM6xIEUkWpqQN3FvxltFX7QpI
 dBSAT4LeFgAB8iiNyyl39hvw10sMbXeNHfjwSM9RLgh6xm/KbRJ/sHA8Ee4uoJwmHl
 DdKP9Koswd09L81TeRzkj7wpgYBYlRae75a1bwU2clmA8W0GPbaBFrRtaop/WIVMbh
 zYPICgbE2fK7f3uop4FDLlleL4EoSNYzXCg4NbK1YzQcI28/wEOBvB+qF2v1+y3fUp
 asI7QrzqaHBD7mz41gcvbA1NCqCca7psPgTR5C5D5Mp1pRbbW24fnYyaFy0t4bEYpK
 7RM1+jvDTsGng==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 10:46:16 +0200
Message-Id: <DJLEHDNJCUD0.38PFZ5773D6BX@kernel.org>
Subject: Re: [PATCH 0/1] nova-core: Convert bindings to use zerocopy
Cc: "SeungJong Ha" <engineer.jjhama@gmail.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>,
 =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>, "David
 Airlie" <airlied@gmail.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 "Simona Vetter" <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Tamir Duberstein"
 <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Pedro Yudi Honda"
 <niyudi.honda@usp.br>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.de>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260629025220.1935622-1-apopple@nvidia.com>
 <DJLAUOEDW6HT.39URSU30Z0HT9@gmail.com>
 <DJLCF3LR0KMN.1TMKMZEZWKN8O@nvidia.com>
In-Reply-To: <DJLCF3LR0KMN.1TMKMZEZWKN8O@nvidia.com>
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

On Mon Jun 29, 2026 at 9:09 AM CEST, Alexandre Courbot wrote:
> Since there is no particular urgency to switch from transmute to
> zerocopy, I think it makes sense to merge things in an order that limits
> churn as much as possible.
>
> This means the conversion should probably be done bottom-to-top,
> starting with the bindings, then the types that embed them. For the
> bindings, `#[derive(zerocopy_derive::most_traits)]` should be landing
> soon [1] and I would like us to understand first whether that is
> something we want to use with the bindings; if so, let's wait for it to
> be available (unless there is a good reason to convert quickly) as each
> change to `bindings.rs` is almost 200 LoCs.

Doing another subsequent conversion to most_traits seems trivial. The upsid=
e
would be that we could remove the transmute::* types from nova entirely, wh=
ich
also allows us to switch the DMA code to zerocopy.

No need to go for it with might and main, but a minor inconvinience like th=
e
above might be worth taking, as switching to zerocopy in core infrastructur=
e can
simplify backports.
