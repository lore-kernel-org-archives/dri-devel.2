Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E142AC98306
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 05:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C11F10F83E;
	Fri, 25 Sep 2026 05:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gd5EJMW4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E033C10E9E5;
 Fri, 25 Sep 2026 05:34:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C0CDB60514;
 Fri, 25 Sep 2026 05:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E991F000FF;
 Fri, 25 Sep 2026 05:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790314466;
 bh=HTWk6IZy6orlfSRnx8oFTjANOFafgh0ZAqnhUrDC3w0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gd5EJMW4fcIPeQReUdhOqtaw4UHacfJIoW1GWiPHvfrchswjBf9f61ykRTCOpPobW
 FOyPPcZ7WeQTioF3GAa823xkTOty9lCiJz9ARGRXr6rmqxgTfG2YbyiayOiG1/fzTC
 4J0oQf/A3H+iIzJqeI2ypXsM696ydBkWLGu7+Rucxo7qkiDMweNC06WDLd0S3sPc2+
 xuzbjD1BCyLNaGzjq6gVgwNcCjwYLNjVg+Uh5/AwKb6/aSLUru/In+OeK/YyFKPjhy
 0QZwf+kZ6CPVSvPzgLxjNPWjS4TeiLd2EY6lvK7ulUrppKGLwg4VgsA8mlLQomptzi
 8ZFpQbenIfCDQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/i915/hdcp: Fail fast when HDCP Type 1 is
 unsupported via MST
To: "George D. Sworo" <george.d.sworo@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260925052703.2068117-1-george.d.sworo@intel.com>
References: <20260925035639.2034315-1-george.d.sworo@intel.com>
 <20260925052703.2068117-1-george.d.sworo@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 05:34:25 +0000
Message-Id: <20260925053426.43E991F000FF@smtp.kernel.org>
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
- [High] drm/i915/hdcp: stale type1_unsupported cache on MST hotplug
- [Medium] drm/i915/hdcp: bypass of Type 1 fast-fail validation
--

commit fb3d7b407b5fff7eb8ca9312ac9476d293a32b63
Author: George D. Sworo <george.d.sworo@intel.com>

drm/i915/hdcp: Fail fast when HDCP Type 1 is unsupported via MST

This commit attempts to fail early in the atomic check phase when userspace
requests HDCP Content Type 1 for a downstream MST sink that lacks HDCP 2.x
support. It queries and caches the sink's capability during initialization
and uses the cached result to reject unsupported configurations.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/=
i915/display/intel_hdcp.c
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c

[ ... ]

> @@ -2421,6 +2454,9 @@ int intel_hdcp_init(struct intel_connector *connect=
or,
>  	if (is_hdcp2_supported(display))
>  		intel_hdcp2_init(connector, dig_port, shim);
> =20
> +	/* Cache the capability for the currently attached MST sink only. */
> +	intel_hdcp_mst_update_type1_capability(connector, shim);
> +

[Severity: High]
Could this cached capability become permanently stale after a hotplug event?

Since DRM MST connectors represent topological branch ports rather than the
sinks themselves, they persist across sink hotplug events. If a user connec=
ts
an HDCP 1.x monitor, type1_unsupported will be cached as true here in
intel_hdcp_init(). If the user then unplugs that monitor and connects an
HDCP 2.x capable monitor to the same port, the cached value is never update=
d.

Will this cause valid HDCP Type 1 requests to be permanently and incorrectly
rejected for the new monitor?

[ ... ]

> @@ -2700,7 +2739,20 @@ void intel_hdcp_atomic_check(struct drm_connector =
*connector,
>  		if (old_cp =3D=3D DRM_MODE_CONTENT_PROTECTION_ENABLED)
>  			new_state->content_protection =3D
>  				DRM_MODE_CONTENT_PROTECTION_DESIRED;
> -		return;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Fail fast if userspace asks for Type1 but neither the platform nor
> +	 * the downstream sink can do HDCP 2.x, instead of only discovering
> +	 * this once intel_hdcp_enable() is reached.
> +	 */
> +	if (new_cp =3D=3D DRM_MODE_CONTENT_PROTECTION_DESIRED &&
> +	    new_state->hdcp_content_type =3D=3D DRM_MODE_HDCP_CONTENT_TYPE1 &&
> +	    intel_connector->mst.type1_unsupported) {

[Severity: Medium]
Does this condition inadvertently allow invalid configurations to bypass the
fast-fail validation?

If userspace has already enabled HDCP Type 0, the content_protection
property will be in the ENABLED state. If a subsequent atomic commit
changes only the hdcp_content_type to TYPE1, new_cp will inherit the
ENABLED state.

Since this check strictly requires new_cp to be DESIRED, it appears it will
evaluate to false, allowing the invalid request to proceed and fail
asynchronously during hardware enablement later. Should this check also
account for the ENABLED state?

> +		drm_dbg_kms(connector->dev,
> +			    "HDCP Type1 requested without HDCP 2.x support\n");
> +		return -EOPNOTSUPP;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925052703.2068=
117-1-george.d.sworo@intel.com?part=3D1
