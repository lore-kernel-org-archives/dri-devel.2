Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188BDF46C78
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 19:46:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50E4310E2B3;
	Mon,  6 Apr 2026 19:46:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="un9klg1x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1DCF10E2B3
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Apr 2026 19:46:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 99667438F9;
 Mon,  6 Apr 2026 19:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335C4C4CEF7;
 Mon,  6 Apr 2026 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775504816;
 bh=nzT2HtlJvPMZ0AgrhMmbkV4GooTiRFDrYylN2jpLluU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=un9klg1x1Hy+axiVeiEHHRd2IDTSt+3DqFG9J1QbTbzSP7PHa2luUuGbNX34DkLf/
 i416WMB50zbo+3BKU+TvkSpUAvEyPFAXs+F+tB9bNkZdQ2qS5g1eA44N8wa94hvj5e
 Ch7w6e34p3yn+9+E7SQaEZOwGSEHbuSntDjkuPFsczLp05gh1jeKJvE/K6aDw4zWbe
 n0Z3kAEHTGFTJbJGZrkEnPxpcQJlSEs0SIj7Lnshfm0AjgYh9CdcOyQQN+tDg2+JrE
 IBLOHwfRBo5mwj/nw53WMorV7hW9duzgRo5JTbU+7kJrco/b2XnIrZrWT3dKF2atv5
 gQzXJDhF0XlFw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 21:46:52 +0200
Message-Id: <DHMBXEFTCYI2.1Z53IVMASJ4Y5@kernel.org>
Subject: Re: [PATCH] gpu: nova-core: require little endian
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur
 Tabi" <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
To: "Eliot Courtney" <ecourtney@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
In-Reply-To: <20260406-fix-kconfig-v1-1-8f634499f7f0@nvidia.com>
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

On Mon Apr 6, 2026 at 8:52 AM CEST, Eliot Courtney wrote:
> The driver already assumes little endian in a lot of locations. For
> example, all the code that reads RPCs out of the command queue just
> directly interprets the bytes.
>
> Make this explicit in Kconfig.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
> The current code assumes little endian in a bunch of places. I think we
> should either explicitly decide to be generic on endianness or explicitly
> decide not to - having some handling sprinkled around in various
> locations seems confusing to me.
>
> I believe that currently e.g. `RUST` transitively depends on
> !CPU_BIG_ENDIAN, so this is more about making the decision explicit for
> nova-core rather than fixing any kind of hole.
> ---
>  drivers/gpu/nova-core/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfi=
g
> index a4f2380654e2..d8456f8eaa05 100644
> --- a/drivers/gpu/nova-core/Kconfig
> +++ b/drivers/gpu/nova-core/Kconfig
> @@ -3,6 +3,7 @@ config NOVA_CORE
>  	depends on 64BIT
>  	depends on PCI
>  	depends on RUST
> +	depends on !CPU_BIG_ENDIAN

Since we have DRM_NOVA select NOVA_CORE, this has to be added to DRM_NOVA a=
s
well, otherwise you could forcefully select NOVA_CORE through DRM_NOVA with=
out
considering !CPU_BIG_ENDIAN.

Note DRM_NOVA intentionally has select NOVA_CORE (instead of depends on), s=
ince
otherwise a user would need to enable NOVA_CORE in order to see DRM_NOVA in=
 the
menuconfig in the first place.

>  	select AUXILIARY_BUS
>  	select RUST_FW_LOADER_ABSTRACTIONS
>  	default n
>
> ---
> base-commit: a7a080bb4236ebe577b6776d940d1717912ff6dd
> change-id: 20260406-fix-kconfig-3a059f622697
>
> Best regards,
> -- =20
> Eliot Courtney <ecourtney@nvidia.com>

