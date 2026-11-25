Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44003606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cZq5Qeq1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A428710E2AA;
	Wed, 25 Nov 2026 00:24:46 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F40910F8FA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 00:24:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65C1461B73;
 Wed, 25 Nov 2026 00:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A611F000C4;
 Wed, 25 Nov 2026 00:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795566279;
 bh=6k6AfQb1gBjvFlGEX0pSJGZhr+4funoFozcLk5duaa0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cZq5Qeq1uFyssgLJOfkIjn57ty4rDulKObXLQNOT6ADti4RtXBf5r/BSsDxAy5IDt
 lN5n0cVmJlmnbIoLzOljSugG9CKsbByFX7Z7o2NAHu1ipLiQihjqgZ11kH2xdEBE6k
 y5wuKjOm/6imN20sFyf0LWh6yQknFrmXLNGviGrk0tKtBZszshLZZe6fsqWvOo/Ajh
 GSsuJ9X6COSrt/oerXV4ooWhm0HPmhBRe0PmncqqD1Qafrdgbtr7fKkHxOy54P+cEV
 WHXeS5c8IKcO092UPaxUCo501cViYL9/CmVzjtL7G3HGwc5rXE1+jauRgeCJpEevBQ
 orgYSqI0mEN5w==
Message-ID: <sashiko-outbox-232275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] misc: fastrpc: add HPASS domain
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261125-fastrpc-hpass-support-v1-2-cb1d46b29e3b@oss.qualcomm.com>
References: <20261125-fastrpc-hpass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com>
 <20261125-fastrpc-hpass-support-v1-2-cb1d46b29e3b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 00:24:37 +0000
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
- [Critical] misc: fastrpc: use-after-free due to dangling dma_mask in
  fastrpc_rpmsg_probe() [1]
--

commit 45628114d33912de02c404c2680ce4e7336df5df
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: add HPASS domain

This commit adds HPASS_DOMAIN_ID for the High Performance Audio Subsystem
(HPASS), maps the "hpass" devicetree label to it, and enables reserved
remote heap memory and device registration for the domain.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9e760f68bcaf2..c515097c3d3ba 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2761,6 +2765,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:
>  	case SDSP_DOMAIN_ID:
> +	case HPASS_DOMAIN_ID:
>  		/* Unsigned PD offloading is only supported on CDSP and GDSP */
>  		data->unsigned_support =3D false;
>  		err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);

[Severity: Critical]
This problem wasn't introduced by this patch, but can fastrpc_rpmsg_probe()
leave a dangling rdev->dma_mask pointer [1]?

drivers/misc/fastrpc.c:fastrpc_rpmsg_probe() {
    ...
	rdev->dma_mask =3D &data->dma_mask;
	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
    ...
	err =3D fastrpc_cb_devices_create(rpdev);
	if (err)
		goto err_deregister_fdev;
    ...
err_free_data:
	kfree(data);
	return err;
}

fastrpc_rpmsg_probe() points rdev->dma_mask at data->dma_mask inside the
heap-allocated fastrpc_channel_ctx.  If fastrpc_cb_devices_create() fails
or the driver is later unbound via fastrpc_rpmsg_remove() ->
fastrpc_channel_ctx_put(), data is freed while rpdev->dev lives on with
rdev->dma_mask still pointing into the freed object, causing a
use-after-free on any subsequent probe or DMA API access on the device.

[1] https://sashiko.dev/#/bug/linux-3d83ea49-16e6-4a33-9f74-77e4b19335b8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125-fastrpc-hp=
ass-support-v1-0-cb1d46b29e3b@oss.qualcomm.com?part=3D2
