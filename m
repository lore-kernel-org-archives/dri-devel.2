Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 320A3C54F54
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85F4910EA5D;
	Wed, 29 Jul 2026 03:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cdhgktj0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B99E110EA5D
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:00:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B94141FA1;
 Wed, 29 Jul 2026 03:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E5B1F000E9;
 Wed, 29 Jul 2026 03:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785294049;
 bh=vNsZJYmNkZb0V1G+E99P7XblpR19tWadzeMGVK7AJVE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cdhgktj0F6lD4jEVtmj9x1Vv1rBsAwo9mscwOqzSmVa9OexOeYim+CeDS6w67LhF8
 inCXaQTErP1QnFPbAYCxVTVd/qmNtkkhyHDg1ggnGXrunl2faqb6iolQptsWnhKZHl
 3uhAUTuKm7wKBIF7he9Cr3lNSzBCuCDAXYtSXjn9YEVtEtuN1jIjlESqgDW72TwAxF
 tveQ2PdWSN4s929wPk6+yDMdh7HX5FIlw7fMPXJTa0lG+jlT9DhxxbUb/SWuc9bSbn
 jP/sGrCTh0rs5lNG1IIMxahTu911CERYHY4xzCs9p6eEMln3PDzWXiPSQq44bf8faL
 ICiX7sRjbUpSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/13] drm/panfrost: Prevent division by 0
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-2-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-2-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:00:48 +0000
Message-Id: <20260729030048.F0E5B1F000E9@smtp.kernel.org>
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
- [Medium] Integer overflow in devfreq load calculation on 32-bit architect=
ures
--

--- Patch [2]: [PATCH v4 02/13] drm/panfrost: Prevent division by 0 ---
commit 1a597fba6ac1a7783fb883935107fe50d2c19cfa
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>

drm/panfrost: Prevent division by 0

This commit modifies the devfreq status calculation to prevent a division
by zero when the total device time is less than 100 ns. It updates the
debug logging divisor and rearranges the operands.

Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88

> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
> index b51c307788110..0fe81d259274e 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -78,7 +78,7 @@ static int panfrost_devfreq_get_dev_status(struct devic=
e *dev,
> =20
>  	dev_dbg(pfdev->base.dev, "busy %lu total %lu %lu %% freq %lu MHz\n",
>  		status->busy_time, status->total_time,
> -		status->busy_time / (status->total_time / 100),
> +		status->busy_time * 100 / MAX(status->total_time, 1),

[Severity: Medium]
Will this cause an integer overflow on 32-bit architectures?

In panfrost_devfreq_get_dev_status(), status->busy_time is an unsigned
long, which is 32 bits on platforms like ARM32.

Since the Panfrost devfreq polling interval is 50ms, a fully busy GPU will
have a status->busy_time around 50,000,000 ns. Multiplying 50,000,000 by
100 yields 5,000,000,000, which overflows the 32-bit ULONG_MAX
(4,294,967,295) and wraps around to 705,032,704.

When this is divided by 50,000,000, it results in 14% instead of the
expected 100%.

Could this be calculated using a 64-bit type or a div-related macro to
prevent the debug log from reporting incorrect load percentages on heavily
loaded 32-bit systems?

>  		status->current_frequency / 1000 / 1000);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D2
