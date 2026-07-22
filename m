Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1C6C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 08:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CF1B89D7F;
	Wed, 22 Jul 2026 08:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bo0GzIx4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A62F89D7F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 08:14:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEDB060A64;
 Wed, 22 Jul 2026 08:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413EF1F000E9;
 Wed, 22 Jul 2026 08:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784708067;
 bh=gP4WQrfVvg/UA5wwFjKkRbgwWlwt5KYKIQnMPuTyr4o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Bo0GzIx4tvRPisfFKi+VlilEJfIGwtSbOVCV7cQNtF6jYLL35KEiZtV7qtGAai6yU
 LPUP85PQz+DojgRJhnRtmAn6V6ETQhVVFGVUMSmrNLkpmTG2HRZ/3dvJKukAQ8Oj1H
 t2+wlW4ooFoMEdffQZqnxYGoQA+3Z6EwQgh8xkhNjPlpk9s7wFTxGRKGspbaBLXbhz
 EcI+XmRBzqSwiGPC1YNDDfcqFUTbfvUEsSsq7NzdGRbrikNXfyH6RVBsNaLOKQM1Tt
 zWkgKA6tDVUcAM5HmqIPys+Tpchj7nn2WPPf03v5CIrMrPWUtvNKePUXE9qfHde0lV
 R6TIURmBuClzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] fbdev: pxafb: Remove redundant dev_err()
To: "Pan Chuang" <panchuang@vivo.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722075803.570532-6-panchuang@vivo.com>
References: <20260722075803.570532-1-panchuang@vivo.com>
 <20260722075803.570532-6-panchuang@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 08:14:26 +0000
Message-Id: <20260722081427.413EF1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The background thread `fbi->smart_thread` is never stopped, le=
ading to a leaked thread that causes Use-After-Free (UAF) upon device remov=
al or probe failure.
- [Critical] The CPU frequency notifier is never unregistered, leading to a=
 UAF upon device unbind.
- [High] The driver masks the original error codes returned by `platform_ge=
t_irq()` and `devm_request_irq()`, overriding them with hardcoded values (`=
-ENODEV` and `-EBUSY`).
- [High] The asynchronous work `fbi->task` may be scheduled during probe bu=
t is not canceled in the probe error paths.
- [High] The device IRQ is requested before the completion objects used by =
the IRQ handler are initialized, risking a crash if an interrupt fires earl=
y.
--

--- Patch [5]: [PATCH 5/7] fbdev: pxafb: Remove redundant dev_err() ---
commit 689be132f4af510aaf94189aee84d65e9d9a1907
Author: Pan Chuang <panchuang@vivo.com>

fbdev: pxafb: Remove redundant dev_err()

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() automatically logs
detailed error messages on failure. Remove the now-redundant
driver-specific dev_err() call.

> diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
> index e418eee825fb2..1682345fb9b0a 100644
> --- a/drivers/video/fbdev/pxafb.c
> +++ b/drivers/video/fbdev/pxafb.c
> @@ -2312,7 +2312,6 @@ static int pxafb_probe(struct platform_device *dev)
> =20
>  	ret =3D devm_request_irq(&dev->dev, irq, pxafb_handle_irq, 0, "LCD", fb=
i);

[Severity: High]
This is a pre-existing issue, but is it safe to request the IRQ here before
the completion objects are initialized?

If the bootloader leaves the hardware active, an early interrupt could cause
complete() to operate on a zero-initialized wait queue in pxafb_handle_irq(=
),
leading to a NULL pointer dereference. The IRQ is requested before
pxafb_smart_init() and pxafb_overlay_init() have had a chance to run.

>  	if (ret) {
> -		dev_err(&dev->dev, "request_irq failed: %d\n", ret);
>  		ret =3D -EBUSY;

[Severity: High]
This is a pre-existing issue, but does this improperly mask the original
error code returned by devm_request_irq()?

A similar pattern exists just above this block for platform_get_irq():

pxafb_probe() {
    ...
	irq =3D platform_get_irq(dev, 0);
	if (irq < 0) {
		ret =3D -ENODEV;
		goto failed_free_mem;
	}
    ...
}

If platform_get_irq() returns -EPROBE_DEFER, overriding it to -ENODEV causes
the device probe to fail permanently instead of deferring correctly.

[Severity: Critical]
This is a pre-existing issue, but is the background thread fbi->smart_thread
ever stopped?

Later in pxafb_probe():

pxafb_probe() {
    ...
	ret =3D pxafb_smart_init(fbi);
	if (ret) {
		dev_err(&dev->dev, "failed to initialize smartpanel\n");
		goto failed_free_mem;
	}
    ...
}

pxafb_smart_init() starts a thread with kthread_run(). If this thread is not
stopped in pxafb_remove() or on probe error paths, and fbi is allocated with
devm_kzalloc(), it will be freed while the thread continues to run. Can this
lead to a use-after-free?

[Severity: Critical]
This is a pre-existing issue, but is cpufreq_unregister_notifier() ever cal=
led
to unregister the CPU frequency notifier?

pxafb_probe() {
    ...
#ifdef CONFIG_CPU_FREQ
	fbi->freq_transition.notifier_call =3D pxafb_freq_transition;
	cpufreq_register_notifier(&fbi->freq_transition,
				CPUFREQ_TRANSITION_NOTIFIER);
#endif
    ...
}

If this is missing from pxafb_remove(), could the cpufreq core retain a
dangling pointer in its notifier list when fbi is freed by devres after
unbind?

[Severity: High]
This is a pre-existing issue, but can the asynchronous work fbi->task be le=
ft
running on the error path?

During probe, pxafb_set_par() can schedule this work. If a subsequent step
fails, the error path is taken:

pxafb_probe() {
    ...
failed_free_cmap:
	if (fbi->fb.cmap.len)
		fb_dealloc_cmap(&fbi->fb.cmap);
failed_free_mem:
	free_pages_exact(fbi->video_mem, fbi->video_mem_size);
    ...
}

Returning without cancel_work_sync(&fbi->task) could leave the system
workqueue executing pxafb_task on a freed object since fbi is managed by
devres.

>  		goto failed_free_mem;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722075803.5705=
32-1-panchuang@vivo.com?part=3D5
