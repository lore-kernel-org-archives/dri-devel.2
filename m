Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E62C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 04:17:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7ABB010F84F;
	Fri, 25 Sep 2026 04:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fQOJaIUI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D487B10F836;
 Fri, 25 Sep 2026 04:17:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F16966022E;
 Fri, 25 Sep 2026 04:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A191F000FF;
 Fri, 25 Sep 2026 04:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790309855;
 bh=Nq1E/W0hOk05nlI9/1a52oKb/tW+irCR05uyh92AyxA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fQOJaIUIr1wbjOjvIpBBaCvTiQAzFx7+QKZ93KZ/lTfsg9AatwueVfJNBsJBmuksW
 KpYM53/bCXfbCwvfWhQMorY9eZScWA1fitbzyxLobIWg2gPS41KIARVIMSqf/bPpto
 XeSmGV5fetvGl4PK0WZ9u6ibwT9uul6aJY5XVrRFociguFqFYNtVWUiCQ/uJUUTGvA
 PaFCAvEPjk8q/qg7GAsKC7OGRVFRv+ZREihYsMjgDiC/WSaYUzkHkYWk/KgDeG01c9
 y0BRbTxbFWkiS2J2m6oMi9gBxV0UnC6y8vPA5sXu9rVV7DMbdxIURORgE6wMYxmiOz
 mDQLFCj3knMHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/hdcp: Fail fast when HDCP Type 1 is
 unsupported via MST
To: "George D. Sworo" <george.d.sworo@intel.com>
Cc: intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260925035639.2034315-1-george.d.sworo@intel.com>
References: <20260925035639.2034315-1-george.d.sworo@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 04:17:34 +0000
Message-Id: <20260925041735.66A191F000FF@smtp.kernel.org>
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
- [Medium] drm/i915: stale cached HDCP capability causes spurious atomic ch=
eck failures
--

commit 74bd0c52833336220c44be4fec288971d8f48f92
Author: George D. Sworo <george.d.sworo@intel.com>

drm/i915/hdcp: Fail fast when HDCP Type 1 is unsupported via MST

This commit queries the downstream sink through its MST remote AUX channel
during HDCP initialization to cache whether HDCP Type 1 is unsupported. It
then uses this cached value in intel_hdcp_atomic_check() to reject invalid
HDCP Type 1 requests early.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/=
i915/display/intel_hdcp.c
> index e56df337dc6d8..7490fc0fd96ab 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdcp.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
[ ... ]
> @@ -2421,6 +2441,10 @@ int intel_hdcp_init(struct intel_connector *connec=
tor,
>  	if (is_hdcp2_supported(display))
>  		intel_hdcp2_init(connector, dig_port, shim);
> =20
> +	/* Cache the remote capability before atomic checks can run. */
> +	connector->mst.type1_unsupported =3D
> +		intel_hdcp_mst_type1_is_unsupported(connector, shim);

[Severity: Medium]
Does caching this capability during intel_hdcp_init() fail to account for
subsequent monitor hotplugs? If an MST dock is connected with an HDCP 1.x
monitor (or no monitor) initially, connector->mst.type1_unsupported evaluat=
es
to true. If an HDCP 2.x monitor is later hotplugged into the same port, the
stale cached value will remain.

>  	ret =3D drm_connector_attach_content_protection_property(&connector->ba=
se,
>  							       hdcp->hdcp2_supported);
[ ... ]
> @@ -2700,7 +2725,20 @@ void intel_hdcp_atomic_check(struct drm_connector =
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
> +		drm_dbg_kms(connector->dev,
> +			    "HDCP Type1 requested without HDCP 2.x support\n");
> +		return -EOPNOTSUPP;
>  	}

[Severity: Medium]
Could this lead to spurious rejections of valid HDCP Type 1 requests for
hotplugged monitors? When userspace requests HDCP Type 1 for a newly connec=
ted
HDCP 2.x monitor, the atomic check reads the stale cached flag and spurious=
ly
fails the request with -EOPNOTSUPP, preventing the display of premium conte=
nt.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925035639.2034=
315-1-george.d.sworo@intel.com?part=3D1
