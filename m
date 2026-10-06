Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A66CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 05:48:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CDFE10E091;
	Tue,  6 Oct 2026 05:48:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="M3mJAZrs";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0FDB10E091;
 Tue,  6 Oct 2026 05:48:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 04D3C60142;
 Tue,  6 Oct 2026 05:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C12D1F000FF;
 Tue,  6 Oct 2026 05:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791265689;
 bh=orgievS4DyYpF+w1OtbLYn2oZvC2aW7sysz6197Ya7E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=M3mJAZrs4XJOxkgVsX2ZWuTR5J7jI9QPe2G88J/rOQQKM21wEOOEd/3Qnszdg11tP
 GAT6uTt9fd8y58QTVtzCMno3mp78yPp4Ra9CUyHO74utVC8hsxnvYgs5EYGWdO0tv+
 xIIxQwKWdoxNHIN0XrXQtXjEv7zg/lniZmza/9TjdfMOwTRSsLHgm/az1CRs8OgKqw
 32pQ1utou9R/528kt2enYnAL1TAJJFjHMvvZdESzm1T/wveB7U1TbVCtw5NGYYa3ar
 37LxXf+Fml0oXtgAzBARiXfI2VCMIUa+2u/FUBtDwyFy4OouMgnq+ZBUgZrpHLQ7lK
 9ta1fCD5wQP0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] video/hdmi: Add hdmi_eotf_get_name()
To: "Pranay Samala" <pranay.samala@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261006054004.285744-2-pranay.samala@intel.com>
References: <20261006054004.285744-1-pranay.samala@intel.com>
 <20261006054004.285744-2-pranay.samala@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 05:48:09 +0000
Message-Id: <20261006054809.8C12D1F000FF@smtp.kernel.org>
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
- [Low] video/hdmi: missing hdmi_eotf_get_name() usage in hdmi_drm_infofram=
e_log()
--

commit b4b5c92367345e70aebcf91cfdea62895c2744ff
Author: Pranay Samala <pranay.samala@intel.com>

video/hdmi: Add hdmi_eotf_get_name()

This patch introduces hdmi_eotf_get_name() to provide human-readable strings
for electro-optical transfer functions. The helper is placed next to other
similar hdmi string helpers.

> diff --git a/drivers/video/hdmi.c b/drivers/video/hdmi.c
> index 45b42f14a7503..cd62afcd38d7d 100644
> --- a/drivers/video/hdmi.c
> +++ b/drivers/video/hdmi.c

[ ... ]

> +const char *hdmi_eotf_get_name(enum hdmi_eotf eotf)
> +{
> +	switch (eotf) {
> +	case HDMI_EOTF_TRADITIONAL_GAMMA_SDR:
> +		return "Traditional gamma SDR";
> +	case HDMI_EOTF_TRADITIONAL_GAMMA_HDR:
> +		return "Traditional gamma HDR";
> +	case HDMI_EOTF_SMPTE_ST2084:
> +		return "SMPTE ST2084";
> +	case HDMI_EOTF_BT_2100_HLG:
> +		return "BT.2100 HLG";
> +	}
> +	return "Invalid";
> +}
> +EXPORT_SYMBOL(hdmi_eotf_get_name);
> +
>  static void hdmi_drm_infoframe_log(const char *level,
>  				   struct device *dev,
>  				   const struct hdmi_drm_infoframe *frame)

[Severity: Low]
This isn't a bug, but could hdmi_drm_infoframe_log() be updated to use this
new helper?

Currently, the function logs the eotf field as a raw integer:

drivers/video/hdmi.c:hdmi_drm_infoframe_log() {
    ...
    hdmi_log("eotf: %d\n", frame->eotf);
    ...
}

Updating this to use hdmi_eotf_get_name() would match the surrounding log
format conventions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006054004.2857=
44-1-pranay.samala@intel.com?part=3D1
