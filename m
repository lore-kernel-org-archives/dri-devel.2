Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60FAC55174
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:33:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B368510E286;
	Sat,  8 Aug 2026 12:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GllSegJH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D115F10E2BB
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:33:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 987CD404BA;
 Sat,  8 Aug 2026 12:33:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461BC1F000E9;
 Sat,  8 Aug 2026 12:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786192410;
 bh=brCq5pWlFjuXy82zBEs0h5OHcAhB14ciaEOIeF38j3Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GllSegJHwvAeepXWchI9lpjdDTdyuAeqDIxzzm7Mc3aWp85srBNOij2I1+Ep1ZcWY
 wkXW7vhwbA/26i8hLcw1GrVpDS40YB7kQ9ZcbrpmiwmgpwHUM5I7xFBPavFRXb8/kB
 /8pYFcX44w0aDGdk0AJlmanPQ3b2PUfKtga1UdZNk1SDgN5IBxu2QbZaIhOZYbWiIm
 pwwtLY/ZxE+mAJkVG1EdwgLsCucpQBx0ZrBcQcyGdmSjbP3gPlk0L19fOEIbrpPtBE
 ApTN3zVHcNbc9bXb6QSqsjsgF1R2W6xdM42kqRpIBUvhaPde7ybHY8wzOs+gVgUvEc
 aXIIcxAu38Xdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/exynos: g2d: fix autosuspend cleanup on probe failure
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808121752.2819486-1-lgs201920130244@gmail.com>
References: <20260808121752.2819486-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 12:33:29 +0000
Message-Id: <20260808123330.461BC1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:

New issues:
- [Medium] Phantom Fix / Dead Code

Pre-existing issues:
- [Critical] Integer Overflow leading to Out-of-Bounds memory access in exy=
nos_g2d_set_cmdlist_ioctl
- [Critical] Out-of-Bounds Write in g2d_map_cmdlist_gem
- [Critical] Use-After-Free in IRQ handler when DRM file descriptor is clos=
ed
- [High] Permanent reference leak and task hang in g2d_dma_start()
- [High] Data Race and Logical Bug bypassing global userptr pool limits
- [High] Use-After-Free / NULL Pointer Dereference in IRQ and workqueue on =
removal
- [High] Double Free of DMA memory in g2d_remove()
- [High] Lockless access UAF to runqueue_node in IRQ handler
- [Medium] Memory Leak in g2d_init_cmdlist
--

--- Patch [1]: [PATCH] drm/exynos: g2d: fix autosuspend cleanup on probe fa=
ilure ---
commit 52d780780d9657013e887d137cd889b60f793705
Author: Guangshuo Li <lgs201920130244@gmail.com>
Subject: drm/exynos: g2d: fix autosuspend cleanup on probe failure

This commit adds a call to pm_runtime_dont_use_autosuspend() in the probe
failure path of the g2d driver. The commit message states this is necessary
to balance a corresponding call to pm_runtime_use_autosuspend() and prevent
a usage_count leak.

> diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_g2d.c
> index 3271fd4b17240..3222b218c8e76 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
> @@ -1448,6 +1448,7 @@ static int g2d_probe(struct platform_device *pdev)
>  	return 0;
> =20
>  err_put_clk:
> +	pm_runtime_dont_use_autosuspend(dev);
[Severity: Medium]
The commit message states that g2d_probe() calls pm_runtime_use_autosuspend=
(),
but does the driver actually ever call pm_runtime_use_autosuspend()? Since
autosuspend is never enabled for this device, it seems dev->power.use_autos=
uspend
is already 0. Does this mean the cleanup call is unnecessary and adds dead =
code?

>  	pm_runtime_disable(dev);
>  err_destroy_workqueue:
>  	destroy_workqueue(g2d->g2d_workq);


While reviewing this patch, I noticed several pre-existing issues in this f=
ile.

> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_dma_start() {
> [ ... ]
> 	ret =3D pm_runtime_get_sync(g2d->dev);
> 	if (ret < 0)
> 		return;
> [ ... ]

[Severity: High]
This is a pre-existing issue, but does this permanently leak the runtime PM
reference if pm_runtime_get_sync() returns < 0? The pm_runtime_get_sync()
function increments the usage counter even on failure. Because
pm_runtime_put_noidle() is not called here, could a userspace application
calling exynos_g2d_exec_ioctl() synchronously be stuck indefinitely waiting
for a completion interrupt that will never fire?


> drivers/gpu/drm/exynos/exynos_drm_g2d.c:exynos_g2d_set_cmdlist_ioctl() {
> [ ... ]
> 	size =3D cmdlist->last + req->cmd_nr * 2 + req->cmd_buf_nr * 2 + 2;
> 	if (size > G2D_CMDLIST_DATA_NUM) {
> [ ... ]

[Severity: Critical]
This is a pre-existing issue, but can this size calculation overflow? If an
attacker provides sufficiently large values for req->cmd_nr and
req->cmd_buf_nr, could the size variable (declared as signed int) become
negative, bypassing the G2D_CMDLIST_DATA_NUM bounds check? This appears to
allow out-of-bounds memory access later in g2d_check_reg_offset().


> drivers/gpu/drm/exynos/exynos_drm_g2d.c:exynos_g2d_set_cmdlist_ioctl() {
> [ ... ]
> 	node->buf_info.map_nr =3D req->cmd_buf_nr;
> [ ... ]
> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_map_cmdlist_gem() {
> [ ... ]
> 	for (i =3D 0; i < buf_info->map_nr; i++) {
> 		buf_info->reg_types[i] =3D reg_type;
> 		buf_info->handles[reg_type] =3D handle;
> [ ... ]

[Severity: Critical]
This is a pre-existing issue, but does this loop write out-of-bounds if
req->cmd_buf_nr is greater than MAX_REG_TYPE_NR (which is 6)? The overall
command list size check permits req->cmd_buf_nr to be up to ~125. Since
buf_info->reg_types is strictly dimensioned to MAX_REG_TYPE_NR, would
iterations above 5 linearly overwrite adjacent fields in the struct
g2d_buf_info?


> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_userptr_free_all() {
> [ ... ]
> 	g2d->current_pool =3D 0;
> [ ... ]

[Severity: High]
This is a pre-existing issue, but does this inadvertently reset the global
device-wide current_pool counter back to zero when a single user closes its
file descriptor? Since g2d->current_pool tracks memory across the entire
hardware device, it seems this clears the accounting for all active clients
on the system, bypassing the max_pool limit.

Additionally, in g2d_userptr_get_dma_addr(), list_add_tail() modifies
g2d_priv->userptr_list locklessly. Is this safe if multiple threads share t=
he
same DRM file descriptor and invoke the ioctl concurrently?


> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_remove() {
> [ ... ]
> 	destroy_workqueue(g2d->g2d_workq);
> [ ... ]
> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_irq_handler() {
> [ ... ]
> 	if (pending & G2D_INTP_ACMD_FIN)
> 		queue_work(g2d->g2d_workq, &g2d->runqueue_work);
> [ ... ]

[Severity: High]
This is a pre-existing issue, but is it possible for the hardware interrupt
to fire after destroy_workqueue() is called? The driver uses devm_request_i=
rq(),
meaning the IRQ is only freed by devres after g2d_remove() returns. If an
interrupt fires during this window, could g2d_irq_handler() access a freed
workqueue pointer?


> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_subdrv_probe() {
> [ ... ]
> 	ret =3D drm_iommu_attach_device(drm_dev, dev);
> 	if (ret < 0) {
> 		dev_err(dev, "failed to enable iommu.\n");
> 		g2d_fini_cmdlist(g2d);
> 	}
> [ ... ]

[Severity: High]
This is a pre-existing issue, but if g2d_subdrv_probe() fails and calls
g2d_fini_cmdlist(g2d), the DMA memory is freed, but g2d->cmdlist_pool_virt
is not set to NULL. Since g2d_remove() also unconditionally calls
g2d_fini_cmdlist(g2d), would this lead to dma_free_attrs() being called
twice on the same pointer?


> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_init_cmdlist() {
> [ ... ]
> 	node =3D kcalloc(G2D_CMDLIST_NUM, sizeof(*node), GFP_KERNEL);
> [ ... ]
> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_fini_cmdlist() {
> [ ... ]
> 	kfree(g2d->cmdlist_node);
> [ ... ]

[Severity: Medium]
This is a pre-existing issue, but the allocated array is assigned to the lo=
cal
variable 'node' in g2d_init_cmdlist(), and it is never saved to
g2d->cmdlist_node. Does this mean kfree(g2d->cmdlist_node) in
g2d_fini_cmdlist() is always called on a NULL pointer, permanently leaking =
the
64 allocated nodes?


> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_close() {
> [ ... ]
> 	mutex_lock(&g2d->cmdlist_mutex);
> 	list_for_each_entry_safe(node, n, &g2d_priv->inuse_cmdlist, list) {
> [ ... ]
> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_finish_event() {
> [ ... ]
> 	list_move_tail(&e->base.link, &e->base.file_priv->event_list);
> 	wake_up_interruptible(&e->base.file_priv->event_wait);
> [ ... ]

[Severity: Critical]
This is a pre-existing issue, but if a user submits an asynchronous ioctl
and closes the file descriptor before the hardware finishes, g2d_close()
cleans up inuse_cmdlist but doesn't wait for pending jobs in the global
runqueue. Later, when the hardware interrupt fires, g2d_finish_event()
dereferences e->base.file_priv. Could this access a freed drm_file object?


> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_runqueue_worker() {
> [ ... ]
> 	if (g2d->runqueue_node->async)
> 		g2d_free_runqueue_node(g2d, g2d->runqueue_node);
>=20
> 	if (g2d->suspended)
> 		g2d->runqueue_node =3D NULL;
> 	else
> 		g2d_exec_runqueue(g2d);
> [ ... ]
> drivers/gpu/drm/exynos/exynos_drm_g2d.c:g2d_finish_event() {
> [ ... ]
> 	struct g2d_runqueue_node *runqueue_node =3D g2d->runqueue_node;
> [ ... ]

[Severity: High]
This is a pre-existing issue, but the worker thread calls
g2d_free_runqueue_node() while holding a mutex, momentarily leaving
g2d->runqueue_node pointing to freed memory until it replaces it inside
g2d_exec_runqueue(). If a hardirq preempts the worker thread during this
window, could g2d_finish_event() locklessly read and dereference the freed
pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808121752.2819=
486-1-lgs201920130244@gmail.com?part=3D1
