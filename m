Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208A4606B24F
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZjA4biY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CEAC10E5C0;
	Thu, 12 Nov 2026 08:49:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5748910FE94
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:49:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CE9FA61DD9;
 Thu, 12 Nov 2026 08:49:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E3B51F00A05;
 Thu, 12 Nov 2026 08:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794473375;
 bh=ifzbClsSYz5JCzH7Y/Xz3Aoz89yqXuOk4m4tIdGla08=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MZjA4biYIgcY7nGC+MZWrbmfrt8TGEbXVKu0G/U4HSDD3LmeqmXZzahJ7EJZ8ioCZ
 d5GFQbDYN0Vbkr6ztqu3fdaZdEbe6Ls1voZrhNlFEgTN1C+JBo8I9cBpMOhdX2oebO
 LVxgJiVbXaqYIqtl9XVs8Fcs90wEBgyTzIp2lSbdT44+srB4vWOvHvk4/XlIk3R/Wu
 zX12k3CzXfxhafC0mw/nSWmc2fnRo6ziW3ni3tURegJ7wsQCuslAjjR+va1XDmQ89I
 PosvbQcX1nJdNiW1GhO0IPJTma1lIF3IKht+1y6T788pvB4mPYNV9HT9JpOf5gNctg
 Qef54f3wctf/A==
Message-ID: <sashiko-outbox-210788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] drm/rockchip: vop2: Report POST_BUF_EMPTY at
 most once per frame
To: "Arun Iyengar" <aiyengar1990@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-vop2-fixes-v2-6-8218c1cf8ac8@gmail.com>
References: <20261112-vop2-fixes-v2-0-8218c1cf8ac8@gmail.com>
 <20261112-vop2-fixes-v2-6-8218c1cf8ac8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:49:35 +0000
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
- [Medium] drm/rockchip: vop2: race in vop2_crtc_handle_post_buf_empty()
  on disable
--

commit 06ecad385f4f1417ba151eac3f81400c9be27660
Author: Arun Iyengar <aiyengar1990@gmail.com>

drm/rockchip: vop2: Report POST_BUF_EMPTY at most once per frame

This commit masks the POST_BUF_EMPTY interrupt when it fires and re-arms
it on the next frame start interrupt to avoid interrupt storms during
video port underflows.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 684fa46924e7f..c59e270739b66 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -842,6 +842,70 @@ static void vop2_crtc_disable_irq(struct vop2_video_=
port *vp, u32 irq)
>  	vop2_writel(vop2, RK3568_VP_INT_EN(vp->id), irq << 16);
>  }
> =20
> +/*
> + * POST_BUF_EMPTY is raised for every line the post processing stage fin=
ds
> + * no data for, so an underflowing video port can raise it 100000 times =
per
> + * second. Report it at most once per frame: mask it when it fires and
> + * unmask it at the next frame start, using the FS interrupt even when
> + * vblank reporting is off.
> + */
> +/* Forget a pending re-arm, called with vp->irq_lock held */
> +static void vop2_crtc_unmask_post_buf_empty(struct vop2_video_port *vp)
> +{
> +	if (vp->post_buf_empty_masked && !vp->vblank_enabled)
> +		vop2_crtc_disable_irq(vp, VP_INT_FS_FIELD);
> +	vp->post_buf_empty_masked =3D false;
> +}
> +
> +static void vop2_crtc_enable_post_buf_empty_irq(struct vop2_video_port *=
vp)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vp->irq_lock, flags);
> +	vop2_crtc_unmask_post_buf_empty(vp);
> +	vop2_crtc_enable_irq(vp, VP_INT_POST_BUF_EMPTY);
> +	spin_unlock_irqrestore(&vp->irq_lock, flags);
> +}
> +
> +static void vop2_crtc_disable_post_buf_empty_irq(struct vop2_video_port =
*vp)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vp->irq_lock, flags);
> +	vop2_crtc_disable_irq(vp, VP_INT_POST_BUF_EMPTY);
> +	vop2_crtc_unmask_post_buf_empty(vp);
> +	spin_unlock_irqrestore(&vp->irq_lock, flags);
> +}
> +
> +static void vop2_crtc_handle_post_buf_empty(struct vop2_video_port *vp)
> +{
> +	spin_lock(&vp->irq_lock);
> +	vop2_crtc_disable_irq(vp, VP_INT_POST_BUF_EMPTY);
> +	vp->post_buf_empty_masked =3D true;
> +	/*
> +	 * POST_BUF_EMPTY is unmasked again by the FS interrupt at the next
> +	 * frame start, so FS must be enabled. With vblank reporting on it
> +	 * is already, and a pending FS may carry a vblank event. Otherwise
> +	 * enable it here, clearing the FS status of the current frame so
> +	 * that FS fires at the next frame start only.
> +	 */
> +	if (!vp->vblank_enabled)
> +		vop2_crtc_enable_irq(vp, VP_INT_FS_FIELD);
> +	spin_unlock(&vp->irq_lock);
> +}

[Severity: Medium]
Can vop2_crtc_handle_post_buf_empty() run after
vop2_crtc_disable_post_buf_empty_irq() during CRTC disable and re-enable
VP_INT_FS_FIELD while VOP2 clocks are being turned off?

In vop2_crtc_atomic_disable(), VP_INT_POST_BUF_EMPTY stays enabled while
waiting on vp->dsp_hold_completion.  In both rk3576_vp_isr() and
vop2_isr(), VP_INT_STATUS is read once and complete(&vp->dsp_hold_completio=
n)
runs before vop2_crtc_handle_post_buf_empty():

CPU0                                  CPU1 (<hardirq>)
vop2_crtc_atomic_disable()
  wait_for_completion_timeout(...)
                                      vop2_isr() / rk3576_vp_isr()
                                        irqs =3D vop2_readl(...);
                                        /* DSP_HOLD_VALID | POST_BUF_EMPTY =
*/
                                        complete(&vp->dsp_hold_completion);
  vop2_crtc_disable_post_buf_empty_irq()
    spin_lock_irqsave(&vp->irq_lock)
    /* disables POST_BUF_EMPTY & FS */
    vp->post_buf_empty_masked =3D false;
    spin_unlock_irqrestore(&vp->irq_lock)
  vop2_disable()
    vop2_core_clks_disable_unprepare()
                                        vop2_crtc_handle_post_buf_empty()
                                          spin_lock(&vp->irq_lock)
                                          vp->post_buf_empty_masked =3D tru=
e;
                                          vop2_crtc_enable_irq(...,
                                                               VP_INT_FS_FI=
ELD);
                                            <-- MMIO write with clocks off

Unlike vop2_crtc_rearm_post_buf_empty(), vop2_crtc_handle_post_buf_empty()
does not check whether POST_BUF_EMPTY reporting is still enabled on the
video port, so it leaves vp->post_buf_empty_masked set and VP_INT_FS_FIELD
enabled on a disabled CRTC, or performs unclocked MMIO writes if the last
CRTC disables VOP2 core clocks concurrently.

Disabling POST_BUF_EMPTY before waiting for dsp_hold_completion, or
tracking under vp->irq_lock whether POST_BUF_EMPTY is enabled so
vop2_crtc_handle_post_buf_empty() becomes a no-op once disabled, would
avoid this race.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-vop2-fixes=
-v2-0-8218c1cf8ac8@gmail.com?part=3D6
