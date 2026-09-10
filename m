Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624ECC79FBF
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:29:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9324410E1FA;
	Thu, 10 Sep 2026 18:29:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lkzPYpeW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBD5D10E1FA
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 18:29:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 82123438D8;
 Thu, 10 Sep 2026 18:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5041F000FF;
 Thu, 10 Sep 2026 18:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789064963;
 bh=LONQFxj6jk5TJQO9dPX4P6Yula22CEdI7EJEOHORUxQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lkzPYpeWMdlRqwr+klokdID2CUjnF/uvKnVhgJRrr+s2kVAzNlLiiNNg6zxwf8UFG
 B0NBlrN7OkHOxUdVlZWB+e4V+vTaVVQzPZT39vLU+vbFaTfqINCo4bx8pojFAOSDzj
 CYQDvE/SKVn+PGX+Cl5lLYKahsd8y0huuHNxWA4AuYr1tRjWClyK3xLCrxQHjGu5oP
 LGeIs7bOTdhJK3zu3JLcGFjyqEKTpeAPSsEwShsNZGDck/+X8R0KnGdwFBBO8ngrlT
 Yv8vRU8AWVUDHFmCibQsgD6wFhrgvACGWRFfj3je3QS8lD8BmYXha0FPRH/vN1EqZ7
 AEpaq2vRaq8ow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amd/display: Default HDMI RGB output to limited
 range on CTA modes
To: "Adrian Betschart" <adrian.betschart@cinemaone.ch>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260910181517.68781-1-adrian.betschart@cinemaone.ch>
References: <20260910181517.68781-1-adrian.betschart@cinemaone.ch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 18:29:22 +0000
Message-Id: <20260910182923.3C5041F000FF@smtp.kernel.org>
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
- [Medium] NULL pointer dereference in KUnit tests due to uninitialized `co=
nnector_state->connector` pointer.
--

commit 76d9dc4fc5efbfc79cdb3d3327ee0c10ae387dea
Author: Adrian Betschart <adrian.betschart@cinemaone.ch>

drm/amd/display: Default HDMI RGB output to limited range on CTA modes

This commit changes the default HDMI RGB output to limited range on CTA
modes by introducing the rgb_output_is_limited_range function. The function
evaluates the broadcast_rgb property and falls back to inspecting the
connector's display_info for HDMI capabilities when set to automatic.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5796

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c

[ ... ]

> @@ -734,6 +734,24 @@ get_aspect_ratio(const struct drm_display_mode *mode=
_in)
> +static bool rgb_output_is_limited_range(const struct dc_crtc_timing *dc_=
crtc_timing,
> +					const struct drm_connector_state *connector_state)
> +{
> +	switch (connector_state->hdmi.broadcast_rgb) {
> +	case DRM_HDMI_BROADCAST_RGB_FULL:
> +		return false;
> +	case DRM_HDMI_BROADCAST_RGB_LIMITED:
> +		return true;
> +	default:
> +		return connector_state->connector->display_info.is_hdmi &&

[Severity: Medium]
Will this cause a NULL pointer dereference during KUnit test execution?

The rgb_output_is_limited_range function dereferences
connector_state->connector to check display_info.is_hdmi in the default
broadcast RGB case.

Many KUnit tests for amdgpu_dm_get_output_color_space, such as
dm_test_output_color_space_default_rgb_full, allocate a dummy
drm_connector_state without explicitly initializing the connector pointer,
leaving it NULL.

When these tests run, they will hit this path and crash when evaluating
connector_state->connector->display_info.is_hdmi. Could we add a check for
connector_state->connector, or update the KUnit tests to initialize it?

> +		       dc_crtc_timing->vic > 1;
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910181517.6878=
1-1-adrian.betschart@cinemaone.ch?part=3D1
