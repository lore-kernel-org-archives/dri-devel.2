Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B90C43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:40:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF26B10F23F;
	Thu,  2 Jul 2026 08:40:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZJ2BmKOv";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B61110F23D
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 08:40:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 958496001D;
 Thu,  2 Jul 2026 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E691F00A3A;
 Thu,  2 Jul 2026 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782981623;
 bh=FAh4FOAqDFjEx2FelwY5zNyhzWl7awFBtNsnC0pgpD0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZJ2BmKOvikxWllR4IW2WEDY5Sqb2nwC6To2UmDHGmzgWkPSTnsp0puI/kjSe/RRqJ
 lr8WzV8GrODws8jfgM/5WmpQM8Hi6zCR4HmuOibqamDT8PhHYy+DC6gowSuKSnURZ3
 Jgt4fW6XUoXyVk2f39UMXrYUP/guBJ/v1quKXpMGbk418AwwKm6mSSdVh847jmhLCa
 yJIXAPOOPed+8OV4jhIyP6QkEEkSFSyi+tuQECAmj6T+FdTsvQOrhQQ9v6MzJfBzXl
 mvTt2ampNmBeRQ0wr4aLCAb02xGUWdNloRPqczUkAy2B3BkWOiWKaanGkwjrh1Cvwl
 gY/9trtGldm3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/i915/display: Use intel_de_write_fw in
 intel_pipe_fastset
To: "Maarten Lankhorst" <dev@lankhorst.se>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702080346.431508-4-dev@lankhorst.se>
References: <20260702080346.431508-1-dev@lankhorst.se>
 <20260702080346.431508-4-dev@lankhorst.se>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 08:40:22 +0000
Message-Id: <20260702084023.29E691F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing Wakelock / DC State Hardware Hang

Pre-existing issues:
- [High] Sleeping in Atomic Context (Incomplete Fix)
--

commit b928342b55781fe54de15efd0d013221c43c3091
Author: Maarten Lankhorst <dev@lankhorst.se>

drm/i915/display: Use intel_de_write_fw in intel_pipe_fastset

This commit updates multiple display configuration functions to use the
_fw register write variants to bypass DMC wakelock acquisition. This is
intended to fix a sleep-in-atomic-context deadlock on PREEMPT_RT when
modifying display registers during vblank evasion.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> index 5bc8e6ea10a50..f5dac380aa7ff 100644
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
[ ... ]
> @@ -2607,14 +2607,14 @@ void intel_set_m_n(struct intel_display *display,
>  		   intel_reg_t data_m_reg, intel_reg_t data_n_reg,
>  		   intel_reg_t link_m_reg, intel_reg_t link_n_reg)
>  {
> -	intel_de_write(display, data_m_reg, TU_SIZE(m_n->tu) | m_n->data_m);
> -	intel_de_write(display, data_n_reg, m_n->data_n);
> -	intel_de_write(display, link_m_reg, m_n->link_m);
> +	intel_de_write_fw(display, data_m_reg, TU_SIZE(m_n->tu) | m_n->data_m);
> +	intel_de_write_fw(display, data_n_reg, m_n->data_n);
> +	intel_de_write_fw(display, link_m_reg, m_n->link_m);
>  	/*
>  	 * On BDW+ writing LINK_N arms the double buffered update
>  	 * of all the M/N registers, so it must be written last.
>  	 */
> -	intel_de_write(display, link_n_reg, m_n->link_n);
> +	intel_de_write_fw(display, link_n_reg, m_n->link_n);

[Severity: High]
Does using intel_de_write_fw() here risk writing to hardware while it is in=
 a
deep sleep DC state?

When intel_set_m_n() is called asynchronously by intel_drrs_downclock_work()
through intel_drrs_set_refresh_rate_m_n():

drivers/gpu/drm/i915/display/intel_drrs.c:intel_drrs_set_refresh_rate_m_n()=
 {
    ...
    intel_cpu_transcoder_set_m1_n1(crtc, crtc->drrs.cpu_transcoder,
                                   refresh_rate =3D=3D DRRS_REFRESH_RATE_LO=
W ?
                                   &crtc->drrs.m2_n2 : &crtc->drrs.m_n);
    ...
}

This async work runs when the display is idle and holds no outer DMC
wakelocks. Bypassing the implicit wakelock acquisition could lead to the
transcoder M/N registers being written without waking up the DMC,
potentially causing dropped writes or hardware hangs.

>  }
> =20
>  bool intel_cpu_transcoder_has_m2_n2(struct intel_display *display,
[ ... ]
> diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i=
915/display/intel_vrr.c
> index bffbdee76ee1c..5b09a17185b9c 100644
> --- a/drivers/gpu/drm/i915/display/intel_vrr.c
> +++ b/drivers/gpu/drm/i915/display/intel_vrr.c
[ ... ]
> @@ -923,8 +923,8 @@ static void intel_vrr_tg_enable(const struct intel_cr=
tc_state *crtc_state,
>  	enum transcoder cpu_transcoder =3D crtc_state->cpu_transcoder;
>  	u32 vrr_ctl;
> =20
> -	intel_de_write(display, TRANS_PUSH(display, cpu_transcoder),
> -		       trans_vrr_push(crtc_state, false));
> +	intel_de_write_fw(display, TRANS_PUSH(display, cpu_transcoder),
> +			  trans_vrr_push(crtc_state, false));
> =20
>  	vrr_ctl =3D VRR_CTL_VRR_ENABLE | trans_vrr_ctl(crtc_state);
> =20

[Severity: High]
This is a pre-existing issue, but while you are converting these functions =
to
avoid sleeping in atomic context, do intel_vrr_set_transcoder_timings(),
intel_vrr_set_vrr_timings(), and intel_vrr_enable_dc_balancing() also need
to be converted to use the _fw variants?

They are called during the vblank evasion loop (which disables interrupts a=
nd
preemption) and still use intel_de_write(), which acquires the DMC wakelock
and uncore spinlock, both of which can sleep on PREEMPT_RT:

intel_de_write(display, TRANS_VRR_CTL(display, cpu_transcoder),
               trans_vrr_ctl(crtc_state));

Will leaving these unconverted result in the same sleep-in-atomic-context
deadlocks during display mode sets or fastsets with VRR enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702080346.4315=
08-1-dev@lankhorst.se?part=3D3
