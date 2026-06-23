Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0DECDB470
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:07:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC3FA10ECC4;
	Tue, 23 Jun 2026 21:07:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ifc1zNI6";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0838510ECC4
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 21:07:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BF7DD40955;
 Tue, 23 Jun 2026 21:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D241F000E9;
 Tue, 23 Jun 2026 21:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248823;
 bh=fH2CbEQP3QAEb17AnHz1rKE2qpKItVZHSxgpYHNwHAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ifc1zNI63G4fjdVoTHMpStncnXYeXU41W6rd7OsTq96bhv+UfhYvKfBgf0rOhROdd
 sTh6ghqv02etcxWED26qkFy6zU6cC+em5+/DhdoTXECRdY9cZ1LzmFPGi2xDuF3Gaj
 lJ2TPk30jjQI+1PxjJxQIRRehCqAmNXb6BQGVOtZHhy1kzKfOX2Cq5KcJ3zGsmCBbS
 C7cGTtC760YarSJLs+m96shVhm13oiapIu+d4CBFFf3dRIOM8tzDrUTwHBTdpw4non
 aTmg/USJ5Kcjn1CKWzNNplwCFn+FzosHJay+zdSZhb8hN+dUtbayB1h461kHPCsuz1
 awgO9YxGZT3eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] drm/xe/xe_ras: Add error-event support for CRI
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622101716.3313496-8-riana.tauro@intel.com>
References: <20260622101716.3313496-5-riana.tauro@intel.com>
 <20260622101716.3313496-8-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:07:03 +0000
Message-Id: <20260623210703.72D241F000E9@smtp.kernel.org>
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
- [Medium] ras_send_error_event() passes internal hardware-specific XE enum=
s to xe_ras_get_counter() instead of the expected DRM enums, resulting in q=
ueries for the wrong error counters.
--

commit dc2a656220167a5ce967cead702288ba6f6f06e4
Author: Riana Tauro <riana.tauro@intel.com>

drm/xe/xe_ras: Add error-event support for CRI

This commit adds error-event support for correctable errors in CRI,
reporting errors that cross a threshold to userspace via interrupts.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c

[ ... ]

> @@ -131,6 +161,27 @@ static inline const char *comp_to_str(u8 component)
>  	return xe_ras_components[component];
>  }
> =20
> +static void ras_send_error_event(struct xe_device *xe, u8 severity, u8 c=
omponent)
> +{
> +	u8 drm_severity, drm_component;
> +	u32 value;
> +	int ret;
> +
> +	drm_severity =3D xe_to_drm_ras_severity(severity);
> +	if (drm_severity =3D=3D DRM_XE_RAS_ERR_SEV_MAX)
> +		return;
> +
> +	drm_component =3D xe_to_drm_ras_component(component);
> +	if (drm_component =3D=3D DRM_XE_RAS_ERR_COMP_MAX)
> +		return;
> +
> +	ret =3D xe_ras_get_counter(xe, severity, component, &value);

[Severity: Medium]
Does this pass the wrong enum type to xe_ras_get_counter?

In this function, severity and component are the raw XE hardware enums. We
convert them to DRM enums just above as drm_severity and drm_component.

Looking at xe_ras_get_counter(), it expects the DRM enums because it conver=
ts
them back to XE enums internally:

int xe_ras_get_counter(struct xe_device *xe, u8 severity, u8 component, u32=
 *value)
{
        struct xe_ras_error_class counter =3D {0};

        counter.common.severity =3D drm_to_xe_ras_severity(severity);
        counter.common.component =3D drm_to_xe_ras_component(component);
        ...
}

Should this be passing drm_severity and drm_component instead to ensure the
correct telemetry counters are read?

> +	if (ret)
> +		return;
> +
> +	xe_drm_ras_event(xe, drm_component, drm_severity, value, GFP_KERNEL);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622101716.3313=
496-5-riana.tauro@intel.com?part=3D3
