Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F134C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 08:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5550110E861;
	Wed, 23 Sep 2026 08:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kP3/h2wj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40E9A10E861
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 08:50:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8F93601F0;
 Wed, 23 Sep 2026 08:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7801F000FF;
 Wed, 23 Sep 2026 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790153436;
 bh=v5dJ9RUYLeLnoQosiUt/T+w42OmPSw8eE6fcWkD+BYs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kP3/h2wjOAu4sXISElKgRinD3OuCeywngOEH4HvxWflnkLNsfvD8+PbOwoOg0flD+
 aWJTI690Eiuo0n+JWVGx1iqUtxKgX4oH2ZN8afM9jDf10sg6w1QzXKW8nA5zjptC1b
 LmBmdrKXnrMZfcQ2XypGmm0Lb9DyEHNy3k86BtNQkWHD7Ui/1ze29DJF11hobzLK4e
 PuC0oPuZULlx59YQJR+iZGCrdnDaPplmTdajXhnixKo6Ly0GCJBt+tvPRhTRguRvN3
 K/i1bBJGc+yutlAeVVS3jOlDIjMGpnhMrTvjEQT/XDQEpbyrJ0SAos6+Ys7aho3fqX
 Vkk8AJgWym1cQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] misc: fastrpc: iterate CB nodes manually instead
 of of_platform_populate
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260923-dup-sessions-v5-1-e953133a1827@oss.qualcomm.com>
References: <20260923-dup-sessions-v5-0-e953133a1827@oss.qualcomm.com>
 <20260923-dup-sessions-v5-1-e953133a1827@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 08:50:35 +0000
Message-Id: <20260923085036.1F7801F000FF@smtp.kernel.org>
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
- [High] of: double-free of device_node references in OF iterator loops
- [Medium] driver-core: memory leak of platform_device in fastrpc_cb_device=
s_destroy
--

commit 0cd61e434e0b0defac9c431333bfa40bb39df800
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: iterate CB nodes manually instead of of_platform_populate

This commit replaces of_platform_populate() with direct iteration over chil=
d=20
context bank nodes to ensure synchronous initialization via fastrpc_cb_init=
().
It also introduces fastrpc_cb_devices_destroy() to manually clean up platfo=
rm=20
devices during teardown and removes the standalone platform driver.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992eed..f20d3e5ecc81f 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -2389,37 +2389,63 @@ static int fastrpc_cb_probe(struct platform_devic=
e *pdev)
> -static void fastrpc_cb_remove(struct platform_device *pdev)
> +static void fastrpc_cb_devices_destroy(struct rpmsg_device *rpdev)
>  {
[ ... ]
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
> +			of_node_put(np);
> +			continue;
>  		}

[Severity: High]
Does explicitly dropping the reference before continue result in a double-f=
ree
when the loop macro advances? The for_each_available_child_of_node() iterat=
or
inherently calls of_node_put() on the previous node when advancing. This
occurs here during device destruction in fastrpc_cb_devices_destroy().

> +
> +		pdev =3D of_find_device_by_node(np);
> +		of_node_put(np);

[Severity: High]
Does explicitly dropping the reference at the end of the loop body result i=
n a
double-free when the loop macro advances to the next iteration?

> +		if (pdev)
> +			of_platform_device_destroy(&pdev->dev, NULL);
>  	}

[Severity: Medium]
Does this leak the platform_device reference acquired by
of_find_device_by_node() in fastrpc_cb_devices_destroy()? The reference
returned by of_find_device_by_node() has an incremented reference count, wh=
ich
doesn't appear to be released via put_device() or platform_device_put() aft=
er
unregistering the device.

> -	spin_unlock_irqrestore(&cctx->lock, flags);
>  }
> =20
[ ... ]
> +static int fastrpc_cb_devices_create(struct rpmsg_device *rpdev)
> +{
> +	struct device *rdev =3D &rpdev->dev;
> +	struct platform_device *pdev;
> +	struct device_node *np;
> +	int err;
> =20
> +	for_each_available_child_of_node(rdev->of_node, np) {
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb")) {
> +			of_node_put(np);
> +			continue;
> +		}

[Severity: High]
Does explicitly dropping the reference before continue result in a double-f=
ree
when the loop macro advances? The for_each_available_child_of_node() iterat=
or
inherently calls of_node_put() on the previous node when advancing. This
occurs during driver initialization in fastrpc_cb_devices_create().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923-dup-sessio=
ns-v5-0-e953133a1827@oss.qualcomm.com?part=3D1
