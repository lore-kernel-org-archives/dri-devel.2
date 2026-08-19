Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B68C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 13:54:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01B6410E58E;
	Wed, 19 Aug 2026 13:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ewam6hLm";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBFC110E14A;
 Wed, 19 Aug 2026 13:54:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 613A643E14;
 Wed, 19 Aug 2026 13:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC051F000E9;
 Wed, 19 Aug 2026 13:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787147692;
 bh=E3qmnuVdPoMXOOn7wE9aOI3xgbl4X6TCl+46TRGDFr8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ewam6hLmwHdXTGOXMxQLZbMqi93L9KLRvo+5U1HoxYeFOG+xB/2SQgXPy3Q3zoS9h
 JIfjQiNZoJR0oaXt9v9bRd45L+wsHvhYRMbHHsLH7f5QAQ465L12/ZZQIA2skibqol
 fPuNGIG5HKCqBSuybJi9bQJMtceLMJhtYTKVjZG2EWmBPEdoxC3Lf4WuyGjjofPdP2
 KXR5ARnW7ShXZFZM28J3Gad9WSBR69W6Ja9NFpllsDwEUMRR/rd5ELXICJNHwu8IWG
 zH4cdlTUt5b+5nrtMAMGD7vLEjM3UWf2Hv8Ypt4ANltWwfOpEoy2Dw51+HDc1i1wx6
 cQFWgN95obabQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] drm/xe/drm_ras: Wire up error threshold callbacks
To: "Raag Jadav" <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260818135304.497098-5-raag.jadav@intel.com>
References: <20260818135304.497098-1-raag.jadav@intel.com>
 <20260818135304.497098-5-raag.jadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 13:54:51 +0000
Message-Id: <20260819135452.1AC051F000E9@smtp.kernel.org>
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
- [Medium] Missing bounds validation for the user-provided `threshold` valu=
e in `set_correctable_error_threshold()`, violating the DRM RAS core API co=
ntract.
--

--- Patch [4]: [PATCH v6 4/5] drm/xe/drm_ras: Wire up error threshold callb=
acks ---
commit 07d0b2b18f83648184a377e573f78e416567ad07
Author: Raag Jadav <raag.jadav@intel.com>

drm/xe/drm_ras: Wire up error threshold callbacks

This commit wires up the get/set error threshold support in the xe driver to
drm_ras, allowing userspace to make use of this functionality via netlink.

> diff --git a/drivers/gpu/drm/xe/xe_drm_ras.c b/drivers/gpu/drm/xe/xe_drm_=
ras.c
> index 78184b6ea7d48..7f3695707611c 100644
> --- a/drivers/gpu/drm/xe/xe_drm_ras.c
> +++ b/drivers/gpu/drm/xe/xe_drm_ras.c

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
Does this code need to validate the threshold bounds before passing it to t=
he
firmware?

The set_error_threshold documentation in include/drm/drm_ras.h explicitly
states: "Driver is responsible for error threshold bounds checking."

Passing an unvalidated user-provided threshold directly to
xe_ras_set_threshold() and the system controller firmware might cause
unexpected behavior or denial-of-service conditions if the firmware does not
robustly handle edge cases like extremely large values or a threshold of 0.

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818135304.4970=
98-1-raag.jadav@intel.com?part=3D4
