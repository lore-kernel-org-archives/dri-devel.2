Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10892606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hm4FKi+W
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79CF810E7DB;
	Thu, 29 Oct 2026 10:46:14 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCDED10E7EA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:46:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E7AF1602D3;
 Thu, 29 Oct 2026 10:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84CB41F031E1;
 Thu, 29 Oct 2026 10:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793270767;
 bh=RL9cqOAUqetxOdDvqsG7NG8I9CMvAg5j1Pnv3t6cHl8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hm4FKi+WTVF10VS2HHLuWTvGqsyD7jjHRG2tWeC09Qg1xYkuz7F1o+ZTxZeNkHXkz
 kDxWWljKAXpWsn2B4kQG9bvgOdBu85Gy9Tu7RZX7JbrNyWUwxCAxZFhVjLciptETEC
 vf+3Za4FwSzoc+k60V8WNnidu+7ISrhJVB5qyFgB3/Sd34sjWo+t+nYE3wdbuVgAjf
 H57yeWwWFri8pPHSPuVi065KT16JMEyJjCejBeBGWOTPbm3ZmocUKGPDoj8Tz4b8tt
 +XijvdwiwUarn8pTpMzndPY23tfsLtt4bFIs1y8RCZiWnZG/RhdmRUEGejGzQF7TyJ
 mmcC76cUnSTZg==
Message-ID: <sashiko-outbox-189150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] drm/bridge: Add ITE IT6162 MIPI DSI to HDMI
 bridge driver
To: "Hermes Wu" <Hermes.wu@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261029-upstream-6162-v5-2-8369f9e5afe6@ite.com.tw>
References: <20261029-upstream-6162-v5-0-8369f9e5afe6@ite.com.tw>
 <20261029-upstream-6162-v5-2-8369f9e5afe6@ite.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 10:46:07 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] drm/bridge: it6162: select DRM_DISPLAY_HDMI_STATE_HELPER in Kconfig
- [High] drm/bridge: it6162: fix bridge.ops flags and set supported_hdmi_ver
- [High] drm/bridge: it6162: avoid HPD notify self-deadlock in IRQ thread
- [High] drm/bridge: it6162: initialize hardware before attaching DSI and b=
ridge
- [High] drm/bridge: it6162: fix OF node refcount underflow in it6162_attac=
h_dsi()
- [High] drm/bridge: it6162: missing port@3 next_bridge and attach flags ha=
ndling
- [Medium] drm/bridge: it6162: unreachable HDCP code and off-by-one KSV lis=
t read
- [Medium] drm/bridge: it6162: missing single-DSI rate limit in it6162_hdmi=
_tmds_char_rate_valid()
--

commit bb2197e5059c8f22ed7c430b26d564ec316ac54c
Author: Hermes Wu <Hermes.wu@ite.com.tw>

drm/bridge: Add ITE IT6162 MIPI DSI to HDMI bridge driver

This commit adds a DRM bridge driver for the ITE IT6162 MIPI DSI to HDMI 2.0
bridge chip, supporting single and dual MIPI DSI inputs, mode setting, EDID
retrieval, HDMI audio, and HPD handling.

> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kcon=
fig
> index c7da6b02d7b6b..59d4911222747 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -106,6 +106,23 @@ config DRM_INNO_HDMI
>  	select DRM_DISPLAY_HELPER
>  	select DRM_KMS_HELPER
> =20
> +config DRM_ITE_IT6162
> +	tristate "iTE IT6162 DSI to HDMI bridge"
> +	depends on OF
> +	select REGMAP_I2C
> +	select DRM_MIPI_DSI
> +	select DRM_PANEL_BRIDGE
> +	select DRM_KMS_HELPER
> +	select DRM_HDMI_HELPER
> +	select DRM_DISPLAY_HDMI_HELPER
> +	select DRM_DISPLAY_HDCP_HELPER
> +	select DRM_DISPLAY_HELPER

[Severity: High]
Should this select DRM_DISPLAY_HDMI_STATE_HELPER instead of DRM_HDMI_HELPER?

There is no DRM_HDMI_HELPER Kconfig symbol in the kernel tree. Meanwhile,
it6162_bridge_atomic_enable(), it6162_bridge_hdmi_audio_prepare(), and
it6162_bridge_hdmi_audio_shutdown() call:

  drm_atomic_helper_connector_hdmi_update_infoframes()
  drm_atomic_helper_connector_hdmi_update_audio_infoframe()
  drm_atomic_helper_connector_hdmi_clear_audio_infoframe()

which are compiled only when CONFIG_DRM_DISPLAY_HDMI_STATE_HELPER is enable=
d.
Without selecting DRM_DISPLAY_HDMI_STATE_HELPER, building the driver when no
other enabled driver selects that symbol fails at link time with undefined
references.

[ ... ]

> diff --git a/drivers/gpu/drm/bridge/ite-it6162.c b/drivers/gpu/drm/bridge=
/ite-it6162.c
> new file mode 100644
> index 0000000000000..5f83722ff4e61
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/ite-it6162.c

[ ... ]

> +static int it6162_hdcp_read_list(struct it6162 *it6162,
> +				 u8 *ksv_list,
> +				 int dev_count)
> +{
> +	u8 buf[DATA_BUFFER_DEPTH];
> +	int i, j, ret;
> +
> +	if (!ksv_list || dev_count <=3D 0)
> +		return -EINVAL;
> +
> +	guard(mutex)(&it6162->lock);
> +	for (i =3D 0; i < (dev_count / 6 + 1); i++) {
> +		ret =3D it6162_infoblock_request_data(it6162, HOST_SET_HDCP_R,
> +						    i + 1, buf);
> +		if (ret < 0)
> +			return ret;
> +
> +		for (j =3D 0; j < 30; j +=3D 5) {
> +			if ((i * 6 + j / 5) >=3D dev_count)
> +				break;
> +
> +			memcpy(&ksv_list[(i * 6 + j / 5) * 5], &buf[j], 5);
> +		}
> +	}
> +	return dev_count;
> +}
> +
> +static void it6162_update_hdcp14(struct it6162 *it6162)
> +{
> +	struct drm_device *drm =3D it6162->drm;
> +	int dev_count;
> +	u8 bksv[5];
> +	u8 bstatus[2];
> +	u8 ksvlist[5 * 30];
> +	int ret;
> +
> +	ret =3D it6162_hdcp_read_information(it6162, bstatus, bksv);
> +	if (ret < 0) {
> +		drm_err(drm, "fail to read Bstatus");
> +		return;
> +	}
> +
> +	dev_count =3D DRM_HDCP_NUM_DOWNSTREAM(bstatus[0]);
> +	if (dev_count =3D=3D 0)
> +		return;
> +
> +	if (DRM_HDCP_MAX_DEVICE_EXCEEDED(bstatus[0]) ||
> +	    DRM_HDCP_MAX_CASCADE_EXCEEDED(bstatus[1])) {
> +		drm_err(drm, "HDCP1.4 Max Topology Limit Exceeded");
> +		return;
> +	}
> +
> +	dev_count =3D dev_count > 30 ? 30 : dev_count;
> +	ret =3D it6162_hdcp_read_list(it6162, ksvlist, dev_count);
> +	if (ret < 0) {
> +		drm_err(drm, "fail to read KSV list");
> +		return;
> +	}
> +}

[Severity: Medium]
Is the HDCP support in this driver incomplete or unreachable?

In it6162_config_default(), it6162->en_hdcp is initialized to false and is
never set to true anywhere in the driver, while it6162->bridge.support_hdcp
is also never set. In addition, it6162_bridge_atomic_enable() stores
conn_state->content_protection into it6162->content_protection, which is
never read, and it6162_tx_enable() never calls it6162_tx_hdcp_setup().

Also, in it6162_update_hdcp14() and it6162_update_hdcp23(), the read
bstatus/bksv/ksvlist and rxinfo/rxid/rxid_list buffers are unused local
arrays, and topology or read failures are not propagated back to
it6162_hdcp_handler(), which still sets:

  cp_status =3D DRM_MODE_CONTENT_PROTECTION_ENABLED;

Finally, in it6162_hdcp_read_list(), the loop bound (dev_count / 6 + 1)
instead of DIV_ROUND_UP(dev_count, 6) performs an extra iteration when
dev_count is an exact multiple of 6 (such as 6 or the clamped maximum of 30=
),
requesting an out-of-range block index via it6162_infoblock_request_data().

Should the unused HDCP code be removed until it is wired up, or completed a=
nd
fixed to use DIV_ROUND_UP(dev_count, 6)?

[ ... ]

> +static void it6162_interrupt_handler(struct it6162 *it6162)
> +{
> +	unsigned int int_status, tx_status;
> +	enum drm_connector_status connector_status;
> +	struct device *dev =3D it6162->dev;
> +	struct regmap *regmap =3D it6162->regmap;
> +	int err;
> +
> +	err =3D regmap_read(regmap, OFFSET_EVENT_CHG, &int_status);
> +	if (err < 0) {
> +		dev_err(dev, "read failed rx reg[0x%x] err: %d",
> +			OFFSET_EVENT_CHG, err);
> +		return;
> +	}
> +
> +	regmap_write(it6162->regmap, OFFSET_EVENT_CHG, 0xFF);
> +
> +	if (!!GET_BUFFER_STATUS(int_status)) {
> +		regmap_write(it6162->regmap, OFFSET_DRIVER_DATA, int_status);
> +		it6162->data_buf_sts =3D GET_BUFFER_STATUS(int_status);
> +		wake_up(&it6162->data_buf_wait);
> +	}
> +
> +	if (!(int_status & EVENT_CHG))
> +		return;
> +
> +	err =3D regmap_read(regmap, OFFSET_TX_STATUS, &tx_status);
> +	if (err < 0) {
> +		dev_err(dev, "read failed rx reg[0x%x] err: %d",
> +			OFFSET_TX_STATUS, err);
> +		return;
> +	}
> +
> +	connector_status =3D GET_TX_HPD_STATUS(tx_status) ?
> +			   connector_status_connected :
> +			   connector_status_disconnected;
> +
> +	if (it6162->connector_status !=3D connector_status) {
> +		it6162->connector_status =3D connector_status;
> +		drm_bridge_hpd_notify(&it6162->bridge,
> +				      it6162->connector_status);
> +	}

[Severity: High]
Won't calling drm_bridge_hpd_notify() synchronously inside
it6162_interrupt_handler() deadlock when HPD processing reads the EDID?

it6162_probe() registers it6162_int_threaded_handler() with IRQF_ONESHOT, so
the IRQ line stays masked and the handler cannot re-enter until
it6162_int_threaded_handler() returns.

However, reading the EDID in it6162_get_edid_block() calls
it6162_infoblock_request_data(), which blocks in wait_event_timeout() on
it6162->data_buf_wait waiting for it6162_int_threaded_handler() to service =
the
buffer status interrupt and call wake_up(&it6162->data_buf_wait):

  it6162_int_threaded_handler()
    it6162_interrupt_handler()
      drm_bridge_hpd_notify()
        drm_bridge_connector_hpd_cb()
          drm_kms_helper_connector_hotplug_event()
            drm_client_dev_hotplug()
              drm_helper_probe_single_connector_modes()
                it6162_bridge_read_edid()
                  it6162_get_edid_block()
                    it6162_infoblock_request_data()
                      wait_event_timeout(it6162->data_buf_wait, ...)

Because this runs on the same IRQF_ONESHOT thread that is supposed to wake
data_buf_wait, wait_event_timeout() will always stall for
TIMEOUT_INFOBLOCK_MS (1800 ms) and fail with -ETIMEDOUT.

Similarly, if another thread holds dev->mode_config.mutex and calls
it6162_bridge_read_edid() -> it6162_infoblock_request_data() while
it6162_interrupt_handler() processes EVENT_CHG and calls
drm_bridge_hpd_notify(), the IRQ thread will block waiting for
dev->mode_config.mutex and never process the buffer-ready interrupt to wake
data_buf_wait.

[ ... ]

> +static int it6162_attach_dsi(struct it6162 *it6162)
> +{
> +	struct device *dev =3D it6162->dev;
> +	struct device_node *np =3D dev->of_node;
> +	const struct mipi_dsi_device_info info =3D {"it6162-mipi", 0, np};
> +	struct mipi_dsi_device *dsi;
> +	struct mipi_dsi_host *host;
> +	struct it6162_mipi_cfg *mipi_cfg =3D &it6162->mipi_cfg;
> +	int ret =3D 0;
> +
> +	it6162->dsi =3D NULL;
> +	for (int port =3D 0; port < 2; port++) {
> +		host =3D it6162_of_get_dsi_host_by_port(it6162, port);
> +		if (IS_ERR(host))
> +			continue;
> +
> +		mipi_cfg->en_port[port] =3D true;
> +
> +		dsi =3D devm_mipi_dsi_device_register_full(dev, host, &info);

[Severity: High]
Does passing np in mipi_dsi_device_info without taking a reference underflow
the OF node refcount of dev->of_node on teardown?

devm_mipi_dsi_device_register_full() calls mipi_dsi_device_register_full(),
which assigns dsi->dev.of_node =3D info->node via device_set_node() without
calling of_node_get(). When the DSI device is released on probe failure or
driver unbind, mipi_dsi_dev_release() unconditionally calls:

  of_node_put(dev->of_node);

Because no matching reference was acquired for each registered DSI device
(one in single-DSI mode, two in dual-DSI mode), this drops references owned=
 by
the I2C client's device_node.

[ ... ]

> +static int it6162_bridge_attach(struct drm_bridge *bridge,
> +				struct drm_encoder *encoder,
> +				enum drm_bridge_attach_flags flags)
> +{
> +	struct it6162 *it6162 =3D bridge_to_it6162(bridge);
> +	struct drm_device *drm =3D bridge->dev;
> +
> +	it6162->drm =3D drm;
> +	if (!drm_core_check_feature(drm, DRIVER_ATOMIC)) {
> +		drm_dbg(drm, "it6162 driver only copes with atomic updates");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}

[Severity: High]
Should it6162_bridge_attach() check DRM_BRIDGE_ATTACH_NO_CONNECTOR and atta=
ch
the downstream HDMI output bridge from port@3?

In it6162_bridge_attach(), the flags parameter is ignored: the function
neither requires DRM_BRIDGE_ATTACH_NO_CONNECTOR nor creates a connector. In
addition, the device tree binding defines port@3 as the HDMI output port
(typically connected to an hdmi-connector node), but it6162_probe() only
checks ports 0, 1, and 2, and never acquires or attaches the next bridge on
port@3.

> +
> +static enum drm_mode_status
> +it6162_bridge_mode_valid(struct drm_bridge *bridge,
> +			 const struct drm_display_info *info,
> +			 const struct drm_display_mode *mode)
> +{
> +	unsigned long long rate;
> +
> +	rate =3D drm_hdmi_compute_mode_clock(mode, 8, DRM_OUTPUT_COLOR_FORMAT_R=
GB444);
> +	if (rate =3D=3D 0)
> +		return MODE_NOCLOCK;
> +
> +	return bridge->funcs->hdmi_tmds_char_rate_valid(bridge, mode, rate);
> +}

[ ... ]

> +static enum drm_mode_status
> +it6162_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> +				 const struct drm_display_mode *mode,
> +				 unsigned long long tmds_rate)
> +{
> +	/*IT6162 hdmi supports HDMI2.0 600Mhz*/
> +	if (tmds_rate > 600000000)
> +		return MODE_CLOCK_HIGH;
> +
> +	return MODE_OK;
> +}

[Severity: Medium]
Should it6162_hdmi_tmds_char_rate_valid() or it6162_bridge_mode_valid() also
limit the maximum rate when only a single MIPI DSI port is enabled?

The commit description notes that single MIPI DSI input supports up to
4K @ 30Hz (~300 MHz) while dual MIPI DSI input is required for 4K @ 60Hz
(600 MHz), but it6162_hdmi_tmds_char_rate_valid() allows up to 600 MHz with=
out
checking whether both ports in mipi_cfg.en_port[] are enabled.

[ ... ]

> +static int it6162_probe(struct i2c_client *client)
> +{

[ ... ]

> +	it6162->bridge.of_node =3D np;
> +	it6162->bridge.ops =3D DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID |
> +			     DRM_BRIDGE_OP_HDMI | DRM_BRIDGE_OP_MODES;
> +
> +	it6162->bridge.type =3D DRM_MODE_CONNECTOR_HDMIA;
> +
> +	it6162->bridge.vendor =3D "ITE";
> +	it6162->bridge.product =3D "IT6162";

[Severity: High]
Are the bridge.ops flags and HDMI version fields configured as intended her=
e?

1. DRM_BRIDGE_OP_MODES is set in it6162->bridge.ops, which tells
drm_bridge_connector to call bridge->funcs->get_modes(). Because
it6162_bridge_funcs does not implement .get_modes (it only implements
.edid_read), drm_bridge_get_modes() will dereference a NULL function pointe=
r:

  if (!(bridge->ops & DRM_BRIDGE_OP_MODES))
          return 0;

  return bridge->funcs->get_modes(bridge, connector);

2. it6162_interrupt_handler() calls drm_bridge_hpd_notify(), but
DRM_BRIDGE_OP_HPD is not set in it6162->bridge.ops, so drm_bridge_connector
never registers an HPD callback on this bridge and drm_bridge_hpd_notify() =
is
a no-op.

3. it6162_bridge_funcs implements .hdmi_write_spd_infoframe and
.hdmi_clear_spd_infoframe, and bridge.vendor and bridge.product are set, but
DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME is omitted from it6162->bridge.ops.

4. DRM_BRIDGE_OP_HDMI is set without setting it6162->bridge.supported_hdmi_=
ver
(for example to HDMI_VERSION_2_0), which triggers a DRM_WARN("HDMI bridge
misses supported HDMI version\n") in drm_bridge_add().

> +
> +	if (it6162_of_get_audio(it6162)) {
> +		it6162->bridge.ops |=3D DRM_BRIDGE_OP_HDMI_AUDIO;
> +		it6162->bridge.hdmi_audio_dev =3D dev;
> +		it6162->bridge.hdmi_audio_max_i2s_playback_channels =3D 8;
> +		it6162->bridge.hdmi_audio_dai_port =3D 2;
> +	}
> +
> +	/*
> +	 * devres releases in reverse order: the IRQ is freed and the HDCP
> +	 * works are cancelled before the bridge is removed, which destroys
> +	 * the HPD notification mutex, and before the supplies and the driver
> +	 * mutex are released.
> +	 */
> +	ret =3D devm_drm_bridge_add(dev, &it6162->bridge);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(dev, it6162_cancel_work_action, it6162=
);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					it6162_int_threaded_handler,
> +					IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> +					IRQF_NO_AUTOEN,
> +					"it6162-intp", it6162);
> +	if (ret)
> +		return ret;
> +
> +	return it6162_attach_dsi(it6162);
> +}

[Severity: High]
Does registering the bridge and attaching the DSI devices before
it6162_hw_start() expose the bridge before the hardware and IRQ are ready?

In it6162_probe(), devm_drm_bridge_add() is called before
devm_request_threaded_irq() and it6162_attach_dsi(). Then, inside
it6162_attach_dsi(), devm_mipi_dsi_attach() is called inside the port loop
before it6162_hw_start() runs:

  it6162_attach_dsi()
    for (int port =3D 0; port < 2; port++) {
      ...
      devm_mipi_dsi_attach(dev, dsi);
    }
    return it6162_hw_start(it6162);

When a DSI host's .attach callback binds the DRM pipeline synchronously dur=
ing
devm_mipi_dsi_attach(), the bridge is already active while it6162->hw_ready=
 is
still false (causing it6162_bridge_detect() to return
connector_status_disconnected) and client->irq is still disabled with
IRQF_NO_AUTOEN (causing any EDID read via it6162_infoblock_request_data() to
time out). Once it6162_hw_start() subsequently runs, it calls
it6162_hw_reset() and resets the chip after the DSI host has attached.

Also, in it6162_attach_dsi(), if it6162_load_mipi_pars_from_port() were to
return 0, the check:

  if (ret <=3D 0)
          return ret;

would return 0 from it6162_probe() without attaching DSI or starting the
hardware.

Should the MIPI DT parameters be parsed and it6162_hw_start() be completed
before publishing the bridge and attaching the DSI host(s)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-upstream-6=
162-v5-0-8369f9e5afe6@ite.com.tw?part=3D2
