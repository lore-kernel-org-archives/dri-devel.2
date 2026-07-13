Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589A5C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 21:09:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0EEF10E66A;
	Mon, 13 Jul 2026 21:09:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cvxblqpC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F75B10E66A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 21:09:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C139460103;
 Mon, 13 Jul 2026 21:09:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 298EB1F000E9;
 Mon, 13 Jul 2026 21:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783976959;
 bh=c52mMQX9J4H2f3aHwpRg0V7ywMz0NgEjSePFhkqtKgE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=cvxblqpCo7wlq6C+75Jh+74Gxa4itrJOCfg8XZ9Xl42F8Rkh7OWyIhhvTCa+2MeEX
 ud2QiVrME/WA7tohwMPrx8jDmCln9sOg7OUWIJY2cevOdnytKSYia0tK0lipbivKnl
 F9U624dFZ2blq8qsNpyy4S4ohk9wpzhrzwvo75MzFKVMk04emAqxrJTyij4GmGJvdZ
 sRw1eovpvPmIT4T/E3q6so/lc7Gyb88K1NRzRrqX37uviz2cldNaTU/Lw0vNHlxhOa
 q8fxBlVy7Hs7KaNJwM1dZVCUy9cCU7uHuu6hvfosnGHyl5jE//443a0/pqINZIzP7M
 JduRHY8Jo55fQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 23:09:13 +0200
Message-Id: <DJXR1UJSFVGA.1O6GR87RE8AIM@kernel.org>
Subject: Re: [PATCH] rust: device: make lifetime on `Core` and
 `CoreInternal` invariant
Cc: "Gary Guo" <gary@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Eliot Courtney" <ecourtney@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260713201455.640151-1-gary@kernel.org>
 <DJXQ72BQ9CJY.3U4YFYKGYEEKU@kernel.org>
 <DJXQX3NU90PQ.2WB4WD69F3H81@garyguo.net>
In-Reply-To: <DJXQX3NU90PQ.2WB4WD69F3H81@garyguo.net>
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

On Mon Jul 13, 2026 at 11:03 PM CEST, Gary Guo wrote:
> but `use` is stable in 1.82+ so we can just use it instead.

Ah, right. I was confusing this with the situation before the version bump =
up
from 1.78.
