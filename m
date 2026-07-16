Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F358C44512
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0B5B10F342;
	Thu, 16 Jul 2026 15:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P9eeDUpQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3588D10F342
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 15:28:43 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B57860A61;
 Thu, 16 Jul 2026 15:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67751F000E9;
 Thu, 16 Jul 2026 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784215722;
 bh=4SJ8A/ZAHXD1/KUP7D+pzc3/xISgnZTZawjks3y+B3o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P9eeDUpQBAxV/zRCj1Cmn7pO7l0kKqurFLtbuUls7guXulv6Qd/R+PY2u+GrKnAEZ
 fKN5QYP0wJXJa2TppM/ihwK29Ix9UuB8OZ0SO64vLdifKvdTci8c8YKIYWsf5QHW6m
 FttH+am1xZGtahvRIHb8fHOJFENmyBgHfepAWr3ZuNWLWK4aYXNMm0EHIMDSCrEuEY
 Jslt5t9LM82amic72clWIaKYHVb299bMv3mXOSiiCDEhyRnmEyxww3Ho4FQyW2ubsY
 tUAdPTnZFmEmf7ZFeXZHVjXtuu3ioUyhFDVbQ3iJKiIVgS8xI+IkBCkHHivWc1eAeL
 dFetTlY0+aOtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1] accel/amdxdna: Fix use-after-free of mm_struct in
 job scheduler
To: "Lizhi Hou" <lizhi.hou@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716151305.1595780-1-lizhi.hou@amd.com>
References: <20260716151305.1595780-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:28:38 +0000
Message-Id: <20260716152839.A67751F000E9@smtp.kernel.org>
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
- [Critical] Job scheduler tracks current->mm instead of client->mm, enabli=
ng cross-process DMA vulnerabilities when file descriptors are shared.
--

--- Patch [1]: [PATCH V1] accel/amdxdna: Fix use-after-free of mm_struct in=
 job scheduler ---
commit 97cf038e79109413737ecf07de35445a6294ab64
Author: Lizhi Hou <lizhi.hou@amd.com>

accel/amdxdna: Fix use-after-free of mm_struct in job scheduler

This commit fixes a use-after-free of mm_struct in the job scheduler by
calling mmgrab to hold a structural reference for the lifetime of the job,
paired with mmdrop in cleanup paths.

> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/=
amdxdna_ctx.c
> index 855da8c79a1cd..ea560025ae79f 100644
> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
[ ... ]
> @@ -598,6 +599,7 @@ int amdxdna_cmd_submit(struct amdxdna_client *client,
> =20
>  	job->hwctx =3D hwctx;
>  	job->mm =3D current->mm;
> +	mmgrab(job->mm);

[Severity: Critical]
This is a pre-existing issue and was not introduced by the patch under revi=
ew,
but should this use client->mm instead of current->mm?

If the file descriptor is shared across processes (for example, via fork),
using current->mm binds the hardware job liveness check to the ioctl caller
rather than the PASID owner.

Could this lead to cross-process DMA if Process A opens the device, binds
IOMMU SVA to its mm (allocating PASID X), forks Process B, and then exits?
The IOMMU would free PASID X, which could be reallocated to a new Process C.

If Process B then calls the submit ioctl, amdxdna_cmd_submit() assigns
Process B's mm to job->mm. Since Process B is still alive, the liveness che=
ck
in aie2_sched_job_run() would pass, and the hardware might access Process C=
's
memory under Process B's control using the recycled PASID.

> =20
>  	job->fence =3D amdxdna_fence_create(hwctx);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716151305.1595=
780-1-lizhi.hou@amd.com?part=3D1
