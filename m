Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AC4C44532
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 15:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21C2410E390;
	Tue, 21 Jul 2026 15:48:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k0P8Jv3+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26D8910E390
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 15:48:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7D16560204;
 Tue, 21 Jul 2026 15:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F073A1F00A3A;
 Tue, 21 Jul 2026 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784648924;
 bh=jf/gmOd/XYNN04eN/025KZlQJap2pGVB+B5WIDpmNaU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=k0P8Jv3+ha5a5fCRxGP3OAuzSuyiUww2AJzNB3QOfeobV/i2+aOO19NtSdQqqTJ+D
 us+Klpr4JVleMY20baM46OdKj//BqEjSzG4m+g6yWLZHGecqum4HFR1ER859dIPxaE
 qvsRF65+TUw4vl5N8wstR6oScqTbSU9sDT32ut6kXfpjh4kKZm0uyWCfbNXpgSavX/
 RJH33357OJtSBTBkOlr/E/rp8q49K0kytYZDx8ROZxlmpNVaalNMrxUWUuj6imiJy0
 Kwm0BZu7zeWBTn8n+4pAX2AMdKVEAo8TaH88dPr7YxD8V7qX7D3Bwtlr/Qz8IdOp+U
 FavNsQHFOUCyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] gpu: nova-core: Move PFB registers definitions
To: "Antonin Malzieu Ridolfi" <dev@nanonej.com>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260721-nova-core-regs-split-v1-2-384fa2a42244@nanonej.com>
References: <20260721-nova-core-regs-split-v1-0-384fa2a42244@nanonej.com>
 <20260721-nova-core-regs-split-v1-2-384fa2a42244@nanonej.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 15:48:43 +0000
Message-Id: <20260721154843.F073A1F00A3A@smtp.kernel.org>
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
- [Low] Broken rustdoc intra-doc link in `NV_PFB_NISO_FLUSH_SYSMEM_ADDR` do=
cumentation.
--

--- Patch [2]: [PATCH 2/3] gpu: nova-core: Move PFB registers definitions -=
--
commit 93581bd57d4fa161f3ef24dd18b77e6a7afea781
Author: Antonin Malzieu Ridolfi <dev@nanonej.com>

gpu: nova-core: Move PFB registers definitions

This commit moves the PFB register definitions from the global regs.rs file
to a dedicated fb/regs.rs file and updates the corresponding references
across the hardware abstraction layers.

> diff --git a/drivers/gpu/nova-core/fb/regs.rs b/drivers/gpu/nova-core/fb/=
regs.rs
> index b2ec02f584bee..b2baa4a2a85ff 100644
> --- a/drivers/gpu/nova-core/fb/regs.rs
> +++ b/drivers/gpu/nova-core/fb/regs.rs

[ ... ]

> @@ -23,3 +26,130 @@ pub(super) fn vga_workspace_addr(self) -> Option<u64>=
 {
>          }
>      }
>  }
> +
> +// PFB
> +
> +register! {
> +    /// Low bits of the physical system memory address used by the GPU t=
o perform sysmembar
> +    /// operations (see [`super::fb::SysmemFlush`]).
> +    pub(super) NV_PFB_NISO_FLUSH_SYSMEM_ADDR(u32) @ 0x00100c10 {

[Severity: Low]
Will this intra-doc link fail to resolve during the rustdoc build?

Since this code was moved into fb/regs.rs, the `super` keyword resolves to
crate::fb. This means `super::fb::SysmemFlush` points to
crate::fb::fb::SysmemFlush, which doesn't exist.

Should this be updated to [`super::SysmemFlush`] to prevent a
broken_intra_doc_links warning?

> +        31:0    adr_39_08;
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-nova-core-=
regs-split-v1-0-384fa2a42244@nanonej.com?part=3D2
