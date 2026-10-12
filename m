Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB86BCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1165910EC31;
	Mon, 12 Oct 2026 04:54:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A0E010EC31;
 Mon, 12 Oct 2026 04:54:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DBD6860AA1;
 Mon, 12 Oct 2026 04:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5416C1F0089B;
 Mon, 12 Oct 2026 04:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780879;
 bh=sLYB7o48L5PjJ9/avTiuaK58U3ZPTJcg9lHqPN9r+9k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UBRhk4uSQtU8oW9IJk1F6q1K0UWTtxaG27l3isRQ/YUyOq7hNyMmQnQ/1YM0Dq2YW
 DE8BkaV2cYCAHxVET1nJPLBukT1zkkreUmMjXAOxad+INdO809sSv2UNZTFbAUPUO/
 hAs6hY60OaoBsPyY1kAw5gV5xNUrab5U4YfJaJj84a0xIApRJ0MNgK665a05UfaTso
 EL1ETw76QgzIIVKeRWdOshV5SwdGW+bE7XFzfPJJ1XQIoaSawNt+MTVVNzD6HNXmMx
 gt6l1/RHwSme/yHSaURSOE+TA7lXo1Cre04P3lMUXj6jz3XChk4XpYo9D3B9UYQf5D
 CvxkX9JlICqcQ==
Message-ID: <sashiko-outbox-167643@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 46/56] drm/i915/display: Add FRL members to the state
 checker
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-47-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-47-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:54:38 +0000
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
- [Medium] drm/i915/display: Incomplete FRL state verification missing tb_t=
hreshold_min and required_rate
- [Medium] drm/i915: spurious WARN_ON in state checker due to uncleared FRL=
 config bits
--

commit 5c7a8a2a5c09104f1fb54f2b4082592bd27316bb
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/display: Add FRL members to the state checker

This commit introduces hardware state verification for FRL (Fixed Rate Link)
by adding several FRL configuration members to the state checker.

> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/d=
rm/i915/display/intel_display.c
> --- a/drivers/gpu/drm/i915/display/intel_display.c
> +++ b/drivers/gpu/drm/i915/display/intel_display.c
> @@ -5626,6 +5626,14 @@ intel_pipe_config_compare(const struct intel_crtc_=
state *current_config,
> =20
>  	PIPE_CONF_CHECK_I(set_context_latency);
> =20
> +	PIPE_CONF_CHECK_BOOL(frl.enable);
> +	PIPE_CONF_CHECK_BOOL(frl.rsrc_sched_en);
> +	PIPE_CONF_CHECK_I(frl.required_lanes);
> +	PIPE_CONF_CHECK_I(frl.tb_actual);
> +	PIPE_CONF_CHECK_I(frl.active_char_buf_threshold);

[Severity: Medium]
Will checking frl.rsrc_sched_en and frl.active_char_buf_threshold trigger
spurious WARN_ON state mismatches due to uncleared hardware bits?

Looking at intel_hdmi_frl_cfg_write() in intel_hdmi.c, it appears to use
intel_de_rmw() with a clear mask of 0:

intel_hdmi.c:intel_hdmi_frl_cfg_write() {
    ...
    val =3D TRANS_HDMI_R_B_SCHED_ENABLE(crtc_state->frl.rsrc_sched_en);
    val |=3D TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH(crtc_state->frl.active_char_=
buf_threshold);
    ...
    intel_de_rmw(display, TRANS_HDMI_FRL_CFG(display, cpu_trans), 0, val);
}

Since the clear mask is 0, preexisting bits from BIOS or prior configuratio=
ns
will persist in the hardware register. Will the state checker trip over the=
se
leftover bits when it compares them against the software state?

> +	PIPE_CONF_CHECK_I(frl.link_m);
> +	PIPE_CONF_CHECK_I(frl.link_n);

[Severity: Medium]
Should frl.tb_threshold_min and frl.required_rate also be verified here?

The driver actively populates tb_threshold_min from hardware during state
readout in intel_hdmi_frl_dfm_read():

intel_hdmi_frl_dfm.c:intel_hdmi_frl_dfm_read() {
    ...
    val =3D intel_de_read(display, TRANS_HDMI_FRL_DFMTHRSH(display, cpu_tra=
ns));
    crtc_state->frl.tb_threshold_min =3D REG_FIELD_GET(TB_MIN_THESHOLD_MASK=
, val);
    ...
}

Similarly, frl.required_rate is populated during hardware readout in
intel_hdmi_frl_get_config(). Without adding these fields to the state check=
er,
can hardware state corruption or mismatches for the minimum threshold and
required rate go undetected?

> +
>  #undef PIPE_CONF_CHECK_X
>  #undef PIPE_CONF_CHECK_I
>  #undef PIPE_CONF_CHECK_LLI

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D46
