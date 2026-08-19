Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B228C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 16:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDD7210E173;
	Wed, 19 Aug 2026 16:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="odtcaGx2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2FE410E173
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 16:08:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62D7040702;
 Wed, 19 Aug 2026 16:08:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C9E1F000E9;
 Wed, 19 Aug 2026 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787155721;
 bh=wN8jFoJWAgS78B0uCti7ywHFK0RjhF8FuKvhVKEnz3o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=odtcaGx2sXRapNJItiq5Ty7s9mKhhyuMBhOjj7beG49/UsJuBWVCsxgDL82g6E7qM
 Gv9blJFMyrDPZhQsBdDbX1h/SsKcGwfEg7uzbWtFF7GmldToX0DgnZL/o7yz1R1llb
 yAMKsXiHSi6LKWdz+44nGCRlBmSGol+brnwcvyGiSDlp153udjmsLGSJhgGBjSn/5H
 nNwPYGkxHVV17ibH1VepJg9A+em6F7LDb+ELasUyk5WubFiQdSoYvTboRGYMjRX9S0
 mEzHZ0RceRLFlYns3ZwjTXLw+uONtpih8Q7y5iJ7FCPn7nMdYcIhNWQdu585DejMAz
 TLwaGQQ7J3zGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] drm/nouveau/kms/nv50-: Obliterate
 nouveau_encoder->crtc
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260819155934.154125-7-lyude@redhat.com>
References: <20260819155934.154125-1-lyude@redhat.com>
 <20260819155934.154125-7-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 16:08:40 +0000
Message-Id: <20260819160841.31C9E1F000E9@smtp.kernel.org>
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
- [High] Encoder atomic disable callback calls a sleeping function, violati=
ng atomic context rules.
--

--- Patch [6]: [PATCH v2 6/6] drm/nouveau/kms/nv50-: Obliterate nouveau_enc=
oder->crtc ---
commit 9b6ea3488cdb59d28deb854dd17d63d4b20e1a27
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Obliterate nouveau_encoder->crtc

This commit removes the nouveau_encoder->crtc tracking artifact from the
pre-atomic modesetting days. It relies entirely on the atomic state to
track the assigned CRTC, as all redundant legacy tracking users have
been removed.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
[ ... ]
> @@ -1634,7 +1631,6 @@ nv50_sor_atomic_disable(struct drm_encoder *encoder=
, struct drm_atomic_commit *s
> =20
>  	nv_encoder->update(nv_encoder, head->base.index, NULL, 0, 0);
>  	nv50_audio_disable(encoder, &head->base);

[Severity: High]
This is a pre-existing issue, but I noticed a potential sleep-in-atomic bug
in this execution path.

The nv50_sor_atomic_disable() function is an encoder atomic disable callbac=
k,
which runs in an atomic context during non-blocking commits. It explicitly
calls nv50_audio_disable():

nv50_sor_atomic_disable()
  nv50_audio_disable(encoder, &head->base);

Looking at nv50_audio_disable(), it acquires a mutex:

nv50_audio_disable()
  mutex_lock(&drm->audio.lock);

Can this cause system instability or kernel warnings by calling a sleeping
function (mutex_lock) from an atomic context?

> -	nv_encoder->crtc =3D NULL;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819155934.1541=
25-1-lyude@redhat.com?part=3D6
