Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137B9C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 09:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6694610F043;
	Thu, 23 Jul 2026 09:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NoI7eR55";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85F2810F052
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 09:42:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 927D160A67;
 Thu, 23 Jul 2026 09:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1473B1F000E9;
 Thu, 23 Jul 2026 09:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784799762;
 bh=aggcGZMyP/xFxs3l+jm/6UMherLlOPYA7srJtY1RSgg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NoI7eR559yBZGnGeJ3R/fy7TeQrpa1kwQ+pp82Yguirub+7uhkimMqwdfpDjn3O4u
 wQaqNp/1SwmfXUGMoUzl1lIqFiZIBBPyxHvk7pz9T77hZhgBWukU/jOkYJ/dNd/ds1
 iCvK8LxZqyQX6eJX2Z3veEneHRqulvD9F3g71Ey2f9kXC5Lw1FntER//PomyBW6XOX
 KJhqWqIQXI8PSGEhMhiL8Xc3QJW6tbLVD/WkAW5WoLL56ktZ8re5Sz5qpd8wzxmnNC
 Jz4eXhIpKVRrZEbCym1GaeN5xe6vV/+XVDZKVcWUdN3LqoO0coc4aST4xBHkHMx0hZ
 hLI73kq8Aq3Jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/xe/xe_ras: Report correctable/uncorrectable
 error events to userspace
To: "Riana Tauro" <riana.tauro@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722094134.3036087-6-riana.tauro@intel.com>
References: <20260722094134.3036087-4-riana.tauro@intel.com>
 <20260722094134.3036087-6-riana.tauro@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 09:42:39 +0000
Message-Id: <20260723094242.1473B1F000E9@smtp.kernel.org>
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
- [High] Unvalidated hardware error severity and component values are conve=
rted to `_MAX` sentinels and used as array indices, causing out-of-bounds m=
emory accesses.
- [High] The event deduplication logic tracks only the component ID, causin=
g distinct RAS events of different severities to be silently dropped.
- [Medium] Using an unvalidated 8-bit `component` value with `BIT()` causes=
 undefined behavior on out-of-bounds shifts and logical failures due to tru=
ncation.
--

--- Patch [2]: [PATCH v6 2/2] drm/xe/xe_ras: Report correctable/uncorrectab=
le error events to userspace ---
commit 27331cfb50f32fc2a792ea10818220c4af94ef3d
Author: Riana Tauro <riana.tauro@intel.com>

drm/xe/xe_ras: Report correctable/uncorrectable error events to userspace

When an interrupt is received for correctable errors indicating that error
counter has crossed its threshold, read the current counter value and
deliver a drm-ras error-event to userspace for each affected component.

> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_=
ras.c
> index 7937d8ba0ed9c..5cbfd12d61f4b 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
[ ... ]
> @@ -185,6 +185,37 @@ static int register_nodes(struct xe_device *xe)
>  	return ret;
>  }
> =20
> +/**
> + * xe_drm_ras_event() - Report drm-ras error event to userspace
> + * @xe: xe device structure
> + * @component: error component (see &enum drm_xe_ras_error_component)
> + * @severity: error severity (see &enum drm_xe_ras_error_severity)
> + * @value: value of error counter
> + *
> + * Report an error-event to userspace.
> + */
> +void xe_drm_ras_event(struct xe_device *xe, u8 component, u8 severity, u=
32 value)
> +{
> +	struct xe_drm_ras *ras =3D &xe->ras;
> +	struct xe_drm_ras_counter *info =3D ras->info[severity];
> +	struct drm_ras_node *node;
> +	int ret;
> +
> +	/* Event is supported only if drm-ras is enabled */
> +	if (!xe->info.has_drm_ras)
> +		return;
> +
> +	node =3D &ras->node[severity];
> +
> +	if (!info || !info[component].name)
> +		return;

[Severity: High]
Does this code introduce a regression where an unexpected firmware response=
 can
cause an out-of-bounds memory access here?

If the firmware returns an unsupported severity or component value,
xe_to_drm_ras_severity() and xe_to_drm_ras_component() map these to
DRM_XE_RAS_ERR_SEV_MAX and DRM_XE_RAS_ERR_COMP_MAX respectively.

Then xe_drm_ras_event() uses these sentinel values as array indices:

    struct xe_drm_ras_counter *info =3D ras->info[severity];
    ...
    node =3D &ras->node[severity];
    ...
    if (!info || !info[component].name)

This evaluates exactly one element past the end of the arrays. Should we
bounds-check or reject _MAX values before using them as indices?

[ ... ]
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index a31e06b8aa67a..d43f614de7237 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> @@ -312,8 +364,10 @@ void xe_ras_counter_threshold_crossed(struct xe_devi=
ce *xe,
>  	struct xe_ras_threshold_crossed *pending =3D (void *)&response->data;
>  	struct xe_ras_error_class *errors =3D pending->counters;
>  	u32 id, ncounters =3D pending->ncounters;
> +	u8 sent =3D 0;
> =20
>  	BUILD_BUG_ON(sizeof(response->data) < sizeof(*pending));
> +	BUILD_BUG_ON(BITS_PER_TYPE(sent) < XE_RAS_COMP_MAX);
>  	xe_device_assert_mem_access(xe);
> =20
>  	if (!ncounters || ncounters > XE_RAS_NUM_COUNTERS)
> @@ -329,6 +383,13 @@ void xe_ras_counter_threshold_crossed(struct xe_devi=
ce *xe,
> =20
>  		xe_warn(xe, "[RAS]: %s %s detected\n",
>  			comp_to_str(component), sev_to_str(severity));
> +
> +		/* Send event once per component */
> +		if (sent & BIT(component))
> +			continue;
> +		sent |=3D BIT(component);

[Severity: Medium]
Does this code introduce a regression if the sysctrl firmware returns an
unexpected component value >=3D 8?

The sent variable is an 8-bit u8. BIT() expands to 1UL << component,
which produces a value >=3D 256. When assigned to the u8 sent variable, this
truncates to 0, breaking deduplication. Furthermore, if the component value=
 is
>=3D 64, shifting by more than the width of unsigned long causes undefined
behavior.

[Severity: High]
Does this deduplication logic introduce a regression by dropping distinct R=
AS
events?

If the hardware sysctrl returns multiple errors for the same component in a
single response, but with different severities (e.g., one correctable, one
uncorrectable), this condition evaluates only the component ID.

The first processed event marks the component as sent, causing all subseque=
nt
events for that component to be silently dropped regardless of their severi=
ty.
Should we track both component and severity to avoid losing these hardware
events?

> +
> +		ras_send_error_event(xe, severity, component);
>  	}
>  }
[ ... ]
> @@ -425,6 +487,12 @@ enum xe_ras_recovery_action xe_ras_process_errors(st=
ruct xe_device *xe)
>  			xe_info(xe, "[RAS]: %s %s detected\n", comp_to_str(component),
>  				sev_to_str(severity));
> =20
> +			/* Send event once per component */
> +			if (!(sent & BIT(component))) {
> +				sent |=3D BIT(component);
> +				ras_send_error_event(xe, severity, component);
> +			}

[Severity: Medium]
Does this logic exhibit the same regressions mentioned above?

Since it uses the same sent bitmask logic, the truncation/undefined behavio=
r and
the distinct RAS event dropping regressions apply here as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722094134.3036=
087-4-riana.tauro@intel.com?part=3D2
