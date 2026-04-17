Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 890DFF4368A
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:00:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB5CD10E0B5;
	Fri, 17 Apr 2026 12:00:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J7Xiw4JE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B011510E0B5
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:00:42 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B5A6560128;
 Fri, 17 Apr 2026 12:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB39AC19425;
 Fri, 17 Apr 2026 12:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776427241;
 bh=tZPmJ+F0Q+5+qbyQORfl3ivntWS2W2QdCwZg4NBs7Uc=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
 b=J7Xiw4JEQZQqZ5x6r4n41db5MYpX8tURzAJLjwAY7HRmmOjw1Z5ua5wfZE+VevU3t
 PaOwqX+p2JSGnTFdWT2fIxbZpu3IIQy/LTQkB7DU2St0p8ussbmz3W1Tiv8JrP0MW3
 wkPruLs49mi36bHyqU3f0AtYpTtlsLQeRFOZ4v+A2C+Cm/6H0veYZg0x4n814hDyWH
 eh1jqil+SqaleOBQgU6VR/gwOCXSg1IbTvMPYpFNUFUomdLpwjX/sBc2+J2Lq4TA91
 gtPAuQXxNDESSrowarkT6TYYdITFIn0Fnh9sFbT3VPDd5A1fMbq/2/USiIc4s4vgxh
 qZNm2tKQ/NMGg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 14:00:34 +0200
Message-Id: <DHVEWDBHYKQF.XBXZ704CMXCF@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Yury
 Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "Mark Brown"
 <broonie@kernel.org>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
 <CANiq72k0FXcekxs=E+xLe3=wyu+KHr4yM0wLj1VgtgTUb_K4MQ@mail.gmail.com>
In-Reply-To: <CANiq72k0FXcekxs=E+xLe3=wyu+KHr4yM0wLj1VgtgTUb_K4MQ@mail.gmail.com>
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

On Fri Apr 17, 2026 at 7:55 AM CEST, Miguel Ojeda wrote:
> I think that for branches going into linux-next, in general, new
> material is not meant to be added until the merge window closes, e.g.
> from last -next:
>
>     The merge window is open, so please to not addd any v7.1 material
>     to your linux-next included branches until after the merge window clo=
ses.
>
> Some things do target future merge windows (e.g. Rust itself was such
> a case for a long time), so it may be fine when adding it before the
> merge window opens, but I think the idea is mostly to avoid too much
> movement during the merge window to avoid interfering with other
> maintainers finishing their trees for Linus etc.
>
> But not sure how flexible this is -- Cc'ing Mark.

This all builds on the assumption that we don't have a process in place tha=
t
covers this.

However, all major DRM trees run the above process and handle linux-next in=
 the
following way.

  * -next
        Features; open at all times.

  * -next-fixes
        Fixes for features in -next that have been included before -rc6; ac=
tive
        between -rc6 and the next -rc1.

  * -fixes
        Fixes targeting the current -rc cycle.

These are mapped to two additional branches that linux-next pulls from:

  * for-linux-next
        Normally points to -next. Between -rc6 and -rc1 it switches to
        -next-fixes instead.

  * for-linux-next-fixes
        Always points to -fixes.

The same thing is going to happen for drm-rust tree, once everything is set=
 up.

- Danilo
