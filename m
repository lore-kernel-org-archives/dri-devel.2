Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9EECA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5B7910E98C;
	Mon, 12 Oct 2026 04:54:25 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 343E710E978;
 Mon, 12 Oct 2026 04:54:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E424B42D87;
 Mon, 12 Oct 2026 04:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918531F0089B;
 Mon, 12 Oct 2026 04:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780858;
 bh=7dghQZ6ZwPZbpPZKl+myzz8b5ED4mw3XYiqXI/2sy48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X6U5cLmjc9U0baRkOfp7imibT3THVPkaivNTFflBV3BezNSPHqoUxwom9qXpfiz/L
 qX8kpnlaAVrFY0sqdILHBxkDkH+m7QNw8tZDnZlJDxe492CHGakF/sRp6HN+qCm6GX
 lTmSmo9Q2SsdKgAesgyniePL/s82mYyXUNhla3XsHrNm8fGzXBBC+UrAHZSsO8Wm6p
 GbgFQIWv4p9ugg9YhlA2BfezieND2Vio/qFzTP6U4RrM+545cL3JmdyDlBDFA9r7lD
 SxyXmdRdHZPJUCf6ZaGi8Qq7lNPFF45oBUwx2g4tD+BRaM5+i4KnX3qmgvrQoECSEM
 ldcnYz0pP+rfw==
Message-ID: <sashiko-outbox-167642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 40/56] drm/i915/ddi: Wire FRL into the HDMI DDI
 enable/disable path
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-41-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-41-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:54:18 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/i915/hdmi: connector refcount underflow via modeset_retry_work
- [Medium] drm/i915/hdmi: intel_hdmi_frl_cfg_write corrupts register by omi=
tting clear mask
- [Medium] drm/i915: unconditional FRL configuration and transcoder enablem=
ent contrary to commit message
--

commit cfc5e8ca998b654bfa60f35c76733a4d8332204f
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Subject: drm/i915/ddi: Wire FRL into the HDMI DDI enable/disable path

This commit enables HDMI FRL in the DDI enable and disable sequences for
MTL+. It prepares for FRL mode, starts FRL link training, and configures
the FRL registers if enabled. On disable, it handles LTS:L teardown and
register cleanup.

> diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i=
915/display/intel_ddi.c
> index 53e889c0d0223..22a49eb50b203 100644
> --- a/drivers/gpu/drm/i915/display/intel_ddi.c
> +++ b/drivers/gpu/drm/i915/display/intel_ddi.c
[ ... ]
> @@ -3605,8 +3614,15 @@ static void intel_ddi_enable_hdmi(struct intel_ato=
mic_state *state,
> =20
>  	intel_ddi_buf_enable(encoder, buf_ctl);
> =20
> -	if (DISPLAY_VER(display) >=3D 14)
> +	if (DISPLAY_VER(display) >=3D 14) {
> +		if (crtc_state->frl.enable &&
> +		    intel_hdmi_start_frl(encoder, crtc_state) < 0)
> +			schedule_work(&intel_connector->modeset_retry_work);

[Severity: High]
Does this code underflow the connector reference count?

If intel_hdmi_start_frl() fails, schedule_work() is called directly without
taking a reference via drm_connector_get(). If the driver suspends, unbinds,
or calls intel_hpd_cancel_work(), it calls
intel_connector_cancel_modeset_retry_work(). This generic cancel helper
invokes cancel_work_sync() and unconditionally calls drm_connector_put() if
the work was pending. Because the work was queued without taking a referenc=
e,
this drops an unowned reference.

> +
> +		intel_hdmi_frl_cfg_write(crtc_state);

[Severity: Medium]
Does intel_hdmi_frl_cfg_write() corrupt the register by omitting a clear ma=
sk?

When this function is called here, it performs a read-modify-write on the
TRANS_HDMI_FRL_CFG register:

intel_hdmi.c:intel_hdmi_frl_cfg_write() {
    ...
    val =3D TRANS_HDMI_R_B_SCHED_ENABLE(crtc_state->frl.rsrc_sched_en);
    val |=3D TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH(crtc_state->frl.active_char_=
buf_threshold);
    val |=3D TRANS_HDMI_MIN_BLANK_CHAR(TRANS_HDMI_MIN_BLANK_CHAR_VAL);

    intel_de_rmw(display, TRANS_HDMI_FRL_CFG(display, cpu_trans), 0, val);
}

Because the clear mask is 0, intel_de_rmw() performs a read, leaves all
existing bits intact, and then bitwise ORs the new val. This could
permanently corrupt the hardware configuration if the previous register
value had bits set that should be zero in the new configuration.

[Severity: Medium]
Does this execute hardware configuration unconditionally despite failures?

The commit message explicitly states: "If FRL link training fails, notify
userspace. On success, write DFM registers and enable the transcoder."
However, the code unconditionally calls intel_hdmi_frl_cfg_write(),
intel_hdmi_frl_dfm_write(), and intel_ddi_enable_transcoder_and_vblank()
even if intel_hdmi_start_frl() returns an error. While this might be
architecturally consistent with how DisplayPort handles link training
failures, is there a discrepancy between the documented intent and the
actual implementation?

> +		intel_hdmi_frl_dfm_write(crtc_state);
>  		intel_ddi_enable_transcoder_and_vblank(state, encoder, crtc_state);
> +	}
> =20
>  	intel_hdmi_poll_for_scrambling_enable(crtc_state, connector);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D40
