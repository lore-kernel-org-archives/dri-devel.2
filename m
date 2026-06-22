Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE184CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 21:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0619310E882;
	Mon, 22 Jun 2026 21:33:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EusqF1f+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0092710E885
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 21:33:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D35A4079B;
 Mon, 22 Jun 2026 21:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080A31F000E9;
 Mon, 22 Jun 2026 21:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782163983;
 bh=eiKGMJnvtl1s4x1K0AHPDI05fpemCuMxOV9tWVGmF0w=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=EusqF1f+lqFj/TUa/4AXRUZ2o7FoMLb56LcxlUUPHPx+v9ysxFbFfQUh4/ZAmPovk
 nhmp2xsp9MZxG2zODu88FcCq6wYx3Nd7iLvmZL8aykVQdGqzrilnkO0veC+bS3GB/R
 SzL5atetfZRObnWkYsT0y1pMr2HLtM175sW0N2/V6CqPCxwQX2jtxqSdbi3KlwG0JZ
 WMDT8Ac7X4MFF0mOmyogNE96YrK0+E2LODB760En5cgUKDM5JD8dQ3mkTQpQhPNrpr
 pm0qbV12NjaXKS52K5aLvQhWog4tN38H8mkqex3/MFz1WR+kD8W0PYgsh1OFamW1wE
 tUULWKVq+hrIQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 22 Jun 2026 23:32:58 +0200
Message-Id: <DJFWELAXB8LS.O3DUMKCB75YF@kernel.org>
Subject: Re: [PATCH v4 14/16] rust: drm: Add RegistrationData to drm::Driver
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <acourbot@nvidia.com>, <ecourtney@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <deborah.brouwer@collabora.com>, <boris.brezillon@collabora.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
 <20260620184924.2247517-15-dakr@kernel.org>
 <29107a0939a8eb67cb4d73a5e06c7ca7e25e3a12.camel@redhat.com>
In-Reply-To: <29107a0939a8eb67cb4d73a5e06c7ca7e25e3a12.camel@redhat.com>
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

On Mon Jun 22, 2026 at 10:17 PM CEST, Lyude Paul wrote:
> This patch seems mostly fine to me, but it'd be wonderful if we could fig=
ure
> out a way to prevent making ::new() unsafe. But even after staring at thi=
s for
> quite a while, I can't really think of anything either :S. Maybe someone =
else
> on the list can think of something

There's currently no way to prevent bypassing the destructor in stable Rust=
.
However, there's an offical Rust project goal [1] to address this with a ne=
w
language feature.

Since this affects almost all Registration types, we could also consider ma=
king
it safe and accept it as a temporary soundness hole.

Getting this wrong seems rather unlikely anyway since in most cases
Registrations live in the bus device private data, which can't be forgotten=
.

But even in the rare cases where they do not, forgetting a Registration wou=
ld be
a very odd thing to do.

In the DRM case the unsafe is not very annoying, but I'm also reworking the=
 IRQ
registration and there it scatters a bit more, so it might be worth conside=
ring.

[1] https://rust-lang.github.io/rust-project-goals/2026/move-trait.html
