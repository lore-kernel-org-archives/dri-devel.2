Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E4FC982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 15:46:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A75210ED86;
	Tue, 22 Sep 2026 15:46:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MOZRs49W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 619B410ED86
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 15:46:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 95A9F60A82;
 Tue, 22 Sep 2026 15:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2721F000FF;
 Tue, 22 Sep 2026 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790091966;
 bh=2r60q6MV4Vb/zDmNz7kJ+IpAVoH+E8DVf3NXcC+v7xs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MOZRs49WovyOctj9aHhNVXMiFAgQvX+gl8zY6Bs9yT3cVgGjZ9IC3R+OYQWA4mpaY
 /TcJqPNcDm6KpsxZnAL9su5jyUtcI78qgCbnttW/n/fuEN/ZLMKRCP+fFO165WHB++
 GAQWipylKZJezOOtdKD9QKHM3si635KuOxi6EfcJID0g5wctjkLn69DoMzfb6tBY8E
 rHxK12mvU2wdXjgzsIibZnaIrmCMQVyqOiG1Xco6Ura+jPBrjGTr0q4kGKgo+B/saP
 B9eRfzKc3VM4s554P56qtLoOQIweYOmVCAxo7Uy+fICY/KoxHeyvX04EKUPMljWp92
 qOU4amehl1NDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: unmap GART dma pages before free
To: "Michail Tatas" <michail.tatas@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <arKhDFCSoPDNYaxX@michalis-linux>
References: <arKhDFCSoPDNYaxX@michalis-linux>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:46:05 +0000
Message-Id: <20260922154606.2C2721F000FF@smtp.kernel.org>
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
- [High] drm/amdgpu: NULL pointer dereference in amdgpu_gart_table_ram_allo=
c error path
--

commit cffcb1919743d55f9dc644f758abf99d4187be7c
Author: Michail Tatas <michail.tatas@gmail.com>

drm/amdgpu: unmap GART dma pages before free

This commit unmaps the GART dma pages before freeing them to avoid leaving
the device writing to freed memory.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index c4c21dbbbdbf8..780fb01530e69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
[ ... ]
> @@ -209,6 +209,8 @@ int amdgpu_gart_table_ram_alloc(struct amdgpu_device =
*adev)
>  error_resv:
>  	amdgpu_bo_unreserve(bo);
>  error:
> +	dma_unmap_page(&adev->pdev->dev, sg_dma_address(sg->sgl), adev->gart.ta=
ble_size,
> +		       DMA_BIDIRECTIONAL);

[Severity: High]
Can this cause a NULL pointer dereference during memory pressure?

If memory allocation fails earlier in amdgpu_gart_table_ram_alloc(),
sg is set to NULL and execution jumps to the error label:

	sg =3D kmalloc_obj(*sg);
	if (!sg) {
		ret =3D -ENOMEM;
		goto error;
	}

The new dma_unmap_page() call unconditionally accesses sg->sgl at the error
label. If the execution arrived here due to the allocation failure above,
dereferencing sg->sgl will crash.

Additionally, if sg_alloc_table() fails, sg is allocated but sg->sgl may be
uninitialized when accessed here.

>  	amdgpu_bo_unref(&bo);
>  	if (sg) {
>  		sg_free_table(sg);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/arKhDFCSoPDNYaxX@mi=
chalis-linux?part=3D1
