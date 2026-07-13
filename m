Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C05FC44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6F3110EB02;
	Mon, 13 Jul 2026 20:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ab/KX7/3";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E8E10EB02
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 20:55:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C4E060103;
 Mon, 13 Jul 2026 20:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5AD1F000E9;
 Mon, 13 Jul 2026 20:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783976120;
 bh=2akodtkTAZQfy7wlbDYrvvBZDGFGBcbpeL4Zo3N4Czg=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=ab/KX7/3kj6eSu9yd0+Yr4p9aGwZK9wqIFjFfXu6gNwAfT2fSzGJtJ/g+jre9JOe7
 GZ2bpi8HIWxeOehtyEa3KOs9uXTYg06NJpWP/FLuS+fGBKqWAEw13KC6WAlfXui9Ad
 azkONarL8pI6YC7sB6X8GN8m+0DjQ36cGAwSz2wKV53iZp4hFU5JHlNWb7EdRiajOS
 CnD9nfFerpJP3iRgDCQxwaPyepyCOzFPwpr6mWpYM8slSscTJoNHSPgec5MAq1wz7e
 m3UZ0k3YMRVMrwNN1xkbkPhU9K0vufjHt2j3+zQA2/F+umqJi3aMw4Akxs7e1O04pg
 EqWlwgQabQlfw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 22:55:14 +0200
Message-Id: <DJXQR57LG8IY.2FG6YY420VFYG@kernel.org>
Subject: Re: [PATCH] rust: device: make lifetime on `Core` and
 `CoreInternal` invariant
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
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
 <DJXQ32PBP5Z8.2ADOOIWKYOLP5@garyguo.net>
In-Reply-To: <DJXQ32PBP5Z8.2ADOOIWKYOLP5@garyguo.net>
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

On Mon Jul 13, 2026 at 10:23 PM CEST, Gary Guo wrote:
> Actually, a more proper fix is to make `Device` invariant over their
> context. It would require touching all `Device`, though.
>
> Danilo, let me know if you'd prefer that approach instead.

The bigger change is not a concern, but requiring every bus device implemen=
tor
to consider this is a bit of a concern. If we can enforce it in the driver =
core
code I'd prefer that.
