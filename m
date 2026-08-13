Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04262C5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 22:12:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2803510E0A0;
	Thu, 13 Aug 2026 22:12:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lh1jEUN8";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC4F410E0A0
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:12:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0F59D600AF;
 Thu, 13 Aug 2026 22:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581C51F00A3A;
 Thu, 13 Aug 2026 22:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786659149;
 bh=7/ajUBf/brnatU79FYJpJPMbPpVzIY6JW8Y/pmBZeC4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lh1jEUN8xYFb1lvbuVeBzHM9pF1CfG0zMIWgVvnTSdKt78pBCpYP9+5dX8RzdTT2w
 M3VoCGGkDjQ3XmIXeo39eyeJWq7KIiqM8yPpaKGMRktkFv74qxt+BWn1q06IFTOoeq
 tXW+n+sQNoXW8kdaqfikZOnUEv4Cl6FDPUa5lm7bydhJx2YsJmyq/SKt1Q+gVKl1Su
 LwuaZZ+CRbGGm4in1KA453JfrnaHb+noEPC+OdbXeUn6tI683yNERlIpRygnBxPjAT
 GE5NCab5OcDAYQoDMrgogIES8z/MfLGlFuoXpjAKGJqynWrAGdsfy6jz7bwPlawclt
 wl3e2v34zySYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/2] drm/bridge: Add ITE IT61620 MIPI DSI to HDMI
 bridge driver
To: "Pet Weng" <pet.weng@ite.com.tw>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260320-it61620-0714-v8-2-0e70271cf5a9@ite.com.tw>
References: <20260320-it61620-0714-v8-2-0e70271cf5a9@ite.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 22:12:24 +0000
Message-Id: <20260813221225.581C51F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 15 potential issue=
(s) to consider:
- [High] The HDMI interrupt handler checks a register offset macro instead =
of the read value, causing interrupts to be silently ignored.
- [High] Deadlock between the PM runtime suspend callback and the threaded =
IRQ handler.
- [High] Calling `drm_hdcp_update_content_protection()` without holding `co=
nnection_mutex` triggers a WARN_ON and creates a state race.
- [High] The delayed work `hdcp_work` is not canceled during driver removal=
, leading to a Use-After-Free.
- [High] Double detachment of the MIPI DSI device due to mixing manual and =
devm-managed teardown.
- [High] Unclamped DDC FIFO read count in `it61620_hdmi_hdcp_ksvlist_rd` ca=
n cause a heap buffer overflow or an infinite loop.
- [High] Incorrect SHA-1 hash length computation breaks HDCP authentication.
- [High] edid_read accesses powered-off hardware, causing regmap_read failu=
res and pervasive use of uninitialized stack variables.
- [High] Premature destruction of `ddc_lock` in `it61620_remove()` before t=
he bridge is unregistered.
- [Medium] PM runtime and regulator state leaks in probe errors and remove =
path.
- [Medium] Incorrect regulator disable order in it61620_poweroff().
- [Medium] `it61620_parse_dt()` is declared to return `unsigned int` but re=
turns negative error codes.
- [Medium] Unprotected DDC hardware access in `it61620_hdmi_ddc_abort()`.
- [Medium] Uninitialized stack variables are written to hardware registers =
if unsupported audio parameters are supplied.
- [Medium] Unsigned underflow in abs(htotal - 2880) causes incorrect delay =
calculation.
--

--- Patch [2]: [PATCH v8 2/2] drm/bridge: Add ITE IT61620 MIPI DSI to HDMI =
bridge driver ---
commit 0da87ff1083d89041b3e6585c68651e55d9e8de2
Author: Pet Weng <pet.weng@ite.com.tw>

drm/bridge: Add ITE IT61620 MIPI DSI to HDMI bridge driver

This adds support for the ITE IT61620 bridge chip which converts
MIPI DSI input to HDMI output. The Driver implements the basic
bridge functions and integrates with the DRM bridge and connector
frameworks.

> diff --git a/drivers/gpu/drm/bridge/ite-it61620.c b/drivers/gpu/drm/bridg=
e/ite-it61620.c
> index 0000000000000..95771e5a39114
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/ite-it61620.c

[ ... ]

> @@ -353,10 +353,10 @@ static void it61620_mipi_set_d2v_video_timing(struc=
t it61620 *it61620,
>  	if (it61620->dev_ver !=3D DEV_VERSION_A0)
>  		regmap_update_bits(it61620->mipirx_regmap, RX_REG_SELDCLK, 0x1c, 0x04);
> =20
>  	if (hdew > 1920) {
>  		if (htotal < 4272) {

[Severity: Medium]
Could htotal - 2880 underflow here? Since htotal is defined as a u32 and can
be less than 2880, the result might wrap around to a very large positive
integer. The abs() macro would return this unsigned value unchanged,
resulting in a large value being divided by 24 and cast to u8, which could
configure incorrect video timing delays.

>  			d2vffrd_adr_dly =3D abs(htotal - 2880) / 24;
>  			regmap_write(it61620->mipirx_regmap, RX_REG_DSC_VFRD,
>  				     d2vffrd_adr_dly);
>  		} else {

[ ... ]

> @@ -482,10 +482,10 @@ static void it61620_hdmi_ddc_abort(struct it61620 *=
it61620)
>  static unsigned int it61620_hdmi_read_ddc_status(struct it61620 *it61620)
>  {
>  	unsigned int val;
> =20
>  	regmap_read(it61620->tx_regmap, TX_REG_DDC_STATUS, &val);

[Severity: High]
Is it safe to return val without checking if regmap_read() succeeded? If the
device is powered off, regmap_read() will fail and leave val uninitialized.
This uninitialized stack variable is then returned and used as a loop
termination condition in it61620_hdmi_ddc_wait(), which could lead to
unpredictable polling loop behavior.

>  	return val;
>  }

[ ... ]

> @@ -628,10 +628,10 @@ static int it61620_hdmi_hdcp_ksvlist_rd(struct it61=
620 *it61620,
>  		if (it61620_hdmi_ddc_wait(it61620) < 0) {
>  			it61620_hdmi_ddc_abort(it61620);
>  			ret =3D -EIO;
>  			dev_dbg(it61620->dev, "ddc fail");
>  			break;
>  		}
> =20
>  		regmap_read(it61620->tx_regmap, TX_REG_DDC_FIFO_STS, &count);
>  		count &=3D M_DDC_STAGE_NUM;

[Severity: High]
Can the hardware report a count that exceeds the remaining bytes requested?
The loop blindly accepts the hardware count and writes it to the output
buffer. If count is not clamped to (bytenum - i), it could overflow the
sha1_input buffer. Additionally, if the hardware reports 0 bytes, would this
cause an infinite loop?

>  		it61620_hdmi_get_ddc_fifo(it61620, (out + i), count);
>  		i +=3D count;
>  	}

[ ... ]

> @@ -668,10 +668,10 @@ static int it61620_hdmi_setup_sha1_input(struct it6=
1620 *it61620, u8 *input)
>  	input[count++] =3D bstatus[0];
>  	input[count++] =3D bstatus[1];
> =20
>  	regmap_update_bits(it61620->tx_regmap, TX_REG_SHA_SEL, 0x70, 0x70);
>  	regmap_update_bits(it61620->tx_regmap, TX_REG_HDCP_CTRL2, B_EN_M0_RD, B=
_EN_M0_RD);
>  	regmap_bulk_read(it61620->tx_regmap, TX_REG_ANM0V1, &input[count], 8);
> =20
>  	regmap_update_bits(it61620->tx_regmap, TX_REG_HDCP_CTRL2, B_EN_M0_RD, 0=
x00);

[Severity: High]
Should the count variable be incremented by 8 after reading the M0 value in=
to
the input buffer? Because count is returned without accounting for these 8
bytes, the caller might compute the SHA-1 hash with an incomplete length,
which could cause HDCP repeater authentication to consistently fail.

>  	return count;
>  }

[ ... ]

> @@ -754,10 +754,10 @@ static int it61620_hdmi_enable_hdcp(struct it61620 =
*it61620)
>  	if (auth_cs =3D=3D CS_AUTH_DONE) {
>  		it61620_hdmi_enable_avmute(it61620, false);
>  		regmap_update_bits(it61620->tx_regmap, TX_REG_INT1, B_INT_AUTH_F,
>  				   B_INT_AUTH_F);
>  		regmap_update_bits(it61620->tx_regmap, TX_REG_INT_MASK1, B_INT_AUTH_F,
>  				   B_INT_AUTH_F);
>  		drm_dbg(drm, "auth done");
>  		it61620->hdcp_cp =3D DRM_MODE_CONTENT_PROTECTION_ENABLED;

[Severity: High]
Could calling drm_hdcp_update_content_protection() in this context trigger a
warning from the DRM core? The DRM core expects the mode config
connection_mutex to be held when updating this state. Modifying connector
state concurrently with atomic commits might create data races.

>  		drm_hdcp_update_content_protection(it61620->connector,
>  						   it61620->hdcp_cp);
>  		return true;
>  	}
> =20
>  	drm_dbg(drm, "auth fail");
>  	it61620_hdmi_enable_avmute(it61620, true);

[Severity: Medium]
Is there a risk of concurrent hardware access here? While standard EDID rea=
ds
hold the ddc_lock, this abort routine is called on HDCP error paths without
acquiring the lock. If userspace concurrently attempts an EDID read, it mig=
ht
cause state corruption on the DDC bus.

>  	it61620_hdmi_ddc_abort(it61620);
>  	return false;
>  }

[ ... ]

> @@ -876,10 +876,10 @@ static void it61620_hdmi_irq_hdcp_auth_fail(struct =
it61620 *it61620)
>  {
>  	struct drm_device *drm =3D it61620->drm;
> =20
>  	if (it61620->hdcp_state =3D=3D CP_GOING) {
>  		it61620_hdmi_enable_avmute(it61620, true);
>  		drm_dbg(drm, "auth fail after done, set avmute");
>  		it61620->hdcp_cp =3D DRM_MODE_CONTENT_PROTECTION_DESIRED;

[Severity: High]
Could calling drm_hdcp_update_content_protection() here from the threaded I=
RQ
handler cause lockdep splats or state races? Similar to the previous usage,
the connection_mutex is not held here.

>  		drm_hdcp_update_content_protection(it61620->connector,
>  						   it61620->hdcp_cp);
>  		it61620_start_hdcp_work(it61620);
>  	}
>  }

[ ... ]

> @@ -930,10 +930,10 @@ static void it61620_hdmi_interrupt_handler(struct i=
t61620 *it61620)
>  	regmap_read(it61620->tx_regmap, TX_REG_INT3, &int_status3);
> =20
>  	regmap_write(it61620->tx_regmap, TX_REG_INT1, int_status1);
>  	regmap_write(it61620->tx_regmap, TX_REG_INT2, int_status2);
>  	regmap_write(it61620->tx_regmap, TX_REG_INT3, int_status3);

[Severity: High]
Does this conditional evaluate the TX_REG_INT1 macro (which expands to the
register address 0x10) instead of the int_status1 variable that was just re=
ad?
Since TX_REG_INT1 & B_HPD_CHG always evaluates to 0, this would silently
ignore Hot-Plug Detect and other interrupts.

>  	if (TX_REG_INT1 & B_HPD_CHG)
>  		it61620_hdmi_irq_hpd(it61620);
> =20
>  	if (TX_REG_INT1 & B_RXSEN_CHANGE)
>  		it61620_hdmi_irq_rxsen_chg(it61620);
> =20
>  	if (TX_REG_INT1 & B_INT_AUTH_F)
>  		it61620_hdmi_irq_hdcp_auth_fail(it61620);

[ ... ]

> @@ -1067,10 +1067,10 @@ static void it61620_audio_update_hw_params(struct=
 it61620 *it61620,
>  	case HDMI_I2S:
>  	case HDMI_SPDIF:
>  		break;
>  	default:
>  		return;
>  	}
> =20
>  	is_lpcm =3D !(hparms->iec.status[0] & IEC958_AES0_NONAUDIO);
>  	it61620_hdmi_audio_set_ncts(it61620, hparms->sample_rate);
> =20
>  	drm_dbg(drm, "sample rate %d", sample_rate_val);
>  	drm_dbg(drm, "sample width %d", sample_width);

[Severity: Medium]
Are sample_rate_val and sample_width guaranteed to be initialized? The swit=
ch
statements lack default cases, so if the ALSA/DRM core passes an unsupported
audio parameter, these variables remain uninitialized when they are written
to the hardware registers below.

>  	regmap_update_bits(it61620->tx_regmap, TX_REG_AUD_FMT, 0x7f,
>  			   (sample_width << 5) | it61620->i2s_input_format);

[ ... ]

> @@ -1220,10 +1220,10 @@ static unsigned int it61620_parse_dt(struct it616=
20 *it61620)
>  {
>  	struct device *dev =3D it61620->dev;
>  	struct device_node *np =3D it61620->dev->of_node;
>  	int num_lanes;
> =20
>  	if (!dev->of_node)

[Severity: Medium]
Should this function be declared to return an int? It is currently defined
to return an unsigned int, but it directly returns negative error codes like
-EINVAL and the result of dev_err_probe().

>  		return -EINVAL;
> =20
>  	num_lanes =3D drm_of_get_data_lanes_count_ep(np, 0, -1, 1, 4);
>  	if (num_lanes < 0)
>  		num_lanes =3D 4;
>  	it61620->mipirx_config.lane_num =3D num_lanes;
> =20
>  	it61620->next_bridge =3D devm_drm_of_get_bridge(dev, np, 1, -1);
>  	if (IS_ERR(it61620->next_bridge))
>  		return dev_err_probe(dev, PTR_ERR(it61620->next_bridge),
>  				     "failed to get next bridge\n");
> =20
>  	return 0;
>  }

[ ... ]

> @@ -1310,18 +1310,18 @@ static int it61620_poweroff(struct it61620 *it616=
20)
>  		return 0;
>  	}
> =20
>  	if (it61620->it61620_i2c->irq) {

[Severity: High]
The suspend path calls it61620_poweroff() which synchronously blocks on
disable_irq() waiting for the threaded handler to finish. However, the
threaded handler calls pm_runtime_get_sync(dev), which blocks waiting for
suspend to finish. Could this create an AB-BA deadlock where both paths wait
on each other?

>  		disable_irq(it61620->it61620_i2c->irq);
>  		drm_dbg(drm, "disable irq %d\n",
>  			it61620->it61620_i2c->irq);
>  	}
> =20
>  	gpiod_set_value_cansleep(it61620->gpiod_reset, 1);

[Severity: Medium]
Are the regulators being disabled in the correct order? They are enabled in
the order ivdd, ovdd1833, then ovdd33, but they are disabled here in the
order ovdd33, ivdd, then ovdd1833. Disabling ivdd before ovdd1833 violates
the reverse sequence and might lead to hardware malfunction.

>  	err =3D regulator_disable(it61620->ovdd33);
>  	if (err)
>  		dev_err(dev, "Failed to disable ovdd33: %d", err);
> =20
>  	err =3D regulator_disable(it61620->ivdd);
>  	if (err)
>  		dev_err(dev, "Failed to disable IVDD: %d", err);
> =20
>  	usleep_range(2000, 3000);
> =20
>  	err =3D regulator_disable(it61620->ovdd1833);
>  	if (err)
>  		dev_err(dev, "Failed to disable ovdd1833: %d", err);

[ ... ]

> @@ -1486,10 +1486,10 @@ static const struct drm_edid *it61620_bridge_edid=
_read(struct drm_bridge *bridge
>  						       struct drm_connector *connector)
>  {
>  	struct it61620 *it61620 =3D bridge_to_it61620(bridge);
>  	struct device *dev =3D it61620->dev;
>  	const struct drm_edid *edid;

[Severity: High]
Does this path ensure the device is powered on before accessing the hardwar=
e?
Unprivileged userspace can trigger EDID reads, and if the bridge is current=
ly
runtime-suspended and not awakened via pm_runtime_get_sync(), the subsequent
I2C operations would fail.

>  	edid =3D drm_edid_read_custom(connector, it61620_get_edid_block, it6162=
0);
> =20
>  	if (!edid)
>  		dev_dbg(dev, "failed to get edid!");
> =20
>  	return edid;
>  }

[ ... ]

> @@ -1560,10 +1560,10 @@ static irqreturn_t it61620_int_threaded_handler(i=
nt unused, void *data)
>  {
>  	struct it61620 *it61620 =3D data;
>  	struct device *dev =3D it61620->dev;

[Severity: High]
Can this cause an AB-BA deadlock with the suspend path? The threaded handler
calls pm_runtime_get_sync(dev) below, which blocks waiting for any ongoing
suspend to finish, while suspend waits for this handler via disable_irq().

>  	pm_runtime_get_sync(dev);
> =20
>  	it61620_mipi_irq_handler(it61620);
>  	it61620_hdmi_irq(it61620);

[ ... ]

> @@ -1763,16 +1763,16 @@ static void it61620_remove(struct i2c_client *cli=
ent)
>  {
>  	struct it61620 *it61620 =3D i2c_get_clientdata(client);
>  	struct device *dev =3D it61620->dev;
> =20
>  	disable_irq(client->irq);

[Severity: Medium]
Does this function ensure the device is synchronously powered off before
disabling PM runtime? If the device was active when unbound, calling
pm_runtime_disable() without a prior pm_runtime_put_sync() could leak the
regulator and PM states.

>  	pm_runtime_disable(dev);

[Severity: High]
Is it necessary to call it61620_detach_dsi() here? The DSI device is attach=
ed
using devm_mipi_dsi_attach() during probe, which means the devres framework
will automatically detach it. Doing it manually here might cause a double
detach.

[Severity: High]
Should cancel_delayed_work_sync(&it61620->hdcp_work) be called here? If an
HDCP authentication work item is queued when the driver is unbound, the
pending work might execute after the devres-managed structure is freed,
leading to a use-after-free.

>  	it61620_detach_dsi(it61620);

[Severity: High]
Is it safe to destroy the ddc_lock mutex before the bridge is unregistered?
The bridge is registered via devm_drm_bridge_add(), so it remains active un=
til
the devres cleanup phase, which runs after remove() completes. If userspace
initiates an EDID read during this window, it would attempt to lock a
destroyed mutex.

>  	mutex_destroy(&it61620->ddc_lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260320-it61620-07=
14-v8-0-0e70271cf5a9@ite.com.tw?part=3D2
