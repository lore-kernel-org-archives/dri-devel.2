Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B4C4CDB475
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5139E10E314;
	Mon, 22 Jun 2026 21:03:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k4wio2Jh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC61B10E314
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 21:03:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 54CCB440DD;
 Mon, 22 Jun 2026 21:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 067231F000E9;
 Mon, 22 Jun 2026 21:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782162184;
 bh=d6lKqpalFTpc0qx48Y3a+XrmMGn1yQwsZp9Dj+auQHc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=k4wio2Jhdpjb74Ar8WeFUpruVWMmqR3pAhH6RCtnBruIoMFRjDZHcysDRykC+1QFM
 vLCmbIAFn2859e7DU/kJgp7J49eXDL5bqSnunkoNCWszcWa2LLi7OsYfFEWbmaMOXw
 TUCXMR+Rd4bKeE1x9c2a735uPy/zG7O45H250F8SijeFge1qdpsq0Axng8YwplHuJR
 d9FMpibn4JTWJNXKJGJuIujhRUjT2ge+NCN/Un5/WL8lJJH0KjrCXYdqkS1afRZRdB
 nL0LQRe08UDlfsWTOA8Rqy1pG83fYHn9SXZX/J88lOqej/uBmhi7k9YL7fuuRk2P/h
 q8yAeaM088OWw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 23:02:59 +0200
Message-Id: <DJFVRMR67B0W.2AJBHU1PWDPFT@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: parse structs via zerocopy
Cc: "Alistair Popple" <apopple@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Simona Vetter" <simona@ffwll.ch>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Tamir Duberstein" <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>
To: =?utf-8?q?Nicol=C3=A1s_Antinori?= <nico.antinori.7@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260621143647.264770-1-nico.antinori.7@gmail.com>
 <ajjj1yyMcrCA8H19@nvdebian.thelocal> <DJFUZJYZHOT1.M74T83PJE8GM@gmail.com>
In-Reply-To: <DJFUZJYZHOT1.M74T83PJE8GM@gmail.com>
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

On Mon Jun 22, 2026 at 10:26 PM CEST, Nicol=C3=A1s Antinori wrote:
> I did my work on rust-next [1] because drm-rust-next does not have the
> zerocopy crate present yet [2]. linux-next contains both zerocopy [3]=20
> and the new users of transmute::FromBytes if I am not mistaken (BitToken,
> PciRomHeader, and PmuLookupTableEntry), so I can make the changes there.

The drm-rust tree is a bit special, as it remains open for contributions ev=
en
after it has been tagged for inclusion into Linus's (including throughout t=
he
merge window). However, all changes staged in drm-rust-next are not going i=
nto
linux-next until -rc1 is released.

IOW, until -rc1 is released this may or may not resolve all conflicts with
drm-rust-next. Once -rc1 is released, it is backmerged into drm-rust-next a=
nd
drm-rust-next is picked up by linux-next again.

Usually all of this remains rather transparent to contributors, but you hit=
 the
case of using a new feature introduced through another tree before drm-rust=
-next
caught up with Linus's tree (which will happen next Sunday).

Before drm-rust-next caught up, this patch can't be applied anyways, so all
good.

> I am fairly new to kernel development, I apologize for the mix-up.

No worries, you did nothing wrong; thanks for the contribution!

- Danilo
