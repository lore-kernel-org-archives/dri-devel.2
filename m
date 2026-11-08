Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A66606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RHgWGgbI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A077510E7E1;
	Sun,  8 Nov 2026 12:37:37 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96EC310E7E1
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 12:37:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B5C6416EF;
 Sun,  8 Nov 2026 12:37:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A4C1F0089F;
 Sun,  8 Nov 2026 12:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794141451;
 bh=wtqhuCAhz0EmO+3zYRfVGhM8rJcwLvDnaKbqoAkLTQo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RHgWGgbIdxmacCsuJgJIt5BIwjVmF+AIsRBkSW2uFI0d1Rk9KlRcnnWSqZGbS5Edm
 Q9yyQ4TDx/oVcjk9G1PR4ZSUH+7S8VmeO3L7/24Z3k/4WIFIztaitOqcWVXfxiKPz9
 wqnYx8ysxylB1tu5psbyO3Xx3K7cXxWsJjzEj/ekGLHIorUzd72Ui9DqzKeDxq7rqx
 2WLpxxrdg/9xh8ulndzSfeFcMkFaMNOUejEHMx3tgit8ixvZ9bkRyK28EqdEahO0vl
 pIShil5ShZ9EQSC24G396I8BINMLrQG2BtS21hh853CABrIQ93Zear68IHCGehw8bM
 05XPDx/qkmm9Q==
Message-ID: <sashiko-outbox-203735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/mxsfb: Complete page flips only once the new buffer
 is latched
To: "Christian Gmeiner" <christian.gmeiner@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20261108-mxsfb-flip-latch-v1-1-ad816b23b646@igalia.com>
References: <20261108-mxsfb-flip-latch-v1-1-ad816b23b646@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 12:37:30 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/mxsfb: premature plane cleanup in
  mxsfb_crtc_handle_vblank()
--

commit c09da195fd06536925306459ef31e61d236a956a
Author: Christian Gmeiner <cgmeiner@igalia.com>

drm/mxsfb: Complete page flips only once the new buffer is latched

This commit holds the pending vblank event in mxsfb_drm_private and
sends it from the vblank interrupt handler only once CUR_BUF matches
NEXT_BUF (and AS_BUF matches AS_NEXT_BUF when the overlay is enabled).

> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mx=
sfb_kms.c
> index bbc2a2df9f161..c7e516758a1ae 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
> @@ -328,6 +328,7 @@ static int mxsfb_crtc_atomic_check(struct drm_crtc *c=
rtc,
>  static void mxsfb_crtc_atomic_flush(struct drm_crtc *crtc,
>  				    struct drm_atomic_commit *state)
>  {
> +	struct mxsfb_drm_private *mxsfb =3D to_mxsfb_drm_private(crtc->dev);
>  	struct drm_pending_vblank_event *event;
> =20
>  	event =3D crtc->state->event;
> @@ -338,12 +339,54 @@ static void mxsfb_crtc_atomic_flush(struct drm_crtc=
 *crtc,
> =20
>  	spin_lock_irq(&crtc->dev->event_lock);
>  	if (drm_crtc_vblank_get(crtc) =3D=3D 0)
> -		drm_crtc_arm_vblank_event(crtc, event);
> +		mxsfb->event =3D event;
>  	else
>  		drm_crtc_send_vblank_event(crtc, event);
>  	spin_unlock_irq(&crtc->dev->event_lock);
>  }
> =20
> +static bool mxsfb_crtc_buffers_latched(struct mxsfb_drm_private *mxsfb)
> +{
> +	if (readl(mxsfb->base + mxsfb->devdata->cur_buf) !=3D
> +	    readl(mxsfb->base + mxsfb->devdata->next_buf))
> +		return false;
> +
> +	if (mxsfb->devdata->has_overlay &&
> +	    (readl(mxsfb->base + LCDC_AS_CTRL) & AS_CTRL_AS_ENABLE) &&
> +	    readl(mxsfb->base + LCDC_AS_BUF) !=3D readl(mxsfb->base + LCDC_AS_N=
EXT_BUF))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void mxsfb_crtc_finish_page_flip(struct mxsfb_drm_private *mxsfb)
> +{
> +	struct drm_crtc *crtc =3D &mxsfb->crtc;
> +
> +	drm_crtc_send_vblank_event(crtc, mxsfb->event);
> +	drm_crtc_vblank_put(crtc);
> +	mxsfb->event =3D NULL;
> +}
> +
> +void mxsfb_crtc_handle_vblank(struct mxsfb_drm_private *mxsfb)
> +{
> +	struct drm_crtc *crtc =3D &mxsfb->crtc;
> +
> +	drm_crtc_handle_vblank(crtc);
> +
> +	/*
> +	 * The controller copies NEXT_BUF to CUR_BUF at the end of a frame. If
> +	 * the commit wrote NEXT_BUF after that point, the new buffer is only
> +	 * scanned out from the next frame on. Complete the flip only once the
> +	 * hardware has latched it, otherwise userspace gets back a buffer that
> +	 * is still being scanned out.
> +	 */
> +	spin_lock(&crtc->dev->event_lock);
> +	if (mxsfb->event && mxsfb_crtc_buffers_latched(mxsfb))
> +		mxsfb_crtc_finish_page_flip(mxsfb);
> +	spin_unlock(&crtc->dev->event_lock);
> +}

[Severity: High]
Can calling drm_crtc_handle_vblank() before the new buffer is latched
cause drm_atomic_helper_commit_tail_rpm() to clean up the old framebuffer
while it is still being scanned out?

mxsfb_mode_config_helpers uses drm_atomic_helper_commit_tail_rpm(), which
waits via drm_atomic_helper_wait_for_vblanks() rather than
drm_atomic_helper_wait_for_flip_done():

drivers/gpu/drm/drm_atomic_helper.c:drm_atomic_helper_commit_tail_rpm() {
	...
	drm_atomic_helper_commit_hw_done(state);

	drm_atomic_helper_wait_for_vblanks(dev, state);

	drm_atomic_helper_cleanup_planes(dev, state);
}

When a commit writes NEXT_BUF just after the end-of-frame copy, the next
frame-done interrupt sees mxsfb_crtc_buffers_latched() =3D=3D false and def=
ers
mxsfb_crtc_finish_page_flip() (leaving commit->flip_done unsignaled).
However, drm_crtc_handle_vblank() still increments the vblank count and
wakes drm_atomic_helper_wait_for_vblanks() on that unlatched interrupt.

commit_tail() then immediately runs drm_atomic_helper_cleanup_planes() and
drops the old framebuffer reference while the LCDIF DMA engine is still
scanning it out from CUR_BUF for another frame.  For a blocking commit, it
also returns to userspace before commit->flip_done is signaled, causing an
immediate follow-up non-blocking flip to fail with -EBUSY in
stall_checks().

A custom atomic_commit_tail that calls
drm_atomic_helper_wait_for_flip_done() instead of
drm_atomic_helper_wait_for_vblanks() would keep plane cleanup and commit
completion synchronized with mxsfb_crtc_finish_page_flip().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-mxsfb-flip=
-latch-v1-1-ad816b23b646@igalia.com?part=3D1
