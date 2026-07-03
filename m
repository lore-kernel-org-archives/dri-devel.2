Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BBDC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1138710E648;
	Fri,  3 Jul 2026 16:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HxsMR3ZD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B5510E648
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 16:38:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 44D9E439B6;
 Fri,  3 Jul 2026 16:38:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC5A1F000E9;
 Fri,  3 Jul 2026 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783096683;
 bh=9uOPBRDHKb0bujGM/elcgmbBSjbGkUZA26EN3tm1Tjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HxsMR3ZDyNs2NenOOPLfjyErLRpgXSYh7dfFIDBVvpLA1nkZXZptX7rhE659O4OQF
 QxMHt/+HkWgGNJseInRokRkjdth/t2hbnm2AnLXXV0GXd5ZyoWMqbFE3pLFjEZ3y+x
 K1X7s4/wT07b6W3EcmfxbIVP1fkjhlvMdd9huyPoAsezqk6GLEIEqzTXX3P5t3sDCT
 IVquMWpAe7z0zg63VhdN/ylXviuuEtqiNUuhNaJcMB4GX3JvWKWUrRzvFiUCF92kNd
 AnsovmLeVl5Az4DaWQrHZ64WT++s5xv8Mn+gcx6Q50EP5+VKRrjJeiiC66Pm1i4rW3
 JtwES2hhZtc3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/10] drm/exec: Add helper to bypass IGNORE_DUPLICATES
 flag
To: "Natalie Vock" <natalie.vock@gmx.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260703-ttm_2_drm_exec-v1-1-43685ac1286b@gmx.de>
References: <20260703-ttm_2_drm_exec-v1-0-43685ac1286b@gmx.de>
 <20260703-ttm_2_drm_exec-v1-1-43685ac1286b@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 16:38:02 +0000
Message-Id: <20260703163802.EFC5A1F000E9@smtp.kernel.org>
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
- [Critical] drm_exec_lock_obj_report_dup() incorrectly passes `false` for =
`always_report_duplicates`, defeating its purpose and leading to premature =
lock releases.
--

commit ac725923453fdf4ef4b9421f9c3993a995b946f9
Author: Natalie Vock <natalie.vock@gmx.de>

drm/exec: Add helper to bypass IGNORE_DUPLICATES flag

This commit introduces a new helper, drm_exec_lock_obj_report_dup(), which
is intended to bypass the DRM_EXEC_IGNORE_DUPLICATES flag during a single
locking operation. This enables callers like the TTM LRU eviction walk to
determine if an object was already locked by an outer context.

> diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
> --- a/drivers/gpu/drm/drm_exec.c
> +++ b/drivers/gpu/drm/drm_exec.c

[ ... ]

> +/**
> + * drm_exec_lock_obj_report_dup - lock a GEM object for use, but always =
report duplicates
> + * @exec: the drm_exec object with the state
> + * @obj: the GEM object to lock
> + *
> + * Like drm_exec_lock_obj, lock a GEM object for use and grab a referenc=
e to it.
> + * Unlike drm_exec_lock_obj, DRM_EXEC_IGNORE_DUPLICATES is ignored and d=
uplicates are
> + * always reported.
> + *
> + * Returns: -EDEADLK if a contention is detected, -EALREADY when object =
is
> + * already locked, -ENOMEM when memory allocation failed and zero for su=
ccess.
> + */
> +int drm_exec_lock_obj_report_dup(struct drm_exec *exec,
> +				 struct drm_gem_object *obj)
> +{
> +	return __drm_exec_lock_obj(exec, obj, false);

[Severity: Critical]
Should this pass true for the always_report_duplicates parameter instead of
false?

By passing false, this helper behaves identically to drm_exec_lock_obj() and
will not bypass the DRM_EXEC_IGNORE_DUPLICATES flag. If it incorrectly
returns 0 instead of -EALREADY when an object is already locked, could an
LRU walk assume it acquired the lock and subsequently call
drm_exec_unlock_obj()?

This sequence appears to lead to a premature lock release and dropped GEM
reference while the outer context still relies on them, potentially causing
a use-after-free during GPU memory eviction.

> +}
> +EXPORT_SYMBOL(drm_exec_lock_obj_report_dup);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-ttm_2_drm_=
exec-v1-0-43685ac1286b@gmx.de?part=3D1
