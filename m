Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CF6C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 17:18:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D611010E52A;
	Thu, 13 Aug 2026 17:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kz/gQfAh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E07F10E52A
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 17:18:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0D8BF429E1;
 Thu, 13 Aug 2026 17:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8821F000E9;
 Thu, 13 Aug 2026 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786641535;
 bh=pveqZt7aLkN/MFloqGDPOiLZVVlaAzzfyhZLJcVqMRY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Kz/gQfAhB1Ei+2dMXxpkwtmzPCkKb4mHY1I5mAxcpHlQJnb6bXxl/rr4CZOxr91zZ
 AzS7n6M58hNfOVwztBLCSB1DwjC2t4lhA3Nwh9f3UANKO42VP0NJjr2RE87VLvE2pM
 Y6vtDCN6GH6raWkxi0QbyGJHV/jXSU3wwhWo1oHE46Kzax/jTA/SmX4yjtVPD2S1fD
 zXgMMXSjFx1YbITlWxDKEgmXnEAoz8jkT6tvOlrRXBMrd1V6ApO+9AuQE5PLIrvZZJ
 CUWEvFX4lwc9mwezaQscjakT50k3DxgoDuA23QQAY2IHeMJpgQd1rtGX6eQLvxa87I
 fyboXEMtIr/GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] drm/amdgpu: honor gpu_recovery_allowed in
 amdgpu_job_timedout
To: "Pierre-Eric Pelloux-Prayer" <pierre-eric.pelloux-prayer@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813170705.15745-2-pierre-eric.pelloux-prayer@amd.com>
References: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
 <20260813170705.15745-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 17:18:55 +0000
Message-Id: <20260813171855.BA8821F000E9@smtp.kernel.org>
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
- [High] Concurrent GPU ring timeouts cause list corruption due to unprotec=
ted modification of `adev->reset_list`.
--

--- Patch [2]: [PATCH v2 2/5] drm/amdgpu: honor gpu_recovery_allowed in amd=
gpu_job_timedout ---
commit 2bc1f829e1f5f1741410cfa00dfab26ce6099f90
Author: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

drm/amdgpu: honor gpu_recovery_allowed in amdgpu_job_timedout

This commit introduces a single can_reset variable in amdgpu_job_timedout
that takes both the global module parameter and the per-device
gpu_recovery_allowed flag into account. It uses this new variable to gate
the soft-recovery, per-ring-reset, and IP-block-reset attempts.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index d97cf1212e0f9..43511e0419a12 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c

[ ... ]

> @@ -111,7 +112,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>  	if (!amdgpu_sriov_vf(adev))
>  		amdgpu_job_core_dump(adev, job);

[Severity: High]
This is a pre-existing issue, but can this lead to list corruption if
multiple GPU rings timeout concurrently?

When a timeout occurs, the code calls amdgpu_job_core_dump(). If the
device does not have an XGMI hive (hive is NULL), amdgpu_job_core_dump()
links the shared adev->reset_list into a local stack-allocated list:

drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:amdgpu_job_core_dump() {
        ...
        if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes > =
1) && hive) {
                ...
        } else {
                list_add_tail(&adev->reset_list, &device_list);
                device_list_handle =3D &device_list;
        }
        ...
}

Since adev->reset_list is shared, if an untrusted userspace application
submits hanging shaders on two different rings concurrently, wouldn't both
threads race to modify adev->reset_list without any lock protection?=20

This looks like it could lead to wild pointer dereferences during list=20
iteration or when exiting the stack frame on concurrent executions of
amdgpu_job_timedout() for the same adev.

> -	if (amdgpu_gpu_recovery &&
> +	if (can_reset &&
>  	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RE=
COVERY) &&
>  	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent))=
 {
>  		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813170705.1574=
5-1-pierre-eric.pelloux-prayer@amd.com?part=3D2
