Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65971606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PdB0CpdF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3EC10E313;
	Thu, 26 Nov 2026 06:54:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 523A110E175
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 06:54:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 91FCB62832;
 Thu, 26 Nov 2026 06:54:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1591F000C4;
 Thu, 26 Nov 2026 06:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795676065;
 bh=4VaRuuqaY9kEZugmP0sYWAa4EOKc+ZhqxbONiAYvAYQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PdB0CpdFPFIzEjnIJ8hTFaRHviVIa/a+30I/7Y9nCFF/W+z7FA5HZFM2MDBjVLg2p
 9ADS6ESmrFhK2/0FUAvYrRZvvKgb8/5YggtLHT0Qg+v8GMfDgBYRYqZGv6KLITgJjo
 m5yUu7a6/Wy5qk6DuLkIDsnrYBraEIF65PcnBvy0LbHUPNsr4R+50LySntyFxvGstO
 QJDbV+9jjllHTUhxoocF53DS54PN5UcbjQYcJzTXagt1E1EOwPph2aZqQzJb/eQdUO
 UcvQopQjo2mwcS1xPIcoLck4nLy6/DctnQEGTYRChZo0wMd4gjiBgK9vv1B0rjg5OK
 ocoXQOA7Mq4bA==
Message-ID: <sashiko-outbox-234915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/21] drm/msm/dcp: Add HFI DSI and panel commands
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org, media-ci@linuxtv.org
In-Reply-To: <20261126-jshekhar-v3-dcp-v3-9-f1e9d7505039@oss.qualcomm.com>
References: <20261126-jshekhar-v3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com>
 <20261126-jshekhar-v3-dcp-v3-9-f1e9d7505039@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:54:24 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/msm/dcp: off-by-one DSC chroma_format and color_space in
  dcp_hfi_dsi_configure()
- [High] drm/msm/dcp: stack completion use-after-free on timeout in
  dcp_hfi_dsi_wait()
- [High] drm/msm/dcp: dcp_hfi_dcs_transfer() returns tx_len instead of
  rx_len on read
- [Medium] drm/msm/dcp: dcp_hfi_dsi_configure() omits packing
  cfg->dma_sched_line
- [Medium] drm/msm/dcp: hardcoded 8-bit panel mode in
  dcp_hfi_dsi_configure()
- [Low] drm/msm/dcp: undocumented struct members in dcp_dsi_hfi_config
  kernel-doc
--

commit 681ba5bae7f7207050885a01cedbdb43a05a6eb8
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add HFI DSI and panel commands

This commit adds HFI commands for DSI mode validation, display session and
power management, panel initialization, and DCS command transfers.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_dsi_config.h b/drivers/gpu/drm/m=
sm/dcp/dcp_dsi_config.h
> new file mode 100644
> index 0000000000000..5f2013739edf1
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_dsi_config.h
> @@ -0,0 +1,67 @@

[ ... ]

> +/**
> + * struct dcp_dsi_hfi_config - DSI configuration passed to HFI.
> + *
> + * This contains the DSI output configuration plus mode-dependent values
> + * assembled before the HFI configuration commands are sent.
> + */
> +struct dcp_dsi_hfi_config {
> +	u32 display_type;

[Severity: Low]
This comment uses the /** kernel-doc marker without documenting the members
of struct dcp_dsi_hfi_config, which triggers kernel-doc warnings under W=3D=
1.

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c b/drivers/gpu/d=
rm/msm/dcp/dcp_hfi_dsi_config.c
> new file mode 100644
> index 0000000000000..8c4855334caac
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_config.c
> @@ -0,0 +1,597 @@

[ ... ]

> +static bool dcp_hfi_dsi_wait(struct dcp_hfi *hfi,
> +			     struct dcp_hfi_completion *comp)
> +{
> +	unsigned long flags;
> +
> +	if (wait_for_completion_timeout(&comp->done,
> +					msecs_to_jiffies(DCP_HFI_TIMEOUT_DISPLAY_MS)))
> +		return false;
> +
> +	/* Serialize removal with response dispatch before the stack object die=
s. */
> +	spin_lock_irqsave(&hfi->resp_drain_lock, flags);
> +	dcp_hfi_pending_find(hfi, comp->packet_id);
> +	spin_unlock_irqrestore(&hfi->resp_drain_lock, flags);
> +	return true;
> +}

[Severity: High]
Can dcp_hfi_dsi_wait() return on timeout while dcp_hfi_complete_pending() is
still accessing the stack-allocated completion?

dcp_hfi_resp_callback() drops hfi->resp_drain_lock right after
virtqueue_get_buf(), before unpacking packets and calling
dcp_hfi_complete_pending().  Inside dcp_hfi_complete_pending(),
dcp_hfi_pending_find() erases comp from hfi->pending_xa under
hfi->pending_lock and returns it before writing comp->status and calling
complete(&comp->done) without holding either lock:

CPU0                                  CPU1
dcp_hfi_dsi_configure()
  dcp_hfi_dsi_wait(&comp1)
    wait_for_completion_timeout()
      -> 0 (timed out)
                                      dcp_hfi_resp_callback()
                                        unlock(&hfi->resp_drain_lock)
                                        ...
                                        dcp_hfi_complete_pending()
                                          comp =3D dcp_hfi_pending_find()
    lock(&hfi->resp_drain_lock)
    dcp_hfi_pending_find() -> NULL
    unlock(&hfi->resp_drain_lock)
  return -ETIMEDOUT;
                                          comp->status =3D status;
                                          complete(&comp->done);
                                            <-- stack use-after-free

If dcp_hfi_pending_find() returns NULL in dcp_hfi_dsi_wait(), the response
handler has already claimed comp and is about to complete it, so
dcp_hfi_dsi_wait() needs to wait_for_completion(&comp->done) before allowing
dcp_hfi_dsi_configure() to unwind its stack frame.

[ ... ]

> +	num_props++;
> +	p +=3D HFI_PACK(p, HFI_PROPERTY_PANEL_BPP, dcp_bpp_to_hfi(bpp));
> +	num_props++;
> +	p +=3D HFI_PACK(p, HFI_PROPERTY_PANEL_LANES_STATE,
> +		       dcp_lanes_to_hfi(num_lanes));
> +	num_props++;
> +	p +=3D HFI_PACK(p, HFI_PROPERTY_PANEL_OPERATING_MODE,
> +		       is_cmd_mode ? HFI_PANEL_CMD_MODE_8_BIT :
> +		       HFI_PANEL_VIDEO_MODE_8_BIT);

[Severity: Medium]
Should HFI_PROPERTY_PANEL_OPERATING_MODE select HFI_PANEL_CMD_MODE_10_BIT or
HFI_PANEL_VIDEO_MODE_10_BIT for 10-bpc panels?

dcp_bpp_to_hfi() maps 30-bpp panels (MIPI_DSI_FMT_RGB101010) to
HFI_PANEL_BPP_30, and HFI_PROPERTY_PANEL_COMPRESSION_DATA passes
cfg->dsc->bits_per_component, but HFI_PROPERTY_PANEL_OPERATING_MODE always
packs an 8-bit mode.

[ ... ]

> +	num_props++;
> +	*p++ =3D HFI_PACK_KEY(HFI_PROPERTY_PANEL_PHY_NUM, 0, 1 + num_phys);
> +	*p++ =3D num_phys;
> +	memcpy(p, cfg->phy_indices, num_phys * sizeof(*p));
> +	p +=3D num_phys;
> +
> +	num_props++;
> +	p +=3D HFI_PACK(p, HFI_PROPERTY_PANEL_DMA_SCHEDULE_WINDOW, dma_win);
> +	payload[0] =3D num_props;

[Severity: Medium]
Should dcp_hfi_dsi_configure() also pack cfg->dma_sched_line as
HFI_PROPERTY_PANEL_DMA_SCHEDULE_LINE?

struct dcp_dsi_hfi_config defines dma_sched_line alongside dma_sched_window,
and hfi_properties_panel.h defines HFI_PROPERTY_PANEL_DMA_SCHEDULE_LINE, but
cfg->dma_sched_line is never sent to firmware.

[ ... ]

> +	if (cfg->dsc) {
> +		u32 chroma_format =3D 0;
> +		u32 color_space =3D 0;
> +
> +		if (cfg->dsc->native_422)
> +			chroma_format =3D 1;
> +		else if (cfg->dsc->native_420)
> +			chroma_format =3D 2;
> +		if (cfg->dsc->native_422 || cfg->dsc->native_420)
> +			color_space =3D 1;
> +
> +		*p++ =3D HFI_PACK_KEY(HFI_PROPERTY_PANEL_COMPRESSION_DATA, 0, 12);
> +		*p++ =3D HFI_PANEL_COMPRESSION_DSC;
> +		*p++ =3D (cfg->dsc->dsc_version_major << 4) |
> +			cfg->dsc->dsc_version_minor;
> +		*p++ =3D 0; /* scr_version is not set by DRM DSC config. */
> +		*p++ =3D cfg->dsc->slice_height;
> +		*p++ =3D cfg->dsc->slice_width;
> +		*p++ =3D 1; /* one slice per packet */
> +		*p++ =3D cfg->dsc->bits_per_component;
> +		*p++ =3D 0; /* no post-PPS delay */
> +		*p++ =3D cfg->dsc->bits_per_pixel;
> +		*p++ =3D chroma_format;
> +		*p++ =3D color_space;
> +		*p++ =3D cfg->dsc->block_pred_enable;
> +	}

[Severity: High]
Are chroma_format and color_space off by one against the HFI panel protocol
enums?

In drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h, both enums are 1-based:

drivers/gpu/drm/msm/dcp/hfi/hfi_defs_panel.h:
enum hfi_panel_chroma_format_type {
	HFI_PANEL_CHROMA_FORMAT_444     =3D 1,
	HFI_PANEL_CHROMA_FORMAT_422     =3D 2,
	HFI_PANEL_CHROMA_FORMAT_420     =3D 3,
};

enum hfi_panel_color_space_type {
	HFI_PANEL_COLOR_SPACE_RGB     =3D 1,
	HFI_PANEL_COLOR_SPACE_YUV     =3D 2,
};

Packing 0/1/2 for chroma_format and 0/1 for color_space sends invalid 0
values for RGB 4:4:4 DSC panels and the wrong format/color space for native
4:2:2 and 4:2:0 panels.

[ ... ]

> +ssize_t dcp_hfi_dcs_transfer(struct dcp_hfi *hfi, u32 session_id,
> +			     const struct mipi_dsi_msg *msg,
> +			     void *tx_buf, dma_addr_t tx_iova,
> +			     void *rx_buf, dma_addr_t rx_iova,
> +			     u32 post_wait_ms, u32 ctrl_idx)
> +{
> +	struct hfi_dsi_cmd_desc cmd_desc =3D {};
> +	static atomic_t seq_no =3D ATOMIC_INIT(0);
> +	int ret;
> +
> +	if (!msg || !msg->tx_buf || !msg->tx_len)
> +		return -EINVAL;

[ ... ]

> +	if (msg->rx_len > 0)
> +		memcpy(msg->rx_buf, rx_buf, msg->rx_len);
> +
> +	return msg->tx_len;
> +}

[Severity: High]
Should dcp_hfi_dcs_transfer() return msg->rx_len on read transfers instead =
of
msg->tx_len?

struct mipi_dsi_host_ops.transfer expects the number of bytes received for
read packets, so returning msg->tx_len causes multi-byte DSI reads (where
tx_len !=3D rx_len) to fail as short reads in callers such as
mipi_dsi_dcs_read().  Also, rejecting !msg->tx_len || !msg->tx_buf at entry
rejects valid 0-parameter generic transfers
(MIPI_DSI_GENERIC_SHORT_WRITE_0_PARAM and
MIPI_DSI_GENERIC_READ_REQUEST_0_PARAM) where tx_len is 0.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-jshekhar-v=
3-dcp-v3-0-f1e9d7505039@oss.qualcomm.com?part=3D9
