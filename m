Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACF1CD98E0
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:49:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF77910E4C3;
	Mon, 15 Jun 2026 19:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KxrliL2t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B4E10E4C3
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 19:49:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D7E90601E4;
 Mon, 15 Jun 2026 19:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E291F000E9;
 Mon, 15 Jun 2026 19:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781552955;
 bh=O2ortx0H9lyMCTxQYUdVMHd3Sh4tnK9erEHODjEgKT8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KxrliL2tyVt/JoeqTo3YsrDrzLS1kfe5oZKRROZJWvbJ8xyR88vtzPqaju/WniXyW
 z05XJl95bRxuqRL6NqQskvAxmiba2jzXrBmJShN/VJHe6cwMQlAqQuwQpuTy5pCgzU
 qCMVNU0v3+hDsUq+y+QKDykdKb30Z5skbt/K3WkFXsS9soqH6ZMt898eA6u7WfmWJ9
 IcyslHJase7j+F0Oo5n10ywB005LvqXk1wsbJaC0nL5ysvtkArRuaGDPLbkM6JdEnA
 jYJ3r5BbHzZ1nnsiFgtVas2DqwotUkdjGZpFNXcIpye3TZEyc0c4DlfVS4LK+Miep6
 KCjxb+PhkgLYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] drm/mipi-dsi: Use put_device() on device_add() failure
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260615193555.757498-1-dbgh9129@gmail.com>
References: <20260615193555.757498-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 19:49:15 +0000
Message-Id: <20260615194915.73E291F000E9@smtp.kernel.org>
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

New issues:
- [High] The patch introduces an inconsistent API contract for ownership of=
 the `info->node` reference in `mipi_dsi_device_register_full()`. By using =
`put_device()` on `device_add()` failure, it now consumes the reference (vi=
a `mipi_dsi_dev_release()`) on that specific error path. However, on earlie=
r error paths (like invalid channel or `mipi_dsi_device_alloc()` failure), =
it returns an error pointer without dropping the reference. Because the fun=
ction returns an opaque `ERR_PTR` on all failures, the caller cannot know w=
hether it still owns the reference, making it structurally impossible for c=
allers to safely handle errors without risking a double-put or memory leak.

Pre-existing issues:
- [High] Double-put of OF node in `rm69380_probe()` due to the API contract=
 of `mipi_dsi_device_register_full()`.
--

commit d11ddeaad1a55c59a2b2250f973cf5d648093cee
Author: Yuho Choi <dbgh9129@gmail.com>

drm/mipi-dsi: Use put_device() on device_add() failure

mipi_dsi_device_alloc() initializes the embedded struct device before
mipi_dsi_device_register_full() calls mipi_dsi_device_add(). If
device_add() fails, the code frees the DSI object directly with kfree(),
bypassing the device release callback.

Drop the initialized device reference with put_device() instead, so
mipi_dsi_dev_release() runs and releases resources owned by the device,
including the OF node reference.

> diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_ds=
i.c
> index 3ac1dd5ad640a..1b4c0acbd30d2 100644
> --- a/drivers/gpu/drm/drm_mipi_dsi.c
> +++ b/drivers/gpu/drm/drm_mipi_dsi.c

[ ... ]

> @@ -233,7 +233,7 @@ mipi_dsi_device_register_full(struct mipi_dsi_host *h=
ost,
>  	ret =3D mipi_dsi_device_add(dsi);
>  	if (ret) {
>  		dev_err(host->dev, "failed to add DSI device %d\n", ret);
> -		kfree(dsi);
> +		put_device(&dsi->dev);

[Severity: High]
Does this introduce an inconsistent API contract for ownership of the
info->node reference?

Earlier in mipi_dsi_device_register_full(), if mipi_dsi_device_alloc()
fails, the function returns ERR_PTR without dropping the reference:

    dsi =3D mipi_dsi_device_alloc(host);
    if (IS_ERR(dsi)) {
        dev_err(host->dev, "failed to allocate DSI device %ld\n",
                PTR_ERR(dsi));
        return dsi;
    }

By using put_device() here, this specific error path now consumes the
reference via mipi_dsi_dev_release().

Since the caller receives an opaque ERR_PTR in both failure cases, they
have no way to distinguish whether the reference was consumed or not, making
it structurally impossible to safely handle errors without risking a
double-put or a memory leak.

[Severity: High]
This isn't a bug introduced by this patch, but does this API contract lead
to a double-put of the OF node in callers like rm69380_probe()?

In drivers/gpu/drm/panel/panel-raydium-rm69380.c, rm69380_probe() calls
of_node_put() explicitly before passing the node to the register function:

    of_node_put(dsi_sec);
    if (!dsi_sec_host)
        return dev_err_probe(dev, -EPROBE_DEFER,
                             "Cannot get secondary DSI host\n");

    ctx->dsi[1] =3D
        devm_mipi_dsi_device_register_full(dev, dsi_sec_host, &info);

Because mipi_dsi_device_register_full() assigns the node without acquiring
its own reference, and mipi_dsi_dev_release() calls of_node_put(dev->of_nod=
e)
when the device is released (or when device_add() fails via this patch),
this results in a use-after-free and double-put of the OF node.

>  		return ERR_PTR(ret);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615193555.7574=
98-1-dbgh9129@gmail.com?part=3D1
