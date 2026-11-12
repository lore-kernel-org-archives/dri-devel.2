Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A84606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFlXZJlQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A7110E40D;
	Thu, 12 Nov 2026 03:58:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E07A10E40D
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:58:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C8C64050C;
 Thu, 12 Nov 2026 03:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D761F00A05;
 Thu, 12 Nov 2026 03:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794455902;
 bh=HlWDqEj4R8nJjL8od1fWZ9tszL5o1gOqhYRAiKGBth4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HFlXZJlQRjquc5/yWrtGqNq8Xqm2CCfDPHzm7oQQE1esZSK8jDwuPIFgYmNkqWBFo
 MtZvWpkgUjDrzoLWQFohZ3fXJWQFOaxip6jHCyRYxXH6f3W46u3mriT526knwxgPUM
 6iizbDldIsVpdkb4KSOsjMjL3oO3slhxigVdOtVTLZ5f2g7qJ3y48hAbFE+mVh+AiM
 /jLbdPSP6kjBbY4KRnL8PMB6HkjMc5dlQO0XB43Dw/60MpOdWAfnlqCa97SQQ8Ox/K
 VqOVweq58dcwhsHzBcWRRTqiS97VSe4x+miWLjHvZCVj3tJH9pdkLDdOmB3W8GoAOC
 P1lITGJx04wMg==
Message-ID: <sashiko-outbox-210304@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] drm/fl2000: Add USB driver with register and I2C
 access
To: "Angel Gabriel Crispin Valdivia" <angelcrispinvaldivia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-fl2000-upstream-v2-1-201f87708cb0@gmail.com>
References: <20261111-fl2000-upstream-v2-0-201f87708cb0@gmail.com>
 <20261111-fl2000-upstream-v2-1-201f87708cb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:58:21 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/fl2000: unchecked regmap writes in int register helpers
--

commit 1083af596ecfae2d3d352f9d352bcede51d3408e
Author: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>

drm/fl2000: Add USB driver with register and I2C access

This commit adds the initial USB driver for Fresco Logic FL2000 display
adapters, including regmap-backed register helpers and an I2C adapter.

> diff --git a/drivers/gpu/drm/fl2000/fl2000_registers.c b/drivers/gpu/drm/=
fl2000/fl2000_registers.c
> new file mode 100644
> index 0000000000000..f1cd28434a520
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_registers.c

[ ... ]

> +int fl2000_set_pll(struct regmap *regmap, struct fl2000_pll *pll)
> +{
> +	u32 val;
> +
> +	val =3D FIELD_PREP(FL2000_VGA_PLL_PRESCALER, pll->prescaler) |
> +	      FIELD_PREP(FL2000_VGA_PLL_MULTIPLIER, pll->multiplier) |
> +	      FIELD_PREP(FL2000_VGA_PLL_DIVISOR, pll->divisor) |
> +	      FIELD_PREP(FL2000_VGA_PLL_FUNCTION, pll->function);
> +	regmap_write(regmap, FL2000_VGA_PLL_REG, val);
> +
> +	val =3D FL2000_VGA_CTRL_ACLK_FORCE_PLL_UP;
> +	regmap_write_bits(regmap, FL2000_VGA_CTRL_REG_ACLK, val, val);
> +
> +	return 0;
> +}

[ ... ]

> +int fl2000_set_timings(struct regmap *regmap, struct fl2000_timings *tim=
ings)
> +{
> +	regmap_write(regmap, FL2000_VGA_HSYNC_REG1,
> +		     FIELD_PREP(FL2000_VGA_HSYNC1_HACTIVE, timings->hactive) |
> +		     FIELD_PREP(FL2000_VGA_HSYNC1_HTOTAL, timings->htotal));
> +
> +	regmap_write(regmap, FL2000_VGA_HSYNC_REG2,
> +		     FIELD_PREP(FL2000_VGA_HSYNC2_HSYNC_WIDTH, timings->hsync_width) |
> +		     FIELD_PREP(FL2000_VGA_HSYNC2_HSTART, timings->hstart));
> +
> +	regmap_write(regmap, FL2000_VGA_VSYNC_REG1,
> +		     FIELD_PREP(FL2000_VGA_VSYNC1_VACTIVE, timings->vactive) |
> +		     FIELD_PREP(FL2000_VGA_VSYNC1_VTOTAL, timings->vtotal));
> +
> +	regmap_write(regmap, FL2000_VGA_VSYNC_REG2,
> +		     FIELD_PREP(FL2000_VGA_VSYNC2_VSYNC_WIDTH, timings->vsync_width) |
> +		     FIELD_PREP(FL2000_VGA_VSYNC2_VSTART, timings->vstart) |
> +		     FIELD_PREP(FL2000_VGA_VSYNC2_START_LATENCY, timings->vstart));
> +
> +	return 0;
> +}
> +
> +int fl2000_set_pixfmt(struct regmap *regmap, u32 bytes_pix)
> +{
> +	u32 mask, val;
> +
> +	mask =3D FL2000_VGA_CTRL_PXCLK_DAC_OUTPUT_EN | FL2000_VGA_CTRL_PXCLK_DR=
OP_CNT |
> +	       FL2000_VGA_CTRL_PXCLK_VGA565_MODE | FL2000_VGA_CTRL_PXCLK_VGA332=
_MODE |
> +	       FL2000_VGA_CTRL_PXCLK_VGA555_MODE | FL2000_VGA_CTRL_PXCLK_VGA_CO=
MPRESS |
> +	       FL2000_VGA_CTRL_PXCLK_CLEAR_WATERMARK;
> +	val =3D FL2000_VGA_CTRL_PXCLK_DAC_OUTPUT_EN | FL2000_VGA_CTRL_PXCLK_CLE=
AR_WATERMARK;
> +	if (bytes_pix =3D=3D 2)
> +		val |=3D FL2000_VGA_CTRL_PXCLK_VGA565_MODE;
> +	regmap_write_bits(regmap, FL2000_VGA_CTRL_REG_PXCLK, mask, val);
> +
> +	return 0;
> +}
> +
> +int fl2000_set_transfers(struct regmap *regmap)
> +{
> +	u32 mask;
> +
> +	mask =3D FL2000_VGA_CTRL_ACLK_USE_PKT_PENDING | FL2000_VGA_CTRL_ACLK_US=
E_ZERO_TD |
> +	       FL2000_VGA_CTRL_ACLK_USE_ZERO_PKT_LEN;
> +	regmap_write_bits(regmap, FL2000_VGA_CTRL_REG_ACLK, mask,
> +			  FL2000_VGA_CTRL_ACLK_USE_ZERO_PKT_LEN);
> +
> +	regmap_write_bits(regmap, FL2000_VGA_ISOCH_REG, FL2000_VGA_ISOCH_MFRAME=
_CNT, 0);
> +
> +	return 0;
> +}
> +
> +int fl2000_reset(struct regmap *regmap)
> +{
> +	regmap_write_bits(regmap, FL2000_RST_CTRL_REG, FL2000_RST_CTRL_SW_RESET,
> +			  FL2000_RST_CTRL_SW_RESET);
> +
> +	msleep(FL2000_HW_RST_MDELAY);
> +
> +	return 0;
> +}
> +
> +int fl2000_afe_magic(struct regmap *regmap)
> +{
> +	regmap_write_bits(regmap, FL2000_USB_LPM_REG, FL2000_USB_LPM_MAGIC, FL2=
000_USB_LPM_MAGIC);
> +
> +	return 0;
> +}
> +
> +int fl2000_usb_magic(struct regmap *regmap)
> +{
> +	u32 val;
> +
> +	/* Writing DONE as 0 would start an I2C operation, see fl2000_i2c_dword=
() */
> +	val =3D FL2000_VGA_I2C_SC_MONITOR_DETECT | FL2000_VGA_I2C_SC_EDID_DETEC=
T |
> +	      FL2000_VGA_I2C_SC_DONE;
> +	regmap_write_bits(regmap, FL2000_VGA_I2C_SC_REG, val, val);
> +
> +	regmap_write_bits(regmap, FL2000_VGA_CTRL_REG_3, FL2000_VGA_CTRL3_WAKEU=
P_CLR_EN, 0);
> +
> +	val =3D FL2000_USB_LPM_U1_REJECT | FL2000_USB_LPM_U2_REJECT;
> +	regmap_write_bits(regmap, FL2000_USB_LPM_REG, val, val);
> +
> +	regmap_write_bits(regmap, FL2000_USB_CTRL_REG, FL2000_USB_CTRL_WAKE_NRD=
Y, 0);
> +
> +	return 0;
> +}
> +
> +/* The interrupts about monitors: they matter from the moment the device=
 is up, mode or no mode */
> +int fl2000_enable_sink_interrupts(struct regmap *regmap)
> +{
> +	regmap_write_bits(regmap, FL2000_VGA_CTRL_REG_ACLK, FL2000_VGA_CTRL_ACL=
K_EDID_MON_INT_EN,
> +			  FL2000_VGA_CTRL_ACLK_EDID_MON_INT_EN);
> +
> +	regmap_write_bits(regmap, FL2000_VGA_CTRL2_REG_ACLK, FL2000_VGA_CTRL2_A=
CLK_HDMI_INT_EN,
> +			  FL2000_VGA_CTRL2_ACLK_HDMI_INT_EN);
> +
> +	return 0;
> +}

[Severity: Medium]
Should these int-returning register helpers check and propagate errors from
regmap_write() and regmap_write_bits(), like fl2000_force_connect() and
fl2000_stream_interrupts() do?

Each regmap access runs a synchronous USB control transfer via
usb_control_msg_recv() or usb_control_msg_send().  When a transfer fails or
times out, these helpers still return 0 and continue issuing further USB
control transfers, hiding initialization or modeset failures from callers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-fl2000-ups=
tream-v2-0-201f87708cb0@gmail.com?part=3D1
