Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB93C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 09:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E323310EBE4;
	Tue, 30 Jun 2026 09:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hsRUnlnj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43B4610EBE4
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 09:48:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F096600BB;
 Tue, 30 Jun 2026 09:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45EB1F00A3D;
 Tue, 30 Jun 2026 09:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782812938;
 bh=Wz2QEdQjtR6RjwHJZO3VyjTyb70C1jKt+To9uiVZSCI=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=hsRUnlnjoHMtUp9PyFc2b/IDfatYNC9odnqc7yaijObG1pGLVULuRTK0j3QOFiiLm
 waWfzZcwM0KGplGdyZ9rcAztOtX7bmdk2c14hn+fF/5olYwd/E7LshddbZFUm7Nq23
 UIMa1pcSphoVqvBrwbZrXui0OwL0oPTIiPaa7S2TdJ4jCxcckGaRl67/QMAI//bWkw
 9RgD5uKmm2UOou0hTxpw5+M8F70Ng/hZmXSB73chY3NtbpzYK/KUpA/UJW9GTt6C9P
 nY0ACq5hgC4TCbOGFAizL7Y+G6NC77hHXWFXQYubsdrsCNE/lP+3/tsyYsotlDn7Tg
 YNkV1jBTv72YQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Jun 2026 11:48:48 +0200
Message-Id: <DJMAFSKM4K9W.19ED2PVPU6S3R@kernel.org>
Subject: Re: [PATCH 1/7] samples: rust_dma: use vertical import style
Cc: "Miguel Ojeda" <ojeda@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>, "Jens Axboe" <axboe@kernel.dk>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>, "Andrew Lunn" <andrew@lunn.ch>,
 "Heiner Kallweit" <hkallweit1@gmail.com>, "Russell King"
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, <driver-core@lists.linux.dev>,
 <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <netdev@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "Guru Das Srinagesh" <linux@gurudas.dev>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260628-b4-rust-vertical-imports-v1-0-98bc71d4810b@gurudas.dev>
 <20260628-b4-rust-vertical-imports-v1-1-98bc71d4810b@gurudas.dev>
In-Reply-To: <20260628-b4-rust-vertical-imports-v1-1-98bc71d4810b@gurudas.dev>
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

On Mon Jun 29, 2026 at 5:38 AM CEST, Guru Das Srinagesh wrote:
>      page, pci,

Can you please also convert this one? Patch 7 also misses at least one case=
.

Thanks,
Danilo
