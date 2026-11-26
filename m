Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37959606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eOrSNW+3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6968010FFFE;
	Thu, 26 Nov 2026 07:06:51 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64D46112096
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 07:06:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 34536461FD;
 Thu, 26 Nov 2026 07:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AD81F000C0;
 Thu, 26 Nov 2026 07:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795676804;
 bh=g/tc4F23xB7BC7CIDStDpeDAOzV5GYMfKxDDACDGb3Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eOrSNW+3SSbEymwJsx7gtQEjqBEoNQlCsqGgUliPWZ2QsPYFynQvtYTn2R8qob/Q0
 DIzsxmDwUQaB3oB9G3b/jdQvTSoD++kYGPGQF1ZF6Z0xS5vwn+d/Dc4JSkbhqG38zI
 a+MuSA9nrjQUqtVCOdbmtABRtn6qlrrALT/6/O5msZ1mRTcH6cmmbCOIxXQmfSkYms
 gV4yRs1rdp29g9fdNEr8V4Lpi40JmbUsE3YthK6IHW92Og6/X4J4mxE56dF11jLXkD
 efX+BvVM6V8qSL9DU//e+glq175q06oXjcrpqQmB46xG8B7GFFdQszMQctTWBjAP3l
 ZqEDSsLCMDaWg==
Message-ID: <sashiko-outbox-234929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/21] drm/msm/dcp: Add DCP DSI host and panel support
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-14-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-14-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 07:06:43 +0000
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

Thank you for your contribution! Sashiko AI review found 13 potential
issues to consider:
- [High] drm/msm/dcp: component_mutex deadlock and unsafe teardown in
  dcp_dsi_bridge_cleanup()
- [High] drm/msm/dcp: missing IOMMU_CACHE when dual-mapping DCS buffers
  in dcp_dsi_bridge_map_buffers()
- [High] drm/msm/dcp: off-by-one DSC chroma and color space in
  dcp_hfi_dsi_configure()
- [Medium] drm/msm/dcp: duplicate dsi_host_dev name from %pOFn in
  dcp_dsi_bridge_init()
- [Medium] drm/msm/dcp: leak of dcp_np OF node on error in
  dcp_dsi_bridge_init()
- [Medium] drm/msm/dcp: missing session_lock in
  dcp_dsi_bridge_atomic_enable()
- [Medium] drm/msm/dcp: disjoint refcounting of bridge and dsi_host_dev
  in dcp_dsi_bridge
- [Medium] drm/msm/dcp: DSI host registered before bridge setup in
  dcp_dsi_bridge_init()
- [Medium] drm/msm/dcp: unsafe teardown and dangling buffer in
  dcp_dsi_bridge_cleanup()
- [Medium] drm/msm/dcp: unreserved display IOMMU IOVA mapping in
  dcp_dsi_dual_map_buf()
- [Medium] drm/msm/dcp: missing dcs_mapped check and wrong read return
  in dcp_dsi_host_transfer()
- [Medium] drm/msm/dcp: skipped post_disable on temporary session in
  dcp_dsi_host_transfer()
- [Medium] drm/msm/dcp: wrong byte count returned for DSI reads in
  dcp_dsi_host_transfer()
--

commit 1336be8e10388bb4c1fe0a4b1f9783fbef0b40b6
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add DCP DSI host and panel support

This commit adds the DCP DSI DRM bridge, MIPI DSI host, DSC configuration,
DCS command transfers, and dual-mapped DMA buffer management for DSI
displays.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c b/drivers/gpu/drm/m=
sm/dcp/dcp_dsi_bridge.c
> new file mode 100644
> index 0000000000000..93d545a558da2
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_bridge.c

[ ... ]

> +static void dcp_dsi_host_dev_release(struct device *dev)
> +{
> +	of_node_put(dev->of_node);
> +}

[Severity: Medium]
Can struct dcp_dsi_bridge be freed while dsi_host_dev still has active
references?

dcp_dsi_bridge_init() allocates struct dcp_dsi_bridge with
devm_drm_bridge_alloc(), which frees the container as soon as
dsi_bridge->bridge.refcount drops to zero, while also embedding struct
device dsi_host_dev by value with its own kobject refcount.  Because
dsi_host_dev does not hold a drm_bridge_get() reference released in
dcp_dsi_host_dev_release(), any reference to dsi_host_dev that outlives
bridge.refcount during probe failure or unbind causes device_release()
and dcp_dsi_host_dev_release() to access freed memory.

[ ... ]

> +static int dcp_dsi_host_detach(struct mipi_dsi_host *host,
> +			       struct mipi_dsi_device *dsi)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D to_dcp_dsi_host(host);
> +
> +	component_del(&dsi_bridge->dsi_host_dev, &dcp_dsi_component_ops);
> +	dsi_bridge->dsi_device =3D NULL;
> +	return 0;
> +}
> +
> +static ssize_t dcp_dsi_host_transfer(struct mipi_dsi_host *host,
> +				     const struct mipi_dsi_msg *msg)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D to_dcp_dsi_host(host);
> +	struct dcp_dpu_kms *kms =3D dsi_bridge->kms;
> +	u32 session_id;
> +	bool temporary_session =3D false;
> +	ssize_t ret;
> +
> +	guard(mutex)(&dsi_bridge->session_lock);
> +	if (!dsi_bridge->dcs_tx_buf)
> +		return -ENODEV;

[Severity: Medium]
Should dcp_dsi_host_transfer() also check dsi_bridge->dcs_mapped before
submitting a transfer?

dcp_dsi_bridge_init() registers the MIPI DSI host before
dcp_dsi_bridge_map_buffers() maps dcs_tx_iova and dcs_rx_iova into the
display IOMMU domain, and dcp_dsi_bridge_unmap_buffers() unmaps them while
leaving dcs_tx_buf non-NULL, so a transfer during those windows passes
unmapped IOVAs to the display domain.

> +
> +	/* Serialize DCS transfers */
> +	guard(mutex)(&dsi_bridge->dcs_lock);
> +
> +	if (dsi_bridge->session_open) {
> +		session_id =3D dsi_bridge->session_id;
> +	} else {
> +		/*
> +		 * mipi_dsi_host_ops::transfer() may be called while the host is
> +		 * disabled. Open a transaction-only DCP session in that case;
> +		 * atomic_pre_enable() will create the full display session later.
> +		 */
> +		ret =3D dcp_hfi_display_enable(kms->hfi, dsi_bridge->intf_idx,
> +					     dsi_bridge->fw_display_id,
> +					     &session_id);
> +		if (ret)
> +			return ret;
> +
> +		temporary_session =3D true;
> +	}
> +
> +	ret =3D dcp_hfi_dcs_transfer(kms->hfi, session_id, msg,
> +				   dsi_bridge->dcs_tx_buf, dsi_bridge->dcs_tx_iova,
> +				   dsi_bridge->dcs_rx_buf, dsi_bridge->dcs_rx_iova, 0,
> +				   dsi_bridge->hfi_config.ctrl_indices[0]);

[Severity: Medium]
Does dcp_dsi_host_transfer() return the wrong byte count for DSI read
packets?

mipi_dsi_host_ops::transfer() must return the number of bytes received for
read packets, but dcp_hfi_dcs_transfer() always returns msg->tx_len even
when msg->rx_len > 0 (and rejects 0-parameter generic packets where
msg->tx_len =3D=3D 0 with -EINVAL):

drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c:dcp_hfi_dcs_transfer() {
    ...
	if (!msg || !msg->tx_buf || !msg->tx_len)
		return -EINVAL;
    ...
	if (msg->rx_len > 0)
		memcpy(msg->rx_buf, rx_buf, msg->rx_len);

	return msg->tx_len;
}

Callers of mipi_dsi_dcs_read() or mipi_dsi_generic_read() that compare the
return value against the requested rx_len will treat the read as failed.

> +	if (temporary_session) {
> +		int cleanup_ret =3D dcp_hfi_display_disable(kms->hfi, session_id);
> +
> +		if (!cleanup_ret)
> +			cleanup_ret =3D dcp_hfi_display_post_disable(kms->hfi, session_id);

[Severity: Medium]
If dcp_hfi_display_disable() fails on a temporary session, does skipping
dcp_hfi_display_post_disable() leak the session in firmware?

Unlike the rollback path in dcp_dsi_bridge_atomic_enable() and the normal
disable flow, gating dcp_hfi_display_post_disable() on !cleanup_ret leaves
the temporary session open in firmware after session_id is discarded.

[ ... ]

> +int dcp_dsi_bridge_prepare_session(struct dcp_dsi_bridge *dsi_bridge,
> +				   const struct drm_display_mode *mode)
> +{
> +	struct dcp_dpu_kms *kms =3D dsi_bridge->kms;
> +	struct dcp_dsi_bridge_state *state =3D dcp_dsi_bridge_get_state(dsi_bri=
dge);
> +	struct dcp_dsi_hfi_config cfg;
> +	int ret;
> +	u32 opened_session_id;
> +
> +	if (!mode)
> +		return -ENODEV;
> +
> +	guard(mutex)(&dsi_bridge->session_lock);
> +	if (dsi_bridge->session_open)
> +		return 0;
> +
> +	dsi_bridge->session_id =3D dsi_bridge->fw_display_id;
> +
> +	if (!dsi_bridge->dsi_device)
> +		return -ENODEV;
> +
> +	dcp_dsi_bridge_build_hfi_config(dsi_bridge, state, &cfg);
> +	/* Publish checked DSC values for the panel's PPS command. */
> +	if (dsi_bridge->dsi_device->dsc)
> +		*dsi_bridge->dsi_device->dsc =3D state->dsc;
> +
> +	ret =3D dcp_hfi_dsi_configure(kms->hfi, dsi_bridge->dsi_idx,
> +				    mode,
> +				    dsi_bridge->dsi_device,
> +				    &cfg);

[Severity: High]
When cfg.dsc is populated here, does dcp_hfi_dsi_configure() send
off-by-one 0-based chroma_format and color_space values to firmware?

dcp_hfi_dsi_configure() encodes 0, 1, 2 for chroma_format and 0, 1 for
color_space:

drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c:dcp_hfi_dsi_configure() {
    ...
		u32 chroma_format =3D 0;
		u32 color_space =3D 0;

		if (cfg->dsc->native_422)
			chroma_format =3D 1;
		else if (cfg->dsc->native_420)
			chroma_format =3D 2;
		if (cfg->dsc->native_422 || cfg->dsc->native_420)
			color_space =3D 1;
    ...
}

However, the HFI protocol enums in
drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h are 1-based
(HFI_PANEL_CHROMA_FORMAT_444 =3D 1, HFI_PANEL_CHROMA_FORMAT_422 =3D 2,
HFI_PANEL_CHROMA_FORMAT_420 =3D 3, and HFI_PANEL_COLOR_SPACE_RGB =3D 1,
HFI_PANEL_COLOR_SPACE_YUV =3D 2), so DSC panels receive invalid 0 values for
RGB 4:4:4 or mismatched formats for YUV 4:2:2/4:2:0.

[ ... ]

> +static void dcp_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
> +					     struct drm_atomic_commit *state)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D to_dcp_dsi_bridge(bridge);
> +	int ret;
> +
> +	ret =3D dsi_bridge->session_open ? 0 : -ENODEV;
> +	dcp_dsi_bridge_get_state(dsi_bridge)->prepare_error =3D ret;
> +	if (ret)
> +		drm_err(bridge->dev, "INTF%u: session prepare failed: %d\n",
> +			dsi_bridge->intf_idx, ret);
> +}
> +
> +static void dcp_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge =3D to_dcp_dsi_bridge(bridge);
> +	struct dcp_dpu_kms *kms =3D dsi_bridge->kms;
> +	int ret;
> +
> +	drm_dbg_driver(kms->dev,
> +		       "INTF%u: bridge atomic_enable (session_id=3D%u)\n",
> +		       dsi_bridge->intf_idx, dsi_bridge->session_id);
> +
> +	if (dcp_dsi_bridge_get_state(dsi_bridge)->prepare_error)
> +		return;
> +	if (!dsi_bridge->session_open)
> +		return;
> +
> +	ret =3D dcp_hfi_display_post_enable(kms->hfi, dsi_bridge->session_id);
> +	if (ret) {
> +		drm_err(bridge->dev,
> +			"INTF%u: HFI DISPLAY_POST_ENABLE failed: %d\n",
> +			dsi_bridge->intf_idx, ret);
> +		goto err_disable;
> +	}

[ ... ]

> +err_deregister_scan_complete:
> +	dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
> +					 HFI_EVENT_FRAME_SCAN_COMPLETE);
> +err_deregister_scan_start:
> +	dcp_hfi_display_event_deregister(kms->hfi, dsi_bridge->session_id,
> +					 HFI_EVENT_FRAME_SCAN_START);
> +err_disable:
> +	drm_err(bridge->dev,
> +		"INTF%u: bridge enable failed; rolling back session\n",
> +		dsi_bridge->intf_idx);
> +	ret =3D dcp_hfi_display_disable(kms->hfi, dsi_bridge->session_id);
> +	if (ret)
> +		drm_warn(bridge->dev,
> +			 "INTF%u: rollback DISPLAY_DISABLE failed: %d\n",
> +			 dsi_bridge->intf_idx, ret);
> +	ret =3D dcp_hfi_display_post_disable(kms->hfi, dsi_bridge->session_id);
> +	if (ret)
> +		drm_warn(bridge->dev,
> +			 "INTF%u: rollback DISPLAY_POST_DISABLE failed: %d\n",
> +			 dsi_bridge->intf_idx, ret);
> +	scoped_guard(mutex, &dsi_bridge->session_lock) {
> +		dsi_bridge->session_id   =3D 0;
> +		dsi_bridge->session_open =3D false;
> +	}
> +	dcp_dsi_bridge_clear_session(dsi_bridge);
> +}

[Severity: Medium]
Can dcp_dsi_host_transfer() race with dcp_dsi_bridge_atomic_enable()
because session_lock is not held here?

CPU0                                    CPU1
dcp_dsi_bridge_atomic_enable()
  dcp_hfi_display_post_enable() fails
  err_disable:
  dcp_hfi_display_disable(session_id)
  dcp_hfi_display_post_disable(session_id)
                                        dcp_dsi_host_transfer()
                                          guard(mutex)(&session_lock)
                                          if (dsi_bridge->session_open)
                                            session_id =3D dsi_bridge->sess=
ion_id
                                          dcp_hfi_dcs_transfer(..., session=
_id)
                                            <-- uses closed session_id
  scoped_guard(mutex, &session_lock)
    dsi_bridge->session_id =3D 0
    dsi_bridge->session_open =3D false

Neither dcp_dsi_bridge_atomic_pre_enable() nor
dcp_dsi_bridge_atomic_enable() holds session_lock while reading or rolling
back session_open and session_id, so a concurrent DSI transfer (such as a
backlight update) can observe session_open =3D=3D true and send a live DCS
command on a session that has already been closed in firmware.

[ ... ]

> +static int dcp_dsi_dual_map_buf(struct dcp_dpu_kms *kms,
> +				struct device *dma_dev, void *cpu_addr,
> +				dma_addr_t iova, size_t size, int prot)
> +{
> +	struct sg_table sgt =3D { 0 };
> +	struct iommu_domain *domain;
> +	ssize_t mapped;
> +	int ret;
> +
> +	if (!kms->iommu_dev || !cpu_addr || !iova ||
> +	    !IS_ALIGNED(iova, DCP_DSI_DUAL_MAP_ALIGN))
> +		return -EINVAL;
> +
> +	domain =3D iommu_get_domain_for_dev(kms->iommu_dev);
> +	if (!domain)
> +		return -ENODEV;
> +
> +	ret =3D dma_get_sgtable(dma_dev, &sgt, cpu_addr, iova, size);
> +	if (ret)
> +		return ret;
> +
> +	mapped =3D iommu_map_sgtable(domain, iova, &sgt, prot);

[Severity: Medium]
Can mapping iova directly into kms->iommu_dev's domain collide with the
display drm_mm IOVA allocator?

dcs_tx_iova and dcs_rx_iova are allocated from dma_dev's DMA domain, and
dcp_dsi_dual_map_buf() maps those same addresses directly into the display
IOMMU domain without reserving the ranges in kms->vm's drm_mm allocator.
When the display VM later assigns an overlapping IOVA to a GEM
framebuffer, iommu_map_sgtable() can fail with -EEXIST or unmapping the
GEM VMA can unmap the DCS buffer PTEs.

[ ... ]

> +struct drm_bridge *dcp_dsi_bridge_init(struct dcp_dpu_kms *kms,
> +				       struct device_node *np,
> +				       struct device_node *dcp_np,
> +				       u32 intf_idx,
> +				       u32 dsi_idx,
> +				       u32 fw_display_id)
> +{
> +	struct dcp_dsi_bridge *dsi_bridge;
> +	struct dcp_dsi_hfi_config *cfg;
> +	struct device *dev =3D kms->pm_dev;
> +	struct device *dma_dev =3D kms->hfi->dma_dev;
> +	int ret;
> +
> +	dsi_bridge =3D devm_drm_bridge_alloc(dev, struct dcp_dsi_bridge,
> +					   bridge, &dcp_dsi_bridge_funcs);
> +	if (IS_ERR(dsi_bridge))
> +		return ERR_CAST(dsi_bridge);
> +
> +	dsi_bridge->dcp_np        =3D of_node_get(dcp_np);

[ ... ]

> +	device_initialize(&dsi_bridge->dsi_host_dev);
> +	dsi_bridge->dsi_host_dev.release =3D dcp_dsi_host_dev_release;
> +	dsi_bridge->dsi_host_dev.parent  =3D dev;
> +	dsi_bridge->dsi_host_dev.of_node =3D of_node_get(np);
> +	dev_set_name(&dsi_bridge->dsi_host_dev, "%pOFn", np);
> +	dsi_bridge->dsi_host.ops =3D &dcp_dsi_host_ops;
> +	dsi_bridge->dsi_host.dev =3D &dsi_bridge->dsi_host_dev;
> +
> +	ret =3D device_add(&dsi_bridge->dsi_host_dev);

[Severity: Medium]
Does using "%pOFn" cause device_add() to fail with -EEXIST on dual-DSI
setups?

The DT binding names DSI controller nodes dsi@<hex>, and "%pOFn" strips
the @unit-address suffix, giving every dsi_host_dev under parent dev the
identical name "dsi".

> +	if (ret) {
> +		dev_err(dev,
> +			"DSI%u: failed to add dsi_host_dev: %d\n", dsi_idx, ret);
> +		put_device(&dsi_bridge->dsi_host_dev);
> +		goto err_unwind_dma;
> +	}
> +
> +	ret =3D mipi_dsi_host_register(&dsi_bridge->dsi_host);
> +	if (ret) {
> +		dev_err(dev,
> +			"DSI%u: failed to register MIPI DSI host: %d\n",
> +			dsi_idx, ret);
> +		device_del(&dsi_bridge->dsi_host_dev);
> +		put_device(&dsi_bridge->dsi_host_dev);
> +		goto err_unwind_dma;
> +	}
> +
> +	dsi_bridge->bridge.of_node =3D of_node_get(np);
> +	dsi_bridge->bridge.type    =3D DRM_MODE_CONNECTOR_DSI;
> +
> +	drm_bridge_add(&dsi_bridge->bridge);

[Severity: Medium]
Can mipi_dsi_host_register() attach the panel and add the component before
dsi_bridge->bridge is initialized and registered?

mipi_dsi_host_register() synchronously creates and probes child DSI
devices, which can call mipi_dsi_attach() -> dcp_dsi_host_attach() ->
component_add() while bridge.of_node is still NULL and before
drm_bridge_add() has added the bridge to bridge_list (triggering a
DRM_WARN in drm_bridge_attach() if the component master binds
immediately).

> +
> +	return &dsi_bridge->bridge;
> +
> +err_unwind_dma:
> +	if (dsi_bridge->dcs_rx_buf) {
> +		dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
> +				  dsi_bridge->dcs_rx_buf,
> +				  dsi_bridge->dcs_rx_iova);
> +	}
> +	if (dsi_bridge->dcs_tx_buf) {
> +		dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
> +				  dsi_bridge->dcs_tx_buf,
> +				  dsi_bridge->dcs_tx_iova);
> +	}
> +	mutex_destroy(&dsi_bridge->session_lock);
> +	mutex_destroy(&dsi_bridge->dcs_lock);
> +	return ERR_PTR(ret);
> +}

[Severity: Medium]
Does err_unwind_dma leak the reference acquired on dsi_bridge->dcp_np?
of_node_get(dcp_np) is called at the start of dcp_dsi_bridge_init(), but
this error path returns without calling of_node_put(dsi_bridge->dcp_np).

> +
> +int dcp_dsi_bridge_map_buffers(struct dcp_dsi_bridge *dsi_bridge)
> +{
> +	struct dcp_dpu_kms *kms =3D dsi_bridge->kms;
> +	struct device *dma_dev =3D kms->hfi->dma_dev;
> +	int ret;
> +
> +	if (dsi_bridge->dcs_mapped)
> +		return 0;
> +
> +	ret =3D dcp_dsi_dual_map_buf(kms, dma_dev, dsi_bridge->dcs_tx_buf,
> +				   dsi_bridge->dcs_tx_iova,
> +				   DCP_DSI_DCS_TX_BUF_SIZE, IOMMU_READ);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D dcp_dsi_dual_map_buf(kms, dma_dev, dsi_bridge->dcs_rx_buf,
> +				   dsi_bridge->dcs_rx_iova,
> +				   DCP_DSI_DCS_RX_BUF_SIZE, IOMMU_WRITE);

[Severity: High]
Should these dual mappings include IOMMU_CACHE?

dcs_tx_buf and dcs_rx_buf are allocated via dma_alloc_coherent() on the
dma-coherent transport device dma_dev (creating Write-Back cacheable CPU
mappings) and are accessed with plain memcpy() and memset() in
dcp_hfi_dcs_transfer().  Mapping them into kms->iommu_dev's SMMU domain
with only IOMMU_READ or IOMMU_WRITE programs Normal Non-Cacheable PTEs, so
display SMMU accesses do not snoop CPU caches and can read stale TX data
from DRAM or leave stale zeroed RX cache lines visible to the CPU.

[ ... ]

> +void dcp_dsi_bridge_cleanup(struct dcp_dsi_bridge *dsi_bridge)
> +{
> +	struct device *dma_dev =3D dsi_bridge->kms->hfi->dma_dev;
> +
> +	drm_bridge_remove(&dsi_bridge->bridge);
> +	of_node_put(dsi_bridge->bridge.of_node);
> +	of_node_put(dsi_bridge->dcp_np);
> +
> +	mipi_dsi_host_unregister(&dsi_bridge->dsi_host);
> +	device_del(&dsi_bridge->dsi_host_dev);
> +	put_device(&dsi_bridge->dsi_host_dev);
> +
> +	dcp_dsi_bridge_unmap_buffers(dsi_bridge);
> +	dma_free_coherent(dma_dev, DCP_DSI_DCS_TX_BUF_SIZE,
> +			  dsi_bridge->dcs_tx_buf, dsi_bridge->dcs_tx_iova);
> +
> +	dma_free_coherent(dma_dev, DCP_DSI_DCS_RX_BUF_SIZE,
> +			  dsi_bridge->dcs_rx_buf, dsi_bridge->dcs_rx_iova);
> +
> +	mutex_destroy(&dsi_bridge->session_lock);
> +	mutex_destroy(&dsi_bridge->dcs_lock);
> +}

[Severity: High]
Does calling mipi_dsi_host_unregister() inside dcp_dsi_bridge_cleanup()
deadlock on component_mutex when a DSI device is attached?

component_master_del() / try_to_bring_up_aggregate_device()
  mutex_lock(&component_mutex)
  ...
    dcp_dsi_bridge_cleanup()
      mipi_dsi_host_unregister()
        mipi_dsi_remove_device_fn()
          mipi_dsi_detach()
            dcp_dsi_host_detach()
              component_del()
                mutex_lock(&component_mutex)  <-- deadlocks

During driver unbind or KMS bind failure/probe-deferral unwind, the
component framework already holds the non-recursive global component_mutex
when invoking dcp_dsi_bridge_cleanup().  In addition, on the unbind path
dcp_dsi_bridge_cleanup() runs before component_unbind_all(), deleting and
putting dsi_host_dev before component_unbind_all() accesses
component->dev.

[Severity: Medium]
Does dcp_dsi_bridge_cleanup() also leave dcs_tx_buf and dcs_rx_buf
dangling and tear down the bridge in the wrong order?

dcp_dsi_host_transfer() checks if (!dsi_bridge->dcs_tx_buf) under
session_lock to detect freed buffers, but dcp_dsi_bridge_cleanup() frees
dcs_tx_buf and dcs_rx_buf without holding session_lock or clearing the
pointers to NULL, and calls mutex_destroy() on session_lock and dcs_lock
while the devm-allocated bridge object is still alive.  It also calls
drm_bridge_remove() and drops dcp_np before mipi_dsi_host_unregister() has
detached the DSI device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D14
