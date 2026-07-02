Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC81CC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D9910F272;
	Thu,  2 Jul 2026 09:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QoeeyLmC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F8910F272
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 09:48:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A59960120;
 Thu,  2 Jul 2026 09:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F295D1F000E9;
 Thu,  2 Jul 2026 09:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782985713;
 bh=xMqEDlo1rK6ONO5MhPeeVPZoyzbriY+sDXyj7maPDb8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QoeeyLmC5tju6MoiUhZZsrgjTezX7+LtxM74pEzOEAG5GyseWXNyJcCrO+iaWVMWf
 g1+3RyVLADJQQPjks28950zhqvuGc3+o7fi8C9gg8ynbHbc+mwAjqTCVQSxW2icpKh
 0uEpt8NLEGEUOHWkhg6eQLmeKo2KKlnrrMnuOqo4ZrBgtgHcPrAjQESnBIe3H8+Osd
 y5zUcHqwQmsjncf/gfg4tsMeV0PGVw1SocY2vrGLM4SO4G8xIE+YjPd8+L7hgqCo3X
 kRJ8wMFw1pdcSw6IYI5Lz9vRfusq9X0Ds6BVIYq2q0EOd2Y76Lo/l8n2E7YcHcZ1i2
 5VoLnn5w7KFDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] drm/xe/xe_drm_ras: Add error-event support for PVC
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701094409.129131-7-riana.tauro@intel.com>
References: <20260701094409.129131-5-riana.tauro@intel.com>
 <20260701094409.129131-7-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 09:48:32 +0000
Message-Id: <20260702094832.F295D1F000E9@smtp.kernel.org>
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
- [Medium] Unconditional emission of spurious zero-delta RAS netlink events=
 for unsupported or uncounted errors.
--

commit 64cb8a4b396dc586545ef894e855aeb177686e56
Author: Riana Tauro <riana.tauro@intel.com>

drm/xe/xe_drm_ras: Add error-event support for PVC

This patch reports drm_ras error events to userspace when an error occurs.
It also adds support for core-compute and SoC errors in PVC.

> diff --git a/drivers/gpu/drm/xe/xe_hw_error.c b/drivers/gpu/drm/xe/xe_hw_=
error.c
> index 4a4b363fc844b..a833cecc74ec5 100644
> --- a/drivers/gpu/drm/xe/xe_hw_error.c
> +++ b/drivers/gpu/drm/xe/xe_hw_error.c
[ ... ]
> @@ -495,6 +495,9 @@ static void hw_error_source_handler(struct xe_tile *t=
ile, const enum hardware_er
>  			gt_hw_error_handler(tile, hw_err, error_id);
>  		if (err_bit =3D=3D XE_SOC_ERROR)
>  			soc_hw_error_handler(tile, hw_err, error_id);
> +
> +		value =3D atomic_read(&info[error_id].counter);
> +		xe_drm_ras_event(xe, error_id, severity, value, GFP_ATOMIC);

[Severity: Medium]
Does this unconditionally emit spurious zero-delta RAS netlink events for
unsupported or uncounted errors?

When gt_hw_error_handler() or soc_hw_error_handler() are called, they might
not increment the error counter. For example, gt_hw_error_handler() returns
early for non-PVC platforms:

drivers/gpu/drm/xe/xe_hw_error.c:gt_hw_error_handler() {
	...
	if (xe->info.platform !=3D XE_PVC)
		return;
	...
}

Similarly, soc_hw_error_handler() skips counter increments for correctable
errors:

drivers/gpu/drm/xe/xe_hw_error.c:soc_hw_error_handler() {
	...
	if (hw_err =3D=3D HARDWARE_ERROR_CORRECTABLE) {
		xe_mmio_write32(mmio, SOC_GLOBAL_ERR_STAT_REG(master, hw_err), REG_GENMAS=
K(31, 0));
		...
		goto unmask_gsysevtctl;
	}
	...
}

In these cases, xe_drm_ras_event() is still called with the unchanged count=
er
value. Could this cause userspace to receive confusing zero-delta event
updates?

>  	}
> =20
>  clear_reg:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701094409.1291=
31-5-riana.tauro@intel.com?part=3D2
