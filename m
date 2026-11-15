Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDE2606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDvPHSud
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA2B10E012;
	Sun, 15 Nov 2026 18:30:40 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EADC10E012
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 18:30:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43BE743CA2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 18:30:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12001F000C4;
 Sun, 15 Nov 2026 18:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794767433;
 bh=KnLftDAs6OECyhkIMxPbQMR16BMamkTdaFnm/OsQa2c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NDvPHSudI6YidCfoHQV1yfPazkIITE+o+XAEXFdj713PtkF6fq/0rW0mseX5hiLUw
 bimPFaUhVlXo5MGgQ1plG3g8K7FkvupzS7rlJmLMrEqj79UntQYGkqWKhlrXOk6Yu+
 R5eLe2zCdGoUvlNGcNqCAYrJps5FssORm1+h2zNpynq4HGrozL8Tmiv16tmWHvg6yf
 pgrKSW2eflJwXbArOcde+KpwxAvkrynJrzm+jNXqfTC8hwwTHUe3zJK8Ij+9gUWOIc
 iK26LHLYysWSnZnme0xNRPFI+EaDss6BxycJsKQTJC3y1/GAFARWoDnIFFw6M/JXIn
 NmGsMCBezCsvQ==
Message-ID: <sashiko-outbox-215719@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mcde: Use power domain for display power
To: "Linus Walleij" <linusw@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261115-ux500-drm-mcde-powerdomain-v1-1-afdc326cceb7@kernel.org>
References: <20261115-ux500-drm-mcde-powerdomain-v1-1-afdc326cceb7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 18:30:32 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/mcde: TOCTOU race in mcde_clk_div_recalc_rate() [1]
--

commit b6626239eb4624a10d2245cb12fab62bbafe702d
Author: Linus Walleij <linusw@kernel.org>

drm/mcde: Use power domain for display power

This commit replaces explicit EPOD regulator handling in the MCDE DRM
driver with runtime PM calls while keeping the separate VANA analog supply
enabled during driver binding.

> diff --git a/drivers/gpu/drm/mcde/mcde_clk_div.c b/drivers/gpu/drm/mcde/m=
cde_clk_div.c
> index 8c5af2677357f..1a22e6233946c 100644
> --- a/drivers/gpu/drm/mcde/mcde_clk_div.c
> +++ b/drivers/gpu/drm/mcde/mcde_clk_div.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
> -#include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
> =20
>  #include "mcde_drm.h"
>  #include "mcde_display_regs.h"
> @@ -95,7 +95,7 @@ static unsigned long mcde_clk_div_recalc_rate(struct cl=
k_hw *hw,
>  	 * It will come up with 0 in the divider register bits, which
>  	 * means "divide by 2".
>  	 */
> -	if (!regulator_is_enabled(mcde->epod))
> +	if (!pm_runtime_active(mcde->dev))
>  		return DIV_ROUND_UP_ULL(prate, 2);
> =20
>  	cr =3D readl(mcde->regs + cdiv->cr);

[Severity: High]
This problem wasn't introduced by this patch, but can mcde->dev runtime-sus=
pend [1] between pm_runtime_active() and readl()?

pm_runtime_active() does not take a runtime PM reference, so a concurrent
suspend can power down the MCDE block before the register read completes:

CPU0                                  CPU1
mcde_clk_div_recalc_rate()
  pm_runtime_active(mcde->dev)
                                      pm_runtime_put_sync_suspend(mcde->dev)
  readl(mcde->regs + cdiv->cr)  <-- unpowered MMIO access

Reading MCDE registers while the power domain is off causes an unhandled
hardware fault.  Using pm_runtime_get_if_in_use() and dropping the
reference after readl() would keep the domain powered across the register
read.

[1] https://sashiko.dev/#/bug/linux-29030bde-9a9e-4287-978a-034b8c472d84

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115-ux500-drm-=
mcde-powerdomain-v1-1-afdc326cceb7@kernel.org?part=3D1
