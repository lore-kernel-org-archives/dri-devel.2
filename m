Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25FD0CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 16:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AA3010E3E8;
	Tue, 13 Oct 2026 16:59:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 479E010E89E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 16:59:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CE5D43B25;
 Tue, 13 Oct 2026 16:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B538B1F000FF;
 Tue, 13 Oct 2026 16:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791910743;
 bh=7rf9l6tketF+QBP9xkJNJiWtgEUDnWbhBZg1Kurq7l0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ta9YNUXHRryiuVISf8kN2q/EautspJSqJKrEyA8gI9WDOgftG2jq/QICDZusfem2C
 07wl+OlE294SUTuDy16R5+PCT9cojgwes5WHGzAKHuXstaLg+LYVPGdWS0//nMEgG8
 QAw/7ybnfYwC8WsvrItvyEXJ70+fKy0otY4s3NZ72jYF+xO5DttS4CbQZyCzoJOsPw
 1OKqNbgEGkQjwLn8WRpkb7ltJhcCmeU6wuHxTU+qWgpiSPyPVnuV9Xdh8GlqY1fMM2
 Rc8TEng3zbn6bo6U1NDKgGmhJY4wRX1EH7DhuZ+CRYtw6lDKXwQUHljgkIN/7TCzMl
 ZzbwfnPuUXawQ==
Message-ID: <sashiko-outbox-170178@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/5] drm/microchip: add a driver for the Microchip
 GFX2D GPU
To: "Cyrille Pitchen" <cyrille.pitchen@microchip.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261013-cpitchen-mainline_gfx2d-v11-2-7527f2efab0a@microchip.com>
References: <20261013-cpitchen-mainline_gfx2d-v11-0-7527f2efab0a@microchip.com>
 <20261013-cpitchen-mainline_gfx2d-v11-2-7527f2efab0a@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:59:03 +0000
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] build: Undefined macro kzalloc_obj causes compilation failure
- [High] drm: Use-after-free in driver remove due to synchronous teardown
- [High] drm: Use-after-free of gfx2d_obj in mchp_gfx2d_thread
- [High] drm: Use-after-free of gfx2d_obj in drm_dbg following unref
- [High] pm: AB-BA deadlock between pm_runtime suspend and IRQ thread
- [High] drm/microchip: VIVT cache coherency bug in multi-process dmabuf sh=
aring
- [High] drm/microchip: mchp_gfx2d_wait sleeps with mutex held, breaking ti=
meouts
- [Medium] locking: Acquiring spinlock_t in hardirq context triggers PREEMP=
T_RT BUG
- [Medium] pm: System suspend fails with -EBUSY due to PM resume failure in=
 IRQ thread
--

commit 008c58aa5740c6e3849d9b3c0fa7843a52355ee3
Author: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Subject: drm/microchip: add a driver for the Microchip GFX2D GPU

This commit introduces a DRM driver for the Microchip GFX2D GPU, supporting
basic 2D operations like FILL, COPY, BLEND, and ROP. The driver communicates
with the GPU via a ring buffer and tracks command completion using a mailbox
mechanism with LDR/STR instructions.

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_cmd.c
> index e462d9bca3170..7a5e8452e690a 100644
> --- a/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_cmd.c
> @@ -207,6 +207,41 @@ static void mchp_gfx2d_release_command(struct mchp_g=
fx2d_device *priv,
>  				       struct mchp_gfx2d_command *cmd,
>  				       bool recycle)
>  {
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	int i;
> =20
>  	drm_dbg(&priv->drm, "cmd %u: release command\n", cmd->id);
> =20
>  	gfx2d_obj =3D cmd->target;
>  	if (gfx2d_obj) {
>  		mchp_gfx2d_gem_unref(gfx2d_obj);
>  		drm_dbg(&priv->drm,
>  			"cmd %u: unref object %u (%d) as target\n",
>  			cmd->id,
>  			gfx2d_obj->id, atomic_read(&gfx2d_obj->gpu_active));

[Severity: High]
Is it safe to access gfx2d_obj after calling mchp_gfx2d_gem_unref()?

If this was the last reference, the object could be freed immediately by
drm_gem_object_put(). The very next line logs gfx2d_obj->id and
gfx2d_obj->gpu_active, which would result in a use-after-free.

>  	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(cmd->sources); i++) {
>  		struct mchp_gfx2d_source *src =3D &cmd->sources[i];
> =20
>  		gfx2d_obj =3D src->gfx2d_obj;
> =20
>  		if (!gfx2d_obj)
>  			continue;
> =20
>  		mchp_gfx2d_gem_unref(gfx2d_obj);
>  		drm_dbg(&priv->drm,
>  			"cmd %u: unref object %u (%d) as source %d at (%d,%d)\n",
>  			cmd->id,
>  			gfx2d_obj->id, atomic_read(&gfx2d_obj->gpu_active),
>  			i, src->x, src->y);

[Severity: High]
Can this similarly cause a use-after-free on the source object?

>  	}
> =20
>  	mchp_gfx2d_free_rectangles(cmd);
> =20
>  	if (recycle) {
>  		mutex_lock(&priv->free_cmdlist_mutex);

[ ... ]

> @@ -1726,6 +1726,38 @@ int mchp_gfx2d_wait(struct mchp_gfx2d_device *priv,
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
>  	mutex_lock(&gfx2d_obj->mutex);
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

[Severity: High]
Does holding gfx2d_obj->mutex across the sleeping mchp_gfx2d_gem_wait() call
break timeout expectations for concurrent waiters?

If a second thread attempts to wait on the same GEM object with a short
timeout, it will block uninterruptibly on this mutex rather than observing
its own specified timeout. This could trigger a hung task warning if the
first thread specified a long timeout and the GPU hangs.

> =20
>  	mutex_lock(&priv->wlist_mutex);
>  	list_del(&gfx2d_obj->w_node);
>  	mutex_unlock(&priv->wlist_mutex);
> =20
>  	drm_dbg(&priv->drm, "obj %u: %s for object\n",
>  		gfx2d_obj->id,
>  		ret ? "failed to wait" : "successfully waited");
> =20
>  	mutex_unlock(&gfx2d_obj->mutex);
> =20
>  put_autosuspend:
>  	pm_runtime_put_autosuspend(dev);
> =20
>  	return ret;
>  }

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c b/drivers/gpu/drm=
/microchip/mchp_gfx2d_drv.c
> index 81b807ad4bad1..0f34a17387cc3 100644
> --- a/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_drv.c
> @@ -31,6 +31,19 @@
>  static int mchp_gfx2d_open(struct drm_device *dev, struct drm_file *file=
_priv)
>  {
>  	struct mchp_gfx2d_file *ctx;
> =20
>  	ctx =3D kzalloc_obj(*ctx);

[Severity: High]
Is kzalloc_obj defined somewhere in the kernel? It appears to be an
undefined macro and will cause a compilation failure. Should this be
kzalloc(sizeof(*ctx), GFP_KERNEL) instead?

>  	if (!ctx)
>  		return -ENOMEM;
> =20
>  	mutex_init(&ctx->rectangles_mutex);
> =20
>  	file_priv->driver_priv =3D ctx;
> =20
>  	return 0;
>  }

[ ... ]

> @@ -84,6 +84,8 @@ static void mchp_gfx2d_disable_irq(struct mchp_gfx2d_de=
vice *priv)
>  {
>  	scoped_guard(mutex, &priv->irq_mutex) {
>  		scoped_guard(spinlock_irqsave, &priv->irq_lock) {
>  			priv->irq_active =3D false;
>  		}
>  	}
>  }
> =20
>  static irqreturn_t mchp_gfx2d_interrupt(int irq, void *dev_id)
>  {
>  	struct mchp_gfx2d_device *priv =3D dev_id;
>  	u32 status, mask, pending;
> =20
>  	/*
>  	 * We can't call pm_runtime_get_if_active() from here to verify that
>  	 * the peripheral clock is actually enabled before accessing the
>  	 * hardware registers because pm_runtime_get_if_active() returns
>  	 * an error if `dev->power.disable_depth > 0`, which would be true if
>  	 * mchp_gfx2d_runtime_suspend() had been called from pm_runtime_force_s=
uspend(),
>  	 * which calls pm_runtime_disable() first.
>  	 * Indeed, mchp_gfx2d_runtime_suspend() may need the IRQ handler and
>  	 * thread to be executed so the `priv->running_cmdlist_empty` event is
>  	 * notified.
>  	 *
>  	 * Instead, we first hold the `priv->irq_lock' lock to prevent races
>  	 * with the mchp_gfx2d_runtime_{suspend,resume}() and mchp_gfx2d_remove=
()
>  	 * functions, then we test the `priv->irq_active` boolean, which can be
>  	 * true only if the peripheral clock is enabled.
>  	 */
>  	guard(spinlock)(&priv->irq_lock);

[Severity: Medium]
Is it safe to acquire priv->irq_lock here since it is defined as a
spinlock_t?

On PREEMPT_RT kernels, spinlock_t becomes a sleepable rt_mutex. Acquiring it
in a hardirq context will trigger a lockdep BUG. Does this lock need to be
converted to a raw_spinlock_t?

> =20
>  	if (unlikely(!priv->irq_active))
>  		return IRQ_HANDLED;
> =20
>  	status =3D readl(priv->regs + GFX2D_IS);
>  	mask =3D readl(priv->regs + GFX2D_IM);
>  	pending =3D status & mask;
> =20
>  	if (pending & GFX2D_IRQ_EXEND)
>  		return IRQ_WAKE_THREAD;
> =20
>  	return IRQ_HANDLED;
>  }
> =20
>  static irqreturn_t mchp_gfx2d_thread(int irq, void *dev_id)
>  {
>  	struct mchp_gfx2d_device *priv =3D dev_id;
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	struct device *dev =3D priv->drm.dev;
>  	bool is_suspended =3D false;
>  	bool enable_exend =3D false;
>  	int ret;
> =20
>  	/*
>  	 * See comment in mchp_gfx2d_interrupt() about `priv->irq_active`.
>  	 * Here, we just hold `priv->irq_mutex` instead of `priv->irq_lock` but
>  	 * the rationale behind is the same.
>  	 */
>  	guard(mutex)(&priv->irq_mutex);
> =20
>  	if (unlikely(!priv->irq_active))
>  		return IRQ_HANDLED;
> =20
>  	drm_dbg(&priv->drm, "enter IRQ thread\n");
> =20
>  	ret =3D pm_runtime_resume_and_get(dev);

[Severity: High]
Could this lock ordering lead to an AB-BA deadlock between the PM core lock
and priv->irq_mutex?

When the PM core auto-suspends the device, it holds the device's PM lock and
invokes mchp_gfx2d_runtime_suspend(), which eventually calls
mchp_gfx2d_disable_irq(). This function blocks trying to acquire
priv->irq_mutex.

Concurrently, if an interrupt fires, the IRQ thread acquires
priv->irq_mutex and then calls pm_runtime_resume_and_get(dev), which
blocks waiting for the PM core lock.

[Severity: Medium]
Will this cause system suspend to fail with -EBUSY?

During system suspend, pm_runtime_force_suspend() disables runtime PM
before calling the suspend callback. When mchp_gfx2d_stop() waits for
pending commands, this IRQ thread wakes up but will fail here with -EACCES
because runtime PM is disabled.

It will exit without processing the commands, causing mchp_gfx2d_stop() to
time out and return -EBUSY, which ultimately aborts the system suspend.

>  	if (ret)
>  		goto exit;
> =20
>  	writel(GFX2D_IRQ_EXEND, priv->regs + GFX2D_ID);
> =20
>  	do {} while (mchp_gfx2d_progress(priv));
> =20
>  	mutex_lock(&priv->cmdlist_mutex);
>  	is_suspended =3D priv->is_suspended;
>  	mutex_unlock(&priv->cmdlist_mutex);
> =20
>  	/*
>  	 * When suspended, the EXEND interrupt is already enabled from
>  	 * mchp_gfx2d_progress() if needed.
>  	 */
>  	if (is_suspended)
>  		goto put_autosuspend;
> =20
>  	mutex_lock(&priv->wlist_mutex);
>  	list_for_each_entry(gfx2d_obj, &priv->wlist, w_node) {
>  		if (is_active(gfx2d_obj)) {
>  			enable_exend =3D true;
>  			break;
>  		}
>  	}
>  	mutex_unlock(&priv->wlist_mutex);
> =20
>  	if (enable_exend) {
>  		drm_dbg(&priv->drm,
>  			"enable EXEND interrupt: still waiting for object %u (%d)\n",
>  			gfx2d_obj->id, atomic_read(&gfx2d_obj->gpu_active));

[Severity: High]
Can this drm_dbg() dereference a freed object?

The IRQ thread releases priv->wlist_mutex before accessing gfx2d_obj.
If the thread sleeping on this object wakes up, removes it from the wait
list, and drops the final GEM reference, the object can be freed before this
debug print executes.

Should a GEM reference be taken while the lock is held to prevent this
use-after-free?

>  	} else {
>  		enable_exend =3D mchp_gfx2d_has_pending_commands(priv);
>  		if (enable_exend)
>  			drm_dbg(&priv->drm,
>  				"enable EXEND interrupt: some commands are pending\n");
>  	}

[ ... ]

> @@ -326,6 +326,17 @@ static void mchp_gfx2d_remove(struct platform_device=
 *pdev)
>  {
>  	struct mchp_gfx2d_device *priv =3D platform_get_drvdata(pdev);
>  	struct device *dev =3D &pdev->dev;
>  	int ret;
> =20
>  	drm_dev_unplug(&priv->drm);
> =20
>  	ret =3D pm_runtime_get_sync(dev);
>  	if (ret < 0)
>  		dev_warn(dev, "Failed to resume device on remove\n");
>  	else
>  		(void)mchp_gfx2d_stop(priv, true);
> =20
>  	mchp_gfx2d_disable_irq(priv);
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  	pm_runtime_set_suspended(dev);
>  	mchp_gfx2d_cleanup_command_queue(priv);

[Severity: High]
Does mchp_gfx2d_cleanup_command_queue() free resources too early?

drm_dev_unplug() prevents new ioctls but does not block waiting for
existing drm_dev_enter() sections to exit. If an in-flight ioctl (such as
MCHP_GFX2D_SUBMIT) continues executing and calls mchp_gfx2d_alloc_command(),
it will attempt to allocate from the destroyed priv->cmd_cache.

This causes an immediate use-after-free on unbind. Should these resources be
managed via drmm_ helpers or freed in the DRM release callback?

>  }

> diff --git a/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c b/drivers/gpu/d=
rm/microchip/mchp_gfx2d_ioctl.c
> index 5ee060cdf7b51..12fa4e87a2a09 100644
> --- a/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c
> +++ b/drivers/gpu/drm/microchip/mchp_gfx2d_ioctl.c
> @@ -305,6 +305,14 @@ static void mchp_gfx2d_flush_user_alias(struct drm_g=
em_object *obj)
>  {
>  	struct mm_struct *mm =3D current->mm;
>  	struct vm_area_struct *vma;
> =20
>  	VMA_ITERATOR(vmi, mm, 0);
> =20
>  	if (!mm)
>  		return;
> =20
>  	mmap_read_lock(mm);
>  	for_each_vma(vmi, vma)
>  		if (vma->vm_private_data =3D=3D obj)
>  			/* clean+invalidate D by user VA */
>  			__cpuc_flush_user_range(vma->vm_start, vma->vm_end,
>  						vma->vm_flags);

[Severity: High]
Is it reliable to flush the cache by walking only current->mm?

If this buffer is shared via DMA-BUF between multiple processes (such as a
Wayland compositor and a client), the client's writes might reside in its
own process's VIVT cache. When the compositor calls
DRM_IOCTL_MCHP_GFX2D_SYNC_FOR_GPU, it only flushes its own mm, leaving the
client's dirty cache lines unflushed. This could cause the GPU to read stale
data.

Additionally, using the internal __cpuc_flush_user_range() macro bypasses
architecture API boundaries. Should this be handled using standard cache
management APIs that ensure all VIVT aliases are flushed?

>  	mmap_read_unlock(mm);
>  }
> =20
>  static int mchp_gfx2d_ioctl_sync_for_gpu(struct drm_device *dev, void *d=
ata,
>  					 struct drm_file *file_priv)
>  {
>  	struct mchp_gfx2d_device *priv =3D drm_to_dev(dev);
>  	struct drm_mchp_gfx2d_sync_for_gpu *args =3D data;
>  	struct mchp_gfx2d_gem_object *gfx2d_obj;
>  	enum dma_data_direction dir;
>  	struct drm_gem_object *obj;
>  	int ret =3D 0;
>  	int idx;
> =20
>  	if (!drm_dev_enter(dev, &idx))
>  		return -ENODEV;
> =20
>  	obj =3D drm_gem_object_lookup(file_priv, args->handle);
>  	if (!obj) {
>  		ret =3D -ENOENT;
>  		goto exit;
>  	}
> =20
>  	gfx2d_obj =3D to_mchp_gfx2d_bo(obj);
> =20
>  	dir =3D gfx2d_obj->direction;
>  	if (valid_dma_direction(dir)) {
>  		dma_sync_single_for_device(dev->dev, gfx2d_obj->base.dma_addr,
>  					   obj->size, dir);
> =20
>  		/*
>  		 * On SAM9X60 and SAM9X75 SoCs (ARM926), dma_sync_single_for_device()
>  		 * flushes the data cache based on the kernel virtual address of
>  		 * the DRM GEM object.
>  		 * However, the user-space virtual address created by mmap is
>  		 * different from the kernel one. Since, ARM926 has a VIVT data cache,
>  		 * there are cache aliasing issues resulting in graphical glitches
>  		 * if the data cache is not flushed properly.
>  		 * So, one work-around is to call mchp_gfx2d_flush_user_alias() here.
>  		 */
>  		if (priv->caps->has_cache_aliasing)
>  			mchp_gfx2d_flush_user_alias(obj);
>  	}
> =20
>  	drm_gem_object_put(obj);
>  exit:
>  	drm_dev_exit(idx);
> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013-cpitchen-m=
ainline_gfx2d-v11-0-7527f2efab0a@microchip.com?part=3D2
