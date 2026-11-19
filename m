Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DB7606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KlaKk2eN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BC8E1121A6;
	Thu, 19 Nov 2026 08:49:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C99E10E4BF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:49:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2BF3E4508D;
 Thu, 19 Nov 2026 08:49:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C93EC1F000C4;
 Thu, 19 Nov 2026 08:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795078147;
 bh=pK1gFP8IqpoUm5p7v196yEl8bxTmpIXQJdejODehnTQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KlaKk2eNdrYC3g2gs+T1dKqLe7jgIGgOlSYW1dTCJKVyTGs6YujKIKUAXOvoGKEVZ
 pz12SJut+eG0bTQBY/jB6igWhs79wVamp26Iu9X/U03OC3tGwPLRBo+9llH0j4SBss
 TucbqDjGhpKK5K0g7yJULCLFZOS0W6PTKmxmxmX8rcBJlTRZHl2DiHk4geCrO6LBtG
 9ZX+4px/KSt7pf0UgI99I6BGpLADze3MbT6my8zG/uanEKb0SO1BRUtsSZq+U/B50o
 bUgPeexi0iDMr/eCvn/VQ7OxSDMZu0YPHzaXWSeH+pnb2iKQBv+n/nYkoUr1AmUYvs
 z2Vm8ZqSBiHpw==
Message-ID: <sashiko-outbox-222717@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 26/29] drm/msm/dp: wake threaded handler for HPD IRQs
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-26-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-26-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:49:06 +0000
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

commit 37c008bcf63491b33f14776e4c87241cd46a2065
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: wake threaded handler for HPD IRQs

This commit fixes msm_dp_display_irq_handler() to return IRQ_WAKE_THREAD
when an HPD interrupt is pending instead of bitwise-ORing it with
msm_dp_ctrl_isr()'s return value, and marks DP_INTERRUPT_STATUS2 interrupts
as IRQ_HANDLED in msm_dp_ctrl_isr().

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 8012c3d477113..bf3f1b35abddb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -3021,6 +3021,9 @@ irqreturn_t msm_dp_ctrl_isr(struct msm_dp_ctrl *msm=
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
> index 6f1f9dd3660d0..ad8c30a8ea798 100644
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
> =20
>  static irqreturn_t msm_dp_display_irq_thread(int irq, void *dev_id)

[Severity: Medium]
Should ret in msm_dp_display_irq_handler() be initialized to IRQ_NONE (or
assigned directly from msm_dp_ctrl_isr())?

With ret initialized to IRQ_HANDLED, ret |=3D msm_dp_ctrl_isr() always
evaluates to IRQ_HANDLED regardless of whether msm_dp_ctrl_isr() returns
IRQ_NONE or IRQ_HANDLED.  This discards IRQ_NONE on unhandled or spurious
interrupts and makes the new DP_INTERRUPT_STATUS2 check in msm_dp_ctrl_isr()
have no effect.

Note that if ret is changed so msm_dp_ctrl_isr()'s return value is
propagated, msm_dp_ctrl_isr() will also need to set ret =3D IRQ_HANDLED when
msm_dp_ctrl_get_psr_interrupt() returns a non-zero status.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D26
