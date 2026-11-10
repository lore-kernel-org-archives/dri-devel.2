Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D76F606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 05:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHZqdY5t
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83AB810E28B;
	Tue, 10 Nov 2026 05:21:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF75310E28B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:21:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B301B41A57;
 Tue, 10 Nov 2026 05:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE991F0089F;
 Tue, 10 Nov 2026 05:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794288065;
 bh=AwgNMmOR33z/qsN2oMioaZGKlcCj6dIMAUsa2AwTt4Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cHZqdY5tMjyUNgpa3fLa0rbMf2RUkUXjMmsHWZE+gsz6ZuE1e51HyRKfNQzqSs7vk
 BI9/r1hiAmtNyO56FWlHQpz2W2IfTvfhLnTVKS+xWcqjngmyIKfDYBmW5oz0bCIlpi
 EfSEeWM/6o1Mlki60ddMiJwqoAFdW2ZzzWJl48YWRFbbEIF4fCEzGRtsvOAZETHa9Z
 GV17c5ycn23bJmnB6vBZlj4F9cNKzz42WkKfl2Eqr6Y6u0LefktgT800dlPw1r8DP+
 S9Hw8YecoBUDP4k3Qt2OeBCcyL5u/teKCyIV32qjnCPzRFwRkd5pHOsJL59ASs3ZoI
 cZP66VUEUmSYA==
Message-ID: <sashiko-outbox-206275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 26/29] drm/msm/dp: wake threaded handler for HPD IRQs
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110-msm-dp-mst-v8-26-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
 <20261110-msm-dp-mst-v8-26-d040fb33db5f@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 05:21:05 +0000
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
- [Medium] drm/msm/dp: ret initialized to IRQ_HANDLED in
  msm_dp_display_irq_handler()
--

commit ee3e939cb1174f2996abe5c5ad053dbd42ebbbaa
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: wake threaded handler for HPD IRQs

This commit fixes msm_dp_display_irq_handler() to return IRQ_WAKE_THREAD
when an HPD interrupt is pending, and updates msm_dp_ctrl_isr() to report
DP_INTERRUPT_STATUS2 interrupts as IRQ_HANDLED.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 82fb3ae750f42..5623693d9242e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -3018,6 +3018,9 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm=
_dp_ctrl,
>  	}
> =20
>  	isr =3D msm_dp_ctrl_get_interrupt(ctrl);
> +	/* All status2 sources are ACKed by msm_dp_ctrl_get_interrupt(). */
> +	if (isr & DP_INTERRUPT_STATUS2)
> +		ret =3D IRQ_HANDLED;
> =20
>  	if (isr & DP_CTRL_INTR_READY_FOR_VIDEO) {
>  		drm_dbg_dp(ctrl->drm_dev, "dp_video_ready\n");
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 8ea3d258a98f3..40b2f6e120cf0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1091,23 +1091,24 @@ static irqreturn_t msm_dp_display_irq_handler(int=
 irq, void *dev_id)
>  	u32 hpd_isr_status;
>  	unsigned long flags;
>  	irqreturn_t ret =3D IRQ_HANDLED;
> +	bool hpd_irq_pending;
> =20
>  	hpd_isr_status =3D msm_dp_aux_get_hpd_intr_status(dp->aux);
> +	hpd_irq_pending =3D hpd_isr_status & DP_DP_HPD_INT_MASK;
> =20
> -	if (hpd_isr_status & 0x0F) {
> +	if (hpd_irq_pending) {
>  		drm_dbg_dp(dp->drm_dev, "type=3D%d isr=3D0x%x\n",
>  			dp->msm_dp_display.connector_type, hpd_isr_status);
> =20
>  		spin_lock_irqsave(&dp->irq_thread_lock, flags);
>  		dp->hpd_isr_status |=3D hpd_isr_status;
> -		ret =3D IRQ_WAKE_THREAD;
>  		spin_unlock_irqrestore(&dp->irq_thread_lock, flags);
>  	}
> =20
>  	/* DP controller isr */
>  	ret |=3D msm_dp_ctrl_isr(dp->ctrl, dp->panel);
> =20
> -	return ret;
> +	return hpd_irq_pending ? IRQ_WAKE_THREAD : ret;
>  }

[Severity: Medium]
Should ret in msm_dp_display_irq_handler() be initialized to IRQ_NONE (or
assigned directly from msm_dp_ctrl_isr()) instead of IRQ_HANDLED?

Because ret starts as IRQ_HANDLED (1) and msm_dp_ctrl_isr() only returns
IRQ_NONE (0) or IRQ_HANDLED (1), "ret |=3D msm_dp_ctrl_isr(...)" always
evaluates to IRQ_HANDLED.  This discards the return value of
msm_dp_ctrl_isr(), makes the new DP_INTERRUPT_STATUS2 check a no-op, and
prevents the IRQ core from ever seeing IRQ_NONE on unhandled or spurious
interrupts.

Also, if ret is changed to reflect msm_dp_ctrl_isr(), should the PSR
branch in msm_dp_ctrl_isr() set ret =3D IRQ_HANDLED when
msm_dp_ctrl_get_psr_interrupt(ctrl) returns a non-zero status?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-msm-dp-mst=
-v8-0-d040fb33db5f@oss.qualcomm.com?part=3D26
