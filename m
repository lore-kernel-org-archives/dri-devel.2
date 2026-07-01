Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD8B8C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 17:39:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1432D10F083;
	Wed,  1 Jul 2026 17:39:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IUo9tZMI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D273A10F083
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:39:09 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A148C401D5;
 Wed,  1 Jul 2026 17:39:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2651F000E9;
 Wed,  1 Jul 2026 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782927549;
 bh=10iNWCLpMgb8foNVPMty0hSaht82IwM6JRWBPVNHFP8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IUo9tZMISjsUCGQZ4fUmr71+V3Ui/8a8wYfo8GiSCiPtPKG2/SdMUoeE9Ru+mCopV
 WJhM2dlGGKRpPiXbWlnCK8GFYhltUfj4faaON1Ob+Oe86SKdiKwz33RLOQlyPg19tA
 6zX8nmcnc4/4LDiqdym2d2OwLcvhSTwkbaNcdGaGJ5VLUhywMqyD+aBC5e28EsKAI0
 SHysKpz39N50lC5KS38kNZRMY9Y92Pse30csYUPvS58gmyw2SXSMr1oxMPPqANEbt/
 hnl50mlV2eobCG4PUjs7BVbf+AeAOY3oe5fO9/MpSTV0W9wV8siGkCsV20PKrcWBET
 OYnB+MP2GDM8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] udmabuf: reject unknown UDMABUF_CREATE flags
To: =?utf-8?b?SXbDoW4gRXplcXVpZWwgUm9kcmlndWV6?= <ivanrwcm25@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701172159.270872-2-ivanrwcm25@gmail.com>
References: <20260701172159.270872-1-ivanrwcm25@gmail.com>
 <20260701172159.270872-2-ivanrwcm25@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 17:39:08 +0000
Message-Id: <20260701173909.5A2651F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Integer overflow in `lsize` calculation in `udmabuf_ioctl_create_l=
ist` allows out-of-bounds heap memory access if `list_limit` is misconfigur=
ed.
--

commit 0bd9a7c7e5bbe2cbc29a0cdc4dcdb2763d2b20e1
Author: Iv=C3=A1n Ezequiel Rodriguez <ivanrwcm25@gmail.com>

udmabuf: reject unknown UDMABUF_CREATE flags

This patch updates udmabuf_create() to reject unknown flags by checking
against UDMABUF_FLAGS_CLOEXEC and returning -EINVAL. It also documents
the flag semantics in udmabuf.h and adds a selftest.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d658..fb36c0d9ffe72 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -358,6 +358,9 @@ static long udmabuf_create(struct miscdevice *device,
>  	long ret =3D -EINVAL;
>  	u32 i, flags;
> =20
> +	if (head->flags & ~UDMABUF_FLAGS_CLOEXEC)
> +		return -EINVAL;
> +
[Severity: High]
This is a pre-existing issue, but can this code trigger an out-of-bounds
heap read if the list limit is misconfigured?

If an administrator sets the module parameter list_limit to a negative
value (like -1 to mean unlimited), a large head.count from userspace
can bypass the limit check in udmabuf_ioctl_create_list() because
head.count is an unsigned u32 and list_limit is promoted to unsigned
for the comparison.

If a user calls ioctl(UDMABUF_CREATE_LIST) with a crafted head.count
of 0x20000001, the allocation size calculation in
udmabuf_ioctl_create_list() overflows:

drivers/dma-buf/udmabuf.c:udmabuf_ioctl_create_list() {
    ...
    lsize =3D sizeof(struct udmabuf_create_item) * head.count;
    list =3D memdup_user((void __user *)(arg + sizeof(head)), lsize);
}

The size calculation evaluates to 0x300000018, which is truncated to 24
bytes when assigned to the u32 lsize variable. memdup_user() then
allocates a 24-byte buffer for the list.

When execution reaches udmabuf_create(), the loop iterates head->count
times:

drivers/dma-buf/udmabuf.c:udmabuf_create() {
    ...
    for (i =3D 0; i < head->count; i++) {
        pgoff_t subpgcnt;

        if (!PAGE_ALIGNED(list[i].offset))
            goto err_noinit;
    ...
}

Since the list buffer is only 24 bytes long but the loop iterates
0x20000001 times, does this result in out-of-bounds reads on the kernel
heap that could trigger a page fault and kernel oops?

>  	ubuf =3D kzalloc(sizeof(*ubuf), GFP_KERNEL);
>  	if (!ubuf)
>  		return -ENOMEM;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701172159.2708=
72-2-ivanrwcm25@gmail.com?part=3D1
