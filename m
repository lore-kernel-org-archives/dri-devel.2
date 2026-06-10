Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA89ECD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 18:03:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED0C10EB42;
	Wed, 10 Jun 2026 18:03:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EyRGaoS+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5DE310EB42
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 18:03:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A9DE2600AF;
 Wed, 10 Jun 2026 18:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374901F00893;
 Wed, 10 Jun 2026 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781114592;
 bh=Sa8w4KqXa0R0NS5GpbN45b/8F2OXA69WSZyigG6d0hc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EyRGaoS+GGdgTMc32fTPm1aL0OwBfhSidGhHSzIpsW/YqQLkmirZHCUHeSf5+3ewy
 Yaq7xURhGhdtWV3exuEHVG6miEx8es5kavEOfxOSZ9le15lOkst3FDLGi6MlJKAFXN
 vobZtUprzbrCH1eHhV98ww2NraEbXGpjObjhBeKkltj0gkr8gugQFkhaX9/QxoMCnW
 XnE/vksfP0I5+6RvCGbFE5SAo7eNXbktisjgIYxV6GiVKWcpPRJMIlBK03UxpFrAxT
 Fj6AciAUnE4OTyK07AGX5Phf2al5aGVqZB6uYPYcfrokrnjgUO0vStBz2O0jE5fcVv
 R7TbtnlgS+TFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs
To: "Alexander Kaplan" <alexander.kaplan@sms-medipool.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260610174819.6258-1-alexander.kaplan@sms-medipool.de>
References: <20260610174819.6258-1-alexander.kaplan@sms-medipool.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 18:03:11 +0000
Message-Id: <20260610180312.374901F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] `intel_dp_check_frl_training` improperly evaluates source control =
mode support, potentially initiating FRL training and writing PCON register=
s on non-PCON or non-HDMI branch devices.
--

commit 4303b79dbb0d5f0f36551e50e709e33e49cee039
Author: Alexander Kaplan <alexander.kaplan@sms-medipool.de>

drm/dp: Read the PCON max FRL bandwidth only for HDMI DFPs

This commit fixes an issue where the PCON max FRL bandwidth was read
without checking the DFP type, branch presence, or whether detailed
capability info was available. By properly scoping the parsing, it
prevents incorrect mode pruning on adapters that replicate the DFP type
byte across the descriptor.

> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/di=
splay/drm_dp_helper.c
> index 9c31e14cc413b..3328909c8db47 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -3686,6 +3686,15 @@ int drm_dp_get_pcon_max_frl_bw(const u8 dpcd[DP_RE=
CEIVER_CAP_SIZE],
>  	int bw;
>  	u8 buf;
> =20
> +	if (!drm_dp_is_branch(dpcd))
> +		return 0;
> +
> +	if ((dpcd[DP_DOWNSTREAMPORT_PRESENT] & DP_DETAILED_CAP_INFO_AVAILABLE) =
=3D=3D 0)
> +		return 0;
> +
> +	if ((port_cap[0] & DP_DS_PORT_TYPE_MASK) !=3D DP_DS_PORT_TYPE_HDMI)
> +		return 0;
> +

[Severity: High]
This is a pre-existing issue, but seeing the capability checks added
here raises a question about similar logic in the i915 driver.

In drivers/gpu/drm/i915/display/intel_dp.c, the intel_dp_check_frl_training=
()
function appears to blindly check downstream_ports[2] without verifying
if detailed capabilities are available:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_check_frl_training() {
    ...
    if (!(intel_dp->downstream_ports[2] & DP_PCON_SOURCE_CTL_MODE) ||
        !intel_dp_is_hdmi_2_1_sink(intel_dp) ||
        intel_dp->frl.is_trained)
        return;
    ...
}

If detailed capability info is not available, downstream_ports contains 1-b=
yte
descriptors per port. Doesn't this mean downstream_ports[2] would represent
the third downstream port rather than byte 2 of Port 0?

If Port 2 happens to have bit 5 set, could this cause the driver to
incorrectly assume it's a PCON supporting source control mode, triggering
FRL training logic on non-PCON or non-HDMI branch devices?=20

Even if the training gracefully aborts due to max_pcon_frl_bw being 0, it
looks like the error path unconditionally calls intel_dp_pcon_set_tmds_mode=
(),
which writes to DP_PCON_HDMI_LINK_CONFIG_1. Could writing to these registers
on generic MST hubs or docks cause hardware hangs or link training failures?

Should intel_dp_check_frl_training() be updated with similar checks to ensu=
re
we only evaluate DP_PCON_SOURCE_CTL_MODE when appropriate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610174819.6258=
-1-alexander.kaplan@sms-medipool.de?part=3D1
