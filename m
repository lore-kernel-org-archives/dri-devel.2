Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094A9C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 16:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31EF810E248;
	Mon, 31 Aug 2026 16:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eG/8CpB0";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5594B10E248
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:54:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 08A6341831
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 16:54:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB5091F00A3D;
 Mon, 31 Aug 2026 16:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788195280;
 bh=0LLhpWCxBpPg1D5mTW6OFIbv9Qj2mRsv00bLjDLuWHc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eG/8CpB0JymVjT5RhYFri2584CA3/xHsmsyjQjq8/8GgExk2RIR1q7ZHKTAR4IO03
 71b2ogVhFEr4mMTj9YaFatEcXIjTCY4+CLUmp9XMFFowkDGnnyK4YI6nH66IcBU8ba
 bzqrZtYwukTep9XzrjUUJXesSWhtXIznuvhH+xppdOiH/M0tLY7DHypQcxL5aprKTW
 jRycnxqeSqG7Zb8I7yjeeOI8VPsIojObQ7Kw9JZF850rVMbVx3thb2soVwEBb5uojX
 aeq/JfzB79Ho/S6pSkfA83MNb3PoQBjszZCEeGnNFPPicWE4QMh8qJdZONdgcdDquC
 hJqG38aDCe+Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amdkfd: fix SMI event cross-process
 information leak
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-514-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-514-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 16:54:40 +0000
Message-Id: <20260831165440.CB5091F00A3D@smtp.kernel.org>
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
- [High] Kernel panic due to NULL pointer dereferences in amdgpu_vm_get_tas=
k_info_vm() and amdgpu_vm_fini() when vm->task_info allocation fails.
- [High] Potential Use-After-Free of amdgpu_vm in amdgpu_vm_get_task_info_p=
asid.
--

commit ac56a0fa84d860ce75aeb92f4bc1e57cf68cb0d2
Author: Yongqiang Sun <Yongqiang.Sun@amd.com>

drm/amdkfd: fix SMI event cross-process information leak

This commit fixes a cross-process information leak by passing the target
process PID into kfd_smi_event_add() for system-wide events. This ensures
that the existing per-client filter properly restricts delivery to the
owning process instead of bypassing the filter with a PID of 0.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_smi_events.c
> index a499449fcb068..d6e737ab10076 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -254,8 +254,10 @@ void kfd_smi_event_update_vmfault(struct kfd_node *d=
ev, uint16_t pasid)
>  	if (task_info) {

[Severity: High]
This isn't a regression introduced by this patch, but can the retrieval of
task_info just above this line lead to a Use-After-Free of the amdgpu_vm
pointer?

In the call to amdgpu_vm_get_task_info_pasid(), it retrieves the vm pointer
from the pasids xarray and immediately drops the lock before passing the ba=
re
pointer to amdgpu_vm_get_task_info_vm():

amdgpu_vm_get_task_info_pasid() {
    ...
    return amdgpu_vm_get_task_info_vm(
                amdgpu_vm_get_vm_from_pasid(adev, pasid));
}

If the owning process concurrently exits and amdgpu_vm_fini() is called,
the vm could be freed between dropping the xarray lock and dereferencing
the pointer in amdgpu_vm_get_task_info_vm(). This could be triggered via
concurrent VM fault interrupts and process teardown.

>  		/* Report VM faults from user applications, not retry from kernel */
>  		if (task_info->task.pid)
> -			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, KFD_EVENT_FMT_VMFAUL=
T(
> -					  task_info->task.pid, task_info->task.comm));
> +			kfd_smi_event_add(task_info->tgid, dev,
> +					  KFD_SMI_EVENT_VMFAULT,
> +					  KFD_EVENT_FMT_VMFAULT(task_info->task.pid,
> +								task_info->task.comm));
>  		amdgpu_vm_put_task_info(task_info);
>  	}
>  }

[ ... ]

> @@ -356,7 +358,7 @@ void kfd_smi_event_process(struct kfd_process_device =
*pdd, bool start)
>  	task_info =3D amdgpu_vm_get_task_info_vm(avm);

[Severity: High]
This is a pre-existing regression, but can this call result in a kernel pan=
ic
due to a NULL pointer dereference?

Looking at amdgpu_vm_get_task_info_vm(), it checks if the vm pointer is val=
id
but unconditionally accesses vm->task_info:

amdgpu_vm_get_task_info_vm() {
    ...
    if (vm) {
        ti =3D vm->task_info;
        kref_get(&vm->task_info->refcount);
    }
    return ti;
}

If the memory allocation fails during initialization in amdgpu_vm_init(), t=
he
error is logged but execution continues:

amdgpu_vm_init() {
    ...
    r =3D amdgpu_vm_create_task_info(vm);
    if (r)
        dev_dbg(adev->dev, "Failed to create task info for VM\n");
    ...
}

This leaves the vm->task_info pointer as NULL, which will cause a crash when
kref_get() is called here.

Additionally, this missing NULL check can cause another dereference during
VM destruction in amdgpu_vm_fini() when formatting the warning message:

amdgpu_vm_fini() {
    ...
    dev_warn(adev->dev,
             "VM memory stats for proc %s(%d) task %s(%d) is non-zero when =
fini\n",
             ti->process_name, ti->task.pid, ti->task.comm, ti->tgid);
    ...
}

> =20
>  	if (task_info) {
> -		kfd_smi_event_add(0, pdd->dev,
> +		kfd_smi_event_add(task_info->tgid, pdd->dev,
>  				  start ? KFD_SMI_EVENT_PROCESS_START :
>  				  KFD_SMI_EVENT_PROCESS_END,
>  				  KFD_EVENT_FMT_PROCESS(task_info->task.pid,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-514-sashal@kernel.org?part=3D1
