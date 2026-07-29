Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E1BC54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:13:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF2A110E002;
	Wed, 29 Jul 2026 08:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mZVEhmJF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCD210E002
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:From:Reply-To;
 bh=ehifnGP1xxe4G+Ord5mtlFwP15sja0qQDZhYLeGG87U=; b=mZVEhmJF94IDP1TWOGdm0aO/hR
 aQm+X+jfZ6PNnxLhfMi+KaUnVeUL8OJY1O6oCZf9at9Y6CQwJ1H38vBlOqW93G7G0U5zcqZOPqHEu
 Rqx3Rm/Ydv37kuD8ijNJDNyt9h/IRI5lVrnQCYZNlJ3P13W7kwRjJg8/9BqkB+j7pnqevUvtwfwjh
 YBsF/Mtcq3SatqPqmbavAVGnGsX/UH5qI5PgPumAYFmlmSpKJsThz3r2z2orLd0Hm+hyXdS+A5uPD
 Ac0xkyOz3QGnFrE76gY7cdewmvbOiBKI7rfFdD8u62NCX9oFu0RDknp2csSZiyW12CwlfXSqceL1o
 +c/8WhJQ==;
Received: from 179-125-64-236-dinamico.pombonet.net.br ([179.125.64.236]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wozPk-007OrN-VR; Wed, 29 Jul 2026 10:13:21 +0200
Date: Wed, 29 Jul 2026 05:13:17 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/atomic: remove bogus check for file_priv
Message-ID: <amm2HXpT4Hnqth3A@quatroqueijos.cascardo.eti.br>
References: <20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com>
 <20260729080458.496221F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729080458.496221F000E9@smtp.kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Wed, Jul 29, 2026 at 08:04:57AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Memory leak of `struct drm_pending_vblank_event` in `prepare_signaling()` error paths when `OUT_FENCE_PTR` is requested without `DRM_MODE_PAGE_FLIP_EVENT`.
> --
> 
> --- Patch [1]: [PATCH] drm/atomic: remove bogus check for file_priv ---
> commit 005f3f9bbee21ecd8f3b8b2687c9b0a8040286cc
> Author: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> 
> drm/atomic: remove bogus check for file_priv
> 
> This commit removes a file_priv check in prepare_signaling(), since
> drm_mode_atomic_ioctl() guarantees it is never NULL. Skipping the block
> here would cause a memory leak of drm_pending_vblank_event.
> 
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -1445,9 +1445,6 @@ static int prepare_signaling(struct drm_device *dev,
> >  		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
> >  			struct drm_pending_vblank_event *e = crtc_state->event;
> >  
> > -			if (!file_priv)
> > -				continue;
> > -
> >  			ret = drm_event_reserve_init(dev, file_priv, &e->base,
> >  						     &e->event.base);
> >  			if (ret) {
> 
> [Severity: High]
> This is a pre-existing issue, but can this function leak the
> drm_pending_vblank_event if an OUT_FENCE_PTR is requested without a
> DRM_MODE_PAGE_FLIP_EVENT?
> 
> If a user submits an atomic commit that requests an out-fence but does not
> request a page flip event, prepare_signaling() allocates an event:
> 
>     if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT || fence_ptr) {
>         ...
>         e = create_vblank_event(crtc, arg->user_data);
>         ...
>         crtc_state->event = e;
>     }
> 
> If the subsequent setup_out_fence() fails (e.g. from FD exhaustion), the
> function returns an error before setting event->base.fence:
> 
>     ret = setup_out_fence(&f[(*num_fences)++], fence);
>     if (ret) {
>         dma_fence_put(fence);
>         return ret;
>     }
>     
>     crtc_state->event->base.fence = fence;
> 
> In the cleanup path, complete_signaling() relies on event->base.fence or
> event->base.file_priv being set to free the event:
> 
>     if (event && (event->base.fence || event->base.file_priv)) {
>         drm_event_cancel_free(dev, &event->base);
>         crtc_state->event = NULL;
>     }
> 
> Since both fields are NULL, does the event get permanently leaked on this
> error path?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com?part=1

Fixed by https://lore.kernel.org/all/20260729-drm_pending_vblank_event_leak-v2-1-a5074aae07df@igalia.com/.

Cascardo.
