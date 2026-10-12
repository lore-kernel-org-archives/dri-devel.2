Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE7FCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D36CC10E663;
	Mon, 12 Oct 2026 04:33:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B23BA10E4BB;
 Mon, 12 Oct 2026 04:33:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B364160AA5;
 Mon, 12 Oct 2026 04:33:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C49E1F0089B;
 Mon, 12 Oct 2026 04:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779614;
 bh=63pqXxUQiih13ifHZi9E86CRWAZPNq3G+dF4pmDH8Bw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X+Et7BBJl7p086DTJyYrpFosRV0g7QWeoseeln+lxPULs767ZnHzDY3UAVQ7w8Ckd
 AmEoaErM4tWnexVwedI5kEgHujFYhkA3g2d4M5anE8Ev4DhmkgCTgHAYwJkDMmoa2r
 WsJ7NBOhAQjBP1o4p4QfGArgFQkA6F6V4p+oC3PLxELbZMaeTOCuCi+nvRaQRzpzXp
 jTomzktc/2WumjZz8TWk/5RSKw+oee/KbDFHy8JHFmshLT0uHi1QJHgNRlZBQQhBhn
 E0Seq87Kdou7MIunjF/jU5dqcQdxEzS31Km7y4FuvPuqPlYtU03Tcf3bOE07SPCqLH
 L28x5PtfQDgcQ==
Message-ID: <sashiko-outbox-167608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 31/56] drm/i915/hdmi: Add helper to write FRL CFG
 register
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-32-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-32-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:33:33 +0000
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
- [Medium] drm/i915: missing clear mask in intel_hdmi_frl_cfg_write() cause=
s register corruption
--

commit 0a0fe491d4ed801c5c5d75f8cf1134e058f90bcb
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi: Add helper to write FRL CFG register

This commit introduces a helper function, intel_hdmi_frl_cfg_write(), to
write FRL CFG register bits.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> +void intel_hdmi_frl_cfg_write(const struct intel_crtc_state *crtc_state)
> +{
> +	struct intel_display *display =3D to_intel_display(crtc_state);
> +	enum transcoder cpu_trans =3D crtc_state->cpu_transcoder;
> +	u32 val;
> +
> +	if (!crtc_state->frl.enable)
> +		return;
> +
> +	val =3D TRANS_HDMI_R_B_SCHED_ENABLE(crtc_state->frl.rsrc_sched_en);
> +	val |=3D TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH(crtc_state->frl.active_char_=
buf_threshold);
> +	val |=3D TRANS_HDMI_MIN_BLANK_CHAR(TRANS_HDMI_MIN_BLANK_CHAR_VAL);
> +
> +	intel_de_rmw(display, TRANS_HDMI_FRL_CFG(display, cpu_trans), 0, val);

[Severity: Medium]
Will this read-modify-write operation accumulate stale bits across multiple
modesets?

The intel_de_rmw() implementation computes the new register value using
(old_val & ~clear) | set. Because 0 is passed as the clear mask here, the n=
ew
configuration values are simply bitwise OR'd against the old register state.

This means multi-bit fields like active_char_buf_threshold could accumulate
bits (e.g. changing from 010 to 001 results in 011), and boolean flags like
rsrc_sched_en might not transition from true to false once set.

Should the clear mask explicitly include TRANS_HDMI_R_B_SCHED_ENABLE_MASK,
TRANS_HDMI_ACTIVE_CHAR_BUF_THRESH_MASK, and TRANS_HDMI_MIN_BLANK_CHAR_MASK?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D31
