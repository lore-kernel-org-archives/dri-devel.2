Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0EAC531CA
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 03:47:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D4F10E51C;
	Thu, 23 Jul 2026 03:47:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CkBg3PHn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF7010E4C6
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:47:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 03C98600AF;
 Thu, 23 Jul 2026 03:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934681F000E9;
 Thu, 23 Jul 2026 03:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784778452;
 bh=tn7HMKw694QQEMmcTxEzMzJWjpY8RuiN2i9WseA0eiE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CkBg3PHnNAlB5PiC7V/mTzaXkuLgYSNzbBgIRmZ2Rg9pmz6RUl877S+MWNhFJbqtt
 1LEbQRepw6mIrd5Y+h9vURrGpW19bS32OsydXjyvZNXkbCiMzBljLenyDi5c9HcDtA
 PBjYtpxws5X0H/PVXpSysBqYN3wVg3OSBxgeIJpiNzDPP2oHDA6m5WLrlB3FBOnywg
 gYp64pTRF1z+WTtIIdg6UkgMDduA535I+WaFEcdPWLkkVlnE1mD6apJOIqMrnmWcJW
 OgwJz52+fmoqo/5VyQ+IgO95aSUJExAa0NL1lETX2RkIUkQ6frZk05bZX1Tcm/X1oI
 JqtlTQiXfpzmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] drm/xe/drm_ras: Wire up error threshold callbacks
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722034228.662746-5-raag.jadav@intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
 <20260722034228.662746-5-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 03:47:32 +0000
Message-Id: <20260723034732.934681F000E9@smtp.kernel.org>
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

New issues:
- [Medium] The driver violates the DRM RAS framework API contract by failin=
g to perform bounds checking on the user-supplied threshold value.

Pre-existing issues:
- [High] Lack of reference counting or RCU read locks in the generic drm_ra=
s core causes a TOCTOU race leading to Use-After-Free of drm_ras_node and x=
e_device during concurrent device unbind.
--

--- Patch [4]: [PATCH v5 4/5] drm/xe/drm_ras: Wire up error threshold callb=
acks ---
commit a57e8de665a45c38e3544fb21f325ce074bc995d
Author: Raag Jadav <raag.jadav@intel.com>

drm/xe/drm_ras: Wire up error threshold callbacks

This commit wires up the get/set error threshold support in the xe driver to
the generic drm_ras core. This allows userspace to query and configure
correctable error thresholds via Netlink.

> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_=
ras.c
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c
> @@ -86,6 +86,38 @@ static int clear_correctable_error_counter(struct drm_=
ras_node *node, u32 error_
>  	return clear_error_counter(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_id=
);
>  }
> =20
> +static int query_correctable_error_threshold(struct drm_ras_node *ep, u3=
2 error_id,
> +					     const char **name, u32 *threshold)
> +{
> +	struct xe_device *xe =3D ep->priv;

[Severity: High]
This is a pre-existing issue, but can this dereference of ep and ep->priv
lead to a use-after-free during concurrent device unbind?

If a Netlink request calls get_node_error_threshold() in the generic drm_ras
core, it retrieves the node via xa_load() but doesn't hold RCU or take a
reference count. Concurrently, if the device is unbound, the drmm action
cleanup_node() could free the drm_ras_node and the xe_device.

When the Netlink thread resumes and calls this callback, could the ep point=
er
and the xe_device it points to already be freed?

> +	struct xe_drm_ras *ras =3D &xe->ras;
> +	struct xe_drm_ras_counter *info =3D ras->info[DRM_XE_RAS_ERR_SEV_CORREC=
TABLE];

[ ... ]

> +static int set_correctable_error_threshold(struct drm_ras_node *ep, u32 =
error_id, u32 threshold)
> +{
> +	struct xe_device *xe =3D ep->priv;
> +	struct xe_drm_ras *ras =3D &xe->ras;
> +	struct xe_drm_ras_counter *info =3D ras->info[DRM_XE_RAS_ERR_SEV_CORREC=
TABLE];
> +
> +	if (!info || !info[error_id].name)
> +		return -ENOENT;
> +
> +	if (!xe->info.has_sysctrl)
> +		return -EOPNOTSUPP;
> +
> +	return xe_ras_set_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_i=
d, threshold);

[Severity: Medium]
Is this missing a bounds check on the user-supplied threshold value?

The DRM RAS documentation in include/drm/drm_ras.h explicitly mandates
that the driver is responsible for error threshold bounds checking in the
set_error_threshold() callback. Here, the threshold value is passed directly
to xe_ras_set_threshold() and the system controller without validation.

Could this lead to speculative hardware misbehavior or interrupt storms if
userspace passes malformed values like 0 or an extremely large integer?

> +}
> +
>  static struct xe_drm_ras_counter *allocate_and_copy_counters(struct xe_d=
evice *xe)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722034228.6627=
46-1-raag.jadav@intel.com?part=3D4
