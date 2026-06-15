Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3DF0CD98DE
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 21:56:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1560210E60C;
	Mon, 15 Jun 2026 21:56:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="A/8idGc1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF52310E60C
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 21:56:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4BED843658;
 Mon, 15 Jun 2026 21:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12DFF1F000E9;
 Mon, 15 Jun 2026 21:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781560615;
 bh=sj2Jl0fyt3Uqn/L6dxcDrSiHN3vyoxnKoYA0w429js4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=A/8idGc1WkV/Oa5Z0WEDwT5BzENHdptyVMYNihvWwmEpG7b+cg3lxUhIRyhhGn+IX
 kO4sQsg+ud4F5BuYAGzeUiF3lSo6sO0Is7KTyVku1PGBmi9jOlmwcrfktCuxdytKMf
 khjTQYrAO3rPIl6YiCFovGD6NXDaAyvh2aOIn8yjHmFv2Tup8nLQkFKSMvjhk0n+Dr
 9B5+5B00zehIIc2CDis9ebxbp5XTKI7w9kRYD1qi0XiOAKjh4FQl7T7nwMqKZE23PC
 q+2UDwsVpUm66QyrCeFsPDf0KMbenAg6kUdCnAHODFaa7sedqpSTca05xdMehRRafc
 PAZfVdAaGpDKg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/imagination: Fix user array stride in
 pvr_set_uobj_array()
To: shuvampandey1@gmail.com
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <178155996993.4848.8618351576278880213@gmail.com>
References: <178155996993.4848.8618351576278880213@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 21:56:54 +0000
Message-Id: <20260615215655.12DFF1F000E9@smtp.kernel.org>
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
- [High] Unbounded unaccounted memory allocations in job submission paths b=
ased on user-controlled counts.
--

commit 6abaeaa93e812673bb771d67a15b960baf454dc7
Author: shuvampandey1@gmail.com <shuvampandey1@gmail.com>

drm/imagination: Fix user array stride in pvr_set_uobj_array()

This commit corrects the pointer arithmetic and padding clearing in
pvr_set_uobj_array to ensure correct element copies. It advances the
userspace pointer by the stride and the kernel pointer by the object size.

Cc: stable@vger.kernel.org # v6.8+

> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imag=
ination/pvr_drv.c
> index b20c462bcba0b..58e24f133bec7 100644
> --- a/drivers/gpu/drm/imagination/pvr_drv.c
> +++ b/drivers/gpu/drm/imagination/pvr_drv.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing this subsystem I noticed a
potential problem with unbounded allocations in the job submission paths.

In drivers/gpu/drm/imagination/pvr_job.c:pvr_submit_jobs():

    err =3D PVR_UOBJ_GET_ARRAY(job_args, &args->jobs);
    ...
    job_data =3D kvmalloc_objs(*job_data, args->jobs.count, GFP_KERNEL | __=
GFP_ZERO);

And similarly in drivers/gpu/drm/imagination/pvr_job.c:pvr_job_data_init():

    err =3D PVR_UOBJ_GET_ARRAY(job_data_out[i].sync_ops, &job_args[i].sync_=
ops);

Since args->jobs.count and sync_ops.count come directly from userspace, can=
 a
malicious local user with access to the DRM render node issue a submit jobs
ioctl with an arbitrarily large count?

Because these allocations use GFP_KERNEL without the __GFP_ACCOUNT flag,
__GFP_NORETRY, or an upper bound validation, could a massive allocation
request bypass memory cgroup limits and trigger the global OOM killer,
leading to a system-wide denial of service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178155996993.4848.8=
618351576278880213@gmail.com?part=3D1
