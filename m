Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34AEC98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 12:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD11C10E3C4;
	Sun, 27 Sep 2026 12:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CG1WIzN4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D848610E3C4
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 12:25:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 276EB60AAE;
 Sun, 27 Sep 2026 12:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECD21F000FF;
 Sun, 27 Sep 2026 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790511905;
 bh=P+NipuqQkuCS9MH+5kBtkFCHseN5UDLBNuO8qD87n6k=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=CG1WIzN4huTUPod30NAXzBZn1rf+q72ZPod8MC+wGKVFx0mRCkF2HxW5ed89z6G8w
 NLoIqwT15WzWhH3dDuZ1r1PiMq9SFC/lfXqShjySKKqhBcGFOEHiECXTQN9gDV8B7d
 Ju/gWjjsKBDB43tuL1xGsnKTcc+K1pNyxEpcmBxhfxysxxZrmSmRJs/elJZepgww/B
 hN+SzVZEfzUh5Sdma9smqRCxocAFsu9wV0df/W6AEwjhOF07B0RHgoS56Ho9cRk6bv
 LW/fijZAHYsOOS9uHbyZ9Eip6fM/KnBRBbL77uKMrKN2xIo8OlT4xi3Abmr+SdA7FC
 am0qLOGO0AaFg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 14:25:01 +0200
Message-Id: <DLQ3HW61LAW1.FLV9E4Z9B5S@kernel.org>
Subject: Re: [PATCH v6 00/13] gpu: nova: Export parameters from nova-core to
 nova-drm
Cc: <rust-for-linux@vger.kernel.org>, "nova-gpu" <nova-gpu@lists.linux.dev>,
 "M Henning" <mhenning@darkrefraction.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>, "John
 Hubbard" <jhubbard@nvidia.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
 <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260909064506.910162-1-apopple@nvidia.com>
 <20260927121736.1186364-1-dakr@kernel.org>
In-Reply-To: <20260927121736.1186364-1-dakr@kernel.org>
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

On Sun Sep 27, 2026 at 2:17 PM CEST, Danilo Krummrich wrote:
> On Wed,  9 Sep 2026 16:44:53 +1000, Alistair Popple wrote:
>> [PATCH v6 00/13] gpu: nova: Export parameters from nova-core to nova-drm
>
> Applied, thanks!
>
>   Branch: drm-rust-next
>   Tree:   https://gitlab.freedesktop.org/drm/rust/kernel.git
>
> [1/13] rust: auxiliary: let registration_data_with() closures return cova=
riant sub-fields
>       commit: 4075acc9d489
> [2/13] gpu: nova-core: Add public driver API to nova-core
>       commit: 6e70b1719991
>
>       [ Rebase and use pin_chain() for Gpu::run_selftests(). - Danilo ]
>
> [3/13] drm: nova: Add DRM registration data
>       commit: ecedc604e0aa
> [4/13] drm: nova: Add GPU architecture enum to nova-drm UAPI
>       commit: 342aaa7bb3cc
> [5/13] drm: nova: Add chipid enum to nova-drm UAPI
>       commit: a1678ed1f8a3
> [6/13] rust: uaccess: add UserSliceWriter::write_truncated()
>       commit: b40f5ed85c5f
>
>       [ Inline write_slice_partial() and use it to simplify write_truncat=
ed().
>         - Danilo ]
>
> [7/13] drm: nova: Add an info ioctl
>       commit: ce6e59897ba5
>
>       [ Avoid 'as' casts (add From<Chipset> for u32, From<Architecture> f=
or
>         u32 and use IntoSafeCast, IntoSafeCastArch); improve / simplify a=
 few
>         comments. - Danilo ]
>
> [8/13] drm: nova: Add usable VRAM size to GPU info
>       commit: d9886a1a06cd
> [9/13] drm: nova: Use nova-core to read VRAM_BAR_SIZE parameter
>       commit: 7edc491f6fca
> [10/13] drm: nova: Expose a render node
>       commit: 843bb3ccde8e
> [11/13] drm: nova: Report GPU name in GPU info
>       commit: 391cc215d22c
>
>       [ Use ..pin_init::zeroed() instead of ..default::Default(). - Danil=
o ]
>
> [12/13] drm: nova: Report GPU short name in GPU info
>       commit: e6d9c5b08c23
> [13/13] drm: nova: Report GPU GID in GPU info
>       commit: 10a6623a24a8
>
> The patches will appear in the next linux-next integration (typically wit=
hin 24
> hours on weekdays).
>
> The patches are queued up for the upcoming merge window for the next majo=
r
> kernel release.

Alistair, I've also updated and merged your drm-test changes. I've also add=
ed a
patch for a Chipset type with strum [1] (it would be nice to have something
similar in the kernel as well).

[1] https://docs.rs/strum/latest/strum/
