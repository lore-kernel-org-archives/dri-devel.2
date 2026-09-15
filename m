Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04D7C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 21:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2430A10E8AE;
	Tue, 15 Sep 2026 21:20:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HpyYcxlp";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ECE410E8A2
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 21:20:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A6DD600CB;
 Tue, 15 Sep 2026 21:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D910E1F000FF;
 Tue, 15 Sep 2026 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789507250;
 bh=WbLk6oqw2jnGp4X6QqpDHE3cC0N4Tuvobq2mrHEHdqg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HpyYcxlpc8prYeSFpVzg4c4pkG2fcrBgPDDGJ/nZGHrR/OYPI/5bKDiGrZE3fqJ7N
 9a9CifHq/FVYo57LGXvIQCnopy7YGFUXjEn++dLoC43IaP26lI1WtkzvPzSa+YT10x
 PklOvVBozh9dcUKwiRiPph0QgXdv5XkU7dRhc9TJReDg1GO/+b67UwOTkXzUGEuPTW
 WYU38saWLOwPeEfRrQ8miG80AZYTv2npX763MB5Pby5d5xuG0APlK2SmBdwhuEERLu
 qKZCkv+S4CcN9YSdbFTT4XRRyjnqUGXRtoIUd1Ia0CsP4d+J9npFizMzbWrnCFQlDb
 7kpEsj+iTa2Tg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] drm/nouveau/gsp/r570: Start saving comptag
 backing stores
To: "Lyude Paul" <lyude@redhat.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260915210647.695187-5-lyude@redhat.com>
References: <20260915210647.695187-1-lyude@redhat.com>
 <20260915210647.695187-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 21:20:49 +0000
Message-Id: <20260915212049.D910E1F000FF@smtp.kernel.org>
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
- [High] nouveau: gsp: buffer overflow in r535_fbsr_memlist() due to unalig=
ned compbit_store_size
- [Medium] nouveau: gsp: integer truncation of size leads to tiny DMA alloc=
ation
--

commit 2f071ac78fdb305696ed659788ff3cf83d6adc73
Author: Lyude Paul <lyude@redhat.com>

drm/nouveau/gsp/r570: Start saving comptag backing stores
   =20
One of the portions of OpenRM's fbsr process that we never implemented is
the saving and restoring of comptag backing stores. This isn't strictly
necessary for fbsr to work (as long as we don't specify bEnteringGcOff =3D
1), but implementing it brings us much closer to matching OpenRM's fbsr
process - which means we can rely on things being well tested on Nvidia's
side.

> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c b/dri=
vers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> index 569732320f3dd..feef5104a6241 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r570/fbsr.c

[ ... ]

> @@ -174,6 +197,8 @@ r570_fbsr_suspend(struct nvkm_gsp *gsp)
>  	size  =3D gsp->fb.heap.size;
>  	size +=3D gsp->fb.rsvd_size;
>  	size +=3D gsp->fb.bios.vga_workspace.size;
> +	size +=3D compbit_store_size;
> +

[Severity: High]
Does adding the unaligned compbit_store_size directly to size here lead to =
an
out-of-bounds write in r535_fbsr_memlist()?

When this unaligned size is passed to nvkm_gsp_sg(), it rounds it up using
DIV_ROUND_UP to allocate memory pages. However, when r535_fbsr_memlist()
constructs the memory list, it computes the required RPC array size by
truncation:

    const u32 pages =3D size / GSP_PAGE_SIZE;

This allocates an undersized array for the PTEs. Then the loop inside
r535_fbsr_memlist() iterates based on the rounded-up scatterlist length:

    for (int i =3D 0; i < sg_dma_len(sgl) / GSP_PAGE_SIZE; i++)

This mismatch causes the pte++ index to write 8 bytes (or more) past the end
of the allocated rpc buffer, resulting in kernel heap memory corruption if a
buggy or compromised firmware returns a non-page-aligned size.


[Severity: Medium]
Could an extremely large compbit_store_size from the GSP firmware cause an
integer truncation when passed to sg_alloc_table()?

If size exceeds the 32-bit limit, DIV_ROUND_UP(size, PAGE_SIZE) in
nvkm_gsp_sg() overflows the 32-bit unsigned int nents parameter in
sg_alloc_table(). This truncates the value, resulting in a tiny DMA
allocation.

Meanwhile, this huge size is still passed to the GSP as the length field.
When the GSP attempts to save its state, it will DMA out of the bounds of t=
he
mapped physical pages, potentially leading to a GSP MMU or IOMMU fault.

>  	nvkm_debug(subdev, "fbsr: size: 0x%llx bytes\n", size);
> =20
>  	ret =3D nvkm_gsp_sg(device, size, &gsp->sr.fbsr);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915210647.6951=
87-1-lyude@redhat.com?part=3D4
