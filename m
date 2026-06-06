Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A18CD8C8E
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 11:23:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B059410E78C;
	Sat,  6 Jun 2026 11:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="chVxYjcD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FBE10E78C
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 11:23:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2D4BA43BA6;
 Sat,  6 Jun 2026 11:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B301F00893;
 Sat,  6 Jun 2026 11:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780744989;
 bh=RW5iDI1nw5+hsyNe8SDVvtSzDbtxr9FzhrWhpqGQpCI=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=chVxYjcD+H8dRnfy4Ion4alSdIl2BOAY9eaMuPzyuDQkyy1J80SdWT0ch9NJHTCpm
 gKLWqzCgl6yTSjmCu01XHOSgSBxLHl/HF/db6rWcNBZFzFRCT0IlpdiXiXNuNZi49W
 y90fW3Hg34vrtv6+3mg+aTiEhiI5sJBThntUB0x9EoBjckeeavulJH2YiZsGUQopbV
 arCDSjbOaKCxi6HlYY8erE6Nc/lPj86n4QFUYOXJ/WcpNNSWshJzMANCFzKZMPO1Mb
 5VnLE0qIhBljeLEDqPl8G3tL25vCnxFSkIafpYDI6s03Z0r9TtbyFw+c5TXG5c9G4D
 BU/uZmF51xFfw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Jun 2026 13:23:04 +0200
Message-Id: <DJ1XEW84UTAU.28B9WK4VR0QLP@kernel.org>
Subject: Re: [PATCH v2 3/7] rust: drm: Add RegistrationData to drm::Driver
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <boris.brezillon@collabora.com>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260603011711.2077361-1-dakr@kernel.org>
 <20260603011711.2077361-4-dakr@kernel.org> <aiC41_huOYhvacQD@um790>
 <DJ0BD0O60VAB.10S80F8N6MQPG@kernel.org> <aiINpEVaLW85LM5j@um790>
In-Reply-To: <aiINpEVaLW85LM5j@um790>
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

On Fri Jun 5, 2026 at 1:43 AM CEST, Deborah Brouwer wrote:
> On Thu, Jun 04, 2026 at 03:53:32PM +0200, Danilo Krummrich wrote:
>> On Thu Jun 4, 2026 at 1:29 AM CEST, Deborah Brouwer wrote:
>> > Hi Danilo, could we use separate data arguments in UnregisteredDevice
>> > vs in the Registration? Basically we want to use the UnregisteredDevic=
e
>> > to initialize and boot the firmware which we then store as registratio=
n
>> > data.
>> >
>> > Could you have a look at this patch, it applies on top of this series:
>> > https://lore.kernel.org/rust-for-linux/20260603-use_tyr_reg_data-v1-1-=
97f64e951cf6@collabora.com/
>>=20
>> They already are separate -- UnregisteredDevice::new() takes T::Data and
>> Registration::new() takes the registration data independently. Your patc=
h
>> demonstrates this correctly.
>
> Ah, true the arguments are different, but the issue for Tyr is we need
> iomem to initialize and boot the firmware before we have a registered
> device.
>
> Could you replace your Tyr with the changes i'm proposing here:

I don't see any change in your patch that belongs into this one. What exact=
ly do
you have in mind?

Please note that this patch is about core infrastructure and should only to=
uch
drivers for the minimum of mechanic changes required. IOW, your follow-up p=
atch
already sits perfectly in this context.

> [PATCH v2] drm/tyr: move probe resources into registration data
> https://lore.kernel.org/rust-for-linux/20260604-use_tyr_reg_data-v2-1-f77=
a1ffcf08d@collabora.com/
