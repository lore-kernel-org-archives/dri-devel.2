Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD27FCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:35:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C63410E99B;
	Mon, 12 Oct 2026 04:35:44 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FB2F10E6DE;
 Mon, 12 Oct 2026 04:35:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 704E7432B3;
 Mon, 12 Oct 2026 04:35:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA861F0089B;
 Mon, 12 Oct 2026 04:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779737;
 bh=buQ/dT+qZ6UXD4lxWkW/nH7QYfLsy264ejLwD4EymfU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UzKSR05EKuYLmL7VZKcWC5ywH8pOT9PfaL0BC0WF7tL2Ouyatds6+BCsmBUVWUW+/
 SCojpV9ZTomlZgYk0h3uPYhVX8g1es4fKiC6h2basSD12S4V6u0crJuwtsmxNRt+n8
 L0VMMKlZOafol8OA6bDc92/vrARB7+ZKhAOfKDdwqmvmN+BjOlDQ+D0FQERqeJPOSs
 wDGtW4fQDuAlYwq7ehHD/Z/jxJI8AyRXCehEl06IhJkbc/xS6YShm4Eg3JYHA4wnwB
 gTYsNRRaUMIzVr8pqAqBvB8/5spLcT98NEtlN2FCOTeYiQXtY5eqhTOvsgbFYjuclb
 uZRmOgRhqjCmw==
Message-ID: <sashiko-outbox-167612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 27/56] drm/i915/hdmi_frl_dfm_regs: Define DFM registers
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-28-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-28-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:35:36 +0000
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
- [Low] drm/i915: Typo in TB_MIN_THESHOLD macro names
--

commit 630f464ba2dd2b53e20d33d3caf2861bb55f1fa9
Author: Vandita Kulkarni <vandita.kulkarni@intel.com>

drm/i915/hdmi_frl_dfm_regs: Define DFM registers

This commit adds definitions for HDMI FRL dataflow metering registers to
handle DFM values.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h b/dri=
vers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h
> new file mode 100644
> index 0000000000000..bb5cb76b3806b
> --- /dev/null
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi_frl_dfm_regs.h

[ ... ]

> +#define _TRANS_HDMI_FRL_DFMTHRSH_A			0x600c4
> +#define TRANS_HDMI_FRL_DFMTHRSH(dev_priv, trans)	_MMIO_TRANS2(dev_priv, \
> +								     trans, \
> +								     _TRANS_HDMI_FRL_DFMTHRSH_A)
> +#define  RUN_LEN_THRESHOLD_MASK				REG_GENMASK(31, 24)
> +#define  RUN_LEN_THRESHOLD(val)				REG_FIELD_PREP(RUN_LEN_THRESHOLD_MASK=
, val)
> +#define  TB_MAX_THRESHOLD_MASK				REG_GENMASK(21, 12)
> +#define  TB_MAX_THRESHOLD(val)				REG_FIELD_PREP(TB_MAX_THRESHOLD_MASK, =
val)
> +#define  TB_MIN_THESHOLD_MASK				REG_GENMASK(9, 0)
> +#define  TB_MIN_THESHOLD(val)				REG_FIELD_PREP(TB_MIN_THESHOLD_MASK, va=
l)

[Severity: Low]
This isn't a bug, but there appears to be a typo in the names of these
minimum threshold macros where THRESHOLD is spelled as THESHOLD. Could
these be updated to include the missing R for consistency with the
TB_MAX_THRESHOLD macros defined just above?

> +
> +#endif /* __INTEL_HDMI_FRL_DFM_REGS_H__ */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D27
