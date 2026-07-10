Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C96C43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:20:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E57110F98A;
	Fri, 10 Jul 2026 22:20:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MVgGUs/Z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D479610F98A
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 22:20:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9AD8C4081A;
 Fri, 10 Jul 2026 22:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549051F000E9;
 Fri, 10 Jul 2026 22:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783722019;
 bh=tC4dLw+MT5TrK+FuJjmpLPrfrt7AK7fHxU0Oin4607E=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MVgGUs/ZIig8+BENXVBI2Uy2Stcg69gKoEXOuUGifYtTibjUEGbqwC6Lind8RGlqZ
 iUITekMIcIvPKL4WRZovggFRXuHEqiFlTmfO7U4knbiDXKabHmeeTgx5syTKzarjXK
 Sjwq3QR/TTbRwOyp6fvmrTRE29NCQMlixhJ+WuGfnmp3OVaWYSmyw0S+jX7TOw3q6Q
 LoS6SEx/KfD90vARqk3t8onBY5oR6aMjhBN2tAyfM/PcfI8T5rvazGXND3zydyZqS9
 bn6V7H93VAy6sPGd2pikD050iW9zwg8JubejaBFzh7+NKA5WBrxYF/0TcOZbKxQaF7
 YaQ0+cOUf1wmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 26/33] drm/xe: Add tracepoint for xe_gem_create_ioctl
To: "Matthew Brost" <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710215442.2444235-27-matthew.brost@intel.com>
References: <20260710215442.2444235-1-matthew.brost@intel.com>
 <20260710215442.2444235-27-matthew.brost@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 22:20:18 +0000
Message-Id: <20260710222019.549051F000E9@smtp.kernel.org>
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
- [Medium] Tracepoint metric `lock_us` incorrectly reports system uptime on=
 early error paths and includes lock-dropped backoff time during contention=
 retries.
--

--- Patch [26]: [PATCH v2 26/33] drm/xe: Add tracepoint for xe_gem_create_i=
octl ---
commit 245e602165eaf1749a023b1941ce834af1e88d5e
Author: Matthew Brost <matthew.brost@intel.com>

drm/xe: Add tracepoint for xe_gem_create_ioctl

This commit adds a tracepoint to xe_gem_create_ioctl to profile GEM creatio=
n,
particularly tracking the time spent under the dma-resv lock versus total I=
OCTL
time. The asid is captured at VM lookup time since the VM reference is drop=
ped
before the tracepoint fires.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index d9226a3995fe4..c096f3dbd5289 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
[ ... ]
> @@ -4057,6 +4062,10 @@ int xe_gem_create_ioctl(struct drm_device *dev, vo=
id *data,
>  			if (err)
>  				break;
>  		}
> +
> +		if (lock_start =3D=3D ktime_set(0, 0))
> +			lock_start =3D ktime_get();

[Severity: Medium]
Will this include lock-dropped backoff time if there is lock contention?=20

If a retry occurs and the validation loop restarts, lock_start is not reset=
=20
to the actual lock acquisition time because it is no longer 0.

> +
>  		bo =3D xe_bo_create_user(xe, vm, args->size, args->cpu_caching,
>  				       bo_flags, have_prealloc ? &prealloc : NULL,
>  				       &exec);
> @@ -4067,6 +4076,7 @@ int xe_gem_create_ioctl(struct drm_device *dev, voi=
d *data,
>  			break;
>  		}
>  	}
> +	lock_ns =3D ktime_to_ns(ktime_sub(ktime_get(), lock_start));

[Severity: Medium]
Does this calculate a duration based on system uptime on early error paths?=
=20

If the validation loop breaks early (e.g. from an -EINTR in xe_vm_drm_exec_=
lock)=20
before lock_start is set, lock_start will still be 0.=20

>  	if (have_prealloc)
>  		ttm_pool_prealloc_fini(&xe->ttm.pool, &prealloc);
>  	if (err)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710215442.2444=
235-1-matthew.brost@intel.com?part=3D26
