Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033B0C79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FA0610EE93;
	Wed,  9 Sep 2026 04:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PDVfTLe2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B952C10EE93
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 04:07:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A23EF40F84;
 Wed,  9 Sep 2026 04:07:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1211F00A3D;
 Wed,  9 Sep 2026 04:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788926866;
 bh=LpiyQLdpbfhHb+u3xqe69GPkWib5HJD+gnktxfGJlB0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PDVfTLe2w98ZnBbxsI+UyAmOnsO9bszBqbNEQCxftPbr1mXyCBLgiN6XAfR6MG/3M
 ng836fHYolG6oMD0yKEz8MfutboqpFCDxgdxYsQy8dkCUzlnTN/BBjI2aM1upgj87x
 g60/U+ipBcuYzgnCW9v+f6oUr5PX16yR7BIRbYGmqMCazJ3igiCDV90/gRYrz4F3FM
 dB8GRSx0/ULj2XLSxUdnvx9JAYsVdnYCxccjC+XqxJ4z/OK8rsieYtEBsUs+tiNF5j
 YXNdMcKut53s3v3p2P54pE/54mL9ZMoJuy1qDaaI8Bxw6aad8haEfoLNdC7kB51efj
 JM9M8bFKMtQxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/16] gpu: nova-core: mm: pagetable: Add PteOps trait
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>,
 "Danilo Krummrich" <dakr@kernel.org>
In-Reply-To: <20260909-mmrebase-v1-4-8dd5d4225d2e@nvidia.com>
References: <20260909-mmrebase-v1-0-8dd5d4225d2e@nvidia.com>
 <20260909-mmrebase-v1-4-8dd5d4225d2e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 04:07:45 +0000
Message-Id: <20260909040746.4E1211F00A3D@smtp.kernel.org>
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
- [Low] Vertical imports in the `crate::mm` block are not alphabetically so=
rted.
--

commit ee1cdc1cc3fda4aebff8e2ad80ace37f03baef14
Author: Joel Fernandes <joelagnelf@nvidia.com>

gpu: nova-core: mm: pagetable: Add PteOps trait

This introduces a trait for GPU Page Table Entries. New read and write
helpers are provided that go through a Pramin, allowing the later
page-table walker and mapper to call PTE operations.

> diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-cor=
e/mm/pagetable.rs
> --- a/drivers/gpu/nova-core/mm/pagetable.rs
> +++ b/drivers/gpu/nova-core/mm/pagetable.rs
> @@ -8,9 +8,18 @@
> =20
>  #![expect(dead_code)]
> =20
> -use kernel::num::Bounded;
> +use kernel::{
> +    io::Io,
> +    num::Bounded,
> +    prelude::*, //
> +};
> =20
>  use crate::gpu::Architecture;
> +use crate::mm::{
> +    pramin,
> +    Pfn,
> +    VramAddress, //
> +};

[Severity: Low]
This isn't a bug, but it looks like the vertical imports in the crate::mm
block are not alphabetically sorted. Should Pfn precede pramin to comply
with the Rust kernel coding guidelines for import formatting?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-mmrebase-v=
1-0-8dd5d4225d2e@nvidia.com?part=3D4
