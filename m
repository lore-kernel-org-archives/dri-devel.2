Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0E3C79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 07:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C40F10E46A;
	Mon,  7 Sep 2026 07:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oBBj6OeR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F73D10E484
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 07:14:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4D6E641438;
 Mon,  7 Sep 2026 07:14:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045B11F00A3A;
 Mon,  7 Sep 2026 07:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788765276;
 bh=zDq/E+kexHdf7nT2Z4Zhb+s4Ll++DopDWBN9mtS2W4k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oBBj6OeRWkNb9IKK+xgaUpN5NSry+stpOLq0TUXNDD8Z3sbCA0Y1U6FBl77GgYQQ1
 nxgg6PhN/6DD9l1ILkievVlYd0DGr1O4sBdSpD/WjsOf2x11FY6vTfmmIkaz4MBeGG
 6X+GBUwfzlAckTnrTijJQIFgGPkWOlZw03Sb105AWzlne+/8zJvkH05Yxh/8f24iRu
 y9X5Mmre9grTs9R7OIwe3Xicl1Kh0a3QRT407tMySBtM0h8ELQRWmJodmnSrz0N++x
 zLi5TztXqX/mm77jWhWeDnNA88jnTZOjsv/4oBzZbWej6AzGnrBJEYUJOR1pLsQs2x
 wHE57RV7z1WjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: Reduce console noise from expected
 DSP info, reserved memory and session messages
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260907070356.509-1-jianping.li@oss.qualcomm.com>
References: <20260907070356.509-1-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 07:14:35 +0000
Message-Id: <20260907071436.045B11F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] Character device is registered and exposed to user-space before cr=
itical context fields (spinlocks, krefs, lists, idr) are initialized, enabl=
ing severe race conditions and NULL pointer dereferences on concurrent open=
().
- [High] Use-After-Free on `fastrpc_rpmsg_probe` error paths after device r=
egistration.
--

commit 449b11a15887fd75279efb078924d324d2fb8fb1
Author: Jianping Li <jianping.li@oss.qualcomm.com>
Subject: misc: fastrpc: Reduce console noise from expected DSP info, reserv=
ed memory and session messages

The commit downgrades expected error messages from the DSP and reserved DMA
memory to dev_dbg, and rate-limits the session availability error to reduce
console flooding on certain platforms.

Link: https://lore.kernel.org/all/20260514062825.50172-1-jianping.li@oss.qu=
alcomm.com/

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 90fd669636ec1..f40356c950519 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2563,7 +2563,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device =
*rpdev)
>  	}
> =20
>  	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
> -		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
> +		dev_dbg(rdev, "no reserved DMA memory for FASTRPC\n");
> =20
>  	vmcount =3D of_property_read_variable_u32_array(rdev->of_node,
>  				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);

[Severity: High]
This isn't a bug introduced by this patch, but could the initialization in
fastrpc_rpmsg_probe() lead to a race condition with concurrent opens?

Looking at fastrpc_rpmsg_probe(), we register the device before initializing
important context fields:

	err =3D fastrpc_device_register(rdev, data, secure_dsp, domain);
	if (err)
		goto err_free_data;
	...
	kref_init(&data->refcount);
	atomic_set(&data->ctx_seq, 0);
	...
	INIT_LIST_HEAD(&data->users);
	spin_lock_init(&data->lock);

If a user-space process opens the character device immediately after
fastrpc_device_register() completes, fastrpc_device_open() will be called.

Since data->refcount and data->users are uninitialized, won't this cause a
null pointer dereference when it calls fastrpc_channel_ctx_get() or attempts
to lock data->lock and add to the zeroed data->users list?

[Severity: High]
This is also a pre-existing issue, but is there a risk of a use-after-free
in the error handling paths of fastrpc_rpmsg_probe()?

If an error occurs after the device is registered (for example, if a
subsequent fastrpc_device_register() fails or if of_platform_populate()
fails), the code branches to the teardown paths:

	err =3D fastrpc_device_register(rdev, data, false, domain);
	if (err)
		goto err_deregister_fdev;
...
err_deregister_fdev:
	if (data->fdevice)
		misc_deregister(&data->fdevice->miscdev);
	if (data->secure_fdevice)
		misc_deregister(&data->secure_fdevice->miscdev);

err_free_data:
	kfree(data);
	return err;

Since misc_deregister() does not revoke active file descriptors, what happe=
ns
if a concurrent open() has already acquired a reference to the device before
we call misc_deregister()?

Will the unconditional kfree(data) result in a use-after-free later when the
user closes the file and fastrpc_device_release() accesses the freed data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907070356.509-=
1-jianping.li@oss.qualcomm.com?part=3D1
