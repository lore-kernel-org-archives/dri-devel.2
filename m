Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C42C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 06:38:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8E710E65E;
	Mon, 10 Aug 2026 06:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; secure) header.d=dewith.io header.i=@dewith.io header.b="gnSL7tzt";
	dkim-atps=neutral
Received: from meve.dewith.io (meve.dewith.io [157.90.20.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D95AA10E4B8
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 10:37:05 +0000 (UTC)
Received: from localhost (37-74-132-17.biz.kpn.net [37.74.132.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1)
 server-digest SHA256) (No client certificate requested)
 by meve.dewith.io (Postfix) with ESMTPSA id DBE5A20157;
 Sat,  8 Aug 2026 10:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dewith.io; s=default; 
 t=1786185424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YMBaPAYHToijBVahmID/bRSHm7hl1KFROWZe+Ee2lu8=;
 b=gnSL7tztfhUSFv4oQ1kEHZvH5rbDhNeMvYW6eGeittWdRtE7jhARpF/TBJixsqlWe/aZdx
 C5bUlSlk7nhWLGw3DwhFiJMczvTsHO+dk6+w3OkRAgby6vD3YkIlPf1TJY0zdtYBJr6FKq
 hbZ0UrsItw7iW/+e8yIu1agKYQSu92U=
Date: Sat, 8 Aug 2026 12:28:16 +0200
From: Wim de With <wf@dewith.io>
To: sashiko-reviews@lists.linux.dev
Cc: lee@kernel.org, robh@kernel.org, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 2/2] backlight: Add support for Orient Chip OCP8178
Message-ID: <A02AA15C-FF70-41E1-B2F7-1DC157CCB544@dewith.io>
References: <20260806201541.101304-1-wf@dewith.io>
 <20260806201541.101304-3-wf@dewith.io>
 <20260806203654.542301F000E9@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806203654.542301F000E9@smtp.kernel.org>
User-Agent: K-9 Mail for Android
X-K9mail-Identity: !l=5700&o=27&fo=27&pl=4796&po=0&qs=PREFIX&f=HTML&m=%2
 3%3AMTRjYmVhM2ItMTllMS00ZTVmLTlkNGUtYTgwNWZmMmI3MTBj%3AMTk%3D%3AMjI%3D&
 p=4124&q=NONE
X-TUID: LDDKbQpo27r7
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

On Thu, Aug 06, 2026 at 08:36:53PM +0000, sashiko-bot@kernel.org wrote:
> > +static void ocp8178_bl_write_u8(struct ocp8178_bl *ocp8178, u8 value)
> > +{
> > + unsigned long flags;
> > +
> > + gpiod_set_value(ocp8178->gpiod, 1);
> > + udelay(OCP8178_1W_T_START_US);
> > +
> > + local_irq_save(flags);
> > +
> > + for (int i = 7; i >= 0; i--) {
> > + if ((value >> i) & 1) {
> > + gpiod_set_value(ocp8178->gpiod, 0);
> 
> [Severity: High]
> Could this trigger a scheduling while atomic bug if the GPIO controller is
> behind an I2C or SPI expander?
> 
> Since this bit-banging occurs inside a local_irq_save() block where hardware
> interrupts are disabled, any GPIO accesses must not sleep. If the driver
> is instantiated via Device Tree with a sleepable GPIO, gpiod_set_value()
> will attempt to sleep in an atomic context.

> Should probe() explicitly reject sleepable GPIOs by checking
> gpiod_cansleep()?

I didn't realize that the spinlock safety is a property of the GPIO
itself. Applying this suggestion means that we don't need to use
gpiod_set_value_cansleep() at all in this driver.

I took inspiration from the ktd253 driver, which also has tight timing
requirements on GPIO bit-banging. This driver does not check
gpiod_cansleep() either and mixes gpiod_set_value() and
gpiod_set_value_cansleep(), which is incorrect.

> > + udelay(OCP8178_1W_HIGH_BIT_T_LOW_US);
> > + gpiod_set_value(ocp8178->gpiod, 1);
> > + udelay(OCP8178_1W_HIGH_BIT_T_HIGH_US);
> > + } else {
> > + gpiod_set_value(ocp8178->gpiod, 0);
> > + udelay(OCP8178_1W_LOW_BIT_T_LOW_US);
> > + gpiod_set_value(ocp8178->gpiod, 1);
> > + udelay(OCP8178_1W_LOW_BIT_T_HIGH_US);
> > + }
> > + }
> > +
> > + gpiod_set_value(ocp8178->gpiod, 0);
> > +
> > + local_irq_restore(flags);
> > +
> > + udelay(OCP8178_1W_T_EOS_US);
> > + gpiod_set_value(ocp8178->gpiod, 1);
> 
> [Severity: High]
> Is there a risk that the end-of-sequence pulse gets extended arbitrarily here?
> 
> By calling local_irq_restore() while the GPIO is driven low, any pending
> interrupts will run immediately. If system interrupt processing or softirqs
> delay execution by more than 2.5ms (OCP8178_T_OFF_MS), the hardware will
> interpret this extended low pulse as a command to disable the onewire mode.
> 
> This could cause the controller to unexpectedly power off and revert to PWM
> mode, breaking backlight control.
> 
> Would it be safer to restore interrupts after the final gpiod_set_value()
> call?

This is indeed a problem and I'll fix it in v2. The datasheet states
that T_EOS must be between 2 and 360 us. Interrupt handling may
exceed this value.

> > +static void ocp8178_bl_set_brightness(struct ocp8178_bl *ocp8178, u8 brightness)
> > +{
> > + u8 data = 0;
> > +
> > + dev_dbg(ocp8178->dev, "setting brightness to %u\n", brightness);
> > +
> > + data |= FIELD_PREP(OCP8178_DATA_ADDR, 0);
> > + data |= FIELD_PREP(OCP8178_DATA_VALUE, brightness);
> > +
> > + ocp8178_bl_write_u8(ocp8178, OCP8178_DEVICE_ADDRESS);
> > + ocp8178_bl_write_u8(ocp8178, data);
> 
> [Severity: Medium]
> Does the controller require strict timing between the address and data bytes?
> 
> Since ocp8178_bl_write_u8() only disables interrupts for the duration of a
> single byte, an interrupt could fire between these two calls. If the 1-wire
> hardware state machine has a maximum idle time, arbitrary interrupt latency
> in the inter-byte gap might cause the controller to reset and drop the
> brightness update.

For sending a single byte, we need to disable interrupts for about 58
us. The datasheet doesn't put a maximum on T_START (which is the start
of sequence period) so I would need to test the practical limitation.
Regardless though, disabling interrupts for both writes would take 118
us and I'm not sure if that is preferable over failing a brightness
update in rare situations.

> > +static const struct backlight_ops ocp8178_bl_ops = {
> > + .options = BL_CORE_SUSPENDRESUME,
> > + .update_status = ocp8178_bl_update_status,
> > +};
> 
> [Severity: Medium]
> Is BL_CORE_SUSPENDRESUME sufficient for restoring this hardware after suspend?
> 
> If the platform cuts power to the backlight controller during system suspend,
> the hardware will wake up in its default PWM mode. The backlight core will
> simply call update_status() on resume to restore brightness, but the onewire
> brightness commands will be ignored because the onewire mode hasn't been
> re-enabled.
> 
> Should the platform driver provide pm operations to re-execute
> ocp8178_bl_enable_onewire() on system resume?

I'm not sure if this is just LLM-hallucination or actually relevant.
Should I account for the power cutting to the controller if the driver
itself doesn't implement the power cutting?
