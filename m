Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E893FC5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 11:18:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2700F10E35B;
	Mon, 17 Aug 2026 11:18:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XTLG2zvl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043BA10E35B;
 Mon, 17 Aug 2026 11:18:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 006D8600AE;
 Mon, 17 Aug 2026 11:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7687B1F000E9;
 Mon, 17 Aug 2026 11:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786965492;
 bh=JxCvdKqLq/biQ6tW9xgNaXvM25N1Kw2BHbFW0+Jedsc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=XTLG2zvlJ/O2/EKlxpZEMn8yOfWKMI7ghhdPKLkrXESGqo4xn38E1zDP8oGbhbWbP
 k2FvvnSpIixSijMuICenyn6/JdOW9Wi4RG6JSjxONY3OwmI1bY7B+RotWWMTb+moYk
 pCPUnW2JG/C1gYeS3lS8xVbligDL0BKeeVp5aXPO/L1oXn2v0Q3PFPD+lsHlDIT1jW
 HOdWjKeiGM7J14WqKN+mufBhLLG7m+3IuiGqHFPzahz7pfAXJxJ/HErNGEQMfohnML
 Ewdw1bjmoHhqRMXnPWiBB+L/JcY1tNOEGP2BzQprcZnX3KN0Maw6iQDFGetxwrG1Dy
 6U+R3j42le40w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Aug 2026 13:18:05 +0200
Message-Id: <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
Cc: "Eliot Courtney" <ecourtney@nvidia.com>, "Yury Norov"
 <ynorov@nvidia.com>, "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com> <anzxKO0X1OrNRD32@yury>
 <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com> <an4NvQBt3389jP6E@yury>
 <DKO414SNC0B2.248FUBGJGSPLU@kernel.org> <an4xDp29VX8Am0uR@yury>
 <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
In-Reply-To: <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
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

On Mon Aug 17, 2026 at 12:54 PM CEST, Gary Guo wrote:
> IMO we can just support zero-sized allocation by always succeeding, simil=
ar to
> how ZST allocation is handled in memory allocation.

Probably, but in contrast to ZST allocations it wouldn't be very useful, so=
 we'd
silently succeed on something that never was a reasonable argument in the f=
irst
palce.
