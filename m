Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3973FCD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9557510E742;
	Tue, 26 May 2026 16:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gJDV3EpM";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EC9F10E742
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779814747; x=1811350747;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=nCZGmGGS4FAj+BjeJda34+/x9mMDHI9CCqnR5FEk5GY=;
 b=gJDV3EpM4CINajW3qihMD8NErzc7BT6OfEVoLQ47U0VbvFVeCSfd+eMA
 8op926XKCjUz1QuNbLskG2S/pJdUQqZ44yKPgef9yd6ZeqPl6g2XDOm9g
 eukX2BoLYzwGgxblbVsqMzBFbYNxJIyfbHdmp4WJ0BRY6E310wJOYqAFW
 QLMRBDl1QOBCJfRvWUdYC5pL6/Y0grWvlgpdQIv6JPJj4/SSMm0Nqb3jv
 xjeqyuHe/Jq1VLzAVbGdk8iHzVCBwty2xdoLNa12t4W9Kr9UWoaxAPWIY
 9LLWs/b4QDdsirp1agOhY5pJ1z6mFf36t88AwJRXVYvOPsg7P9uZTWBZh Q==;
X-CSE-ConnectionGUID: Y5XTAphlQD6BE6ud/9UsgA==
X-CSE-MsgGUID: fk2KFsr0TD+/ktffIwpHZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="80821674"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="80821674"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:59:06 -0700
X-CSE-ConnectionGUID: 5xTHHabOQM6hb2+1Fdlx3g==
X-CSE-MsgGUID: A5DLhZnxS2a6gJr2L3queA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="242137645"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost)
 ([10.245.244.104])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:59:02 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/probe-helper: honour connector->force in
 drm_helper_probe_detect()
In-Reply-To: <20260526152025.12530-2-pmenzel@molgen.mpg.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260526152025.12530-2-pmenzel@molgen.mpg.de>
Date: Tue, 26 May 2026 19:58:59 +0300
Message-ID: <f167bfecbf7054005ec67eebd96044846812ae8c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 26 May 2026, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> With `video=3DDP-2:d drm.debug=3D0x04` the connectors are correctly forced
> off at init time:
>
>     [9.742468] [drm] forcing DP-2 connector off
>
> but `intel_dp_detect()` is still called immediately after:
>
>     [9.908738] [drm:intel_dp_detect] [CONNECTOR:130:DP-2]
>     [9.912982] [drm:intel_hotplug_detect_connector] [CONNECTOR:130:DP-2] =
status updated from unknown to unknown (epoch counter 0->1)
>
> `drm_helper_probe_single_connector_modes()` already short-circuits when
> `connector->force` is set, returning the forced status without calling
> any detect callbacks.  `drm_helper_probe_detect()` however has no such
> guard, so callers that go through it directly =E2=80=93 such as i915's
> `intel_hotplug_detect_connector()` =E2=80=93 still run the full hardware =
probe
> (AUX DPCD read, GMBus DDC transaction, =E2=80=A6) even when the user has
> forced a connector off via the `video=3D` command-line parameter.

Note that drm_helper_probe_single_connector_modes() still calls the
->force hook, which is crucial.

Returning early for force off may be fine, but force on will still need
to try to read the EDID. And the EDID reads return early for force off.

Side note, please drop the excessive backticks and the ellipsis from
commit messages.

BR,
Jani.

>
> Add the same connector->force check at the top of
> `drm_helper_probe_detect()`, so that the hardware probe is skipped
> regardless of the entry point.  This makes `video=3D<connector>:d`
> effective at boot time, not just for userspace `GETCONNECTOR` ioctls.
>
> This is tested on a Dell XPS 13 9360 (Intel Kaby Lake-U GT2 [HD Graphics
> 620] [8086:5916]). With `video=3DDP-2:d drm.debug=3D0x04`, Linux logs:
>
>     [   11.701243] [drm] forcing DP-2 connector off
>     [   11.701245] [drm:drm_connector_init_only [drm]] cmdline mode for c=
onnector DP-2  0x0@60Hz
>     [=E2=80=A6]
>     [   12.102009] i915 0000:00:02.0: [drm:drm_helper_probe_detect [drm_k=
ms_helper]] [CONNECTOR:130:DP-2] force=3D1, skipping detect
>
> Assisted-by: Claude Sonnet 4.6
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/gpu/drm/drm_probe_helper.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_pro=
be_helper.c
> index d4dc8cb45bce..bc513f24bc28 100644
> --- a/drivers/gpu/drm/drm_probe_helper.c
> +++ b/drivers/gpu/drm/drm_probe_helper.c
> @@ -401,6 +401,17 @@ drm_helper_probe_detect(struct drm_connector *connec=
tor,
>  	struct drm_device *dev =3D connector->dev;
>  	int ret;
>=20=20
> +	if (connector->force) {
> +		drm_dbg_kms(dev, "[CONNECTOR:%d:%s] force=3D%d, skipping detect\n",
> +			     connector->base.id, connector->name,
> +			     connector->force);
> +		if (connector->force =3D=3D DRM_FORCE_ON ||
> +		    connector->force =3D=3D DRM_FORCE_ON_DIGITAL)
> +			return connector_status_connected;
> +		else
> +			return connector_status_disconnected;
> +	}
> +
>  	if (!ctx)
>  		return drm_helper_probe_detect_ctx(connector, force);

--=20
Jani Nikula, Intel
