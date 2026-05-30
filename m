Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470CCCD5BD0
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 20:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9426010E40B;
	Sat, 30 May 2026 20:59:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jifiKmME";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A166B10E40B
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 20:59:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A36DE600CB;
 Sat, 30 May 2026 20:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B681F00893;
 Sat, 30 May 2026 20:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780174795;
 bh=I0XpV/UJgvdMUeyZPVzwXcTNw9GkbNU1eOxQB0PkzTI=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=jifiKmME7zfqB4ndc4TqFzgI+RvBKaEp8U5IqhXg5aMLiy2CbWdLlxm6zI+A/Y92T
 7w9Rn4Le26XDiSOEA7az5HG9E74L3NGVjem4JK4u4g1XkTSHLFCxsXrg9szIVqDen0
 ahvS5RkCtt9R6AlDcmKqf8zlBU1WUsB/SZJ/ZlRmTvvPyiYivgfL1ssHMsXyaw3sGx
 QbT0hehHG2ZVuk8CxHGB6ulgQSMuDT9G2C06vvwNXpzGJ+JfunOTJ6PAvKLB036v4y
 SkhQyhiQyyG+pDTISsRdhdYEAspZvkzOSihwAoeFfBdbwRzwoQlhxArEbECZv1X4WQ
 dHm1juONeM39g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 22:59:48 +0200
Message-Id: <DIWBAO4X3AAZ.I66NB6DQNQO3@kernel.org>
Subject: Re: [PATCH v8 3/5] rust: add basic serial device bus abstractions
Cc: "Markus Probst via B4 Relay"
 <devnull+markus.probst.posteo.de@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Kari Argillander"
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng" <boqun@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
To: "Markus Probst" <markus.probst@posteo.de>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260530-rust_serdev-v8-0-2a95f1da22a7@posteo.de>
 <20260530-rust_serdev-v8-3-2a95f1da22a7@posteo.de>
 <DIW1B4FUIXO7.28GSUA0CEA4EV@kernel.org>
 <4638946fc49a38797b716ea173c93327eb751479.camel@posteo.de>
 <ad98dfb1d8469022519d37364e8a068bed3b5687.camel@posteo.de>
 <888dc39c52bb6ddac1a1eed7876c4573bdbef002.camel@posteo.de>
 <DIW2JUUL6A6J.96VI4IQN6HYU@kernel.org>
 <55eae11ea68f129508d0f7e30ac457ba919812b2.camel@posteo.de>
 <DIW34DX6BSUS.ANXBOP9687B0@kernel.org>
 <25dc9a4bbde0b542abf608be1b3305f1421a4502.camel@posteo.de>
 <DIW587AGXYCS.39MR1B4TVSO9@kernel.org>
 <01e20401845ce5eab5731698ca8a0f8f44ed3eb9.camel@posteo.de>
 <DIW9Q5GVC0H2.2BEOWKL02AMWA@kernel.org>
 <aaf88d7fc2168c3ef893713b0643c4132bec1da3.camel@posteo.de>
In-Reply-To: <aaf88d7fc2168c3ef893713b0643c4132bec1da3.camel@posteo.de>
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

On Sat May 30, 2026 at 10:31 PM CEST, Markus Probst wrote:
> On Sat, 2026-05-30 at 21:45 +0200, Danilo Krummrich wrote:
>> On Sat May 30, 2026 at 8:55 PM CEST, Markus Probst wrote:
>> > pin-init doesn't have enum support yet, so at least in my driver devre=
s is
>> > still required for now.
>>=20
>> Hm...how is this related to having a registration type that takes a life=
time
>> rather than a registration type being wrapped in Devres?
> In order to register "optional" devices, the driver currently uses
> devres::register.
>
> I just released I could use KBox for this.

Ah, so you basically use devres::register() to avoid a pinned Option. Let's=
 not
absuse devres for this.

The class device registration should rather use a lifetime now that we got =
all
the infrastructure for this; the pinned Option problem can be tackled other=
wise.
