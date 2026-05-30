Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C59CD6E4A
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 11:55:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 536B810E272;
	Sat, 30 May 2026 11:55:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XCqCaQI3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A1410E272
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 11:55:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71418600B0;
 Sat, 30 May 2026 11:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D1A1F00893;
 Sat, 30 May 2026 11:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780142105;
 bh=jm8hdmAkEvJcbwS7hgydGF1qmrnzoDP4FHKn0i/2TXc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=XCqCaQI3wTaiEpjHV+goSY6qoZCDZ8DaWIgGBul+wGjAgZWvz1L2AvWDURbUbLHXL
 bOrBQqdGXVTtfC/wxJjKkhtbb9ecGvyvFErDQRz0kxTggLdFYwwi1WOLmu3ED+3cHd
 pu9PoeZwr/zJ8Ntt4tyEuaVJPISqI6sPubXdr1vPp0N8QYwCdpQ1Zv/IPpKuttT3U0
 1pU7LdDg9ePcx09dnPQFzY39KIPQ6ywI1Dk1grBW6IEv6DXLZ+WKdnEfqBi7SsN6os
 P/1rNqCr62Fm1MdM5XT+rvEnUtKHMSkYV5FFl6BbURT0ht23Eb592jDlQ+w+HS9pYE
 eWHTdoMkOr4Fg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 13:54:58 +0200
Message-Id: <DIVZPIJYZ244.26RVUD86YHX1N@kernel.org>
Subject: Re: [PATCH v8 1/5] rust: devres: return reference in
 `devres::register`
Cc: <markus.probst@posteo.de>, "Rob Herring" <robh@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri Slaby"
 <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng" <boqun@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Markus Probst via B4 Relay" <devnull+markus.probst.posteo.de@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
 <20260530-rust_serdev-v8-1-2a95f1da22a7@posteo.de>
In-Reply-To: <20260530-rust_serdev-v8-1-2a95f1da22a7@posteo.de>
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

On Sat May 30, 2026 at 3:13 AM CEST, Markus Probst via B4 Relay wrote:
> From: Markus Probst <markus.probst@posteo.de>
>
> Return the reference to the initialized data in the `devres::register`
> function.
>
> This is needed in a following commit (rust: add basic serial device bus
> abstractions).
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

For driver-core and DRM,

Acked-by: Danilo Krummrich <dakr@kernel.org>

This is useful in the context of the HRT work in general, should this serie=
s not
make it this cycle, please let me know, then I'm going to pick this through=
 the
driver-core tree.
