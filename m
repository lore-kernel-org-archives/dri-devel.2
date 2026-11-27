Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10952606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bjuzlGT1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C49C1129D8;
	Fri, 27 Nov 2026 10:20:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF5C1129CF
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:20:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EAD27411EF;
 Fri, 27 Nov 2026 10:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7ACE1F00A23;
 Fri, 27 Nov 2026 10:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795774846;
 bh=JaY8iiV0bmEbcp8pDD8qlr2cD8VPuxdKtbGn/xLB49Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bjuzlGT1vntG0jDp8v5wIkRo19yf7Bm6MRyhB0l9kCBfDrpGHuqudCT/xAXffAT2S
 ZI1J6uxJ7mE+RIBEglzM8BxRfgmE6oXYM8qvgYzaf4QPFJlc+SRIWsWuq7SU8WDAnN
 AOmahX/spzsWgirFP8iRTC6HSlCaFvtg94ZqOjr7Y/SfgAzBlDKUxGS7Nl0lvR88on
 gA3vnCopta+xjEvnq1UT+yFHS66EtRU6G9E+1sjhrlNjcyEq1qFw7yM0jYVZilo0gJ
 O8f1cGXMf0KNQNv9EWufk9WopwnCZ8BbZRhGWxqTL4s9PxG9egZ7tXJaGUWKCqFZmc
 D92yimqmiWvTQ==
Message-ID: <sashiko-outbox-237100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] misc: fastrpc: expose unsigned PD node for
 compute-capable ADSP
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127-master-v1-2-f998ec22497b@oss.qualcomm.com>
References: <20261127-master-v1-0-f998ec22497b@oss.qualcomm.com>
 <20261127-master-v1-2-f998ec22497b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:20:46 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] misc: fastrpc: unsigned ADSP node bypasses
  is_session_rejected() on attach
- [Medium] misc: fastrpc: double misc_deregister() on
  fastrpc_register_devices() failure
--

commit d18eec61ddce41081d48907710281fa58756b138
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: expose unsigned PD node for compute-capable ADSP

This commit registers both the secure and non-secure fastrpc device nodes
when an ADSP domain reports FASTRPC_DSP_COMPUTE_LITE in its cached DSP
attributes.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 48ded6080ddd6..28d29c768aad7 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2647,6 +2664,9 @@ static int fastrpc_register_devices(struct fastrpc_=
channel_ctx *cctx,
> =20
>  	switch (cctx->domain_id) {
>  	case ADSP_DOMAIN_ID:
> +		if (compute_capable)
> +			goto unsigned_capable;
> +		fallthrough;

[Severity: High]
Can an untrusted application opening the non-secure /dev/fastrpc-adsp
node on a secure ADSP channel bypass is_session_rejected() and attach to
signed protection domains?

Jumping to unsigned_capable registers a non-secure node (fl->is_secure_dev
is false) on a secure ADSP channel (fl->cctx->secure is true).  While
fastrpc_init_create_process() calls is_session_rejected() to restrict
non-secure nodes to unsigned PD requests, neither
fastrpc_init_create_static_process() nor fastrpc_init_attach() checks
is_session_rejected(fl, false).  Unlike CDSP and GDSP, ADSP populates
cctx->remote_heap_addr, so an unprivileged caller holding an fd to
/dev/fastrpc-adsp can invoke FASTRPC_IOCTL_INIT_CREATE_STATIC,
FASTRPC_IOCTL_INIT_ATTACH, or FASTRPC_IOCTL_INIT_ATTACH_SNS to attach to
the static Audio PD, ROOT_PD, or SENSORS_PD and invoke remote methods in
those privileged PDs.

>  	case MDSP_DOMAIN_ID:
>  	case SDSP_DOMAIN_ID:
>  		/* Unsigned PD offloading is only supported on CDSP and GDSP */
> @@ -2657,6 +2677,7 @@ static int fastrpc_register_devices(struct fastrpc_=
channel_ctx *cctx,
>  		break;
>  	case CDSP_DOMAIN_ID:
>  	case GDSP_DOMAIN_ID:
> +unsigned_capable:
>  		cctx->unsigned_support =3D true;
>  		/* Create both device nodes so that we can allow both Signed and Unsig=
ned PD */
>  		err =3D fastrpc_device_register(rdev, cctx, true, cctx->domain);

[Severity: Medium]
Can a failure when registering the second device node under
unsigned_capable cause a double misc_deregister() on
cctx->secure_fdevice->miscdev?

If the first fastrpc_device_register() succeeds and sets
cctx->secure_fdevice, and the second fastrpc_device_register() for the
non-secure node fails, err_deregister_fdev deregisters
cctx->secure_fdevice->miscdev without clearing cctx->secure_fdevice to
NULL:

drivers/misc/fastrpc.c:fastrpc_register_devices() {
	...
err_deregister_fdev:
	if (cctx->fdevice)
		misc_deregister(&cctx->fdevice->miscdev);
	if (cctx->secure_fdevice)
		misc_deregister(&cctx->secure_fdevice->miscdev);

	return err;
}

Because fastrpc_register_devices() runs asynchronously in
fastrpc_cap_query_work() after fastrpc_rpmsg_probe() has already returned
0, the rpmsg device remains bound.  When fastrpc_rpmsg_remove() later runs
on channel teardown, it sees cctx->secure_fdevice still non-NULL and calls
misc_deregister(&cctx->secure_fdevice->miscdev) a second time, freeing an
already-freed minor number.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-master-v1-=
0-f998ec22497b@oss.qualcomm.com?part=3D2
