Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AEEAC44501
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:29:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E85BA10E377;
	Thu, 16 Jul 2026 13:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YhhIZaQm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD4E110E377
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:29:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 310AD600AF
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EA81F000E9;
 Thu, 16 Jul 2026 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208559;
 bh=7MPgXf9UAL/gXsSLCJ8Dcg1C84AG+AD9fQHrDf2wTww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YhhIZaQm7GATFahYYusbqI7s5tkPiJH22w3kQpdKW7kg7UO80yVinwIeBziK48J4D
 G8f15OZGP9wHgPanjhxgBabr1jTcHfkWV5IdSxTe+9kGjBGQFPlos4dINyfwhWWu6S
 fn6fAWeNxb2N6F9rNq5ZY1abKJDctosATIt7YKW5eGxGeTiFLKwGCg9qnIJ6iMC2jU
 QD/8b7F5ahms5Y4Kqmw5zFsVfgUqP8GORWifR2R4i6bM40yDPE4YKpa10IXPDmMwSK
 l6tl08wQV/dsgXylTeQrcXyzrW94ShN3qoSj2mZ3nKaDInGxB1lhFhZf3VCHby6y1k
 pph+pH6JIyZAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/exynos: hdmi: take i2c adapter module reference
To: "Johan Hovold" <johan@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260716131802.1564776-1-johan@kernel.org>
References: <20260716131802.1564776-1-johan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 13:29:18 +0000
Message-Id: <20260716132919.A3EA81F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Use-after-free on error paths in probe due to un-cancelled delayed=
 work.
- [High] Resource leak of drm_bridge in probe error paths.
- [High] Resource leak of DRM connector and CEC notifier if drm_bridge_atta=
ch fails.
--

--- Patch [1]: [PATCH] drm/exynos: hdmi: take i2c adapter module reference =
---
commit 63541a71709f0db259d49c1fafb2342af0cef43e
Author: Johan Hovold <johan@kernel.org>
drm/exynos: hdmi: take i2c adapter module reference

This patch changes the i2c adapter retrieval to use
of_get_i2c_adapter_by_node() instead of of_find_i2c_adapter_by_node()
so it takes a module reference to prevent uninterruptible blocking
during adapter deregistration. The removal path is updated to use
i2c_put_adapter() instead of put_device().

> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exyno=
s/exynos_hdmi.c
> index 09b2cabb236f3..b971b7098a4d9 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
[ ... ]
> @@ -2069,7 +2069,7 @@ static int hdmi_probe(struct platform_device *pdev)
>  	if (hdata->regs_hdmiphy)
>  		iounmap(hdata->regs_hdmiphy);
>  err_ddc:
> -	put_device(&hdata->ddc_adpt->dev);
> +	i2c_put_adapter(hdata->ddc_adpt);

[Severity: High]
This isn't a bug introduced by this patch, but does the error path here lea=
ve
a pending delayed work item that could cause a use-after-free?

In hdmi_probe(), hdata->hotplug_work is initialized and an IRQ handler is
registered via devm_request_threaded_irq(). If the IRQ triggers during the
remainder of the probe function, the handler will schedule the delayed work.

If probe subsequently fails, devres automatically disables and frees the IR=
Q,
and then frees hdata. However, because the error paths do not call
cancel_delayed_work_sync(), the scheduled work could remain on the timer or
workqueue and eventually execute, accessing the already freed hdata memory.

[Severity: High]
This isn't a bug introduced by this patch, but is there a resource leak of
the drm_bridge in these error paths?

Earlier in hdmi_probe(), hdmi_resources_init() acquires a bridge reference =
via
of_drm_find_and_get_bridge() and stores it in hdata->bridge. If hdmi_probe()
fails and takes this error path, it seems drm_bridge_put(hdata->bridge) is
never called, leaking the reference and permanently pinning the bridge modu=
le.

> =20
>  	return ret;
>  }

[Severity: High]
This is a pre-existing issue, but can hdmi_create_connector() leak resources
if drm_bridge_attach() fails?

In hdmi_create_connector(), if drm_bridge_attach() fails, ret is set to an
error code, but the function does not return immediately:

drivers/gpu/drm/exynos/exynos_hdmi.c:hdmi_create_connector() {
    ...
	if (hdata->bridge)
		ret =3D drm_bridge_attach(encoder, hdata->bridge, NULL, 0);

	cec_fill_conn_info_from_drm(&conn_info, connector);

	hdata->notifier =3D cec_notifier_conn_register(hdata->dev, NULL,
						     &conn_info);
    ...
	return ret;
}

If the CEC registration succeeds, the function returns the error code from
drm_bridge_attach(). The caller observes the error and aborts, but since
hdmi_connector_destroy() is never called, do the DRM connector and CEC
notifier remain registered and leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716131802.1564=
776-1-johan@kernel.org?part=3D1
