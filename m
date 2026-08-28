Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBDAC61DBD
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 16:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A62D10F41B;
	Fri, 28 Aug 2026 16:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MALC5b0b";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 840A910F41B
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 16:08:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B08D43BC1;
 Fri, 28 Aug 2026 16:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7451F000E9;
 Fri, 28 Aug 2026 16:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787933312;
 bh=+gEQMekLJ88gGO9h8WjllZEQ78sqqRzKnyDsWAijI0Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MALC5b0bQ5favzyRzlEuf6HijRlSKKDFJ1V3VO6Ap2323cmniP0n96cS+Z1Z8gHdr
 FMRtyr3XowjI2x77BJgUPnC7D6l6PyZuP9h7ljqSPR2lfs0xnozsP0qQ+Pj6mfdQ8d
 A6JmA3BngX9L99yK3fSkLsZQEbGQrhiUnyqwgYKaOLQjIiP2vQTwH0MPbYncvpIYkJ
 o6wuN72O1zLDcNYoSXxilSM/g/pV9HtNDaHaUnHrUF1U/TBJSN18u1DM6Dbq9emcB1
 cW6mmD1bBbTZDhDngeDW6awPNUFNhTk+DLBuFbMyVlu4jtM7qamIAsBWYgCvKRbg0c
 /cIejjmjUKX1A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/5] drm/microchip: add a driver for the Microchip
 GFX2D GPU
To: "Cyrille Pitchen" <cyrille.pitchen@microchip.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260828-cpitchen-mainline_gfx2d-v8-2-378374559738@microchip.com>
References: <20260828-cpitchen-mainline_gfx2d-v8-0-378374559738@microchip.com>
 <20260828-cpitchen-mainline_gfx2d-v8-2-378374559738@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 16:08:31 +0000
Message-Id: <20260828160831.EE7451F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 17 potential issue=
(s) to consider:
- [Critical] Concurrent WAIT ioctls on the same GEM object corrupt `priv->w=
list` leading to a double `list_del()` kernel panic.
- [Critical] Lack of synchronization around static `next_id` causes duplica=
te command IDs and premature Use-After-Free.
- [High] Concurrent SUBMIT ioctls on the same file descriptor corrupt the s=
hared per-file `ctx->rectangles` buffer.
- [High] Shallow copying `struct vm_area_struct` by value leads to Use-Afte=
r-Free and API misuse during cache flushing.
- [High] Hardware exception (bus fault) due to unsafe MMIO register access =
while the peripheral clock is disabled.
- [High] `IMPORT_BUFFER` unconditionally overwrites shared GEM buffer metad=
ata.
- [High] `SYNC_FOR_CPU` ioctl fails to invalidate CPU caches for noncoheren=
t buffers.
- [High] Invalid use of `virt_to_page()` on DMA addresses in `mchp_gfx2d_ge=
m_object_mmap`.
- [High] Integer truncation allows userspace to bypass ROP4 mask validation=
 and trigger a GPU fault.
- [High] Double-subtraction of `drm_vma_node_start` causes mmap to permanen=
tly fail with `-ENXIO`.
- [High] Integer overflow in `round_up(size, PAGE_SIZE)` allows 0-sized all=
ocation bypassing limits.
- [High] Use-After-Free in `mchp_gfx2d_ioctl_alloc_buffer` due to exposing =
the GEM handle before object initialization is complete.
- [High] The driver fails to reinitialize hardware registers after waking u=
p from a system suspend, leading to a GPU hang.
- [Medium] Use of `__kernel_size_t` and implicit padding in UAPI structures=
 breaks 32-bit compatibility.
- [Medium] Silent overwrite of `BLEND_SREG` when hardware lacks `DREG` for =
BLEND instructions.
- [Medium] Missing upper bound check on `num_rectangles` allows arbitrary l=
arge memory allocations.
- [Medium] The interrupt handler silently acknowledges and ignores all GPU =
hardware error interrupts.
--

commit 9a29a32449f034a19c84420d0dbfd7fc866315ff
Author: Cyrille Pitchen <cyrille.pitchen@microchip.com>

drm/microchip: add a driver for the Microchip GFX2D GPU

This commit adds a DRM driver for the Microchip GFX2D 2D GPU, supporting
basic graphics instructions like FILL, COPY, BLEND, and ROP. The driver
handles queueing instructions into a ring buffer and tracks completion
via a LDR/STR command ID trick to a mailbox in system memory.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_cmd.c
> index 0000000000000..5b2cc704a336f
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c
> @@ -96,15 +96,12 @@ static int mchp_gfx2d_alloc_rectangles(struct mchp_gf=
x2d_command *cmd,
>  				       size_t num_rectangles)
>  {
>  	cmd->num_rects =3D num_rectangles;
> =20
>  	if (num_rectangles <=3D ARRAY_SIZE(cmd->ctx->rectangles)) {
>  		cmd->can_free_rects =3D false;
>  		cmd->rects =3D cmd->ctx->rectangles;
>  		return 0;
>  	}

[Severity: High]
Can this corrupt graphics instructions if multiple threads use the same file
descriptor?=20

Unprivileged userspace can spawn threads that concurrently invoke the submit
ioctl on the same fd. Blindly assigning the shared per-file ctx rectangles
buffer without synchronization could allow concurrent copy operations to
overwrite each other's data, leading to arbitrary GPU execution or faults.

[ ... ]

> @@ -616,11 +616,10 @@ static void mchp_gfx2d_run_command(struct mchp_gfx2=
d_device *priv,
>  		if (cmd->blend.flags & GFX2D_BLEND_SET_DST_COLOR) {
>  			enum mchp_gfx2d_reg_id reg =3D priv->caps->has_dreg ?
>  				BLEND_DREG :
>  				BLEND_SREG;
>  			mchp_gfx2d_ldr(priv, reg, cmd->blend.dst_color);
>  			mchp_gfx2d_trigger(priv);
>  			cmd->blend.flags &=3D ~GFX2D_BLEND_SET_DST_COLOR;
>  		}
>  		if (cmd->blend.flags & GFX2D_BLEND_SET_SRC_COLOR) {
>  			mchp_gfx2d_ldr(priv, BLEND_SREG, cmd->blend.src_color);

[Severity: Medium]
If hardware lacks a dedicated destination register, won't this silently
overwrite the destination color?

The register gets populated with the destination color above, but if the
source color flag is also set, the exact same register is immediately
overwritten, causing the operation to execute without the correct destinati=
on
color.

[ ... ]

> @@ -1242,15 +1242,14 @@ static int
>  mchp_gfx2d_set_rop_params(struct mchp_gfx2d_device *priv,
>  			  struct drm_file *file_priv,
>  			  const struct drm_mchp_gfx2d_submit *args,
>  			  struct mchp_gfx2d_command *cmd)
>  {
>  	uint32_t handle =3D args->rop.mask_handle;
> =20
>  	cmd->rop.mode =3D (u8)args->rop.mode;
>  	if (cmd->rop.mode > DRM_MCHP_GFX2D_ROP4)
>  		return -EINVAL;
> =20
>  	if (args->rop.mode =3D=3D DRM_MCHP_GFX2D_ROP2 && args->rop.low > 15)
>  		return -EINVAL;
> =20
>  	if (((args->rop.mode =3D=3D DRM_MCHP_GFX2D_ROP4) && !handle) ||
>  	    ((args->rop.mode !=3D DRM_MCHP_GFX2D_ROP4) && handle))
>  		return -EINVAL;

[Severity: High]
Does the integer truncation of the mode allow userspace to bypass mask
validation?=20

The 32-bit mode is truncated to an 8-bit integer for the bounds check.
If a user passes 0x10000002, it truncates to 2 (ROP4) and passes the check.
However, the subsequent validation for a missing mask uses the untruncated
32-bit value. This could allow a ROP4 command into the pipeline with a null
mask pointer, potentially hard-faulting the GPU.

[ ... ]

> @@ -1291,15 +1291,14 @@ static struct mchp_gfx2d_command *
>  mchp_gfx2d_alloc_command(struct mchp_gfx2d_device *priv)
>  {
>  	static uint32_t next_id;
>  	struct mchp_gfx2d_command *cmd =3D NULL;

[ ... ]

>  	memset(cmd, 0, sizeof(*cmd));
>  	cmd->id =3D next_id++;
> =20
>  	return cmd;
>  }

[Severity: Critical]
Can this race if multiple threads submit graphics instructions concurrently=
?=20

Since the identifier is a static variable updated without synchronization,
concurrent ioctls might assign identical identifiers to different commands.
If the hardware mailbox reports the most recently completed identifier,
compleosing the first command could incorrectly signal that both are finish=
ed.
This could cause the driver to free the second command and its GEM referenc=
es
while the GPU is still executing it.

[ ... ]

> @@ -1513,11 +1513,10 @@ void mchp_gfx2d_cleanup_command_queue(struct mchp=
_gfx2d_device *priv)
>  {
>  	struct device *dev =3D priv->drm.dev;
>  	struct mchp_gfx2d_command *cmd, *tmp;
>  	uint32_t i;
> =20
>  	writel(GFX2D_IRQ_EXEND, priv->regs + GFX2D_ID);

[Severity: High]
Does this safely handle hardware accesses if the peripheral clock is gated?

This unconditionally writes to registers, which could trigger a hardware bus
fault if the clock failed to enable or was disabled by runtime suspend.

[ ... ]

> @@ -1568,14 +1568,13 @@ int mchp_gfx2d_submit(struct mchp_gfx2d_device *p=
riv,
>  		      struct drm_file *file_priv,
>  		      const struct drm_mchp_gfx2d_submit *args)
>  {
>  	struct mchp_gfx2d_file *ctx =3D file_priv->driver_priv;
>  	struct mchp_gfx2d_command *cmd;
>  	size_t i, num_sources;
>  	int ret;
> =20
>  	if (!args->num_rectangles)
>  		return -EINVAL;
> =20
>  	cmd =3D mchp_gfx2d_alloc_command(priv);
>  	if (!cmd)
>  		return -ENOMEM;
> =20
>  	cmd->ctx =3D ctx;
>  	cmd->operation =3D (u8)args->operation;
>  	drm_dbg(&priv->drm, "cmd %u: allocate command (operation =3D %u)\n",
>  		cmd->id, cmd->operation);
> =20
>  	ret =3D mchp_gfx2d_alloc_rectangles(cmd, args->num_rectangles);

[Severity: Medium]
Is there a missing upper bound check for the number of rectangles here?

Since this untrusted user value is passed directly to the memory allocation
routines, an unprivileged user could pass an extremely large value to exhau=
st
kernel memory or trigger the OOM killer.

>  	if (ret)
>  		goto err_release_command;
> =20
>  	ret =3D copy_from_user(cmd->rects, u64_to_user_ptr(args->rectangles),
>  			     args->num_rectangles * sizeof(*cmd->rects));

[Severity: High]
Can this copy operations corrupt the shared context array?

If multiple threads use the same file descriptor and the shared context buf=
fer
is assigned without synchronization, concurrent copies here would overwrite=
 each
other's data.

[ ... ]

> @@ -1689,17 +1689,16 @@ int mchp_gfx2d_wait(struct mchp_gfx2d_device *pri=
v,
>  		    struct mchp_gfx2d_gem_object *gfx2d_obj,
>  		    const struct drm_mchp_timespec *timeout)
>  {
>  	struct device *dev =3D priv->drm.dev;
>  	int ret;
> =20
>  	ret =3D pm_runtime_resume_and_get(dev);
>  	if (ret)
>  		return ret;
> =20
>  	(void)mchp_gfx2d_progress(priv);
> =20
>  	drm_dbg(&priv->drm, "obj %u: poll object\n", gfx2d_obj->id);
> =20
>  	ret =3D mchp_gfx2d_gem_wait(gfx2d_obj, NULL);
>  	if (!ret || !timeout)
>  		goto put_autosuspend;
> =20
>  	drm_dbg(&priv->drm, "obj %u: wait for object\n", gfx2d_obj->id);
> =20
>  	mutex_lock(&priv->wlist_mutex);
>  	list_add_tail(&gfx2d_obj->w_node, &priv->wlist);
>  	mutex_unlock(&priv->wlist_mutex);
> =20
>  	mchp_gfx2d_enable_exend(priv);
> =20
>  	ret =3D mchp_gfx2d_gem_wait(gfx2d_obj, timeout);
> =20
>  	mutex_lock(&priv->wlist_mutex);
>  	list_del(&gfx2d_obj->w_node);
>  	mutex_unlock(&priv->wlist_mutex);

[Severity: Critical]
Can this corrupt the linked list?=20

Unprivileged userspace can spawn multiple threads invoking a wait on the sa=
me
GEM object concurrently. They will sequentially acquire the mutex and blind=
ly
call list_add_tail on the same embedded node. Inserting an already-linked n=
ode
corrupts the pointers, and when the threads later attempt to remove it, a
double-delete kernel panic will occur.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_drv.c
> index 0000000000000..ab8df683f3e00
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c
> @@ -69,14 +69,13 @@ static const struct drm_driver mchp_gfx2d_drm_driver =
=3D {
> =20
>  static irqreturn_t mchp_gfx2d_interrupt(int irq, void *dev_id)
>  {
>  	struct mchp_gfx2d_device *priv =3D dev_id;
>  	u32 status, mask, pending;
> =20
>  	status =3D readl(priv->regs + GFX2D_IS);

[Severity: High]
Does this safely handle spurious interrupts while the peripheral clock is
gated?=20

Reading an MMIO register without checking if the clock is active might cause
a synchronous external abort (bus fault) if the driver is runtime suspended.

>  	mask =3D readl(priv->regs + GFX2D_IM);
>  	pending =3D status & mask;
> =20
>  	if (!pending)
>  		return IRQ_NONE;
> =20
>  	if (pending & GFX2D_IRQ_EXEND)
>  		return IRQ_WAKE_THREAD;
> =20
>  	return IRQ_HANDLED;
>  }

[Severity: Medium]
Does this intentionally silently acknowledge and ignore GPU hardware error
interrupts?=20

If the interrupt was triggered by a read error, write error, or illegal
instruction, falling through without waking up waiters or resetting the GPU
might cause waiting processes to hang indefinitely until they time out.

[ ... ]

> @@ -212,12 +212,11 @@ static void mchp_gfx2d_remove(struct platform_devic=
e *pdev)
>  {
>  	struct mchp_gfx2d_device *priv =3D platform_get_drvdata(pdev);
>  	int ret;
> =20
>  	drm_dev_unregister(&priv->drm);
> =20
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	mchp_gfx2d_cleanup_command_queue(priv);

[Severity: High]
If the runtime resume fails here, does the cleanup function safely handle
hardware accesses?=20

The cleanup function unconditionally writes to hardware registers, which co=
uld
trigger a hardware bus fault if the clock failed to enable.

[ ... ]

> @@ -279,13 +279,12 @@ static int __maybe_unused mchp_gfx2d_runtime_resume=
(struct device *dev)
>  {
>  	struct mchp_gfx2d_device *priv =3D dev_get_drvdata(dev);
>  	int ret;
> =20
>  	ret =3D clk_enable(priv->pclk);
>  	if (ret)
>  		return ret;
> =20
>  	mutex_lock(&priv->cmdlist_mutex);

[Severity: High]
Does the hardware retain its configuration after a system suspend (S3)?=20

If power is lost, waking up and only enabling the clock without restoring
critical registers like the ring buffer address and global enable flag might
cause the GPU to permanently stall when subsequent commands are submitted.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_gem.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_gem.c
> index 0000000000000..66f22cd6ac981
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_gem.c
> @@ -23,17 +23,16 @@ static int mchp_gfx2d_gem_object_mmap(struct drm_gem_=
object *obj,
>  				      struct vm_area_struct *vma)
>  {
>  	struct mchp_gfx2d_gem_object *gfx2d_obj =3D to_mchp_gfx2d_bo(obj);
>  	int ret;
> =20
>  	/*
>  	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
>  	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want to map
>  	 * the whole buffer.
>  	 */
>  	vma->vm_pgoff -=3D drm_vma_node_start(&obj->vma_node);

[Severity: High]
Could this double-subtraction permanently break the mapping?

The core DRM subsystem already translates and subtracts the offset before
invoking the driver callback. Doing it a second time here will underflow the
offset, causing the subsequent mapping call to reject the operation with an
error.

>  	vm_flags_mod(vma, VM_DONTEXPAND, VM_PFNMAP);
> =20
>  	if (gfx2d_obj->direction =3D=3D DMA_NONE) {
>  		ret =3D dma_mmap_wc(obj->dev->dev, vma, gfx2d_obj->vaddr,
>  				  gfx2d_obj->dma_addr,
>  				  vma->vm_end - vma->vm_start);
>  	} else {
>  		vma->vm_page_prot =3D vm_get_page_prot(vma->vm_flags);
> =20
>  		ret =3D dma_mmap_pages(obj->dev->dev,
>  				     vma, vma->vm_end - vma->vm_start,
>  				     virt_to_page(gfx2d_obj->vaddr));

[Severity: High]
Is virt_to_page() safe to use on DMA addresses here?=20

The virtual address is allocated with the noncoherent dma allocator, which
on many architectures returns a non-linear vmalloc address. Using this help=
er
on non-linear addresses yields a bogus page structure, potentially leading =
to
page faults or mapping arbitrary physical memory to userspace.

>  	}
>  	if (ret)
>  		drm_gem_vm_close(vma);
>  	else
>  		memcpy(&gfx2d_obj->vma, vma, sizeof(gfx2d_obj->vma));

[Severity: High]
Does this safely handle the lifecycle of the memory management struct?=20

Performing a shallow copy using memcpy means that if the original mapping is
unmapped, split, or the process exits, this cached copy will contain stale
pointers that could cause a use-after-free later.

[ ... ]

> @@ -100,12 +100,11 @@ struct mchp_gfx2d_gem_object *
>  mchp_gfx2d_gem_create(struct drm_device *dev, size_t size,
>  		      enum dma_data_direction dir)
>  {
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
> =20
>  	size =3D round_up(size, PAGE_SIZE);

[Severity: High]
Can this overflow?=20

If userspace passes an extremely large size close to U32_MAX, this can sile=
ntly
wrap to 0. The driver would allocate 0 bytes of physical memory but still
populate the metadata with the huge dimensions, tricking the GPU into
out-of-bounds DMA accesses.

[ ... ]

> @@ -132,14 +131,13 @@ mchp_gfx2d_gem_create_with_handle(struct drm_file *=
file_priv,
>  				  struct drm_device *dev, size_t size,
>  				  enum dma_data_direction dir,
>  				  uint32_t *handle)
>  {
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	struct drm_gem_object *obj;
>  	int ret;
> =20
>  	gfx2d_obj =3D mchp_gfx2d_gem_create(dev, size, dir);
>  	if (IS_ERR(gfx2d_obj))
>  		return gfx2d_obj;
> =20
>  	obj =3D &gfx2d_obj->base;
> =20
>  	ret =3D drm_gem_handle_create(file_priv, obj, handle);
>  	/* drop reference from allocate - handle holds it now. */
>  	drm_gem_object_put(obj);
>  	if (ret)
>  		return ERR_PTR(ret);
> =20
>  	return gfx2d_obj;
>  }

[Severity: High]
Does dropping the reference here expose the object to being concurrently fr=
eed
before initialization is complete?=20

Once the handle is registered, it becomes visible to userspace. A concurrent
thread can immediately issue the free ioctl, releasing the memory. When this
function returns and its callers subsequently write to the object's propert=
ies,
it would result in a use-after-free.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c b/drivers/gpu/d=
rm/microchip/mchp_gfx2d_ioctl.c
> index 0000000000000..2a24738577892
> --- /dev/null
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c
> @@ -178,16 +178,15 @@ static int mchp_gfx2d_ioctl_import_buffer(struct dr=
m_device *dev, void *data,
>  					  struct drm_file *file_priv)
>  {
>  	struct drm_mchp_gfx2d_import_buffer *args =3D data;
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	struct drm_gem_object *obj;
>  	int ret;
> =20
>  	if (!mchp_gfx2d_valid_buffer_params(args->width, args->stride, args->fo=
rmat))
>  		return -EINVAL;
> =20
>  	ret =3D drm_gem_prime_fd_to_handle(dev, file_priv, args->fd, &args->han=
dle);
>  	if (ret)
>  		return ret;
> =20
>  	obj =3D drm_gem_object_lookup(file_priv, args->handle);
>  	if (!obj)
>  		return -ENOENT;
> =20
>  	if (!mchp_gfx2d_valid_size(args->stride, args->height, obj->size)) {
>  		drm_gem_object_put(obj);
>  		drm_gem_handle_delete(file_priv, args->handle);
>  		return -EINVAL;
>  	}
> =20
>  	gfx2d_obj =3D to_mchp_gfx2d_bo(obj);
>  	gfx2d_obj->width =3D args->width;
>  	gfx2d_obj->height =3D args->height;
>  	gfx2d_obj->stride =3D args->stride;
>  	gfx2d_obj->format =3D args->format;
> =20
>  	drm_gem_object_put(obj);
> =20
>  	return 0;
>  }

[Severity: High]
Is it safe to unconditionally overwrite these metadata bounds on an imported
object?=20

If a buffer is exported by one process and imported by another, the importi=
ng
process could provide arbitrary dimensions here. This modifies the shared
object globally, potentially breaking metadata immutability and permitting
out-of-bounds memory accesses for other processes sharing the object.

[ ... ]

> @@ -206,16 +205,15 @@ static int mchp_gfx2d_ioctl_sync_for_cpu(struct drm=
_device *dev, void *data,
>  					 struct drm_file *file_priv)
>  {
>  	struct mchp_gfx2d_device *priv =3D drm_to_dev(dev);
>  	struct drm_mchp_gfx2d_sync_for_cpu *args =3D data;
>  	const struct drm_mchp_timespec *timeout =3D &args->timeout;
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	struct drm_gem_object *obj;
>  	int ret;
> =20
>  	if (args->flags & ~DRM_MCHP_GFX2D_WAIT_NONBLOCK)
>  		return -EINVAL;
> =20
>  	obj =3D drm_gem_object_lookup(file_priv, args->handle);
>  	if (!obj)
>  		return -ENOENT;
> =20
>  	gfx2d_obj =3D to_mchp_gfx2d_bo(obj);
> =20
>  	if (args->flags & DRM_MCHP_GFX2D_WAIT_NONBLOCK)
>  		timeout =3D NULL;
> =20
>  	ret =3D mchp_gfx2d_wait(priv, gfx2d_obj, timeout);
> =20
>  	drm_gem_object_put(obj);
> =20
>  	return ret;
>  }

[Severity: High]
Does this ioctl intentionally skip invalidating CPU caches?=20

For buffers allocated via the noncoherent allocator, failing to call the CPU
cache synchronization functions means the CPU might read stale cached data
instead of the final GPU output once the wait completes.

> @@ -236,13 +234,12 @@ static int mchp_gfx2d_ioctl_sync_for_gpu(struct drm=
_device *dev, void *data,
>  					 struct drm_file *file_priv)
>  {
>  	struct drm_mchp_gfx2d_sync_for_gpu *args =3D data;
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	enum dma_data_direction dir;
>  	struct drm_gem_object *obj;
> =20
>  	obj =3D drm_gem_object_lookup(file_priv, args->handle);
>  	if (!obj)
>  		return -ENOENT;
> =20
>  	gfx2d_obj =3D to_mchp_gfx2d_bo(obj);
> =20
>  	dir =3D gfx2d_obj->direction;
>  	if (valid_dma_direction(dir)) {
>  		struct vm_area_struct *vma =3D &gfx2d_obj->vma;
> =20
>  		flush_cache_range(vma, vma->vm_start, vma->vm_end);
>  	}

[Severity: High]
Continuing from the shallow copy concern, does the cache flush safely handle
the copied struct?=20

The architecture-level cache flush can dereference potentially freed proper=
ties
if the original mapping was already unmapped or split by the process, leadi=
ng
to a use-after-free.

> diff --git a/include/uapi/drm/microchip_drm.h b/include/uapi/drm/microchi=
p_drm.h
> index 0000000000000..6be5ea9edd7cd
> --- /dev/null
> +++ b/include/uapi/drm/microchip_drm.h
> @@ -148,15 +148,14 @@ struct drm_mchp_gfx2d_rop {
>  	__u32 mask_handle;
>  	enum drm_mchp_gfx2d_rop_mode mode;
>  	__u8 high;
>  	__u8 low;
>  };
> =20
>  struct drm_mchp_gfx2d_submit {
>  	__u64 rectangles;
>  	__kernel_size_t num_rectangles;

[Severity: Medium]
Does using this type in a UAPI struct break 32-bit compatibility ioctl
translations?=20

Its size varies between 32-bit and 64-bit architectures, which typically ca=
uses
ABI mismatches.

[ ... ]

> @@ -224,15 +224,14 @@ enum drm_mchp_gfx2d_direction {
>  	DRM_MCHP_GFX2D_DIR_BIDIRECTIONAL,
>  	DRM_MCHP_GFX2D_DIR_TO_DEVICE,
>  	DRM_MCHP_GFX2D_DIR_FROM_DEVICE,
>  	DRM_MCHP_GFX2D_DIR_NONE,
>  };
> =20
>  struct drm_mchp_gfx2d_alloc_buffer {
>  	__u32 size;     /* in bytes for mmap() */
>  	__u16 width;
>  	__u16 height;
>  	__u16 stride;
>  	enum drm_mchp_gfx2d_pixel_format format;

[Severity: Medium]
Will this 16-bit field followed by a 32-bit enum create implicit padding?

Leaving uninitialized padding in UAPI structures can lead to information le=
aks
to userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828-cpitchen-m=
ainline_gfx2d-v8-0-378374559738@microchip.com?part=3D2
