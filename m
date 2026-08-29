Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54791C624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:00:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404FC10E682;
	Mon, 31 Aug 2026 07:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="HDqj+Bcf";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="TW++Hb4n";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9563010E094
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 20:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1788035714; bh=D9gR527E+crHrw708MCpBEa
 Z4Y72U3o4s32o2HAIkWA=; b=HDqj+Bcf+gxvZGfa/NKGolduwSX8HUos7+EQ/JOy9gaY40F20h
 EnKFYgfeGWqqvdcuhtxF/1Qx+383VhffOSLURYqGdgIXTDdk3hI3GKfswC59HO8Kapv08uCv8CJ
 4CTkccCWQfjEJ1kxn2YyHXuuzi9Mf2akzWNqZCl0j9BoNNfzMjXCmsWSbsdhJp0Q7GpD21bZ39x
 cqbglG2Pnx+3PH0sa9LUnB/X8kt8CmuHTLyD+3DwmU0nAf68qXIwmWI2p9aqZXnZPJ4NzPc14q5
 0qlHE3tlTqO6gzXzYsas1ICPmrFtS0D5+M4D0TBVEoQONwp5H7YKEQudF6l1YdEXJNw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1788035714; bh=D9gR527E+crHrw708MCpBEa
 Z4Y72U3o4s32o2HAIkWA=; b=TW++Hb4ny+BHSbjlsDX2npsNK2m4ErIaD6NPlVl6MvPpreFEbj
 sjlD2ivRfvPA0fInUecx5/lbrevgpFvDIhCg==;
Message-ID: <7a48378b-4a5d-4dfc-8bf9-9187b6ca6a0c@mainlining.org>
Date: Sat, 29 Aug 2026 23:35:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/2] drivers: gpu: drm: panel: Add BOE NT51021 driver
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
References: <20260829-qcom-novatek-nt51021-panels-v1-0-cc1ca61bd261@mainlining.org>
 <20260829-qcom-novatek-nt51021-panels-v1-2-cc1ca61bd261@mainlining.org>
 <20260829201932.1BFEB1F000E9@smtp.kernel.org>
Content-Language: ru-RU, en-US
From: Nickolay Goppen <setotau@mainlining.org>
In-Reply-To: <20260829201932.1BFEB1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 07:00:03 +0000
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


29.08.2026 23:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The panel initialization sequence lacks the DCS 'Set Display On' (0x29) command.
> - [Medium] Missing reset assertion and stabilization delay during panel preparation.
> --
>
> commit 864f3dccc86bc8a97845ebafd73a7df32e9d6b9e
> Author: Nickolay Goppen <setotau@mainlining.org>
>
> drivers: gpu: drm: panel: Add BOE NT51021 driver
>
> This commit adds support for the BOE NT51021-based 8-inch and 10-inch DSI
> video mode panels used in Xiaomi Mi Pad 4 tablets. It includes panel
> initialization sequences and content-adaptive brightness control.
>
>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt51021.c b/drivers/gpu/drm/panel/panel-novatek-nt51021.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt51021.c
> [ ... ]
>> +static void nt51021_boe_reset(struct boe_nt51021_desc *ctx)
>> +{
>> +	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
>> +	usleep_range(10000, 11000);
>> +}
> [Severity: Medium]
> Does the panel require an explicit reset assertion pulse before de-asserting
> the reset line? The current code only de-asserts the reset line here. Without
> an explicit assertion pulse and delay prior to de-assertion, the hardware
> might not be guaranteed a valid minimum reset pulse width once power is stable.
>
> [ ... ]

Downstream reset sequence is just a deassertion of a reset line [1].

[1] 
https://github.com/xiaomi-sdm660/android_kernel_xiaomi_sdm660/blob/11-EAS/arch/arm/boot/dts/qcom/xiaomi/mi/clover/dsi-panel-nt51021-boe-10wu-video.dtsi#L331

>> +static int nt51021_boe_8_init(struct boe_nt51021_desc *ctx)
>> +{
>> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> [ ... ]
>> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> +	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
>> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0x00);
>> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
>> +
>> +	nt51021_cabc_on(&dsi_ctx);
>> +
>> +	return dsi_ctx.accum_err;
>> +}
> [Severity: Medium]
> Does this initialization sequence miss a DCS "Set Display On" command?
> The panel is awakened from sleep mode via mipi_dsi_dcs_exit_sleep_mode_multi(),
> but it is never explicitly instructed to turn on the display output here in
> nt51021_boe_8_init(). This could cause the panel to remain blank on some DSI
> hosts.
>
> [ ... ]
>> +static int nt51021_boe_10wu_init(struct boe_nt51021_desc *ctx)
>> +{
>> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
> [ ... ]
>> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>> +	mipi_dsi_usleep_range(&dsi_ctx, 5000, 6000);
>> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0x00);
>> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
>> +
>> +	nt51021_cabc_on(&dsi_ctx);
>> +	mipi_dsi_usleep_range(&dsi_ctx, 1000, 2000);
>> +
>> +	return dsi_ctx.accum_err;
>> +}
> [Severity: Medium]
> Similarly to nt51021_boe_8_init(), the 10-inch variant initialization path
> also appears to omit the mipi_dsi_dcs_set_display_on_multi() command.
>
>> +static int nt51021_boe_off(struct boe_nt51021_desc *ctx)
>> +{
>> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
>> +
>> +	nt51021_cabc_off(&dsi_ctx);
>> +
>> +	mipi_dsi_generic_write_seq_multi(&dsi_ctx, 0x8f, 0xa5);
>> +	mipi_dsi_msleep(&dsi_ctx, 20);
>> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> [Severity: Medium]
> The power-off sequence explicitly turns the display off using
> mipi_dsi_dcs_set_display_off_multi(). Should there be a matching turn-on
> command in the initialization sequences to ensure the display activates
> correctly across power cycles?
>
> [ ... ]
>> +static int nt51021_boe_prepare(struct drm_panel *panel)
>> +{
>> +	struct boe_nt51021_desc *ctx = to_boe_panel(panel);
>> +	struct device *dev = &ctx->dsi->dev;
>> +	int ret;
>> +
>> +	ret = regulator_bulk_enable(ARRAY_SIZE(nt51021_boe_supplies), ctx->supplies);
>> +	if (ret < 0) {
>> +		dev_err(dev, "Failed to enable regulators: %d\n", ret);
>> +		return ret;
>> +	}
>> +	nt51021_boe_reset(ctx);
> [Severity: Medium]
> Does the panel require a stabilization delay after enabling the regulators
> and before de-asserting the reset line? The current code immediately calls
> nt51021_boe_reset(ctx). Without a delay, the reset logic might execute
> before the regulators have fully ramped up, potentially leading to unstable
> hardware initialization.
>
> [ ... ]
>
-- 
Best regards,
Nickolay
