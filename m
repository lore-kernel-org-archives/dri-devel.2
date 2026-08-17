Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6D0C5DF66
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 18:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ADA10E1E5;
	Mon, 17 Aug 2026 18:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MtdT0+ti";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2EF10E1E5
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 18:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
 From:Reply-To; bh=921MT1MCybA/bNAvIEBIXf7DfKR7GUAt0AQdTDfqnoY=; b=MtdT0+ti3O7
 bFlHDOv9yLbLPd2gSNRTLS6Qx+M8n3EYuxehyGAhR8qJUeFKdTlq/GHR+6+D47MvrUCbrRstRz/67
 Ja6kbVcov0gcZbyKFUENi/nQY21Cq1MXzFAxTxH40dX8BmGEHH8peyf00aE4EBrAob2XTKE2tD2GW
 PrnpzOp19KyevikPDcFIX3nDNrcJBd3Oa4lKItKcEpbNKprQ1R0FBIcYyQdoAiyRuiQmvlf4XM64n
 2L1tldPa+h80TXuhe8+jYBFNKtqlT+fV6vNPTGifXDkmDrPp++EbIWKhJHkg9GiIFY3S4d9V3vzRv
 gIqEzSn4MtwJP9HryHt2Zfg==;
Received: from 189-69-160-4.dial-up.telesp.net.br ([189.69.160.4]
 helo=quatroqueijos.cascardo.eti.br)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ww2IL-004roK-Vw; Mon, 17 Aug 2026 20:42:50 +0200
Date: Mon, 17 Aug 2026 15:42:41 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Melissa Wen <mwen@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com
Subject: Re: [PATCH] drm/atomic: remove bogus check for file_priv
Message-ID: <aoNWIaq9uot338J_@quatroqueijos.cascardo.eti.br>
References: <20260729-drm_atomic_bogus_check-v1-1-a4d5bd4ae4c8@igalia.com>
 <a64e03f4-dcd5-4842-ab21-b59dce159540@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a64e03f4-dcd5-4842-ab21-b59dce159540@igalia.com>
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

On Wed, Aug 12, 2026 at 06:19:34PM +0200, Melissa Wen wrote:
> 
> 
> On 29/07/2026 09:52, Thadeu Lima de Souza Cascardo wrote:
> > Skipping the rest of the block here would cause the drm_pending_vblank_event
> > object to leak and fail to set up the fence in case out_fence_ptr is set.
> > 
> > Since file_priv can never be NULL at prepare_signaling() as it is only
> > called by drm_mode_atomic_ioctl(), simply remove the check.
> 
> Hey,
> 
> The change looks correct, but I'm a little confused by the first sentence,
> because, if `file_priv` can never be NULL, there's no real leak, right?
> 

That is correct!

> Could you clarify the first sentence by saying it's currently an unreachable
> bug? That way, people will not think it's a live bug and will understand
> that
> a Fixes tag isn't necessary.
> 

Agreed!

Let me resend.

Cascardo.

> With this small clarification added:
> 
> Reviewed-by: Melissa Wen <mwen@igalia.com>
> 
> Thanks!
> 
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > ---
> >   drivers/gpu/drm/drm_atomic_uapi.c | 3 ---
> >   1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> > index e997917819e8..657c15474ed5 100644
> > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > @@ -1445,9 +1445,6 @@ static int prepare_signaling(struct drm_device *dev,
> >   		if (arg->flags & DRM_MODE_PAGE_FLIP_EVENT) {
> >   			struct drm_pending_vblank_event *e = crtc_state->event;
> > -			if (!file_priv)
> > -				continue;
> > -
> >   			ret = drm_event_reserve_init(dev, file_priv, &e->base,
> >   						     &e->event.base);
> >   			if (ret) {
> > 
> > ---
> > base-commit: d5efb1e1b1d7cd27c642654042f80d19a7ba3caf
> > change-id: 20260729-drm_atomic_bogus_check-456d5fb6eee9
> > 
> > Best regards,
> > --
> > Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
> > 
> 
