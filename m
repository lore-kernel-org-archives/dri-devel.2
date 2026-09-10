Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A317C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 07:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EF210F338;
	Thu, 10 Sep 2026 07:18:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eP4juDlS";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91D5010F334
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 07:18:06 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hgTXq43H6zKmTw;
 Thu, 10 Sep 2026 09:18:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1789024683; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+1zmxJeDmDJwzvkVkV4IGrkUV2Tvu3F2l7ySW6LsSfM=;
 b=eP4juDlSsvCuXMaXLGytbVmZ6JcVeKrubgNxhlKyr5reEV21lnav3VSPMXhaKzgUcnCUcC
 SrgeWXlRbg6WNAFMFLlb9otubfpC+ObHIZ0RccuhZGfnXGAbWn4uds8E2XxtFpBcbFIUFW
 niKa7LuWo5K3vYN2mgtjJcqhJIfJJjfwQWzgkB4jqTJXqg2dwWsYozwopCib5HnhYV/K1X
 gQaadJVqcRNUCrTC59OtScxG/DaVG18elmEz9PO2LVdA9DR/RgZD5wRGqILDstjJ4VbHgF
 gCNsYVXTmYrr3SWm/lF0lkNWXjHLgdCsNzA3yPSdmLqiOV+AXxG1hfX9vrThjQ==
Message-ID: <514c6865ede98be45b4a628049ae950b519e0b23.camel@mailbox.org>
Subject: Re: [PATCH drm-rust-next] rust: dma_fence: gate abstractions on
 CONFIG_DMA_SHARED_BUFFER
From: Philipp Stanner <phasta@mailbox.org>
To: Edwin Peer <epeer@nvidia.com>, dakr@kernel.org, aliceryhl@google.com, 
 phasta@kernel.org, sumit.semwal@linaro.org, christian.koenig@amd.com
Cc: jhubbard@nvidia.com, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 09:17:59 +0200
In-Reply-To: <20260909202327.33285-1-epeer@nvidia.com>
References: <20260909202327.33285-1-epeer@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MBO-RS-META: faztazzf75br86cbck75geih8jrxjyxi
X-MBO-RS-ID: 5cd1705c7d2ed4d554d
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
Reply-To: phasta@kernel.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, 2026-09-09 at 13:23 -0700, Edwin Peer wrote:
> The dma_fence abstractions added by commit 3282d5916019 ("rust: Add
> dma_fence abstractions") are compiled unconditionally, but the C
> `dma_fence_*` symbols they reference live in
> drivers/dma-buf/dma-fence.c, which is only built when
> CONFIG_DMA_SHARED_BUFFER=3Dy. Kernels with CONFIG_RUST=3Dy and
> CONFIG_RUST_KERNEL_DOCTESTS=3Dy but CONFIG_DMA_SHARED_BUFFER=3Dn fail
> to link:
>=20
> =C2=A0 ld.lld: error: undefined symbol: dma_fence_release
> =C2=A0 >>> referenced by usercopy_64.c
> =C2=A0 >>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 vmlinux.o:(rust_helper_dma_fence_put)
> =C2=A0 ... dma_fence_signal{,_locked}, dma_fence_context_alloc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_fence_init, dma_fence_{add,remove}_cal=
lback ...
>=20
> Wrap the dma_fence.c helper include in the same
> `pub mod dma_buf;` in rust/kernel/lib.rs with a matching #[cfg].

Oh dear, yes. Sorry about that, thx for fixing!

>=20
> Fixes: 3282d5916019 ("rust: Add dma_fence abstractions")
> Signed-off-by: Edwin Peer <epeer@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: Philipp Stanner <phasta@kernel.org>

> ---
> =C2=A0rust/helpers/helpers.c | 2 +-
> =C2=A0rust/kernel/lib.rs=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A02 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 609689fba3dd..2c5eecc091c4 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -57,8 +57,8 @@
> =C2=A0#include "cred.c"
> =C2=A0#include "device.c"
> =C2=A0#include "dma.c"
> -#include "dma_fence.c"
> =C2=A0#ifdef CONFIG_DMA_SHARED_BUFFER
> +#include "dma_fence.c"
> =C2=A0#include "dma-resv.c"
> =C2=A0#endif
> =C2=A0#include "drm.c"
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 72f5527ba66c..f9ef36217bb5 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -67,6 +67,7 @@
> =C2=A0pub mod device_id;
> =C2=A0pub mod devres;
> =C2=A0pub mod dma;
> +#[cfg(CONFIG_DMA_SHARED_BUFFER)]
> =C2=A0pub mod dma_buf;
> =C2=A0pub mod driver;
> =C2=A0#[cfg(CONFIG_DRM =3D "y")]
