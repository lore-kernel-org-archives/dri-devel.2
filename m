Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2170C61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B89E10F27A;
	Fri, 28 Aug 2026 06:59:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="An1GkoTg";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25E6C10F27A
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 06:59:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2AF99602D4;
 Fri, 28 Aug 2026 06:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28511F00A3A;
 Fri, 28 Aug 2026 06:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787900343;
 bh=lwzt3rJ2E/k+ILtpA4lEnci1czOa2aliqgfiL1i5RJ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=An1GkoTgg3ERenlEruh4XAo/BaylFysUKDD9IS3oFhxQvemz5RgiX4XbjPJdphHqg
 enbHVxP8Y1K2k+qrTDvpxKeuKpTTE0XL0hSoZvmW/aW+1ei23G/GbEgZc9YSP1LeP7
 Q2Sg6HihMM3co3JoBZKH0Li+GWChspSXhWMRcr6X1MDC18IEScEO/3WhlwId6FkZ9a
 7I9TcjZx6j4gH4UFHOIFYfjqFruUAYc1/EerkazA6y4feAdIVAYwD5ojtpGXOhwyrF
 EnO988OtkTyABhSgw64qtb+Eg2DfWthEeXyTr9ez03mDrNk4avkY+Lo9OQ4FHXDEXn
 4UwQMISCnhsHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] accel/rocket: Propagate job submission errors
To: "Haoming Gao" <Naixumogu@whut.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260828064152.37822-4-Naixumogu@whut.edu.cn>
References: <20260828064152.37822-1-Naixumogu@whut.edu.cn>
 <20260828064152.37822-4-Naixumogu@whut.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 06:59:03 +0000
Message-Id: <20260828065903.B28511F00A3A@smtp.kernel.org>
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
- [High] Unbounded `job_count` allows memory exhaustion and memcg limit byp=
ass (Denial of Service).
--

commit 25d3cd6d4d07a127ac97a2a68ff62409e8f7d1fd
Author: Haoming Gao <Naixumogu@whut.edu.cn>

accel/rocket: Propagate job submission errors

This commit modifies rocket_ioctl_submit() to return the first error
encountered during job submission and stops processing remaining jobs,
leaving previously queued jobs intact.

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -647,8 +647,11 @@ int rocket_ioctl_submit(struct drm_device *dev, void=
 *data, struct drm_file *fil
>  	}
> =20
> =20
> -	for (i =3D 0; i < args->job_count; i++)
> -		rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +	for (i =3D 0; i < args->job_count; i++) {
> +		ret =3D rocket_ioctl_submit_job(dev, file, &jobs[i]);
> +		if (ret)
> +			goto exit;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for an
unprivileged user to exhaust system memory here?

The loop iterates based on args->job_count without an apparent upper bound.
During each iteration, rocket_ioctl_submit_job() allocates struct rocket_jo=
b,
task arrays, and DRM scheduler objects.

Because these are allocated using kzalloc_obj and kvmalloc_objs (which
default to GFP_KERNEL without __GFP_ACCOUNT), they are not charged to the
caller's memory cgroup.

Could a user pass a massive job_count to the ioctl via the DRM render node
to bypass container limits and trigger a system-wide out of memory conditio=
n?

> =20
>  exit:
>  	kvfree(jobs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828064152.3782=
2-1-Naixumogu@whut.edu.cn?part=3D3
