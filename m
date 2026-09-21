Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2549C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073B510E3CF;
	Mon, 21 Sep 2026 16:04:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lA85cOg/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF0310E3CF
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:04:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AF2B960120;
 Mon, 21 Sep 2026 16:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 499731F000FF;
 Mon, 21 Sep 2026 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790006676;
 bh=0L8ydUfdFDmiT2IBGtBZiDDx27TXCJI05QM8vX6/l0A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lA85cOg/EIBrBBMLirtoeOrCFgTcivlFVPMyUjtEEr7Zi8ewEAo7IqOZ/G3SUAAyz
 ShGMxelZ+iWgXdhdXfmn4Q1r5DWwrn9osIpqUVjYahJok6yZfRzvhjLzrqi8/AXnjR
 OOkMoy3eq5dlsPcKrXx7LtYY/C48AFJa7H6Dgb0Lrpa8wgBCyhNg6TTE9JankEOxQ8
 K/ZgGOGTYpHwnTIP1+TM0ZKEIcS5sJx+hHDNQIXOafhbGS4anHV28K0YjE7uPIeoAG
 fg4E3PdqzDkxWUz7VUUYYX+DBfEtLEUJNsjbfSD3d9b4L1mHlwIewrkqfLEjCL++2D
 pSlTf2LGFyhrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 09/25] drm/connector: Add
 drm_display_info_is_vrr_capable
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-9-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-9-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:04:35 +0000
Message-Id: <20260921160436.499731F000FF@smtp.kernel.org>
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
- [High] drm: drm_display_info_is_vrr_capable falsely reports VRR capabilit=
y for fixed-refresh monitors
- [Medium] drm: drm_display_info_is_vrr_capable fails to detect AMD FreeSyn=
c over HDMI
--

commit 2bcca4d009b9b65ca1552a608f777146fe2b4086
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/connector: Add drm_display_info_is_vrr_capable

This commit adds a function to return whether a sink, as described by a
drm_display_info struct, is capable of receiving VRR signals. It checks
the HDMI specific vrr_capable field or evaluates whether the monitor
range's minimum frequency is above 0.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index d94c86bfed866..fc7d9fcf9d9f6 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> @@ -1378,6 +1378,25 @@ int drm_display_info_set_bus_formats(struct drm_di=
splay_info *info,
> +/**
> + * drm_display_info_is_vrr_capable - Check whether sink is VRR capable
> + * @info: pointer to a &struct drm_display_info representing the sink
> + *
> + * Check whether the sink supports variable refresh rate signals.
> + *
> + * Returns:
> + * - true if variable refresh rate is supported by the sink
> + * - false otherwise
> + */
> +bool drm_display_info_is_vrr_capable(const struct drm_display_info *info)
> +{
> +	if (info->is_hdmi)
> +		return info->hdmi.vrr_capable;

[Severity: Medium]
Does this miss AMD FreeSync capabilities for older HDMI monitors?

For HDMI displays, drm_display_info_is_vrr_capable unconditionally returns
info->hdmi.vrr_capable. This field is exclusively set to true when parsing
an HDMI Forum Sink Capability Data Structure (HF-VSDB). Older monitors use
an AMD Vendor Specific Data Block instead, which the DRM core parses into
info->amd_vsdb.freesync_supported.

By ignoring info->amd_vsdb.freesync_supported, will this produce false
negatives and fail to enable VRR for older FreeSync HDMI monitors?

> +
> +	return info->monitor_range.min_vfreq > 0;
> +}

[Severity: High]
Will this falsely report VRR capability for fixed-refresh monitors?

The min_vfreq field is unconditionally populated by drm_get_monitor_range()
from the standard EDID Monitor Range Limits descriptor (Tag 0xFD) for any
monitor with the DRM_EDID_FEATURE_CONTINUOUS_FREQ flag set. Most modern
standard monitors use this descriptor to declare safe sync bounds, not VRR
capability.

As a result, will standard fixed-refresh monitors be incorrectly reported
as VRR-capable to userspace, potentially causing sync loss, screen
blanking, or visual glitches if VRR is enabled?

Additionally, a prior commit in this same series modifies
drm_parse_hdmi_forum_scds() in drm_edid.c to set hdmi->vrr_capable using
this identical min_vfreq > 0 check. Does that earlier logic also break
HDMI VRR detection in the same way, since min_vfreq is already populated
by drm_get_monitor_range()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D9
