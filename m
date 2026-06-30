Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C399C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8586110E186;
	Tue, 30 Jun 2026 08:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BN9kaQxI";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6344D10E186
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:46:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6A10D60008;
 Tue, 30 Jun 2026 08:46:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F251D1F000E9;
 Tue, 30 Jun 2026 08:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782809177;
 bh=LsDgW5y1lXH+ZyD7odtxWf3c81AXB22D5071REMVNMk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BN9kaQxI40xeS3IDS5nU6I4SiMK1cpccAtqSOQkpoIGZ7caT9gli9nhV2oF1/wCVD
 5k7Uz68TbRRX0AtmrB9+WbzhKhEI6vaCzQuYjXb58SbZFWDpdiTuAp6D6M4NnwXyHu
 RGTxNo5inSPbRKKcV/fxqJNaR9Pg45LAQcc26O7f/o9uIf0JzUdGIFsBG2DXN2Kd0F
 BirdXPZo5uoM9shMp/B2697/8j8qJJvyN7XbLIeR+9sJ/LW5CdBXpvsCxH3xSlqnBV
 /JxF5JMRISa0tLVAPDcfQxr8W8czlDGBxeeL0q9Hyv/aT7FpWbadMZQLLiiA7vKFBI
 hiaH0aZvwgWTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/5] drm/gpusvm: split MM state flags out of
 drm_gpusvm_pages_flags
To: "Honglei Huang" <honghuan@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630083307.381909-2-honghuan@amd.com>
References: <20260630083307.381909-1-honghuan@amd.com>
 <20260630083307.381909-2-honghuan@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:46:16 +0000
Message-Id: <20260630084616.F251D1F000E9@smtp.kernel.org>
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
- [Medium] Missing READ_ONCE() when reading the lockless bitfield `migrate_=
devmem` in `xe_svm_alloc_vram()` causes a data race.
--

commit e500b2422f5c84b340b191071b2b62f1ff1b58ca
Author: Honglei Huang <honghuan@amd.com>

drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags

This commit splits MM state flags from drm_gpusvm_pages_flags into a new
drm_gpusvm_range_flags structure. It introduces a union with a __flags
member to allow WRITE_ONCE and READ_ONCE for lockless readers, aiming
to keep concurrent bitfield access data-race free.

Link: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-=
2025/-/commit/623f6a50c037d9e44f6c9fbe6859a0ba7ad50177

> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c

[ ... ]

> @@ -1621,7 +1629,7 @@ int xe_svm_alloc_vram(struct xe_svm_range *range, c=
onst struct drm_gpusvm_ctx *c
>  	int err, retries =3D 1;
>  	bool write_locked =3D false;
> =20
> -	xe_assert(range_to_vm(&range->base)->xe, range->base.pages.flags.migrat=
e_devmem);
> +	xe_assert(range_to_vm(&range->base)->xe, range->base.flags.migrate_devm=
em);

[Severity: Medium]
Does this plain bitfield read trigger a KCSAN data race warning?

The commit message states that lockless readers should use READ_ONCE() on
the __flags member. However, xe_svm_alloc_vram() reads the migrate_devmem
bitfield directly without holding the notifier_lock.

Since drm_gpusvm_range_set_unmapped() modifies this overlapping memory using
WRITE_ONCE(range->flags.__flags, range_flags.__flags), could this concurrent
access trigger KCSAN warnings and violate the intended data-race free desig=
n?

>  	range_debug(range, "ALLOCATE VRAM");
> =20
>  	migration_state =3D drm_gpusvm_scan_mm(&range->base,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630083307.3819=
09-1-honghuan@amd.com?part=3D1
