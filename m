Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3B6C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:09:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9392310E1C1;
	Sat, 15 Aug 2026 20:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FK768pQW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1327610E1C1
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 20:09:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0BBAB60052;
 Sat, 15 Aug 2026 20:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A1131F000E9;
 Sat, 15 Aug 2026 20:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786824554;
 bh=Gt9+r6vyCV1URF6sdF9ZMK+bNyTp0pyuHBy6PBKQ+UE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FK768pQWgA3Pezmd7Ih4D+nnSczhe0+yEEAOEAB729sRrvm/z2BdkuAmWtu11Nj3n
 rGBtIgvGJV/rexMApu/ij/QfvKcDX4XhEdbWj/cmU9hNPrN66qu7rQeJUljQByexRg
 jXrV6uEnvRAzvuRDRUVfrBE6s3YH+6++wYyU7kXTNgOhmfXRttBiGk9VhChbwtgPdE
 8u/5D155aoNHwDQLeCfQ+EmQzSHGxPBapMNMBfd4EQreiOoPZCE0jcbwxtVEXDLDgh
 6e3N7z8QQC8Y3AqzqTE9+DjDO9fBj1qDgayPnBiryAjuXOYVXcyTWFRdioqrDx3tXe
 OTpSu/QXR7hhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/nouveau: destroy the fence event before
 cancelling its work
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178682366002.3748010.12779628082366287968@gmail.com>
References: <178682366001.3748010.7798811159846779765@gmail.com>
 <178682366002.3748010.12779628082366287968@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 20:09:14 +0000
Message-Id: <20260815200914.8A1131F000E9@smtp.kernel.org>
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
- [Critical] Moving `nvif_event_dtor()` before `nouveau_fence_context_kill(=
)` introduces an unprotected Time-of-Check to Time-of-Use (TOCTOU) race con=
dition that results in a NULL pointer dereference in `nvif_object_ioctl`.
--

--- Patch [1]: [PATCH 1/3] drm/nouveau: destroy the fence event before canc=
elling its work ---
commit 248f9b5f2479dc65d3572babf739eb3883d7b9f7
Author: Marek Czernohous <marek@czernohous.de>

drm/nouveau: destroy the fence event before cancelling its work

This commit reorders the teardown sequence in nouveau_fence_context_del() by
moving nvif_event_dtor() before cancel_work_sync() and
nouveau_fence_context_kill(). It aims to prevent a newly arriving interrupt
from re-arming the work that was just cancelled.

Link: https://sashiko.dev/#/patchset/20260812231330.705425-1-mczernohous@gm=
ail.com?part=3D1

> diff --git a/drivers/gpu/drm/nouveau/nouveau_fence.c b/drivers/gpu/drm/no=
uveau/nouveau_fence.c
> index edbe9e08ba0fd..4a3698dc2cd14 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_fence.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_fence.c
> @@ -96,9 +96,9 @@ nouveau_fence_context_kill(struct nouveau_fence_chan *f=
ctx, int error)
>  void
>  nouveau_fence_context_del(struct nouveau_fence_chan *fctx)
>  {
> +	nvif_event_dtor(&fctx->event);
>  	cancel_work_sync(&fctx->uevent_work);
>  	nouveau_fence_context_kill(fctx, 0);

[Severity: Critical]
Does moving nvif_event_dtor() before nouveau_fence_context_kill() introduce=
 a
Time-of-Check to Time-of-Use (TOCTOU) race condition?

Since nouveau_fence_context_kill() hasn't run yet, the fences are still
active and unsignaled. If Thread A is polling a fence and calls
nouveau_fence_enable_signaling() which reaches nvif_event_allow(), it might
evaluate nvif_event_constructed() right before Thread B destroys the event:

Thread A:
drivers/gpu/drm/nouveau/nvif/event.c:nvif_event_allow() {
	if (nvif_event_constructed(event)) {

Thread B concurrently cleans up the channel:
drivers/gpu/drm/nouveau/nouveau_fence.c:nouveau_fence_context_del() {
	nvif_event_dtor(&fctx->event);
	...
drivers/gpu/drm/nouveau/nvif/object.c:nvif_object_dtor() {
	nvif_object_ioctl(object, &args, sizeof(args), NULL);
	object->client =3D NULL;

Thread A then continues and calls into nvif_mthd():
drivers/gpu/drm/nouveau/nvif/event.c:nvif_event_allow() {
		int ret =3D nvif_mthd(&event->object, NVIF_EVENT_V0_ALLOW, ...);
		...
drivers/gpu/drm/nouveau/nvif/object.c:nvif_object_ioctl() {
	struct nvif_client *client =3D object->client;
	/* ... */
	return client->driver->ioctl(client->object.priv, data, size, hack);

Could Thread A read the stale object->client as NULL and fatally dereference
it here, since both polling on an exported sync_file fd and channel cleanup
are accessible to unprivileged userspace?

> -	nvif_event_dtor(&fctx->event);
>  	fctx->dead =3D 1;
> =20
>  	/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178682366001.374801=
0.7798811159846779765@gmail.com?part=3D1
