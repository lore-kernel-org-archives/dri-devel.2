Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5959AF34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE41710E47C;
	Mon, 13 Apr 2026 14:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S5laxPVh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC49410E47C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:00:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 247C661334;
 Mon, 13 Apr 2026 14:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F596C2BCAF;
 Mon, 13 Apr 2026 14:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776088842;
 bh=4rCaIafwro2YsN6ASU9dy/vhqoGxHYk8QdM6FjlBmxw=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=S5laxPVhdN4l6MX8ot6jaZWg6k4wOjY/dLUKJ3WpW7J++kxOqpvbPk/+W24prV3by
 O97r+xPdP8hvteaPAOd0RQ7IegBQjUDDSgDj23K1PeG9JOHGDErwHZtwMxjWSeLrgA
 drnic58EhoRE4G5jhR6lazernthhJVOcGf9p4SoYUY+ygs37zMI2Hh3IMhlmQ0xQS5
 DhfvcN21jbPNTJdP3irHNc5BU5dobaWeXY2j/yMtUnjYqLM9lDGOtBqMq7lFHfEGJt
 30kOGE0cLgjljSXN6MD/wJ/OCUISOAeRe1KqwT3xQ2UafSnZjACr3l043q7CInim3e
 82U+DD8Rv9Hrw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 16:00:38 +0200
Message-Id: <DHS2Y4JX150L.8Z6OKIIHSYI5@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: fb: make sure to unregister SysmemFlush
 on boot failure
Cc: "Gary Guo" <gary@garyguo.net>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Joel
 Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260409-fix-systemflush-v1-1-a1d6c968f17c@nvidia.com>
 <DHPLKB40FM08.1L3H2S589WUW@garyguo.net>
 <DHRZ01R16ZXR.3T0D56PREGR18@kernel.org>
 <DHS2DLJW7ISY.1QW0Y0WC1NSZJ@nvidia.com>
In-Reply-To: <DHS2DLJW7ISY.1QW0Y0WC1NSZJ@nvidia.com>
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

On Mon Apr 13, 2026 at 3:33 PM CEST, Eliot Courtney wrote:
> Yeah, I agree that this patch is the wrong long term solution. If we
> don't have the infra for the proper way to do it soon, it might be worth
> taking it anyway since it adds minimal complexity and fixes a real
> issue.

Yeah, let's see how it goes the next weeks.

> I had a brief look into the Devres chain stuff that exists on the C side
> and it looks like it doesn't provide any actual guarantees about the
> lifetime (it seems possible to delete from the middle of the chain, so
> descendants can't assume ancestors exist in general, AFAICT), so the
> the translation of that into lifetimes in rust might get interesting

There is no such API that does what we want here on the C side. In C it sim=
ply
is the responsibility of drivers to take care of this. So, I'm not sure wha=
t you
are referring to.

In case you are talking about devres groups, they have a different purpose.=
 They
are used in cases where you e.g. have some middle layer API between drivers=
 and
a subsystem, so the middle layer can acquire resources on the driver's beha=
lf
and manage them. If the middle layer fails on optional features, it can sim=
ply
release the group of resources acquired for the purpose of the optional fea=
ture.

I.e. devres groups are simply markers for a certain range within the list o=
f
devres nodes of a specific device.
