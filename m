Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBA6C5DF7D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105C510ED04;
	Wed, 19 Aug 2026 00:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jPUK+ez4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B2BB10ED04
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 00:04:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F9EC4018E;
 Wed, 19 Aug 2026 00:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C885F1F000E9;
 Wed, 19 Aug 2026 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787097864;
 bh=7aShhx26CRVPqu3vnIVyEXX9HRod1kLmNIW35PkjK9U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jPUK+ez4y3WJSB2XwDE3AX7XbfmfhnXMNWmR6c48ionhNMIXrHSmPF8oUzBALmkJr
 dlBXEXhN5qqNykuWExn9DAprJOHUNLyxARK7TA3L8g7s0FKj7rNy4rbvEz+uOHZsvn
 jsyVAzgkzAXTDQDJTTbci0CUxB/xVOPf6ksw8JmzWc2IUREeHMqb3axh0XgdEsH85c
 npZHko2vr01hbl5DePS7luWqCnIVui394doc4CWm4EECQzYYfgya65uqpo8MbMp5cQ
 oQAcRSKe3rSfGvb2t8wGCUpqIkMWkx0Ixz36jMghRzTUaW4HFElVLkwF7M5a9VCAjx
 JB9TYfmU8zbsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc
 in nv50_disp_atomic_commit_core()
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260818235637.1738055-5-lyude@redhat.com>
References: <20260818235637.1738055-1-lyude@redhat.com>
 <20260818235637.1738055-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 00:04:24 +0000
Message-Id: <20260819000424.C885F1F000E9@smtp.kernel.org>
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
- [High] Unconditional CRTC lookup and NULL check bypasses the output disab=
le path, leaking hardware resources and causing spurious warnings.
--

--- Patch [4]: [PATCH 4/6] drm/nouveau/kms/nv50-: Stop using nv_encoder->cr=
tc in nv50_disp_atomic_commit_core() ---
commit 3c40fb984475628cc9b548d32d5295add5289647
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/kms/nv50-: Stop using nv_encoder->crtc in nv50_disp_atomic_comm=
it_core()

This commit replaces direct access to nv_encoder->crtc with a proper lookup
from the new atomic state in the core commit function. It adds a warning
and continues the loop if the new CRTC is not found.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index f19820dc055ae..63d554e97fb62 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -2171,10 +2171,14 @@ nv50_disp_atomic_commit_core(struct drm_atomic_co=
mmit *state, u32 *interlock)
>  	list_for_each_entry(outp, &atom->outp, head) {
>  		if (outp->encoder->encoder_type !=3D DRM_MODE_ENCODER_DPMST) {
>  			struct nouveau_encoder *nv_encoder =3D nouveau_encoder(outp->encoder);
> +			struct nouveau_crtc *nv_crtc =3D nv50_outp_get_new_crtc(state, nv_enc=
oder);
> +
> +			if (drm_WARN_ON(drm->dev, !nv_crtc))
> +				continue;

[Severity: High]
When an output is being disabled (for instance, when a monitor is unplugged=
),
wouldn't nv50_outp_get_new_crtc() correctly return NULL here since the enco=
der
is no longer assigned to a CRTC?

If this unconditionally triggers the drm_WARN_ON and early return via the
continue statement, it appears it will completely bypass the cleanup path
below.

Could this skip the call to nvif_outp_release(&nv_encoder->outp), leaking t=
he
hardware resource and generating a spurious warning every time a display is
disabled?

> =20
>  			if (outp->enabled) {
> -				nv50_audio_enable(outp->encoder, nouveau_crtc(nv_encoder->crtc),
> -						  nv_encoder->conn, NULL, NULL);
> +				nv50_audio_enable(outp->encoder, nv_crtc, nv_encoder->conn, NULL,
> +						  NULL);
>  				outp->enabled =3D outp->disabled =3D false;
>  			} else {
>  				if (outp->disabled) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818235637.1738=
055-1-lyude@redhat.com?part=3D4
