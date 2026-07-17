Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A563C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 11:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B695B10E40A;
	Fri, 17 Jul 2026 11:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ePSmAzOY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B96C10F51B
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 11:45:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6407260A5E;
 Fri, 17 Jul 2026 11:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA491F000E9;
 Fri, 17 Jul 2026 11:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784288738;
 bh=V41X7WavnzWLeeev2QuhBlPBPXS7/DAwkzvvVWtVMEY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ePSmAzOYeiQIkaMoeu2KJKvZOD29bmMNz+HDvjIyGBrp/KABkY3iaM2FZPOaDSL6q
 hAow/z8vvuVBiNopquV2wXVGx3u/qmxC4qAn18IRil85336Wz/SxVRvhK8cJvUOhwt
 VPKJrDc63mvXzurRCKirnp3w20fhp/Lj/w0oZTY0EKPAiTAhi29CMrb37Lb7cThsrU
 D45yRKqElfrT2CHCwSwlPyYIScJ1OtcEW6ncoOQd4lrr+BYP8B8og/4lBOFAyNqI6G
 3ZA5N2jIqA3ZKPQJmjh6yV+oUBPrzZ77SVKy+dZbWnH7e4C3ikt93zcLnNNSav+5Sj
 pVDEADdmTr2rg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/msm/dp: add .shutdown to mask HPD IRQ before system
 shutdown
To: "Mahadevan P" <mahadevan.p@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260717-dpshutdown-v1-1-b062c2f7dfb1@oss.qualcomm.com>
References: <20260717-dpshutdown-v1-1-b062c2f7dfb1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 11:45:37 +0000
Message-Id: <20260717114537.EFA491F000E9@smtp.kernel.org>
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
- [Low] Redundant synchronize_irq() call.

Pre-existing issues:
- [High] Incomplete fix: Race window in system shutdown still allows IOMMU =
faults.
- [High] Use-after-free of dp->aux in IRQ handler during driver unbind.
--

--- Patch [1]: [PATCH] drm/msm/dp: add .shutdown to mask HPD IRQ before sys=
tem shutdown ---
commit d07c91cbfabdf117c1daa68222fb3889fa6527d8
Author: Mahadevan P <mahadevan.p@oss.qualcomm.com>

drm/msm/dp: add .shutdown to mask HPD IRQ before system shutdown

This commit adds a .shutdown callback to mask and flush the HPD IRQ before
system shutdown. This is intended to prevent late hotplug events from
triggering a new modeset that drives hardware through a stale IOMMU mapping
during reboot.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index dc6f33809ca5f..b4fbdeebf952c 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1207,6 +1207,14 @@ static void msm_dp_display_remove(struct platform_=
device *pdev)
>  	platform_set_drvdata(pdev, NULL);
>  }

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free during
driver unbind?

Looking at msm_dp_display_remove(), msm_dp_display_deinit_sub_modules() is
called right before platform_set_drvdata():

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_remove() {
    ...
    msm_dp_display_deinit_sub_modules(dp);
    platform_set_drvdata(pdev, NULL);
}

This manually frees dp->aux. However, since the IRQ is managed by
devm_request_threaded_irq, it remains registered and enabled until the
devres release phase occurs after the remove callback returns.

If a hotplug interrupt fires during this window, wouldn't the handler
dereference the freed pointer?

msm_dp_display_irq_handler()
    ...
    hpd_isr_status =3D msm_dp_aux_get_hpd_intr_status(dp->aux);

> =20
> +static void msm_dp_display_shutdown(struct platform_device *pdev)
> +{
> +	struct msm_dp_display_private *dp =3D dev_get_dp_display_private(&pdev-=
>dev);
> +
> +	disable_irq(dp->irq);

[Severity: High]
This is a pre-existing issue, but does this fully resolve the race condition
during system shutdown?

If a hotplug interrupt fires after the DRM master .shutdown callback has
disabled CRTCs but before msm_dp_display_shutdown(), disable_irq() will wait
for the scheduled msm_dp_display_irq_thread to finish.=20

If that thread executes drm_client_dev_hotplug() and performs an atomic
commit to turn the display back on, disable_irq() waits for it to complete.

Doesn't this guarantee the display is active when .shutdown returns,
allowing the IOMMU shutdown to trigger the same fatal fault?

> +	synchronize_irq(dp->irq);

[Severity: Low]
Is this call to synchronize_irq() redundant?

Since disable_irq() is not called from an atomic context here, it
inherently calls synchronize_irq() internally to wait for any currently
executing handlers to complete.

> +}
> +
>  static int msm_dp_pm_runtime_suspend(struct device *dev)

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717-dpshutdown=
-v1-1-b062c2f7dfb1@oss.qualcomm.com?part=3D1
