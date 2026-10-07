Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD087CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:59:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3584110E644;
	Wed,  7 Oct 2026 08:59:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZNqzEOH0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76B0E10E644
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:59:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A84DD600C8;
 Wed,  7 Oct 2026 08:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369C61F0089C;
 Wed,  7 Oct 2026 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791363565;
 bh=8Aoign/A8gvRlhla4RqN/wknasQxvdxrjpxw4WzkJvs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZNqzEOH0d8165rkh0u85P1SbZhyiKvPyuiw34IPIahb2WX5C7ZFB7pWewDVnD4wAR
 eR8gOENu9Vb41CwuiA+Crj5nqt8waidag7RCTNwBDTeL9EkrxBz2qv55C/brBvGrLY
 Nix7HK0UZ75YfA7copFCgIzv6Pyy5csHs4NSK/5Fwh5kSfw6DnJJxWr2IeawXD0NO8
 8Yl3+GUxTO5WG6hpuYmZpRaI+1GvM0XgrJYZxupY1/AxAhaai98zIv+5mVS/VDebgh
 X9e2iLwd2ZJGiTywomXrYLpEHdBO41mUCytNCMdkPAppWC82CMHAaZe6JpKDKLQrHe
 9fyDn3+B7EZUw==
Message-ID: <sashiko-outbox-162764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] misc: fastrpc: initialise channel refcount
 before exposing the misc device
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261007084447.922-2-jianping.li@oss.qualcomm.com>
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
 <20261007084447.922-2-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 08:59:24 +0000
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
- [High] misc: fastrpc: uninitialized spin_lock access due to premature reg=
istration
- [High] misc: fastrpc: UAF on probe error path due to direct kfree
- [High] misc: fastrpc: UAF in fastrpc_rpmsg_probe error path due to raw kf=
ree
--

commit 7fb377963b47742ec8445ae7a99aea90b1ae5375
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: initialise channel refcount before exposing the misc device

This patch moves kref_init() before fastrpc_device_register() to fix a
refcount warning when userspace opens the misc device concurrently during
probe.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index af18ff1992eed..05b2e7e4ad3b7 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2599,6 +2599,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  	data->poll_mode_supported =3D soc_data->poll_mode_supported ||
>  		of_machine_get_match(fastrpc_poll_supported_machines);
> =20
> +	kref_init(&data->refcount);
>  	switch (domain_id) {
>  	case ADSP_DOMAIN_ID:
>  	case MDSP_DOMAIN_ID:

[ ... ]

> @@ -2626,7 +2627,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  		goto err_free_data;
>  	}
> =20
> -	kref_init(&data->refcount);
>  	atomic_set(&data->ctx_seq, 0);
> =20
>  	rdev->dma_mask =3D &data->dma_mask;

[Severity: High]
Does exposing the device to userspace before initializing the spinlock resu=
lt
in a fatal crash if the device is opened immediately?

In fastrpc_rpmsg_probe(), spin_lock_init(&data->lock) is called further dow=
n,
after the switch statement. If userspace opens the device immediately after
fastrpc_device_register(), the open path calls fastrpc_session_alloc(), whi=
ch
attempts to acquire the uninitialized lock:

fastrpc_device_open()
   fastrpc_session_alloc()
      spin_lock_irqsave(&cctx->lock, flags);

[Severity: High]
Does the probe error path cause a use-after-free if userspace has successfu=
lly
opened the device?

Since kref_init() now executes before the device registration, an early open
can successfully acquire a reference via fastrpc_channel_ctx_get().

If a subsequent probe step fails (such as the second fastrpc_device_registe=
r()
call for CDSP/GDSP, or of_platform_populate()), the probe error path direct=
ly
frees the channel context:

err_free_data:
	kfree(data);
	return err;

This unconditional kfree() bypasses the kref lifecycle. When userspace later
closes the file descriptor, fastrpc_device_release() calls
fastrpc_channel_ctx_put(), which will dereference the freed memory.

Should the error path use fastrpc_channel_ctx_put() once the kref has been
initialized, instead of calling kfree() directly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007084447.922-=
1-jianping.li@oss.qualcomm.com?part=3D1
