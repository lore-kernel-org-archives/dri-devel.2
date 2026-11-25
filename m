Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13A606A32A
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dlc3kWRy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70DBD10FBF1;
	Wed, 25 Nov 2026 11:56:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C021110FBF1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 11:56:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7CF062974;
 Wed, 25 Nov 2026 11:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8521F000C6;
 Wed, 25 Nov 2026 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795607765;
 bh=juffY9NjQaGpSpObJ1qqI/GuvyuvkWIQ43A+NfXBYfI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dlc3kWRyE20y/tviu2U777Mlo33/hcXx3ZiJF9FYcVJYV30BFVBeYpMD+Dtd/y8Wq
 yPi2M//CmOp70mLNMbYl/CAjI80ALLPBt8pI2HqTAyYTJsUFbV8zmgpd0yP3vwJxsq
 ahp8zSqdTQ1CqhCQ8niMm9SWT0PpXtXnWCIf+53vwxm2FO3u9DwoA7TAVTdh5y5yOT
 Q7gwBOvwbtc3u5pfT1R0JsVQTt1WuqSuYyE09jQ16L0kYsYaPJrjE0E2/eY+ZR2rmW
 MjdrxcFsGi28KVRCbPtwWNm5n+WP1MWI0kEHtJLpXvm5QoZr5VdyGkxLz7lyqhS0OE
 Aq4LVz9A2TGTA==
Message-ID: <sashiko-outbox-233304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dp: clear AUX_TRANS_CTRL on reset and enable
 HPD_REFTIMER
To: "Robert Ijtsma" <robertijtsma@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261125-drm-msm-dp-aux-resume-v1-1-17f5a40b9a61@gmail.com>
References: <20261125-drm-msm-dp-aux-resume-v1-1-17f5a40b9a61@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 11:56:04 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/msm/dp: msm_dp_aux_reset() gated on internal HPD and
  skipped on timeout
- [Medium] drm/msm/dp: msm_dp_aux_hpd_disable() disables reftimer while
  AUX is active
--

commit 348e835311cd64ac96d86e0a747eaee01eb395a2
Author: Robert Ijtsma <robertijtsma@gmail.com>

drm/msm/dp: clear AUX_TRANS_CTRL on reset and enable HPD_REFTIMER

This commit clears REG_DP_AUX_TRANS_CTRL in msm_dp_aux_reset() and enables
DP_DP_HPD_REFTIMER_ENABLE in msm_dp_aux_enable() so AUX transactions work
on boards that do not use internal HPD.

> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_=
aux.c
> index b52393dcc0670..2584dbf960431 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -76,6 +76,8 @@ static void msm_dp_aux_reset(struct msm_dp_aux_private =
*aux)
>  {
>  	u32 aux_ctrl;
> =20
> +	msm_dp_write_aux(aux, REG_DP_AUX_TRANS_CTRL, 0);

[Severity: Medium]
Is msm_dp_aux_reset() ever reached when internal HPD is disabled?

The only active caller is msm_dp_aux_transfer(), which gates the reset on
msm_dp_aux_is_link_connected():

drivers/gpu/drm/msm/dp/dp_aux.c:msm_dp_aux_transfer() {
    ...
	if (ret < 0) {
		if (aux->native) {
			aux->retry_cnt++;
			if (!(aux->retry_cnt % MAX_AUX_RETRIES))
				phy_calibrate(aux->phy);
		}
		/* reset aux if link is in connected state */
		if (msm_dp_aux_is_link_connected(msm_dp_aux))
			msm_dp_aux_reset(aux);
	} else {
    ...
}

msm_dp_aux_is_link_connected() reads the internal HPD state machine status
bits from REG_DP_DP_HPD_INT_STATUS, which stay 0 when internal HPD_CTRL is
never enabled, so msm_dp_aux_reset() is skipped on external-HPD boards.

In addition, once DP_DP_HPD_REFTIMER_ENABLE is set, hardware AUX timeouts
raise DP_INTR_TIMEOUT in msm_dp_aux_isr(), which sets aux->aux_error_num =3D
DP_AUX_ERR_TOUT and completes aux->comp.  msm_dp_aux_cmd_fifo_tx() then
returns a non-negative value and msm_dp_aux_transfer() takes the else
branch, returning -ETIMEDOUT without calling msm_dp_aux_reset() or clearing
REG_DP_AUX_TRANS_CTRL.

> +
>  	aux_ctrl =3D msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
> =20
>  	aux_ctrl |=3D DP_AUX_CTRL_RESET;
> @@ -88,7 +90,12 @@ static void msm_dp_aux_reset(struct msm_dp_aux_private=
 *aux)
> =20
>  static void msm_dp_aux_enable(struct msm_dp_aux_private *aux)
>  {
> -	u32 aux_ctrl;
> +	u32 aux_ctrl, reftimer;
> +
> +	/* Keep the 1us AUX/HPD reference timer running without internal HPD. */
> +	reftimer =3D msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
> +	reftimer |=3D DP_DP_HPD_REFTIMER_ENABLE;
> +	msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reftimer);

[Severity: Medium]
Will msm_dp_aux_hpd_disable() turn off DP_DP_HPD_REFTIMER_ENABLE while the
AUX controller is still active?

msm_dp_aux_hpd_disable() unconditionally clears DP_DP_HPD_REFTIMER_ENABLE
in REG_DP_DP_HPD_REFTIMER (while msm_dp_aux_disable() leaves it untouched).
During system suspend, drm_mode_config_helper_suspend() runs
drm_kms_helper_poll_disable() -> msm_dp_bridge_hpd_disable() ->
msm_dp_aux_hpd_disable() before drm_atomic_helper_suspend() disables active
displays.  When a display is connected and holds runtime PM active, any AUX
transactions during drm_atomic_helper_suspend() (such as
msm_dp_link_psm_config() in msm_dp_display_unprepare()) will run with the
reference timer disabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-drm-msm-dp=
-aux-resume-v1-1-17f5a40b9a61@gmail.com?part=3D1
