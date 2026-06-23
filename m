Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FED8CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 20:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C85B110ECBA;
	Tue, 23 Jun 2026 20:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dr+nwURw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A10110ECB9
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 20:58:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 854FB60008;
 Tue, 23 Jun 2026 20:58:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B471F00A3A;
 Tue, 23 Jun 2026 20:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782248296;
 bh=FXWpQI05tIdDiSI7wu3xY4WmZ/LcP/6rALr4Ew5U8rk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Dr+nwURwjLfekZdn+7+CFvv+Dbrf3H/TBbz4cGAqeKYBcEXUb1wnBjRHDTd3NoaH0
 S4epaPEs9SV2bfxXRucj7QPC3MXpTYZB096vylyy6pt8ml64EyuMeI0p3JkBX1uqz1
 lyBuzYHr6u5OW2YNWuehA33nRHIU7Q5smtlfpjWJoAR8xhrlIsfOwVVfjR08bYzq1h
 kLul0gpkdBb6hyIGGuyxBtPGiXUxbjKVxXid9Jk0QSnTy7Z/wVkOumwJzX+BT1mkxb
 gya9t7zmUtzNVMc1F+1vsWA2w2b5ZzSBO99oerWz+TfkLHQcRb91ZcaqrNj75Z6hHG
 JDSCv/qR9GdrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/xe/xe_drm_ras: Add error-event support for PVC
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622101716.3313496-7-riana.tauro@intel.com>
References: <20260622101716.3313496-5-riana.tauro@intel.com>
 <20260622101716.3313496-7-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 20:58:15 +0000
Message-Id: <20260623205816.20B471F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Potential console flood due to unratelimited `drm_err` in atomic c=
ontext when netlink multicast fails.
- [Medium] Emitting RAS events with unchanged/zero counter values for uncou=
nted errors.
- [Medium] Pointer arithmetic is performed on a potentially NULL pointer be=
fore checking if the DRM RAS feature is enabled.
--

commit 948141f8cea37215cdae8a5d0e089b0c6b181396
Author: Riana Tauro <riana.tauro@intel.com>

drm/xe/xe_drm_ras: Add error-event support for PVC

Report drm_ras error event to userspace when an error occurs.
Add support for core-compute and SoC errors in PVC.

> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_=
ras.c
> index 7937d8ba0ed9c..36afdfb5e4120 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c

[ ... ]

> @@ -185,6 +185,36 @@ static int register_nodes(struct xe_device *xe)
>  	return ret;
>  }
> =20
> +/**
> + * xe_drm_ras_event() - Report drm-ras error event to userspace
> + * @xe: xe device structure
> + * @component: error component (see &enum drm_xe_ras_error_component)
> + * @severity: error severity (see &enum drm_xe_ras_error_severity)
> + * @value: value of error counter
> + * @flags: flags for allocation
> + *
> + * Report an error-event to userspace.
> + */
> +void xe_drm_ras_event(struct xe_device *xe, u32 component, u32 severity,=
 u32 value, gfp_t flags)
> +{
> +	struct xe_drm_ras *ras =3D &xe->ras;
> +	struct xe_drm_ras_counter *info =3D ras->info[severity];
> +	struct drm_ras_node *node =3D &ras->node[severity];

[Severity: Medium]
Is it safe to compute the node pointer here before checking if the DRM
RAS feature is enabled?

If xe->info.has_drm_ras is false, xe_drm_ras_init() might not have been
called, leaving ras->node as NULL. Evaluating &ras->node[severity] on a
NULL pointer results in undefined behavior which could be flagged by UBSAN
or compiler optimizations.

> +	int ret;
> +
> +	/* Event is supported only if drm_ras is enabled */
> +	if (!xe->info.has_drm_ras)
> +		return;
> +
> +	if (!info || !info[component].name)
> +		return;
> +
> +	ret =3D drm_ras_nl_error_event(node, component, info[component].name, v=
alue, flags);
> +	if (ret)
> +		drm_err(&xe->drm, "RAS error-event failed: %d for %s %s\n", ret,
> +			info[component].name, error_severity[severity]);

[Severity: High]
Could this unratelimited drm_err() cause a console flood?

Since xe_drm_ras_event() is called from hw_error_source_handler() in
hardware error interrupt context, an interrupt storm could occur.
If drm_ras_nl_error_event() fails (e.g., due to GFP_ATOMIC allocation
failures under memory pressure), this will rapidly print errors to
the console.

Should this use drm_err_ratelimited() similar to how the caller
handles its logging?

> +}
> +
>  /**
>   * xe_drm_ras_init() - Initialize DRM RAS
>   * @xe: xe device instance

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
Will this emit an event with an unchanged or zero counter value for
correctable SOC errors?

In soc_hw_error_handler(), if the error is HARDWARE_ERROR_CORRECTABLE,
it clears the registers and jumps to unmask_gsysevtctl without
incrementing the error counter:

soc_hw_error_handler() {
    ...
    if (hw_err =3D=3D HARDWARE_ERROR_CORRECTABLE) {
        ...
        goto unmask_gsysevtctl;
    }
    ...
}

However, here in hw_error_source_handler(), xe_drm_ras_event() is
called unconditionally after soc_hw_error_handler() returns.
Does this result in userspace receiving an error event where the
counter value hasn't actually changed?

>  	}
> =20
>  clear_reg:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622101716.3313=
496-5-riana.tauro@intel.com?part=3D2
