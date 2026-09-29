Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B57CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40AAB10EEB7;
	Tue, 29 Sep 2026 13:18:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b9MX+vhT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02C1110EEBC
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:18:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 54CC1600D1;
 Tue, 29 Sep 2026 13:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF20C1F0089E;
 Tue, 29 Sep 2026 13:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790687921;
 bh=I4XAUKK7UAGP9ty57e21Alp5B7WqOwEeRZIF7JnAG74=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b9MX+vhTNHoiSc5amMO9YK+Ujh66DeR63bTnESEqop0M+lZzmpyTRN9B5/nad5t/6
 gxkwXBBWXx6O5qibS2XwbjcixdiZER88RySMXMuFC3HWXmSH2pJOjK2EJb5hAZg72W
 7mqof//sk4Ig8boj9wO1xoh5NWrsI3AtXkNTxtufQaWhOYHA52nszLqauoysDlcoXo
 rDNkcjW9g2yHOf6xlLzyUsNPIZecr3RRPARerSbQiotYiY28uWv6ckTRw+o6KkEX/e
 fBxUHp5tMCtHxLkLXoi0Gq8P9EPj7xWuOiH5tyaewgXn3PDyP5TpRY0Ndv4eiylzX1
 hBsmy54aUKu1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dpu: stop all video interfaces before cleaning
 up a split encoder
To: "Joonhoe Kim" <26rote@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929130621.943-1-26rote@gmail.com>
References: <20260929130621.943-1-26rote@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:18:40 +0000
Message-Id: <20260929131840.DF20C1F0089E@smtp.kernel.org>
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
- [Medium] drm/msm/dpu: race condition causes 84ms timeout during display d=
isable
--

commit 9a915625643ca9da58dbf62e57c9c0b79c93bceb
Author: Joonhoe Kim <26rote@gmail.com>

drm/msm/dpu: stop all video interfaces before cleaning up a split encoder

dpu_encoder_virt_atomic_disable() disables the physical encoders one by
one. For a video-mode master, dpu_encoder_phys_vid_disable() stops its
timing engine, waits for the frame to finish and then runs
dpu_encoder_helper_phys_cleanup(), which resets the CTL. With a split
display that CTL is shared with the slave, whose timing engine is still
running at that point, causing the source pipe to stall.

> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/dr=
m/msm/disp/dpu1/dpu_encoder.c
> index 1f20695f81e35..a14156408126b 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
[ ... ]
> @@ -1380,6 +1380,35 @@ static void dpu_encoder_virt_atomic_enable(struct =
drm_encoder *drm_enc,
>  	mutex_unlock(&dpu_enc->enc_lock);
>  }
> =20
> +/*
> + * Stop the timing engine of every video-mode interface of the encoder b=
efore
> + * any of them is cleaned up. With a split display (two interfaces on on=
e CTL,
> + * e.g. bonded DSI) the master's cleanup resets the shared CTL while the
> + * slave's timing engine would still be running; the source pipes then s=
tart
> + * fetching the slave's next frame and stall half-way through it. The st=
all
> + * survives until the MDSS core GDSC is power-collapsed, so when somethi=
ng else
> + * keeps MDSS powered (an active DP controller) the next enable scans out
> + * nothing.
> + */
> +static void dpu_encoder_stop_video_timing(struct dpu_encoder_virt *dpu_e=
nc)
> +{
> +	unsigned long lock_flags;
> +	int i;
> +
> +	for (i =3D 0; i < dpu_enc->num_phys_encs; i++) {
> +		struct dpu_encoder_phys *phys =3D dpu_enc->phys_encs[i];
> +
> +		if (phys->intf_mode !=3D INTF_MODE_VIDEO || !phys->hw_intf ||
> +		    !phys->hw_intf->ops.enable_timing ||
> +		    phys->enable_state =3D=3D DPU_ENC_DISABLED)
> +			continue;
> +
> +		spin_lock_irqsave(phys->enc_spinlock, lock_flags);
> +		phys->hw_intf->ops.enable_timing(phys->hw_intf, 0);
> +		spin_unlock_irqrestore(phys->enc_spinlock, lock_flags);

[Severity: Medium]
Will this lead to an 84ms timeout during display disable?

By stopping the timing engine here without incrementing pending_kickoff_cnt,
we open a window where a final vsync interrupt could fire.

In dpu_encoder_phys_vid_vblank_irq(), the IRQ handler explicitly ignores the
vsync if pending_kickoff_cnt is 0:

	if (!(flush_register & hw_ctl->ops.get_pending_flush(hw_ctl)))
		atomic_add_unless(&phys_enc->pending_kickoff_cnt, -1, 0);

If the final vsync fires before dpu_encoder_phys_vid_disable() is called, it
will be ignored.

Then, when dpu_encoder_phys_vid_disable() runs, it increments the counter
and waits for a vsync that already happened:

	spin_lock_irqsave(phys_enc->enc_spinlock, lock_flags);
	phys_enc->hw_intf->ops.enable_timing(phys_enc->hw_intf, 0);
	if (dpu_encoder_phys_vid_is_master(phys_enc))
		dpu_encoder_phys_inc_pending(phys_enc);
	spin_unlock_irqrestore(phys_enc->enc_spinlock, lock_flags);

	/* Wait for a vsync so we know the ENABLE=3D0 latched... */
	if (dpu_encoder_phys_vid_is_master(phys_enc)) {
		ret =3D dpu_encoder_phys_vid_wait_for_tx_complete(phys_enc);

Could this result in the vsync being permanently missed, causing the wait
to timeout?

> +	}
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929130621.943-=
1-26rote@gmail.com?part=3D1
