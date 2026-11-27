Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED00606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dAUMugMR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EBE710E044;
	Fri, 27 Nov 2026 18:37:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36F5610E044
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 18:37:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52D7E611D2;
 Fri, 27 Nov 2026 18:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D561F0089A;
 Fri, 27 Nov 2026 18:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795804652;
 bh=kwe+A0ByfQmNrMVNsowMrCvPXHeMC+u6zbS6OHo1pYw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dAUMugMRWvpIKZnN2iqZ8WWueCG8F3S3djIFct56p1YWt1bMEXziwoHVVraEcCLpX
 inhbliLTbOtgIjjzxvAQATzZ3FD5k4OmvR4KMx4aluKKb7ECazyCv+/iwMQziw4I05
 0KBw0BqMos7Y4T+50YCMqnu9+MjD/J0H/fPEmGruw+A2pIZPimFMxn433PxPxTCtc/
 YrciZXga0Jy5nTYC45SK3No4OUuHU8q17hDt9kbWUXtRSrzJZYS9gtXzq1Gr5m92rz
 Ck/NwEaqEMf/ywVSiebyZwvkLrPNu7Szo9L2CTMpC7S54WNsLWElFnQ+PKIPppOltn
 A90VW0xM/j0Aw==
Message-ID: <sashiko-outbox-238085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] rust: dma_buf: dma_fence: add SignallingSection
To: "Daniel Almeida" <daniel.almeida@collabora.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, ojeda@kernel.org,
 gary@garyguo.net
In-Reply-To: <20261127-dma-fence-signalling-v1-1-c44e8f4910ca@collabora.com>
References: <20261127-dma-fence-signalling-v1-0-c44e8f4910ca@collabora.com>
 <20261127-dma-fence-signalling-v1-1-c44e8f4910ca@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 18:37:32 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] rust: dma_buf: unbraced types:: imports violate vertical import
  style
--

commit 56c9983dfb639b5faf163be9218eb021f7654558
Author: Daniel Almeida <daniel.almeida@collabora.com>

rust: dma_buf: dma_fence: add SignallingSection

This commit adds a SignallingSection guard wrapping
dma_fence_begin_signalling() and dma_fence_end_signalling(), and uses it
in the DriverFence documentation example.

> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index a1d851656562d..7ee87935d3be3 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -17,6 +17,7 @@
>      error::to_result,
>      prelude::*,
>      types::ForeignOwnable,
> +    types::NotThreadSafe,
>      types::Opaque, //
>  };

[Severity: Low]
This isn't a bug, but per Documentation/rust/coding-guidelines.rst,
multiple items imported from crate::types should be grouped in nested
braces:

    types::{
        ForeignOwnable,
        NotThreadSafe,
        Opaque, //
    },

Also, in the DriverFence doc example below, the SignallingSection entry at
the end of the dma_buf::{ ... } import list is missing the trailing "//"
comment that keeps rustfmt from collapsing the block.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-dma-fence-=
signalling-v1-0-c44e8f4910ca@collabora.com?part=3D1
