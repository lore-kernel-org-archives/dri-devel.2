Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1ABDCA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:43:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071A210E58B;
	Mon, 12 Oct 2026 04:43:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F192E10E4B0;
 Mon, 12 Oct 2026 04:42:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B08F60A9D;
 Mon, 12 Oct 2026 04:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F4841F0089B;
 Mon, 12 Oct 2026 04:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780172;
 bh=h9irwgE+hAAgjuhb34+Vg/6K0qGl0+P28LgQSGoGO18=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RRuNMFSqD1j3JnA891rin3zk5nfDo04RQtQDVsaHv77pKeGo6nyE/pSIk3mfSsdkE
 laojrDWbRGjBfTkWlNDqvmLfDql1MIozfKSvIaFfuTJT50ppdGJt5Cia9I8DCoo3BY
 snvK0IcxnuSso7hPFwi4LLR9FqoV2mifwA7a9taf9GcZcl4cWhVZ0oQiw+IiDGvkhg
 6HWb69SWWbnJvAARZPdhYk3WSuCvfvwsVsNUPyxc05hSBn73JCSG8qpaC6HEUNdwJ8
 3OtqXeHQUcY9Ud5Py9DMD+V80ris34brF7KMCNpi8dBck/aAJQbp4W8aI8LG7gVHtp
 xWZB5a1lUmZlQ==
Message-ID: <sashiko-outbox-167621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 32/56] drm/i915/hdmi_frl_dfm: Add helpers to
 read/write FRL DFM registers
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-33-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-33-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:42:52 +0000
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
- [Low] i915/display: spelling mistake in TB_MIN_THESHOLD macro usage
--

commit 468a8e227948c1192c42e05f62742d8315145e2f
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi_frl_dfm: Add helpers to read/write FRL DFM registers

This commit introduces helpers to read and write FRL Data Flow Metering
registers.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c b/drivers/=
gpu/drm/i915/display/intel_hdmi_frl_dfm.c
> index fe1df69a10968..8062baed63db8 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm.c
[ ... ]
> @@ -719,3 +724,40 @@ bool intel_hdmi_frl_dfm_dsc_requirement_met(struct i=
ntel_hdmi_frl_dfm *frl_dfm)
[ ... ]
> +void intel_hdmi_frl_dfm_write(const struct intel_crtc_state *crtc_state)
> +{
[ ... ]
> +	reg =3D TRANS_HDMI_FRL_DFMTHRSH(display, cpu_trans);
> +	val =3D TB_MIN_THESHOLD(crtc_state->frl.tb_threshold_min);
> +	intel_de_rmw(display, reg, TB_MIN_THESHOLD_MASK, val);

[Severity: Low]
This isn't a bug, but there appears to be a typo in the macro names
TB_MIN_THESHOLD and TB_MIN_THESHOLD_MASK (missing the 'R' in THRESHOLD).

Would it be worth updating the spelling to maintain consistency with
adjacent macros and the struct field tb_threshold_min?

> +}
> +
> +void intel_hdmi_frl_dfm_read(struct intel_crtc_state *crtc_state)
> +{
[ ... ]
> +	val =3D intel_de_read(display, TRANS_HDMI_FRL_DFMTHRSH(display, cpu_tra=
ns));
> +	crtc_state->frl.tb_threshold_min =3D
> +		REG_FIELD_GET(TB_MIN_THESHOLD_MASK, val);

[Severity: Low]
This isn't a bug, but the same typo (THESHOLD instead of THRESHOLD) is also
present here.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D32
