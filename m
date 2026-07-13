Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7620C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:23:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EFE10E960;
	Mon, 13 Jul 2026 12:23:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bYYb3iC2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4072610E960
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:23:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DEF443E6D;
 Mon, 13 Jul 2026 12:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AF61F000E9;
 Mon, 13 Jul 2026 12:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783945431;
 bh=mfkYvXchsq41aWkSrCkNKYoKA+D2jJR6+NT5QAp3nGA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bYYb3iC2JeTQ3Yv/rpmn2BOrLwMsGk26C+xDWIBkxo8xTZlZyg2iRWxVSpp+bLTb6
 p13byozgJaUcrmUQU7KulchWBAApLfv5f240N8j5tLHhLYyjV8Xpk1GLB2UWjNPcSZ
 Gr3GDrJob7H33wzVviHZfnwTGdBDHdKEtwPQNlIoHencG2la5iDz9csDwtBQeB0fJA
 3IbdD0Ur5zhR1nOeF4BVYTrCSKbQN/bWUgUHmuvPEvIJbEIyTpeh/NSj2pzh3Mnvxp
 QaNU3+LdXwwiD4zingrHZCb02zDAoVwJTcunNYCL0SYPEFSYsdpqVyrW4RrtWjXw46
 jAWgWqcd8D6+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/19] media: meson: vdec: Fix use-after-free race
 between teardown and ISR routines
To: "Anand Moon" <linux.amoon@gmail.com>
Cc: neil.armstrong@linaro.org, linux-amlogic@lists.infradead.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260713120840.17427-5-linux.amoon@gmail.com>
References: <20260713120840.17427-1-linux.amoon@gmail.com>
 <20260713120840.17427-5-linux.amoon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 12:23:51 +0000
Message-Id: <20260713122351.A4AF61F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Returning `IRQ_HANDLED` for a NULL session in the hardware interru=
pt handler causes an infinite interrupt storm.

Pre-existing issues:
- [High] Calling `synchronize_irq()` before stopping hardware interrupts fa=
ils to fix the use-after-free race condition.
- [High] Unbind operations destroy devm-managed structures and the m2m devi=
ce while open file descriptors remain, causing UAF on closure.
--

--- Patch [4]: [PATCH v7 04/19] media: meson: vdec: Fix use-after-free race=
 between teardown and ISR routines ---
commit 7f1533ed7c182234db28cc4195417115cb635bb9
Author: Anand Moon <linux.amoon@gmail.com>

media: meson: vdec: Fix use-after-free race between teardown and ISR routin=
es

This patch attempts to prevent race conditions and null pointer dereferences
by synchronizing interrupt service routines during session teardown and file
descriptor release phases. It adds synchronize_irq() calls and uses
smp_load_acquire() to safely capture the current session in the ISR handler=
s.

Link: https://lore.kernel.org/all/20260521090944.F35401F00A3D@smtp.kernel.o=
rg/

> diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/me=
dia/meson/vdec/vdec.c
> index 7fc73d5cdebbf..7ae3d5a9dd6ab 100644
> --- a/drivers/staging/media/meson/vdec/vdec.c
> +++ b/drivers/staging/media/meson/vdec/vdec.c
> @@ -484,6 +484,9 @@ static void vdec_stop_streaming(struct vb2_queue *q)
>  			}
>  		}
> =20
> +		/* Synchronize and flush pending hardware interrupt service routines */
> +		synchronize_irq(core->vdec_irq);
> +

[Severity: High]
This isn't a bug introduced by this patch, but does calling synchronize_irq=
()
before vdec_poweroff() actually prevent the race condition?

Since synchronize_irq() only waits for currently executing handlers to fini=
sh
and does not disable the IRQ line or prevent new hardware interrupts, it se=
ems
new interrupts can still fire immediately after it returns.

Because the hardware isn't stopped until vdec_poweroff() runs, could a newly
triggered ISR observe a valid session pointer and execute concurrently with=
 the
rest of the teardown sequence?

Should the hardware be stopped via vdec_poweroff() before synchronizing IRQ=
s?

>  		vdec_poweroff(sess);
>  		vdec_free_canvas(sess);
> =20

[ ... ]

> @@ -989,6 +992,9 @@ static int vdec_close(struct file *file)
>  	struct amvdec_session *sess =3D file_to_amvdec_session(file);
>  	struct amvdec_core *core =3D sess->core;
> =20
> +	/* Synchronize and flush pending hardware interrupt service routines */
> +	synchronize_irq(core->vdec_irq);
> +

[Severity: High]
This is a pre-existing issue, but does the driver handle unbind safely if
user-space keeps the video device file open?

If the driver is unbound, vdec_remove() executes:

vdec_remove()
    video_unregister_device(core->vdev_dec);
    v4l2_m2m_release(core->m2m_dev);
    v4l2_device_unregister(&core->v4l2_dev);

Since devres automatically frees the amvdec_core structure upon unbind
completion, and video_unregister_device() does not forcefully close open fi=
le
descriptors, could a later call to vdec_close() dereference the freed core
structure?

For instance, this newly added synchronize_irq(core->vdec_irq) call would
use the freed core pointer. Similarly, v4l2_m2m_ctx_release(sess->m2m_ctx)
later in vdec_close() would use the freed core->m2m_dev.

>  	if (!IS_ERR_OR_NULL(sess->recycle_thread)) {
>  		kthread_stop(sess->recycle_thread);
>  		sess->recycle_thread =3D NULL;

[ ... ]

> @@ -1038,7 +1044,12 @@ static const struct v4l2_file_operations vdec_fops=
 =3D {
>  static irqreturn_t vdec_isr(int irq, void *data)
>  {
>  	struct amvdec_core *core =3D data;
> -	struct amvdec_session *sess =3D core->cur_sess;
> +	struct amvdec_session *sess;
> +
> +	/* Secure an atomic acquire snapshot to protect against concurrent tear=
down */
> +	sess =3D smp_load_acquire(&core->cur_sess);
> +	if (!sess)
> +		return IRQ_HANDLED;

[Severity: High]
Can returning IRQ_HANDLED here cause an infinite interrupt storm?

If the handler evaluates the session to NULL and returns IRQ_HANDLED without
acknowledging or clearing the interrupt at the hardware level, the generic =
IRQ
framework will unmask the interrupt line.

Since the hardware interrupt source hasn't been cleared, won't the interrupt
controller immediately re-trigger the interrupt, resulting in a soft lockup=
 or
CPU stall?

Should this return IRQ_NONE so the IRQ subsystem can detect it as spurious =
and
eventually disable the IRQ line?

> =20
>  	sess->last_irq_jiffies =3D get_jiffies_64();
> =20
> @@ -1048,7 +1059,12 @@ static irqreturn_t vdec_isr(int irq, void *data)
>  static irqreturn_t vdec_threaded_isr(int irq, void *data)
>  {
>  	struct amvdec_core *core =3D data;
> -	struct amvdec_session *sess =3D core->cur_sess;
> +	struct amvdec_session *sess;
> +
> +	/* Prevent late-stage threaded interrupts from dereferencing a NULL ses=
sion */
> +	sess =3D smp_load_acquire(&core->cur_sess);
> +	if (!sess)
> +		return IRQ_HANDLED;

[Severity: High]
Does returning IRQ_HANDLED here also incorrectly propagate the same interru=
pt
storm behavior?

> =20
>  	return sess->fmt_out->codec_ops->threaded_isr(sess);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713120840.1742=
7-1-linux.amoon@gmail.com?part=3D4
