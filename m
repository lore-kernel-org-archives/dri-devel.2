Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E34C5AD4E
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199C410E15E;
	Sun,  9 Aug 2026 13:36:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cGJtBLTi";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC5FF10E15E
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:36:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 48F9760008;
 Sun,  9 Aug 2026 13:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A711F000E9;
 Sun,  9 Aug 2026 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786282565;
 bh=P5Bg/oaykp14rin3RjiNprNpcavQbQmhK7o7+wKpbOM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cGJtBLTis3iW0UOkE02bKdNuR5JXUvkvsJtMJwIQ5nn3ETvBsKFcEL+UJC5IpwiLn
 QDoYKl/525z3GRLfIVtzw+3bzL8VljPyHEM6SKbuiv6ryahKYPdsodG2157nmmP8ns
 sbbC9azdV9zpm04YDOHDSUDD+X/N6ZkqrqLnPkneBfgUTU166bQx7m8MqdciPBAkHX
 Ws76Mkad+J1wX4JubxVBtZqjpwDbDHZEuDJfwIeJ4Gu6HYypkXgKJI6NFcI0ky/epJ
 ZEqaHXbx+k1KioR0gF+KIgGu5ENXLokf/nYwrsNWvLg2Km04V2ihagWu/rdEkuS2DP
 z29R7hnGdqv0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/17] drm/spacemit: add Innosilicon DP/eDP
 controller bridge driver
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: neil.armstrong@linaro.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, olteanv@gmail.com, devicetree@vger.kernel.org,
 conor+dt@kernel.org, vkoul@kernel.org
In-Reply-To: <20260809-k3-display-v2-12-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-12-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 13:36:03 +0000
Message-Id: <20260809133604.45A711F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Premature bridge and component registration before eDP panel probe=
 completion breaks `drm_bridge_connector`.
- [High] Incorrect lock acquired before calling `drm_connector_set_link_sta=
tus_property`.
- [High] Infinite modeset loop caused by partial clearing of link capabilit=
ies on training failure.
- [Medium] Data race on DPCD and link capabilities during `mode_valid` and =
`atomic_check`.
- [Medium] AUX hardware reset during modesets races with concurrent AUX tra=
nsfers.
- [Medium] Stale AUX interrupt status causes false completions on subsequen=
t transfers.
--

--- Patch [12]: [PATCH v2 12/17] drm/spacemit: add Innosilicon DP/eDP contr=
oller bridge driver ---
commit 67f4fc821826b59800af024c1981f9d4c8be1a74
Author: Cody Kang <codykang.hk@gmail.com>
Subject: drm/spacemit: add Innosilicon DP/eDP controller bridge driver

This commit introduces the DisplayPort/embedded DisplayPort controller
bridge driver for the SpacemiT Saturn DPU. It leverages the generic PHY
framework and provides hotplug detection alongside link training mechanisms.

> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c
[ ... ]
> +static void spacemit_dp_modeset_retry_work(struct work_struct *work)
> +{
> +	struct spacemit_dp_dev *dp =3D container_of(work, struct spacemit_dp_de=
v,
> +						  modeset_retry_work);
> +	struct drm_connector *connector =3D dp->connector;
> +
> +	if (!connector)
> +		return;
> +
> +	mutex_lock(&connector->dev->mode_config.mutex);
> +	drm_connector_set_link_status_property(connector,
> +					       DRM_MODE_LINK_STATUS_BAD);
> +	mutex_unlock(&connector->dev->mode_config.mutex);

[Severity: High]
Does this acquire the correct lock? The DRM core requires the caller to hold
mode_config.connection_mutex (a drm_modeset_lock) to protect connection
state. Calling drm_connector_set_link_status_property with just the
standard mode_config.mutex triggers a lockdep warning and leaves the state
unprotected against concurrent atomic commits.

[ ... ]
> +static ssize_t spacemit_dp_aux_transfer(struct drm_dp_aux *aux,
> +					struct drm_dp_aux_msg *msg)
> +{
[ ... ]
> +	regmap_write_bits(dp->regs, DP_AUX_START_REG, DP_AUX_START,
> +			  FIELD_PREP(DP_AUX_START, 0));
> +	regmap_write_bits(dp->regs, DP_AUX_START_REG, DP_AUX_START,
> +			  FIELD_PREP(DP_AUX_START, 1));
> +
> +	timeout =3D jiffies + msecs_to_jiffies(200);
> +	ret =3D -ETIMEDOUT;
> +
> +	while (1) {
> +		regmap_read(dp->regs, DP_GENERAL_INTERRUPT, &val);
> +		val =3D FIELD_GET(DP_AUX_REPLY_EVENT_INT_STA, val);
> +		if (val) {
> +			ret =3D 0;
> +			break;
> +		}
> +		if (time_after(jiffies, timeout))
> +			break;
> +		usleep_range(100, 110);
> +	}
> +
> +	if (ret) {
> +		if (retries < SPACEMIT_DP_AUX_MAX_RETRIES) {
> +			retries++;
> +			spacemit_dp_aux_hw_reset(dp);
> +			dev_dbg(dp->dev,
> +				"AUX timeout, cmd=3D0x%x addr=3D0x%x size=3D%zu retry %d/%d\n",
> +				cmd, msg->address, msg->size, retries, SPACEMIT_DP_AUX_MAX_RETRIES);
> +			goto retry_eio;
> +		}
> +
> +		dev_err(dp->dev,
> +			"AUX transfer timeout, req: 0x%x, cmd: 0x%x, addr: 0x%x, size %zu\n",
> +			msg->request, cmd, msg->address, msg->size);
> +		return ret;

[Severity: Medium]
If a transfer times out and this returns -ETIMEDOUT, is the
DP_AUX_REPLY_EVENT_INT_STA interrupt bit left uncleared?

If the hardware completes the transaction shortly after the timeout expires,
this bit will be set. Since the next AUX transfer does not clear this bit
before starting, its polling loop will instantly see the stale event bit and
incorrectly assume the new transfer has completed.

Could this lead to reading garbage data and corrupting DPCD or EDID reads?

[ ... ]
> +static int spacemit_dp_hw_read_sink_caps(struct spacemit_dp_dev *dp)
> +{
> +	ssize_t ret;
> +	u8 max_bw;
> +	int retry;
> +
> +	for (retry =3D 0; retry < SPACEMIT_DP_SINK_READY_RETRIES; retry++) {
> +		if (retry) {
> +			spacemit_dp_aux_hw_reset(dp);

[Severity: Medium]
Can this reset disrupt concurrent AUX transfers initiated by userspace?

The driver issues a hardware reset to the AUX controller here and in
spacemit_dp_link_disable() without holding dp->aux.hw_mutex. If a concurrent
AUX transfer is initiated (e.g., via /dev/drm_dp_auxN) while a modeset or
detect operation is occurring, the hardware reset could corrupt or abort the
in-flight transfer.

[ ... ]
> +static enum drm_mode_status
> +spacemit_dp_bridge_mode_valid(struct drm_bridge *bridge,
> +			      const struct drm_display_info *info,
> +			 const struct drm_display_mode *mode)
> +{
> +	struct spacemit_dp_dev *dp =3D container_of(bridge,
> +						  struct spacemit_dp_dev,
> +						  bridge);
> +	unsigned int max_link_rate, max_lanes;
> +	u64 max_bw, req_bw;
> +	const unsigned int bpp =3D 24;
> +
> +	/*
> +	 * drm_dp_max_link_rate() is in 10 kHz units; clamp to what the PHY can
> +	 * do.
> +	 */
> +	max_link_rate =3D min_t(unsigned int, drm_dp_max_link_rate(dp->dpcd),
> +			      SPACEMIT_DP_SOURCE_MAX_RATE / 10);

[Severity: Medium]
Is it safe to read dp->dpcd here without holding dp->mode_lock?

These hardware capability properties are updated in
spacemit_dp_hw_read_sink_caps(), which runs from the hotplug threaded IRQ
handler while holding dp->mode_lock. Reading them here without the lock
could expose a data race where concurrent hotplug events result in torn
reads of the capabilities array.

[ ... ]
> +static void spacemit_dp_bridge_atomic_enable(struct drm_bridge *bridge,
> +					     struct drm_atomic_commit *state)
> +{
[ ... ]
> +	if (!trained) {
> +		dev_err(dp->dev,
> +			"no usable link config; leaving video disabled (%u kHz x%u lanes)\n",
> +			dp->link.max_rate, dp->link.max_num_lanes);
> +		/*
> +		 * The caps may be from a sink that has since been swapped out.
> +		 */
> +		dp->link.max_rate =3D 0;
> +		dp->link.max_num_lanes =3D 0;
> +
> +		/*
> +		 * Deferred: we are inside the commit and hold the modeset
> +		 * locks.
> +		 */
> +		schedule_work(&dp->modeset_retry_work);
> +		return;
> +	}

[Severity: High]
Does clearing dp->link.max_rate but not the raw dp->dpcd array cause an
infinite modeset loop on training failure?

When link training fails, the driver sets max_rate to 0 and schedules a link
status retry but leaves the raw dp->dpcd array untouched. When the hotplug
event prompts userspace to request a new modeset:

spacemit_dp_bridge_mode_valid() will accept the failing mode because it
reads from the unchanged dp->dpcd.

spacemit_dp_bridge_atomic_check() will accept it because max_rate is 0,
causing it to unconditionally return success.

spacemit_dp_bridge_atomic_enable() then attempts to train the link again,
fails again, and repeats the cycle indefinitely, wedging the display server.

[ ... ]
> +static int spacemit_dp_bridge_atomic_check(struct drm_bridge *bridge,
> +					   struct drm_bridge_state *bridge_state,
> +				      struct drm_crtc_state *crtc_state,
> +				      struct drm_connector_state *conn_state)
> +{
[ ... ]
> +	/* No caps yet: leave idx unset and let ->atomic_enable() retry. */
> +	if (!dp->link.max_rate || !dp->link.max_num_lanes) {
> +		st->link_cfg_idx =3D -1;
> +		return 0;
> +	}

[Severity: Medium]
Similar to the read in spacemit_dp_bridge_mode_valid(), is it safe to read
the dp->link properties without holding dp->mode_lock here?

[ ... ]
> +static int inno_dp_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	/*
> +	 * eDP hands panel power, enable-GPIO and backlight to panel-edp over
> +	 * the AUX bus. A DP instance has no aux-bus child and takes the
> +	 * -ENODEV path.
> +	 */
> +	if (dp->edp_mode) {
> +		ret =3D devm_of_dp_aux_populate_bus(&dp->aux,
> +						  spacemit_dp_edp_link_panel);
> +		if (ret) {
> +			dev_err_probe(dev, ret,
> +				"eDP: failed to populate aux-bus panel\n");
> +			return ret;
> +		}
> +	}
> +
> +	/*
> +	 * drm_bridge_attach() expects the bridge to already be on the global
> +	 * list.
> +	 */
> +	ret =3D devm_drm_bridge_add(dev, &dp->bridge);
> +	if (ret) {
> +		dev_err(dev, "failed to register DP bridge: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, dp);
> +
> +	/*
> +	 * The handler needs bind-created state, so keep the line disabled until
> +	 * bind.
> +	 */
> +	ret =3D devm_request_threaded_irq(dev, dp->irq, spacemit_dp_irq_handler,
> +					spacemit_dp_hotplug_event_handler,
> +					IRQF_NO_AUTOEN, dev_name(dev), dp);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D component_add(dev, &spacemit_dp_ops);

[Severity: High]
Does registering the component here before the eDP panel finishes probing
break drm_bridge_connector?

The driver calls devm_drm_bridge_add() and component_add() right after
asking the AUX bus to asynchronously probe the eDP panel. This signals to
the DRM master that this component is ready, prompting it to bind and build
the connector immediately.

Since drm_bridge_connector_init() captures the capabilities of the bridge
chain statically, the late attachment of the panel bridge in
spacemit_dp_edp_link_panel() goes unnoticed by the connector. This results
in the eDP panel missing its modes and panel-specific properties.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-k3-display=
-v2-0-327d7910bf71@gmail.com?part=3D12
