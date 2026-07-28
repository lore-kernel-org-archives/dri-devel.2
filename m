Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22393C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 14:06:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE8610E90F;
	Tue, 28 Jul 2026 14:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VE3C16IV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80B5310E90F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:06:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EBBE841451;
 Tue, 28 Jul 2026 14:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE39D1F000E9;
 Tue, 28 Jul 2026 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785247590;
 bh=BHr2LhfcbgThr2v9PL94m/2k7z7dj5xsBJxTIMPHDZY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VE3C16IVeYi1H+6ykrLdsva01ktAbHX77W5xeWTn6Bghm+Z8GATxyl4MdglaEDmX3
 Dqzu2Cb7KgMrSNKgoX5F54Jtqq7VI5R6Qp47okIvlpH554pZtMdlAeWJBlAKmoHFFO
 UtqZSDJcjtGPWV7EzcAzQZFw0FCqMp7jd+7Tjv3zrvXBD0Hh//t7vwo8ELpKiVdlGF
 lmlLumkbBDSYWLFynHoswrw+3RIbYUZ0iC3YDtbRLdVIHT/sEvf2DIF7tCF4x8ViJ6
 IHP784PLngxGbJBdEeE9wjvjBI4YckN/tHrtxyLOLqPZSeMO7uM+lp5RfDgqVf3LeL
 RGLEthsQbuJrw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: cdns-mhdp8546: cancel work before teardown
To: "Hongyan Xu" <getshell@seu.edu.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728135214.1850-1-getshell@seu.edu.cn>
References: <20260728135214.1850-1-getshell@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 14:06:30 +0000
Message-Id: <20260728140630.AE39D1F000E9@smtp.kernel.org>
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

New issues:
- [High] Moving work cancellations to the beginning of the remove function =
creates a Use-After-Free race condition where DRM atomic hooks can re-queue=
 the works.

Pre-existing issues:
- [Critical] Stack buffer overflow in `cdns_mhdp_hdcp_check_receviers` due =
to missing bounds check on `recv_num`.
- [High] The asynchronous firmware loading callback `cdns_mhdp_fw_cb` can e=
xecute after device teardown has completed, causing a use-after-free, acces=
sing unmapped memory, and locking a destroyed mutex.
- [High] `cdns_mhdp_modeset_retry_fn` dereferences `mhdp->connector` withou=
t checking for NULL, leading to a kernel crash if the bridge is disabled be=
fore the work executes.
- [Medium] Overwriting `platform_get_irq()` return value breaks deferred pr=
obing.
--

--- Patch [1]: [PATCH] drm/bridge: cdns-mhdp8546: cancel work before teardo=
wn ---
commit aa3183d71b3121eab38e232fed56925730e48ce8
Author: Hongyan Xu <getshell@seu.edu.cn>
Subject: drm/bridge: cdns-mhdp8546: cancel work before teardown

This commit attempts to fix race conditions during module removal by
masking interrupts and cancelling work items before tearing down the
DRM bridge and hardware state.

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
[ ... ]
> @@ -2338,12 +2337,12 @@ static int cdns_mhdp_probe(struct platform_device=
 *pdev)
> =20
>  	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
> =20
> -	irq =3D platform_get_irq(pdev, 0);
> -	ret =3D devm_request_threaded_irq(mhdp->dev, irq, NULL,
> +	mhdp->irq =3D platform_get_irq(pdev, 0);
> +	ret =3D devm_request_threaded_irq(mhdp->dev, mhdp->irq, NULL,
>  					cdns_mhdp_irq_handler, IRQF_ONESHOT,
>  					"mhdp8546", mhdp);
>  	if (ret) {
> -		dev_err(dev, "cannot install IRQ %d\n", irq);
> +		dev_err(dev, "cannot install IRQ %d\n", mhdp->irq);
>  		ret =3D -EIO;
>  		goto plat_fini;
>  	}

[Severity: Medium]
This is a pre-existing issue, but does overwriting the return value of
platform_get_irq() break deferred probing?

If platform_get_irq() returns -EPROBE_DEFER, the negative value causes
devm_request_threaded_irq() to fail. The error path then unconditionally
overwrites the error with -EIO instead of propagating -EPROBE_DEFER, which
might permanently prevent the driver from probing if the IRQ provider is
initialized later.

[ ... ]
> @@ -2406,6 +2405,19 @@ static void cdns_mhdp_remove(struct platform_devic=
e *pdev)
>  	unsigned long timeout =3D msecs_to_jiffies(100);
>  	int ret;
> =20
> +	spin_lock(&mhdp->start_lock);
> +	mhdp->bridge_attached =3D false;
> +	spin_unlock(&mhdp->start_lock);
> +	writel(~0, mhdp->regs + CDNS_APB_INT_MASK);
> +	devm_free_irq(mhdp->dev, mhdp->irq, mhdp);
> +
> +	cancel_work_sync(&mhdp->hpd_work);
> +	cancel_work_sync(&mhdp->modeset_retry_work);

[Severity: High]
Can moving these work cancellations to the beginning of the remove function
create a race condition where DRM atomic hooks re-queue the work?

Because drm_bridge_remove() has not yet been called at this point,
concurrent DRM operations might invoke cdns_mhdp_atomic_enable().=20
If an error occurs there, the code schedules the work again:

cdns_mhdp_atomic_enable() {
    ...
    if (ret < 0)
        schedule_work(&mhdp->modeset_retry_work);
    ...
}

Since cdns_mhdp_atomic_enable() does not check the newly added
mhdp->bridge_attached flag, could this re-queue the work after the
cancellation completes, causing it to access freed memory once the
remove function finishes?

[Severity: High]
This isn't a bug introduced by this patch, but while looking at
modeset_retry_work, can the work function dereference a NULL pointer?

If cdns_mhdp_atomic_enable() fails and queues mhdp->modeset_retry_work,
and the display pipeline is then disabled before the work executes:

cdns_mhdp_atomic_disable() {
    ...
    mhdp->connector =3D NULL;
}

The pending work is not cancelled. When cdns_mhdp_modeset_retry_fn()
eventually executes, it behaves like this:

cdns_mhdp_modeset_retry_fn() {
    conn =3D mhdp->connector;
    ...
    mutex_lock(&conn->dev->mode_config.mutex);
    ...
}

Will this crash when dereferencing conn->dev if the connector is NULL?

> +	if (mhdp->hdcp_supported) {
> +		cancel_delayed_work_sync(&mhdp->hdcp.check_work);
> +		cancel_work_sync(&mhdp->hdcp.prop_work);
> +	}
> +
>  	drm_bridge_remove(&mhdp->bridge);
> =20
>  	ret =3D wait_event_timeout(mhdp->fw_load_wq,
[ ... ]
> @@ -2432,10 +2444,6 @@ static void cdns_mhdp_remove(struct platform_devic=
e *pdev)
> =20
>  	pm_runtime_put_sync(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
> -
> -	cancel_work_sync(&mhdp->modeset_retry_work);
> -	flush_work(&mhdp->hpd_work);
> -	/* Ignoring mhdp->hdcp.check_work and mhdp->hdcp.prop_work here. */
>  }

[Severity: High]
This is a pre-existing issue, but can the asynchronous firmware loading=20
callback execute after the device teardown has completed?

In cdns_mhdp_remove(), the driver waits for firmware loading with a timeout:

cdns_mhdp_remove() {
    ...
    ret =3D wait_event_timeout(mhdp->fw_load_wq,
                             mhdp->hw_state =3D=3D MHDP_HW_READY,
                             timeout);
    ...
}

If the firmware load takes longer than the 100ms timeout, the driver
proceeds with teardown and devres frees the mhdp structure. When the
firmware eventually loads, cdns_mhdp_fw_cb() executes:

cdns_mhdp_fw_cb() {
    struct cdns_mhdp_device *mhdp =3D context;

    dev_dbg(mhdp->dev, "firmware callback\n");
    ...
}

Does this result in a use-after-free by accessing the freed mhdp structure
and unmapped memory?

[Severity: Critical]
This is a pre-existing issue, but does cdns_mhdp_hdcp_check_receviers()
suffer from a stack buffer overflow?

The function allocates a fixed-size stack array for receiver IDs:

cdns_mhdp_hdcp_check_receviers() {
    u8 hdcp_rec_id[HDCP_MAX_RECEIVERS][HDCP_RECEIVER_ID_SIZE_BYTES];
    ...
}

It then calls cdns_mhdp_hdcp_rx_id_valid(), which reads recv_num directly
from the firmware mailbox and copies data into the caller's stack buffer
without bounds checking:

cdns_mhdp_hdcp_rx_id_valid() {
    ...
    *recv_num =3D rec_id_hdr[0];
    ret =3D cdns_mhdp_secure_mailbox_recv_data(mhdp, hdcp_rx_id, 5 * *recv_=
num);
    ...
}

If a compromised sink device or firmware returns an unexpectedly large
recv_num (which is an 8-bit value up to 255), does this overflow the 160-by=
te
hdcp_rec_id array on the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728135214.1850=
-1-getshell@seu.edu.cn?part=3D1
