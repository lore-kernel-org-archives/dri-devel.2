Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325ADC5DF6E
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 13:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F40C10E136;
	Sun, 16 Aug 2026 13:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mCfe19ds";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C0610E136
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 13:17:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DE25600E2;
 Sun, 16 Aug 2026 13:17:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B99B1F000E9;
 Sun, 16 Aug 2026 13:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786886275;
 bh=IugcH3Qq9avsEIv1LPH3JlUxe564U1MEbhpB3Dh87SE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mCfe19dsmg1R4ckN2I/OSyNVUWknuHVf4CovnV5kri3paDrhnmXYB7+a0YYdrUf/i
 adzS1IE3cSDkaSr3oIlECYJHbiFBGohoTsiNhi5OlUKErD3BicdFal2vJ4q5bb2MfS
 hcLWX2pSuxxVvS89PcH9BmLtY+qeeUC7RcK7mZ8mUzX98j7iecz1br4cD4c66nNrUr
 bI+g3Oj7yfV2Ic+6Ouvqmj6ygOb3+aTnCRAUOFtz7Q/ps9V54Ki7Tz2inc8/rmRwa6
 VjvgkPgTGIi9YP4Z3jimX9pMd8uZhlurrgru/+lKPbjyKXbpykA6qoUX02y/QlEHJU
 2xfBswx9YuboA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/nouveau/kms: guard NULL crtc in
 nv50_sor_atomic_disable()
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178688574402.522643.5471719764843371376@gmail.com>
References: <178688574400.522643.6695278742335367229@gmail.com>
 <178688574402.522643.5471719764843371376@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 13:17:54 +0000
Message-Id: <20260816131755.1B99B1F000E9@smtp.kernel.org>
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
- [High] The patch adds a guard against disable-without-enable or double-di=
sable in `nv50_sor_atomic_disable()`, but misses an identical structural vu=
lnerability in `nv50_msto_atomic_disable()`.
--

--- Patch [2]: [PATCH v4 2/2] drm/nouveau/kms: guard NULL crtc in nv50_sor_=
atomic_disable() ---
commit 7ccc8c2fed1546597f7a2ed45ab47da4012b6d66
Author: Marek Czernohous <marek@czernohous.de>

drm/nouveau/kms: guard NULL crtc in nv50_sor_atomic_disable()

nv50_sor_atomic_disable() unconditionally computes
nv50_head(nv_encoder->crtc) and dereferences the result a few lines
later. nv_encoder->crtc is nouveau's own shadow pointer, set in
.atomic_enable and cleared at the end of .atomic_disable.
This patch restores the guard, as drm_WARN_ON_ONCE() instead of a
silent return.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 364227f5456f1..f532b0ed88809 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1565,16 +1565,36 @@ static void
>  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_c=
ommit *state)
>  {
>  	struct nouveau_encoder *nv_encoder =3D nouveau_encoder(encoder);
> -	struct nv50_head *head =3D nv50_head(nv_encoder->crtc);
> +	struct nv50_head *head;
>  #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT

[Severity: High]
This isn't a bug introduced by this patch, but while fixing the
disable-without-enable issue here, does a similar vulnerability
exist in nv50_msto_atomic_disable() in the same file?

Looking at nv50_msto_atomic_disable():

static void
nv50_msto_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_com=
mit *state)
{
	struct nv50_msto *msto =3D nv50_msto(encoder);
	struct nv50_mstc *mstc =3D msto->mstc;
	struct nv50_mstm *mstm =3D mstc->mstm;

If this is called during session teardown without a matching
.atomic_enable, couldn't msto->mstc be NULL, leading to a NULL pointer
dereference when accessing mstc->mstm?

> -	struct nouveau_connector *nv_connector =3D nv50_outp_get_old_connector(=
state, nv_encoder);
>  	struct nouveau_drm *drm =3D nouveau_drm(nv_encoder->base.base.dev);
> -	struct nouveau_backlight *backlight =3D nv_connector->backlight;
> -	struct drm_dp_aux *aux =3D &nv_connector->aux;
>  	int ret;
> +#endif
> =20
> +	/* nv_encoder->crtc is the driver's shadow pointer, set in
> +	 * .atomic_enable (and by the boot-time hardware readback) and
> +	 * cleared at the end of this function.  NULL here
> +	 * means disable-without-enable or a double disable; bail before
> +	 * container_of() turns it into a bogus head pointer (checking the
> +	 * result would not work, container_of(NULL) is never NULL).  The
> +	 * encoder release is handled by the commit_tail release loop, so
> +	 * there is nothing to clean up here.
> +	 */
> +	if (drm_WARN_ON_ONCE(encoder->dev, !nv_encoder->crtc))
> +		return;
> +	head =3D nv50_head(nv_encoder->crtc);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178688574400.522643=
.6695278742335367229@gmail.com?part=3D2
