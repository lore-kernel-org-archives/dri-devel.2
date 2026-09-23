Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8004EC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 00:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 818B310EEC9;
	Wed, 23 Sep 2026 00:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AtdQXEXe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB3F010EEC9
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 00:45:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E03F601F0;
 Wed, 23 Sep 2026 00:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D871F000FF;
 Wed, 23 Sep 2026 00:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790124332;
 bh=kcnpP1SNAOeSNbsydu24GYeKi3hY4GC7wEv+Y3ajnsg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AtdQXEXeUJRd68/JCUd+HyHYB0pGK9erIxkqw/CfWZFGcjmIn1YI02GR8Po/afkdN
 07YiJ8Y1al0PmV6D292GkkWhoMg/wpsuDCzTnMTAFFK30bLF1QO8OPa+krcwDEqPzp
 b4izWleG6WYftXCWwoJ/yo1UBtX+ketH1Jux1LNbmMzQU2KH1z4yeyl7QwRi4MeCZt
 wlUwkEwsu7KLJal+pdn3EWZrNSndrcNcPYuAcOMPJcoi40IU4NX7cSmoypdNMFFjYg
 ZeX4TbE0ZZ7s+Q3y9rbeLJPN8tHbwZo9VO2GwC/b4PZNbt4KCyj1v1vFbIAcxygUEf
 uJ91jEBlrlqpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] gpu: nova-core: Extract PFSP register definitions
To: "Antonin Malzieu Ridolfi" <dev@nanonej.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260923-b4-extract-pfsp-registers-to-falcon-mod-v2-1-74600fc068c4@nanonej.com>
References: <20260923-b4-extract-pfsp-registers-to-falcon-mod-v2-0-74600fc068c4@nanonej.com>
 <20260923-b4-extract-pfsp-registers-to-falcon-mod-v2-1-74600fc068c4@nanonej.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 00:45:31 +0000
Message-Id: <20260923004532.76D871F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] nova-core: PFSP registers remain pub(crate) despite commit messa=
ge
- [Low] nova-core: sentence fragment in commit message
--

commit 4db1b123b08a2ccc218c14e49151c182aa9d6c36
Author: Antonin Malzieu Ridolfi <dev@nanonej.com>

gpu: nova-core: Extract PFSP register definitions

This commit moves the Foundation Security Processor (PFSP) register
definitions from the root regs module into the falcon module. It also
re-exports PFALCON registers to allow using a single regs:: prefix.

> Since PFALCON registers are defined in the root regs.rs but are
> also part of the falcon interface, accessed by the whole falcon
> module. They are re-exported in falcon/regs.rs so falcon code can use
> a single regs:: prefix.

[Severity: Low]
This isn't a bug, but there is a sentence fragment in the commit message he=
re.
The first sentence begins with the subordinating conjunction "Since" but
terminates with a period before reaching a main clause. Should these two
sentences be combined?

> diff --git a/drivers/gpu/nova-core/falcon/regs.rs b/drivers/gpu/nova-core=
/falcon/regs.rs
> new file mode 100644
> index 0000000000000..5ccb10946ec4d
> --- /dev/null
> +++ b/drivers/gpu/nova-core/falcon/regs.rs
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use crate::driver::NovaRegisters;
> +use kernel::io::register;
> +
> +// FSP (Foundation Security Processor) queue registers for Hopper/Blackw=
ell Chain of Trust.
> +// These registers manage falcon EMEM communication queues.
> +
> +register! {
> +    base: NovaRegisters;
> +
> +    pub(crate) NV_PFSP_QUEUE_HEAD(u32)[8] @ 0x008f2c00 {

[Severity: Medium]
The commit message states that visibility for these moved registers changes
to pub(super), but the code retains pub(crate) visibility here and for the
other NV_PFSP_* registers below. Should this be updated to pub(super) as
intended?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-b4-extract=
-pfsp-registers-to-falcon-mod-v2-0-74600fc068c4@nanonej.com?part=3D1
