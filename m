Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D4AF8DFCF
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6DB10E02C;
	Thu, 16 Apr 2026 22:19:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WEBN06aA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 575EC10E02C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 22:19:03 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 05BE743827;
 Thu, 16 Apr 2026 22:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E23AC2BCAF;
 Thu, 16 Apr 2026 22:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776377942;
 bh=6gKe+C7aovSqogOpgng5S4425BdIF18vZOv6JAeEIzM=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=WEBN06aAXFBHORGJuxkOAb7bhg7MtgQ6MTwuFZEgFibFBeoJl7kO2QniT3x5qZXbc
 vu/abPFHXuMSOFiPhoTUF73+f3mPGHb2Ca7/M9zMHyKmHpfcqQS3VF2bUqjSmoJwEb
 W7Q7VdR0wiCzHtyN+KxQ00lImJNf2ma27XLy5uc+DnP8Gb9omOOrK6pigRzy/CRmnu
 b1wmyiI/E/jcyypHdzmX0T5U9JXSt2cveBWiheBsGsSuZWKMZmxMo9Dfp9WBsVEYfr
 xB9dtIn8466mLuoawUHBEtD3SXU/TS2WUpxCYicsMvgcGH3Kw0zrv4N/GkbY6pOUJI
 3Bx7FKeOQYmww==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 00:18:56 +0200
Message-Id: <DHUXFAD38G5Y.6X6QNTANYNGH@kernel.org>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/3] rust: add `bitfield!` macro
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
In-Reply-To: <798e83e6-eb7b-4502-85e7-5a0f6d9c6281@nvidia.com>
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

On Thu Apr 16, 2026 at 1:22 AM CEST, John Hubbard wrote:
> Can we please put this into your drm-rust-next-staging ASAP? I don't
> think we have any comments that would really need to hold that up.

I would like to see the first patch being split up and we also need to agre=
e the
merge strategy for this series and obtain the corresponding ACKs first.

That said, I'm not a huge fan of the drm-rust-next-staging thing. It starte=
d out
as part of Alex' (private) process of staging patches he's about to pick up
(which is fine of course).

But now it seems to develop into some semi-official "shadow infrastructure"=
 for
when the drm-rust tree is closed after -rc6 and during the merge window, an=
d
it's not part of the official drm-rust workflow and other maintainers don't=
 have
oversight of it.

So, in order to not motivate workarounds, starting from the next cycle, the
drm-rust-next branch will be open for new features at all times.

Consequently, all patches applied to drm-rust-next after -rc6 do not target=
 the
upcoming merge window, but the next one.

Fixes for code that is within drm-rust-next and was merged before -rc6 have=
 to
go into drm-rust-next-fixes.

drm-rust-fixes will continue to be the target for fixes for the current -rc=
.

I will update all corresponding documentation in the next days and send ano=
ther
announcement mail, so it is not only this one buried in a thread where no o=
ne
expects it. :)

- Danilo
