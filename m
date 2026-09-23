Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1B5C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A163610E840;
	Wed, 23 Sep 2026 08:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U0/hgMRo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E9E10E840
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:50:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0AD8B600AA;
 Wed, 23 Sep 2026 08:50:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719551F000FF;
 Wed, 23 Sep 2026 08:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790153419;
 bh=PaLiowRkPvkzHWsoVbcartkgXvyXnuaFcZ9i0jYYz/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=U0/hgMRo6UYv/r2XsQb643tW7V+E27qu7s3bQ8vDrgSFrRCCBfnMWxMJeshHklPBI
 12Jdt/19h/NQgPGX+6WkSEmxNWGDtPU6tt0KUBRZ4d+WToPz/iP54oAqRNBs4BrfHU
 c969O26X4IFGg3dr1mPVwVR4Bfb6X1fLOKVt8NSdjVnxO+6qNV+tRurSWckd52yfBQ
 6A/DaavXrNNMvrocX/ENKe0am29ertVhzimvaWl7seQqQjBgDC/D4Be9VUosqKJosp
 6DGWTLySkSdQQIWDZ8Wrzc40GADoHszai1cmPbTt1HAzyPlqBPFeMOEhKxNkmBULJa
 eqZIGlab+gXDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260923-dup-sessions-v5-3-e953133a1827@oss.qualcomm.com>
References: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
 <20260923-dup-sessions-v5-3-e953133a1827@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 08:50:18 +0000
Message-Id: <20260923085019.719551F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] of: use-after-free and double put on device tree node during itera=
tion
- [Medium] device: memory leak due to missing put_device() after of_find_de=
vice_by_node()
--

commit 0cd61e434e0b0defac9c431333bfa40bb39df800
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: iterate CB nodes manually instead of of_platform_populate

This commit replaces of_platform_populate() with manual iteration of device
tree child nodes to ensure context banks are fully initialised before
fastrpc_rpmsg_probe() returns. It introduces fastrpc_cb_devices_create()
and fastrpc_cb_devices_destroy() to handle this synchronous setup and
teardown.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992eed..f20d3e5ecc81f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2389,37 +2389,63 @@ static int fastrpc_cb_probe(struct platform_devic=
e *pdev)
>  	return 0;
>  }
> =20
> -static void fastrpc_cb_remove(struct platform_device *pdev)
> +static void fastrpc_cb_devices_destroy(struct rpmsg_device *rpdev)
>  {
> -	struct fastrpc_channel_ctx *cctx =3D dev_get_drvdata(pdev->dev.parent);
> -	struct fastrpc_session_ctx *sess =3D dev_get_drvdata(&pdev->dev);
> +	struct fastrpc_channel_ctx *cctx =3D dev_get_drvdata(&rpdev->dev);
> +	struct device *rdev =3D &rpdev->dev;
> +	struct platform_device *pdev;
> +	struct device_node *np;
>  	unsigned long flags;
>  	int i;
> =20
>  	spin_lock_irqsave(&cctx->lock, flags);
> -	for (i =3D 0; i < FASTRPC_MAX_SESSIONS; i++) {
> -		if (cctx->session[i].sid =3D=3D sess->sid) {
> -			cctx->session[i].valid =3D false;
> -			cctx->sesscount--;
> +	for (i =3D 0; i < cctx->sesscount; i++)
> +		cctx->session[i].valid =3D false;
> +	spin_unlock_irqrestore(&cctx->lock, flags);
> +
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
> +			of_node_put(np);
> +			continue;
>  		}

[Severity: High]
Can this result in a double-put and use-after-free on the device tree node?

The for_each_available_child_of_node() macro automatically handles dropping
the reference on the current child node at the end of each iteration via
of_get_next_available_child(). Calling of_node_put(np) manually before
continue causes the iterator to dereference np->sibling on the already-freed
node, followed by a second of_node_put(np) that underflows the reference
count.

> +
> +		pdev =3D of_find_device_by_node(np);
> +		of_node_put(np);

[Severity: High]
Will this manual of_node_put() lead to the same use-after-free issue?

Calling of_node_put(np) manually at the end of the loop body causes the same
issue with the loop macro underflowing the reference count and accessing the
freed node during iteration.

> +		if (pdev)
> +			of_platform_device_destroy(&pdev->dev, NULL);

[Severity: Medium]
Could this leak the pdev device reference?

of_find_device_by_node() acquires a device reference by incrementing its
refcount. This reference doesn't appear to be released via put_device(&pdev=
->dev)
or platform_device_put(pdev) after calling of_platform_device_destroy().

>  	}
> -	spin_unlock_irqrestore(&cctx->lock, flags);
>  }
> =20
> -static const struct of_device_id fastrpc_match_table[] =3D {
> -	{ .compatible =3D "qcom,fastrpc-compute-cb" },
> -	{ }
> -};
> +static int fastrpc_cb_devices_create(struct rpmsg_device *rpdev)
> +{
> +	struct device *rdev =3D &rpdev->dev;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int err;
> =20
> -static struct platform_driver fastrpc_cb_driver =3D {
> -	.probe =3D fastrpc_cb_probe,
> -	.remove =3D fastrpc_cb_remove,
> -	.driver =3D {
> -		.name =3D "qcom,fastrpc-cb",
> -		.of_match_table =3D fastrpc_match_table,
> -		.suppress_bind_attrs =3D true,
> -	},
> -};
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
> +			of_node_put(np);
> +			continue;
> +		}

[Severity: High]
Does this early of_node_put() cause a similar double-put and use-after-free
during the loop iteration?

Similar to fastrpc_cb_devices_destroy(), calling of_node_put(np) before
continue will double-put the node and use-after-free np->sibling during
the loop iteration.

> +
> +		pdev =3D of_platform_device_create(np, NULL, rdev);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dup-sessio=
ns-v5-0-e953133a1827@oss.qualcomm.com?part=3D3
