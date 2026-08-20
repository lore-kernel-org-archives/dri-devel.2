Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1505C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08AB310E5CE;
	Thu, 20 Aug 2026 14:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IDGEKwNZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C465A10E5CE
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 14:11:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 780E541B37;
 Thu, 20 Aug 2026 14:11:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478701F000E9;
 Thu, 20 Aug 2026 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787235115;
 bh=DCSbIZ8ZNPc+2lg1U8pQ7AdpAOmDHyVYHcGtnzrt0q4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IDGEKwNZcoo4hs5UcaQaQJ4fLgmm+RrE9TpZMx12KawFc8rjmHVnSQccGlh3ljIq6
 NuFZbahgK84rTf7kBf0YvOl+Pfn4eWvFySFBR/uOSPz+RtGB4iAZ3mslOltA01uAIP
 5TZgh9qov3r3gkDalI/aV2Er+oN6XdViZKINQKES5T/5pUnV2l3ds7uSs7yVIc1ShK
 7hAhPe6NM1wD9VmvB/oRnOn7xgs3bucb38neBroqjI3ZHFWIIP3WPrnWeGMQEHCZEv
 4ZTwm1mpQKVJk8Ws4uigXj/vO3dQIZcL3SjvesLFbgxVmrxdKll7LJYcFicDyDoVL7
 NM2Bpk4XNoRmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/panfrost: Prevent division by 0
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260820-b4-panfrost-fixes-v1-2-1b2c2376f4bc@collabora.com>
References: <20260820-b4-panfrost-fixes-v1-0-1b2c2376f4bc@collabora.com>
 <20260820-b4-panfrost-fixes-v1-2-1b2c2376f4bc@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:11:54 +0000
Message-Id: <20260820141155.478701F000E9@smtp.kernel.org>
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
- [Medium] Rearranging the expression to `status->busy_time * 100` introduc=
es an integer overflow on 32-bit architectures, resulting in drastically in=
correct devfreq load percentages being logged.
--

--- Patch [2]: [PATCH 2/3] drm/panfrost: Prevent division by 0 ---
commit f1707dda0ddcd92307754978d37b7e0bf9939612
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
drm/panfrost: Prevent division by 0

This commit addresses a potential division by zero when calculating device
frequency utilization for debug logging. It rearranges the calculation to
multiply busy time by 100 before dividing by the maximum of total time or 1.

Closes: https://gitlab.freedesktop.org/panfrost/linux/-/work_items/88

> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/dr=
m/panfrost/panfrost_devfreq.c
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
Will this calculation overflow on 32-bit architectures?

In panfrost_devfreq_get_dev_status(), status->busy_time is an unsigned long,
which is 32 bits on ARM32 architectures where Panfrost is widely used.

Since devfreq times are calculated in nanoseconds, a standard 50ms polling
interval can yield a busy_time of around 50,000,000 ns. Multiplying
50,000,000 by 100 results in 5,000,000,000, which exceeds the maximum
32-bit unsigned long value of 4,294,967,295.

Could this cause drastically incorrect load percentages to be logged during
normal GPU workloads when devfreq debug logging is enabled?

>  		status->current_frequency / 1000 / 1000);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-b4-panfros=
t-fixes-v1-0-1b2c2376f4bc@collabora.com?part=3D2
