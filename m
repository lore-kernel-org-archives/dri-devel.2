Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7C3C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 22:24:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC0910E26C;
	Mon, 10 Aug 2026 22:24:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iM57X0TP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A6C110E26C
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 22:24:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F0E436001D;
 Mon, 10 Aug 2026 22:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D5821F000E9;
 Mon, 10 Aug 2026 22:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786400687;
 bh=FI+QEvHaJfs+rB3erfK08nuwK2MZ2xUllGkJ76apD/s=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=iM57X0TPSPGu5vzBZK8rTJXuOLnPi16/A99NKabmzXHoCOKKN8hVjJH8MjIFQGteL
 4gxhW9FeYNWvYzMv2QokA5XCoxTPlSx6rVZ0xwBrIDk3WEDUqPBcDnADOlN2v54lmR
 7kqoy2o2TNdEsQdf21FmHoxCh0j1SlSA31sgx/xKn2F7L9vqbUdo9JdDoRShM3rqOE
 EbIpz0nVjZNX7KWE0QNWKnIwMF/Yj1yIqwi4VdJicoDdSxyTyrcVcLEdqIj67bMXaY
 m55uw0LxsUUD63+PxQ8WOHO1lcgxLfot/NYUMG1Xh4/EZ9M6em2DlOkgRyObJ6Z7zv
 czkcMzRLGa6rw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 00:24:40 +0200
Message-Id: <DKLM6VGASU6I.11XJUXXC41OIQ@kernel.org>
Subject: Re: [PATCH v2 01/12] rust: num: use const_assert! in Bounded
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan
 Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
In-Reply-To: <20260810-pramin-split-v2-1-65a00b3c7309@nvidia.com>
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

On Mon Aug 10, 2026 at 3:55 PM CEST, Eliot Courtney wrote:
> Convert the const-block asserts in bounded.rs to const_assert!,
> matching the rest of the file.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
