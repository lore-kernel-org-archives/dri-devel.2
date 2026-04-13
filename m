Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80D6EBFD38
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DEA710E0E8;
	Mon, 13 Apr 2026 10:55:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KseREcQp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7705810E0E8
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 10:55:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 161B641ACF;
 Mon, 13 Apr 2026 10:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F35BC116C6;
 Mon, 13 Apr 2026 10:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776077708;
 bh=mebjK2cAZrUdQlTQQgV1HIxyCDUGl4Xmv1vG2uJF1K4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=KseREcQpkmqkqhkMpCnL31tO460Y0QOb8s2k5w1zFFWtKkUXjLOFLi0FIK7tdC7w3
 WBJCA0uR3GKWCaZuQiEQxGdp4ERDeB29b3a9cQNaBBG/4R+PWqOea1hGsTFmMbZo+W
 iAhuwJQdYkaBG9M53Sohu5Vi1egAWWgAum5hnT8ppzAJdtsedyqb+mwpJpOomdgv9y
 KURYonPrFAXdDjkYevJnc2JThOsjP02XaX4HFQgc9Zw43jcrwO8sDjT5PAtmoeNgxp
 VjbPRQorhFEZV6jewHmZ9240DKM9NcCVr4an762CQ7LqJsu4VIXNeVuT4WAREYGbA8
 Nw2KypmLfn/kw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 12:55:04 +0200
Message-Id: <DHRZ01R16ZXR.3T0D56PREGR18@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: fb: make sure to unregister SysmemFlush
 on boot failure
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com>
 <DHPLKB40FM08.1L3H2S589WUW@garyguo.net>
In-Reply-To: <DHPLKB40FM08.1L3H2S589WUW@garyguo.net>
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

On Fri Apr 10, 2026 at 5:57 PM CEST, Gary Guo wrote:
>> +impl Drop for SysmemFlush {
>> +    fn drop(&mut self) {
>> +        let _ =3D self.bar.try_access_with(|bar| self.unregister(bar));
>
> I feel that this is the wrong solution to the problem.

Yeah, it is pretty fragile as it relies on outer implementation details, su=
ch as
the fact that SysmemFlush is part of the device private data and hence
try_access_with() will fail when not dropped in an unwind path.

> The thing we want is to *ensure* that `SysmemFlush` Drop is called with d=
evice
> still being bound.
>
> It's not yet fully clear to me how we'd want to guarantee that, but one A=
PI that
> might make sense is to create a DevRes API that allows you to reference a=
n
> existing `DevRes` and have driver-core making sure that the tear down hap=
pens in
> reverse order. So inside the `Drop` the `bar` can still be unconditionall=
y
> access.

Yes, I have something like this on my list of things I want to look into fo=
r
while (my list entry calls it DevresChain).

I want to leverage the internal reference count of Devres for this, which i=
s not
exactly straight forward, but should be possible.

I will prioritize this and have a look.

Thanks,
Danilo
