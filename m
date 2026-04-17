Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E945EF43698
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:30:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3FE10E2AF;
	Fri, 17 Apr 2026 12:30:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TYl2RQtE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CD9210E2AF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 12:30:37 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id DFC4444217;
 Fri, 17 Apr 2026 12:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2057DC19425;
 Fri, 17 Apr 2026 12:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776429036;
 bh=nMyMR9xnTunoJmhz+upy+A+az7Geu7EY/3hPQmlD6ac=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=TYl2RQtEgCvUKENjL9SrlglFDcP+SCpLywVFyQvw0VosJWCNGCItHYJ+wisE0CMyx
 zr/zim8UIwT6GTnfIOKMlUBKOIUg+IJtGwlD/fxG/Swrmv5ydkRSSGjOI3mRyowgUv
 cBwBckOsy7FI1tJrXHtQWdr3bTO0MAiFjJNth6PRy1ZAnl0lyImn1OiJXxA5JULw7N
 jBKB1gt5dfYcSa+CcC4QZxXGJI/3eNMUPqgonvd+lJLmkDRUnv/X+6bknaf2YkhNf1
 ukUoI8Hsp4dr8OkdiURiWwRSbKSLkNp4I+hbbNA7H0sJ4ODXMKZWxPAuoST8iTT0Ae
 VN6Db2sQUvbWQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 14:30:30 +0200
Message-Id: <DHVFJAHGWX8X.2DXC4BU5KZLG8@kernel.org>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
Cc: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alexandre Courbot" <acourbot@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Mark Brown" <broonie@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
 <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
 <CANiq72k0FXcekxs=E+xLe3=wyu+KHr4yM0wLj1VgtgTUb_K4MQ@mail.gmail.com>
 <5a0b7de0-3bfe-4e71-9e0e-3d9396e1d9d5@sirena.org.uk>
In-Reply-To: <5a0b7de0-3bfe-4e71-9e0e-3d9396e1d9d5@sirena.org.uk>
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

On Fri Apr 17, 2026 at 12:59 PM CEST, Mark Brown wrote:
> Of course, nothing stops you maintaining a branch which isn't in -next
> and is open all the time and that won't have any wider impact.

This is exactly what's going to happen, please see [1].

Thanks,
Danilo

[1] https://lore.kernel.org/lkml/DHVEWDBHYKQF.XBXZ704CMXCF@kernel.org/
