Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E52C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 04:13:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E0010EFC4;
	Wed,  8 Jul 2026 04:13:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O5sL1WJR";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38ECC10EFC4
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 04:13:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4EB3D60008;
 Wed,  8 Jul 2026 04:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF681F000E9;
 Wed,  8 Jul 2026 04:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783483993;
 bh=SyyZkIPQhYS+aKTZk/Su+hotvAEGiru0HGu+EAyfvvw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O5sL1WJRVJKhaGO54+M19R2HwiYbMsv3OxA89bvCTRGXMXFCKoepIDqcW4kl0UOnE
 m8zQyMK+5GqQJfIZ0AmuVIP3tFqfj69gaQTfjQKe+K4iiurBI6H3McDxqC3t25GI59
 hMe2YwyKLe032qk7j0enjFwQV7SqG8r5bAY244h+JXJsXUVymd2waefbrk94t996DB
 tuyH71Kbdcn36q/h6xcb2xnmdIcU6Zb5yxVXtuQmLEAhmDtV0DQmWbJxW3YeyxFhgi
 PEmppCPZ3aHaYi70HhQ0pQjEMXPSqNM5MJ/KAQB94Au4Ip5i7KsAob9wsgDspmo9yo
 aNON8CE9VTZ/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] misc: fastrpc: create duplicate sessions after
 all CB probing
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260708-dup-sessions-v2-2-da40f9c98a2b@oss.qualcomm.com>
References: <20260708-dup-sessions-v2-0-da40f9c98a2b@oss.qualcomm.com>
 <20260708-dup-sessions-v2-2-da40f9c98a2b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 04:13:12 +0000
Message-Id: <20260708041312.ACF681F000E9@smtp.kernel.org>
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
- [High] Concurrent `open()` calls during the unprotected gap after child p=
robing permanently leak duplicated sessions.

Pre-existing issues:
- [Critical] The misc device is exposed to userspace before crucial synchro=
nization primitives and lists are initialized, leading to uninitialized spi=
nlock usage and NULL pointer dereferences.
- [High] Missing `of_platform_depopulate()` on the `of_platform_populate()`=
 error path causes dangling child devices with freed drvdata.
- [High] On the error path of `fastrpc_rpmsg_probe()`, `kfree(data)` uncond=
itionally frees memory while a userspace file descriptor may hold a referen=
ce.
--

--- Patch [2]: [PATCH v2 2/2] misc: fastrpc: create duplicate sessions afte=
r all CB probing ---
commit 56303754fdfc0beae4b68e60fa9dc54ca7e73396
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: create duplicate sessions after all CB probing

Instead of duplicating sessions inline during fastrpc_cb_probe() using
the qcom,nsessions DT property, defer duplication until after
of_platform_populate() returns in fastrpc_rpmsg_probe(), at which point
all compute-CB child nodes have been probed and the session array is
fully populated.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2352,6 +2352,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
[ ... ]
>  	switch (domain_id) {
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
>  	case SDSP_DOMAIN_ID:
>  		/* Unsigned PD offloading is only supported on CDSP and GDSP */
>  		data->unsigned_support =3D false;
>  		err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);

[Severity: Critical]
This isn't a bug introduced by this patch, but does registering the misc
device here expose it to userspace before crucial synchronization primitives
are initialized?

A concurrent userspace process could immediately call open(), which would
attempt to use data->refcount and data->lock before they are initialized
further down in this function.

>  		if (err)
>  			goto err_free_data;
>  		break;
[ ... ]
>  	spin_lock_init(&data->lock);
>  	idr_init(&data->ctx_idr);
>  	data->domain_id =3D domain_id;
>  	data->rpdev =3D rpdev;
>  	dev_set_drvdata(&rpdev->dev, data);
> =20
>  	err =3D of_platform_populate(rdev->of_node, NULL, NULL, rdev);
>  	if (err)
>  		goto err_deregister_fdev;

[Severity: High]
This is a pre-existing issue, but if of_platform_populate() fails halfway
through, does the error path miss a call to of_platform_depopulate()?

Since the channel context data is freed on the error path, this could leave
dangling child devices that might dereference freed drvdata when they are
later unbound.

> +	if (data->domain_id =3D=3D ADSP_DOMAIN_ID && data->sesscount > 0) {
> +		struct fastrpc_session_ctx *last_sess;
> +		struct fastrpc_session_ctx *dup_sess;
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&data->lock, flags);
> +		last_sess =3D &data->session[data->sesscount - 1];
> +		for (i =3D 0; i < FASTRPC_DUP_SESSIONS; i++) {
> +			if (data->sesscount >=3D FASTRPC_MAX_SESSIONS)
> +				break;
> +			dup_sess =3D &data->session[data->sesscount++];
> +			memcpy(dup_sess, last_sess, sizeof(*dup_sess));

[Severity: High]
Can this loop permanently leak session capacity if userspace calls open()
concurrently?

Since the lock is dropped in fastrpc_cb_probe() long before we get here,
could a concurrent open() claim last_sess and set its used flag to true?
If so, this memcpy() would blindly duplicate the used=3Dtrue state into all
new sessions, making them permanently unavailable to subsequent users.

> +		}
> +		spin_unlock_irqrestore(&data->lock, flags);
> +	}
> +
>  	return 0;
> =20
>  err_deregister_fdev:
>  	if (data->fdevice)
>  		misc_deregister(&data->fdevice->miscdev);
>  	if (data->secure_fdevice)
>  		misc_deregister(&data->secure_fdevice->miscdev);
> =20
>  err_free_data:
>  	kfree(data);

[Severity: High]
This is a pre-existing issue, but does calling kfree(data) here
unconditionally cause a use-after-free if userspace has already opened
the misc device?

Because the misc device is registered earlier in this function, a userspace
process might already hold an open file descriptor. If we free the channel
context here upon a probe failure, any subsequent ioctls or close
operations by that process will access freed memory.

>  	return err;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-dup-sessio=
ns-v2-0-da40f9c98a2b@oss.qualcomm.com?part=3D2
