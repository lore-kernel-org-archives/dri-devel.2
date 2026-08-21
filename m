Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A99C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:35:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 353DB10F319;
	Fri, 21 Aug 2026 15:35:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oIwDYD22";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E62610F319
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:35:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8682C414B7;
 Fri, 21 Aug 2026 15:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1941F000E9;
 Fri, 21 Aug 2026 15:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787326526;
 bh=sG0HHK6+Yj1gmmcLrZPZaxtPvAzeV+Pl0X401caA/LU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oIwDYD22VF4swd6gYMaecpN23aFXY78nhyJgdBQ3R4G05uNDoZfrFpHWsyVbx0b8y
 FJAfX09TrNy1tuHtRK4rebGXuc63URZ5+wb7aWDv+77yPMf7TugRV8tDkW6DeHOCLU
 IqfkgC/mZFK2D42kOA14ToMLg68fytGrpYd0dkSqDTDq9xDm9uV280yH60n1Rc61XV
 JVFR8htwxS1xls3Y2dLsFPoCV3NwgY+GMJ3CzBe4wRky1jhEHLSCi7qpMcDdIVsmKO
 +KiHkPxqJ4M9+L2qyVInXpLhbeAijafkhC0upuWYFEqaw00CcfQFYAG0irER/5CHCJ
 +QQV1B79FFVOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] drm/nouveau: unsubscribe the channel-kill event
 before the fence context
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178732578167.167481.14789825868710929167@gmail.com>
References: <178732578167.167481.5619512544301226563@gmail.com>
 <178732578167.167481.14789825868710929167@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 15:35:25 +0000
Message-Id: <20260821153526.4A1941F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Race condition in nouveau_fence_context_del between cancel_work_sy=
nc and nvif_event_dtor leads to use-after-free of fctx.
- [High] Missing cancel_work_sync for irq_work in nouveau_connector_destroy=
 leads to use-after-free of the connector.
--

--- Patch [1]: [PATCH v4 1/3] drm/nouveau: unsubscribe the channel-kill eve=
nt before the fence context ---
commit 4ae9b89defb4e27bc74c023fe090b6ae974e3378
Author: Marek Czernohous <mczernohous@gmail.com>

drm/nouveau: unsubscribe the channel-kill event before the fence context

nouveau_channel_del() tears the fence context down first and only drops
the channel-kill subscription later, which can cause a use-after-free
if a kill event is delivered in that window. This patch drops the
subscription before anything it depends on is torn down.

> diff --git a/drivers/gpu/drm/nouveau/nouveau_chan.c b/drivers/gpu/drm/nou=
veau/nouveau_chan.c
> index 598513f604493..f142f63105966 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_chan.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_chan.c
> @@ -90,6 +90,14 @@ nouveau_channel_del(struct nouveau_channel **pchan)
>  {
>  	struct nouveau_channel *chan =3D *pchan;
>  	if (chan) {
> +		/*
> +		 * Drop the kill-event subscription first.  Its handler
> +		 * dereferences chan->fence, which the fence context teardown
> +		 * below frees, so leaving it armed across the teardown leaves
> +		 * a window for a use-after-free.
> +		 */
> +		nvif_event_dtor(&chan->kill);
> +
>  		if (chan->fence)
>  			nouveau_fence(chan->cli->drm)->context_del(chan);
> =20
[ ... ]
> @@ -100,7 +108,6 @@ nouveau_channel_del(struct nouveau_channel **pchan)
>  		nvif_object_dtor(&chan->nvsw);
>  		nvif_object_dtor(&chan->gart);
>  		nvif_object_dtor(&chan->vram);
> -		nvif_event_dtor(&chan->kill);
>  		nvif_object_dtor(&chan->user);
>  		nvif_mem_dtor(&chan->mem_userd);
>  		nouveau_vma_del(&chan->sema.vma);

[Severity: High]
This isn't a bug introduced by this patch, but looking at similar teardown
paths, is there a race condition in nouveau_fence_context_del() between
cancel_work_sync() and nvif_event_dtor()?

drivers/gpu/drm/nouveau/nouveau_fence.c:nouveau_fence_context_del() {
	...
	cancel_work_sync(&fctx->uevent_work);
	nouveau_fence_context_kill(fctx, 0);
	nvif_event_dtor(&fctx->event);
	...
}

If a hardware interrupt fires in the narrow window after cancel_work_sync()
but before nvif_event_dtor(), could the event handler schedule the work
again?

The work would remain pending on the workqueue while fctx is subsequently
freed, leading to a use-after-free when the work executes.


[Severity: High]
This is another pre-existing issue in a similar teardown path, but is there=
 a
missing cancel_work_sync() for irq_work in nouveau_connector_destroy()?

drivers/gpu/drm/nouveau/nouveau_connector.c:nouveau_connector_destroy() {
	...
	nvif_event_dtor(&nv_connector->irq);
	nvif_event_dtor(&nv_connector->hpd);
	kfree(nv_connector->edid);
	drm_connector_unregister(connector);
	...
}

When a connector is destroyed, it calls nvif_event_dtor() to unregister the
hardware event, but does not appear to call cancel_work_sync() for
nv_connector->irq_work.

If an IRQ fires right before the event is destroyed, the handler schedules
irq_work:

drivers/gpu/drm/nouveau/nouveau_connector.c:nouveau_connector_irq() {
	...
	schedule_work(&nv_connector->irq_work);
	return NVIF_EVENT_KEEP;
}

Because the work is never canceled, will it eventually execute on freed
memory after the connector has been freed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178732578167.167481=
.5619512544301226563@gmail.com?part=3D1
