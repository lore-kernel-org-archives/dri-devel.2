Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6B9C982CC
	for <dri-devel@archiver.kernel.org>; Sat, 19 Sep 2026 22:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A86C510E589;
	Sat, 19 Sep 2026 22:57:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PRzw5pjM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1576510E589
 for <dri-devel@lists.freedesktop.org>; Sat, 19 Sep 2026 22:57:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F34274132C;
 Sat, 19 Sep 2026 22:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88581F000FF;
 Sat, 19 Sep 2026 22:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789858659;
 bh=oP+Sm44f7y5PfuJ9xotpFHdQr8JUdq20lrGjbJpdT+c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PRzw5pjMwLChpR0OalbzUjUVnsg5OWji5mXZbJgPyowQUa3F3UpY0o9HIzyY0qCDb
 UkNvvMD6aDwDm4lgTa80IvzBoFErp8EAzLC2SLCPWYL8XW+zgNQWQV3qHC0JeHrkyh
 CdAiu9K907upsEPskEZtYb2Xf6SU/Gv3NZke2DEh2CrLaX0gYqeOFWklQBUEjpobvt
 UbiEtpKo+wC7Vk4ai8sIXwAG2u7yw7EOOcYLH1BYBhgzZDkKUFd6Yg7ah01b0IC7ig
 86Ce8hpxU7oMNk5giFgcLqrFLPCj1qETqpoOYcGBtwvZH816odqi6oqBfNwbnlqL8O
 7wKrUdYk79Fzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/vboxvideo: validate VBVA ring buffer offsets and
 cursor dimensions
To: "Hui Peng" <benquike@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260919223512.3889313-1-benquike@gmail.com>
References: <20260919223512.3889313-1-benquike@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 22:57:39 +0000
Message-Id: <20260919225739.B88581F000FF@smtp.kernel.org>
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
- [High] drm/vboxvideo: VRAM size validation uses uninitialized num_crtcs
- [High] drm/vboxvideo: TOCTOU race on vbva->data_len allows divide-by-zero
--

commit b1a081469cd7aae1113cfd3057268becc7a4f37a
Author: Hui Peng <benquike@gmail.com>

    drm/vboxvideo: validate VBVA ring buffer offsets and cursor dimensions
   =20
    In drivers/gpu/drm/vboxvideo/ (vbox_main.c, vbox_mode.c, vbva_base.c),
    validate VBVA ring buffer offsets against buffer_length and check cursor
    dimensions before copying cursor data into HGSMI buffers.

> diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vbox=
video/vbox_main.c
> index aa6664542b20d..8cf326661b57f 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_main.c
> +++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
> @@ -115,6 +115,10 @@ int vbox_hw_init(struct vbox_private *vbox)
> =20
>  	DRM_INFO("VRAM %08x\n", vbox->full_vram_size);
> =20
> +	if (vbox->full_vram_size < VBVA_ADAPTER_INFORMATION_SIZE +
> +				   vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE)
> +		return -EINVAL;
> +

[Severity: High]
Does this code use an uninitialized value for vbox->num_crtcs?

Looking at vbox_hw_init(), it appears the memory for vbox is allocated with
devm_drm_dev_alloc(), which zero-initializes the memory. Since
vbox->num_crtcs is not populated until later in the function via
hgsmi_query_conf(), is it strictly 0 at the time of this check?

Could this cause the validation to evaluate 0 * VBVA_MIN_BUFFER_SIZE,
allowing an inadequate VRAM size to slip through and resulting in a
potential out-of-bounds mapping later in vbox_accel_init()?

>  	ret =3D pcim_request_region(pdev, 0, "vboxvideo");
>  	if (ret)
>  		return ret;

[ ... ]

> diff --git a/drivers/gpu/drm/vboxvideo/vbva_base.c b/drivers/gpu/drm/vbox=
video/vbva_base.c
> index 36bc9824ec3f9..3a752be06f4e1 100644
> --- a/drivers/gpu/drm/vboxvideo/vbva_base.c
> +++ b/drivers/gpu/drm/vboxvideo/vbva_base.c

[ ... ]

> @@ -93,6 +110,9 @@ bool vbva_write(struct vbva_buf_ctx *vbva_ctx, struct =
gen_pool *ctx,
>  		vbva_buffer_place_data_at(vbva_ctx, p, chunk,
>  					  vbva->free_offset);
> =20
> +		if (!vbva->data_len)
> +			return false;
> +
>  		vbva->free_offset =3D (vbva->free_offset + chunk) %
>  				    vbva->data_len;

[Severity: High]
Could this check introduce a time-of-check to time-of-use vulnerability?

Because vbva resides in VRAM, which is shared memory accessible by the host,
and the check does not use READ_ONCE() or store the length locally, might
the compiler emit two distinct memory loads for vbva->data_len?

Can a buggy host hypervisor bypass this check by setting data_len to a valid
non-zero value, then immediately flipping it to 0 before the modulo operati=
on
executes, potentially leading to a divide-by-zero kernel panic in the guest?

>  		record->len_and_flags +=3D chunk;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919223512.3889=
313-1-benquike@gmail.com?part=3D1
