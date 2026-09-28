Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD4ACA5FA3
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 18:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB64B10E09B;
	Mon, 28 Sep 2026 18:22:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jzRocgp9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2125C10E09B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 18:22:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3F984361D;
 Mon, 28 Sep 2026 18:22:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04541F000FF;
 Mon, 28 Sep 2026 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790619763;
 bh=K1cLWac03IM4KLKAmCbBaNPBWoO0bBv/YDS2Dcc186U=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=jzRocgp9APFbn7PWm/lVftNBWm3nQuRe4DUsY1sk9cmMIiwjTgRQz3nzamHXngS9I
 D5vM+QVrBcWiDqiAKnqzhNEGR+VN4zBbJZRS+3RhDWZgRZHyyaOjXYKtHZ8UYogYlI
 xnP2x0peEeKDhrzkQMemQW6PZjv0TfneoPHS8XXrk+10ztob7MmG8VcIFgBndIwMmI
 X6rxeLZb1m7SDtl/JNvNQ2qRBw8oM1zCVVLFrw8dfMra73wGuHSIpl0DSNbBOHtJ2g
 gVsGur5H9GW6bmWAm67uLZpkNuy8XV/GVUc41PQrczztiKYMoML/svpOqrDftsFfIa
 MZbh+EkmNLKCw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 20:22:39 +0200
Message-Id: <DLR5Q993RA06.3UA51L951IFX0@kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Matteo Kloiber"
 <kernel@matt3o12.de>, "Robin Murphy" <robin.murphy@arm.com>,
 <aliceryhl@google.com>, <ojeda@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <a.hindborg@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
 <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
 <DLF3BLOLU8HS.1AXNNXWVQUFNU@kernel.org>
 <DLHH0K25NLX5.616R4D860TXU@nvidia.com>
 <20260927224446.1053037-1-kernel@matt3o12.de>
 <DLR1JCUWS824.35QJU45D2W9ZE@nvidia.com>
 <DLR4TIXBL0K0.3GNRPD2HU6S4T@garyguo.net>
In-Reply-To: <DLR4TIXBL0K0.3GNRPD2HU6S4T@garyguo.net>
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

On Mon Sep 28, 2026 at 7:39 PM CEST, Gary Guo wrote:
> I was quite skeptical whether the complication of adding the dma setup to=
ken is
> worth the effort, but the capacity struct sounds like a very nice design =
as it's
> infinitely extensible. I can foresee that we might want to eventually get=
 rid of
> the special `Core` typestate and just replace everything with setup
> capabilities.

I had a similar thought (which is one of the reasons I proposed it), but I =
don't
think we can replace the Core type state entirely.

There's more than just one bus callback that holds the Core type state, so =
I
think the bus setup token is rather the (much) better version of a Probe ty=
pe
state.
