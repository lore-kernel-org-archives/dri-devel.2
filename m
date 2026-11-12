Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB1606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bS8eCm7z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E61B112402;
	Thu, 12 Nov 2026 23:39:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAEB112402
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:38:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D9BB142E16;
 Thu, 12 Nov 2026 23:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CDC1F000C4;
 Thu, 12 Nov 2026 23:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794526738;
 bh=nP5K03VatiObXIjOOxI9DdwMA4flri/rrGuIMLEp6lM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bS8eCm7zMBteD7ln772ATL/X4xRMQApPaq+mEyJkF42KO6CWFAQsuSndfaSHT3N/w
 oZ9UtjMP017DkWIFNJMsRrCgvPxPABcZyCNpnYx6qGlepiJ6rrxs6i1eo45xb5DqE6
 SHlt5VlglKhO/tFlyriltOwTA26yZjFjBeuMV8gEHevQy1istpiUmkvijGXk4k0Myq
 H/c2zMW7vpruU39Egj4z55afWf6vEW5b1kUtl8ARlLB6wQ5QpCg2LdW8lNkxrvSsIF
 3qEKCF0e0jC3a6BQ0poAI3hzkQomkQ8Ov8a60i/3NnPf/gxyX0C9CVrV+l7nqvY3BQ
 3QiZh3JdzP/cg==
Message-ID: <sashiko-outbox-211960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 12/13] drm/powervr_sgx: Add the DRM driver, power
 management and debugging
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-12-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-12-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:38:58 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] drm/powervr_sgx: premature PM teardown in
  pvrsgx_remove_common()
- [High] drm/powervr_sgx: unsynchronized pvrsgx_fw_stop() in shutdown
  callbacks
- [High] drm/powervr_sgx: drm_device ref cycle leak via unreaped
  pvrsgx_kobj
- [High] drm/powervr_sgx: pvrsgx_suspend() races with in-flight reset in
  pvrsgx_timedout_job()
- [Medium] drm/powervr_sgx: unclocked register reads in debugfs
  status_show()
- [Medium] drm/powervr_sgx: pb_default_pages exceeds pb_max_pages on
  SGX530
- [Medium] drm/powervr_sgx: missing GPU stop on resume failure and when
  lost on suspend
--

commit 2e8bb00c340e90f94be8141151b69913ad1bd3f0
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Add the DRM driver, power management and debugging

This commit adds the DRM driver, PCI/auxiliary/OF bus bindings, runtime
and system sleep power management, debugfs entries, devcoredump support,
and Kconfig/Makefile wiring for PowerVR SGX5xx GPUs.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.c b/drivers/gpu/d=
rm/powervr_sgx/pvrsgx_debugfs.c
> new file mode 100644
> index 0000000000000..99f1b7a8c84ae
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_debugfs.c

[ ... ]

> +static int status_show(struct seq_file *m, void *unused)
> +{
> +	struct drm_debugfs_entry *entry =3D m->private;
> +	struct pvrsgx_device *sdev =3D to_pvrsgx_device(entry->dev);
> +	struct seq_buf sb;
> +	char *buf =3D kmalloc(SZ_4K, GFP_KERNEL);
> +	int idx, awake;
> +
> +	if (!buf)
> +		return -ENOMEM;
> +	if (!drm_dev_enter(entry->dev, &idx)) {
> +		kfree(buf);
> +		return -ENODEV;
> +	}
> +	/* -EINVAL: runtime PM is off and the device always on. */
> +	awake =3D pm_runtime_get_if_active(sdev->base.dev);
> +	seq_buf_init(&sb, buf, SZ_4K);
> +	pvrsgx_dump_status(&sb, sdev, awake > 0 || awake =3D=3D -EINVAL);
> +	if (awake > 0)
> +		pm_runtime_put(sdev->base.dev);
> +	drm_dev_exit(idx);
> +	seq_puts(m, seq_buf_str(&sb));
> +	kfree(buf);
> +	return 0;
> +}

[Severity: Medium]
Can status_show() read SGX registers while the core clocks are gated off?

CPU0                              CPU1
pvrsgx_timedout_job()
  mutex_lock(&sdev->reset_lock)
  pvrsgx_fw_start()
    deinit_script()  /* gates clocks */
    fsleep(10000)
                                  status_show()
                                    pm_runtime_get_if_active() > 0
                                    pvrsgx_dump_status(..., true)
                                      if (!READ_ONCE(sdev->powered))
                                      dump_regs()
                                        sgx_rd()  <-- unclocked MMIO read

status_show() does not take sdev->reset_lock, and pvrsgx_fw_start() keeps
sdev->powered set to true while deinit_script() gates SGX_CR_CLKGATECTL and
sleeps for 10 ms during a reset (as well as before SGX_CR_CLKGATECTL is
enabled on runtime resume):

drivers/gpu/drm/powervr_sgx/pvrsgx_fw.c:pvrsgx_fw_start() {
    ...
	WRITE_ONCE(sdev->powered, true);
    ...
		if (was_powered) {
			/* What an unload and reload (which recovers) does in between. */
			deinit_script(sdev);
			sgx_wr(sdev, SGX_CR_SOFT_RESET, cr->soft_reset_bif | cr->soft_reset_core=
s);
			sgx_rd(sdev, SGX_CR_SOFT_RESET);
			/* Behind gma500 bus mastering is the display's too: leave it. */
			if (sdev->pdev)
				pci_clear_master(sdev->pdev);
			fsleep(10000);
    ...
}

In addition, when CONFIG_PM is enabled, pm_runtime_get_if_active() returns
-EINVAL whenever dev->power.disable_depth > 0, which happens during
pm_runtime_force_suspend() and pvrsgx_power_fini().  Treating -EINVAL as
awake lets status_show() read registers concurrently with pvrsgx_fw_stop()
without holding a runtime PM reference, which can hang the bus on CE5300
or OMAP3630.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_drv.c b/drivers/gpu/drm/p=
owervr_sgx/pvrsgx_drv.c
> new file mode 100644
> index 0000000000000..fe996a17f61a5
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_drv.c

[ ... ]

> +	case DRM_POWERVR_SGX_DEV_QUERY_LIMITS_GET: {
> +		/*
> +		 * Render-target limits are not documented: these are the sizes
> +		 * known to work, to be raised when larger targets are tested.
> +		 */
> +		struct drm_powervr_sgx_dev_query_limits lim =3D {
> +			.rt_max_width =3D 2048,
> +			.rt_max_height =3D 2048,
> +			.rt_max_samples =3D sdev->family->cmds->max_samples,
> +			.pb_min_pages =3D 0x100,
> +			.pb_default_pages =3D PVRSGX_PB_DEFAULT_PAGES,
> +			.pb_max_pages =3D pvrsgx_heaps(sdev)->pb_max_pages,

[Severity: Medium]
On SGX530, does reporting PVRSGX_PB_DEFAULT_PAGES (0x1000) for
pb_default_pages exceed pb_max_pages (0x800 in sgx530_heaps)?  Any client
that passes lim.pb_default_pages to DRM_IOCTL_POWERVR_SGX_CREATE_CONTEXT
is rejected with -EINVAL by pvrsgx_ioctl_create_context() because
param_buffer_pages > pvrsgx_heaps(sdev)->pb_max_pages.

[ ... ]

> +static void pvrsgx_postclose(struct drm_device *drm, struct drm_file *fi=
le)
> +{
> +	struct pvrsgx_file *sfile =3D to_pvrsgx_file(file);
> +
> +	pvrsgx_rtds_destroy_all(sfile);
> +	pvrsgx_context_destroy_all(sfile);
> +	pvrsgx_vm_destroy_all(sfile);
> +	xa_destroy(&sfile->rtds);
> +	xa_destroy(&sfile->contexts);
> +	xa_destroy(&sfile->vms);
> +	pvrsgx_usage_put(sfile->usage);
> +	kfree(sfile);
> +	file->driver_priv =3D NULL;
> +}

[ ... ]

> +int pvrsgx_probe_common(struct pvrsgx_device *sdev)
> +{
> +	int err;
> +
> +	err =3D pvrsgx_device_init(sdev);
> +	if (err)
> +		return err;
> +
> +	/* Runtime PM is set up before userspace can reach the device. */
> +	pvrsgx_power_init(sdev);
> +	err =3D drm_dev_register(&sdev->base, 0);
> +	if (err) {
> +		pvrsgx_power_fini(sdev);
> +		pvrsgx_device_unplug(sdev);
> +	}
> +	return err;
> +}
> +
> +void pvrsgx_remove_common(struct pvrsgx_device *sdev)
> +{
> +	/* No new ioctl, and the running ones done, before the hardware goes. */
> +	drm_dev_unplug(&sdev->base);
> +	pvrsgx_power_fini(sdev);
> +	pvrsgx_device_unplug(sdev);
> +}

[Severity: High]
Does calling pvrsgx_power_fini() before pvrsgx_device_unplug() allow the
parent device to runtime-suspend while pvrsgx_fw_stop() is still accessing
SGX registers?

CPU0                              CPU1 (pm_wq)
pvrsgx_of_remove()
  pvrsgx_remove_common()
    pvrsgx_power_fini()
      pm_runtime_disable(dev)
      pm_runtime_set_suspended(dev)
        /* child_count -> 0 */
        pm_request_idle(parent)
                                  rpm_idle(parent)
                                    rpm_suspend(parent)
                                      /* gates SGX clocks */
    pvrsgx_device_unplug()
      pvrsgx_job_unplug()
        pvrsgx_fw_stop()
          sgx_wr() / sgx_rd()  <-- unclocked MMIO access

Unlike pvrsgx_of_probe() and pvrsgx_aux_probe(), pvrsgx_of_remove() and
pvrsgx_aux_remove() do not hold a runtime PM reference on dev->parent.
On non-PCI devices, pvrsgx_power_fini() marks dev RPM_SUSPENDED, which
decrements dev->parent->power.child_count to 0 and schedules
pm_request_idle(dev->parent) before pvrsgx_device_unplug() ->
pvrsgx_job_unplug() -> pvrsgx_fw_stop() runs up to 600 ms of MMIO register
accesses, hanging the SoC or bus if the parent gates the clocks.

In addition, jobs cancelled in pvrsgx_job_unplug() later call
pvrsgx_free_job() -> pvrsgx_power_put() after pvrsgx_power_fini() has
already disabled runtime PM and autosuspend.  Should pvrsgx_device_unplug()
run before pvrsgx_power_fini() in both pvrsgx_remove_common() and the
error path of pvrsgx_probe_common()?

[Severity: High]
Can unreaped per-VM pvrsgx_kobj objects in sdev->graveyard and
sdev->kobj_unmapped create a reference cycle that prevents sdev->base from
ever being freed on device unbind?

Each per-VM pvrsgx_kobj (such as a render context's scratch object or an
RT dataset's objects) holds a reference to struct pvrsgx_vm via
pvrsgx_vm_get(), and vm->gpuvm holds a reference to &sdev->base via
drm_gpuvm_init().  When a client destroys its last render context or
closes its fd, pvrsgx_kobj_release() queues those objects onto
sdev->graveyard, where they stay until a subsequent render and CCB command
reap them:

drivers/gpu/drm/powervr_sgx/pvrsgx_kobj.c:pvrsgx_kobj_release() {
	if (!o)
		return;
	mutex_lock(&o->sdev->kobj_lock);
	o->grave_seq =3D o->sdev->renders_submitted;
	list_add_tail(&o->link, &o->sdev->graveyard);
	mutex_unlock(&o->sdev->kobj_lock);
}

Because pvrsgx_device_unplug() does not call pvrsgx_kobj_reap(sdev,
U64_MAX) (and pvrsgx_kobj_release() still queues onto sdev->graveyard if a
file is closed after unbind), while pvrsgx_kobj_fini() only runs from the
drmm release callback pvrsgx_device_release() once sdev->base's refcount
reaches 0, sdev->base's refcount never drops to 0 and leaks the device,
workqueues, and 16 MiB parameter buffer.

[ ... ]

> +static void pvrsgx_shutdown(struct pci_dev *pdev)
> +{
> +	struct pvrsgx_device *sdev =3D pci_get_drvdata(pdev);
> +
> +	/* Leave the GPU quiet for whatever runs next. */
> +	pvrsgx_fw_stop(sdev);
> +}

[Severity: High]
Can pvrsgx_shutdown() and pvrsgx_of_shutdown() race with pvrsgx_run_job()
or pvrsgx_timedout_job() when stopping the microkernel?

CPU0                              CPU1
pvrsgx_shutdown()
  pvrsgx_fw_stop(sdev)
    /* gates clocks, resets SGX */
                                  pvrsgx_timedout_job()
                                    pvrsgx_coredump()
                                      dump_bif()
                                        sgx_rd()  <-- unclocked MMIO read
                                    pvrsgx_fw_start()
                                      /* re-enables bus master & FW */

Unlike pvrsgx_job_unplug(), which stops sdev->sched, takes
sdev->reset_lock, sets sdev->lost, and cancels sdev->poll_work around
pvrsgx_fw_stop(), pvrsgx_shutdown() and pvrsgx_of_shutdown() call
pvrsgx_fw_stop() directly.  An in-flight or queued job can then access
unclocked registers in pvrsgx_run_job() or pvrsgx_timedout_job(), and a
timeout reset will restart the microkernel and PCI bus mastering after
shutdown.  Also, pvrsgx_aux_driver has no .shutdown callback, leaving the
SGX running across shutdown or kexec on Cedarview.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_pm.c b/drivers/gpu/drm/po=
wervr_sgx/pvrsgx_pm.c
> new file mode 100644
> index 0000000000000..24c93a91b649d
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_pm.c

[ ... ]

> +static int pvrsgx_runtime_suspend(struct device *dev)
> +{
> +	struct pvrsgx_device *sdev =3D dev_get_drvdata(dev);
> +
> +	if (!sdev->lost)
> +		pvrsgx_fw_stop(sdev);
> +	return 0;
> +}
> +
> +static int pvrsgx_runtime_resume(struct device *dev)
> +{
> +	struct pvrsgx_device *sdev =3D dev_get_drvdata(dev);
> +
> +	/* A failed start loses the device: run_job then fails every job with -=
EIO. */
> +	if (!sdev->lost && pvrsgx_fw_start(sdev)) {
> +		drm_err(&sdev->base, "microkernel did not start on resume: device lost=
\n");
> +		sdev->lost =3D true;
> +	}
> +	return 0;
> +}

[Severity: Medium]
When pvrsgx_fw_start() fails in pvrsgx_runtime_resume(), or when
pvrsgx_runtime_suspend() runs after sdev->lost is set, does sdev->powered
stay true while the hardware is left unstopped or unclocked?

pvrsgx_fw_start() sets sdev->powered =3D true and releases SGX_CR_SOFT_RESET
before kicking the microkernel.  If pvrsgx_fw_start() fails in
pvrsgx_runtime_resume(), setting sdev->lost =3D true without calling
pvrsgx_fw_stop() leaves the GPU and PCI bus mastering out of reset while
pvrsgx_ccb_after_invalidate() immediately frees unmapped GEM pages upon
seeing sdev->lost.  Then, when pvrsgx_runtime_suspend() runs (after a
failed resume or a failed reset in pvrsgx_timedout_job()), skipping
pvrsgx_fw_stop() when sdev->lost is true leaves sdev->powered set to true
after the parent suspends and gates the clocks, so any shared interrupt in
pvrsgx_irq() will read SGX_CR_EVENT_STATUS from an unclocked GPU:

drivers/gpu/drm/powervr_sgx/pvrsgx_device.c:pvrsgx_irq() {
	struct pvrsgx_device *sdev =3D arg;
	u32 status;

	if (!READ_ONCE(sdev->powered))
		return IRQ_NONE;
	status =3D sgx_rd(sdev, SGX_CR_EVENT_STATUS);
    ...
}

> +static int pvrsgx_suspend(struct device *dev)
> +{
> +	struct pvrsgx_device *sdev =3D dev_get_drvdata(dev);
> +	int err =3D pvrsgx_job_quiesce(sdev);
> +
> +	if (err)
> +		return err;
> +	err =3D pm_runtime_force_suspend(dev);
> +	if (err)
> +		pvrsgx_job_unquiesce(sdev);
> +	return err;
> +}

[Severity: High]
Can pvrsgx_suspend() race with an in-progress reset in
pvrsgx_timedout_job()?

CPU0                              CPU1
pvrsgx_suspend()
  pvrsgx_job_quiesce()
    dma_fence_wait_timeout(last)
                                  pvrsgx_timedout_job()
                                    mutex_lock(&sdev->reset_lock)
                                    dma_fence_signal(job->hw_fence)
    /* loop i=3D1: last signaled */
    return 0
  pm_runtime_force_suspend()
    pvrsgx_runtime_suspend()
      pvrsgx_fw_stop()            pvrsgx_fw_start()  <-- concurrent stop/st=
art
                                  drm_sched_start()  <-- restarts sched whi=
le suspended

pvrsgx_timedout_job() signals all active jobs' hw_fence (including
sdev->last_fence) before calling pvrsgx_fw_start() and drm_sched_start():

drivers/gpu/drm/powervr_sgx/pvrsgx_job.c:pvrsgx_timedout_job() {
    ...
		dma_fence_set_error(job->hw_fence, -ECANCELED);
		dma_fence_signal(job->hw_fence);
	}
    ...
	if (pvrsgx_fw_start(sdev)) {
    ...
	}
	mutex_unlock(&sdev->reset_lock);
	pvrsgx_kobj_reap(sdev, sdev->renders_submitted);
	pvrsgx_ccb_inval_reap(sdev, true);
	drm_sched_start(&sdev->sched, 0);
    ...
}

As soon as sdev->last_fence is signaled, pvrsgx_job_quiesce() wakes up,
sees dma_fence_is_signaled(last) on its second iteration without taking
sdev->reset_lock, and returns 0 while pvrsgx_timedout_job() is still
inside pvrsgx_fw_start().  pm_runtime_force_suspend() then runs
pvrsgx_fw_stop() concurrently with pvrsgx_fw_start(), and
pvrsgx_timedout_job() calls drm_sched_start() after the device is
suspended.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D12
