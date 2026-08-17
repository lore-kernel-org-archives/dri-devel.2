Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54633C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 21:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC3C310E3CA;
	Mon, 17 Aug 2026 21:36:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DGW7GfF5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 230B510E3CA
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=r4vBnR69ptfxUE0Psx8LyetuBY+zV0gwkoSynnVI/nI=; b=DGW7GfF5TAP
 Xp/uumOTdUkCslHaiTwPEPFkROcrFGEML/C6oTjFT2/k+5SSymexaLAqdtG4W4FWeSS8HXF9WMCBb
 wlwhzdwmlpyOdmC4zrus5Rt/uGL4hBxpYy3UQSRGL7Wn48mR/HyhErT5orH6fW6Oz2ZNJpYIVAjAw
 qA1+YcX4Dy6lrk/TvV0XqHoz94s/WtxGEu5YAgQ69c+JyV7pN/aNy0X5wkW5SKAWFoHR5dDPL3gJj
 0dX/w3z8p4QwufLY4NjNopCjMcghV2aiDIo4dt83/vK2/UnM9AQI/L+hfB39OI6FXlUpBp48/jGUO
 sHUKEBA7WHKoS44CqIKYawQ==;
Received: from 179-125-92-196-dinamico.pombonet.net.br ([179.125.92.196]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww509-0052TS-BM; Mon, 17 Aug 2026 23:36:13 +0200
Date: Mon, 17 Aug 2026 18:36:07 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Melissa Wen <mwen@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm: Fix drm_pending_vblank_event leak in error path
 for out_fence_ptr
Message-ID: <aoN-x2TYaXINwOAQ@quatroqueijos.cascardo.eti.br>
References: <20260729-drm_pending_vblank_event_leak-v2-1-a5074aae07df@igalia.com>
 <1399f290-b320-4322-a39f-a00bab362169@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1399f290-b320-4322-a39f-a00bab362169@igalia.com>
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

On Wed, Aug 12, 2026 at 06:45:46PM +0200, Melissa Wen wrote:
> 
> 
> On 29/07/2026 08:10, Thadeu Lima de Souza Cascardo wrote:
> > When an out_fence_ptr is provided but DRM_MODE_PAGE_FLIP_EVENT is not
> > set, a drm_pending_vblank_event will be allocated. If later, there is an
> > allocation failure or another failure at setup_out_fence(), that event
> > will not have base.fence set and it will not be released at
> > complete_signaling().
> > 
> > Release the event and set crtc_state->event to NULL just like in the
> > DRM_MODE_PAGE_FLIP_EVENT case when there is a failure at
> > drm_event_reserve_init(). That is, prepare_signaling() releases the
> > event and there is nothing to be done at complete_signaling(). Use
> > drm_event_cancel_free() as that will also undo drm_event_reserve_init()
> > in case it has been called.
> Hey,
> 
> Nice catch!
> > Reported-by: sashiko-bot@kernel.org
> 
> Take this with a grain of salt: I think checkpatch will complain about
> reporter
> as just an email. I usually use:
> `Reported-by: Sashiko <sashiko-bot@kernel.org>` but not 100% sure.

Neither b4 prep --check or directly calling checkpatch complain about it.
And I noticed some other occurences of applied commits with only the email
address.

> > Closes: https://sashiko.dev/#/patchset/20260727-drm_crtc_atomic_commit_leak-v1-1-23d9948a9d7c@igalia.com?part=1
> > Fixes: 92c715fca907 ("drm/atomic: Fix double free in drm_atomic_state_default_clear")
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> > Changes in v2:
> > - Fix UAF when DRM_MODE_PAGE_FLIP_EVENT is used.
> > - Link to v1: https://patch.msgid.link/20260728-drm_pending_vblank_event_leak-v1-1-08429b920b16@igalia.com
> > ---
> >   drivers/gpu/drm/drm_atomic_uapi.c | 13 +++++++++++--
> >   1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> > index 1050dddadb17..aed6040182eb 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -1464,11 +1464,15 @@ static int prepare_signaling(struct drm_device *dev,
> >   		if (fence_ptr) {
> >   			struct dma_fence *fence;
> >   			struct drm_out_fence_state *f;
> > +			struct drm_pending_vblank_event *e = crtc_state->event;
> >   			f = krealloc(*fence_state, sizeof(**fence_state) *
> >   				     (*num_fences + 1), GFP_KERNEL);
> > -			if (!f)
> > +			if (!f) {
> > +				drm_event_cancel_free(dev, &e->base);
> > +				crtc_state->event = NULL;
> >   				return -ENOMEM;
> > +			}
> >   			memset(&f[*num_fences], 0, sizeof(*f));
> > @@ -1476,12 +1480,17 @@ static int prepare_signaling(struct drm_device *dev,
> >   			*fence_state = f;
> >   			fence = drm_crtc_create_fence(crtc);
> > -			if (!fence)
> > +			if (!fence) {
> > +				drm_event_cancel_free(dev, &e->base);
> > +				crtc_state->event = NULL;
> >   				return -ENOMEM;
> > +			}
> >   			ret = setup_out_fence(&f[(*num_fences)++], fence);
> >   			if (ret) {
> >   				dma_fence_put(fence);
> > +				drm_event_cancel_free(dev, &e->base);
> > +				crtc_state->event = NULL;
> 
> How about to goto a single error handle instead of repeating those three
> lines
> three times? I think it'd be better for maintenance, but the fix looks
> correct as is:

I have tested a fix with an error label and I am going to send it as a v3.
Let me know what you think about it.

Thanks.
Cascardo.

> 
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> 
> >   				return ret;
> >   			}
> > 
> > ---
> > base-commit: df0311845915442ab75d03ee89fb443b444c1370
> > change-id: 20260728-drm_pending_vblank_event_leak-a36cedb296ba
> > 
> > Best regards,
> > --
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > 
> 
