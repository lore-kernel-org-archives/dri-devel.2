Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37680606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGzJGlfq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95DB010EE4B;
	Mon, 26 Oct 2026 11:13:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D2D710EE4B
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:13:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B0AF060A53;
 Mon, 26 Oct 2026 11:13:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045E51F01825;
 Mon, 26 Oct 2026 11:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793013192;
 bh=Vzrq5dwCotIg0S8fxReszMlgFK+WzgY8xlv4kDTBw7I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KGzJGlfqKqjRV/xFypH7j18ghslIGVAt5aOAXqd9rApoAGQ/WemR5HPLNauQIAnNP
 GnrlwC4iEwLg7Bu6EI7cNPAbrBieCakl26UPxY/3Tp5H2FWSzQAFjT4R534iCw9TVE
 QY8jcGfxZ1pa2l/lk0euVDdEorKL6R0qRJeWxz7J8JabYgglHu5GyW370liQLCSvS7
 Sj/mcnEqRUcttxnGPIcN3YicK8IRrRJyOPjwYhQt6cmrihpZZ/zwql+PY7TJyXDGvj
 BFqXZPVyQEPJmdw3U71lQkJw6ku7gwIFpsLDYz24hK+CW4ksxon+V0JJ64CViITV5d
 MSz5g0/oEwAvA==
Message-ID: <sashiko-outbox-185075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/23] drm/msm/dcp: Add HFI DSI and panel commands
To: "Jayant Shekhar" <jayant.shekhar@oss.qualcomm.com>
Cc: virtualization@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261026-jshekhar-dcp-hlos-v2-10-7cf014efdee1@oss.qualcomm.com>
References: <20261026-jshekhar-dcp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com>
 <20261026-jshekhar-dcp-hlos-v2-10-7cf014efdee1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:13:11 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] drm/msm/dcp: stack use-after-free on timeout in dcp_hfi_panel_=
wait()
- [High] drm/msm/dcp: dcp_hfi_dcs_transfer() returns tx_len instead of rx_l=
en on read
- [Medium] drm/msm/dcp: unsigned bpp in dcp_hfi_panel_init() makes error ch=
eck dead
--

commit 7a46a036c27a241a8f787ac3f2ae566d027d7a46
Author: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>

drm/msm/dcp: Add HFI DSI and panel commands

This commit translates DSI host and panel operations into HFI commands,
implementing DSI mode validation, display session and power management,
panel initialization, and DCS transfer helpers.

> diff --git a/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c b/drivers/gpu/dr=
m/msm/dcp/dcp_hfi_dsi_panel.c
> new file mode 100644
> index 0000000000000..b27fa8fa31609
> --- /dev/null
> +++ b/drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c

[ ... ]

> +static bool dcp_hfi_panel_wait(struct dcp_hfi *hfi,
> +			       struct dcp_hfi_completion *comp)
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

[Severity: Critical]
Can dcp_hfi_panel_wait() in drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c
cause a stack use-after-free when a timeout races with response completion?

In dcp_hfi_panel_init(), comp1, comp2, and comp3 are allocated on the stack
and waited on via dcp_hfi_panel_wait(), which returns -ETIMEDOUT and unwinds
the stack frame as soon as dcp_hfi_panel_wait() returns true.

However, in drivers/gpu/drm/msm/dcp/dcp_hfi_core.c, dcp_hfi_resp_callback()
drops hfi->resp_drain_lock before unpacking packets and calling
dcp_hfi_complete_pending():

drivers/gpu/drm/msm/dcp/dcp_hfi_core.c:dcp_hfi_resp_callback() {
    ...
    spin_unlock_irqrestore(&hfi->resp_drain_lock, drain_flags);
    ...
    dcp_hfi_complete_pending(hfi, &pkt_info, status);
}

And dcp_hfi_complete_pending() erases comp from hfi->pending_xa under
hfi->pending_lock, drops the lock, and then writes comp->status and calls
complete(&comp->done) without holding either resp_drain_lock or
pending_lock:

drivers/gpu/drm/msm/dcp/dcp_hfi_core.c:dcp_hfi_complete_pending() {
    comp =3D dcp_hfi_pending_find(hfi, pkt_info->packet_id);
    if (!comp) {
        ...
        return;
    }
    ...
    comp->status =3D status;
    complete(&comp->done);
}

If dcp_hfi_complete_pending() erases comp from pending_xa right as
wait_for_completion_timeout() expires, dcp_hfi_panel_wait() will acquire the
unheld resp_drain_lock, ignore the NULL return from dcp_hfi_pending_find(),
and allow dcp_hfi_panel_init() to return while dcp_hfi_complete_pending() is
still writing to comp->status and calling complete(&comp->done) on the
unwound stack.

If dcp_hfi_pending_find() returns NULL on timeout, should
dcp_hfi_panel_wait() call wait_for_completion(&comp->done) to wait for the
in-flight completion to finish before returning?

> +
> +int dcp_hfi_panel_init(struct dcp_hfi *hfi, u32 intf_idx,
> +		       const struct drm_display_mode *mode,
> +		       const struct mipi_dsi_device *dsi,
> +		       const struct dcp_dsi_hfi_panel_config *cfg)
> +{
> +	u32 num_lanes;
> +	u32 bpp;
> +	bool is_cmd_mode;

[ ... ]

> +	num_lanes =3D dsi->lanes;
> +	bpp =3D mipi_dsi_pixel_format_to_bpp(dsi->format);
> +	if (bpp < 0)
> +		return -EINVAL;
> +	is_cmd_mode =3D !(dsi->mode_flags & MIPI_DSI_MODE_VIDEO);
> +	traffic_mode =3D dcp_dsi_traffic_mode(dsi);
> +	link_bpp_x16 =3D bpp << 4;

[Severity: Medium]
In dcp_hfi_panel_init() in drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c, bpp
is declared as u32, whereas mipi_dsi_pixel_format_to_bpp() returns a signed
int that can be -EINVAL on an unrecognized pixel format.

Because bpp is unsigned, is the check (bpp < 0) always false? If
mipi_dsi_pixel_format_to_bpp() returns -EINVAL, bpp becomes 0xffffffeaU,
bypassing the error return, defaulting to HFI_PANEL_BPP_24 in
dcp_bpp_to_hfi(), and corrupting link_bpp_x16 and clk_hz. Should bpp be
declared as int instead of u32?

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
> +
> +	if (msg->rx_len && (!msg->rx_buf || !rx_buf))
> +		return -EINVAL;
> +
> +	if (msg->tx_len > DCP_DSI_DCS_TX_BUF_SIZE) {
> +		dev_err(hfi->dev, "DCS TX too large: %zu > %u\n",
> +			msg->tx_len, DCP_DSI_DCS_TX_BUF_SIZE);
> +		return -EINVAL;
> +	}
> +
> +	memcpy(tx_buf, msg->tx_buf, msg->tx_len);

[ ... ]

> +	if (msg->rx_len > 0)
> +		memcpy(msg->rx_buf, rx_buf, msg->rx_len);
> +
> +	return msg->tx_len;
> +}

[Severity: High]
Should dcp_hfi_dcs_transfer() in
drivers/gpu/drm/msm/dcp/dcp_hfi_dsi_panel.c return msg->rx_len instead of
msg->tx_len when msg->rx_len > 0?

Under the struct mipi_dsi_host_ops.transfer contract in
include/drm/drm_mipi_dsi.h, the return value must be the number of bytes
transmitted for write packets or the number of bytes received for read
packets. Returning msg->tx_len on read transfers causes multi-byte reads
through mipi_dsi_dcs_read() or mipi_dsi_generic_read() (where msg->tx_len !=
=3D
msg->rx_len) to appear as short reads to callers checking the received byte
count.

Also, at the entry of dcp_hfi_dcs_transfer(), the check (!msg ||
!msg->tx_buf || !msg->tx_len) rejects 0-parameter generic transfers where
msg->tx_len =3D=3D 0, while hfi and tx_buf are dereferenced without a NULL
check. Should this validate hfi and tx_buf and allow 0-length tx when
appropriate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-jshekhar-d=
cp-hlos-v2-0-7cf014efdee1@oss.qualcomm.com?part=3D10
