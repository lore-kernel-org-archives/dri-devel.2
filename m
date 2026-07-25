Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947F0C531D0
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8A3B10F507;
	Sat, 25 Jul 2026 05:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xape2hWe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B840910F507
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:12:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6880E42D53;
 Sat, 25 Jul 2026 05:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64D01F000E9;
 Sat, 25 Jul 2026 05:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956323;
 bh=zfDIe0jTVWLaFGOUrSraY+Ff1wIleInx4p1re0OCiRI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Xape2hWexNPq6GbnmbuuCpBIQ2DGvKC4NPtjqhCIr6sQsOQQjifP2pXjoIvWwtAGN
 CYWK2zEB+9uWmJiEXShV8tkH2hnXHDmpj0dgJZXN3sMU8D6SE7NBPEXogY1emgEVIj
 A0WJJxSKYrAJstAOMUGbDdi54GR7rfjPV5C1k4hgg2PeeWawf1AS1PRMvfmjMtPUvD
 YMRX+B2oU5PUa3ko2dPPSoJoJfzOokUIT4igmwqXuUmO0ivk884ZDkoJ5TSHLtm/UR
 H4vWrSFdnjU0SUB5wkWNARBhr3Sxm8XtObk12ki8Ro98MZjIEInor5YHCLuY0QD2Kj
 KEkKzD5mdI5Mg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 15/17] riscv: dts: spacemit: k3-pico-itx: enable
 the DisplayPort output
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: vkoul@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, olteanv@gmail.com, neil.armstrong@linaro.org,
 linux-phy@lists.infradead.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260725-k3-display-v1-15-6de34d80e86c@gmail.com>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-15-6de34d80e86c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:12:02 +0000
Message-Id: <20260725051202.C64D01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Precision Loss in DP Timing Configuration due to integer division
- [High] Protocol Violation in I2C-over-AUX EDID Read (Missing MOT flag)
--

--- Patch [15]: [PATCH RESEND 15/17] riscv: dts: spacemit: k3-pico-itx: ena=
ble the DisplayPort output ---
commit 8521347c30ea3dc057bb9d8b08c1de584bd6ba67
Author: Cody Kang <codykang.hk@gmail.com>

riscv: dts: spacemit: k3-pico-itx: enable the DisplayPort output

This commit enables the second Saturn DPU and the corresponding DisplayPort
controller on the Pico-ITX board. While this patch configures the devicetree
to route the DPU output, it exposes regressions in the newly added underlyi=
ng
Innosilicon DP/eDP driver.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_inno_dp.c b/drivers/gpu/dr=
m/spacemit/spacemit_inno_dp.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_inno_dp.c
[ ... ]
> @@ -982,19 +982,19 @@ static void spacemit_dp_hw_set_msa_and_enable_video=
(struct spacemit_dp_dev *dp,
>  						    const struct drm_display_mode *mode,
>  					       enum spacemit_dp_link_rate rate,
>  					       enum spacemit_dp_lane_count lanes,
>  		u32 color_format)
>  {
>  	u64 hb_num;
>  	u32 link_rate;
>  	u32 fp; /* Pixel clock in MHz */
>  	u32 bpp, misc0;
>  	u32 tu, tu_frac, tu_int, rd_thres;
>  	u32 hsync_len;
> =20
>  	/* mode->clock unit is kHz, fp unit is MHz */
>  	if (dp->use_ext_pixel_clock)
>  		fp =3D dp->pixel_clock / 1000;
>  	else
>  		fp =3D mode->clock / 1000;
> =20
>  	if (fp =3D=3D 0)
>  		fp =3D 1; /* Prevent division by zero */

[Severity: High]
Will dividing by 1000 here truncate necessary precision?

Since mode->clock / 1000 discards the fractional part (for example, a 74.25
MHz clock becomes 74 MHz), this truncated value is used in calculating the
Transfer Unit size and horizontal blanking interval. This discrepancy can
cause the display controller and the DP transmitter to disagree on the
required bandwidth, resulting in the DP TX FIFO overflowing and corrupting
the display for common standard resolutions like 720p and 1080p.

[ ... ]
> @@ -1278,9 +1278,9 @@ static int spacemit_dp_aux_i2c_write(struct spacemi=
t_dp_dev *dp, u32 address,
>  				     const u8 *buf, size_t len)
>  {
>  	struct drm_dp_aux_msg msg =3D {
>  		.address =3D address,
>  		.request =3D DP_AUX_I2C_WRITE,

[Severity: High]
Is it intentional to hardcode DP_AUX_I2C_WRITE here without allowing the
DP_AUX_I2C_MOT (Middle Of Transaction) flag to be appended?

[ ... ]
> @@ -1320,11 +1320,11 @@ static int spacemit_dp_conn_get_edid_block(void *=
data, u8 *buf,
>  	int ret, retry;
>  	size_t offset;
> =20
>  	if (segment) {
>  		for (retry =3D 0; retry < 3; retry++) {
>  			ret =3D spacemit_dp_aux_i2c_write(dp,
>  				SPACEMIT_DP_DDC_SEGMENT_ADDR, &segment, 1);
>  			if (!ret)
>  				break;
>  		}

[Severity: High]
Can this segment write cause the hardware to generate an I2C STOP condition?

Because spacemit_dp_aux_i2c_write() lacks the MOT flag, writing the E-DDC
segment pointer without it directs the hardware to generate a STOP conditio=
n.
According to the E-DDC specification, a STOP condition immediately after
writing the segment pointer forces the display EEPROM to reset its segment
pointer to 0.

As a result, subsequent reads might always fetch EDID blocks 0 and 1, making
it impossible to correctly read EDID blocks >=3D 2 (such as CTA-861 extensi=
on
blocks) and potentially breaking support for advanced resolutions and audio
and HDR features.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-k3-display=
-v1-0-6de34d80e86c@gmail.com?part=3D15
