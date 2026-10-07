Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F781CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 11:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B8F10E0E1;
	Wed,  7 Oct 2026 11:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="O1MP1hqw";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0158A10E0E1
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 11:52:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 250DE601FB;
 Wed,  7 Oct 2026 11:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AA01F0089C;
 Wed,  7 Oct 2026 11:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791373940;
 bh=ADgAF1xiCxd0tx2uicEcbqOQh+sTsqYQi06qtCZ5W0w=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=O1MP1hqwT3RS50n0VBOcFzq4cMUgP47+UUeEGn3J1T+ODsTvDPZACS9uzDKybEh6z
 NUpFa7H63ygQVi5C8Wa90blYyvhqNgVEau3DDXgUpw8Ky9kIIt/qWXvudJY14kQqR/
 xORUd3klZnfbqIUV9dKns4OPiq3y13RdqoHfbg4Q4qnTEbM8kuN3BW/8HHxHqLSyig
 H7YF/pb80MsvyFsZPy8vwnRlkqPeMFQPcPNOGZH3sNBhULVM9BitOUP/6yf8uME9Ib
 wN+FbP6dGlsULobsNaDPc9svxqEON4+XO4sMa6xquXewqeA3XYCMrwaRJdrK9mIveB
 aElKbTlsT7pYQ==
Message-ID: <sashiko-outbox-162946@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] misc: fastrpc: add extended context bank support
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261007-extended-mapping-v2-3-5dca3aa2c2d3@oss.qualcomm.com>
References: <20261007-extended-mapping-v2-0-5dca3aa2c2d3@oss.qualcomm.com>
 <20261007-extended-mapping-v2-3-5dca3aa2c2d3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 11:52:20 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] misc: fastrpc: Use-After-Free of ext_cb array due to concurrent kr=
ealloc during probe
- [High] misc: fastrpc: memory leak of dynamically allocated ext_cb array e=
lements on probe error path
- [High] misc: fastrpc: premature device registration allows UAF on probe f=
ailure
- [High] of: double-free of device node in fastrpc_cb_devices_destroy
- [Medium] misc: fastrpc: memory leak of ext_cb on probe error path
- [Medium] misc: fastrpc: memory leak of ext_cb array on probe error path
--

commit 670e94cdc2cb15ca5f0de40ab9985878a7a72c7b
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

    misc: fastrpc: add extended context bank support
   =20
This commit detects extended context banks by checking for the iommu-ranges
property on the context bank node. It registers them in a separate ext_cb
array, allowing the mapping layer to direct large allocations into the wider
IOVA window.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 5c7bb56cf46d0..d40cdcd5dec30 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2352,6 +2359,43 @@ static int fastrpc_cb_init(struct platform_device =
*pdev)
>  				       of_n_addr_cells(dev->of_node) - 1, &sid))
>  		dev_info(dev, "FastRPC Session ID not specified in DT\n");
> =20
> +	if (of_property_present(dev->of_node, "iommu-ranges"))
> +		is_extended_cb =3D true;
> +
> +	if (is_extended_cb) {
> +		struct fastrpc_session_ctx **new_ext;
> +
> +		sess =3D kzalloc_obj(*sess);
> +		if (!sess)
> +			return -ENOMEM;

[Severity: High]
Can this new failure path trigger a use-after-free regression due to premat=
ure
device registration?

If this allocation fails, fastrpc_cb_init() returns an error, which propaga=
tes
up to fastrpc_rpmsg_probe(). In fastrpc_rpmsg_probe(), the misc device is
registered and exposed to userspace before fastrpc_cb_devices_create() is
called.=20

If userspace opens the device concurrently during probe, it obtains an acti=
ve
file descriptor. When the error path in fastrpc_rpmsg_probe() unconditional=
ly
frees the channel context (data), any subsequent ioctl() or close() by user=
space
will dereference the freed pointer.

> +
> +		rc =3D dma_set_mask(dev, DMA_BIT_MASK(40));
> +		if (rc) {
> +			dev_err(dev, "40-bit DMA enable failed\n");
> +			kfree(sess);
> +			return rc;
> +		}
> +
> +		new_ext =3D krealloc(cctx->ext_cb,
> +				   (cctx->ext_cb_count + 1) * sizeof(*cctx->ext_cb),
> +				   GFP_KERNEL);

[Severity: High]
Does this code cause a use-after-free regression of the ext_cb array pointe=
r?

krealloc() is called without holding cctx->lock. If krealloc() allocates a =
new
block, it frees the old cctx->ext_cb pointer. The cctx->ext_cb pointer is o=
nly
updated to new_ext later inside the spinlock.=20

During this window, cctx->ext_cb points to freed memory, and concurrent
readers may fetch the freed pointer if they race with the probe thread.

[Severity: High]
Does this code also introduce a regression that leaks the dynamically alloc=
ated
ext_cb array elements on the probe error path?

If a failure occurs during the context bank initialization loop
(e.g., if krealloc() fails for a second child node after the first succeede=
d),
the error propagates to fastrpc_rpmsg_probe().=20

The error path in fastrpc_rpmsg_probe() directly executes kfree(data), bypa=
ssing
the proper teardown sequence in fastrpc_channel_ctx_free(). Because
fastrpc_channel_ctx_free() is circumvented, the sess objects allocated by t=
his
patch are permanently leaked.

[Severity: Medium]
Does this code also leak the ext_cb array itself on the probe error path?

Similar to the array elements, because the probe error path executes kfree(=
data)
directly and skips calling fastrpc_channel_ctx_free(), the new_ext block
allocated here is never freed and permanently leaked.

> +		if (!new_ext) {
> +			kfree(sess);
> +			return -ENOMEM;
> +		}
> +
> +		spin_lock_irqsave(&cctx->lock, flags);
> +		cctx->ext_cb =3D new_ext;
> +		sess->valid =3D true;
> +		sess->dev =3D dev;
> +		sess->sid =3D sid;
> +		dev_set_drvdata(dev, sess);
> +		cctx->ext_cb[cctx->ext_cb_count++] =3D sess;
> +		spin_unlock_irqrestore(&cctx->lock, flags);
> +
> +		return 0;
> +	}
> +
[ ... ]
> @@ -2391,6 +2435,8 @@ static void fastrpc_cb_devices_destroy(struct rpmsg=
_device *rpdev)
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	for (i =3D 0; i < cctx->sesscount; i++)
>  		cctx->session[i].valid =3D false;
> +	for (i =3D 0; i < cctx->ext_cb_count; i++)
> +		cctx->ext_cb[i]->valid =3D false;
>  	spin_unlock_irqrestore(&cctx->lock, flags);
> =20
>  	for_each_available_child_of_node(rdev->of_node, np) {
>  		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
>  			of_node_put(np);

[Severity: High]
Does this loop cause a double-free regression of the device node?

The for_each_available_child_of_node() macro automatically drops the refere=
nce
to the previous node upon advancing in the loop. Explicitly calling
of_node_put(np) inside the loop body (both before continue and at the end of
the iteration) violates OF iterator semantics and results in a double-free.

Since this patch introduces new allocations in fastrpc_cb_init() that can
fail, it exposes this buggy cleanup path when fastrpc_cb_devices_destroy()
is triggered on error.

>  			continue;
>  		}
> =20
>  		pdev =3D of_find_device_by_node(np);
>  		of_node_put(np);
>  		if (pdev)
>  			of_platform_device_destroy(&pdev->dev, NULL);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007-extended-m=
apping-v2-0-5dca3aa2c2d3@oss.qualcomm.com?part=3D3
