Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2FFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DD4710E5D4;
	Mon, 13 Jul 2026 12:28:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c57OCsU5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 969BD10E5D4
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:28:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4B932402BF;
 Mon, 13 Jul 2026 12:28:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E21031F000E9;
 Mon, 13 Jul 2026 12:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783945731;
 bh=6Uc3VVn8Aq1XfnvrCkubgMWGnVvS2e+ZwNlccy7alJk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c57OCsU53v9OHqwVSxShevXigL8VD5yLQBODqmpacHUhMeRXdVn7c8E8kRLc0/Q44
 uub4rYoAahxEuKfJ48itSmOZhne0Aw2lAwms3JSlJ2/2hAwQ7hSR4DyhONv2FUeCg0
 sbDygiuHzupQjBOEGlBnG+2YpfQlpDrQrjzYVPLjtq9o6jtht3Bt/z1o3wvSi12pY8
 Z8ECWOuNgs6CEz87ndCNr9Vx5wt0ORVzDX1qTKypdqWdvzZilQ+A8V5nXyrRVM/90a
 /Nokrx6SojZYaeWPK6tLSX/Esxt/PgxNBFxwqIQqpQWpFsknwsK1uv7P+z0hf828Sq
 jh1D2/AWEhgTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/19] media: meson: vdec: Fix race condition and
 synchronize esparser IRQ
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
 neil.armstrong@linaro.org
In-Reply-To: <20260713120840.17427-6-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-6-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:28:50 +0000
Message-Id: <20260713122850.E21031F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The newly added early return path in `esparser_isr()` incorrectly =
returns `IRQ_HANDLED` without clearing the hardware interrupt status, leadi=
ng to an interrupt storm and violating shared IRQ semantics.
- [Medium] The commit message falsely claims to fix a race condition where =
the ISR 'attempts to handle stream data and allocate internal tracking stat=
e structures', which does not exist in the code.

Pre-existing issues:
- [High] The synchronization and early-exit logic introduced by the patch i=
s ineffective and leaves the system vulnerable to synchronous bus faults du=
ring teardown.
- [High] Unconditional execution of `vdec_poweroff()` in `vdec_close()` cau=
ses clock underflows.
--

--- Patch [5]: [PATCH v7 05/19] media: meson: vdec: Fix race condition and =
synchronize esparser IRQ ---
commit 2f7e559e32b43d068f1e5390f023fbf7f75f1262
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Fix race condition and synchronize esparser IRQ

This commit attempts to fix a race condition during session teardown sequen=
ces
by synchronizing the esparser IRQ and adding a NULL check for the session
pointer in the ISR. It aims to prevent the interrupt handler from running
while context structures are dismantled.

Closes: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel=
.org/

> During session teardown sequences in vdec_stop_streaming() and
> vdec_close(), the 'esparser' hardware interrupt handler can still be
> actively triggered or executing on another CPU core. This creates a
> transient race condition where the ISR attempts to handle stream data and
> allocate internal tracking state structures after session contexts have
> been modified or freed.

[Severity: Medium]
Does the ISR actually allocate tracking state or handle stream data?

Looking at esparser_isr(), the sess pointer is retrieved and checked for NU=
LL,
but the rest of the ISR does not appear to dereference this pointer or
allocate any internal tracking structures.

> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/stagin=
g/media/meson/vdec/esparser.c
> index 4632346f04a9e..37749ede308c6 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -60,6 +60,12 @@ static irqreturn_t esparser_isr(int irq, void *dev)
>  {
>  	int int_status;
>  	struct amvdec_core *core =3D dev;
> +	struct amvdec_session *sess;
> +
> +	/* Secure an atomic snapshot to protect against concurrent teardown */
> +	sess =3D smp_load_acquire(&core->cur_sess);
> +	if (!sess)
> +		return IRQ_HANDLED;

[Severity: High]
Is it safe to return IRQ_HANDLED here without interacting with the hardware
to clear the interrupt?

Because esparser_irq is registered with IRQF_SHARED, returning IRQ_HANDLED
when cur_sess is NULL falsely tells the IRQ subsystem that this driver
handled the interrupt.

Will this cause an interrupt storm for level-triggered interrupts, or break
spurious interrupt detection for other devices sharing this IRQ line?

> =20
>  	int_status =3D amvdec_read_parser(core, PARSER_INT_STATUS);
>  	amvdec_write_parser(core, PARSER_INT_STATUS, int_status);

[ ... ]

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> index 7ae3d5a9dd6ab..7689ffdb2e500 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -486,6 +486,8 @@ static void vdec_stop_streaming(struct vb2_queue *q)
> =20
>  		/* Synchronize and flush pending hardware interrupt service routines */
>  		synchronize_irq(core->vdec_irq);
> +		/* Ensure esparser ISR finishes executing */
> +		synchronize_irq(core->esparser_irq);
> =20
>  		vdec_poweroff(sess);
>  		vdec_free_canvas(sess);

[Severity: High]
This is a pre-existing issue, but does this synchronization logic fully
close the race condition?

The synchronize_irq() call waits for in-flight ISRs, but the interrupt line
remains enabled. Later in this teardown path:

vdec_stop_streaming()
    vdec_poweroff(sess);
    ...
    smp_store_release(&core->cur_sess, NULL);

If the interrupt fires after vdec_poweroff() completes, but before cur_sess
is set to NULL, the ISR will pass the !sess check and attempt to read
PARSER_INT_STATUS from unclocked hardware.

Could this lead to a synchronous bus fault and kernel panic?

[ ... ]

> @@ -994,6 +996,8 @@ static int vdec_close(struct file *file)
> =20
>  	/* Synchronize and flush pending hardware interrupt service routines */
>  	synchronize_irq(core->vdec_irq);
> +	/* Ensure esparser ISR finishes executing */
> +	synchronize_irq(core->esparser_irq);
> =20
>  	if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
>  		kthread_stop(sess->recycle_thread);

[Severity: High]
This is a pre-existing issue, but does vdec_close() unconditionally call
vdec_poweroff() even if the device was just opened without starting streami=
ng?

If vdec_open() is called and immediately followed by vdec_close(), calling
vdec_poweroff() unconditionally would execute clk_disable_unprepare() on
dos_clk and dos_parser_clk which were never enabled.

Can this cause clock framework underflow warnings and potentially disable
clocks for other hardware sharing the same clock tree?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D5
