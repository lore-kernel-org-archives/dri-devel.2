Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D1AC44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B981B10E807;
	Mon, 20 Jul 2026 08:55:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BFyenPib";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18EC310E807
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 08:55:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EB80E41A9A;
 Mon, 20 Jul 2026 08:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AF01F000E9;
 Mon, 20 Jul 2026 08:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784537754;
 bh=Sg/hGfQs+vrq/ZR0xd/vGij5bRyUNMh2w8FSPZX5G7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BFyenPibmi8v4MdUmvmvX6g+XFBso1ePVd5w3NZTFIcat+rfDF0nx4gwfnfSkZZAe
 olxomffMmx+u7GJ2qqwsOFzcr2M9tmGaLJBzR7pX5loRCNzi6bwvRlY2mZtkyl/N+T
 7OsowsVcHbSxtnP5NxviX51kiZEoHiI6M/91eSDoTjDXJ4K/e0nTLlyK6TDVjSl+gG
 f3kchWZm3A8sLEAj1EtWRfNYr3gR3NYBCKis3AkcJdaHZkJ5X6b5m5lI3xE2GnTD++
 wrXfn5Y9Yo6SoztKYj/onQGRzXcdqgvCoN45dirxpfubQn8tELwBX/p2+prRA8eEL4
 PlvHF8Lpa9prA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vc4: Shut down BO cache timer before teardown
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720084426.1632508-1-lilinmao@kylinos.cn>
References: <20260720084426.1632508-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 08:55:54 +0000
Message-Id: <20260720085554.B0AF01F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] A validated shader BO can be mapped as read-only and later upg=
raded to writable via mprotect(), bypassing the security sandbox.
- [High] Several timers and work items are initialized but never shut down =
or cancelled during device teardown, leading to use-after-free vulnerabilit=
ies on device unbind.
--

--- Patch [1]: [PATCH] drm/vc4: Shut down BO cache timer before teardown ---
commit bece90f7afc134c57af68dcefaaf2ffb856fd71f
Author: Linmao Li <lilinmao@kylinos.cn>

drm/vc4: Shut down BO cache timer before teardown

The BO cache timer callback schedules time_work, and time_work can rearm
the timer through vc4_bo_cache_free_old(). This commit uses
timer_shutdown_sync() to prevent the timer from being rearmed during
teardown.

> diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
> index 2161761b1f221..90a51bc316208 100644
> --- a/drivers/gpu/drm/vc4/vc4_bo.c
> +++ b/drivers/gpu/drm/vc4/vc4_bo.c
[ ... ]
> @@ -731,6 +731,6 @@ static int vc4_gem_object_mmap(struct drm_gem_object =
*obj, struct vm_area_struct
>  {
>  	struct vc4_bo *bo =3D to_vc4_bo(obj);
> =20
>  	if (bo->validated_shader && (vma->vm_flags & VM_WRITE)) {
>  		DRM_DEBUG("mmapping of shader BOs for writing not allowed.\n");
>  		return -EINVAL;
>  	}

[Severity: Critical]
This is a pre-existing issue, but does this check allow a sandbox bypass
via mprotect()?

Because vma->vm_flags doesn't clear VM_MAYWRITE here, userspace could
mmap the validated shader BO as read-only (which passes this check), and
then later use mprotect() to upgrade the mapping to PROT_WRITE. Could this
allow unprivileged userspace to overwrite validated GPU instructions?

[ ... ]
> @@ -1044,7 +1044,7 @@ static void vc4_bo_cache_destroy(struct drm_device =
*dev, void *unused)
>  	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
>  	int i;
> =20
> -	timer_delete(&vc4->bo_cache.time_timer);
> +	timer_shutdown_sync(&vc4->bo_cache.time_timer);
>  	cancel_work_sync(&vc4->bo_cache.time_work);
> =20
>  	vc4_bo_cache_purge(dev);

[ ... ]
> diff --git a/drivers/gpu/drm/vc4/vc4_gem.c b/drivers/gpu/drm/vc4/vc4_gem.c
> --- a/drivers/gpu/drm/vc4/vc4_gem.c
> +++ b/drivers/gpu/drm/vc4/vc4_gem.c
> @@ -1193,4 +1193,4 @@ static void vc4_gem_destroy(struct drm_device *dev,=
 void *unused)
>  {
>  	struct vc4_dev *vc4 =3D to_vc4_dev(dev);
> =20
>  	/* Waiting for exec to finish would need to be done before

[Severity: High]
This isn't a bug introduced by this patch, but does vc4_gem_destroy() leak
active timers and work items?

The hangcheck.timer, hangcheck.reset_work, and job_done_work are
initialized in vc4_gem_init() but don't appear to be cancelled or shut
down here during teardown. Could these pending callbacks execute after
the vc4_dev structure is freed if the device is unbound?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720084426.1632=
508-1-lilinmao@kylinos.cn?part=3D1
