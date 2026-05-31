Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B431FCD6E57
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 21:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941E8112C63;
	Sun, 31 May 2026 21:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gezCKlVM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF61E112C4C
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 21:49:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 08E71601FE;
 Sun, 31 May 2026 21:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2211F00893;
 Sun, 31 May 2026 21:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780264146;
 bh=L+ffRUF60vNQKYusqHpysiqlE6F10p7SF3tPVvi3AmA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=gezCKlVMpK/cNhif0323MPZ5yTHiTdOBBH7LLBsRzD+yhKZAmNe67+tH2KRprtphm
 +3SbrLyMWbH//guqNJpELaJpYEN+1gbFiuMVselAJ8RYh+grES/nfyDWiJIf5RhiP+
 31IIG9YuVzY+bkicD3y2Oep7XrqP0l2gaORBB1HPsYyxYl/KnSgrlsqDfJOBev/Dra
 1/pANUFgjwYpNIHbkGocM63nvQuYdOLU60hnDmPZlfeQ20qlbLOoTfd7E5zIbjLl5Q
 mQ2YTpzeWOOrIER5JTf0bcXLcrTDUTTpp4YDBWy/WYQQ77O8mtl2fta7Wd9v9Uhm4u
 2ZRBk14QW5GjQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 May 2026 23:49:00 +0200
Message-Id: <DIX6YVWRDL67.3TXDMTAMASCVZ@kernel.org>
Subject: Re: [PATCH v11 1/3] rust: add basic serial device bus abstractions
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
References: <20260531-rust_serdev-v11-0-dee8e0d830f1@posteo.de>
 <20260531-rust_serdev-v11-1-dee8e0d830f1@posteo.de>
 <DIWEXUCNLURG.136XXDBHSBNVR@kernel.org>
 <12fa6237168ecf6dc65ebf46118beeb5c51f3d1c.camel@posteo.de>
In-Reply-To: <12fa6237168ecf6dc65ebf46118beeb5c51f3d1c.camel@posteo.de>
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

On Sun May 31, 2026 at 9:42 PM CEST, Markus Probst wrote:
> I just noticed, is it even possible to use SRCU here? Currently the mutex=
 not
> only ensures that no drvdata access happens after drvdata drop, but also =
that
> the receive_buf waits for the probe to complete, as the drvdata hasn't be=
en
> initialized yet.

Yeah, if you drop the completion, you need the mutex.

(In case it wasn't discussed in previous versions already, there is also th=
e
option to just attach separate private data to the receive callback, which =
would
avoid this synchonization problem in the first place.

You could have serdev::Device<Core>::open(), which takes its own private da=
ta
and a corresponding close(), this way you'd allow drivers to control whethe=
r
they want the serial line "open" or not. You just need to make sure it is c=
losed
eventually.)

That said, I don't know what turns out to be the better approach. And maybe=
 it
simply isn't something this initial series has to tackle? I think your driv=
er
does not implement the receive callback?
