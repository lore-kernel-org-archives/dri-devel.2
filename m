Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59ABDC5B56A
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:30:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1446710E932;
	Mon, 10 Aug 2026 16:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dajWCyaK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C5910E1EF
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:30:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A034C43222;
 Mon, 10 Aug 2026 16:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5F01F000E9;
 Mon, 10 Aug 2026 16:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786379402;
 bh=XPP//AGyV4M3GkmszSuKx5FMxFP4bL+DNUDYzMBNOOE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dajWCyaKaTYjbHAiuZNWW7zoCcaBG5TAEInXCUgk+QvTQmot9R+/IJXOAEZDwgVXe
 YidBIpJnzSq2o9TBEtiGs6QoVBUmA+6K8ggzaep3N2bD0mqcmzFh4Zk5UWygQCQrVY
 ADp8abFzUkttMnNPdCjS2rJdIYLxbLIn7dHH6F08afYqTf7fBNBlLQ0GAl4zb++1SB
 lvzxvEMgfyxnJGs1apj6w+D+QpNs7541sNg/dLhRmUor3mB4sV9h+WQFfjUt9AW5/8
 KzqjxCDuO8lFUfHcQ3liXorSfTQsk0vMwm1R7RESrG0dFE3+Gr9/ZHF1D4o37FJNCc
 bnx9XCsZLiJrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/5] drm/amdgpu: free userptr HMM ranges on the CS error
 path
To: "Junrui Luo" <moonafterrain@outlook.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260811-amdgpu-fixes-v1-5-4954a417b8ff@outlook.com>
References: <20260811-amdgpu-fixes-v1-0-4954a417b8ff@outlook.com>
 <20260811-amdgpu-fixes-v1-5-4954a417b8ff@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 16:30:01 +0000
Message-Id: <20260810163002.4F5F01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Data Race / Use-After-Free due to shared amdgpu_bo_list_entry
- [High] DRM scheduler API contract violation: aborting job after drm_sched=
_job_arm()
--

--- Patch [5]: [PATCH 5/5] drm/amdgpu: free userptr HMM ranges on the CS er=
ror path ---
commit c42f00dbd4932bbfbbb760f3bcc81040f9afbef4
Author: Junrui Luo <moonafterrain@outlook.com>

drm/amdgpu: free userptr HMM ranges on the CS error path

This commit fixes a memory leak in the amdgpu_cs ioctl error path by
releasing userptr HMM ranges in amdgpu_cs_parser_fini(). Previously, these
ranges were only freed on success or specific error paths, leading to leaks
when errors occurred between allocation and the release loop in
amdgpu_cs_submit().

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_cs.c
> index 617f53f135f35..17c4fec214028 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1416,6 +1416,16 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs=
_parser *parser)
>  				amdgpu_vm_bo_invalidate(bo, false);
>  			}
>  		}
> +
> +		/*
> +		 * Release the ranges still live on the error paths;
> +		 * amdgpu_cs_submit() already freed and cleared them when it
> +		 * got far enough to check them for invalidation.
> +		 */
> +		amdgpu_bo_list_for_each_userptr_entry(e, parser->bo_list) {
> +			amdgpu_hmm_range_free(e->range);
> +			e->range =3D NULL;

[Severity: Critical]
This is a pre-existing issue, but does lockless modification of the shared
bo_list_entry introduce a data race or use-after-free here?

If userspace creates a BO list, obtains a handle, and invokes multiple
concurrent amdgpu_cs ioctls using the same BO list handle, the amdgpu_bo_li=
st
objects are reference-counted and shared across those ioctls.

If one thread fails during the ioctl and reaches this newly modified
amdgpu_cs_parser_fini(), could it free e->range while another thread is
concurrently allocating or using it in amdgpu_cs_parser_bos()?

Thread 1:
amdgpu_cs_parser_bos() {
    ...
    e->range =3D amdgpu_hmm_range_alloc(NULL);
    ...
}

Thread 2 (on an error path):
amdgpu_cs_parser_fini() {
    ...
    amdgpu_bo_list_for_each_userptr_entry(e, parser->bo_list) {
        amdgpu_hmm_range_free(e->range);
        e->range =3D NULL;
    }
}

> +		}
>  		amdgpu_bo_list_put(parser->bo_list);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but does amdgpu_cs_submit() viol=
ate
the DRM scheduler API contract by aborting jobs after they are armed?

Looking at amdgpu_cs_submit(), it arms jobs but can return an error before
pushing them:

amdgpu_cs_submit() {
    ...
    for (i =3D 0; i < p->gang_size; ++i)
        drm_sched_job_arm(&p->jobs[i]->base);
    ...
    if (r || !list_empty(&vm->individual.needs_update)) {
        r =3D -EAGAIN;
        mutex_unlock(&p->adev->notifier_lock);
        return r;
    }
    ...
}

If the function returns an error (e.g., if drm_sched_job_add_dependency() f=
ails
or !list_empty(&vm->individual.needs_update) is true), the armed job is
aborted via drm_sched_job_cleanup() instead of being submitted.

Does calling drm_sched_job_cleanup() after drm_sched_job_arm() leave sequen=
ce
gaps on the scheduler entity timeline, potentially causing permanent GPU ha=
ngs
for subsequent jobs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811-amdgpu-fix=
es-v1-0-4954a417b8ff@outlook.com?part=3D5
