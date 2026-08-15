Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D00C5AD5A
	for <dri-devel@archiver.kernel.org>; Sat, 15 Aug 2026 15:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E35110E0EB;
	Sat, 15 Aug 2026 15:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GMMflgaG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 935B910E0EB
 for <dri-devel@lists.freedesktop.org>; Sat, 15 Aug 2026 15:13:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 935B0600E2;
 Sat, 15 Aug 2026 15:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7121F000E9;
 Sat, 15 Aug 2026 15:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786806790;
 bh=v7MYdyDCN+KPf28CdavPmqQFk2vI8qKfLy4l5J8K2DM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GMMflgaGY5HFDSvmeOWiQja5yydXYkKuCvPfWmko+ZVIfTNe0KN3LxHLMRxxOFsEx
 l9qK3v3UK+hfKaER0h5qovRxN4hY4ld4WjuCFGht8REymkUJjinTDp0H5QVFxZ4j74
 BXpKQkdqtGbjaW7aqII4eV3+XwqHikd/dUSbMwCbQWhBufFwu++6p6Ic3A/N/pevs6
 eYabe+2lRmbqtfrelVoF0kMll5xt0uPQe/z44meqEqMt/RM8FpdMjI6wiN4eqruOm8
 EKKcrri8PHUBA9+NC8K+U+qWljWWrB1DIET2gNRG+4SDDWmbmcIm0Ev8weyqSVc5oe
 ZQCiTxPD5AYRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cleanup
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260815145914.84154-1-kmehltretter@gmail.com>
References: <20260815145914.84154-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 15 Aug 2026 15:13:09 +0000
Message-Id: <20260815151310.1F7121F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Logical Use-After-Free/Double-Free introduced by attempting to man=
ually free a job already tracked in the global submit array.
- [Low] The patch introduces calls to an undefined function `v3d_job_deallo=
cate()`, which will cause a build failure.

Pre-existing issues:
- [Critical] Pre-existing double-free vulnerability in the extension parsin=
g error paths for CPU jobs.
--

--- Patch [1]: [PATCH] drm/v3d: Fix NULL pointer dereference in CPU job cle=
anup ---
commit f37328e13f9e40584da544c634e4094ecc1b59ee
Author: Karl Mehltretter <kmehltretter@gmail.com>

drm/v3d: Fix NULL pointer dereference in CPU job cleanup

This commit attempts to fix a NULL pointer dereference in CPU job cleanup
by manually deallocating the job and clearing the pointer when extension
parsing or BO count validation fails. It aims to match the error handling
present when v3d_job_init() fails.

> diff --git a/drivers/gpu/drm/v3d/v3d_submit.c b/drivers/gpu/drm/v3d/v3d_s=
ubmit.c
> index 834d52030979d..8cabb3ba77898 100644
> --- a/drivers/gpu/drm/v3d/v3d_submit.c
> +++ b/drivers/gpu/drm/v3d/v3d_submit.c
> @@ -1573,6 +1573,7 @@ v3d_submit_cpu_ioctl(struct drm_device *dev, void *=
data,
>  		ret =3D v3d_get_extensions(file_priv, args->extensions, &se, cpu_job);
>  		if (ret) {
>  			drm_dbg(dev, "Failed to get extensions.\n");
> +			v3d_job_deallocate((void *)&cpu_job);

[Severity: Low]
Does this code break the build? It appears v3d_job_deallocate() is not
defined or declared anywhere in the kernel tree.


[Severity: High]
If v3d_job_deallocate() were defined and freed the job, would this cause a
double-free?

The cpu_job was already added to the global submit array earlier in
v3d_submit_cpu_ioctl() via:

    cpu_job =3D (struct v3d_cpu_job *)v3d_submit_add_job(&submit, V3D_CPU);

When this code jumps to the fail label, it executes v3d_submit_cleanup_jobs=
(),
which iterates over the submit.jobs array and calls v3d_job_cleanup() on
the pointer. If the job was already manually freed here, would
v3d_submit_cleanup_jobs() dereference a dangling pointer?


[Severity: Critical]
This is a pre-existing issue, but does v3d_get_extensions() leave a
dangling pointer that gets double-freed on this error path?

If a user provides an invalid sync handle,=20
v3d_get_cpu_timestamp_query_params() fails and calls=20
v3d_timestamp_query_info_free():

drivers/gpu/drm/v3d/v3d_sched.c:v3d_timestamp_query_info_free() {
    ...
    kvfree(query_info->queries);
    ...
}

The queries array is freed but the pointer is not set to NULL. The error
bubbles up here, and the code jumps to the fail label.

The fail path calls v3d_submit_cleanup_jobs(), which calls v3d_cpu_job_free=
()
on the same job, and that unconditionally calls
v3d_timestamp_query_info_free() again:

drivers/gpu/drm/v3d/v3d_submit.c:v3d_cpu_job_free() {
    ...
    v3d_timestamp_query_info_free(&job->timestamp_query,
                                  job->timestamp_query.count);
    ...
}

Will this result in a double-free of query_info->queries?

>  			goto fail;
>  		}
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260815145914.8415=
4-1-kmehltretter@gmail.com?part=3D1
