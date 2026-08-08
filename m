Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3724EC5B560
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:37:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F06F610E644;
	Mon, 10 Aug 2026 06:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="XwQx54XP";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D3C410E4B8
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 10:37:07 +0000 (UTC)
Received: from localhost (37-74-132-17.biz.kpn.net [37.74.132.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id EBD802405F;
 Sat,  8 Aug 2026 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786185425;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSaDElFw+MnqgzYhA8gil00pUiBrcKmpVElDCxEHTOg=;
 b=XwQx54XPslzIhyxXiB6aSPF1Adj1QirMNYk6mQVdMqt4fC9iujdypzx1yq5owwh4w0h2pw
 ONb9k8aNGtNxwU8SNvMR7HuAxVESJ4sqaVm6lMg9NTuHNPPcwu0zDOpfplG/mfA6Kl7FOi
 ++w+Dlf6XsZgQLd0E7jBfsnoAafLRiU=
Date: Sat, 8 Aug 2026 12:36:49 +0200
From: Wim de With <wf@dewith.io>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <ancGwXAICfur322a@dewith.io>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-3-wf@dewith.io> <anV9EBIaZvoTz-lp@monoceros>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anV9EBIaZvoTz-lp@monoceros>
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:37:47 +0000
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

On Fri, Aug 07, 2026 at 08:46:07AM +0200, Uwe Kleine-König wrote:
> On Thu, Aug 06, 2026 at 10:15:41PM +0200, Wim de With wrote:
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/platform_device.h>
> 
> Please don't use <linux/mod_devicetable.h> in new code.
> <linux/platform_device.h> already provides struct of_device_id, so you
> should be able to just drop the include for <linux/mod_devicetable.h>.

Sure, will do.

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
> > +	gpiod_set_value(ocp8178->gpiod, 1);
> > +}
> 
> Is this function open-coding stuff that already exists in drivers/w1?
> (Just asking because you call that onewire).

The datasheet calls this 1-Wire, but it is a proprietary protocol, not
the 1-Wire protocol from Dallas Semiconductor that is implemented in
drivers/w1.

> > [...]
> > +static int ocp8178_bl_probe(struct platform_device *pdev)
> > +{
> > +	[...]
> > +
> > +	dev_info(dev, "probed, brightness=%u/%u\n", brightness, max_brightness);
> 
> IMHO this is just noise once the code hits mainline. The amount of log
> lines like these during boot is just annoying and makes it hard to
> identify the relevant lines. So if you're confident that your driver
> works, users are probably not interested in that line and you can drop
> it (or degrade to dev_dbg).

I'm confident that when the driver fails to load, a message is logged,
so I'll downgrade it to dev_dbg.

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
> 
> I'm not a fan of aligning the = chars. But opinions differ.

I have no strong opinions on this, so I'll go along with what the
maintainer wants.

Regards,
Wim
