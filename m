Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F11A606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l162tGFk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C03248825E;
	Wed,  4 Nov 2026 09:07:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 973098825E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 09:07:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 671E340299;
 Wed,  4 Nov 2026 09:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 317EF1F000C1;
 Wed,  4 Nov 2026 09:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793783270;
 bh=W6zfrGdE5xOFovD/77OgwOSVPfC+zD1yyQsRJmCCATw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l162tGFkjluvlhh+5nVDZ2uoalNh/GGsWdBOOw59EOORF6Db4fQ5U/6sJR3//GQRa
 3AsRWjIsG4WcxVwhPdYjMSTFlPMDGzAPmTD9yj2deSb0+7I2WZoJS8zi2Hyr9W/h0r
 f2+LIDQaJEGxPAlrQwCxX0qHve/g4nbwLa2tkVGxYtQM7sSdehWfxnfe79DBfO50Zd
 WTJcUuOUOQ0FQ1KU9SCBXewlm7GfMqZRAZIJq6xq1F3n5mSSZ/CxSqDP3QlRh+CqdP
 0zawaHGrWkM+ulFOjHgXYjdi2FtmGqpZ8eN8Lni6EwtpmFA/cpT2AxKF2399IR0aUS
 2jdoI6Nc3K4pw==
Message-ID: <sashiko-outbox-196924@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] accel/habanalabs: disable pending-reset work in
 hl_device_fini()
To: "Chengyu Liu" <lui2012qwq@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103163354.1599176-1-lui2012qwq@gmail.com>
References: <20261103163354.1599176-1-lui2012qwq@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:07:49 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] accel/habanalabs: disabling reset_work in hl_device_fini() str=
ands in_reset
--

commit eb768a82770d27a90572b30cd01bc34db4fd01ba
Author: Chengyu Liu <lui2012qwq@gmail.com>

accel/habanalabs: disable pending-reset work in hl_device_fini()

This commit replaces flush_delayed_work() with disable_delayed_work_sync() =
in
hl_device_fini() to prevent device_hard_reset_pending() from re-arming
hdev->device_reset_work.reset_work during device teardown.

> diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/hab=
analabs/common/device.c
> index 09b27bac3a31d..4635dc8572f03 100644
> --- a/drivers/accel/habanalabs/common/device.c
> +++ b/drivers/accel/habanalabs/common/device.c
> @@ -2487,7 +2487,7 @@ void hl_device_fini(struct hl_device *hdev)
>  	dev_info(hdev->dev, "Removing device %s\n", dev_name(&(hdev)->pdev->dev=
));
> =20
>  	hdev->device_fini_pending =3D 1;
> -	flush_delayed_work(&hdev->device_reset_work.reset_work);
> +	disable_delayed_work_sync(&hdev->device_reset_work.reset_work);

[Severity: Critical]
Does cancelling and disabling hdev->device_reset_work.reset_work here leave
hdev->reset_info.in_reset stuck at 1 and cause hl_device_fini() to time out
and skip teardown?

When a hard reset is initiated outside the reset thread, hl_device_reset()
sets hdev->reset_info.in_reset =3D 1 and hands off clearing it to
hdev->device_reset_work.reset_work:

drivers/accel/habanalabs/common/device.c:hl_device_reset() {
	...
		hdev->reset_info.in_compute_reset =3D !hard_reset;

		hdev->reset_info.in_reset =3D 1;

		spin_unlock(&hdev->reset_info.lock);
	...
	if ((hard_reset) && (!from_hard_reset_thread)) {
		hdev->reset_info.hard_reset_pending =3D true;
		...
		queue_delayed_work(hdev->reset_wq, &hdev->device_reset_work.reset_work, 0=
);

		return 0;
	}
}

When device_hard_reset_pending() runs hl_device_reset() and
device_kill_open_processes() returns -EBUSY while device_fini_pending is 0,
hl_device_reset() returns -EBUSY directly without jumping to out_err, keepi=
ng
hdev->reset_info.in_reset set to 1 across the retry delay:

drivers/accel/habanalabs/common/device.c:hl_device_reset() {
	...
		rc =3D device_kill_open_processes(hdev, 0, false);

		if (rc =3D=3D -EBUSY) {
			if (hdev->device_fini_pending) {
				dev_crit(hdev->dev,
					"%s Failed to kill all open processes, stopping hard reset\n",
					dev_name(&(hdev)->pdev->dev));
				goto out_err;
			}

			/* signal reset thread to reschedule */
			return rc;
		}
	...
out_err:
	...
	hdev->reset_info.in_reset =3D 0;

	spin_unlock(&hdev->reset_info.lock);

	return rc;
}

Previously, setting hdev->device_fini_pending =3D 1 and calling
flush_delayed_work() forced any pending reset_work to execute immediately
with device_fini_pending =3D=3D 1, which entered the goto out_err path and
cleared hdev->reset_info.in_reset =3D 0.

With disable_delayed_work_sync(), if reset_work is waiting on its retry tim=
er
(or queued on reset_wq before starting), or if a running callback already r=
ead
hdev->device_fini_pending =3D=3D 0 in hl_device_reset() before returning -E=
BUSY,
or if a concurrent hl_device_reset() sets in_reset =3D 1 and queues reset_w=
ork
before hl_device_fini() takes hdev->reset_info.lock, the work item never ru=
ns
again to clear hdev->reset_info.in_reset.

Won't hl_device_fini() then spin in while (device_in_reset) for the full
HL_HARD_RESET_MAX_TIMEOUT (or HL_PLDM_HARD_RESET_MAX_TIMEOUT) and return
early without cleaning up the device before hl_pci_remove() calls
destroy_hdev()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103163354.1599=
176-1-lui2012qwq@gmail.com?part=3D1
