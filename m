Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB00C5DF85
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC60510EE69;
	Wed, 19 Aug 2026 16:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZQ0fpUUF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E0A10EE69
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:15:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A147660A92;
 Wed, 19 Aug 2026 16:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439931F000E9;
 Wed, 19 Aug 2026 16:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787156140;
 bh=BUmaf+mKw3B5vqUwZJTDaQmYkUpxboKi8p8LA5RLipc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZQ0fpUUFzarLtT+aHQTctVK5rD2UjZQiQfj7oX/x3JvEhJd68FGltkQSCWsPypM1W
 8BVeW7xPwgfb8rQh3mmDE++EzgLXP6zd9bvw7qvqthXbTcjyIez4UyQybKs/24IAGN
 I7tOTE/fc0S2vZYass+qITHGHhaL+S6z1l4DT51iV3osfOrO6ElzY++1W4XyR1laRF
 fCu1lbZbwJr370u9EEI5xcZd/O8jnNGHrUvmW4JRDrZdVS7TCp5MZL0GtT1E8A1RDf
 1/xKiEkiUEaLGSPb6yJ2+PzA75TgcmXBh9MmsSMJoMGmyZEsfqODJ4j7qkQFCI9y3E
 wnCjTCQHd8eng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] drm/nouveau/kms/nv50-: Add
 nouveau_encoder->audio.crtc
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819155934.154125-6-lyude@redhat.com>
References: <20260819155934.154125-1-lyude@redhat.com>
 <20260819155934.154125-6-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 16:15:39 +0000
Message-Id: <20260819161540.439931F000E9@smtp.kernel.org>
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
- [Medium] PIOR encoders do not clear `audio.crtc` when disabled, leading t=
o stale CRTC pointers, ghost ELD reporting, and missing ALSA unplug notific=
ations.
--

--- Patch [5]: [PATCH v2 5/6] drm/nouveau/kms/nv50-: Add nouveau_encoder->a=
udio.crtc ---
commit 0aca92d5a854c753a64fd874b928d45d30c64cde
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Add nouveau_encoder->audio.crtc

This replaces nouveau_encoder->crtc with a new variable
nouveau_encoder->audio.crtc to handle state-tracking for audio.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index d038743d1382a..fbb874b11d7a8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -636,7 +636,7 @@ nv50_audio_component_get_eld(struct device *kdev, int=
 port, int dev_id,
> =20
>  		nv_encoder =3D nouveau_encoder(encoder);
>  		nv_connector =3D nv_encoder->conn;
> -		nv_crtc =3D nouveau_crtc(nv_encoder->crtc);
> +		nv_crtc =3D nv_encoder->audio.crtc;
> =20
>  		if (!nv_crtc || nv_encoder->outp.or.id !=3D port || nv_crtc->index !=
=3D dev_id)
>  			continue;

[Severity: Medium]
Will this lead to stale CRTC pointers and ghost ELD reporting for PIOR
encoders?

Looking at nv50_pior_atomic_disable(), it explicitly clears the main crtc
pointer:

    core->func->pior->ctrl(core, nv_encoder->outp.or.id, ctrl, NULL);
    nv_encoder->crtc =3D NULL;

Since this function was not updated to clear the new audio.crtc pointer
or call nv50_audio_disable(), won't a disabled PIOR encoder leave its
audio hardware state enabled?

If a PIOR display output is disabled, it seems like
nv50_audio_component_get_eld() will still see a non-NULL audio.crtc,
causing it to return ELD for a disabled encoder and miss ALSA unplug
notifications.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819155934.1541=
25-1-lyude@redhat.com?part=3D5
