Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E2B4CD8CB9
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 07:39:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D1E510ED35;
	Thu, 11 Jun 2026 07:39:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hu2Ns6kV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E12610ED35
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 07:39:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0C5CC60098;
 Thu, 11 Jun 2026 07:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9009D1F00893;
 Thu, 11 Jun 2026 07:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781163541;
 bh=BhnSD1q2EQ2H+cKiLv2+Cwclj4nYtAnV+MBnPr+oH5w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hu2Ns6kVvXLnqdwDw3rY6WqgUP8LkyJaTLQHSXq609K0UvvgEZpllqaFuxPb33ADX
 9e3CBeH6j3UH6Su2pPJz2bid3S8RRXAT+ct9BeZYFY95378NSNWQmCP5RYKDrynXC6
 dh0VjLZvomZ7YmXsgjZ9ftre+jOTn5hIEdtdNj0Jn/aecwK5RnRS48XXqiKNSKHwid
 jUEqmFIPOJ2iPxFtewhB0nmLBuNEOGnwXVHtOOos7qO/D9QjuRpS7AGbQd7uM1D9Rc
 yf9q2MLtrUIJsuMe8Bhk2XJr6sWeS8nSskGkwfWakroqCR9UkuZ+eRjvbQeUNEWZSi
 O+JieXqTQIpwA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/nouveau/kms: guard NULL crtc in
 nv50_sor_atomic_disable()
To: "Marek Czernohous" <mczernohous@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <66ea307dd4fa080db27b2b9a0caa31b562d72c2b.1781162589.git.marek@czernohous.de>
References: <66ea307dd4fa080db27b2b9a0caa31b562d72c2b.1781162589.git.marek@czernohous.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 07:39:01 +0000
Message-Id: <20260611073901.9009D1F00893@smtp.kernel.org>
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
- [High] The early return added to guard against a NULL `nv_encoder->crtc` =
during inconsistent atomic disables is placed too late. When `CONFIG_DRM_NO=
UVEAU_BACKLIGHT` is enabled, the code unconditionally initializes and deref=
erences `nv_connector` (via `nv_connector->backlight`) before the new `!nv_=
encoder->crtc` safeguard is reached. In the exact state-tracking inconsiste=
ncies this patch aims to fix (e.g., disable without a matching enable), `nv=
50_outp_get_old_connector()` can return NULL, leading to a NULL pointer der=
eference.
--

commit c0ee57413f11f85e156ca80153f2707e59b79de5
Author: Marek Czernohous <mczernohous@gmail.com>

drm/nouveau/kms: guard NULL crtc in nv50_sor_atomic_disable()

This commit restores a NULL guard for the crtc pointer in
nv50_sor_atomic_disable() to prevent a kernel oops during VT switches and
Wayland session teardowns. The guard replaces a silent return with a warning
to ensure state-tracking inconsistencies remain visible without crashing.

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 6c3a8712d38ab..597bc64073a5c 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -1565,14 +1565,28 @@ static void
>  nv50_sor_atomic_disable(struct drm_encoder *encoder, struct drm_atomic_s=
tate *state)
>  {
>  	struct nouveau_encoder *nv_encoder =3D nouveau_encoder(encoder);
> -	struct nv50_head *head =3D nv50_head(nv_encoder->crtc);
> +	struct nv50_head *head;
>  #ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
>  	struct nouveau_connector *nv_connector =3D nv50_outp_get_old_connector(=
state, nv_encoder);
>  	struct nouveau_drm *drm =3D nouveau_drm(nv_encoder->base.base.dev);
>  	struct nouveau_backlight *backlight =3D nv_connector->backlight;
>  	struct drm_dp_aux *aux =3D &nv_connector->aux;

[Severity: High]
This isn't a bug introduced by this patch, but does the new early return
happen too late if CONFIG_DRM_NOUVEAU_BACKLIGHT is enabled?

In the exact disable-without-enable scenario this patch is addressing,=20
nv50_outp_get_old_connector() can return NULL. Because nv_connector is
unconditionally dereferenced here to initialize the backlight and aux
variables, won't this still cause a NULL pointer dereference in
nv50_sor_atomic_disable() before the newly added crtc guard is ever reached?

>  	int ret;
> +#endif
> +
> +	/* nv_encoder->crtc is the driver's shadow pointer, set in
> +	 * .atomic_enable and cleared at the end of this function.  NULL here
> +	 * means disable-without-enable or a double disable; bail before
> +	 * container_of() turns it into a bogus head pointer (checking the
> +	 * result would not work, container_of(NULL) is never NULL).  The
> +	 * encoder release is handled by the commit_tail release loop, so
> +	 * there is nothing to clean up here.
> +	 */
> +	if (drm_WARN_ON_ONCE(encoder->dev, !nv_encoder->crtc))
> +		return;
> +	head =3D nv50_head(nv_encoder->crtc);
> =20
> +#ifdef CONFIG_DRM_NOUVEAU_BACKLIGHT
>  	if (backlight && backlight->uses_dpcd) {
>  		ret =3D drm_edp_backlight_disable(aux, &backlight->edp_info);
>  		if (ret < 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781162589.gi=
t.marek@czernohous.de?part=3D2
