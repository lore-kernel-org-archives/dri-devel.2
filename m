Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A26FF885D
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 16:47:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EFFE10E139;
	Sun, 26 Apr 2026 16:47:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FUJ3FeOH";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05A7010E139
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 16:47:43 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-703d-e500--2a1.rev.dnainternet.fi [IPv6:2001:14ba:703d:e500::2a1])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C74E8981;
 Sun, 26 Apr 2026 18:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1777221960;
 bh=JHkWtqG1syN5M2zJzbXjCcAC0qMYBTMOxbe5qquROQc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FUJ3FeOH7r57hfceOnj3GGVeQHajWJ/gfgKatdhHnxd19qMBXm6/ezrndHFr2F5kx
 NASZ5i6IxKVFIZwxFTQzzgfvCO47LShxrZQ8Li8MuSVCm309/uKsl/ukY7FxrgTpA4
 IG6trek4zbTpiRPWZHaK8pMSGXxZOMVd4K2DDyJA=
Date: Sun, 26 Apr 2026 19:47:39 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, Pekka Paalanen <ppaalanen@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Daniel Stone <daniel@fooishbar.org>
Subject: Re: [PATCH] drm/fourcc: document format naming scheme
Message-ID: <20260426164739.GE2964234@killaraus.ideasonboard.com>
References: <20260426151641.93763-1-contact@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260426151641.93763-1-contact@emersion.fr>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Simon,

Thank you for the patch.

On Sun, Apr 26, 2026 at 03:16:58PM +0000, Simon Ser wrote:
> When adding a new format, one needs to pick a name and fourcc.
> This is not always an easy task: figuring out why current formats
> are named this way is tricky.
> 
> Document current practice to make that process easier.
> 
> See previous discussion at:
> https://lore.kernel.org/all/aocdbgbLe5WhUEOGeLg3P7fRDM8i72H9zBuUnoAjjsuvBLfMPofrPtaUEjII_43KXf1wCbv1G9UutJKMkWLaEcBSnrlUV78Wrhu6l_Z0xi8=@emersion.fr/
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Pekka Paalanen <ppaalanen@gmail.com>
> Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Cc: Daniel Stone <daniel@fooishbar.org>
> ---
>  include/uapi/drm/drm_fourcc.h | 39 +++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index ac66fa93b5a3..dc737c4fa5f2 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -38,6 +38,45 @@ extern "C" {
>   * fourcc code, a Format Modifier may optionally be provided, in order to
>   * further describe the buffer's format - for example tiling or compression.
>   *
> + * Formats
> + * -------
> + *
> + * Formats describe how a buffer is interpreted to decode pixel color and alpha
> + * values. Formats are uniquely identified by a four character code (fourcc).
> + * Memory layout is always described in little-endian order.

This sentence may be a bit vague, especially given that we have the
DRM_FORMAT_BIG_ENDIAN() macro.

> + *
> + * The following channels are defined:
> + *
> + * - "R", red
> + * - "G", green
> + * - "B", blue
> + * - "A", alpha
> + * - "C", color index (for paletted formats)
> + * - "D", darkness (inverse relationship between channel value and brightness)
> + * - "Y", luma/brightness
> + * - "U", blue-difference chroma (Cb)
> + * - "V", red-difference chroma (Cr)
> + * - "X", a placeholder for undefined/unused contents
> + *
> + * Formats using the RGB color model have names made up of a list of channels
> + * followed by the number of bits used by each channel, respectively. Any
> + * padding is explicitly indicated by the special "X" channel. Channels use
> + * unsigned integers, except when suffixed by "F" to indicate IEEE 754 floats.
> + * An underscore "_" can be used to delimit planes.
> + *
> + * Multi-planar YUV formats use the following naming scheme for the most part:
> + *
> + * - The first letter indicates the number of planes, channel alignment and
> + *   ordering. It is should not be a letter already used to denote a channel.

s/It is/It/

> + * - The first digit indicates chroma sub-sampling: 0 for 2x2, 2 for 2x1, 4 for
> + *   none.

We also have 4x4 and 4x1 sub-sampled formats, it would be good to
document them.

> + * - The two other digits indicate bits for the Y channel. If the Cb channel
> + *   comes before Cr, the digits are reversed.
> + *
> + * Fourccs are allocated on a first-come, first-served basis. New format names
> + * and fourccs should try to use the same naming scheme as existing, similar
> + * formats.
> + *
>   * Format Modifiers
>   * ----------------
>   *

-- 
Regards,

Laurent Pinchart
