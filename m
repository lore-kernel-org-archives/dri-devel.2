Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1725CA9ED6
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10A3410EC78;
	Mon, 12 Oct 2026 04:44:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78C6310EC6A;
 Mon, 12 Oct 2026 04:44:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9A65660A9D;
 Mon, 12 Oct 2026 04:44:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7671F0089B;
 Mon, 12 Oct 2026 04:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780269;
 bh=fauviOaBU3CSyOQy8auY7OCM9wQNYgbRj4t+m8wWy38=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GJy/6zahphSa8sImX4BS/eaxfWENNzieODxF1GtTnNkKNxkCzKRDANMz6eV/nOoLn
 p+pq+GxF+55pA6kSNpCnBXjy685QCzDfYI4BTHzs1ieJUPcYCrtmbp7JUvC2pk3eOz
 HF1LzpjWOAcuVUfh7vYHDUu4Mn8QDF86cltZ11pAug6CpeMEcIEKH5viE6uckS7zGp
 3vL2BvLpAWEeQaq78zLhpQkjZRVKUp+wSrcWTZMDiHQlafJKKNrTKU6Ku+XFBYVMYu
 8AKk7HzdJqUtmuVAU0kFy+OZvt37753vaqgVx+DRpyoq7PTarioJN/k+YNge5Q8KVd
 PBsXTi9eyKnAQ==
Message-ID: <sashiko-outbox-167623@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/56] drm/i915/intel_hdmi: Add helper to disable FRL
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-16-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-16-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:44:28 +0000
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
- [High] drm/i915: NULL pointer deref in intel_hdmi_frl_ltsl() on systems w=
ith broken VBT
- [Low] drm/i915: unused crtc_state parameter in intel_hdmi_frl_ltsl()
--

commit bf532cf416aeac573dbb2724089b2e009ada86f1
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/intel_hdmi: Add helper to disable FRL

This commit adds a function to reset the SCDC FRL configuration and
Transcoder FRL configuration registers.

> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> @@ -3824,3 +3824,31 @@ int intel_hdmi_start_frl(struct intel_encoder *enc=
oder,
> =20
>  	return -EINVAL;
>  }
> +
> +static void intel_hdmi_frl_ltsl(struct intel_encoder *encoder,
> +				const struct intel_crtc_state *crtc_state)

[Severity: Low]
Is the crtc_state parameter needed here? Looking at the function body, it
appears to be passed in but never referenced. Removing it might help clean
up the function signature.

> +{
> +	struct intel_display *display =3D to_intel_display(encoder);
> +	struct i2c_adapter *adapter =3D
> +		intel_gmbus_get_adapter(display, intel_hdmi_ddc_pin(encoder));
> +
> +	drm_scdc_disable_frl(adapter);

[Severity: High]
Could this lead to a NULL pointer dereference on systems with a misconfigur=
ed
VBT?

If a system has a missing or conflicting DDC pin, intel_hdmi_ddc_pin() can
return 0. Consequently, intel_hdmi_init_connector() fails and no HDMI
connector is registered.

However, if the BIOS left the port enabled in HDMI FRL mode, the driver's
hardware state readout (intel_hdmi_frl_get_config()) will still set
crtc_state->frl.enable =3D true because it unconditionally trusts the hardw=
are
register state.

When intel_sanitize_encoder() later cleans up this connector-less encoder,
it calls the newly added intel_hdmi_disable_frl(). Since frl.enable is true,
this invokes intel_hdmi_frl_ltsl(), which fetches the adapter for pin 0
(GMBUS_PIN_DISABLED), receiving a NULL pointer.

Passing this NULL adapter to drm_scdc_disable_frl() will then cause a crash
when it is subsequently dereferenced in i2c_transfer(). Should there be a
NULL check for the adapter before calling drm_scdc_disable_frl()?

> +	drm_scdc_clear_update_flags(adapter, SCDC_FLT_UPDATE);
> +}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D15
