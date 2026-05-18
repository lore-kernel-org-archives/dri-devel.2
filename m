Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451BFCD4F54
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:09:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DB110E77C;
	Mon, 18 May 2026 10:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NHDF4F8W";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F35B10E5C0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:09:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2AAD943DD2;
 Mon, 18 May 2026 10:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17ECC2BCB7;
 Mon, 18 May 2026 10:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1779098987;
 bh=shQp/tVJMsNoDiJP76yqXZ2VF/81FyuiPhegcrIEk/g=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
 b=NHDF4F8W/MhWIyiaCQe/mW/O5mnYG6vH2O+bHlW1tDvJV9m2Eu9qIZMMa7aOdmm+i
 IHZ7d3Sxt2e+rXguB+3ly01EZsq1/PHkjLrsKiTwRbEYZQy8WFoSUv42q8CFBcOQKt
 g+4aHwqWwK1x8+XPYJN2BZHIpk8NkCp9x1jU9wRsGpTajFDOyTFF14v2ob9P1OkpSK
 e5UfFSSEi+vWwG8RtBs+SODtFoe6S9wl7Empp3P792te4MTPDA/iZeb3V8p9hd8ZCj
 eq+YzTCZzEpfXgxleXJvNvqcqvvA3vuYlz0WEgHtMBQJLpjoaeQcXHVE68Pl5IBaqx
 EQIj2z8aiAE4A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 12:09:42 +0200
Message-Id: <DILPYDI01YFS.2NPFG6ZG085PP@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH 11/13] drm/tyr: add debugfs infrastructure
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Sumit Semwal"
 <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>
To: "Alvin Sun" <alvin.sun@linux.dev>
References: <20260326-b4-tyr-debugfs-v1-0-074badd18716@linux.dev>
 <20260326-b4-tyr-debugfs-v1-11-074badd18716@linux.dev>
In-Reply-To: <20260326-b4-tyr-debugfs-v1-11-074badd18716@linux.dev>
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

On Thu Mar 26, 2026 at 7:53 AM CET, Alvin Sun wrote:
> +#[pin_data]
> +struct TyrModule {
> +    _debugfs_root: HazPtrRevokeHandle<'static, kernel::debugfs::Dir>,
> +    #[pin]
> +    _driver: Registration<platform::Adapter<TyrPlatformDriverData>>,
> +}
> +
> +impl InPlaceModule for TyrModule {
> +    fn init(module: &'static kernel::ThisModule) -> impl PinInit<Self, e=
rror::Error> {
> +        let dir =3D kernel::debugfs::Dir::new(kernel::c_str!("tyr"));

Why does Tyr need its own debugfs directory to expose DRM data structures? =
DRM
already has a common debugfs directory per DRM device in /sys/kernel/debug/=
dri/,
which you should attach to instead if you want to expose driver specific fi=
les.
