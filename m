Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F337606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIdNBSoq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53CC610FD3D;
	Thu, 26 Nov 2026 07:03:30 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8003310FD3D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:03:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E72944879;
 Thu, 26 Nov 2026 07:03:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD461F000C6;
 Thu, 26 Nov 2026 07:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795676604;
 bh=leV8fysZ0yZjoMqKTw945SOl5gehj0RLmxn+dSyoS+M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LIdNBSoqRCpidO8Qc/TF9E7ko9Ly9FKj7V+Ilr/XWmGSKeGBNYSpFCvm7pjf5RIwx
 5es/KDBlGZMFlf2L68PAWCgjy/qHTo1++KRGcjyFhRHLVwWaK8SsoivUqMMh2BTTzb
 70JiG6tLm8vpQL5NuTPmnJWCihDCFT2ZucLVJ4zs2XTEtRwhiRQ6haQidoGk38IyS9
 Ayj310nBTGMZ8R5wrEQHZ3Oh4I/LuTRh3DCLodjBC4kcgdtcGPlD82b5am6Tq4HQcS
 d2a4UtKzWUI2KPTa71jq1H7y9a21RaI3QvqAJy+YBpzekKTbt5kIzQQyDTz3uJzf6g
 HtEAcSENqFUOw==
Message-ID: <sashiko-outbox-234926@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 16/21] drm/msm/dcp: Register DCP display pipeline
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-16-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-16-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:03:23 +0000
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

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] drm/msm/dcp: deadlock in dcp_dpu_kms_cleanup_bridges() under
  component_mutex
- [High] drm/msm/dcp: race and runtime PM leak in
  dcp_dpu_kms_enable_commit()
- [High] drm/msm/dcp: unbalanced KMS and runtime PM teardown in
  dcp_dpu_kms_destroy()
- [High] drm/msm/dcp: dangling CRTC and drm_device pointers in
  dcp_dpu_kms_destroy()
- [High] drm/msm/dcp: missing remote endpoint check in
  dcp_dpu_kms_init_dsi_bridges()
- [Medium] drm/msm/dcp: mismatched CRTC/encoder ordering and unclamped
  possible_crtcs
- [Medium] drm/msm/dcp: stale error in ret after continue in
  dcp_dpu_kms_setup_bridges()
- [Medium] drm/msm/dcp: unreserved DCS buffer IOVAs in kms->vm and late
  hfi check
- [Medium] drm/msm/dcp: missing remote endpoint check in
  dcp_dpu_kms_init_dsi_bridges()
--

commit 2186cfdbd849f345868626184491e6057a461eb9
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Register DCP display pipeline

This commit registers the DCP KMS display pipeline by initializing power
management and the display IOMMU domain, parsing firmware capabilities and
the device-tree display graph, and creating the DRM bridges, encoders,
connectors, planes, and CRTCs.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c b/drivers/gpu/drm/msm/=
dcp/dcp_dpu_kms.c
> index 61a4d85653594..a8c04022d6cd5 100644
> --- a/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dpu_kms.c
[ ... ]
> +void dcp_dpu_kms_cleanup_bridges(struct dcp_dpu_kms *dcp_kms)
> +{
> +	u32 i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
> +		if (!dcp_kms->dsi_bridge[i])
> +			continue;
> +
> +		dcp_dsi_bridge_cleanup(dcp_kms->dsi_bridge[i]);
> +		dcp_kms->dsi_bridge[i] =3D NULL;
> +	}
> +}

[Severity: High]
Does calling dcp_dpu_kms_cleanup_bridges() from dcp_dpu_kms_setup_bridges(),
dcp_dpu_setup_pipeline(), and dcp_dpu_kms_destroy() deadlock on
component_mutex?

Both component master bind (try_to_bring_up_aggregate_device() ->
msm_drm_bind() -> ... -> dcp_dpu_kms_hw_init()) and unbind
(take_down_aggregate_device() -> msm_drm_unbind() -> msm_drm_uninit() ->
dcp_dpu_kms_destroy()) run while the global component_mutex is held.  When a
DSI peripheral is attached, dcp_dsi_bridge_cleanup() unregisters the DSI ho=
st
and detaches the device, which re-enters component_del():

try_to_bring_up_aggregate_device() / take_down_aggregate_device()
  mutex_lock(&component_mutex)
  ...
    dcp_dpu_kms_cleanup_bridges()
      dcp_dsi_bridge_cleanup()
        mipi_dsi_host_unregister()
          ...
            dcp_dsi_host_detach()
              component_del()
                mutex_lock(&component_mutex)  <-- self-deadlock

In addition, msm_drm_uninit() calls dcp_dpu_kms_destroy() before
component_unbind_all() and drm_dev_put(), so dcp_dsi_bridge_cleanup() delet=
es
dsi_host_dev while it is still bound as a component and attached to the
encoder bridge chain.  Destroying and clearing dcp_kms->dsi_bridge[] in
dcp_dpu_kms_setup_bridges() when drm_bridge_attach() returns -EPROBE_DEFER
also permanently removes the bridges created prior to
component_master_add_with_match(), causing subsequent deferred probe retries
to fail with -ENODEV.

[ ... ]

> +static int dcp_dpu_kms_hw_init(struct msm_kms *kms)
> +{
[ ... ]
> +	vm =3D msm_kms_init_vm(dev, NULL);
> +	if (IS_ERR(vm)) {
> +		drm_err(dev, "SMMU/IOMMU init failed: %pe\n", vm);
> +		ret =3D PTR_ERR(vm);
> +		goto err_cleanup;
> +	}
> +	kms->vm =3D vm;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
> +		if (!dcp_kms->dsi_bridge[i])
> +			continue;
> +
> +		ret =3D dcp_dsi_bridge_map_buffers(dcp_kms->dsi_bridge[i]);
> +		if (ret) {
> +			drm_err(dev, "failed to map DSI%u DCS buffers: %d\n", i, ret);
> +			goto err_cleanup;
> +		}
> +	}
> +
> +	if (!dcp_kms->hfi) {
> +		drm_err(dev, "HFI unavailable, cannot initialize DCP KMS\n");
> +		ret =3D -ENODEV;
> +		goto err_cleanup;
> +	}

[Severity: Medium]
Can GEM scanout buffer allocations in kms->vm collide with the dual-mapped
DSI DCS buffer IOVAs?

msm_kms_init_vm() initializes kms->vm's drm_mm allocator across the full
[0x1000, 0x100000000) range, and dcp_dsi_bridge_map_buffers() then maps
dcs_tx_iova and dcs_rx_iova directly into the underlying display IOMMU doma=
in
without reserving those ranges in to_msm_vm(kms->vm)->mm.  Subsequent scano=
ut
VMA allocations from kms->vm can pick overlapping IOVAs and fail
iommu_map_sgtable() with -EEXIST.

Also, dcp_dsi_bridge_map_buffers() dereferences dcp_kms->hfi->dma_dev before
 the !dcp_kms->hfi check right below it.

[ ... ]

> +static void dcp_dpu_kms_enable_commit(struct msm_kms *kms)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D to_dcp_dpu_kms(kms);
> +	int ret;
> +
> +	ret =3D pm_runtime_resume_and_get(dcp_kms->pm_dev);
> +	if (ret < 0) {
> +		dcp_kms->commit_pm_active =3D false;
> +		drm_err_ratelimited(dcp_kms->dev,
> +				    "pm_runtime_resume_and_get failed: %d\n",
> +				    ret);
> +		return;
> +	}
> +
> +	dcp_kms->commit_pm_active =3D true;
> +}
> +
> +static void dcp_dpu_kms_disable_commit(struct msm_kms *kms)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D to_dcp_dpu_kms(kms);
> +
> +	if (dcp_kms->commit_pm_active) {
> +		pm_runtime_put_autosuspend(dcp_kms->pm_dev);
> +		dcp_kms->commit_pm_active =3D false;
> +	}
> +}

[Severity: High]
Can overlapping commits race on dcp_kms->commit_pm_active, causing false
-EIO commit aborts and leaking runtime PM references on dcp_kms->pm_dev?

msm_atomic_commit_tail() calls kms->funcs->enable_commit() before acquiring
per-CRTC locks and calls disable_commit() after releasing them, and commits
on different CRTCs or async commit workers run concurrently:

CPU0 (commit A)                   CPU1 (commit B)
dcp_dpu_kms_enable_commit()
  pm_runtime_resume_and_get()
  dcp_kms->commit_pm_active =3D true
                                  dcp_dpu_kms_enable_commit()
                                    pm_runtime_resume_and_get()
                                    dcp_kms->commit_pm_active =3D true
dcp_dpu_kms_disable_commit()
  pm_runtime_put_autosuspend()
  dcp_kms->commit_pm_active =3D false
                                  dcp_crtc_atomic_begin()
                                    if (!dcp_kms->commit_pm_active)
                                      cstate->hfi_error =3D -EIO;  <-- abor=
ts
                                  dcp_dpu_kms_disable_commit()
                                    if (dcp_kms->commit_pm_active)
                                      /* false: skips put, leaks RPM ref */

Because commit_pm_active is a single unsynchronized boolean rather than a
per-commit status or reference count, the first commit to finish clears
commit_pm_active while the second commit is still in flight.

[ ... ]

> +static void dcp_dpu_kms_destroy(struct msm_kms *kms)
> +{
> +	struct dcp_dpu_kms *dcp_kms =3D to_dcp_dpu_kms(kms);
> +
> +	dcp_dpu_kms_cleanup_bridges(dcp_kms);
> +
> +	if (kms->vm) {
> +		struct msm_gem_vm *msm_vm =3D to_msm_vm(kms->vm);
> +
> +		if (msm_vm->mmu && msm_vm->mmu->funcs->detach) {
> +			drm_dbg_driver(dcp_kms->dev,
> +				       "detaching IOMMU domain from dcp-dpus\n");
> +			msm_vm->mmu->funcs->detach(msm_vm->mmu);
> +		}
> +
> +		drm_gpuvm_put(kms->vm);
> +		kms->vm =3D NULL;
> +	}
> +
> +	if (dcp_kms->rpm_enabled) {
> +		pm_runtime_disable(dcp_kms->pm_dev);
> +		dcp_kms->rpm_enabled =3D false;
> +	}
> +
> +	msm_kms_destroy(&dcp_kms->base);
> +}

[Severity: High]
Does tearing down runtime PM and msm_kms in dcp_dpu_kms_destroy() leave
kms->wq and kms->pending_timers[] freed and runtime PM disabled if component
bind is retried?

pm_runtime_enable() and msm_kms_init() are called once during
dcp_virtio_probe(), not in dcp_kms_init().  When component bind fails or
defers in msm_drm_init(), msm_drm_uninit() invokes dcp_dpu_kms_destroy(),
which disables runtime PM on dcp_kms->pm_dev and destroys kms->wq and
kms->pending_timers[].  A subsequent bind retry in dcp_kms_init() does not
re-enable runtime PM or reinitialize msm_kms, leading to use-after-free and
double destruction of kms->wq and kms->pending_timers[]; on driver removal,
dcp_subsystem_dev_deinit() also calls pm_runtime_disable() a second time on
dcp_subsystem_dev->dev.

[ ... ]

> +int dcp_dpu_kms_init_dsi_bridges(struct dcp_dpu_kms *dcp_kms,
> +				 struct component_match **matchptr)
> +{
> +	struct device_node *dpu_np =3D dcp_kms->dpus_np;
> +	struct device_node *ep_np, *dsi_np, *child_np, *proto_np;
> +	struct of_endpoint ep;
> +	int ret;
> +
> +	for_each_of_graph_port(dpu_np, port_np) {
> +		u32 intf_idx, dsi_idx, fw_display_id;
> +		struct drm_bridge *bridge;
> +
> +		ep_np =3D of_get_next_child(port_np, NULL);
> +		if (!ep_np)
> +			continue;
> +
> +		ret =3D of_graph_parse_endpoint(ep_np, &ep);
> +		of_node_put(ep_np);
> +		if (ret)
> +			continue;

[Severity: High]
Should dcp_dpu_kms_init_dsi_bridges() skip ports whose remote endpoint is
absent or disabled, the same way dcp_dpu_kms_setup_bridges() does?

Without checking of_graph_get_remote_port_parent(ep_np) and
of_device_is_available(remote_np), any unpopulated or disabled port in the
device tree still initializes dcp_kms->dsi_bridge[dsi_idx] and adds dsi_np =
to
matchptr.  Because no panel attaches to that DSI host to call component_add=
(),
the component master never binds; and if a lower-indexed dsi_bridge[] slot =
is
populated for an inactive port, dcp_dpu_setup_pipeline() later creates CRTCs
from dsi_bridge[] in index order for the wrong fw_display_id.

[ ... ]

> +		dcp_kms->dsi_bridge[dsi_idx] =3D to_dcp_dsi_bridge(bridge);
> +		drm_of_component_match_add(dcp_kms->pm_dev, matchptr,
> +					   component_compare_of, dsi_np);
> +		of_node_put(dsi_np);
> +	}

[Severity: Medium]
Does adding dsi_np to matchptr here without verifying that the port has an
available remote endpoint prevent the aggregate DRM device from binding on
boards with unused or disabled DSI ports?

dcp_dpu_kms_setup_bridges() checks of_graph_get_remote_port_parent() and
of_device_is_available() before using a port, so dcp_dpu_kms_init_dsi_bridg=
es()
needs the same check before registering dsi_bridge[dsi_idx] and its compone=
nt
match entry.

[ ... ]

> +static int dcp_dpu_kms_setup_bridges(struct dcp_dpu_kms *dcp_kms,
> +				     struct device_node *dpu_np)
> +{
[ ... ]
> +	for_each_of_graph_port(dpu_np, port_np) {
> +		ep_np =3D of_get_next_child(port_np, NULL);
> +		if (!ep_np)
> +			continue;
> +
> +		ret =3D of_graph_parse_endpoint(ep_np, &ep);
> +		if (ret) {
> +			of_node_put(ep_np);
> +			continue;
> +		}
[ ... ]
> +	}
> +
> +out:
> +	if (ret)
> +		dcp_dpu_kms_cleanup_bridges(dcp_kms);
> +	return ret;
> +}

[Severity: Medium]
If of_graph_parse_endpoint() fails on a port and the loop skips it with
continue, can a stale negative ret cause dcp_dpu_kms_setup_bridges() to fail
at out:?

When no later port reaches drm_bridge_attach() to overwrite ret (for exampl=
e,
if the failing port is the last port or subsequent ports also hit continue),
dcp_dpu_kms_setup_bridges() treats the leftover ret as fatal and cleans up =
all
bridges.

> +
> +static int dcp_dpu_setup_pipeline(struct dcp_dpu_kms *dcp_kms,
> +				  struct device_node *dpu_np)
> +{
[ ... ]
> +	for (i =3D 0; i < total_planes; i++) {
> +		enum drm_plane_type type;
> +		unsigned long possible_crtcs;
> +
> +		possible_crtcs =3D ((1UL << max_crtc_count) - 1)
> +				 << dev->mode_config.num_crtc;
[ ... ]
> +		if (type =3D=3D DRM_PLANE_TYPE_PRIMARY)
> +			primary_planes[primary_idx++] =3D plane;
> +	}
> +
> +	max_crtc_count =3D min(max_crtc_count, primary_idx);
> +
> +	dcp_kms->num_crtcs =3D 0;
> +	for (i =3D 0; i < ARRAY_SIZE(dcp_kms->dsi_bridge); i++) {
> +		u32 display_id;
> +
> +		if (dcp_kms->num_crtcs >=3D max_crtc_count)
> +			break;
> +		if (!dcp_kms->dsi_bridge[i])
> +			continue;
[ ... ]
> +		dcp_kms->crtcs[dcp_kms->num_crtcs].crtc =3D crtc;
> +		dcp_kms->crtcs[dcp_kms->num_crtcs++].display_id =3D display_id;
> +	}
[ ... ]
> +}
> +
> +int dcp_dpu_drm_obj_init(struct dcp_dpu_kms *dcp_kms)
> +{
[ ... ]
> +	/* v1 - Encoders map one-to-one to CRTCs; cloning is unsupported. */
> +	drm_for_each_encoder(encoder, dev) {
> +		encoder->possible_crtcs =3D BIT(enc_idx);
> +		encoder->possible_clones =3D 0;
> +		enc_idx++;
> +	}

[Severity: Medium]
Can encoder->possible_crtcs and plane->possible_crtcs reference the wrong
CRTC or a non-existent CRTC index?

dcp_dpu_kms_setup_bridges() creates encoders in DT port (intf_idx) order for
active remote endpoints, whereas dcp_dpu_setup_pipeline() creates CRTCs by
iterating dcp_kms->dsi_bridge[] in dsi_idx order without checking whether an
encoder was attached to dsi_bridge[i].  If DT port order differs from dsi_i=
dx
order or dsi_bridge[0] has no encoder attached, encoder->possible_crtcs =3D
BIT(enc_idx) pairs the encoder with a CRTC whose display_id does not match
its bridge's fw_display_id.

In addition, if max_crtc_count is clamped below the encoder count by
caps->num_displays or primary_idx, encoder->possible_crtcs =3D BIT(enc_idx)=
 and
the plane possible_crtcs mask (computed before max_crtc_count is clamped to
primary_idx) set bits for CRTCs that were never created, triggering a WARN =
in
drm_mode_config_validate().

[ ... ]

> +int dcp_kms_init(struct drm_device *ddev)
> +{
> +	struct msm_drm_private *priv =3D ddev->dev_private;
> +	struct dcp_dpu_kms *dcp_kms =3D to_dcp_dpu_kms(priv->kms);
> +	struct dcp_drv *drv =3D dcp_kms->drv;
> +
> +	dcp_kms->dev =3D ddev;
> +	if (drv) {
> +		drv->kms =3D dcp_kms;
> +		dcp_kms->pm_dev =3D &drv->dcp_subsystem_dev->dev;
> +	}
> +
> +	if (!dcp_kms->hfi)
> +		return -ENODEV;
> +	if (!dcp_kms->caps)
> +		return -ENODEV;
> +
> +	return 0;
> +}

[Severity: High]
Does leaving drv->kms, dcp_kms->dev, dcp_kms->crtcs[], and dcp_kms->num_crt=
cs
populated across dcp_dpu_setup_pipeline() failure or dcp_dpu_kms_destroy()
expose freed drmm CRTCs and drm_device to use-after-free in HFI callbacks?

dcp_crtc_init() allocates CRTCs with drmm_kzalloc(ddev, ...), so
msm_drm_uninit() frees them and ddev in drm_dev_put(ddev) right after calli=
ng
dcp_dpu_kms_destroy(), while dcp_kms and drv remain alive and the VirtIO HFI
queues are not stopped until dcp_virtio_hfi_cleanup().  Because
dcp_crtc_hfi_vblank_cb() and dcp_crtc_hfi_frame_done_cb() only check
if (!drv || !drv->kms) before scanning drv->kms->crtcs[] and logging with
drv->kms->dev, an incoming HFI event after teardown or bind failure will
dereference freed CRTC and drm_device memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D16
