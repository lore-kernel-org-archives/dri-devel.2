Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F841CCA464
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1B2C10E27A;
	Thu, 15 Oct 2026 18:36:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A8C81121A9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 18:36:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B196406BD;
 Thu, 15 Oct 2026 18:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F181F000C4;
 Thu, 15 Oct 2026 18:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792089376;
 bh=qfunBLfL+YUR/Df3syAiPwfZG8eHkTd8LfIFGXeg++o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d39Gqi6Ibs5QaZSVUtVhY74j3P3DTz+4vP2Bhr3lh6z6D4fQd9lrILZyvpoO+NIU1
 KDdL2Gzgwpcfcx3NX0bdqGG1H0NnJ922+eWM0BnPKB5LnGdixmB1O6KKsDBslgkKyP
 wUSYUSq7aRI4fSTwL4E9g82HlNhrJMHQ7546gxfn2j6ZIAXE1c6cEP/JY5Rsl3ynOk
 qOxrNfRps39ClPoPNGWX6ws4VL/+C8MCD3OWkH8IJpYHgSinOfT0R/oUqPmXEJK8BN
 WO/vtxUxNAGUvxlE++V32eCPd61XNHIqAdTWEzAN3It4Rzp0H/BTuFAgqBEWqQ+Pgb
 BhYqWgZPJKcKA==
Message-ID: <sashiko-outbox-173309@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/panfrost: Enable cycle counting when perfcnt is
 enabled
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261015-panfrost-reset-races-fixes-v1-1-bb74c1786a0b@collabora.com>
References: <20261015-panfrost-reset-races-fixes-v1-0-bb74c1786a0b@collabora.com>
 <20261015-panfrost-reset-races-fixes-v1-1-bb74c1786a0b@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:36:15 +0000
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
- [Medium] drm/panfrost: Spurious drm_WARN_ON during GPU reset with active =
perfcnt
--

commit d9ae50cec3ff06c2a614193efb813114ed5ac709
Author: Boris Brezillon <boris.brezillon@collabora.com>
Date:   Thu Oct 15 18:22:31 2026 +0000

    drm/panfrost: Enable cycle counting when perfcnt is enabled

    If we don't do that, we end up with invalid timestamps in the block
    headers.

> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/dr=
m/panfrost/panfrost_perfcnt.c
> index a9def452d5ef9..b26da057a1a01 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c

[ ... ]

> @@ -84,6 +86,7 @@ static int panfrost_perfcnt_hw_enable(struct panfrost_d=
evice *pfdev)
>  		return ret;
> =20
>  	perfcnt->owns_as_ref =3D true;
> +	panfrost_cycle_counter_get(pfdev);

[Severity: Medium]
Will this cause a spurious drm_WARN_ON() during a GPU reset?

When a GPU reset is triggered (e.g. by a job timeout), panfrost_device_rese=
t()
is called. This function calls panfrost_gpu_soft_reset() before it handles
the perfcnt state via panfrost_perfcnt_reset():

drivers/gpu/drm/panfrost/panfrost_device.c:panfrost_device_reset() {
    ...
	panfrost_gpu_soft_reset(pfdev);
    ...
	panfrost_perfcnt_reset(pfdev);
}

Inside panfrost_gpu_soft_reset(), it expects all cycle counter references
to be released:

drivers/gpu/drm/panfrost/panfrost_gpu.c:panfrost_gpu_soft_reset() {
    ...
	/*
	 * All in-flight jobs should have released their cycle
	 * counter references upon reset, but let us make sure
	 */
	if (drm_WARN_ON(&pfdev->base, atomic_read(&pfdev->cycle_counter.use_count)=
 !=3D 0))
		atomic_set(&pfdev->cycle_counter.use_count, 0);
    ...
}

Because the perfcnt still holds the reference when panfrost_gpu_soft_reset()
is called, won't this trigger the drm_WARN_ON() and potentially panic the k=
ernel
if panic_on_warn is enabled?

> =20
>  	as =3D ret;
>  	cfg =3D GPU_PERFCNT_CFG_AS(as) |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-panfrost-r=
eset-races-fixes-v1-0-bb74c1786a0b@collabora.com?part=3D1
