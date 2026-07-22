Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB35C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C8210E46B;
	Wed, 22 Jul 2026 13:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AlfaQNhi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4AF10E478
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 13:57:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C9740600AB;
 Wed, 22 Jul 2026 13:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536D61F000E9;
 Wed, 22 Jul 2026 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784728634;
 bh=UubJwImUIyclENccxr6oyPYUY+C6pAEkxO9XV/O11V0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AlfaQNhirqXz9BdFTKns6puOZK7kk841NGH8yeyy7ne7C7ANRnNmxW6fRYA+///bT
 trkNpywqkOaeZWvXMks3H83bd7Oohq6VYTv/XFqUXPUNB9IAegBytVVlMg7hPSSLG2
 Zv/zUr3cImDUMjYwtHEEOSW37yyql1UTPOe2CQi4D0lcJY9ffxTTvSAWKDizqL5Y2u
 b/cEPd3d33gkktlWyDV3/Ygs9jPm/N6CMFx5ltXpDPW+4qokdgwTLy31h1mRM7ww7n
 5ZGJLr3EmeC5PskZLkKm2cxeEiqBLop5T0pTGm2RYdnmYs8Oc07J61+4pUV5DxqElG
 6ALTnN9qZtZng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/4] drm/xe/mcr: Sanitize steering semaphore on GT
 resume
To: =?utf-8?b?VGFsZXMgQS4gTWVuZG9uw6dh?= <talesam@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722004654.744249-3-talesam@gmail.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-3-talesam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 13:57:13 +0000
Message-Id: <20260722135714.536D61F000E9@smtp.kernel.org>
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
- [Medium] Missing MCR lock sanitization during driver load despite documen=
ted claims.
--

--- Patch [2]: [PATCH v1 2/4] drm/xe/mcr: Sanitize steering semaphore on GT=
 resume ---
commit 5b9e1b6b52eef7a040056b851f2fb96429ee7d28
Author: Tales A. Mendon=C3=A7a <talesam@gmail.com>

drm/xe/mcr: Sanitize steering semaphore on GT resume

This commit addresses an issue where the MCR steering semaphore is left
held across a suspend cycle. It adds xe_gt_mcr_lock_sanitize() to forcibly
release the semaphore and calls it in xe_gt_resume() before the first MCR
access.

> diff --git a/drivers/gpu/drm/xe/xe_gt_mcr.c b/drivers/gpu/drm/xe/xe_gt_mc=
r.c
> index e1e3c0688dc2e..3934d0de7170a 100644
> --- a/drivers/gpu/drm/xe/xe_gt_mcr.c
> +++ b/drivers/gpu/drm/xe/xe_gt_mcr.c
[ ... ]
> @@ -750,6 +750,28 @@ static void mcr_unlock(struct xe_gt *gt, unsigned in=
t fw_ref) __releases(&gt->mc
>  	}
>  }
> =20
> +/**
> + * xe_gt_mcr_lock_sanitize - Release the hardware MCR steering semaphore
> + * @gt: GT structure
> + *
> + * The MCR steering semaphore can be left in a held state after a suspend
> + * cycle, in which case the first MCR access after resume stalls until t=
he
> + * semaphore wait times out.  Forcibly release the semaphore during driv=
er
> + * load/resume; this is safe because no other agents acquire the semapho=
re

[Severity: Medium]
The comment and commit message both mention releasing the semaphore during
driver load, but the patch only adds the sanitization call to xe_gt_resume(=
).

If the boot firmware leaves the MCR lock held, won't the first MCR access
during driver load still stall and log a timeout error?

For example, this could occur in early initialization paths like:
xe_device_probe()
  -> xe_gt_init_early()
    -> xe_pat_init()

Or in:
gt_init_with_gt_forcewake()
  -> xe_gt_enable_host_l2_vram()

Should a call to xe_gt_mcr_lock_sanitize() be added to the early driver
initialization paths to fully cover the load sequence?

> + * during the load/resume process, mirroring i915's
> + * intel_gt_mcr_lock_sanitize().
> + */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722004654.7442=
49-1-talesam@gmail.com?part=3D2
