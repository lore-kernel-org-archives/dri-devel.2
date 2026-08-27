Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DA8C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:19:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1734F10F088;
	Thu, 27 Aug 2026 14:19:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TFT4gYce";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A3B10F088
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:19:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95EBE600D3;
 Thu, 27 Aug 2026 14:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC011F000E9;
 Thu, 27 Aug 2026 14:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787840394;
 bh=ESru2GpfcWhRVaYcQLXjsdmf5HAS0fthnsuPNAlGccM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TFT4gYceDU/bshZpBDJyJXnTuHm4jDjB7/p6G61pEY2qfCniji6AhYlAelSo3XpSb
 fqqj2iqG8MPp90aVtKZFw7jdUx6PQ1Y0fi7SIWRYp01QGLt3XMVzy0PY1s7sgIu15v
 QDaeecGWpTQnb+qSZQ+VOfhnxK1SnvJ0WrdcLQw8WnmHByJ8+3T9DW5+a0ETUU5hOj
 TCmB0Lql+1gbsGTyQDBZBPhytxG4HqiWNcy/Wndx5fOQbYJGqZG8rCbsUso25KdJ8N
 3ycf5ZGticYeT2vFSn5W4S6VP53wxZgFlOLefJOAbBxRMI82HH7pDqMXTYfjcf06wh
 nvpSDEcsryjaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/edid: Add drm_edid_get_preferred_size()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260827140726.420734-2-tzimmermann@suse.de>
References: <20260827140726.420734-1-tzimmermann@suse.de>
 <20260827140726.420734-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 14:19:53 +0000
Message-Id: <20260827141954.2AC011F000E9@smtp.kernel.org>
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
- [High] Pointer Dereference and Logic Error in drm_edid_get_preferred_size
- [High] Missing EDID Hardware Validation for Detailed Timing Descriptor
--

commit 2d529ec582fce7d82757afd45c986da44f50ceb6
Author: Thomas Zimmermann <tzimmermann@suse.de>
Subject: drm/edid: Add drm_edid_get_preferred_size()

This commit adds drm_edid_get_preferred_size() to extract the panel's
preferred display resolution from a given EDID. This is required for
DRM's panel orientation quirks.

> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index df3c25bac761d..650ccd05977be 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c

[ ... ]

> @@ -2844,6 +2844,46 @@ u32 drm_edid_get_panel_id(const struct drm_edid *d=
rm_edid)
>  }
>  EXPORT_SYMBOL(drm_edid_get_panel_id);
> =20
> +/**
> + * drm_edid_get_preferred_size - Get a panel's preferred size from EDID
> + * @drm_edid: EDID that contains panel ID.
> + * @width: Returns the panel's width in pixels per scanline, if given
> + * @height: Returns the panel's height in scanlines, if given
> + *
> + * This function detects the preferred size of a panel from the given
> + * EDID. There is no such information stored in the EDID block directly,
> + * but the preferred mode often corresponds to the panel's native geomet=
ry.
> + *
> + * Return: Zero on success, or a negative errno code otherwise.
> + */
> +int drm_edid_get_preferred_size(const struct drm_edid *drm_edid,
> +				unsigned int *width, unsigned int *height)
> +{
> +	const struct edid *edid =3D drm_edid->edid;
> +	const struct detailed_pixel_timing *pt;
> +
> +	if (drm_edid->size < EDID_LENGTH)
> +		return -EINVAL;
> +
> +	/*
> +	 * Use whatever the Preferred Timing Descriptor tells us. For old
> +	 * and obscure displays, we might need better heuristics.
> +	 */
> +
> +	if (edid->revision < 4 && !(edid->features & DRM_EDID_FEATURE_PREFERRED=
_TIMING))
> +		return -EINVAL; /* no Preferred Timing Descriptor */
> +
> +	pt =3D &edid->detailed_timings[0].data.pixel_data;

[Severity: High]
Does this safely handle non-compliant or corrupted EDIDs where the first
detailed timing block might be a Display Descriptor rather than a pixel
timing descriptor?

In the EDID specification, a detailed timing block is only a Detailed Timing
Descriptor if its pixel clock is non-zero. If the pixel clock is 0, the blo=
ck
is a Display Descriptor like an ASCII monitor name. By unconditionally
accessing it as pixel data without validating it, could we end up reading
overlapping union fields and returning garbage display geometry data to the
driver?

> +
> +	if (*width)
> +		*width =3D (pt->hactive_hblank_hi & 0xf0) << 4 | pt->hactive_lo;
> +	if (*height)
> +		*height =3D (pt->vactive_vblank_hi & 0xf0) << 4 | pt->vactive_lo;

[Severity: High]
Does this logic incorrectly dereference the pointers before checking if they
are valid?

The kernel doc mentions that width and height are optional, which implies
callers might pass a NULL pointer. If a caller passes NULL for width or
height, evaluating if (*width) will cause a NULL pointer dereference crash.

Additionally, if a caller passes a valid pointer to a 0-initialized variabl=
e,
evaluating if (*width) will result in false, skipping the assignment entire=
ly
and leaving the output as 0. Should these conditions check if (width) and
if (height) instead?

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(drm_edid_get_preferred_size);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827140726.4207=
34-1-tzimmermann@suse.de?part=3D1
