Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DDBC43602
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4540610E0D8;
	Thu,  2 Jul 2026 15:40:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JovWHn6P";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE84910E0D8
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:40:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 56EF943EBE;
 Thu,  2 Jul 2026 15:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC991F000E9;
 Thu,  2 Jul 2026 15:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783006820;
 bh=v7sz6V6G0TkujYMQ8Cj4niLBJ58e/JTkgA6O/2YMpEU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JovWHn6PagMdCc6/MkoE934HcY6drY3+gvsfr9uIc4hVsPqhjzbICrDqSucEP73Sh
 wlrUVQcbIm+59jrqWDw2vhwmw9xV+lGDnjYaro2R1xiqW+KJYjFU9Ib9SUyp+xTN4J
 alC7X7JLcK1LiuXMFEWO+L0v0uCKFKFImsvBmx/NDkx+bt0RwjPxzgCm1maDfvLC/X
 Y6yloRW5ie+ttk77zUXUDnz/HG4twlOO9jljVhz7Hnwk+J+Y+cN4PxzpC69x9spcNr
 25IxzO7W3Hw4K7dQzN1lmK2bj6FMYy6/sdnb8EugKqqWzHzoTp6CKPfmhTjOlH8cWn
 M52mc57r1/CAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/omap: dsi: do not copy isr table
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
References: <20260702-dsi-uaf-v2-1-dbb4aa0f0b8e@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:40:19 +0000
Message-Id: <20260702154020.0DC991F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missed fix / Use-After-Free in fbdev omapfb driver
--

commit 84bfbe9de64eb5f62f575283f7f6c859c07c8287
Author: Andreas Kemnade <andreas@kemnade.info>

drm/omap: dsi: do not copy isr table

This commit stops copying the ISR table in the OMAP DSI interrupt handler
to prevent potential use-after-free vulnerabilities. By directly handling
ISRs with the original table, it avoids accessing stack-allocated objects
that might have been unregistered and destroyed.

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

[Severity: High]
This is a pre-existing issue, but does the same vulnerability still exist
in the fbdev omapfb driver?

Looking at drivers/video/fbdev/omap2/omapfb/dss/dsi.c in omap_dsi_irq_handl=
er(),
it still contains the copied table pattern:

	/* make a copy and unlock, so that isrs can unregister
	 * themselves */
	memcpy(&dsi->isr_tables_copy, &dsi->isr_tables,
		sizeof(dsi->isr_tables));

	spin_unlock(&dsi->irq_lock);

	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);

If a timed-out waiter unregisters its ISR and its on-stack completion object
is destroyed, could the interrupt handler still access it via the copied
isr_tables_copy table?

Should this fix be applied to the fbdev driver as well?

> =20
>  	spin_unlock(&dsi->irq_lock);
> =20
> -	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
> -
>  	dsi_handle_irq_errors(dsi, irqstatus, vcstatus, ciostatus);
> =20
>  	dsi_collect_irq_stats(dsi, irqstatus, vcstatus, ciostatus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dsi-uaf-v2=
-1-dbb4aa0f0b8e@kemnade.info?part=3D1
