Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4B5606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o3kUgJoh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B1D112A14;
	Fri, 27 Nov 2026 10:31:42 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27D5112A15
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:31:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6D86A43989;
 Fri, 27 Nov 2026 10:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3931F00899;
 Fri, 27 Nov 2026 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795775496;
 bh=avk5cytN+L/J7/Lh48gtpu2LdPZ+kZWamSRmpSDap3g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=o3kUgJohCk3yx6ekC7x0KWBwdq5puZyL7lEgHc6FSghysF8as+cIHwVnCvIpo3gaM
 RntJ/pJaIYpsDjB2iaQ7ZOCkELy385mp8SOuIuTT0U3MeJfuYI8gsWyja+BDcq2sxL
 T6OrEzh26so8b4mYETlKwIbsRRhTwitfM2Cxmt2SUpVSVZhBvnbOzNgNm/rr+FLVrK
 SvkFTms9yEumfsfMVdS3S3EP9/TC2ejFD2XhgbsC1WKK+a+MLGDYOx61VBhXTz8ajS
 jjhjMT3zKZpedxW431+ybk+DD/fyuxytuYXuzs9qZZWBxN3aj+RFoA1wvwkFcBJtCj
 Wr3rGEoV0diCw==
Message-ID: <sashiko-outbox-237137@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] drm/msm/dp: reinit video_comp and guard stream
 state on link maintenance
To: "Gianfranco Mariotti" <gianfranco.mariotti94@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127101417.24303-5-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
 <20261127101417.24303-5-gianfranco.mariotti94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:31:35 +0000
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
- [Medium] drm/msm/dp: race on stream_clks_on and video_comp in link
  maintenance
--

commit 74fb6ec8be236f906bc006dd2cc6f05e8c05939a
Author: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>

drm/msm/dp: reinit video_comp and guard stream state on link maintenance

This commit reinitializes ctrl->video_comp in
msm_dp_ctrl_link_maintenance() and guards msm_dp_ctrl_push_idle() and
the post-training steps on ctrl->stream_clks_on[panel->stream_id].

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index 779f743f94189..7201b7b513a32 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -2089,13 +2089,16 @@ static int msm_dp_ctrl_link_maintenance(struct ms=
m_dp_ctrl_private *ctrl,
>  	int ret =3D 0;
>  	int training_step =3D DP_TRAINING_NONE;
> =20
> -	msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
> +	if (ctrl->stream_clks_on[panel->stream_id])
> +		msm_dp_ctrl_push_idle(&ctrl->msm_dp_ctrl);
> =20
>  	ctrl->link->phy_params.p_level =3D 0;
>  	ctrl->link->phy_params.v_level =3D 0;
> =20
> +	reinit_completion(&ctrl->video_comp);
> +
>  	ret =3D msm_dp_ctrl_setup_main_link(ctrl, panel, &training_step);
> -	if (ret)
> +	if (ret || !ctrl->stream_clks_on[panel->stream_id])
>  		goto end;
> =20
>  	msm_dp_ctrl_clear_training_pattern(ctrl, panel, DP_PHY_DPRX);

[Severity: Medium]
Can msm_dp_ctrl_link_maintenance() race with msm_dp_ctrl_on_stream() on
ctrl->stream_clks_on[panel->stream_id] and ctrl->video_comp?

In msm_dp_display_atomic_enable(), msm_dp_display_prepare_link() is
followed immediately by msm_dp_display_enable() ->
msm_dp_ctrl_on_stream() on the atomic commit thread without holding
dp->plugged_lock.  Because msm_dp_ctrl_setup_main_link() sleeps across
AUX transactions and fsleep() delays, the stream state can change mid-way
through link maintenance:

CPU0 (HPD IRQ thread)                  CPU1 (atomic commit)
msm_dp_irq_hpd_handle()                msm_dp_display_atomic_enable()
  msm_dp_ctrl_link_maintenance()         msm_dp_display_prepare_link()
    stream_clks_on[...] is false
    reinit_completion(&video_comp)
    msm_dp_ctrl_setup_main_link()
      ... (sleeps in AUX / fsleep)       msm_dp_display_enable()
                                           msm_dp_ctrl_on_stream()
                                             msm_dp_ctrl_on_pixel_clk()
                                               stream_clks_on[...] =3D true
                                             reinit_completion(&video_comp)
                                             write DP_STATE_CTRL_SEND_VIDEO
                                             msm_dp_ctrl_wait4video_ready()
    !stream_clks_on[...] is now false
    msm_dp_ctrl_clear_training_pattern()
    write DP_STATE_CTRL_SEND_VIDEO
    msm_dp_ctrl_wait4video_ready()     <-- both wait on single video_comp

Conversely, if msm_dp_ctrl_link_maintenance() runs
reinit_completion(&ctrl->video_comp) while msm_dp_ctrl_on_stream() is
already waiting in msm_dp_ctrl_wait4video_ready() (or just after
msm_dp_ctrl_isr() completes video_comp), video_comp.done is reset to 0,
causing msm_dp_ctrl_wait4video_ready() to time out with -ETIMEDOUT and
fail display bring-up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101417.2430=
3-1-gianfranco.mariotti94@gmail.com?part=3D4
