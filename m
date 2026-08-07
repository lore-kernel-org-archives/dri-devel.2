Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5DDC2A09B
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7C3210F52B;
	Fri,  7 Aug 2026 15:27:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fmvd7Mn1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB4410F52B
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 15:27:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B45C860051;
 Fri,  7 Aug 2026 15:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E851F00A3A;
 Fri,  7 Aug 2026 15:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786116423;
 bh=jFZjuVd5tYFoNKfwBYJUYFwZVQtaj2WhWsO8ncfQ2/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fmvd7Mn1Coz2VDHZUxYBa4c4+cN74ZlMrQeUBlriAe0EDptk2lQ0gwX0FKKPQ7U85
 vVXvnwS7GncKIkB7JL5qvk1UNc5dc1SCkJU1kKkUEQyOdvjcrexH5XjJln3+Sb4f2Y
 lTjE2RMdreO8gqAMPdeJm+2WaTNhm/5ScMZ3QZqBnLbcn77tyCaifEh1iOaTWRuU+0
 NW/N6Jur/QGPwmhgxRRNtNuOIJbRm10pQxKopMzUXQEP8vYMPGhyqfQXZ9EaD5NCLv
 qKX15Omi9QgtSahI7E+YSihVHoXfVxr/aTm1/IucPbr3lR9AJt4k2EEmN/068lDXH0
 pg/Bn7W9J9ZUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] staging: fbtft: make dirty_lock IRQ-safe
To: "Hui Su" <sh_def@163.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260807150953.2811933-3-sh_def@163.com>
References: <20260807150953.2811933-3-sh_def@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:27:03 +0000
Message-Id: <20260807152703.57E851F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] dirty_lock must be converted to raw_spinlock_t to prevent fatal ke=
rnel panics on PREEMPT_RT.
--

--- Patch [1]: [PATCH v2] staging: fbtft: make dirty_lock IRQ-safe ---
commit 2781cf2c7f0e0cfa744e4747b9f7004477fdff7b
Author: Hui Su <sh_def@163.com>

staging: fbtft: make dirty_lock IRQ-safe

This commit updates the dirty_lock acquisitions in fbtft_mkdirty() and
fbtft_deferred_io() to use IRQ-safe variants. This prevents a possible
IRQ lock inversion between dirty_lock and console_owner.

Link: https://lore.kernel.org/lkml/20260804173712.176017-1-sh_def@163.com/

> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/f=
btft-core.c
> index ca0c38221c16b..7925d974de801 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -298,14 +298,15 @@ static void fbtft_mkdirty(struct fb_info *info, int=
 y, int height)
>  {
>  	struct fbtft_par *par =3D info->par;
>  	struct fb_deferred_io *fbdefio =3D info->fbdefio;
> +	unsigned long flags;
> =20
>  	/* Mark display lines/area as dirty */
> -	spin_lock(&par->dirty_lock);
> +	spin_lock_irqsave(&par->dirty_lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but will this cause a kernel
panic on PREEMPT_RT systems?

The commit message notes that fbtft_mkdirty() can be reached from the fbcon
rendering path while processing printk() in hardirq context. On PREEMPT_RT,
spinlock_t is mapped to a sleepable rt_mutex. Acquiring a sleepable lock in
true hardirq context will trigger a sleep-in-atomic bug.

Since dirty_lock is accessed in true hardirq context, should the
declaration of dirty_lock in struct fbtft_par be converted to a
raw_spinlock_t and acquired via raw_spin_lock_irqsave() to safely
synchronize under PREEMPT_RT?

>  	if (y < par->dirty_lines_start)
>  		par->dirty_lines_start =3D y;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807150953.2811=
933-3-sh_def@163.com?part=3D1
