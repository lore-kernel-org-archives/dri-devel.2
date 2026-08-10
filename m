Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB597C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B3EC10E8A1;
	Mon, 10 Aug 2026 14:09:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kRpbgZyB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7831310E8A1
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:09:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B320460120;
 Mon, 10 Aug 2026 14:09:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C13E1F000E9;
 Mon, 10 Aug 2026 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786370992;
 bh=buvn+dwWNKzJldXB83DCTa9unYwx8YVZUzF4gvGbhNU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kRpbgZyBQRiJQE3ljZo02z2bhd5OzY8oJuD2+G6Q740jU3oG5nlhgkjAcKG+ubpzA
 +Np97BSF/Ng/0eqj5A9DLwnYT708xVFSsLQ3sZguCtOkGWU32S4X1u9fcQqsTTKtmh
 SvFdPorgkv0BxLo/JqUTcO8S7ob3weIDQlTToZrZx5DqIoJGP5kVVKOSvVNNmyqcg1
 MyM6AOwIxQl2dMRsXkn0U3XNyi1H4cORYDtBBRpOukRwEsRbowNyPEZThfKzA8ipNi
 XaLrUCd+pEs1aTTG+Ofx2XprNnIW2oGQFEMZPne+T+1CtUNpW3DdwomdpEcttTYBS3
 Bfi1ol7/XJ7uw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] gpu: nova-core: mm: Add GpuMm centralized
 memory manager
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260810-pramin-split-v2-10-65a00b3c7309@nvidia.com>
References: <20260810-pramin-split-v2-0-65a00b3c7309@nvidia.com>
 <20260810-pramin-split-v2-10-65a00b3c7309@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:09:51 +0000
Message-Id: <20260810140952.3C13E1F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `pramin_mut` method in `GpuMm` is missing the `pub(crate)` v=
isibility modifier, despite the commit message claiming it is exposed for f=
ollow-on patches.
--

--- Patch [10]: [PATCH v2 10/12] gpu: nova-core: mm: Add GpuMm centralized =
memory manager ---
commit 454fed327c5dab971b01225656d96fa09a0fc921
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: Add GpuMm centralized memory manager

Introduce GpuMm as the centralized GPU memory manager. At this point in
the series, GpuMm only owns the PRAMIN window for direct VRAM access. This
provides a clean ownership model where GpuMm provides accessor methods for
its components.

> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> index ef5b1cad56c31..58dce211a3373 100644
> --- a/drivers/gpu/nova-core/mm.rs
> +++ b/drivers/gpu/nova-core/mm.rs

[ ... ]

> +
> +    /// Access the [`pramin::Pramin`].
> +    fn pramin_mut(&mut self) -> &mut pramin::Pramin<'gpu> {
> +        &mut self.pramin
> +    }
> +}

[Severity: Medium]
The commit message mentions this provides accessor methods so that follow-on
patches can reference pramin_mut() cleanly. However, GpuMm::pramin_mut() is
defined without the pub(crate) visibility modifier, making it strictly priv=
ate
to the mm module.

Will this prevent cross-subsystem access from gpu.rs or external tests as
intended by the commit message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810-pramin-spl=
it-v2-0-65a00b3c7309@nvidia.com?part=3D10
