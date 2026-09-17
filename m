Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AB6C982D0
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 21:36:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049EC10ECCD;
	Thu, 17 Sep 2026 21:36:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="B5U8CmOo";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A257910ECCD
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789680962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I87HRKxUjbLtk6rWRYvy4vS0t0WCg7MM2j1+qGT2I8o=;
 b=B5U8CmOoQduaUQfX3vgIdxVn0Fui0Q7hkAKlG3Lj6RNfYQXdu+Ah3NnEa5lk97sCAVIXuV
 1I5OkuGd+MiSEcylmcNA+VMXUf8uOMks2C7/4km6jGIDTcZ74q6loL5YUknFSd/ICQQcr8
 vlZ52yGUTxhRjPV1Kt7jWb2ZQjl+2rk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-NgIYc-OyOIy1QPruailYyw-1; Thu, 17 Sep 2026 17:36:01 -0400
X-MC-Unique: NgIYc-OyOIy1QPruailYyw-1
X-Mimecast-MFC-AGG-ID: NgIYc-OyOIy1QPruailYyw_1789680961
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-90ce8ad8002so3021366d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 14:36:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789680960; x=1790285760;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GPQYwNrXtzx5wg61th1A6MtnGzGLpKWbnnt0jGgdHkE=;
 b=dx36NRpL5VzP0mds+or/pPkLdRQj5H9PhnGVgl7dW1thb6fUTyYvW/RNGL9sCz0p5F
 L4k8IEGu2mxS6o2Z3SM9vPUhV3phEu2UK9ilfvwDD9HiJ3hVofqFzV9AOX5mcE2EMvR5
 jQaS2EwQfgUZHpkMdQQ4LEPwLoqKCPp8i27oVWgITWvED3uApl2xiyBMWndOx8NrFomi
 gbLrf4RvC5748riCFeN7yEF8oK02bQFm5y0W1I4zKryesWtZmxqvfScxtLsKZDoLAxAy
 yBe8CfH11L54+SukYK+xP926d+FK7dGbMLVAqGRkdM2LtG4rX33fA27TZ55Xuih8CU+T
 bkGQ==
X-Gm-Message-State: AFuF++n7wTyIF3kME2GtJFr6n6So1gge52fNXjYAUBulVRQDJqupUBh1
 NQEzEzhiECitGINJ1EsbO+vMfS9IGV6wIJO4ZRPLHwb0Gk/cd/6c1bDVpMLQGp4sx2QA9JxXy2h
 Q5jhTvI4Dw2jooxATbHA8Iia108dcDPeLohG6VZLIxuOirCFEe7ijAR2qeZ62XCHArX9fMw==
X-Gm-Gg: AYBFou2VIWT/835jUYdoxX6lrBEVYpGkaeC5GqqF235rLkwGNoboHWOhxSPdBzDEnCA
 jUHWA+YKxNCawC1f3/4APzbcCWlUYtivLxN1/q98dHy7VsXw9ynKfzgYkCtRWR8w2BYnRhWjRM9
 2azvs8ncOXLMr/xcgJfVuRS6LDCu8I7FMTq6ugQNBiZsfLo3rKstPOgLv7xYnZTFXhdyeU/vYok
 P1jIk47fCIBy9v9vdDqgXRLfpl8n3DFsR3fQdLQIahgxDMVytVaiT4ChEGDwLfZpms8vRnmVUa0
 Wsg4cxvfvaDKdwn8glLqAIgr5OG7U7wqv82gJG+9udI79DD1umUv9OdmWIyvMuS5E6WfASQY
X-Received: by 2002:a0c:fa46:0:b0:912:428a:8bb2 with SMTP id
 6a1803df08f44-91254b57120mr8659286d6.19.1789680960575; 
 Thu, 17 Sep 2026 14:36:00 -0700 (PDT)
X-Received: by 2002:a0c:fa46:0:b0:912:428a:8bb2 with SMTP id
 6a1803df08f44-91254b57120mr8659126d6.19.1789680960046; 
 Thu, 17 Sep 2026 14:36:00 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91252cd9fc8sm7298096d6.38.2026.09.17.14.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 14:35:59 -0700 (PDT)
Message-ID: <c0c9f4af21a0918f1198cc929820c01c1190f5b6.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/uvmm: fix UAF in nouveau_uvmm_sm when BO is
 in TTM_PL_SYSTEM
From: lyude@redhat.com
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, airlied@redhat.com
Date: Thu, 17 Sep 2026 17:35:57 -0400
In-Reply-To: <0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn>
References: <0D77BEC410CE0129+20260907052204.1431488-1-peiyang_he@smail.nju.edu.cn>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XFyewSfz4fP9U1j73n-NPYOewVzlOur29Tg75gSAAYY_1789680961
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Reviewed-by: Lyude Paul <lyude@redhat.com>

Will push to drm-misc-fixes in just a moment

On Mon, 2026-09-07 at 13:22 +0800, Peiyang He wrote:
> nouveau_uvmm_sm() calls op_map(), which passes bo->resource through
> nouveau_mem() to nouveau_uvma_map(). nouveau_uvmm_vmm_map() then
> reads
> mem->mem.type.
>=20
> But this is only valid when bo->resource is backed by struct
> nouveau_mem,
> as is the case for VRAM and TT resources. If the BO is left in
> TTM_PL_SYSTEM, bo->resource is only a struct ttm_resource. Treating
> it
> as struct nouveau_mem makes the mem->mem.type read past the end of
> the
> resource, causing a KASAN: slab-use-after-free Read in
> nouveau_uvmm_sm
> report:
>=20
> BUG: KASAN: slab-use-after-free in nouveau_uvmm_vmm_map
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:152 [inline]
> BUG: KASAN: slab-use-after-free in nouveau_uvma_map
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:199 [inline]
> BUG: KASAN: slab-use-after-free in op_map
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:849 [inline]
> BUG: KASAN: slab-use-after-free in
> nouveau_uvmm_sm.constprop.0+0x6ab/0x900
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:903
> Read of size 1 at addr ffff888127d3e3a0 by task kworker/0:1/11
>=20
> CPU: 0 UID: 0 PID: 11 Comm: kworker/0:1 Not tainted 7.2.0 #5
> PREEMPT(lazy)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-
> debian-1.16.3-2 04/01/2014
> Workqueue: nouveau_sched_wq_2224 drm_sched_run_job_work
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__dump_stack lib/dump_stack.c:94 [inline]
> =C2=A0dump_stack_lvl+0x95/0xe0 lib/dump_stack.c:120
> =C2=A0print_address_description mm/kasan/report.c:378 [inline]
> =C2=A0print_report+0xcb/0x5a0 mm/kasan/report.c:482
> =C2=A0kasan_report+0xca/0x100 mm/kasan/report.c:595
> =C2=A0nouveau_uvmm_vmm_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:152
> [inline]
> =C2=A0nouveau_uvma_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:199 [inline=
]
> =C2=A0op_map drivers/gpu/drm/nouveau/nouveau_uvmm.c:849 [inline]
> =C2=A0nouveau_uvmm_sm.constprop.0+0x6ab/0x900
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:903
> =C2=A0nouveau_uvmm_sm_unmap drivers/gpu/drm/nouveau/nouveau_uvmm.c:932
> [inline]
> =C2=A0nouveau_uvmm_bind_job_run+0xd6/0x250
> drivers/gpu/drm/nouveau/nouveau_uvmm.c:1532
> =C2=A0nouveau_job_run drivers/gpu/drm/nouveau/nouveau_sched.c:350 [inline=
]
> =C2=A0nouveau_sched_run_job+0x62/0xd0
> drivers/gpu/drm/nouveau/nouveau_sched.c:364
> =C2=A0drm_sched_run_job_work+0x356/0xa10
> drivers/gpu/drm/scheduler/sched_main.c:1061
> =C2=A0process_one_work+0x8a5/0x1900 kernel/workqueue.c:3322
> =C2=A0process_scheduled_works kernel/workqueue.c:3405 [inline]
> =C2=A0worker_thread+0x5dd/0xd80 kernel/workqueue.c:3486
> =C2=A0kthread+0x31d/0x420 kernel/kthread.c:436
> =C2=A0ret_from_fork+0x662/0x940 arch/x86/kernel/process.c:158
> =C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> =C2=A0</TASK>
>=20
> Allocated by task 2224 on cpu 0 at 66.550027s:
> =C2=A0kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
> =C2=A0kasan_save_track+0x17/0x60 mm/kasan/common.c:78
> =C2=A0poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
> =C2=A0__kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
> =C2=A0kasan_kmalloc include/linux/kasan.h:263 [inline]
> =C2=A0__do_kmalloc_node mm/slub.c:5334 [inline]
> =C2=A0__kmalloc_noprof+0x304/0x7c0 mm/slub.c:5359
> =C2=A0_kmalloc_noprof include/linux/slab.h:992 [inline]
> =C2=A0dma_resv_list_alloc+0x27/0x90 drivers/dma-buf/dma-resv.c:106
> =C2=A0dma_resv_reserve_fences+0x60e/0xa30 drivers/dma-buf/dma-resv.c:205
> =C2=A0ttm_bo_alloc_resource+0x12c/0xbd0 drivers/gpu/drm/ttm/ttm_bo.c:721
> =C2=A0ttm_bo_validate+0x1bc/0x4a0 drivers/gpu/drm/ttm/ttm_bo.c:856
> =C2=A0ttm_bo_init_reserved+0x2c3/0x570 drivers/gpu/drm/ttm/ttm_bo.c:970
> =C2=A0nouveau_bo_init+0x159/0x2c0 drivers/gpu/drm/nouveau/nouveau_bo.c:35=
9
> =C2=A0nouveau_gem_new+0x234/0x5f0
> drivers/gpu/drm/nouveau/nouveau_gem.c:272
> =C2=A0nouveau_gem_ioctl_new+0x1eb/0x420
> drivers/gpu/drm/nouveau/nouveau_gem.c:352
> =C2=A0drm_ioctl_kernel+0x192/0x350 drivers/gpu/drm/drm_ioctl.c:817
> =C2=A0drm_ioctl+0x4f8/0xb40 drivers/gpu/drm/drm_ioctl.c:914
> =C2=A0nouveau_drm_ioctl+0xea/0x2c0
> drivers/gpu/drm/nouveau/nouveau_drm.c:1338
> =C2=A0vfs_ioctl fs/ioctl.c:51 [inline]
> =C2=A0__do_sys_ioctl fs/ioctl.c:597 [inline]
> =C2=A0__se_sys_ioctl fs/ioctl.c:583 [inline]
> =C2=A0__x64_sys_ioctl+0x180/0x1d0 fs/ioctl.c:583
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0x115/0x690 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Freed by task 2223 on cpu 0 at 66.554063s:
> =C2=A0kasan_save_stack+0x24/0x50 mm/kasan/common.c:57
> =C2=A0kasan_save_track+0x17/0x60 mm/kasan/common.c:78
> =C2=A0kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
> =C2=A0poison_slab_object mm/kasan/common.c:253 [inline]
> =C2=A0__kasan_slab_free+0x61/0x80 mm/kasan/common.c:285
> =C2=A0kasan_slab_free include/linux/kasan.h:235 [inline]
> =C2=A0slab_free_hook mm/slub.c:2677 [inline]
> =C2=A0__rcu_free_sheaf_prepare+0xb6/0x2e0 mm/slub.c:2928
> =C2=A0rcu_free_sheaf+0x1b/0x120 mm/slub.c:5978
> =C2=A0rcu_do_batch kernel/rcu/tree.c:2645 [inline]
> =C2=A0rcu_core+0x521/0x1490 kernel/rcu/tree.c:2897
> =C2=A0handle_softirqs+0x1b1/0x8a0 kernel/softirq.c:622
> =C2=A0__do_softirq kernel/softirq.c:656 [inline]
> =C2=A0invoke_softirq kernel/softirq.c:496 [inline]
> =C2=A0__irq_exit_rcu+0x137/0x1c0 kernel/softirq.c:735
> =C2=A0irq_exit_rcu+0x9/0x20 kernel/softirq.c:752
> =C2=A0instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062
> [inline]
> =C2=A0sysvec_apic_timer_interrupt+0x70/0x80
> arch/x86/kernel/apic/apic.c:1062
> =C2=A0asm_sysvec_apic_timer_interrupt+0x1a/0x20
> arch/x86/include/asm/idtentry.h:674
>=20
> The buggy address belongs to the object at ffff888127d3e380
> =C2=A0which belongs to the cache kmalloc-96 of size 96
> The buggy address is located 32 bytes inside of
> =C2=A0freed 96-byte region [ffff888127d3e380, ffff888127d3e3e0)
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> pfn:0x127d3e
> flags: 0x200000000000000(node=3D0|zone=3D2)
> page_type: f5(slab)
> raw: 0200000000000000 ffff888100041280 dead000000000122
> 0000000000000000
> raw: 0000000000000000 0000000000200020 00000000f5000000
> 0000000000000000
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
> =C2=A0ffff888127d3e280: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
> =C2=A0ffff888127d3e300: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> > ffff888127d3e380: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0ffff888127d3e400: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> =C2=A0ffff888127d3e480: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
>=20
> Fix by resetting the placement to the BO's valid domains before
> calling nouveau_bo_validate(), matching the handling in
> nouveau_uvmm_bo_validate(), so map jobs do not run for SYSTEM
> resources;
> Reject BO that cannot reside in VRAM or GART;
> Also skip op_map() when the GPUVA has been invalidated, matching the
> handling in the unmap and remap paths.
>=20
> Found when fuzzing the nouveau driver with a modified Syzkaller.
>=20
> Fixes: b88baab82871 ("drm/nouveau: implement new VM_BIND uAPI")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Assisted-by: Codex:gpt-5.5
> ---
> =C2=A0drivers/gpu/drm/nouveau/nouveau_uvmm.c | 13 +++++++++++--
> =C2=A01 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> index fc125fd44a9b..2026fe6b48c6 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_uvmm.c
> @@ -846,6 +846,9 @@ op_map(struct nouveau_uvma *uvma)
> =C2=A0{
> =C2=A0=09struct nouveau_bo *nvbo =3D nouveau_gem_object(uvma-
> >va.gem.obj);
> =C2=A0
> +=09if (drm_gpuva_invalidated(&uvma->va))
> +=09=09return;
> +
> =C2=A0=09nouveau_uvma_map(uvma, nouveau_mem(nvbo->bo.resource));
> =C2=A0}
> =C2=A0
> @@ -1232,6 +1235,7 @@ bind_lock_validate(struct nouveau_job *job,
> struct drm_exec *exec,
> =C2=A0
> =C2=A0=09=09drm_gpuva_for_each_op(va_op, op->ops) {
> =C2=A0=09=09=09struct drm_gem_object *obj =3D
> op_gem_obj(va_op);
> +=09=09=09struct nouveau_bo *nvbo;
> =C2=A0
> =C2=A0=09=09=09if (unlikely(!obj))
> =C2=A0=09=09=09=09continue;
> @@ -1246,8 +1250,13 @@ bind_lock_validate(struct nouveau_job *job,
> struct drm_exec *exec,
> =C2=A0=09=09=09if (va_op->op =3D=3D DRM_GPUVA_OP_UNMAP)
> =C2=A0=09=09=09=09continue;
> =C2=A0
> -=09=09=09ret =3D
> nouveau_bo_validate(nouveau_gem_object(obj),
> -=09=09=09=09=09=09=C2=A0 true, false);
> +=09=09=09nvbo =3D nouveau_gem_object(obj);
> +=09=09=09if (!(nvbo->valid_domains &
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (NOUVEAU_GEM_DOMAIN_VRAM |
> NOUVEAU_GEM_DOMAIN_GART)))
> +=09=09=09=09return -EINVAL;
> +
> +=09=09=09nouveau_bo_placement_set(nvbo, nvbo-
> >valid_domains, 0);
> +=09=09=09ret =3D nouveau_bo_validate(nvbo, true,
> false);
> =C2=A0=09=09=09if (ret)
> =C2=A0=09=09=09=09return ret;
> =C2=A0=09=09}
> =C2=A0=09}
> =C2=A0

