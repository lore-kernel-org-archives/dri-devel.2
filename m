Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7A5C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 08:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67F4F10E47A;
	Thu, 17 Sep 2026 08:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lPwotUdR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B14B710E47A
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 08:57:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFF5C60210;
 Thu, 17 Sep 2026 08:57:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767731F000FF;
 Thu, 17 Sep 2026 08:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789635433;
 bh=185K7E+yDGpdqm72K1yyJEdvhz2PLVSX2+A8CdqzS6I=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=lPwotUdRj/KhDUwr6PxOoMJXRA3U3CJGfvY955sz8mLgUGfdhysIeIfTAN+uLZSXb
 luvwBhp6oqA53N6tbBpBviSzZWlcMa7CzlKasGyxkvRTfrYbYT4o/6mYEYlyxZf4r4
 H5nI9/akUADQ3NHayuTtYJw3/zOMLYR+mYC2pqfeGpkHZL4M5VbwtUEuY1G48+cGz9
 HUr3w5hczsSFKBMQKX1IebxiASM0Mr0+xIfbBOfZsFY5UsIpTruW2aZBK8xDUezhTG
 9V7nBw9s2Wq5fvtqtQ2JZrpepVHc7NAUgXkvEWum7ZzFZQSUHT41PJSy4n02ZHuk3y
 qtlwfNC3ew7mw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 10:57:08 +0200
Message-Id: <DLHGT9SR5T1E.2Z3D1088WA64H@kernel.org>
Subject: Re: [PATCH v4 2/2] gpu: nova-core: use cv! for constant casts
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260917-cv-v4-0-547ef5727451@nvidia.com>
 <20260917-cv-v4-2-547ef5727451@nvidia.com>
In-Reply-To: <20260917-cv-v4-2-547ef5727451@nvidia.com>
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

On Thu Sep 17, 2026 at 10:34 AM CEST, Eliot Courtney wrote:
> The new `cv!` macro allows safe casting of constant expressions in a
> const context. Update code in nova-core to use it.
>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
