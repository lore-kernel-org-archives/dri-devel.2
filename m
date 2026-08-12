Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1338FC5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:30:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 392CB10E3E1;
	Wed, 12 Aug 2026 23:30:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mhGmc6WO";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29F1E10E3E1
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:30:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F2D0600BB;
 Wed, 12 Aug 2026 23:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159301F000E9;
 Wed, 12 Aug 2026 23:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786577422;
 bh=J/n2X2zKg1ahCtDxkl8tagOc03XGwaI5WLhbfjOrtd8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mhGmc6WOtbeCItjw5OI/PvIDuO/z1OV1LT7mqO5jZrv28YPQSXvlCwW4KqxVGu6x4
 L1s7zLeLp1jUStWnUeHYSWDeeGkMgCyBC6XQqiMkInDF+xafwTUIL5zduBBw21AKMp
 RuPnkX58YEcd/3JlR6aO4yDZNpYRf/TT+IF7f9OZH+fOFcHKLJDm2YCgJYaZBshCO/
 b8gxQDuQXaI3mWY3lJGY2v5lKI+/Jj5Z4Xx53vxmfIKhCwaJLmjOH4XjqwYvnaJ6Jz
 Sfl4KrpQUVUFHVw1vjDex2PPfsWSVPCf4ITZv2bFWe1xVtv/smgEvhwL/K+xlNTN1J
 b5jQFlsA0hJLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] drm/nouveau: unsubscribe the channel-kill event
 before the fence context
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812231330.705425-2-mczernohous@gmail.com>
References: <20260812231330.705425-1-mczernohous@gmail.com>
 <20260812231330.705425-2-mczernohous@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:30:21 +0000
Message-Id: <20260812233022.159301F000E9@smtp.kernel.org>
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
- [High] Canceling `uevent_work` before destroying `fctx->event` in `nouvea=
u_fence_context_del` leaves a window for use-after-free.
- [High] `nouveau_connector_destroy()` frees the connector without cancelli=
ng `nv_connector->irq_work`, leading to a UAF.
--

--- Patch [1]: [PATCH v3 1/4] drm/nouveau: unsubscribe the channel-kill eve=
nt before the fence context ---
commit a14b59dbc876448fa7fc08aa6ef35ba9137e4909
Author: Marek Czernohous <marek@czernohous.de>

drm/nouveau: unsubscribe the channel-kill event before the fence context

nouveau_channel_del() tears the fence context down first and only drops
the channel-kill subscription later. This leaves a race window where a kill
event can be delivered and attempt to access a freed fence context. This
patch drops the subscription before anything it depends on is torn down.

Fixes: ea13e5abf807 ("drm/nouveau: signal pending fences when channel has b=
een killed")
Cc: stable@vger.kernel.org

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

[Severity: High]
This isn't a bug introduced by this patch, but I noticed a similar pattern
in nouveau_fence_context_del() inside=20
drivers/gpu/drm/nouveau/nouveau_fence.c:

void
nouveau_fence_context_del(struct nouveau_fence_chan *fctx)
{
	cancel_work_sync(&fctx->uevent_work);
	nouveau_fence_context_kill(fctx, 0);
	nvif_event_dtor(&fctx->event);
        ...

If a hardware event triggers exactly in the window between cancel_work_sync=
()
and nvif_event_dtor(), nouveau_fence_wait_uevent_handler() unconditionally
reschedules the work via schedule_work(&fctx->uevent_work).=20

Does this leave a window where the work remains on the queue after the fctx
structure is freed, resulting in a use-after-free?


[Severity: High]
This is also a pre-existing issue, but there is a similar teardown problem
in nouveau_connector_destroy() inside=20
drivers/gpu/drm/nouveau/nouveau_connector.c:

static void
nouveau_connector_destroy(struct drm_connector *connector)
{
	struct nouveau_connector *nv_connector =3D nouveau_connector(connector);
	nvif_event_dtor(&nv_connector->irq);
	nvif_event_dtor(&nv_connector->hpd);
        ...
	kfree(connector);
}

The connector is freed without calling cancel_work_sync(&nv_connector->irq_=
work)
to cancel any previously scheduled work.=20

If an interrupt fires just before or during nvif_event_dtor(), the work is
successfully scheduled on the system queue. When the queued work executes, =
it
will dereference the freed nv_connector pointer.=20

Should this function cancel the irq_work before freeing the connector?

[ ... ]

> @@ -100,7 +108,6 @@ nouveau_channel_del(struct nouveau_channel **pchan)
>  		nvif_object_dtor(&chan->nvsw);
>  		nvif_object_dtor(&chan->gart);
>  		nvif_object_dtor(&chan->vram);
> -		nvif_event_dtor(&chan->kill);
>  		nvif_object_dtor(&chan->user);
>  		nvif_mem_dtor(&chan->mem_userd);
>  		nouveau_vma_del(&chan->sema.vma);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812231330.7054=
25-1-mczernohous@gmail.com?part=3D1
