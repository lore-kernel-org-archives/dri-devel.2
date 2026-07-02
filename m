Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A889CC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15DE910F4AD;
	Thu,  2 Jul 2026 16:05:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NhdwKROA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D9B610F4AD
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 16:05:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9F873601EE;
 Thu,  2 Jul 2026 16:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340B11F000E9;
 Thu,  2 Jul 2026 16:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783008341;
 bh=X+a2ynDNyWNMFBrH1rBckhb61px7ZqNYhHrVo1Uct5g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NhdwKROAvXtpk9WbdYp2Tqo3V3Pn+YBWeqBZiBXBQbhKdrHoVnqzn7Q9R/n0jyK87
 tx1HA2dGX0wTLerCBRvd8khJ5nsYRs66hLhL71Hwiw5B5GSpUD4BecehVgAR4bix7f
 eq+3vTfgmka+/TkiyutuFi894EHMoG5CRBCSSP4SOCMDrAvNYGO0OnkVybof0+9QQF
 aIut/XdZRQ9OsZZfIaNpqKzjUhbdUeSHey10yg5cvEDuaUzT3/oJBtwAswkqLikA+A
 ibrVvaKQX2GTxXbZxXUeFCG/k1E5fYZBs7XDCYqT17zRsiZ5F8xHTc11p1tYLLTqoL
 3IEfevymQXsyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fb: omap2: dsi: do not copy isr table
To: "Andreas Kemnade" <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-fbomap-uaf-fix-v1-1-6417edf9d3e7@kemnade.info>
References: <20260702-fbomap-uaf-fix-v1-1-6417edf9d3e7@kemnade.info>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 16:05:40 +0000
Message-Id: <20260702160541.340B11F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The identical use-after-free vulnerability fixed in the fbdev OMAP=
 DSI driver remains unpatched in the equivalent DRM driver.
- [High] The Use-After-Free vulnerability fixed in the DSI driver is identi=
cally present in the DISPC hardware interrupt demultiplexer.
- [High] The driver fails to cancel the delayed work `framedone_timeout_wor=
k` and `te_timer` in its unbind/teardown path, causing a Use-After-Free.
--

commit c84d1fd5cdf35436c608e4883f1ea5ab4237c8b4
Author: Andreas Kemnade <andreas@kemnade.info>

fb: omap2: dsi: do not copy isr table
   =20
This commit prevents a use-after-free in the omap2 dsi driver by no longer
copying the ISR table and dropping the lock before executing handlers.
This avoids a race condition where a stack-allocated object could be freed
while the lockless ISR copy is still being processed.

> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c b/drivers/video/f=
bdev/omap2/omapfb/dss/dsi.c
> index 330d9fb7d2b00..d98db01fdd39c 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dsi.c
[ ... ]
> @@ -838,15 +836,10 @@ static irqreturn_t omap_dsi_irq_handler(int irq, vo=
id *arg)
>  		timer_delete(&dsi->te_timer);

[Severity: High]
This is a pre-existing issue, but does the driver fail to cancel this timer
and related work queues during teardown?

Looking at dsi_unbind(), it returns without cancelling pending work or time=
rs:

drivers/video/fbdev/omap2/omapfb/dss/dsi.c:dsi_unbind() {
    ...
    of_platform_depopulate(&dsidev->dev);
    WARN_ON(dsi->scp_clk_refcount > 0);
    dss_pll_unregister(&dsi->pll);
    dsi_uninit_output(dsidev);
    pm_runtime_disable(&dsidev->dev);
    ...
}

If framedone_timeout_work or te_timer expires after the driver is unbound a=
nd
the devres subsystem frees the dsi structure, will this result in a
use-after-free?

>  #endif
> =20
> -	/* make a copy and unlock, so that isrs can unregister
> -	 * themselves */
> -	memcpy(&dsi->isr_tables_copy, &dsi->isr_tables,
> -		sizeof(dsi->isr_tables));
> =20
> +	dsi_handle_isrs(&dsi->isr_tables, irqstatus, vcstatus, ciostatus);
>  	spin_unlock(&dsi->irq_lock);

[Severity: High]
This isn't a bug introduced by this patch, but it appears the identical
use-after-free vulnerability you are fixing here remains unpatched in the
equivalent DRM driver.

Does drivers/gpu/drm/omapdrm/dss/dsi.c:omap_dsi_irq_handler() need the same
fix? It still copies the table and drops the lock:

drivers/gpu/drm/omapdrm/dss/dsi.c:omap_dsi_irq_handler() {
    ...
    memcpy(&dsi->isr_tables_copy, &dsi->isr_tables, sizeof(dsi->isr_tables)=
);
    spin_unlock(&dsi->irq_lock);
    dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
    ...
}

This could still race with a timeout in dsi_sync_vc_vp(), which creates a
completion on the stack:

drivers/gpu/drm/omapdrm/dss/dsi.c:dsi_sync_vc_vp() {
    DECLARE_COMPLETION_ONSTACK(completion);
    ...
}

[Severity: High]
This is also a pre-existing issue, but this same vulnerability pattern seems
to be present in the DISPC hardware interrupt demultiplexer.

Does drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c:omap_dispc_irq_han=
dler()
need to be updated? It makes a similar lockless copy:

drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c:omap_dispc_irq_handler(=
) {
    ...
    memcpy(registered_isr, dispc_compat.registered_isr, sizeof(registered_i=
sr));
    spin_unlock(&dispc_compat.irq_lock);
    ...
}

This could race with dispc_mgr_disable_lcd_out(), which registers a
stack-allocated completion as an ISR and waits for a timeout:

drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c:dispc_mgr_disable_lcd_o=
ut() {
    DECLARE_COMPLETION_ONSTACK(framedone_compl);
    ...
}

> =20
> -	dsi_handle_isrs(&dsi->isr_tables_copy, irqstatus, vcstatus, ciostatus);
> -
>  	dsi_handle_irq_errors(dsidev, irqstatus, vcstatus, ciostatus);
> =20
>  	dsi_collect_irq_stats(dsidev, irqstatus, vcstatus, ciostatus);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-fbomap-uaf=
-fix-v1-1-6417edf9d3e7@kemnade.info?part=3D1
