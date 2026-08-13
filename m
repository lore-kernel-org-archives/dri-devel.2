Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F393FC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A92D10EB10;
	Fri, 14 Aug 2026 07:04:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="Izimf/4J";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9E4010F2A1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:45:05 +0000 (UTC)
Received: from localhost (70-26-208-87.ftth.glasoperator.nl [87.208.26.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id 105FA209BA;
 Thu, 13 Aug 2026 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786617904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ENLaVUVqC0mYQp9TN/bCjqw09D0fL6xGKRTiCroOuDg=;
 b=Izimf/4Jm6XrDG3fECjrkdKVcx5dfFp3aaG27c9skXn3LOJo16zvmxMoUZHbqlU+ccMyYS
 MZYJQcZt/O/zoI2Tx9jluhf+zW+m6LhfrdXSqJFudIkd2BhJXpfOIRXSWTerbekACx7gsX
 Ef5XdRqerHU+upFpTyJDp+u6xtuD/+U=
Date: Thu, 13 Aug 2026 12:45:00 +0200
From: Wim de With <wf@dewith.io>
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 lee@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 robh@kernel.org
Subject: Re: [PATCH v2 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <an2gLPdQZDaubtRC@dewith.io>
References: <20260812-ocp8178-backlight-v2-0-4ad18b48bef8@dewith.io>
 <20260812-ocp8178-backlight-v2-2-4ad18b48bef8@dewith.io>
 <20260812193457.002A61F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812193457.002A61F000E9@smtp.kernel.org>
X-Mailman-Approved-At: Fri, 14 Aug 2026 07:04:05 +0000
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

On Wed, Aug 12, 2026 at 07:34:56PM +0000, sashiko-bot@kernel.org wrote:
> > +static void ocp8178_bl_set_brightness(struct ocp8178_bl *ocp8178, u8 brightness)
> > +{
> > +	u8 data = 0;
> > +
> > +	/*
> > +	 * We cannot set RFA (request for acknowledge) unless the GPIO pin is
> > +	 * configured as open drain.
> > +	 */
> > +	data |= FIELD_PREP(OCP8178_DATA_RFA, 0);
> > +	data |= FIELD_PREP(OCP8178_DATA_ADDR, 0);
> > +	data |= FIELD_PREP(OCP8178_DATA_VALUE, brightness);
> > +
> > +	ocp8178_bl_write_u8(ocp8178, OCP8178_DEVICE_ADDRESS);
> > +	ocp8178_bl_write_u8(ocp8178, data);
> 
> [Severity: Medium]
> Can a preemption or interrupt between these two byte writes delay the second
> byte and violate the 1-Wire protocol timing?
> 
> The initialization sequence ocp8178_bl_enable_onewire() explicitly checks
> duration >= OCP8178_1W_T_WIN_NS to verify that timing wasn't ruined by
> preemption. However, in ocp8178_bl_set_brightness(), if the thread is preempted
> between the two ocp8178_bl_write_u8() calls, the GPIO line is left idle HIGH.
> 
> Would this cause the hardware's 1-Wire state machine to time out and treat the
> subsequent data byte as a new command, resulting in a silently lost brightness
> update since the driver doesn't read an ACK?
> 

This is the same point that Sashiko raised for v1, but now I tested it
like so:

ocp8178_bl_write_u8(ocp8178, OCP8178_DEVICE_ADDRESS);
msleep(1000);
ocp8178_bl_write_u8(ocp8178, data);

It still works for 90% of the brightness updates, and only misses some
if you spam the updates during the sleep, so I'm inclined to say it is
robust enough.

> > +}
> [ ... ]
> > +static const struct backlight_ops ocp8178_bl_ops = {
> > +	.options = BL_CORE_SUSPENDRESUME,
> > +	.update_status = ocp8178_bl_update_status,
> > +};
> [ ... ]
> > +static struct platform_driver ocp8178_bl_driver = {
> > +	.driver = {
> > +		.name = "ocp8178-bl",
> > +		.of_match_table = ocp8178_bl_of_match,
> > +	},
> > +	.probe = ocp8178_bl_probe,
> > +};
> 
> [Severity: High]
> Does this driver need a resume PM hook to re-initialize the 1-Wire mode?
> 
> The BL_CORE_SUSPENDRESUME option causes the backlight core to call
> update_status() on resume. Since power to the chip may be cut during suspend,
> the device defaults to PWM mode upon power-on.
> 
> Without a resume hook in the platform driver to call
> ocp8178_bl_enable_onewire(), the chip will misinterpret the 1-Wire brightness
> data as a PWM signal. This leaves the GPIO HIGH at the end of the transaction,
> which translates to 100% brightness in PWM mode.

This is still an open question for me. I know the ClockworkPi platform
doesn't cut power to the chip during suspend, because the cores it uses
don't really support suspend power states.

However, for mainline inclusion, should I assume that the chip might be
used in situations where suspend does cut power to the chip and plan for
it accordingly?

Regards,
Wim
