Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD34AC5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 22:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E971510F579;
	Thu, 13 Aug 2026 22:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iE2eEBER";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B661710F56C
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:07:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 717BC40A5A
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123571F000E9;
 Thu, 13 Aug 2026 22:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786658842;
 bh=Ez2O9EsudjqKbgFt8anSxfHUeZ2ZMxQcNR7I27pkmB0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iE2eEBERz3CImuJeTC14peEtP6MZMqtZ0bdt1AwZ4C9hcqozPps9BkJEAdQ1aI3IU
 iOZLDB2DAOLDrPjKIhj8P2sGuTa6x2b5PEgiXvg7bVPziIVUgKY3VbAedz8puDXqJo
 gE5lnt4ZErlmwj7pt1uJKKldECVf9COGJPcO83sjEIsMzxA9WVhrtyFKu7qNanjU6R
 Q4eI+kP9bH6JrUOMLl5m88lV9fTRDjqV+E7PkFhSoj/7Rhvtkg7XssZ7W4duv+g8q1
 kXbVZekCoIFcEMAw/tJOH+kVCqGZBVL4U+BUBj0HMQMgwKHVQEKmioMfUdv91RRI5Z
 b6nltxUpeTZfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/bridge: Add ITE IT6162 MIPI DSI to HDMI
 bridge driver
To: "Hermes Wu via B4 Relay" <devnull+Hermes.wu.ite.com.tw@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260319-upstream-6162-v4-2-7268483ef03d@ite.com.tw>
References: <20260319-upstream-6162-v4-2-7268483ef03d@ite.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:07:18 +0000
Message-Id: <20260813220722.123571F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [High] Unbalanced regulator enable calls cause permanent resource leaks d=
uring probe error paths, duplicate enables on successful probe, and missing=
 disables on driver removal.
- [High] Missing mutex lock in `it6162_write_infoframe()` and `it6162_clear=
_infoframe()` causes concurrent I2C register corruption.
- [High] The HDCP worker thread calls `drm_hdcp_update_content_protection()=
` without holding the required DRM `connection_mutex`.
- [High] The `video_setting` struct is missing zero-initialization, causing=
 uninitialized stack memory to be written to hardware registers.
- [High] Ignored return values from I2C regmap reads cause hardware logic t=
o execute based on uninitialized stack memory.
- [High] Premature destruction of mutex and workqueue before the DRM bridge=
 is unregistered, creating a Use-After-Free/Use-After-Destroy window.
- [High] Incorrect bitwise assembly of `chip_id` and `version` due to rever=
sed endianness, causing probe to fail on real hardware.
- [Medium] Adjusted display timings validated during `atomic_check` are com=
pletely ignored in `atomic_enable`.
- [Medium] Device tree node reference leak in `it6162_load_mipi_pars_from_p=
ort()` on early error return.
- [Medium] Potential NULL pointer dereference of `chip_info` in `it6162_det=
ect_devices()`.
- [Medium] `it6162_get_edid_block()` ignores the provided `len` parameter, =
potentially writing past the bounds of the destination buffer.
- [Medium] Lockless concurrent access to `it6162->connector_status` can lea=
d to missed HPD notifications.
--

--- Patch [2]: [PATCH v4 2/2] drm/bridge: Add ITE IT6162 MIPI DSI to HDMI b=
ridge driver ---
commit 53d21a12a42eb37de64cf50aa087df4e67188c9d
Author: Hermes Wu <Hermes.wu@ite.com.tw>
Subject: drm/bridge: Add ITE IT6162 MIPI DSI to HDMI bridge driver

This commit adds support for the ITE IT6162 MIPI DSI to HDMI 2.0 bridge chi=
p.
It implements the DRM bridge and connector frameworks, supporting mode sett=
ing,
EDID retrieval, and HPD.

> diff --git a/drivers/gpu/drm/bridge/ite-it6162.c b/drivers/gpu/drm/bridge=
/ite-it6162.c
> new file mode 100644
> index 0000000000000..09274468dc73f
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/ite-it6162.c

[ ... ]

> +static void it6162_tx_hdcp_enable(struct it6162 *it6162,
> +				  struct it6162_hdcp_cfg *tx_out)
> +{
> +	int val;
> +	struct regmap *regmap =3D it6162->regmap;
> +
> +	guard(mutex)(&it6162->lock);
> +	it6162->hdcp_sts =3D HDCP_STATE_IDLE;
> +
> +	regmap_read(regmap, OFFSET_TX_SETTING, &val);
> +	val &=3D 0x0F;

[Severity: High]
Does this code process uninitialized memory if the regmap_read() fails?
If the I2C read encounters an error, regmap_read() will leave val=20
uninitialized, but its return value is ignored here. The driver then applie=
s=20
a bitmask to stack garbage and writes it back to the hardware.

[ ... ]

> +static inline void
> +it6162_display_mode_to_settings(struct drm_display_mode *mode,
> +				struct it6162_video_settings *settings)
> +{
> +	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> +		settings->hpol =3D 1;
> +
> +	if (mode->flags & DRM_MODE_FLAG_NVSYNC)
> +		settings->vpol =3D 1;
> +
> +	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
> +		settings->prog =3D 0;

[Severity: High]
Can this leave hardware settings uninitialized? In
it6162_bridge_atomic_enable(), video_setting is declared without zero
initialization. Here in it6162_display_mode_to_settings(), hpol, vpol,
and prog are conditionally assigned. If the corresponding flags are missing
from mode->flags, these fields will contain uninitialized stack memory,
which is later packed into a byte and sent to the hardware in
it6162_pack_video_setting().

[ ... ]

> +static void it6162_hdcp_handler(struct it6162 *it6162)
> +{
[ ... ]
> +			case HDCP_STATE_AUTH_FAIL:
> +				if (hdcp_ver =3D=3D HDCP_23)
> +					it6162_tx_hdcp_setup(it6162, HDCP_14,
> +							     true);
> +				else
> +					it6162_tx_hdcp_disable(it6162);
> +
> +				break;
> +			default:
> +				it6162_tx_hdcp_setup(it6162,
> +						     it6162->hdcp_version,
> +						     true);
> +				break;
> +			}
> +			drm_hdcp_update_content_protection(it6162->connector,
> +							   cp_status);
> +		}
> +	}
> +}

[Severity: High]
Is it safe to call drm_hdcp_update_content_protection() from this context?
This is executed asynchronously from a delayed workqueue thread
(it6162_hdcp_work). The DRM helper requires the caller to hold the
dev->mode_config.connection_mutex lock, which is not acquired here. This
could lead to a kernel warning splat and data races.

[ ... ]

> +static void it6162_interrupt_handler(struct it6162 *it6162)
> +{
[ ... ]
> +	connector_status =3D GET_TX_HPD_STATUS(tx_status) ?
> +			   connector_status_connected :
> +			   connector_status_disconnected;
> +
> +	if (it6162->connector_status !=3D connector_status) {
> +		it6162->connector_status =3D connector_status;
> +		drm_bridge_hpd_notify(&it6162->bridge,
> +				      it6162->connector_status);
> +	}

[Severity: Medium]
Could this miss HPD notifications due to lockless state tracking?
The it6162_detect() function reads hardware status and updates
it6162->connector_status without locks. If a concurrent ioctl triggers
it6162_detect() right before this check in the IRQ handler, the IRQ might
observe no change and fail to call drm_bridge_hpd_notify().

[ ... ]

> +static int it6162_platform_set_power(struct it6162 *it6162)
> +{
> +	int err;
> +
> +	err =3D regulator_enable(it6162->ivdd);
> +	if (err)
> +		return err;
> +
> +	err =3D regulator_enable(it6162->pwr1833);
> +	if (err)
> +		return err;
> +
> +	err =3D regulator_enable(it6162->ovdd);
> +	if (err)
> +		return err;

[Severity: High]
Does this code leak enabled regulators on failure? If enabling pwr1833
or ovdd fails, the function returns early without calling
regulator_disable() for the already-enabled ivdd and pwr1833.

[ ... ]

> +static int it6162_detect_devices(struct it6162 *it6162)
> +{
> +	struct device *dev =3D it6162->dev;
> +	const struct it6162_chip_info *chip_info;
> +	u32 chip_id, version;
> +	u8 buf[6];
> +
> +	if (it6162_platform_set_power(it6162) < 0)
> +		return -ENODEV;
> +
> +	/* Firmware must finish booting before register access is valid */
> +	if (!it6162_wait_mcu_ready(it6162))
> +		return -ENODEV;
> +
> +	chip_info =3D of_device_get_match_data(dev);
> +	regmap_bulk_read(it6162->regmap, OFFSET_CHIP_ID_L, &buf[0], 6);

[Severity: Medium]
Will this crash if probed without a device tree? If the driver is bound
via sysfs or an ACPI fallback using it6162_i2c_ids, of_device_get_match_dat=
a()
will return NULL, which is unconditionally dereferenced below.

[Severity: High]
Does this code process uninitialized memory if the regmap_bulk_read() fails?
The return value is ignored. If the read fails, the stack buffer buf
remains uninitialized, and the driver will attempt to match a chip ID
built from garbage memory.

> +	chip_id =3D (buf[0] << 16) | (buf[1] << 8) | (buf[2]);
> +	version =3D (buf[3] << 16) | (buf[4] << 8) | (buf[5]);

[Severity: High]
Is the bitwise assembly of chip_id correct for little-endian hardware?
If buf[0] holds the LSB from OFFSET_CHIP_ID_L, shifting it by 16 places it
in the MSB position. This reverses the endianness, causing the chip ID and
version comparison to fail on real hardware.

> +	if (chip_id =3D=3D chip_info->chip_id && version >=3D chip_info->versio=
n)
> +		return 0;

[ ... ]

> +static enum drm_connector_status it6162_detect(struct it6162 *it6162)
> +{
> +	struct regmap *regmap =3D it6162->regmap;
> +	unsigned int tx_status;
> +
> +	regmap_read(regmap, OFFSET_TX_STATUS, &tx_status);
> +	it6162->connector_status =3D GET_TX_HPD_STATUS(tx_status) ?
> +				   connector_status_connected :
> +				   connector_status_disconnected;
> +	return it6162->connector_status;
> +}

[Severity: High]
Does this ignore the return value of regmap_read()? If the I2C read fails,
tx_status contains uninitialized stack memory, which will be parsed as a
hot-plug status, causing erratic or false connector state tracking.

[ ... ]

> +static int it6162_get_edid_block(void *data, u8 *buf, unsigned int block,
> +				 size_t len)
> +{
> +	struct it6162 *it6162 =3D data;
> +	unsigned int i, cnt;
> +	int ret;
> +	u8 config;
> +
> +	if (len > EDID_LENGTH)
> +		return -EINVAL;
> +
> +	guard(mutex)(&it6162->lock);
> +	for (i =3D 0, cnt =3D 0; i < EDID_LENGTH; i +=3D DATA_BUFFER_DEPTH, cnt=
++) {
> +		config =3D (block << 2) | (cnt);
> +		ret =3D it6162_infoblock_request_data(it6162, HOST_SET_EDID_R,
> +						    config, buf + i);

[Severity: Medium]
Will this overwrite memory if the requested len is smaller than EDID_LENGTH?
While it ensures len is not too large, the loop always unconditionally
reads exactly EDID_LENGTH (128) bytes from hardware into buf.

[ ... ]

> +static int it6162_load_mipi_pars_from_port(struct it6162 *it6162, int po=
rt)
> +{
> +	struct device_node *of =3D it6162->dev->of_node;
> +	struct device_node *endpoint;
> +	struct it6162_mipi_cfg *mipicfg =3D &it6162->mipi_cfg;
> +	u32 data_lanes[4] =3D {1};
> +	u32 lane_polarities[5] =3D {0};
> +	int dsi_lanes;
> +
> +	endpoint =3D of_graph_get_endpoint_by_regs(of, port, -1);
> +	if (!endpoint)
> +		return 0;
> +
> +	dsi_lanes =3D drm_of_get_data_lanes_count(endpoint, 1, 4);
> +	if (dsi_lanes < 0)
> +		return dsi_lanes;

[Severity: Medium]
Does this code leak the endpoint device node? If drm_of_get_data_lanes_coun=
t()
returns a negative error, the function returns without calling of_node_put()
to release the reference acquired by of_graph_get_endpoint_by_regs().

[ ... ]

> +static int it6162_attach_dsi(struct it6162 *it6162)
> +{
[ ... ]
> +		dsi->lanes =3D mipi_cfg->lane_num;
> +		dsi->format =3D mipi_cfg->format;
> +		dsi->mode_flags =3D mipi_cfg->mode_flags;
> +		ret =3D devm_mipi_dsi_attach(dev, dsi);
> +		if (ret) {
> +			dev_err(dev, "failed to attach dsi device %d", port);
> +			return ret;
> +		}
> +	}
> +
> +	it6162_poweron(it6162);
> +	return 0;
> +}

[Severity: High]
Does this cause duplicate regulator enables? The driver's probe function
calls it6162_detect_devices(), which successfully calls
it6162_platform_set_power(). Later, it6162_attach_dsi() calls it6162_powero=
n(),
which calls it6162_platform_set_power() a second time, leaving the regulator
enable counts permanently unbalanced.

[ ... ]

> +static void it6162_bridge_atomic_enable(struct drm_bridge *bridge,
> +					struct drm_atomic_state *state)
> +{
> +	struct it6162 *it6162 =3D bridge_to_it6162(bridge);
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_connector_state *conn_state;
> +	struct drm_connector *connector;
> +	struct hdmi_avi_infoframe *avi;
> +	struct it6162_video_settings video_setting;
[ ... ]
> +	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
> +	avi =3D &conn_state->hdmi.infoframes.avi.data.avi;
> +	video_setting.colorspace =3D conn_state->hdmi.output_format;
> +	it6162_avi_to_video_setting(avi, &video_setting);
> +	it6162_display_mode_to_settings(&crtc_state->mode, &video_setting);
> +
> +	it6162_mipi_set_video_timing(it6162, &video_setting);
> +	it6162_tx_enable(it6162);
> +	it6162_mipi_enable(it6162);
> +}

[Severity: Medium]
Should this use crtc_state->adjusted_mode instead of crtc_state->mode?
The it6162_bridge_atomic_check() function enforces hardware constraints by
modifying the horizontal front porch in crtc_state->adjusted_mode. However,
this function discards those adjustments and passes the original unadjusted
mode directly to it6162_display_mode_to_settings().

[ ... ]

> +static inline int
> +it6162_write_infoframe(struct it6162 *it6162, const u8 *buffer, size_t l=
en)
> +{
> +	if (len > DATA_BUFFER_DEPTH)
> +		return -EINVAL;
> +
> +	regmap_bulk_write(it6162->regmap, OFFSET_DATA_BUFFER, buffer, len);
> +	regmap_write(it6162->regmap, OFFSET_DATA_TYPE_IDX, len);
> +	it6162_infoblock_trigger(it6162, HOST_SET_CEA_INFOFRAME);
> +	return 0;
> +}
> +
> +static inline int it6162_clear_infoframe(struct it6162 *it6162, u8 type)
> +{
> +	regmap_write(it6162->regmap, OFFSET_DATA_TYPE_IDX, 3);
> +	regmap_write(it6162->regmap, OFFSET_DATA_BUFFER, type);
> +	regmap_write(it6162->regmap, OFFSET_DATA_BUFFER + 1, 0x00);
> +	regmap_write(it6162->regmap, OFFSET_DATA_BUFFER + 2, 0x00);
> +	it6162_infoblock_trigger(it6162, HOST_SET_CEA_INFOFRAME);
> +	return 0;
> +}

[Severity: High]
Do these functions lack the necessary mutex lock? They write to the shared
mailbox registers (OFFSET_DATA_BUFFER and OFFSET_DATA_TYPE_IDX) and trigger
firmware commands without acquiring it6162->lock. Since they are called dur=
ing
atomic commits, they could corrupt concurrent I2C register accesses from
it6162_get_edid_block() or it6162_hdcp_read_information().

[ ... ]

> +static void it6162_remove(struct i2c_client *client)
> +{
> +	struct it6162 *it6162 =3D i2c_get_clientdata(client);
> +
> +	disable_irq(client->irq);
> +	cancel_delayed_work_sync(&it6162->hdcp_work);
> +	mutex_destroy(&it6162->lock);
> +}

[Severity: High]
Does this code leak the enabled regulators during driver removal? There is =
no
call to regulator_disable() or the it6162_poweroff() helper during teardown.

[Severity: High]
Is this prone to a use-after-destroy window? The DRM bridge is registered
with devm_drm_bridge_add(), so it remains globally active until after this
remove function returns. If userspace issues an ioctl (e.g., an EDID read or
modeset) concurrently during unbind, the bridge callbacks will try to lock =
the
already-destroyed mutex.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260319-upstream-6=
162-v4-0-7268483ef03d@ite.com.tw?part=3D2
