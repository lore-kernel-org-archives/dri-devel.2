Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B22C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 17:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7939B10E9B7;
	Mon, 29 Jun 2026 17:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kGytTE1f";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D3CA10E9B7
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 17:08:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D6B824053B;
 Mon, 29 Jun 2026 17:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF6D1F000E9;
 Mon, 29 Jun 2026 17:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782752902;
 bh=SKzXFCX5Hz/9JDCNuzIk9SSBqkzd/1pv8APHR218gPc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kGytTE1ff0+iWVtruMqXSceoIBgeR4O+DiaCg+7DrmzCGBDdqnZZG+uDbpW1nm9sm
 /7qCvpJxB677fQKOofu3vZzz+Q980b790Uo+1VZti24X3DWKowvszuYu7BsB4MCnfQ
 lyOFzyZvW5L1IVntj/vkhRgYjkgunA6XsqNAM1voBFMXYyzgErC5LI3+jDQmoNFVnw
 ZWH/BTXmAYyZSx/2uEnBQ2wJ1JhCYDexLLaB5Dwz2TG/NJTxpth7gR6aBarnhl2Dhu
 C8sxu5pwGBy8JbqX+bf2317jVu2SGoOFn/hl/1pwnIXm1jX3JVjfOiUkecZBshYrqS
 D9BC0dCbC3XJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/omap: dsi: do not copy isr table
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info>
References: <20260629-dsi-uaf-v1-1-a5e894f4e4d1@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 17:08:22 +0000
Message-Id: <20260629170822.8FF6D1F000E9@smtp.kernel.org>
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

New issues:
- [Low] The `isr_tables_copy` field is no longer used but was not removed f=
rom `struct dsi_data`, leaving unused memory.

Pre-existing issues:
- [Critical] The exact same Use-After-Free (UAF) vulnerability exists in th=
e legacy fbdev OMAP DSI driver but was not patched.
--

commit 18bc0b56dc801c9ead9c7b993f8c1e1f228ff1c0
Author: Andreas Kemnade <andreas@kemnade.info>
Subject: drm/omap: dsi: do not copy isr table

This commit removes the copying of the ISR table in the omapdrm DSI IRQ
handler. This change prevents a use-after-free scenario when stack-allocated
objects are passed to unregistered ISRs.

> diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/=
dss/dsi.c
> index 27fe7bca9e2cf..70cfb779d6ae5 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dsi.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
> @@ -455,15 +455,10 @@ static irqreturn_t omap_dsi_irq_handler(int irq, vo=
id *arg)
>  		timer_delete(&dsi->te_timer);
>  #endif
> =20
> -	/* make a copy and unlock, so that isrs can unregister
> -	 * themselves */
> -	memcpy(&dsi->isr_tables_copy, &dsi->isr_tables,
> -		sizeof(dsi->isr_tables));
> +	dsi_handle_isrs(&dsi->isr_tables, irqstatus, vcstatus, ciostatus);
> =20
>  	spin_unlock(&dsi->irq_lock);
> =20
> -	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
> -

[Severity: Low]
Since isr_tables_copy is no longer used here, should it also be removed
from struct dsi_data in drivers/gpu/drm/omapdrm/dss/dsi.h to avoid
leaving unused memory?

drivers/gpu/drm/omapdrm/dss/dsi.h:
struct dsi_data {
    ...
    struct dsi_isr_tables isr_tables;
    /* space for a copy used by the interrupt handler */
    struct dsi_isr_tables isr_tables_copy;
    ...
};

[Severity: Critical]
This isn't a bug introduced by this patch, but the exact same issue seems to
still exist in the legacy omapfb driver.=20

Looking at omap_dsi_irq_handler() in drivers/video/fbdev/omap2/omapfb/dss/d=
si.c:

	/* make a copy and unlock, so that isrs can unregister
	 * themselves */
	memcpy(&dsi->isr_tables_copy, &dsi->isr_tables,
		sizeof(dsi->isr_tables));

	spin_unlock(&dsi->irq_lock);

	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);

If a hardware timeout occurs during operations like dsi_vc_send_bta_sync(),
causing wait_for_completion_timeout() to return 0, could the waiting thread
destroy its local stack frame while the IRQ handler continues using the cop=
y?
Should a similar fix be applied to the fbdev driver as well?

>  	dsi_handle_irq_errors(dsi, irqstatus, vcstatus, ciostatus);
> =20
>  	dsi_collect_irq_stats(dsi, irqstatus, vcstatus, ciostatus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-dsi-uaf-v1=
-1-a5e894f4e4d1@kemnade.info?part=3D1
