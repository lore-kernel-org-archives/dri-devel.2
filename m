Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E78CECDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:15:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4C310EE77;
	Wed, 24 Jun 2026 10:15:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S37ScJK6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4502410EE6D
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 10:15:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BF0DD60138;
 Wed, 24 Jun 2026 10:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C8B1F00A3A;
 Wed, 24 Jun 2026 10:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782296133;
 bh=3ETaqt9hY+Z13KIFY2UMBAcKeANwzMskjUsNsVclVH8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S37ScJK6PKb8qReko85QL2SLloLrhfq9EwzS0hnPWSDX2NmkVrdFmWwZ58RysBe1o
 lROd7woQxjrcecw4HwK+01NQZDHNW0+s2LJfRpVK/HVK4a+gGRgybOe339+650jfJ6
 m1WnhIeGXe5nyIT2oTXiGjwC6inzEtrkOVXk6N23zdPyeb/AkoNnlBuo45GUwB3e0t
 f+tPDFKkzT3a817Hue4IGNe19wtRnLSjpL8V3gES0wYPd3l0QcYTa3HS5JaI0o8v52
 7aiv1oGjwdaGfHR/pMpsJ1CX7NjyGV9XKZnds43wyPTWPrvprAoE/D5N0JBSr25joh
 5k5FEVeE/J/YA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/5] drm/xe/drm_ras: Wire up error threshold callbacks
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260623101043.255897-5-raag.jadav@intel.com>
References: <20260623101043.255897-1-raag.jadav@intel.com>
 <20260623101043.255897-5-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 10:15:32 +0000
Message-Id: <20260624101533.63C8B1F00A3A@smtp.kernel.org>
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
- [Medium] The set_error_threshold callback implementation does not perform=
 bounds checking on the threshold value.
--

commit fed54e8b69e86b28d2dcdaf8a7fe08701b357d95
Author: Raag Jadav <raag.jadav@intel.com>

drm/xe/drm_ras: Wire up error threshold callbacks

This commit wires up the get and set error threshold callbacks to the
drm_ras infrastructure, allowing userspace to configure these thresholds
via netlink commands.

> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_=
ras.c
> index 7937d8ba0ed9c..4afa2ad98300f 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c

[ ... ]

> @@ -86,6 +86,38 @@ static int clear_correctable_error_counter(struct drm_=
ras_node *node, u32 error_

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

[Severity: Medium]
Does this code need bounds checking for the threshold value before passing =
it
to the hardware?

The drm_ras API documentation for set_error_threshold specifies that the
driver is responsible for error threshold bounds checking. If a privileged
user provides an extreme value, such as 0, could this result in undefined
hardware behavior or continuous interrupts from the system controller?

> +	return xe_ras_set_threshold(xe, DRM_XE_RAS_ERR_SEV_CORRECTABLE, error_i=
d, threshold);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623101043.2558=
97-1-raag.jadav@intel.com?part=3D4
