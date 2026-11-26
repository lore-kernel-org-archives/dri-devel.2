Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1F8606A323
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SXt5jTJh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E8D310FE50;
	Thu, 26 Nov 2026 07:07:21 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11D1210FE50
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:07:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1579860619;
 Thu, 26 Nov 2026 07:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 653F21F000C0;
 Thu, 26 Nov 2026 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795676832;
 bh=Kd+/NRnMI526H4UnaUPSQs6YIBxSdnHZyazysk+Tnzo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SXt5jTJhAWoOacaSLQ+c66j+vb5sueYMVlUfLJK2XfGLNrOLrYhon43sMlayrHI56
 i5Z1KYExiARRwF/xofvCxlFQXO903ziP45DcVdA2x8Cl31F8+eaMA2i1a5QnANDN0H
 vfNX+QxTs7scQmHV3VPqBsQsBaKs/OZccmSUC5clYKGMafxtiNOF+mdK5//s4+M2Sk
 O3qPvEkjHCBtw/Jt+Z1ebraIcXyn+DVpY65L+qb+8InrLP6jPZksRQ7pv0Gv6cANDY
 JG2so9kqsLYxR5ZIkWKoyn5Cw4P7JUzBkXr7Vp9phBU2fY4w4rZjS+HXYfQNw+Tz9z
 Xj3HelHKQbb9w==
Message-ID: <sashiko-outbox-234931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 18/21] drm/msm/dcp: Add DCP VirtIO driver
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-18-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-18-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:07:11 +0000
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

Thank you for your contribution! Sashiko AI review found 11 potential
issues to consider:
- [High] drm/msm/dcp: component_mutex self-deadlock on bridge cleanup
  during unbind
- [High] drm/msm/dcp: missing GPU split and match checks in
  dcp_component_register()
- [High] drm/msm/dcp: workqueue/kthread leak and UAF from msm_kms_init()
  in probe
- [Medium] drm/msm/dcp: missing 64-bit DMA mask setup in
  dcp_subsystem_dev_init()
- [Medium] drm/msm/dcp: OF node reference leak in dcp_dsi_bridge_init()
  error path
- [Medium] drm/msm/dcp: missing HFI stop and device reset in
  dcp_virtio_shutdown()
- [Medium] drm/msm/dcp: race in dcp_virtio_hfi_cleanup() and freeze()
  re-queues work
- [Medium] drm/msm/dcp: unlocked virtqueue_kick() on resp_vq in probe
  and restore
- [Medium] drm/msm/dcp: unbalanced pm_runtime_disable() on
  dcp_subsystem_dev
- [Medium] drm/msm/dcp: UAF on dcp_crtc and drm_device in HFI event
  callbacks on teardown
- [Low] drm/msm/dcp: missing pm_sleep_ptr() on dcp_virtio_pm_ops and dup
  macro
--

commit 6d25009560449227335c0480569b4d7a329bf13b
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP VirtIO driver

This commit adds the DCP VirtIO function driver to set up DMA/IOMMU
identity, initialize the VirtIO and HFI transport, and register the MSM
DRM component.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_drv.c b/drivers/gpu/drm/msm/dcp/=
dcp_drv.c
> new file mode 100644
> index 0000000000000..62f38dff06ed1
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_drv.c
[ ... ]
> +int dcp_subsystem_dev_init(struct dcp_drv *drv)
> +{
[ ... ]
> +	dev =3D &pdev->dev;
> +
> +	dev->dma_parms =3D &drv->dcp_subsystem_dma_parms;
> +	dma_set_max_seg_size(dev, UINT_MAX);
> +
> +	ret =3D of_dma_configure_id(dev, dcp_subsystem_node, true, NULL);
> +	if (ret) {
> +		dev_err(dev, "of_dma_configure_id failed: %d\n", ret);
> +		goto err_destroy;
> +	}

[Severity: Medium]
Should dcp_subsystem_dev_init() call dma_set_mask_and_coherent(dev, ~0)
after of_dma_configure_id(), the same way msm_drv_probe() configures the
master device?

of_platform_device_create() initializes pdev->dev with a 32-bit DMA mask,
and of_dma_configure_id() does not widen it when no dma-ranges property is
present.  Leaving dcp_subsystem_dev->dev with a 32-bit mask restricts
default-domain IOVA allocations to 32 bits and causes dma_map_sgtable() in
passthrough mode to bounce 4K pages above 4 GiB through SWIOTLB and fail
with -EIO on 2 MiB THP GEM folios.

[ ... ]
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, DCP_DPU_AUTOSUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	drv->dcp_subsystem_dev =3D pdev;
> +	drv->dcp_subsystem_node =3D dcp_subsystem_node;
> +
> +	return 0;
> +
> +err_destroy:
> +	of_platform_device_destroy(dev, NULL);
> +	of_node_put(dcp_subsystem_node);
> +	return ret;
> +}
> +
> +void dcp_subsystem_dev_deinit(struct dcp_drv *drv)
> +{
> +	if (!drv->dcp_subsystem_dev)
> +		return;
> +
> +	pm_runtime_disable(&drv->dcp_subsystem_dev->dev);
> +	of_platform_device_destroy(&drv->dcp_subsystem_dev->dev, NULL);
> +	of_node_put(drv->dcp_subsystem_node);
> +	drv->dcp_subsystem_dev =3D NULL;
> +}

[Severity: Medium]
Does setting dcp_kms->rpm_enabled =3D true in dcp_virtio_probe() cause an
unbalanced pm_runtime_disable() on drv->dcp_subsystem_dev->dev?

dcp_subsystem_dev_init() calls pm_runtime_enable(dev) once, but both
dcp_dpu_kms_destroy() (when dcp_kms->rpm_enabled is set) and
dcp_subsystem_dev_deinit() call pm_runtime_disable() on the same device.
If the DRM aggregate device unbinds or msm_drm_init() fails after
component_bind_all() (for example on -EPROBE_DEFER), dcp_dpu_kms_destroy()
disables the device's only runtime PM enable and clears
dcp_kms->rpm_enabled, so later bind attempts fail in
dcp_dpu_kms_hw_init() -> pm_runtime_resume_and_get() with -EACCES.

[ ... ]
> +int dcp_component_register(struct dcp_drv *drv)
> +{
> +	struct device *dev =3D &drv->dcp_subsystem_dev->dev;
> +	struct component_match *match =3D NULL;
> +	int ret;
> +
> +	ret =3D dcp_dpu_kms_init_dsi_bridges(drv->kms, &match);
> +	if (ret) {
> +		dev_err(dev, "DSI host initialization failed: %d\n", ret);
> +		dcp_dpu_kms_cleanup_bridges(drv->kms);
> +		return ret;
> +	}

[Severity: Medium]
Does dcp_dsi_bridge_init() (called from dcp_dpu_kms_init_dsi_bridges())
leak the dcp_np OF node reference on its error path?

drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c:dcp_dsi_bridge_init() {
	...
	dsi_bridge->dcp_np        =3D of_node_get(dcp_np);
	...
err_unwind_dma:
	...
	mutex_destroy(&dsi_bridge->session_lock);
	mutex_destroy(&dsi_bridge->dcs_lock);
	return ERR_PTR(ret);
}

When dma_alloc_coherent(), device_add() or mipi_dsi_host_register() fails,
dcp_dsi_bridge_init() returns before the bridge is stored in
dcp_kms->dsi_bridge[], so dcp_dpu_kms_cleanup_bridges() cannot release
dsi_bridge->dcp_np either.

> +
> +	/* A GPU is optional for the DCP display-only DRM device. */
> +	ret =3D msm_add_gpu_components(dev, &match);
> +	if (ret)
> +		dev_err(dev, "failed to add GPU components: %d\n", ret);
> +
> +	ret =3D component_master_add_with_match(dev, &msm_drm_ops, match);
> +	if (ret) {
> +		dev_err(dev, "component_master_add_with_match failed: %d\n",
> +			ret);
> +		dcp_dpu_kms_cleanup_bridges(drv->kms);
> +		return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Should msm_add_gpu_components() be guarded by
!msm_separate_gpu_kms_components(), and should match be checked for NULL or
IS_ERR(match) before calling component_master_add_with_match()?

When msm_separate_gpu_kms_components() is true (such as with
separate_gpu_kms=3D1), adreno_probe() probes the GPU as a standalone DRM
device rather than registering a component, so adding the GPU node to match
causes the DCP component master to wait forever for a GPU component that
never appears.  In addition, if no components are added (leaving match
NULL) or drm_of_component_match_add() sets match to ERR_PTR(-ENOMEM),
component_master_add_with_match() immediately dereferences match->num in
component_match_realloc().

> +
> +void dcp_component_unregister(struct dcp_drv *drv)
> +{
> +	struct device *dev =3D &drv->dcp_subsystem_dev->dev;
> +
> +	component_master_del(dev, &msm_drm_ops);
> +	dcp_dpu_kms_cleanup_bridges(drv->kms);
> +}

[Severity: High]
Does component_master_del() self-deadlock on component_mutex when an
attached MIPI DSI panel is cleaned up?

dcp_component_unregister()
  component_master_del()
    mutex_lock(&component_mutex)
    take_down_aggregate_device()
      msm_drm_unbind()
        msm_drm_uninit()
          msm_drm_kms_uninit()
            dcp_dpu_kms_destroy()
              dcp_dpu_kms_cleanup_bridges()
                dcp_dsi_bridge_cleanup()
                  mipi_dsi_host_unregister()
                    ...
                      dcp_dsi_host_detach()
                        component_del()
                          mutex_lock(&component_mutex)  <-- self-deadlock

The same call chain also runs under component_mutex during aggregate
bringup if msm_drm_init() fails after component_bind_all() and unwinds via
msm_drm_uninit(), and msm_drm_kms_uninit() destroys
dsi_bridge->dsi_host_dev before component_unbind_all() unbinds the
component.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_virtio.c b/drivers/gpu/drm/msm/d=
cp/dcp_virtio.c
> new file mode 100644
> index 0000000000000..595e0650103cf
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_virtio.c
[ ... ]
> +static int dcp_virtio_probe(struct virtio_device *vdev)
> +{
[ ... ]
> +	/*
> +	 * Keep the device unready until HFI state and virtqueues are initializ=
ed.
> +	 * KMS registration below depends on synchronous firmware initializatio=
n.
> +	 */
> +	virtio_device_ready(vdev);
> +	virtqueue_kick(drv->hfi->resp_vq);

[Severity: Medium]
Should virtqueue_kick() on resp_vq in dcp_virtio_probe() and
dcp_virtio_restore() be serialized under hfi->resp_drain_lock?

Once virtio_device_ready() enables virtqueue callbacks, an interrupt can
enter dcp_hfi_resp_callback(resp_vq) while process context runs
virtqueue_kick(resp_vq):

dcp_virtio_probe()
  virtio_device_ready(vdev)
  virtqueue_kick(drv->hfi->resp_vq)
    virtqueue_kick_prepare(vq)
      <hardirq>
        dcp_hfi_resp_callback(vq)
          spin_lock_irqsave(&hfi->resp_drain_lock, ...)
          virtqueue_get_buf(vq, ...)
          virtqueue_add_inbuf_premapped(vq, ...)
          virtqueue_kick_prepare(vq)  <-- concurrent vq access

Virtqueues require external serialization; concurrent access races on
vq->num_added and triggers BAD_RING in START_USE(vq) when virtio_ring
debugging is enabled.

[ ... ]
> +	dcp_kms =3D devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*dcp_kms)=
, GFP_KERNEL);
> +	if (!dcp_kms) {
> +		ret =3D -ENOMEM;
> +		goto err_hfi_deinit;
> +	}
> +
> +	dcp_kms->drv       =3D drv;
> +	dcp_kms->pm_dev    =3D &drv->dcp_subsystem_dev->dev;
> +	dcp_kms->hfi       =3D drv->hfi;
> +	dcp_kms->caps      =3D &drv->caps;
> +	dcp_kms->dpus_np   =3D drv->dcp_subsystem_node;
> +	dcp_kms->iommu_dev =3D &drv->dcp_subsystem_dev->dev;
> +	drv->kms        =3D dcp_kms;
> +
> +	ret =3D msm_kms_init(&dcp_kms->base, &dcp_dpu_kms_funcs);
> +	if (ret) {
> +		dev_err(&vdev->dev, "msm_kms_init failed: %d\n", ret);
> +		goto err_hfi_deinit;
> +	}
> +
> +	priv =3D devm_kzalloc(&drv->dcp_subsystem_dev->dev, sizeof(*priv), GFP_=
KERNEL);
> +	if (!priv) {
> +		ret =3D -ENOMEM;
> +		goto err_hfi_deinit;
> +	}
> +
> +	priv->kms      =3D &dcp_kms->base;
> +	priv->kms_init =3D dcp_kms_init;
> +	dev_set_drvdata(&drv->dcp_subsystem_dev->dev, priv);
> +	dcp_kms->rpm_enabled =3D true;
> +
> +	/* Component binding now sees initialized HFI, capabilities, and IOMMU =
state. */
> +	ret =3D dcp_component_register(drv);
> +	if (ret) {
> +		dev_err_probe(&vdev->dev, ret, "component register failed\n");
> +		goto err_hfi_deinit;
> +	}

[Severity: High]
Does calling msm_kms_init() here in dcp_virtio_probe() leak kms->wq and
the pending_timers kthreads, and leave them referencing freed dcp_kms
memory when the component master never binds?

msm_kms_init() allocates kms->wq and spawns MAX_CRTCS atomic-worker
kthreads that hold pointers into dcp_kms->base, but msm_kms_destroy() is
only called from dcp_dpu_kms_destroy() when a bound DRM aggregate device is
torn down.  If dcp_virtio_probe() fails after msm_kms_init(), or if
dcp_virtio_remove() runs while component binding is still pending or
deferred, dcp_subsystem_dev_deinit() destroys drv->dcp_subsystem_dev and
frees the devm-allocated dcp_kms without msm_kms_destroy() ever stopping
the workqueue and kthreads.  Conversely, if a bound component later unbinds
or msm_drm_init() fails after component_bind_all(), dcp_dpu_kms_destroy()
destroys kms->wq and pending_timers, and a subsequent bind retry calls
dcp_kms_init() without re-running msm_kms_init().  Additionally, neither
dcp_dpu_kms_destroy() nor dcp_subsystem_dev_deinit() pairs
pm_runtime_use_autosuspend() with pm_runtime_dont_use_autosuspend().

[ ... ]
> +static void dcp_virtio_hfi_cleanup(struct dcp_drv *drv)
> +{
> +	struct virtio_device *vdev =3D drv->vdev;
> +
> +	if (!drv->hfi)
> +		return;
> +
> +	dcp_hfi_stop(drv->hfi);
> +	virtio_reset_device(vdev);
> +	virtio_synchronize_cbs(vdev);
> +	if (drv->vqs_allocated) {
> +		dcp_hfi_quiesce_queues(drv->hfi);
> +		vdev->config->del_vqs(vdev);
> +		drv->vqs_allocated =3D false;
> +	}
> +	drv->hfi->cmd_vq =3D NULL;
> +	drv->hfi->resp_vq =3D NULL;
> +	dcp_hfi_deinit(drv->hfi);
> +}

[Severity: Medium]
Can an in-flight dcp_hfi_resp_callback() re-queue resource_vote_work or
resp_repost_work after dcp_hfi_stop() cancels them in
dcp_virtio_hfi_cleanup() and dcp_virtio_freeze()?

CPU0                                  CPU1
                                      dcp_hfi_resp_callback()
                                        /* passes shutdown_in_progress */
                                        spin_unlock(&hfi->resp_drain_lock)
dcp_virtio_hfi_cleanup()
  dcp_hfi_stop(drv->hfi)
    atomic_set(&shutdown_in_progress, 1)
    cancel_work_sync(&resource_vote_work)
    cancel_delayed_work_sync(&resp_repost_work)
                                        schedule_work(&resource_vote_work)
                                        schedule_delayed_work(&resp_repost_=
work)
  virtio_reset_device(vdev)
  virtio_synchronize_cbs(vdev)
  ...
  /* devm frees drv->hfi */
                                      dcp_hfi_resource_vote_work()
                                        /* dereferences freed hfi */  <-- u=
se-after-free

Because callbacks are not drained until virtio_synchronize_cbs() returns,
work scheduled by an already-running callback before
virtio_synchronize_cbs() is never cancelled afterward.

[ ... ]
> +static void dcp_virtio_remove(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv =3D vdev->priv;
> +
> +	dev_dbg(&vdev->dev, "DCP VirtIO remove\n");
> +
> +	dcp_component_unregister(drv);
> +	dcp_panic_notifier_unregister(drv);
> +
> +	dcp_virtio_hfi_cleanup(drv);
> +
> +	dcp_subsystem_dev_deinit(drv);
> +}

[Severity: Medium]
Can an HFI display event callback access freed dcp_crtc and drm_device
objects after dcp_component_unregister() returns?

CPU0                                  CPU1
dcp_virtio_remove()
  dcp_component_unregister(drv)
    component_master_del()
      msm_drm_unbind()
        msm_drm_uninit()
          drm_dev_put(ddev)
            /* frees ddev and drmm dcp_crtc */
                                      dcp_hfi_resp_callback()
                                        dcp_crtc_hfi_vblank_cb()
                                          dcp_crtc_find_by_session_id(drv->=
kms, ...)
                                            dcp_crtc_get_session(crtc)
                                              spin_lock(&dcp_crtc->spin_loc=
k)  <-- use-after-free
  dcp_virtio_hfi_cleanup(drv)

dcp_component_unregister() frees ddev and the drmm-allocated dcp_crtc
instances before dcp_virtio_hfi_cleanup() stops HFI, while drv->kms,
dcp_kms->crtcs[], dcp_kms->num_crtcs and dcp_kms->dev remain non-NULL
(which also happens if a sub-component unbinds while VirtIO stays bound).

> +
> +/* KMS shutdown must complete while the firmware transport is available.=
 */
> +static void dcp_virtio_shutdown(struct virtio_device *vdev)
> +{
> +	struct dcp_drv *drv =3D vdev->priv;
> +
> +	pm_runtime_get_sync(&drv->dcp_subsystem_dev->dev);
> +	msm_kms_shutdown(drv->dcp_subsystem_dev);
> +	pm_runtime_put_noidle(&drv->dcp_subsystem_dev->dev);
> +}

[Severity: Medium]
Should dcp_virtio_shutdown() call dcp_hfi_stop(drv->hfi) and
virtio_device_shutdown(vdev) after msm_kms_shutdown()?

When a virtio_driver provides a custom .shutdown callback,
virtio_dev_shutdown() calls drv->shutdown(dev) and skips the default
virtio_device_shutdown(dev) path.  Returning after msm_kms_shutdown()
leaves HFI work items, virtqueue callbacks and DMA rings active across
system shutdown or kexec while IOMMU translation is torn down.

[ ... ]
> +static const struct dev_pm_ops dcp_virtio_pm_ops =3D {
> +	.prepare =3D dcp_pm_prepare,
> +	.complete =3D dcp_pm_complete,
> +};
> +
> +static struct virtio_driver dcp_virtio_driver =3D {
> +	.driver =3D {
> +		.name  =3D "qcom-dcp-hfi",
> +		.owner =3D THIS_MODULE,
> +		.pm    =3D &dcp_virtio_pm_ops,
> +	},

[Severity: Low]
This isn't a bug, but dcp_virtio_pm_ops and .driver.pm can use
pm_sleep_ptr() and pm_ptr() so the PM callbacks are dropped when PM is
disabled.  Also, DCP_DPU_AUTOSUSPEND_DELAY_MS in dcp_drv.c duplicates the
definition in dcp_dpu_kms.h, and struct component_match in dcp_drv.h is
unused.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D18
