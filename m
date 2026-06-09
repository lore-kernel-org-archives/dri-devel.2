Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE83CD8CAD
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 944A610E191;
	Tue,  9 Jun 2026 08:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oxNz1Xy7";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC1F010E18D
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 08:16:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 616CA601DC;
 Tue,  9 Jun 2026 08:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C401F00898;
 Tue,  9 Jun 2026 08:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780992973;
 bh=83SSt/6M9YasZHu5XeeqQEyHb+uu91F02h/PYaNJRkc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oxNz1Xy7oyzXm+2gDABLUzoE1G4d0fnueHHq0nt4VB2a2EtzERLfWJj5Io+Wq+pkD
 tyA8zYfqNKczM2hnaNy+vyJ/E9mP7oQz6x8EOrnSpGStGROixoX6dhbUVljd9w1Q8+
 7W6dRHupG7Jacv3dU4FxzjwwyFR5v82nBoc/H3+f8pemmZie2eVr/LhrVvDOMYonPI
 9laGYBtaD6dvX1lFtjtEq5jS6xRU2pP4AOPO2buMsx338bDP1rTMyamc5XKJdELHwh
 JA/Sqm2ZKhZ7Hg0mbP979A3FssCJS5L/8+f4Fr+EuiaCl2Jf39Qv05ucW3d3hGFaWg
 NRtUTKc2OuMuA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] gpu: nova-core: move GSP unload state to a pinned
 Gpu subobject
To: "Alexandre Courbot" <acourbot@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Danilo Krummrich" <dakr@kernel.org>,
 ojeda@kernel.org
In-Reply-To: <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
References: <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 08:16:12 +0000
Message-Id: <20260609081612.C1C401F00898@smtp.kernel.org>
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
- [High] Moving the GSP unload logic into `GspResources` while leaving `sys=
mem_flush` declared before `gsp_resources` in `Gpu` causes the sysmem flush=
 memory page to be unregistered before the GSP is shut down, leading to har=
dware faults or DMA use-after-free.
--

commit 77c9cd387aef2d5054c5d4097053c58f9a0d5c45
Author: Alexandre Courbot <acourbot@nvidia.com>

gpu: nova-core: move GSP unload state to a pinned Gpu subobject

This commit moves the GSP state and unload bundle into a dedicated pinned
GspResources object to ensure that the GSP unload sequence is executed even
if a later Gpu field initialization fails.

> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index b3c91731db45d..6b3e02c71dee1 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs

[ ... ]

> +/// Structure holding the resources required to operate the GPU.
> +#[pin_data]
> +pub(crate) struct Gpu<'gpu> {
> +    spec: Spec,
> +    /// System memory page required for flushing all pending GPU-side me=
mory writes done through
> +    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memor=
y-barrier operation).
> +    sysmem_flush: SysmemFlush<'gpu>,
> +    /// GSP and its resources.
> +    #[pin]
> +    gsp_resources: GspResources<'gpu>,
> +}

[Severity: High]
Since Rust drops struct fields in their declaration order, will sysmem_flush
be dropped before gsp_resources here?

If sysmem_flush drops first, it will unregister the system memory DMA page
by writing 0 to the hardware register. Next, when gsp_resources drops, its
PinnedDrop implementation will execute this.gsp.unload(...) which resets the
falcons.

Since the unload sequence strictly relies on the sysmembar flush page to
acknowledge resets and flush writes, won't this cause the hardware to attem=
pt
to write to physical address 0 after the page has already been unregistered,
resulting in an IOMMU fault or driver timeout?

Should gsp_resources be declared before sysmem_flush to ensure the GSP is
shut down fully before the flush page is unregistered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-boot-vram-=
v1-0-d9382610507a@nvidia.com?part=3D1
