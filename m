Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D53A606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMX0mLEl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4206112D67;
	Fri,  6 Nov 2026 13:32:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31490112D67
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:32:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EEDC741A84
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2C61F0089F;
 Fri,  6 Nov 2026 13:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971929;
 bh=LrFYHDu+0cgUyqOZLejxo7bDM4Z0LD9eaDc6yWVPixc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SMX0mLElZ/m2K8FZJOF9gV35NIbASr9aUYV+3bEUVCBT0T/M7ajfdef8zXttkbYdy
 K987qWReKDjzZONSqt25roUJ15xXlEtUL6/oMwxY4TMnGUEYUprGZ2PJaY6IWNFHtB
 MCVw/BxJWtNRfnmOUtSOEm7ncw7q/Sx/2D+zP+oBtlcwlPRBfcfInKvyq0MYZKTm8H
 +eoUMftH1iR5YWvE/hl7OE7IL6PmkiTQ9Fv95L/KYuMQTvfOM2ODrcp6yPbJzk+LUX
 wFaoyXe06sS/jUfBiTqNRbdHvEuIInVNi9wWtsiDGEUyIDeOBnQPTP7n2pVUEqRZ9p
 oWoMQGktcuOPg==
Message-ID: <sashiko-outbox-201466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/39] drm/fb-dma-helper: Handle framebuffers without
 a GEM object
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261106-drm-state-readout-v8-10-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
 <20261106-drm-state-readout-v8-10-cbe78624e1bc@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:32:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/fb-dma-helper: drm_WARN_ON_ONCE() in
  drm_fb_dma_get_scanout_buffer()
--

commit 42874beaaaa70520e8f9990fa06a12e91732fab6
Author: Maxime Ripard <mripard@kernel.org>

drm/fb-dma-helper: Handle framebuffers without a GEM object

This commit updates drm_fb_dma_get_scanout_buffer() to return -ENODEV when
a framebuffer has no backing GEM object on its first plane, such as a
framebuffer reconstructed from hardware state readout.

> diff --git a/drivers/gpu/drm/drm_fb_dma_helper.c b/drivers/gpu/drm/drm_fb=
_dma_helper.c
> index fd71969d2fb15..3a37253ab9f83 100644
> --- a/drivers/gpu/drm/drm_fb_dma_helper.c
> +++ b/drivers/gpu/drm/drm_fb_dma_helper.c
> @@ -179,6 +179,14 @@ int drm_fb_dma_get_scanout_buffer(struct drm_plane *=
plane,
> =20
>  	dma_obj =3D drm_fb_dma_get_gem_obj(fb, 0);
> =20
> +	/*
> +	 * The framebuffer has no GEM object backing its first plane,
> +	 * like a framebuffer reconstructed from a hardware state
> +	 * readout: we cannot access its contents.
> +	 */
> +	if (!dma_obj)
> +		return -ENODEV;
> +
>  	/* Buffer should be accessible from the CPU */
>  	if (drm_gem_is_imported(&dma_obj->base))
>  		return -ENODEV;

[Severity: Medium]
Does calling drm_fb_dma_get_gem_obj(fb, 0) here trigger a drm_WARN_ON_ONCE()
when fb->obj[0] is NULL?

drm_fb_dma_get_gem_obj() calls drm_gem_fb_get_obj(), which warns when a
plane has no backing GEM object:

drivers/gpu/drm/drm_gem_framebuffer_helper.c:drm_gem_fb_get_obj() {
	...
	if (drm_WARN_ON_ONCE(dev, plane >=3D ARRAY_SIZE(fb->obj)))
		return NULL;
	else if (drm_WARN_ON_ONCE(dev, !fb->obj[plane]))
		return NULL;
	...
}

When a panic occurs while a hardware readout framebuffer is still active,
drm_fb_dma_get_scanout_buffer() will hit that warning (or a nested panic if
panic_on_warn is set).

Note that the following patch in the series, commit "drm/gem-atomic-helper:
Handle framebuffers without a GEM object", checks state->fb->obj[i] directly
in drm_gem_plane_helper_prepare_fb() to avoid this same warning. Checking
!fb->obj[0] before calling drm_fb_dma_get_gem_obj(fb, 0) would avoid it here
as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-drm-state-=
readout-v8-0-cbe78624e1bc@kernel.org?part=3D10
