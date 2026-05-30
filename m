Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E07ACD6E49
	for <dri-devel@archiver.kernel.org>; Sat, 30 May 2026 14:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C06E411285D;
	Sat, 30 May 2026 14:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RyTrtnhj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3573D11285D
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 14:08:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D44994411F;
 Sat, 30 May 2026 14:08:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BCE1F00893;
 Sat, 30 May 2026 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780150124;
 bh=9h3omsab3wD/YbJIteGGZlazo155REDIL3udFpbQEu4=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=RyTrtnhjoXqfk12tW+B26C0j7dyZxT24tdh7vHcLGFGPR8j4MRvPrEJk3MoJ5OwhE
 Ms/N6bKrTZKrjm+flKjpjDdjOKkdp/aFVAx0oaLvkwAPIuxz4L4odMYr2SWI22rrOQ
 /2er9ydLD2hQKwuAs2uSOCgdmccUG7wonj4xgP3N4xe5QZEGf4L4AGf1OQgrF/qi/k
 N8fwwFbqZDWGpYNcNbUWAOs1New611dojdb1HGAEGoUwE0jfP5DZdorcgtYH3qURbP
 lGqrf/L8503gPHNxSk73ilF7aUAKpnWNWJS3AnT2gFFrd9+jJJYOS4M5F1L6nL4slB
 ZxpB27juk2mVA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 30 May 2026 16:08:38 +0200
Message-Id: <DIW2JUUL6A6J.96VI4IQN6HYU@kernel.org>
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
In-Reply-To: <888dc39c52bb6ddac1a1eed7876c4573bdbef002.camel@posteo.de>
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

On Sat May 30, 2026 at 4:00 PM CEST, Markus Probst wrote:
> On Sat, 2026-05-30 at 15:53 +0200, Markus Probst wrote:
>> On Sat, 2026-05-30 at 15:37 +0200, Markus Probst wrote:
>> > If I think about it, I can't even close it inside remove_callback afte=
r
>> > `T::unbind`. With the driver lifetimes, the driver could store the
>> > `serdev::Device<Bound>` pointer in its DriverData and could still make
>> > calls to the device.
>> >=20
>> > Any suggestions?

Now that there is no public drvdata() accessor anymore, all bus device priv=
ate
data accesses go through the bus abstraction.

So, you could go back to your original approach and wrap the state in a bus
specific bus device private data wrapper type, which would also get you rid=
 of
the rust_private_data pointer you add to struct serdev_device.
