Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF14CA9ED8
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C475710EC9C;
	Mon, 12 Oct 2026 04:51:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5149C10EC98;
 Mon, 12 Oct 2026 04:51:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D0E3601FA;
 Mon, 12 Oct 2026 04:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D911F0089B;
 Mon, 12 Oct 2026 04:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780685;
 bh=5nwFjXy3l6U41bbWQU5joM4GO2hiIDB/u852tSLOFFM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HbfXtzmmJVIRjxdXD0bzojZxHxWZRKmgvEAH/xD1OOSjG1LR4bp1TjsrOM4znC1mH
 lnhTZJU8SW43CrnqqWYwB1nJBu2tPeJiw59Qnt1fgRMncxn6mO3tDPT61+3vHSzqyq
 dl3CE25ID7IdD0LfVJlm1cjBQjeCtWiIYxjd/1gny3XrTZydGOUDGYbZIzZYOjvSHJ
 YtPUlJNY+M2ene8hkRSjpyFS0vLZuH+ODp0VejtXHAQKaR/RxIAn9mZQGcq6GIM0V9
 0yu7gCdVftsFuZDB2zTh8rrbJ/oIJGRf8qIQBMQJ/q9d6jIPNGNLAsd0t+GKXnJWjN
 HecEJmDAJ7bsA==
Message-ID: <sashiko-outbox-167635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 42/56] drm/i915/hdmi: Add read out for FRL state
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-43-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-43-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:51:24 +0000
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
- [Medium] drm/i915: unconditional extraction of FRL configuration fields c=
auses state mismatches
--

commit 7fe3edceb823d24a4b2a0a493b7dfd96cc58cbdd
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi: Add read out for FRL state

Read out the FRL configuration and Data Flow Metering registers and fill the
FRL members in crtc_state. In subsequent changes these are added to the
state checker and compared bwteen two crtc_states in
intel_pipe_config_compare().

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index 69612ebe80f04..c5f25d2d6331c 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c

[ ... ]

> @@ -4160,3 +4160,38 @@ void intel_hdmi_frl_cfg_write(const struct intel_c=
rtc_state *crtc_state)
> =20
>  	intel_de_rmw(display, TRANS_HDMI_FRL_CFG(display, cpu_trans), 0, val);
>  }
> +
> +static void intel_hdmi_frl_cfg_read(struct intel_crtc_state *crtc_state)
> +{
> +	struct intel_display *display =3D to_intel_display(crtc_state);
> +	enum transcoder cpu_trans =3D crtc_state->cpu_transcoder;
> +	u32 val;
> +
> +	val =3D intel_de_read(display, TRANS_HDMI_FRL_CFG(display, cpu_trans));
> +
> +	if (val & TRANS_HDMI_FRL_ENABLE)
> +		crtc_state->frl.enable =3D true;
> +
> +	crtc_state->frl.rsrc_sched_en =3D
> +		REG_FIELD_GET(TRANS_HDMI_R_B_SCHED_ENABLE_MASK, val);
> +	crtc_state->frl.active_char_buf_threshold =3D
> +		REG_FIELD_GET(TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH_MASK, val);

[Severity: Medium]
Will this unconditional extraction cause state mismatch warnings during
fastset?

When FRL is disabled, it typically only clears the TRANS_HDMI_FRL_ENABLE bi=
t,
potentially leaving stale non-zero values in the other bitfields of this
register. Because these fields are extracted and stored in the hardware sta=
te
without being guarded by a check for TRANS_HDMI_FRL_ENABLE, the hardware st=
ate
will contain these stale values even for non-FRL (TMDS) modes.

If these fields are then compared in intel_pipe_config_compare(), it may
trigger a state mismatch because the computed software state has these fiel=
ds
properly zeroed out for TMDS modes.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D42
