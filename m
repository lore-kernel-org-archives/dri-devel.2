Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92276C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04DAD10E523;
	Wed, 19 Aug 2026 00:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ivjTpYhf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C509310E523
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 00:10:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1749A601DE;
 Wed, 19 Aug 2026 00:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B0E1F000E9;
 Wed, 19 Aug 2026 00:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787098252;
 bh=EGyMPGJHiC8hPsdFBfImWr9nQ8GX5tFUpR4gWQoZt54=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ivjTpYhfE28K6wGxCrIClNgwmIWE4fD0uX3JPvHQd1JXVAW84IXhXJwNPO113yWmw
 U6amdw7aVFwFuSeEP2ptiX9sCYvea6vIbXOLA/WDaDR/hQeHNlJ4g7DozQyfyCFaF6
 HJGRFh7/SFbjhR+Hd4Ektq4JOaw8Ywo/MkZYFUM9oTe5QCHSr7p/fzBuxwziMAvu1f
 4gmX4XRhfr2N1XGW3xt2HPhsGEGrS9rIaFqhwMhuP4V7oM4ZEAj9dHP5o98bVv0MLB
 y1qp95rerIcUL/BhaLtAsUs0lTKucH8POkh2gzZcJjj5yla8j/Uv79Jz7pI/fhcU4A
 NZNO+oR1B6vHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] drm/nouveau/kms/nv50-: Add nouveau_encoder->audio.crtc
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818235637.1738055-6-lyude@redhat.com>
References: <20260818235637.1738055-1-lyude@redhat.com>
 <20260818235637.1738055-6-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 00:10:52 +0000
Message-Id: <20260819001052.A7B0E1F000E9@smtp.kernel.org>
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
- [Medium] PIOR encoders do not clear `audio.crtc` on disable, leading to s=
tale audio state being reported.
--

--- Patch [5]: [PATCH 5/6] drm/nouveau/kms/nv50-: Add nouveau_encoder->audi=
o.crtc ---
commit d00b281328e092a25d08552356c0a7fc11880073
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Add nouveau_encoder->audio.crtc

This commit adds an audio.crtc pointer to track the assigned CRTC for an
encoder outside of modesetting locks. It replaces the usage of
nouveau_encoder->crtc in the audio ELD retrieval path.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 63d554e97fb62..3bfc04f7ef602 100644
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
Will this cause stale audio state to be reported when PIOR encoders are
disabled?

Before this patch, checking the cleared crtc pointer successfully skipped
the disabled encoder. However, it looks like nv50_pior_atomic_disable()
only clears the old crtc pointer, but not the new audio.crtc pointer:

nv50_pior_atomic_disable()
{
	...
	core->func->pior->ctrl(core, nv_encoder->outp.or.id, ctrl, NULL);
	nv_encoder->crtc =3D NULL;
}

Does nv_encoder->audio.crtc also need to be cleared here, or does
nv50_audio_disable() need to be called in nv50_pior_atomic_disable() to
prevent userspace from receiving stale ELD data for a deactivated display?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818235637.1738=
055-1-lyude@redhat.com?part=3D5
