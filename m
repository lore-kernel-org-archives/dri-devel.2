Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8010C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 07:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7845310EAAB;
	Tue, 11 Aug 2026 07:26:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="pb3nrYYW";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EEF10E209
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 17:10:30 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id 4A7F31FC16;
 Mon, 10 Aug 2026 17:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786381828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zRlDAn2w48ZOZSZja/33WF3x7tTj9Ajju1bg/9k60To=;
 b=pb3nrYYWp3nNM+k9njiYwFJaTuEL9Ade7KEZPKnuZ+jtdjeD8fwDTt0KqqaeJxucPeNAHL
 ehglFj142Zbwq0lELcvxmtSBzHjLCNHBhsIVOlbqE4UfKx9lfRN8q1GDMmKduoBYg1Anfr
 j812+YNlLlQi/oYgc4zNqXYxZTf6Zss=
Date: Mon, 10 Aug 2026 19:10:22 +0200
From: Wim de With <wf@dewith.io>
To: Daniel Thompson <danielt@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <anoF_hOjV-BRvYBI@dewith.io>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-3-wf@dewith.io> <anm3DY86P_TGxj3a@aspen.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anm3DY86P_TGxj3a@aspen.lan>
X-Mailman-Approved-At: Tue, 11 Aug 2026 07:26:09 +0000
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

Thanks for the review.

On Mon, Aug 10, 2026 at 12:33:33PM +0100, Daniel Thompson wrote:
> On Thu, Aug 06, 2026 at 10:15:41PM +0200, Wim de With wrote:
> > +static void ocp8178_bl_write_u8(struct ocp8178_bl *ocp8178, u8 value)
> > +{
> > +	unsigned long flags;
> > +
> > +	gpiod_set_value(ocp8178->gpiod, 1);
> > +	udelay(OCP8178_1W_T_START_US);
> > +
> > +	local_irq_save(flags);
> > +
> > +	for (int i = 7; i >= 0; i--) {
> > +		if ((value >> i) & 1) {
> > +			gpiod_set_value(ocp8178->gpiod, 0);
> > +			udelay(OCP8178_1W_HIGH_BIT_T_LOW_US);
> > +			gpiod_set_value(ocp8178->gpiod, 1);
> > +			udelay(OCP8178_1W_HIGH_BIT_T_HIGH_US);
> > +		} else {
> > +			gpiod_set_value(ocp8178->gpiod, 0);
> > +			udelay(OCP8178_1W_LOW_BIT_T_LOW_US);
> > +			gpiod_set_value(ocp8178->gpiod, 1);
> > +			udelay(OCP8178_1W_LOW_BIT_T_HIGH_US);
> > +		}
> > +	}
> > +
> > +	gpiod_set_value(ocp8178->gpiod, 0);
> > +
> > +	local_irq_restore(flags);
> > +
> > +	udelay(OCP8178_1W_T_EOS_US);
> 
> Given this happens after we restore local irqs this should probably be
> fsleep().
 
This one is wrong, the IRQs should be restored after this delay and
following GPIO set, as noted by Sashiko.

> > +	gpiod_set_value(ocp8178->gpiod, 1);
> > +}
> > +
> > +static void ocp8178_bl_set_brightness(struct ocp8178_bl *ocp8178, u8 brightness)
> > +{
> > +	u8 data = 0;
> > +
> > +	dev_dbg(ocp8178->dev, "setting brightness to %u\n", brightness);
> 
> Do we really need the dev_dbg() here?

We don't, it adds no value. I'll remove it in v2.

> > +
> > +	data |= FIELD_PREP(OCP8178_DATA_ADDR, 0);
> > +	data |= FIELD_PREP(OCP8178_DATA_VALUE, brightness);
> > +
> > +	ocp8178_bl_write_u8(ocp8178, OCP8178_DEVICE_ADDRESS);
> > +	ocp8178_bl_write_u8(ocp8178, data);
> > +}
> > +
> > +static int ocp8178_bl_update_status(struct backlight_device *bl)
> > +{
> > +	struct ocp8178_bl *ocp8178 = bl_get_data(bl);
> > +	u8 brightness = backlight_get_brightness(bl);
> > +
> > +	/*
> > +	 * Setting brightness to 0 turns the backlight off but retains the
> > +	 * onewire mode. If we disable the controller, we would need to enable
> > +	 * the onewire mode again.
> > +	 */
> > +	if (backlight_is_blank(bl))
> > +		brightness = 0;
> 
> This is not needed. It will happen inside backlight_get_brightness().

Will remove in v2.

> > +
> > +	ocp8178_bl_set_brightness(ocp8178, brightness);
> > +	return 0;
> > +}
> > +
> > +static const struct backlight_ops ocp8178_bl_ops = {
> > +	.options	= BL_CORE_SUSPENDRESUME,
> > +	.update_status	= ocp8178_bl_update_status,
> > +};
> > +
> > +static int ocp8178_bl_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct backlight_device *bl;
> > +	struct backlight_properties props;
> > +	struct ocp8178_bl *ocp8178;
> > +	u32 max_brightness, brightness;
> > +	int ret, retries;
> > +
> > +	ocp8178 = devm_kzalloc(dev, sizeof(*ocp8178), GFP_KERNEL);
> > +	if (!ocp8178)
> > +		return -ENOMEM;
> > +
> > +	ocp8178->dev = dev;
> > +
> > +	ret = device_property_read_u32(dev, "max-brightness", &max_brightness);
> > +	if (ret)
> > +		max_brightness = OCP8178_MAX_BRIGHTNESS;
> > +	if (max_brightness > OCP8178_MAX_BRIGHTNESS) {
> > +		dev_warn(dev, "max brightness exceeds hardware limit\n");
> > +		max_brightness = OCP8178_MAX_BRIGHTNESS;
> > +	}
> > +
> > +	ret = device_property_read_u32(dev, "default-brightness", &brightness);
> > +	if (ret)
> > +		brightness = max_brightness;
> > +	if (brightness > max_brightness) {
> > +		dev_warn(dev, "default brightness exceeds max brightness\n");
> > +		brightness = max_brightness;
> > +	}
> > +
> > +	ocp8178->gpiod = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> > +	if (IS_ERR(ocp8178->gpiod))
> > +		return dev_err_probe(dev, PTR_ERR(ocp8178->gpiod),
> > +				     "gpio missing or invalid\n");
> > +	gpiod_set_consumer_name(ocp8178->gpiod, dev_name(dev));
> > +
> > +	for (retries = 0; retries < OCP8178_1W_INIT_MAX_RETRIES; retries++) {
> > +		ret = ocp8178_bl_enable_onewire(ocp8178);
> > +		if (!ret)
> > +			break;
> > +		if (ret != -EAGAIN)
> > +			return ret;
> > +		msleep(OCP8178_1W_INIT_SLEEP_MS);
> 
> fsleep()?

Sure, and I'll make the udelay() for the ~100 us in the initialization
use usleep_range because those timings aren't that precise.

> 
> > +	}
> > +	if (retries >= OCP8178_1W_INIT_MAX_RETRIES)
> > +		return dev_err_probe(dev, -ETIMEDOUT,
> > +				     "failed to initialize onewire protocol");
> > +
> > +	props = (typeof(props)){
> > +		.type		= BACKLIGHT_RAW,
> > +		.brightness	= brightness,
> > +		.max_brightness = max_brightness,
> > +		.power		= BACKLIGHT_POWER_ON,
> > +		.scale		= BACKLIGHT_SCALE_NON_LINEAR,
> > +	};
> > +
> > +	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ocp8178,
> > +					    &ocp8178_bl_ops, &props);
> > +	if (IS_ERR(bl))
> > +		return dev_err_probe(dev, PTR_ERR(bl),
> > +				     "failed to register backlight\n");
> > +
> > +	platform_set_drvdata(pdev, bl);
> > +	backlight_update_status(bl);
> > +
> > +	dev_info(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id ocp8178_bl_of_match[] = {
> > +	{ .compatible = "ocs,ocp8178" },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ocp8178_bl_of_match);
> > +
> > +static struct platform_driver ocp8178_bl_driver = {
> > +	.driver		= {
> > +		.name		= "ocp8178-bl",
> > +		.of_match_table	= ocp8178_bl_of_match,
> > +	},
> > +	.probe		= ocp8178_bl_probe,
> > +};
> 
> I'm with Uwe on the indentation here. No padding needed after the
> = IMHO.

Will fix in v2.

> 
> Daniel.

Regards,
Wim
