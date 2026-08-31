Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3472FC624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 17:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71EEA10E0E6;
	Mon, 31 Aug 2026 17:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OXvG9KqA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1617C10E0E6
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:38:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D753601FB
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 17:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA78B1F000E9;
 Mon, 31 Aug 2026 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788197888;
 bh=9Nqw6nVCXxNU1MQtviEyKzf0GjrR39KHpyk0NEx8Jpg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OXvG9KqA067qwLoBJBT8L0gLY9C6IBVINEHbCX6lGqEyLHyzonpCDhCvYJn/MBKXF
 SE7VLIeJWtrZUDztsVPss02wDZOFAXWCnBY74SBrOfQjR8jiXZePFIzOj9Z/L6eoN5
 IJdTzucNk7XjdqDEZlwtUuLAOj7h05fBPtFqipuwzltrXIvxGroITJtie5axzy28l6
 e8lQbmLEBjMWsbnY0ZkkP03l+/FlSsQmJFMfvHF3SmO32L8QS1/DiHJ6a/ueK0Rwd0
 L7/auKrFCFAgCBLo+hpw+plKGSgsLZugqx0kb9TJ8zyyIRAfr9P1bMkIZwi89X13fq
 d+avBQamnt7vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] drm/amdkfd: Check bounds on
 allocate_doorbell
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-635-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-635-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 17:38:08 +0000
Message-Id: <20260831173808.BA78B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing bounds check on user-supplied `restore_sdma_id` during CRI=
U restore causes out-of-bounds bit operations on `sdma_bitmap` and `xgmi_sd=
ma_bitmap`.
- [High] Missing bounds check on restore_id causes out-of-bounds array acce=
ss to page_slots array during CRIU event restore.
- [High] Memory leak of gang_ctx_bo and wptr_bo_gart when queue creation fa=
ils.
- [Medium] User-triggerable WARN(1) by supplying an invalid queue type duri=
ng CRIU restore.
--

commit 075dbb15b0e52c82ca15eafa0439de9c1173bea4
Author: David Francis <David.Francis@amd.com>

drm/amdkfd: Check bounds on allocate_doorbell
   =20
allocated_doorbell has an option to set the doorbell id
to a specific value (used by CRIU). This value was not
bounds checked.
   =20
Check to confirm it's less than KFD_MAX_NUM_OF_QUEUES_PER_PROCESS.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6e7bc983fc0b6..394ed3d3ce26a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -472,6 +472,9 @@ static int allocate_doorbell(struct qcm_process_devic=
e *qpd,
>  	} else {
>  		/* For CP queues on SOC15 */
>  		if (restore_id) {
> +			if (*restore_id >=3D KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
> +				return -EINVAL;
> +
>  			/* make sure that ID is free  */
>  			if (__test_and_set_bit(*restore_id, qpd->doorbell_bitmap))
>  				return -EINVAL;

[Severity: High]
This isn't a bug introduced by this patch, but does the same missing bounds=
=20
check issue exist in allocate_sdma_queue() for restore_sdma_id?

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:allocate_sdma_queue()=
 {
    ...
    if (restore_sdma_id) {
        /* Re-use existing sdma_id */
        if (!test_bit(*restore_sdma_id, dqm->sdma_bitmap)) {
            dev_err(dev, "SDMA queue already in use\n");
            return -EBUSY;
        }
        clear_bit(*restore_sdma_id, dqm->sdma_bitmap);
    ...
}

And also further down in the same function for the xgmi_sdma_bitmap?

drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c:allocate_sdma_queue()=
 {
    ...
    if (restore_sdma_id) {
        /* Re-use existing sdma_id */
        if (!test_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap)) {
            dev_err(dev, "SDMA queue already in use\n");
            return -EBUSY;
        }
        clear_bit(*restore_sdma_id, dqm->xgmi_sdma_bitmap);
    ...
}

Since restore_sdma_id is provided by userspace during a CRIU restore via=20
kfd_criu_restore_queue()->pqm_create_queue()->create_queue_cpsch(), can an=
=20
out-of-bounds ID cause out-of-bounds memory read and write operations on th=
e=20
statically sized sdma_bitmap arrays?


[Severity: High]
This is a pre-existing issue, but is there a similar missing bounds check=20
for restore_id during CRIU event restore?

drivers/gpu/drm/amd/amdkfd/kfd_events.c:allocate_event_notification_slot() {
    ...
    if (restore_id) {
        id =3D idr_alloc(&p->event_idr, ev, *restore_id, *restore_id + 1,
                       GFP_KERNEL);
    }
    ...
    ev->event_id =3D id;
    page_slots(p->signal_page)[id] =3D UNSIGNALED_EVENT_SLOT;
    ...
}

During CRIU restore, kfd_criu_restore_event() passes the userspace-supplied=
=20
restore_id to create_signal_event()->allocate_event_notification_slot().=20
If restore_id is >=3D KFD_SIGNAL_EVENT_LIMIT, will this cause an out-of-bou=
nds=20
write to the page_slots array?


[Severity: High]
This is a pre-existing issue, but does this code leak the gang_ctx_bo and=20
wptr_bo_gart when queue creation fails?

drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c:init_user_queue() {
    ...
    retval =3D amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
                                         AMDGPU_MES_GANG_CTX_SIZE,
                                         &(*q)->gang_ctx_bo,
                                         &(*q)->gang_ctx_gpu_addr,
                                         &(*q)->gang_ctx_cpu_ptr,
                                         false);
    ...
}

If dev->dqm->ops.create_queue() subsequently fails (for example, due to an=
=20
invalid doorbell ID being rejected by your new bounds check), we jump to th=
e=20
err_create_queue path:

drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c:pqm_create_queue() {
    ...
err_create_queue:
    uninit_queue(q);
    if (kq)
        kernel_queue_uninit(kq);
    kfree(pqn);
    ...
}

Because pqm_clean_queue_resource() is not called here, will this result in =
a=20
permanent leak of the MES GPU memory allocations? A privileged user could=20
potentially trigger this path repeatedly by passing invalid doorbell IDs=20
during CRIU restore.


[Severity: Medium]
This is a pre-existing issue, but can a user trigger a kernel WARN by=20
supplying an invalid queue type during CRIU restore?

drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c:pqm_create_queue() {
    ...
    switch (type) {
    ...
    default:
        WARN(1, "Invalid queue type %d", type);
        retval =3D -EINVAL;
    }
    ...
}

Since kfd_criu_restore_queue() copies the queue type from the userspace=20
q_data, could a malicious checkpoint file hit this WARN(1)? If a system=20
runs with panic_on_warn enabled, could this translate into a denial of=20
service?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-635-sashal@kernel.org?part=3D1
