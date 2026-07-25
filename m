Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B02C531D0
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:20:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49A2D10F50F;
	Sat, 25 Jul 2026 05:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UXRhN/e1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1B310F513
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:20:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52E7341870;
 Sat, 25 Jul 2026 05:20:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3DA1F00A3A;
 Sat, 25 Jul 2026 05:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956852;
 bh=PXUXK/fDokeeNcb06VtOfelMGDGmgtUKXn+Cnmz51+U=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UXRhN/e1ecuJZulJ9M4I2U+jsXkKyiG7vcUWffXmuTunvHa1RO8b4yVDJ0iGAdd9L
 FQ6j3aKjX3OL3sb/N9EFWXVHdp7ukX44+9Gz+x55CON7fx5Qz4LT/bIfxeKGN6iyTf
 Ocay9SV0yJYB2W4MmgNNHz1EsFmXDzthTzKQuCBrf6qlD1z83jtYN1sZu6N00CN57a
 UkNxtQXtGA/wq0RIXblN2RUne9bIlk0yJHJT8Ohz9ClNTuWAqzmjl+RxrGI3awF+2n
 04D7rLiezJXRj2mtwEzG7jvXbcWBwsq4X17dt2JEPfFqFOBek4qGWTKedNMQHD2F+H
 gcuo50V1PsmMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/17] drm/spacemit: add Innosilicon DP/eDP controller
 bridge driver
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: vkoul@kernel.org, devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com, conor+dt@kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, neil.armstrong@linaro.org
In-Reply-To: <20260724-k3-display-v1-12-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-12-f22a10a52867@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:20:51 +0000
Message-Id: <20260725052051.BB3DA1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Missing W1C handling on DP_GENERAL_INTERRUPT causes unintentionall=
y cleared interrupts.
- [High] Late dynamic bridge attachment breaks `drm_bridge_connector_init` =
for eDP panels, resulting in 0 modes.
- [High] Custom EDID reading bypasses standard DRM core helpers and breaks =
I2C MOT semantics.
- [High] Integer truncation of the pixel clock causes inaccurate DisplayPor=
t Transfer Unit (TU) and HBLANK calculations.
- [High] Link training aborts prematurely because successful DPCD writes ar=
e evaluated as errors.
- [High] Asynchronous panel probe causes Use-After-Free due to improper unb=
ind/error cleanup order.
- [Medium] Returning IRQ_NONE after actively clearing pending hardware inte=
rrupts violates the IRQ API.
- [Medium] Sink capabilities are read concurrently without synchronization.
- [Medium] Hardware shutdown sequence modifies registers without acquiring =
`dp->mode_lock`.
--

--- Patch [12]: [PATCH 12/17] drm/spacemit: add Innosilicon DP/eDP controll=
er bridge driver ---
commit 7a2976d5d6f50aaede0b18a3f5e99c3cb67bd5c1
Author: Cody Kang <codykang.hk@gmail.com>

    drm/spacemit: add Innosilicon DP/eDP controller bridge driver
   =20
    Add the DP/eDP controller that sits downstream of the Saturn DPU. Two
    identical instances share one compatible; the eDP-vs-DP role is board
    wiring, so it is taken from the devicetree: an eDP panel always sits
    under an aux-bus child node, an external DP connector never does.
   =20
    The link is driven through the generic PHY framework, so the controller
    never touches a PLL register. The controller's HPD interrupt is gated by
    the DP pixel clock, which can be off exactly when a plug has to be
    caught, so the connector is also polled and the interrupt path re-reads
    the live level when it does fire.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_inno_dp.c b/drivers/gpu/dr=
m/spacemit/spacemit_inno_dp.c
> index 0000000000000..e88731d9b18bf
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c

[ ... ]

> @@ -290,6 +290,9 @@ static void spacemit_dp_aux_hw_reset(struct spacemit_=
dp_dev *dp)
>  	usleep_range(2000, 2500);
>  	regmap_write_bits(dp->regs, DP_SOFT_RESET, DP_AUX_RESET,
>  			  FIELD_PREP(DP_AUX_RESET, 0x0));
>  	usleep_range(2000, 2500);
>  	regmap_write_bits(dp->regs, DP_GENERAL_INTERRUPT,
>  			  DP_AUX_REPLY_EVENT_INT_STA,
>  			  FIELD_PREP(DP_AUX_REPLY_EVENT_INT_STA, 1));
>  }

[Severity: High]
Does this unintentionally clear other pending interrupts?

DP_GENERAL_INTERRUPT appears to be a write-1-to-clear register. Calling
regmap_write_bits() performs a read-modify-write operation, which reads all
currently asserted interrupt bits and writes them back as 1s.

This drops any unrelated pending interrupts (such as HDCP, overflow events,
and hotplugs) that arrived concurrently.

[ ... ]

> @@ -401,9 +401,12 @@ static ssize_t spacemit_dp_aux_transfer(struct drm_d=
p_aux *aux,
>  	regmap_read(dp->regs, DP_AUX_STS_REG,
>  		    &status); status =3D FIELD_GET(DP_AUX_STATUS, status);
> =20
>  	/* Write 1 to clear. */
>  	regmap_write_bits(dp->regs, DP_GENERAL_INTERRUPT,
>  			  DP_AUX_REPLY_EVENT_INT_STA,
>  			  FIELD_PREP(DP_AUX_REPLY_EVENT_INT_STA, 1));

[Severity: High]
Can this read-modify-write on a write-1-to-clear register silently drop
other pending hardware interrupts that arrive during the AUX transfer?

[ ... ]

> @@ -806,6 +806,8 @@ static int spacemit_dp_aux_i2c_write(struct spacemit_=
dp_dev *dp, u32 address,
>  		.buffer =3D (u8 *)buf,
>  		.size =3D len,
>  	};
>  	int ret;
> =20
>  	ret =3D spacemit_dp_aux_transfer(&dp->aux, &msg);
>  	if (ret < 0)
>  		return ret;

[Severity: High]
Does this custom I2C over AUX implementation bypass synchronization?

By directly invoking spacemit_dp_aux_transfer() here rather than using stan=
dard
DRM core helpers, the code bypasses aux->hw_mutex, allowing concurrent AUX
transactions on the bus.

[ ... ]

> @@ -831,6 +831,10 @@ static int spacemit_dp_link_train_clock_recovery(str=
uct spacemit_dp_dev *dp,
> =20
>  		if (drm_dp_clock_recovery_ok(link_status, lanes))
>  			return 0;
> =20
>  		ret =3D spacemit_dp_link_apply_adjust(dp, link_status, lanes,
>  						    training_set);
>  		if (ret) {
>  			spacemit_dp_set_training_pattern(dp,
>  				DP_TRAINING_PATTERN_DISABLE);
>  			return ret;
>  		}

[Severity: High]
Could this return value check cause link training to fail?

drm_dp_dpcd_write_data() returns the number of bytes written on success
(a positive value). Since spacemit_dp_link_apply_adjust() returns that value
directly, this "if (ret)" check will evaluate to true for successful writes.

This causes the driver to interpret successful DPCD writes as failures and
immediately abort the training sequence.

[ ... ]

> @@ -854,6 +854,10 @@ static int spacemit_dp_conn_get_edid_block(void *dat=
a, u8 *buf,
>  		for (retry =3D 0; retry < 3; retry++) {
>  			ret =3D spacemit_dp_aux_i2c_write(dp, DDC_ADDR,
>  							&edid_offset, 1);
>  			if (ret)
>  				continue;
> =20
>  			ret =3D spacemit_dp_aux_i2c_read(dp, DDC_ADDR,
>  						       buf + offset, chunk);
>  			if (!ret)
>  				break;

[Severity: High]
Can splitting the EDID write and read cause corrupted EDID reads?

The I2C offset write and data read are split into two separate transactions
without the DP_AUX_I2C_MOT (Middle-Of-Transaction) flag.

This generates an I2C STOP condition between them, which causes many DP sin=
ks
to reset their internal EDID offset to 0.

[ ... ]

> @@ -954,6 +954,9 @@ static void spacemit_dp_hw_set_msa_and_enable_video(s=
truct spacemit_dp_dev *dp,
> =20
>  	/* mode->clock unit is kHz, fp unit is MHz */
>  	if (dp->use_ext_pixel_clock)
>  		fp =3D dp->pixel_clock / 1000;
>  	else
>  		fp =3D mode->clock / 1000;
> =20
>  	if (fp =3D=3D 0)

[Severity: High]
Can this integer division truncate fractional pixel clocks?

If mode->clock is a fractional value like 148500 (148.5 MHz), dividing by 1=
000
truncates it to 148.

This loss of precision skews the subsequent DisplayPort Transfer Unit (tu) =
and
horizontal blanking interval (hb_num) calculations, which could cause displ=
ay
output corruption or video FIFO underflows.

[ ... ]

> @@ -1650,6 +1650,9 @@ static int spacemit_dp_bridge_atomic_check(struct d=
rm_bridge *bridge,
> =20
>  	/* No caps yet: leave idx unset and let ->atomic_enable() retry. */
>  	if (!dp->link.max_rate || !dp->link.max_num_lanes) {
>  		st->link_cfg_idx =3D -1;
>  		return 0;
>  	}
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(spacemit_dp_link_priority_table); i++) {

[Severity: Medium]
Is it safe to read dp->link capabilities here without holding dp->mode_lock?

This read races with spacemit_dp_bridge_detect(), which updates these fields
during a hotplug event. A concurrent hotplug could cause the validation path
to see torn or inconsistent sink capabilities.

[ ... ]

> @@ -1777,6 +1777,10 @@ static irqreturn_t spacemit_dp_irq_handler(int irq=
, void *data)
> =20
>  	/*
>  	 * Only compare here: the authoritative connector_status update
>  	 * happens in the thread under mode_lock, via .detect().
>  	 */
>  	if (spacemit_dp_hw_detect_hpd(dp) !=3D READ_ONCE(dp->connector_status))
>  		ret =3D IRQ_WAKE_THREAD; /* Call hotplug_event */
>  	spacemit_dp_hw_clean_hpd(dp);
> =20
>  	drm_dev_exit(idx);
>  	return ret;
>  }

[Severity: Medium]
Should this return IRQ_HANDLED when interrupts are explicitly cleared?

The handler calls spacemit_dp_hw_clean_hpd(), which reads and clears pending
hardware interrupt bits. If the current HPD level matches the cached state
(which can happen during physical contact bounce), the handler returns IRQ_=
NONE.

Returning IRQ_NONE after servicing and clearing a hardware interrupt violat=
es
the IRQ API and can cause the kernel's spurious interrupt detector to perma=
nently
disable the DP interrupt line.

[ ... ]

> @@ -2129,6 +2129,9 @@ static int spacemit_dp_bind(struct device *dev, str=
uct device *master,
> =20
>  	dp->connector =3D drm_bridge_connector_init(drm, &dp->encoder);
>  	if (IS_ERR(dp->connector)) {
>  		ret =3D PTR_ERR(dp->connector);
>  		dev_err(dev, "failed to init bridge connector: %d\n", ret);
>  		goto err_encoder;
>  	}

[Severity: High]
Does this initialize the connector before the panel bridge is attached?

For eDP, the downstream panel bridge is attached dynamically later via the
async probe callback spacemit_dp_edp_link_panel().

Calling drm_bridge_connector_init() here before the panel is attached means
the connector is built without the panel's mode-getting function, resulting
in it reporting 0 modes to userspace.

[ ... ]

> @@ -2160,6 +2160,9 @@ static int spacemit_dp_bind(struct device *dev, str=
uct device *master,
>  	return 0;
> =20
>  err_encoder:
>  	drm_encoder_cleanup(&dp->encoder);
>  err_aux:
>  	drm_dp_aux_unregister(&dp->aux);
>  	return ret;
>  }

[Severity: High]
Can this cleanup order cause a use-after-free?

drm_encoder_cleanup() is called before drm_dp_aux_unregister().

This leaves a window where the eDP panel's asynchronous done_probing callba=
ck
(spacemit_dp_edp_link_panel) can still execute. It will attempt to derefere=
nce
dp->bridge.encoder (which has been zeroed here) and the parent DRM device,
leading to memory corruption.

[ ... ]

> @@ -2327,6 +2327,8 @@ static void inno_dp_shutdown(struct platform_device=
 *pdev)
>  	/* A deferred or failed bind leaves drvdata NULL. */
>  	if (!dp)
>  		return;
> =20
>  	spacemit_dp_hw_disable(dp);
>  }

[Severity: Medium]
Is it safe to modify hardware registers here without acquiring dp->mode_loc=
k?

spacemit_dp_hw_disable() modifies numerous DP configuration registers. Runn=
ing
this during system shutdown without holding the lock allows it to race with
concurrent atomic modesets executed by the DRM core, potentially causing
hardware lockups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-k3-display=
-v1-0-f22a10a52867@gmail.com?part=3D12
