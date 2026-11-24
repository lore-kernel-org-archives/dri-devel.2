Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BF2606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esrJHS2L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 675B310F44E;
	Tue, 24 Nov 2026 10:28:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9080D10F44E
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:28:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 96A5D62370;
 Tue, 24 Nov 2026 10:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010CA1F000C0;
 Tue, 24 Nov 2026 10:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795516113;
 bh=SDwr1KZ4oZt+iDhXVYNXUHxXhSJikmNHcMaW2U+zd9Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=esrJHS2LWdJBPx3zc9zGvREZApYVjomKONLc+2qlruwrxauf8SNZJ4AocsU3t4a4r
 0exZqdh19HpBQkKXWxpoUZ7C91qO9RavZz96sjnr5ovxnfMlI5R5Aorj/R9CZ9fEaI
 H/3zSNvkAohZ0KpfHcxrmafNfN58A5mWwmFLOIa4vitMVewGswKxtbJ5AocLkBEo3/
 pp3ntmIUwS83Jge5CWHPtm4OqGIENHF/9bMNhciLp4J5qgKQOpy/EV1i5ys2hgUbQv
 L33wMw22SifsvBQy7Jvz2eXoUKpigAW2bLSrTVNuvgQi5PuIBvcH1ZiiFxyrfkjifR
 rkt0Rng7g2rtw==
Message-ID: <sashiko-outbox-230963@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/bridge: cdns-mhdp8546: Power on/off the PHY in
 probe/remove
To: "Abhash Kumar Jha" <a-kumar2@ti.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124101747.2432344-1-a-kumar2@ti.com>
References: <20261124101747.2432344-1-a-kumar2@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 10:28:31 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] drm/bridge: cdns-mhdp8546: use-after-free in
  cdns_mhdp_fw_cb() [1]
--

commit 23a21b2ed969a0e335bad1cc0a8b7a4ecba91485
Author: Abhash Kumar Jha <a-kumar2@ti.com>

drm/bridge: cdns-mhdp8546: Power on/off the PHY in probe/remove

This commit adds phy_power_on() and phy_power_off() calls alongside
phy_init() and phy_exit() in cdns_mhdp_probe() and cdns_mhdp_remove().

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index f47717bd10798..86e850a4752dc 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
[ ... ]
> @@ -2424,6 +2432,7 @@ static void cdns_mhdp_remove(struct platform_device=
 *pdev)
>  				ERR_PTR(ret));
>  	}
> =20
> +	phy_power_off(mhdp->phy);
>  	phy_exit(mhdp->phy);
> =20
>  	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->exit)

[Severity: Critical]
This problem wasn't introduced by this patch, but can cdns_mhdp_fw_cb()
trigger a use-after-free on mhdp [1] if firmware loading takes longer
than the 100ms timeout in cdns_mhdp_remove()?

cdns_mhdp_load_firmware() starts an asynchronous request with
request_firmware_nowait(), passing the devres-managed mhdp as the callback
context.  If wait_event_timeout() in cdns_mhdp_remove() expires before the
firmware finishes loading, cdns_mhdp_remove() logs an error and returns
without cancelling or waiting for the request:

drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:cdns_mhdp_remove() {
    ...
	ret =3D wait_event_timeout(mhdp->fw_load_wq,
				 mhdp->hw_state =3D=3D MHDP_HW_READY,
				 timeout);
	spin_lock(&mhdp->start_lock);
	mhdp->hw_state =3D MHDP_HW_STOPPED;
	spin_unlock(&mhdp->start_lock);

	if (ret =3D=3D 0) {
		dev_err(mhdp->dev, "%s: Timeout waiting for fw loading\n",
			__func__);
	} else {
    ...
}

After cdns_mhdp_remove() returns, devres cleanup frees mhdp, and when the
pending request completes later, cdns_mhdp_fw_cb() dereferences the freed
mhdp pointer.

[1] https://sashiko.dev/#/bug/linux-745c94fb-512f-4afa-95f5-092458e19f3a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124101747.2432=
344-1-a-kumar2@ti.com?part=3D1
