Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E2ECA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3792210EB8E;
	Mon, 12 Oct 2026 04:58:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9D410E4B6;
 Mon, 12 Oct 2026 04:58:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B07B444002;
 Mon, 12 Oct 2026 04:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A061F0089B;
 Mon, 12 Oct 2026 04:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791781091;
 bh=N+IQ5UdKybR/yr2F/imU6346cC7w9uh3D+7mTxEwUvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DqGlbAsOP6EuoRd4XhaML2ijHjgfDtWDBx62Z0LzKfZC0SQ8+uAM6/Hh9ze46eONS
 zKLUTSbkaTFFemSa806HsT1UNbq2w32hY92cG9dZwQ3/00qNpXzJkk7Oti0p8FgKxU
 49P7toXVHq4EfXYtFcNlfg9ZXfx+ZKL4BWK/jsjI/zKq7MyuBHBOLFMhuaGaiY0run
 0qmBK4x+Mz8XJW+jOF8a3oISG+0ABbkSCaLeq/iReQxKzLrE7qmEUAbr7jJdsDKtdW
 i9pb7aHC3XOA0z0jg4cKg0eGYbmx2cPTj4iHrLLIMU+XqNbG1iXJohFrYil8WpZK5W
 cwl3H9CciTKqQ==
Message-ID: <sashiko-outbox-167647@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 50/56] drm/i915/hdmi: Enable FRL based mode clock valid
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-51-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-51-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:58:10 +0000
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
- [High] drm/i915/hdmi: 4K120 4:2:0 bypasses FRL and fails via TMDS
--

commit 4c023e7cde26d2644e793aa505b046a46b2d33ef
Author: Vandita Kulkarni <vandita.kulkarni@intel.com>

drm/i915/hdmi: Enable FRL based mode clock valid

Higher resolution modes like 8K@60, 4K@120 need FRL support. Platforms
before MTL do not support FRL, so allow modes requiring more than 600MHz
dotclock to be enumerated only on MTL+ where FRL is supported.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index c57d99195ed03..e3dbd71a3652e 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c

[ ... ]

> @@ -2176,12 +2179,10 @@ intel_hdmi_mode_valid(struct drm_connector *_conn=
ector,
>  	}
> =20
>  	/*
> -	 * HDMI2.1 requires higher resolution modes like 8k60, 4K120 to be
> -	 * enumerated only if FRL is supported. Current platforms do not support
> -	 * FRL so prune the higher resolution modes that require doctclock more
> -	 * than 600MHz.
> +	 * Platforms < MTL do not support FRL so prune the higher resolution
> +	 * modes that require doctclock more than 600MHz.
>  	 */
> -	if (clock > 600000)
> +	if (!intel_hdmi_can_support_frl(hdmi) && clock > 600000)
>  		return MODE_CLOCK_HIGH;

[Severity: High]
Does this allow high-bandwidth 4:2:0 modes to bypass FRL validation and
fail later during atomic commit?

By restricting the 600MHz dotclock limit to non-FRL platforms here,
dotclocks up to 1200MHz can reach format validation on FRL platforms.
However, when a mode like 4K@120Hz (1188MHz) in YCbCr 4:2:0 format reaches
intel_hdmi_mode_valid_format(), the TMDS clock check executes first:

intel_hdmi_mode_valid_format() {
    ...
    status =3D intel_hdmi_tmds_mode_clock_valid(&connector->base, clock,
                                              has_hdmi_sink, sink_format);

    if (status !=3D MODE_OK && intel_hdmi_can_support_frl(hdmi))
        status =3D intel_hdmi_frl_mode_clock_valid(connector, mode,
                                                 sink_format);
    ...
}

For 4:2:0 formats, intel_hdmi_tmds_mode_clock_valid() halves the 1188MHz
dotclock to 594MHz, which successfully passes the TMDS limit check and
returns MODE_OK.

Since the status is MODE_OK, intel_hdmi_frl_mode_clock_valid() is
completely bypassed. The mode is incorrectly validated as TMDS instead of
FRL. Because TMDS configuration does not support pipe joiner, the single-pi=
pe
dotclock limits will be exceeded during compute_config, causing the atomic
commit to fail for advertised modes.

> =20
>  	if (drm_mode_is_420_only(info, mode)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D50
